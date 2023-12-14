Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD68C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 16:53:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B131487AF0;
	Thu, 14 Dec 2023 17:52:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JBOXH96S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C4A787AEB; Thu, 14 Dec 2023 17:51:59 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA7F187ADB
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 17:51:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-35d77fb7d94so33491625ab.0
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 08:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702572712; x=1703177512; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OnxaOH30r60T7+oSlSkA+ajW591bR3sRQHUO8KJSj+w=;
 b=JBOXH96SmycC8CzcQ4HuDAKE6qBxx4xFQA0lIx31T0FONq1BJkM1GJrtjCUczBZPKJ
 WCm4X+XutaU+EWdfDm3014lRgoR9+hyeTZSHG07F0+DSIxri+w16+GmTlFCNZEFUT3TU
 pKLyL6naHQE0IwtmSuDVgpwo8EkzhwF2gDGi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702572712; x=1703177512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OnxaOH30r60T7+oSlSkA+ajW591bR3sRQHUO8KJSj+w=;
 b=PTiXFm4mdRhLYVLx5Nari5sR3xYqbzBrqQX1ksj02LLbHjZcU3dJpdCIcoiyhfTXFA
 awLj7RxdcR2PkietKib/SoDr52dwUsuQ3v9ldkd+lspsi96M9muTY4MU+BEkhjGEVTPg
 IUZK33Elisc3slnyg1XiEEwoQJj+m9dbJpbohhf8o6AI/FgcsmjjHTbT1G9dfL0IWoBk
 QYEILcwo7+OMpdYBzyJzdgOVvDN+5HU8mOnMGqcUYTrS+AIAhv6uMsRJnHTkaqp+Qzp7
 4tz9DaF3/xgUGRfFu4iIxIta3Ijkbfrp5qUM3s3mB11WV2ywFrpieBL+2PofHcJf8oGw
 0M/w==
X-Gm-Message-State: AOJu0YwOcMn5W2fC4k5KgSgYU3W0YJoGWlUsxVAXtB9hK/6hBdJe4MKV
 R5kwgqTH4VJPdIDX8FXeXekIg3C6yHntT0xll9MlJw==
X-Google-Smtp-Source: AGHT+IGeoD1LBVMkl1xKuemi/OV0BCazxiML3CBxY5Q1AzYctObcH+HssOWjm1K9WAERcNU5JWN5Jg==
X-Received: by 2002:a05:6e02:1a2d:b0:35d:5995:1d5c with SMTP id
 g13-20020a056e021a2d00b0035d59951d5cmr15282478ile.33.1702572712289; 
 Thu, 14 Dec 2023 08:51:52 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 bn14-20020a056e02338e00b00357ca1ed25esm1228347ilb.80.2023.12.14.08.51.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 08:51:52 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v2 10/21] bootm: Add more fields to bootm_info
Date: Thu, 14 Dec 2023 09:50:19 -0700
Message-ID: <20231214165112.2182274-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231214165112.2182274-1-sjg@chromium.org>
References: <20231214165112.2182274-1-sjg@chromium.org>
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
index 85c560d5a0ae..c9ab55f18d39 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -19,17 +19,52 @@ struct cmd_tbl;
 /**
  * struct bootm_info() - information used when processing images to boot
  *
+ * These mirror the first three arguments of the bootm command. They are
+ * designed to handle any type of image, but typically it is a FIT.
+ *
+ * @addr_fit: Address of image to bootm, as passed to
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
+	const char *addr_fit;
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

