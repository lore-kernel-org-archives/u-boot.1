Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD67EE77188
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 02:40:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31E098022B;
	Thu, 19 Dec 2024 03:39:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="babM0u3U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB7F18034E; Thu, 19 Dec 2024 03:39:23 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D6ED8021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 03:39:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3a815ed5acfso1124575ab.0
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 18:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734575957; x=1735180757; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q8q27xEutl2+4INVSFpgO7QgQ2KKPtia8cJlvSkE+N8=;
 b=babM0u3UnuZBX/uSZyfLBRfS9YRjrEDhto6sH9LEuGiz3kxwySJTYh/25Q/2eLP056
 Oo5D26QdMRNisocJYL/luvYf5cNI1Tj4LsrCFgzxEToM15W1durVoCoPa6OEd4/RHEvY
 HY2zf2brzzv8DpHIbNkc86E0Aqvc2jUUh/QGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734575957; x=1735180757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q8q27xEutl2+4INVSFpgO7QgQ2KKPtia8cJlvSkE+N8=;
 b=izGDPAcrPYjbyt+dCuHV5l1oHeek6MnEwlVCyOYAvxKA0qIuNKONlgNlZ0xYSUeapp
 mNHOZv7VYfEtS+M0YtGN9ztcPZcyvCj/ktve6pxgoj2cj7nG3gNSZ5c3HtuiQabSUrGB
 Wt4TUJumOmf8cCDlG3utpG50alxMVUZwPQL0e6Y+m+uTiMca8SKc6AlI5AgRvPP0OhKq
 /XnCFBHW2x6eOufXRMzJVBLev8lXEalQiFFmNFLcbpGtrrm0vwGHz2j+7c+9J5CLgV42
 twciyPLKa2m05Hy3FEmZAWdWISYeI0qvFIhV2WXoOd6NQbgWnVl0BijAOWutzIr2Z+Dn
 H3EA==
X-Gm-Message-State: AOJu0YxP66HH59XQLbtJnz9F5q5jDNLS5qHsngPneKwSQGNq28XbnuHY
 GjKvjyG3OEuJIUMxGImpGl2l9l0Bz6pVel5yqBNUVwTvp6FCZHAbiUJMnfN0wXpsq3gAQBSxrjA
 =
X-Gm-Gg: ASbGncvwYqL99xMBt5z2w1a0gM2GwXcwOuzCumnCY0uSAA812DLZ1pQIJoJqr5rg3kQ
 vAnw21u1bCm51KW1kp/Ty3ZAIC8bOrEu1mq0NRAJmQ16+MOKvTxprZstTv0lsnoCQgBXpl928ki
 VsaS19nbTvq/GU3Uat3ISDP0jD82LVpS4D3ScJeUyQZVMh0uH6Q6muRXkBW9FaytI7nDbUEEuzO
 BCUEEJmhhCsMl4E4JbNGK0PEAimSTQoTG3H4MLQ3NDYb2taRGH4DEreZeKrO7Vj5lqy6OfWf4os
 tvHz/7EkFPLislcOFQ==
X-Google-Smtp-Source: AGHT+IEIe75dFcPV3YKQ/rHmkp/zRnyAvYda/nf/GumghlUiewnngzoLPjweArduzwhkwnu/NT+ybQ==
X-Received: by 2002:a05:6e02:1a2d:b0:3a7:85ee:fa78 with SMTP id
 e9e14a558f8ab-3bdc437a8e0mr48683795ab.18.1734575957247; 
 Wed, 18 Dec 2024 18:39:17 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0e47d6cdcsm712125ab.71.2024.12.18.18.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 18:39:16 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Moritz Fischer <moritzf@google.com>, Patrick Wildt <pwildt@google.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v3 6/7] efi_loader: Pass in the required parameters from EFI
 bootmeth
Date: Wed, 18 Dec 2024 19:38:31 -0700
Message-Id: <20241219023832.1098689-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219023832.1098689-1-sjg@chromium.org>
References: <20241219023832.1098689-1-sjg@chromium.org>
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
index 8332993f421..b5d15a723b4 100644
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

