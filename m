Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9684C88E5C
	for <u-boot@archiver.kernel.org>; Sun, 13 Sep 2026 23:20:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9480780D64;
	Sun, 13 Sep 2026 23:20:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZRCWjNntsgle; Sun, 13 Sep 2026 23:20:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2045680CDF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789341609;
	b=aH5xENFVzOGuxA4RThEl0ABvHvmAtQrOBxbSnVOjVt8sS/Fi6gN7JUroMCp3S2RVGHV9
	 0gyiB8dMyOxrxfkiaEQg9velwDC3hEx9/+jsEGO65TZHFqYFR156q87wOdvZfDoxWyguM
	 3o7vqEAu8KcCiEsioBspf5wkPUXfhyjcoHjEzvAAMLER7tkPwkHCbdvv4A1wjrx9XJ7Jc
	 I3GSmibL6Ws7mloBQscJS3QPJiQ5hoKgVxST8fazRa6hddb9/AbsIkXE2ofKQybX5T7pV
	 htX5mfBY0TxX3pBUB9zixM6Z59gsBEwViZKV2m588nkSM3cPpM0ytdCcYYsTx1XQdWg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789341609;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rTmhg8pWFj+Go0c9XA4aD/DQ5nHu1ouSXtS3rJ9Ml/M=;
	b=k54+wHosCpfj9bIWctqFQ94hp/U9sMd07njT6QvyuXH0TKRp+i1fCaGynfAi1cgqFK4n
	 xj9C9v+d8TjkXyncGDg6D0ScOr4lsWP8zSSbETG5vbOzYa8IY5q3rXyHYNVXGO3jBHemI
	 N8EVnclQkMl3yiWJlzI1H0aezaT2ydOwcjuyUJOtGMm6ngVRTzuRnv3t+VCDVGSYmcDTl
	 3iIzf8S3RYATlZMYRs2w8ZvdXm+GGVFpgaC7QL8fY7Hhvddh/jGN5pd7eO7bApI6I54M6
	 3/nL/mXOM6bd1+L9g0/g8Ny6Jqpnp0U2zcmiOVE9D38OZk1+ns+ugMb5+QfjPTX+PbQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789341609;
	bh=rTmhg8pWFj+Go0c9XA4aD/DQ5nHu1ouSXtS3rJ9Ml/M=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=R5/bAcRtidJhQS7yeDf2d/pIjos6vHIFelGAgBuIot1V4rS7OlmSyJI365peDa6O/
	 Tt7dK3ABwswwXagphomo2rMUyBoenMg/C2Al54cpHFocK7izc/lxZ9tixiFoIeL19z
	 RYu1X5b1nVn/kEXOyNBTneDT89lTfMYv+GXEcFJpL1jXj4SngWnHRXoSYmkm+i072c
	 pEMTjUDv4r50O7OgJzmOKzXWY/ocTfWEiVfrOOPwqUrh0F+EFHw38CnlCwJdsl22yI
	 0IZuaEJ33Mlr+klotQkQjouVfeiXM8NQTdxKcOZvMc1c7tZBRLvltgoSNbihDzW1Hi
	 uqQrWXNLzl3Eg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2045680CDF;
	Sun, 13 Sep 2026 23:20:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DAFB9259
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 15:52:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CD3D540599
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 15:52:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dukTKA7EmZg8 for <u-boot@lists.u-boot-project.org>;
 Sun, 13 Sep 2026 15:52:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8E8EF4058C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:34::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789314758;
 b=CdtjUaASOB8Walh2QmDL9Fiuvh1pasq/qS0r9nLoaorPdMdJ4cWC/bIseAP1vDV2cn0B
 JOHHHkHd3GKFnrhptJukk7TTMTISUJ1cifusQX1EWeFEruC0/2xI/qorDiL+zogojEq2O
 74OnO0WGAJQ6/VHWfm0zNCRhndHseuxz50xyFqsa3IVBU8R7EKtDm3VDGRVqqXUSVhyZR
 w85nxGRhfiQTxjumljVTbjvaYqTzY2+hkh+I9KZsAEXiUB2d71/R+gGlNPMfYRiOIfcxq
 GhAOAf+qFOGuNbiWMhbKLiHafE0mrG5a5W6H6FP7xUBG4k7Hqj72lavdykJQaadTBXg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789314758;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=rTmhg8pWFj+Go0c9XA4aD/DQ5nHu1ouSXtS3rJ9Ml/M=;
 b=rCP/VB7zHf4KLbu7ZKKxlznAqfiCkqKgGyRW5/9fgCb+wE+K0LZ3vdu66z9Fo0Q7Y6tM
 D4E/wRZdKdBU4HbIDpacQ4CZm9O3yVd7P3GZMzKnPbQwz+VY0g7d6inZO8nDzmzEBuexn
 1r17681KZaGmYDkhF/FG/X3hMHOULfLtFub1UJ2HlklGXkjUtg6wiEAcrzhcYq/rnRsZi
 ggkusqhxVO5dhrjCYt3Gi2Y9X5m4H60Im11APiLuM3O1mguAEiTZXpt6v/5Y+oS02CJ+y
 +U3DsZm78FHnIBO4mBXZLHnPsflGWZCMae78D5h9mGaX07UUPF7GwyyCLBiyA0LcA0w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=d5o6lAat; 
 arc=none smtp.remote-ip="2607:f8b0:4864:34::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:34::11; helo=mail-qk2-x11.google.com;
 envelope-from=aford173@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=d5o6lAat
Received: from mail-qk2-x11.google.com (mail-qk2-x11.google.com
 [IPv6:2607:f8b0:4864:34::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8E8EF4058C
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 15:52:37 +0000 (UTC)
Received: by mail-qk2-x11.google.com with SMTP id
 d75a77b69052e-530de452c33so20072911cf.1
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 08:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789314756; x=1789919556;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rTmhg8pWFj+Go0c9XA4aD/DQ5nHu1ouSXtS3rJ9Ml/M=;
 b=d5o6lAatNt8Pd8IiadheGjnfCTJgJAnpOFUk6h0T2WgxSreU8k72pT3hSEcut2sTiL
 J4c6PStw3D2/pN1MFEV8V/MPxLs6f9zpCgHI9ogayffvcqYHyEgJJdLCueowqk/T9owd
 P7eT/eSzF1ubMyxVG88IU01QjB0TrdcpA/W2K1BfNcBv7ZgBFxsyRqkYwVlNk453r5hZ
 kQvmePBILCkClwIdQ3d9WZyqkOP3tWrkqd+WBhsBILzuwdDHPATMddNcJMYA8ZUbXGeg
 WCU7PWgh5O3HPNvbx4u8oOw4ulxxaOrCcYJy2WOxbJ1tGezM/aRqpx9d0q0utH16eZmg
 mYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789314756; x=1789919556;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rTmhg8pWFj+Go0c9XA4aD/DQ5nHu1ouSXtS3rJ9Ml/M=;
 b=gjv9NPbsoNywwSp2gZ75/q5ZuQduH3sqp3ORM5+kSRDX0+TxLep7wPBICaMLJKz91Q
 nFxUqDMk8LPh6yzJFwhfO/+cUCngNBDecvcag9hYFfbhzTbjec7G1GnmIVZ+1xfIr2IE
 XKN7nfMFUMU2qj7vOz7hVq055SsF3WX48O/RiSNdXKzEuqFwzAUJBA+WID3xR2Afy1dK
 lukd10hqJ4jpMpa/ANGNbG5UkBedn3ixPQgLBY3DcuXf8u7lzDO7p4KIsmHdyEQot/cy
 WR7Dm9r3INFOl4iyoVVLbYsFeJgh837Yhe4mGTsGS9IkBRknAYB5H09Ilip593YThNuC
 lY4A==
X-Gm-Message-State: AFuF++mpW1xB0nAafLtFEE27cCBqjri7FN0xKUkiifbORVM2+46enhbe
 j9yczRY3rI2ni2lsPDSmtKFZVRclZtFY9mCsi067jr3JiZmkqUMqzQhHnr2XmQ==
X-Gm-Gg: AYBFou1wK1yBfgfZF4g9OhvH8EHXLxKmwsYt+tlRbxOovkAKZyJ/qsCxGLXozA/evK4
 FrXaRb4snbwX8McF7zP9nXBwob66FcCpD5Hil1wBDBi5K4bOg+FjCsr5s2t23169RWyAtg9ZZ8h
 hNJlu/3yZ2mhNI5UDpxit/klJPBqHtsbrb435pkx7+okp2VFCxhaQsSuMG1edgu7+G09gknjs0Y
 m9IK0kRELZUcL7T5LsL/lALp5JywTFJBRAaLeXUswuIxpBEa3I0SF6GBJLYnSSE4UWy7/HjdcBl
 hX41gtQAXxaAnrRa/v0psuBbyANQmnm3DwVWpCh0Rvw4YS1nPwz8Wpqhw9lXbcSspAJcb3eGq/t
 TkNzLNi25wTJ4es9UrhTie4bzLlMZIlYs6DZS77Oh1zsw8eYMcuIqcFA3T8CiWkILQK5JRJU1fJ
 ZQV3dx85gkuHhNn+oV2guxibp3FB84VIYzfH9fsA+yCh0bmhcB7XQD7hzrxM8EYuLOApGIemesI
 J11B6kD/Y8HjoyWOou8Z6cCOaTB5pk65ccYZynl4CiLx/eFGuo4
X-Received: by 2002:ac8:5a10:0:b0:530:e429:ea81 with SMTP id
 d75a77b69052e-530e429f293mr134806181cf.11.1789314755851; 
 Sun, 13 Sep 2026 08:52:35 -0700 (PDT)
Received: from aford-System-Version.lan (c-73-94-212-116.hsd1.mn.comcast.net.
 [73.94.212.116]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9120f4d3a50sm72984396d6.40.2026.09.13.08.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 08:52:35 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adam Ford <aford173@gmail.com>
Subject: [PATCH] board: logicpd: Remove AM3517 EVM support
Date: Sun, 13 Sep 2026 10:52:31 -0500
Message-ID: <20260913155231.84127-1-aford173@gmail.com>
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

Remove the Logic PD AM3517 EVM board support along with its defconfig,
config header, U-Boot device tree overlays and Kconfig target. The
stale copy of am3517-evm-ui.dtsi in arch/arm/dts is dropped too, since
the board is built from the upstream device tree.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 arch/arm/dts/am3517-evm-u-boot.dtsi   |  54 -------
 arch/arm/dts/am3517-evm-ui.dtsi       | 217 --------------------------
 arch/arm/dts/am3517-u-boot.dtsi       |   9 --
 arch/arm/mach-omap2/omap3/Kconfig     |  10 --
 board/logicpd/am3517evm/Kconfig       |  14 --
 board/logicpd/am3517evm/MAINTAINERS   |   6 -
 board/logicpd/am3517evm/Makefile      |   9 --
 board/logicpd/am3517evm/am3517evm.c   | 152 ------------------
 board/logicpd/am3517evm/am3517evm.env |  20 ---
 board/logicpd/am3517evm/am3517evm.h   | 194 -----------------------
 configs/am3517_evm_defconfig          |  96 ------------
 include/configs/am3517_evm.h          |  42 -----
 12 files changed, 823 deletions(-)
 delete mode 100644 arch/arm/dts/am3517-evm-u-boot.dtsi
 delete mode 100644 arch/arm/dts/am3517-evm-ui.dtsi
 delete mode 100644 arch/arm/dts/am3517-u-boot.dtsi
 delete mode 100644 board/logicpd/am3517evm/Kconfig
 delete mode 100644 board/logicpd/am3517evm/MAINTAINERS
 delete mode 100644 board/logicpd/am3517evm/Makefile
 delete mode 100644 board/logicpd/am3517evm/am3517evm.c
 delete mode 100644 board/logicpd/am3517evm/am3517evm.env
 delete mode 100644 board/logicpd/am3517evm/am3517evm.h
 delete mode 100644 configs/am3517_evm_defconfig
 delete mode 100644 include/configs/am3517_evm.h

diff --git a/arch/arm/dts/am3517-evm-u-boot.dtsi b/arch/arm/dts/am3517-evm-u-boot.dtsi
deleted file mode 100644
index 8d486f0020d..00000000000
--- a/arch/arm/dts/am3517-evm-u-boot.dtsi
+++ /dev/null
@@ -1,54 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2017
- * Logic PD - http://www.logicpd.com
- */
-
-#include "omap3-u-boot.dtsi"
-
-/ {
-	aliases {
-		/delete-property/ serial0;
-		/delete-property/ serial1;
-	};
-
-	ocp@68000000 {
-		/delete-node/ bandgap@48002524;
-	};
-};
-
-&gpio1 {
-	/delete-property/ bootph-pre-ram;
-};
-
-&gpio2 {
-	/delete-property/ bootph-pre-ram;
-};
-
-&gpio3 {
-	/delete-property/ bootph-pre-ram;
-};
-
-&gpio5 {
-	/delete-property/ bootph-pre-ram;
-};
-
-&gpio6 {
-	/delete-property/ bootph-pre-ram;
-};
-
-&mmc2 {
-	/delete-property/ bootph-pre-ram;
-};
-
-&mmc3 {
-	/delete-property/ bootph-pre-ram;
-};
-
-&uart1 {
-	/delete-property/ bootph-pre-ram;
-};
-
-&uart2 {
-	/delete-property/ bootph-pre-ram;
-};
diff --git a/arch/arm/dts/am3517-evm-ui.dtsi b/arch/arm/dts/am3517-evm-ui.dtsi
deleted file mode 100644
index 75ad42179ae..00000000000
--- a/arch/arm/dts/am3517-evm-ui.dtsi
+++ /dev/null
@@ -1,217 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2018 Logic PD, Inc - https://www.logicpd.com/
- */
-
-#include <dt-bindings/input/input.h>
-
-/ {
-	codec1 {
-		compatible = "simple-audio-card";
-		simple-audio-card,name = "tlv320aic23-hifi";
-
-		simple-audio-card,widgets =
-			"Microphone", "Mic In",
-			"Line", "Line In",
-			"Line", "Line Out";
-
-		simple-audio-card,routing =
-			"Line Out", "LOUT",
-			"Line Out", "ROUT",
-			"LLINEIN", "Line In",
-			"RLINEIN", "Line In",
-			"MICIN", "Mic In";
-
-		simple-audio-card,format = "i2s";
-		simple-audio-card,bitclock-master = <&sound_master>;
-		simple-audio-card,frame-master = <&sound_master>;
-
-		simple-audio-card,cpu {
-			sound-dai = <&mcbsp1>;
-		};
-
-		sound_master: simple-audio-card,codec {
-			sound-dai = <&tlv320aic23_1>;
-			system-clock-frequency = <12000000>;
-		};
-	};
-
-	codec2 {
-		compatible = "simple-audio-card";
-		simple-audio-card,name = "tlv320aic23-hifi";
-
-		simple-audio-card,widgets =
-			"Microphone", "Mic In",
-			"Line", "Line In",
-			"Line", "Line Out";
-
-		simple-audio-card,routing =
-			"Line Out", "LOUT",
-			"Line Out", "ROUT",
-			"LLINEIN", "Line In",
-			"RLINEIN", "Line In",
-			"MICIN", "Mic In";
-
-		simple-audio-card,format = "i2s";
-		simple-audio-card,bitclock-master = <&sound_master2>;
-		simple-audio-card,frame-master = <&sound_master2>;
-
-		simple-audio-card,cpu {
-			sound-dai = <&mcbsp2>;
-		};
-
-		sound_master2: simple-audio-card,codec {
-			sound-dai = <&tlv320aic23_2>;
-			system-clock-frequency = <12000000>;
-		};
-	};
-
-	expander-keys {
-		compatible = "gpio-keys-polled";
-		poll-interval = <100>;
-
-		key-record {
-			label = "Record";
-			/* linux,code = <BTN_0>; */
-			gpios = <&tca6416_2 15 GPIO_ACTIVE_LOW>;
-		};
-
-		key-play {
-			label = "Play";
-			linux,code = <KEY_PLAY>;
-			gpios = <&tca6416_2 14 GPIO_ACTIVE_LOW>;
-		};
-
-		key-stop {
-			label = "Stop";
-			linux,code = <KEY_STOP>;
-			gpios = <&tca6416_2 13 GPIO_ACTIVE_LOW>;
-		};
-
-		key-fwd {
-			label = "FWD";
-			linux,code = <KEY_FASTFORWARD>;
-			gpios = <&tca6416_2 12 GPIO_ACTIVE_LOW>;
-		};
-
-		key-rwd {
-			label = "RWD";
-			linux,code = <KEY_REWIND>;
-			gpios = <&tca6416_2 11 GPIO_ACTIVE_LOW>;
-		};
-
-		key-shift {
-			label = "Shift";
-			linux,code = <KEY_LEFTSHIFT>;
-			gpios = <&tca6416_2 10 GPIO_ACTIVE_LOW>;
-		};
-
-		key-mode {
-			label = "Mode";
-			linux,code = <BTN_MODE>;
-			gpios = <&tca6416_2 9 GPIO_ACTIVE_LOW>;
-		};
-
-		key-menu {
-			label = "Menu";
-			linux,code = <KEY_MENU>;
-			gpios = <&tca6416_2 8 GPIO_ACTIVE_LOW>;
-		};
-
-		key-up {
-			label = "Up";
-			linux,code = <KEY_UP>;
-			gpios = <&tca6416_2 7 GPIO_ACTIVE_LOW>;
-		};
-
-		key-down {
-			label = "Down";
-			linux,code = <KEY_DOWN>;
-			gpios = <&tca6416_2 6 GPIO_ACTIVE_LOW>;
-		};
-	};
-};
-
-&i2c2 {
-	/* Audio codecs */
-	tlv320aic23_1: codec@1a {
-		compatible = "ti,tlv320aic23";
-		reg = <0x1a>;
-		#sound-dai-cells = <0>;
-		status = "okay";
-	};
-
-	tlv320aic23_2: codec@1b {
-		compatible = "ti,tlv320aic23";
-		reg = <0x1b>;
-		#sound-dai-cells = <0>;
-		status = "okay";
-	};
-};
-
-&i2c3 {
-	/* Audio codecs */
-	tlv320aic23_3: codec@1a {
-		compatible = "ti,tlv320aic23";
-		reg = <0x1a>;
-		#sound-dai-cells = <0>;
-		status = "okay";
-	};
-
-	/* GPIO Expanders */
-	tca6416_2: gpio@20 {
-		compatible = "ti,tca6416";
-		reg = <0x20>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		vcc-supply = <&vdd_io_reg>;
-	};
-
-	tca6416_3: gpio@21 {
-		compatible = "ti,tca6416";
-		reg = <0x21>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		vcc-supply = <&vdd_io_reg>;
-	};
-
-	/* TVP5146 Analog Video decoder input */
-	tvp5146@5c {
-		compatible = "ti,tvp5146m2";
-		reg = <0x5c>;
-	};
-};
-
-&mcbsp1 {
-	status = "okay";
-	#sound-dai-cells = <0>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&mcbsp1_pins>;
-};
-
-&mcbsp2 {
-	status = "okay";
-	#sound-dai-cells = <0>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&mcbsp2_pins>;
-};
-
-&omap3_pmx_core {
-	mcbsp1_pins: pinmux_mcbsp1_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x2190, PIN_OUTPUT | MUX_MODE0)	/* mcbsp1_dx.mcbsp1_dx */
-			OMAP3_CORE1_IOPAD(0x2192, PIN_INPUT | MUX_MODE0)	/* mcbsp1_dx.mcbsp1_dr */
-			OMAP3_CORE1_IOPAD(0x2196, PIN_INPUT | MUX_MODE0)	/* mcbsp_clks.mcbsp1_fsx */
-			OMAP3_CORE1_IOPAD(0x2198, PIN_INPUT | MUX_MODE0)	/* mcbsp1_clkx.mcbsp1_clkx */
-		>;
-	};
-
-	mcbsp2_pins: pinmux_mcbsp2_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x213c, PIN_INPUT | MUX_MODE0)	/* mcbsp2_fsx.mcbsp2_fsx */
-			OMAP3_CORE1_IOPAD(0x213e, PIN_INPUT | MUX_MODE0)	/* mcbsp2_clkx.mcbsp2_clkx */
-			OMAP3_CORE1_IOPAD(0x2140, PIN_INPUT | MUX_MODE0)	/* mcbsp2_dr.mcbsp2.dr */
-			OMAP3_CORE1_IOPAD(0x2142, PIN_OUTPUT | MUX_MODE0)	/* mcbsp2_dx.mcbsp2_dx */
-		>;
-	};
-};
diff --git a/arch/arm/dts/am3517-u-boot.dtsi b/arch/arm/dts/am3517-u-boot.dtsi
deleted file mode 100644
index 374499dcb2a..00000000000
--- a/arch/arm/dts/am3517-u-boot.dtsi
+++ /dev/null
@@ -1,9 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2017
- * Logic PD - http://www.logicpd.com
- */
-
-&uart4 {
-	reg-shift = <2>;
-};
diff --git a/arch/arm/mach-omap2/omap3/Kconfig b/arch/arm/mach-omap2/omap3/Kconfig
index f6cad7d9d82..79e24acba8d 100644
--- a/arch/arm/mach-omap2/omap3/Kconfig
+++ b/arch/arm/mach-omap2/omap3/Kconfig
@@ -25,15 +25,6 @@ choice
 	prompt "OMAP3 board select"
 	optional
 
-config TARGET_AM3517_EVM
-	bool "AM3517 EVM"
-	select DM
-	select DM_GPIO
-	select DM_I2C
-	select DM_SERIAL
-	select MMC
-	imply CMD_DM
-
 config TARGET_DEVKIT8000
 	bool "TimLL OMAP3 Devkit8000"
 	select DM
@@ -138,7 +129,6 @@ config SPL_OMAP3_ID_NAND
 config SYS_SOC
 	default "omap3"
 
-source "board/logicpd/am3517evm/Kconfig"
 source "board/timll/devkit8000/Kconfig"
 source "board/ti/omap3evm/Kconfig"
 source "board/isee/igep00x0/Kconfig"
diff --git a/board/logicpd/am3517evm/Kconfig b/board/logicpd/am3517evm/Kconfig
deleted file mode 100644
index 743e500a5ca..00000000000
--- a/board/logicpd/am3517evm/Kconfig
+++ /dev/null
@@ -1,14 +0,0 @@
-if TARGET_AM3517_EVM
-
-config SYS_BOARD
-	default "am3517evm"
-
-config SYS_VENDOR
-	default "logicpd"
-
-config SYS_CONFIG_NAME
-	default "am3517_evm"
-
-source "board/ti/common/Kconfig"
-
-endif
diff --git a/board/logicpd/am3517evm/MAINTAINERS b/board/logicpd/am3517evm/MAINTAINERS
deleted file mode 100644
index 198023fb15c..00000000000
--- a/board/logicpd/am3517evm/MAINTAINERS
+++ /dev/null
@@ -1,6 +0,0 @@
-AM3517EVM BOARD
-M:	Adam Ford <aford173@gmail.com>
-S:	Maintained
-F:	board/logicpd/am3517evm/
-F:	include/configs/am3517_evm.h
-F:	configs/am3517_evm_defconfig
diff --git a/board/logicpd/am3517evm/Makefile b/board/logicpd/am3517evm/Makefile
deleted file mode 100644
index c7da6e3fe0d..00000000000
--- a/board/logicpd/am3517evm/Makefile
+++ /dev/null
@@ -1,9 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-#
-# Author: Vaibhav Hiremath <hvaibhav@ti.com>
-#
-# Based on ti/evm/Makefile
-#
-# Copyright (C) 2010 Texas Instruments Incorporated - https://www.ti.com/
-
-obj-y	:= am3517evm.o
diff --git a/board/logicpd/am3517evm/am3517evm.c b/board/logicpd/am3517evm/am3517evm.c
deleted file mode 100644
index e4f619d0942..00000000000
--- a/board/logicpd/am3517evm/am3517evm.c
+++ /dev/null
@@ -1,152 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * am3517evm.c - board file for TI's AM3517 family of devices.
- *
- * Author: Vaibhav Hiremath <hvaibhav@ti.com>
- *
- * Based on ti/evm/evm.c
- *
- * Copyright (C) 2010
- * Texas Instruments Incorporated - https://www.ti.com/
- */
-
-#include <dm.h>
-#include <init.h>
-#include <net.h>
-#include <ns16550.h>
-#include <serial.h>
-#include <asm/global_data.h>
-#include <asm/io.h>
-#include <asm/omap_musb.h>
-#include <asm/arch/am35x_def.h>
-#include <asm/arch/mem.h>
-#include <asm/arch/mux.h>
-#include <asm/arch/sys_proto.h>
-#include <asm/arch/mmc_host_def.h>
-#include <asm/arch/musb.h>
-#include <asm/mach-types.h>
-#include <linux/errno.h>
-#include <asm/gpio.h>
-#include <linux/usb/ch9.h>
-#include <linux/usb/gadget.h>
-#include <linux/usb/musb.h>
-#include <i2c.h>
-#include "am3517evm.h"
-
-DECLARE_GLOBAL_DATA_PTR;
-
-#define AM3517_IP_SW_RESET	0x48002598
-#define CPGMACSS_SW_RST		(1 << 1)
-#define PHY_GPIO		30
-
-#if defined(CONFIG_XPL_BUILD)
-#if defined(CONFIG_SPL_OS_BOOT)
-int spl_start_uboot(void)
-{
-	/* break into full u-boot on 'c' */
-	return serial_tstc() && serial_getc() == 'c';
-}
-#endif
-#endif
-
-/*
- * Routine: board_init
- * Description: Early hardware init.
- */
-int board_init(void)
-{
-	gpmc_init(); /* in SRAM or SDRAM, finish GPMC */
-	/* board id for Linux */
-	gd->bd->bi_arch_number = MACH_TYPE_OMAP3517EVM;
-	/* boot param addr */
-	gd->bd->bi_boot_params = (OMAP34XX_SDRC_CS0 + 0x100);
-
-	return 0;
-}
-
-#ifdef CONFIG_USB_MUSB_AM35X
-static struct musb_hdrc_config musb_config = {
-	.multipoint     = 1,
-	.dyn_fifo       = 1,
-	.num_eps        = 16,
-	.ram_bits       = 12,
-};
-
-static struct omap_musb_board_data musb_board_data = {
-	.set_phy_power		= am35x_musb_phy_power,
-	.clear_irq		= am35x_musb_clear_irq,
-	.reset			= am35x_musb_reset,
-};
-
-static struct musb_hdrc_platform_data musb_plat = {
-#if defined(CONFIG_USB_MUSB_HOST)
-	.mode           = MUSB_HOST,
-#elif defined(CONFIG_USB_MUSB_GADGET)
-	.mode		= MUSB_PERIPHERAL,
-#else
-#error "Please define either CONFIG_USB_MUSB_HOST or CONFIG_USB_MUSB_GADGET"
-#endif
-	.config         = &musb_config,
-	.power          = 250,
-	.platform_ops	= &am35x_ops,
-	.board_data	= &musb_board_data,
-};
-
-static void am3517_evm_musb_init(void)
-{
-	/*
-	 * Set up USB clock/mode in the DEVCONF2 register.
-	 * USB2.0 PHY reference clock is 13 MHz
-	 */
-	clrsetbits_le32(&am35x_scm_general_regs->devconf2,
-			CONF2_REFFREQ | CONF2_OTGMODE | CONF2_PHY_GPIOMODE,
-			CONF2_REFFREQ_13MHZ | CONF2_SESENDEN |
-			CONF2_VBDTCTEN | CONF2_DATPOL);
-
-	musb_register(&musb_plat, &musb_board_data,
-			(void *)AM35XX_IPSS_USBOTGSS_BASE);
-}
-#else
-#define am3517_evm_musb_init() do {} while (0)
-#endif
-
-/*
- * Routine: misc_init_r
- * Description: Init i2c, ethernet, etc... (done here so udelay works)
- */
-int misc_init_r(void)
-{
-	omap_die_id_display();
-
-	am3517_evm_musb_init();
-
-	return 0;
-}
-
-/*
- * Routine: set_muxconf_regs
- * Description: Setting up the configuration Mux registers specific to the
- *		hardware. Many pins need to be moved from protect to primary
- *		mode.
- */
-void set_muxconf_regs(void)
-{
-	MUX_AM3517EVM();
-}
-
-#if defined(CONFIG_USB_ETHER) && defined(CONFIG_USB_MUSB_GADGET)
-int board_eth_init(struct bd_info *bis)
-{
-	int rv, n = 0;
-
-	rv = cpu_eth_init(bis);
-	if (rv > 0)
-		n += rv;
-
-	rv = usb_eth_initialize(bis);
-	if (rv > 0)
-		n += rv;
-
-	return n;
-}
-#endif
diff --git a/board/logicpd/am3517evm/am3517evm.env b/board/logicpd/am3517evm/am3517evm.env
deleted file mode 100644
index 77bb31c4168..00000000000
--- a/board/logicpd/am3517evm/am3517evm.env
+++ /dev/null
@@ -1,20 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-
-console=ttyS2,115200n8
-fdtfile=am3517-evm.dtb
-fdtaddr=0x82C00000
-vram=16M
-bootenv=uEnv.txt
-mmcdev=0
-mmcpart=1
-mmcroot=/dev/mmcblk0p2 rw
-mmcrootfstype=ext4 rootwait fixrtc
-mmcargs=setenv bootargs console=${console} ${mtdparts} ${optargs} root=${mmcroot} rootfstype=${mmcrootfstype} ${cmdline}
-nandargs=setenv bootargs console=${console} ${mtdparts} ${optargs} root=ubi0:rootfs rw ubi.mtd=rootfs rootfstype=ubifs rootwait ${cmdline}
-loadbootenv=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${bootenv}
-importbootenv=echo "Importing environment from mmc ..."; env import -t ${loadaddr} ${filesize}
-bootscript=echo "Running bootscript from mmc ..."; source ${loadaddr}
-loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${bootfile}
-loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdtaddr} ${fdtfile}
-mmcboot=echo "Booting from mmc ..."; run mmcargs; bootz ${loadaddr} - ${fdtaddr}
-nandboot=echo "Booting from nand ..."; run nandargs; nand read ${loadaddr} 2a0000 800000; nand read ${fdtaddr} aa0000 80000; bootm ${loadaddr} - ${fdtaddr}
diff --git a/board/logicpd/am3517evm/am3517evm.h b/board/logicpd/am3517evm/am3517evm.h
deleted file mode 100644
index 283b4535a6b..00000000000
--- a/board/logicpd/am3517evm/am3517evm.h
+++ /dev/null
@@ -1,194 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * am3517evm.h - Header file for the AM3517 EVM.
- *
- * Author: Vaibhav Hiremath <hvaibhav@ti.com>
- *
- * Based on ti/evm/evm.h
- *
- * Copyright (C) 2010
- * Texas Instruments Incorporated - https://www.ti.com/
- */
-
-#ifndef _AM3517EVM_H_
-#define _AM3517EVM_H_
-
-const omap3_sysinfo sysinfo = {
-	DDR_DISCRETE,
-	"AM3517EVM Board",
-	"NAND",
-};
-
-/*
- * IEN  - Input Enable
- * IDIS - Input Disable
- * PTD  - Pull type Down
- * PTU  - Pull type Up
- * DIS  - Pull type selection is inactive
- * EN   - Pull type selection is active
- * M0   - Mode 0
- * The commented string gives the final mux configuration for that pin
- */
-#define MUX_AM3517EVM() \
-	/* SDRC */\
-	MUX_VAL(CP(SDRC_D0),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(SDRC_D1),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(SDRC_D2),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(SDRC_D3),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(SDRC_D4),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(SDRC_D5),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(SDRC_D6),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(SDRC_D7),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(SDRC_D8),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(SDRC_D9),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(SDRC_D10),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(SDRC_D11),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(SDRC_D12),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(SDRC_D13),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(SDRC_D14),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(SDRC_D15),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(SDRC_D16),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(SDRC_D17),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(SDRC_D18),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(SDRC_D19),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(SDRC_D20),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(SDRC_D21),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(SDRC_D22),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(SDRC_D23),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(SDRC_D24),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(SDRC_D25),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(SDRC_D26),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(SDRC_D27),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(SDRC_D28),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(SDRC_D29),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(SDRC_D30),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(SDRC_D31),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(SDRC_CLK),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(SDRC_DQS0),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(SDRC_DQS1),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(SDRC_DQS2),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(SDRC_DQS3),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(SDRC_DQS0N),		(IEN  | PTD | EN  | M0)) \
-	MUX_VAL(CP(SDRC_DQS1N),		(IEN  | PTD | EN  | M0)) \
-	MUX_VAL(CP(SDRC_DQS2N),		(IEN  | PTD | EN  | M0)) \
-	MUX_VAL(CP(SDRC_DQS3N),		(IEN  | PTD | EN  | M0)) \
-	MUX_VAL(CP(SDRC_CKE0),		(M0)) \
-	MUX_VAL(CP(SDRC_CKE1),		(M0)) \
-	/*sdrc_strben_dly0*/\
-	MUX_VAL(CP(STRBEN_DLY0),	(IEN  | PTD | EN  | M0)) \
-	 /*sdrc_strben_dly1*/\
-	MUX_VAL(CP(STRBEN_DLY1),	(IEN  | PTD | EN  | M0)) \
-	/* GPMC */\
-	MUX_VAL(CP(GPMC_A1),		(IDIS | PTU | EN  | M0)) \
-	MUX_VAL(CP(GPMC_A2),		(IDIS | PTU | EN  | M0)) \
-	MUX_VAL(CP(GPMC_A3),		(IDIS | PTU | EN  | M0)) \
-	MUX_VAL(CP(GPMC_A4),		(IDIS | PTU | EN  | M0)) \
-	MUX_VAL(CP(GPMC_A5),		(IDIS | PTU | EN  | M0)) \
-	MUX_VAL(CP(GPMC_A6),		(IDIS | PTU | EN  | M0)) \
-	MUX_VAL(CP(GPMC_A7),		(IDIS | PTU | EN  | M0)) \
-	MUX_VAL(CP(GPMC_A8),		(IDIS | PTU | EN  | M0)) \
-	MUX_VAL(CP(GPMC_A9),		(IDIS | PTU | EN  | M0)) \
-	MUX_VAL(CP(GPMC_A10),		(IDIS | PTU | EN  | M0)) \
-	MUX_VAL(CP(GPMC_D0),		(IEN  | PTU | EN  | M0)) \
-	MUX_VAL(CP(GPMC_D1),		(IEN  | PTU | EN  | M0)) \
-	MUX_VAL(CP(GPMC_D2),		(IEN  | PTU | EN  | M0)) \
-	MUX_VAL(CP(GPMC_D3),		(IEN  | PTU | EN  | M0)) \
-	MUX_VAL(CP(GPMC_D4),		(IEN  | PTU | EN  | M0)) \
-	MUX_VAL(CP(GPMC_D5),		(IEN  | PTU | EN  | M0)) \
-	MUX_VAL(CP(GPMC_D6),		(IEN  | PTU | EN  | M0)) \
-	MUX_VAL(CP(GPMC_D7),		(IEN  | PTU | EN  | M0)) \
-	MUX_VAL(CP(GPMC_D8),		(IEN  | PTU | EN  | M0)) \
-	MUX_VAL(CP(GPMC_D9),		(IEN  | PTU | EN  | M0)) \
-	MUX_VAL(CP(GPMC_D10),		(IEN  | PTU | EN  | M0)) \
-	MUX_VAL(CP(GPMC_D11),		(IEN  | PTU | EN  | M0)) \
-	MUX_VAL(CP(GPMC_D12),		(IEN  | PTU | EN  | M0)) \
-	MUX_VAL(CP(GPMC_D13),		(IEN  | PTU | EN  | M0)) \
-	MUX_VAL(CP(GPMC_D14),		(IEN  | PTU | EN  | M0)) \
-	MUX_VAL(CP(GPMC_D15),		(IEN  | PTU | EN  | M0)) \
-	MUX_VAL(CP(GPMC_NCS0),		(IDIS | PTU | EN  | M0)) \
-	MUX_VAL(CP(GPMC_NCS1),		(IDIS | PTU | EN  | M0)) \
-	MUX_VAL(CP(GPMC_NCS2),		(IDIS | PTU | EN  | M0)) \
-	MUX_VAL(CP(GPMC_NCS3),		(IDIS | PTU | EN  | M0)) \
-	MUX_VAL(CP(GPMC_NCS4),		(IEN  | PTU | EN  | M0)) \
-	MUX_VAL(CP(GPMC_NCS5),		(IDIS | PTU | EN  | M0)) \
-	MUX_VAL(CP(GPMC_NCS6),		(IDIS | PTD | DIS | M4)) \
-	MUX_VAL(CP(GPMC_NCS7),		(IEN  | PTU | EN  | M0)) \
-	MUX_VAL(CP(GPMC_CLK),		(IDIS | PTU | EN  | M0)) \
-	MUX_VAL(CP(GPMC_NADV_ALE),	(IDIS | PTD | DIS | M0)) \
-	MUX_VAL(CP(GPMC_NOE),		(IDIS | PTD | DIS | M0)) \
-	MUX_VAL(CP(GPMC_NWE),		(IDIS | PTD | DIS | M0)) \
-	MUX_VAL(CP(GPMC_NBE0_CLE),	(IDIS | PTU | EN  | M0)) \
-	MUX_VAL(CP(GPMC_NBE1),		(IEN  | PTU | EN  | M0)) \
-	MUX_VAL(CP(GPMC_NWP),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(GPMC_WAIT0),		(IEN  | PTU | EN  | M0)) \
-	MUX_VAL(CP(GPMC_WAIT1),		(IEN  | PTU | EN  | M0)) \
-	MUX_VAL(CP(GPMC_WAIT3),		(IEN  | PTU | EN  | M0)) \
-	/* MMC */\
-	MUX_VAL(CP(MMC1_CLK),		(IEN  | PTU | EN  | M0)) \
-	MUX_VAL(CP(MMC1_CMD),		(IEN  | PTU | DIS | M0)) \
-	MUX_VAL(CP(MMC1_DAT0),		(IEN  | PTU | DIS | M0)) \
-	MUX_VAL(CP(MMC1_DAT1),		(IEN  | PTU | DIS | M0)) \
-	MUX_VAL(CP(MMC1_DAT2),		(IEN  | PTU | DIS | M0)) \
-	MUX_VAL(CP(MMC1_DAT3),		(IEN  | PTU | DIS | M0)) \
-	/* UART */\
-	MUX_VAL(CP(UART3_CTS_RCTX),	(IEN  | PTU | DIS | M0)) \
-	MUX_VAL(CP(UART3_RTS_SD),	(IDIS | PTD | DIS | M0)) \
-	MUX_VAL(CP(UART3_RX_IRRX),	(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(UART3_TX_IRTX),	(IDIS | PTD | DIS | M0)) \
-	/* Control and debug */\
-	MUX_VAL(CP(SYS_32K),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(SYS_CLKREQ),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(SYS_NIRQ),		(IEN  | PTU | EN  | M0)) \
-	MUX_VAL(CP(SYS_BOOT7),		(IEN  | PTD | EN  | M0)) \
-	MUX_VAL(CP(SYS_BOOT8),		(IEN  | PTD | EN  | M0)) \
-	\
-	MUX_VAL(CP(SYS_OFF_MODE),	(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(SYS_CLKOUT1),	(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(SYS_CLKOUT2),	(IEN  | PTU | EN  | M0)) \
-	/* JTAG */\
-	MUX_VAL(CP(JTAG_NTRST),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(JTAG_TCK),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(JTAG_TMS),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(JTAG_TDI),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(JTAG_EMU0),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(JTAG_EMU1),		(IEN  | PTD | DIS | M0)) \
-	/* ETK (ES2 onwards) */\
-	MUX_VAL(CP(ETK_D10_ES2),	(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(ETK_D11_ES2),	(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(ETK_D12_ES2),	(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(ETK_D13_ES2),	(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(ETK_D14_ES2),	(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(ETK_D15_ES2),	(IEN  | PTD | DIS | M0)) \
-	/* Die to Die */\
-	MUX_VAL(CP(D2D_MCAD34),		(IEN  | PTD | EN  | M0)) \
-	MUX_VAL(CP(D2D_MCAD35),		(IEN  | PTD | EN  | M0)) \
-	MUX_VAL(CP(D2D_MCAD36),		(IEN  | PTD | EN  | M0)) \
-	MUX_VAL(CP(D2D_CLK26MI),	(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(D2D_NRESPWRON),	(IEN  | PTD | EN  | M0)) \
-	MUX_VAL(CP(D2D_NRESWARM),	(IEN  | PTU | EN  | M0)) \
-	MUX_VAL(CP(D2D_ARM9NIRQ),	(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(D2D_UMA2P6FIQ),	(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(D2D_SPINT),		(IEN  | PTD | EN  | M0)) \
-	MUX_VAL(CP(D2D_FRINT),		(IEN  | PTD | EN  | M0)) \
-	MUX_VAL(CP(D2D_DMAREQ0),	(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(D2D_DMAREQ1),	(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(D2D_DMAREQ2),	(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(D2D_DMAREQ3),	(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(D2D_N3GTRST),	(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(D2D_N3GTDI),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(D2D_N3GTDO),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(D2D_N3GTMS),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(D2D_N3GTCK),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(D2D_N3GRTCK),	(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(D2D_MSTDBY),		(IEN  | PTU | EN  | M0)) \
-	MUX_VAL(CP(D2D_SWAKEUP),	(IEN  | PTD | EN  | M0)) \
-	MUX_VAL(CP(D2D_IDLEREQ),	(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(D2D_IDLEACK),	(IEN  | PTU | EN  | M0)) \
-	MUX_VAL(CP(D2D_MWRITE),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(D2D_SWRITE),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(D2D_MREAD),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(D2D_SREAD),		(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(D2D_MBUSFLAG),	(IEN  | PTD | DIS | M0)) \
-	MUX_VAL(CP(D2D_SBUSFLAG),	(IEN  | PTD | DIS | M0)) \
-
-#endif
diff --git a/configs/am3517_evm_defconfig b/configs/am3517_evm_defconfig
deleted file mode 100644
index 39800366599..00000000000
--- a/configs/am3517_evm_defconfig
+++ /dev/null
@@ -1,96 +0,0 @@
-CONFIG_ARM=y
-# CONFIG_SPL_USE_ARCH_MEMCPY is not set
-# CONFIG_SPL_USE_ARCH_MEMSET is not set
-CONFIG_ARCH_OMAP2PLUS=y
-CONFIG_TEXT_BASE=0x80100000
-CONFIG_SYS_MALLOC_F_LEN=0x4000
-CONFIG_TI_COMMON_CMD_OPTIONS=y
-CONFIG_ENV_SOURCE_FILE="am3517evm"
-CONFIG_DEFAULT_DEVICE_TREE="ti/omap/am3517-evm"
-CONFIG_TARGET_AM3517_EVM=y
-CONFIG_EMIF4=y
-CONFIG_SPL_SYS_MALLOC_F_LEN=0x2500
-CONFIG_SPL=y
-CONFIG_LTO=y
-# CONFIG_EFI_LOADER is not set
-CONFIG_DISTRO_DEFAULTS=y
-CONFIG_BOOTDELAY=10
-CONFIG_BOOTCOMMAND="mmc dev ${mmcdev}; if mmc rescan; then echo SD/MMC found on device $mmcdev; if run loadbootenv; then run importbootenv; fi; echo Checking if uenvcmd is set ...; if test -n $uenvcmd; then echo Running uenvcmd ...; run uenvcmd; fi; echo Running default loadimage ...; setenv bootfile zImage; if run loadimage; then run loadfdt; run mmcboot; fi; else run nandboot; fi"
-CONFIG_SYS_PBSIZE=1054
-CONFIG_SPL_SYS_MALLOC_SIMPLE=y
-CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
-# CONFIG_SPL_FS_EXT4 is not set
-# CONFIG_SPL_I2C is not set
-CONFIG_SPL_MTD=y
-CONFIG_SPL_NAND_DRIVERS=y
-CONFIG_SPL_NAND_ECC=y
-CONFIG_SPL_NAND_SIMPLE=y
-CONFIG_SPL_NAND_BASE=y
-CONFIG_SPL_OS_BOOT=y
-CONFIG_SPL_PAYLOAD_ARGS_ADDR=0x84000000
-CONFIG_SYS_NAND_SPL_KERNEL_OFFS=0x2a0000
-CONFIG_SPL_FALCON_BOOT_MMCSD=y
-CONFIG_SYS_MMCSD_RAW_MODE_KERNEL_SECTOR=0x1700
-CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTOR=0x1500
-CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTORS=0x200
-# CONFIG_SPL_POWER is not set
-CONFIG_SYS_PROMPT="AM3517_EVM # "
-# CONFIG_CMD_IMI is not set
-CONFIG_CMD_SPL_NAND_OFS=0xaa0000
-CONFIG_CMD_SPL_WRITE_SIZE=0x20000
-# CONFIG_CMD_GPT is not set
-CONFIG_CMD_NAND=y
-# CONFIG_CMD_SPI is not set
-# CONFIG_CMD_SETEXPR is not set
-CONFIG_BOOTP_DNS2=y
-# CONFIG_CMD_TIME is not set
-CONFIG_CMD_MTDPARTS=y
-CONFIG_MTDIDS_DEFAULT="nand0=omap2-nand.0"
-CONFIG_MTDPARTS_DEFAULT="mtdparts=omap2-nand.0:512k(MLO),1920k(u-boot),256k(u-boot-env),8m(kernel),512k(dtb),-(rootfs)"
-CONFIG_CMD_UBI=y
-CONFIG_OF_CONTROL=y
-CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_UPSTREAM=y
-CONFIG_ENV_OVERWRITE=y
-# CONFIG_ENV_IS_IN_FAT is not set
-CONFIG_ENV_IS_IN_NAND=y
-CONFIG_USE_BOOTFILE=y
-CONFIG_BOOTFILE="uImage"
-CONFIG_VERSION_VARIABLE=y
-CONFIG_NET_RETRY_COUNT=10
-CONFIG_BOOTP_SEND_HOSTNAME=y
-CONFIG_SPL_DM=y
-CONFIG_DM_PCA953X=y
-CONFIG_MMC_OMAP_HS=y
-CONFIG_MTD=y
-CONFIG_MTD_RAW_NAND=y
-CONFIG_NAND_OMAP_ECCSCHEME_BCH8_CODE_HW_DETECTION_SW=y
-CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
-CONFIG_SYS_NAND_PAGE_SIZE=0x800
-CONFIG_SYS_NAND_OOBSIZE=0x40
-CONFIG_SYS_NAND_BUSWIDTH_16BIT=y
-CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
-CONFIG_SYS_NAND_U_BOOT_OFFS=0x80000
-CONFIG_SYS_NAND_MAX_OOBFREE=2
-CONFIG_SYS_NAND_MAX_ECCPOS=56
-CONFIG_MII=y
-CONFIG_DRIVER_TI_EMAC=y
-CONFIG_DRIVER_TI_EMAC_USE_RMII=y
-CONFIG_PINCTRL=y
-CONFIG_PINCTRL_SINGLE=y
-CONFIG_DM_PMIC=y
-# CONFIG_SPL_PMIC_CHILDREN is not set
-CONFIG_DM_REGULATOR=y
-CONFIG_DM_REGULATOR_FIXED=y
-CONFIG_DM_REGULATOR_GPIO=y
-# CONFIG_TWL4030_POWER is not set
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_OMAP3_SPI=y
-CONFIG_USB=y
-CONFIG_USB_EHCI_HCD=y
-CONFIG_USB_MUSB_HOST=y
-CONFIG_USB_MUSB_AM35X=y
-CONFIG_BCH=y
-CONFIG_SPL_TINY_MEMSET=y
diff --git a/include/configs/am3517_evm.h b/include/configs/am3517_evm.h
deleted file mode 100644
index e3432ebeaab..00000000000
--- a/include/configs/am3517_evm.h
+++ /dev/null
@@ -1,42 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * am3517_evm.h - Default configuration for AM3517 EVM board.
- *
- * Author: Vaibhav Hiremath <hvaibhav@ti.com>
- *
- * Based on omap3_evm_config.h
- *
- * Copyright (C) 2010 Texas Instruments Incorporated
- */
-
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-#include <configs/ti_omap3_common.h>
-
-/* Board NAND Info. */
-#if defined(CONFIG_MTD_RAW_NAND)
-#define CFG_SYS_NAND_ECCPOS		{ 2,  3,  4,  5,  6,  7,  8,  9, 10, \
-					 11, 12, 13, 14, 16, 17, 18, 19, 20, \
-					 21, 22, 23, 24, 25, 26, 27, 28, 30, \
-					 31, 32, 33, 34, 35, 36, 37, 38, 39, \
-					 40, 41, 42, 44, 45, 46, 47, 48, 49, \
-					 50, 51, 52, 53, 54, 55, 56 }
-
-#define CFG_SYS_NAND_ECCSIZE		512
-#define CFG_SYS_NAND_ECCBYTES	13
-#define CFG_SYS_NAND_U_BOOT_START	CONFIG_TEXT_BASE
-/* NAND block size is 128 KiB.  Synchronize these values with
- * corresponding Device Tree entries in Linux:
- *  MLO(SPL)             4 * NAND_BLOCK_SIZE = 512 KiB  @ 0x000000
- *  U-Boot              15 * NAND_BLOCK_SIZE = 1920 KiB @ 0x080000
- *  U-Boot environment   2 * NAND_BLOCK_SIZE = 256 KiB  @ 0x260000
- *  Kernel              64 * NAND_BLOCK_SIZE = 8 MiB    @ 0x2A0000
- *  DTB                  4 * NAND_BLOCK_SIZE = 512 KiB  @ 0xAA0000
- *  RootFS              Remaining Flash Space           @ 0xB20000
- */
-
-#define CFG_SYS_FLASH_BASE		NAND_BASE
-#endif /* CONFIG_MTD_RAW_NAND */
-
-#endif /* __CONFIG_H */
-- 
2.53.0

