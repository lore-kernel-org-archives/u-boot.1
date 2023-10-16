Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C1A8CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 16:29:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE0C086BA6;
	Mon, 16 Oct 2023 18:29:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="O19sNChu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D54486BF2; Mon, 16 Oct 2023 18:29:26 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41ECB86BA1
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 18:29:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39GGTGoY089285;
 Mon, 16 Oct 2023 11:29:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1697473756;
 bh=ZXjLw+i8mVW3i1ERHWUWvk7pNipVUyGVLqKkTWbA4BA=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=O19sNChuDPtUop3X5wpil/LpBUX+9tWV7TsaIjFzjIWkE84wEfX7x3lLG0m/s0XYE
 Trh4ZuKQC6n4ai5jjTBoLASxmSX/fDGCBQmvW8IfWZmbF1Rhu2pV3fYBqF9yvDRg6p
 wlifOQ4Yfg/sksQF624sdXUjpav/PFfUbXBHdm3M=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39GGTGtm117014
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 16 Oct 2023 11:29:16 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 16
 Oct 2023 11:29:15 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 16 Oct 2023 11:29:15 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39GGTFHe120591;
 Mon, 16 Oct 2023 11:29:15 -0500
Date: Mon, 16 Oct 2023 11:29:15 -0500
From: Nishanth Menon <nm@ti.com>
To: Thomas Richard <thomas.richard@bootlin.com>
CC: <u-boot@lists.denx.de>, <thomas.petazzoni@bootlin.com>,
 <gregory.clement@bootlin.com>, <u-kumar1@ti.com>, Gowtham Tammana
 <g-tammana@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 1/9] DO NOT MERGE: arm: dts: k3-j7200-r5-common: Add pmic
 node for esm
Message-ID: <20231016162915.53tpyquivwltekdr@anagram>
References: <20231016141135.325698-1-thomas.richard@bootlin.com>
 <20231016141135.325698-2-thomas.richard@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231016141135.325698-2-thomas.richard@bootlin.com>
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

On 16:11-20231016, Thomas Richard wrote:
> From: Gowtham Tammana <g-tammana@ti.com>
> 
> Add pmic tps659413 node needed for ESM error event handling.
> 
> Signed-off-by: Gowtham Tammana <g-tammana@ti.com>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---
> 
>  arch/arm/dts/k3-j7200-r5-common-proc-board.dts | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> index e62f9218e8..2bf0d5e3c0 100644
> --- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> +++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> @@ -249,13 +249,24 @@
>  
>  &wkup_i2c0 {
>  	bootph-pre-ram;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&wkup_i2c0_pins_default>;
> +	clock-frequency = <400000>;
> +
> +	tps659413: tps659413@48 {
> +		compatible = "ti,tps659413";
> +		reg = <0x48>;
> +		bootph-pre-ram;
> +
> +		regulators_a: regulators {
> +			bootph-pre-ram;
> +		};
> +	};
> +
>  	lp876441: lp876441@4c {
>  		compatible = "ti,lp876441";
>  		reg = <0x4c>;
>  		bootph-pre-ram;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&wkup_i2c0_pins_default>;
> -		clock-frequency = <400000>;
>  
>  		regulators: regulators {
>  			bootph-pre-ram;
> -- 
> 2.39.2
> 

Please send these changes upstream linux kernel.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
