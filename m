Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C47FCA0EF2
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 15:55:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 230A386406;
	Tue, 12 Sep 2023 17:55:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="eJj9cPIv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4079A86FA4; Tue, 12 Sep 2023 17:55:24 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D26D86406
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 17:55:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38CFtG4v101403;
 Tue, 12 Sep 2023 10:55:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694534116;
 bh=n0MixtHh8AOki4hBF++3oLysBBaZZEX2jTNpANHKBlM=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=eJj9cPIv/DUjonZGUN/17DQm225WUKqyYsJ0qORZ+28X59WIS+w3W0eLnuZzV4KbT
 CYg96IWSG5GLPugJOS+e04GCRU0j9NIyxhPhffOCXzVX+UhBuwuGRuTrpiVdmUW1xq
 B0QWUtD+UiSbgxraro0wQvAyCO7kxJPIY117z0hA=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38CFtG8o076448
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 Sep 2023 10:55:16 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Sep 2023 10:55:13 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Sep 2023 10:55:13 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38CFtDgM128129;
 Tue, 12 Sep 2023 10:55:13 -0500
Date: Tue, 12 Sep 2023 10:55:13 -0500
From: Nishanth Menon <nm@ti.com>
To: Udit Kumar <u-kumar1@ti.com>
CC: <vigneshr@ti.com>, <jh80.chung@samsung.com>, <lukma@denx.de>,
 <seanga2@gmail.com>, <trini@konsulko.com>, <u-boot@lists.denx.de>,
 <n-francis@ti.com>, <a-nandan@ti.com>
Subject: Re: [PATCH v2 1/3] power: domain: ti: Enable single config for power
 domain
Message-ID: <20230912155513.qesx4fhbn4rneyvi@mumps>
References: <20230912130645.1202325-1-u-kumar1@ti.com>
 <20230912130645.1202325-2-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230912130645.1202325-2-u-kumar1@ti.com>
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

On 18:36-20230912, Udit Kumar wrote:
> TI SOC has two power domain TI_SCI_POWER_DOMAIN and
> TI_POWER_DOMAIN. These are mutually exclusive.
> So adding rule to select one, in case defconfig enabled both.
> 
> Suggested-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
>  drivers/power/domain/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
> index 411c210756..30c358fb88 100644
> --- a/drivers/power/domain/Kconfig
> +++ b/drivers/power/domain/Kconfig
> @@ -92,7 +92,7 @@ config TEGRA186_POWER_DOMAIN
>  
>  config TI_SCI_POWER_DOMAIN
>  	bool "Enable the TI SCI-based power domain driver"
> -	depends on POWER_DOMAIN && TI_SCI_PROTOCOL
> +	depends on POWER_DOMAIN && TI_SCI_PROTOCOL && !TI_POWER_DOMAIN
>  	help
>  	  Generic power domain implementation for TI devices implementing the
>  	  TI SCI protocol.
> -- 
> 2.34.1
> 

Reviewed-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
