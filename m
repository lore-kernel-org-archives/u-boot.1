Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D118606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 04:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Qz+xwjpG;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gsGRuo0E
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1083740644;
	Mon, 23 Nov 2026 04:03:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5aX6XsySUo_Z; Mon, 23 Nov 2026 04:03:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6278240663
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795406632;
	b=gactbc0rRA2Y87QFo+7VeMkRxBozErmh6dlEPJ5s17GxIXsXtOwoEN5AYfAEwYO+LBNU
	 gC+CrcXYi9+hjh2rW0lUMDM4rT7ooJVKo5zWLKMbSP26p/oANqljcfSh/CYwTKVbBKTGT
	 BUjJAOCe9FNu/mq21HotpY5PPPQh4yT7EPCy1chiQI0PZxckAxZvEsdzGfRxpNeNmOdKk
	 XAcrdvDh8aiMPwwV1jFUHd8C8o8g/enyputguIAxPpvOXtPbam5DQTlkF4CQPwPTr/vRr
	 HJdJr0pcDJqjlfAlUuFS4qXU6n8HzAqDmhkvUA5I7NQPjWR2dq9d3JAzqlPm2qSrJpg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795406632;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=MP2e9FamI8SGyfvSXHIPEUHn3HgLmqZeBQaWpG6mhik=;
	b=jI0wHLcxBrS8jv66Say4Cyd0kushb6yZ1jPx3whPMyjIc6LL3pbuXVKVdpEgR0l6EElh
	 jNftTsl/80fCoN0xyaIKOEreUvhWJIkV729YEFRG8dLE1GXkJmpNvJaoL3RuTVkmPQWlV
	 Vw77e6ux+HFStW3/XsjE1nGQGxJw+iTC2HTLELdQSLjgU4b3+kOHFgXFaueM4U5wIek7S
	 JNK5i/dEmMsRXCDftAFm/exxK8YvkmOKU+0PMa0ODYFfToIeuQoxfCAjOr2vdCeogoH6K
	 5ZaFebNz3zkMLrB2Axu0XBKMUyTm3bv0gNt653B6txCKNk2u5W8pdB9z9mf0MbpAIeQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gsGRuo0E;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795406632;
	bh=MP2e9FamI8SGyfvSXHIPEUHn3HgLmqZeBQaWpG6mhik=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Qz+xwjpG2RNHXLCJ6iEYkmqoMtooOtzaDH0uUVTjSuSiQkMdi5HWGMSUR+7Ga3mBT
	 Qw74H16tNpKHncn25fIuSN+XBepaci5bY3KTM3ZuEzJ3fzOTriKa9v+fe9QRtGTmiL
	 4uGu/abywcavG7Nn9JOShqRyxjFdpmQzqVwQE0+KU9C3vzepLmcNydROmxn1qiTSE1
	 ifwj8GMcljgEjYhIAlJTCIeAVMGhaZ7++TMJyHWw+OlIXVuZUIwmnFupyZiwz1y8r8
	 sNR+ESO2IES/qQYVhI+sM8tsmMzG4IswV3MIgkgkArOC0RHjjBh6qF9KGkRJNm3suD
	 pyqnOIiwNLQKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6278240663;
	Mon, 23 Nov 2026 04:03:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 951C91AB
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 04:03:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 865094064E
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 04:03:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SEPHuTSFPwzy for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 04:03:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 841FC4065D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+iav.iav.lv@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=gsGRuo0E
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 841FC4065D
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 04:03:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 80A5A438C3;
 Mon, 23 Nov 2026 04:03:44 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id C53891F000E1;
 Mon, 23 Nov 2026 04:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795406624;
 bh=MP2e9FamI8SGyfvSXHIPEUHn3HgLmqZeBQaWpG6mhik=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=gsGRuo0EfgP+2pTd9To4gGKdaMw1wqA+KfRjTB/DCRjetFlVlj1GLzpJ+opC/w0ny
 PwYEy46MtqZzkPNUDlTHFlC6A6y3oU1VlpaV/wvCvQWsCoAR3uictf2V3NsgdZdWOH
 YBY+CcwdVvealtWSA52UiuHa39ycyGyQQrIUqZk3vVjjiSosKkS80xBa1OwaG8zF0L
 Fl0nz3S887vOl+o053JVFb9Y6QBQRF71WkLElzSXbNAdpTK0XPuj/fHAFf0Q5MaYoz
 KnwsmFxKO7wKpKjNgwwuL4LEY0FdoezbUt6mfW92IzjDsAyOt8iQmAHynekR7HpFsW
 qXZvvqvD1CwZg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 0112C4C339;
 Mon, 23 Nov 2026 04:03:23 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Mon, 23 Nov 2026 04:03:22 +0000
Subject: [PATCH v2 7/8] lib: add a stream sink for block devices
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261123-b4-wget-blk-r4-v2-7-073d800a5aaa@iav.lv>
References: <20261123-b4-wget-blk-r4-v2-0-073d800a5aaa@iav.lv>
In-Reply-To: <20261123-b4-wget-blk-r4-v2-0-073d800a5aaa@iav.lv>
To: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Adriano Cordova <adrianox@gmail.com>, u-boot@lists.u-boot-project.org, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=21587; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=aFhcjmHEXT322Rz7SvRUHsJgydv7HeXNhnEk2cnlzmY=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDNnMuzni4v1WpD2ueSvGni+c8tlM6Y/Gy1iJH4VzuPR99
 GawTH3cUcrCIMbFICumyDLhkMatjCVX//p7mD+AmcPKBDKEgYtTACbSepWRYcGNKm2JmP40ZrM1
 eYXK13uXBE8x8/ogwN54Q3c9V2bZK0aGl5s8fM85X1MPNjyy8quyg3LXrUYJIZYOtQ25rnI6wT8
 5AA==
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: iav@iav.lv
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Igor Velkov <iav@iav.lv>

Writing a disk image while it downloads needs a writer that takes the
data piece by piece and puts it on a block device, without the whole
image in memory.

Add sink_to_blk(). It takes the input through sink_write() in pieces of
any size and writes it through a write buffer of a size the caller
picks. sink_finish() pads the last block with zeroes, and sink_abort()
drops the buffered tail of a stream that did not complete. Data that
does not fit in the target area fails the stream. sink_finish() and
sink_abort() read the partition table again, since the stream may have
replaced it.

sink_blk_area() turns "<dev>[.<hwpart>][:<part>|#<name>]" and a byte
offset into a block range. Without a partition the range is the whole
device, also on a partitioned one. A partition that lies outside the
device is refused, and so are an empty <part> and "auto", which leave
the choice of partition to U-Boot. An empty <dev> or <name> and "0x"
without digits are refused for the same reason, and so is a number of
more than 8 digits or above 0x7fffffff, which the device and partition
lookups cut to an int. A <hwpart> that the device does not have is
refused: one above 7 on MMC, which mmc_switch_part() takes modulo 8, and
one other than 0 elsewhere, where the lookup takes any number.
"ubi" is refused too: by that name the block layer finds the raw MTD
device under the UBI volumes.

lib_test_sink_blk covers the area lookup and the writer on the sandbox
MMC; sandbox_defconfig enables STREAM_SINK for it.

Signed-off-by: Igor Velkov <iav@iav.lv>
---
 configs/sandbox_defconfig |   1 +
 include/stream_sink.h     |  84 +++++++++++++++
 lib/Kconfig               |   8 ++
 lib/Makefile              |   1 +
 lib/stream_sink.c         | 268 ++++++++++++++++++++++++++++++++++++++++++++++
 test/lib/Makefile         |   3 +
 test/lib/stream_sink.c    | 204 +++++++++++++++++++++++++++++++++++
 7 files changed, 569 insertions(+)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index e8b462e7c11..f82114fe1fc 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -407,6 +407,7 @@ CONFIG_ECDSA_VERIFY=y
 CONFIG_RSASSA_PSS=y
 CONFIG_TPM=y
 CONFIG_TPM_AUTOSTART=y
+CONFIG_STREAM_SINK=y
 CONFIG_ERRNO_STR=y
 CONFIG_GETOPT=y
 CONFIG_TEST_FDTDEC=y
diff --git a/include/stream_sink.h b/include/stream_sink.h
new file mode 100644
index 00000000000..0f80e72bf9c
--- /dev/null
+++ b/include/stream_sink.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Write a stream to a block device
+ */
+
+#ifndef __STREAM_SINK_H
+#define __STREAM_SINK_H
+
+#include <blk.h>
+#include <linux/types.h>
+
+struct stream_sink;
+
+/**
+ * sink_to_blk() - start writing a stream to a block device
+ *
+ * @dev:	the device
+ * @start:	first block to write
+ * @count:	blocks available from @start; more output fails the stream
+ * @wbuf:	size of the write buffer, a multiple of the block size
+ * Return:	the sink, or NULL with the reason printed
+ */
+struct stream_sink *sink_to_blk(struct blk_desc *dev, lbaint_t start,
+				lbaint_t count, size_t wbuf);
+
+/**
+ * sink_blk_area() - find the blocks that a command line names
+ *
+ * Without ":<part>" or "#<name>" the area is the whole device (or hardware
+ * partition), which a raw write wants even where the device has a partition
+ * table; ":0" names it too. An empty <part> and "auto" are refused: they
+ * leave the choice of partition to U-Boot. An empty <dev> or <name>, "0x"
+ * without digits, and a number of more than 8 digits or above 0x7fffffff are
+ * refused for the same reason, and so is a <hwpart> that the device does not
+ * have: one above 7 on MMC, one other than 0 elsewhere.
+ *
+ * @ifname:	interface, e.g. "mmc"
+ * @dev_part:	"<dev>[.<hwpart>][:<part>|#<name>]"
+ * @offs:	byte offset into the area, a multiple of the block size
+ * @dev:	returns the device
+ * @start:	returns the first block to write
+ * @count:	returns the blocks from @start to the end of the area
+ * Return:	0, or a negative error with the reason printed
+ */
+int sink_blk_area(const char *ifname, const char *dev_part, u64 offs,
+		  struct blk_desc **dev, lbaint_t *start, lbaint_t *count);
+
+/**
+ * sink_write() - feed the next piece of the stream
+ *
+ * @s:		the sink
+ * @buf:	input data
+ * @len:	length of @buf
+ * Return:	0, or a negative error with the reason printed
+ */
+int sink_write(struct stream_sink *s, const void *buf, size_t len);
+
+/**
+ * sink_finish() - complete the stream and release the sink
+ *
+ * This writes out what is still buffered, the last partial block padded with
+ * zeroes, and frees @s. After a failed sink_write() it only frees @s and
+ * returns that error.
+ * Either way it reads the partition table again: the stream may have
+ * replaced it.
+ *
+ * @s:		the sink
+ * @outlen:	if not NULL, receives the number of bytes that sink_write()
+ *		took, also when the stream failed
+ * Return:	0, or a negative error with the reason printed
+ */
+int sink_finish(struct stream_sink *s, u64 *outlen);
+
+/**
+ * sink_abort() - release the sink of a stream that did not complete
+ *
+ * Output already written stays where it is; this drops the buffered tail
+ * and reads the partition table again.
+ *
+ * @s:		the sink
+ */
+void sink_abort(struct stream_sink *s);
+
+#endif /* __STREAM_SINK_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index e86548985d8..0562ae49ef4 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1096,6 +1096,14 @@ config SPL_ZSTD
 
 endmenu
 
+config STREAM_SINK
+	bool "Write a stream to a block device"
+	depends on BLK && PARTITIONS
+	help
+	  Write data piece by piece as it arrives, for example from wget,
+	  to a block device. Memory use does not grow with the data: the
+	  sink needs only its write buffer.
+
 config ERRNO_STR
 	bool "Enable function for getting errno-related string message"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index 925cb619807..db14b8804ee 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -91,6 +91,7 @@ obj-$(CONFIG_$(PHASE_)ASN1_DECODER_LEGACY) += asn1_decoder.o
 obj-$(CONFIG_$(PHASE_)ZLIB) += zlib/
 obj-$(CONFIG_$(PHASE_)ZSTD) += zstd/
 obj-$(CONFIG_$(PHASE_)GZIP) += gunzip.o
+obj-$(CONFIG_$(PHASE_)STREAM_SINK) += stream_sink.o
 obj-$(CONFIG_$(PHASE_)LZO) += lzo/
 obj-$(CONFIG_$(PHASE_)LZMA) += lzma/
 obj-$(CONFIG_$(PHASE_)LZ4) += lz4_wrapper.o
diff --git a/lib/stream_sink.c b/lib/stream_sink.c
new file mode 100644
index 00000000000..e05e9ff7152
--- /dev/null
+++ b/lib/stream_sink.c
@@ -0,0 +1,268 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Write a stream to a block device
+ *
+ * The input arrives in pieces of any size, and memory use does not depend
+ * on the size of the data.
+ */
+
+#include <blk.h>
+#include <limits.h>
+#include <log.h>
+#include <malloc.h>
+#include <memalign.h>
+#include <mmc.h>
+#include <part.h>
+#include <stream_sink.h>
+#include <u-boot/schedule.h>
+#include <vsprintf.h>
+#include <linux/ctype.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/math64.h>
+#include <linux/string.h>
+
+struct stream_sink {
+	u64 outlen;
+	/* first error of sink_write(), returned by every later call */
+	int err;
+
+	struct blk_desc *dev;
+	lbaint_t blk;
+	/* first block past the target area */
+	lbaint_t end;
+	u8 *wbuf;
+	size_t wbuf_size;
+	size_t fill;
+};
+
+static int sink_blk_flush(struct stream_sink *s)
+{
+	lbaint_t blocks = DIV_ROUND_UP(s->fill, s->dev->blksz);
+
+	if (!blocks)
+		return 0;
+	if (s->fill % s->dev->blksz)
+		memset(s->wbuf + s->fill, 0,
+		       blocks * s->dev->blksz - s->fill);
+	if (blocks > s->end - s->blk) {
+		log_err("sink: output does not fit in the target area\n");
+		return -ENOSPC;
+	}
+	if (blk_dwrite(s->dev, s->blk, blocks, s->wbuf) != blocks) {
+		log_err("sink: write error at block " LBAFU "\n", s->blk);
+		return -EIO;
+	}
+	s->blk += blocks;
+	s->fill = 0;
+	schedule();
+
+	return 0;
+}
+
+static int sink_blk_write(struct stream_sink *s, const u8 *buf, size_t len)
+{
+	size_t n;
+	int ret;
+
+	while (len) {
+		if (s->fill == s->wbuf_size) {
+			ret = sink_blk_flush(s);
+			if (ret)
+				return ret;
+		}
+		n = min(len, s->wbuf_size - s->fill);
+		memcpy(s->wbuf + s->fill, buf, n);
+		s->fill += n;
+		s->outlen += n;
+		buf += n;
+		len -= n;
+	}
+
+	return 0;
+}
+
+static void sink_free(struct stream_sink *s)
+{
+	free(s->wbuf);
+	free(s);
+}
+
+/* The stream may have replaced the partition table: read it again. */
+static void sink_close(struct stream_sink *s)
+{
+	part_init(s->dev);
+	sink_free(s);
+}
+
+/*
+ * The device and partition lookups read "0x" without digits as 0 and keep
+ * the low 32 bits of a number, as a signed int. Return the end of a number
+ * that they read as written, and the number in @num, or NULL.
+ */
+static const char *sink_num(const char *str, int *num)
+{
+	const char *digits = str;
+	char *end;
+	ulong val;
+
+	if (digits[0] == '0' && tolower(digits[1]) == 'x')
+		digits += 2;
+	val = hextoul(str, &end);
+	if (end == digits || end - digits > 8 || val > INT_MAX)
+		return NULL;
+	*num = val;
+
+	return end;
+}
+
+int sink_blk_area(const char *ifname, const char *dev_part, u64 offs,
+		  struct blk_desc **dev, lbaint_t *start, lbaint_t *count)
+{
+	struct disk_partition info;
+	int devnum, hwpart = 0, part;
+	const char *p;
+	u64 skip;
+	u32 rem;
+
+	/* the block layer takes "ubi" for the raw MTD device under the volumes */
+	if (!strcmp(ifname, "ubi")) {
+		log_err("sink: %s is not a block device\n", ifname);
+		return -ENODEV;
+	}
+	/* a write must not land where U-Boot picks the device or partition */
+	p = sink_num(dev_part, &devnum);
+	if (p && *p == '.')
+		p = sink_num(p + 1, &hwpart);
+	if (!p || (*p && *p != ':' && *p != '#')) {
+		log_err("sink: bad device number in %s '%s'\n", ifname,
+			dev_part);
+		return -EINVAL;
+	}
+	if (*p == ':') {
+		p = sink_num(p + 1, &part);
+		if (!p || *p) {
+			log_err("sink: no partition number in %s %s\n", ifname,
+				dev_part);
+			return -EINVAL;
+		}
+	} else if (*p == '#' && !p[1]) {
+		/* an empty name matches the first partition that has none */
+		log_err("sink: no partition name in %s %s\n", ifname,
+			dev_part);
+		return -EINVAL;
+	}
+	/* mmc_switch_part() takes a hardware partition above 7 modulo 8 */
+	if (hwpart > PART_ACCESS_MASK && !strcmp(ifname, "mmc")) {
+		log_err("sink: no hardware partition %x on %s %x\n", hwpart,
+			ifname, devnum);
+		return -ENODEV;
+	}
+	if (strpbrk(dev_part, ":#")) {
+		if (part_get_info_by_dev_and_name_or_num(ifname, dev_part, dev,
+							 &info, 1) < 0)
+			return -ENODEV;
+		/* hostfs and 9p have partitions but no block device */
+		if (!*dev) {
+			log_err("sink: %s is not a block device\n", ifname);
+			return -ENODEV;
+		}
+	} else {
+		if (blk_get_device_by_str(ifname, dev_part, dev) < 0) {
+			log_err("sink: no device %s %s\n", ifname, dev_part);
+			return -ENODEV;
+		}
+		info.start = 0;
+		info.size = (*dev)->lba;
+	}
+	/* a device without hardware partitions takes any number for one */
+	if ((*dev)->hwpart != hwpart) {
+		log_err("sink: no hardware partition %x on %s %x\n", hwpart,
+			ifname, devnum);
+		return -ENODEV;
+	}
+
+	/* a broken partition table must not wrap the block math below */
+	if (info.start >= (*dev)->lba || info.size > (*dev)->lba - info.start) {
+		log_err("sink: %s %s lies outside the device\n", ifname,
+			dev_part);
+		return -EINVAL;
+	}
+	skip = div_u64_rem(offs, (*dev)->blksz, &rem);
+	if (rem) {
+		log_err("sink: offset %#llx is not a multiple of the block size %#lx\n",
+			offs, (*dev)->blksz);
+		return -EINVAL;
+	}
+	if (skip >= info.size) {
+		log_err("sink: offset %#llx is past the end of %s %s\n",
+			offs, ifname, dev_part);
+		return -EINVAL;
+	}
+	*start = info.start + skip;
+	*count = info.size - skip;
+
+	return 0;
+}
+
+struct stream_sink *sink_to_blk(struct blk_desc *dev, lbaint_t start,
+				lbaint_t count, size_t wbuf)
+{
+	struct stream_sink *s;
+
+	if (!wbuf || wbuf % dev->blksz) {
+		log_err("sink: write buffer %#zx must be a nonzero multiple of the block size %#lx\n",
+			wbuf, dev->blksz);
+		return NULL;
+	}
+	if (!count || start + count < start || start + count > dev->lba) {
+		log_err("sink: blocks " LBAFU "+" LBAFU " are outside the device\n",
+			start, count);
+		return NULL;
+	}
+
+	s = calloc(1, sizeof(*s));
+	if (!s) {
+		log_err("sink: out of memory\n");
+		return NULL;
+	}
+	s->wbuf = malloc_cache_aligned(wbuf);
+	if (!s->wbuf) {
+		log_err("sink: no memory for a write buffer of %#zx bytes\n",
+			wbuf);
+		sink_free(s);
+		return NULL;
+	}
+	s->dev = dev;
+	s->blk = start;
+	s->end = start + count;
+	s->wbuf_size = wbuf;
+
+	return s;
+}
+
+int sink_write(struct stream_sink *s, const void *buf, size_t len)
+{
+	if (!s->err)
+		s->err = sink_blk_write(s, buf, len);
+
+	return s->err;
+}
+
+int sink_finish(struct stream_sink *s, u64 *outlen)
+{
+	int ret = s->err;
+
+	if (!ret)
+		ret = sink_blk_flush(s);
+	if (outlen)
+		*outlen = s->outlen;
+	sink_close(s);
+
+	return ret;
+}
+
+void sink_abort(struct stream_sink *s)
+{
+	sink_close(s);
+}
diff --git a/test/lib/Makefile b/test/lib/Makefile
index 9fc4a1a9b5d..af099777391 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -8,6 +8,9 @@ obj-$(CONFIG_$(PHASE_)UT_COMPRESSION) += compression.o
 ifeq ($(CONFIG_XPL_BUILD),)
 obj-y += abuf.o
 obj-y += alist.o
+ifeq ($(CONFIG_SANDBOX)$(CONFIG_STREAM_SINK),yy)
+obj-y += stream_sink.o
+endif
 obj-$(CONFIG_ECDSA_VERIFY_MBEDTLS) += ecdsa.o
 obj-$(CONFIG_EFI_LOADER) += efi_device_path.o efi_memory.o
 obj-$(CONFIG_EFI_SECURE_BOOT) += efi_image_region.o
diff --git a/test/lib/stream_sink.c b/test/lib/stream_sink.c
new file mode 100644
index 00000000000..42396041dbf
--- /dev/null
+++ b/test/lib/stream_sink.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Tests for writing a stream to a block device
+ */
+
+#include <blk.h>
+#include <part.h>
+#include <stream_sink.h>
+#include <u-boot/uuid.h>
+#include <test/lib.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+#define DATA_LEN	3000
+
+/* No two blocks of the data are alike, so that a misplaced one shows. */
+static void fill(u8 *buf, size_t len, unsigned int seed)
+{
+	while (len--) {
+		*buf++ = seed >> 16;
+		seed = seed * 1103515245 + 12345;
+	}
+}
+
+/* Feed @len bytes of @src in pieces of @piece bytes. */
+static int feed(struct stream_sink *s, const u8 *src, size_t len,
+		size_t piece)
+{
+	size_t done, n;
+	int ret;
+
+	for (done = 0; done < len; done += n) {
+		n = min(piece, len - done);
+		ret = sink_write(s, src + done, n);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/* Give mmc2 two named partitions, as test/cmd/rw.c does, and one without. */
+static int setup_partitions(struct unit_test_state *uts,
+			    struct blk_desc **desc)
+{
+	char guid[UUID_STR_LEN + 1] = "";
+	struct disk_partition parts[3] = {
+		{ .start = 48, .size = 8, .name = "data" },
+		{ .start = 56, .size = 16, .name = "log" },
+		{ .start = 72, .size = 8, .name = "" },
+	};
+
+	ut_asserteq(2, blk_get_device_by_str("mmc", "2", desc));
+	if (CONFIG_IS_ENABLED(RANDOM_UUID)) {
+		gen_rand_uuid_str(parts[0].uuid, UUID_STR_FORMAT_STD);
+		gen_rand_uuid_str(parts[1].uuid, UUID_STR_FORMAT_STD);
+		gen_rand_uuid_str(parts[2].uuid, UUID_STR_FORMAT_STD);
+		gen_rand_uuid_str(guid, UUID_STR_FORMAT_STD);
+	}
+	ut_assertok(gpt_restore(*desc, guid, parts, ARRAY_SIZE(parts)));
+
+	return 0;
+}
+
+static int lib_test_sink_blk(struct unit_test_state *uts)
+{
+	u8 src[DATA_LEN], back[4096];
+	struct blk_desc *desc, *dev;
+	lbaint_t start, count;
+	struct stream_sink *s;
+	u64 outlen;
+
+	ut_assertok(setup_partitions(uts, &desc));
+	fill(src, sizeof(src), 2);
+
+	/* the whole device, with a byte offset, also as hardware partition 0 */
+	ut_assertok(sink_blk_area("mmc", "2", 0x400, &dev, &start, &count));
+	ut_asserteq_ptr(desc, dev);
+	ut_asserteq(2, start);
+	ut_asserteq(desc->lba - 2, count);
+	ut_assertok(sink_blk_area("mmc", "2.0", 0, &dev, &start, &count));
+	ut_asserteq(0, start);
+	ut_asserteq(desc->lba, count);
+	ut_assertok(sink_blk_area("mmc", "2:0", 0, &dev, &start, &count));
+	ut_asserteq(0, start);
+	ut_asserteq(desc->lba, count);
+
+	/* a partition left to U-Boot's choice */
+	ut_asserteq(-EINVAL, sink_blk_area("mmc", "2:", 0, &dev, &start,
+					   &count));
+	ut_asserteq(-EINVAL, sink_blk_area("mmc", "2:auto", 0, &dev, &start,
+					   &count));
+
+	/* a device, hardware partition or partition number that is not there */
+	ut_asserteq(-EINVAL, sink_blk_area("mmc", "", 0, &dev, &start,
+					   &count));
+	ut_asserteq(-EINVAL, sink_blk_area("mmc", "-", 0, &dev, &start,
+					   &count));
+	ut_asserteq(-EINVAL, sink_blk_area("mmc", ":1", 0, &dev, &start,
+					   &count));
+	ut_asserteq(-EINVAL, sink_blk_area("mmc", "#log", 0, &dev, &start,
+					   &count));
+	ut_asserteq(-EINVAL, sink_blk_area("mmc", "2.:1", 0, &dev, &start,
+					   &count));
+	ut_asserteq(-EINVAL, sink_blk_area("mmc", "0x", 0, &dev, &start,
+					   &count));
+	ut_asserteq(-EINVAL, sink_blk_area("mmc", "2:0x", 0, &dev, &start,
+					   &count));
+
+	/* an empty name, which matches the partition that has none */
+	ut_asserteq(-EINVAL, sink_blk_area("mmc", "2#", 0, &dev, &start,
+					   &count));
+
+	/* numbers that the lookups read as 2, 0, 1 and "auto" */
+	ut_asserteq(-EINVAL, sink_blk_area("mmc", "100000002", 0, &dev,
+					   &start, &count));
+	ut_asserteq(-EINVAL, sink_blk_area("mmc", "2.100000000", 0, &dev,
+					   &start, &count));
+	ut_asserteq(-EINVAL, sink_blk_area("mmc", "2:100000001", 0, &dev,
+					   &start, &count));
+	ut_asserteq(-EINVAL, sink_blk_area("mmc", "2:ffffffff", 0, &dev,
+					   &start, &count));
+
+	/* a partition that is not on a block device */
+	ut_asserteq(-ENODEV, sink_blk_area("hostfs", "0:1", 0, &dev, &start,
+					   &count));
+
+	/* a hardware partition above 7 on MMC, also at a second try */
+	ut_asserteq(-ENODEV, sink_blk_area("mmc", "2.8", 0, &dev, &start,
+					   &count));
+	ut_asserteq(-ENODEV, sink_blk_area("mmc", "2.8", 0, &dev, &start,
+					   &count));
+
+	/* a partition by number and by name */
+	ut_assertok(sink_blk_area("mmc", "2:1", 0, &dev, &start, &count));
+	ut_asserteq(48, start);
+	ut_asserteq(8, count);
+	ut_assertok(sink_blk_area("mmc", "2#log", 0x200, &dev, &start,
+				  &count));
+	ut_asserteq(57, start);
+	ut_asserteq(15, count);
+
+	ut_asserteq(-EINVAL, sink_blk_area("mmc", "2:1", 0x100, &dev, &start,
+					   &count));
+	ut_asserteq(-EINVAL, sink_blk_area("mmc", "2:1", 8 * 512, &dev,
+					   &start, &count));
+	ut_asserteq(-ENODEV, sink_blk_area("mmc", "9", 0, &dev, &start,
+					   &count));
+	ut_asserteq(-ENODEV, sink_blk_area("mmc", "2:7", 0, &dev, &start,
+					   &count));
+	ut_asserteq(-ENODEV, sink_blk_area("mmc", "2#none", 0, &dev, &start,
+					   &count));
+
+	/* 3000 bytes into "log", a 1 KiB buffer; the tail block is padded */
+	memset(back, 0xff, sizeof(back));
+	ut_asserteq(sizeof(back) / 512, blk_dwrite(desc, 56, 8, back));
+	ut_assertok(sink_blk_area("mmc", "2#log", 0, &dev, &start, &count));
+	s = sink_to_blk(dev, start, count, 1024);
+	ut_assertnonnull(s);
+	ut_assertok(feed(s, src, sizeof(src), 7));
+	ut_assertok(sink_finish(s, &outlen));
+	ut_asserteq(DATA_LEN, outlen);
+	ut_asserteq(sizeof(back) / 512, blk_dread(desc, 56, 8, back));
+	ut_asserteq_mem(src, back, DATA_LEN);
+	ut_assert(!memchr_inv(back + DATA_LEN, 0, 3072 - DATA_LEN));
+	ut_assert(!memchr_inv(back + 3072, 0xff, sizeof(back) - 3072));
+
+	/* an aborted stream leaves the buffered tail unwritten */
+	memset(back, 0xff, sizeof(back));
+	ut_asserteq(sizeof(back) / 512, blk_dwrite(desc, 56, 8, back));
+	s = sink_to_blk(dev, 56, 8, 1024);
+	ut_assertnonnull(s);
+	ut_assertok(feed(s, src, 1500, 1500));
+	sink_abort(s);
+	ut_asserteq(sizeof(back) / 512, blk_dread(desc, 56, 8, back));
+	ut_asserteq_mem(src, back, 1024);
+	ut_assert(!memchr_inv(back + 1024, 0xff, sizeof(back) - 1024));
+
+	/* "data" is 4 KiB: the flush of the fifth KiB fails */
+	s = sink_to_blk(dev, 48, 8, 1024);
+	ut_assertnonnull(s);
+	ut_assertok(feed(s, src, sizeof(src), sizeof(src)));
+	ut_asserteq(-ENOSPC, feed(s, src, sizeof(src), sizeof(src)));
+	ut_asserteq(-ENOSPC, sink_finish(s, NULL));
+	/* the first block of "log" is as the aborted stream left it */
+	ut_asserteq(1, blk_dread(desc, 56, 1, back));
+	ut_asserteq_mem(src, back, 512);
+
+	/* the write buffer must be a multiple of the block size */
+	ut_assertnull(sink_to_blk(dev, 48, 8, 1000));
+
+	/* a stream over the partition table: the device has none afterwards */
+	ut_asserteq(PART_TYPE_EFI, desc->part_type);
+	memset(back, 0, sizeof(back));
+	s = sink_to_blk(dev, 0, 8, 1024);
+	ut_assertnonnull(s);
+	ut_assertok(feed(s, back, sizeof(back), sizeof(back)));
+	ut_assertok(sink_finish(s, NULL));
+	ut_asserteq(PART_TYPE_UNKNOWN, desc->part_type);
+	ut_assertok(setup_partitions(uts, &desc));
+
+	return 0;
+}
+LIB_TEST(lib_test_sink_blk, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);

-- 
2.43.0


