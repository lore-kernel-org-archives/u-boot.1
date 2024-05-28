Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85761C25B7E
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 07:44:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04A7788361;
	Tue, 28 May 2024 09:44:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="shxOAtHx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E903883FB; Tue, 28 May 2024 09:44:39 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE9BE87F31
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 09:44:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44S7iY7r107665;
 Tue, 28 May 2024 02:44:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716882274;
 bh=Yf5RV+anhI40N1MkQvmH8torcLGETOhkrJwn2P6xH1s=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=shxOAtHxfDW0CG+1n0nU1fiJWe4CDSGDg3/4ZBKkdOno0nuLC+I94U46QHYDHBEtH
 ATpV378wm3ViYRutpxCN9psQodUay6GF8Gs6nT2+faAggdFGWkTErgFEkgV8NAxp6u
 bH0Gk/edu5tKNgokyHgnoz9lv5zqJWHXrIwymj6A=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44S7iYSN099485
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 28 May 2024 02:44:34 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 May 2024 02:44:34 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 May 2024 02:44:33 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44S7iXpi111506;
 Tue, 28 May 2024 02:44:33 -0500
Date: Tue, 28 May 2024 13:14:32 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>, <nm@ti.com>,
 <sjg@chromium.org>, <u-kumar1@ti.com>
Subject: Re: [PATCH] arm: dts: k3-j721e-r5-common-proc-board: Set parent
 clock for clock ID 342
Message-ID: <20240528074432.c6zbd3iwmsvnn5rv@uda0497581>
References: <20240528073727.4057843-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240528073727.4057843-1-n-francis@ti.com>
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

Hi Neha,

On 13:07-20240528, Neha Malcom Francis wrote:
> From: Apurva Nandan <a-nandan@ti.com>
> 
> This virtual clock mux configuration enables the use of dynamic frequency
> scaling on A72 clock ID 202 by setting up the required register.
> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
> Boot logs:
> https://gist.github.com/nehamalcom/138d25fe32d4d80af3e0e4c19c1b18e0
> 
>  arch/arm/dts/k3-j721e-r5-common-proc-board.dts | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/k3-j721e-r5-common-proc-board.dts b/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
> index 9655ca21d02..25e4b4c7663 100644
> --- a/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
> +++ b/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
> @@ -28,7 +28,8 @@
>  				<&k3_pds 4 TI_SCI_PD_EXCLUSIVE>;
>  		resets = <&k3_reset 202 0>;
>  		clocks = <&k3_clks 61 1>;
> -		assigned-clocks = <&k3_clks 202 2>, <&k3_clks 61 1>;
> +		assigned-clocks = <&k3_clks 202 2>, <&k3_clks 61 1>, <&k3_clks 342 0>;
> +		assigned-clock-parents= <0>, <0>, <&k3_clks 342 2>;

I think it would be better to base this patch on top of your j721e
of_upstream series. There you have introduced k3-j721e-r5.dtsi [0] and I
feel it would be better to put this change on that file maybe.

[0]: https://lore.kernel.org/u-boot/20240520095916.1809962-2-n-francis@ti.com/

Regards,
Manorit
>  		assigned-clock-rates = <2000000000>, <200000000>;
>  		ti,sci = <&dmsc>;
>  		ti,sci-proc-id = <32>;
> -- 
> 2.34.1
> 
