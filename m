Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A52C83F03
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 08:22:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 387E983390;
	Wed,  9 Jul 2025 10:22:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="disWmvfa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3181083394; Wed,  9 Jul 2025 10:22:02 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA5C383371
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 10:21:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5698LcSc1394719;
 Wed, 9 Jul 2025 03:21:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1752049298;
 bh=jbwr+aXOIO+iLx0V609ousk2kdSowvMIRbwb+HOlJcU=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=disWmvfadgufkRPj03w921HnTTYiere6ciAWlbKl0/QTVE/Jzie1jfZbTkUbH8RCZ
 jcB8SF4mlGtsutzvIhRAStfO0fF9VxwLZK97UePmZJHdGhC4k3svgtvSlDKxMc80y7
 y40ULBYXkzJBidt/P63rAE39d38uP3WFg9kF46c8=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5698LccB1825252
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 9 Jul 2025 03:21:38 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 9
 Jul 2025 03:21:38 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 9 Jul 2025 03:21:38 -0500
Received: from localhost (prasanth-server.dhcp.ti.com [172.24.227.142])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5698LbBq3321905;
 Wed, 9 Jul 2025 03:21:37 -0500
Date: Wed, 9 Jul 2025 13:51:36 +0530
From: Prasanth Mantena <p-mantena@ti.com>
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
CC: <u-boot@lists.denx.de>, <tudor.ambarus@linaro.org>, <j-humphreys@ti.com>, 
 <marex@denx.de>, <michal.simek@amd.com>, <jagan@amarulasolutions.com>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <trini@konsulko.com>,
 <seanga2@gmail.com>, <caleb.connolly@linaro.org>, <sjg@chromium.org>,
 <william.zhang@broadcom.com>, <stefan_b@posteo.net>,
 <quentin.schulz@cherry.de>, <Takahiro.Kuwano@infineon.com>,
 <git@amd.com>, Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
Subject: Re: [PATCH v2] spi: cadence_qspi: Fix odd byte write issue in STIG
 mode
Message-ID: <20250709082136.aiq63w4br3cyjxao@prasanth-server>
References: <20250704040444.671604-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250704040444.671604-1-venkatesh.abbarapu@amd.com>
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

On 09:34, Venkatesh Yadav Abbarapu wrote:
> Starting from 'commit <8077d296adff> ("spi: cadence-quadspi: Use STIG
> mode for all ops with small payload") the utilization of STIG mode
> has been implemented for read and write operations involving less
> than 8 bytes of data.
> 
> However, following this commit, encountering timeout issues occurs when
> writing odd bytes of data in DDR mode, as indicated below:
> "jedec_spi_nor flash@0: flash operation timed out
> SF: 3 bytes @ 0x0 Written: ERROR -110"
> 
> To resolve this issue, the number of bytes to write has been updated
> specifically for DDR mode.
> 
> Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
> Changes in v2:
> -Modified the logic from using modulus and changed to use "logical and" 
> operator to check the odd bytes.
> ---
>  drivers/spi/cadence_qspi_apb.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
> index b579699d2eb..76569a8019b 100644
> --- a/drivers/spi/cadence_qspi_apb.c
> +++ b/drivers/spi/cadence_qspi_apb.c
> @@ -554,6 +554,9 @@ int cadence_qspi_apb_command_write(struct cadence_spi_priv *priv,
>  	void *reg_base = priv->regbase;
>  	u8 opcode;
>  
> +	if (priv->dtr)
> +		txlen += txlen & 1;
> +

Hi Venkatesh,

1> Is this not a generic problem, having a DTR write in stig mode. If so,
shouldn't this be handled at the spi-nor core level.

2> You are just increasing the number of bytes here, aren't we writing
an unwanted extra data ? Where did we pad the buffer ?


Thanks,
Prasanth

>  	if (priv->dtr)
>  		opcode = op->cmd.opcode >> 8;
>  	else
> -- 
> 2.34.1
> 
