Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73DC9E7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 16:29:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E65C189722;
	Mon,  9 Dec 2024 17:29:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eI7EZoJE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C806489721; Mon,  9 Dec 2024 17:29:03 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66C1189712
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 17:29:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-84183532291so334417139f.2
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 08:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733761739; x=1734366539; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gc7Vv0F8EEjVzQEmTSeR398uxpPL8p/XMQltgZk+NXY=;
 b=eI7EZoJEnrzdi/O2UbzB0Ea0kxEaNQScr4/Xk4M3QOsrkVFazOSy4x6JOmx+6jk5Q9
 oESTxpEfZg8vXeCBdVJnOcUZGSA2r+JLaTg40WoBqeuY0IpufJT896n4lDswxIuLlmS6
 yOA0QiQtQ+zedblB+Kl+RkiQegkN1Otx1U7DY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733761739; x=1734366539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gc7Vv0F8EEjVzQEmTSeR398uxpPL8p/XMQltgZk+NXY=;
 b=VIWY5JuXLjZHoBlO0HdCjS3LpnDMy9/TmMAsRdQiGbTgUyuzlxuy5VuaDxxJiH1XOc
 iJs01JpNU5bLL+vXDa1hLT+F0Y2dOKB/BZmEgQSjHPksmaDx2SOBC81Tp3Q17dpCQyOY
 D4Wl9WQewHHoB2s7+C6yO2TLhl9+2veXoF9btIZpEEci7L6r6RvKmYCODdIuiYUcjCiu
 qfgCxYSPJnCrhi8wIFMuHQtdmHW34rlcYjjrd5QGE0CpliAkwT7ybZQfjNcmdod0s5NH
 +CGnmXBiRP6iWG3Qvx/q/l8CUZ0rGWItnIGVd7x1zyVN2MPeAMau8KKTJHBdKjkQ5aw+
 cchQ==
X-Gm-Message-State: AOJu0Yw+ak4SH01mVJBP8u3ABojBro9eNcDmk2RwlA9svFGv5/DMnSAu
 K9qIBTaTmPG1m3IfYNO5/xKQBPgm2ajUArQkz3p2YdjlxFRv09B4qIUQqTP4gr5KmCOYHnHNBBo
 =
X-Gm-Gg: ASbGncsy9F7sugVP6sJ06XV5ZeyyfVKCm8+pP+77Qcg8hhYUbkzSdECg28kwuxdu078
 PtLtPsmKDx1KAABOXno7FzO0ZAIgCXCkoG2Er1Srx7lFrzz9JLMZWHI2EUZqFBVSFnTUZmHMrYo
 Y0nQ7vyBCI1DPXXIiKPFjLMlryIq9IJhjT9Y5SXDz72vaSEIGxTiC/KHTdzg0/YHDDXIxrfLVL4
 vO1Lqn0YSjiIpy2UIvRp42URr6T5estzwHRlezGaqcK0I7ynsTdSRbud1jHCBRQE/PDmD/M279P
 X6U3zi3CNHM=
X-Google-Smtp-Source: AGHT+IHGwl146Xb6RbM2VFqbSmE3K8dzZtO0ZvbM+EW2QgCJvgVAzAJH8lX6Df3CqPPD2QeHIxA4rg==
X-Received: by 2002:a05:6602:160e:b0:843:ea73:134a with SMTP id
 ca18e2360f4ac-844b52721f5mr122273539f.15.1733761739219; 
 Mon, 09 Dec 2024 08:28:59 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-844737bc549sm272432339f.2.2024.12.09.08.28.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 08:28:58 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Matthew Garrett <mgarrett@aurora.tech>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/8] cmd: Refactor part_find() into separate functions
Date: Mon,  9 Dec 2024 09:27:58 -0700
Message-Id: <20241209162801.288363-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241209162801.288363-1-sjg@chromium.org>
References: <20241209162801.288363-1-sjg@chromium.org>
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

This function uses #ifdefs and ends up with a very large indent, Split
it into two separate functions, one for the EFI app and one for other
builds.

Drop the use of config.h while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/part_find.c | 153 +++++++++++++++++++++++++++++-------------------
 1 file changed, 93 insertions(+), 60 deletions(-)

diff --git a/cmd/part_find.c b/cmd/part_find.c
index 38919935641..0864c3f1042 100644
--- a/cmd/part_find.c
+++ b/cmd/part_find.c
@@ -5,12 +5,10 @@
  */
 
 #include <blk.h>
-#include <config.h>
 #include <command.h>
 #include <dm.h>
 #include <env.h>
 #include <part.h>
-#if defined(CONFIG_EFI) || defined(CONFIG_EFI_APP)
 #include <efi.h>
 #include <efi_api.h>
 
@@ -47,21 +45,86 @@ static bool partition_is_on_device(const struct efi_device_path *device,
 	}
 	return false;
 }
-#endif
+
+/**
+ * part_self_find() - Check if a device contains the loaded-image path
+ *
+ * @udev: Block device to check
+ * @loaded_image_path: EFI path of the loaded image
+ * Return 0 if found, -ENOENT if not, other -ve value on error
+ */
+static int part_self_find(struct udevice *udev,
+			  struct efi_device_path *loaded_image_path)
+{
+	struct blk_desc *desc = dev_get_uclass_plat(udev);
+
+	if (desc->uclass_id == UCLASS_EFI_MEDIA) {
+		struct efi_media_plat *plat = dev_get_plat(udev->parent);
+		u32 loader_part_no;
+
+		if (partition_is_on_device(plat->device_path, loaded_image_path,
+					   &loader_part_no)) {
+			char env[256];
+			int ret;
+
+			ret = snprintf(env, sizeof(env), "%s %x:%x",
+				       blk_get_uclass_name(desc->uclass_id),
+				       desc->devnum, loader_part_no);
+			if (ret < 0 || ret == sizeof(env))
+				return -ENOSPC;
+			if (env_set("target_part", env))
+				return -ENOMEM;
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
+
+/**
+ * part_blk_find() - Check if a device contains a partition with a type uuid
+ *
+ * @udev: Block device to check
+ * @uuid: UUID to search for (in string form)
+ * Return 0 if found, -ENOENT if not, other -ve value on error
+ */
+static int part_blk_find(struct udevice *udev, const char *uuid)
+{
+	struct blk_desc *desc = dev_get_uclass_plat(udev);
+	int i;
+
+	for (i = 1; i <= MAX_SEARCH_PARTITIONS; i++) {
+		struct disk_partition info;
+		int ret;
+
+		ret = part_get_info(desc, i, &info);
+		if (ret)
+			break;
+		if (strcasecmp(uuid, info.type_guid) == 0) {
+			char env[256];
+
+			ret = snprintf(env, sizeof(env), "%s %x:%x",
+				       blk_get_uclass_name(desc->uclass_id),
+				       desc->devnum, i);
+			if (ret < 0 || ret == sizeof(env))
+				return -ENOSPC;
+			debug("Setting target_part to %s\n", env);
+			if (env_set("target_part", env))
+				return -ENOMEM;
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
 
 static int part_find(int argc, char *const argv[])
 {
-#if defined(CONFIG_EFI) || defined(CONFIG_EFI_APP)
 	efi_guid_t efi_devpath_guid = EFI_DEVICE_PATH_PROTOCOL_GUID;
 	struct efi_device_path *loaded_image_path = NULL;
-	struct efi_boot_services *boot = efi_get_boot();
-	struct efi_priv *priv = efi_get_priv();
 	bool part_self = false;
-#endif
 	struct driver *d = ll_entry_start(struct driver, driver);
 	const int n_ents = ll_entry_count(struct driver, driver);
-	struct disk_partition info;
-	struct blk_desc *desc;
 	struct driver *entry;
 	struct udevice *udev;
 	struct uclass *uc;
@@ -70,16 +133,20 @@ static int part_find(int argc, char *const argv[])
 	if (argc != 2)
 		return CMD_RET_USAGE;
 
-#if defined(CONFIG_EFI) || defined (CONFIG_EFI_APP)
-	part_self = !strncmp(argv[1], "self", 6);
-	if (part_self) {
-		ret = boot->handle_protocol(priv->loaded_image->device_handle,
-					&efi_devpath_guid,
-					(void **)&loaded_image_path);
-		if (ret)
-			log_warning("failed to get device path for loaded image (ret=%d)", ret);
+	if (IS_ENABLED(CONFIG_EFI)) {
+		struct efi_boot_services *boot = efi_get_boot();
+		struct efi_priv *priv = efi_get_priv();
+
+		part_self = !strncmp(argv[1], "self", 6);
+		if (part_self) {
+			ret = boot->handle_protocol(priv->loaded_image->device_handle,
+						    &efi_devpath_guid,
+						    (void **)&loaded_image_path);
+			if (ret)
+				log_warning("failed to get device path for loaded image (ret=%d)",
+					    ret);
+		}
 	}
-#endif
 
 	ret = uclass_get(UCLASS_BLK, &uc);
 	if (ret) {
@@ -90,50 +157,16 @@ static int part_find(int argc, char *const argv[])
 		if (entry->id != UCLASS_BLK)
 			continue;
 		uclass_foreach_dev(udev, uc) {
-			int i;
-
 			if (udev->driver != entry)
 				continue;
-			desc = dev_get_uclass_plat(udev);
-#if defined(CONFIG_EFI) || defined(CONFIG_EFI_APP)
-			if (part_self) {
-				if (desc->if_type == IF_TYPE_EFI_MEDIA) {
-					struct efi_media_plat *plat =
-						dev_get_plat(udev->parent);
-					__u32 loader_part_no;
-
-					if (partition_is_on_device(plat->device_path,
-								   loaded_image_path,
-								   &loader_part_no)) {
-						char env[256];
-
-						ret = snprintf(env, sizeof(env), "%s %x:%x", blk_get_if_type_name(desc->if_type), desc->devnum, loader_part_no);
-						if (ret < 0 || ret == sizeof(env))
-							return CMD_RET_FAILURE;
-						if (env_set("target_part", env))
-							return CMD_RET_FAILURE;
-						return CMD_RET_SUCCESS;
-					}
-				}
-			} else {
-#endif
-				for (i = 1; i <= MAX_SEARCH_PARTITIONS; i++) {
-					ret = part_get_info(desc, i, &info);
-					if (ret)
-						break;
-					if (strcasecmp(argv[1], info.type_guid) == 0) {
-						char env[256];
-						ret = snprintf(env, sizeof(env), "%s %x:%x", blk_get_uclass_name(desc->uclass_id), desc->devnum, i);
-						if (ret < 0 || ret == sizeof(env))
-							return CMD_RET_FAILURE;
-						env_set("target_part", env);
-						debug("Setting target_part to %s\n", env);
-						return CMD_RET_SUCCESS;
-					}
-				}
-#if defined(CONFIG_EFI) || defined(CONFIG_EFI_APP)
-			}
-#endif
+			if (IS_ENABLED(CONFIG_EFI) && part_self)
+				ret = part_self_find(udev, loaded_image_path);
+			else
+				ret = part_blk_find(udev, argv[1]);
+			if (!ret)
+				return 0;
+			if (ret != -ENOENT)
+				break;
 		}
 	}
 
-- 
2.34.1

