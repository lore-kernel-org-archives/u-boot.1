Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25270C48BC4
	for <u-boot@archiver.kernel.org>; Sun, 18 Feb 2024 21:20:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22F1087ED2;
	Sun, 18 Feb 2024 22:20:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R5BUAMJH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 679A18573F; Sun, 18 Feb 2024 22:20:18 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01E8787EBD
 for <u-boot@lists.denx.de>; Sun, 18 Feb 2024 22:20:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mr.bossman075@gmail.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-dcc86086c9fso3608239276.3
 for <u-boot@lists.denx.de>; Sun, 18 Feb 2024 13:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708291200; x=1708896000; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8rQljSIFqFzBgkBOWBJFJhANpJ9TUHheFX2elvh4eso=;
 b=R5BUAMJHQqhWPcc30+VD2VNcnj2g0zMUwGkCSeoQDt9iYIIfuNf1G8ILUmA9u0NwXk
 IDprv0jhR5Y6Y6uRP8OMqT8FYdAj6ZjfPZq2W0t9YskEqRsWJWGBVB6uT0voOq+C0ZsO
 JsSASV8h/5NSsesY99Ai1ewmgrfPyr/sjFT6EHzvAc6DN2RXI+59kFo0Qy5cpPKMlNa5
 dkFfwuCtvCvWjlG3y7QwjNvxzIv6O4P3gymtIwItFwxzePpxngZJ3TTu5v2kmekvaZ4p
 BtnMwJUZLPFZ4lxh2HMoVaPZARajPXi96zZkgoQVIGW4q9H65x000E0bNKXMp4+ucj1A
 Jg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708291200; x=1708896000;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8rQljSIFqFzBgkBOWBJFJhANpJ9TUHheFX2elvh4eso=;
 b=R1R0zB/uBEeZOxfJVX9LVfBnq27Ds6kHr4Be2RT0BUaptqfKviShGLNyqXKNUJiNRG
 yIzFSc7XYsi+QbP147Bg2fzzsLqUjLYOXKlVMDDGIBL5PnNX5LwNY+PKtRRaJJlMfgtO
 imYmEQeA9sMG86hTK5YMj11liTcWUEIxNxhWf3is9NNdNjSsupMzJfH2Ku5lLYE0qgka
 Tn9hEb+TbY0gnQtvUsPhZVJicL90cmn9z6BtOHiC9IPV9KUbfFdW8NV+Mdr7qh8Ig8z/
 7HRRX6mlz/QDKoqtHlTZxY2fKeBt290gNmF0F/YkgGIgT5KQvjedAEGQ0fLEV145BuDR
 Gfkg==
X-Gm-Message-State: AOJu0YybVi4T4Akuoq68R3hV8qv0vK0NOfLk5rYW4LGlM+MKA8i/MOhM
 nAagD+yQMVGrmCuajfNXVH7ScWw8MlPwCca3dw/JreUrKqKu8Szpj2l7Bfs68DE=
X-Google-Smtp-Source: AGHT+IH/n3ZRCSyMVDkxdXyP2CXVW3Ad5B7b18yjwLbJ+iVqCKck/T2AUz7sPfWJd7KaIyKM2z1pJQ==
X-Received: by 2002:a25:8204:0:b0:dcd:4878:1f9 with SMTP id
 q4-20020a258204000000b00dcd487801f9mr10639690ybk.8.1708291200060; 
 Sun, 18 Feb 2024 13:20:00 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab
 (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
 by smtp.gmail.com with ESMTPSA id
 o15-20020a05620a110f00b00785b02c5784sm1863219qkk.86.2024.02.18.13.19.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Feb 2024 13:19:59 -0800 (PST)
From: Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To: u-boot@lists.denx.de
Cc: Jesse Taube <Mr.Bossman075@gmail.com>,
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 1/3] arm: dts: imxrt: Add binman support
Date: Sun, 18 Feb 2024 16:19:56 -0500
Message-ID: <20240218211958.2849847-1-Mr.Bossman075@gmail.com>
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

Enable binman in Kconfig and in device tree.

Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
V2 -> V3:
 - New commit
---
 arch/arm/dts/imxrt1020-evk-u-boot.dtsi | 4 ++++
 arch/arm/dts/imxrt1050-evk-u-boot.dtsi | 4 ++++
 arch/arm/dts/imxrt1170-evk-u-boot.dtsi | 4 ++++
 arch/arm/mach-imx/imxrt/Kconfig        | 1 +
 4 files changed, 13 insertions(+)

diff --git a/arch/arm/dts/imxrt1020-evk-u-boot.dtsi b/arch/arm/dts/imxrt1020-evk-u-boot.dtsi
index 46928c07e9..e246de0299 100644
--- a/arch/arm/dts/imxrt1020-evk-u-boot.dtsi
+++ b/arch/arm/dts/imxrt1020-evk-u-boot.dtsi
@@ -5,6 +5,10 @@
  */
 
 / {
+	binman: binman {
+		multiple-images;
+	};
+
 	chosen {
 		bootph-pre-ram;
 	};
diff --git a/arch/arm/dts/imxrt1050-evk-u-boot.dtsi b/arch/arm/dts/imxrt1050-evk-u-boot.dtsi
index a9095e736b..8a9f6119b1 100644
--- a/arch/arm/dts/imxrt1050-evk-u-boot.dtsi
+++ b/arch/arm/dts/imxrt1050-evk-u-boot.dtsi
@@ -8,6 +8,10 @@
 #include "imxrt1050-pinfunc.h"
 
 / {
+	binman: binman {
+		multiple-images;
+	};
+
 	aliases {
 		display0 = &lcdif;
 		usbphy0 = &usbphy1;
diff --git a/arch/arm/dts/imxrt1170-evk-u-boot.dtsi b/arch/arm/dts/imxrt1170-evk-u-boot.dtsi
index f923a14301..6e892c1af7 100644
--- a/arch/arm/dts/imxrt1170-evk-u-boot.dtsi
+++ b/arch/arm/dts/imxrt1170-evk-u-boot.dtsi
@@ -6,6 +6,10 @@
  */
 
 / {
+	binman: binman {
+		multiple-images;
+	};
+
 	chosen {
 		bootph-pre-ram;
 	};
diff --git a/arch/arm/mach-imx/imxrt/Kconfig b/arch/arm/mach-imx/imxrt/Kconfig
index c1d6b09e77..ccccf702f6 100644
--- a/arch/arm/mach-imx/imxrt/Kconfig
+++ b/arch/arm/mach-imx/imxrt/Kconfig
@@ -2,6 +2,7 @@ if ARCH_IMXRT
 
 config IMXRT
 	bool
+	select BINMAN
 	select SYS_FSL_ERRATUM_ESDHC135
 
 config IMXRT1020
-- 
2.43.0

