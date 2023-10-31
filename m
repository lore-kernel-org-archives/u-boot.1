Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B7CBC4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 11:54:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA29D8757E;
	Tue, 31 Oct 2023 12:54:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mSoZajMg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CB43875F2; Tue, 31 Oct 2023 12:54:16 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F8B28757E
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 12:54:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39VBs99o062349;
 Tue, 31 Oct 2023 06:54:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698753249;
 bh=NOy/IEY8axzv3sAiqxMxU2cBRdwZqyS46N5tgY7w0Qc=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=mSoZajMgdjRcbuLW0hNOt6b8kbQ5Af7lBx/iMd+gFBeAkg1mlbN1k7VOSKzWrdUf5
 lw4mr4+AxcLfplHxneo6JtQ6LTWLEwMnYeAFXsLSfx6POF8d50emGPsBrPgp+YzUF1
 /mZAYaxrTKYGSjx79mFA4WZrmv/F0NIQnmyblgyk=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39VBs9A4051652
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 31 Oct 2023 06:54:09 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 31
 Oct 2023 06:54:09 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 31 Oct 2023 06:54:09 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39VBs9X7047559;
 Tue, 31 Oct 2023 06:54:09 -0500
Date: Tue, 31 Oct 2023 06:54:09 -0500
From: Nishanth Menon <nm@ti.com>
To: Nitin Yadav <n-yadav@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 1/4] arm: dts: Refactor common dtsi file for R5 and
 A53 SPL
Message-ID: <20231031115409.psb6on2zdgin2zhp@among>
References: <20231030110138.1347603-1-n-yadav@ti.com>
 <20231030110138.1347603-2-n-yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231030110138.1347603-2-n-yadav@ti.com>
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

On 16:31-20231030, Nitin Yadav wrote:
[...]
> ---
> diff --git a/arch/arm/dts/k3-am625-sk-u-boot.dtsi b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
> index c1685bc9ca..1a5238fb11 100644
> --- a/arch/arm/dts/k3-am625-sk-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
> @@ -1,102 +1,12 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Common AM625 SK dts file for SPLs
> - * Copyright (C) 2021-2022 Texas Instruments Incorporated - https://www.ti.com/
> + * AM625 SK dts file for SPLs
> + * Copyright (C) 2021-2023 Texas Instruments Incorporated - https://www.ti.com/
>   */
>  
> -#include "k3-am625-sk-binman.dtsi"
> -
> -/ {
> -	chosen {
> -		stdout-path = "serial2:115200n8";
> -		tick-timer = &main_timer0;
> -	};
> -
> -	aliases {
> -		mmc1 = &sdhci1;
> -	};
> -
> -	memory@80000000 {
> -		bootph-pre-ram;
> -	};
> -};
> -
> -&cbass_main {
> -	bootph-pre-ram;
> -};

What code base are you based off?
https://github.com/u-boot/u-boot/blob/master/arch/arm/dts/k3-am625-sk-u-boot.dtsi#L29

your patch does not match with the code that is in upstream.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
