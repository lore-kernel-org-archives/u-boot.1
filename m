Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE958C43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 21:55:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDDCF8498C;
	Mon,  6 Jul 2026 23:55:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QwrViyBl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62AB784942; Mon,  6 Jul 2026 23:55:09 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CDE58494B
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 23:55:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c99eaa1f020so3620286a12.2
 for <u-boot@lists.denx.de>; Mon, 06 Jul 2026 14:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783374905; x=1783979705; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DhbkHKf1DFyEOgH7SOCgHV5fToqMoLikH+QUyivMids=;
 b=QwrViyBlkmJZjjOzivgujD+Ti2/imDdkJXs4yyZ7WPJuIeLNVW6gHssg802yJ3/Yhh
 pXA+5WviXtXpCG71kqOQxPP3s4rVfQANSLUI0g7jnOHONf2wzRScQ1ckM7w7m+egLK7w
 Qjcdb6cGEATaXmDKqz9dfOejPS3VbK2gs9ZDGRE85VrhRPuXYi71tCG3U2+YC48cwShm
 vqf7qIpq57gNw2j6OlIU6hqCAszMd3nbBePpnszvG+M0NHr9xGrs4awoi4CxwQuuSz2v
 g6bSxhP7/OnefwL7cQXTynj/oZXMVgaM44Dvp3KtxHzjUpqpavVITBH3I9tVcbB2XXh0
 VFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783374905; x=1783979705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DhbkHKf1DFyEOgH7SOCgHV5fToqMoLikH+QUyivMids=;
 b=dAMrZV/5I7OqTa9lSA+mVY/CsEPK0/1gK6e49NcrTDXejtviEN1AWC76wKV9V1tScz
 TFBg95h8aqob7AW27cBUrJEnkDSpvTMwh5QdumUtBiWPByTiJ2Hlo2BBkfnba+0RS4SO
 ztfW0zmKPkuSWqFFrqFOSNMkG1F4j7AyJ8tkn6ZHJTlTSSL72Lu7Va50+ZqLjLOtWiP8
 1ochJ4SB2bCrCsC+J41+muEimuvNVEqeWQCAHPzvtvaa5A5I3jFg5YJjFrKgLgNxLOik
 aKh90s5aoohIT8mLsGVuz4m1SM/1SICf8YrvbhiomzcjeKgC0XfJQzrm9cO6sLE7o0lR
 sgJg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpqbeQrCBvphz68+2nUt0DFQa50XDD6K4CDZ4/r7fVm5XXWwraRT9DlNjoTbn15POOZu7G3GEo=@lists.denx.de
X-Gm-Message-State: AOJu0YyLDr6fCyeUfi/nVl8HNSI34k4qqqJTnzZfGyGCsW7Ah6udbTVU
 j0B3pLRKFqjpPFazt43pzrj5FgVitJduUiUqKvsyPFBari6KcKJKpQeIveMSbw==
X-Gm-Gg: AfdE7cliSHQ5GvWb86eSoeHKSxfsMZxplHjXNvknwGXwgxpRMZ+YmIepZHKaqGIV1My
 rWBRQEi/ruM9Bs2GILEfHfHr1ykv6/U2HshXXG5t8AlgkUEpNneC5DTFfGePw0X81aBH5Hob7J+
 p2BwurDZDSn6Xm1ZZyj47mAjer2Of+BF2qlM/hJmeRsWohBXnHrN+rBS655H08gzVAm2qBtaFmi
 qhjxoGJOt8utIvO9ar7yqb2ECw4gUs5UGacwH5omwMwk7yhgYBYicnryKNZ9Q3INNCjW8zIXoIR
 CL8gKBpl4Pai1k7x61vs9jK3LVqaFDhDuyiYY09T4ie8Q3kHz7ooMEQHKBBwSlFFeVt5v0AluLH
 qWWw1WYzGVs8cTX6mWf6XfMft/54Krp6P4flsaHPERYKvg/ELrylTCs5qkxQ/+/2EJWRCD9wTiI
 /gEu9dCCzcVYdpDt7xv4cJwt3Oq0ygCVZ9d/SwTKbUTfovaBlG2kAAQLkrHmDt43icTyXKU5UbP
 gsazzQ2Bi8t
X-Received: by 2002:a05:6300:2206:b0:3b7:aefe:4367 with SMTP id
 adf61e73a8af0-3c08ee3949fmr2872632637.33.1783374905446; 
 Mon, 06 Jul 2026 14:55:05 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (32.237.80.34.bc.googleusercontent.com. [34.80.237.32])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174a56d64sm650864eec.17.2026.07.06.14.55.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 14:55:05 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: trini@konsulko.com, bmeng.cn@gmail.com, joe.hershberger@ni.com,
 rfried.dev@gmail.com, jerome.forissier@arm.com
Cc: jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com,
 u-boot@lists.denx.de, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 2/4] fs: 9p: Add 9P filesystem support
Date: Mon,  6 Jul 2026 21:54:44 +0000
Message-ID: <20260706215446.4068820-3-visitorckw@gmail.com>
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

Implement the VFS interface for the 9P filesystem.

Map the U-Boot filesystem operations to the underlying 9P protocol
client. It also registers the 9P filesystem type within the U-Boot
generic fs framework, allowing it to bypass standard block device
partition checks since 9P is a network/host-backed filesystem.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 fs/9p/9p.c     | 137 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/9p/Kconfig  |   8 +++
 fs/9p/Makefile |   5 ++
 fs/Kconfig     |   2 +
 fs/Makefile    |   1 +
 fs/fs.c        |  35 +++++++++++++
 include/fs.h   |   1 +
 7 files changed, 189 insertions(+)
 create mode 100644 fs/9p/9p.c
 create mode 100644 fs/9p/Kconfig
 create mode 100644 fs/9p/Makefile

diff --git a/fs/9p/9p.c b/fs/9p/9p.c
new file mode 100644
index 00000000000..37d60c03891
--- /dev/null
+++ b/fs/9p/9p.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026, Kuan-Wei Chiu <visitorckw@gmail.com>
+ */
+
+#include <9p.h>
+#include <config.h>
+#include <log.h>
+#include <asm/unaligned.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+static u32 p9_root_fid = 1;
+
+int p9_fs_probe(struct blk_desc *fs_dev_desc, struct disk_partition *fs_partition)
+{
+	struct p9_client *c = p9_get_client();
+
+	if (!c) {
+		log_err("9P Error: No transport client registered\n");
+		return -ENODEV;
+	}
+
+	if (p9_client_version(c))
+		return -EIO;
+	if (p9_client_attach(c, p9_root_fid, "root", ""))
+		return -EIO;
+
+	return 0;
+}
+
+int p9_fs_ls(const char *dirname)
+{
+	struct p9_client *c = p9_get_client();
+	u32 fid = p9_client_alloc_fid(c);
+	u8 buf[4096];
+	u32 actread;
+	u8 *ptr, *end;
+	u16 name_len;
+	u8 d_type;
+
+	if (p9_client_walk(c, p9_root_fid, fid, dirname))
+		return -ENOENT;
+	if (p9_client_lopen(c, fid, P9_O_RDONLY))
+		return -EIO;
+
+	if (p9_client_readdir(c, fid, 0, sizeof(buf), buf, &actread)) {
+		p9_client_clunk(c, fid);
+		return -EIO;
+	}
+
+	if (actread == 0) {
+		printf("  (empty directory)\n");
+	} else {
+		ptr = buf;
+		end = buf + actread;
+		while (ptr < end) {
+			ptr += P9_DIRENT_OFFSET;
+			d_type = *ptr++;
+			name_len = get_unaligned_le16(ptr);
+			ptr += 2;
+			printf("  %s %.*s\n", (d_type == P9_DT_DIR) ? "<DIR> " : "      ",
+			       name_len, ptr);
+			ptr += name_len;
+		}
+	}
+
+	p9_client_clunk(c, fid);
+	return 0;
+}
+
+int p9_fs_size(const char *filename, loff_t *size)
+{
+	struct p9_client *c = p9_get_client();
+	u32 fid = p9_client_alloc_fid(c);
+	int ret;
+
+	if (p9_client_walk(c, p9_root_fid, fid, filename))
+		return -ENOENT;
+	ret = p9_client_stat(c, fid, size);
+	p9_client_clunk(c, fid);
+
+	return ret;
+}
+
+int p9_fs_exists(const char *filename)
+{
+	loff_t size;
+
+	return (p9_fs_size(filename, &size) == 0) ? 1 : 0;
+}
+
+int p9_fs_read(const char *filename, void *buf, loff_t offset, loff_t len, loff_t *actread)
+{
+	struct p9_client *c = p9_get_client();
+	u32 fid = p9_client_alloc_fid(c);
+	u32 read_bytes = 0;
+	loff_t total_read = 0;
+	loff_t remaining;
+	u32 req_len;
+	u8 *dst = (u8 *)buf;
+	int ret = 0;
+
+	if (p9_client_walk(c, p9_root_fid, fid, filename))
+		return -ENOENT;
+	if (p9_client_lopen(c, fid, P9_O_RDONLY)) {
+		p9_client_clunk(c, fid);
+		return -EIO;
+	}
+
+	while (1) {
+		if (len == 0) {
+			req_len = 0;
+		} else {
+			remaining = len - total_read;
+			if (remaining == 0)
+				break;
+
+			req_len = (remaining > 0xFFFFFFFF) ? 0xFFFFFFFF : (u32)remaining;
+		}
+
+		ret = p9_client_read(c, fid, offset, req_len, dst, &read_bytes);
+
+		if (ret != 0 || read_bytes == 0)
+			break;
+
+		total_read += read_bytes;
+		offset += read_bytes;
+		dst += read_bytes;
+	}
+
+	*actread = total_read;
+	p9_client_clunk(c, fid);
+
+	return (total_read > 0 || ret == 0) ? 0 : ret;
+}
diff --git a/fs/9p/Kconfig b/fs/9p/Kconfig
new file mode 100644
index 00000000000..bc6d4962288
--- /dev/null
+++ b/fs/9p/Kconfig
@@ -0,0 +1,8 @@
+config FS_9P
+	bool "9P filesystem support"
+	depends on NET_9P
+	help
+	  This provides support for the 9P2000.L filesystem.
+
+	  To use this filesystem, you also need to enable a 9P
+	  transport driver.
diff --git a/fs/9p/Makefile b/fs/9p/Makefile
new file mode 100644
index 00000000000..c7f7553e8f4
--- /dev/null
+++ b/fs/9p/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2026, Kuan-Wei Chiu <visitorckw@gmail.com>
+
+obj-y += 9p.o
diff --git a/fs/Kconfig b/fs/Kconfig
index e0b0b901e1d..e4aa726ea35 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -26,4 +26,6 @@ source "fs/squashfs/Kconfig"
 
 source "fs/erofs/Kconfig"
 
+source "fs/9p/Kconfig"
+
 endmenu
diff --git a/fs/Makefile b/fs/Makefile
index ce5e74257a0..5aa34b39172 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -26,5 +26,6 @@ obj-$(CONFIG_CMD_UBIFS) += ubifs/
 obj-$(CONFIG_CMD_ZFS) += zfs/
 obj-$(CONFIG_FS_SQUASHFS) += squashfs/
 obj-$(CONFIG_FS_EROFS) += erofs/
+obj-$(CONFIG_FS_9P) += 9p/
 endif
 obj-y += fs_internal.o
diff --git a/fs/fs.c b/fs/fs.c
index 8ea50a6c13c..0bb996dede5 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -32,6 +32,7 @@
 #include <squashfs.h>
 #include <erofs.h>
 #include <exfat.h>
+#include <9p.h>
 
 static struct blk_desc *fs_dev_desc;
 static int fs_dev_part;
@@ -398,6 +399,26 @@ static struct fstype_info fstypes[] = {
 		.mkdir = exfat_fs_mkdir,
 		.rename = exfat_fs_rename,
 	},
+#endif
+#if CONFIG_IS_ENABLED(FS_9P)
+	{
+		.fstype = FS_TYPE_9P,
+		.name = "9p",
+		.null_dev_desc_ok = true,
+		.probe = p9_fs_probe,
+		.close = fs_close_unsupported,
+		.ls = p9_fs_ls,
+		.exists = p9_fs_exists,
+		.size = p9_fs_size,
+		.read = p9_fs_read,
+		.write = fs_write_unsupported,
+		.uuid = fs_uuid_unsupported,
+		.opendir = fs_opendir_unsupported,
+		.unlink = fs_unlink_unsupported,
+		.mkdir = fs_mkdir_unsupported,
+		.ln = fs_ln_unsupported,
+		.rename = fs_rename_unsupported,
+	},
 #endif
 	{
 		.fstype = FS_TYPE_ANY,
@@ -464,6 +485,20 @@ int fs_set_blk_dev(const char *ifname, const char *dev_part_str, int fstype)
 	struct fstype_info *info;
 	int part, i;
 
+	/* Intercept 9p to bypass block device partition checks */
+	if (CONFIG_IS_ENABLED(FS_9P) && !strncmp(ifname, "9p", 2)) {
+		for (i = 0, info = fstypes; i < ARRAY_SIZE(fstypes); i++, info++) {
+			if (info->fstype == FS_TYPE_9P) {
+				fs_dev_desc = NULL;
+				fs_type = FS_TYPE_9P;
+				if (info->probe(fs_dev_desc, NULL))
+					return -1;
+				return 0;
+			}
+		}
+		return -1;
+	}
+
 	part = part_get_info_by_dev_and_name_or_num(ifname, dev_part_str, &fs_dev_desc,
 						    &fs_partition, 1);
 	if (part < 0)
diff --git a/include/fs.h b/include/fs.h
index bec02117737..8afc81c0017 100644
--- a/include/fs.h
+++ b/include/fs.h
@@ -19,6 +19,7 @@ struct cmd_tbl;
 #define FS_TYPE_EROFS   7
 #define FS_TYPE_SEMIHOSTING 8
 #define FS_TYPE_EXFAT   9
+#define FS_TYPE_9P      10
 
 struct blk_desc;
 
-- 
2.55.0.rc2.803.g1fd1e6609c-goog

