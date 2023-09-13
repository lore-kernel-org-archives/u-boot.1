Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C66EDEC44
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 11:32:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B235D869F6;
	Wed, 13 Sep 2023 13:32:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MW6AvxI/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5F4B86CF5; Wed, 13 Sep 2023 13:32:36 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57EAA8694A
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 13:32:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38DBWTJK004009;
 Wed, 13 Sep 2023 06:32:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694604749;
 bh=rafdhPPORDfIDJZBoqAd0gLN6B+6kq3Nz6YfyTvHGFg=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=MW6AvxI//+i5mRb9yilULwIaajbFsB++PWh7jejJg66UHXTFFsrlULmbr2F0nJ2Cf
 1sDjDYhOU/eHGYJJP5UeSluqaWanz1cboWuV7BaHTHSzmhGxeId2uc9+6+5mPJyzY8
 iG683IEBPe7+I0IxlEavar91pfBXq0dFHevWWOKQ=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38DBWTqS085541
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 13 Sep 2023 06:32:29 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 13
 Sep 2023 06:32:29 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 13 Sep 2023 06:32:29 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38DBWTQT034956;
 Wed, 13 Sep 2023 06:32:29 -0500
Date: Wed, 13 Sep 2023 06:32:29 -0500
From: Nishanth Menon <nm@ti.com>
To: Udit Kumar <u-kumar1@ti.com>
CC: <vigneshr@ti.com>, <jh80.chung@samsung.com>, <lukma@denx.de>,
 <seanga2@gmail.com>, <trini@konsulko.com>, <u-boot@lists.denx.de>,
 <n-francis@ti.com>, <a-nandan@ti.com>
Subject: Re: [PATCH v3 3/3] config: j7200: remove not needed power config
Message-ID: <20230913113229.uyw3em4vinhneb6t@grasp>
References: <20230913043930.1316130-1-u-kumar1@ti.com>
 <20230913043930.1316130-4-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230913043930.1316130-4-u-kumar1@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 10:09-20230913, Udit Kumar wrote:
> For J7200, R5/SPL TI_SCI_POWER_DOMAIN should be
> disabled as DM is a separate binary like other
> SOC of J7* family.
> 
> Fixes: 02dff65efe70 ("configs: j7200_evm_r5: Add initial support")
> 
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
>  configs/j7200_evm_r5_defconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/configs/j7200_evm_r5_defconfig b/configs/j7200_evm_r5_defconfig
> index 6d240b16cb..9e744ba434 100644
> --- a/configs/j7200_evm_r5_defconfig
> +++ b/configs/j7200_evm_r5_defconfig
> @@ -126,7 +126,6 @@ CONFIG_SPL_PINCTRL=y
>  # CONFIG_SPL_PINCTRL_GENERIC is not set
>  CONFIG_PINCTRL_SINGLE=y
>  CONFIG_POWER_DOMAIN=y
> -CONFIG_TI_SCI_POWER_DOMAIN=y
>  CONFIG_TI_POWER_DOMAIN=y
>  CONFIG_DM_PMIC=y
>  CONFIG_PMIC_TPS65941=y
> -- 
> 2.34.1
> 

Reviewed-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
