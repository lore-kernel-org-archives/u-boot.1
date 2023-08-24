Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 827D0C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:59:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67AC586A23;
	Thu, 24 Aug 2023 21:56:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eMdPnjXf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3C3486A1B; Thu, 24 Aug 2023 21:56:21 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDDEB868D0
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:56:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-79264ca4b34so7684039f.0
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692906977; x=1693511777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NCcMny4bayrZo9YHzO0EWGTNgSgc4KSuspR92K47bDk=;
 b=eMdPnjXfUXtzZro2xmQKt+GRdKXn1TXed8YqzwLiw/qlchm9O27gH4QWgHCbeqqTDO
 lOR+rpDYEqeBydZENexKiDGc1Vt0BGdVJgi4L5npDJrIfuuGdR7SG4Xw+cSUlZqCJXLm
 uo5A9q9/Vs1nfg6iWKeWpIsAavFT57+CVE0QI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692906977; x=1693511777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NCcMny4bayrZo9YHzO0EWGTNgSgc4KSuspR92K47bDk=;
 b=HBsN2zVzI8K3E8HEWQswPGDepKHzRgbkUW6twN+8SoSVGq1g71MdmsygzEfAHnPDVt
 Qy/cIiodtUHZeYnHoApBI2W2Hi6I26XeMGTBxmZGjjt1tue9tdczo/r0YI6gYeGq3lRi
 Cxx9/YPrhWG9NAJ5w/oASBdn6etUUi2EaCYDWe9RvPfmA2Rdz32jsvZ2JhqHpt+j8GXE
 Y0qP5OUptCKdbNzou1YHGm5lF06c53Q66H9j8uAjoRtEqn4J4xsWFc2xT4sZCeswUgte
 Jxjv50EimElh56lzv2ue74CNECNtoKktx7C5WGnfInLJZxsYSCJ+MiAsm8B925r7c4tf
 Mohg==
X-Gm-Message-State: AOJu0YylWL8lG0RSZd84IboanHbz9cZ3DvY8xT42laadDvUC5wfoAodn
 qcqC3kOXd5LgFQ9kj1wCL1cVEa/H2Z5bGk7LS2Y=
X-Google-Smtp-Source: AGHT+IEh7iBKFhIc+U0RdSOmFSbGfLIhjZT9RWYIxlTKCmxWKGkV+ecZxtTJS/MzTbxgz+0mKXHp9A==
X-Received: by 2002:a6b:db0a:0:b0:790:6629:b222 with SMTP id
 t10-20020a6bdb0a000000b007906629b222mr7168819ioc.5.1692906977559; 
 Thu, 24 Aug 2023 12:56:17 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 b22-20020a6be716000000b007925328d6ddsm12734ioh.20.2023.08.24.12.56.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:56:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: [PATCH v2 22/23] bootstd: cros: Allow detection of any kernel
 partition
Date: Thu, 24 Aug 2023 13:55:45 -0600
Message-ID: <20230824195553.1685996-23-sjg@chromium.org>
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

The existing ChromiumOS bootmeth only supports reading a single kernel
partition, either 2 or 4. In fact there are normally two options
available.

Use the GUID to detect kernel partitions, with the BOOTMETHF_ANY_PART
flag, so that bootstd does not require a valid filesystem before calling
the bootmeth.

Tidy up and improve the logging while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---

Changes in v2:
- Rebase to -next

 boot/Kconfig         |  2 ++
 boot/bootmeth_cros.c | 48 +++++++++++++++++++++++++++-----------------
 test/boot/bootflow.c |  5 +++--
 3 files changed, 35 insertions(+), 20 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 5e2d4286aeaa..b385902b53fe 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -466,6 +466,8 @@ config BOOTMETH_CROS
 	bool "Bootdev support for Chromium OS"
 	depends on X86 || ARM || SANDBOX
 	default y if !ARM
+	select PARTITION_TYPE_GUID
+	select PARTITION_UUIDS
 	help
 	  Enables support for booting Chromium OS using bootdevs. This uses the
 	  kernel A slot and obtains the kernel command line from the parameters
diff --git a/boot/bootmeth_cros.c b/boot/bootmeth_cros.c
index 1776fb1838c6..20e0b1e89c36 100644
--- a/boot/bootmeth_cros.c
+++ b/boot/bootmeth_cros.c
@@ -16,16 +16,19 @@
 #include <bootmeth.h>
 #include <display_options.h>
 #include <dm.h>
+#include <efi.h>
 #include <malloc.h>
 #include <mapmem.h>
 #include <part.h>
 #include <linux/sizes.h>
 #include "bootmeth_cros.h"
 
+static const efi_guid_t cros_kern_type = PARTITION_CROS_KERNEL;
+
 /*
  * Layout of the ChromeOS kernel
  *
- * Partitions 2 and 4 contain kernels
+ * Partitions 2 and 4 contain kernels with type GUID_CROS_KERNEL
  *
  * Contents are:
  *
@@ -145,13 +148,25 @@ static int scan_part(struct udevice *blk, int partnum,
 {
 	struct blk_desc *desc = dev_get_uclass_plat(blk);
 	struct vb2_keyblock *hdr;
+	struct uuid type;
 	ulong num_blks;
 	int ret;
 
+	if (!partnum)
+		return log_msg_ret("efi", -ENOENT);
+
 	ret = part_get_info(desc, partnum, info);
 	if (ret)
 		return log_msg_ret("part", ret);
 
+	/* Check for kernel partition type */
+	log_debug("part %x: type=%s\n", partnum, info->type_guid);
+	if (uuid_str_to_bin(info->type_guid, (u8 *)&type, UUID_STR_FORMAT_GUID))
+		return log_msg_ret("typ", -EINVAL);
+
+	if (memcmp(&cros_kern_type, &type, sizeof(type)))
+		return log_msg_ret("typ", -ENOEXEC);
+
 	/* Make a buffer for the header information */
 	num_blks = PROBE_SIZE >> desc->log2blksz;
 	log_debug("Reading header, blk=%s, start=%lx, blocks=%lx\n",
@@ -167,6 +182,7 @@ static int scan_part(struct udevice *blk, int partnum,
 
 	if (memcmp(VB2_KEYBLOCK_MAGIC, hdr->magic, VB2_KEYBLOCK_MAGIC_SIZE)) {
 		free(hdr);
+		log_debug("no magic\n");
 		return -ENOENT;
 	}
 
@@ -340,24 +356,16 @@ static int cros_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 	struct vb2_keyblock *hdr;
 	const char *uuid = NULL;
 	struct cros_priv *priv;
-	int part, ret;
-
-	log_debug("starting, part=%d\n", bflow->part);
+	int ret;
 
-	/* We consider the whole disk, not any one partition */
-	if (bflow->part)
-		return log_msg_ret("max", -ENOENT);
+	log_debug("starting, part=%x\n", bflow->part);
 
-	/* Check partition 2 then 4 */
-	part = 2;
-	ret = scan_part(bflow->blk, part, &info, &hdr);
+	/* Check for kernel partitions */
+	ret = scan_part(bflow->blk, bflow->part, &info, &hdr);
 	if (ret) {
-		part = 4;
-		ret = scan_part(bflow->blk, part, &info, &hdr);
-		if (ret)
-			return log_msg_ret("scan", ret);
+		log_debug("- scan failed: err=%d\n", ret);
+		return log_msg_ret("scan", ret);
 	}
-	bflow->part = part;
 
 	priv = malloc(sizeof(struct cros_priv));
 	if (!priv) {
@@ -366,8 +374,8 @@ static int cros_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 	}
 	bflow->bootmeth_priv = priv;
 
-	log_info("Selected partition %d, header at %lx\n", bflow->part,
-		 (ulong)map_to_sysmem(hdr));
+	log_debug("Selected partition %d, header at %lx\n", bflow->part,
+		  (ulong)map_to_sysmem(hdr));
 
 	/* Grab a few things from the preamble */
 	preamble = (void *)hdr + hdr->keyblock_size;
@@ -381,8 +389,11 @@ static int cros_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 	ret = cros_read_info(bflow, uuid, preamble);
 	preamble = NULL;
 	free(hdr);
-	if (ret)
+	if (ret) {
+		free(priv->info_buf);
+		free(priv);
 		return log_msg_ret("inf", ret);
+	}
 	bflow->size = priv->body_size;
 	bflow->state = BOOTFLOWST_READY;
 
@@ -437,6 +448,7 @@ static int cros_bootmeth_bind(struct udevice *dev)
 	struct bootmeth_uc_plat *plat = dev_get_uclass_plat(dev);
 
 	plat->desc = "ChromiumOS boot";
+	plat->flags = BOOTMETHF_ANY_PART;
 
 	return 0;
 }
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index ae34370981cb..1ff2320c0365 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -983,9 +983,10 @@ static int bootflow_cros(struct unit_test_state *uts)
 	ut_assert_nextlinen("Seq");
 	ut_assert_nextlinen("---");
 	ut_assert_nextlinen("  0  extlinux");
-	ut_assert_nextlinen("  1  cros         ready   mmc          2  mmc5.bootdev.whole       ");
+	ut_assert_nextlinen("  1  cros         ready   mmc          2  mmc5.bootdev.part_2       ");
+	ut_assert_nextlinen("  2  cros         ready   mmc          4  mmc5.bootdev.part_4       ");
 	ut_assert_nextlinen("---");
-	ut_assert_skip_to_line("(2 bootflows, 2 valid)");
+	ut_assert_skip_to_line("(3 bootflows, 3 valid)");
 
 	ut_assert_console_end();
 
-- 
2.42.0.rc1.204.g551eb34607-goog

