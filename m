Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E670BC61DC6
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 08:40:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9FE8780EB5;
	Fri, 28 Aug 2026 08:40:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nYgtyMmJfSRj; Fri, 28 Aug 2026 08:40:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787906411;
	bh=lWUhxMUi3kYfGFLoma+UySgaLOX1UNwkvexaGn6yZ6c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uThrnjTBT4owYmQ8tHhE2kAmqQ11UhwBsdJ6UwTfFHHutsF29CjpGE9HQds6JTTmK
	 Mf6/FQQPBZ87hB+Eo0DkLwWWPxjQFqheT+S3Q2HjmBKTcXZOdAJy8ZqHp5oISKv4mk
	 ctf76TC+YEEf+7NnJY3NYuccxucWziO8Gf/Q65pisKgj2qS8RJ8Pl4uAW4Odfktic6
	 Sr/eXrJtesZxf77FCWw4EYEeIINhkNrheQevQQynIFOl8CNQ2F6nNb0ahT3eFjsOyG
	 AsQ4aIi7v/C6xTS/1e6Jl0sbQC21597FNcPI20B4x6tlSP2NLVgoo+PTMmc/91hPEO
	 j3j1Sua0v5L5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 45EDD80EA4;
	Fri, 28 Aug 2026 08:40:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C231B386
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 08:40:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B3F39407D4
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 08:40:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O60VhBqsp_so for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 08:40:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=kvtfJw0M
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EF327407D3
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 08:40:05 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4953e04ef16so6711265e9.2
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 01:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787906403; x=1788511203;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lWUhxMUi3kYfGFLoma+UySgaLOX1UNwkvexaGn6yZ6c=;
 b=kvtfJw0M1HVlF8e+0bZIxmRJkY6f4mPreRBRI1EjBWUB6lgghhhCHzha9P+j5N3LW5
 bYfscIPrTrgt8gehST+pAHnXfhBrS/PNlut7QM6Pbp1W+Uce05lniPzBf/qlbqtijtBf
 AsN5nWx6DFoVIp5I9TdYeGXlsXeTwXD3XQ30kyr36n2wKKA1DIZI+m+ydganIanJpdpp
 GIWSXiAfzlrVLkuvlKTv1RNYRtqI4QLKdd65IWxTZcrBQ/l3etBap/9wabNSMkWj4yo7
 7UkE+iQayZWA7dLJpr00w0bYkqrgHxj/GUcOpMYvMxDs2Ok2e6Jv6dTf8boK32vFizR9
 jLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787906403; x=1788511203;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lWUhxMUi3kYfGFLoma+UySgaLOX1UNwkvexaGn6yZ6c=;
 b=OFtl5vnyadz1WLuVDyXogiF+9D+elh31oB13gh68I2iM5MH2aTOj45PtRMaI3ebj/m
 yh5q9LbFC7hA1cU/Get/2LxifRcv5ELde+I3wZS4V5UjQjN0t+NYoBUg19wNGHvk2v0h
 z1OzakAYqFpgLDTls9hPJV4m46m/vNYARsNSEX3XGrbu7WbnY835V7OwIVhCEasdebhE
 8UwRhJsAiMhGMMfMNEsTzmoFpAbJBLiNGOLqHjiSOA4O3aQJP/lDBIC7A9bRqvBQzHve
 jiBbVpJsJ8RtM60bM3e303ut6ZxXaUiXQbH3rwLSCcaowRO6GJDa3fyQzHIe3b6g/nuF
 RBdg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpV+gDa0ZY0CihkVKllLSfeNQiZ0IntK4pvefDNqXWqb2TxevYmBjGcvniAbr8lzfKZete0drw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mtYwYdHB/+U8RViNEVJNXvLQNbs33uu4ECbOPEKN+npCNc+t78
 R/GdDxrcIyDD7VEaujt3Fvt89qTyZYVHYZXM2HO1rHiEk3l7uf5E2TLv0Y5bBzCx9aY=
X-Gm-Gg: AR+sD10DZnJ6o1E4zHIm/c0Fgpzi7cKmL1BZTtlTwPgGT3KXghynsHmfGJFUA8WhixZ
 Pz3KWIOK+FFK+e5INg5r6M+JTOer1B4ySgU5/e2RB3M3F5OEJ0sFsZ4p/vWUFjPIwDoWLgCYCqx
 CmaVXB8dDb9qbSQhzxcLrca+ukbwvhk+tITfuDeIxZrJ4aTeAuuy7Y1N1NEksThpqoPMbq0msAb
 yZ5ucsfQ/X5G/nNDNAYO1ubNj6pK/ZJZpvFSU2VcbpPRI989KFDQLCT3N68cLVToYb2iiIy9KN+
 iYhSL6zaK0BYWnvCvT0SeVSk2Ph7W7/h/5cbVKlN15m2TPd1qaIv5gVVPneiStLkhEOh/Y+g6/B
 VCYBx2rjMdW3DlS3giANBYHuRCeUvW0/pIt+riRJWf4iuOIqxoJk+vNMufCjOFD2iZOn8qixRef
 0tdFKn84QQCn39FBSOhIyvQkhMaana6Fq/9BJIvvyUMQufEMGrYR5+kDcKr9/EZofvbccc9FMz9
 pqqsWue3KuunExYWLVvbIKwZLQi+xKQswBqkwILzuf/0gm4gQEfIy+bpwMys79VT/YGk0K7gz0P
 baBAVKUlDA==
X-Received: by 2002:a05:600c:1f8f:b0:495:48d7:f178 with SMTP id
 5b1f17b1804b1-49b91c44ec6mr64572915e9.11.1787906403230; 
 Fri, 28 Aug 2026 01:40:03 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-212-171-227-71.pool212171.interbusiness.it. [212.171.227.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b9500c80asm34428435e9.9.2026.08.28.01.40.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 01:40:02 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Fri, 28 Aug 2026 10:39:56 +0200
Subject: [PATCH 1/3] arm: mediatek: add RITY devicetree preparation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-ccaione-upstream-mtk-fdt-prepare-v1-1-bf80b489eb0f@baylibre.com>
References: <20260828-ccaione-upstream-mtk-fdt-prepare-v1-0-bf80b489eb0f@baylibre.com>
In-Reply-To: <20260828-ccaione-upstream-mtk-fdt-prepare-v1-0-bf80b489eb0f@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>, Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

RITY images select a base devicetree and an ordered list of overlays
through the storage, storage_dev, dtb_path, boot_dtb, fdtfile and list_dtbo
environment variables. The selected tree must be assembled before EFI
boot and published through the standard fdt_addr variable.

Add a MediaTek preparation service which consumes that established
interface. For block devices, locate the source partition by the existing
MediaTek GPT type GUID. Also support the RITY NOR layout through MTD, UBI
and UBIFS when those subsystems are enabled.

Load the base tree and apply the overlays in list order.
Non-authenticated builds consume raw DTB and DTBO files. With MTK_FDT_AUTH
enabled, treat each same-named file as a single-image FIT, verify its
flat-devicetree payload and extract it before using the common assembly
path.

Publish the result through fdt_addr only after the whole tree has been
prepared successfully. Clear fdt_addr on failure and remove fdtfile from
the EFI fallback search so a preparation failure cannot silently fall back
to a different tree.

Run the service at EVT_POST_PREBOOT for EFI-capable boot targets, while
leaving embedded legacy boot unchanged. Provide a separately selectable
mtk_fdt_prepare command so an interactive user can rebuild the tree after
changing a selector. It accepts either no arguments, using the environment,
or explicit interface, device and directory arguments.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/mach-mediatek/Kconfig           |  35 +++
 arch/arm/mach-mediatek/Makefile          |   2 +
 arch/arm/mach-mediatek/cmd_fdt_prepare.c |  31 ++
 arch/arm/mach-mediatek/fdt_prepare.c     | 502 +++++++++++++++++++++++++++++++
 arch/arm/mach-mediatek/fdt_prepare.h     |  10 +
 5 files changed, 580 insertions(+)

diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 5e6c50ca64d..75fa88a1510 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -215,4 +215,39 @@ config MTK_TZ_MOVABLE
 	select OF_SYSTEM_SETUP
 	bool
 
+config MTK_FDT_PREPARE
+	bool "Prepare a MediaTek RITY devicetree"
+	select EVENT
+	select PARTITION_TYPE_GUID
+	depends on OF_LIBFDT_OVERLAY
+	help
+	  Load the base devicetree and the overlays selected by list_dtbo,
+	  assemble them before autoboot and publish the resulting tree through
+	  the standard fdt_addr environment variable.
+
+	  The source and selection are described by the RITY environment
+	  variables storage, storage_dev, dtb_path, boot_dtb, fdtfile and
+	  list_dtbo. Both block filesystems and, when enabled, UBI/UBIFS
+	  storage are supported.
+
+config CMD_MTK_FDT_PREPARE
+	bool "Enable the 'mtk_fdt_prepare' command"
+	depends on MTK_FDT_PREPARE
+	help
+	  Provide the mtk_fdt_prepare command so the assembled devicetree can
+	  be rebuilt after changing a selector at the U-Boot prompt. With no
+	  arguments the command uses storage, storage_dev and dtb_path from the
+	  environment. It also accepts the interface, device and path arguments
+	  explicitly.
+
+config MTK_FDT_AUTH
+	bool "Authenticate MediaTek RITY devicetrees"
+	depends on MTK_FDT_PREPARE && FIT_SIGNATURE
+	select RSA
+	select RSA_VERIFY
+	help
+	  Treat every loose-named DTB and DTBO as a signed single-image FIT,
+	  authenticate its default flat-devicetree image and extract the
+	  verified payload before assembling the final tree.
+
 endif
diff --git a/arch/arm/mach-mediatek/Makefile b/arch/arm/mach-mediatek/Makefile
index 35f748a70d6..e11fddd27bc 100644
--- a/arch/arm/mach-mediatek/Makefile
+++ b/arch/arm/mach-mediatek/Makefile
@@ -3,6 +3,8 @@
 obj-$(CONFIG_ARM64) += armv8-mem-map.o
 obj-y	+= cpu.o
 obj-$(CONFIG_MTK_TZ_MOVABLE)	+= tzcfg.o
+obj-$(CONFIG_MTK_FDT_PREPARE)	+= fdt_prepare.o
+obj-$(CONFIG_CMD_MTK_FDT_PREPARE)	+= cmd_fdt_prepare.o
 obj-$(CONFIG_XPL_BUILD)	+= spl.o
 
 obj-$(CONFIG_TARGET_MT7622) += mt7622/
diff --git a/arch/arm/mach-mediatek/cmd_fdt_prepare.c b/arch/arm/mach-mediatek/cmd_fdt_prepare.c
new file mode 100644
index 00000000000..91d56f747ef
--- /dev/null
+++ b/arch/arm/mach-mediatek/cmd_fdt_prepare.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Carlo Caione <ccaione@baylibre.com>
+ */
+
+#include <command.h>
+
+#include "fdt_prepare.h"
+
+static int do_mtk_fdt_prepare(struct cmd_tbl *cmdtp, int flag, int argc,
+			      char *const argv[])
+{
+	int ret;
+
+	if (argc == 1)
+		ret = mtk_fdt_prepare();
+	else if (argc == 4)
+		ret = mtk_fdt_prepare_from(argv[1], argv[2], argv[3]);
+	else
+		return CMD_RET_USAGE;
+
+	return ret ? CMD_RET_FAILURE : CMD_RET_SUCCESS;
+}
+
+#define MTK_FDT_PREPARE_USAGE \
+	"[<interface> <dev> <probe_base>]\n" \
+	"    - use the environment when no source arguments are given"
+
+U_BOOT_CMD(mtk_fdt_prepare, 4, 1, do_mtk_fdt_prepare,
+	   "load and assemble the MediaTek RITY devicetree",
+	   MTK_FDT_PREPARE_USAGE);
diff --git a/arch/arm/mach-mediatek/fdt_prepare.c b/arch/arm/mach-mediatek/fdt_prepare.c
new file mode 100644
index 00000000000..ff5e1e02820
--- /dev/null
+++ b/arch/arm/mach-mediatek/fdt_prepare.c
@@ -0,0 +1,502 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Carlo Caione <ccaione@baylibre.com>
+ */
+
+#include <blk.h>
+#include <env.h>
+#include <event.h>
+#include <fdt_support.h>
+#include <fs.h>
+#include <image.h>
+#include <log.h>
+#include <malloc.h>
+#include <mapmem.h>
+#include <part.h>
+#include <vsprintf.h>
+#include <linux/errno.h>
+#include <linux/libfdt.h>
+#include <linux/string.h>
+
+#include "fdt_prepare.h"
+
+#if CONFIG_IS_ENABLED(MTD) && CONFIG_IS_ENABLED(CMD_UBI) && \
+	CONFIG_IS_ENABLED(CMD_UBIFS)
+#include <mtd.h>
+#include <ubi_uboot.h>
+#include <ubifs_uboot.h>
+#define MTK_FDT_HAS_UBI 1
+#else
+#define MTK_FDT_HAS_UBI 0
+#endif
+
+#define MTK_FW_PART_GUID	"384e979b-eb76-435a-a3a6-1a071dbad91d"
+#define MTK_FDT_PATH_MAX	512
+
+enum mtk_fdt_source_type {
+	MTK_FDT_SOURCE_BLOCK,
+	MTK_FDT_SOURCE_UBI,
+};
+
+struct mtk_fdt_source {
+	enum mtk_fdt_source_type type;
+	struct blk_desc *desc;
+	int part;
+};
+
+static int mtk_fdt_make_path(char *path, size_t size, const char *dir,
+			     const char *name)
+{
+	int len;
+
+	if (!dir || !*dir || !name || !*name)
+		return -EINVAL;
+
+	len = snprintf(path, size, "%s%s%s", dir,
+		       dir[strlen(dir) - 1] == '/' ? "" : "/", name);
+	if (len < 0 || (size_t)len >= size)
+		return -ENOSPC;
+
+	return 0;
+}
+
+static int mtk_fdt_block_read(struct mtk_fdt_source *source,
+			      const char *path, ulong addr, loff_t *sizep)
+{
+	int ret;
+
+	ret = fs_set_blk_dev_with_part(source->desc, source->part);
+	if (ret)
+		return ret;
+
+	return fs_read(path, addr, 0, 0, sizep);
+}
+
+static int mtk_fdt_block_exists(struct blk_desc *desc, int part,
+				const char *path)
+{
+	int ret;
+
+	ret = fs_set_blk_dev_with_part(desc, part);
+	if (ret)
+		return ret;
+
+	return fs_exists(path) ? 0 : -ENOENT;
+}
+
+static int mtk_fdt_select_block(struct mtk_fdt_source *source,
+				const char *path, const char *ifname,
+				const char *devnum)
+{
+	const char *boot_dtb = env_get("boot_dtb");
+	const char *type_guid = env_get("fw_fdt_part_type_uuid");
+	struct disk_partition info;
+	struct blk_desc *desc;
+	ulong selected = 0;
+	int part, ret;
+
+	if (!ifname || !devnum)
+		return -EINVAL;
+	if (!type_guid || !*type_guid)
+		type_guid = MTK_FW_PART_GUID;
+
+	if (boot_dtb && *boot_dtb &&
+	    strict_strtoul(boot_dtb, 10, &selected)) {
+		printf("Invalid boot_dtb partition number: %s\n", boot_dtb);
+		return -EINVAL;
+	}
+
+	ret = blk_get_device_by_str(ifname, devnum, &desc);
+	if (ret < 0)
+		return ret;
+
+	for (part = 1; part <= MAX_SEARCH_PARTITIONS; part++) {
+		ret = part_get_info(desc, part, &info);
+		if (ret)
+			continue;
+		if (strcasecmp(info.type_guid, type_guid))
+			continue;
+		if (selected && selected != part)
+			continue;
+
+		printf("Probing %s %s:%d for RITY devicetree...\n",
+		       ifname, devnum, part);
+		ret = mtk_fdt_block_exists(desc, part, path);
+		if (ret)
+			continue;
+
+		source->type = MTK_FDT_SOURCE_BLOCK;
+		source->desc = desc;
+		source->part = part;
+		return 0;
+	}
+
+	return -ENOENT;
+}
+
+#if MTK_FDT_HAS_UBI
+static int mtk_fdt_ubi_read(const char *path, ulong addr, loff_t *sizep)
+{
+	int ret;
+
+	ret = ubifs_load(path, addr, 0);
+	if (!ret)
+		*sizep = env_get_hex("filesize", 0);
+
+	return ret;
+}
+
+static int mtk_fdt_try_ubi_source(struct mtk_fdt_source *source,
+				  const struct mtd_info *mtd,
+				  const char *devnum, const char *path)
+{
+	char volume[UBI_VOL_NAME_MAX + 16];
+	int ret;
+
+	ret = ubi_part(mtd->name, NULL);
+	if (ret)
+		return ret;
+
+	ret = snprintf(volume, sizeof(volume), "ubi%s:%s", devnum, mtd->name);
+	if (ret < 0 || (size_t)ret >= sizeof(volume))
+		return -ENOSPC;
+
+	ret = cmd_ubifs_mount(volume);
+	if (ret)
+		return ret;
+	if (!ubifs_exists(path))
+		return -ENOENT;
+
+	source->type = MTK_FDT_SOURCE_UBI;
+	return 0;
+}
+
+static int mtk_fdt_select_ubi(struct mtk_fdt_source *source,
+			      const char *path, const char *devnum)
+{
+	const char *boot_dtb = env_get("boot_dtb");
+	const char *match = env_get("fw_fdt_mtd_name");
+	struct mtd_info *mtd;
+	ulong selected = 0;
+	int ret;
+
+	if (!devnum)
+		return -EINVAL;
+	if (!match || !*match)
+		match = "firmware";
+
+	if (boot_dtb && *boot_dtb &&
+	    strict_strtoul(boot_dtb, 10, &selected)) {
+		printf("Invalid boot_dtb MTD index: %s\n", boot_dtb);
+		return -EINVAL;
+	}
+
+	ret = mtd_probe_devices();
+	if (ret)
+		return ret;
+
+	mtd_for_each_device(mtd) {
+		if (!mtd_is_partition(mtd) || !mtd->name)
+			continue;
+		if (!strstr(mtd->name, match))
+			continue;
+		if (selected && selected != mtd->index)
+			continue;
+
+		printf("Probing UBI source %s for RITY devicetree...\n",
+		       mtd->name);
+		ret = mtk_fdt_try_ubi_source(source, mtd, devnum, path);
+		if (!ret)
+			return 0;
+	}
+
+	return -ENOENT;
+}
+#else
+static int mtk_fdt_select_ubi(struct mtk_fdt_source *source,
+			      const char *path, const char *devnum)
+{
+	printf("MediaTek RITY devicetree UBI support is not enabled\n");
+	return -ENOSYS;
+}
+#endif
+
+static int mtk_fdt_select_source(struct mtk_fdt_source *source,
+				 const char *path, const char *storage,
+				 const char *storage_dev)
+{
+	if (!storage || !storage_dev)
+		return -EINVAL;
+	if (!strcmp(storage, "ubi"))
+		return mtk_fdt_select_ubi(source, path, storage_dev);
+
+	return mtk_fdt_select_block(source, path, storage, storage_dev);
+}
+
+static int mtk_fdt_source_read(struct mtk_fdt_source *source,
+			       const char *path, ulong addr, loff_t *sizep)
+{
+	if (source->type == MTK_FDT_SOURCE_BLOCK)
+		return mtk_fdt_block_read(source, path, addr, sizep);
+
+#if MTK_FDT_HAS_UBI
+	return mtk_fdt_ubi_read(path, addr, sizep);
+#else
+	return -ENOSYS;
+#endif
+}
+
+#if CONFIG_IS_ENABLED(MTK_FDT_AUTH)
+static int mtk_fdt_extract_verified(ulong fit_addr, loff_t fit_size,
+				    ulong dest_addr, size_t *sizep)
+{
+	const void *fit_data;
+	const char *uname;
+	void *dest, *fit;
+	size_t fit_len;
+	int images, node, ret;
+
+	fit = map_sysmem(fit_addr, fit_size);
+	ret = fit_check_format(fit, fit_size);
+	if (ret)
+		goto out;
+
+	images = fdt_path_offset(fit, FIT_IMAGES_PATH);
+	if (images < 0) {
+		ret = images;
+		goto out;
+	}
+
+	uname = fdt_getprop(fit, images, FIT_DEFAULT_PROP, NULL);
+	if (!uname) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	node = fit_image_get_node(fit, uname);
+	if (node < 0) {
+		ret = node;
+		goto out;
+	}
+	if (!fit_image_check_type(fit, node, IH_TYPE_FLATDT)) {
+		ret = -ENOEXEC;
+		goto out;
+	}
+	if (!fit_image_verify(fit, node)) {
+		ret = -EACCES;
+		goto out;
+	}
+
+	ret = fit_image_get_data(fit, node, &fit_data, &fit_len);
+	if (ret)
+		goto out;
+
+	dest = map_sysmem(dest_addr, fit_len);
+	memmove(dest, fit_data, fit_len);
+	unmap_sysmem(dest);
+	*sizep = fit_len;
+out:
+	unmap_sysmem(fit);
+	return ret;
+}
+#endif
+
+static int mtk_fdt_load(struct mtk_fdt_source *source, const char *path,
+			ulong dest_addr, size_t *sizep)
+{
+	loff_t size;
+	ulong load_addr = dest_addr;
+	int ret;
+
+#if CONFIG_IS_ENABLED(MTK_FDT_AUTH)
+	load_addr = env_get_hex("fw_fdt_wrapper_addr_r", 0);
+	if (!load_addr) {
+		printf("fw_fdt_wrapper_addr_r is not set\n");
+		return -EINVAL;
+	}
+#endif
+
+	printf("Loading RITY devicetree '%s'\n", path);
+	ret = mtk_fdt_source_read(source, path, load_addr, &size);
+	if (ret)
+		return ret;
+	if (!size)
+		return -EINVAL;
+
+#if CONFIG_IS_ENABLED(MTK_FDT_AUTH)
+	ret = mtk_fdt_extract_verified(load_addr, size, dest_addr, sizep);
+	if (ret) {
+		printf("Authentication failed for '%s' (%d)\n", path, ret);
+		return -EKEYREJECTED;
+	}
+
+	return 0;
+#else
+	*sizep = size;
+	return 0;
+#endif
+}
+
+static int mtk_fdt_apply_overlays(struct mtk_fdt_source *source,
+				  void *working_fdt, const char *dtb_path)
+{
+	const char *list = env_get("list_dtbo");
+	ulong overlay_addr = env_get_hex("fdtoverlay_addr_r", 0);
+	char path[MTK_FDT_PATH_MAX];
+	char *copy, *overlay, *next;
+	size_t size;
+	void *blob;
+	int ret = 0;
+
+	if (!list || !*list)
+		return 0;
+	if (!overlay_addr)
+		return -EINVAL;
+
+	copy = strdup(list);
+	if (!copy)
+		return -ENOMEM;
+	next = copy;
+
+	while ((overlay = strsep(&next, " "))) {
+		if (!*overlay)
+			continue;
+
+		ret = mtk_fdt_make_path(path, sizeof(path), dtb_path, overlay);
+		if (ret)
+			break;
+		ret = mtk_fdt_load(source, path, overlay_addr, &size);
+		if (ret)
+			break;
+
+		blob = map_sysmem(overlay_addr, size);
+		ret = fdt_check_header(blob);
+		if (!ret)
+			ret = fdt_overlay_apply_verbose(working_fdt, blob);
+		unmap_sysmem(blob);
+		if (ret)
+			break;
+	}
+
+	free(copy);
+	return ret;
+}
+
+int mtk_fdt_prepare_from(const char *storage, const char *storage_dev,
+			 const char *dtb_path)
+{
+	const char *fdtfile = env_get("fdtfile");
+	struct mtk_fdt_source source = {};
+	ulong fdt_addr = env_get_hex("fdt_addr_r", 0);
+	ulong fdt_resize = env_get_hex("fdt_resize", 0);
+	char path[MTK_FDT_PATH_MAX];
+	void *working_fdt;
+	size_t size;
+	int ret;
+
+	/*
+	 * Never leave a previous or fallback tree published after an error.
+	 * Publish zero rather than deleting fdt_addr: efi_install_fdt() falls
+	 * back to fdtcontroladdr when fdt_addr is absent, while a zero value
+	 * shadows that fallback and is rejected, so a failed preparation
+	 * cannot boot an OS with the U-Boot control devicetree.
+	 */
+	env_set_hex("fdt_addr", 0);
+	env_set_hex("fw_fdt_size", 0);
+
+	if (fdtfile && *fdtfile) {
+		ret = env_set("fw_fdtfile", fdtfile);
+		if (ret)
+			return ret;
+	}
+	env_set("fdtfile", NULL);
+	fdtfile = env_get("fw_fdtfile");
+
+	if (!fdt_addr || !dtb_path || !fdtfile || !*fdtfile)
+		return -EINVAL;
+
+	ret = mtk_fdt_make_path(path, sizeof(path), dtb_path, fdtfile);
+	if (ret)
+		return ret;
+	ret = mtk_fdt_select_source(&source, path, storage, storage_dev);
+	if (ret) {
+		printf("No RITY devicetree source contains '%s'\n", path);
+		return ret;
+	}
+
+	ret = mtk_fdt_load(&source, path, fdt_addr, &size);
+	if (ret)
+		return ret;
+
+	working_fdt = map_sysmem(fdt_addr, size);
+	ret = fdt_check_header(working_fdt);
+	if (ret)
+		goto out;
+
+	ret = fdt_shrink_to_minimum(working_fdt, fdt_resize);
+	if (ret < 0)
+		goto out;
+
+	ret = mtk_fdt_apply_overlays(&source, working_fdt, dtb_path);
+	if (ret)
+		goto out;
+
+	size = fdt_totalsize(working_fdt);
+	ret = env_set_hex("fw_fdt_size", size);
+	if (!ret)
+		ret = env_set_hex("fdt_addr", fdt_addr);
+	if (!ret)
+		printf("Prepared RITY devicetree at 0x%lx (%zu bytes)\n",
+		       fdt_addr, size);
+out:
+	unmap_sysmem(working_fdt);
+	return ret;
+}
+
+int mtk_fdt_prepare(void)
+{
+	return mtk_fdt_prepare_from(env_get("storage"), env_get("storage_dev"),
+				    env_get("dtb_path"));
+}
+
+static bool mtk_fdt_has_efi_target(void)
+{
+	const char *targets = env_get("boot_targets");
+	char *copy, *next, *target;
+	bool has_efi = false;
+
+	/* With no explicit policy, bootstd may still discover an EFI bootflow. */
+	if (!targets || !*targets)
+		return true;
+
+	copy = strdup(targets);
+	if (!copy)
+		return true;
+	next = copy;
+	while ((target = strsep(&next, " "))) {
+		if (*target && strcmp(target, "embedded")) {
+			has_efi = true;
+			break;
+		}
+	}
+	free(copy);
+
+	return has_efi;
+}
+
+static int mtk_fdt_post_preboot(void)
+{
+	int ret;
+
+	if (!mtk_fdt_has_efi_target())
+		return 0;
+
+	ret = mtk_fdt_prepare();
+	if (ret)
+		printf("RITY devicetree preparation failed (%d)\n", ret);
+
+	/* Keep the prompt and legacy boot path available; EFI fails via fdt_addr=0. */
+	return 0;
+}
+
+EVENT_SPY_SIMPLE(EVT_POST_PREBOOT, mtk_fdt_post_preboot);
diff --git a/arch/arm/mach-mediatek/fdt_prepare.h b/arch/arm/mach-mediatek/fdt_prepare.h
new file mode 100644
index 00000000000..5c140e3e335
--- /dev/null
+++ b/arch/arm/mach-mediatek/fdt_prepare.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __MTK_FDT_PREPARE_H
+#define __MTK_FDT_PREPARE_H
+
+int mtk_fdt_prepare(void);
+int mtk_fdt_prepare_from(const char *storage, const char *storage_dev,
+			 const char *dtb_path);
+
+#endif

-- 
2.55.0

