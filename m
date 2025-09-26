Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D09DCAC5AE
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 15:31:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 717228382A;
	Fri, 26 Sep 2025 17:31:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OTF6RnIj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E75D8380F; Fri, 26 Sep 2025 17:31:38 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C341C83807
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 17:31:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-4248a13fbe9so12272875ab.1
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 08:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758900694; x=1759505494; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=n5xKL3Qk2gPWyscI3LFnczAHbMX1VzoZX1pah5Qj6Xw=;
 b=OTF6RnIj+rmZAm8kB6Gp+erNhPqxOzmKF+JvKVQNI7WO2kW3hGFSV2gNvzT1uvYtZj
 NCSL2eXWtwGFW4hhyMZbURcBOpf7vABB2Fbdya1GoPDrdr9r69bf4hFsM7EuaTEcFJzf
 GLoNaASW7ynK+9KrtsOEyuP1nUtGcUPvJNr1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758900694; x=1759505494;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n5xKL3Qk2gPWyscI3LFnczAHbMX1VzoZX1pah5Qj6Xw=;
 b=fN1BSUBVtTkFripJvpxdAyfvW0Zj+OvKsEtG7ZbR5DFYv11A+WnA/vmLh1vIMZBRqQ
 4dCltTn7RlYQMrEp2avTEa8CnuHG60UWHovs2pnSa7Uwf11UKR/cQOXGsFF7LHbJ/ZFY
 adIXvYUF6STn+JBlcQsDFL+wir56ER93rOfoVU1fLycwtLqAtxlgh9guFM5AtfK6+f4m
 ayTTS1GUaotFgCi/HmSUPd3ghPFiHaZ58usRDwSdp/GedYDJtwCx0AchH5L9kxdfG+Xo
 z9Rsp/+SdKDhaKXxpFZ3sNlMw514yeptQL8asi0UG/saS78xbPAq6cA/TQ7HZnC0mvH0
 vIdg==
X-Gm-Message-State: AOJu0Yz9krPi/QHRW2gS4rtuUCxCjCOgLDFlFnSiqwmxjT8I39Rsb44U
 oTossePKSs90u8Ir6eKNsy4TFntAjvtQcrV2EyTuRmt0JsGx1GjlIbr6IPS6Muv8AKDh/j6xVce
 EkX9mR5Y=
X-Gm-Gg: ASbGncu0cFvf0Wh3gc/BOoxw2a+w6YL1KBf1qsDatOcTP4+MqCcvBRi+27/yNHsJC5A
 FFG4ZBaoawJn4+PXIyCYzhymkDUElJCkBsFVKZWCDCIuEn7DrsRdawh/PB7Yvs+0Je9eEJz68yY
 TpJdKt72mUeilKT61cE+tyDaTc7H47eLAhCeQJ2xdfyRroTF72TVw8vYNLPksleeJfTA85UsJz8
 AK3T2a+1D2OGS52sf4ycgdU40p4UsVbXiJnjstSq0XZesiitBBjlYAuIfYPFpThFghILzsTBkeP
 gdNrASQGnYAsmU1RbpmclmvzqBdzKeZIdHi6ycoJ7z1QFX3phnTPwsdap8EpdmYauUeEIhRzqIs
 Aga93U9vb2o8IG4qx87b5wvgQRC4ZexWDDk1ja8JpwLgHb3DIgyD+dKOv6R9xab2hfSfYpA==
X-Google-Smtp-Source: AGHT+IGU8bQariWEQ1qwQpeVPSH3QmX0KG0QBxMTcJzj0zR7lGIfgS7Vqw1lT1qeMLIU6IOKQr/6sg==
X-Received: by 2002:a05:6e02:b26:b0:426:3ab1:74b4 with SMTP id
 e9e14a558f8ab-4263ab179ecmr74340535ab.19.1758900694389; 
 Fri, 26 Sep 2025 08:31:34 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-425c06433b4sm22902845ab.47.2025.09.26.08.31.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 08:31:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>,
 Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH] clk: ti: Tighten some TI clock driver dependencies
Date: Fri, 26 Sep 2025 09:31:32 -0600
Message-ID: <20250926153132.3680837-1-trini@konsulko.com>
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

A few of the TI clock drivers cannot link without access to TI platform
specific drivers and headers.  Express those requirements in Kconfig as
well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: Andrew Davis <afd@ti.com>
Cc: Udit Kumar <u-kumar1@ti.com>
---
 drivers/clk/ti/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/ti/Kconfig b/drivers/clk/ti/Kconfig
index e0f15f57f826..ba658c741c4d 100644
--- a/drivers/clk/ti/Kconfig
+++ b/drivers/clk/ti/Kconfig
@@ -18,19 +18,19 @@ config CLK_TI_CTRL
 
 config CLK_TI_DIVIDER
 	bool "TI divider clock driver"
-	depends on CLK && OF_CONTROL && CLK_CCF
+	depends on CLK && OF_CONTROL && CLK_CCF && ARCH_OMAP2PLUS
 	help
 	  This enables the divider clock driver support on TI's SoCs.
 
 config CLK_TI_GATE
 	bool "TI gate clock driver"
-	depends on CLK && OF_CONTROL
+	depends on CLK && OF_CONTROL && ARCH_OMAP2PLUS
 	help
 	  This enables the gate clock driver support on TI's SoCs.
 
 config CLK_TI_MUX
 	bool "TI mux clock driver"
-	depends on CLK && OF_CONTROL && CLK_CCF
+	depends on CLK && OF_CONTROL && CLK_CCF && ARCH_OMAP2PLUS
 	help
 	  This enables the mux clock driver support on TI's SoCs.
 
-- 
2.43.0

