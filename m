Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35335C61DD9
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 19:21:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C700560615;
	Sat, 29 Aug 2026 19:21:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tnepmmLUKxc1; Sat, 29 Aug 2026 19:21:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788031296;
	bh=gsYO3fLThBD8wFle5ah2jrHB1VJ/AG8jS2T4VSwArXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y6mtx+NAcURZANRCk+Bs0bWhES5vRA6OildTCqCYIjd1sPv1Uc7c+kuVULgOBa2n3
	 LnHW+bHFqUKddYawXAFFzmpaB7HmCb8Kfs7QRiIUd/Wk5LQofi0Lof1TVfIcb4EGcu
	 /4OUrj7ysVpyq9UZBmQbkPPh/eOFRyagZs3kDIc/22+2iZgijpvVUmy9tzIY5CMh6s
	 Ha1p755WGemyq9z6dxVyaeHBnL68n+SqZTHC/zGTcGkmaWjCpqacaLmcnWiXqX4T8u
	 z90wadvxjqqWEloQGlywZ8gb/hMv1PW+9kuhMT4/UDBteBMg2oEG0J2mHmbqxsLiBG
	 tc/fGqQH+52rw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 54D526060C;
	Sat, 29 Aug 2026 19:21:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 16402355
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 19:21:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 07FA860607
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 19:21:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QfR8I_nGfN4S for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 19:21:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=fL6Ke5Tc
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 925A2605F3
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 19:21:32 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2d9004f39d3so2316245ad.2
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 12:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788031292; x=1788636092;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gsYO3fLThBD8wFle5ah2jrHB1VJ/AG8jS2T4VSwArXo=;
 b=fL6Ke5TcMWfFtQ+7+c/xHVutcSDWQmkFA/hBozNRYJtHvJadwbwa0DDtz6Meg1Od4M
 AUVlBtVG/b2iozyqObcv2h9KHU1/LsMC/0+bN1Bh0QzO79+35p6eYMpDZ/3eDD7BAVAJ
 My3UQrubyWtjnq5Nt1T0xG3hMa7cpcgLutCHdYOAyo0TGWinpUnB1x9sgt+TP+z49VQ6
 Y5YcuVsTYwi5niNY+R/64iIEVmGtCojvowXJsKRP1S+roFquGM1+dl2jMN1V+3Krnbzx
 HW9g2R4jsqZlIpNnBGD26YT1q88AXLzFNwFsjOmoEuhxzUiSuQ6KbhSnFgnC/oTHqkKi
 T8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788031292; x=1788636092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gsYO3fLThBD8wFle5ah2jrHB1VJ/AG8jS2T4VSwArXo=;
 b=W5nyVF5I1N00N7ftL4jxA0hIV+nLF4NHF4ctKh/M6XxOPQJOVwxDoEGBKgMg2h0h+/
 mrumUfMgvORGd9S/ATsfxfj1vSqYZKzGrEeYJsceIw3EzCtAz/xJQPdDjZEQ8mOJsYow
 U0JD32rcXcMyvD3wRkM0B2GIOrqVMH5ETV4bJ4Cl8HzITuA6v8Gh6kk30NzfxrisXDTa
 AzipLxqJUk5sDjy2i2Hc0MDUaYGYHI8N3qWQVhwagPi5brc5lE3Ik9e3JK0xrxVT/gCP
 JrHPOC51VHQ92TUlkOS/KejpNFM0qrY0COQzp4E3BTnpO5d93F1OfT1NcjuFAlsqDvJe
 vRAw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwotKzjbuEGKl7DyqTQEgq0je6jUp3e/F6YJAYiXsY4W9o6Fz0W0RBecBSvy1OFFyYvcYijtGU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nvnEsM6NtnFBpakyc00q68ESaPyCrZMT5yhp5b7vPyvxlGruNv
 tYlwlnQTxP3QeirjzCrDyFfs4/+PqPEgAewlLP8hbSzBPDfahaOo/YmC
X-Gm-Gg: AYBFou3FTOkLD3+v6/XHKIGEPNUbdrx+AVEV+6itgncEkfB5Fvj0xNvmL7RpJ+czJ7/
 kSCPMsgppkVS45KPQ3zPMxYR+JNBUSFbqMZ1h3GXI6w2SD544Wi66S22Lw7L4Q6uT3RGqRe+YHe
 sCiK5P77x8hFKNMrfsSOKTjWor8BPoe5y6cjyt+ubksWlz+B2QVQk+tVUW3uUHubqdzag+qFksB
 BBgTKgIcozMc3TXO0fM7n5iipMtHAA2H6PbyJItaze466rE/3q3BQJEpOmoFXoH6++UWoXiC9dm
 FKBpjsT+fFTgHQT0CXz+iRXbxRuICF7e1r9zaAyyj7FAQh70KH3ud0HqNOgOV1AHfUEHc0QE8QC
 k/r4bYu/XBDps0IlGJGohN7U/DF2M1Do6Tmor2qHDH9MNwH0IO/6fu+jivKFCMVdP0lByIm8zup
 /wzJZGuZ9JJ6Da0e9a0WV55twwsdM51Se8lRru23AvEck53xuXuazeaP5ysu8VuYkhfxMqUTXYM
 G16inhwTQM45vzAMHfhfiZY+kBraQR+5bC0bq+c33nn7ZEW68j8kvy26D2wTJ57fQ==
X-Received: by 2002:a17:90b:1dcb:b0:38f:57f0:1f5d with SMTP id
 98e67ed59e1d1-396d0f3df80mr28354248a91.15.1788031292194; 
 Sat, 29 Aug 2026 12:21:32 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (184.247.229.35.bc.googleusercontent.com. [35.229.247.184])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0ea7fa9sm12837034a91.4.2026.08.29.12.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2026 12:21:31 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: trini@konsulko.com, tuomas.tynkkynen@iki.fi, bmeng.cn@gmail.com,
 sjg@chromium.org, jerome.forissier@arm.com
Cc: jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com,
 u-boot@lists.u-boot-project.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 1/6] net: 9p: Add 9P2000.L protocol support
Date: Sat, 29 Aug 2026 19:21:14 +0000
Message-ID: <20260829192119.2658328-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
In-Reply-To: <20260829192119.2658328-1-visitorckw@gmail.com>
References: <20260829192119.2658328-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Introduce the core 9P network protocol client implementation.

9P is a network filesystem protocol originally developed for the
Plan 9 operating system. Add the baseline 9P2000.L protocol handling,
including message serialization, DM UCLASS_9P transport management,
and basic transport operations.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v2:
- Consistently use 9P2000.L instead of 9P2000 in subject and Kconfig.
- Add kerneldoc comments in include/9p.h.
- Move filesystem declarations to include/9pfs.h.
- Add LOG_CATEGORY and drop #include <config.h>.
- Return -ecode from P9_RLERROR in p9_check_error().
- Check memalign() return for NULL and return -ENOMEM.
- Parse server msize and version string in Rversion.
- Check return value of strlcpy() in p9_client_walk().
- Check nwqid == nwname in Rwalk reply.
- Validate count <= read_len before memcpy in read/readdir.
- Implement DM UCLASS_9P.
---
 include/9p.h           | 203 ++++++++++++++++++++
 include/dm/uclass-id.h |   1 +
 net/9p/Kconfig         |   5 +
 net/9p/Makefile        |   5 +
 net/9p/client.c        | 408 +++++++++++++++++++++++++++++++++++++++++
 net/Kconfig            |   2 +
 net/Makefile           |   1 +
 7 files changed, 625 insertions(+)
 create mode 100644 include/9p.h
 create mode 100644 net/9p/Kconfig
 create mode 100644 net/9p/Makefile
 create mode 100644 net/9p/client.c

diff --git a/include/9p.h b/include/9p.h
new file mode 100644
index 00000000000..e755c78be0f
--- /dev/null
+++ b/include/9p.h
@@ -0,0 +1,203 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2026, Kuan-Wei Chiu <visitorckw@gmail.com>
+ */
+
+#ifndef __9P_H__
+#define __9P_H__
+
+#include <linux/types.h>
+
+#define P9_MSIZE            65536
+#define P9_NOFID            (~0U)
+#define P9_NOTAG            0xFFFF
+#define P9_REQ_TAG          1
+
+#define P9_RLERROR          7
+#define P9_TLOPEN           12
+#define P9_RLOPEN           13
+#define P9_TGETATTR         24
+#define P9_RGETATTR         25
+#define P9_TREADDIR         40
+#define P9_RREADDIR         41
+#define P9_TVERSION         100
+#define P9_RVERSION         101
+#define P9_TATTACH          104
+#define P9_RATTACH          105
+#define P9_TWALK            110
+#define P9_RWALK            111
+#define P9_TREAD            116
+#define P9_RREAD            117
+#define P9_TCLUNK           120
+#define P9_RCLUNK           121
+
+#define P9_O_RDONLY         00000000
+#define P9_GETATTR_SIZE     0x00000010ULL
+#define P9_GETATTR_SIZE_OFFSET  41
+#define P9_DT_DIR           4
+
+/**
+ * struct p9_dirent_hdr - 9P2000.L directory entry wire header
+ * @qid: File QID (13 bytes)
+ * @offset: Offset cookie for next readdir (8 bytes)
+ * @type: Directory entry type (1 byte)
+ * @name_len: Length of filename (2 bytes)
+ */
+struct p9_dirent_hdr {
+	u8  qid[13];
+	u64 offset;
+	u8  type;
+	u16 name_len;
+} __packed;
+
+/**
+ * struct p9_header - 9P message header
+ * @size: Total message size in bytes, including this header
+ * @id: Message type / opcode (e.g. P9_TVERSION)
+ * @tag: Message tag to match request and reply
+ */
+struct p9_header {
+	u32 size;
+	u8  id;
+	u16 tag;
+} __packed;
+
+struct udevice;
+
+/**
+ * struct dm_p9_ops - Driver model operations for 9P transports
+ * @request: Execute a transmit/receive transaction
+ * @get_mount_tag: (optional) Retrieve the mount tag string
+ */
+struct dm_p9_ops {
+	int (*request)(struct udevice *dev, void *tx, int tx_len, void *rx, int rx_len);
+	const char *(*get_mount_tag)(struct udevice *dev);
+};
+
+/**
+ * struct p9_client - 9P client state
+ * @dev: Underlying transport udevice
+ * @tx: Transmit buffer
+ * @rx: Receive buffer
+ * @next_fid: Next FID to allocate
+ * @msize: Negotiated maximum message size
+ */
+struct p9_client {
+	struct udevice *dev;
+	u8 *tx;
+	u8 *rx;
+	u32 next_fid;
+	u32 msize;
+};
+
+/**
+ * p9_get_device() - Find a 9P transport device by mount tag or default
+ * @tag: Mount tag to match, or NULL/"-" for default/first device
+ * @devp: Output pointer to the found udevice
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int p9_get_device(const char *tag, struct udevice **devp);
+
+/**
+ * p9_get_client() - Get 9P client state from a transport udevice
+ * @dev: 9P transport udevice
+ *
+ * Return: Pointer to struct p9_client
+ */
+struct p9_client *p9_get_client(struct udevice *dev);
+
+/**
+ * p9_client_alloc_fid() - Allocate a unique FID
+ * @c: Pointer to 9P client
+ *
+ * Return: Newly allocated FID
+ */
+u32 p9_client_alloc_fid(struct p9_client *c);
+
+/**
+ * p9_client_version() - Negotiate 9P2000.L protocol version and msize
+ * @c: Pointer to 9P client
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int p9_client_version(struct p9_client *c);
+
+/**
+ * p9_client_attach() - Attach to the root directory
+ * @c: Pointer to 9P client
+ * @fid: FID to assign to root
+ * @uname: User name
+ * @aname: File tree / mount point name
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int p9_client_attach(struct p9_client *c, u32 fid, const char *uname, const char *aname);
+
+/**
+ * p9_client_walk() - Walk a path and associate with a new FID
+ * @c: Pointer to 9P client
+ * @base_fid: Starting directory FID
+ * @new_fid: New FID to associate with target path
+ * @path: Relative path to walk
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int p9_client_walk(struct p9_client *c, u32 base_fid, u32 new_fid, const char *path);
+
+/**
+ * p9_client_lopen() - Open a file (9P2000.L)
+ * @c: Pointer to 9P client
+ * @fid: FID of file to open
+ * @flags: Open flags (e.g. P9_O_RDONLY)
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int p9_client_lopen(struct p9_client *c, u32 fid, u32 flags);
+
+/**
+ * p9_client_clunk() - Forget / close a FID
+ * @c: Pointer to 9P client
+ * @fid: FID to clunk
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int p9_client_clunk(struct p9_client *c, u32 fid);
+
+/**
+ * p9_client_stat() - Get file size attribute via Tgetattr
+ * @c: Pointer to 9P client
+ * @fid: FID of file
+ * @size: Output pointer for file size
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int p9_client_stat(struct p9_client *c, u32 fid, loff_t *size);
+
+/**
+ * p9_client_read() - Read data from a file
+ * @c: Pointer to 9P client
+ * @fid: FID of file
+ * @offset: Byte offset in file to read from
+ * @count: Maximum number of bytes to read
+ * @buf: Destination buffer
+ * @actread: Output pointer for actual bytes read
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int p9_client_read(struct p9_client *c, u32 fid, u64 offset, u32 count, void *buf, u32 *actread);
+
+/**
+ * p9_client_readdir() - Read directory entries
+ * @c: Pointer to 9P client
+ * @fid: FID of directory
+ * @offset: Directory offset / cookie
+ * @count: Maximum bytes of dirents to read
+ * @buf: Destination buffer
+ * @actread: Output pointer for actual bytes returned
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int p9_client_readdir(struct p9_client *c, u32 fid, u64 offset, u32 count, void *buf, u32 *actread);
+
+#endif /* __9P_H__ */
diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
index fe0aae2720c..10680dc860c 100644
--- a/include/dm/uclass-id.h
+++ b/include/dm/uclass-id.h
@@ -108,6 +108,7 @@ enum uclass_id {
 	UCLASS_PANEL,		/* Display panel, such as an LCD */
 	UCLASS_PANEL_BACKLIGHT,	/* Backlight controller for panel */
 	UCLASS_PARTITION,	/* Logical disk partition device */
+	UCLASS_9P,		/* 9P protocol transport */
 	UCLASS_PCH,		/* x86 platform controller hub */
 	UCLASS_PCI,		/* PCI bus */
 	UCLASS_PCI_EP,		/* PCI endpoint device */
diff --git a/net/9p/Kconfig b/net/9p/Kconfig
new file mode 100644
index 00000000000..5fda98cb23d
--- /dev/null
+++ b/net/9p/Kconfig
@@ -0,0 +1,5 @@
+config NET_9P
+	bool "9P2000.L protocol support"
+	help
+	  This enables support for the 9P network protocol (9P2000.L).
+	  It implements the core 9P2000.L client and protocol handling.
diff --git a/net/9p/Makefile b/net/9p/Makefile
new file mode 100644
index 00000000000..e9220b0826e
--- /dev/null
+++ b/net/9p/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2026, Kuan-Wei Chiu <visitorckw@gmail.com>
+
+obj-y += client.o
diff --git a/net/9p/client.c b/net/9p/client.c
new file mode 100644
index 00000000000..970cf4d6e8f
--- /dev/null
+++ b/net/9p/client.c
@@ -0,0 +1,408 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026, Kuan-Wei Chiu <visitorckw@gmail.com>
+ */
+
+#define LOG_CATEGORY LOGC_NET
+
+#include <9p.h>
+#include <dm.h>
+#include <dm/device.h>
+#include <dm/device-internal.h>
+#include <dm/uclass.h>
+#include <log.h>
+#include <malloc.h>
+#include <asm/cache.h>
+#include <asm/unaligned.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+static int p9_post_probe(struct udevice *dev)
+{
+	struct p9_client *c = dev_get_uclass_priv(dev);
+
+	c->dev = dev;
+	return 0;
+}
+
+UCLASS_DRIVER(p9) = {
+	.name = "p9",
+	.id = UCLASS_9P,
+	.per_device_auto = sizeof(struct p9_client),
+	.post_probe = p9_post_probe,
+};
+
+struct p9_client *p9_get_client(struct udevice *dev)
+{
+	return dev_get_uclass_priv(dev);
+}
+
+int p9_get_device(const char *tag, struct udevice **devp)
+{
+	struct udevice *dev;
+	char *endp;
+	ulong num;
+	int ret;
+
+	if (!tag || !tag[0] || !strcmp(tag, "-"))
+		return uclass_first_device_err(UCLASS_9P, devp);
+
+	num = simple_strtoul(tag, &endp, 10);
+	if (*endp == '\0') {
+		ret = uclass_get_device(UCLASS_9P, num, devp);
+		if (!ret)
+			return 0;
+	}
+
+	uclass_foreach_dev_probe(UCLASS_9P, dev) {
+		const struct dm_p9_ops *ops = device_get_ops(dev);
+
+		if (ops && ops->get_mount_tag) {
+			const char *mtag = ops->get_mount_tag(dev);
+
+			if (mtag && !strcmp(mtag, tag)) {
+				*devp = dev;
+				return 0;
+			}
+		}
+
+		if (!strcmp(dev->name, tag)) {
+			*devp = dev;
+			return 0;
+		}
+	}
+
+	return -ENODEV;
+}
+
+u32 p9_client_alloc_fid(struct p9_client *c)
+{
+	if (c->next_fid >= 0xFFFF0000 || c->next_fid == 0)
+		c->next_fid = 2; /* fid 1 is reserved for root */
+	return c->next_fid++;
+}
+
+static void p9_put_u16(u8 **p, u16 v)
+{
+	put_unaligned_le16(v, *p);
+	*p += 2;
+}
+
+static void p9_put_u32(u8 **p, u32 v)
+{
+	put_unaligned_le32(v, *p);
+	*p += 4;
+}
+
+static void p9_put_u64(u8 **p, u64 v)
+{
+	put_unaligned_le64(v, *p);
+	*p += 8;
+}
+
+static void p9_put_str(u8 **p, const char *s)
+{
+	u16 len = strlen(s);
+
+	put_unaligned_le16(len, *p);
+	*p += 2;
+	memcpy(*p, s, len);
+	*p += len;
+}
+
+static int p9_request(struct p9_client *c, void *tx, int tx_len, void *rx, int rx_len)
+{
+	const struct dm_p9_ops *ops = device_get_ops(c->dev);
+
+	if (!ops || !ops->request)
+		return -ENOSYS;
+
+	return ops->request(c->dev, tx, tx_len, rx, rx_len);
+}
+
+static int p9_check_error(struct p9_client *c, int expected_id, const char *step)
+{
+	struct p9_header *rx_hdr = (struct p9_header *)c->rx;
+	u32 ecode;
+
+	if (rx_hdr->id == P9_RLERROR) {
+		ecode = get_unaligned_le32(c->rx + sizeof(struct p9_header));
+		log_err("9P Error: %s failed (ecode=%u)\n", step, ecode);
+		return -ecode;
+	} else if (rx_hdr->id != expected_id) {
+		log_err("9P Error: %s got id %d (expected %d)\n", step, rx_hdr->id, expected_id);
+		return -EIO;
+	}
+	return 0;
+}
+
+int p9_client_version(struct p9_client *c)
+{
+	struct p9_header *hdr;
+	u8 *ptr;
+	u32 server_msize;
+	u16 vlen;
+	int ret;
+
+	if (!c->tx) {
+		c->tx = memalign(ARCH_DMA_MINALIGN, P9_MSIZE);
+		if (!c->tx)
+			return -ENOMEM;
+	}
+	if (!c->rx) {
+		c->rx = memalign(ARCH_DMA_MINALIGN, P9_MSIZE);
+		if (!c->rx) {
+			free(c->tx);
+			c->tx = NULL;
+			return -ENOMEM;
+		}
+	}
+
+	hdr = (struct p9_header *)c->tx;
+	ptr = c->tx + sizeof(*hdr);
+	p9_put_u32(&ptr, P9_MSIZE);
+	p9_put_str(&ptr, "9P2000.L");
+
+	hdr->size = ptr - c->tx;
+	hdr->id = P9_TVERSION;
+	hdr->tag = P9_NOTAG;
+
+	ret = p9_request(c, c->tx, hdr->size, c->rx, P9_MSIZE);
+	if (ret < 0)
+		return ret;
+
+	ret = p9_check_error(c, P9_RVERSION, "Tversion");
+	if (ret < 0)
+		return ret;
+
+	ptr = c->rx + sizeof(*hdr);
+	server_msize = get_unaligned_le32(ptr);
+	ptr += 4;
+	vlen = get_unaligned_le16(ptr);
+	ptr += 2;
+
+	if (vlen != strlen("9P2000.L") || memcmp(ptr, "9P2000.L", vlen) != 0) {
+		log_err("9P: Unsupported server version: %.*s\n", vlen, ptr);
+		return -EPROTONOSUPPORT;
+	}
+
+	c->msize = min((u32)P9_MSIZE, server_msize);
+	return 0;
+}
+
+int p9_client_attach(struct p9_client *c, u32 fid, const char *uname, const char *aname)
+{
+	struct p9_header *hdr = (struct p9_header *)c->tx;
+	u8 *ptr = c->tx + sizeof(*hdr);
+	int ret;
+
+	p9_put_u32(&ptr, fid);
+	p9_put_u32(&ptr, P9_NOFID);
+	p9_put_str(&ptr, uname);
+	p9_put_str(&ptr, aname);
+	p9_put_u32(&ptr, 0);
+
+	hdr->size = ptr - c->tx;
+	hdr->id = P9_TATTACH;
+	hdr->tag = P9_REQ_TAG;
+
+	ret = p9_request(c, c->tx, hdr->size, c->rx, c->msize ? c->msize : P9_MSIZE);
+	if (ret < 0)
+		return ret;
+
+	return p9_check_error(c, P9_RATTACH, "Tattach");
+}
+
+int p9_client_walk(struct p9_client *c, u32 base_fid, u32 new_fid, const char *path)
+{
+	struct p9_header *hdr = (struct p9_header *)c->tx;
+	u8 *ptr = c->tx + sizeof(*hdr);
+	char path_buf[128];
+	char *wnames[16];
+	char *token, *p = path_buf;
+	int nwname = 0, i, ret;
+	u16 nwqid;
+
+	if (strlcpy(path_buf, path, sizeof(path_buf)) >= sizeof(path_buf)) {
+		log_err("9P: Path too long\n");
+		return -ENAMETOOLONG;
+	}
+
+	while ((token = strsep(&p, "/")) != NULL) {
+		if (*token == '\0' || strcmp(token, ".") == 0)
+			continue;
+		if (nwname >= 16) {
+			log_err("9P: Path too deep (max 16 levels)\n");
+			return -EINVAL;
+		}
+		wnames[nwname++] = token;
+	}
+
+	p9_put_u32(&ptr, base_fid);
+	p9_put_u32(&ptr, new_fid);
+	p9_put_u16(&ptr, nwname);
+	for (i = 0; i < nwname; i++)
+		p9_put_str(&ptr, wnames[i]);
+
+	hdr->size = ptr - c->tx;
+	hdr->id = P9_TWALK;
+	hdr->tag = P9_REQ_TAG;
+
+	ret = p9_request(c, c->tx, hdr->size, c->rx, c->msize ? c->msize : P9_MSIZE);
+	if (ret < 0)
+		return ret;
+
+	ret = p9_check_error(c, P9_RWALK, "Twalk");
+	if (ret < 0)
+		return ret;
+
+	ptr = c->rx + sizeof(*hdr);
+	nwqid = get_unaligned_le16(ptr);
+	if (nwqid != nwname)
+		return -ENOENT;
+
+	return 0;
+}
+
+int p9_client_lopen(struct p9_client *c, u32 fid, u32 flags)
+{
+	struct p9_header *hdr = (struct p9_header *)c->tx;
+	u8 *ptr = c->tx + sizeof(*hdr);
+	int ret;
+
+	p9_put_u32(&ptr, fid);
+	p9_put_u32(&ptr, flags);
+
+	hdr->size = ptr - c->tx;
+	hdr->id = P9_TLOPEN;
+	hdr->tag = P9_REQ_TAG;
+
+	ret = p9_request(c, c->tx, hdr->size, c->rx, c->msize ? c->msize : P9_MSIZE);
+	if (ret < 0)
+		return ret;
+
+	return p9_check_error(c, P9_RLOPEN, "Tlopen");
+}
+
+int p9_client_clunk(struct p9_client *c, u32 fid)
+{
+	struct p9_header *hdr = (struct p9_header *)c->tx;
+	u8 *ptr = c->tx + sizeof(*hdr);
+
+	p9_put_u32(&ptr, fid);
+	hdr->size = ptr - c->tx;
+	hdr->id = P9_TCLUNK;
+	hdr->tag = P9_REQ_TAG;
+
+	return p9_request(c, c->tx, hdr->size, c->rx, c->msize ? c->msize : P9_MSIZE);
+}
+
+int p9_client_stat(struct p9_client *c, u32 fid, loff_t *size)
+{
+	struct p9_header *hdr = (struct p9_header *)c->tx;
+	u8 *ptr = c->tx + sizeof(*hdr);
+	u64 valid;
+	int ret;
+
+	p9_put_u32(&ptr, fid);
+	p9_put_u64(&ptr, P9_GETATTR_SIZE);
+
+	hdr->size = ptr - c->tx;
+	hdr->id = P9_TGETATTR;
+	hdr->tag = P9_REQ_TAG;
+
+	ret = p9_request(c, c->tx, hdr->size, c->rx, c->msize ? c->msize : P9_MSIZE);
+	if (ret < 0)
+		return ret;
+
+	ret = p9_check_error(c, P9_RGETATTR, "Tgetattr");
+	if (ret == 0) {
+		ptr = c->rx + sizeof(*hdr);
+		valid = get_unaligned_le64(ptr);
+		ptr += sizeof(valid);
+		ptr += P9_GETATTR_SIZE_OFFSET;
+		if (valid & P9_GETATTR_SIZE) {
+			*size = get_unaligned_le64(ptr);
+			return 0;
+		}
+	}
+	return ret ? ret : -EIO;
+}
+
+int p9_client_read(struct p9_client *c, u32 fid, u64 offset, u32 count, void *buf, u32 *actread)
+{
+	struct p9_header *hdr = (struct p9_header *)c->tx;
+	u8 *ptr = c->tx + sizeof(*hdr);
+	u32 max_read = (c->msize ? c->msize : P9_MSIZE) - 24;
+	u32 read_len = (count == 0 || count > max_read) ? max_read : count;
+	u32 count_rx;
+	int ret;
+
+	p9_put_u32(&ptr, fid);
+	p9_put_u64(&ptr, offset);
+	p9_put_u32(&ptr, read_len);
+
+	hdr->size = ptr - c->tx;
+	hdr->id = P9_TREAD;
+	hdr->tag = P9_REQ_TAG;
+
+	ret = p9_request(c, c->tx, hdr->size, c->rx, c->msize ? c->msize : P9_MSIZE);
+	if (ret < 0)
+		return ret;
+
+	ret = p9_check_error(c, P9_RREAD, "Tread");
+	if (ret < 0)
+		return ret;
+
+	ptr = c->rx + sizeof(*hdr);
+	count_rx = get_unaligned_le32(ptr);
+	ptr += 4;
+	if (count_rx > read_len) {
+		log_err("9P: Tread returned count %u > requested %u\n", count_rx, read_len);
+		return -EIO;
+	}
+
+	*actread = count_rx;
+	memcpy(buf, ptr, count_rx);
+	return 0;
+}
+
+int p9_client_readdir(struct p9_client *c, u32 fid, u64 offset, u32 count, void *buf, u32 *actread)
+{
+	struct p9_header *hdr = (struct p9_header *)c->tx;
+	u8 *ptr = c->tx + sizeof(*hdr);
+	u32 max_read = (c->msize ? c->msize : P9_MSIZE) - 24;
+	u32 read_len = (count == 0 || count > max_read) ? max_read : count;
+	u32 count_rx;
+	int ret;
+
+	p9_put_u32(&ptr, fid);
+	p9_put_u64(&ptr, offset);
+	p9_put_u32(&ptr, read_len);
+
+	hdr->size = ptr - c->tx;
+	hdr->id = P9_TREADDIR;
+	hdr->tag = P9_REQ_TAG;
+
+	ret = p9_request(c, c->tx, hdr->size, c->rx, c->msize ? c->msize : P9_MSIZE);
+	if (ret < 0)
+		return ret;
+
+	ret = p9_check_error(c, P9_RREADDIR, "Treaddir");
+	if (ret < 0)
+		return ret;
+
+	ptr = c->rx + sizeof(*hdr);
+	count_rx = get_unaligned_le32(ptr);
+	ptr += 4;
+	if (count_rx > read_len) {
+		log_err("9P: Treaddir returned count %u > requested %u\n", count_rx, read_len);
+		return -EIO;
+	}
+
+	*actread = count_rx;
+	memcpy(buf, ptr, count_rx);
+	return 0;
+}
diff --git a/net/Kconfig b/net/Kconfig
index 386376ce884..00448ab4cc6 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -236,6 +236,8 @@ endif   # if NET_LEGACY
 
 source "net/lwip/Kconfig"
 
+source "net/9p/Kconfig"
+
 config BOOTDEV_ETH
 	bool "Enable bootdev for ethernet"
 	depends on BOOTSTD
diff --git a/net/Makefile b/net/Makefile
index ceac6de6377..7745607248b 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -49,3 +49,4 @@ obj-y += net-common.o
 endif
 
 obj-$(CONFIG_NET_LWIP) += lwip/
+obj-$(CONFIG_NET_9P) += 9p/
-- 
2.55.0.897.gb25b4bd76c-goog

