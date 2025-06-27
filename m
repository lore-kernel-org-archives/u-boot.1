Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7306BC77B7F
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 10:22:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C477382EC6;
	Fri, 27 Jun 2025 12:22:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="O8lbPdV0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C53082F10; Fri, 27 Jun 2025 12:22:33 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 917C282E9A
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 12:22:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55RAMKSQ2388215;
 Fri, 27 Jun 2025 05:22:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1751019740;
 bh=Jv8Ehu8tjm6U8sW2e5nisfZC+WTrdQGU+vVZCpz5RlE=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=O8lbPdV00a94X5nY+MIRmd3O7CdRdv+HWhDCobJKqMMU0dU9zIfaCt4CnflLoAtEJ
 OsoagTPptaNtr7Y3pAmnk2KKhKzXtkOLWpaMG1GtpA4NGqiMF+BtwftIoRD26/trhw
 Yq+PfxDfi96oLVsKoEttQSA9qSK2CzlMpwZTJbbs=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55RAMJVX299971
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 27 Jun 2025 05:22:19 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 27
 Jun 2025 05:22:19 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 27 Jun 2025 05:22:19 -0500
Received: from localhost (uda0497581-hp.dhcp.ti.com [172.24.227.253])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55RAMI862910428;
 Fri, 27 Jun 2025 05:22:19 -0500
Date: Fri, 27 Jun 2025 15:52:18 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Gokul <g-praveen@ti.com>
CC: <trini@konsulko.com>, <casey.connolly@linaro.org>,
 <tien.fong.chee@altera.com>, <sjg@chromium.org>,
 <patrick.rudolph@9elements.com>, <1425075683@qq.com>,
 <Oliver.Gaskell@analog.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/1] configs: KASLR OPTEE RNG support for K3 devices
Message-ID: <20250627102218.xtjlreu5qmpmfszr@uda0497581-HP>
References: <20250627092224.36325-1-g-praveen@ti.com>
 <20250627092224.36325-2-g-praveen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250627092224.36325-2-g-praveen@ti.com>
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

Hi Gokul,

On 14:52-20250627, Gokul wrote:
> From: Gokul Praveen <g-praveen@ti.com>
> 
> Add KASLR OPTEE RNG support across K3 devices by enabling the required
> configs.
> 
> Signed-off-by: Gokul Praveen <g-praveen@ti.com>
> ---
>  arch/arm/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 7282c4123b0..cd27e5a5422 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -805,6 +805,9 @@ config ARCH_K3
>  	select REGEX
>  	select FIT_SIGNATURE if ARM64
>  	imply TI_SECURE_DEVICE
> +	imply DM_RNG
> +	imply TEE
> +	imply OPTEE
>  

Does it get enabled for R5 based defconfigs too in .config? ARCH_K3 is
enabled for both R5 and ARM64 cores so wondering if we are ending up
enabling it for R5 too which might not be required ( or is it? )

Regards,
Manorit

>  config ARCH_OMAP2PLUS
>  	bool "TI OMAP2+"
> -- 
> 2.34.1
> 
