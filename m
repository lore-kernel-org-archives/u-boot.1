Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B6D4C5ACB3
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 10:54:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB64E8718E;
	Tue, 21 Nov 2023 11:54:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XLIg18ZW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19E78871CD; Tue, 21 Nov 2023 11:54:55 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 584F086D38
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 11:54:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40859dee28cso26616305e9.0
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 02:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700564091; x=1701168891;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=g9XOHiE3bwKQuNEsoZdDgX+nKVjdXvsyNCpDbyLxBFc=;
 b=XLIg18ZWj2ymuojMfQr1DUhZnf02qUIDMEPtQ/Htm6RJXEgAJsMp4Wpis5BfZCm7dW
 dSMfLNQfrpjL+2RjJsMugM6XXoR5KGKiDKbVhAP0WLn3pVemDNMLaOYCU4lbAeIHtAcd
 FIQEfYZp1rbgFDznQ4OnMgVmQy/HbX8MyNWkjY3vOCC0zES/zgUOpZ48jr/g4GNCMiry
 Smq1lptBENG3bm6BerhGJChWjj9JPkEIB+L+xSiFa9NIO/0lIggjBnF2UXemnYgoy0cV
 1SGC8MLUshVCgngdaPLR6ryJ293RSppWFPym01ckIz5vfey/S+47O2p38FcdBBBQVucU
 jVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700564091; x=1701168891;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g9XOHiE3bwKQuNEsoZdDgX+nKVjdXvsyNCpDbyLxBFc=;
 b=mh+DHz/aU/uK31n+zwdMRIwazD1996Ryksdzso0PQeNh01Q+9EnVzp7Y9wvOO+K7jp
 4HRladG/eIj6t8Xrn2O0LZ/hip9fNAhyAK83BofWCG0vWXnsuBloF8zQKjRoC0eJLHfw
 5IjcTVGBOmgunocxM0eZRNJR3Ue4zzRLnbs8nprYuQ3mFen6TE1tucSBzyLemPWeZpmO
 SNjCjFrnMIVwntMSoYYWRqIGXSoW7r/aYx2mRdHxnXNXP6AvpEM2zarnK2dNFhQfId2J
 ngjcdlONcRUQpaVy6JmtkcYsjtEGj2DKqH8gVao2X5o7kA9wk3o2MFKnWUYE2jtNpmLl
 YynQ==
X-Gm-Message-State: AOJu0Yxadg97XstU3Bd0KJceXdM4Y5Jz4rEfU+OrxcARezdT7ZWP1uD/
 y7XwBKw9thlH7DsHyYNeXU7y2w==
X-Google-Smtp-Source: AGHT+IH711hRC53ignXrqgiloc65zwgREzdoJBf8DSrEXumskdGGLVnKUW56GaZrPpmz3/ieqaCVxQ==
X-Received: by 2002:a05:600c:354f:b0:40b:2b86:c88a with SMTP id
 i15-20020a05600c354f00b0040b2b86c88amr578847wmq.2.1700564090949; 
 Tue, 21 Nov 2023 02:54:50 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 t14-20020a05600c450e00b003fee567235bsm21383758wmo.1.2023.11.21.02.54.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 02:54:50 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>, Neha Malcom Francis
 <n-francis@ti.com>, Roger Quadros <rogerq@kernel.org>, Bryan Brattlof
 <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Jai Luthra
 <j-luthra@ti.com>, u-boot@lists.denx.de, Sjoerd Simons
 <sjoerd@collabora.com>, Robert
 Nelson <robertcnelson@gmail.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Dhruva Gole <d-gole@ti.com>, Nishanth
 Menon <nm@ti.com>
Subject: Re: [PATCH V2 0/4] arm: dts: k3-am625*: Upgrade kernel dts to v6.7-rc1
In-Reply-To: <20231115032857.3071474-1-nm@ti.com>
References: <20231115032857.3071474-1-nm@ti.com>
Date: Tue, 21 Nov 2023 11:54:49 +0100
Message-ID: <87v89vl6km.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Nishanth,

Thank you for the series.

On mar., nov. 14, 2023 at 21:28, Nishanth Menon <nm@ti.com> wrote:

> Hi,
> rev 2 of the series to sync am62 with v6.7-rc1.
>
> Changes:
> - picked up reviews, tested tags.
> - minor commit message correction in patch #4.
>
> Boot logs:
> https://gist.github.com/nmenon/d62c4795c6d3d40c83ba36d1cd047c42
>
> WARNING: This will have  a minor conflict (binman) with:
> https://lore.kernel.org/u-boot/20231104080137.9628-1-nm@ti.com/
>
>
> I haven't had a chance to test this out on verdin (only build tested)
> - going to depend on any checks folks can provide.
>
> V1: https://lore.kernel.org/all/20231113145919.1928812-1-nm@ti.com/
>
> Nishanth Menon (4):
>   arm: dts: k3-am625*: Sync with kernel v6.7-rc1
>   arm: dts: k3-am625: Drop SoC provided bootph params from board
>     u-boot/r5 dtsi
>   arm: dts: k3-am625-beagleplay-u-boot: drop duplicate bootph-nodes
>   arm: dts: k3-am625-sk-r5/u-boot: Drop duplicate bootph-nodes

Boot tested eMMC boot on AM62 SK EVM.

For the whole series:

Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # am625 sk

>
>  arch/arm/dts/k3-am62-main.dtsi                |  12 +-
>  arch/arm/dts/k3-am62-mcu.dtsi                 |   2 +
>  arch/arm/dts/k3-am62-verdin-wifi.dtsi         |   6 +
>  arch/arm/dts/k3-am62-verdin.dtsi              |   1 +
>  arch/arm/dts/k3-am62-wakeup.dtsi              |   2 +
>  arch/arm/dts/k3-am62.dtsi                     |   3 +
>  arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi  | 110 -------------
>  arch/arm/dts/k3-am625-beagleplay.dts          |  34 +++-
>  arch/arm/dts/k3-am625-r5-beagleplay.dts       |   9 --
>  arch/arm/dts/k3-am625-r5-sk.dts               |  21 +--
>  arch/arm/dts/k3-am625-sk-u-boot.dtsi          | 145 ------------------
>  arch/arm/dts/k3-am625-sk.dts                  |  27 ++++
>  arch/arm/dts/k3-am625-verdin-r5.dts           |   9 --
>  .../dts/k3-am625-verdin-wifi-dev-u-boot.dtsi  |  55 +------
>  arch/arm/dts/k3-am62x-sk-common.dtsi          | 109 ++++++++++++-
>  15 files changed, 197 insertions(+), 348 deletions(-)
>
> -- 
> 2.40.0
