Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65692C28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 19:13:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A10CB812BC;
	Sun, 30 Mar 2025 21:12:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WQm+mM61";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 870FE8144A; Sun, 30 Mar 2025 21:12:58 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5725A80FDA
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 21:12:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=arturkow2000@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5e5cd420781so7520616a12.2
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 12:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743361975; x=1743966775; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=REwa9p3MMjI7vrno5DDEPM4fYogsmKhbMmV7R2i3mww=;
 b=WQm+mM61ZWcWcJyLHx/U6IEwCfHqB4SKiNOSSpExiVdy19H4AOyTwvrXr9sfPRGIgv
 FvosejFOunYVljJgdFDkiAJoAot78V5jYpStRPY6a594GamFlnw2ZBqbmQKFyUafjDHp
 icYP4tFL8lkuUdITQsTI2tMXv/vGyYtJ6mbinILNs9kKWoScShtxHKULOONfvwp8BvKk
 gqSDPZFFL2YCBqo+65WTGGWDXlf6S74QCZ+eoVfA/O/uHIeuKwrVrgvWKNu+9PWkXXjw
 SfzVux02k1V7tBJAOQ1sTndiVFsy9eMDJb99nLP3402sALS5UfPU5+HMTrVFKFSYX0OV
 Dp0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743361975; x=1743966775;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=REwa9p3MMjI7vrno5DDEPM4fYogsmKhbMmV7R2i3mww=;
 b=iVeTrA6uk3MiXAsLrpdg6Y2fyLZ5QnROpGsQiF8J6H/Lu5l8XRHej8RqWz/Asidu4h
 tKc9rCIvnQU0Uih4IQGvDXxu1L7/Slm/jmjoOZkngC03YKAMmMrJMcTSJuzKYD0wQA6S
 +oEq06KjuRXzSZRHkGlw9ITlTOA6TzllW9tg1eg/u85+HRS1xCW9WK4ikt6VUNRleCtp
 U5BuQysTmp596Ppg7gunUJ5YkaKew09NwQYpAnOkOn/mfybqMksVTSRDsmUfwLbaVOF5
 PyqkMsVM7OYV2VilBRjdJDqTfZ0EEUMWdIgNZJRMFKWS8ksI6g3vw0y+DGwmaQKT05VY
 9EKA==
X-Gm-Message-State: AOJu0YxVCBkvRA8Ce0R7RYtv2tEJlTDC+qCE65pBbwZS5fbBsGmH9XwV
 ucYl9GlfpG+bDDaz2mfyOqNyOsp97qGLYCp3eJMap5sux3OmFooL7qGAESiZ
X-Gm-Gg: ASbGncus6cSt4u4OzVTKlfBR4I9kp8Z0lR1BAGtersa9acsoEgipsMowWTO6fuJS6qp
 sgmrX1/Nmlm1GUgMU8fwP0ExshEhFGAFi2jfvFivpDteqZPjgXk5THTj+/O+C6de06Cb640YSlz
 0pMFAVVnqZ46p0O9jU/aRrYgLf2P6ZbecmRf9h6uElHj+BtfAjBv3buZjipyvfRJOVXdXkuIboP
 SQ57g40E8GbA/DuC/LfDGooVc2kBZPBQtUoZvV29V4Xo6rtAb6dSxgYj8Uk+EWx76+IDMS3B2Qp
 bYxAUWklT/5tVFQLJH/kIqcscYdxNuIHDAf4OWPK34q1PYVu2bQ=
X-Google-Smtp-Source: AGHT+IHj6keUnB0wnZZ3BgaiSB1BZBLN179T4xnw0ks5mxERPQpMeLyYkwDtG5QII8Mb/zpsjmnXuA==
X-Received: by 2002:a05:6402:d0b:b0:5de:dfd0:9d22 with SMTP id
 4fb4d7f45d1cf-5edfd705782mr5610146a12.22.1743361974580; 
 Sun, 30 Mar 2025 12:12:54 -0700 (PDT)
Received: from eta.play.pl ([2a02:a312:c49b:a180:1d7c:64d:f4dd:a029])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5edc17b1da5sm4844046a12.49.2025.03.30.12.12.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 12:12:53 -0700 (PDT)
From: Artur Kowalski <arturkow2000@gmail.com>
To: u-boot@lists.denx.de
Cc: Artur Kowalski <arturkow2000@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stephen Warren <swarren@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 Tom Warren <twarren@nvidia.com>
Subject: [RFC PATCH] pinctrl: tegra: detect unknown/invalid pin/func
 configurations
Date: Sun, 30 Mar 2025 21:11:54 +0200
Message-ID: <20250330211153.RFC.1.Iebf436d41ff5f52c0b11aaf9e8f98d6a2d4d56bc@changeid>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Tegra20 driver doesn't know about some pin configurations and even about
some pins. In case when pin configuration is unknown the pin would be
muxed to whatever is under function 0, in case when pin itself is
unknown, it could cause out-of-bounds array access in pinmux_set_func
and pinmux_set_pullupdown.

Signed-off-by: Artur Kowalski <arturkow2000@gmail.com>
---
This allows to detect some unsupported/partially supported pinmux functions.
Without this patch, U-Boot boots "normally" on Transformer T20, unless
we enable debug by defining DEBUG in include/log.h, then we will hit an
assertion in pinmux_set_func: pmux_func_isvalid.

With this patch I get following warnings:

warning: not muxing i2cp(18) to i2cp(64): invalid pin or function
warning: not muxing ld0(64) to displaya(64): invalid pin or function
warning: not muxing ld1(65) to displaya(64): invalid pin or function
warning: not muxing ld2(66) to displaya(64): invalid pin or function
warning: not muxing ld3(67) to displaya(64): invalid pin or function
warning: not muxing ld4(68) to displaya(64): invalid pin or function
warning: not muxing ld5(69) to displaya(64): invalid pin or function
warning: not muxing ld6(70) to displaya(64): invalid pin or function
warning: not muxing ld7(71) to displaya(64): invalid pin or function
warning: not muxing ld8(72) to displaya(64): invalid pin or function
warning: not muxing ld9(73) to displaya(64): invalid pin or function
warning: not muxing ld10(74) to displaya(64): invalid pin or function
warning: not muxing ld11(75) to displaya(64): invalid pin or function
warning: not muxing ld12(76) to displaya(64): invalid pin or function
warning: not muxing ld13(77) to displaya(64): invalid pin or function
warning: not muxing ld14(78) to displaya(64): invalid pin or function
warning: not muxing ld15(79) to displaya(64): invalid pin or function
warning: not muxing ld16(80) to displaya(64): invalid pin or function
warning: not muxing ld17(81) to displaya(64): invalid pin or function
warning: not muxing ldi(102) to displaya(64): invalid pin or function
warning: not muxing lhp0(82) to displaya(64): invalid pin or function
warning: not muxing lhp1(83) to displaya(64): invalid pin or function
warning: not muxing lhp2(84) to displaya(64): invalid pin or function
warning: not muxing lhs(103) to displaya(64): invalid pin or function
warning: not muxing lpp(104) to displaya(64): invalid pin or function
warning: not muxing lpw0(99) to displaya(64): invalid pin or function
warning: not muxing lpw2(101) to displaya(64): invalid pin or function
warning: not muxing lsc0(91) to displaya(64): invalid pin or function
warning: not muxing lsc1(92) to displaya(64): invalid pin or function
warning: not muxing lsck(93) to displaya(64): invalid pin or function
warning: not muxing lsda(97) to displaya(64): invalid pin or function
warning: not muxing lspi(96) to displaya(64): invalid pin or function
warning: not muxing lvp1(86) to displaya(64): invalid pin or function
warning: not muxing lvs(90) to displaya(64): invalid pin or function
warning: not muxing rm(25) to i2c1(64): invalid pin or function
warning: not muxing uad(53) to irda(64): invalid pin or function

and pins:
warning: not configuring pull/tristate on lc(121): invalid pin
warning: not configuring pull/tristate on ls(121): invalid pin
warning: not configuring pull/tristate on ld17_0(121): invalid pin
warning: not configuring pull/tristate on ld19_18(121): invalid pin
warning: not configuring pull/tristate on ld21_20(121): invalid pin
warning: not configuring pull/tristate on ld23_22(121): invalid pin

Going back to what was before the patch, here is what happens in release build:
tegra_pinctrl_set_func iterates over tegra_pinctrl_to_func to find
matching func_id

if (function)
        for (i = 0; i < PMUX_FUNC_COUNT; i++)
                if (tegra_pinctrl_to_func[i])
                        if (!strcmp(function, tegra_pinctrl_to_func[i]))
                                break;

If there is no match loop exits with i = PMUX_FUNC_COUNT which is then
assigned to func_id (if function were NULL, func_id would be
uninitialized). Similar logic applies to the loop below, looking for
pin_id, and to loop in tegra_pinctrl_set_pin. All these loops are fixed
by this commit.

But, going back to what was before: pinmux_set_func is called with
PMUX_FUNC_COUNT, in effect we end up here:

if (func >= PMUX_FUNC_RSVD1) {
        mux = (func - PMUX_FUNC_RSVD1) & 3;
}

As PMUX_FUNC_COUNT = 64 and PMUX_FUNC_RSVD1 = 60 this becomes:

mux = (64 - 60) & 3 = 0

In effect U-Boot sets some pins (look at logs above with (64) after
function name) to whatever is under function 0. In case of LD* pins
this is displaya, exactly what we needed, so we still have working
display. This seems to be the case for other pins too, however I still
need to validate that.

In the case of pull mode, PULL_SHIFT macro internal accesses
tegra_soc_pingroups, here causing out-of-bounds access.

For now, this patch only add warnings and some IFs to prevent undefined
behaviour but doesn't address missing functionality yet. I'd like to fix
that in another patch/series in following weeks.

Device still doesn't boot in debug due to some other issues which
require further investigation:

clk_set_defaults(regulator-3v3)
clk_set_default_parents: could not read assigned-clock-parents for 3f33a518
ofnode_read_prop: assigned-clock-rates: <not found>
regulator_common_set_enable: dev='regulator-3v3', enable=1, delay=0, has_gpio=0
regulator-3v3@vdd_3v3_vs: set 3300000 uV; enabling
initcall: 00112c70 (relocated to 3f73cc70)
Osc = 12000000
CLKM = 12000000
PLLC = 600000000
PLLM = 600000000
PLLP = 216000000
PLLU = 960000000
PLLD = 1000000
PLLX = 1000000000
arch/arm/mach-tegra/tegra20/clock.c:492: get_periph_clock_source: Assertion `!err' failed.
resetting ...

 drivers/pinctrl/tegra/pinctrl-tegra20.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/tegra/pinctrl-tegra20.c b/drivers/pinctrl/tegra/pinctrl-tegra20.c
index d59b3ec7b5d..aa73ada92ba 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra20.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra20.c
@@ -37,6 +37,12 @@ static void tegra_pinctrl_set_pin(struct udevice *config)
 				if (!strcmp(pins[i], tegra_pinctrl_to_pingrp[pin_id]))
 					break;
 
+		if (pin_id == PMUX_PINGRP_COUNT) {
+			debug("warning: not configuring pull/tristate on %s(%d): invalid pin\n",
+			      pins[i], pin_id);
+			continue;
+		}
+
 		if (pull >= 0)
 			pinmux_set_pullupdown(pin_id, pull);
 
@@ -58,13 +64,16 @@ static void tegra_pinctrl_set_func(struct udevice *config)
 	const char **pins;
 
 	function = dev_read_string(config, "nvidia,function");
-	if (function)
+	if (function) {
 		for (i = 0; i < PMUX_FUNC_COUNT; i++)
 			if (tegra_pinctrl_to_func[i])
 				if (!strcmp(function, tegra_pinctrl_to_func[i]))
 					break;
 
-	func_id = i;
+		func_id = i;
+	} else {
+		func_id = PMUX_FUNC_COUNT;
+	}
 
 	count = dev_read_string_list(config, "nvidia,pins", &pins);
 	if (count < 0) {
@@ -78,6 +87,12 @@ static void tegra_pinctrl_set_func(struct udevice *config)
 				if (!strcmp(pins[i], tegra_pinctrl_to_pingrp[pin_id]))
 					break;
 
+		if (func_id == PMUX_FUNC_COUNT || pin_id == PMUX_PINGRP_COUNT) {
+			debug("warning: not muxing %s(%d) to %s(%d): invalid pin or function\n",
+			      pins[i], pin_id, function, func_id);
+			continue;
+		}
+
 		debug("%s(%d) muxed to %s(%d)\n", pins[i], pin_id, function, func_id);
 
 		pinmux_set_func(pin_id, func_id);
-- 
2.48.1

