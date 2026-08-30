Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3701C61DB9
	for <u-boot@archiver.kernel.org>; Sun, 30 Aug 2026 10:18:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D7C8580E15;
	Sun, 30 Aug 2026 10:18:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mqWFt0Pl5FFn; Sun, 30 Aug 2026 10:18:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788085135;
	bh=effWmU/Y9pp8FS/C07tC8Ukp6oV092Q09uKHdlJNWao=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q9q+xdmMw33f8V9cRgJJcgH1xJxKD7KhqSXbBOuEL5pTQRJI/aVNTs9jAKcVqW1UX
	 IJWo8aaTGyLvDAl/7E1hQN6t3RLnYVv1mWv9F4SyN1OKrr6IXAnQnrc+aawZSgbNEm
	 FPyQERctIJqumNamT3MQJL6FfRcHd9XLNosNrMUyYbOOKNCbDGgRJz1XDhW9hUIiPl
	 m3eEI92cjri3o383Z2tpLbS/ER5ywtrV8q6m5p+wxjfl3eHd4FUw6VAzUgDWrF4Lol
	 I/jDFWcsXUFLZ6lzx75tPXN2dl5CGKRnie/7i8jHJ8tluqWL0SFs0wmxQ3xqARLNgI
	 xnhCIbYEczNzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7AC7C80E09;
	Sun, 30 Aug 2026 10:18:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C7171230
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 10:18:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AC80260613
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 10:18:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1NbKfUsfOacG for <u-boot@lists.u-boot-project.org>;
 Sun, 30 Aug 2026 10:18:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=bVeiT3e0
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 86FEB60607
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 10:18:48 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-484362f5c4aso524170f8f.3
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 03:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788085126; x=1788689926;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=effWmU/Y9pp8FS/C07tC8Ukp6oV092Q09uKHdlJNWao=;
 b=bVeiT3e0UghqMUN6dJ78lOc9veqFEreCF7bQrC+6RPpZzJk6VAcV9UXXIQcPraiqML
 48KPhjz6g/GDRY8jNDLPqTWrfPFgGqidiAnk/Bic07KXeTyTRkubTFJZZw1JtpDYD05s
 nYKqRE6mkihG0+Wx2vFqb4+D8mhXE2ccM7BAKQgLbHj6BTEVRyE+iodfLukQ0kmhAUHb
 utyDrV0OrWRvRGSqXkJirsZ789o33m58Zhqhem2v2QobXAvzv63aj9ylbWyePe/MWfYR
 ILeYVoSBD/IE/MTZ2X9tbxav2FlaRlFsdDZNKRiFQQpk8hitE37adlnw9yjAoVP4oplu
 XCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788085126; x=1788689926;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=effWmU/Y9pp8FS/C07tC8Ukp6oV092Q09uKHdlJNWao=;
 b=cB4FS3aaWua3DTXQ5avY4613QQ+VhtvnNTdgx1UgAKm74XVFCeviuzSB/ft/RcCj4c
 jtEyZvasDHj85FeTtpru0deqmYkSBo9BuaLkC2bv8zulwhuJE7E4V8OCIfcQUZUjMI4a
 oa5GdXi4IlCqWpmtIAIbzhQ8leRp0Fqqi3Me8JWkua85rLtVcLlopYC+xFJEdYh/9wMl
 dQQW3uevZie4azc02VYWlnZXIjScUiwhvNu/M89epWRLxSCxwl8C60Ql2NFmUTl+DVr1
 9AFE5NXMtaBHJRtqMGvT9D2bL0ewIcBs6zEye52Tr2TEFp1slEG+v+U6g9bppZwtfLYG
 kaQQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzp/I1ddswuO1kIizp/ViUFEq9A/FNgh19fJ73BNbZwkJ+Cb9dM2MND4DaYrwnhcl9I7qV80hc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++n1ElTnNIOSx1GwNPSOk0oS41gMENWi0/RWOfNdJ3wSLEZ4TU0X
 YHl84hKyOzo0COlIujemt7fQoBTO08K7AVUEERBhIs5oEgNX3eiaGin/wbEvKzlOUXE=
X-Gm-Gg: AYBFou0aFfXRiefp8lnOgjDY41QCGhR2i8KbR2to6X7xI0tmkm3kalAUtuWpIaunubV
 EIomXtEcygBxcLw+c04YDmPxH+LbtsTquBsVLMFbH1Aq0bsA1ulRkvKzJbbAQJ65VQdSObidMO/
 rlXsqyd8Vzuy8/FIvYLrt/LTOof/CSeRL/iActCIR545WSQJNsO0rgI7NkWZ9H1SbyXB7uGHyXB
 +sKfXYBZlhU9uvGQH8+087w/QECcrhMRvQrLp0bTC59Zo1LVtCpCifkCJA3aP1+6HjFMyBPp/g9
 JMFPKcr0KZQQZiUJfnO+qvg2rV0asFZJq/3B7lB50vnR31qGWxMdaznXOMO/7HvsKYmz8NjkdEM
 pkP9/xEpG6fv57d7nhkE4MXKlU8Npq5tcIHWGGsIwf6yeK6xqJnNv/vanxxZzosYMIyUtG24Wsf
 0f/dH1XToOkuyviNSCM4xIwrbBVeMrWfpyk58jpM5uBa/BRzQoF25aIi4sprht5GoM+OmuMWGZg
 /hrfx57xXZd4D9sRf/D9uYp5NswKuEF7jyKQ8Qnr58/OeScw1qwWmX4KI03qTj1WrzHTYxLRKUT
 bfWu
X-Received: by 2002:a05:6000:2904:b0:482:ea9b:962c with SMTP id
 ffacd0b85a97d-482f79c91e1mr32251171f8f.22.1788085126481; 
 Sun, 30 Aug 2026 03:18:46 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbab3fcesm14644619f8f.5.2026.08.30.03.18.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 03:18:46 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Sun, 30 Aug 2026 12:18:39 +0200
Subject: [PATCH v2 1/3] arm: mediatek: add RITY devicetree preparation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-ccaione-upstream-mtk-fdt-prepare-v2-1-f9cfce2ed42a@baylibre.com>
References: <20260830-ccaione-upstream-mtk-fdt-prepare-v2-0-f9cfce2ed42a@baylibre.com>
In-Reply-To: <20260830-ccaione-upstream-mtk-fdt-prepare-v2-0-f9cfce2ed42a@baylibre.com>
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
 <pablo.sun@mediatek.com>, 
 Carlo Caione <ccaione@baylibre.com>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Robinson <pbrobinson@gmail.com>, Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 =?utf-8?q?Ramax_Lo_=28=E7=BE=85=E6=98=8E=E9=81=A0=29?= <Ramax.Lo@mediatek.com>,
 =?utf-8?q?Chris-qj_Chen_=28=E9=99=B3=E5=A5=87=E9=80=B2=29?=
 <Chris-qj.Chen@mediatek.com>
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

This environment and image-layout contract is specific to MediaTek RITY.
The referenced DTB, DTBO, FIT, filesystem, UBI and UBIFS formats are
existing U-Boot formats.

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
mtk_fdt_prepare command under cmd/mediatek so an interactive user can
rebuild the tree after changing a selector. Document its source selection,
environment variables and authentication behavior.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 MAINTAINERS                                      |   3 +
 arch/arm/include/asm/arch-mediatek/fdt_prepare.h |  10 +
 arch/arm/mach-mediatek/Kconfig                   |  25 ++
 arch/arm/mach-mediatek/Makefile                  |   1 +
 arch/arm/mach-mediatek/fdt_prepare.c             | 501 +++++++++++++++++++++++
 cmd/Kconfig                                      |   1 +
 cmd/Makefile                                     |   3 +
 cmd/mediatek/Kconfig                             |  20 +
 cmd/mediatek/Makefile                            |   3 +
 cmd/mediatek/fdt_prepare.c                       |  30 ++
 doc/usage/cmd/mtk_fdt_prepare.rst                |  79 ++++
 11 files changed, 676 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index eb48eea55c5..8c0bfe2d3a3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -418,6 +418,9 @@ R:	GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-mediatek.git
 S:	Maintained
 F:	arch/arm/dts/mt*
+F:	arch/arm/include/asm/arch-mediatek/
+F:	arch/arm/mach-mediatek/
+F:	cmd/mediatek/
 F:	drivers/power/domain/mt*
 F:	drivers/power/regulator/mt*.c
 F:	drivers/usb/mtu3/
diff --git a/arch/arm/include/asm/arch-mediatek/fdt_prepare.h b/arch/arm/include/asm/arch-mediatek/fdt_prepare.h
new file mode 100644
index 00000000000..baa7461d042
--- /dev/null
+++ b/arch/arm/include/asm/arch-mediatek/fdt_prepare.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __ASM_ARCH_MEDIATEK_FDT_PREPARE_H
+#define __ASM_ARCH_MEDIATEK_FDT_PREPARE_H
+
+int mtk_fdt_prepare(void);
+int mtk_fdt_prepare_from(const char *storage, const char *storage_dev,
+			 const char *dtb_path);
+
+#endif /* __ASM_ARCH_MEDIATEK_FDT_PREPARE_H */
diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 5e6c50ca64d..911d812319d 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -215,4 +215,29 @@ config MTK_TZ_MOVABLE
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
index 35f748a70d6..17f79cad11d 100644
--- a/arch/arm/mach-mediatek/Makefile
+++ b/arch/arm/mach-mediatek/Makefile
@@ -3,6 +3,7 @@
 obj-$(CONFIG_ARM64) += armv8-mem-map.o
 obj-y	+= cpu.o
 obj-$(CONFIG_MTK_TZ_MOVABLE)	+= tzcfg.o
+obj-$(CONFIG_MTK_FDT_PREPARE)	+= fdt_prepare.o
 obj-$(CONFIG_XPL_BUILD)	+= spl.o
 
 obj-$(CONFIG_TARGET_MT7622) += mt7622/
diff --git a/arch/arm/mach-mediatek/fdt_prepare.c b/arch/arm/mach-mediatek/fdt_prepare.c
new file mode 100644
index 00000000000..0401d7b3b0a
--- /dev/null
+++ b/arch/arm/mach-mediatek/fdt_prepare.c
@@ -0,0 +1,501 @@
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
+#include <asm/arch-mediatek/fdt_prepare.h>
+#include <linux/errno.h>
+#include <linux/libfdt.h>
+#include <linux/string.h>
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
diff --git a/cmd/Kconfig b/cmd/Kconfig
index ff90a87024c..dabe790d2e9 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2658,6 +2658,7 @@ config CMD_PSTORE_ECC_SIZE
 
 endif
 
+source "cmd/mediatek/Kconfig"
 source "cmd/mvebu/Kconfig"
 
 config CMD_TERMINAL
diff --git a/cmd/Makefile b/cmd/Makefile
index ce772e5555b..921d9048352 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -249,6 +249,9 @@ obj-$(CONFIG_RISCV) += riscv/
 obj-$(CONFIG_SANDBOX) += sandbox/
 obj-$(CONFIG_X86) += x86/
 
+# Mediatek
+obj-$(CONFIG_CMD_MEDIATEK) += mediatek/
+
 # Meson
 obj-$(CONFIG_CMD_MESON) += meson/
 
diff --git a/cmd/mediatek/Kconfig b/cmd/mediatek/Kconfig
new file mode 100644
index 00000000000..777b9778e1f
--- /dev/null
+++ b/cmd/mediatek/Kconfig
@@ -0,0 +1,20 @@
+menuconfig CMD_MEDIATEK
+	bool "MediaTek commands"
+	depends on ARCH_MEDIATEK
+	default y
+	help
+	  Enable MediaTek-specific commands. Individual commands can be selected
+	  below.
+
+if CMD_MEDIATEK
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
+endif
diff --git a/cmd/mediatek/Makefile b/cmd/mediatek/Makefile
new file mode 100644
index 00000000000..82f3d0dc412
--- /dev/null
+++ b/cmd/mediatek/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-$(CONFIG_CMD_MTK_FDT_PREPARE) += fdt_prepare.o
diff --git a/cmd/mediatek/fdt_prepare.c b/cmd/mediatek/fdt_prepare.c
new file mode 100644
index 00000000000..a861fe8804e
--- /dev/null
+++ b/cmd/mediatek/fdt_prepare.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Carlo Caione <ccaione@baylibre.com>
+ */
+
+#include <command.h>
+#include <asm/arch-mediatek/fdt_prepare.h>
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
diff --git a/doc/usage/cmd/mtk_fdt_prepare.rst b/doc/usage/cmd/mtk_fdt_prepare.rst
new file mode 100644
index 00000000000..aa10516c2b1
--- /dev/null
+++ b/doc/usage/cmd/mtk_fdt_prepare.rst
@@ -0,0 +1,79 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. Copyright (C) 2026 Carlo Caione <ccaione@baylibre.com>
+
+.. index::
+   single: mtk_fdt_prepare (command)
+
+mtk_fdt_prepare command
+=======================
+
+Synopsis
+--------
+
+::
+
+    mtk_fdt_prepare [<interface> <dev> <probe_base>]
+
+Description
+-----------
+
+The ``mtk_fdt_prepare`` command loads a base devicetree and applies the
+overlays listed in the ``list_dtbo`` environment variable. The completed tree
+is published through ``fdt_addr`` for use by EFI boot.
+
+With no arguments, the command obtains the source from these environment
+variables:
+
+``storage``
+    Storage interface. The value ``ubi`` selects UBI/UBIFS; any other value is
+    treated as a block-device interface accepted by U-Boot.
+
+``storage_dev``
+    Device number. For UBI/UBIFS this is the UBI device number.
+
+``dtb_path``
+    Directory containing the base devicetree and overlays.
+
+The three positional arguments override ``storage``, ``storage_dev`` and
+``dtb_path`` respectively.
+
+Source selection
+----------------
+
+For block devices, the command searches for a partition whose type GUID is
+``384e979b-eb76-435a-a3a6-1a071dbad91d``. The
+``fw_fdt_part_type_uuid`` environment variable can override this GUID.
+``boot_dtb`` can select a specific matching partition number.
+
+For UBI/UBIFS, the command searches MTD partitions whose name contains the
+value of ``fw_fdt_mtd_name``, which defaults to ``firmware``. ``boot_dtb`` can
+select a specific MTD index.
+
+Devicetree selection
+--------------------
+
+``fdtfile`` selects the base devicetree. The command saves this selection in
+``fw_fdtfile`` and removes ``fdtfile`` so EFI cannot fall back to loading a
+different tree. Subsequent invocations use ``fw_fdtfile``.
+
+``list_dtbo`` is a space-separated list of overlays. They are loaded from
+``dtb_path`` and applied in list order.
+
+The command uses ``fdt_addr_r`` for the assembled tree,
+``fdtoverlay_addr_r`` for each overlay and ``fdt_resize`` as the extra space
+reserved before applying overlays. On success, it sets ``fdt_addr`` and
+``fw_fdt_size``. On failure, both variables remain zero.
+
+Authentication
+--------------
+
+With ``CONFIG_MTK_FDT_AUTH``, each file is a signed single-image FIT whose
+default image contains the flat devicetree payload. The command loads the FIT
+at ``fw_fdt_wrapper_addr_r``, verifies the selected image and extracts it
+before assembly.
+
+Configuration
+-------------
+
+The command is available when ``CONFIG_CMD_MTK_FDT_PREPARE`` is enabled. The
+preparation service requires ``CONFIG_MTK_FDT_PREPARE``.

-- 
2.55.0

