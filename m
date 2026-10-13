Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88985CA9ED2
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 13:03:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 472E9605F4;
	Tue, 13 Oct 2026 13:03:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7SIigJ_FXaKI; Tue, 13 Oct 2026 13:03:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 118EF6060C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791896594;
	b=VVeZdxbDgg+dkpPzX/I6mBEbhrmKxYAm6F6/DuyBWKTThbxuhmTW8CFiNUPz2sQk7KqW
	 GN+wl7lHLpJTk+teTK0iBHwTDWN1HM7CUZ2cG5FasAZmyXelJCcmzFnXNsEWPsswNCJVe
	 CCiWO6xWrqtQQvw8UgI0ZEdXSVmYHV4T3hDjh+ctfPbvfXHF1mR1/urz2czS/ZHN9xBgR
	 /mDqwrAWWVn8IUBYV8re6nym8x0rKMnU70HeA94gC70D5IeuQHPGN2SSBAJYvV99HPzGM
	 9S3fEpXQk5f2ZaPLrRTD+ZHk+eZ7jWCjcbU5+pAFXnGNJAc0+bWmneXbMxDvnHi69HQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791896594;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JgxL7cX4+xhmMBFt08gnD8oHnrsEb86WTliRJ9YX3TI=;
	b=qTZaiEcKRFAZP1IjcGqPu0cw7gpEcw9/dRRkiwzBiiD0BQdH5bXM0zmdqEnOvqWaLNfV
	 TZxVscVCNTgRoHcSpYljxzpIyXN5drx99pSOWTWIFvoSQQ0/TPYc93TEDxFt1sjqcIXDf
	 0V87r4Q4Z3iLo0LbLpQD6QlrmCR6cYcA96tMJvkiSUtBrj7eP4Ehh83ms6X8rIp/cIkOQ
	 yCOZZsY1qanh0i4Tb4MexjBRlUqnjxm+seTUHeLm+b2glwl1V0kUhHJb/Vi05XjqNl/lx
	 EonYXewYL0ZiF+JSwsOsfbMcZtRXke0bn8Er8aVweFb896V7gHFdFD1opc7dH7wBAPw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791896594;
	bh=JgxL7cX4+xhmMBFt08gnD8oHnrsEb86WTliRJ9YX3TI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RWo5c6ikkIHK5i2bN3HRhlpJ1pJDWXbhYx/BMycroGQuVhpbq+1Ag0FpQwWPHOGdh
	 ELJ0C86eKTGmVG153vodX0BDc+rfo0DOdzhPOf0d92ix7giED75SB2SrWr5k6lTyT5
	 lRHQM0JxGmdwv2SLBiX4kkIYYK+cYy0IMMqvhx/1RY5SNmpNsQRdc4PbNPUyG4JH/W
	 ILQV+IdMaPcSlXr1vlbomvNlIc4lpxlvma0nmUhyoTscRrA3CG6PVVYsceyEgp0iw/
	 wttUQZjsvk7EvcGVflAwyBFziuE9GIHx0q5JlSQitLQL1FzoBIGCrTMbbW5v+Hv+69
	 FGA/qE6n/disQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 118EF6060C;
	Tue, 13 Oct 2026 13:03:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E44F0788
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 13:03:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CA14D8083F
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 13:03:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Te1Af8bSxz8v for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 13:03:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 05DF880849
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791896589;
 b=To+Y3ZbYpGgbFkn8igmUrPUpoKvdhmkUdFeYx8bmSiHb97cNQwqpsmA6WETxFNvXRg35
 A2udqLT7TgENtv7s5e6ICeTD7DFiTcZ//RXgCbJPgVHLDcfm1gUYkbfVIbpOF7S5hs3Nw
 AU6ey3w4k8tYOTtp9uKYpsUX3lY+vs4BE6KNUGbDtKcSIMSr38NdTygxNLJ8natK70P6k
 pBMguWXaKhUcFXUq40i9dAUMrktAmOzQMERqisKnwyJamo0casyoDefX+01iJR0BONSAz
 7OGxAjuqv+hGI8TWTLB+AV0F2OTtCxl68mSlivoRnpES4AJ6aQBwvMW6mq4hUyenIZw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791896589;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
 X-Originating-IP:X-CM-SenderInfo;
 bh=JgxL7cX4+xhmMBFt08gnD8oHnrsEb86WTliRJ9YX3TI=;
 b=jtdNdiUAws3IKaoqnR/gQ1uxsTBDEo7ARgv2te3oIneyC4dn8ovpNbPzvcCcJ/YaJ5/t
 HzGlAt0tUnTBX84LXyDi3NZGmiijGgCXUkue3r6fHcnzSbrBpCHDQomkhKHnDBwbsVnul
 vkhPBUnJeJZpiTghZWLFLCigp+VJMYDMfsKCgtaxWxC+Erhh8TWAaNCRgkzyay6/iniR1
 FSW7MKjrbHTZ43iQkOOx5EnUnbW6+ll7VB20tOaZZxrkCKFbG9FUtJ+OFnqgPMQtRVJxy
 dsb9cqoo9ajOIsuR3MzhLMzgpd9bDlvQ2sG/EAtTx1fhA+Sgf9M2kKnlv0Gf/zhaMqg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=163.com;
 dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=B9m2K26d; 
 arc=none smtp.remote-ip=117.135.210.3
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=117.135.210.3;
 helo=m16.mail.163.com; envelope-from=hyyoxhk@163.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=B9m2K26d
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 05DF880849
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 13:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Jg
 xL7cX4+xhmMBFt08gnD8oHnrsEb86WTliRJ9YX3TI=; b=B9m2K26dyKDVO1yvBw
 cj0CXGVT2fgUd7AKuDfT29Q++UEBrcSCvyfcTrn7NnVMn/KACoolIWATroXAdikV
 3u6AAdVl06wYK/g2nCxaZ9PTDa9HSb+iwuFLSePzF/UNXEwUvo0P4pB0dsbcVunK
 R/ndhh+IETIjZVRsR/xKytFhY=
Received: from nh50.. (unknown [])
 by gzsmtp5 (Coremail) with SMTP id QCgvCgDnT4brK85qiFBwEQ--.17862S4;
 Tue, 13 Oct 2026 21:02:36 +0800 (CST)
From: He Yong <hyyoxhk@163.com>
To: u-boot@lists.u-boot-project.org
Cc: sjg@chromium.org, trini@konsulko.com, alchark@flipper.net,
 daniel@makrotopia.org, jbx6244@gmail.com, quentin.schulz@cherry.de
Subject: [PATCH v2 2/2] bootstd: Add a bootmeth for scripts in raw partitions
Date: Tue, 13 Oct 2026 21:02:35 +0800
Message-ID: <20261013130235.3172204-3-hyyoxhk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013130235.3172204-1-hyyoxhk@163.com>
References: <20261013130235.3172204-1-hyyoxhk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: QCgvCgDnT4brK85qiFBwEQ--.17862S4
X-Coremail-Antispam: 1Uf129KBjvAXoWfZF4rGw4fWw17Jw45Xr13Jwb_yoW5WF18to
 Z3KFsI9wn5Kr47ZFZ8WFnrGF4Y9F40grnxXrW5trn8X3WrAw1Skr1293W5XF18ArySgryr
 Xa47K3Z3Xr42qa95n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU3zVbUUUUU
X-Originating-IP: [2409:8a62:2b4:2720:a989:5f4f:c438:1387]
X-CM-SenderInfo: pk1105lkn6il2tof0z/xtbC8Q1UJ2rOK+1rKAAA3u
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
partition, without a filesystem. Add a script_raw bootmeth to find these
images without a board-specific bootcmd.

Read the image size from the first block and bound it by the partition
size and configured limit. Support legacy scripts and FIT scripts with
embedded data, using the shared script parser and execution handler.
Validate the FIT structure and reject external data before verification.

Keep raw-partition scanning independently selectable from filesystem
script lookup. Document the configuration and self-contained FIT policy.
Enable the method for sandbox and test it in C, using a generated GPT disk
with valid images and malformed or unsupported images.

Signed-off-by: He Yong <hyyoxhk@163.com>
---
 MAINTAINERS                           |   1 +
 arch/sandbox/dts/test.dts             |  12 ++
 boot/Kconfig                          |  26 ++++
 boot/Makefile                         |   1 +
 boot/bootmeth_script.c                |   4 +-
 boot/bootmeth_script_raw.c            | 183 ++++++++++++++++++++++++++
 configs/sandbox_defconfig             |   1 +
 doc/develop/bootstd/index.rst         |   1 +
 doc/develop/bootstd/script_raw.rst    |  51 +++++++
 doc/device-tree-bindings/bootmeth.txt |   1 +
 include/bootmeth.h                    |  12 ++
 test/boot/bootflow.c                  |  84 +++++++++++-
 test/boot/bootmeth.c                  |  31 ++++-
 test/py/img/__init__.py               |   2 +
 test/py/img/script_raw.py             | 107 +++++++++++++++
 test/py/tests/test_ut.py              |   9 ++
 16 files changed, 518 insertions(+), 8 deletions(-)
 create mode 100644 boot/bootmeth_script_raw.c
 create mode 100644 doc/develop/bootstd/script_raw.rst
 create mode 100644 test/py/img/__init__.py
 create mode 100644 test/py/img/script_raw.py

diff --git a/MAINTAINERS b/MAINTAINERS
index d1f51d9197d..6870298ee0f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -846,6 +846,7 @@ F:	include/bootflow.h
 F:	include/bootmeth.h
 F:	include/bootstd.h
 F:	test/boot/
+F:	test/py/img/script_raw.py
 
 BOOTMETH_ANDROID
 M:	Mattijs Korpershoek <mkorpershoek@kernel.org>
diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 25c99ef8147..f308c0768e2 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -50,6 +50,7 @@
 		mmc9 = "/mmc9";
 		mmc10 = "/mmc10";
 		mmc11 = "/mmc11";
+		mmc12 = "/mmc12";
 		pci0 = &pci0;
 		pci1 = &pci1;
 		pci2 = &pci2;
@@ -187,6 +188,10 @@
 			version-offset = <0xdffe00>;
 			version-size = <0x100>;
 		};
+
+		script_raw {
+			compatible = "u-boot,script-raw";
+		};
 	};
 
 	cedit: cedit {
@@ -1398,6 +1403,13 @@
 		filename = "mmc11.img";
 	};
 
+	/* This is used for raw script bootflow tests */
+	mmc12 {
+		status = "disabled";
+		compatible = "sandbox,mmc";
+		filename = "mmc12.img";
+	};
+
 	pch {
 		compatible = "sandbox,pch";
 	};
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
index 00000000000..2f017fbe1bd
--- /dev/null
+++ b/boot/bootmeth_script_raw.c
@@ -0,0 +1,183 @@
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
+	uint len;
+	char *data;
+	int images, node, ret;
+
+	if (IS_ENABLED(CONFIG_FIT) &&
+	    genimg_get_format(buf) == IMAGE_FORMAT_FIT) {
+		ret = fdt_check_full(buf, size);
+		if (ret)
+			return log_msg_ret("fit", -EINVAL);
+		images = fdt_path_offset(buf, FIT_IMAGES_PATH);
+		if (images < 0)
+			return log_msg_ret("images", -EINVAL);
+		fdt_for_each_subnode(node, buf, images) {
+			/* Do not follow external data offsets during verification. */
+			if (fdt_getprop(buf, node, FIT_DATA_OFFSET_PROP, NULL) ||
+			    fdt_getprop(buf, node, FIT_DATA_POSITION_PROP, NULL))
+				return log_msg_ret("external", -EOPNOTSUPP);
+		}
+	}
+
+	ret = image_locate_script(buf, size, NULL, NULL, &data, &len);
+	return ret ? log_msg_ret("script", -EINVAL) : 0;
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
+		return log_msg_ret("part", -ENOENT);
+	desc = dev_get_uclass_plat(bflow->blk);
+	ret = part_get_info(desc, bflow->part, &info);
+	if (ret)
+		return log_msg_ret("part", ret);
+	if (strcmp(info.name, CONFIG_BOOTMETH_SCRIPT_RAW_PARTITION))
+		return log_msg_ret("name", -ENOENT);
+	bflow->state = BOOTFLOWST_PART;
+
+	if (!info.size || desc->blksz < sizeof(*hdr) ||
+	    desc->blksz > CONFIG_BOOTMETH_SCRIPT_RAW_MAX_SIZE)
+		return log_msg_ret("block", -EINVAL);
+	buf = memalign(ARCH_DMA_MINALIGN, desc->blksz);
+	if (!buf)
+		return log_msg_ret("buf", -ENOMEM);
+	if (blk_dread(desc, info.start, 1, buf) != 1) {
+		ret = log_msg_ret("header-read", -EIO);
+		goto out;
+	}
+
+	hdr = buf;
+	if (IS_ENABLED(CONFIG_LEGACY_IMAGE_FORMAT) &&
+	    genimg_get_format(buf) == IMAGE_FORMAT_LEGACY) {
+		if (!image_check_hcrc(hdr) ||
+		    !image_check_type(hdr, IH_TYPE_SCRIPT)) {
+			ret = log_msg_ret("header", -EINVAL);
+			goto out;
+		}
+		size = image_get_data_size(hdr);
+		if (size > CONFIG_BOOTMETH_SCRIPT_RAW_MAX_SIZE - sizeof(*hdr)) {
+			ret = log_msg_ret("legacy-size", -E2BIG);
+			goto out;
+		}
+		size += sizeof(*hdr);
+	} else if (IS_ENABLED(CONFIG_FIT) && !fdt_check_header(buf)) {
+		size = fdt_totalsize(buf);
+		if (size < sizeof(struct fdt_header)) {
+			ret = log_msg_ret("fit-size", -EINVAL);
+			goto out;
+		}
+	} else {
+		ret = log_msg_ret("format", -ENOEXEC);
+		goto out;
+	}
+	if (size > CONFIG_BOOTMETH_SCRIPT_RAW_MAX_SIZE) {
+		ret = log_msg_ret("size", -E2BIG);
+		goto out;
+	}
+	count = DIV_ROUND_UP(size, desc->blksz);
+	if (count > info.size) {
+		ret = log_msg_ret("partition-size", -E2BIG);
+		goto out;
+	}
+	free(buf);
+	buf = memalign(ARCH_DMA_MINALIGN, count * desc->blksz + 1);
+	if (!buf)
+		return log_msg_ret("buf", -ENOMEM);
+	if (blk_dread(desc, info.start, count, buf) != count) {
+		ret = log_msg_ret("image-read", -EIO);
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
+		ret = log_msg_ret("name-alloc", -ENOMEM);
+		goto out;
+	}
+	if (!bootflow_img_add(bflow, bflow->fname, (enum bootflow_img_t)IH_TYPE_SCRIPT,
+			      map_to_sysmem(buf), size)) {
+		ret = log_msg_ret("image-alloc", -ENOMEM);
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
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index a2708e6fb33..09b2980f79b 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -28,6 +28,7 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_BOOTMETH_ANDROID=y
 CONFIG_BOOTMETH_BLS=y
 CONFIG_BOOTMETH_RAUC=y
+CONFIG_BOOTMETH_SCRIPT_RAW=y
 CONFIG_UPL=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_MEASURED_BOOT=y
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
index 00000000000..29a63c0ceb7
--- /dev/null
+++ b/doc/develop/bootstd/script_raw.rst
@@ -0,0 +1,51 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Raw Script Bootmeth
+===================
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
+not supported: script FITs are small and must be self-contained so that all
+metadata and script data can be validated within the loaded partition image.
+
+Plain text scripts must first be wrapped with ``mkimage``, for example::
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
+A separate bootmeth keeps raw-partition scanning independent of the existing
+filesystem script lookup and allows either method to be selected in the bootmeth
+order. Both methods share the script execution handler and verification policy.
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
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index c4b41668a62..456b581ae27 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -221,7 +221,10 @@ static int bootflow_cmd_scan_e(struct unit_test_state *uts)
 {
 	ut_assertok(bootstd_test_drop_bootdev_order(uts));
 
-	ut_assertok(run_command("bootflow scan -aleGH", 0));
+	/* Exercise the filesystem methods without global-method scanning. */
+	ut_assertok(bootmeth_set_order(IS_ENABLED(CONFIG_BOOTMETH_BLS) ?
+		"extlinux efi bls" : "extlinux efi"));
+	ut_assertok(run_command("bootflow scan -aleH", 0));
 	ut_assert_nextline("Scanning for bootflows in all bootdevs");
 	ut_assert_nextline("Seq  Method       State   Uclass    Part  Name                      Filename");
 	ut_assert_nextlinen("---");
@@ -368,6 +371,16 @@ static int bootflow_iter(struct unit_test_state *uts)
 	struct bootflow_iter iter;
 	struct bootflow bflow;
 
+	/* Keep default ordering to exercise runtime global-method filtering. */
+	ut_assertok(bootmeth_set_order(NULL));
+	if (IS_ENABLED(CONFIG_BOOTMETH_SCRIPT_RAW)) {
+		struct udevice *dev;
+
+		ut_assertok(uclass_get_device_by_name(UCLASS_BOOTMETH,
+						      "script_raw", &dev));
+		ut_assertok(device_remove(dev, DM_REMOVE_NORMAL));
+		ut_assertok(device_unbind(dev));
+	}
 	bootstd_clear_glob();
 
 	/* The first device is mmc2.bootdev which has no media */
@@ -516,6 +529,12 @@ static int bootflow_iter_glob(struct unit_test_state *uts)
 	struct bootflow_iter iter;
 	struct bootflow bflow;
 
+	/* Keep the filesystem-method ordering exercised by this test. */
+	ut_assertok(bootmeth_set_order(IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) ?
+		(IS_ENABLED(CONFIG_BOOTMETH_BLS) ? "extlinux efi bls firmware0" :
+		 "extlinux efi firmware0") :
+		(IS_ENABLED(CONFIG_BOOTMETH_BLS) ? "extlinux efi bls" :
+		 "extlinux efi")));
 	bootstd_clear_glob();
 
 	/* we should get the global bootmeth initially */
@@ -597,6 +616,14 @@ static int bootflow_iter_disable(struct unit_test_state *uts)
 	ut_assertok(device_bind_driver(bootstd, "bootmeth_sandbox", "sandbox",
 				       &dev));
 
+	/* Include the newly bound sandbox method first, as the test expects. */
+	ut_assertok(bootmeth_set_order(IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) ?
+		(IS_ENABLED(CONFIG_BOOTMETH_BLS) ?
+		 "sandbox extlinux efi bls firmware0" :
+		 "sandbox extlinux efi firmware0") :
+		(IS_ENABLED(CONFIG_BOOTMETH_BLS) ? "sandbox extlinux efi bls" :
+		 "sandbox extlinux efi")));
+
 	ut_assertok(bootstd_test_drop_bootdev_order(uts));
 
 	bootstd_clear_glob();
@@ -1908,4 +1935,57 @@ static int bootdev_hunt_fallthrough(struct unit_test_state *uts)
 }
 BOOTSTD_TEST(bootdev_hunt_fallthrough,
              UTF_DM | UTF_SCAN_FDT | UTF_SF_BOOTDEV | UTF_CONSOLE);
-#endif /* CONFIG_SANDBOX */
+
+/* Exercise valid and rejected images without restarting U-Boot per case. */
+static int bootflow_script_raw(struct unit_test_state *uts)
+{
+	static const int errors[] = {
+		0, 0, -EOPNOTSUPP, -EINVAL, -EINVAL, -E2BIG,
+		-ENOENT, -ENOEXEC, -EINVAL, -E2BIG, -EINVAL, -EINVAL,
+	};
+	struct bootflow_iter iter;
+	struct bootflow bflow;
+	struct bootstd_priv *std;
+	const char *order[2] = {"mmc12", NULL};
+	const char **old_order;
+	int ret, part;
+
+	if (!IS_ENABLED(CONFIG_BOOTMETH_SCRIPT_RAW))
+		return -EAGAIN;
+
+	ut_assertok(prep_mmc_bootdev(uts, "mmc12", false, &old_order));
+	ut_assertok(bootstd_get_priv(&std));
+	std->bootdev_order = order;
+	ut_assertok(bootmeth_set_order("script_raw"));
+	ut_assertok(env_set("verify", "yes"));
+	ret = bootflow_scan_first(NULL, NULL, &iter, BOOTFLOWIF_ALL, &bflow);
+	/* A raw script belongs to a partition, never to the whole disk. */
+	ut_asserteq(-ENOENT, ret);
+	ut_asserteq(0, bflow.part);
+	bootflow_free(&bflow);
+	for (part = 1; part <= ARRAY_SIZE(errors); part++) {
+		ret = bootflow_scan_next(&iter, &bflow);
+		ut_asserteq(part, bflow.part);
+		ut_asserteq(errors[part - 1], ret);
+		if (!ret) {
+			ut_asserteq(BOOTFLOWST_READY, bflow.state);
+			ut_asserteq_str("uboot_scr", bflow.fname);
+			/* A script returning successfully did not boot an OS. */
+			ut_asserteq(-EFAULT, bootflow_run_boot(&iter, &bflow));
+			ut_assert_skip_to_line("%sraw-script-ok mmc c %d",
+					       part == 2 ? "sha256+ " : "", part);
+			ut_asserteq_str("mmc", env_get("devtype"));
+		} else {
+			ut_assert(bflow.state < BOOTFLOWST_READY);
+			ut_assertnull(bflow.buf);
+		}
+		bootflow_free(&bflow);
+	}
+	bootflow_iter_uninit(&iter);
+	std->bootdev_order = old_order;
+
+	return 0;
+}
+
+BOOTSTD_TEST(bootflow_script_raw, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
+#endif
diff --git a/test/boot/bootmeth.c b/test/boot/bootmeth.c
index 8400a2e7879..6fffa508103 100644
--- a/test/boot/bootmeth.c
+++ b/test/boot/bootmeth.c
@@ -26,10 +26,18 @@ static int bootmeth_cmd_list(struct unit_test_state *uts)
 	if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL))
 		ut_assert_nextline(" glob    %d  firmware0           VBE simple",
 				   2 + IS_ENABLED(CONFIG_BOOTMETH_BLS));
+	if (IS_ENABLED(CONFIG_BOOTMETH_SCRIPT_RAW))
+		ut_assert_nextline("    %d    %d  script_raw          %s",
+				   2 + IS_ENABLED(CONFIG_BOOTMETH_BLS)
+				     + IS_ENABLED(CONFIG_BOOTMETH_GLOBAL),
+				   2 + IS_ENABLED(CONFIG_BOOTMETH_BLS)
+				     + IS_ENABLED(CONFIG_BOOTMETH_GLOBAL),
+				   "Script boot from a raw partition");
 	ut_assert_nextlinen("---");
 	ut_assert_nextline("(%d bootmeths)",
 			   2 + IS_ENABLED(CONFIG_BOOTMETH_BLS)
-			     + IS_ENABLED(CONFIG_BOOTMETH_GLOBAL));
+			     + IS_ENABLED(CONFIG_BOOTMETH_GLOBAL)
+			     + IS_ENABLED(CONFIG_BOOTMETH_SCRIPT_RAW));
 	ut_assert_console_end();
 
 	return 0;
@@ -65,10 +73,17 @@ static int bootmeth_cmd_order(struct unit_test_state *uts)
 	if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL))
 		ut_assert_nextline(" glob    %d  firmware0           VBE simple",
 				   2 + IS_ENABLED(CONFIG_BOOTMETH_BLS));
+	if (IS_ENABLED(CONFIG_BOOTMETH_SCRIPT_RAW))
+		ut_assert_nextline("    %s    %d  script_raw          %s",
+				   "-",
+				   2 + IS_ENABLED(CONFIG_BOOTMETH_BLS)
+				     + IS_ENABLED(CONFIG_BOOTMETH_GLOBAL),
+				   "Script boot from a raw partition");
 	ut_assert_nextlinen("---");
 	ut_assert_nextline("(%d bootmeths)",
 			   2 + IS_ENABLED(CONFIG_BOOTMETH_BLS)
-			     + IS_ENABLED(CONFIG_BOOTMETH_GLOBAL));
+			     + IS_ENABLED(CONFIG_BOOTMETH_GLOBAL)
+			     + IS_ENABLED(CONFIG_BOOTMETH_SCRIPT_RAW));
 	ut_assert_console_end();
 
 	/* Check the -a flag with the reverse order */
@@ -84,10 +99,17 @@ static int bootmeth_cmd_order(struct unit_test_state *uts)
 	if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL))
 		ut_assert_nextline(" glob    %d  firmware0           VBE simple",
 				   2 + IS_ENABLED(CONFIG_BOOTMETH_BLS));
+	if (IS_ENABLED(CONFIG_BOOTMETH_SCRIPT_RAW))
+		ut_assert_nextline("    %s    %d  script_raw          %s",
+				   "-",
+				   2 + IS_ENABLED(CONFIG_BOOTMETH_BLS)
+				     + IS_ENABLED(CONFIG_BOOTMETH_GLOBAL),
+				   "Script boot from a raw partition");
 	ut_assert_nextlinen("---");
 	ut_assert_nextline("(%d bootmeths)",
 			   2 + IS_ENABLED(CONFIG_BOOTMETH_BLS)
-			     + IS_ENABLED(CONFIG_BOOTMETH_GLOBAL));
+			     + IS_ENABLED(CONFIG_BOOTMETH_GLOBAL)
+			     + IS_ENABLED(CONFIG_BOOTMETH_SCRIPT_RAW));
 	ut_assert_console_end();
 
 	/* Now reset the order to empty, which should show all of them again */
@@ -97,7 +119,8 @@ static int bootmeth_cmd_order(struct unit_test_state *uts)
 	ut_assertok(run_command("bootmeth list", 0));
 	ut_assert_skip_to_line("(%d bootmeths)",
 			       2 + IS_ENABLED(CONFIG_BOOTMETH_BLS)
-				 + IS_ENABLED(CONFIG_BOOTMETH_GLOBAL));
+				 + IS_ENABLED(CONFIG_BOOTMETH_GLOBAL)
+			     + IS_ENABLED(CONFIG_BOOTMETH_SCRIPT_RAW));
 
 	/* Try reverse order */
 	ut_assertok(run_command("bootmeth order \"efi extlinux\"", 0));
diff --git a/test/py/img/__init__.py b/test/py/img/__init__.py
new file mode 100644
index 00000000000..526c5dda958
--- /dev/null
+++ b/test/py/img/__init__.py
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0+
+"""Disk-image generators for U-Boot C tests."""
diff --git a/test/py/img/script_raw.py b/test/py/img/script_raw.py
new file mode 100644
index 00000000000..dc459a24e4e
--- /dev/null
+++ b/test/py/img/script_raw.py
@@ -0,0 +1,107 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright 2026 He Yong <hyyoxhk@163.com>
+
+"""Create a GPT disk containing valid and malformed raw script images."""
+
+import os
+import struct
+import zlib
+
+import utils
+
+
+CASES = ('legacy', 'fit', 'external', 'bad_crc', 'no_terminator',
+         'too_large', 'wrong_name', 'empty', 'bad_header', 'partition_size',
+         'script_length', 'bad_fit')
+
+
+def script_image(ubman, case):
+    """Build one script image, optionally corrupting its header or data."""
+    workdir = ubman.config.build_dir
+    script = os.path.join(workdir, 'raw-script.cmd')
+    image = os.path.join(workdir, 'raw-script.scr')
+    mkimage = os.path.join(ubman.config.build_dir, 'tools', 'mkimage')
+    with open(script, 'w', encoding='utf-8') as outf:
+        outf.write('echo raw-script-ok ${devtype} ${devnum} '
+                   '${distro_bootpart}\n')
+    if case in ('fit', 'external', 'bad_fit'):
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
+    configurations {
+        default = "conf";
+        conf {
+            script = "script";
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
+    return data
+
+
+def setup_script_raw_image(ubman):
+    """Create one disk for all cases, with 512 KiB non-bootable partitions."""
+    disk = os.path.join(ubman.config.source_dir, 'mmc12.img')
+    with open(disk, 'wb') as outf:
+        outf.truncate(16 * 1024 * 1024)
+    args = ['sgdisk', '--clear']
+    for part, case in enumerate(CASES, 1):
+        start = part * 2048
+        label = 'other' if case == 'wrong_name' else 'uboot_scr'
+        args += ['-n', f'{part}:{start}:{start + 1023}',
+                 '-c', f'{part}:{label}']
+    utils.run_and_log(ubman, args + [disk])
+    with open(disk, 'r+b') as outf:
+        for part, case in enumerate(CASES, 1):
+            data = script_image(ubman, case)
+            if case == 'bad_header':
+                data[4] ^= 1
+            elif case == 'partition_size':
+                struct.pack_into('>I', data, 12, 512 * 1024)
+            elif case == 'script_length':
+                struct.pack_into('>I', data, 64, len(data))
+                struct.pack_into('>I', data, 24, zlib.crc32(data[64:]))
+            elif case == 'bad_fit':
+                # Keep the header valid but corrupt the structure block.
+                offset = struct.unpack_from('>I', data, 8)[0]
+                struct.pack_into('>I', data, offset, 0xffffffff)
+            if case in ('partition_size', 'script_length'):
+                struct.pack_into('>I', data, 4, 0)
+                struct.pack_into('>I', data, 4, zlib.crc32(data[:64]))
+            outf.seek(part * 1024 * 1024)
+            outf.write(data)
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 2a5acc18c61..5723c4864a0 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -16,6 +16,7 @@ import re
 import pytest
 
 import utils
+from img.script_raw import setup_script_raw_image
 # pylint: disable=E0611
 from tests import fs_helper
 from fs_helper import DiskHelper, FsHelper
@@ -760,6 +761,14 @@ def test_ut_dm_init_bootstd(ubman):
     ubman.restart_uboot()
 
 
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('bootmeth_script_raw')
+@pytest.mark.requiredtool('sgdisk')
+def test_ut_dm_init_script_raw(ubman):
+    """Prepare the disk used by the raw script C bootflow test."""
+    setup_script_raw_image(ubman)
+
+
 @pytest.fixture(name="ut_ubman")
 def ut_ubman_fixture(ubman, ut_subtest):
     """Fixture to restart the sandbox after known problematic tests.

