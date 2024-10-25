Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99BC7D1039C
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 02:02:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04E6088F83;
	Fri, 25 Oct 2024 04:02:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bqUnGvko";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8A1A88B0C; Fri, 25 Oct 2024 04:02:39 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA8A588FBF
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 04:02:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mr.bossman075@gmail.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7b13fe8f4d0so106090285a.0
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 19:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729821750; x=1730426550; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Qf2km1sVoj38LAoHSbncMebl/iwPREBdiLFqLWYuvbE=;
 b=bqUnGvkoMFoidPMAH9nh1vWnjj2KYzZxWq0QwIr0pRXIB5MT5b71pMAoXDNMn+1WBp
 hP/vcJCbBwXVt2u+vSHXBABIOcOs0nviHXOFV5J6s4JrKlY88K7PT2qS0kOjizUd+U39
 CGv68etoK3c1U+VJUd8Wd3MQ+HCko5ihu0KkU9azTzgbB8fKkP3QiYHGXcJbYYx2dXKm
 4WLs7fHV8bmrdkiiKHwFtQITaNE2Vh8tA3HHFgk/kMFV6g6RP7AHfgx8lvx2BJ0fAC6g
 90FW9szQ6kDfYUZIwan5WE6ZuJJ0F94hHknHbQcc0wZ4ONp4CMxVwoKCZZ4wrfjYBhOF
 YexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729821750; x=1730426550;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qf2km1sVoj38LAoHSbncMebl/iwPREBdiLFqLWYuvbE=;
 b=PfKIi0iTmYAVPyyC+nB6b7nviqVz7/xHhGR0H4Xb69+osNAUvpImsnm6xF30jRfup6
 8jHolQ5tGKwAzg8jUkIGQ4QlgPs5tT7v+UShifZTssOKQdh4OEZYsdRSAQ0BGFfibX+h
 8mikKCzbDcaUofIKgm8OTLzqvgCG/X3n8Wxak4NUBI2TKiMX9b8A8h2fVM4hVBDSvG3k
 HVpHWNWMVvUDBPEJztM0hXJWGwvJ/+meI6zr/MQJsUXqkgMLCezGX5YXgtQsASPxCI+w
 w96MYHJZC2vd1Yt26zm2smlsrgsYWwAieGjy2x7ek7E3a5Bf7HzFvblQuULHX7KoyQ9a
 fEHA==
X-Gm-Message-State: AOJu0Yx162lwM88ttcOsI05wEDkkOCEeW1nMquVlnSHlSfXY75HuqoWT
 OtCTgTiKbJQtLRf6XbfZlJiLpE6HlanX1CsFv54QRP2WtbcwjVdLpXP0hn95
X-Google-Smtp-Source: AGHT+IF9reYre7qMYzTPcPAHBWRQg5LyTo6c49zSPu02y+3oTPrgy5sOQxR8FJLHTJRY+VGMqBwuyg==
X-Received: by 2002:a05:620a:240a:b0:7a7:fdef:27a with SMTP id
 af79cd13be357-7b17e5bc63emr1107339085a.58.1729821750278; 
 Thu, 24 Oct 2024 19:02:30 -0700 (PDT)
Received: from jesse-desktop.. (pool-108-26-179-17.bstnma.fios.verizon.net.
 [108.26.179.17]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d294b3fsm11607585a.33.2024.10.24.19.02.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 19:02:29 -0700 (PDT)
From: Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To: u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Jesse Taube <Mr.Bossman075@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/4] imx: imxrt*: Fix binman breaking boot
Date: Thu, 24 Oct 2024 22:02:25 -0400
Message-ID: <20241025020228.1686306-1-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.45.2
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

The init_r parsing of U-Boot device tree to search the binman
information errors. set CONFIG_BINMAN_FDT to no to fix this.

Fixes: 7079eeb72fc ("imx: imxrt1050-evk: Add support for SPI flash booting
s")
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
 configs/imxrt1020-evk_defconfig      | 1 +
 configs/imxrt1050-evk_defconfig      | 1 +
 configs/imxrt1050-evk_fspi_defconfig | 1 +
 configs/imxrt1170-evk_defconfig      | 1 +
 4 files changed, 4 insertions(+)

diff --git a/configs/imxrt1020-evk_defconfig b/configs/imxrt1020-evk_defconfig
index 5865d41a741..58a3e92ce08 100644
--- a/configs/imxrt1020-evk_defconfig
+++ b/configs/imxrt1020-evk_defconfig
@@ -67,6 +67,7 @@ CONFIG_FSL_LPUART=y
 CONFIG_TIMER=y
 CONFIG_SPL_TIMER=y
 CONFIG_IMX_GPT_TIMER=y
+# CONFIG_BINMAN_FDT is not set
 CONFIG_SHA1=y
 CONFIG_SHA256=y
 CONFIG_HEXDUMP=y
diff --git a/configs/imxrt1050-evk_defconfig b/configs/imxrt1050-evk_defconfig
index f8b85398b79..2653efac148 100644
--- a/configs/imxrt1050-evk_defconfig
+++ b/configs/imxrt1050-evk_defconfig
@@ -84,5 +84,6 @@ CONFIG_VIDEO_MXS=y
 CONFIG_SPLASH_SCREEN=y
 CONFIG_SPLASH_SCREEN_ALIGN=y
 CONFIG_BMP_16BPP=y
+# CONFIG_BINMAN_FDT is not set
 CONFIG_SHA256=y
 CONFIG_HEXDUMP=y
diff --git a/configs/imxrt1050-evk_fspi_defconfig b/configs/imxrt1050-evk_fspi_defconfig
index 73001ffe161..95b5b56ece7 100644
--- a/configs/imxrt1050-evk_fspi_defconfig
+++ b/configs/imxrt1050-evk_fspi_defconfig
@@ -85,6 +85,7 @@ CONFIG_VIDEO_MXS=y
 CONFIG_SPLASH_SCREEN=y
 CONFIG_SPLASH_SCREEN_ALIGN=y
 CONFIG_BMP_16BPP=y
+# CONFIG_BINMAN_FDT is not set
 CONFIG_SHA256=y
 CONFIG_HEXDUMP=y
 CONFIG_FSPI_CONF_HEADER=y
diff --git a/configs/imxrt1170-evk_defconfig b/configs/imxrt1170-evk_defconfig
index 5f28c22e66c..487da275c62 100644
--- a/configs/imxrt1170-evk_defconfig
+++ b/configs/imxrt1170-evk_defconfig
@@ -68,3 +68,4 @@ CONFIG_FSL_LPUART=y
 CONFIG_TIMER=y
 CONFIG_SPL_TIMER=y
 CONFIG_IMX_GPT_TIMER=y
+# CONFIG_BINMAN_FDT is not set
-- 
2.45.2

