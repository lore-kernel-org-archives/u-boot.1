Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B116DC02183
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 15:04:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B405D805EA;
	Thu,  9 Jan 2025 16:03:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QU0aGux1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68954805E2; Thu,  9 Jan 2025 16:03:19 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8C20806FC
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 16:03:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-844e7bc6d84so31975939f.0
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 07:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736434991; x=1737039791; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sTyuC2je7vrHTN8yLUER7REjzZHI7AiPfX4QtpH4MmM=;
 b=QU0aGux1CCL4hZN5jUc5VVc/ylxDg1tK/NhMf0ApE108CZcM49nZldlLQLB3jRPAdi
 xt12Yax31dj8KK4004cJ9+ntsw019+rUGrMbDR2+4dh6fBe113DMtBfRw+bI0A3sFHPo
 QwQr7EJuv41RBnwh8Ft3sW3j5Ncj/d4pw28JE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736434991; x=1737039791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sTyuC2je7vrHTN8yLUER7REjzZHI7AiPfX4QtpH4MmM=;
 b=A2I91HrNdiqNybcvJs4LgcUB+CiQK+MGZguCFbBYUb4fYJ2VeINqpxEw8Zng/egwix
 sNPIl7BxLcBwytSYyq6jD6II/CYXO5W1eZ4VQzIvM1PUqqRnyg/X+xd6+CXAu0m2ePgs
 vm8wOb70stpAmJ1GbdJvFYqKKqafLfxfVHOhEnk8RKifsD+F3ZEDAtBdJa81b2A0QqTV
 ilMLBJVnTDQHhOTchdMPw0bHcvvHPEgw5w0mQaCJMgZK1e2AX3loVaz2vCliMXp2lF6x
 gkzYajDOBEY3CuYLGWqAqW6a0ygEdHD8rZ4Np3RHavTwJCDFWiPEK4AhC+Z5/bxt9tyy
 dNYQ==
X-Gm-Message-State: AOJu0YwBTSAycsYF7TcuDM5GdoWxx/gorzI3i+69KfeN+Ri6v0nACxPi
 bFiT5tj+gKZuGEEe4MNTx9UgAvTzipEiHT+8VmGnQz4GZiN6CJ6fL+eA/EwyQK9S5CxmhEewXXs
 =
X-Gm-Gg: ASbGncv/F66R34Wb7hAwVYj+xRPX3VmiYPQRv9TSUCp4LZVCRmIpMH4lO9AZp2Ocoks
 fX+Ws44/Qfhr1Jg1FrLqCcxJy7NVMjtm8n5oGWL01jFogu9FzPsxNVSr6RlOqTVX7PUJBYtim3N
 yNMJW1R+SiYmDXFDHPxJlc9HyDyPFTG1GtLDp+Wg+QeJKyr0cJJd/Ehyji+Uo2VfmluOOsdMU4Z
 PgyWq79BHsZ+imAZuPGCyPOzJkwC8Xhq8+qAOK3805YRzv2WMPUgq328mu0HCO66hcKmCCzoR1H
 qlyTw/Nwk1lsHE+I4g==
X-Google-Smtp-Source: AGHT+IHlyQZbAeESNEloni+YCOWVIP2sg/4VYnmAKdqsro20UFIlJh4+OHeYmxrMhx9tUuWrFImNtg==
X-Received: by 2002:a05:6602:3a87:b0:84a:5ded:b7c6 with SMTP id
 ca18e2360f4ac-84cebef565emr266820839f.5.1736434991107; 
 Thu, 09 Jan 2025 07:03:11 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b7463d0sm350530173.123.2025.01.09.07.03.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 07:03:08 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Moritz Fischer <moritzf@google.com>, Patrick Wildt <pwildt@google.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v4 6/7] efi_loader: Pass in the required parameters from EFI
 bootmeth
Date: Thu,  9 Jan 2025 08:02:43 -0700
Message-Id: <20250109150244.141173-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250109150244.141173-1-sjg@chromium.org>
References: <20250109150244.141173-1-sjg@chromium.org>
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

(no changes since v2)

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
index f836aa655f5..fa7f66c9a0b 100644
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
@@ -103,8 +69,6 @@ static int efiload_read_file(struct bootflow *bflow, ulong addr)
 		return log_msg_ret("read", ret);
 	bflow->buf = map_sysmem(addr, bflow->size);
 
-	set_efi_bootdev(desc, bflow);
-
 	return 0;
 }
 
@@ -342,17 +306,8 @@ static int distro_efi_boot(struct udevice *dev, struct bootflow *bflow)
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
index 9afbec35ebf..a9325b1a9d0 100644
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
index 7c6a88c79fd..a4f6b4264fb 100644
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
+	ret = _efi_binary_run(bflow->buf, bflow->size, fdt, device, image);
+
+	return ret;
+}
+
-- 
2.34.1

