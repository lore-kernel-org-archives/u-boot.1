Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6134C71136
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 09:05:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 520E386C93;
	Fri, 18 Aug 2023 11:05:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aMianJ9G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07E6B86C73; Fri, 18 Aug 2023 11:05:13 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35C7086C76
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 11:05:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-4ff9bbc83a5so913633e87.1
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 02:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692349509; x=1692954309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kZE1CtnT7xwGm6Qeo+2XOdk+uSHEA1NmFqpRkhF7JAA=;
 b=aMianJ9G8zdt3R/g5dw/tMEMQYqueq/yPCowV42xWSKfvv/ZWKBF6C3TqJhXBvNVNy
 rNASEQu8ns11XrMfiFC9q+zzYWrj0/GdNWNVmupD4giL3K3vY7iuo222NaAABQ+Am9JS
 buBcnoMjirtHrxwTQwIexExFrQ05tMlVEExzT2UfqKytpPb27s7umywkKfVmDQo9Gmcz
 d055kVKSm/fkTAdRXmDdyOst5LZWT4vg4+Uto5YMs53tjLWCxjI8GLL5BHY0b2K4lJRd
 Y4f4EMhGUmbwJj9f7M4UZpa7NFc8sE903flHvuhtse5O8flJpisd7KMg4iCZWmMn5IPC
 Vh1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692349509; x=1692954309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kZE1CtnT7xwGm6Qeo+2XOdk+uSHEA1NmFqpRkhF7JAA=;
 b=TPc3EQosLdnDR4iMir03doqdx/Z5neiM9ZA+2jZAO+EVU48SsaUlxnnJHTHriU2VsU
 Yyx/+tpgjkSOjhUeDDOcEnQsB1io8rc2uoofbFTFrHmNUe9gDSY8Rsi5MvcU0lpiJGvd
 ZCIM5MzSzpvk/s6k3Ju46DF0hO/LxQp+Zo4cGeo7h7scv7in6LbSN13hWmZljKt0TF+2
 93WMvu0jfgtBtVOOSb8YPjnmFg3+QCINbFr41Nep17x2pZ0tHAItDGLAoyigimC9ulty
 cyPhEPchL+5TiGHNJ/JLnoZeNbvgsKZH3TGf3IVCDXTPnX+b/ngOvLATmwYes7MVM8In
 XLiA==
X-Gm-Message-State: AOJu0YzGKPS3dYXHiBdlmZM6lNuARjOznG5M2DlWMYe3HLwsBDvO3hVU
 E9YjDlaOM4+wSBV4MR24KQQ=
X-Google-Smtp-Source: AGHT+IH6kyzkbxZFgDlURnppf6KAq7RZVe5CO3l7xNWAuIdHWJbH1raNnZRUCh9RfGnmiuHzb5DLyw==
X-Received: by 2002:ac2:5f6d:0:b0:4fb:99c7:bb60 with SMTP id
 c13-20020ac25f6d000000b004fb99c7bb60mr1063937lfc.59.1692349509058; 
 Fri, 18 Aug 2023 02:05:09 -0700 (PDT)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 va30-20020a17090711de00b0099ce025f8ccsm926772ejb.186.2023.08.18.02.05.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 02:05:08 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Maxim Schwalm <maxim.schwalm@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v9 2/7] configs: tegra-common-post: make PXE and DHCP boot
 targets optional
Date: Fri, 18 Aug 2023 12:04:42 +0300
Message-Id: <20230818090447.348820-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230818090447.348820-1-clamor95@gmail.com>
References: <20230818090447.348820-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Jonas Schwöbel <jonasschwoebel@yahoo.de>

Disabling the network related features in defconfig causes build to
fail so make them optional.

Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com> # ASUS Grouper E1565
Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # LG P895 T30
Signed-off-by: Jonas Schwöbel <jonasschwoebel@yahoo.de>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 include/configs/tegra-common-post.h | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/configs/tegra-common-post.h b/include/configs/tegra-common-post.h
index 2d5095639a..0d0965ecce 100644
--- a/include/configs/tegra-common-post.h
+++ b/include/configs/tegra-common-post.h
@@ -8,9 +8,21 @@
 #define __TEGRA_COMMON_POST_H
 
 #if IS_ENABLED(CONFIG_CMD_USB)
-# define BOOT_TARGET_USB(func) func(USB, usb, 0)
+#define BOOT_TARGET_USB(func) func(USB, usb, 0)
 #else
-# define BOOT_TARGET_USB(func)
+#define BOOT_TARGET_USB(func)
+#endif
+
+#if CONFIG_IS_ENABLED(CMD_DHCP) && CONFIG_IS_ENABLED(CMD_PXE)
+#define BOOT_TARGET_PXE(func) func(PXE, pxe, na)
+#else
+#define BOOT_TARGET_PXE(func)
+#endif
+
+#if CONFIG_IS_ENABLED(CMD_DHCP)
+#define BOOT_TARGET_DHCP(func) func(DHCP, dhcp, na)
+#else
+#define BOOT_TARGET_DHCP(func)
 #endif
 
 #ifndef BOOT_TARGET_DEVICES
@@ -18,8 +30,8 @@
 	func(MMC, mmc, 1) \
 	func(MMC, mmc, 0) \
 	BOOT_TARGET_USB(func) \
-	func(PXE, pxe, na) \
-	func(DHCP, dhcp, na)
+	BOOT_TARGET_PXE(func) \
+	BOOT_TARGET_DHCP(func)
 #endif
 #include <config_distro_bootcmd.h>
 
-- 
2.39.2

