Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF4DC54F2E
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:07:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61AAB8310F;
	Fri, 23 May 2025 15:07:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FnHdPBaV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61FB283238; Fri, 23 May 2025 15:07:11 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A72F583108
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:07:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so72904325e9.1
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748005627; x=1748610427; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4uo0732/MLhFiQAKvlMFjIXiGn4FaTpx+I44xnuc7tg=;
 b=FnHdPBaVnSajpafcm4dsUCffr5qLl7OxDdom8pd0oZZiR6YAa7Vu0saaIR+cqFFX7c
 ruETJ2XBiRVc0fbCZgkqNKRwuTjV2SiRCmGxNYsB+bmyb7qYVS6IuoQSsJpM3ncDRMGf
 HQ2U/VHqffUPnIHmcEBIz/5ofFEIOFNldapFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748005627; x=1748610427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4uo0732/MLhFiQAKvlMFjIXiGn4FaTpx+I44xnuc7tg=;
 b=NS7D2/dg7my28GEwTnD4CQzc4YMaA4DT2ssadI5IvSS+Bniq3CLoN8FrMiSaHyNVgl
 g45Te5Oa6o8GQYDX/YSVm1YVJToODQDn/Md0F8YiPm0G+l6oeizZ4LdkvXEfpgTW0dto
 BpMFkpG2GyGagfahbgQ+THh7BbJzigYYm8Jdyh7Ul5AwuFWfnVcbOCNPfr8C/FFMDsZ4
 /PAqb2c5DLEZgPp7Hh2+9+DUu2vk+r50orxtU2UJ9C2XMZpFBVlsUXdrxXFoQhzotVdj
 Vt8wcAYMC6CewKoO1Sx6n+ncTy1aCAyjI/XD1TLJMF3waOYLUSrdhoXysSy2LmPpGAIB
 m1ug==
X-Gm-Message-State: AOJu0YzrSyyySJc39i77/qaAkulYaAIeKLKCW3nMmDOaDDtevYDc3DOv
 FO8ViS1m8fRw3qFOSpvf9AenaAip8bCLtSEx+H/nABzNttyuavSAssVCnd9TGJLCHIZBBm7s4ey
 tfVrXf64N
X-Gm-Gg: ASbGncvEP8S4IzuMQEP5jRvEVlLjt3zoDkrHCh0HOsxBp50dZqWHKUPCj9nS60JMdJH
 BspOUGSUpsPXVx8IVv3GveRc1+bq0JRRg9LDKLCLPRI/u+gKYrUOJIPURvyN1Ih4IcO/o38Z3BW
 XpThhNJv8owDvXeHVnxw+CXOExH2w5rS1ieXgADOXZRXzw1VhoqwE9ELZszKOGnMUC+D850IG1Y
 Fb0pHnlMbjSm6yxVXIw2v7+QzmbCdOSeh8Tz/bN6iKywkxjLRfVKE2QVGK5AwJWCncdtJ8mTMMQ
 yKW025qkPaZ9pMzeaxME3W4ZIOOmn6EeB0Fal/vZayHLL+M6ZTNssD77XbAGO91kAXo6XCwejJu
 OtGTBtw==
X-Google-Smtp-Source: AGHT+IGP7flr990CnSsGeivewyzgIkKRkXHzNw4/leruKVQM1cbNGb1LchJfblN8HVuoHS7nVqIkhw==
X-Received: by 2002:a05:600c:474a:b0:442:f44f:65b with SMTP id
 5b1f17b1804b1-442fd675a33mr242841535e9.32.1748005626992; 
 Fri, 23 May 2025 06:07:06 -0700 (PDT)
Received: from chromium.org (82-132-216-100.dab.02.net. [82.132.216.100])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a37b0bbd1fsm12109241f8f.100.2025.05.23.06.07.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 May 2025 06:07:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?q?Christian=20Kohlschu=CC=88tter?= <christian@kohlschutter.com>,
 Daniel Golle <daniel@makrotopia.org>, Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Maks Mishin <maks.mishinfz@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Moritz Fischer <moritzf@google.com>,
 Pawel Kochanowski <pkochanowski@sii.pl>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <ziyao@disroot.org>
Subject: [PATCH 01/10] efi_loader: Separate device path into its own header
Date: Fri, 23 May 2025 14:06:36 +0100
Message-ID: <20250523130651.1329593-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250523130651.1329593-1-sjg@chromium.org>
References: <20250523130651.1329593-1-sjg@chromium.org>
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

These functions are useful for the EFI app. As a first step towards
making these available outside lib/efi_loader, create a separate header
file and include it where needed. Add proper comments to the functions,
since many are missing at present.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/bootefi.c                              |   1 +
 cmd/eficonfig.c                            |   1 +
 cmd/efidebug.c                             |   1 +
 include/efi_device_path.h                  | 419 +++++++++++++++++++++
 include/efi_loader.h                       |  57 +--
 lib/efi_driver/efi_uclass.c                |   1 +
 lib/efi_loader/efi_bootbin.c               |   1 +
 lib/efi_loader/efi_bootmgr.c               |   1 +
 lib/efi_loader/efi_boottime.c              |   1 +
 lib/efi_loader/efi_capsule.c               |   1 +
 lib/efi_loader/efi_console.c               |   1 +
 lib/efi_loader/efi_device_path.c           |  89 +----
 lib/efi_loader/efi_device_path_utilities.c |   1 +
 lib/efi_loader/efi_disk.c                  |   1 +
 lib/efi_loader/efi_fdt.c                   |   1 +
 lib/efi_loader/efi_helper.c                |   1 +
 lib/efi_loader/efi_net.c                   |   1 +
 lib/efi_loader/efi_tcg2.c                  |   1 +
 test/lib/efi_device_path.c                 |   1 +
 19 files changed, 437 insertions(+), 144 deletions(-)
 create mode 100644 include/efi_device_path.h

diff --git a/cmd/bootefi.c b/cmd/bootefi.c
index dce8285b047..18c82a88ea9 100644
--- a/cmd/bootefi.c
+++ b/cmd/bootefi.c
@@ -9,6 +9,7 @@
 
 #include <command.h>
 #include <efi.h>
+#include <efi_device_path.h>
 #include <efi_loader.h>
 #include <exports.h>
 #include <log.h>
diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
index e08b6ba4a5d..7142a704fef 100644
--- a/cmd/eficonfig.c
+++ b/cmd/eficonfig.c
@@ -8,6 +8,7 @@
 #include <ansi.h>
 #include <cli.h>
 #include <charset.h>
+#include <efi_device_path.h>
 #include <efi_loader.h>
 #include <efi_load_initrd.h>
 #include <efi_config.h>
diff --git a/cmd/efidebug.c b/cmd/efidebug.c
index 6d180e81fdf..d7006307ec4 100644
--- a/cmd/efidebug.c
+++ b/cmd/efidebug.c
@@ -8,6 +8,7 @@
 #include <charset.h>
 #include <command.h>
 #include <dm/device.h>
+#include <efi_device_path.h>
 #include <efi_dt_fixup.h>
 #include <efi_load_initrd.h>
 #include <efi_log.h>
diff --git a/include/efi_device_path.h b/include/efi_device_path.h
new file mode 100644
index 00000000000..cea7fbafb34
--- /dev/null
+++ b/include/efi_device_path.h
@@ -0,0 +1,419 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * EFI device path from U-Boot device-model mapping
+ *
+ * (C) Copyright 2017 Rob Clark
+ */
+
+#ifndef EFI_DP_UTILS_H
+#define EFI_DP_UTILS_H
+
+#include <efi.h>
+
+struct blk_desc;
+struct efi_load_option;
+
+/**
+ * END - Template end node for EFI device paths.
+ *
+ * Represents the terminating node of an EFI device path.
+ * It has a type of DEVICE_PATH_TYPE_END and sub_type DEVICE_PATH_SUB_TYPE_END
+ */
+extern const struct efi_device_path END;
+
+/**
+ * efi_dp_next() - Iterate to next block in device-path
+ *
+ * Advance to the next node in an EFI device path.
+ *
+ * @dp: Pointer to the current device path node.
+ * Return: Pointer to the next device path node, or NULL if at the end
+ * or if input is NULL.
+ */
+struct efi_device_path *efi_dp_next(const struct efi_device_path *dp);
+
+/**
+ * efi_dp_match() - Compare two device-paths
+ *
+ * Compare two device paths node by node. The comparison stops when an End
+ * node is reached in the shorter of the two paths. This is useful, for example,
+ * to compare a device-path representing a device with one representing a file
+ * on that device, or a device with a parent device.
+ *
+ * @a: Pointer to the first device path.
+ * @b: Pointer to the second device path.
+ * Return: An integer less than, equal to, or greater than zero if the first
+ * differing node in 'a' is found, respectively, to be less than,
+ * to match, or be greater than the corresponding node in 'b'. Returns 0
+ * if they match up to the end of the shorter path. Compares length first,
+ * then content.
+ */
+int efi_dp_match(const struct efi_device_path *a,
+		 const struct efi_device_path *b);
+
+/**
+ * efi_dp_shorten() - shorten device-path
+ *
+ * When creating a short-boot option we want to use a device-path that is
+ * independent of the location where the block device is plugged in.
+ *
+ * UsbWwi() nodes contain a serial number, hard drive paths a partition
+ * UUID. Both should be unique.
+ *
+ * See UEFI spec, section 3.1.2 for "short-form device path".
+ *
+ * @dp:     original device-path
+ * Return:  shortened device-path or NULL
+ */
+struct efi_device_path *efi_dp_shorten(struct efi_device_path *dp);
+
+/**
+ * efi_dp_find_obj() - find handle by device path
+ *
+ * If @rem is provided, the handle with the longest partial match is returned.
+ *
+ * @dp:     device path to search
+ * @guid:   GUID of protocol that must be installed on path or NULL
+ * @rem:    pointer to receive remaining device path
+ * Return:  matching handle
+ */
+efi_handle_t efi_dp_find_obj(struct efi_device_path *dp, const efi_guid_t *guid,
+			     struct efi_device_path **rem);
+
+/**
+ * efi_dp_last_node() - Determine the last device path node before the end node
+ *
+ * Iterate through the device path to find the very last node before
+ * the terminating END node.
+ *
+ * @dp: Pointer to the device path.
+ * Return: Pointer to the last actual data node before the end node if it exists
+ * otherwise NULL (e.g., if dp is NULL or only an END node).
+ */
+const struct efi_device_path *efi_dp_last_node(const struct efi_device_path *dp);
+
+/**
+ * efi_dp_instance_size() - Get size of the first device path instance
+ *
+ * Calculate the total length of all nodes in the first instance of a
+ * (potentially multi-instance) device path. The size of the instance-specific
+ * end node (if any) or the final device path. The end node is not included.
+ *
+ * @dp: Pointer to the device path.
+ * Return: Size in bytes of the first instance, or 0 if dp is NULL or an END
+ * node
+ */
+efi_uintn_t efi_dp_instance_size(const struct efi_device_path *dp);
+
+/**
+ * efi_dp_size() - Get size of multi-instance device path excluding end node
+ *
+ * Calculate the total size of the entire device path structure, traversing
+ * through all instances, up to but not including the final
+ * END_ENTIRE_DEVICE_PATH node.
+ *
+ * @dp: Pointer to the device path.
+ * Return: Total size in bytes of all nodes in the device path (excluding the
+ * final END node), or 0 if dp is NULL.
+ */
+efi_uintn_t efi_dp_size(const struct efi_device_path *dp);
+
+/**
+ * efi_dp_dup() - Copy multi-instance device path
+ *
+ * Duplicate the given device path, including its end node(s).
+ * The caller is responsible for freeing the allocated memory (e.g.,
+ * using efi_free()).
+ *
+ * @dp: Pointer to the device path to duplicate.
+ * Return: Pointer to the newly allocated and copied device path, or NULL on
+ * allocation failure or if dp is NULL.
+ */
+struct efi_device_path *efi_dp_dup(const struct efi_device_path *dp);
+
+/**
+ * efi_dp_concat() - Concatenate two device paths and terminate the result
+ *
+ * @dp1:        First device path
+ * @dp2:        Second device path
+ * @split_end_node:
+ * - 0 to concatenate (dp1 is assumed not to have an end node or it's ignored,
+ *   dp2 is appended, then one END node)
+ * - 1 to concatenate with end node added as separator (dp1, END_THIS_INSTANCE,
+ *   dp2, END_ENTIRE)
+ *
+ * Size of dp1 excluding last end node to concatenate with end node as
+ * separator in case dp1 contains an end node (dp1 (partial), END_THIS_INSTANCE,
+ * dp2, END_ENTIRE)
+ *
+ * Return:
+ * concatenated device path or NULL. Caller must free the returned value.
+ */
+struct efi_device_path *efi_dp_concat(const struct efi_device_path *dp1,
+				      const struct efi_device_path *dp2,
+				      size_t split_end_node);
+
+/**
+ * efi_dp_append_node() - Append a single node to a device path
+ *
+ * Create a new device path by appending a given node to an existing
+ * device path.
+ * If the original device path @dp is NULL, a new path is created
+ * with the given @node followed by an END node.
+ * If the @node is NULL and @dp is not NULL, the original path @dp is
+ * duplicated.
+ * If both @dp and @node are NULL, a path with only an END node is returned.
+ * The caller must free the returned path (e.g., using efi_free()).
+ *
+ * @dp:   Original device path (can be NULL).
+ * @node: Node to append (can be NULL).
+ * Return: New device path with the node appended, or NULL on allocation
+ * failure.
+ */
+struct efi_device_path *efi_dp_append_node(const struct efi_device_path *dp,
+					   const struct efi_device_path *node);
+
+/**
+ * efi_dp_create_device_node() - Create a new device path node
+ *
+ * Allocate and initialise the header of a new EFI device path node with the
+ * given type, sub-type, and length. The content of the node beyond the basic
+ * efi_device_path header is zeroed by efi_alloc.
+ *
+ * @type:     Device path type.
+ * @sub_type: Device path sub-type.
+ * @length:   Length of the node (must be >= sizeof(struct efi_device_path)).
+ * Return: Pointer to the new device path node, or NULL on allocation failure
+ * or if length is invalid.
+ */
+struct efi_device_path *efi_dp_create_device_node(const u8 type,
+						  const u8 sub_type,
+						  const u16 length);
+
+/**
+ * efi_dp_append_instance() - Append a device path instance to another
+ *
+ * Concatenate two device paths, treating the second path (@dpi) as a new
+ * instance appended to the first path (@dp). An END_THIS_INSTANCE node is
+ * inserted between @dp and @dpi if @dp is not NULL.
+ * If @dp is NULL, @dpi is duplicated (and terminated appropriately).
+ * @dpi must not be NULL.
+ * The caller is responsible for freeing the returned path (e.g., using
+ * efi_free()).
+ *
+ * @dp:  The base device path. If NULL, @dpi is duplicated.
+ * @dpi: The device path instance to append. Must not be NULL.
+ * Return: A new device path with @dpi appended as a new instance, or NULL on
+ * error  (e.g. allocation failure, @dpi is NULL).
+ */
+struct efi_device_path *
+efi_dp_append_instance(const struct efi_device_path *dp,
+		       const struct efi_device_path *dpi);
+
+/**
+ * efi_dp_get_next_instance() - Extract the next dp instance
+ *
+ * Given a pointer to a pointer to a device path (@dp), this function extracts
+ * the first instance from the path. It allocates a new path for this extracted
+ * instance (including its instance-specific END node). The input pointer
+ * (*@dp) is then updated to point to the start of the next instance in the
+ * original path, or set to NULL if no more instances remain.
+ * The caller is responsible for freeing the returned instance path (e.g.,
+ * using efi_free()).
+ *
+ * @dp:  On input, a pointer to a pointer to the multi-instance device path.
+ * On output, *@dp is updated to point to the start of the next instance,
+ * or NULL if no more instances.
+ * @size: Optional pointer to an efi_uintn_t variable that will receive the size
+ * of the extracted instance path (including its END node).
+ * Return: Pointer to a newly allocated device path for the extracted instance,
+ * or NULL if no instance could be extracted or an error occurred (e.g.,
+ * allocation failure).
+ */
+struct efi_device_path *efi_dp_get_next_instance(struct efi_device_path **dp,
+						 efi_uintn_t *size);
+
+/**
+ * efi_dp_is_multi_instance() - Check if a device path is multi-instance
+ *
+ * Traverse the device path to its end. It is considered multi-instance if an
+ * END_THIS_INSTANCE_DEVICE_PATH node (type DEVICE_PATH_TYPE_END, sub-type
+ * DEVICE_PATH_SUB_TYPE_INSTANCE_END) is encountered before the final
+ * END_ENTIRE_DEVICE_PATH node.
+ *
+ * @dp: The device path to check.
+ * Return: True if the device path contains multiple instances, false otherwise
+ * (including if @dp is NULL).
+ */
+bool efi_dp_is_multi_instance(const struct efi_device_path *dp);
+
+/**
+ * efi_dp_from_part() - Construct a dp from a partition on a block device
+ *
+ * Create a full device path for a specified partition on a given block device.
+ * If the partition number @part is 0, the path is for the block device itself.
+ * The caller is responsible for freeing the allocated memory (e.g., using
+ * efi_free()).
+ *
+ * @desc: Pointer to the block device descriptor.
+ * @part: Partition number (0 for the whole device, >0 for a specific
+ * partition).
+ * Return: Pointer to the newly created device path, or NULL on allocation
+ * failure or if the device/partition is not found or invalid.
+ */
+struct efi_device_path *efi_dp_from_part(struct blk_desc *desc, int part);
+
+/**
+ * efi_dp_part_node() - Create a device node for a block device partition
+ *
+ * Creates a single device path node representing a specific partition
+ * (e.g., HardDrivePath or CDROMPath, depending on desc->part_type).
+ * It does not create the full path from the root, only the partition-specific
+ * node. The caller is responsible for freeing the allocated memory (e.g.,
+ * using efi_free()).
+ *
+ * @desc: Pointer to the block device descriptor.
+ * @part: Partition number (must be > 0 and correspond to a valid partition on
+ * the device).
+ * Return: Pointer to the new device path node for the partition, or NULL on
+ * allocation * failure or error in getting partition information.
+ */
+struct efi_device_path *efi_dp_part_node(struct blk_desc *desc, int part);
+
+/**
+ * efi_dp_from_file() - append file path node to device path.
+ *
+ * @dp:     device path or NULL
+ * @path:   file path or NULL
+ * Return:  device path or NULL in case of an error
+ */
+struct efi_device_path *efi_dp_from_file(const struct efi_device_path *dp,
+					 const char *path);
+
+/**
+ * efi_dp_from_uart() - Create a device path for a UART device.
+ *
+ * Construct a device path representing the system's default UART,
+ * typically based on the U-Boot device model root and a UART messaging node.
+ * The caller is responsible for freeing the allocated memory (e.g., using
+ * efi_free()).
+ *
+ * Return: Pointer to the new UART device path, or NULL on allocation failure.
+ */
+struct efi_device_path *efi_dp_from_uart(void);
+
+/**
+ * efi_dp_from_eth() - Create a device path for an Ethernet device
+ *
+ * Construct a device path representing the given device. The caller is
+ * responsible for freeing the allocated memory (e.g. using efi_free())
+ *
+ * @dev: UCLASS_ETH device to process
+ *
+ * Return: Pointer to the new Ethernet device path, or NULL on allocation
+ * failure
+ */
+struct efi_device_path *efi_dp_from_eth(struct udevice *dev);
+
+/**
+ * efi_dp_from_mem() - Construct a device-path for a memory-mapped region
+ *
+ * Create an EFI device path representing a specific memory region, defined
+ * by its type, start address, and size.
+ * The caller is responsible for freeing the allocated memory (e.g.,
+ * using efi_free()).
+ *
+ * @memory_type: EFI memory type (e.g., EFI_RESERVED_MEMORY_TYPE).
+ * @start_ptr: Starting address of the memory region.
+ * @size: Size of the memory region in bytes.
+ * Return: Pointer to the new memory device path, or NULL on allocation failure
+ */
+struct efi_device_path *efi_dp_from_mem(u32 memory_type, void *start_ptr,
+					size_t size);
+
+/**
+ * efi_dp_split_file_path() - split of relative file path from device path
+ *
+ * Given a device path indicating a file on a device, separate the device
+ * path in two: the device path of the actual device and the file path
+ * relative to this device.
+ *
+ * @full_path:      device path including device and file path
+ * @device_path:    path of the device
+ * @file_path:      relative path of the file or NULL if there is none
+ * Return:      status code
+ */
+efi_status_t efi_dp_split_file_path(struct efi_device_path *full_path,
+				    struct efi_device_path **device_path,
+				    struct efi_device_path **file_path);
+
+/**
+ * efi_dp_from_name() - convert U-Boot device and file path to device path
+ *
+ * @dev:    U-Boot device, e.g. 'mmc'
+ * @devnr:  U-Boot device number, e.g. 1 for 'mmc:1'
+ * @path:   file path relative to U-Boot device, may be NULL
+ * @device: pointer to receive device path of the device
+ * @file:   pointer to receive device path for the file
+ * Return:  status code
+ */
+efi_status_t efi_dp_from_name(const char *dev, const char *devnr,
+			      const char *path, struct efi_device_path **device,
+			      struct efi_device_path **file);
+
+/**
+ * efi_dp_check_length() - check length of a device path
+ *
+ * @dp:     pointer to device path
+ * @maxlen: maximum length of the device path
+ * Return:
+ * * length of the device path if it is less or equal @maxlen
+ * * -1 if the device path is longer then @maxlen
+ * * -1 if a device path node has a length of less than 4
+ * * -EINVAL if maxlen exceeds SSIZE_MAX
+ */
+ssize_t efi_dp_check_length(const struct efi_device_path *dp,
+			    const size_t maxlen);
+
+/**
+ * efi_dp_from_lo() - get device-path from load option
+ *
+ * The load options in U-Boot may contain multiple concatenated device-paths.
+ * The first device-path indicates the EFI binary to execute. Subsequent
+ * device-paths start with a VenMedia node where the GUID identifies the
+ * function (initrd or fdt).
+ *
+ * @lo:     EFI load option containing a valid device path
+ * @guid:   GUID identifying device-path or NULL for the EFI binary
+ *
+ * Return:
+ * device path excluding the matched VenMedia node or NULL.
+ * Caller must free the returned value.
+ */
+struct efi_device_path *efi_dp_from_lo(struct efi_load_option *lo,
+				       const efi_guid_t *guid);
+
+/**
+ * search_gpt_dp_node() - search gpt device path node
+ *
+ * @device_path:    device path
+ *
+ * Return:  pointer to the gpt device path node
+ */
+struct efi_device_path *search_gpt_dp_node(struct efi_device_path *device_path);
+
+/**
+ * efi_dp_from_http() - set device path from http
+ *
+ * Set the device path to an IPv4 path as provided by efi_dp_from_ipv4
+ * concatenated with a device path of subtype DEVICE_PATH_SUB_TYPE_MSG_URI,
+ * and an END node.
+ *
+ * @server:	URI of remote server
+ * @dev:	net udevice
+ * Return:	pointer to HTTP device path, NULL on error
+ */
+struct efi_device_path *efi_dp_from_http(const char *server,
+					 struct udevice *dev);
+
+#endif /* EFI_DP_UTILS_H */
diff --git a/include/efi_loader.h b/include/efi_loader.h
index a55efc2e1a2..5cc4cad9697 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -9,6 +9,7 @@
 #define _EFI_LOADER_H 1
 
 #include <blk.h>
+#include <efi_device_path.h>
 #include <event.h>
 #include <log.h>
 #include <part_efi.h>
@@ -967,66 +968,10 @@ extern void *efi_bounce_buffer;
 #define EFI_LOADER_BOUNCE_BUFFER_SIZE (64 * 1024 * 1024)
 #endif
 
-/* shorten device path */
-struct efi_device_path *efi_dp_shorten(struct efi_device_path *dp);
-struct efi_device_path *efi_dp_next(const struct efi_device_path *dp);
-int efi_dp_match(const struct efi_device_path *a,
-		 const struct efi_device_path *b);
-efi_handle_t efi_dp_find_obj(struct efi_device_path *dp,
-			     const efi_guid_t *guid,
-			     struct efi_device_path **rem);
-/* get size of the first device path instance excluding end node */
-efi_uintn_t efi_dp_instance_size(const struct efi_device_path *dp);
-/* size of multi-instance device path excluding end node */
-efi_uintn_t efi_dp_size(const struct efi_device_path *dp);
-struct efi_device_path *efi_dp_dup(const struct efi_device_path *dp);
-struct efi_device_path *efi_dp_append_node(const struct efi_device_path *dp,
-					   const struct efi_device_path *node);
-/* Create a device path node of given type, sub-type, length */
-struct efi_device_path *efi_dp_create_device_node(const u8 type,
-						  const u8 sub_type,
-						  const u16 length);
-/* Append device path instance */
-struct efi_device_path *efi_dp_append_instance(
-		const struct efi_device_path *dp,
-		const struct efi_device_path *dpi);
-/* Get next device path instance */
-struct efi_device_path *efi_dp_get_next_instance(struct efi_device_path **dp,
-						 efi_uintn_t *size);
-/* Check if a device path contains muliple instances */
-bool efi_dp_is_multi_instance(const struct efi_device_path *dp);
-
-struct efi_device_path *efi_dp_from_part(struct blk_desc *desc, int part);
-/* Create a device node for a block device partition. */
-struct efi_device_path *efi_dp_part_node(struct blk_desc *desc, int part);
-struct efi_device_path *efi_dp_from_file(const struct efi_device_path *dp,
-					 const char *path);
-struct efi_device_path *efi_dp_from_eth(struct udevice *dev);
-struct efi_device_path *efi_dp_from_mem(uint32_t mem_type, void *start_ptr,
-					size_t size);
-struct efi_device_path *efi_dp_from_http(const char *server,
-					 struct udevice *dev);
-/* Determine the last device path node that is not the end node. */
-const struct efi_device_path *efi_dp_last_node(
-			const struct efi_device_path *dp);
-efi_status_t efi_dp_split_file_path(struct efi_device_path *full_path,
-				    struct efi_device_path **device_path,
-				    struct efi_device_path **file_path);
-struct efi_device_path *efi_dp_from_uart(void);
-efi_status_t efi_dp_from_name(const char *dev, const char *devnr,
-			      const char *path,
-			      struct efi_device_path **device,
-			      struct efi_device_path **file);
-ssize_t efi_dp_check_length(const struct efi_device_path *dp,
-			    const size_t maxlen);
-
 #define EFI_DP_TYPE(_dp, _type, _subtype) \
 	(((_dp)->type == DEVICE_PATH_TYPE_##_type) && \
 	 ((_dp)->sub_type == DEVICE_PATH_SUB_TYPE_##_subtype))
 
-/* template END node: */
-extern const struct efi_device_path END;
-
 /* Indicate supported runtime services */
 efi_status_t efi_init_runtime_supported(void);
 
diff --git a/lib/efi_driver/efi_uclass.c b/lib/efi_driver/efi_uclass.c
index 495be53cb77..7392c60f0f9 100644
--- a/lib/efi_driver/efi_uclass.c
+++ b/lib/efi_driver/efi_uclass.c
@@ -20,6 +20,7 @@
 #define LOG_CATEGORY LOGC_EFI
 
 #include <dm.h>
+#include <efi_device_path.h>
 #include <efi_driver.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index 2ae3069301c..d232f450c66 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -10,6 +10,7 @@
 #include <charset.h>
 #include <dm.h>
 #include <efi.h>
+#include <efi_device_path.h>
 #include <efi_loader.h>
 #include <env.h>
 #include <image.h>
diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index 61a6d2e7982..8579cc1a8d7 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -12,6 +12,7 @@
 #include <charset.h>
 #include <dm.h>
 #include <efi.h>
+#include <efi_device_path.h>
 #include <log.h>
 #include <malloc.h>
 #include <mapmem.h>
diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index 6bc042a4efc..c51694399e7 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -11,6 +11,7 @@
 #include <div64.h>
 #include <dm/device.h>
 #include <dm/root.h>
+#include <efi_device_path.h>
 #include <efi_loader.h>
 #include <irq_func.h>
 #include <log.h>
diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
index 1aa52ac7bb6..f19e78ae9d1 100644
--- a/lib/efi_loader/efi_capsule.c
+++ b/lib/efi_loader/efi_capsule.c
@@ -8,6 +8,7 @@
 
 #define LOG_CATEGORY LOGC_EFI
 
+#include <efi_device_path.h>
 #include <efi_loader.h>
 #include <efi_variable.h>
 #include <env.h>
diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.c
index 9d9f786a6db..ade44cb6e36 100644
--- a/lib/efi_loader/efi_console.c
+++ b/lib/efi_loader/efi_console.c
@@ -9,6 +9,7 @@
 
 #include <ansi.h>
 #include <charset.h>
+#include <efi_device_path.h>
 #include <malloc.h>
 #include <time.h>
 #include <dm/device.h>
diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index 2b277126d68..b53fdb1b9c2 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -10,6 +10,7 @@
 #include <blk.h>
 #include <dm.h>
 #include <dm/root.h>
+#include <efi_device_path.h>
 #include <log.h>
 #include <mapmem.h>
 #include <net.h>
@@ -47,10 +48,6 @@ static bool is_sd(struct blk_desc *desc)
 }
 #endif
 
-/*
- * Iterate to next block in device-path, terminating (returning NULL)
- * at /End* node.
- */
 struct efi_device_path *efi_dp_next(const struct efi_device_path *dp)
 {
 	if (dp == NULL)
@@ -63,12 +60,6 @@ struct efi_device_path *efi_dp_next(const struct efi_device_path *dp)
 	return (struct efi_device_path *)dp;
 }
 
-/*
- * Compare two device-paths, stopping when the shorter of the two hits
- * an End* node. This is useful to, for example, compare a device-path
- * representing a device with one representing a file on the device, or
- * a device with a parent device.
- */
 int efi_dp_match(const struct efi_device_path *a,
 		 const struct efi_device_path *b)
 {
@@ -91,20 +82,6 @@ int efi_dp_match(const struct efi_device_path *a,
 	}
 }
 
-/**
- * efi_dp_shorten() - shorten device-path
- *
- * When creating a short boot option we want to use a device-path that is
- * independent of the location where the block device is plugged in.
- *
- * UsbWwi() nodes contain a serial number, hard drive paths a partition
- * UUID. Both should be unique.
- *
- * See UEFI spec, section 3.1.2 for "short-form device path".
- *
- * @dp:		original device-path
- * Return:	shortened device-path or NULL
- */
 struct efi_device_path *efi_dp_shorten(struct efi_device_path *dp)
 {
 	while (dp) {
@@ -181,16 +158,6 @@ static efi_handle_t find_handle(struct efi_device_path *dp,
 	return best_handle;
 }
 
-/**
- * efi_dp_find_obj() - find handle by device path
- *
- * If @rem is provided, the handle with the longest partial match is returned.
- *
- * @dp:		device path to search
- * @guid:	GUID of protocol that must be installed on path or NULL
- * @rem:	pointer to receive remaining device path
- * Return:	matching handle
- */
 efi_handle_t efi_dp_find_obj(struct efi_device_path *dp,
 			     const efi_guid_t *guid,
 			     struct efi_device_path **rem)
@@ -205,13 +172,6 @@ efi_handle_t efi_dp_find_obj(struct efi_device_path *dp,
 	return handle;
 }
 
-/*
- * Determine the last device path node that is not the end node.
- *
- * @dp		device path
- * Return:	last node before the end node if it exists
- *		otherwise NULL
- */
 const struct efi_device_path *efi_dp_last_node(const struct efi_device_path *dp)
 {
 	struct efi_device_path *ret;
@@ -225,7 +185,6 @@ const struct efi_device_path *efi_dp_last_node(const struct efi_device_path *dp)
 	return ret;
 }
 
-/* get size of the first device path instance excluding end node */
 efi_uintn_t efi_dp_instance_size(const struct efi_device_path *dp)
 {
 	efi_uintn_t sz = 0;
@@ -240,7 +199,6 @@ efi_uintn_t efi_dp_instance_size(const struct efi_device_path *dp)
 	return sz;
 }
 
-/* get size of multi-instance device path excluding end node */
 efi_uintn_t efi_dp_size(const struct efi_device_path *dp)
 {
 	const struct efi_device_path *p = dp;
@@ -254,7 +212,6 @@ efi_uintn_t efi_dp_size(const struct efi_device_path *dp)
 	return (void *)p - (void *)dp;
 }
 
-/* copy multi-instance device path */
 struct efi_device_path *efi_dp_dup(const struct efi_device_path *dp)
 {
 	struct efi_device_path *ndp;
@@ -271,21 +228,6 @@ struct efi_device_path *efi_dp_dup(const struct efi_device_path *dp)
 	return ndp;
 }
 
-/**
- * efi_dp_concat() - Concatenate two device paths and add and terminate them
- *                   with an end node.
- *
- * @dp1:	    First device path
- * @dp2:	    Second device path
- * @split_end_node:
- * * 0 to concatenate
- * * 1 to concatenate with end node added as separator
- * * size of dp1 excluding last end node to concatenate with end node as
- *   separator in case dp1 contains an end node
- *
- * Return:
- * concatenated device path or NULL. Caller must free the returned value
- */
 struct
 efi_device_path *efi_dp_concat(const struct efi_device_path *dp1,
 			       const struct efi_device_path *dp2,
@@ -450,9 +392,6 @@ bool efi_dp_is_multi_instance(const struct efi_device_path *dp)
 	return p->sub_type == DEVICE_PATH_SUB_TYPE_INSTANCE_END;
 }
 
-/* size of device-path not including END node for device and all parents
- * up to the root device.
- */
 __maybe_unused static unsigned int dp_size(struct udevice *dev)
 {
 	if (!dev || !dev->driver)
@@ -821,7 +760,6 @@ static void *dp_part_fill(void *buf, struct blk_desc *desc, int part)
 	return dp_part_node(buf, desc, part);
 }
 
-/* Construct a device-path from a partition on a block device: */
 struct efi_device_path *efi_dp_from_part(struct blk_desc *desc, int part)
 {
 	void *buf, *start;
@@ -837,13 +775,6 @@ struct efi_device_path *efi_dp_from_part(struct blk_desc *desc, int part)
 	return start;
 }
 
-/*
- * Create a device node for a block device partition.
- *
- * @buf		buffer to which the device path is written
- * @desc	block device descriptor
- * @part	partition number, 0 identifies a block device
- */
 struct efi_device_path *efi_dp_part_node(struct blk_desc *desc, int part)
 {
 	efi_uintn_t dpsize;
@@ -893,13 +824,6 @@ static void path_to_uefi(void *uefi, const char *src)
 	*pos = 0;
 }
 
-/**
- * efi_dp_from_file() - append file path node to device path.
- *
- * @dp:		device path or NULL
- * @path:	file path or NULL
- * Return:	device path or NULL in case of an error
- */
 struct efi_device_path *efi_dp_from_file(const struct efi_device_path *dp,
 					 const char *path)
 {
@@ -1024,17 +948,6 @@ static struct efi_device_path *efi_dp_from_ipv4(struct efi_ipv4_address *ip,
 	return dp2;
 }
 
-/**
- * efi_dp_from_http() - set device path from http
- *
- * Set the device path to an IPv4 path as provided by efi_dp_from_ipv4
- * concatenated with a device path of subtype DEVICE_PATH_SUB_TYPE_MSG_URI,
- * and an END node.
- *
- * @server:	URI of remote server
- * @dev:	net udevice
- * Return:	pointer to HTTP device path, NULL on error
- */
 struct efi_device_path *efi_dp_from_http(const char *server, struct udevice *dev)
 {
 	struct efi_device_path *dp1, *dp2;
diff --git a/lib/efi_loader/efi_device_path_utilities.c b/lib/efi_loader/efi_device_path_utilities.c
index 552c5bb1f05..f3ef3eabdae 100644
--- a/lib/efi_loader/efi_device_path_utilities.c
+++ b/lib/efi_loader/efi_device_path_utilities.c
@@ -7,6 +7,7 @@
 
 #define LOG_CATEGORY LOGC_EFI
 
+#include <efi_device_path.h>
 #include <efi_loader.h>
 
 const efi_guid_t efi_guid_device_path_utilities_protocol =
diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
index 5452640354e..47b583cc5e1 100644
--- a/lib/efi_loader/efi_disk.c
+++ b/lib/efi_loader/efi_disk.c
@@ -11,6 +11,7 @@
 #include <dm.h>
 #include <dm/device-internal.h>
 #include <dm/tag.h>
+#include <efi_device_path.h>
 #include <event.h>
 #include <efi_driver.h>
 #include <efi_loader.h>
diff --git a/lib/efi_loader/efi_fdt.c b/lib/efi_loader/efi_fdt.c
index 1ba6641d821..bfaa9cfc207 100644
--- a/lib/efi_loader/efi_fdt.c
+++ b/lib/efi_loader/efi_fdt.c
@@ -8,6 +8,7 @@
 
 #define LOG_CATEGORY LOGC_EFI
 
+#include <efi_device_path.h>
 #include <efi_loader.h>
 #include <env.h>
 #include <errno.h>
diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index c2761b76d4a..5a0a97fe6d0 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -6,6 +6,7 @@
 #define LOG_CATEGORY LOGC_EFI
 
 #include <bootm.h>
+#include <efi_device_path.h>
 #include <env.h>
 #include <image.h>
 #include <log.h>
diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index b3291b4f1d5..232e1dfc36f 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -17,6 +17,7 @@
 
 #define LOG_CATEGORY LOGC_EFI
 
+#include <efi_device_path.h>
 #include <efi_loader.h>
 #include <dm.h>
 #include <linux/sizes.h>
diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
index 210a846ebc8..1832eeb5dce 100644
--- a/lib/efi_loader/efi_tcg2.c
+++ b/lib/efi_loader/efi_tcg2.c
@@ -10,6 +10,7 @@
 #define LOG_CATEGORY LOGC_EFI
 
 #include <dm.h>
+#include <efi_device_path.h>
 #include <efi_loader.h>
 #include <efi_variable.h>
 #include <efi_tcg2.h>
diff --git a/test/lib/efi_device_path.c b/test/lib/efi_device_path.c
index 5cc001e209e..5a358ddcb93 100644
--- a/test/lib/efi_device_path.c
+++ b/test/lib/efi_device_path.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2020 Heinrich Schuchardt <xypron.glpk@gmx.de>
  */
 
+#include <efi_device_path.h>
 #include <efi_loader.h>
 #include <test/lib.h>
 #include <test/test.h>
-- 
2.43.0

