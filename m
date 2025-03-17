Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 338F2C28B30
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 03:55:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EC928058A;
	Mon, 17 Mar 2025 04:55:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NfYxURWm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D68880F4C; Mon, 17 Mar 2025 04:55:40 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A431F800C2
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 04:55:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52H3tZFE2222832
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 16 Mar 2025 22:55:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1742183735;
 bh=8EoJDI1SOtVgLIm1Kfw0OziWBg8cH6nWVbFIhbiPv5U=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=NfYxURWm2MK7d4FQLaQHOQfGmMQWC7qttmqz2zgcRp99OT1hrLA5l6se3nZwaFOOZ
 +PsBlQs0NuLW5Dtgqz9HubMnx0ZTu2AoMhTFpnMJ3hrc6YH4HV5RvaNLDiM8FYdCnV
 3ETiIvIwm94CTApgUzFuwqhfKlbhn/m3FZDQsNMg=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52H3tZmm106500;
 Sun, 16 Mar 2025 22:55:35 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 16
 Mar 2025 22:55:35 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 16 Mar 2025 22:55:35 -0500
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52H3tWK6000568;
 Sun, 16 Mar 2025 22:55:33 -0500
Message-ID: <b8a97a67-7eab-452b-afda-6d70168b5502@ti.com>
Date: Mon, 17 Mar 2025 09:25:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: am68_sk_r5: Enable AVS config
To: Udit Kumar <u-kumar1@ti.com>, <trini@konsulko.com>, <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, <nm@ti.com>, <m-chawdhry@ti.com>,
 <j-keerthy@ti.com>, <m-shah@ti.com>, <a-limaye@ti.com>
References: <20250314123824.2886341-1-u-kumar1@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20250314123824.2886341-1-u-kumar1@ti.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Udit

On 14/03/25 18:08, Udit Kumar wrote:
> Enable AVS config
> 
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
> Test logs
> https://gist.github.com/uditkumarti/9b30461e66aa27e4a813a65f1c552e51#file-gistfile1-txt-L298
> 
> Following print was added to see AVS voltage setting at
> diff --git a/drivers/misc/k3_avs.c b/drivers/misc/k3_avs.c
> index 0774e0a4c9e..ed1a5768147 100644
> --- a/drivers/misc/k3_avs.c
> +++ b/drivers/misc/k3_avs.c
> @@ -142,7 +142,7 @@ static int k3_avs_program_voltage(struct k3_avs_privdata *priv,
> 
>                 vd2->flags |= VD_FLAG_INIT_DONE;
>         }
> -
> +       printf("Finally setting voltage \n");

Was this printf intended to be in the patch?

>         return regulator_set_value(vd->supply, volt);
>  }
> 
> 
>  configs/am68_sk_r5_defconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/configs/am68_sk_r5_defconfig b/configs/am68_sk_r5_defconfig
> index 097bed62061..d6ef89c7b84 100644
> --- a/configs/am68_sk_r5_defconfig
> +++ b/configs/am68_sk_r5_defconfig
> @@ -6,7 +6,6 @@ CONFIG_SOC_K3_J721S2=y
>  CONFIG_TARGET_J721S2_R5_EVM=y
>  
>  CONFIG_ESM_K3=n
> -CONFIG_K3_AVS0=n
>  CONFIG_ESM_PMIC=n
>  CONFIG_DM_REGULATOR_TPS65941=n
>  CONFIG_PMIC_TPS65941=n

-- 
Thanking You
Neha Malcom Francis
