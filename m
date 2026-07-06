Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A208C43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 21:55:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AC7D84979;
	Mon,  6 Jul 2026 23:55:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cxLGCe3M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A113D8496E; Mon,  6 Jul 2026 23:55:05 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F275284942
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 23:55:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2c9bd2f8bf7so249785ad.1
 for <u-boot@lists.denx.de>; Mon, 06 Jul 2026 14:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783374900; x=1783979700; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xsEsE6GyZBckolXQ5ahH2DVlXs9OABMzezlrcaJvuR8=;
 b=cxLGCe3MYpJ/Jwx7ZRrYMOb0I/fVhXZ7SEQi94VARiZCiKp7Zr7rXj6SJOWGY9bgu4
 IfccDvPt27JMp4LwuZNj6+P03be32tO4zvTa+jlDvAMhgvhYLbeqmeBoJO/uunYfcguZ
 72y9bwhZc/jCC8buE+Dj9b4JN/aEOpUzILXDJmvoaVlpEShnygCWY9xexHu3OegMtBBM
 9SZ9pzqGy8C9uL9uWZcQRyJnoyMfF0SQMIbfXXWtFwmkdQ3YdYKqlJvYTMUR7Vvi8bb0
 AVKmvFnMTv9W9iY68WLSGUOgDOQOHR3ZKalEQkyvKscND+nVIUO/GXfkj2bACaRP9MBg
 mMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783374900; x=1783979700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xsEsE6GyZBckolXQ5ahH2DVlXs9OABMzezlrcaJvuR8=;
 b=LFu6VA1jXfh0a4sWA4izm2hL0dvG5qLPua6GgwRVFndO0QNPXf/77/GxASlB/5SPqU
 hGi3HTykzTYPOgUHY565Nva9+ss773RU0kqk1hDbexWJkPJroarR5AFRBeMlS7nEjBWq
 IwPdZDnyXGITRFHT/3s1Nvp7PA4xpupI69fa+bKEBc79UQUHsGY16u3oNT5oRz6INZBe
 696Ia1Dao4lW0D2yVicYHMD9cEVHSpO0HTTwHb4GDBvBcKtTdkh43cmtWXcdbnY59G+j
 YGaFFNq9BG3BeBijdpARZYva1A4TynNH3uOVPJxJfzcpux5LJGanzMh9fdLbSTLLDEYS
 XEFg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpwisPpKeHfKSp09FbZa2kOWaCK3sN7QhSKBVj6PO534d8Z42i1xx7Ou0Bw381CdSwwLssNzuw=@lists.denx.de
X-Gm-Message-State: AOJu0YwrVuv0mpXvCoGoIJRFeBuGor1EXkwpcwW65iOCDe9/3LXUbAbn
 67vLDwTDwI1xdN7N4ey4ZmFd1K7EzIv7KUtNlGwu3iJqjH4aq8I5x/F+
X-Gm-Gg: AfdE7cmMN89DY+6xNwapC7EdClT89kQRHzSGq93BcCyqabQsPxQlDmjAUNPVvuv2Czw
 QP1T7Yr0IwQ/cSpEKnwVrtaRNVi0KLyvTkWpW8Z0fgzkdnQmb3E5vhzQpSvlj7GANICGfnKJXpe
 0XLTZck5+AG3zG3doEopy9Mok/Ns7dyqB4ZeFMBwBtzYBlhHxSUSB6Uoi0zALFqo7V7cS+QXpqW
 rHGP+LN+OYtvgjP9uE94DnP+IPrFlbYdkVRHy+AU+ddxrKcjXHG0L1d6UtkduWhyqaieFDz9Og3
 whjjAJl53OvoVXNMWXruMVi93JaAC76o42JjP0Smp6CyYcycJEg5oXwHBQq5/qzcRVN1oArXlan
 YUD5bM9qDPXi9QZ0NQp8DAMqscKE9GQhSmwXWd27kuu5+mXY+bSjpuCzsy5GhA3Oj/7FxdUwVHD
 1nk0xijmJxj42kW+55zHYo0UQPs/uCcCoA5ZY21iUnADvxXnJ3JBl/nBoBA/H/9O7z6LqDNYAOK
 W4QWghADH7c
X-Received: by 2002:a05:6a21:2989:b0:3bf:9bd9:cf54 with SMTP id
 adf61e73a8af0-3c09af93d49mr137610637.8.1783374899890; 
 Mon, 06 Jul 2026 14:54:59 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (32.237.80.34.bc.googleusercontent.com. [34.80.237.32])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174a56d64sm650864eec.17.2026.07.06.14.54.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 14:54:59 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: trini@konsulko.com, bmeng.cn@gmail.com, joe.hershberger@ni.com,
 rfried.dev@gmail.com, jerome.forissier@arm.com
Cc: jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com,
 u-boot@lists.denx.de, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 1/4] net: 9p: Add 9P2000 protocol support
Date: Mon,  6 Jul 2026 21:54:43 +0000
Message-ID: <20260706215446.4068820-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
In-Reply-To: <20260706215446.4068820-1-visitorckw@gmail.com>
References: <20260706215446.4068820-1-visitorckw@gmail.com>
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

Introduce the core 9P network protocol client implementation.

9P is a network filesystem protocol originally developed for the
Plan 9 operating system. Add the baseline 9P2000.L protocol handling,
including message serialization, client registration, and basic
transport operations.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 include/9p.h    |  82 +++++++++++++++
 net/9p/Kconfig  |   5 +
 net/9p/Makefile |   5 +
 net/9p/client.c | 272 ++++++++++++++++++++++++++++++++++++++++++++++++
 net/Kconfig     |   2 +
 net/Makefile    |   1 +
 6 files changed, 367 insertions(+)
 create mode 100644 include/9p.h
 create mode 100644 net/9p/Kconfig
 create mode 100644 net/9p/Makefile
 create mode 100644 net/9p/client.c

diff --git a/include/9p.h b/include/9p.h
new file mode 100644
index 00000000000..5e46daa3414
--- /dev/null
+++ b/include/9p.h
@@ -0,0 +1,82 @@
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
+#define P9_DIRENT_OFFSET    21
+#define P9_DT_DIR           4
+
+struct p9_header {
+	u32 size;
+	u8  id;
+	u16 tag;
+} __packed;
+
+struct p9_client;
+
+struct p9_trans_ops {
+	int (*request)(struct p9_client *c, void *tx, int tx_len, void *rx, int rx_len);
+};
+
+struct p9_client {
+	const struct p9_trans_ops *ops;
+	void *priv;
+	u8 *tx;
+	u8 *rx;
+	u32 next_fid;
+};
+
+void p9_register_client(struct p9_client *c);
+struct p9_client *p9_get_client(void);
+
+u32 p9_client_alloc_fid(struct p9_client *c);
+int p9_client_version(struct p9_client *c);
+int p9_client_attach(struct p9_client *c, u32 fid, const char *uname, const char *aname);
+int p9_client_walk(struct p9_client *c, u32 base_fid, u32 new_fid, const char *path);
+int p9_client_lopen(struct p9_client *c, u32 fid, u32 flags);
+int p9_client_clunk(struct p9_client *c, u32 fid);
+int p9_client_stat(struct p9_client *c, u32 fid, loff_t *size);
+int p9_client_read(struct p9_client *c, u32 fid, u64 offset, u32 count, void *buf, u32 *actread);
+int p9_client_readdir(struct p9_client *c, u32 fid, u64 offset, u32 count, void *buf, u32 *actread);
+
+struct blk_desc;
+struct disk_partition;
+
+int p9_fs_probe(struct blk_desc *fs_dev_desc, struct disk_partition *fs_partition);
+int p9_fs_ls(const char *dirname);
+int p9_fs_exists(const char *filename);
+int p9_fs_size(const char *filename, loff_t *size);
+int p9_fs_read(const char *filename, void *buf, loff_t offset, loff_t len, loff_t *actread);
+
+#endif /* __9P_H__ */
diff --git a/net/9p/Kconfig b/net/9p/Kconfig
new file mode 100644
index 00000000000..3681e0b6d6d
--- /dev/null
+++ b/net/9p/Kconfig
@@ -0,0 +1,5 @@
+config NET_9P
+	bool "9P protocol support"
+	help
+	  This enables support for the 9P network protocol (9P2000).
+	  It implements the core 9P client and protocol handling.
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
index 00000000000..038cb7a78c0
--- /dev/null
+++ b/net/9p/client.c
@@ -0,0 +1,272 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026, Kuan-Wei Chiu <visitorckw@gmail.com>
+ */
+
+#include <9p.h>
+#include <config.h>
+#include <log.h>
+#include <malloc.h>
+#include <asm/cache.h>
+#include <asm/unaligned.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+static struct p9_client *current_client;
+
+void p9_register_client(struct p9_client *c)
+{
+	current_client = c;
+}
+
+struct p9_client *p9_get_client(void)
+{
+	return current_client;
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
+	put_unaligned_le64(v, *p); *p += 8;
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
+static int p9_check_error(struct p9_client *c, int expected_id, const char *step)
+{
+	struct p9_header *rx_hdr = (struct p9_header *)c->rx;
+	u32 ecode;
+
+	if (rx_hdr->id == P9_RLERROR) {
+		ecode = get_unaligned_le32(c->rx + 7);
+		log_err("9P Error: %s failed (ecode=%u)\n", step, ecode);
+		return -EIO;
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
+
+	if (!c->tx)
+		c->tx = memalign(ARCH_DMA_MINALIGN, P9_MSIZE);
+	if (!c->rx)
+		c->rx = memalign(ARCH_DMA_MINALIGN, P9_MSIZE);
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
+	if (c->ops->request(c, c->tx, hdr->size, c->rx, P9_MSIZE) < 0)
+		return -EIO;
+
+	return p9_check_error(c, P9_RVERSION, "Tversion");
+}
+
+int p9_client_attach(struct p9_client *c, u32 fid, const char *uname, const char *aname)
+{
+	struct p9_header *hdr = (struct p9_header *)c->tx;
+	u8 *ptr = c->tx + sizeof(*hdr);
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
+	if (c->ops->request(c, c->tx, hdr->size, c->rx, P9_MSIZE) < 0)
+		return -EIO;
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
+	int nwname = 0, i;
+
+	strlcpy(path_buf, path, sizeof(path_buf));
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
+	if (c->ops->request(c, c->tx, hdr->size, c->rx, P9_MSIZE) < 0)
+		return -EIO;
+
+	return p9_check_error(c, P9_RWALK, "Twalk");
+}
+
+int p9_client_lopen(struct p9_client *c, u32 fid, u32 flags)
+{
+	struct p9_header *hdr = (struct p9_header *)c->tx;
+	u8 *ptr = c->tx + sizeof(*hdr);
+
+	p9_put_u32(&ptr, fid);
+	p9_put_u32(&ptr, flags);
+
+	hdr->size = ptr - c->tx;
+	hdr->id = P9_TLOPEN;
+	hdr->tag = P9_REQ_TAG;
+
+	if (c->ops->request(c, c->tx, hdr->size, c->rx, P9_MSIZE) < 0)
+		return -EIO;
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
+	return c->ops->request(c, c->tx, hdr->size, c->rx, P9_MSIZE);
+}
+
+int p9_client_stat(struct p9_client *c, u32 fid, loff_t *size)
+{
+	struct p9_header *hdr = (struct p9_header *)c->tx;
+	u8 *ptr = c->tx + sizeof(*hdr);
+	u64 valid;
+
+	p9_put_u32(&ptr, fid);
+	p9_put_u64(&ptr, P9_GETATTR_SIZE);
+
+	hdr->size = ptr - c->tx;
+	hdr->id = P9_TGETATTR;
+	hdr->tag = P9_REQ_TAG;
+
+	if (c->ops->request(c, c->tx, hdr->size, c->rx, P9_MSIZE) < 0)
+		return -EIO;
+
+	if (p9_check_error(c, P9_RGETATTR, "Tgetattr") == 0) {
+		ptr = c->rx + sizeof(*hdr);
+		valid = get_unaligned_le64(ptr);
+		ptr += sizeof(valid);
+		ptr += P9_GETATTR_SIZE_OFFSET;
+		if (valid & P9_GETATTR_SIZE) {
+			*size = get_unaligned_le64(ptr);
+			return 0;
+		}
+	}
+	return -EIO;
+}
+
+int p9_client_read(struct p9_client *c, u32 fid, u64 offset, u32 count, void *buf, u32 *actread)
+{
+	struct p9_header *hdr = (struct p9_header *)c->tx;
+	u8 *ptr = c->tx + sizeof(*hdr);
+	u32 max_read = P9_MSIZE - 24;
+	u32 read_len = (count == 0 || count > max_read) ? max_read : count;
+
+	p9_put_u32(&ptr, fid);
+	p9_put_u64(&ptr, offset);
+	p9_put_u32(&ptr, read_len);
+
+	hdr->size = ptr - c->tx;
+	hdr->id = P9_TREAD;
+	hdr->tag = P9_REQ_TAG;
+
+	if (c->ops->request(c, c->tx, hdr->size, c->rx, P9_MSIZE) < 0)
+		return -EIO;
+
+	if (p9_check_error(c, P9_RREAD, "Tread") == 0) {
+		ptr = c->rx + sizeof(*hdr);
+		*actread = get_unaligned_le32(ptr);
+		ptr += 4;
+		memcpy(buf, ptr, *actread);
+		return 0;
+	}
+	return -EIO;
+}
+
+int p9_client_readdir(struct p9_client *c, u32 fid, u64 offset, u32 count, void *buf, u32 *actread)
+{
+	struct p9_header *hdr = (struct p9_header *)c->tx;
+	u8 *ptr = c->tx + sizeof(*hdr);
+
+	p9_put_u32(&ptr, fid);
+	p9_put_u64(&ptr, offset);
+	p9_put_u32(&ptr, count);
+
+	hdr->size = ptr - c->tx;
+	hdr->id = P9_TREADDIR;
+	hdr->tag = P9_REQ_TAG;
+
+	if (c->ops->request(c, c->tx, hdr->size, c->rx, P9_MSIZE) < 0)
+		return -EIO;
+
+	if (p9_check_error(c, P9_RREADDIR, "Treaddir") == 0) {
+		ptr = c->rx + sizeof(*hdr);
+		*actread = get_unaligned_le32(ptr);
+		ptr += 4;
+		memcpy(buf, ptr, *actread);
+		return 0;
+	}
+	return -EIO;
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
2.55.0.rc2.803.g1fd1e6609c-goog

