Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAEE0C3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 15:55:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C0C881F66;
	Fri,  2 May 2025 17:55:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BwqPZ4uD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A61E181F7E; Fri,  2 May 2025 17:55:15 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF6C3812BC
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 17:55:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 542FtBkK3897909
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 May 2025 10:55:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1746201311;
 bh=lL4/bZUERwiDqCGUksIlctZWg6nnI+8MmOLM59Usjxo=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=BwqPZ4uDeREpXXqaGL9fNNrE7qDVp7Jzg61ThREjGAfTb4shRGSiS87yl+6O4jciQ
 5Rmljek8TBR00Duloj7Z9DrusAgTyjamBGDCMGbaU0VxryCW8DbzPDMXyO5qEONOE4
 vuUcBVDdx+CM+V5yQeHx5OXXQxEpFB31o9Bn37zw=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 542FtAlr012042
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 2 May 2025 10:55:10 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 2
 May 2025 10:55:09 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 2 May 2025 10:55:09 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 542Ft9LR119230;
 Fri, 2 May 2025 10:55:09 -0500
Date: Fri, 2 May 2025 10:55:09 -0500
From: Bryan Brattlof <bb@ti.com>
To: Daniel Schultz <d.schultz@phytec.de>
CC: <trini@konsulko.com>, <d-gole@ti.com>, <vibhore@ti.com>, <kamlesh@ti.com>, 
 <nm@ti.com>, <n-francis@ti.com>, <afd@ti.com>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>
Subject: Re: [PATCH] arm: dts: k3-am62a-*-binman: Update ti-dm blob
Message-ID: <20250502155509.z57ec4dhcdsy6fsz@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250502143414.2841260-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250502143414.2841260-1-d.schultz@phytec.de>
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

On May  2, 2025 thus sayeth Daniel Schultz:
> With [1], TI changed the Device Manager for the AM62Ax to an EdgeAI
> based firmware. Update all binman device-tree files to match the
> latest firmware name.
> 
> 1: https://git.ti.com/cgit/arago-project/meta-ti/commit/?h=scarthgap&id=430bab80d46ed921e4d4dc8ecaad8a4903b514c3
> 
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
> ---
>  arch/arm/dts/k3-am62a-phycore-som-binman.dtsi | 2 +-
>  arch/arm/dts/k3-am62a-sk-binman.dtsi          | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi b/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
> index 325702ed6e0..aa4caaeae33 100644
> --- a/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
> +++ b/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
> @@ -167,7 +167,7 @@
>  	ti-dm {
>  		filename = "ti-dm.bin";
>  		blob-ext {
> -			filename = "ti-dm/am62axx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
> +			filename = "ti-dm/am62axx/dm_edgeai_mcu1_0_release_strip.out";
>  			optional;
>  		};
>  	};
> diff --git a/arch/arm/dts/k3-am62a-sk-binman.dtsi b/arch/arm/dts/k3-am62a-sk-binman.dtsi
> index 2a8c260387b..dc6e8523172 100644
> --- a/arch/arm/dts/k3-am62a-sk-binman.dtsi
> +++ b/arch/arm/dts/k3-am62a-sk-binman.dtsi
> @@ -151,7 +151,7 @@
>  	ti-dm {
>  		filename = "ti-dm.bin";
>  		blob-ext {
> -			filename = "ti-dm/am62axx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
> +			filename = "ti-dm/am62axx/dm_edgeai_mcu1_0_release_strip.out";

I've had to ask around internally to what's actually being changed in 
this different firmware blob. I think there are probably more changes 
that need to happen before we can make this switch unfortunately

~Bryan
