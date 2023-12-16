Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1A6C4332F
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 03:16:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE41C87C7B;
	Sat, 16 Dec 2023 04:15:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Yyqa78md";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEBB087B52; Sat, 16 Dec 2023 04:15:20 +0100 (CET)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E21787C4F
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 04:15:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-35f77a076e1so3231125ab.1
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 19:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702696517; x=1703301317; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4S9K4VtkYqHSTfS5AhSHz0kuHeipFhFPFLKwmETBBGQ=;
 b=Yyqa78md9hGTBYerIIrwY/BuOdr0oCAhvpsoD04nD1ts3AnTfY5Yv6C0ILJoNNv7l7
 WEbLcfVVvSz52DGh/H2SWUVfvQsXrE7e8IsvJMDxX+KYL57I0X6yVEq+ZV8VpGG92/7U
 hk1B5+8Uj+hR69QtBNBSnVu5YUQX5Ud5xQB9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702696517; x=1703301317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4S9K4VtkYqHSTfS5AhSHz0kuHeipFhFPFLKwmETBBGQ=;
 b=ErP9vfX6msaF3xZGzcioZk+XkilW8CQYjLhQVzjosg7VRMgWE9F8hoSITJlU35WYlM
 09n0ClF9Lj75SPA+DCgVSDh7O0aolFqPFe5G+kTKNOp8IJhtkMrZbKzwzc8SukwJGHRP
 pt30z8lIyYeR71QJwN9UNiHQImrfo13N3A64gB4jwG6cyKfpSxgfHVDO+feIJD7wR8tH
 6O1QzmhelYVNBkpTZuvu/YblE4o7ElAKT0IqDvNA7+yk2ZdfCpdmGqCa65gSOyTaygGg
 aujpp5JgRiGdGjuHmP0zuVRpVU/J60Wx0S8qpOXMCDr5Xe7F49aqKqPb5+bTR6p8yo96
 QcJw==
X-Gm-Message-State: AOJu0Yy2QazVVBnpG0G4CDd7D9wnmA94iVSjgEaw7e07LMlFhtZsA+JC
 4/xODQyGvRhcUFgRC5YU9erOhNAMcoxy2WZltCJR3w==
X-Google-Smtp-Source: AGHT+IHbrm1VcN9N4DUS8wzP5pxf8X21wuBzJ7z7lvFRG77bNt/CqLVcUCwOouPCmn7kEi0IXQR1cA==
X-Received: by 2002:a05:6e02:1b06:b0:35d:59b3:2f87 with SMTP id
 i6-20020a056e021b0600b0035d59b32f87mr9967524ilv.28.1702696516961; 
 Fri, 15 Dec 2023 19:15:16 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a92ceca000000b0035f75e80d1esm542163ilq.52.2023.12.15.19.15.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 19:15:16 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v3 10/22] bootm: Add more fields to bootm_info
Date: Fri, 15 Dec 2023 20:14:14 -0700
Message-ID: <20231216031446.2222362-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231216031446.2222362-1-sjg@chromium.org>
References: <20231216031446.2222362-1-sjg@chromium.org>
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

Add fields for the three bootm parameters and other things needed for
booting. Also add a helper to set up the struct correctly.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Rename addr_fit to addr_img in struct bootm_info

Changes in v2:
- Split out adding the rest of struct bootm_info fields to separate patch

 boot/bootm.c    |  8 ++++++++
 include/bootm.h | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/boot/bootm.c b/boot/bootm.c
index f1c45c380659..9e42fa5117d0 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -1192,6 +1192,14 @@ int bootm_boot_start(ulong addr, const char *cmdline)
 	return ret;
 }
 
+void bootm_init(struct bootm_info *bmi)
+{
+	memset(bmi, '\0', sizeof(struct bootm_info));
+	bmi->boot_progress = true;
+	if (IS_ENABLED(CONFIG_CMD_BOOTM))
+		bmi->images = &images;
+}
+
 /**
  * switch_to_non_secure_mode() - switch to non-secure mode
  *
diff --git a/include/bootm.h b/include/bootm.h
index 85c560d5a0ae..7cfaa0a7d053 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -19,17 +19,52 @@ struct cmd_tbl;
 /**
  * struct bootm_info() - information used when processing images to boot
  *
+ * These mirror the first three arguments of the bootm command. They are
+ * designed to handle any type of image, but typically it is a FIT.
+ *
+ * @addr_img: Address of image to bootm, as passed to
+ *	genimg_get_kernel_addr_fit() for processing:
+ *
+ *    NULL: Usees default load address, i.e. image_load_addr
+ *    <addr>: Uses hex address
+ *
+ * For FIT:
+ *    "[<addr>]#<conf>": Uses address (or image_load_addr) and also specifies
+ *	the FIT configuration to use
+ *    "[<addr>]:<subimage>": Uses address (or image_load_addr) and also
+ *	specifies the subimage name containing the OS
+ *
+ * @conf_ramdisk: Address (or with FIT, the name) of the ramdisk image, as
+ *	passed to boot_get_ramdisk() for processing, or NULL for none
+ * @conf_fdt: Address (or with FIT, the name) of the FDT image, as passed to
+ *	boot_get_fdt() for processing, or NULL for none
+ * @boot_progress: true to show boot progress
  * @images: images information
+ * @cmd_name: command which invoked this operation, e.g. "bootm"
  * @argc: Number of arguments to the command (excluding the actual command).
  *	This is 0 if there are no arguments
  * @argv: NULL-terminated list of arguments, or NULL if there are no arguments
  */
 struct bootm_info {
+	const char *addr_img;
+	const char *conf_ramdisk;
+	const char *conf_fdt;
+	bool boot_progress;
 	struct bootm_headers *images;
+	const char *cmd_name;
 	int argc;
 	char *const *argv;
 };
 
+/**
+ * bootm_init() - Set up a bootm_info struct with useful defaults
+ *
+ * Set up the struct with default values for all members:
+ * @boot_progress is set to true and @images is set to the global images
+ * variable. Everything else is set to NULL except @argc which is 0
+ */
+void bootm_init(struct bootm_info *bmi);
+
 /*
  *  Continue booting an OS image; caller already has:
  *  - copied image header to global variable `header'
-- 
2.43.0.472.g3155946c3a-goog

