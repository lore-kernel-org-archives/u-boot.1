Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8FC606EE93
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=O1DPjscV;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=MIlWo40n
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C29281584;
	Sat,  7 Nov 2026 14:34:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lfWopPI6ebeQ; Sat,  7 Nov 2026 14:34:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5B8E181AEF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794062063;
	b=bkVd6JDhFCILnw6Sv62gL1LnZ909cKwLbdYXIVKFUjEgOV/WiK2s3CLtDmwfpZglnGVV
	 eWghaZbYgUBqFfNPJ/mDK5Vi7QF77tBHkz+CxmJy2YePa7EP+t5PRFRK57qkdGRY/5mqb
	 o1YJQDfNbnK5r7O+xjCNGU5/95vgCxlz+o4Oi22+07u7iC4lWhU4hQPLSHgR5nzfqkkOZ
	 LykBSuN8WEhzO0OSsjiqQiKTjLCzyedEXoHDUmqnbpg9k0CF8CFN7WkzD4hDENSUFlQKt
	 qICY/iMxBdWPN34csh2pdzCyhsqSs06Xj8lxb+60uqjkQ3D0HUVKQvZZ4VYz0/GPRZQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794062063;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=sRFbxQ3s9pzBsRNgpvKDroYDKFjDLcTGP5ZUBaoSb5s=;
	b=EE8JIYOTmrP+T4SvjpqNFAqi8RdFPy7nzGGrwEKb1OJJb/+8cYtKeo4f4pl7SUAkM6P8
	 blcn+Ldw0DVxqzzZgYAPqnWVr4OGMNaBUtDiFPm7G5Y6hDOmcHPe8tOM3D8aim7E8d5aW
	 vVE6ZKOUKFXZZVD16CCBCuZSjdtV7193NpUD1+UqvEAmyuzZr+zJQj2w7CE3HnwJbXpO5
	 XEBb08ODsp2aF/Mwz0NYWR6Delo/M8V4qeZSIl2xzyjI1wWwV8P7LLmeVW9AXX8TR11HL
	 HYU7b0lr/pTUYXnfPgeGVnG+n/z7MtGseiOFS7ZQAllBgAQ5p8EWGvP8pzBul0Q80BA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794062063;
	bh=sRFbxQ3s9pzBsRNgpvKDroYDKFjDLcTGP5ZUBaoSb5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O1DPjscV56Ez9IhwUNEYCb0E41eY4+puBZQOPxgf4/bOGXsnAh+FhZEVBAsUHkfSW
	 5oSkhDJfEm6FgGJI9d7bhi44MdchNhfQnT3ZusfBA0Kfb5S8z77LCbhYTEGDMQGC4c
	 8myhLgl3qrI1GdFjltKSsAlxQvdGkqCcjoTjjQP4dGo7SPeWAPf/+lCnzW8OCO3RuB
	 SJwEvBIlehX2OKhsJA1U9uWiho4JXmF59mVZKJa/Jd6Qr0Qa3fNBUCL5XCaFTkz26v
	 y1EZxww48mkuJ8A7lXNheE6zluoaxpSwmdg6Ihr4DAjG++VW1sC1nLSQDKDZVpl/LP
	 n3ilOMxVj7lwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B8E181AEF;
	Sat,  7 Nov 2026 14:34:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D12D37D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5A9ED608DC
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W5gaS9iQqB9V for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:33:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 006A360823
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=MIlWo40n
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 006A360823
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:51 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so12048315e9.0
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1794062030; x=1794666830;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sRFbxQ3s9pzBsRNgpvKDroYDKFjDLcTGP5ZUBaoSb5s=;
 b=MIlWo40n3r6yrVIF/Ej9aVNRydRMisonHFdmnj75zCEWnVnmW73QQxKOKuHQyVXYtH
 y/4LQI49G32O0cJ5x+aer+K+C9H9wi4YAZ0apavrCz8yZ+emkui5vKf6GpRRSpB+X6DM
 rvE+FPNyPhrzr59M9gd4NlslXB7+Sg1glNN48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794062030; x=1794666830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sRFbxQ3s9pzBsRNgpvKDroYDKFjDLcTGP5ZUBaoSb5s=;
 b=oJQ7czqrTPoDGY32ioQWdYbnZBcfMZ5GPyPqLKKklF0JZper0pkD3sS0iNOZw/rRo8
 Y3Rx8QdqeaHTp70I4XeT/PW9GEQ8RmzcqKZb4yrQK3gNibymet9kW31Ymiog8k720jAF
 +lraAr29l6AotSu0WSwq98CpPuC/QtuT/v+DxXxbv9tWZalJo5M3rOX/VsD+sS8Lx7Xq
 2u9fM93KmoS7ywvSbdM5Hji4438BpCFNq/+GUrV1J9DjNzELHyQgqvN/vX+p5Eq8i7HX
 m5JoFX9pLzjGjc25a8m2dGL9mmMy9IXxwbaN/b6iXVLMgIWvn3udbwxgwKiHIJyA98pl
 mg+g==
X-Forwarded-Encrypted: i=1;
 AKwUvByQ4v6+y1Q4rW8Q+1Mna/WpQRcwTZc1S5GOeAm9t/+ONnp8JHSRY0m2fl0UCQIYQ4LlcfhvjxI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/UwLUGodlqTGwKq7eEEBteqT/sRld+WmAbdrn7ZznBjrgdoNjD
 LBFXn89N3RL6ipWt2YZtqaF0e8zGDt0WkMFgKHt1VJk6LRVwCd3jI0GkILG1nfwIZWY=
X-Gm-Gg: AYBFou3oDYejezHhTOHfyB4XUOVbEz9PXH4nMe3qdmQ84X1DSe12oU9TIzXx8aeF1e5
 7r0nJdEGI5HEDZMiqEc0Tne8aHbxJtUaG9ohbJnNj5ZX6xS4fqjbBmss0fusRuekpdkvhX+3xDU
 KsHITyPbXKQq9Ox6XllvPdwJr0cc7hxojqexOviSLbC1wsbGvomnQSCoTo0/PL6GJNxNDE4cXK3
 gsP5H+8pSnEEmGYiFk+SQAHBleZyEoit+zZPF8wmGbTDEURTItBsf3tORAWaf8CazOuMWPf/huy
 kl1ILty0UusG3tdfLUjq4DfuLilXnbzidqkLtL8e8rhcqqpkuJ2cV3DOkyUlNOeFucfzySSRliZ
 7CZnru1YecNwzxcwa/hXrPqfvU5QTEBQlbmCj9TXHXB1oThIbixKLfCkftM77CnSA6IWbviAwP6
 Ax7txd88H8uAyH4h8latEfNa66UDl7N41yB3ovt/vMILXXktUfIwWdGg6sp9DoFI5BWCcxu+/pL
 3YhimJJ82HHbobHl0ypBh5FFO6nPM050zPdd71uWLLeNwX/jURgqWQUUPbgbVzoTXsM0RM7wHbR
 TBCLXm/+oaAk1AvEmMvAAP7p5wsgqRrC5ELOZF4BMzvuJ4j7L5qhZ8YGVbodbZqKcDeYdhCb0kr
 qLXd7O77tAhpU4BUItFR8wqKTpoN3eHcxq78nb3tS+OhrcJr7BFgxDgCwZatSNqVPiFDBBiiwqi
 gbYlrzAegqJQywseeQq8vGaKUoIBE=
X-Received: by 2002:a05:600c:c058:b0:4a2:1cc:6551 with SMTP id
 5b1f17b1804b1-4b6e0172438mr72885475e9.35.1794062029699; 
 Sat, 07 Nov 2026 06:33:49 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7cc6187sm10027247f8f.46.2026.11.07.06.33.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 06:33:49 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 32/35] board: engicam: stm32mp2: add
 MicroGEA-STM32MP257D-RMM board
Date: Sat,  7 Nov 2026 15:32:22 +0100
Message-ID: <20261107143241.2236511-33-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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

Changes in v2:
- Simplify the comments

 ...m32mp257d-engicam-microgea-rmm-u-boot.dtsi |  27 +++++
 arch/arm/mach-stm32mp/Kconfig.25x             |  17 +++
 board/engicam/stm32mp2/Kconfig                |  12 ++
 board/engicam/stm32mp2/MAINTAINERS            |   7 ++
 board/engicam/stm32mp2/Makefile               |   7 ++
 board/engicam/stm32mp2/microgea-stm32mp2.env  |   9 ++
 board/engicam/stm32mp2/stm32mp2.c             | 104 +++++++++++++++++
 configs/stm32mp25-microgea-rmm_defconfig      | 105 ++++++++++++++++++
 8 files changed, 288 insertions(+)
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
index 000000000000..1f50f68d4972
--- /dev/null
+++ b/board/engicam/stm32mp2/microgea-stm32mp2.env
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause */
+/*
+ * Copyright (C) 2026 Amarula Solutions, Dario Binacchi <dario.binacchi@amarulasolutions.com>
+ * Copyright (C) 2026 Engicam srl
+ */
+
+/* Default display of the carrier board */
+display=rk050hr345-ct106a
+extension_overlay_addr=0x90300000
diff --git a/board/engicam/stm32mp2/stm32mp2.c b/board/engicam/stm32mp2/stm32mp2.c
new file mode 100644
index 000000000000..5f3afd877a11
--- /dev/null
+++ b/board/engicam/stm32mp2/stm32mp2.c
@@ -0,0 +1,104 @@
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
+ * The display is described by the Linux devicetree overlay
+ * <fdtfile without .dtb>-overlay-<display>.dtbo
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

