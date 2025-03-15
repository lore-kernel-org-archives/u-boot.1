Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F82C28B30
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 01:29:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01874820FE;
	Sat, 15 Mar 2025 02:29:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U7AIv9Wi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02966820FE; Sat, 15 Mar 2025 02:29:18 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E0048210E
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 02:29:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-476964b2c1dso13747381cf.3
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 18:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742002154; x=1742606954; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UbEgWFYCj/KgYxyNtlraPBrE2chesUhN0p8gcTlHpeQ=;
 b=U7AIv9Wixvw5ki/I+N1QFfHG0rztndkqh4UOn2cY3TYJHIRuH3bVpSSOz00zgnNxhY
 jCZn/VezejljO7STkZH27Cu2bma86eidaEx5KpgtMlBep3xVVvb5o441elnmFtihjlKc
 z7dhoX6zPziHNQwDkj4tgf4VD41iLKUeEqwvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742002154; x=1742606954;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UbEgWFYCj/KgYxyNtlraPBrE2chesUhN0p8gcTlHpeQ=;
 b=XanZSB+5IdkzgFZySvylh0J2dAplli68c3EiWbFAU9Fhv6tCuZ41NvgpPM8ITVzdIU
 1fupDgQo+mOB/lQ5PoHDVDZMwYHBSPUL/f/yiBAwjZqVa1ckYBFg1lMggT4QkM5FtlO/
 xEK23zKdM/hQ8eizsNTAPI/ZchLSE4+1LrPi7acMULY29dIT7UO442q3xyibuqfndJ1i
 VkHh20IElUj88Oa1RxNQE5pI/hq+6K5GcNWFShwWXFu6Aq4ppRGv0LwBs0LXjlxS8896
 k+Xrx4Czw7JGfcnq6eO9VorX5ZsOChXm4bIlv6jzIobQh9OP8GtlVh6SgCeCBp+ddOQs
 tGiQ==
X-Gm-Message-State: AOJu0YyKEVCAdLwXEzueSuS2vNalOQWVKuaM4XtmptE4UAvHkq+4YH/w
 i0C4vC+yX4OZcRm96bRwA7aKMM/fni/XvbDIVuBRRHOls3jRkwrD/UsNUr4JhsuS9dJ5G0T2jga
 q
X-Gm-Gg: ASbGnctRswH8mYccWxbD4hMtGYNJXp+YQMVHlvXpSnsTzgiTeA6qIddar3jsgX0qjfX
 NWxrcEAMK7g3Pf1BBjsM7GjuusMRmdDbf2nUfEdSzLTWX6SAZf4OwldHco5KPymhu+oCx9yIZb6
 ItqqLo2Xx+4yTXddoWuj+6nx6ElCRj8pjDLTSz1sGKTAgzN45CY8uw0D+ZvH3/IJh0IjQ+mHUVe
 ZYljarU2MHf+Jr2+wongfWzMysS24XM+XU4x6j14eICLxOXsBztR4ksll09qig+4WjuhVZFE+ms
 xL24ZZiufC3ewqkV4pjk2SpQMmfzl6E9jjD6QG3V4yGfXKZN8Rqk6tVUgAA=
X-Google-Smtp-Source: AGHT+IF0J7UV4XaXl0yLwrgzBvOxBXACYTsNBKRw/Uee5C58robMOneZDEAu4+MxR4n83Ik5dhJO/Q==
X-Received: by 2002:a05:622a:41cb:b0:476:9377:17aa with SMTP id
 d75a77b69052e-476c81ef817mr62721781cf.52.1742002154576; 
 Fri, 14 Mar 2025 18:29:14 -0700 (PDT)
Received: from bill-the-cat.. ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb82da6fsm29379311cf.72.2025.03.14.18.29.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 18:29:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH] ARM: renesas: Drop 'imply MULTI_DTB_FIT_USER_DEFINED_AREA'
 lines
Date: Fri, 14 Mar 2025 19:29:11 -0600
Message-ID: <20250315012911.399422-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

As the code is today, we get a warning about "select" statements on
"choice" options not doing anything. This is why for all of the boards
which had an 'imply MULTI_DTB_FIT_USER_DEFINED_AREA' they then also had
to set the option in the defconfig. Drop the imply lines here.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 arch/arm/mach-renesas/Kconfig       | 1 -
 arch/arm/mach-renesas/Kconfig.rcar3 | 4 ----
 2 files changed, 5 deletions(-)

diff --git a/arch/arm/mach-renesas/Kconfig b/arch/arm/mach-renesas/Kconfig
index aeb55da609bd..86135f10b8f6 100644
--- a/arch/arm/mach-renesas/Kconfig
+++ b/arch/arm/mach-renesas/Kconfig
@@ -74,7 +74,6 @@ config RZG2L
 	select RCAR_64
 	imply CLK_RZG2L
 	imply MULTI_DTB_FIT
-	imply MULTI_DTB_FIT_USER_DEFINED_AREA
 	imply PINCTRL_RZG2L
 	imply RENESAS_SDHI
 	imply RZG2L_GPIO
diff --git a/arch/arm/mach-renesas/Kconfig.rcar3 b/arch/arm/mach-renesas/Kconfig.rcar3
index ad35d1058f29..0d5f74862182 100644
--- a/arch/arm/mach-renesas/Kconfig.rcar3
+++ b/arch/arm/mach-renesas/Kconfig.rcar3
@@ -91,7 +91,6 @@ config TARGET_BEACON_RZG2M
 	imply CLK_CCF
 	imply CLK_VERSACLOCK
 	imply MULTI_DTB_FIT
-	imply MULTI_DTB_FIT_USER_DEFINED_AREA
 
 config TARGET_CONDOR
 	bool "Condor board"
@@ -130,7 +129,6 @@ config TARGET_EBISU
 config TARGET_HIHOPE_RZG2
 	bool "HiHope RZ/G2 board"
 	imply MULTI_DTB_FIT
-	imply MULTI_DTB_FIT_USER_DEFINED_AREA
 	imply R8A774A1
 	imply R8A774B1
 	imply R8A774E1
@@ -149,7 +147,6 @@ config TARGET_SILINUX_EK874
 config TARGET_SALVATOR_X
 	bool "Salvator-X board"
 	imply MULTI_DTB_FIT
-	imply MULTI_DTB_FIT_USER_DEFINED_AREA
 	imply R8A7795
 	imply R8A7796
 	imply R8A77965
@@ -160,7 +157,6 @@ config TARGET_SALVATOR_X
 config TARGET_ULCB
 	bool "ULCB board"
 	imply MULTI_DTB_FIT
-	imply MULTI_DTB_FIT_USER_DEFINED_AREA
 	imply R8A7795
 	imply R8A7796
 	imply R8A77965
-- 
2.43.0

