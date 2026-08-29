Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3424AC61DCB
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 19:21:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 73D256062A;
	Sat, 29 Aug 2026 19:21:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id amIkOnzA6Bfi; Sat, 29 Aug 2026 19:21:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788031300;
	bh=pLY/GTjNHlhcYVr8KD8tZK3f+Sn1CCmjA53D3N/KWY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fma2TJ+Hyo228ElFrYh9MLkQ1dlsGxt7Fde6b43yAW2h8MM2qkraxvQQe3rnCOTBs
	 21/IztjL/Jc8CyJmphebT1okvWAkg91nMBviIVuAKfJAGgxhyb7fvB9G5NfFNzv4OM
	 hMZKXdBI20oMKweUo1K32v6/ymAZ0fPz7okIZoXNlWj8JXu1T0gsEYNrou9uyTUpuB
	 zdOL3E1qlKSrvd6TBnvb+Fd909rccnmaycBEmhC63XjnjlDd+J4EGSFpCuRTI9DH+8
	 kXcwoYKR8CSXDwNGwMGhctRxrSmv8AU4Et69Z3J4hOmLiOfgWO+JTlLc2rGghFtgbM
	 mXL6CWzN+Jl0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6EFDB6060E;
	Sat, 29 Aug 2026 19:21:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 95C1F118
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 19:21:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7C66440755
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 19:21:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TG3Cf5cFQE4F for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 19:21:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=r5GN6xz4
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 92CCC40730
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 19:21:38 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-383b4a3755fso2488574a91.3
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 12:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788031297; x=1788636097;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pLY/GTjNHlhcYVr8KD8tZK3f+Sn1CCmjA53D3N/KWY0=;
 b=r5GN6xz48BbrkAELyhW1GfvOMG/KOYAJScYU1Y1KPq/j2AgAzqng+LZTHmwEJvANmn
 Vbl5cPJ/QMJh7LOkKL2uJVx0PilR1nz9OgiuiATv3ZWcRIYijlS9NQFb0DROkmIKdymq
 rs4f4dV40+EanHzUyK8EhVJhWdHS0f0YYGSkel5TIifaoNaUqDg5E/uv9OddUJuNo0BV
 Nl4MSZfeQvVR5gsa0aXInB1JoXASy1PELSA4DCRmt0JifDGVQSfi9GHqorrWYy27T1sc
 LTaBTge9iBvKPZKJD02jd8Tx88in+pwJI8IvSurDsK2kiPmfFYcoR2v4cE2I/8GAJLRD
 dazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788031297; x=1788636097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pLY/GTjNHlhcYVr8KD8tZK3f+Sn1CCmjA53D3N/KWY0=;
 b=YzfxarCIu6Y9Zu2s5MGtCzhKzdO3FE8k+LT1w4H0j2J9VgMrmPOMCEci3vrlmmSE1O
 +jyfd2cwjx3WZCm77clK45mR2kb5j897do6YGmYDbywiOlXlMTKGYBTCsSqMbwdR0YLn
 gDn/sHYGFuYbINuZwWj71RbDDA55FDkBCtSQVWVqBEolC1Q0drChF6reHrlqwIp+f4IP
 shIC9RrQHFFesJJoyT5B+aZwKGYITkq+u7b9QU78O6lT2QxYihMfIK8Hx64cppncUgrb
 29l+99Pqu/JtsvXeOX0XNEFDXDLg6QflQXsAX5LnF7rDe9q4nsLnuRz+suOM8q+Mgq9n
 YRRw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxmJOi894PQVEiR1ntipU+onxwm+ch1//Yg/9Q6KYdC3NkgXuMJSnFkRhKupDmNCuxHLRXuuSc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nYcRjPHCiMdikE4Q6LW+C6zeWhbMmzSK32sSwP9mvGUdeVPeVG
 htB5Q2JUqT11HJENuiZa/TZTZ8ipZHdDVXX2ebpzKGzPt2q58oco8xxt
X-Gm-Gg: AYBFou1QXLnoKtvx1KDUurerhSaOiVsnCHpkestowVEILki6dgPlEZ65uThBghZyEKm
 0X0Q0Vm91qJVZpeiRIwk058axfeZiz34VycnprwwTvMW7d8teZCBMpA6bjoZ11kMl6kGakIMw0D
 e1wCgrr9Wf62JTxyvYx0dAFIeXTLFhMSHWN2W4NABlrDxzCq3EFRTnIsDlzViXebZDnpO/2sVvB
 EskD66J/rOZsusl+Ru/4QlfHPxOQzvOGgllHSSb1zbcwUxdTQdzR7Pe43NuwoRzV6zcASt1jIxA
 VR4zkvr2K5NqHFiip1klKhCjwyTBikkpI75a7cq0+bxjIL/RqzmDFyeyX3AtAHvAn5M9K14H1zr
 PC/HHFIl5Xl9ka8HE7o4mlbgJAwNmBTxvT6VISfjYXwOQcIXfgF4QMXFrkjM/87wTCFTVAeswgK
 s1MwczodDn0VHSZnTs4HnQ/8GbSZWcfmEHIDNQSeXCa87c+IDV8tUAtgUoK6dUUCEBVIc2fetgv
 F4JaIhMKis+CYng9F/u6ag8bXP4L6htEYaxHIUJAoVl9/5jImbS+lgzikTBIhDvig==
X-Received: by 2002:a17:90b:49:b0:398:9be5:b41d with SMTP id
 98e67ed59e1d1-3989be5b4e2mr13351440a91.24.1788031297370; 
 Sat, 29 Aug 2026 12:21:37 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (184.247.229.35.bc.googleusercontent.com. [35.229.247.184])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0ea7fa9sm12837034a91.4.2026.08.29.12.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2026 12:21:37 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: trini@konsulko.com, tuomas.tynkkynen@iki.fi, bmeng.cn@gmail.com,
 sjg@chromium.org, jerome.forissier@arm.com
Cc: jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com,
 u-boot@lists.u-boot-project.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 2/6] fs: 9p: Add 9P filesystem support
Date: Sat, 29 Aug 2026 19:21:15 +0000
Message-ID: <20260829192119.2658328-3-visitorckw@gmail.com>
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

Implement the VFS interface for the 9P filesystem.

Map VFS operations to the underlying 9P protocol client and register
the 9P filesystem type, allowing access without traditional block
device partition tables.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v2:
- Add pseudo block device "9p" handling in disk/part.c.
- Look up 9P transport device via DM UCLASS_9P by mount tag or index.
- Add p9_client_clunk() calls on open failure.
- Dynamically allocate readdir buffer and implement pagination loop.
- Propagate return error code in p9_fs_read().
---
 disk/part.c    |  16 +++++
 fs/9p/9p.c     | 185 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/9p/Kconfig  |   8 +++
 fs/9p/Makefile |   5 ++
 fs/Kconfig     |   2 +
 fs/Makefile    |   1 +
 fs/fs.c        |  25 +++++++
 include/9pfs.h |  60 ++++++++++++++++
 include/fs.h   |   1 +
 9 files changed, 303 insertions(+)
 create mode 100644 fs/9p/9p.c
 create mode 100644 fs/9p/Kconfig
 create mode 100644 fs/9p/Makefile
 create mode 100644 include/9pfs.h

diff --git a/disk/part.c b/disk/part.c
index 4923dc44593..8fa1dfd4c19 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -482,6 +482,22 @@ int blk_get_device_part_str(const char *ifname, const char *dev_part_str,
 	}
 #endif
 
+#if IS_ENABLED(CONFIG_FS_9P)
+	/*
+	 * Special-case a pseudo block device "9p", to allow access to the
+	 * 9P filesystem.
+	 */
+	if (!strcmp(ifname, "9p")) {
+		strcpy((char *)info->type, BOOT_PART_TYPE);
+		if (dev_part_str)
+			strlcpy((char *)info->name, dev_part_str, sizeof(info->name));
+		else
+			strcpy((char *)info->name, "9P filesystem");
+
+		return 0;
+	}
+#endif
+
 #if IS_ENABLED(CONFIG_CMD_UBIFS) && !IS_ENABLED(CONFIG_XPL_BUILD)
 	/*
 	 * Special-case ubi, ubi goes through a mtd, rather than through
diff --git a/fs/9p/9p.c b/fs/9p/9p.c
new file mode 100644
index 00000000000..41d46b7328e
--- /dev/null
+++ b/fs/9p/9p.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026, Kuan-Wei Chiu <visitorckw@gmail.com>
+ */
+
+#include <9p.h>
+#include <9pfs.h>
+#include <dm.h>
+#include <log.h>
+#include <malloc.h>
+#include <part.h>
+#include <asm/unaligned.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+static u32 p9_root_fid = 1;
+static struct p9_client *current_p9_client;
+
+int p9_fs_set_blk_dev(struct blk_desc *fs_dev_desc, struct disk_partition *fs_partition)
+{
+	const char *tag = NULL;
+	struct udevice *dev;
+	struct p9_client *c;
+	int ret;
+
+	if (fs_partition && fs_partition->name[0])
+		tag = (const char *)fs_partition->name;
+
+	ret = p9_get_device(tag, &dev);
+	if (ret) {
+		log_err("9P Error: No matching 9P transport device found for '%s'\n",
+			tag ? tag : "-");
+		return ret;
+	}
+
+	c = p9_get_client(dev);
+	if (!c)
+		return -ENODEV;
+
+	if (p9_client_version(c))
+		return -EIO;
+	if (p9_client_attach(c, p9_root_fid, "root", ""))
+		return -EIO;
+
+	current_p9_client = c;
+	return 0;
+}
+
+int p9_fs_ls(const char *dirname)
+{
+	struct p9_client *c = current_p9_client;
+	u32 fid;
+	u8 *buf, *ptr, *end;
+	u32 actread;
+	u64 offset = 0;
+	int count = 0;
+	int ret;
+
+	if (!c)
+		return -ENODEV;
+
+	fid = p9_client_alloc_fid(c);
+	if (p9_client_walk(c, p9_root_fid, fid, dirname))
+		return -ENOENT;
+	if (p9_client_lopen(c, fid, P9_O_RDONLY)) {
+		p9_client_clunk(c, fid);
+		return -EIO;
+	}
+
+	buf = malloc(4096);
+	if (!buf) {
+		p9_client_clunk(c, fid);
+		return -ENOMEM;
+	}
+
+	while (1) {
+		ret = p9_client_readdir(c, fid, offset, 4096, buf, &actread);
+		if (ret || actread == 0)
+			break;
+
+		ptr = buf;
+		end = buf + actread;
+		while (ptr + sizeof(struct p9_dirent_hdr) <= end) {
+			struct p9_dirent_hdr *entry = (struct p9_dirent_hdr *)ptr;
+			u64 next_offset = get_unaligned_le64(&entry->offset);
+			u8 d_type = entry->type;
+			u16 name_len = get_unaligned_le16(&entry->name_len);
+			const char *name = (const char *)(entry + 1);
+
+			if (ptr + sizeof(struct p9_dirent_hdr) + name_len > end)
+				break;
+			printf("  %s %.*s\n", (d_type == P9_DT_DIR) ? "<DIR> " : "      ",
+			       name_len, name);
+			offset = next_offset;
+			ptr += sizeof(struct p9_dirent_hdr) + name_len;
+			count++;
+		}
+	}
+
+	free(buf);
+	p9_client_clunk(c, fid);
+
+	if (ret)
+		return ret;
+
+	if (count == 0)
+		printf("  (empty directory)\n");
+
+	return 0;
+}
+
+int p9_fs_size(const char *filename, loff_t *size)
+{
+	struct p9_client *c = current_p9_client;
+	u32 fid;
+	int ret;
+
+	if (!c)
+		return -ENODEV;
+
+	fid = p9_client_alloc_fid(c);
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
+	struct p9_client *c = current_p9_client;
+	u32 fid;
+	u32 read_bytes = 0;
+	loff_t total_read = 0;
+	loff_t remaining;
+	u32 req_len;
+	u8 *dst = (u8 *)buf;
+	int ret = 0;
+
+	if (!c)
+		return -ENODEV;
+
+	fid = p9_client_alloc_fid(c);
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
+	return ret ? ret : 0;
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
index 2824c7defa2..b18ccec8cb4 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -32,6 +32,7 @@
 #include <squashfs.h>
 #include <erofs.h>
 #include <exfat.h>
+#include <9pfs.h>
 
 static struct blk_desc *fs_dev_desc;
 static int fs_dev_part;
@@ -400,6 +401,26 @@ static struct fstype_info fstypes[] = {
 		.mkdir = exfat_fs_mkdir,
 		.rename = exfat_fs_rename,
 	},
+#endif
+#if CONFIG_IS_ENABLED(FS_9P)
+	{
+		.fstype = FS_TYPE_9P,
+		.name = "9p",
+		.null_dev_desc_ok = true,
+		.probe = p9_fs_set_blk_dev,
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
@@ -501,11 +522,15 @@ int fs_set_blk_dev(const char *ifname, const char *dev_part_str, int fstype)
 	if (info) {
 		fs_dev_desc = NULL;
 		memset(&fs_partition, 0, sizeof(fs_partition));
+		if (dev_part_str)
+			strlcpy((char *)fs_partition.name, dev_part_str,
+				sizeof(fs_partition.name));
 		if (!info->probe(NULL, &fs_partition)) {
 			fs_type = info->fstype;
 			fs_dev_part = 0;
 			return 0;
 		}
+		return -1;
 	}
 
 	part = part_get_info_by_dev_and_name_or_num(ifname, dev_part_str, &fs_dev_desc,
diff --git a/include/9pfs.h b/include/9pfs.h
new file mode 100644
index 00000000000..130cb06ac3c
--- /dev/null
+++ b/include/9pfs.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2026, Kuan-Wei Chiu <visitorckw@gmail.com>
+ */
+
+#ifndef __9PFS_H__
+#define __9PFS_H__
+
+#include <linux/types.h>
+
+struct blk_desc;
+struct disk_partition;
+
+/**
+ * p9_fs_set_blk_dev() - Set/probe block device for 9P filesystem
+ * @fs_dev_desc: Block device descriptor (expected NULL for pseudo dev)
+ * @fs_partition: Disk partition information
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int p9_fs_set_blk_dev(struct blk_desc *fs_dev_desc, struct disk_partition *fs_partition);
+
+/**
+ * p9_fs_ls() - List files in a directory
+ * @dirname: Path to directory
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int p9_fs_ls(const char *dirname);
+
+/**
+ * p9_fs_exists() - Check if a file exists
+ * @filename: Path to file
+ *
+ * Return: 1 if file exists, 0 otherwise
+ */
+int p9_fs_exists(const char *filename);
+
+/**
+ * p9_fs_size() - Get size of a file
+ * @filename: Path to file
+ * @size: Output pointer for size
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int p9_fs_size(const char *filename, loff_t *size);
+
+/**
+ * p9_fs_read() - Read file content into memory
+ * @filename: Path to file
+ * @buf: Destination memory buffer
+ * @offset: Byte offset within file
+ * @len: Maximum bytes to read (0 for entire file)
+ * @actread: Output pointer for actual bytes read
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int p9_fs_read(const char *filename, void *buf, loff_t offset, loff_t len, loff_t *actread);
+
+#endif /* __9PFS_H__ */
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
2.55.0.897.gb25b4bd76c-goog

