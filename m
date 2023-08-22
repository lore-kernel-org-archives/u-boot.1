Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22873EE49A3
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 11:25:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28B2B864E2;
	Tue, 22 Aug 2023 13:23:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e/AebKTO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7A85864E7; Tue, 22 Aug 2023 13:22:56 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19BF9864D2
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 13:22:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9936b3d0286so584079666b.0
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 04:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692703372; x=1693308172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fEa198a6fMa7GR83hbK0P0c49BjDlUPNQRyCWL0U6Wg=;
 b=e/AebKTOnYEP/OO12K+b5N5heN34zmxi8FZZia/rlq8i0dRSSjR8i2ZaVNVqEduhdT
 6Kqd/Ldae2YsjY0ibswvg1/85Bi9gsfpnokT1LKX3Ca64ArTIYtsKDmTZcvTnTLoU6pA
 qh7ufpnFZvrlbeCRw5fNzn+V30PUwLpeqYYexw4JTvbNr6KYCC/ARwqk1h1qEwkcoeoD
 8u6HrTphfvfH+LandbAnUb8zdTYCrTMp5yw2JV2vvJhAD5KCKbtJiot7DXgoX9wnFhRF
 rz0xnARoR9x5e7XGHA97fWRvgLOSxp+GpjF8R0DZDCdgNeOnA29plX907Y0ln2F70gsP
 9pBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692703372; x=1693308172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fEa198a6fMa7GR83hbK0P0c49BjDlUPNQRyCWL0U6Wg=;
 b=KweQYkOB/1QY+YaF37D8MXvL8ZZwL6RPNwtNOGiG84/cRB5zPtAS72HhyP2W1ka4f8
 2U1DLk8ZYuPEOaDTZQ4d/JBJOej+A03pYelhJr7zxczxz9voTLwhppbdwskOfpseIdzp
 WJ3qCL0A9F/06ieWduHDtg5BC1Pnt0FvQwQABzQbk8+pbNblDggH+3IYFbkNquKvG8Ij
 ZQ9ZZ2vsNqtGe1rbJESrGXCnFlzOhUlioueIM5PswRAUkmwPOalArhPxufSeqopH1jB6
 KFzGFPh+FgBnY3u8WML0XM98NUTicd8rwfriPylEav1DcUnS13WKa2RNv5JkLTtWOZfF
 F18g==
X-Gm-Message-State: AOJu0YzDkBqD1iznfi4bEXv+pqyMblov1xgW2N+/Wgd03KDvrnmojiaI
 a4c1dnQlyshtRuXrbQdePvkODzF94cv1Qw==
X-Google-Smtp-Source: AGHT+IEwnG7UyMn5ls11B4+TLnJ1mjhlyQkPxaxUgFMs7tHzWB4NgYFFlEl4UVZB5dH24otMR9HzMQ==
X-Received: by 2002:a17:907:78cb:b0:99d:decf:1a0d with SMTP id
 kv11-20020a17090778cb00b0099ddecf1a0dmr8184948ejc.3.1692703372561; 
 Tue, 22 Aug 2023 04:22:52 -0700 (PDT)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 mh9-20020a170906eb8900b009934855d8f1sm8041456ejb.34.2023.08.22.04.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 04:22:52 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 15/19] ARM: tegra: board2: add generic late init
Date: Tue, 22 Aug 2023 14:22:13 +0300
Message-Id: <20230822112217.4646-16-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230822112217.4646-1-clamor95@gmail.com>
References: <20230822112217.4646-1-clamor95@gmail.com>
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

Board specific late init allows vendors to set up different device
or board specific env variables (like serial number, platform name).
In case this information is missing, u-boot will lack info regards
serial or platform.

To avoid this prior nvidia_board_late_init internal generic function
is called which fills required data. In this case platform name is
obtained from get_chip and serialno is filled with SoC id.

Though SoC id is not dedicated to be devices serial but it fits well
in case of restriction of data about device and since SoC is basically
a main chip of the device.

Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com> # ASUS Transformers
Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Nvidia Tegratab
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/mach-tegra/board2.c | 43 ++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/mach-tegra/board2.c b/arch/arm/mach-tegra/board2.c
index 981768bb0e..ee69cb657a 100644
--- a/arch/arm/mach-tegra/board2.c
+++ b/arch/arm/mach-tegra/board2.c
@@ -26,6 +26,10 @@
 #include <asm/arch-tegra/gpu.h>
 #include <asm/arch-tegra/usb.h>
 #include <asm/arch-tegra/xusb-padctl.h>
+#ifndef CONFIG_TEGRA186
+#include <asm/arch-tegra/fuse.h>
+#include <asm/arch/gp_padctrl.h>
+#endif
 #if IS_ENABLED(CONFIG_TEGRA_CLKRST)
 #include <asm/arch/clock.h>
 #endif
@@ -256,6 +260,37 @@ int board_early_init_f(void)
 }
 #endif	/* EARLY_INIT */
 
+#ifndef CONFIG_TEGRA186
+static void nvidia_board_late_init_generic(void)
+{
+	char serialno_str[17];
+
+	/* Set chip id as serialno */
+	sprintf(serialno_str, "%016llx", tegra_chip_uid());
+	env_set("serial#", serialno_str);
+
+	switch (tegra_get_chip()) {
+	case CHIPID_TEGRA20:
+		env_set("platform", "Tegra 2 T20");
+		break;
+	case CHIPID_TEGRA30:
+		env_set("platform", "Tegra 3 T30");
+		break;
+	case CHIPID_TEGRA114:
+		env_set("platform", "Tegra 4 T114");
+		break;
+	case CHIPID_TEGRA124:
+		env_set("platform", "Tegra K1 T124");
+		break;
+	case CHIPID_TEGRA210:
+		env_set("platform", "Tegra X1 T210");
+		break;
+	default:
+		return;
+	}
+}
+#endif
+
 int board_late_init(void)
 {
 #if defined(CONFIG_TEGRA_SUPPORT_NON_SECURE)
@@ -268,6 +303,14 @@ int board_late_init(void)
 #endif
 	start_cpu_fan();
 	cboot_late_init();
+
+	/*
+	 * Perform generic env setup in case
+	 * vendor does not provide it.
+	 */
+#ifndef CONFIG_TEGRA186
+	nvidia_board_late_init_generic();
+#endif
 	nvidia_board_late_init();
 
 	return 0;
-- 
2.39.2

