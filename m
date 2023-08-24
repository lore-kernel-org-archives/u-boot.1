Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB7DC27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:59:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28CD586A49;
	Thu, 24 Aug 2023 21:56:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mUbLFXRX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0133A8683C; Thu, 24 Aug 2023 21:56:21 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2212B869B8
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:56:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-792707f78b5so8195739f.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692906976; x=1693511776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pwyIhU8PDI/9PoJgGR0ubVgCSfGmv1uKYAyf+SNQi2U=;
 b=mUbLFXRX8/NvePdec2D/BW5DPJWncossmZE8rKj8vdlDHC+0OoLSumIv+C2YSRxSl1
 P/LdiHNI1QgbSmO/tqRXUVBlpw0uJZqpNIkyV/Kwc/7maXPb6otacefjbPn8te6BOaYI
 82kNEwenlqBa/tZ+fBzQpY4qMFQhwSfyHE2OI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692906976; x=1693511776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pwyIhU8PDI/9PoJgGR0ubVgCSfGmv1uKYAyf+SNQi2U=;
 b=ec1W0fMoGx1bbBUci9sS24jYSRI+9irGHDtZZ0IS9nP3QORmoCWdBiMG82REukcLa7
 iPnG9p1BC57SeoCl01nJpQ9xPiw5mnjEErHtTngWeiUncpPFJGZuOusY1ow46WgRT8hR
 aLFXJfx+UhVYRYUePrtqGNr6kXsenbCvzJAIwX5SbiluKrOIk5OUY7twjWRGKf1F4tyi
 DSexHlf3Ovu+5EvfYOVEDI/4gfI40IH6EdAr/oMY4cl1bDib6hqUkr59lmq9FgoXgAuR
 MAyOLLFUTt3K8Cf12fSTLF9lqOEJCzADid8kvfZ8mqDlkSAQzvjo3a9tx9ZtusjXClB8
 SwNg==
X-Gm-Message-State: AOJu0Yw/bjumeS/dVZFc5xVyeu2vmdem3/obhjBSSZ+vK8Y9tdGknX0f
 saPcEYOV95ZiQy4YJK/3hzy2ZwrimNkHcAgQ8JA=
X-Google-Smtp-Source: AGHT+IGPeh3ueiipPT6ppitQ66oliz0/orFLJS2B3I4837hPAdWpSCiYsW0KaVdkvAALctYlvJ0QwQ==
X-Received: by 2002:a5d:930c:0:b0:783:550e:33c0 with SMTP id
 l12-20020a5d930c000000b00783550e33c0mr7659730ion.7.1692906976773; 
 Thu, 24 Aug 2023 12:56:16 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 b22-20020a6be716000000b007925328d6ddsm12734ioh.20.2023.08.24.12.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:56:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 21/23] uuid: Add ChromiumOS partition types
Date: Thu, 24 Aug 2023 13:55:44 -0600
Message-ID: <20230824195553.1685996-22-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824195553.1685996-1-sjg@chromium.org>
References: <20230824195553.1685996-1-sjg@chromium.org>
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

Add some GUIDs for ChromiumOS so we can detect the partitions.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/part_efi.h | 14 ++++++++++++++
 lib/uuid.c         |  7 +++++++
 2 files changed, 21 insertions(+)

diff --git a/include/part_efi.h b/include/part_efi.h
index c68529b4dafe..59b7895b8a23 100644
--- a/include/part_efi.h
+++ b/include/part_efi.h
@@ -60,6 +60,20 @@
 	EFI_GUID( 0x3de21764, 0x95bd, 0x54bd, \
 		0xa5, 0xc3, 0x4a, 0xbe, 0x78, 0x6f, 0x38, 0xa8)
 
+/* Special ChromiumOS things */
+#define PARTITION_CROS_KERNEL \
+	EFI_GUID(0xfe3a2a5d, 0x4f32, 0x41a7, \
+		 0xb7, 0x25, 0xac, 0xcc, 0x32, 0x85, 0xa3, 0x09)
+#define PARTITION_CROS_ROOT \
+	EFI_GUID(0x3cb8e202, 0x3b7e, 0x47dd, \
+		 0x8a, 0x3c, 0x7f, 0xf2, 0xa1, 0x3c, 0xfc, 0xec)
+#define PARTITION_CROS_FIRMWARE \
+	EFI_GUID(0xcab6e88e, 0xabf3, 0x4102, \
+		 0xa0, 0x7a, 0xd4, 0xbb, 0x9b, 0xe3, 0xc1, 0xd3)
+#define PARTITION_CROS_RESERVED \
+	EFI_GUID(0x2e0a753d, 0x9e48, 0x43b0, \
+		 0x83, 0x37, 0xb1, 0x51, 0x92, 0xcb, 0x1b, 0x5e)
+
 /* linux/include/efi.h */
 typedef u16 efi_char16_t;
 
diff --git a/lib/uuid.c b/lib/uuid.c
index 3bdb20b0e5b6..afb40bff507a 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -7,6 +7,8 @@
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
  */
 
+#define LOG_CATEGOT LOGC_CORE
+
 #include <common.h>
 #include <command.h>
 #include <efi_api.h>
@@ -61,6 +63,10 @@ static const struct {
 	{"swap",	PARTITION_LINUX_SWAP_GUID},
 	{"lvm",		PARTITION_LINUX_LVM_GUID},
 	{"u-boot-env",	PARTITION_U_BOOT_ENVIRONMENT},
+	{"cros-kern",	PARTITION_CROS_KERNEL},
+	{"cros-root",	PARTITION_CROS_ROOT},
+	{"cros-fw",	PARTITION_CROS_FIRMWARE},
+	{"cros-rsrv",	PARTITION_CROS_RESERVED},
 #endif
 #if defined(CONFIG_CMD_EFIDEBUG) || defined(CONFIG_EFI)
 	{
@@ -258,6 +264,7 @@ int uuid_str_to_bin(const char *uuid_str, unsigned char *uuid_bin,
 	uint64_t tmp64;
 
 	if (!uuid_str_valid(uuid_str)) {
+		log_debug("not valid\n");
 #ifdef CONFIG_PARTITION_TYPE_GUID
 		if (!uuid_guid_get_bin(uuid_str, uuid_bin))
 			return 0;
-- 
2.42.0.rc1.204.g551eb34607-goog

