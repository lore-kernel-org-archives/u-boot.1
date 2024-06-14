Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8341C41513
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 09:46:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8821188996;
	Fri, 14 Jun 2024 11:46:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AnczyP2R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A771187B30; Fri, 14 Jun 2024 11:46:36 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76C608899F
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 11:46:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45E9kWKW081163;
 Fri, 14 Jun 2024 04:46:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718358392;
 bh=oBLNKJnLWCL8AwxZ9c9aVz1S3a1sLiYk6VWlCGrUZZk=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=AnczyP2RZ+AdQT2k7kTRUeoMo1Gvc2ARjTe8wJsnOrm6u4KWBE63Xgd4/pzkhzGVw
 BbodEkL55FteQb4YeoNbWJ3mw6OFtPHgV6vCioYtdogCkHcAbUggTh0hPYRPrPSaJA
 QwS2XxZg7+zyYuxJe+4qkeaHAkTeCovembcbzv2U=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45E9kWdH043602
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 14 Jun 2024 04:46:32 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Jun 2024 04:46:31 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Jun 2024 04:46:31 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45E9kV1M020233;
 Fri, 14 Jun 2024 04:46:31 -0500
Date: Fri, 14 Jun 2024 15:16:30 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Dhruva Gole <d-gole@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Neha Malcom Francis
 <n-francis@ti.com>, Nishant Menon <nm@ti.com>,
 <c-shilwant@ti.com>, <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH] arm: dts: k3-am625-beagleplay: Add symlinks for tiboot3
 and tispl
Message-ID: <20240614094630.pbkujnh6glttdu6d@uda0497581>
References: <20240614084052.4029849-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240614084052.4029849-1-d-gole@ti.com>
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

Hi Dhruva,

On 14:10-20240614, Dhruva Gole wrote:
> Add symlinks for both tiboot3.bin and tispl.bin because a user has to
> anyway rename these files to get the platform to boot up.
> This just makes it more intuitive and convenient.
> 
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
>  arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi | 1 +
>  arch/arm/dts/k3-am625-r5-beagleplay.dts      | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> index fb2032068d1c..bd48af8d186a 100644
> --- a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> @@ -71,6 +71,7 @@
>  
>  	ti-spl_unsigned {
>  		filename = "tispl.bin_unsigned";
> +		symlink = "tispl.bin";
>  		pad-byte = <0xff>;
>  
>  		fit {
> diff --git a/arch/arm/dts/k3-am625-r5-beagleplay.dts b/arch/arm/dts/k3-am625-r5-beagleplay.dts
> index 9db58f093c8c..da6746e009d5 100644
> --- a/arch/arm/dts/k3-am625-r5-beagleplay.dts
> +++ b/arch/arm/dts/k3-am625-r5-beagleplay.dts
> @@ -79,6 +79,7 @@
>  &binman {
>  	tiboot3-am62x-gp-evm.bin {
>  		filename = "tiboot3-am62x-gp-evm.bin";
> +		symlink = "tiboot3.bin";
>  		ti-secure-rom {
>  			content = <&u_boot_spl_unsigned>, <&ti_fs_gp>,
>  				<&combined_tifs_cfg_gp>, <&combined_dm_cfg_gp>;

Maybe do it for u-boot.img_unsigned as well, I see that also doesn't have a
symlink.

Regards,
Manorit

> 
> base-commit: 1ebd659cf020843fd8e8ef90d85a66941cbab6ec
> -- 
> 2.34.1
> 
