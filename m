Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FA4C0218B
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 22:08:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 046EF803B5;
	Thu, 23 Jan 2025 23:07:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H+7znn93";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA06F807E1; Thu, 23 Jan 2025 23:07:47 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DEB1807E0
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 23:07:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-71e181fb288so725669a34.2
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 14:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737670061; x=1738274861; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P2yuhdN7S7z62BBZqZYFK88p9a+b76HeeG1HshNxZk4=;
 b=H+7znn93rWPxJeyr2Kb/Ftf7N99X4VoN63mOTzjoU5uN1yFWa/sHbdpEsCIKgx1/QM
 rY50M2AhWBdGp3UDRSjfcC36iEOrdzy4P1j1CTVgi/98bA1haFkOA3E+5qae6t6Ndh+e
 fLk2EbgJANAqT/lE20ckFk7ZMTP86IHzkcHbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737670061; x=1738274861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P2yuhdN7S7z62BBZqZYFK88p9a+b76HeeG1HshNxZk4=;
 b=JfeXhu2vy2BF/FM/vjqLECVlrwmaocd3cwwWeAPnd0gHSR2AwaqWkGaabUXH2pkpu1
 aGwaW3p3rdnE9VpyF3uSHmAqWTlRfv9PB2tDNxjMIKV2QyuC8Dez/wr7VJknqpA7y4kY
 UeSf+mlf4XN4x5xUThBjk9IzeZuf5f5f3Sh8xh1JF/0lT7f3xypqZUOX6tJc4EqrSnSc
 6v4LuPOVgZQlx1bdfjM9L/DtdMip26hrVFfntn19ij82yDWXYrprIJm/HIN3+kXJDl2i
 DSkGCJt1KYBRdK9gJKivLqN0S0DvbNcOa6UbIeNj/7UnccUVu4fSA2EBGsERnmisMt61
 Zosw==
X-Gm-Message-State: AOJu0Yz8kxzZw0DtCf7X5A/fj7ZBdzSl7dc7a0oESqTqO6aEmag00YJX
 fR8kSe4ybTQUsXSMMAYsMhErjiS5DtwNwg2dRIFibty26qitU+neX4lBlEh6qb3lQhTvWl0iCi0
 =
X-Gm-Gg: ASbGncu3JKp23zzywRjUyC0MjC5shT+knpVn9+xmd7vXYzuFIa4juKE6IRSDLVVATmc
 HfG0OTx9pc7hGnc1b9iWx3UjE3d8F4Y1Y3ZEP0PCLqQR6PwelVi4mcJ3kD4HiMcKLGE2kZdJOGy
 F67QX0d+22ImIX/W9d8CFGEZAEiEWS6rXSTPdBPh2rVx6Zlbo48VU4B4eE0IVtxVXPD3fQ+hfue
 g7OlV9OSGXGsqOazUy/S9AANqsPZfN8NytuRbDXk/za3fGicGPjfRzx5eOuzj5kbjHW3ECX1gAE
 2SBjSzk6ojMQF0HNHj5/18xFttML0Fk3kn0xi01AuA==
X-Google-Smtp-Source: AGHT+IG9OU9r6P2SnxXLi+2dSnZXWA0DGrmE/w9hSbNPg/7/fl6FpqMBK2+WF9XHBu0l7THwFKkOWg==
X-Received: by 2002:a05:6830:6d0d:b0:71d:6314:40dd with SMTP id
 46e09a7af769-7249da8f751mr16847962a34.14.1737670061643; 
 Thu, 23 Jan 2025 14:07:41 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-724ecda47bbsm143136a34.2.2025.01.23.14.07.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 14:07:40 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Adriano Cordova <adrianox@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Moritz Fischer <moritzf@google.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v5 4/5] efi_loader: Pass in the required parameters from EFI
 bootmeth
Date: Thu, 23 Jan 2025 15:07:23 -0700
Message-ID: <20250123220726.412396-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250123220726.412396-1-sjg@chromium.org>
References: <20250123220726.412396-1-sjg@chromium.org>
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

Changes in v5:
- Rebase on earlier change

Changes in v2:
- Use efi_loader tag instead of efi
- Drop unnecessary path removal
- Fix 'require' typo
- Move calculation of dev-name into a separate function

 boot/bootmeth_efi.c          | 49 +------------------------
 include/efi_loader.h         | 10 +++++
 lib/efi_loader/efi_bootbin.c | 71 ++++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+), 47 deletions(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index a2998452666..b745ba8bd4b 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -52,40 +52,6 @@ static bool bootmeth_uses_network(struct bootflow *bflow)
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
@@ -102,8 +68,6 @@ static int efiload_read_file(struct bootflow *bflow, ulong addr)
 		return log_msg_ret("rdf", ret);
 	bflow->buf = map_sysmem(addr, bflow->size);
 
-	set_efi_bootdev(desc, bflow);
-
 	return 0;
 }
 
@@ -344,17 +308,8 @@ static int distro_efi_boot(struct udevice *dev, struct bootflow *bflow)
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
index 0d858c1e12e..2243e3a179c 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -20,6 +20,7 @@
 #include <linux/oid_registry.h>
 
 struct blk_desc;
+struct bootflow;
 struct jmp_buf_data;
 
 #if CONFIG_IS_ENABLED(EFI_LOADER)
@@ -578,6 +579,15 @@ efi_status_t efi_install_fdt(void *fdt);
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
index fdb4c6e4b51..efc2ca36c0f 100644
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
@@ -285,3 +288,71 @@ out:
 	return ret;
 }
 
+/**
+ * calc_dev_name() - Calculate the device name to give to EFI
+ *
+ * If not supported, this shows an error.
+ *
+ * Return name, or NULL if not supported
+ */
+static const char *calc_dev_name(struct bootflow *bflow)
+{
+	const struct udevice *media_dev;
+
+	media_dev = dev_get_parent(bflow->dev);
+
+	if (!bflow->blk) {
+		log_err("Cannot boot EFI app on media '%s'\n",
+			dev_get_uclass_name(media_dev));
+
+		return NULL;
+	}
+
+	if (device_get_uclass_id(media_dev) == UCLASS_MASS_STORAGE)
+		return "usb";
+
+	return blk_get_uclass_name(device_get_uclass_id(media_dev));
+}
+
+efi_status_t efi_bootflow_run(struct bootflow *bflow)
+{
+	struct efi_device_path *device, *image;
+	const struct udevice *media_dev;
+	struct blk_desc *desc = NULL;
+	const char *dev_name;
+	char devnum_str[9];
+	efi_status_t ret;
+	void *fdt;
+
+	media_dev = dev_get_parent(bflow->dev);
+	if (bflow->blk) {
+		desc = dev_get_uclass_plat(bflow->blk);
+
+		snprintf(devnum_str, sizeof(devnum_str), "%x:%x",
+			 desc ? desc->devnum : dev_seq(media_dev), bflow->part);
+	} else {
+		*devnum_str = '\0';
+	}
+
+	dev_name = calc_dev_name(bflow);
+	log_debug("dev_name '%s' devnum_str '%s' fname '%s' media_dev '%s'\n",
+		  dev_name, devnum_str, bflow->fname, media_dev->name);
+	if (!dev_name)
+		return EFI_UNSUPPORTED;
+	ret = calculate_paths(dev_name, devnum_str, bflow->fname, &device,
+			      &image);
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
+	ret = efi_binary_run_dp(bflow->buf, bflow->size, fdt, device, image);
+
+	return ret;
+}
+
-- 
2.43.0

