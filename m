Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E11C27C52
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 09:11:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06189831A2;
	Wed,  5 Jun 2024 11:11:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ebBZ5REw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F4BE882B6; Wed,  5 Jun 2024 11:11:17 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F96D88341
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 11:11:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrejs.cainikovs@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2eaad2c670aso23433061fa.1
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 02:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717578674; x=1718183474; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TLhnh0XKoKCK0x1ZtNZws4/Wc6r3BFOAU5J4TngxMc0=;
 b=ebBZ5REw1jyvB/apFvWdArTFKOp7IJ/+0CAphUr/E2w52asyEAi73zW/HK0jBk9dHP
 AQFVTCGim6Uk1FGh7I6FXK0uZrlWk3y0IWqrgdErDVNKGQuh9GQ2FmI9jKihoOjHb0WG
 cYNsF324MyzLF2anYq2OMThAHxrn24OYndngHqvEMtT4pLMNm1mIGLQNbWNHBntfnFLT
 dOMTuIoSkUnrvgRV5VP0O0Gtk5kN+PYAj1npJKzcWwXL/4K65IVyIvGx9lEgXnPvHcxL
 Uz09t/8DXOmpjf+8TG52UjEK5W23V37Pp5FGcZxkhBbfNCcmLYuU5jMXeaVU1GrySgxc
 a2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717578674; x=1718183474;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TLhnh0XKoKCK0x1ZtNZws4/Wc6r3BFOAU5J4TngxMc0=;
 b=UNw2cGxuzO1bzGj5PCAnSWKMQxS/2j9u8T84qd5XbisUiBx77bGTYmb0RulIqLPtfQ
 NvPTvB9xjOW3i/JD4vA1WEPDm3+KvrzxoqN4JHczhKGVyX/po4QHaQYV8Y0Ia1cmBsaC
 AX/p7qDt6AFZhbY9H6XxJeVY9iHBWZ8mSW0iKpL/SpfvKni6S3zbRmUzi3rxDSTPA6kb
 3Zh10P6tDz3lv24ncNmkMaz2q0fCOWOuwkvB1FnGgCMzFuAKp6MR4406y5hBnkzPOsOy
 GgldcArF2zlUW9NlhmwnYywkk+JHTHwxXshOkVktoHUH8x4Na0Fz+OWIxR1La/WbD+DA
 tUAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGaziVhdhncuhlcm5W8iAcM2L1/eK/LHcMCeb6OoC6uPn5mgCmIHFmdxzJZicAzhnex49fpHNN63PHrd+LLvPbom19tg==
X-Gm-Message-State: AOJu0YwBUReUbkW7jlrAHvBcYUnq9NP9GFosPBwmMCOgOoONyFJMimKh
 sOHM/X8E7V6s/TmqkicSDNfA+EOozgWELYg0a3hj2zXmTyHtBoYrHhUbRA==
X-Google-Smtp-Source: AGHT+IFtYRlZ48zompZrWbtSoeX+JhL1A7SYzyfz3IdOSLSGGsuOdqx6nfEFxTuFqihUHCh+XxOuFw==
X-Received: by 2002:a2e:3509:0:b0:2ea:8d54:4530 with SMTP id
 38308e7fff4ca-2eac7a22291mr10145921fa.28.1717578673570; 
 Wed, 05 Jun 2024 02:11:13 -0700 (PDT)
Received: from andrejs-nb.. (31-10-206-125.static.upc.ch. [31.10.206.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215813c171sm13162145e9.40.2024.06.05.02.11.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 02:11:12 -0700 (PDT)
From: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1] arm: dts: k3-am625-verdin: add combined binaries
Date: Wed,  5 Jun 2024 11:10:57 +0200
Message-Id: <20240605091057.48225-1-andrejs.cainikovs@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>

Add combined binaries for all Verdin AM62 variants.
These binaries can be used to flash the U-Boot via single
binary instead of few as it is done at the moment.

Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
---
 .../dts/k3-am625-verdin-wifi-dev-binman.dtsi  | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
index a9b86b61e53..0e6188907e4 100644
--- a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
+++ b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
@@ -448,4 +448,72 @@
 	};
 };
 
+&binman {
+	firmware-verdin-am62-gp.bin {
+		filename = "firmware-verdin-am62-gp.bin";
+
+		blob-ext@1 {
+			filename = "tiboot3-am62x-gp-verdin.bin";
+		};
+
+		blob-ext@2 {
+			filename = "tispl.bin_unsigned";
+			/*
+			 * This value matches CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR
+			 * from R5 SPL config.
+			 */
+			offset = <0x80000>;
+		};
+
+		blob-ext@3 {
+			filename = "u-boot.img_unsigned";
+			offset = <(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)>;
+		};
+	};
+
+	firmware-verdin-am62-hs.bin {
+		filename = "firmware-verdin-am62-hs.bin";
+
+		blob-ext@1 {
+			filename = "tiboot3-am62x-hs-verdin.bin";
+		};
+
+		blob-ext@2 {
+			filename = "tispl.bin";
+			/*
+			 * This value matches CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR
+			 * from R5 SPL config.
+			 */
+			offset = <0x80000>;
+		};
+
+		blob-ext@3 {
+			filename = "u-boot.img";
+			offset = <(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)>;
+		};
+	};
+
+	firmware-verdin-am62-hs-fs.bin {
+		filename = "firmware-verdin-am62-hs-fs.bin";
+
+		blob-ext@1 {
+			filename = "tiboot3-am62x-hs-fs-verdin.bin";
+		};
+
+		blob-ext@2 {
+			filename = "tispl.bin";
+			/*
+			 * This value matches CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR
+			 * from R5 SPL config.
+			 */
+			offset = <0x80000>;
+		};
+
+		blob-ext@3 {
+			filename = "u-boot.img";
+			offset = <(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)>;
+		};
+	};
+};
+
 #endif /* CONFIG_TARGET_VERDIN_AM62_A53 */
-- 
2.34.1

