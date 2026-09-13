Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95B2C88E5C
	for <u-boot@archiver.kernel.org>; Sun, 13 Sep 2026 23:20:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A656A80DC4;
	Sun, 13 Sep 2026 23:20:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v6dX3_IGyvXh; Sun, 13 Sep 2026 23:20:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3CAF980CFE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789341613;
	b=QgPKlYe0BmmpX4jFvhumBZSALGLPzG8sheAPRxP6AIjwJ6vhmLuQEC9tkj1z18VdHtWT
	 JckusWNYVlIsQuA896LfMpilHlPtYfiF/jEWYdm3EvUccJgnpxerd5XkUntMpe2L7OCzF
	 fUe0lH1Wzj4YFQpcbodjlBpJ3UZfmlX/xnhl5R350RwIobnQkjFjl+FtV3uPRPj7eq/Ch
	 Lt3Apw1ZapaQdVd6+nAStO6P/9dYAZhvkd0nkMyc9rCX62uDw468TB0XZDWgaOKHuISOD
	 4QTTeV7Zu3kLjg6bwK31QwybLBtfLVe1PeAnHM1sSE2XirJcu6A1wyiieAW8zwJvgkg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789341613;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Y22K7DYoV2HJc0DyUWW22dUQ65uAqVlskxyR6HLJcv4=;
	b=THKfI2YMVu/gE/sUdIcySIJXA+D3QjC2ybcH/lCfX1Qkc7hzCvMkHaycewX+o9HzHGnH
	 hkYc/WK8QzgDdrVT4+Cy/5q79+jFRwsIj6F8LikidfXzvZ9WubCwADqcje203bwwF2J10
	 e3SRflLsUBQI+0d3ZlaFq4B87uc9hN8IlKkIB7fmZrRFZWnbYZYAn6+EP2Gtp6OmWUbgL
	 eDqbW8jAtBtJ9q8B+bLsihIa0Y2mp6jyvDhBzU/WFMqJmm782081JKTWQKCcsf/+SH80S
	 VqlxsV+g965wmn6pctln6MisEPZJD898Ff5YyHcgnM+pma/AEIYlMBLPHjLNgjeiYPA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cOsvioOM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789341613;
	bh=Y22K7DYoV2HJc0DyUWW22dUQ65uAqVlskxyR6HLJcv4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ompRzlxXSZTsT9BkS15lIcAazR7QwPyt6nOTxqRa6zAGKQKrJkx7JShOkE04GSgTJ
	 eBV7rwNadSEpVWCqC7YfnUEX5pZVkzkt6ux/bv6ISpx05ewRFyGycVqx59tqyS4CzP
	 TKiFXeChTi1oCnGKd3xx3+1rLgmWdk5KHkKMJDIDAdm3OOcMdL4xSbefYppO3FC7+U
	 tP29UoXwQEqa+37u+xHlV8TvDXRRj165OnyYhqZh9uuhWsUCUWDMzBc8sgRy9dC+03
	 nyPGAqaXzJ/Fo76ntJPxPr0/vPiKu8wgLQ6JLkOOjkSVP738YXCHTVV1nD9NWUmNDR
	 jHK7flB4LTDmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3CAF980CFE;
	Sun, 13 Sep 2026 23:20:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 764043AF
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 15:53:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 697F280D50
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 15:53:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jYXuGxw50pMJ for <u-boot@lists.u-boot-project.org>;
 Sun, 13 Sep 2026 15:53:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2D07F80D2B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:34::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789314781;
 b=adEXBhvpBbBTKO8OyDNO++DDkz2HG2BocTv8qB78vLiloTIZhwXPVhy5s4JSVCDSzNx3
 fm9FoIcO2Umqxo+lFP5b0h8JGgODA5dP5Qhu5u6rzyKV5QtrDM61QlVZETT03now363Pm
 Z7aCd2+6GqvgUhAB5CBvCrTloQ0CAcDpdll36RGt3wdVC84xBFcTDTstti/iLdsbG1RJM
 U4pTlgtV8yJ7zXNRWWKgnsnnjqSvLjJWCP8Wgkq0Iq5AiL9dmhm7veISooX6PeqnWsOXG
 RUBnAKhlkOj1mkzDowq8U4hHYfxZ4xBayeENf5HLFqNHXwJGsr5EhJTUlcEOyiA/aAQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789314781;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=Y22K7DYoV2HJc0DyUWW22dUQ65uAqVlskxyR6HLJcv4=;
 b=hjXLPtiuzWC5rNB4HcUqSbr2VA/Y4kRQxoJL7fH8CM+hS584wuHKURPa45gUvx0I1jOC
 FFQjAV3itgZvcH8/uBQ3rCP7E2PRL+I/SHyWRTm6Py8DGvuI36olLqyL8vqCLwH3rKCgf
 /JYaxZY7y5H/ezUdeR/Dmb+9AZw5H9u/zrsBGfedIT2iMpV10rULIs2ORqwR7mwrMEkgz
 3pORCFsYTVJS6jihFFXj2JZySf/QGYF0U8zlPoVMporUcqHvkrb8muZMouITM7/sWp1id
 z0vDQx9U3n52zv6vD/mIlGkfHPYyslphdOadm5EvsD5IEFK665sLa6qOwkiuUgrW+Qg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=cOsvioOM; 
 arc=none smtp.remote-ip="2607:f8b0:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:34::10; helo=mail-qk2-x10.google.com;
 envelope-from=aford173@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=cOsvioOM
Received: from mail-qk2-x10.google.com (mail-qk2-x10.google.com
 [IPv6:2607:f8b0:4864:34::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2D07F80D2B
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 15:53:00 +0000 (UTC)
Received: by mail-qk2-x10.google.com with SMTP id
 af79cd13be357-93910cadeb7so183549185a.0
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 08:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789314779; x=1789919579;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y22K7DYoV2HJc0DyUWW22dUQ65uAqVlskxyR6HLJcv4=;
 b=cOsvioOMDKuiAF/XpqUR/cjBGC12GeLtMH240fn2P7bM6xwz/mH35RVPeRFtgG4GHE
 qgP8jj8lT9X/kqMB9PxRZ1p7MShX7eO2o/tDvknfyo8QhDa6HeWK6fq/qyEwZ7QqYjJE
 97dntYTo5k/8+Q993TBoNtwlQjRGFnRscVvDlOMqqe9AuqVHZBvOovxem5RqH7HvUTZo
 Om3TpdRv5uzwdNS+ovEWOUMKAqPBqkiT9B5/jHvlx/yG3kSeFBXmpPYMZrDR/KC1WNod
 91QhcSmiT0qzx1LJx/wJWeYbXY8TC2AC683qaSsdtY1OcM0mB4R4SPaHY/bfDOfMOmft
 88TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789314779; x=1789919579;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y22K7DYoV2HJc0DyUWW22dUQ65uAqVlskxyR6HLJcv4=;
 b=QEiYiMwCuv0QvUDv6fRbrEu8lcPFY4MM37j+SeqSuoRCvxTJQ2gRILmSi8iZ9AmQvD
 D5Rxsv9iwbD4HGdQiO5kTZH/W0hjvY6WAMZbw9GAJR/bn7SahtzxJk1NElzEUIdmQZuL
 891FIKTtsI5o0A3jTKCQGuTV4SexOUsqCBowvonEEJRCd6XKzP+Aj4muBHxQZ652H91f
 733H+5a90PTEmMaVpZW+pwcWpZzxUNoIvkCCbY52axERBAQ2BvDz8ejgKSMOspF6lXxo
 tJ8g69CIOsGOjkQ3yegOjodkitUI4Jh9lNxMrNw00xYtGWA9M6t+RhIPh2CnbvKRN56m
 ky1Q==
X-Gm-Message-State: AFuF++kT09+3TLZGInMEpwY/5udwXLekcDF0kIHAQOvu1U+hOhaJoa70
 XoVVt/upj4YSwfbajUnYN+evSH4+qPznD6/Ep3Oj0M75G5lcbRdegYEXRrvHSg==
X-Gm-Gg: AYBFou10WUgZ1ByJodXofVeje9M1Su5SJreqWQTXAF9TDo8K4DxK4OJCORhxZThllpN
 pyucf/1Oz3mh1e35b51ughqnOrsYx+cSSEP9pI3rEgH9CqNBr4jwfucHBBcaxv8/ElyPUBUPedj
 Be7d+yaJcn6UppKN5vWZcf4oG4MENAVJiG2ZcOsfyh3a2Ze538LKX93lnv9werVujY7T65wOdaI
 LeW3juL2sHtBrbtU7Ao/vduaGEPb0hFnjaiMiMBvtMOdoYEh56BL6qYYEODulDQuOuv9oK4DVPw
 nVPleKp4o3V9m964sU70aSncJF/cxZQLO/lfnLABHMae91/n/wYWvZET/xrfzIKHFBT17zNFRni
 quXSLzqKmUuN9efkIbs5jRxKmTeYIOPTp+grgcYrGsdPS84N5C/2VFDOAPeze5gFxJaCn1OpT1p
 eqGVQ/bqBZSmFRrF76RIpNat6j6bisQ+2po4N2jHUOwb6LUxDvsYHWUbh6INNkNBNjj0761KQ7T
 hxDofyDtk7FYnJIl+HMb+FxWIbI4DNiLYDNob2P3T2v6IRp9H1o
X-Received: by 2002:a05:620a:439e:b0:937:5ab5:53f7 with SMTP id
 af79cd13be357-939ea1c6460mr1778782185a.43.1789314778920; 
 Sun, 13 Sep 2026 08:52:58 -0700 (PDT)
Received: from aford-System-Version.lan (c-73-94-212-116.hsd1.mn.comcast.net.
 [73.94.212.116]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93a1bf286dbsm131321785a.40.2026.09.13.08.52.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 08:52:58 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Huy Bui <huy.bui.pz@bp.renesas.com>,
 Nguyen Tran <nguyen.tran.pz@bp.renesas.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adam Ford <aford173@gmail.com>
Subject: [PATCH] board: beacon: Remove Beacon EmbeddedWorks RZ/G2 Dev Kit
 support
Date: Sun, 13 Sep 2026 10:52:53 -0500
Message-ID: <20260913155253.84181-1-aford173@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 13 Sep 2026 23:20:05 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Remove the Beacon EmbeddedWorks RZ/G2M/N/H SoM and Dev Kit board
support along with its defconfig, config header, U-Boot device tree
overlays, the leftover pre-OF_UPSTREAM DTSI files, the Kconfig target
and the entry in the Renesas board documentation table.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 arch/arm/dts/beacon-renesom-baseboard.dtsi    | 816 ------------------
 arch/arm/dts/beacon-renesom-som.dtsi          | 334 -------
 .../dts/r8a774a1-beacon-rzg2m-kit-u-boot.dtsi |   6 -
 .../dts/r8a774b1-beacon-rzg2n-kit-u-boot.dtsi |   6 -
 .../dts/r8a774e1-beacon-rzg2h-kit-u-boot.dtsi |   6 -
 arch/arm/dts/rz-g2-beacon-u-boot.dtsi         |  82 --
 arch/arm/mach-renesas/Kconfig.rcar3           |  16 -
 board/beacon/beacon-rzg2m/Kconfig             |  15 -
 board/beacon/beacon-rzg2m/MAINTAINERS         |  17 -
 board/beacon/beacon-rzg2m/Makefile            |   9 -
 board/beacon/beacon-rzg2m/beacon-rzg2m.c      |  33 -
 configs/rzg2_beacon_defconfig                 |  46 -
 doc/board/renesas/renesas.rst                 |  12 +-
 include/configs/beacon-rzg2m.h                |  67 --
 14 files changed, 3 insertions(+), 1462 deletions(-)
 delete mode 100644 arch/arm/dts/beacon-renesom-baseboard.dtsi
 delete mode 100644 arch/arm/dts/beacon-renesom-som.dtsi
 delete mode 100644 arch/arm/dts/r8a774a1-beacon-rzg2m-kit-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a774b1-beacon-rzg2n-kit-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a774e1-beacon-rzg2h-kit-u-boot.dtsi
 delete mode 100644 arch/arm/dts/rz-g2-beacon-u-boot.dtsi
 delete mode 100644 board/beacon/beacon-rzg2m/Kconfig
 delete mode 100644 board/beacon/beacon-rzg2m/MAINTAINERS
 delete mode 100644 board/beacon/beacon-rzg2m/Makefile
 delete mode 100644 board/beacon/beacon-rzg2m/beacon-rzg2m.c
 delete mode 100644 configs/rzg2_beacon_defconfig
 delete mode 100644 include/configs/beacon-rzg2m.h

diff --git a/arch/arm/dts/beacon-renesom-baseboard.dtsi b/arch/arm/dts/beacon-renesom-baseboard.dtsi
deleted file mode 100644
index 2e9927b9773..00000000000
--- a/arch/arm/dts/beacon-renesom-baseboard.dtsi
+++ /dev/null
@@ -1,816 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright 2020, Compass Electronics Group, LLC
- */
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/clock/versaclock.h>
-
-/ {
-	backlight_lvds: backlight-lvds {
-		compatible = "pwm-backlight";
-		power-supply = <&reg_lcd>;
-		enable-gpios = <&gpio_exp1 3 GPIO_ACTIVE_HIGH>;
-		pwms = <&pwm2 0 25000>;
-		brightness-levels = <0 4 8 16 32 64 128 255>;
-		default-brightness-level = <6>;
-	};
-
-	backlight_dpi: backlight-dpi {
-		compatible = "pwm-backlight";
-		power-supply = <&reg_lcd>;
-		enable-gpios = <&gpio_exp1 7 GPIO_ACTIVE_LOW>;
-		pwms = <&pwm0 0 25000>;
-		brightness-levels = <0 25 33 50 63 75 88 100>;
-		default-brightness-level = <6>;
-	};
-
-	hdmi0-out {
-		compatible = "hdmi-connector";
-		type = "a";
-
-		port {
-			hdmi0_con: endpoint {
-				remote-endpoint = <&rcar_dw_hdmi0_out>;
-			};
-		};
-	};
-
-	keys {
-		compatible = "gpio-keys";
-
-		key-1 { /* S19 */
-			gpios = <&gpio4 6 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_UP>;
-			label = "Up";
-			wakeup-source;
-			debounce-interval = <20>;
-		};
-		key-2 { /*S20 */
-			gpios = <&gpio3 13 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_LEFT>;
-			label = "Left";
-			wakeup-source;
-			debounce-interval = <20>;
-		};
-		key-3 { /* S21 */
-			gpios = <&gpio5 17 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_DOWN>;
-			label = "Down";
-			wakeup-source;
-			debounce-interval = <20>;
-		};
-		key-4 { /* S22 */
-			gpios = <&gpio5 20 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_RIGHT>;
-			label = "Right";
-			wakeup-source;
-			debounce-interval = <20>;
-		};
-		key-5 { /* S23 */
-			gpios = <&gpio5 22 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_ENTER>;
-			label = "Center";
-			wakeup-source;
-			debounce-interval = <20>;
-		};
-	};
-
-	leds {
-		compatible = "gpio-leds";
-		pinctrl-0 = <&led_pins>;
-		pinctrl-names = "default";
-
-		led0 {
-			gpios = <&gpio0 4 GPIO_ACTIVE_HIGH>;
-			label = "LED0";
-			linux,default-trigger = "heartbeat";
-		};
-		led1 {
-			gpios = <&gpio7 0 GPIO_ACTIVE_HIGH>;
-			label = "LED1";
-		};
-		led2 {
-			gpios = <&gpio7 1 GPIO_ACTIVE_HIGH>;
-			label = "LED2";
-		};
-		led3 {
-			gpios = <&gpio7 3 GPIO_ACTIVE_HIGH>;
-			label = "LED3";
-		};
-	};
-
-	lvds {
-		compatible = "panel-lvds";
-		power-supply = <&reg_lcd_reset>;
-		width-mm = <223>;
-		height-mm = <125>;
-		backlight = <&backlight_lvds>;
-		data-mapping = "vesa-24";
-
-		panel-timing {
-			/* 800x480@60Hz */
-			clock-frequency = <30000000>;
-			hactive = <800>;
-			vactive = <480>;
-			hsync-len = <48>;
-			hfront-porch = <40>;
-			hback-porch = <40>;
-			vfront-porch = <13>;
-			vback-porch = <29>;
-			vsync-len = <1>;
-			hsync-active = <1>;
-			vsync-active = <3>;
-			de-active = <1>;
-			pixelclk-active = <0>;
-		};
-
-		port {
-			panel_in: endpoint {
-				remote-endpoint = <&lvds0_out>;
-			};
-		};
-	};
-
-	rgb {
-		/* Different LCD with compatible timings */
-		compatible = "rocktech,rk070er9427";
-		backlight = <&backlight_dpi>;
-		enable-gpios = <&gpio1 21 GPIO_ACTIVE_HIGH>;
-		power-supply = <&reg_lcd>;
-		port {
-			rgb_panel: endpoint {
-				remote-endpoint = <&du_out_rgb>;
-			};
-		};
-	};
-
-	reg_audio: regulator-audio {
-		compatible = "regulator-fixed";
-		regulator-name = "audio-1.8V";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		gpio = <&gpio_exp4 1 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reg_lcd: regulator-lcd {
-		compatible = "regulator-fixed";
-		regulator-name = "lcd_panel_pwr";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio_exp1 1 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reg_lcd_reset: regulator-lcd-reset {
-		compatible = "regulator-fixed";
-		regulator-name = "nLCD_RESET";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio5 3 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		vin-supply = <&reg_lcd>;
-	};
-
-	reg_cam0: regulator-cam0 {
-		compatible = "regulator-fixed";
-		regulator-name = "reg_cam0";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		gpio = <&gpio_exp2 2 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reg_cam1: regulator-cam1 {
-		compatible = "regulator-fixed";
-		regulator-name = "reg_cam1";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		gpio = <&gpio_exp2 5 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		startup-delay-us = <100000>;
-	};
-
-	sound_card {
-		compatible = "audio-graph-card";
-		label = "rcar-sound";
-		dais = <&rsnd_port0>, <&rsnd_port1>;
-		widgets = "Microphone", "Mic Jack",
-			  "Line", "Line In Jack",
-			  "Headphone", "Headphone Jack";
-		mic-det-gpio = <&gpio0 2 GPIO_ACTIVE_LOW>;
-		routing = "Headphone Jack", "HPOUTL",
-			 "Headphone Jack", "HPOUTR",
-			 "IN3R", "MICBIAS",
-			 "Mic Jack", "IN3R";
-	};
-
-	vccq_sdhi0: regulator-vccq-sdhi0 {
-		compatible = "regulator-gpio";
-		regulator-name = "SDHI0 VccQ";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-		gpios = <&gpio6 30 GPIO_ACTIVE_HIGH>;
-		gpios-states = <1>;
-		states = <3300000 1>, <1800000 0>;
-	};
-
-	/* External DU dot clocks */
-	x302_clk: x302-clock {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <33000000>;
-	};
-
-	x304_clk: x304-clock {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <25000000>;
-	};
-
-	connector {
-		compatible = "usb-c-connector";
-		label = "USB-C";
-		data-role = "dual";
-
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			port@0 {
-				reg = <0>;
-				hs_ep: endpoint {
-					remote-endpoint = <&usb3_hs_ep>;
-				};
-			};
-			port@1 {
-				reg = <1>;
-				ss_ep: endpoint {
-					remote-endpoint = <&hd3ss3220_in_ep>;
-				};
-			};
-		};
-	};
-};
-
-&audio_clk_b {
-	clock-frequency = <22579200>;
-};
-
-&can0 {
-	pinctrl-0 = <&can0_pins>;
-	pinctrl-names = "default";
-	renesas,can-clock-select = <0x0>;
-	status = "okay";
-};
-
-&can1 {
-	pinctrl-0 = <&can1_pins>;
-	pinctrl-names = "default";
-	renesas,can-clock-select = <0x0>;
-	status = "okay";
-};
-
-&du {
-	ports {
-		port@0 {
-			du_out_rgb: endpoint {
-				remote-endpoint = <&rgb_panel>;
-			};
-		};
-	};
-};
-
-&ehci0 {
-	dr_mode = "otg";
-	status = "okay";
-	clocks = <&cpg CPG_MOD 703>, <&cpg CPG_MOD 704>, <&usb2_clksel>, <&versaclock5 3>;
-};
-
-&ehci1 {
-	status = "okay";
-	clocks = <&cpg CPG_MOD 703>, <&cpg CPG_MOD 704>, <&usb2_clksel>, <&versaclock5 3>;
-};
-
-&hdmi0 {
-	status = "okay";
-	ports {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		port@0 {
-			reg = <0>;
-			dw_hdmi0_in: endpoint {
-				remote-endpoint = <&du_out_hdmi0>;
-			};
-		};
-		port@1 {
-			reg = <1>;
-			rcar_dw_hdmi0_out: endpoint {
-				remote-endpoint = <&hdmi0_con>;
-			};
-		};
-		port@2 {
-			reg = <2>;
-			dw_hdmi0_snd_in: endpoint {
-				remote-endpoint = <&rsnd_endpoint1>;
-			};
-		};
-	};
-};
-
-&hscif1 {
-	pinctrl-0 = <&hscif1_pins>;
-	pinctrl-names = "default";
-	uart-has-rtscts;
-	status = "okay";
-};
-
-&hsusb {
-	dr_mode = "otg";
-	status = "okay";
-};
-
-&i2c2 {
-	status = "okay";
-	clock-frequency = <400000>;
-	pinctrl-0 = <&i2c2_pins>;
-	pinctrl-names = "default";
-
-	gpio_exp2: gpio@21 {
-		compatible = "onnn,pca9654";
-		reg = <0x21>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
-	gpio_exp3: gpio@22 {
-		compatible = "onnn,pca9654";
-		reg = <0x22>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
-	gpio_exp4: gpio@23 {
-		compatible = "onnn,pca9654";
-		reg = <0x23>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
-	versaclock6_bb: clock-controller@6a {
-		compatible = "idt,5p49v6965";
-		reg = <0x6a>;
-		#clock-cells = <1>;
-		clocks = <&x304_clk>;
-		clock-names = "xin";
-
-		assigned-clocks = <&versaclock6_bb 1>, <&versaclock6_bb 2>,
-				  <&versaclock6_bb 3>, <&versaclock6_bb 4>;
-		assigned-clock-rates = <24000000>, <24000000>, <24576000>,
-				       <24576000>;
-
-		OUT1 {
-			idt,mode = <VC5_CMOS>;
-			idt,voltage-microvolt = <1800000>;
-			idt,slew-percent = <100>;
-		};
-
-		OUT2 {
-			idt,mode = <VC5_CMOS>;
-			idt,voltage-microvolt = <1800000>;
-			idt,slew-percent = <100>;
-		};
-
-		OUT3 {
-			idt,mode = <VC5_CMOS>;
-			idt,voltage-microvolt = <3300000>;
-			idt,slew-percent = <100>;
-		};
-
-		OUT4 {
-			idt,mode = <VC5_CMOS>;
-			idt,voltage-microvolt = <3300000>;
-			idt,slew-percent = <100>;
-		};
-	};
-};
-
-&i2c0 {
-	status = "okay";
-	clock-frequency = <400000>;
-
-	pinctrl-0 = <&i2c0_pins>;
-	pinctrl-names = "default";
-};
-
-&i2c5 {
-	status = "okay";
-	clock-frequency = <400000>;
-	pinctrl-0 = <&i2c5_pins>;
-	pinctrl-names = "default";
-
-	codec: wm8962@1a {
-		compatible = "wlf,wm8962";
-		reg = <0x1a>;
-		clocks = <&versaclock6_bb 3>;
-		DCVDD-supply = <&reg_audio>;
-		DBVDD-supply = <&reg_audio>;
-		AVDD-supply = <&reg_audio>;
-		CPVDD-supply = <&reg_audio>;
-		MICVDD-supply = <&reg_audio>;
-		PLLVDD-supply = <&reg_audio>;
-		SPKVDD1-supply = <&reg_audio>;
-		SPKVDD2-supply = <&reg_audio>;
-		gpio-cfg = <
-			0x0000 /* 0:Default */
-			0x0000 /* 1:Default */
-			0x0000 /* 2:Default */
-			0x0000 /* 3:Default */
-			0x0000 /* 4:Default */
-			0x0000 /* 5:Default */
-		>;
-		port {
-			wm8962_endpoint: endpoint {
-				remote-endpoint = <&rsnd_endpoint0>;
-			};
-		};
-	};
-
-	touchscreen@26 {
-		compatible = "ilitek,ili2117";
-		reg = <0x26>;
-		interrupt-parent = <&gpio5>;
-		interrupts = <9 IRQ_TYPE_EDGE_RISING>;
-		wakeup-source;
-	};
-
-	hd3ss3220@47 {
-		compatible = "ti,hd3ss3220";
-		reg = <0x47>;
-		interrupt-parent = <&gpio6>;
-		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
-
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			port@0 {
-				reg = <0>;
-				hd3ss3220_in_ep: endpoint {
-					remote-endpoint = <&ss_ep>;
-				};
-			};
-			port@1 {
-				reg = <1>;
-				hd3ss3220_out_ep: endpoint {
-					remote-endpoint = <&usb3_role_switch>;
-				};
-			};
-		};
-	};
-
-	gpio_exp1: gpio@70 {
-		compatible = "nxp,pca9538";
-		reg = <0x70>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		gpio-line-names = "lcd_reset", "lcd_pwr", "lcd_select",
-				  "backlight-enable", "Touch_shdwn",
-				  "LCD_H_pol", "lcd_V_pol";
-	};
-};
-
-&lvds0 {
-	status = "okay";
-
-	ports {
-		port@1 {
-			lvds0_out: endpoint {
-				remote-endpoint = <&panel_in>;
-			};
-		};
-	};
-};
-
-&msiof1 {
-	pinctrl-0 = <&msiof1_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-	cs-gpios = <&gpio3 10 GPIO_ACTIVE_LOW>;
-};
-
-&ohci0 {
-	dr_mode = "otg";
-	status = "okay";
-};
-
-&ohci1 {
-	status = "okay";
-};
-
-&pciec0 {
-	status = "okay";
-};
-
-&pciec1 {
-	status = "okay";
-};
-
-&pcie_bus_clk {
-	clock-frequency = <100000000>;
-};
-
-&pfc {
-	can0_pins: can0 {
-		groups = "can0_data_a";
-		function = "can0";
-	};
-
-	can1_pins: can1 {
-		groups = "can1_data";
-		function = "can1";
-	};
-
-	du_pins: du {
-		groups = "du_rgb888", "du_sync", "du_clk_out_1", "du_disp";
-		function = "du";
-	};
-
-	i2c2_pins: i2c2 {
-		groups = "i2c2_a";
-		function = "i2c2";
-	};
-
-	i2c5_pins: i2c5 {
-		groups = "i2c5";
-		function = "i2c5";
-	};
-
-	led_pins: leds {
-		/* GP_0_4 , AVS1, AVS2, GP_7_3 */
-		pins = "GP_0_4", "GP_7_0", "GP_7_1", "GP_7_3";
-		bias-pull-down;
-	};
-
-	msiof1_pins: msiof1 {
-		groups = "msiof1_clk_g", "msiof1_rxd_g", "msiof1_txd_g";
-		function = "msiof1";
-	};
-
-	pwm0_pins: pwm0 {
-		groups = "pwm0";
-		function = "pwm0";
-	};
-
-	pwm2_pins: pwm2 {
-		groups = "pwm2_a";
-		function = "pwm2";
-	};
-
-	sdhi0_pins: sd0 {
-		groups = "sdhi0_data4", "sdhi0_ctrl";
-		function = "sdhi0";
-		power-source = <3300>;
-	};
-
-	sdhi0_pins_uhs: sd0_uhs {
-		groups = "sdhi0_data4", "sdhi0_ctrl";
-		function = "sdhi0";
-		power-source = <1800>;
-	};
-
-	sound_pins: sound {
-		groups = "ssi01239_ctrl", "ssi0_data", "ssi1_data_a";
-		function = "ssi";
-	};
-
-	sound_clk_pins: sound_clk {
-		groups = "audio_clk_a_a", "audio_clk_b_a";
-		function = "audio_clk";
-	};
-
-	usb0_pins: usb0 {
-		mux {
-			groups = "usb0";
-			function = "usb0";
-		};
-	};
-
-	usb1_pins: usb1 {
-		mux {
-			groups = "usb1";
-			function = "usb1";
-		};
-	};
-
-	usb30_pins: usb30 {
-		mux {
-			groups = "usb30";
-			function = "usb30";
-		};
-	};
-};
-
-&pwm0 {
-	pinctrl-0 = <&pwm0_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
-&pwm2 {
-	pinctrl-0 = <&pwm2_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
-&rcar_sound {
-	pinctrl-0 = <&sound_pins>, <&sound_clk_pins>;
-	pinctrl-names = "default";
-
-	/* Single DAI */
-	#sound-dai-cells = <0>;
-
-	/* audio_clkout0/1/2/3 */
-	#clock-cells = <1>;
-	clock-frequency = <11289600>;
-
-	/* Reference versaclock instead of audio_clk_a */
-	clocks = <&cpg CPG_MOD 1005>,
-		 <&cpg CPG_MOD 1006>, <&cpg CPG_MOD 1007>,
-		 <&cpg CPG_MOD 1008>, <&cpg CPG_MOD 1009>,
-		 <&cpg CPG_MOD 1010>, <&cpg CPG_MOD 1011>,
-		 <&cpg CPG_MOD 1012>, <&cpg CPG_MOD 1013>,
-		 <&cpg CPG_MOD 1014>, <&cpg CPG_MOD 1015>,
-		 <&cpg CPG_MOD 1022>, <&cpg CPG_MOD 1023>,
-		 <&cpg CPG_MOD 1024>, <&cpg CPG_MOD 1025>,
-		 <&cpg CPG_MOD 1026>, <&cpg CPG_MOD 1027>,
-		 <&cpg CPG_MOD 1028>, <&cpg CPG_MOD 1029>,
-		 <&cpg CPG_MOD 1030>, <&cpg CPG_MOD 1031>,
-		 <&cpg CPG_MOD 1020>, <&cpg CPG_MOD 1021>,
-		 <&cpg CPG_MOD 1020>, <&cpg CPG_MOD 1021>,
-		 <&cpg CPG_MOD 1019>, <&cpg CPG_MOD 1018>,
-		 <&versaclock6_bb 4>, <&audio_clk_b>,
-		 <&audio_clk_c>,
-		 <&cpg CPG_CORE CPG_AUDIO_CLK_I>;
-
-	status = "okay";
-
-	ports {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		rsnd_port0: port@0 {
-			reg = <0>;
-			rsnd_endpoint0: endpoint {
-				remote-endpoint = <&wm8962_endpoint>;
-
-				dai-format = "i2s";
-				bitclock-master = <&rsnd_endpoint0>;
-				frame-master = <&rsnd_endpoint0>;
-
-				playback = <&ssi1>, <&dvc1>, <&src1>;
-				capture = <&ssi0>;
-			};
-		};
-		rsnd_port1: port@1 {
-		    reg = <0x01>;
-			rsnd_endpoint1: endpoint {
-				remote-endpoint = <&dw_hdmi0_snd_in>;
-
-				dai-format = "i2s";
-				bitclock-master = <&rsnd_endpoint1>;
-				frame-master = <&rsnd_endpoint1>;
-
-				playback = <&ssi2>;
-			};
-		};
-	};
-};
-
-&rwdt {
-	status = "okay";
-	timeout-sec = <60>;
-};
-
-&scif0 {
-	pinctrl-0 = <&scif0_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
-&scif5 {
-	pinctrl-0 = <&scif5_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
-&scif_clk {
-	clock-frequency = <14745600>;
-};
-
-&sdhi0 {
-	pinctrl-0 = <&sdhi0_pins>;
-	pinctrl-1 = <&sdhi0_pins_uhs>;
-	pinctrl-names = "default", "state_uhs";
-	vmmc-supply = <&reg_3p3v>;
-	vqmmc-supply = <&vccq_sdhi0>;
-	cd-gpios = <&gpio3 12 GPIO_ACTIVE_LOW>;
-	bus-width = <4>;
-	sd-uhs-sdr50;
-	sd-uhs-sdr104;
-	status = "okay";
-};
-
-&ssi1 {
-	shared-pin;
-};
-
-&tmu0 {
-	status = "okay";
-};
-
-&tmu1 {
-	status = "okay";
-};
-
-&tmu2 {
-	status = "okay";
-};
-
-&tmu3 {
-	status = "okay";
-};
-
-&tmu4 {
-	status = "okay";
-};
-
-&usb2_phy0 {
-	pinctrl-0 = <&usb0_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
-&usb2_phy1 {
-	pinctrl-0 = <&usb1_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
-&usb3_peri0 {
-	companion = <&xhci0>;
-	status = "okay";
-	usb-role-switch;
-
-	ports {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		port@0 {
-			reg = <0>;
-			usb3_hs_ep: endpoint {
-				remote-endpoint = <&hs_ep>;
-			};
-		};
-		port@1 {
-			reg = <1>;
-			usb3_role_switch: endpoint {
-				remote-endpoint = <&hd3ss3220_out_ep>;
-			};
-		};
-	};
-};
-
-&usb3_phy0 {
-	status = "okay";
-};
-
-&vin0 {
-	status = "okay";
-};
-&vin1 {
-	status = "okay";
-};
-&vin2 {
-	status = "okay";
-};
-&vin3 {
-	status = "okay";
-};
-&vin4 {
-	status = "okay";
-};
-&vin5 {
-	status = "okay";
-};
-&vin6 {
-	status = "okay";
-};
-&vin7 {
-	status = "okay";
-};
-
-&xhci0
-{
-	pinctrl-0 = <&usb30_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-};
diff --git a/arch/arm/dts/beacon-renesom-som.dtsi b/arch/arm/dts/beacon-renesom-som.dtsi
deleted file mode 100644
index 68b04e56ae5..00000000000
--- a/arch/arm/dts/beacon-renesom-som.dtsi
+++ /dev/null
@@ -1,334 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright 2020, Compass Electronics Group, LLC
- */
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/clock/versaclock.h>
-
-/ {
-	memory@48000000 {
-		device_type = "memory";
-		/* first 128MB is reserved for secure area. */
-		reg = <0x0 0x48000000 0x0 0x78000000>;
-	};
-
-	osc_32k: osc_32k {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <32768>;
-		clock-output-names = "osc_32k";
-	};
-
-	reg_1p8v: regulator-1p8v {
-		compatible = "regulator-fixed";
-		regulator-name = "fixed-1.8V";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		regulator-boot-on;
-		regulator-always-on;
-	};
-
-	reg_3p3v: regulator-3p3v {
-		compatible = "regulator-fixed";
-		regulator-name = "fixed-3.3V";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-boot-on;
-		regulator-always-on;
-	};
-
-	wlan_pwrseq: wlan_pwrseq {
-		compatible = "mmc-pwrseq-simple";
-		reset-gpios = <&pca9654 1 GPIO_ACTIVE_LOW>;
-		clocks = <&osc_32k>;
-		clock-names = "ext_clock";
-		post-power-on-delay-ms = <80>;
-	};
-};
-
-&avb {
-	pinctrl-0 = <&avb_pins>;
-	pinctrl-names = "default";
-	phy-mode = "rgmii-rxid";
-	phy-handle = <&phy0>;
-	rx-internal-delay-ps = <1800>;
-	tx-internal-delay-ps = <2000>;
-	clocks = <&cpg CPG_MOD 812>, <&versaclock5 4>;
-	clock-names = "fck", "refclk";
-	status = "okay";
-
-	phy0: ethernet-phy@0 {
-		compatible = "ethernet-phy-id0022.1640",
-			     "ethernet-phy-ieee802.3-c22";
-		reg = <0>;
-		interrupt-parent = <&gpio2>;
-		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
-		reset-gpios = <&gpio2 10 GPIO_ACTIVE_LOW>;
-	};
-};
-
-&extal_clk {
-	clock-frequency = <16666666>;
-};
-
-&extalr_clk {
-	clock-frequency = <32768>;
-};
-
-&gpio6 {
-	usb-hub-reset-hog {
-		gpio-hog;
-		gpios = <10 GPIO_ACTIVE_HIGH>;
-		output-high;
-		line-name = "usb-hub-reset";
-	};
-};
-
-&hscif0 {
-	pinctrl-0 = <&hscif0_pins>;
-	pinctrl-names = "default";
-	uart-has-rtscts;
-	status = "okay";
-
-	bluetooth {
-		compatible = "brcm,bcm43438-bt";
-		shutdown-gpios = <&pca9654 2 GPIO_ACTIVE_HIGH>;
-		host-wakeup-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
-		device-wakeup-gpios = <&pca9654 5 GPIO_ACTIVE_HIGH>;
-		clocks = <&osc_32k>;
-		clock-names = "extclk";
-		max-speed = <4000000>;
-	};
-};
-
-&hscif2 {
-	status = "okay";
-	pinctrl-0 = <&hscif2_pins>;
-	pinctrl-names = "default";
-};
-
-&i2c4 {
-	status = "okay";
-	clock-frequency = <100000>;
-
-	pca9654: gpio@20 {
-		compatible = "onnn,pca9654";
-		reg = <0x20>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		gpio-line-names =
-			"i2c4_20_0",
-			"wl_reg_on",
-			"bt_reg_on",
-			"i2c4_20_3",
-			"i2c4_20_4",
-			"bt_dev_wake",
-			"i2c4_20_6",
-			"i2c4_20_7";
-	};
-
-	pca9654_lte: gpio@21 {
-		compatible = "onnn,pca9654";
-		reg = <0x21>;
-		interrupt-parent = <&gpio5>;
-		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		gpio-line-names =
-			"i2c4_21_0",
-			"zoe_pwr_on",
-			"zoe_extint",
-			"zoe_reset_n",
-			"sara_reset",
-			"i2c4_21_5",
-			"sara_pwr_off",
-			"sara_networking_status";
-	};
-
-	eeprom@50 {
-		compatible = "microchip,24c64", "atmel,24c64";
-		pagesize = <32>;
-		read-only;	/* Manufacturing EEPROM programmed at factory */
-		reg = <0x50>;
-	};
-
-	rtc@51 {
-		compatible = "nxp,pcf85263";
-		reg = <0x51>;
-	};
-
-	versaclock5: versaclock_som@6a {
-		compatible = "idt,5p49v6965";
-		reg = <0x6a>;
-		#clock-cells = <1>;
-		clocks = <&x304_clk>;
-		clock-names = "xin";
-		/* du_dotclkin0, du_dotclkin2, usb_extal, avb_txcrefclk */
-		assigned-clocks = <&versaclock5 1>,
-				   <&versaclock5 2>,
-				   <&versaclock5 3>,
-				   <&versaclock5 4>;
-
-		assigned-clock-rates = <33333333>, <33333333>, <50000000>, <125000000>;
-
-		OUT1 {
-			idt,mode = <VC5_CMOS>;
-			idt,voltage-microvolt = <1800000>;
-			idt,slew-percent = <100>;
-		};
-
-		OUT2 {
-			idt,mode = <VC5_CMOS>;
-			idt,voltage-microvolt = <1800000>;
-			idt,slew-percent = <100>;
-		};
-
-		OUT3 {
-			idt,mode = <VC5_CMOS>;
-			idt,voltage-microvolt = <1800000>;
-			idt,slew-percent = <100>;
-		};
-
-		OUT4 {
-			idt,mode = <VC5_CMOS>;
-			idt,voltage-microvolt = <3300000>;
-			idt,slew-percent = <100>;
-		};
-	};
-};
-
-&pfc {
-	pinctrl-0 = <&scif_clk_pins>;
-	pinctrl-names = "default";
-
-	avb_pins: avb {
-		mux {
-			groups = "avb_link", "avb_mdio", "avb_mii";
-			function = "avb";
-		};
-
-		pins_mdio {
-			groups = "avb_mdio";
-			drive-strength = <24>;
-		};
-
-		pins_mii_tx {
-			pins = "PIN_AVB_TX_CTL", "PIN_AVB_TXC", "PIN_AVB_TD0",
-			       "PIN_AVB_TD1", "PIN_AVB_TD2", "PIN_AVB_TD3";
-			drive-strength = <12>;
-		};
-	};
-
-	scif2_pins: scif2 {
-		groups = "scif2_data_a";
-		function = "scif2";
-	};
-
-	hscif0_pins: hscif0 {
-		groups = "hscif0_data", "hscif0_ctrl";
-		function = "hscif0";
-	};
-
-	hscif1_pins: hscif1 {
-		groups = "hscif1_data_a", "hscif1_ctrl_a";
-		function = "hscif1";
-	};
-
-	hscif2_pins: hscif2 {
-		groups = "hscif2_data_a";
-		function = "hscif2";
-	};
-
-	scif0_pins: scif0 {
-		groups = "scif0_data";
-		function = "scif0";
-	};
-
-	scif5_pins: scif5 {
-		groups = "scif5_data_a";
-		function = "scif5";
-	};
-
-	scif_clk_pins: scif_clk {
-		groups = "scif_clk_a";
-		function = "scif_clk";
-	};
-
-	i2c0_pins: i2c0 {
-		groups = "i2c0";
-		function = "i2c0";
-	};
-
-	sdhi2_pins: sd2 {
-		groups = "sdhi2_data4", "sdhi2_ctrl";
-		function = "sdhi2";
-		power-source = <1800>;
-	};
-
-	sdhi3_pins: sd3 {
-		groups = "sdhi3_data8", "sdhi3_ctrl", "sdhi3_ds";
-		function = "sdhi3";
-		power-source = <1800>;
-	};
-};
-
-&scif_clk {
-	clock-frequency = <14745600>;
-};
-
-&scif2 {
-	pinctrl-0 = <&scif2_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
-&sdhi2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&sdhi2_pins>;
-	bus-width = <4>;
-	vmmc-supply = <&reg_3p3v>;
-	vqmmc-supply = <&reg_1p8v>;
-	non-removable;
-	cap-power-off-card;
-	keep-power-in-suspend;
-	mmc-pwrseq = <&wlan_pwrseq>;
-	status = "okay";
-	#address-cells = <1>;
-	#size-cells = <0>;
-
-	brcmf: bcrmf@1 {
-		reg = <1>;
-		compatible = "brcm,bcm4329-fmac";
-		interrupt-parent = <&gpio1>;
-		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
-		interrupt-names = "host-wake";
-	};
-};
-
-&sdhi3 {
-	pinctrl-0 = <&sdhi3_pins>;
-	pinctrl-1 = <&sdhi3_pins>;
-	pinctrl-names = "default", "state_uhs";
-	vmmc-supply = <&reg_3p3v>;
-	vqmmc-supply = <&reg_1p8v>;
-	bus-width = <8>;
-	mmc-hs200-1_8v;
-	no-sd;
-	no-sdio;
-	non-removable;
-	fixed-emmc-driver-type = <1>;
-	status = "okay";
-};
-
-&usb2_clksel {
-	clocks = <&cpg CPG_MOD 703>, <&cpg CPG_MOD 704>,
-		  <&versaclock5 3>, <&usb3s0_clk>;
-	status = "okay";
-};
-
-&usb3s0_clk {
-	clock-frequency = <100000000>;
-};
diff --git a/arch/arm/dts/r8a774a1-beacon-rzg2m-kit-u-boot.dtsi b/arch/arm/dts/r8a774a1-beacon-rzg2m-kit-u-boot.dtsi
deleted file mode 100644
index 85336d5f3ba..00000000000
--- a/arch/arm/dts/r8a774a1-beacon-rzg2m-kit-u-boot.dtsi
+++ /dev/null
@@ -1,6 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright 2021 LogicPD dba Beacon EmbeddedWorks
- */
-
-#include "rz-g2-beacon-u-boot.dtsi"
diff --git a/arch/arm/dts/r8a774b1-beacon-rzg2n-kit-u-boot.dtsi b/arch/arm/dts/r8a774b1-beacon-rzg2n-kit-u-boot.dtsi
deleted file mode 100644
index 85336d5f3ba..00000000000
--- a/arch/arm/dts/r8a774b1-beacon-rzg2n-kit-u-boot.dtsi
+++ /dev/null
@@ -1,6 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright 2021 LogicPD dba Beacon EmbeddedWorks
- */
-
-#include "rz-g2-beacon-u-boot.dtsi"
diff --git a/arch/arm/dts/r8a774e1-beacon-rzg2h-kit-u-boot.dtsi b/arch/arm/dts/r8a774e1-beacon-rzg2h-kit-u-boot.dtsi
deleted file mode 100644
index 85336d5f3ba..00000000000
--- a/arch/arm/dts/r8a774e1-beacon-rzg2h-kit-u-boot.dtsi
+++ /dev/null
@@ -1,6 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright 2021 LogicPD dba Beacon EmbeddedWorks
- */
-
-#include "rz-g2-beacon-u-boot.dtsi"
diff --git a/arch/arm/dts/rz-g2-beacon-u-boot.dtsi b/arch/arm/dts/rz-g2-beacon-u-boot.dtsi
deleted file mode 100644
index 97c4d4d292a..00000000000
--- a/arch/arm/dts/rz-g2-beacon-u-boot.dtsi
+++ /dev/null
@@ -1,82 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright 2021 LogicPD dba Beacon EmbeddedWorks
- */
-
-/ {
-	aliases {
-		spi0 = &rpc;
-	};
-
-	soc {
-		bootph-all;
-	};
-};
-
-&cpg {
-	bootph-all;
-};
-
-&ehci0 {
-	clocks = <&cpg CPG_MOD 703>, <&cpg CPG_MOD 704>, <&versaclock5 3>;
-};
-
-&ehci1 {
-	clocks = <&cpg CPG_MOD 703>, <&cpg CPG_MOD 704>, <&versaclock5 3>;
-};
-
-&extal_clk {
-	bootph-all;
-};
-
-&extalr_clk {
-	bootph-all;
-};
-
-&pfc {
-	qspi_pins: qspi {
-		groups = "qspi_ctrl", "qspi_data4";
-		function = "qspi";
-	};
-};
-
-&prr {
-	bootph-all;
-};
-
-&rpc {
-	pinctrl-0 = <&qspi_pins>;
-	pinctrl-names = "default";
-	spi-max-frequency = <40000000>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-	status = "okay";
-
-	flash0: spi-flash@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		reg = <0>;
-		compatible = "spi-flash", "jedec,spi-nor";
-		spi-max-frequency = <40000000>;
-		spi-tx-bus-width = <1>;
-		spi-rx-bus-width = <1>;
-	};
-};
-
-&sdhi0 {
-	/delete-property/ cd-gpios;
-	sd-uhs-sdr12;
-	sd-uhs-sdr25;
-	sd-uhs-sdr104;
-	max-frequency = <208000000>;
-};
-
-&sdhi2 {
-	status = "disabled";
-};
-
-&sdhi3 {
-	mmc-ddr-1_8v;
-	mmc-hs200-1_8v;
-	mmc-hs400-1_8v;
-};
diff --git a/arch/arm/mach-renesas/Kconfig.rcar3 b/arch/arm/mach-renesas/Kconfig.rcar3
index 6bed7684fb8..9a8a9a5edca 100644
--- a/arch/arm/mach-renesas/Kconfig.rcar3
+++ b/arch/arm/mach-renesas/Kconfig.rcar3
@@ -79,19 +79,6 @@ choice
 	prompt "Renesas ARM64 SoCs board select"
 	optional
 
-config TARGET_BEACON_RZG2M
-	bool "Beacon EmbeddedWorks RZ/G2 Dev Kit"
-	select PINCTRL_PFC_R8A774A1
-	select PINCTRL_PFC_R8A774B1
-	select PINCTRL_PFC_R8A774E1
-	select R8A774A1
-	select R8A774B1
-	select R8A774E1
-	select RZ_G2
-	imply CLK_CCF
-	imply CLK_VERSACLOCK
-	imply MULTI_DTB_FIT
-
 config TARGET_CONDOR
 	bool "Condor board"
 	imply R8A77980
@@ -182,18 +169,15 @@ source "board/renesas/salvator-x/Kconfig"
 source "board/renesas/ulcb/Kconfig"
 source "board/renesas/v3hsk/Kconfig"
 source "board/renesas/v3msk/Kconfig"
-source "board/beacon/beacon-rzg2m/Kconfig"
 source "board/hoperun/hihope-rzg2/Kconfig"
 source "board/silinux/ek874/Kconfig"
 
 config MULTI_DTB_FIT_UNCOMPRESS_SZ
-	default 0x80000 if TARGET_BEACON_RZG2M
 	default 0x80000 if TARGET_HIHOPE_RZG2
 	default 0x80000 if TARGET_SALVATOR_X
 	default 0x80000 if TARGET_ULCB
 
 config MULTI_DTB_FIT_USER_DEF_ADDR
-	default 0x49000000 if TARGET_BEACON_RZG2M
 	default 0x49000000 if TARGET_HIHOPE_RZG2
 	default 0x49000000 if TARGET_SALVATOR_X
 	default 0x49000000 if TARGET_ULCB
diff --git a/board/beacon/beacon-rzg2m/Kconfig b/board/beacon/beacon-rzg2m/Kconfig
deleted file mode 100644
index 1eb9e0dda94..00000000000
--- a/board/beacon/beacon-rzg2m/Kconfig
+++ /dev/null
@@ -1,15 +0,0 @@
-if TARGET_BEACON_RZG2M
-
-config SYS_SOC
-	default "renesas"
-
-config SYS_BOARD
-	default "beacon-rzg2m"
-
-config SYS_VENDOR
-	default "beacon"
-
-config SYS_CONFIG_NAME
-	default "beacon-rzg2m"
-
-endif
diff --git a/board/beacon/beacon-rzg2m/MAINTAINERS b/board/beacon/beacon-rzg2m/MAINTAINERS
deleted file mode 100644
index a4a920a017b..00000000000
--- a/board/beacon/beacon-rzg2m/MAINTAINERS
+++ /dev/null
@@ -1,17 +0,0 @@
-BEACON_RZG2M BOARD
-M:	Adam Ford <aford173@gmail.com>
-M:	Marek Vasut <marek.vasut+renesas@mailbox.org>
-S:	Maintained
-F:	board/beacon/beacon-rzg2m/
-F:	include/configs/beacon-rzg2m.h
-F:	configs/rzg2_beacon_defconfig
-F:	arch/arm/dts/beacon-renesom-baseboard.dtsi
-F:	arch/arm/dts/beacon-renesom-som.dtsi
-F:	arch/arm/dts/r8a774a1-beacon-rzg2m-kit.dts
-F:	arch/arm/dts/r8a774b1-beacon-rzg2n-kit.dts
-F:	arch/arm/dts/r8a774e1-beacon-rzg2h-kit.dts
-F:	arch/arm/dts/r8a774a1-beacon-rzg2m-kit-u-boot.dtsi
-F:	arch/arm/dts/r8a774b1-beacon-rzg2n-kit-u-boot.dtsi
-F:	arch/arm/dts/r8a774e1-beacon-rzg2h-kit-u-boot.dtsi
-F:	arch/arm/dts/rz-g2-beacon-u-boot.dtsi
-
diff --git a/board/beacon/beacon-rzg2m/Makefile b/board/beacon/beacon-rzg2m/Makefile
deleted file mode 100644
index 10b7a7fbfa9..00000000000
--- a/board/beacon/beacon-rzg2m/Makefile
+++ /dev/null
@@ -1,9 +0,0 @@
-#
-# board/renesas/hihope-rzg2m/Makefile
-#
-# Copyright (C) 2019 Renesas Electronics Corporation
-#
-# SPDX-License-Identifier: GPL-2.0+
-#
-
-obj-y	:= beacon-rzg2m.o ../../renesas/common/gen3-common.o ../../renesas/common/rcar64-common.o
diff --git a/board/beacon/beacon-rzg2m/beacon-rzg2m.c b/board/beacon/beacon-rzg2m/beacon-rzg2m.c
deleted file mode 100644
index 099053235de..00000000000
--- a/board/beacon/beacon-rzg2m/beacon-rzg2m.c
+++ /dev/null
@@ -1,33 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2020 Compass Electronics Group, LLC
- */
-
-#include <asm/global_data.h>
-#include <asm/io.h>
-
-DECLARE_GLOBAL_DATA_PTR;
-
-int board_init(void)
-{
-	/* address of boot parameters */
-	gd->bd->bi_boot_params = CONFIG_TEXT_BASE + 0x50000;
-
-	return 0;
-}
-
-#if IS_ENABLED(CONFIG_MULTI_DTB_FIT)
-int board_fit_config_name_match(const char *name)
-{
-	if (!strcmp(rzg_get_cpu_name(), "R8A774A1") && !strcmp(name, "r8a774a1-beacon-rzg2m-kit"))
-		return 0;
-
-	if (!strcmp(rzg_get_cpu_name(), "R8A774B1") && !strcmp(name, "r8a774b1-beacon-rzg2n-kit"))
-		return 0;
-
-	if (!strcmp(rzg_get_cpu_name(), "R8A774E1") && !strcmp(name, "r8a774e1-beacon-rzg2h-kit"))
-		return 0;
-
-	return -1;
-}
-#endif
diff --git a/configs/rzg2_beacon_defconfig b/configs/rzg2_beacon_defconfig
deleted file mode 100644
index d3f7061f04d..00000000000
--- a/configs/rzg2_beacon_defconfig
+++ /dev/null
@@ -1,46 +0,0 @@
-#include <configs/renesas_rcar3.config>
-
-CONFIG_ARM=y
-CONFIG_ARCH_RENESAS=y
-CONFIG_RCAR_GEN3=y
-CONFIG_SYS_MALLOC_F_LEN=0x2000
-CONFIG_ENV_SIZE=0x2000
-CONFIG_ENV_OFFSET=0xFFFFE000
-CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a774a1-beacon-rzg2m-kit"
-CONFIG_TARGET_BEACON_RZG2M=y
-# CONFIG_SPL is not set
-# CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="mmc dev ${mmcdev}; if mmc rescan; then if run loadbootscript; then run bootscript; else if run loadimage; then run mmcboot; else run netboot; fi; fi; else booti ${loadaddr} - ${fdt_addr}; fi"
-CONFIG_DEFAULT_FDT_FILE="r8a774a1-beacon-rzg2m-kit.dtb"
-# CONFIG_BOARD_EARLY_INIT_F is not set
-CONFIG_CMD_MMC=y
-CONFIG_CMD_MTD=y
-CONFIG_CMD_PART=y
-CONFIG_CMD_USB=y
-CONFIG_OF_LIST="renesas/r8a774a1-beacon-rzg2m-kit renesas/r8a774b1-beacon-rzg2n-kit renesas/r8a774e1-beacon-rzg2h-kit"
-CONFIG_MULTI_DTB_FIT_LZO=y
-CONFIG_MULTI_DTB_FIT_USER_DEFINED_AREA=y
-CONFIG_ENV_IS_IN_MMC=y
-CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
-CONFIG_DM_PCA953X=y
-CONFIG_SYS_I2C_RCAR_I2C=y
-CONFIG_SYS_I2C_RCAR_IIC=y
-CONFIG_MMC_IO_VOLTAGE=y
-CONFIG_MMC_UHS_SUPPORT=y
-CONFIG_MMC_HS200_SUPPORT=y
-CONFIG_RENESAS_SDHI=y
-CONFIG_DM_MTD=y
-CONFIG_SPI_FLASH_WINBOND=y
-CONFIG_PHY_ATHEROS=y
-CONFIG_PHY_MICREL=y
-CONFIG_PHY_MICREL_KSZ90X1=y
-CONFIG_RENESAS_RAVB=y
-CONFIG_SPECIFY_CONSOLE_INDEX=y
-CONFIG_SYSRESET=y
-CONFIG_SYSRESET_PSCI=y
-CONFIG_USB=y
-CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_EHCI_HCD=y
-CONFIG_USB_EHCI_GENERIC=y
-CONFIG_USB_STORAGE=y
diff --git a/doc/board/renesas/renesas.rst b/doc/board/renesas/renesas.rst
index c0cefc15dd8..8945e2eab22 100644
--- a/doc/board/renesas/renesas.rst
+++ b/doc/board/renesas/renesas.rst
@@ -81,19 +81,13 @@ Renesas is a SoC solutions provider for automotive and industrial applications.
    +--------+------------------+----------------------------------+--------------------+--------------------+----------------------------------------------+----------------------------------+
    | RZ     | A1               | :doc:`arm <build-env-aarch32>`   | R7S72100 (RZ/A1H)  | Cortex A9          | GR-PEACH                                     | grpeach_defconfig                |
    |        +------------------+----------------------------------+--------------------+--------------------+----------------------------------------------+----------------------------------+
-   |        |                  |                                  |                    |                    | Beacon EmbeddedWorks RZ/G2M SoM              | rzg2_beacon_defconfig            |
-   |        |                  |                                  | R8A774A1 (RZ/G2M)  | Cortex A53 or A57  +----------------------------------------------+----------------------------------+
-   |        |                  |                                  |                    |                    | HopeRun HiHope RZ/G2M                        | hihope_rzg2_defconfig            |
+   |        |                  |                                  | R8A774A1 (RZ/G2M)  | Cortex A53 or A57  | HopeRun HiHope RZ/G2M                        | hihope_rzg2_defconfig            |
    |        |                  |                                  +--------------------+--------------------+----------------------------------------------+----------------------------------+
-   |        |                  |                                  |                    |                    | Beacon EmbeddedWorks RZ/G2N SoM              | rzg2_beacon_defconfig            |
-   |        | G2               | :doc:`arm64 <build-env-aarch64>` | R8A774B1 (RZ/G2N)  | Cortex A57         +----------------------------------------------+----------------------------------+
-   |        |                  |                                  |                    |                    | HopeRun HiHope RZ/G2N                        | hihope_rzg2_defconfig            |
+   |        | G2               | :doc:`arm64 <build-env-aarch64>` | R8A774B1 (RZ/G2N)  | Cortex A57         | HopeRun HiHope RZ/G2N                        | hihope_rzg2_defconfig            |
    |        |                  |                                  +--------------------+--------------------+----------------------------------------------+----------------------------------+
    |        |                  |                                  | R8A774C0 (RZ/G2E)  | Cortex A53         | Silicon Linux RZ/G2E evaluation kit (EK874)  | silinux_ek874_defconfig          |
    |        |                  |                                  +--------------------+--------------------+----------------------------------------------+----------------------------------+
-   |        |                  |                                  |                    |                    | Beacon EmbeddedWorks RZ/G2H SoM              | rzg2_beacon_defconfig            |
-   |        |                  |                                  | R8A774E1 (RZ/G2H)  | Cortex A53 or A57  +----------------------------------------------+----------------------------------+
-   |        |                  |                                  |                    |                    | HopeRun HiHope RZ/G2H                        | hihope_rzg2_defconfig            |
+   |        |                  |                                  | R8A774E1 (RZ/G2H)  | Cortex A53 or A57  | HopeRun HiHope RZ/G2H                        | hihope_rzg2_defconfig            |
    +--------+------------------+----------------------------------+--------------------+--------------------+----------------------------------------------+----------------------------------+
    |        |                  |                                  | R9A06G032 (RZ/N1D) |                    | Schneider RZ/N1D board                       | rzn1_snarc_defconfig             |
    |        | :doc:`N1 <rzn1>` | :doc:`arm <build-env-aarch32>`   +--------------------+ Cortex A7          +----------------------------------------------+----------------------------------+
diff --git a/include/configs/beacon-rzg2m.h b/include/configs/beacon-rzg2m.h
deleted file mode 100644
index 65c01835cc6..00000000000
--- a/include/configs/beacon-rzg2m.h
+++ /dev/null
@@ -1,67 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2020 Compass Electronics Group, LLC
- */
-
-#ifndef __BEACON_RZG2M_H
-#define __BEACON_RZG2M_H
-
-#include "rcar-gen3-common.h"
-
-#undef CFG_EXTRA_ENV_SETTINGS
-
-#define CFG_EXTRA_ENV_SETTINGS		\
-	"usb_pgood_delay=2000\0"	\
-	"script=boot.scr\0" \
-	"image=Image\0" \
-	"console=ttySC0,115200\0" \
-	"fdt_addr=0x48000000\0" \
-	"loadaddr=0x48080000\0" \
-	"boot_fdt=try\0" \
-	"fdt_file=" CONFIG_DEFAULT_FDT_FILE "\0" \
-	"initrd_addr=0x43800000\0"		\
-	"mmcdev=1\0" \
-	"mmcpart=1\0" \
-	"mmcrootpart=2\0" \
-	"finduuid=part uuid mmc ${mmcdev}:${mmcrootpart} uuid\0" \
-	"mmcautodetect=yes\0" \
-	"mmcargs=setenv bootargs console=${console} " \
-	" root=PARTUUID=${uuid} rootwait rw ${optargs}\0" \
-	"loadbootscript=load mmc ${mmcdev}:${mmcpart} ${loadaddr} ${script};\0" \
-	"bootscript=echo Running bootscript from mmc ...; " \
-		"source\0" \
-	"loadimage=load mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}\0" \
-	"loadfdt=load mmc ${mmcdev}:${mmcpart} ${fdt_addr} ${fdt_file}\0" \
-	"mmcboot=echo Booting from mmc ...; " \
-		"run finduuid; run mmcargs; " \
-		"if test ${boot_fdt} = yes || test ${boot_fdt} = try; then " \
-			"if run loadfdt; then " \
-				"booti ${loadaddr} - ${fdt_addr}; " \
-			"else " \
-				"echo WARN: Cannot load the DT; " \
-			"fi; " \
-		"else " \
-			"echo wait for boot; " \
-		"fi;\0" \
-	"netargs=setenv bootargs ${jh_clk} console=${console} " \
-		"root=/dev/nfs " \
-		"ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp\0" \
-	"netboot=echo Booting from net ...; " \
-		"run netargs;  " \
-		"if test ${ip_dyn} = yes; then " \
-			"setenv get_cmd dhcp; " \
-		"else " \
-			"setenv get_cmd tftp; " \
-		"fi; " \
-		"${get_cmd} ${loadaddr} ${image}; " \
-		"if test ${boot_fdt} = yes || test ${boot_fdt} = try; then " \
-			"if ${get_cmd} ${fdt_addr} ${fdt_file}; then " \
-				"booti ${loadaddr} - ${fdt_addr}; " \
-			"else " \
-				"echo WARN: Cannot load the DT; " \
-			"fi; " \
-		"else " \
-			"booti; " \
-		"fi;\0"
-
-#endif /* __BEACON_RZG2M_H */
-- 
2.53.0

