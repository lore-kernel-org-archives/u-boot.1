Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856B5606A31C
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 13:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=r6S+2lRZ;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=Tg1GCa0b
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6184A606EB;
	Sat, 28 Nov 2026 13:12:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9OU94-NTL2IH; Sat, 28 Nov 2026 13:12:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3DD0F60690
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795871555;
	b=SLI6iRPTtT4vZ1IvzsxcO4NFO0PS/ZEdl3VfYhTy+1VstcWCwZfLFcbT3r9WCPxSNE2j
	 IdAY6VO/OBluouixr7SDEmo+OU8Eit3vvNUe0m4y9q0LzLB449IkUg/3F9kpLg8HdF/dz
	 NZcbOSwwv0S9aAubjOesoOQivWB6kpHMPTnYyyINF2DzEiXlpP+94B1UdPJPQK6GQyRg4
	 becRXLWDyVAwf5ugTRbEQt4ag0ScyqjvlxoqF0FXxbxpwFDGDcXty4hKdlL3Hj0iiYGNq
	 i/bgFMkz/nwCyNmXfPzY8Qz5p9kR4U0LHEWpasdw12FK1BdT8ku7nd3afHl0K3jWwYg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795871555;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=oahsSGO7Jscbi1nLbm2eiLOPFUnjaIbLzoHnQutoHFU=;
	b=aZHWNhOGQeFZru/3CH73wOSyD/hmug0qDLf8snLMxVItQRUNBG8PwtkniBNShqqfV8RM
	 xYHz226DzPh5UIkFRl3+DL98JYPPbVu199htZP8B4gseS1Bu+hm1BZG9cIGyc5XPUgG+T
	 GEqzy6e00a0n5yMjzKg6DvwIlNvvn5WxbP+z/DT+ibvhfp75+/8K7gtnNa+X0/KnXZkoD
	 3doghenwUG8dqCKD3mTY+9xSc8iWtVvXasXoa7rPVHhgmaVnlzlMQk6U54MPDvjHMNV0K
	 jdsaxgkcBbZvzFZUJCJGrjLJawTcYp/Rg3oga4q+91ijtldfuWqx5t7rdOaFiEevojg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795871555;
	bh=oahsSGO7Jscbi1nLbm2eiLOPFUnjaIbLzoHnQutoHFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r6S+2lRZrdHcM7nA9yhV6MTC/zOTinyzGBtAu9Fca/SozuCU8cNz0EeV9gjq+YzPc
	 KISZa3svBt73YgDeZewZpEjOCCbvN0FHO1Qw0zpJrYRPmNduk96MdFrl/OpUA7MMHi
	 +g5jktrAUIX2ikw3jLFzG+EfYi6jmrDBwDrTTflp3VNEAHNoz3PgO68pfJGh7vWMOv
	 iOk9BDfurIPF6BZWMaVo4K5/xC8z0ugoPyQZA7Z++CIBpJXecb2PT6hBUDQPN+ZrSI
	 RGauE++D9mToDVtlAhTqZTy6zsopO8iVSVPccsM8RNT+Dm+FiI6qnrgg1JvAi/d/P+
	 Ce/T3uCHoqUaw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3DD0F60690;
	Sat, 28 Nov 2026 13:12:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6210DBF4
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:12:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 53D6B400E0
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:12:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LuelcXwDMzpb for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 13:12:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0E2424005D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=Tg1GCa0b
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0E2424005D
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:12:16 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4a5024b3c28so5648590f8f.0
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 05:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795871535; x=1796476335;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oahsSGO7Jscbi1nLbm2eiLOPFUnjaIbLzoHnQutoHFU=;
 b=Tg1GCa0bbn8DVPDhW27HsAB94dkqg67sjhfdRSP5hzIN6SqxMZzqig3k5LKMxDgf00
 CzDG3dBs51Aj4kCfN5IydhQGMD8clxVB6F5ebmJPpF4+WYa7F2QlxzbMlFBdes9r4end
 USGyhUbCBRs5CAPqWpBqIUVF5aNohh3aU2Wnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795871535; x=1796476335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oahsSGO7Jscbi1nLbm2eiLOPFUnjaIbLzoHnQutoHFU=;
 b=dmdJ4HvU60dFJ/YDE5+lz8PjEVd+6dfInSNShKhw2HGU1MIgm1r1zsvwH5tAN4pFFr
 zITsyNNz0D9cUt5d1pIdbYPkF9GJ+RYtVcOspAzCSeiNLTdYdqEb7Kzb20KUIecrzm+M
 lHyWdoTC3+C7vew0YGpwUmXrtu6l0OKFarmGxqTPxJcCASbTEwjDmQO3VrH+nEGbhg5P
 JldMXWEbJG+zvnJ20vbg5n1C81Ym2QMw8SqTflj94bbGQ7racZQuRSlYxHIvuU4tqF8o
 kcWmCYYzq0cehYzgejfZWZVo8JCVkyH2Ee6x4UfKSYCmKiGIoaZuqhP9cs2flxZqJP/8
 ZQXg==
X-Forwarded-Encrypted: i=1;
 AL+hErHZ2eBa0om/V2E8ph+Ym7FnSzR03pUobghKE3fIQsYZiMFJrymFsm8Zeu8+FJ5TEUjUqT7bsP4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8kuT5Xw4im3EzYWA/QE3cOsloxxwQ97zItBGDAfWlfCL9AEYWC
 LPsh1Nv/zGYCbQJLOLXTWCKqgdZ3eRjjmJ6AsQ0ja+h38fSl2JjYyux5bX9kFMyLnVY=
X-Gm-Gg: AZFdTZfHQljo81AZd0rWgArAQ2h19d543gauJo3lZlPLdkkMARPUMhF+z6zmH+QDFWe
 TvjEbWbw8WCKdzsV5oapf4SiifIN2au+FzQ15kzeYC9oensIrCAsMo7RbEcaf6wHKsK6nF0it49
 c0AjMxBXtWUi4wfBkSclWGR4LstfOsB641MtYFoDxRh7KK33bVJ5Hh5efkNGFHUigbryqK2aM3T
 15o7EaGp3h5JqTlStjpfwoqTjETdy/sKT9ZAU1qdIt6c6TOIvGWhNKXQABKbb0HohJVP7MJRAyf
 TwR1Pntc3flny1GKf3wlIrn4YEwMtsgGKYCytu1Io93z/vsX/p4OZx4YXTuYlhZ8MMfPXV0NW9v
 YWK+YT8MiMq0RdrtKmgIvxTUc5btOZQOejKZ0ytOTssneMz7QMl6PLgsLKNlH6peykyUJ8mHh9Q
 mA7iAHHr4AOHFfd0/B4C/9Wvc1BR/C53nAiwYrUCrYwvqRlmEqsIQaOAU/Ue2Cg6Dsi3CofP2hI
 tBvF3tLtXzaMwhGUQWCBCMgLYHBhwNJWJYdTK/sSjmm3qlEP3g8Bs+dwR6t0wNZKlbSfkDsaeaf
 fZu0MIiGMkViljrjVItG4oHfavg3gWf84X/6epMQ7aBUgDrqwogdpB30PUJIobjZaAw+H2xC/wm
 U4+ltopg9WQvXZoai8b7prcyb1q1vXZfdxgYZyMpqshPvXP9gQWarWdZhdVvXc+NbDLMzfpqIQY
 1lCPou6y+ZhO04kz9uyhLfhWCM3ZIehFRqiFRLJMBfVW4hQD4=
X-Received: by 2002:a05:600c:4e0b:b0:49e:65f2:db64 with SMTP id
 5b1f17b1804b1-4bb887fb66cmr586315915e9.5.1795871534674; 
 Sat, 28 Nov 2026 05:12:14 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm1076382015e9.13.2026.11.28.05.12.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 05:12:14 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Yannick Fertre <yannick.fertre@foss.st.com>,
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org (open list)
Subject: [PATCH v3 26/29] board: engicam: stm32mp2: add
 MicroGEA-STM32MP257D-RMM board
Date: Sat, 28 Nov 2026 14:10:43 +0100
Message-ID: <20261128131125.2141352-27-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261128131125.2141352-1-dario.binacchi@amarulasolutions.com>
References: <20261128131125.2141352-1-dario.binacchi@amarulasolutions.com>
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
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

---

Changes in v3:
- Add Reviewed-by tag

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

