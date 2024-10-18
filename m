Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EDF0D30011
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 14:53:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0FB18917E;
	Fri, 18 Oct 2024 16:52:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BItAJHoj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED64E88E90; Fri, 18 Oct 2024 16:52:11 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACEB788CC1
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 16:52:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-83ac05206f6so13932439f.2
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 07:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729263128; x=1729867928; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u6GARXU1VRcOXUZrPNoC1Bn6G8dbbXTtSz+fL+GqUz8=;
 b=BItAJHojQ75XZcBrUR8v0FBOXn6veLLT85JpwYXyStpV6PzSjmRM9hRN+jFJW+fJ+f
 xu/b4b+RqOiJV8p2t8zwIWQGpIqGoIC9Vyyo2B8JxvpCXwCRendetT13LmrECm0Cs5rD
 TsBxnrH0nttEUUuuiSMEqUtvVXgu4wvNs5kw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729263128; x=1729867928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u6GARXU1VRcOXUZrPNoC1Bn6G8dbbXTtSz+fL+GqUz8=;
 b=pkWKVf3YCyDvVREi3Kee4M0dc4B1S86lEO01pdufNzhSAHI1MnVQlgA/nIxEoncDNU
 V/KX9JPYDf+gnKHoyGmHIZfMNCIByegHcc6yNEVSkm0jNICF+vr20gYT5IyoOffxyYo+
 kKGR+JPGKHtu5Igk4JNG8l1yk2WILpKdz6m86tB2GxfYnkIWe/pTq4v4XdV/HAqnWGwP
 rlXS02V9BjJnALehQ2SCBw69EYPSjiYGiLlLwpZVKXQuclyxNVBAQpmhZTA1cNYBb++J
 gxjBFzX0qA33YFNX0WOF1q6TrY0bt4t6M3B5It5YYLgl06E7IWB5rgAJFVdUvfdjMvAb
 wdcQ==
X-Gm-Message-State: AOJu0Ywy+gxhXclXRXokoybNNAZEvEvi8ApaRPFxDurvfHcbGKDXWjzK
 +tYf6yNjdRgmylrinVpeO4LvcyeMgXUA35qQFtOviEtZIJlWR6QKkyt3zuWETmPamUrV9Ku1Bys
 =
X-Google-Smtp-Source: AGHT+IG3iNfw5sLBp/3CTOpCwW/HXByz6UyyXxq+BFnEiyGSLugcc+PPOOZ/8CHwVsKaFLk5wvWiJg==
X-Received: by 2002:a05:6602:6b89:b0:83a:942d:7ded with SMTP id
 ca18e2360f4ac-83aba5f08bfmr259641139f.6.1729263128220; 
 Fri, 18 Oct 2024 07:52:08 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b5adf1sm450573173.3.2024.10.18.07.52.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 07:52:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Shantur Rathore <i@shantur.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH 6/6] efi: Pass in the require parameters from EFI bootmeth
Date: Fri, 18 Oct 2024 08:51:57 -0600
Message-Id: <20241018145157.3918429-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018145157.3918429-1-sjg@chromium.org>
References: <20241018145157.3918429-1-sjg@chromium.org>
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

Rather than setting up the global variables and then making the call,
pass them into function directly. This cleans up the code and makes it
all a bit easier to understand.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootmeth_efi.c          | 49 ++----------------------------------
 include/efi_loader.h         | 10 ++++++++
 lib/efi_loader/efi_bootbin.c | 46 +++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 47 deletions(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index 2ad6d3b4ace..f5b73c09441 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -73,40 +73,6 @@ static bool bootmeth_uses_network(struct bootflow *bflow)
 	    device_get_uclass_id(media) == UCLASS_ETH;
 }
 
-static void set_efi_bootdev(struct blk_desc *desc, struct bootflow *bflow)
-{
-	const struct udevice *media_dev;
-	int size = bflow->size;
-	const char *dev_name;
-	char devnum_str[9];
-	char dirname[200];
-	char *last_slash;
-
-	/*
-	 * This is a horrible hack to tell EFI about this boot device. Once we
-	 * unify EFI with the rest of U-Boot we can clean this up. The same hack
-	 * exists in multiple places, e.g. in the fs, tftp and load commands.
-	 *
-	 * Once we can clean up the EFI code to make proper use of driver model,
-	 * this can go away.
-	 */
-	media_dev = dev_get_parent(bflow->dev);
-	snprintf(devnum_str, sizeof(devnum_str), "%x:%x",
-		 desc ? desc->devnum : dev_seq(media_dev),
-		 bflow->part);
-
-	strlcpy(dirname, bflow->fname, sizeof(dirname));
-	last_slash = strrchr(dirname, '/');
-	if (last_slash)
-		*last_slash = '\0';
-
-	dev_name = device_get_uclass_id(media_dev) == UCLASS_MASS_STORAGE ?
-		 "usb" : blk_get_uclass_name(device_get_uclass_id(media_dev));
-	log_debug("setting bootdev %s, %s, %s, %p, %x\n",
-		  dev_name, devnum_str, bflow->fname, bflow->buf, size);
-	efi_set_bootdev(dev_name, devnum_str, bflow->fname, bflow->buf, size);
-}
-
 static int efiload_read_file(struct bootflow *bflow, ulong addr)
 {
 	struct blk_desc *desc = NULL;
@@ -124,8 +90,6 @@ static int efiload_read_file(struct bootflow *bflow, ulong addr)
 		return log_msg_ret("read", ret);
 	bflow->buf = map_sysmem(addr, bflow->size);
 
-	set_efi_bootdev(desc, bflow);
-
 	return 0;
 }
 
@@ -363,17 +327,8 @@ static int distro_efi_boot(struct udevice *dev, struct bootflow *bflow)
 		fdt = env_get_hex("fdt_addr_r", 0);
 	}
 
-	if (bflow->flags & BOOTFLOWF_USE_BUILTIN_FDT) {
-		log_debug("Booting with built-in fdt\n");
-		if (efi_binary_run(map_sysmem(kernel, 0), bflow->size,
-				   EFI_FDT_USE_INTERNAL))
-			return log_msg_ret("run", -EINVAL);
-	} else {
-		log_debug("Booting with external fdt\n");
-		if (efi_binary_run(map_sysmem(kernel, 0), bflow->size,
-				   map_sysmem(fdt, 0)))
-			return log_msg_ret("run", -EINVAL);
-	}
+	if (efi_bootflow_run(bflow))
+		return log_msg_ret("run", -EINVAL);
 
 	return 0;
 }
diff --git a/include/efi_loader.h b/include/efi_loader.h
index 291eca5c077..3a4b948f60f 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -19,6 +19,7 @@
 #include <linux/oid_registry.h>
 
 struct blk_desc;
+struct bootflow;
 struct jmp_buf_data;
 
 #if CONFIG_IS_ENABLED(EFI_LOADER)
@@ -544,6 +545,15 @@ efi_status_t efi_install_fdt(void *fdt);
 efi_status_t do_bootefi_exec(efi_handle_t handle, void *load_options);
 /* Run loaded UEFI image with given fdt */
 efi_status_t efi_binary_run(void *image, size_t size, void *fdt);
+
+/**
+ * efi_bootflow_run() - Run a bootflow containing an EFI application
+ *
+ * @bootflow: Bootflow to run
+ * Return: Status code, something went wrong
+ */
+efi_status_t efi_bootflow_run(struct bootflow *bootflow);
+
 /* Initialize variable services */
 efi_status_t efi_init_variables(void);
 /* Notify ExitBootServices() is called */
diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index 3646c706dd3..e4a130da2a4 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -6,13 +6,16 @@
 
 #define LOG_CATEGORY LOGC_EFI
 
+#include <bootflow.h>
 #include <charset.h>
+#include <dm.h>
 #include <efi.h>
 #include <efi_loader.h>
 #include <env.h>
 #include <image.h>
 #include <log.h>
 #include <malloc.h>
+#include <mapmem.h>
 
 static struct efi_device_path *bootefi_image_path;
 static struct efi_device_path *bootefi_device_path;
@@ -253,3 +256,46 @@ out:
 	return ret;
 }
 
+efi_status_t efi_bootflow_run(struct bootflow *bflow)
+{
+	struct efi_device_path *device, *image;
+	const struct udevice *media_dev;
+	struct blk_desc *desc = NULL;
+	const char *dev_name;
+	char devnum_str[9];
+	char dirname[200];
+	char *last_slash;
+	efi_status_t ret;
+	void *fdt;
+
+	if (bflow->blk)
+		desc = dev_get_uclass_plat(bflow->blk);
+
+	media_dev = dev_get_parent(bflow->dev);
+	snprintf(devnum_str, sizeof(devnum_str), "%x:%x",
+		 desc ? desc->devnum : dev_seq(media_dev),
+		 bflow->part);
+
+	strlcpy(dirname, bflow->fname, sizeof(dirname));
+	last_slash = strrchr(dirname, '/');
+	if (last_slash)
+		*last_slash = '\0';
+	dev_name = device_get_uclass_id(media_dev) == UCLASS_MASS_STORAGE ?
+		 "usb" : blk_get_uclass_name(device_get_uclass_id(media_dev));
+
+	ret = calculate_paths(dev_name, devnum_str, dirname, &device, &image);
+	if (ret)
+		return ret;
+
+	if (bflow->flags & BOOTFLOWF_USE_BUILTIN_FDT) {
+		log_debug("Booting with built-in fdt\n");
+		fdt = EFI_FDT_USE_INTERNAL;
+	} else {
+		log_debug("Booting with external fdt\n");
+		fdt = map_sysmem(bflow->fdt_addr, 0);
+	}
+	ret = efi_binary_run_(bflow->buf, bflow->size, fdt, device, image);
+
+	return ret;
+}
+
-- 
2.34.1

