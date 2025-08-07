Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E01C87FD2
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 04:49:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30ED483AFD;
	Thu,  7 Aug 2025 06:49:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KPc5wxWC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF81083B96; Thu,  7 Aug 2025 06:49:45 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1ED383AB9
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 06:49:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5774ng2V278672;
 Wed, 6 Aug 2025 23:49:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1754542182;
 bh=CacL2Kq7GIs6IhJE8hQHpLlhPDkxPxt/+rDD0FnQyfU=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=KPc5wxWCEhdnDgoIvfLTjB8vUChk61mxp8wYJLsa72mfNjZ592y1D7y9HE3wtUSKQ
 JmyBRvgg0FLR04UFe6QDH9+bz4sJzQoYD9uLNsf+oko5i6Pnsw4/epK4F/sVAtEIq+
 5n6BTE44oTMszyg0se32kcqAYGDU8Y86yCATqw4E=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5774ngD4544412
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 6 Aug 2025 23:49:42 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 6
 Aug 2025 23:49:42 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 6 Aug 2025 23:49:42 -0500
Received: from [172.24.20.139] (lt5cd2489kgj.dhcp.ti.com [172.24.20.139])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5774ndID753422;
 Wed, 6 Aug 2025 23:49:40 -0500
Message-ID: <a2cdad2f-51d1-460b-960c-a5f6a648c1d1@ti.com>
Date: Thu, 7 Aug 2025 10:19:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] ram: k3-ddrss: Add support for number of
 controllers under MSMC
To: Neha Malcom Francis <n-francis@ti.com>, <trini@konsulko.com>, <bb@ti.com>, 
 <w.egorov@phytec.de>, <s-k6@ti.com>, <marek.vasut+renesas@mailbox.org>
CC: <u-boot@lists.denx.de>
References: <20250730133720.3315478-1-n-francis@ti.com>
 <20250730133720.3315478-7-n-francis@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250730133720.3315478-7-n-francis@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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


On 7/30/2025 7:07 PM, Neha Malcom Francis wrote:
> In K3 multi-DDR systems, the MSMC is responsible for the interleave
> mechanism across all the DDR controllers. Add support for MSMC to obtain
> the number of controllers it's responsible for using the DT.
>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>   drivers/ram/k3-ddrss/k3-ddrss.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
> index cd117d7eba7..2d2558eaa9e 100644
> --- a/drivers/ram/k3-ddrss/k3-ddrss.c
> +++ b/drivers/ram/k3-ddrss/k3-ddrss.c
> @@ -127,6 +127,7 @@ struct k3_msmc {
>   	enum ecc_enable enable;
>   	enum emif_config config;
>   	enum emif_active active;
> +	u32 num_ddr;

num_ddr to num_ddr_controllers

with this change

Reviewed-by: Udit Kumar <u-kumar1@ti.com>


>   };
>   
>   #define K3_DDRSS_MAX_ECC_REG		3
> @@ -1007,6 +1008,13 @@ static int k3_msmc_probe(struct udevice *dev)
>   		return -EINVAL;
>   	}
>   
> +	ret = device_get_child_count(dev);
> +	if (ret <= 0) {
> +		dev_err(dev, "no child ddr nodes present");
> +		return -EINVAL;
> +	}
> +	msmc->num_ddr = ret;
> +
>   	return 0;
>   }
>   
