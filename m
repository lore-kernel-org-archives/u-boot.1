Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2079CA601D
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 15:11:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 76900812D3;
	Fri,  9 Oct 2026 15:11:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VTwjdyXWPk8M; Fri,  9 Oct 2026 15:11:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BCDEC81328
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791558678;
	b=foE03v4+8lqfsuKfsZewXQA1p5dB8DZTv52nWBMQANaurQZ3DYxeEzG23au6JawGO8rC
	 KWGreHeoumhyAY33fOZdu13QBEqsn8vsJwaI7RAtrVJfLVPa2HVJCqetikoTnQSJcXb3G
	 xA1/p57ddWovxYyJAB7B4E7eqZWEcCy8N3kW8GksfQXeMW1PUEBu9PR7ARKYtdqmBl9IL
	 FyaSdgLZRP72mf2vNmrdVw42QsrXdUI9QAeFztw4vj1ppm6+XcLE83wRc/kFO7h3h73ty
	 FBeoozFYyZLmVP3NcVBgHt1GfEDzHE0VN5vpQJZK87VVpyvw43Vt6ZrD/fp+z6w49+Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791558678;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IXH01edYGManc4NWURROCGjfU6nRb8W4/SBDMlDUokc=;
	b=jES0rThhrKtExg1F3lidn0KDt1Hdee7lHI+kih9qHN4Uf10VQ0QQVNzy5ZR0wDv7GnjJ
	 pLy+4ILO3xY+jtRIdgmMxLiYvU9qzLevUH2JLU6LCJ8dgiKis8Aob2DXMOvcw0btnCxSR
	 KsCpc6L19FKYS2WpSJGmsGrVrKID56tQwpAdc6TgQdAVL300bPNl4VTu8InBmDan4h7Of
	 KYfkZS5nSFK55WAE/FnbgyPXf8vTJpehYWD9vqeeLI8raSYfAGRrQ9rXY+AWpsR/prCTd
	 VUrxjGhKO1nrm0sBzDKqd3Nu1XNO/91vQYH0QOxtn44aDmzFo8DCnP9if1p0OXjtb0g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791558678;
	bh=IXH01edYGManc4NWURROCGjfU6nRb8W4/SBDMlDUokc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kcy1pI6KhvlXlmQp7+gWDk23yB3FKWAfgHNXUfOcw74aXJmTazStVExiaM8FONZRb
	 1ATmIKwTMrNqj3tyb9JHPlZSCxhZUTL7PNFXdjQKoL72hX5I4VnF1Y8aG8ZlAbQghP
	 +7JGRw64Rmu5QkHFyw3qtBK1NEdvqY6bezWTI7LAkgev8J5DNVPsf1h4ZCVegTidA1
	 AI6YrOAzNbvZD/6+cMQS0Ekl1deZBCiju5SfxcB/TQQWOMQ7ezw+qtf3tjA0/96jhb
	 2kfoqQsPbqWXhmEKmJYkmAp7yAsWisxVAvenqqOLjvm7lDe3RmjT9sV5Li03SvcjuS
	 YKS/PEbv9JBgg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BCDEC81328;
	Fri,  9 Oct 2026 15:11:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 88079317
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 15:11:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 79ED4400FD
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 15:11:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9ziRfszK1b7X for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 15:11:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 842E940061
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791558675;
 b=b7KDaxKi0F5eOfc/fBhtYal5Rh/6qkeXbf5VmAB/GdrJptotbdnQJEQwSRzrxish9XLB
 mBphI1b4GQXW+CYPOu/wAN9zcV0p6C1O8adBjJy4SQd1YbmMmlx+30EQf9bV21OaREtrP
 +G+x5YKiUst1ZGr0dWed7fp9hzGA5DeR+BiCqV9OOp1K06b5xu1LAYQ4yFkJYR8QDfmDl
 JWigRpIzl8BRfZQS/qICZO8zhGyoGsMkP83VDNbM0+BcB5POQGAvXedsTG1zCuK01TouR
 i8IYifvaosKzw8xhwu99Em917FyDobCXxKGVWFZWthgSUh9PIJ1MZrDu7HFymofyQmA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791558675;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
 bh=IXH01edYGManc4NWURROCGjfU6nRb8W4/SBDMlDUokc=;
 b=dmrnFkMNyA5MdH+ysuyNGsK2fWb6r5gNH8t4HQ+VKGMqGm/btY+vBiSgBgbpa1ub9lC1
 +QgC5u4fBujYZHMNtoGGbsab7R9wyoC3i4kCh8oftHm+BHKNfLarixPB39ylvY13Z3/0o
 mwXvCjD+b0M828ZvoTe6oT+4lMenYGMIYvnvKzRBEY7JAuLWDNDOp7U586t+lmpg4Bcda
 k917Y/QFv7yAP1na139iB2htCrmHdc9FayhHL6LOiFsxnCS9W/lrZT03yTZA848v8c9kU
 aw6HSgd9shoiFRX26/5R0DwyXc3tGvbVril+Q8KodZffwUetGlAj7rcXJQuOdfqXVlg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=163.com;
 dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=QKczCcaU; 
 arc=none smtp.remote-ip=117.135.210.2
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=117.135.210.2;
 helo=m16.mail.163.com; envelope-from=hyyoxhk@163.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=QKczCcaU
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 842E940061
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 15:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=IX
 H01edYGManc4NWURROCGjfU6nRb8W4/SBDMlDUokc=; b=QKczCcaUAEURA3QB4W
 R/asMepUZ3WYx4C0rcNrDhMfnrhPZeXcTF/v7bWsBCa/D6fdAXnZjtS/v1VWDofR
 sRad01/sN1Lt+RIeSlvFKnRzGQjXwEliMHMg6xqPMLMc3cUXVmggJJWtCYeqIK1v
 mTqHX0TG9Zn1e8YxcKroekTL0=
Received: from nh50.. (unknown [])
 by gzsmtp5 (Coremail) with SMTP id QCgvCgD3X33NA8lqRBSiDg--.8060S2;
 Fri, 09 Oct 2026 23:10:06 +0800 (CST)
From: He Yong <hyyoxhk@163.com>
To: u-boot@lists.u-boot-project.org
Cc: sjg@chromium.org, trini@konsulko.com, alchark@flipper.net,
 daniel@makrotopia.org, jbx6244@gmail.com, quentin.schulz@cherry.de
Subject: [PATCH] bootstd: Add a bootmeth for scripts in raw partitions
Date: Fri,  9 Oct 2026 23:10:05 +0800
Message-ID: <20261009151005.2870671-1-hyyoxhk@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: QCgvCgD3X33NA8lqRBSiDg--.8060S2
X-Coremail-Antispam: 1Uf129KBjvAXoWfGFWftF4fXw13Wr1xtFW3Awb_yoW8AFWUXo
 ZakrnIvFn8Kr47ArZ8WF4DGF45ZF48KrnxXFW3GFZ8X3WUAw1xK347Za15Wa4UAFySgw15
 XFy2g3Wftr1jq3yrn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU4eHqUUUUU
X-CM-SenderInfo: pk1105lkn6il2tof0z/xtbC8g4B02rJA85j4QAA3C
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

Some disk layouts store a U-Boot script image directly in a named
partition, without a filesystem. The existing script bootmeth cannot
find these images, so booting them requires a board-specific bootcmd.

Add an optional script_raw bootmeth which matches a partition label and
reads the image from the first block. Determine the image size from its
header and check it against the partition size and a configurable limit
before allocating and reading the complete image.

Support legacy script images and FIT scripts with embedded data. Check
legacy length-table bounds and validate the complete FIT before passing
it to image_locate_script(). Reject FIT external data to avoid following
references outside the loaded buffer. Use the existing script verification
policy and share the script boot handler to set the device environment
variables and execute the image.

Document the configuration and disk layout, and add sandbox tests for
legacy and FIT execution, invalid images, size limits, partition labels
and unsupported external data.

Signed-off-by: He Yong <hyyoxhk@163.com>
---
 MAINTAINERS                               |   1 +
 boot/Kconfig                              |  26 +++
 boot/Makefile                             |   1 +
 boot/bootmeth_script.c                    |   4 +-
 boot/bootmeth_script_raw.c                | 202 ++++++++++++++++++++++
 doc/develop/bootstd/index.rst             |   1 +
 doc/develop/bootstd/script_raw.rst        |  45 +++++
 doc/device-tree-bindings/bootmeth.txt     |   1 +
 include/bootmeth.h                        |  12 ++
 test/py/tests/test_bootmeth_script_raw.py |  97 +++++++++++
 10 files changed, 388 insertions(+), 2 deletions(-)
 create mode 100644 boot/bootmeth_script_raw.c
 create mode 100644 doc/develop/bootstd/script_raw.rst
 create mode 100644 test/py/tests/test_bootmeth_script_raw.py

diff --git a/MAINTAINERS b/MAINTAINERS
index d1f51d9197d..2f2630400c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -846,6 +846,7 @@ F:	include/bootflow.h
 F:	include/bootmeth.h
 F:	include/bootstd.h
 F:	test/boot/
+F:	test/py/tests/test_bootmeth_script_raw.py
 
 BOOTMETH_ANDROID
 M:	Mattijs Korpershoek <mkorpershoek@kernel.org>
diff --git a/boot/Kconfig b/boot/Kconfig
index 8fcdc36c931..990c8bc0110 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1009,6 +1009,32 @@ config BOOTMETH_SCRIPT
 	  This provides a way to try out standard boot on an existing boot flow.
 	  It is not enabled by default to save space.
 
+config BOOTMETH_SCRIPT_RAW
+	bool "Boot from a script in a raw partition"
+	depends on BOOTMETH_SCRIPT && BLK && PARTITIONS
+	depends on LEGACY_IMAGE_FORMAT || FIT
+	help
+	  Locate a named partition and read a U-Boot script image directly from
+	  its first block, without a filesystem. This adds the script_raw boot
+	  method. Legacy script images and FIT scripts with embedded data are
+	  supported.
+
+config BOOTMETH_SCRIPT_RAW_PARTITION
+	string "Raw script partition name"
+	depends on BOOTMETH_SCRIPT_RAW
+	default "uboot_scr"
+	help
+	  Partition label to match when scanning for a raw script image.
+
+config BOOTMETH_SCRIPT_RAW_MAX_SIZE
+	hex "Maximum raw script image size"
+	depends on BOOTMETH_SCRIPT_RAW
+	default 0x100000
+	range 0x200 0x1000000
+	help
+	  Maximum script image size in bytes, including its image header.
+	  The image must also fit within the selected partition.
+
 config UPL
 	bool "upl - Universal Payload Specification"
 	imply CMD_UPL
diff --git a/boot/Makefile b/boot/Makefile
index f2cbda176a0..12649286601 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_$(PHASE_)BOOTMETH_QFW) += bootmeth_qfw.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_RAUC) += bootmeth_rauc.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_SANDBOX) += bootmeth_sandbox.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_SCRIPT) += bootmeth_script.o
+obj-$(CONFIG_$(PHASE_)BOOTMETH_SCRIPT_RAW) += bootmeth_script_raw.o
 obj-$(CONFIG_$(PHASE_)CEDIT) += cedit.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_EFI_BOOTMGR) += bootmeth_efi_mgr.o
 
diff --git a/boot/bootmeth_script.c b/boot/bootmeth_script.c
index cd50977cc40..9e95cc51e58 100644
--- a/boot/bootmeth_script.c
+++ b/boot/bootmeth_script.c
@@ -188,7 +188,7 @@ static int script_set_bootflow(struct udevice *dev, struct bootflow *bflow,
 	return 0;
 }
 
-static int script_boot(struct udevice *dev, struct bootflow *bflow)
+int bootmeth_script_boot(struct udevice *dev, struct bootflow *bflow)
 {
 	struct blk_desc *desc;
 	ulong addr;
@@ -258,7 +258,7 @@ static struct bootmeth_ops script_bootmeth_ops = {
 	.read_bootflow	= script_read_bootflow,
 	.set_bootflow	= script_set_bootflow,
 	.read_file	= bootmeth_common_read_file,
-	.boot		= script_boot,
+	.boot		= bootmeth_script_boot,
 };
 
 static const struct udevice_id script_bootmeth_ids[] = {
diff --git a/boot/bootmeth_script_raw.c b/boot/bootmeth_script_raw.c
new file mode 100644
index 00000000000..7da42055298
--- /dev/null
+++ b/boot/bootmeth_script_raw.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Bootmethod for scripts stored in a raw partition
+ *
+ * Copyright 2026 He Yong <hyyoxhk@163.com>
+ */
+
+#define LOG_CATEGORY UCLASS_BOOTSTD
+
+#include <blk.h>
+#include <bootflow.h>
+#include <bootmeth.h>
+#include <dm.h>
+#include <image.h>
+#include <malloc.h>
+#include <mapmem.h>
+#include <part.h>
+#include <asm/cache.h>
+
+static int script_raw_check(struct udevice *dev, struct bootflow_iter *iter)
+{
+	return bootflow_iter_check_blk(iter);
+}
+
+/**
+ * script_raw_validate() - Check bounds before following image metadata
+ *
+ * @buf: Complete script image
+ * @size: Image size in bytes, excluding block padding
+ * Return: 0 if valid, or a negative error code
+ */
+static int script_raw_validate(void *buf, uint size)
+{
+	struct legacy_img_hdr *hdr = buf;
+	const fdt32_t *lengths;
+	uint pos, len;
+	char *data;
+	int images, node, ret;
+
+	if (genimg_get_format(buf) == IMAGE_FORMAT_LEGACY) {
+		pos = sizeof(*hdr);
+		if (size < pos + 2 * sizeof(*lengths) ||
+		    image_get_data_size(hdr) != size - pos ||
+		    !image_check_hcrc(hdr))
+			return -EINVAL;
+		lengths = buf + pos;
+		len = fdt32_to_cpu(*lengths);
+		do {
+			if (size - pos < sizeof(*lengths))
+				return -EINVAL;
+			pos += sizeof(*lengths);
+		} while (*lengths++);
+		if (!len || len > size - pos)
+			return -EINVAL;
+	} else if (IS_ENABLED(CONFIG_FIT) &&
+		   genimg_get_format(buf) == IMAGE_FORMAT_FIT) {
+		ret = fdt_check_full(buf, size);
+		if (ret || fdt_totalsize(buf) != size)
+			return -EINVAL;
+		images = fdt_path_offset(buf, FIT_IMAGES_PATH);
+		if (images < 0)
+			return -EINVAL;
+		fdt_for_each_subnode(node, buf, images) {
+			/* Do not follow external data offsets during verification. */
+			if (fdt_getprop(buf, node, FIT_DATA_OFFSET_PROP, NULL) ||
+			    fdt_getprop(buf, node, FIT_DATA_POSITION_PROP, NULL))
+				return -EOPNOTSUPP;
+		}
+	} else {
+		return -ENOEXEC;
+	}
+
+	ret = image_locate_script(buf, size, NULL, NULL, &data, &len);
+	return ret ? -EINVAL : 0;
+}
+
+static int script_raw_read_bootflow(struct udevice *dev, struct bootflow *bflow)
+{
+	struct legacy_img_hdr *hdr;
+	struct disk_partition info;
+	struct blk_desc *desc;
+	lbaint_t count;
+	uint size;
+	void *buf;
+	int ret;
+
+	if (!bflow->blk || !bflow->part)
+		return -ENOENT;
+	desc = dev_get_uclass_plat(bflow->blk);
+	ret = part_get_info(desc, bflow->part, &info);
+	if (ret)
+		return ret;
+	if (strcmp(info.name, CONFIG_BOOTMETH_SCRIPT_RAW_PARTITION))
+		return -ENOENT;
+	bflow->state = BOOTFLOWST_PART;
+
+	if (!info.size || desc->blksz < sizeof(*hdr) ||
+	    desc->blksz > CONFIG_BOOTMETH_SCRIPT_RAW_MAX_SIZE)
+		return -EINVAL;
+	buf = memalign(ARCH_DMA_MINALIGN, desc->blksz);
+	if (!buf)
+		return -ENOMEM;
+	if (blk_dread(desc, info.start, 1, buf) != 1) {
+		ret = -EIO;
+		goto out;
+	}
+
+	hdr = buf;
+	if (IS_ENABLED(CONFIG_LEGACY_IMAGE_FORMAT) &&
+	    genimg_get_format(buf) == IMAGE_FORMAT_LEGACY) {
+		if (!image_check_hcrc(hdr) ||
+		    !image_check_type(hdr, IH_TYPE_SCRIPT)) {
+			ret = -EINVAL;
+			goto out;
+		}
+		size = image_get_data_size(hdr);
+		if (size > CONFIG_BOOTMETH_SCRIPT_RAW_MAX_SIZE - sizeof(*hdr)) {
+			ret = -E2BIG;
+			goto out;
+		}
+		size += sizeof(*hdr);
+	} else if (IS_ENABLED(CONFIG_FIT) && !fdt_check_header(buf)) {
+		size = fdt_totalsize(buf);
+	} else {
+		ret = -ENOEXEC;
+		goto out;
+	}
+	if (size < sizeof(struct fdt_header)) {
+		ret = -EINVAL;
+		goto out;
+	}
+	if (size > CONFIG_BOOTMETH_SCRIPT_RAW_MAX_SIZE) {
+		ret = -E2BIG;
+		goto out;
+	}
+	count = DIV_ROUND_UP(size, desc->blksz);
+	if (count > info.size) {
+		ret = -E2BIG;
+		goto out;
+	}
+	free(buf);
+	buf = memalign(ARCH_DMA_MINALIGN, count * desc->blksz + 1);
+	if (!buf)
+		return -ENOMEM;
+	if (blk_dread(desc, info.start, count, buf) != count) {
+		ret = -EIO;
+		goto out;
+	}
+	((char *)buf)[size] = '\0';
+	ret = script_raw_validate(buf, size);
+	if (ret)
+		goto out;
+
+	bflow->fname = strdup(CONFIG_BOOTMETH_SCRIPT_RAW_PARTITION);
+	bflow->subdir = strdup("");
+	if (!bflow->fname || !bflow->subdir) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	if (!bootflow_img_add(bflow, bflow->fname, (enum bootflow_img_t)IH_TYPE_SCRIPT,
+			      map_to_sysmem(buf), size)) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	bflow->buf = buf;
+	bflow->size = size;
+	bflow->state = BOOTFLOWST_READY;
+
+	return 0;
+out:
+	free(buf);
+	return ret;
+}
+
+static int script_raw_bootmeth_bind(struct udevice *dev)
+{
+	struct bootmeth_uc_plat *plat = dev_get_uclass_plat(dev);
+
+	plat->desc = "Script boot from a raw partition";
+	plat->flags = BOOTMETHF_ANY_PART;
+
+	return 0;
+}
+
+static struct bootmeth_ops script_raw_bootmeth_ops = {
+	.check		= script_raw_check,
+	.read_bootflow	= script_raw_read_bootflow,
+	.boot		= bootmeth_script_boot,
+};
+
+static const struct udevice_id script_raw_bootmeth_ids[] = {
+	{ .compatible = "u-boot,script-raw" },
+	{ }
+};
+
+U_BOOT_DRIVER(bootmeth_2script_raw) = {
+	.name		= "bootmeth_script_raw",
+	.id		= UCLASS_BOOTMETH,
+	.of_match	= script_raw_bootmeth_ids,
+	.ops		= &script_raw_bootmeth_ops,
+	.bind		= script_raw_bootmeth_bind,
+};
diff --git a/doc/develop/bootstd/index.rst b/doc/develop/bootstd/index.rst
index 9271b5eef14..0a2452a44c2 100644
--- a/doc/develop/bootstd/index.rst
+++ b/doc/develop/bootstd/index.rst
@@ -15,4 +15,5 @@ Standard Boot
    cros
    rauc
    script
+   script_raw
    sandbox
diff --git a/doc/develop/bootstd/script_raw.rst b/doc/develop/bootstd/script_raw.rst
new file mode 100644
index 00000000000..980b8b34ae0
--- /dev/null
+++ b/doc/develop/bootstd/script_raw.rst
@@ -0,0 +1,45 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Raw Script Bootmeth
+==================
+
+The ``script_raw`` bootmeth reads a script image from the start of a named
+partition on a block device, without a filesystem. Enable
+``CONFIG_BOOTMETH_SCRIPT`` and ``CONFIG_BOOTMETH_SCRIPT_RAW`` to build it.
+The partition name is selected by ``CONFIG_BOOTMETH_SCRIPT_RAW_PARTITION``
+and defaults to ``uboot_scr``. The partition need not be marked bootable.
+
+The method reads the first block to determine the image size, then reads the
+complete image. The image must fit within the partition and the limit set by
+``CONFIG_BOOTMETH_SCRIPT_RAW_MAX_SIZE`` (1 MiB by default). It supports legacy
+U-Boot script images and FIT scripts with embedded data. FIT external data is
+not supported. Plain text scripts must first be wrapped with ``mkimage``, for
+example::
+
+    mkimage -A arm64 -T script -C none -n 'Boot script' -d boot.cmd boot.scr
+
+Write ``boot.scr`` directly at the start of the ``uboot_scr`` partition when
+creating the disk image. There is no filename lookup on the target partition.
+Image validation is performed before the bootflow is marked ready, using the
+same verification policy as ``source`` (including the ``verify`` environment
+variable).
+
+To scan only this bootmeth on MMC device 0::
+
+    bootmeth order script_raw
+    bootflow scan -lb mmc0
+
+To use the configured bootmeth order for normal automatic boot, set
+``CONFIG_BOOTCOMMAND="bootflow scan -lb"``. Existing saved environments may
+override this default; check ``printenv bootcmd bootmeths boot_targets``.
+Restore the default bootmeth order with ``bootmeth order`` if necessary.
+
+The script is executed from the bootflow's allocated buffer, so ``scriptaddr``
+is not required. Before execution, the method sets ``devtype``, ``devnum`` and
+``distro_bootpart`` as described in :doc:`script`, with an empty ``prefix``.
+The script itself is responsible for selecting and booting an A/B slot.
+
+The compatible string is ``u-boot,script-raw``. On boards which explicitly
+declare bootmeth devices in their device tree, add a child node with this
+compatible under the ``bootstd`` node. Otherwise standard boot automatically
+binds the enabled bootmeth drivers.
diff --git a/doc/device-tree-bindings/bootmeth.txt b/doc/device-tree-bindings/bootmeth.txt
index 127b09cd1b2..6886842b8f3 100644
--- a/doc/device-tree-bindings/bootmeth.txt
+++ b/doc/device-tree-bindings/bootmeth.txt
@@ -11,6 +11,7 @@ compatible:
    "u-boot,extlinux-pxe" - distro boot from a network device
    "u-boot,distro-efi" - EFI boot from an .efi file
    "u-boot,efi-bootmgr" - EFI boot using boot manager (bootmgr)
+   "u-boot,script-raw" - script boot from a named raw partition
 
 
 Example:
diff --git a/include/bootmeth.h b/include/bootmeth.h
index 2a492dfd73a..e1f40b6fb24 100644
--- a/include/bootmeth.h
+++ b/include/bootmeth.h
@@ -425,4 +425,16 @@ int bootmeth_common_read_file(struct udevice *dev, struct bootflow *bflow,
  */
 int bootmeth_get_bootflow(struct udevice *dev, struct bootflow *bflow);
 
+/**
+ * bootmeth_script_boot() - Execute a script bootflow
+ *
+ * Set the device and partition environment variables and execute the script
+ * stored in the bootflow buffer.
+ *
+ * @dev: Bootmeth device
+ * @bflow: Bootflow containing the script image
+ * Return: 0 on success, or a negative error code
+ */
+int bootmeth_script_boot(struct udevice *dev, struct bootflow *bflow);
+
 #endif
diff --git a/test/py/tests/test_bootmeth_script_raw.py b/test/py/tests/test_bootmeth_script_raw.py
new file mode 100644
index 00000000000..36c97bb5e06
--- /dev/null
+++ b/test/py/tests/test_bootmeth_script_raw.py
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright 2026 He Yong <hyyoxhk@163.com>
+
+"""Test script images stored directly in a GPT partition."""
+
+import os
+import struct
+import zlib
+
+import pytest
+import utils
+
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('bootmeth_script_raw')
+@pytest.mark.buildconfigspec('legacy_image_format')
+@pytest.mark.buildconfigspec('fit')
+@pytest.mark.buildconfigspec('cmd_host')
+@pytest.mark.buildconfigspec('cmd_bind')
+@pytest.mark.buildconfigspec('cmd_bootflow')
+@pytest.mark.parametrize('case', [
+    'legacy', 'fit', 'external', 'bad_crc', 'no_terminator', 'too_large',
+    'wrong_name', 'empty',
+])
+def test_bootmeth_script_raw(ubman, case):
+    """Scan and execute valid images; reject malformed or unrelated images."""
+    ubman.restart_uboot()
+    workdir = ubman.config.result_dir
+    script = os.path.join(workdir, 'raw-script.cmd')
+    image = os.path.join(workdir, 'raw-script.scr')
+    disk = os.path.join(workdir, 'raw-script.img')
+    mkimage = os.path.join(ubman.config.build_dir, 'tools', 'mkimage')
+    with open(script, 'w', encoding='utf-8') as outf:
+        outf.write('echo raw-script-ok ${devtype} ${devnum} '
+                   '${distro_bootpart}\n')
+    if case in ('fit', 'external'):
+        its = os.path.join(workdir, 'raw-script.its')
+        with open(its, 'w', encoding='utf-8') as outf:
+            outf.write('''/dts-v1/;
+/ {
+    description = "Raw script test";
+    #address-cells = <1>;
+    images {
+        script {
+            description = "Boot script";
+            data = /incbin/("raw-script.cmd");
+            type = "script";
+            arch = "sandbox";
+            compression = "none";
+            hash { algo = "sha256"; };
+        };
+    };
+};
+''')
+        args = [mkimage, '-f', its]
+        if case == 'external':
+            args.append('-E')
+        utils.run_and_log(ubman, args + [image])
+    else:
+        utils.run_and_log(ubman, [mkimage, '-A', 'sandbox', '-T', 'script',
+                                  '-C', 'none', '-d', script, image])
+    with open(image, 'rb') as inf:
+        data = bytearray(inf.read())
+    if case == 'bad_crc':
+        data[-1] ^= 1
+    elif case == 'no_terminator':
+        data[64:] = b'\xff' * (len(data) - 64)
+    elif case == 'too_large':
+        struct.pack_into('>I', data, 12, 2 * 1024 * 1024)
+    elif case == 'empty':
+        data = bytearray(512)
+    if case in ('no_terminator', 'too_large'):
+        if case == 'no_terminator':
+            struct.pack_into('>I', data, 24, zlib.crc32(data[64:]))
+        struct.pack_into('>I', data, 4, 0)
+        struct.pack_into('>I', data, 4, zlib.crc32(data[:64]))
+    with open(disk, 'wb') as outf:
+        outf.truncate(4 * 1024 * 1024)
+    label = 'other' if case == 'wrong_name' else 'uboot_scr'
+    utils.run_and_log(ubman, ['sgdisk', '-n', '1:2048:4095',
+                              '-c', f'1:{label}', disk])
+    with open(disk, 'r+b') as outf:
+        outf.seek(1024 * 1024)
+        outf.write(data)
+    try:
+        ubman.run_command(f'host bind 0 {disk}')
+        ubman.run_command('bind bootstd 0 bootmeth_script_raw')
+        ubman.run_command('bootmeth order bootmeth_script_raw')
+        ubman.run_command('setenv verify yes')
+        output = ubman.run_command('bootflow scan -lb host0')
+        if case in ('legacy', 'fit'):
+            assert 'raw-script-ok host 0 1' in output
+        else:
+            assert 'raw-script-ok' not in output
+            assert 'No more bootdevs' in output
+    finally:
+        ubman.restart_uboot()
-- 
2.43.0

