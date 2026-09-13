Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24323C88E5C
	for <u-boot@archiver.kernel.org>; Sun, 13 Sep 2026 23:20:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A3C9680CEC;
	Sun, 13 Sep 2026 23:20:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BRhr6F1LssoA; Sun, 13 Sep 2026 23:20:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0FF0280CC3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789341606;
	b=OgwyUCGFYk40tXHCmyvkDIYJVw03lNS4RBURIeMHHplG6Ryp/o+MfThN2A48IFclasul
	 vYR5vSTk3Q1X5IiJ1EyNLG+oRJ7Ckv2g4cBMqRbp9wwmB0W40pSEuzV+aZN96SIXK4U+V
	 NFTrL/XqlEVPImYJMWg2bdzdY1euFEGg7LXHqUYMSCKoLPu/ZOpOF7viVlk/NZyNDGnIV
	 B86y5KdEXZyoIs1nhgXP4AF74+QvlG/XtvSXpUqk4SVFovd9TNK6Q8SUuGftbjJpIQaaU
	 TwfnIq0AabDIXLKgBQFTASsM6vyfk43uKoCya0zr+zXG3YZe3mSgMczRhUSt6CYWkBA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789341606;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=iAy27cAVJbwmBVsGG67PzmxCfkT5Ut2XxJrLPYK48Mo=;
	b=iQvc/FH/3bq0Ic+mr3xJGKF1QrR1NAHYbAsheV7HTWhQGl2uyk/BQMBWUCwKlOqrNZiM
	 2+rIuGUreOOjZDmqnOC/oX7vK3cjmhos+BiHmXXvCc4nTxz7PgF4Zx1JM0s4SEcdIgUa4
	 QSUkbHNx17XA91bz5l69b9smD2zNDuogrSwdnGNvDOTpCVDTdxcvzFyQVWLu+vwa+ieKj
	 nCKUF5Usj/vgLEM9pLNgk9p8F7p8oo/CyNveXXHRcv4yLTImjK7biuW9nfZp5iiWzPKBj
	 03uxJQkNyUlI+4Rm81dZ4dlvXcNM6yaaR42rQDZt8LX1T1x4E07j2dvl3S1Zv/IdUrQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789341606;
	bh=iAy27cAVJbwmBVsGG67PzmxCfkT5Ut2XxJrLPYK48Mo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=htDY4TzvxmIODjycF8T7z0k7ukZU4zqdbVZ1eWav36VF9GifSqWwJpy+bqvduvLj3
	 cXml9/o+8KneRvBHYtVojGsS1r8feUxquiSD58DOvCybgEuJGHW/+Yv7PvyvWSPjYn
	 pnywc9ZW8sMcpCGqHUDXviPdH+si3kYFb9lmP5GX7Zw4xXR88SGYfRg5v+12YenQe9
	 YJbPtxs/TqVZBuz1dsBCHwyVXSpWjAXD/u9Xi1qImvjlTcZo+0gDQ7K9WzedisuLE3
	 BhlDEIEYhflO82mRllmYhruNth93GiW04k4oSoJ0q32SXPpJeRJKIB5popVKb5VnqL
	 z0rK/4Bbg4MGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0FF0280CC3;
	Sun, 13 Sep 2026 23:20:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1BFF724D
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 15:52:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0D9F940022
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 15:52:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eKedX7e3a2rp for <u-boot@lists.u-boot-project.org>;
 Sun, 13 Sep 2026 15:52:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org EF0C140076
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:33::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789314733;
 b=dyqdIx+f/izgQNlWo57R5N7fru239l4yWJOxwqqmBn7Tj0faWAp3LFdakU07DX7sSv3F
 6bzP6B8LuUwNPa3cxtGfks/wpWXQJcJF0EgKhQra0tjS4NY6rtePSAuMszb+kwaeqV+BU
 H50m3ZPXX+ZiweY5FDR0Qz/Xzmdq8ZrptGg6EsUW1A+NnbysV1ld2ab2IT/oeTyYPv/7H
 A/7tmOF0k/6CAxn06LWaCQ6MV+X2YVv8U3jAuXvb/jR/G7rEzyCd4D3KTw6jKIvnCho0J
 146YDoGEHKeYBPEi2h7swt1zqhzZxPC7BgDEkK36w2MtIy3nfLjAknFgIEvZmOjejlA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789314733;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=iAy27cAVJbwmBVsGG67PzmxCfkT5Ut2XxJrLPYK48Mo=;
 b=Ujy39BLHIrYuUwWvaE/xJ8sBfwoNwR2YcYv0/7huJATh4WpP+rItOJnDCutxGaYB+cuM
 nELLOW8c7p4xJxtoJX4lYjWLiViwEzaBNcdVtji7H93z0UCuvHGjrX9lE9z9lCuoCsRxh
 LJABHoSUalgcGwdnYFlLuDOdLmhJWWVOrPkPPpKiN6CdqpElYsVHXVG7yV0g0ldELriMo
 nEQ4RJSq2r3kShmM43YGwIHhgg0Baq8PiRZlcHciNEBDvOFKBUtB8oR3RhIcLDogDHm3h
 Ppbg2JFbE4uT5aKUSQQqnty8+NoRF0y5uJzPyIBucqvSmCUB0tDgmmwEo1mPRfx37tQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ahlYBGus; 
 arc=none smtp.remote-ip="2607:f8b0:4864:33::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:33::10; helo=mail-qv2-x10.google.com;
 envelope-from=aford173@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ahlYBGus
Received: from mail-qv2-x10.google.com (mail-qv2-x10.google.com
 [IPv6:2607:f8b0:4864:33::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EF0C140076
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 15:52:12 +0000 (UTC)
Received: by mail-qv2-x10.google.com with SMTP id
 6a1803df08f44-90cdfc9b6e3so20751686d6.1
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 08:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789314731; x=1789919531;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iAy27cAVJbwmBVsGG67PzmxCfkT5Ut2XxJrLPYK48Mo=;
 b=ahlYBGus+3d2rVuePbKXbudU8anOoP9FT8dfPL3tkdM22MpWsTjrgRbdmvnV8pbPnu
 vDEAV+HlHaGWVqPOf7CvMtUI9HkN15cO/GQ+y5V7ZI/xPYh9FpfCo0L7kTqgiVwHAbIh
 opv5i/bsGbI4uKzf91FgweEWhZ8Y0UawcK68/fDDNQdKqeAprLALsXuSHFNBS5UWawjz
 9OX8erwrz16V9XRfWw+AnIYIriYYxYPA+5v8pvls0kX6BU+gqBbgu3c3xO8LmswAVPj9
 C/vcLmpy/90L58umkPQYvSxZuUiclJm4vPWkgbgq0mT3AVUPEzYdxdY/XWtBnPMmmLaa
 WmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789314731; x=1789919531;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iAy27cAVJbwmBVsGG67PzmxCfkT5Ut2XxJrLPYK48Mo=;
 b=JSRkqh5CcHF5sp0LK2JVVKbbphH+0IENIlEeGusfB4416z8CJDlP8v1vuHFIgQpS/+
 xLyLfpqIiiLxNUUPccRmDbeXTjM2pbLryc9FV+mdoQt79sN+AxOfNG0jPRp86fpB3VJA
 a9Yxo+/8mHnPnjHjrBg+uAtbw+OKTxm4l4CP/VocbV3oQ82KRObp1qi0DoGQp8vdqMkU
 aNFmt/CelmPQ6AADRJ0AewP65rg91eQJiJQnmSBt5ij+Gg86nFL5ZEIpMFVGJecApXiO
 1MasjzHyAJQPpSKCuKXrI6y+zZ48CE/hq5Dao+oS9bn/84FC8OmyOTbZWQBmzMEL4dUf
 31Hw==
X-Gm-Message-State: AFuF++lZYEQpN5AfmvaGFJH9onNThfHt4AWzGcC1biE0Br1q4YcjtGSV
 uZ+EDpGC94WRX3Q/to5Sxf2QSv8l++q9Yh2Lt6El4Rq0TKQjQ0d7q0gHgDUt9A==
X-Gm-Gg: AYBFou1cw2eUjD69ROXT00HP191s1hDjc65xwrB45IFOM8NB3+nRDBfuu8L614sdscI
 vsdlrarNlP6bpB2cvctg46hjshDx/cQprIKydKpoEir5QxqmwyoJlT5F48gLfloblhmjhbI7T7U
 cgNoRXey+fv/tyCdQ3BxzdflSCbBAaJFcP5YGAV63jGkdztxQpFzpF+25jXnz9A2+dtNAJjvJ06
 GP1EYpmbPnd9mc57Ftznne/g06OB/ukl2XOH60EgqWKbtt6rRWiE/mZZnpV0nSixP0Z2Qs5ejHZ
 vroMnUCPE/iMqiUz1+99GaJtSfvX2PAMvcky1q8kcuH7oXVMjgRfxmZN/JieXhQrh8oB1o/sVfy
 4vNA4tVI5xWq99v1BASfFERLD2UFo+u84OTHC4Gth3iAJ5AKbbLARM4EX74QemicEqxtBcfMYGM
 jpzkyzIiR61YC+vfWq+Bfnszg7HFQNRt0iKeefjbLBN9hiBHbi85p8rhLJV/arOepDYlnK9Y69j
 iXVN8UqrtHvY+GFpB05C696XJ2BjUemBZS+KwwJgvI63Zr+UVK3CVlo/WXD/k4=
X-Received: by 2002:ad4:5d4d:0:b0:907:64a4:ca00 with SMTP id
 6a1803df08f44-9121209aabamr230180466d6.10.1789314730589; 
 Sun, 13 Sep 2026 08:52:10 -0700 (PDT)
Received: from aford-System-Version.lan (c-73-94-212-116.hsd1.mn.comcast.net.
 [73.94.212.116]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9120f4963fcsm73051386d6.33.2026.09.13.08.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 08:52:09 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Adam Ford <aford173@gmail.com>
Subject: [PATCH] board: logicpd: Remove OMAP3 SOM support
Date: Sun, 13 Sep 2026 10:52:05 -0500
Message-ID: <20260913155205.84071-1-aford173@gmail.com>
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

Remove the Logic PD OMAP35xx/DM37xx SOM-LV and Torpedo board support
along with its defconfigs, config header, U-Boot device tree overlays,
Kconfig target and the board specific MMC PBIAS quirk.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 .../logicpd-som-lv-35xx-devkit-u-boot.dtsi    |  72 ------
 .../logicpd-som-lv-37xx-devkit-u-boot.dtsi    |  72 ------
 .../logicpd-torpedo-35xx-devkit-u-boot.dtsi   |  71 ------
 .../logicpd-torpedo-37xx-devkit-u-boot.dtsi   |  68 -----
 arch/arm/mach-omap2/omap3/Kconfig             |  13 -
 board/logicpd/omap3som/Kconfig                |  14 -
 board/logicpd/omap3som/MAINTAINERS            |   9 -
 board/logicpd/omap3som/Makefile               |   6 -
 board/logicpd/omap3som/README                 |  56 ----
 board/logicpd/omap3som/omap3logic.c           | 240 ------------------
 board/logicpd/omap3som/omap3logic.h           | 237 -----------------
 configs/omap35_logic_defconfig                |  94 -------
 configs/omap35_logic_somlv_defconfig          | 103 --------
 configs/omap3_logic_defconfig                 |  93 -------
 configs/omap3_logic_somlv_defconfig           | 104 --------
 drivers/mmc/omap_hsmmc.c                      |   4 -
 include/configs/omap3_logic.h                 | 152 -----------
 17 files changed, 1408 deletions(-)
 delete mode 100644 arch/arm/dts/logicpd-som-lv-35xx-devkit-u-boot.dtsi
 delete mode 100644 arch/arm/dts/logicpd-som-lv-37xx-devkit-u-boot.dtsi
 delete mode 100644 arch/arm/dts/logicpd-torpedo-35xx-devkit-u-boot.dtsi
 delete mode 100644 arch/arm/dts/logicpd-torpedo-37xx-devkit-u-boot.dtsi
 delete mode 100644 board/logicpd/omap3som/Kconfig
 delete mode 100644 board/logicpd/omap3som/MAINTAINERS
 delete mode 100644 board/logicpd/omap3som/Makefile
 delete mode 100644 board/logicpd/omap3som/README
 delete mode 100644 board/logicpd/omap3som/omap3logic.c
 delete mode 100644 board/logicpd/omap3som/omap3logic.h
 delete mode 100644 configs/omap35_logic_defconfig
 delete mode 100644 configs/omap35_logic_somlv_defconfig
 delete mode 100644 configs/omap3_logic_defconfig
 delete mode 100644 configs/omap3_logic_somlv_defconfig
 delete mode 100644 include/configs/omap3_logic.h

diff --git a/arch/arm/dts/logicpd-som-lv-35xx-devkit-u-boot.dtsi b/arch/arm/dts/logicpd-som-lv-35xx-devkit-u-boot.dtsi
deleted file mode 100644
index d77fa38746f..00000000000
--- a/arch/arm/dts/logicpd-som-lv-35xx-devkit-u-boot.dtsi
+++ /dev/null
@@ -1,72 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2017
- * Logic PD - http://www.logicpd.com
- */
-
-#include "omap3-u-boot.dtsi"
-
-/ {
-	chosen {
-		stdout-path = &uart1;
-	};
-
-	aliases {
-		/delete-property/ serial1;
-		/delete-property/ serial2;
-		/delete-property/ mmc1;
-		/delete-property/ mmc2;
-	};
-
-	ethernet@08000000 {
-		compatible = "smsc,lan9221","smsc,lan9115";
-		reg = <0x08000000 0xff>;
-		bank-width = <2>;
-		vddvario-supply = <&vddvario>;
-		vdd33a-supply = <&vdd33a>;
-		reg-io-width = <4>;
-		smsc,save-mac-address;
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
-&gpio4 {
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
-&i2c1 {
-	clock-frequency = <400000>;
-	/delete-property/ bootph-pre-ram;
-};
-
-&i2c2 {
-	clock-frequency = <400000>;
-	/delete-property/ bootph-pre-ram;
-};
-
-/delete-node/ &bandgap;
-/delete-node/ &uart2;
-/delete-node/ &uart3;
-/delete-node/ &mmc2;
-/delete-node/ &mmc3;
-/delete-node/ &thermal_zones;
-
diff --git a/arch/arm/dts/logicpd-som-lv-37xx-devkit-u-boot.dtsi b/arch/arm/dts/logicpd-som-lv-37xx-devkit-u-boot.dtsi
deleted file mode 100644
index d77fa38746f..00000000000
--- a/arch/arm/dts/logicpd-som-lv-37xx-devkit-u-boot.dtsi
+++ /dev/null
@@ -1,72 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2017
- * Logic PD - http://www.logicpd.com
- */
-
-#include "omap3-u-boot.dtsi"
-
-/ {
-	chosen {
-		stdout-path = &uart1;
-	};
-
-	aliases {
-		/delete-property/ serial1;
-		/delete-property/ serial2;
-		/delete-property/ mmc1;
-		/delete-property/ mmc2;
-	};
-
-	ethernet@08000000 {
-		compatible = "smsc,lan9221","smsc,lan9115";
-		reg = <0x08000000 0xff>;
-		bank-width = <2>;
-		vddvario-supply = <&vddvario>;
-		vdd33a-supply = <&vdd33a>;
-		reg-io-width = <4>;
-		smsc,save-mac-address;
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
-&gpio4 {
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
-&i2c1 {
-	clock-frequency = <400000>;
-	/delete-property/ bootph-pre-ram;
-};
-
-&i2c2 {
-	clock-frequency = <400000>;
-	/delete-property/ bootph-pre-ram;
-};
-
-/delete-node/ &bandgap;
-/delete-node/ &uart2;
-/delete-node/ &uart3;
-/delete-node/ &mmc2;
-/delete-node/ &mmc3;
-/delete-node/ &thermal_zones;
-
diff --git a/arch/arm/dts/logicpd-torpedo-35xx-devkit-u-boot.dtsi b/arch/arm/dts/logicpd-torpedo-35xx-devkit-u-boot.dtsi
deleted file mode 100644
index d14d68e458a..00000000000
--- a/arch/arm/dts/logicpd-torpedo-35xx-devkit-u-boot.dtsi
+++ /dev/null
@@ -1,71 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2017
- * Logic PD - http://www.logicpd.com
- */
-
-#include "omap3-u-boot.dtsi"
-
-/ {
-	chosen {
-		stdout-path = &uart1;
-	};
-
-	aliases {
-		/delete-property/ serial1;
-		/delete-property/ serial2;
-		/delete-property/ mmc1;
-		/delete-property/ mmc2;
-	};
-
-	ethernet@08000000 {
-		compatible = "smsc,lan9221","smsc,lan9115";
-		reg = <0x08000000 0xff>;
-		bank-width = <2>;
-		vddvario-supply = <&vddvario>;
-		vdd33a-supply = <&vdd33a>;
-		reg-io-width = <4>;
-		smsc,save-mac-address;
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
-&gpio4 {
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
-&i2c1 {
-	clock-frequency = <400000>;
-	/delete-property/ bootph-pre-ram;
-};
-
-&i2c2 {
-	clock-frequency = <400000>;
-	/delete-property/ bootph-pre-ram;
-};
-
-/delete-node/ &bandgap;
-/delete-node/ &uart2;
-/delete-node/ &uart3;
-/delete-node/ &mmc2;
-/delete-node/ &mmc3;
-/delete-node/ &thermal_zones;
diff --git a/arch/arm/dts/logicpd-torpedo-37xx-devkit-u-boot.dtsi b/arch/arm/dts/logicpd-torpedo-37xx-devkit-u-boot.dtsi
deleted file mode 100644
index 8e8e2e4096f..00000000000
--- a/arch/arm/dts/logicpd-torpedo-37xx-devkit-u-boot.dtsi
+++ /dev/null
@@ -1,68 +0,0 @@
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
-		/delete-property/ serial1;
-		/delete-property/ serial2;
-		/delete-property/ mmc1;
-		/delete-property/ mmc2;
-	};
-
-	ethernet@08000000 {
-		compatible = "smsc,lan9221","smsc,lan9115";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x08000000 0xff>;
-		bank-width = <2>;
-		vddvario-supply = <&vddvario>;
-		vdd33a-supply = <&vdd33a>;
-		reg-io-width = <4>;
-		smsc,save-mac-address;
-	};
-};
-
-&i2c1 {
-	clock-frequency = <400000>;
-	/delete-property/ bootph-pre-ram;
-};
-
-&i2c2 {
-	clock-frequency = <400000>;
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
-&gpio4 {
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
-/delete-node/ &bandgap;
-/delete-node/ &uart2;
-/delete-node/ &uart3;
-/delete-node/ &mmc2;
-/delete-node/ &mmc3;
-/delete-node/ &thermal_zones;
diff --git a/arch/arm/mach-omap2/omap3/Kconfig b/arch/arm/mach-omap2/omap3/Kconfig
index 79e24acba8d..61e1c1a2854 100644
--- a/arch/arm/mach-omap2/omap3/Kconfig
+++ b/arch/arm/mach-omap2/omap3/Kconfig
@@ -70,18 +70,6 @@ config TARGET_OMAP3_PANDORA
 	select OMAP3_GPIO_4
 	select OMAP3_GPIO_6
 
-config TARGET_OMAP3_LOGIC
-	bool "OMAP3 Logic"
-	select BOARD_LATE_INIT
-	select DM
-	select DM_GPIO
-	select DM_SERIAL
-	select OMAP3_GPIO_3
-	select OMAP3_GPIO_4
-	select OMAP3_GPIO_6
-	imply CMD_DM
-	imply VIDEO_DAMAGE
-
 config TARGET_TAO3530
 	bool "TAO3530"
 	select OMAP3_GPIO_2
@@ -132,7 +120,6 @@ config SYS_SOC
 source "board/timll/devkit8000/Kconfig"
 source "board/ti/omap3evm/Kconfig"
 source "board/isee/igep00x0/Kconfig"
-source "board/logicpd/omap3som/Kconfig"
 source "board/lg/sniper/Kconfig"
 
 endif
diff --git a/board/logicpd/omap3som/Kconfig b/board/logicpd/omap3som/Kconfig
deleted file mode 100644
index 68d40dcd62d..00000000000
--- a/board/logicpd/omap3som/Kconfig
+++ /dev/null
@@ -1,14 +0,0 @@
-if TARGET_OMAP3_LOGIC
-
-config SYS_BOARD
-	default "omap3som"
-
-config SYS_VENDOR
-	default "logicpd"
-
-config SYS_CONFIG_NAME
-	default "omap3_logic"
-
-source "board/ti/common/Kconfig"
-
-endif
diff --git a/board/logicpd/omap3som/MAINTAINERS b/board/logicpd/omap3som/MAINTAINERS
deleted file mode 100644
index 459393cf54c..00000000000
--- a/board/logicpd/omap3som/MAINTAINERS
+++ /dev/null
@@ -1,9 +0,0 @@
-OMAP3SOM BOARD
-M:	Adam Ford <aford173@gmail.com>
-S:	Maintained
-F:	board/logicpd/omap3som/
-F:	include/configs/omap3_logic.h
-F:	configs/omap3_logic_defconfig
-F:	configs/omap35_logic_defconfig
-F:	configs/omap35_logic_somlv_defconfig
-F:	configs/omap3_logic_somlv_defconfig
diff --git a/board/logicpd/omap3som/Makefile b/board/logicpd/omap3som/Makefile
deleted file mode 100644
index 61ef14e87a0..00000000000
--- a/board/logicpd/omap3som/Makefile
+++ /dev/null
@@ -1,6 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-#
-# (C) Copyright 2000, 2001, 2002
-# Wolfgang Denk, DENX Software Engineering, wd@denx.de.
-
-obj-y	:= omap3logic.o
diff --git a/board/logicpd/omap3som/README b/board/logicpd/omap3som/README
deleted file mode 100644
index 5aaf58f0a69..00000000000
--- a/board/logicpd/omap3som/README
+++ /dev/null
@@ -1,56 +0,0 @@
-Summary
-=======
-
-The source for omap3logic.c encompases the OMAP35 and DM3730 SOM-LV and DM3730 Torpedo platforms, but there are device trees custom taylored to each board.
-
-omap3_logic_defconfig = DM37 Torpedo / Torpedo + Wireless
-omap35_logic_defconfig = OMAP35 Torpedo
-omap3_logic_somlv_defconfig = DM37 SOM-LV
-omap35_logic_somlv_defconfig = OMAP35 SOM-LV
-
-The device tree included with each of the defconfig files will also direct the board as to which dtb file to load when loading the kernel, so it is not
-recomended to mix and match the defconfig files.
-
-Falcon Mode: FAT SD cards
-=========================
-
-In this case the additional file is written to the filesystem.  In this
-example we assume that the uImage and device tree to be used are already on
-the FAT filesystem (only the uImage MUST be for this to function
-afterwards) along with a Falcon Mode aware MLO and the FAT partition has
-already been created and marked bootable:
-
-U-Boot # mmc rescan
-# Load kernel and device tree into memory, perform export
-U-Boot # fatload mmc 0 ${loadaddr} uImage
-U-Boot # run loadfdt
-U-Boot # setenv optargs quiet
-U-Boot # run mmcargs
-U-Boot # run common_bootargs
-U-Boot # spl export fdt ${loadaddr} - ${fdtaddr}
-
-This will print a number of lines and then end with something like:
-   Loading Device Tree to 8dec9000, end 8dee0295 ... OK
-
-So then note the starting address and write the args to mmc/sd:
-
-U-Boot # fatwrite mmc 0:1 0x8dec9000 args 0x20000
-
-The size of 0x20000 matches the CMD_SPL_WRITE_SIZE.
-
-Falcon Mode: NAND
-=================
-
-In this case the additional data is written to another partition of the
-NAND.  In this example we assume that the uImage and device tree to be are
-already located on the NAND somewhere (such as filesystem or mtd partition)
-along with a Falcon Mode aware MLO written to the correct locations for
-booting and mtdparts have been configured correctly for the board:
-
-U-Boot # nand read ${loadaddr} kernel
-U-Boot # load nand rootfs ${fdtaddr} /boot/am335x-evm.dtb
-U-Boot # run nandargs
-U-Boot # run common_bootargs
-U-Boot # spl export fdt ${loadaddr} - ${fdtaddr}
-U-Boot # nand erase.part u-boot-spl-os
-U-Boot # nand write ${fdtaddr} u-boot-spl-os
diff --git a/board/logicpd/omap3som/omap3logic.c b/board/logicpd/omap3som/omap3logic.c
deleted file mode 100644
index 352b519b451..00000000000
--- a/board/logicpd/omap3som/omap3logic.c
+++ /dev/null
@@ -1,240 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2011
- * Logic Product Development <www.logicpd.com>
- *
- * Author :
- *	Peter Barada <peter.barada@logicpd.com>
- *
- * Derived from Beagle Board and 3430 SDP code by
- *	Richard Woodruff <r-woodruff2@ti.com>
- *	Syed Mohammed Khasim <khasim@ti.com>
- */
-#include <config.h>
-#include <dm.h>
-#include <init.h>
-#include <net.h>
-#include <ns16550.h>
-#include <nand.h>
-#include <i2c.h>
-#include <serial.h>
-#include <twl4030.h>
-#include <asm/global_data.h>
-#include <asm/io.h>
-#include <asm/arch/mmc_host_def.h>
-#include <asm/arch/mux.h>
-#include <asm/arch/mem.h>
-#include <asm/arch/sys_proto.h>
-#include <asm/gpio.h>
-#include <asm/omap_mmc.h>
-#include <asm/mach-types.h>
-#include <linux/mtd/rawnand.h>
-#include <asm/omap_musb.h>
-#include <linux/errno.h>
-#include <linux/usb/ch9.h>
-#include <linux/usb/gadget.h>
-#include <linux/usb/musb.h>
-#include "omap3logic.h"
-#ifdef CONFIG_USB_EHCI_HCD
-#include <usb.h>
-#include <asm/ehci-omap.h>
-#endif
-
-DECLARE_GLOBAL_DATA_PTR;
-
-#define LOGIC_MT28_DM37_ASYNC_GPMC_CONFIG1	0x00011203
-#define LOGIC_MT28_DM37_ASYNC_GPMC_CONFIG2	0x000A1302
-#define LOGIC_MT28_DM37_ASYNC_GPMC_CONFIG3	0x000F1302
-#define LOGIC_MT28_DM37_ASYNC_GPMC_CONFIG4	0x0A021303
-#define LOGIC_MT28_DM37_ASYNC_GPMC_CONFIG5	0x00120F18
-#define LOGIC_MT28_DM37_ASYNC_GPMC_CONFIG6	0x0A030000
-#define LOGIC_MT28_DM37_ASYNC_GPMC_CONFIG7	0x00000C50
-
-#define LOGIC_MT28_OMAP35_ASYNC_GPMC_CONFIG1	0x00011203
-#define LOGIC_MT28_OMAP35_ASYNC_GPMC_CONFIG2	0x00091102
-#define LOGIC_MT28_OMAP35_ASYNC_GPMC_CONFIG3	0x000D1102
-#define LOGIC_MT28_OMAP35_ASYNC_GPMC_CONFIG4	0x09021103
-#define LOGIC_MT28_OMAP35_ASYNC_GPMC_CONFIG5	0x00100D15
-#define LOGIC_MT28_OMAP35_ASYNC_GPMC_CONFIG6	0x09030000
-#define LOGIC_MT28_OMAP35_ASYNC_GPMC_CONFIG7	0x00000C50
-
-#define CFG_SMC911X_BASE 0x08000000
-
-#ifdef CONFIG_SPL_OS_BOOT
-int spl_start_uboot(void)
-{
-	/* break into full u-boot on 'c' */
-	return serial_tstc() && serial_getc() == 'c';
-}
-#endif
-
-#if defined(CONFIG_XPL_BUILD)
-/*
- * Routine: get_board_mem_timings
- * Description: If we use SPL then there is no x-loader nor config header
- * so we have to setup the DDR timings ourself on the first bank.  This
- * provides the timing values back to the function that configures
- * the memory.
- */
-void get_board_mem_timings(struct board_sdrc_timings *timings)
-{
-	timings->mr = MICRON_V_MR_165;
-
-	if (get_cpu_family() == CPU_OMAP36XX) {
-		/* 200 MHz works for OMAP36/DM37 */
-		/* 256MB DDR */
-		timings->mcfg = MICRON_V_MCFG_200(256 << 20);
-		timings->ctrla = MICRON_V_ACTIMA_200;
-		timings->ctrlb = MICRON_V_ACTIMB_200;
-		timings->rfr_ctrl = SDP_3430_SDRC_RFR_CTRL_200MHz;
-	} else {
-		/* 165 MHz works for OMAP35 */
-		timings->mcfg = MICRON_V_MCFG_165(256 << 20);
-		timings->ctrla = MICRON_V_ACTIMA_165;
-		timings->ctrlb = MICRON_V_ACTIMB_165;
-		timings->rfr_ctrl = SDP_3430_SDRC_RFR_CTRL_165MHz;
-	}
-}
-
-#define GPMC_NAND_COMMAND_0 (OMAP34XX_GPMC_BASE + 0x7c)
-#define GPMC_NAND_DATA_0 (OMAP34XX_GPMC_BASE + 0x84)
-#define GPMC_NAND_ADDRESS_0 (OMAP34XX_GPMC_BASE + 0x80)
-
-void spl_board_prepare_for_linux(void)
-{
-	/* The Micron NAND starts locked which
-	 * prohibits mounting the NAND as RW
-	 * The following commands are what unlocks
-	 * the NAND to become RW Falcon Mode does not
-	 * have as many smarts as U-Boot, but Logic PD
-	 * only makes NAND with 512MB so these hard coded
-	 * values should work for all current models
-	 */
-
-	writeb(0x70, GPMC_NAND_COMMAND_0);
-	writeb(-1, GPMC_NAND_DATA_0);
-	writeb(0x7a, GPMC_NAND_COMMAND_0);
-	writeb(0x00, GPMC_NAND_ADDRESS_0);
-	writeb(0x00, GPMC_NAND_ADDRESS_0);
-	writeb(0x00, GPMC_NAND_ADDRESS_0);
-	writeb(-1, GPMC_NAND_COMMAND_0);
-
-	/* Begin address 0 */
-	writeb(NAND_CMD_UNLOCK1, 0x6e00007c);
-	writeb(0x00, GPMC_NAND_ADDRESS_0);
-	writeb(0x00, GPMC_NAND_ADDRESS_0);
-	writeb(0x00, GPMC_NAND_ADDRESS_0);
-	writeb(-1, GPMC_NAND_DATA_0);
-
-	/* Ending address at the end of Flash */
-	writeb(NAND_CMD_UNLOCK2, GPMC_NAND_COMMAND_0);
-	writeb(0xc0, GPMC_NAND_ADDRESS_0);
-	writeb(0xff, GPMC_NAND_ADDRESS_0);
-	writeb(0x03, GPMC_NAND_ADDRESS_0);
-	writeb(-1, GPMC_NAND_DATA_0);
-	writeb(0x79, GPMC_NAND_COMMAND_0);
-	writeb(-1, GPMC_NAND_DATA_0);
-	writeb(-1, GPMC_NAND_DATA_0);
-}
-#endif
-
-/*
- * Routine: misc_init_r
- * Description: Configure board specific parts
- */
-int misc_init_r(void)
-{
-	twl4030_power_init();
-	twl4030_power_mmc_init(0);
-	omap_die_id_display();
-	return 0;
-}
-
-#if defined(CONFIG_FLASH_CFI_DRIVER)
-static const u32 gpmc_dm37_c2nor_config[] = {
-	LOGIC_MT28_DM37_ASYNC_GPMC_CONFIG1,
-	LOGIC_MT28_DM37_ASYNC_GPMC_CONFIG2,
-	LOGIC_MT28_DM37_ASYNC_GPMC_CONFIG3,
-	LOGIC_MT28_DM37_ASYNC_GPMC_CONFIG4,
-	LOGIC_MT28_DM37_ASYNC_GPMC_CONFIG5,
-	LOGIC_MT28_DM37_ASYNC_GPMC_CONFIG6,
-	LOGIC_MT28_DM37_ASYNC_GPMC_CONFIG7
-};
-
-static const u32 gpmc_omap35_c2nor_config[] = {
-	LOGIC_MT28_OMAP35_ASYNC_GPMC_CONFIG1,
-	LOGIC_MT28_OMAP35_ASYNC_GPMC_CONFIG2,
-	LOGIC_MT28_OMAP35_ASYNC_GPMC_CONFIG3,
-	LOGIC_MT28_OMAP35_ASYNC_GPMC_CONFIG4,
-	LOGIC_MT28_OMAP35_ASYNC_GPMC_CONFIG5,
-	LOGIC_MT28_OMAP35_ASYNC_GPMC_CONFIG6,
-	LOGIC_MT28_OMAP35_ASYNC_GPMC_CONFIG7
-};
-#endif
-
-/*
- * Routine: board_init
- * Description: Early hardware init.
- */
-int board_init(void)
-{
-	gpmc_init(); /* in SRAM or SDRAM, finish GPMC */
-
-	/* boot param addr */
-	gd->bd->bi_boot_params = (OMAP34XX_SDRC_CS0 + 0x100);
-#if defined(CONFIG_FLASH_CFI_DRIVER)
-	if (get_cpu_family() == CPU_OMAP36XX) {
-		/* Enable CS2 for NOR Flash */
-		enable_gpmc_cs_config(gpmc_dm37_c2nor_config, &gpmc_cfg->cs[2],
-				      0x10000000, GPMC_SIZE_64M);
-	} else {
-		enable_gpmc_cs_config(gpmc_omap35_c2nor_config, &gpmc_cfg->cs[2],
-				      0x10000000, GPMC_SIZE_64M);
-	}
-#endif
-	return 0;
-}
-
-#ifdef CONFIG_BOARD_LATE_INIT
-
-static void unlock_nand(void)
-{
-	int dev = nand_curr_device;
-	struct mtd_info *mtd;
-
-	mtd = get_nand_dev_by_index(dev);
-	nand_unlock(mtd, 0, mtd->size, 0);
-}
-
-#ifdef CONFIG_SMC911X
-/* GPMC CS1 settings for Logic SOM LV/Torpedo LAN92xx Ethernet chip */
-static const u32 gpmc_lan92xx_config[] = {
-	NET_LAN92XX_GPMC_CONFIG1,
-	NET_LAN92XX_GPMC_CONFIG2,
-	NET_LAN92XX_GPMC_CONFIG3,
-	NET_LAN92XX_GPMC_CONFIG4,
-	NET_LAN92XX_GPMC_CONFIG5,
-	NET_LAN92XX_GPMC_CONFIG6,
-};
-#endif
-
-int board_late_init(void)
-{
-#ifdef CONFIG_CMD_NAND_LOCK_UNLOCK
-	unlock_nand();
-#endif
-
-#ifdef CONFIG_SMC911X
-	enable_gpmc_cs_config(gpmc_lan92xx_config, &gpmc_cfg->cs[1],
-			CFG_SMC911X_BASE, GPMC_SIZE_16M);
-#endif
-	return 0;
-}
-#endif
-
-#if defined(CONFIG_MMC)
-void board_mmc_power_init(void)
-{
-	twl4030_power_mmc_init(0);
-}
-#endif
diff --git a/board/logicpd/omap3som/omap3logic.h b/board/logicpd/omap3som/omap3logic.h
deleted file mode 100644
index 55d8f429513..00000000000
--- a/board/logicpd/omap3som/omap3logic.h
+++ /dev/null
@@ -1,237 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * (C) Copyright 2011
- * Logic Product Development <www.logicpd.com>
- *
- * Author:
- * Peter Barada <peter.barada@logicpd.com>
- */
-#ifndef _OMAP3LOGIC_H_
-#define _OMAP3LOGIC_H_
-
-/*
- * OMAP3 GPMC register settings for CS1 LAN922x
- */
-#define NET_LAN92XX_GPMC_CONFIG1	0x00001000
-#define NET_LAN92XX_GPMC_CONFIG2	0x00080801
-#define NET_LAN92XX_GPMC_CONFIG3	0x00000000
-#define NET_LAN92XX_GPMC_CONFIG4	0x08010801
-#define NET_LAN92XX_GPMC_CONFIG5	0x00080a0a
-#define NET_LAN92XX_GPMC_CONFIG6	0x03000280
-
-const omap3_sysinfo sysinfo = {
-	DDR_DISCRETE,
-	"Logic DM37x/OMAP35x reference board",
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
-
-/*
- * Routine: set_muxconf_regs
- * Description: Setting up the configuration Mux registers specific to the
- *		hardware. Many pins need to be moved from protect to primary
- *		mode.
- */
-void set_muxconf_regs(void)
-{
-	MUX_VAL(CP(SDRC_D0), (IEN  | PTD | DIS | M0)) /*SDRC_D0*/
-	MUX_VAL(CP(SDRC_D1), (IEN  | PTD | DIS | M0)) /*SDRC_D1*/
-	MUX_VAL(CP(SDRC_D2), (IEN  | PTD | DIS | M0)) /*SDRC_D2*/
-	MUX_VAL(CP(SDRC_D3), (IEN  | PTD | DIS | M0)) /*SDRC_D3*/
-	MUX_VAL(CP(SDRC_D4), (IEN  | PTD | DIS | M0)) /*SDRC_D4*/
-	MUX_VAL(CP(SDRC_D5), (IEN  | PTD | DIS | M0)) /*SDRC_D5*/
-	MUX_VAL(CP(SDRC_D6), (IEN  | PTD | DIS | M0)) /*SDRC_D6*/
-	MUX_VAL(CP(SDRC_D7), (IEN  | PTD | DIS | M0)) /*SDRC_D7*/
-	MUX_VAL(CP(SDRC_D8), (IEN  | PTD | DIS | M0)) /*SDRC_D8*/
-	MUX_VAL(CP(SDRC_D9), (IEN  | PTD | DIS | M0)) /*SDRC_D9*/
-	MUX_VAL(CP(SDRC_D10), (IEN  | PTD | DIS | M0)) /*SDRC_D10*/
-	MUX_VAL(CP(SDRC_D11), (IEN  | PTD | DIS | M0)) /*SDRC_D11*/
-	MUX_VAL(CP(SDRC_D12), (IEN  | PTD | DIS | M0)) /*SDRC_D12*/
-	MUX_VAL(CP(SDRC_D13), (IEN  | PTD | DIS | M0)) /*SDRC_D13*/
-	MUX_VAL(CP(SDRC_D14), (IEN  | PTD | DIS | M0)) /*SDRC_D14*/
-	MUX_VAL(CP(SDRC_D15), (IEN  | PTD | DIS | M0)) /*SDRC_D15*/
-	MUX_VAL(CP(SDRC_D16), (IEN  | PTD | DIS | M0)) /*SDRC_D16*/
-	MUX_VAL(CP(SDRC_D17), (IEN  | PTD | DIS | M0)) /*SDRC_D17*/
-	MUX_VAL(CP(SDRC_D18), (IEN  | PTD | DIS | M0)) /*SDRC_D18*/
-	MUX_VAL(CP(SDRC_D19), (IEN  | PTD | DIS | M0)) /*SDRC_D19*/
-	MUX_VAL(CP(SDRC_D20), (IEN  | PTD | DIS | M0)) /*SDRC_D20*/
-	MUX_VAL(CP(SDRC_D21), (IEN  | PTD | DIS | M0)) /*SDRC_D21*/
-	MUX_VAL(CP(SDRC_D22), (IEN  | PTD | DIS | M0)) /*SDRC_D22*/
-	MUX_VAL(CP(SDRC_D23), (IEN  | PTD | DIS | M0)) /*SDRC_D23*/
-	MUX_VAL(CP(SDRC_D24), (IEN  | PTD | DIS | M0)) /*SDRC_D24*/
-	MUX_VAL(CP(SDRC_D25), (IEN  | PTD | DIS | M0)) /*SDRC_D25*/
-	MUX_VAL(CP(SDRC_D26), (IEN  | PTD | DIS | M0)) /*SDRC_D26*/
-	MUX_VAL(CP(SDRC_D27), (IEN  | PTD | DIS | M0)) /*SDRC_D27*/
-	MUX_VAL(CP(SDRC_D28), (IEN  | PTD | DIS | M0)) /*SDRC_D28*/
-	MUX_VAL(CP(SDRC_D29), (IEN  | PTD | DIS | M0)) /*SDRC_D29*/
-	MUX_VAL(CP(SDRC_D30), (IEN  | PTD | DIS | M0)) /*SDRC_D30*/
-	MUX_VAL(CP(SDRC_D31), (IEN  | PTD | DIS | M0)) /*SDRC_D31*/
-	MUX_VAL(CP(SDRC_CLK), (IEN  | PTD | DIS | M0)) /*SDRC_CLK*/
-	MUX_VAL(CP(SDRC_DQS0), (IEN  | PTD | DIS | M0)) /*SDRC_DQS0*/
-	MUX_VAL(CP(SDRC_DQS1), (IEN  | PTD | DIS | M0)) /*SDRC_DQS1*/
-	MUX_VAL(CP(SDRC_DQS2), (IEN  | PTD | DIS | M0)) /*SDRC_DQS2*/
-	MUX_VAL(CP(SDRC_DQS3), (IEN  | PTD | DIS | M0)) /*SDRC_DQS3*/
-	MUX_VAL(CP(SDRC_CKE0), (IDIS | PTU | EN  | M0)) /*SDRC_CKE0*/
-	MUX_VAL(CP(SDRC_CKE1), (IDIS | PTU | DIS | M0)) /*SDRC_CKE1*/
-
-	MUX_VAL(CP(GPMC_A1), (IDIS | PTU | EN  | M0)) /*GPMC_A1*/
-	MUX_VAL(CP(GPMC_A2), (IDIS | PTU | EN  | M0)) /*GPMC_A2*/
-	MUX_VAL(CP(GPMC_A3), (IDIS | PTU | EN  | M0)) /*GPMC_A3*/
-	MUX_VAL(CP(GPMC_A4), (IDIS | PTU | EN  | M0)) /*GPMC_A4*/
-	MUX_VAL(CP(GPMC_A5), (IDIS | PTU | EN  | M0)) /*GPMC_A5*/
-	MUX_VAL(CP(GPMC_A6), (IDIS | PTU | EN  | M0)) /*GPMC_A6*/
-	MUX_VAL(CP(GPMC_A7), (IDIS | PTU | EN  | M0)) /*GPMC_A7*/
-	MUX_VAL(CP(GPMC_A8), (IDIS | PTU | EN  | M0)) /*GPMC_A8*/
-	MUX_VAL(CP(GPMC_A9), (IDIS | PTU | EN  | M0)) /*GPMC_A9*/
-	MUX_VAL(CP(GPMC_A10), (IDIS | PTU | EN  | M0)) /*GPMC_A10*/
-	MUX_VAL(CP(GPMC_D0), (IEN  | PTU | EN  | M0)) /*GPMC_D0*/
-	MUX_VAL(CP(GPMC_D1), (IEN  | PTU | EN  | M0)) /*GPMC_D1*/
-	MUX_VAL(CP(GPMC_D2), (IEN  | PTU | EN  | M0)) /*GPMC_D2*/
-	MUX_VAL(CP(GPMC_D3), (IEN  | PTU | EN  | M0)) /*GPMC_D3*/
-	MUX_VAL(CP(GPMC_D4), (IEN  | PTU | EN  | M0)) /*GPMC_D4*/
-	MUX_VAL(CP(GPMC_D5), (IEN  | PTU | EN  | M0)) /*GPMC_D5*/
-	MUX_VAL(CP(GPMC_D6), (IEN  | PTU | EN  | M0)) /*GPMC_D6*/
-	MUX_VAL(CP(GPMC_D7), (IEN  | PTU | EN  | M0)) /*GPMC_D7*/
-	MUX_VAL(CP(GPMC_D8), (IEN  | PTU | EN  | M0)) /*GPMC_D8*/
-	MUX_VAL(CP(GPMC_D9), (IEN  | PTU | EN  | M0)) /*GPMC_D9*/
-	MUX_VAL(CP(GPMC_D10), (IEN  | PTU | EN  | M0)) /*GPMC_D10*/
-	MUX_VAL(CP(GPMC_D11), (IEN  | PTU | EN  | M0)) /*GPMC_D11*/
-	MUX_VAL(CP(GPMC_D12), (IEN  | PTU | EN  | M0)) /*GPMC_D12*/
-	MUX_VAL(CP(GPMC_D13), (IEN  | PTU | EN  | M0)) /*GPMC_D13*/
-	MUX_VAL(CP(GPMC_D14), (IEN  | PTU | EN  | M0)) /*GPMC_D14*/
-	MUX_VAL(CP(GPMC_D15), (IEN  | PTU | EN  | M0)) /*GPMC_D15*/
-	MUX_VAL(CP(GPMC_NCS0), (IDIS | PTU | EN  | M0)) /*GPMC_nCS0*/
-	MUX_VAL(CP(GPMC_NCS1), (IDIS | PTU | EN  | M0)) /*GPMC_nCS1*/
-	MUX_VAL(CP(GPMC_NCS2), (IDIS | PTU | EN  | M0)) /*GPMC_nCS2*/
-	MUX_VAL(CP(GPMC_NCS3), (IDIS | PTU | EN  | M0)) /*GPMC_nCS3*/
-	MUX_VAL(CP(GPMC_NCS4), (IEN  | PTU | EN  | M0)) /*GPMC_nCS4*/
-	MUX_VAL(CP(GPMC_NCS5), (IDIS | PTU | EN  | M0)) /*GPMC_nCS5*/
-	MUX_VAL(CP(GPMC_NCS6), (IEN  | PTU | EN | M0)) /*GPMC_nCS6*/
-	MUX_VAL(CP(GPMC_NCS7), (IEN  | PTU | EN  | M0)) /*GPMC_nCS7*/
-	MUX_VAL(CP(GPMC_CLK), (IDIS | PTU | EN  | M0)) /*GPMC_CLK*/
-	MUX_VAL(CP(GPMC_NADV_ALE), (IDIS | PTD | DIS | M0)) /*GPMC_nADV_ALE*/
-	MUX_VAL(CP(GPMC_NOE), (IDIS | PTD | DIS | M0)) /*GPMC_nOE*/
-	MUX_VAL(CP(GPMC_NWE), (IDIS | PTD | DIS | M0)) /*GPMC_nWE*/
-	MUX_VAL(CP(GPMC_NBE0_CLE), (IDIS | PTU | EN  | M0)) /*GPMC_nBE0_CLE*/
-	MUX_VAL(CP(GPMC_NBE1), (IEN  | PTU | EN  | M0)) /*GPMC_nBE1*/
-	MUX_VAL(CP(GPMC_NWP),  (IEN  | PTD | DIS | M0)) /*GPMC_nWP*/
-	MUX_VAL(CP(GPMC_WAIT0), (IEN  | PTU | EN  | M0)) /*GPMC_WAIT0*/
-	MUX_VAL(CP(GPMC_WAIT1), (IEN  | PTU | EN  | M0)) /*GPMC_WAIT1*/
-	MUX_VAL(CP(GPMC_WAIT2), (IEN  | PTU | EN  | M4)) /*GPIO_64*/
-	MUX_VAL(CP(GPMC_WAIT3), (IEN  | PTU | EN  | M0)) /*GPMC_WAIT3*/
-
-	MUX_VAL(CP(MMC1_CLK), (IDIS | PTU | EN  | M0)) /*MMC1_CLK*/
-	MUX_VAL(CP(MMC1_CMD), (IEN  | PTU | EN  | M0)) /*MMC1_CMD*/
-	MUX_VAL(CP(MMC1_DAT0), (IEN  | PTU | EN  | M0)) /*MMC1_DAT0*/
-	MUX_VAL(CP(MMC1_DAT1), (IEN  | PTU | EN  | M0)) /*MMC1_DAT1*/
-	MUX_VAL(CP(MMC1_DAT2), (IEN  | PTU | EN  | M0)) /*MMC1_DAT2*/
-	MUX_VAL(CP(MMC1_DAT3), (IEN  | PTU | EN  | M0)) /*MMC1_DAT3*/
-
-	MUX_VAL(CP(UART1_TX), (IDIS | PTD | DIS | M0)) /*UART1_TX*/
-	MUX_VAL(CP(UART1_RTS), (IDIS | PTD | DIS | M0)) /*UART1_RTS*/
-	MUX_VAL(CP(UART1_CTS), (IEN  | PTU | DIS | M0)) /*UART1_CTS*/
-	MUX_VAL(CP(UART1_RX), (IEN  | PTD | DIS | M0)) /*UART1_RX*/
-
-	MUX_VAL(CP(JTAG_TCK), (IEN  | PTD | DIS | M0)) /*JTAG_TCK*/
-	MUX_VAL(CP(JTAG_TMS), (IEN  | PTD | DIS | M0)) /*JTAG_TMS*/
-	MUX_VAL(CP(JTAG_TDI), (IEN  | PTD | DIS | M0)) /*JTAG_TDI*/
-	MUX_VAL(CP(JTAG_EMU0), (IEN  | PTD | DIS | M0)) /*JTAG_EMU0*/
-	MUX_VAL(CP(JTAG_EMU1), (IEN  | PTD | DIS | M0)) /*JTAG_EMU1*/
-
-	MUX_VAL(CP(ETK_CLK_ES2), (IDIS | PTU | EN  | M0)) /*ETK_CLK*/
-	MUX_VAL(CP(ETK_CTL_ES2), (IDIS | PTD | DIS | M0)) /*ETK_CTL*/
-	MUX_VAL(CP(ETK_D0_ES2), (IEN  | PTD | DIS | M0)) /*ETK_D0*/
-	MUX_VAL(CP(ETK_D1_ES2), (IEN  | PTD | DIS | M0)) /*ETK_D1*/
-	MUX_VAL(CP(ETK_D2_ES2), (IEN  | PTD | EN  | M0)) /*ETK_D2*/
-	MUX_VAL(CP(ETK_D3_ES2), (IEN  | PTD | DIS | M0)) /*ETK_D3*/
-	MUX_VAL(CP(ETK_D4_ES2), (IEN  | PTD | DIS | M0)) /*ETK_D4*/
-	MUX_VAL(CP(ETK_D5_ES2), (IEN  | PTD | DIS | M0)) /*ETK_D5*/
-	MUX_VAL(CP(ETK_D6_ES2), (IEN  | PTD | DIS | M0)) /*ETK_D6*/
-	MUX_VAL(CP(ETK_D7_ES2), (IEN  | PTD | DIS | M0)) /*ETK_D7*/
-	MUX_VAL(CP(ETK_D8_ES2), (IEN  | PTD | DIS | M0)) /*ETK_D8*/
-	MUX_VAL(CP(ETK_D9_ES2), (IEN  | PTD | DIS | M0)) /*ETK_D9*/
-#ifndef CONFIG_USB_EHCI_OMAP /* Torpedo does not use EHCI_OMAP */
-	MUX_VAL(CP(ETK_D10_ES2), (IEN  | PTD | DIS | M0)) /*ETK_D10*/
-	MUX_VAL(CP(ETK_D11_ES2), (IEN  | PTD | DIS | M0)) /*ETK_D11*/
-	MUX_VAL(CP(ETK_D12_ES2), (IEN  | PTD | DIS | M0)) /*ETK_D12*/
-	MUX_VAL(CP(ETK_D13_ES2), (IEN  | PTD | DIS | M0)) /*ETK_D13*/
-	MUX_VAL(CP(ETK_D14_ES2), (IEN  | PTD | DIS | M0)) /*ETK_D14*/
-	MUX_VAL(CP(ETK_D15_ES2), (IEN  | PTD | DIS | M0)) /*ETK_D15*/
-#endif
-
-	MUX_VAL(CP(D2D_MCAD1), (IEN  | PTD | EN  | M0)) /*d2d_mcad1*/
-	MUX_VAL(CP(D2D_MCAD2), (IEN  | PTD | EN  | M0)) /*d2d_mcad2*/
-	MUX_VAL(CP(D2D_MCAD3), (IEN  | PTD | EN  | M0)) /*d2d_mcad3*/
-	MUX_VAL(CP(D2D_MCAD4), (IEN  | PTD | EN  | M0)) /*d2d_mcad4*/
-	MUX_VAL(CP(D2D_MCAD5), (IEN  | PTD | EN  | M0)) /*d2d_mcad5*/
-	MUX_VAL(CP(D2D_MCAD6), (IEN  | PTD | EN  | M0)) /*d2d_mcad6*/
-	MUX_VAL(CP(D2D_MCAD7), (IEN  | PTD | EN  | M0)) /*d2d_mcad7*/
-	MUX_VAL(CP(D2D_MCAD8), (IEN  | PTD | EN  | M0)) /*d2d_mcad8*/
-	MUX_VAL(CP(D2D_MCAD9), (IEN  | PTD | EN  | M0)) /*d2d_mcad9*/
-	MUX_VAL(CP(D2D_MCAD10), (IEN  | PTD | EN  | M0)) /*d2d_mcad10*/
-	MUX_VAL(CP(D2D_MCAD11), (IEN  | PTD | EN  | M0)) /*d2d_mcad11*/
-	MUX_VAL(CP(D2D_MCAD12), (IEN  | PTD | EN  | M0)) /*d2d_mcad12*/
-	MUX_VAL(CP(D2D_MCAD13), (IEN  | PTD | EN  | M0)) /*d2d_mcad13*/
-	MUX_VAL(CP(D2D_MCAD14), (IEN  | PTD | EN  | M0)) /*d2d_mcad14*/
-	MUX_VAL(CP(D2D_MCAD15), (IEN  | PTD | EN  | M0)) /*d2d_mcad15*/
-	MUX_VAL(CP(D2D_MCAD16), (IEN  | PTD | EN  | M0)) /*d2d_mcad16*/
-	MUX_VAL(CP(D2D_MCAD17), (IEN  | PTD | EN  | M0)) /*d2d_mcad17*/
-	MUX_VAL(CP(D2D_MCAD18), (IEN  | PTD | EN  | M0)) /*d2d_mcad18*/
-	MUX_VAL(CP(D2D_MCAD19), (IEN  | PTD | EN  | M0)) /*d2d_mcad19*/
-	MUX_VAL(CP(D2D_MCAD20), (IEN  | PTD | EN  | M0)) /*d2d_mcad20*/
-	MUX_VAL(CP(D2D_MCAD21), (IEN  | PTD | EN  | M0)) /*d2d_mcad21*/
-	MUX_VAL(CP(D2D_MCAD22), (IEN  | PTD | EN  | M0)) /*d2d_mcad22*/
-	MUX_VAL(CP(D2D_MCAD23), (IEN  | PTD | EN  | M0)) /*d2d_mcad23*/
-	MUX_VAL(CP(D2D_MCAD24), (IEN  | PTD | EN  | M0)) /*d2d_mcad24*/
-	MUX_VAL(CP(D2D_MCAD25), (IEN  | PTD | EN  | M0)) /*d2d_mcad25*/
-	MUX_VAL(CP(D2D_MCAD26), (IEN  | PTD | EN  | M0)) /*d2d_mcad26*/
-	MUX_VAL(CP(D2D_MCAD27), (IEN  | PTD | EN  | M0)) /*d2d_mcad27*/
-	MUX_VAL(CP(D2D_MCAD28), (IEN  | PTD | EN  | M0)) /*d2d_mcad28*/
-	MUX_VAL(CP(D2D_MCAD29), (IEN  | PTD | EN  | M0)) /*d2d_mcad29*/
-	MUX_VAL(CP(D2D_MCAD30), (IEN  | PTD | EN  | M0)) /*d2d_mcad30*/
-	MUX_VAL(CP(D2D_MCAD31), (IEN  | PTD | EN  | M0)) /*d2d_mcad31*/
-	MUX_VAL(CP(D2D_MCAD32), (IEN  | PTD | EN  | M0)) /*d2d_mcad32*/
-	MUX_VAL(CP(D2D_MCAD33), (IEN  | PTD | EN  | M0)) /*d2d_mcad33*/
-	MUX_VAL(CP(D2D_MCAD34), (IEN  | PTD | EN  | M0)) /*d2d_mcad34*/
-	MUX_VAL(CP(D2D_MCAD35), (IEN  | PTD | EN  | M0)) /*d2d_mcad35*/
-	MUX_VAL(CP(D2D_MCAD36), (IEN  | PTD | EN  | M0)) /*d2d_mcad36*/
-	MUX_VAL(CP(D2D_CLK26MI), (IEN  | PTD | DIS | M0)) /*d2d_clk26mi*/
-	MUX_VAL(CP(D2D_NRESPWRON), (IEN  | PTD | EN  | M0)) /*d2d_nrespwron*/
-	MUX_VAL(CP(D2D_NRESWARM), (IEN  | PTU | EN  | M0)) /*d2d_nreswarm */
-	MUX_VAL(CP(D2D_ARM9NIRQ), (IEN  | PTD | DIS | M0)) /*d2d_arm9nirq */
-	MUX_VAL(CP(D2D_UMA2P6FIQ), (IEN  | PTD | DIS | M0)) /*d2d_uma2p6fiq*/
-	MUX_VAL(CP(D2D_SPINT), (IEN  | PTD | EN  | M0)) /*d2d_spint*/
-	MUX_VAL(CP(D2D_FRINT), (IEN  | PTD | EN  | M0)) /*d2d_frint*/
-	MUX_VAL(CP(D2D_DMAREQ0), (IEN  | PTD | DIS | M0)) /*d2d_dmareq0*/
-	MUX_VAL(CP(D2D_DMAREQ1), (IEN  | PTD | DIS | M0)) /*d2d_dmareq1*/
-	MUX_VAL(CP(D2D_DMAREQ2), (IEN  | PTD | DIS | M0)) /*d2d_dmareq2*/
-	MUX_VAL(CP(D2D_DMAREQ3), (IEN  | PTD | DIS | M0)) /*d2d_dmareq3*/
-	MUX_VAL(CP(D2D_N3GTRST), (IEN  | PTD | DIS | M0)) /*d2d_n3gtrst*/
-	MUX_VAL(CP(D2D_N3GTDI), (IEN  | PTD | DIS | M0)) /*d2d_n3gtdi*/
-	MUX_VAL(CP(D2D_N3GTDO), (IEN  | PTD | DIS | M0)) /*d2d_n3gtdo*/
-	MUX_VAL(CP(D2D_N3GTMS), (IEN  | PTD | DIS | M0)) /*d2d_n3gtms*/
-	MUX_VAL(CP(D2D_N3GTCK), (IEN  | PTD | DIS | M0)) /*d2d_n3gtck*/
-	MUX_VAL(CP(D2D_N3GRTCK), (IEN  | PTD | DIS | M0)) /*d2d_n3grtck*/
-	MUX_VAL(CP(D2D_MSTDBY),  (IEN  | PTU | EN  | M0)) /*d2d_mstdby*/
-	MUX_VAL(CP(D2D_SWAKEUP), (IEN  | PTD | EN  | M0)) /*d2d_swakeup*/
-	MUX_VAL(CP(D2D_IDLEREQ), (IEN  | PTD | DIS | M0)) /*d2d_idlereq*/
-	MUX_VAL(CP(D2D_IDLEACK), (IEN  | PTU | EN  | M0)) /*d2d_idleack*/
-	MUX_VAL(CP(D2D_MWRITE), (IEN  | PTD | DIS | M0)) /*d2d_mwrite*/
-	MUX_VAL(CP(D2D_SWRITE), (IEN  | PTD | DIS | M0)) /*d2d_swrite*/
-	MUX_VAL(CP(D2D_MREAD), (IEN  | PTD | DIS | M0)) /*d2d_mread*/
-	MUX_VAL(CP(D2D_SREAD), (IEN  | PTD | DIS | M0)) /*d2d_sread*/
-	MUX_VAL(CP(D2D_MBUSFLAG), (IEN  | PTD | DIS | M0)) /*d2d_mbusflag*/
-	MUX_VAL(CP(D2D_SBUSFLAG), (IEN  | PTD | DIS | M0)) /*d2d_sbusflag*/
-}
-
-#endif
diff --git a/configs/omap35_logic_defconfig b/configs/omap35_logic_defconfig
deleted file mode 100644
index 61d8003af66..00000000000
--- a/configs/omap35_logic_defconfig
+++ /dev/null
@@ -1,94 +0,0 @@
-CONFIG_ARM=y
-# CONFIG_SPL_USE_ARCH_MEMCPY is not set
-# CONFIG_SPL_USE_ARCH_MEMSET is not set
-CONFIG_ARCH_OMAP2PLUS=y
-CONFIG_TEXT_BASE=0x80100000
-CONFIG_SYS_MALLOC_F_LEN=0x3000
-CONFIG_TI_COMMON_CMD_OPTIONS=y
-# CONFIG_SPL_GPIO is not set
-CONFIG_DEFAULT_DEVICE_TREE="ti/omap/logicpd-torpedo-35xx-devkit"
-CONFIG_TARGET_OMAP3_LOGIC=y
-# CONFIG_SPL_OMAP3_ID_NAND is not set
-CONFIG_SPL=y
-CONFIG_LTO=y
-CONFIG_ANDROID_BOOT_IMAGE=y
-CONFIG_DISTRO_DEFAULTS=y
-CONFIG_BOOTCOMMAND="run autoboot"
-CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="setenv preboot;saveenv;"
-CONFIG_DEFAULT_FDT_FILE="logicpd-torpedo-35xx-devkit.dtb"
-CONFIG_SYS_PBSIZE=1054
-CONFIG_SYS_CONSOLE_INFO_QUIET=y
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
-CONFIG_SYS_NAND_SPL_KERNEL_OFFS=0x280000
-CONFIG_SPL_FALCON_BOOT_MMCSD=y
-CONFIG_SYS_MMCSD_RAW_MODE_KERNEL_SECTOR=0x1700
-CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTOR=0x1500
-CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTORS=0x200
-CONFIG_SYS_PROMPT="OMAP Logic # "
-# CONFIG_CMD_IMI is not set
-CONFIG_CMD_SPL_NAND_OFS=0x240000
-CONFIG_CMD_SPL_WRITE_SIZE=0x20000
-CONFIG_CMD_NAND=y
-CONFIG_CMD_NAND_LOCK_UNLOCK=y
-CONFIG_SYS_DISABLE_AUTOLOAD=y
-CONFIG_CMD_UUID=y
-CONFIG_CMD_MTDPARTS=y
-CONFIG_MTDIDS_DEFAULT="nand0=omap2-nand.0"
-CONFIG_MTDPARTS_DEFAULT="mtdparts=omap2-nand.0:512k(MLO),1792k(u-boot),128k(spl-os),128k(u-boot-env),6m(kernel),-(fs)"
-CONFIG_CMD_UBI=y
-CONFIG_OF_CONTROL=y
-CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_UPSTREAM=y
-CONFIG_ENV_OVERWRITE=y
-# CONFIG_ENV_IS_IN_FAT is not set
-CONFIG_ENV_IS_IN_NAND=y
-CONFIG_VERSION_VARIABLE=y
-CONFIG_SPL_DM=y
-CONFIG_SPL_OF_TRANSLATE=y
-CONFIG_DM_I2C=y
-CONFIG_SYS_I2C_EEPROM_ADDR=0x50
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
-CONFIG_SMC911X=y
-CONFIG_SMC911X_32_BIT=y
-CONFIG_PINCTRL=y
-CONFIG_PINCTRL_SINGLE=y
-CONFIG_DM_PMIC=y
-# CONFIG_SPL_PMIC_CHILDREN is not set
-CONFIG_DM_REGULATOR=y
-CONFIG_DM_REGULATOR_FIXED=y
-CONFIG_DM_REGULATOR_GPIO=y
-CONFIG_SPECIFY_CONSOLE_INDEX=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_OMAP3_SPI=y
-CONFIG_USB=y
-# CONFIG_SPL_DM_USB is not set
-CONFIG_USB_EHCI_HCD=y
-# CONFIG_USB_EHCI_OMAP is not set
-CONFIG_USB_MUSB_HOST=y
-CONFIG_USB_MUSB_OMAP2PLUS=y
-CONFIG_TWL4030_USB=y
-CONFIG_BCH=y
diff --git a/configs/omap35_logic_somlv_defconfig b/configs/omap35_logic_somlv_defconfig
deleted file mode 100644
index ac792437a28..00000000000
--- a/configs/omap35_logic_somlv_defconfig
+++ /dev/null
@@ -1,103 +0,0 @@
-CONFIG_ARM=y
-# CONFIG_SPL_USE_ARCH_MEMCPY is not set
-# CONFIG_SPL_USE_ARCH_MEMSET is not set
-CONFIG_ARCH_OMAP2PLUS=y
-CONFIG_TEXT_BASE=0x80100000
-CONFIG_SYS_MALLOC_F_LEN=0x3000
-CONFIG_TI_COMMON_CMD_OPTIONS=y
-# CONFIG_SPL_GPIO is not set
-CONFIG_DEFAULT_DEVICE_TREE="ti/omap/logicpd-som-lv-35xx-devkit"
-CONFIG_TARGET_OMAP3_LOGIC=y
-# CONFIG_SPL_OMAP3_ID_NAND is not set
-CONFIG_SPL=y
-CONFIG_LTO=y
-CONFIG_SYS_MONITOR_BASE=0x10000000
-CONFIG_ANDROID_BOOT_IMAGE=y
-CONFIG_DISTRO_DEFAULTS=y
-CONFIG_BOOTCOMMAND="run autoboot"
-CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="setenv preboot;saveenv;"
-CONFIG_DEFAULT_FDT_FILE="logicpd-som-lv-35xx-devkit.dtb"
-CONFIG_SYS_PBSIZE=1054
-CONFIG_SYS_CONSOLE_INFO_QUIET=y
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
-CONFIG_SYS_NAND_SPL_KERNEL_OFFS=0x280000
-CONFIG_SPL_FALCON_BOOT_MMCSD=y
-CONFIG_SYS_MMCSD_RAW_MODE_KERNEL_SECTOR=0x1700
-CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTOR=0x1500
-CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTORS=0x200
-# CONFIG_SPL_POWER is not set
-CONFIG_SYS_PROMPT="OMAP Logic # "
-# CONFIG_CMD_IMI is not set
-CONFIG_CMD_SPL_NAND_OFS=0x240000
-CONFIG_CMD_SPL_WRITE_SIZE=0x20000
-CONFIG_CMD_NAND=y
-CONFIG_CMD_NAND_LOCK_UNLOCK=y
-CONFIG_SYS_DISABLE_AUTOLOAD=y
-CONFIG_CMD_UUID=y
-CONFIG_CMD_MTDPARTS=y
-CONFIG_MTDIDS_DEFAULT="nand0=omap2-nand.0,nor0=physmap-flash.0"
-CONFIG_MTDPARTS_DEFAULT="mtdparts=omap2-nand.0:512k(MLO),1792k(u-boot),128k(spl-os),128k(u-boot-env),6m(kernel),-(fs);physmap-flash.0:-(nor)"
-CONFIG_CMD_UBI=y
-CONFIG_OF_CONTROL=y
-CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_UPSTREAM=y
-CONFIG_ENV_OVERWRITE=y
-# CONFIG_ENV_IS_IN_FAT is not set
-CONFIG_ENV_IS_IN_NAND=y
-CONFIG_VERSION_VARIABLE=y
-CONFIG_SPL_DM=y
-CONFIG_DM_I2C=y
-CONFIG_SYS_I2C_EEPROM_ADDR=0x50
-CONFIG_MMC_OMAP_HS=y
-CONFIG_MTD=y
-CONFIG_MTD_NOR_FLASH=y
-CONFIG_FLASH_CFI_DRIVER=y
-CONFIG_SYS_FLASH_CFI_WIDTH_16BIT=y
-CONFIG_FLASH_SHOW_PROGRESS=0
-CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
-CONFIG_FLASH_CFI_MTD=y
-CONFIG_SYS_FLASH_PROTECTION=y
-CONFIG_SYS_FLASH_CFI=y
-CONFIG_SYS_MAX_FLASH_SECT=256
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
-CONFIG_SMC911X=y
-CONFIG_SMC911X_32_BIT=y
-CONFIG_PINCTRL=y
-CONFIG_PINCTRL_SINGLE=y
-CONFIG_DM_PMIC=y
-# CONFIG_SPL_PMIC_CHILDREN is not set
-CONFIG_DM_REGULATOR=y
-CONFIG_DM_REGULATOR_FIXED=y
-CONFIG_DM_REGULATOR_GPIO=y
-CONFIG_SPECIFY_CONSOLE_INDEX=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_OMAP3_SPI=y
-CONFIG_USB=y
-# CONFIG_SPL_DM_USB is not set
-CONFIG_USB_EHCI_HCD=y
-CONFIG_USB_MUSB_HOST=y
-CONFIG_USB_MUSB_OMAP2PLUS=y
-CONFIG_TWL4030_USB=y
-CONFIG_BCH=y
diff --git a/configs/omap3_logic_defconfig b/configs/omap3_logic_defconfig
deleted file mode 100644
index 6eebb9cc4e1..00000000000
--- a/configs/omap3_logic_defconfig
+++ /dev/null
@@ -1,93 +0,0 @@
-CONFIG_ARM=y
-# CONFIG_SPL_USE_ARCH_MEMCPY is not set
-# CONFIG_SPL_USE_ARCH_MEMSET is not set
-CONFIG_ARCH_OMAP2PLUS=y
-CONFIG_TEXT_BASE=0x80100000
-CONFIG_SYS_MALLOC_F_LEN=0x3000
-CONFIG_TI_COMMON_CMD_OPTIONS=y
-# CONFIG_SPL_GPIO is not set
-CONFIG_DEFAULT_DEVICE_TREE="ti/omap/logicpd-torpedo-37xx-devkit"
-CONFIG_TARGET_OMAP3_LOGIC=y
-# CONFIG_SPL_OMAP3_ID_NAND is not set
-CONFIG_SPL=y
-CONFIG_LTO=y
-CONFIG_ANDROID_BOOT_IMAGE=y
-CONFIG_DISTRO_DEFAULTS=y
-CONFIG_BOOTCOMMAND="run autoboot"
-CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="setenv preboot;saveenv;"
-CONFIG_SYS_PBSIZE=1054
-CONFIG_SYS_CONSOLE_INFO_QUIET=y
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
-CONFIG_SYS_NAND_SPL_KERNEL_OFFS=0x280000
-CONFIG_SPL_FALCON_BOOT_MMCSD=y
-CONFIG_SYS_MMCSD_RAW_MODE_KERNEL_SECTOR=0x1700
-CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTOR=0x1500
-CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTORS=0x200
-CONFIG_SYS_PROMPT="OMAP Logic # "
-# CONFIG_CMD_IMI is not set
-CONFIG_CMD_SPL_NAND_OFS=0x240000
-CONFIG_CMD_SPL_WRITE_SIZE=0x20000
-CONFIG_CMD_NAND=y
-CONFIG_CMD_NAND_LOCK_UNLOCK=y
-CONFIG_SYS_DISABLE_AUTOLOAD=y
-CONFIG_CMD_UUID=y
-CONFIG_CMD_MTDPARTS=y
-CONFIG_MTDIDS_DEFAULT="nand0=omap2-nand.0"
-CONFIG_MTDPARTS_DEFAULT="mtdparts=omap2-nand.0:512k(MLO),1792k(u-boot),128k(spl-os),128k(u-boot-env),6m(kernel),-(fs)"
-CONFIG_CMD_UBI=y
-CONFIG_OF_CONTROL=y
-CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_UPSTREAM=y
-CONFIG_ENV_OVERWRITE=y
-# CONFIG_ENV_IS_IN_FAT is not set
-CONFIG_ENV_IS_IN_NAND=y
-CONFIG_VERSION_VARIABLE=y
-CONFIG_SPL_DM=y
-CONFIG_DM_I2C=y
-CONFIG_SYS_I2C_EEPROM_ADDR=0x50
-CONFIG_MMC_OMAP_HS=y
-CONFIG_MMC_OMAP36XX_PINS=y
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
-CONFIG_SMC911X=y
-CONFIG_SMC911X_32_BIT=y
-CONFIG_PINCTRL=y
-CONFIG_PINCTRL_SINGLE=y
-CONFIG_DM_PMIC=y
-# CONFIG_SPL_PMIC_CHILDREN is not set
-CONFIG_DM_REGULATOR=y
-CONFIG_DM_REGULATOR_FIXED=y
-CONFIG_DM_REGULATOR_GPIO=y
-CONFIG_SPECIFY_CONSOLE_INDEX=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_OMAP3_SPI=y
-CONFIG_USB=y
-# CONFIG_SPL_DM_USB is not set
-CONFIG_USB_EHCI_HCD=y
-# CONFIG_USB_EHCI_OMAP is not set
-CONFIG_USB_MUSB_HOST=y
-CONFIG_USB_MUSB_OMAP2PLUS=y
-CONFIG_TWL4030_USB=y
-CONFIG_BCH=y
diff --git a/configs/omap3_logic_somlv_defconfig b/configs/omap3_logic_somlv_defconfig
deleted file mode 100644
index f2b4f83ff19..00000000000
--- a/configs/omap3_logic_somlv_defconfig
+++ /dev/null
@@ -1,104 +0,0 @@
-CONFIG_ARM=y
-# CONFIG_SPL_USE_ARCH_MEMCPY is not set
-# CONFIG_SPL_USE_ARCH_MEMSET is not set
-CONFIG_ARCH_OMAP2PLUS=y
-CONFIG_TEXT_BASE=0x80100000
-CONFIG_SYS_MALLOC_F_LEN=0x3000
-CONFIG_TI_COMMON_CMD_OPTIONS=y
-# CONFIG_SPL_GPIO is not set
-CONFIG_DEFAULT_DEVICE_TREE="ti/omap/logicpd-som-lv-37xx-devkit"
-CONFIG_TARGET_OMAP3_LOGIC=y
-# CONFIG_SPL_OMAP3_ID_NAND is not set
-CONFIG_SPL=y
-CONFIG_LTO=y
-CONFIG_SYS_MONITOR_BASE=0x10000000
-CONFIG_ANDROID_BOOT_IMAGE=y
-CONFIG_DISTRO_DEFAULTS=y
-CONFIG_BOOTCOMMAND="run autoboot"
-CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="setenv preboot;saveenv;"
-CONFIG_DEFAULT_FDT_FILE="logicpd-som-lv-37xx-devkit.dtb"
-CONFIG_SYS_PBSIZE=1054
-CONFIG_SYS_CONSOLE_INFO_QUIET=y
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
-CONFIG_SYS_NAND_SPL_KERNEL_OFFS=0x280000
-CONFIG_SPL_FALCON_BOOT_MMCSD=y
-CONFIG_SYS_MMCSD_RAW_MODE_KERNEL_SECTOR=0x1700
-CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTOR=0x1500
-CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTORS=0x200
-# CONFIG_SPL_POWER is not set
-CONFIG_SYS_PROMPT="OMAP Logic # "
-# CONFIG_CMD_IMI is not set
-CONFIG_CMD_SPL_NAND_OFS=0x240000
-CONFIG_CMD_SPL_WRITE_SIZE=0x20000
-CONFIG_CMD_NAND=y
-CONFIG_CMD_NAND_LOCK_UNLOCK=y
-CONFIG_SYS_DISABLE_AUTOLOAD=y
-CONFIG_CMD_UUID=y
-CONFIG_CMD_MTDPARTS=y
-CONFIG_MTDIDS_DEFAULT="nand0=omap2-nand.0,nor0=physmap-flash.0"
-CONFIG_MTDPARTS_DEFAULT="mtdparts=omap2-nand.0:512k(MLO),1792k(u-boot),128k(spl-os),128k(u-boot-env),6m(kernel),-(fs);physmap-flash.0:-(nor)"
-CONFIG_CMD_UBI=y
-CONFIG_OF_CONTROL=y
-CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_UPSTREAM=y
-CONFIG_ENV_OVERWRITE=y
-# CONFIG_ENV_IS_IN_FAT is not set
-CONFIG_ENV_IS_IN_NAND=y
-CONFIG_VERSION_VARIABLE=y
-CONFIG_SPL_DM=y
-CONFIG_DM_I2C=y
-CONFIG_SYS_I2C_EEPROM_ADDR=0x50
-CONFIG_MMC_OMAP_HS=y
-CONFIG_MMC_OMAP36XX_PINS=y
-CONFIG_MTD=y
-CONFIG_MTD_NOR_FLASH=y
-CONFIG_FLASH_CFI_DRIVER=y
-CONFIG_SYS_FLASH_CFI_WIDTH_16BIT=y
-CONFIG_FLASH_SHOW_PROGRESS=0
-CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
-CONFIG_FLASH_CFI_MTD=y
-CONFIG_SYS_FLASH_PROTECTION=y
-CONFIG_SYS_FLASH_CFI=y
-CONFIG_SYS_MAX_FLASH_SECT=256
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
-CONFIG_SMC911X=y
-CONFIG_SMC911X_32_BIT=y
-CONFIG_PINCTRL=y
-CONFIG_PINCTRL_SINGLE=y
-CONFIG_DM_PMIC=y
-# CONFIG_SPL_PMIC_CHILDREN is not set
-CONFIG_DM_REGULATOR=y
-CONFIG_DM_REGULATOR_FIXED=y
-CONFIG_DM_REGULATOR_GPIO=y
-CONFIG_SPECIFY_CONSOLE_INDEX=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_OMAP3_SPI=y
-CONFIG_USB=y
-# CONFIG_SPL_DM_USB is not set
-CONFIG_USB_EHCI_HCD=y
-CONFIG_USB_MUSB_HOST=y
-CONFIG_USB_MUSB_OMAP2PLUS=y
-CONFIG_TWL4030_USB=y
-CONFIG_BCH=y
diff --git a/drivers/mmc/omap_hsmmc.c b/drivers/mmc/omap_hsmmc.c
index ae742080643..2cf3e4e5d34 100644
--- a/drivers/mmc/omap_hsmmc.c
+++ b/drivers/mmc/omap_hsmmc.c
@@ -226,10 +226,6 @@ static unsigned char mmc_board_init(struct mmc *mmc)
 	/* for cairo board, we need to set up 1.8 Volt bias level on MMC1 */
 	pbias_lite &= ~PBIASLITEVMODE0;
 #endif
-#ifdef CONFIG_TARGET_OMAP3_LOGIC
-	/* For Logic PD board, 1.8V bias to go enable gpio127 for mmc_cd */
-	pbias_lite &= ~PBIASLITEVMODE1;
-#endif
 #ifdef CONFIG_MMC_OMAP36XX_PINS
 	if (get_cpu_family() == CPU_OMAP36XX) {
 		/* Disable extended drain IO before changing PBIAS */
diff --git a/include/configs/omap3_logic.h b/include/configs/omap3_logic.h
deleted file mode 100644
index 957f1c369e6..00000000000
--- a/include/configs/omap3_logic.h
+++ /dev/null
@@ -1,152 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * (C) Copyright 2011 Logic Product Development <www.logicpd.com>
- *	Peter Barada <peter.barada@logicpd.com>
- *
- * Configuration settings for the Logic OMAP35x/DM37x SOM LV/Torpedo
- * reference boards.
- */
-
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-/* High Level Configuration Options */
-
-#include <configs/ti_omap3_common.h>
-
-/* Board NAND Info. */
-#ifdef CONFIG_MTD_RAW_NAND
-						  /* NAND devices */
-#define CFG_SYS_NAND_ECCPOS		{2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, \
-					 13, 14, 16, 17, 18, 19, 20, 21, 22, \
-					 23, 24, 25, 26, 27, 28, 30, 31, 32, \
-					 33, 34, 35, 36, 37, 38, 39, 40, 41, \
-					 42, 44, 45, 46, 47, 48, 49, 50, 51, \
-					 52, 53, 54, 55, 56}
-
-#define CFG_SYS_NAND_ECCSIZE		512
-#define CFG_SYS_NAND_ECCBYTES	13
-#endif
-
-/* Environment information */
-
-#define CFG_EXTRA_ENV_SETTINGS \
-	DEFAULT_LINUX_BOOT_ENV \
-	"mmcdev=0\0" \
-	"finduuid=part uuid mmc ${mmcdev}:2 uuid\0" \
-	"mmcrootfstype=ext4 rootwait\0" \
-	"nandroot=ubi0:rootfs rw ubi.mtd=fs noinitrd\0" \
-	"nandrootfstype=ubifs rootwait\0" \
-	"autoboot=mmc dev ${mmcdev}; if mmc rescan; then " \
-			"if run loadbootscript; then " \
-				"run bootscript; " \
-			"else " \
-				"run defaultboot;" \
-			"fi; " \
-		"else run defaultboot; fi\0" \
-	"defaultboot=run mmcramboot\0" \
-	"consoledevice=ttyS0\0" \
-	"setconsole=setenv console ${consoledevice},${baudrate}n8\0" \
-	"dump_bootargs=echo 'Bootargs: '; echo $bootargs\0" \
-	"rotation=0\0" \
-	"vrfb_arg=if itest ${rotation} -ne 0; then " \
-		"setenv bootargs ${bootargs} omapfb.vrfb=y " \
-		"omapfb.rotate=${rotation}; " \
-		"fi\0" \
-	"optargs=ignore_loglevel early_printk no_console_suspend\0" \
-	"common_bootargs=run setconsole; setenv bootargs " \
-		"${bootargs} "\
-		"console=${console} " \
-		"${mtdparts} "\
-		"${optargs}; " \
-		"run vrfb_arg\0" \
-	"loadbootscript=load mmc ${mmcdev} ${loadaddr} boot.scr\0" \
-	"bootscript=echo 'Running bootscript from mmc ...'; " \
-		"source ${loadaddr}\0" \
-	"loadimage=mmc rescan; " \
-		"load mmc ${mmcdev} ${loadaddr} ${bootfile}\0" \
-	"ramdisksize=64000\0" \
-	"ramdiskimage=rootfs.ext2.gz.uboot\0" \
-	"loadramdisk=mmc rescan; " \
-		"load mmc ${mmcdev} ${rdaddr} ${ramdiskimage}\0" \
-	"ramargs=setenv bootargs "\
-		"root=/dev/ram rw ramdisk_size=${ramdisksize}\0" \
-	"mmcargs=setenv bootargs "\
-		"root=PARTUUID=${uuid} " \
-		"rootfstype=${mmcrootfstype} rw\0" \
-	"nandargs=setenv bootargs "\
-		"root=${nandroot} " \
-		"rootfstype=${nandrootfstype}\0" \
-	"nfsargs=setenv serverip ${tftpserver}; " \
-		"setenv bootargs root=/dev/nfs " \
-		"nfsroot=${nfsrootpath} " \
-		"ip=${ipaddr}:${tftpserver}:${gatewayip}:${netmask}::eth0:off\0" \
-	"nfsrootpath=/opt/nfs-exports/omap\0" \
-	"fdtimage=" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" \
-	"loadfdt=mmc rescan; " \
-		"load mmc ${mmcdev} ${fdtaddr} ${fdtimage}\0" \
-	"mmcbootcommon=echo Booting with DT from mmc${mmcdev} ...; " \
-		"run finduuid; "\
-		"run mmcargs; " \
-		"run common_bootargs; " \
-		"run dump_bootargs; " \
-		"run loadimage; " \
-		"run loadfdt;\0 " \
-	"mmcbootz=setenv bootfile zImage; " \
-		"run mmcbootcommon; "\
-		"bootz ${loadaddr} - ${fdtaddr}\0" \
-	"mmcboot=setenv bootfile uImage; "\
-		"run mmcbootcommon; "\
-		"bootm ${loadaddr} - ${fdtaddr}\0" \
-	"mmcrambootcommon=echo 'Booting kernel from MMC w/ramdisk...'; " \
-		"run ramargs; " \
-		"run common_bootargs; " \
-		"run dump_bootargs; " \
-		"run loadimage; " \
-		"run loadfdt; " \
-		"run loadramdisk\0" \
-	"mmcramboot=setenv bootfile uImage; " \
-		"run mmcrambootcommon; " \
-		"bootm ${loadaddr} ${rdaddr} ${fdtaddr}\0" \
-	"mmcrambootz=setenv bootfile zImage; " \
-		"run mmcrambootcommon; " \
-		"bootz ${loadaddr} ${rdaddr} ${fdtaddr}\0" \
-	"tftpboot=echo 'Booting kernel/ramdisk rootfs from tftp...'; " \
-		"run ramargs; " \
-		"run common_bootargs; " \
-		"run dump_bootargs; " \
-		"tftpboot ${loadaddr} ${zimage}; " \
-		"tftpboot ${rdaddr} ${ramdiskimage}; " \
-		"bootm ${loadaddr} ${rdaddr}\0" \
-	"tftpbootz=echo 'Booting kernel NFS rootfs...'; " \
-		"dhcp;" \
-		"run nfsargs;" \
-		"run common_bootargs;" \
-		"run dump_bootargs;" \
-		"tftpboot $loadaddr zImage;" \
-		"bootz $loadaddr\0" \
-	"nandbootcommon=echo 'Booting kernel from NAND...';" \
-		"run nandargs;" \
-		"run common_bootargs;" \
-		"run dump_bootargs;" \
-		"nand read ${loadaddr} kernel;" \
-		"nand read ${fdtaddr} spl-os;\0" \
-	"nandbootz=run nandbootcommon; "\
-		"bootz ${loadaddr} - ${fdtaddr}\0"\
-	"nandboot=run nandbootcommon; "\
-		"bootm ${loadaddr} - ${fdtaddr}\0"\
-
-/* Miscellaneous configurable options */
-
-/* memtest works on */
-
-/* FLASH and environment organization */
-
-/* **** PISMO SUPPORT *** */
-#if defined(CONFIG_CMD_NAND)
-#define CFG_SYS_FLASH_BASE		0x10000000
-#endif
-
-#define CFG_SYS_FLASH_SIZE		0x4000000
-
-#endif /* __CONFIG_H */
-- 
2.53.0

