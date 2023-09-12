Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 827D5CA0EC3
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 07:04:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BE2D86D05;
	Tue, 12 Sep 2023 09:04:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iF9B8QIC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE59786CC4; Tue, 12 Sep 2023 09:04:31 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7F0E86961
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 09:04:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38C74QJE089268;
 Tue, 12 Sep 2023 02:04:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694502266;
 bh=/xyiG+9jtzwZ7VzW7ugQUExm2Ao33u9pj3y5FxbE/Vw=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=iF9B8QIC9bkuxeKkTzvE21xg1ljpJ/7cfJsUKS6fD886MLWMK1yEm/t4zx6wquPRA
 CU9Bm9ANmRwwjIFWNZvBuTc9/2g2yoRgV4VpwYVH2sVnyYFR0GcKt8AfsnZMoc4poJ
 IA6Ktf+umYVXqsPJffl90m+217zc0DprOBnuUr98=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38C74Pom012707
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 Sep 2023 02:04:26 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Sep 2023 02:04:25 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Sep 2023 02:04:25 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38C74ORV018949;
 Tue, 12 Sep 2023 02:04:25 -0500
Date: Tue, 12 Sep 2023 12:34:24 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: Neha Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, Bryan
 <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Marcel Ziswiler <marcel@ziswiler.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, Emanuele Ghidoli
 <emanuele.ghidoli@toradex.com>
Subject: Re: [PATCH 1/2] arm: dts: k3-pinctrl: Sync with kernel v6.6-rc1
Message-ID: <20230912070424.4vlcxflue2tycxqj@dhruva>
References: <20230911140256.945074-1-nm@ti.com>
 <20230911140256.945074-2-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230911140256.945074-2-nm@ti.com>
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

On Sep 11, 2023 at 09:02:55 -0500, Nishanth Menon wrote:
> Sync pinctrl header with v6.6-rc1
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/dts/k3-pinctrl.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/dts/k3-pinctrl.h b/arch/arm/dts/k3-pinctrl.h
> index c97548a3f42d..2a4e0e084d69 100644
> --- a/arch/arm/dts/k3-pinctrl.h
> +++ b/arch/arm/dts/k3-pinctrl.h
> @@ -11,6 +11,7 @@
>  #define PULLUDEN_SHIFT		(16)
>  #define PULLTYPESEL_SHIFT	(17)
>  #define RXACTIVE_SHIFT		(18)
> +#define DEBOUNCE_SHIFT		(11)
>  
>  #define PULL_DISABLE		(1 << PULLUDEN_SHIFT)
>  #define PULL_ENABLE		(0 << PULLUDEN_SHIFT)
> @@ -29,9 +30,20 @@
>  #define PIN_INPUT_PULLUP	(INPUT_EN | PULL_UP)
>  #define PIN_INPUT_PULLDOWN	(INPUT_EN | PULL_DOWN)
>  
> +#define PIN_DEBOUNCE_DISABLE	(0 << DEBOUNCE_SHIFT)
> +#define PIN_DEBOUNCE_CONF1	(1 << DEBOUNCE_SHIFT)
> +#define PIN_DEBOUNCE_CONF2	(2 << DEBOUNCE_SHIFT)
> +#define PIN_DEBOUNCE_CONF3	(3 << DEBOUNCE_SHIFT)
> +#define PIN_DEBOUNCE_CONF4	(4 << DEBOUNCE_SHIFT)
> +#define PIN_DEBOUNCE_CONF5	(5 << DEBOUNCE_SHIFT)
> +#define PIN_DEBOUNCE_CONF6	(6 << DEBOUNCE_SHIFT)
> +
>  #define AM62AX_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
>  #define AM62AX_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
>  
> +#define AM62PX_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
> +#define AM62PX_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
> +
>  #define AM62X_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
>  #define AM62X_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
>  

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
