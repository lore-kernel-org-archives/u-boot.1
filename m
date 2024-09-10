Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB70ECE582
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 06:39:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 708B588BDA;
	Tue, 10 Sep 2024 08:39:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vo9L8gJL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5602388EEE; Tue, 10 Sep 2024 08:39:40 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 636F688960
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 08:39:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a8ce5db8668so567452166b.1
 for <u-boot@lists.denx.de>; Mon, 09 Sep 2024 23:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725950378; x=1726555178; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JYGfALPIlLFLoQcqioSl61d2f2Lj4NeOUi5RgHuuLuQ=;
 b=vo9L8gJLgEnlbhRraTV5BZY/uxlyQKHm6dncpgmKtfmbQQ27NkbL1OhIYwVOEXHmpA
 7HOEG68A5sCk8RIyjjdAl3RTW3URn7u7SBZtAVJ8g46Qb06fzexQVUuPuZgFp42ZQTHa
 DMPzwUjX0hdZugbGaSPj8twhkiUCKMr/mWwfbB5M2/c2G1gvx0uv720xQSuw2V9gLuAv
 R/qoa5E2D6hDxROd9wUS8lhMHa9iFRQr8zNMZmv/MwhFSPGmvXITMBrG5Q4ZrzYvECWb
 mhaSgQBM/VMXj7pXT5ivD2ESgS7tXbhP2vuxtdPBeYw5dO5pbr/VG4EgA1sdrqF+r7JE
 0Oyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725950378; x=1726555178;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JYGfALPIlLFLoQcqioSl61d2f2Lj4NeOUi5RgHuuLuQ=;
 b=szq6YV2hMgdLRkqF3uP82yG3LL/sRYEnSoPZVsxupAf01km+J9hSho9Yl8qkzbP9OT
 uZDYqpa0V5YRzQygSZtPt0Z4tlksarKEq7j3pV5WovSLUwh+TyKRXZ78TuVB5MlpRthU
 GzH3yJ/gza6mbfSpfkhlXcTfmIffeQyta4Va8fllvg8M6CYwCXENu+lAjybVmBEAlFm1
 41hK4E6Bjk5GGXfIhLo/L0VlH9Oqccn8/ol1GLIf5Ycw/bP8IzrGB6QFS28xo5aKwcpM
 kf0r/1X8k5GUHqr7aamHHCDkfdwpE1BeToxDaNcsTCfzEUkrM7zvcfaGDl3OLkqsRriz
 GKZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTte8HcA1ZLMTGr2XXC+GO+73g2QTW6ATY8OaleuUURfZ+5yLaVYcp506VLo3m0vlHGoedUG8=@lists.denx.de
X-Gm-Message-State: AOJu0YyS9ATesKXbtOUTTimhfDVc3jjFMcKuNKcLbxKlXDB5tjTpNxO0
 lI+JfCbiSj8aSCLlDdWZFn3w7aKL0E4gWeDXIcDFkzwyH0gXD8u2JBlqepU8itI=
X-Google-Smtp-Source: AGHT+IEW/hMLmJ/wBENA5EW3B0EJaAvNQd2pivDeMl0Ven1iniPzXjgB3b9e9RSKs3PXqxN0uvQuHA==
X-Received: by 2002:a17:906:f5a9:b0:a8a:91d1:5262 with SMTP id
 a640c23a62f3a-a8d1bfcbdd2mr1240212766b.28.1725950377232; 
 Mon, 09 Sep 2024 23:39:37 -0700 (PDT)
Received: from localhost.localdomain (ppp176092143132.access.hol.gr.
 [176.92.143.132]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c61210sm434884966b.113.2024.09.09.23.39.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 23:39:36 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: pbrobinson@gmail.com,
	mbrugger@suse.com
Cc: sughosh.ganu@linaro.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Roese <sr@denx.de>,
 "Ivan T. Ivanov" <iivanov@suse.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Subject: [PATCH] board: rpi: Enable capsule updates
Date: Tue, 10 Sep 2024 09:39:32 +0300
Message-ID: <20240910063933.141283-1-ilias.apalodimas@linaro.org>
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

Since RPI works well using EFI and has no size limitations with regards
to U-Boot, add the needed structures and Kconfig options needed to
enable capsule updates
---
 board/raspberrypi/rpi/rpi.c | 22 ++++++++++++++++++++++
 configs/rpi_4_defconfig     |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
index ab5ea85cf9f8..1f342eee12b2 100644
--- a/board/raspberrypi/rpi/rpi.c
+++ b/board/raspberrypi/rpi/rpi.c
@@ -63,6 +63,28 @@ struct msg_get_clock_rate {
 	u32 end_tag;
 };
 
+struct efi_fw_image fw_images[] = {
+	{
+		.fw_name = u"RPI_UBOOT",
+		.image_index = 1,
+	},
+};
+
+struct efi_capsule_update_info update_info = {
+	.dfu_string = "mmc 0=u-boot.bin fat 0 1",
+	.num_images = ARRAY_SIZE(fw_images),
+	.images = fw_images,
+};
+
+#if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
+void set_dfu_alt_info(char *interface, char *devstr)
+{
+	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
+		env_set("dfu_alt_info", update_info.dfu_string);
+}
+#endif
+
+
 #ifdef CONFIG_ARM64
 #define DTB_DIR "broadcom/"
 #else
diff --git a/configs/rpi_4_defconfig b/configs/rpi_4_defconfig
index f5fb322aa8fc..c70414e6fcaf 100644
--- a/configs/rpi_4_defconfig
+++ b/configs/rpi_4_defconfig
@@ -65,3 +65,5 @@ CONFIG_SYS_WHITE_ON_BLACK=y
 CONFIG_VIDEO_BCM2835=y
 CONFIG_CONSOLE_SCROLL_LINES=10
 CONFIG_PHYS_TO_BUS=y
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
-- 
2.45.2

