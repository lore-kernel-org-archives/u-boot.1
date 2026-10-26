Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DD2606A31E
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 14:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NhUDk9sS;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=iLLXezEk
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 82722406C3;
	Mon, 26 Oct 2026 14:02:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gp47xwbe6kYR; Mon, 26 Oct 2026 14:02:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3D253406C4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793023370;
	b=eRLgMEDzCVj2nPEHm+iCOp9rUbB7OBvWpb0lHZ+piUI1oTZhR7qCh95dV77MBNWx9NfU
	 o7T9OPJ/fGXqqxX3vjOedIQ2EPpMo+fRNdMQ+TOhB5kscgCO8sfy+Bf5Bip4AjGcXmgR6
	 GuAC4jWaTRexsjxmPIPqqvGAdLYfpbvd81UDwbF51LHNLdropFaXyN/jG9t0dO7koQXOx
	 OMmqqKx/BvRAzQc1vMbNRKh3A8gRMZjxvQjVfj7DVhDMNidRlTpSQ9J803vdvkXM9nm7y
	 Fxc3/1ZnTlHM7iFxxsFAxIEWcpgUcuqzge4XLTHLYEauPvj9a0N7hitAnfLqtbTYBOA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793023370;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Pa7aAMgaR7UnuYGE1QL+v2ibj8lBOnqX1WglfJ4a9D4=;
	b=hxiBtdqqz7XY3jGG4Oz0kgdPGscpZFwknGSa0XnDppy6ZDzSsnXPTs6XZFUpEa5iD/jU
	 mIKYe072/BgDAiYY4VQZt9UA3AvLRv7rLysYXhn7LwWcYV813Yoq00JNhIGymsWuesgNN
	 K3wWADer1aYiresVSL9VGiaYvIe9BLYzd4L0LhPUY24Ms1lWdomsXQsT8xTatjfWErFvm
	 wOcl9RUNPpEJSgu6ucFVpA3kci6SrKmNrrXUrj8MGyoqNXx47FlPD6uJAN/exfwNjXS98
	 JehdQHTMiMq9tI/Cxtqdoub2IdaQVVk8d5YvsMEgrMNZMJsyllzHSojMkuseDr4jSiw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793023370;
	bh=Pa7aAMgaR7UnuYGE1QL+v2ibj8lBOnqX1WglfJ4a9D4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NhUDk9sSS4q578XmHiFb+Wk0mxQixDEPXFv4h++cCO9jXwYOh/5f8RlgxrZQhMMhU
	 u9vWuvhpPCdBwMIsY4plPcuwtFfvAAZqyF5vLe5VMkYqsuyQrg97j4wncaaoDPG5/Q
	 T4QhXh7fYnb5aiymF0mv/3c1HszNBOjy/37wOCoSNZQnhz7OmFO7cYsmCzkFwO3Tr4
	 iYtKwI/VIevupaWRITdWmr/IIhr+M9KdncPkJo/qATxfw8xcCSIPwrQ7LHyZcTdIEW
	 Klm9qXDhnGYxw7A6fMqDIE+MfERCmowtLqgkiY4cTccbuDQ0E6/IDGmPDpm0HDKyDW
	 0wkjt1FA9bcjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D253406C4;
	Mon, 26 Oct 2026 14:02:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0AC303B6
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:02:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E248A80E4E
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:02:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4jU_TlbAaUab for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 14:02:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3F7CB80E51
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793023365;
 b=AAFlsWnalkus7ln9QHgzw0dP+9W8jFCwe8oarIG/P3EUhKYjO1P7n7kTarn+9XqU+t48
 5e67OEoQbgLf1mbXa1WptWQ8EYEVlBzSnUa72lA7J40atzDHmObaM35yIwoA6ZPH8EKOu
 9CvNpADC5zJBhMxv0Rd0KMkiSTD0j5nGxJnLW45YFOPi/WcWGb3iXp5Kd0ijv0YaFNphj
 bGWt0gvYDpxA5pdtxqI3GCw1K4NgZJQmrM7vLoO5krmgzIvLT98vrrZoE/kUTVIO3+Z8C
 IHWzcj5obpEOXhQ2mzseqLkFyIh+6uuCkQ4Jrr0t8INCNE0qefW084ccUVbUMXj8QuA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793023365;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
 X-CM-SenderInfo;
 bh=Pa7aAMgaR7UnuYGE1QL+v2ibj8lBOnqX1WglfJ4a9D4=;
 b=dVL7GZ60fJPxWzaimgcNuo36ujmZZR0o0pl/Ig4wbIYDaRaQr8ymsGcF3w6uF6sqlUE1
 YDldolNbhBQbNrKD6fIdjQvhu49gLk0HbZSY14Smix4wBNEZnGYLzcb9LqUKcrK+enSYu
 Cs5d2rRMWcWljauM7by5n6b+PreV+M1YGbf2NU1Q919VI4J7pX+ku0bXZYy8QC1lYB7mB
 f5baeNTyPE0s38ng7hTZetNg9n8RMpSndcFcXVebV631SZsS+ks7QWieczlFvjgwZtdKl
 8rbj+alPn7ae3JFd3FlklcKnm1t0vYt/VZ8TBYg9rgoXSvCD9DJo2IlWCDPaZxh/4hw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=163.com;
 dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=iLLXezEk; 
 arc=none smtp.remote-ip=220.197.31.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.4;
 helo=m16.mail.163.com; envelope-from=hyyoxhk@163.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=163.com header.i=@163.com
 header.a=rsa-sha256 header.s=s110527 header.b=iLLXezEk
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3F7CB80E51
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Pa
 7aAMgaR7UnuYGE1QL+v2ibj8lBOnqX1WglfJ4a9D4=; b=iLLXezEkYOoaXwxvNc
 tiwCwASQnIFCaD3ufqHy89AohPjPcqpDy+yZIVSJu4Xqwc3Xh7n7BEv5BNUmi/S/
 MKGfdAlYGWX2jS4j3+npCodSpP9lU9g/7ejOa/KEKdWFebWLpLk0L+Hog7St/TRE
 HJtDwfuIRFuDI7212FlcvI5ik=
Received: from nh50.. (unknown [])
 by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id
 _____wD3N95qXd9qrufGCw--.5946S5; 
 Mon, 26 Oct 2026 22:02:20 +0800 (CST)
From: He Yong <hyyoxhk@163.com>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 3/4] bootstd: Add a bootmeth for scripts in raw partitions
Date: Mon, 26 Oct 2026 22:02:17 +0800
Message-ID: <7292117110e4b5dee555f33c98140e529b865c64.1793020986.git.hyyoxhk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793020986.git.hyyoxhk@163.com>
References: <cover.1793020986.git.hyyoxhk@163.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3N95qXd9qrufGCw--.5946S5
X-Coremail-Antispam: 1Uf129KBjvJXoW3tw17Ww1xWFWfKF4fuF15Jwb_yoWkAFWkpa
 1kAa45Jr1kJF13uryfA3WxCF95Cr4kJa45uFykZ345Ar17KrZ2qr1ayryYyF4xZFZYyrWY
 vF4kAa4DGrn8u3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jD0edUUUUU=
X-CM-SenderInfo: pk1105lkn6il2tof0z/xtbC8QwF12rfXWxeWwAA3u
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Some disk layouts store a U-Boot script image directly in a named
partition, without a filesystem. Add a script_raw bootmeth to find these
images without a board-specific bootcmd.

Read the image size from the first block and bound it by the partition
size and configured limit. Support legacy scripts and FIT scripts with
embedded data, using the shared script parser for validation and the
shared execution handler for booting.

Keep raw-partition scanning independently selectable from filesystem
script lookup. Document the configuration and self-contained FIT policy.

Signed-off-by: He Yong <hyyoxhk@163.com>
---
Changes in v3:
- Move shared FIT checks, handler export and sandbox tests to separate patches.

 MAINTAINERS                           |   1 +
 boot/Kconfig                          |  26 +++++
 boot/Makefile                         |   1 +
 boot/bootmeth_script_raw.c            | 152 ++++++++++++++++++++++++++
 doc/develop/bootstd/index.rst         |   1 +
 doc/develop/bootstd/script_raw.rst    |  51 +++++++++
 doc/device-tree-bindings/bootmeth.txt |   1 +
 7 files changed, 233 insertions(+)
 create mode 100644 boot/bootmeth_script_raw.c
 create mode 100644 doc/develop/bootstd/script_raw.rst

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
 
diff --git a/boot/bootmeth_script_raw.c b/boot/bootmeth_script_raw.c
new file mode 100644
index 00000000000..53913f20e98
--- /dev/null
+++ b/boot/bootmeth_script_raw.c
@@ -0,0 +1,152 @@
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
+static int script_raw_read_bootflow(struct udevice *dev, struct bootflow *bflow)
+{
+	struct legacy_img_hdr *hdr;
+	struct disk_partition info;
+	struct blk_desc *desc;
+	lbaint_t count;
+	uint size, len;
+	char *data;
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
+		if (!image_check_hcrc(hdr)) {
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
+	ret = image_locate_script(buf, size, NULL, NULL, &data, &len);
+	if (ret) {
+		ret = log_msg_ret("script", -EINVAL);
+		goto out;
+	}
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
-- 
2.43.0

