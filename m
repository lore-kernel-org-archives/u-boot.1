Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1EC5CA0EE4
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 18:41:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9C1E81E13;
	Wed, 20 Aug 2025 20:41:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="T30r+qh4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9246881FEE; Wed, 20 Aug 2025 20:41:08 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C1FF801DD
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 20:41:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-314c3dc92f4so18717fac.1
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 11:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755715265; x=1756320065; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t7A/eLLE7NpVu85KBG0zHIP2r221KebhBb2IjdyW4kk=;
 b=T30r+qh4Qq3SF7p/sXP3lc//Jy7TOH7Na3HIvDlSJVkP8B2GBv3wccCEJ5vaZPDV4z
 HagHdbKtZOmcom3W3YDTCISCHD3GqF0mtAshDtxJaWbyW664EBQv7lcfARV71fkXNrkX
 4a08XM5vww1ddEOoqvVhQDC2vbGC9xxyv+p+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755715265; x=1756320065;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t7A/eLLE7NpVu85KBG0zHIP2r221KebhBb2IjdyW4kk=;
 b=DuWqxRGXJPZ1rB0MsgQjRiXBJIJESchjExJO+mqNl/SYJlAvcHiF9hoAkV6yNNWEWN
 KARLjwRK9+NTnYCj0naifxt0A5CkG+THojdV5rwWYkXgTI0fnRwSFAc+nEW/w4jzldXO
 1J9keBN/bWo1k0RPkNPCPgk6Gfc3ranCSWgdTIH4VLnJ77WLK8wj8ThAOTCdDbG1ypxM
 Yyu587he8jy/T6iLDrBJ7KOcXzBYD4+0aNvHiY7lNmbOj5gTQCfhXHFciioa6tjQ8jiA
 Cc5UoD2OTXwRHtL9CZaX+6gGaBDQIGxEX8TcIsbslH7QcchyU2RNyQGnvjH8Jzt4apfR
 /fgQ==
X-Gm-Message-State: AOJu0YylxIIcriKWEv9pJwb10k/tAi7YjrOQgGtjZlZPUoKG+7xq2Xty
 zIOvjF7yra+P3km2YD42DdMRGrFyafQzNSoy7LAPUgzw9PP/TIKwnLUUIRuJSL/hwpI=
X-Gm-Gg: ASbGncv1DEk36qwwUKPUTvulufC9cdQCgNPXLQe+ZWVK9Mg3oqamcCj9W12q5SUc3Mk
 1/zdt3loeyBZLSNnUbeOz0jCPYF1hijTkxT9M1hi6+2Vmd77fodyJnoGe54In7urY+XpqPArez+
 tUQ8s6K4P6izv2tW2CMbBhHQOD7yP+eI+oUj+1oSCGpB5AHTcw1JaaLdetOn3NPSmzgrz0bc6tH
 8J4EZZJVm8tfuG5hCQf0Ki0K7iQfgivPfuVjx+oEPWAdey22KCVT9+8V0I3kneMZG00rD0uPNFw
 q0kxSEq103CwLZCbN9Egkmqzq4zb7aWiPI8Pb+LhcqEj+Z4ImS/6DzJ/fxfwu+0WEoE5BGcBGrf
 Uns9k24WvMgHDzKtTcIEIPUKgxzky3GIbFSR9iXt+gPVOOxlJw4P99zY=
X-Google-Smtp-Source: AGHT+IE2AdJjAMvX09WqTYdgayZwnnLaGEdElR15DDvtnK2fgEbBXR/Ph7g5AlvFp8yUwjAaLT+phg==
X-Received: by 2002:a05:6870:63a3:b0:314:9689:a464 with SMTP id
 586e51a60fabf-314c09b4e12mr330034fac.20.1755715264700; 
 Wed, 20 Aug 2025 11:41:04 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-310b6e61351sm4106096fac.0.2025.08.20.11.41.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 11:41:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Richard Genoud <richard.genoud@bootlin.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Santhosh Kumar K <s-k6@ti.com>, 
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Bhavya Kapoor <b-kapoor@ti.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, 
 Andreas Dannenberg <dannenberg@ti.com>, Moteen Shah <m-shah@ti.com>, 
 Beleswar Padhi <b-padhi@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Prasanth Babu Mantena <p-mantena@ti.com>, Wadim Egorov <w.egorov@phytec.de>, 
 Simon Glass <sjg@chromium.org>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Kishon Vijay Abraham I <kishon@ti.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Jayesh Choudhary <j-choudhary@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>, 
 Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Chintan Vankar <c-vankar@ti.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250731075956.605474-1-c-vankar@ti.com>
References: <20250731075956.605474-1-c-vankar@ti.com>
Subject: Re: [PATCH v4 00/21] Add support for Ethernet boot
Message-Id: <175571526259.3510627.5533095969532405581.b4-ty@konsulko.com>
Date: Wed, 20 Aug 2025 12:41:02 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Thu, 31 Jul 2025 13:29:35 +0530, Chintan Vankar wrote:

> This series adds bind method for CPSW to avoid explicit probing, removes
> explicit probing of CPSW, adds support for Ethernet boot on SK-AM68,
> SK-AM62P-LP, J722S, SK-AM69.
> 
> This series is based on commit 'a8f20bb6650df56d' of origin/master
> branch of U-Boot.
> 
> [...]

Applied to u-boot/next, thanks!

[01/21] net: ti: am65-cpsw-nuss: Define bind method for CPSW driver
        commit: 3943531a54680b76813960655458e88f49f6bfb7
[02/21] arch: mach-k3: common: Remove explicit probing of CPSW driver
        commit: 50ededad3204072a5fe6b8ee49826643e7c8e7aa
[03/21] Revert "mach-k3: am642_init: Probe AM65 CPSW NUSS for R5/A53 SPL"
        commit: 3967d64740b69cda6b2642036bfb9269b05a7e35
[04/21] Revert "arm: mach-k3: am62x: am625_init: Probe AM65 CPSW NUSS"
        commit: b4a0702c924851906b1c127b3c9884e8a4870bd1
[05/21] arm: mach-k3: j721s2: Update SoC auto-gen data to enable Ethernet boot
        commit: 0b092a2aa81b84eba1ea48f87c04b0be62afd1e9
[06/21] arm: mach-k3: j721s2_spl: Alias Ethernet boot to CPGMAC
        commit: e85b090165ec55ef7e19bdd7fc11e9e6f74ec58e
[07/21] net: ti: Kconfig: Enable SPL_SYSCON config for CPSW
        commit: 333b50d32d76ded3d69e3f65d47ca0de1d32dcc4
[08/21] configs: am68_sk_r5_ethboot: Add configs for enabling Ethernet boot in R5SPL
        commit: 07774020f75b51fc3437d697528cac5978b407ac
[09/21] configs: am68_sk_a72_ethboot: Enable configs required for Ethernet boot
        commit: 3325b13d53f5a8991185936adc981678eb6d1b97
[10/21] arm: mach-k3: am62p: Update SoC auto-gen data to enable Ethernet boot
        commit: 6fc2a6a97171e0d4ecb8cef9385fb1a0a0a14611
[11/21] board: ti: am62px: evm: Enable cache for AM62p
        commit: 3bab8f17fb17c59f83ef409eb14b3aec92cd3f9b
[12/21] configs: am62px_evm_r5_ethboot: Add configs to enable Ethernet boot in R5SPL
        commit: c8c2da2ab817d78efdad88b85ef4449dd5719e01
[13/21] configs: am62px_evm_a53_ethboot: Enable configs required for Ethboot
        commit: c1f1d28c44543dc0fd74653215e25f5153ddd398
[14/21] arm: mach-k3: j722s: Update SoC autogenerated data to enable Ethernet boot
        commit: a02009f3a816e7de42fccff895397906304290ef
[15/21] board: ti: j722s: evm: Enable cache for J722s
        commit: 80b529d8776fe48eb595bc3eaf739751b5bea15c
[16/21] configs: j722s_evm_r5_ethboot: Add configs to enable Ethernet boot in R5SPL
        commit: d449db6cd7c896d69e2dba2b902797d9b329beef
[17/21] configs: j722s_evm_a53_ethboot: Enable configs required for Ethernet boot
        commit: 9def2b0fc17d5ed1162d6a8fbe9a06ec26557512
[18/21] arm: mach-k3: j784s4: Update SoC auto-gen data to enable Ethernet boot
        commit: 8eecd9edb58e57018ce1a9adf9283d88541e974f
[19/21] arm: mach-k3: j784s4_spl: Alias Ethernet boot to CPGMAC
        commit: 721d5c30f5704c78e7e45fa0234c8096a1bcd683
[20/21] configs: am69_sk_r5_ethboot: Add configs to enable Ethernet boot in R5SPL
        commit: 02b2a3277116d80137e62cb931dd365eda54790c
[21/21] configs: am69_sk_a72_ethboot: Add configs to enable Ethernet boot
        commit: 841d3d06ce2c1fb9d7a785bd7df5a1b6b70003bb
-- 
Tom


