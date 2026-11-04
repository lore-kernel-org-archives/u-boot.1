Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2157B606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 08:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vwgJH3uo;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=ZSEPzCO3
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EC35960889;
	Wed,  4 Nov 2026 08:52:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rv_a4oEYxGM2; Wed,  4 Nov 2026 08:52:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C7F0B6083D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793782353;
	b=GNUR98499pl1CvL/0/dINSdgZ6V34XeXoW7rkWXS+JWjQhhKeIQPK85/qXjOL6qIeRY2
	 VAG9TaQwxwkW/P9ee3/HLD1dSkLD4DeV29zq3VCgrOmzFI0ZtsAQbMc05q0kgKFbhwqNc
	 /kmclDXvYaD3d+RBBYnHupvAfTG6tynhovHBQzmWoyxjZHVz1Ry7/7G87Md6QFghnXX/W
	 gvJSzybLHbfzHhz8ST/5cbKW12OVICQkAOMHlE0oifmmrRvHKxmewZHKVYXMTaJ3kdt6X
	 6gHd/j00XymoigFI9K/TJsHuaaIvw0op2KRFzOcQ3k+ORJLW68e/8XZa/qCw7bNT1kQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793782353;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=E5S0Cx0iGLo+7cIRZlIwa2/3wJDO5h9jrxGYpfQ+Hn4=;
	b=nSkBhCkwLbcAhY68DLWVeHWQO8XLclAxyGHmBLhuai+JBdH96s7nk2C1ohU9P9pJA90o
	 Pa20LlYYYH+rB2cJmL8MZpkyUSjbZba+6RZuNwZfnUsSxDCs14C0BACI4/3/nwOxH+EXH
	 Y17A19o3fmRWhutF9/kZuSy3zOXAOGFy9YvD5VGKK5jT4SUkOVZ1DAfjF3sS+hLxesltU
	 tfCrZyG8QWekphT7zkU4IRTvFQwUikXQojaUg75VrV9Bp0RHzfYOrnoJ/OSTWkl4Uz15o
	 5w5SGbkOHq5zyML7rnO02kFJtuRjEtln40/nHgjEKfOl4FIf/QPIZxQIEK6ZOnNMg0A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793782352;
	bh=E5S0Cx0iGLo+7cIRZlIwa2/3wJDO5h9jrxGYpfQ+Hn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vwgJH3uox3GmeZD0w2BZHUBPZUwmZ1SkTwyQLp03ZGsiyTbq7avOhLFnw7aN9vlc+
	 afrv12mFhY5YgKhwOQvVI7r2XKprUTPSV1npSZuXHF07DLh11Hz/UpjjAWsHNLMwan
	 TR6aIr2856lMEbBFay6qXAserfR/ot10lmwgASokN08nuZfDX+CeKQGEC5o/tmjyrc
	 jyOGC+FoKMVQr1VgoSD134LHIAGXVcaEacfysPdPN7YJOd6XnWb30mUpur2rjVl/VO
	 xb1dYiMDmdWBxCuHF4V+mf8P3HT77gT1tLNDBQj4c6IHYgbolAif1efDIZPkCOGnRH
	 tYzsD2yqoLy6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C7F0B6083D;
	Wed,  4 Nov 2026 08:52:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9D345235
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:52:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9A75D407A1
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:52:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DzQv_sDm9zc7 for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 08:52:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2A9C74081F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793782348;
 b=O1CAw5TwqozD+qyd0Mcwt4TZbhD8tw7edjEAogmOumSMZ8PYtNMP9rFNeX2qlebwY/KP
 S5Y3Tpv3NAFM11oncy+kmJ1iAI6mD899TP9rMn+KAK630cTs79W5J0zDFSvIIK+R0Ccxu
 MQhc6ODRO/HbyJpZ27Ac8wo2/vro0YPsn+p5V9XbgvXE6ShXe6aNzOETCF+ZEXFChcqYc
 UUCunAveuL/Aj2kkWIrAj+tM6S4faZDtNvvYS6R+tz4RuNSMzrpXOz2ik9ZLnoqCiVQQO
 W30t45Kmg0XJEfIQ3301Guo7VR1Rf/4Dj5bNRZl4RQi/H0coCp5j3PtVZxk+YKaxcVg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793782348;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=E5S0Cx0iGLo+7cIRZlIwa2/3wJDO5h9jrxGYpfQ+Hn4=;
 b=Ns2CXLlae2K7716ce90zO2jWkE+nh5TCnYuEixXz49FwtDLtbyqOJvJy8mb9fq1pCHr+
 hMUph8OqL7scijcn5Ra5mUmgbbxz1uXKIzSDoehRK3B4+svyXB4CGL9E+2gR+X4OlWZbC
 oUWx6afPQTR9fCzbM1preiW/afYSbVso76TxJJ5YpiaXpDfDCs+mH74CuUKJMXR+02qss
 OirrrZGD/9h7ZaoAbv2rDYhg6wsqznq38MRbEe9oJm3JakPyHzEYNo8rDEKTKD1XlPcpp
 +kYHf83Vh3RWVEIc344CitffSkLgEdXOS0Gj8OgP9VdrqwMHkf01id3BLQAfzmH5KWQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=amarulasolutions.com;
 dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=ZSEPzCO3; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=ZSEPzCO3
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2A9C74081F
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:52:27 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso3567335e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 00:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1793782346; x=1794387146;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E5S0Cx0iGLo+7cIRZlIwa2/3wJDO5h9jrxGYpfQ+Hn4=;
 b=ZSEPzCO3NsVxa/jj+UrYty/zjmxkGjU3ZMdUChW+OVAzk12xHEioZlxk6URfnT3c+O
 HuYTq/SFwJWQxfjXRONF5vzQH7ShvxlpAuqKBqTp80Okq5HnFth1ZP4qPzUuTx33f3PE
 JFXHrg7gOm1TuG85ndsl63RivYfIztFHvAqnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793782346; x=1794387146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=E5S0Cx0iGLo+7cIRZlIwa2/3wJDO5h9jrxGYpfQ+Hn4=;
 b=YLovqLAvjlWujeTRXuXZ0XVUxSi5QtSm3GK96OnNO0koJf7jtszQkq5MWFfdGMiQ/J
 GhzxwrN3pYggst4hvd+LllNV7wi3m1cSwQYykTt1p8gwBBc5u1Nz+1Mh42FADNQTmxmp
 mD+8uab5gZD3N1n1UBUJVdy6HWio2oGDc07Zv1Dl7W2563ISM8l1L7AEcS5sWdjU4h3e
 FoCLdGrsb31VzhnX8zTKfLIOzryTQ3lWZ2gbm5r1TCC9DolkbkkP1r9W1N1T3ttfVoEK
 1Htl3+073iX2hoK9uTuquNADf3e3dpyYXEOaatUtLCewQFz3bqyJ14nI4CL8dH0M34Ph
 5H4g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxcVLdL/SFEieuv4gO21+NIGCSXwjdBHtL63UvbqRLJpQedKPtpUrHCb92TJFFCizVtiUzUivg=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z88ePES2vxrW7M7rlsn0PLKMJngaJejqzxzVFp4dZjFhc0C5IkY
 TFS9Rq/HtbQfwTJqF1prEtk8/OWatYGwNK7gk365rp7LPw2fJRPIcBUHmkbFBTuKXic=
X-Gm-Gg: AYBFou1WLYmS3ap1C32AsuA0YMEYTiZnlo1Kcv++BgKhOaWhBCPbcwcaNifJYYDqTKW
 S2a8QKYhxxP4bX+dMaPzTEvEjNt/tQNsYttiMm8Eg/8Bn7NUWu0Fj3tsjQUwM5nP2gnNwx1WLtM
 CgEZj2LOo6cp2CEmqiMMUkJpv+TFW6OUKj64qZbpHEGwjcifJ0Dg3vgW5QmXx8T7S2wKputXyM4
 AgQ3okzCWv20VBtEo587JZiAT7lilC6J5lzmgEaoT+hK5aYhRdRXg/PE2AGhJORx6QyrHB5dh+f
 ADD6jIo+UjHx7cxuttnAiU0ITkpllKtF1M1zpDHkAagclgXxCQkaOZ8rIuGygpJ7Ym9/KqzUAlo
 lhAIuq6Rtz912LOwNbVNj25OOdNeJwja3ZbqbSWeH64wlRgnxKDA3OzCNVZsRByftiyxxJ23HUT
 uGn59eZUvxe/c719LAs80xI6dKtMsjF5l9t2z9o2/pQ9DzK2hbMUReFWRViAB6aJaIqvwnw4aiH
 Vmk+pHIB4v2LCVIWW30d92yq6t2vcq0JTs/Zel4WwUj1383j0boQIOx2Zw5FCE/StTxfOikYbMd
 R+2KnNGpFN+/YnJSmp8mG39rUBJn+5InAsZ9SaiYWWvQ4Crll2YkhKfHPfvScu5jjcYhWbtCZ+o
 /rtD3h50uKsILc5DT6a/Z28GJpli2
X-Received: by 2002:a05:600c:19d2:b0:4a4:4d57:8487 with SMTP id
 5b1f17b1804b1-4ac1737c51dmr342850185e9.5.1793782345725; 
 Wed, 04 Nov 2026 00:52:25 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.. ([109.54.139.206])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b413312a4fsm20555915e9.1.2026.11.04.00.52.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:52:25 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 30/33] board: engicam: stm32mp2: add MicroGEA-STM32MP257D-RMM
 board
Date: Wed,  4 Nov 2026 09:50:03 +0100
Message-ID: <20261104085036.4012238-31-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
References: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for the Engicam MicroGEA-STM32MP257D-RMM board, based on
the Engicam MicroGEA-STM32MP257 SoM.

General features:
- STM32MP257D SoC
- 2GB of RAM
- eMMC
- microSD slot
- CAN
- Audio codec (SGTL5000)
- PWM backlight and buzzer
- 5" RGB or 10.1" LVDS display

As for the Engicam STM32MP1 SoMs, add a dedicated target for the SoM,
so that the carrier boards are handled by the devicetree.

The display can't be detected, so it is selected by the "display"
environment variable, which defaults to the RGB one. The board
registers an extension driver reporting the matching Linux devicetree
overlay, which the extlinux and EFI boot methods apply to the kernel
devicetree.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 ...m32mp257d-engicam-microgea-rmm-u-boot.dtsi |  27 +++++
 arch/arm/mach-stm32mp/Kconfig.25x             |  17 +++
 board/engicam/stm32mp2/Kconfig                |  12 ++
 board/engicam/stm32mp2/MAINTAINERS            |   7 ++
 board/engicam/stm32mp2/Makefile               |   7 ++
 board/engicam/stm32mp2/microgea-stm32mp2.env  |  15 +++
 board/engicam/stm32mp2/stm32mp2.c             | 112 ++++++++++++++++++
 configs/stm32mp25-microgea-rmm_defconfig      | 105 ++++++++++++++++
 8 files changed, 302 insertions(+)
 create mode 100644 arch/arm/dts/stm32mp257d-engicam-microgea-rmm-u-boot.dtsi
 create mode 100644 board/engicam/stm32mp2/Kconfig
 create mode 100644 board/engicam/stm32mp2/MAINTAINERS
 create mode 100644 board/engicam/stm32mp2/Makefile
 create mode 100644 board/engicam/stm32mp2/microgea-stm32mp2.env
 create mode 100644 board/engicam/stm32mp2/stm32mp2.c
 create mode 100644 configs/stm32mp25-microgea-rmm_defconfig

diff --git a/arch/arm/dts/stm32mp257d-engicam-microgea-rmm-u-boot.dtsi b/arch/arm/dts/stm32mp257d-engicam-microgea-rmm-u-boot.dtsi
new file mode 100644
index 000000000000..4cc0d47e999d
--- /dev/null
+++ b/arch/arm/dts/stm32mp257d-engicam-microgea-rmm-u-boot.dtsi
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
+/*
+ * Copyright (C) 2026 Amarula Solutions, Dario Binacchi <dario.binacchi@amarulasolutions.com>
+ * Copyright (C) 2026 Engicam srl
+ */
+
+#include "stm32mp25-u-boot.dtsi"
+
+/ {
+	config {
+		u-boot,mmc-env-partition = "u-boot-env";
+	};
+};
+
+&usart2 {
+	bootph-all;
+};
+
+&usart2_pins_a {
+	bootph-all;
+	pins1 {
+		bootph-all;
+	};
+	pins2 {
+		bootph-all;
+	};
+};
diff --git a/arch/arm/mach-stm32mp/Kconfig.25x b/arch/arm/mach-stm32mp/Kconfig.25x
index 7d2d8171845b..cfd746b82c2c 100644
--- a/arch/arm/mach-stm32mp/Kconfig.25x
+++ b/arch/arm/mach-stm32mp/Kconfig.25x
@@ -13,6 +13,22 @@ config TARGET_ST_STM32MP25X
 		managed by board/st/stm32mp2
 		The difference between board are managed with devicetree
 
+config TARGET_MICROGEA_STM32MP257
+	bool "Engicam MicroGEA STM32MP257 SOM"
+	select SUPPORT_EXTENSION_SCAN
+	imply BOOTSTAGE
+	imply CMD_BOOTSTAGE
+	help
+		MicroGEA STM32MP257 is a System-on-Module (SoM) from Engicam
+		based on the STM32MP257 SoC, with 2GB of RAM and eMMC.
+
+		The carrier boards supported are managed with devicetree:
+		* MicroGEA STM32MP257D RMM
+
+		The display fitted on the carrier board is described by a
+		devicetree overlay, selected through the "display" environment
+		variable and applied to the kernel devicetree at boot.
+
 endchoice
 
 config TEXT_BASE
@@ -35,6 +51,7 @@ config DEBUG_UART_BASE
 
 endif
 
+source "board/engicam/stm32mp2/Kconfig"
 source "board/st/stm32mp2/Kconfig"
 
 endif
diff --git a/board/engicam/stm32mp2/Kconfig b/board/engicam/stm32mp2/Kconfig
new file mode 100644
index 000000000000..a4d590d161f4
--- /dev/null
+++ b/board/engicam/stm32mp2/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_MICROGEA_STM32MP257
+
+config SYS_BOARD
+	default "stm32mp2"
+
+config SYS_VENDOR
+	default "engicam"
+
+config SYS_CONFIG_NAME
+	default "stm32mp25_common"
+
+endif
diff --git a/board/engicam/stm32mp2/MAINTAINERS b/board/engicam/stm32mp2/MAINTAINERS
new file mode 100644
index 000000000000..680b083aca2b
--- /dev/null
+++ b/board/engicam/stm32mp2/MAINTAINERS
@@ -0,0 +1,7 @@
+MicroGEA-STM32MP257D-RMM
+M:	Dario Binacchi <dario.binacchi@amarulasolutions.com>
+M:	Michael Trimarchi <michael@amarulasolutions.com>
+S:	Maintained
+F:	arch/arm/dts/stm32mp257d-engicam-microgea-rmm*
+F:	board/engicam/stm32mp2/
+F:	configs/stm32mp25-microgea-rmm_defconfig
diff --git a/board/engicam/stm32mp2/Makefile b/board/engicam/stm32mp2/Makefile
new file mode 100644
index 000000000000..e86afc9c9e34
--- /dev/null
+++ b/board/engicam/stm32mp2/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
+#
+# Copyright (C) 2026 Amarula Solutions, Dario Binacchi <dario.binacchi@amarulasolutions.com>
+# Copyright (C) 2026 Engicam srl
+#
+
+obj-y += stm32mp2.o
diff --git a/board/engicam/stm32mp2/microgea-stm32mp2.env b/board/engicam/stm32mp2/microgea-stm32mp2.env
new file mode 100644
index 000000000000..2a65b14231a3
--- /dev/null
+++ b/board/engicam/stm32mp2/microgea-stm32mp2.env
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause */
+/*
+ * Copyright (C) 2026 Amarula Solutions, Dario Binacchi <dario.binacchi@amarulasolutions.com>
+ * Copyright (C) 2026 Engicam srl
+ */
+
+/*
+ * Display fitted on the carrier board: name of the Linux devicetree
+ * overlay describing it, without the base devicetree prefix, i.e. the
+ * overlay <fdtfile without .dtb>-overlay-${display}.dtbo is applied to
+ * the kernel devicetree at boot. If unset or empty, this default one is
+ * used.
+ */
+display=rk050hr345-ct106a
+extension_overlay_addr=0x90300000
diff --git a/board/engicam/stm32mp2/stm32mp2.c b/board/engicam/stm32mp2/stm32mp2.c
new file mode 100644
index 000000000000..de06d21764c2
--- /dev/null
+++ b/board/engicam/stm32mp2/stm32mp2.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
+/*
+ * Copyright (C) 2026 Amarula Solutions, Dario Binacchi <dario.binacchi@amarulasolutions.com>
+ * Copyright (C) 2026 Engicam srl
+ */
+
+#define LOG_CATEGORY LOGC_BOARD
+
+#include <alist.h>
+#include <config.h>
+#include <env.h>
+#include <extension_board.h>
+#include <log.h>
+#include <dm/ofnode.h>
+#include <linux/string.h>
+
+int checkboard(void)
+{
+	const char *fdt_compat;
+	int fdt_compat_len;
+
+	fdt_compat = ofnode_get_property(ofnode_root(), "compatible",
+					 &fdt_compat_len);
+
+	log_info("Board: stm32mp2 (%s)\n",
+		 fdt_compat && fdt_compat_len ? fdt_compat : "");
+
+	return 0;
+}
+
+/*
+ * The display fitted on the carrier board, from the "display" environment
+ * variable or, if not set or empty, from the default environment.
+ */
+static const char *microgea_get_display(void)
+{
+	const char *display = env_get("display");
+
+	if (!display || !*display)
+		display = env_get_default("display");
+
+	return display;
+}
+
+int board_late_init(void)
+{
+	const char *fdt_compat;
+	int fdt_compat_len;
+
+	if (IS_ENABLED(CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG)) {
+		fdt_compat = ofnode_get_property(ofnode_root(), "compatible",
+						 &fdt_compat_len);
+		if (fdt_compat && fdt_compat_len)
+			env_set("board_name", fdt_compat);
+	}
+
+	if (!env_get("fdtfile"))
+		env_set("fdtfile", CONFIG_DEFAULT_DEVICE_TREE ".dtb");
+
+	return 0;
+}
+
+/*
+ * The display fitted on the carrier board is described by a Linux
+ * devicetree overlay, named after the base devicetree:
+ *
+ *   <fdtfile without .dtb>-overlay-<display>.dtbo
+ *
+ * where <display> is the display fitted on the carrier board.
+ */
+static int microgea_extension_board_scan(struct udevice *dev,
+					 struct alist *extension_list)
+{
+	struct extension display = {0};
+	const char *fdtfile, *name;
+	int len, ret;
+
+	name = microgea_get_display();
+	if (!name || !*name)
+		return 0;
+
+	fdtfile = env_get("fdtfile");
+	if (!fdtfile) {
+		log_err("fdtfile not set, cannot select the display overlay\n");
+		return -ENOENT;
+	}
+
+	len = strlen(fdtfile);
+	if (len > 4 && !strcmp(fdtfile + len - 4, ".dtb"))
+		len -= 4;
+
+	ret = snprintf(display.overlay, sizeof(display.overlay),
+		       "%.*s-overlay-%s.dtbo", len, fdtfile, name);
+	if (ret >= sizeof(display.overlay)) {
+		log_err("display overlay name too long\n");
+		return -ENAMETOOLONG;
+	}
+
+	strlcpy(display.name, name, sizeof(display.name));
+	strlcpy(display.owner, "Engicam", sizeof(display.owner));
+	strlcpy(display.other, "Display", sizeof(display.other));
+	if (!alist_add(extension_list, display))
+		return -ENOMEM;
+
+	return 1;
+}
+
+U_BOOT_EXTENSION(microgea_extension, microgea_extension_board_scan);
+
+U_BOOT_DRVINFO(microgea_extension) = {
+	.name = "microgea_extension",
+};
diff --git a/configs/stm32mp25-microgea-rmm_defconfig b/configs/stm32mp25-microgea-rmm_defconfig
new file mode 100644
index 000000000000..34933f1e7e41
--- /dev/null
+++ b/configs/stm32mp25-microgea-rmm_defconfig
@@ -0,0 +1,105 @@
+CONFIG_ARM=y
+CONFIG_ARCH_STM32MP=y
+CONFIG_SYS_MALLOC_F_LEN=0x600000
+CONFIG_ENV_SOURCE_FILE="microgea-stm32mp2"
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x90000000
+CONFIG_ENV_OFFSET=0x900000
+CONFIG_ENV_SECT_SIZE=0x40000
+CONFIG_DEFAULT_DEVICE_TREE="st/stm32mp257d-engicam-microgea-rmm"
+CONFIG_SYS_BOOTM_LEN=0x2000000
+CONFIG_SYS_LOAD_ADDR=0x84000000
+CONFIG_STM32MP25X=y
+CONFIG_DDR_CACHEABLE_SIZE=0x10000000
+CONFIG_CMD_STM32KEY=y
+CONFIG_MFD_STM32_TIMERS=y
+CONFIG_ENV_OFFSET_REDUND=0x940000
+CONFIG_TARGET_MICROGEA_STM32MP257=y
+CONFIG_SYS_MEMTEST_START=0x84000000
+CONFIG_SYS_MEMTEST_END=0x88000000
+CONFIG_API=y
+CONFIG_SYS_MMC_MAX_DEVICE=3
+CONFIG_FIT=y
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTDELAY=1
+CONFIG_BOOTCOMMAND="run bootcmd_stm32mp"
+# CONFIG_BOARD_INIT is not set
+CONFIG_SYS_PROMPT="STM32MP> "
+# CONFIG_CMD_BDI is not set
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_ADTIMG=y
+# CONFIG_CMD_ELF is not set
+CONFIG_CMD_EXTENSION=y
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_FUSE=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_PWM=y
+# CONFIG_CMD_LOADB is not set
+CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_RNG=y
+CONFIG_CMD_TIMER=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_LOG=y
+CONFIG_CMD_UBI=y
+CONFIG_OF_LIVE=y
+CONFIG_OF_UPSTREAM_BUILD_VENDOR=y
+CONFIG_OF_UPSTREAM_VENDOR="st"
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_IS_IN_UBI=y
+CONFIG_ENV_REDUNDANT=y
+CONFIG_ENV_UBI_PART="UBI"
+CONFIG_ENV_UBI_VOLUME="uboot_config"
+CONFIG_ENV_UBI_VOLUME_REDUND="uboot_config_r"
+CONFIG_ENV_MMC_DEVICE_INDEX=-1
+CONFIG_NO_NET=y
+CONFIG_SYS_64BIT_LBA=y
+CONFIG_BUTTON=y
+CONFIG_BUTTON_GPIO=y
+CONFIG_SCMI_FIRMWARE=y
+CONFIG_GPIO_HOG=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_STM32F7=y
+CONFIG_LED=y
+CONFIG_LED_BOOT=y
+CONFIG_LED_GPIO=y
+CONFIG_STM32_OMM=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_STM32_SDMMC2=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_USE_SYS_MAX_FLASH_BANKS=y
+CONFIG_MTD_SPI_NAND=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_SOFT_RESET=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_WINBOND=y
+# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_PINCONF=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_PWM=y
+CONFIG_PWM_STM32=y
+CONFIG_RAM=y
+# CONFIG_STM32MP1_DDR is not set
+CONFIG_DM_RNG=y
+CONFIG_SERIAL_RX_BUFFER=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_STM32_OSPI=y
+CONFIG_STM32_SPI=y
+# CONFIG_OPTEE_TA_AVB is not set
+CONFIG_WDT=y
+CONFIG_WDT_STM32MP=y
+CONFIG_WDT_ARM_SMC=y
+# CONFIG_UBIFS_SILENCE_DEBUG_DUMP is not set
+CONFIG_ERRNO_STR=y
-- 
2.43.0

