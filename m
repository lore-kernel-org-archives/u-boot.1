Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 901D8D4415E
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:52:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00E2889597;
	Tue, 19 Nov 2024 14:52:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dUMnRrdt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAE1E8959E; Tue, 19 Nov 2024 14:52:36 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98ED088E5C
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:52:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4AJDqORf3888405
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Nov 2024 07:52:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732024344;
 bh=7XU4MIc8SXUXw7+A8fYt23ucwJV5S+fSG3AqaYcawaE=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=dUMnRrdtQtgIGsJ4r4sc1NcggroLxA33W3fMJjNXNEmUowBq1OvnKtwqjOvQb7fhf
 AgXYDUzoJTp+ifRL2HzVRfeasw7ISOWwydB2XU8u2IhRnMTz41BiusFIwwo3Tx+D3s
 BTTS5hiOxupOVoO3vGABEQFgjkFmrenzDSFXiW3U=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AJDqOd9012416
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Nov 2024 07:52:24 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Nov 2024 07:52:24 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Nov 2024 07:52:23 -0600
Received: from localhost (prasanth-server.dhcp.ti.com [10.24.68.215])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AJDqNQX106732;
 Tue, 19 Nov 2024 07:52:23 -0600
Date: Tue, 19 Nov 2024 19:22:22 +0530
From: Prasanth Mantena <p-mantena@ti.com>
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
CC: <u-boot@lists.denx.de>, <michal.simek@amd.com>,
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <trini@konsulko.com>, <seanga2@gmail.com>, <caleb.connolly@linaro.org>,
 <sjg@chromium.org>, <william.zhang@broadcom.com>,
 <stefan_b@posteo.net>, <quentin.schulz@cherry.de>, <git@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>
Subject: Re: [PATCH] mtd: spi-nor: Send write disable cmd after every write
 enable
Message-ID: <20241119135222.bpoxymraueeifkcr@prasanth-server>
References: <20241119063918.12540-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241119063918.12540-1-venkatesh.abbarapu@amd.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 12:09, Venkatesh Yadav Abbarapu wrote:
> Write enable(06h) command will be sent to a flash device to
> set the write enable latch bit before every program, erase,
> write command. After that write disable command (04h) needs
> to be sent to clear the write enable latch.
> 
> This write_disable() is missing at the majority of the places
> in the driver, add it to clear write enable latch.
> 
> Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>  drivers/mtd/spi/spi-nor-core.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
> index ec841fb13b..5977c634c2 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -944,6 +944,7 @@ static int spi_nor_erase_chip_wait_till_ready(struct spi_nor *nor, unsigned long
>  static int clean_bar(struct spi_nor *nor)
>  {
>  	u8 cmd, bank_sel = 0;
> +	int ret;
>  
>  	if (nor->bank_curr == 0)
>  		return 0;
> @@ -951,7 +952,11 @@ static int clean_bar(struct spi_nor *nor)
>  	nor->bank_curr = 0;
>  	write_enable(nor);
>  
> -	return nor->write_reg(nor, cmd, &bank_sel, 1);
> +	ret = nor->write_reg(nor, cmd, &bank_sel, 1);
> +	if (ret)
> +		return ret;
> +
> +	return write_disable(nor);
>  }
>  
>  static int write_bar(struct spi_nor *nor, u32 offset)
> @@ -1270,6 +1275,10 @@ static int write_sr_and_check(struct spi_nor *nor, u8 status_new, u8 mask)
>  	if (ret)
>  		return ret;
>  
> +	ret = write_disable(nor);
> +	if (ret)
> +		return ret;
> +
>  	ret = read_sr(nor);
>  	if (ret < 0)
>  		return ret;
> @@ -1796,13 +1805,18 @@ static int sst26_lock_ctl(struct spi_nor *nor, loff_t ofs, uint64_t len, enum lo
>  	if (ctl == SST26_CTL_CHECK)
>  		return 0;
>  
> +	/* Write latch enable before write operation */
> +	ret = write_enable(nor);
> +	if (ret)
> +		return ret;
> +
>  	ret = nor->write_reg(nor, SPINOR_OP_WRITE_BPR, bpr_buff, bpr_size);
>  	if (ret < 0) {
>  		dev_err(nor->dev, "fail to write block-protection register\n");
>  		return ret;
>  	}
>  
> -	return 0;
> +	return write_disable(nor);
>  }
>  
>  static int sst26_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
> @@ -2204,7 +2218,7 @@ static int write_sr_cr(struct spi_nor *nor, u8 *sr_cr)
>  		return ret;
>  	}
>  
> -	return 0;
> +	return write_disable(nor);
>  }
>  
>  /**
> @@ -4273,6 +4287,9 @@ static int spi_nor_init(struct spi_nor *nor)
>  				write_disable(nor);
>  			}
>  		}
> +		err = write_disable(nor);
> +		if (err)
> +			return err;
>  	}
>  
>  	if (nor->quad_enable) {
> -- 
> 2.17.1
> 
>
Tested on j721s2-evm. 
Link: https://gist.github.com/PrasanthBabuMantena/c12f39744de188a9d08cd5ca51dc2a7b

Tested-by: Prasanth Babu Mantena <p-mantena@ti.com>
