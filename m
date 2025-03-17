Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3145DC35FF1
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 03:16:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFADE8197F;
	Mon, 17 Mar 2025 04:15:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742181305;
	bh=LzahNAZBUoncSzaLT/43NR29RVcU5NHfiY5ZfPx8RJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fRrYna8/cS5UKAeefrN9TUFXPwSy5sXEAa1PFcZPvqtSXuGVRwLzHncZ6BQAWKH48
	 1mFvbDfqzKYNRqNv7iXXZxnPUKBvPrGt+vHfq7kA+YstD7gc58jbB869pGQxBV6N8E
	 8S0oEbKA/A+U+rkapun5aBSIxSwU+FJ09NOM74SiXIYspF+aOlCDygo74uEpDIZtRt
	 TvrgN47C+mPlSn8Jmf6qQIL0HedHGaAH3LcquVfXG8WlTlDEYq0EoDhcpnIhs/glNE
	 4xWuCDt9+4BHW1mFzsnFDhsa9lVd3xa05/AhimMx7u+5bghvioNy5Z2v68A8CKq+rm
	 f6qSeP4Km1xDQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACCA581101; Mon, 17 Mar 2025 04:15:04 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 946B781100
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 04:15:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="AFYYdk5o"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2F020101F71C1; Mon, 17 Mar 2025 04:14:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742181300; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=LzahNAZBUoncSzaLT/43NR29RVcU5NHfiY5ZfPx8RJU=;
 b=AFYYdk5oK0RktJ+ro7Q7NOfXg9AIiBzCFzDrDHqDHIkNtuks8yXkYH6IrCZ2THxbHKquC5
 RnlDYyEutiH1RJZZLmeKjzWvHdlZI15mzl7prF2jBamPszRAguO6v/fkEEw93oC/B76oBC
 eBukdEytCWCX4LD0GjzoP4itjoKHPHkTaX0WzwRrgwDU5EuMzVEWMViYOXo/s2b59at7yN
 bTEmBoJs1uMJjTkRK/CtNNz5rvcSDPE6VqCta1lX0uqJuThfI0BUtAPd2iARwOgv+bMG1R
 ARP10k6mu/uvqC6M5CXAgpRi9y9D5N4pRuGJ1lL/xOQlDTTSrR/CDihUNqV2Jw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Baruch Siach <baruch@tkos.co.il>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 07/11] fs: exfat: Add U-Boot porting layer
Date: Mon, 17 Mar 2025 04:12:46 +0100
Message-ID: <20250317031418.223019-8-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250317031418.223019-1-marex@denx.de>
References: <20250317031418.223019-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Add U-Boot adjustments to the libexfat code and integrate
the result into U-Boot filesystem layer. This provides full
read-write exfat support for U-Boot available via generic
filesystem interface.

FS_DIRENT_NAME_LEN is increased to 1024 in case exfat is
enabled, because EXFAT can use UTF16 names, which do not
fit into current FS_DIRENT_NAME_LEN. To avoid affecting
every configuration, increase FS_DIRENT_NAME_LEN only in
case EXFAT is enabled.

Example usage via sandbox, assuming disk.img with one exfat partition:

Drive info:
$ ./u-boot -Tc 'host bind 0 ../disk.img ; host info 0'
dev       blocks  blksz label           path
  0       262144    512 0               ../disk.img

List files:
$ ./u-boot -Tc 'host bind 0 ../disk.img ; ls host 0:1 /api'
      475   Kconfig
      230   Makefile
     1873   README
     ...
10 file(s), 0 dir(s)

Load and checksum a file:
$ ./u-boot -Tc 'host bind 0 ../disk.img ; load host 0:1 $loadaddr .config ; \
                crc32 $loadaddr $filesize'
56724 bytes read in 1 ms (54.1 MiB/s)
crc32 for 00000000 ... 0000dd93 ==> b2e847c9

$ crc32 .config
b2e847c9

Load .config file to RAM, store the file into FS as /newconfig,
load the /newconfig into RAM and checksum the file:
$ ./u-boot -Tc 'host bind 0 ../disk.img ; load host 0:1 $loadaddr .config ; \
		save host 0:1 $loadaddr /newconfig $filesize ; \
		load host 0:1 0x10000 /newconfig ; \
		crc32 0x10000 $filesize'
56724 bytes read in 1 ms (54.1 MiB/s)
56724 bytes written in 0 ms
56724 bytes read in 0 ms
crc32 for 00010000 ... 0001dd93 ==> b2e847c9

Remove file 3.txt and create new directory /newdir:
$ ./u-boot -Tc 'host bind 0 ../disk.img ; ls host 0:1 / ; \
                rm host 0:1 3.txt ; mkdir host 0:1 /newdir ; \
		ls host 0:1 /'
...
        0   1.txt
        0   2.txt
        0   3.txt
        0   4.txt
        0   5.txt

7 file(s), 4 dir(s)
...
        0   1.txt
        0   2.txt
            newdir/
        0   4.txt
        0   5.txt

6 file(s), 5 dir(s)

Acked-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Baruch Siach <baruch@tkos.co.il>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Hiago De Franco <hiago.franco@toradex.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Nam Cao <namcao@linutronix.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: - Update Kconfig, imply CMD_FS_GENERIC if CMDLINE
    - Update Makefile to use obj .. +=
V3: - Add AB from Tom
---
 fs/Kconfig          |   2 +
 fs/Makefile         |   1 +
 fs/exfat/Kconfig    |   5 +
 fs/exfat/Makefile   |  13 ++
 fs/exfat/exfat.h    |  11 +
 fs/exfat/exfatfs.h  |  19 ++
 fs/exfat/io.c       | 486 ++++++++++++++++++++++++++++++++++++++++++++
 fs/exfat/lookup.c   |   3 +
 fs/exfat/mount.c    |   2 +
 fs/exfat/platform.h |   2 +
 fs/exfat/repair.c   |  13 ++
 fs/exfat/time.c     |   2 +
 fs/fs.c             |  22 ++
 include/exfat.h     |  24 +++
 include/fs.h        |   3 +-
 15 files changed, 607 insertions(+), 1 deletion(-)
 create mode 100644 fs/exfat/Kconfig
 create mode 100644 fs/exfat/Makefile
 create mode 100644 include/exfat.h

diff --git a/fs/Kconfig b/fs/Kconfig
index 5e83cb27059..e0b0b901e1d 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -8,6 +8,8 @@ source "fs/btrfs/Kconfig"
 
 source "fs/cbfs/Kconfig"
 
+source "fs/exfat/Kconfig"
+
 source "fs/ext4/Kconfig"
 
 source "fs/fat/Kconfig"
diff --git a/fs/Makefile b/fs/Makefile
index 1c2ff180bda..ce5e74257a0 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -16,6 +16,7 @@ obj-y				+= fs.o
 obj-$(CONFIG_FS_BTRFS) += btrfs/
 obj-$(CONFIG_FS_CBFS) += cbfs/
 obj-$(CONFIG_CMD_CRAMFS) += cramfs/
+obj-$(CONFIG_FS_EXFAT) += exfat/
 obj-$(CONFIG_FS_EXT4) += ext4/
 obj-$(CONFIG_FS_FAT) += fat/
 obj-$(CONFIG_FS_JFFS2) += jffs2/
diff --git a/fs/exfat/Kconfig b/fs/exfat/Kconfig
new file mode 100644
index 00000000000..bce61e8fcc7
--- /dev/null
+++ b/fs/exfat/Kconfig
@@ -0,0 +1,5 @@
+config FS_EXFAT
+	bool "Enable EXFAT filesystem support"
+	imply CMD_FS_GENERIC if CMDLINE
+	help
+	  This provides read/write support for EXFAT filesystem.
diff --git a/fs/exfat/Makefile b/fs/exfat/Makefile
new file mode 100644
index 00000000000..550c0683d65
--- /dev/null
+++ b/fs/exfat/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+
+obj-$(CONFIG_FS_EXFAT) += \
+	cluster.o \
+	io.o \
+	lookup.o \
+	mount.o \
+	node.o \
+	repair.o \
+	time.o \
+	utf.o \
+	utils.o
diff --git a/fs/exfat/exfat.h b/fs/exfat/exfat.h
index 0e146e8f4d9..cce3e3021ca 100644
--- a/fs/exfat/exfat.h
+++ b/fs/exfat/exfat.h
@@ -34,8 +34,10 @@
 #include <stdlib.h>
 #include <time.h>
 #include <stdbool.h>
+#ifndef __UBOOT__
 #include <sys/stat.h>
 #include <sys/types.h>
+#endif
 
 #define EXFAT_NAME_MAX 255
 /* UTF-16 encodes code points up to U+FFFF as single 16-bit code units.
@@ -51,7 +53,9 @@
 
 #define MIN(a, b) ((a) < (b) ? (a) : (b))
 #define MAX(a, b) ((a) > (b) ? (a) : (b))
+#ifndef __UBOOT__
 #define DIV_ROUND_UP(x, d) (((x) + (d) - 1) / (d))
+#endif
 #define ROUND_UP(x, d) (DIV_ROUND_UP(x, d) * (d))
 
 #define BMAP_SIZE(count) (ROUND_UP(count, sizeof(bitmap_t) * 8) / 8)
@@ -145,10 +149,17 @@ struct exfat_human_bytes
 extern int exfat_errors;
 extern int exfat_errors_fixed;
 
+#ifdef __UBOOT__
+#define exfat_bug(fmt, args...)		log_crit(fmt, ##args)
+#define exfat_error(fmt, args...)	log_err(fmt, ##args)
+#define exfat_warn(fmt, args...)	log_warning(fmt, ##args)
+#define exfat_debug(fmt, args...)	log_debug(fmt, ##args)
+#else
 void exfat_bug(const char* format, ...) PRINTF NORETURN;
 void exfat_error(const char* format, ...) PRINTF;
 void exfat_warn(const char* format, ...) PRINTF;
 void exfat_debug(const char* format, ...) PRINTF;
+#endif
 
 struct exfat_dev* exfat_open(const char* spec, enum exfat_mode mode);
 int exfat_close(struct exfat_dev* dev);
diff --git a/fs/exfat/exfatfs.h b/fs/exfat/exfatfs.h
index 3618d4d3024..fa59aab47b6 100644
--- a/fs/exfat/exfatfs.h
+++ b/fs/exfat/exfatfs.h
@@ -23,6 +23,25 @@
 #ifndef EXFATFS_H_INCLUDED
 #define EXFATFS_H_INCLUDED
 
+#ifdef __UBOOT__
+#include <linux/stat.h>
+#include <linux/types.h>
+#include <log.h>
+#include <stdint.h>
+#include <vsprintf.h>
+
+struct timespec {
+	time_t	tv_sec;		/* seconds */
+	long	tv_nsec;	/* nanoseconds */
+};
+
+#define time(t)		1741234567	/* Thu Mar  6 05:16:07 CET 2025 */
+#define geteuid(n)	1000
+#define getegid(n)	1000
+#define strtol(n, e, b)	simple_strtol(n, e, b)
+#define off_t		unsigned long long
+#endif
+
 #include "byteorder.h"
 #include "compiler.h"
 
diff --git a/fs/exfat/io.c b/fs/exfat/io.c
index 7af5316da70..81e82829c72 100644
--- a/fs/exfat/io.c
+++ b/fs/exfat/io.c
@@ -22,6 +22,7 @@
 
 #include "exfat.h"
 #include <inttypes.h>
+#ifndef __UBOOT__
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
@@ -44,6 +45,16 @@
 #include <sys/uio.h>
 #include <ublio.h>
 #endif
+#else
+#include <fs.h>
+#include <fs_internal.h>
+
+static struct exfat_ctxt {
+	struct disk_partition	cur_part_info;
+	struct blk_desc		*cur_dev;
+	struct exfat		ef;
+} ctxt;
+#endif
 
 struct exfat_dev
 {
@@ -54,8 +65,12 @@ struct exfat_dev
 	off_t pos;
 	ublio_filehandle_t ufh;
 #endif
+#ifdef __UBOOT__
+	struct exfat_ctxt *ctxt;
+#endif
 };
 
+#ifndef __UBOOT__
 static bool is_open(int fd)
 {
 	return fcntl(fd, F_GETFD) != -1;
@@ -386,6 +401,74 @@ ssize_t exfat_pwrite(struct exfat_dev* dev, const void* buffer, size_t size,
 	return pwrite(dev->fd, buffer, size, offset);
 #endif
 }
+#else	/* U-Boot */
+struct exfat_dev* exfat_open(const char* spec, enum exfat_mode mode)
+{
+	struct exfat_dev* dev;
+
+	dev = malloc(sizeof(struct exfat_dev));
+	if (!dev) {
+		exfat_error("failed to allocate memory for device structure");
+		return NULL;
+	}
+	dev->mode = EXFAT_MODE_RW;
+	dev->size = ctxt.cur_part_info.size * ctxt.cur_part_info.blksz;
+	dev->ctxt = &ctxt;
+
+	return dev;
+}
+
+int exfat_close(struct exfat_dev* dev)
+{
+	free(dev);
+	return 0;
+}
+
+int exfat_fsync(struct exfat_dev* dev)
+{
+	return 0;
+}
+
+enum exfat_mode exfat_get_mode(const struct exfat_dev* dev)
+{
+	return dev->mode;
+}
+
+off_t exfat_get_size(const struct exfat_dev* dev)
+{
+	return dev->size;
+}
+
+ssize_t exfat_pread(struct exfat_dev* dev, void* buffer, size_t size,
+		off_t offset)
+{
+	lbaint_t sect = offset >> ctxt.cur_dev->log2blksz;
+	int off = offset & (ctxt.cur_dev->blksz - 1);
+
+	if (!ctxt.cur_dev)
+		return -EIO;
+
+	if (fs_devread(ctxt.cur_dev, &ctxt.cur_part_info, sect,
+		       off, size, buffer))
+		return 0;
+	return -EIO;
+}
+
+ssize_t exfat_pwrite(struct exfat_dev* dev, const void* buffer, size_t size,
+		off_t offset)
+{
+	lbaint_t sect = offset >> ctxt.cur_dev->log2blksz;
+	int off = offset & (ctxt.cur_dev->blksz - 1);
+
+	if (!ctxt.cur_dev)
+		return -EIO;
+
+	if (fs_devwrite(ctxt.cur_dev, &ctxt.cur_part_info, sect,
+		       off, size, buffer))
+		return 0;
+	return -EIO;
+}
+#endif
 
 ssize_t exfat_generic_pread(const struct exfat* ef, struct exfat_node* node,
 		void* buffer, size_t size, off_t offset)
@@ -512,3 +595,406 @@ ssize_t exfat_generic_pwrite(struct exfat* ef, struct exfat_node* node,
 		exfat_update_mtime(node);
 	return size - remainder;
 }
+
+#ifdef __UBOOT__
+struct exfat_dir_stream {
+	struct fs_dir_stream fs_dirs;
+	struct fs_dirent dirent;
+
+	struct exfat_node* node;
+	struct exfat_iterator it;
+	/* State tracker flags for emulated . and .. dirents */
+	bool dot;
+	bool dotdot;
+};
+
+int exfat_fs_probe(struct blk_desc *fs_dev_desc,
+		struct disk_partition *fs_partition)
+{
+	int ret;
+
+	ctxt.cur_dev = fs_dev_desc;
+	ctxt.cur_part_info = *fs_partition;
+
+	ret = exfat_mount(&ctxt.ef, NULL, "");
+	if (ret)
+		goto error;
+
+	return 0;
+error:
+	ctxt.cur_dev = NULL;
+	return ret;
+}
+
+#define PATH_MAX FS_DIRENT_NAME_LEN
+
+/* Adapted from uclibc 1.0.35 */
+static char *exfat_realpath(const char *path, char got_path[])
+{
+	char copy_path[PATH_MAX];
+	char *max_path, *new_path;
+	size_t path_len;
+
+	if (path == NULL)
+		return NULL;
+
+	if (*path == '\0')
+		return NULL;
+
+	/* Make a copy of the source path since we may need to modify it. */
+	path_len = strlen(path);
+	if (path_len >= PATH_MAX - 2)
+		return NULL;
+
+	/* Copy so that path is at the end of copy_path[] */
+	strcpy(copy_path + (PATH_MAX-1) - path_len, path);
+	path = copy_path + (PATH_MAX-1) - path_len;
+	max_path = got_path + PATH_MAX - 2; /* points to last non-NUL char */
+	new_path = got_path;
+	*new_path++ = '/';
+	path++;
+
+	/* Expand each slash-separated pathname component. */
+	while (*path != '\0') {
+		/* Ignore stray "/". */
+		if (*path == '/') {
+			path++;
+			continue;
+		}
+
+		if (*path == '.') {
+			/* Ignore ".". */
+			if (path[1] == '\0' || path[1] == '/') {
+				path++;
+				continue;
+			}
+
+			if (path[1] == '.') {
+				if (path[2] == '\0' || path[2] == '/') {
+					path += 2;
+					/* Ignore ".." at root. */
+					if (new_path == got_path + 1)
+						continue;
+					/* Handle ".." by backing up. */
+					while ((--new_path)[-1] != '/')
+						;
+					continue;
+				}
+			}
+		}
+
+		/* Safely copy the next pathname component. */
+		while (*path != '\0' && *path != '/') {
+			if (new_path > max_path)
+				return NULL;
+			*new_path++ = *path++;
+		}
+
+		*new_path++ = '/';
+	}
+
+	/* Delete trailing slash but don't whomp a lone slash. */
+	if (new_path != got_path + 1 && new_path[-1] == '/')
+		new_path--;
+
+	/* Make sure it's null terminated. */
+	*new_path = '\0';
+	return got_path;
+}
+
+int exfat_lookup_realpath(struct exfat* ef, struct exfat_node** node,
+			  const char* path)
+{
+	char input_path[FS_DIRENT_NAME_LEN];
+	char real_path[FS_DIRENT_NAME_LEN];
+	char *name;
+
+	/* Input is always absolute path */
+	snprintf(input_path, FS_DIRENT_NAME_LEN, "/%s", path);
+	name = exfat_realpath(input_path, real_path);
+	if (!name)
+		return -EINVAL;
+
+	return exfat_lookup(ef, node, real_path);
+}
+
+int exfat_fs_opendir(const char *filename, struct fs_dir_stream **dirsp)
+{
+	struct exfat_dir_stream *dirs;
+	int err;
+
+	dirs = calloc(1, sizeof(*dirs));
+	if (!dirs)
+		return -ENOMEM;
+
+	err = exfat_lookup_realpath(&ctxt.ef, &dirs->node, filename);
+	if (err)
+		goto err_out;
+
+	if (!(dirs->node->attrib & EXFAT_ATTRIB_DIR)) {
+		err = -ENOTDIR;
+		goto err_out;
+	}
+
+	err = exfat_opendir(&ctxt.ef, dirs->node, &dirs->it);
+	if (err)
+		goto err_out;
+
+	*dirsp = &dirs->fs_dirs;
+
+	return 0;
+err_out:
+	free(dirs);
+	return err;
+}
+
+int exfat_fs_readdir(struct fs_dir_stream *fs_dirs, struct fs_dirent **dentp)
+{
+	struct exfat_dir_stream *dirs =
+		container_of(fs_dirs, struct exfat_dir_stream, fs_dirs);
+	struct fs_dirent *dent = &dirs->dirent;
+	struct exfat_node* node;
+
+	/* Emulate current directory ./ */
+	if (!dirs->dot) {
+		dirs->dot = true;
+		snprintf(dent->name, FS_DIRENT_NAME_LEN, ".");
+		dent->type = FS_DT_DIR;
+		*dentp = dent;
+		return 0;
+	}
+
+	/* Emulate parent directory ../ */
+	if (!dirs->dotdot) {
+		dirs->dotdot = true;
+		snprintf(dent->name, FS_DIRENT_NAME_LEN, "..");
+		dent->type = FS_DT_DIR;
+		*dentp = dent;
+		return 0;
+	}
+
+	/* Read actual directory content */
+	node = exfat_readdir(&dirs->it);
+	if (!node) {	/* No more content, reset . and .. emulation */
+		dirs->dot = false;
+		dirs->dotdot = false;
+		return 1;
+	}
+
+	exfat_get_name(node, dent->name);
+	if (node->attrib & EXFAT_ATTRIB_DIR) {
+		dent->type = FS_DT_DIR;
+	} else {
+		dent->type = FS_DT_REG;
+		dent->size = node->size;
+	}
+
+	*dentp = dent;
+
+	return 0;
+}
+
+void exfat_fs_closedir(struct fs_dir_stream *fs_dirs)
+{
+	free(fs_dirs);
+}
+
+int exfat_fs_ls(const char *dirname)
+{
+	struct exfat_node *dnode, *node;
+	char name[FS_DIRENT_NAME_LEN];
+	int nfiles = 0, ndirs = 2;
+	struct exfat_iterator it;
+	int err;
+
+	err = exfat_lookup_realpath(&ctxt.ef, &dnode, dirname);
+	if (err)
+		return err;
+
+	if (!(dnode->attrib & EXFAT_ATTRIB_DIR)) {
+		err = -ENOTDIR;
+		goto err_out;
+	}
+
+	err = exfat_opendir(&ctxt.ef, dnode, &it);
+	if (err)
+		goto err_out;
+
+	printf("            ./\n");
+	printf("            ../\n");
+
+	/* Read actual directory content */
+	while ((node = exfat_readdir(&it))) {
+		exfat_get_name(node, name);
+		if (node->attrib & EXFAT_ATTRIB_DIR) {
+			printf("            %s/\n", name);
+			ndirs++;
+		} else {
+			printf(" %8lld   %s\n", node->size, name);
+			nfiles++;
+		}
+		exfat_put_node(&ctxt.ef, node);
+	}
+
+	printf("\n%d file(s), %d dir(s)\n\n", nfiles, ndirs);
+
+	exfat_closedir(&ctxt.ef, &it);
+
+err_out:
+	exfat_put_node(&ctxt.ef, dnode);
+	return err;
+}
+
+int exfat_fs_exists(const char *filename)
+{
+	struct exfat_node* node;
+	int err;
+
+	err = exfat_lookup_realpath(&ctxt.ef, &node, filename);
+	if (err)
+		return err;
+
+	exfat_put_node(&ctxt.ef, node);
+
+	return 0;
+}
+
+int exfat_fs_size(const char *filename, loff_t *size)
+{
+	struct exfat_node* node;
+	int err;
+
+	err = exfat_lookup_realpath(&ctxt.ef, &node, filename);
+	if (err)
+		return err;
+
+	*size = node->size;
+
+	exfat_put_node(&ctxt.ef, node);
+
+	return 0;
+}
+
+int exfat_fs_read(const char *filename, void *buf, loff_t offset, loff_t len,
+	       loff_t *actread)
+{
+	struct exfat_node* node;
+	ssize_t sz;
+	int err;
+
+	err = exfat_lookup_realpath(&ctxt.ef, &node, filename);
+	if (err)
+		return err;
+
+	if (!len)
+		len = node->size;
+
+	sz = exfat_generic_pread(&ctxt.ef, node, buf, len, offset);
+	if (sz < 0) {
+		*actread = 0;
+		err = -EINVAL;
+		goto exit;
+	}
+
+	*actread = sz;
+
+	exfat_put_node(&ctxt.ef, node);
+
+	return exfat_flush_node(&ctxt.ef, node);
+exit:
+	exfat_put_node(&ctxt.ef, node);
+	return err;
+}
+
+int exfat_fs_unlink(const char *filename)
+{
+	struct exfat_node* node;
+	int err;
+
+	err = exfat_lookup_realpath(&ctxt.ef, &node, filename);
+	if (err) {
+		printf("%s: doesn't exist (%d)\n", filename, err);
+		return err;
+	}
+
+	if (node->attrib & EXFAT_ATTRIB_DIR) {
+		err = exfat_rmdir(&ctxt.ef, node);
+		if (err == -ENOTEMPTY)
+			printf("Error: directory is not empty: %d\n", err);
+	} else {
+		err = exfat_unlink(&ctxt.ef, node);
+	}
+
+	if (err)
+		goto exit;
+
+	exfat_put_node(&ctxt.ef, node);
+
+	return exfat_cleanup_node(&ctxt.ef, node);
+exit:
+	exfat_put_node(&ctxt.ef, node);
+	return err;
+}
+
+int exfat_fs_mkdir(const char *dirname)
+{
+	if (!strcmp(dirname, ".") || !strcmp(dirname, ".."))
+		return -EINVAL;
+
+	return exfat_mkdir(&ctxt.ef, dirname);
+}
+
+int exfat_fs_write(const char *filename, void *buf, loff_t offset,
+		   loff_t len, loff_t *actwrite)
+{
+	struct exfat_node* node;
+	ssize_t sz;
+	int err;
+
+	/*
+	 * Ignore -EEXIST error here, if the file exists,
+	 * this write should act as an append to offset.
+	 */
+	err = exfat_mknod(&ctxt.ef, filename);
+	if (err && err != -EEXIST)
+		return err;
+
+	err = exfat_lookup_realpath(&ctxt.ef, &node, filename);
+	if (err)
+		return err;
+
+	/* Write into directories is not allowed. */
+	if (node->attrib & EXFAT_ATTRIB_DIR)
+		return -EISDIR;
+
+	/* Write past end of file is not allowed. */
+	if (offset > node->size) {
+		err = -EINVAL;
+		goto exit;
+	}
+
+	sz = exfat_generic_pwrite(&ctxt.ef, node, buf, len, offset);
+	if (sz < 0) {
+		*actwrite = 0;
+		err = -EINVAL;
+		goto exit;
+	}
+
+	err = exfat_truncate(&ctxt.ef, node, offset + sz, false);
+	if (err)
+		goto exit;
+
+	*actwrite = sz;
+
+	err = exfat_flush_node(&ctxt.ef, node);
+exit:
+	exfat_put_node(&ctxt.ef, node);
+	return err;
+}
+
+void exfat_fs_close(void)
+{
+	exfat_unmount(&ctxt.ef);
+	ctxt.cur_dev = NULL;
+}
+#endif	/* __U_BOOT__ */
diff --git a/fs/exfat/lookup.c b/fs/exfat/lookup.c
index bb7b1243632..9867aab95f3 100644
--- a/fs/exfat/lookup.c
+++ b/fs/exfat/lookup.c
@@ -219,4 +219,7 @@ int exfat_split(struct exfat* ef, struct exfat_node** parent,
 		*parent = *node;
 	}
 	exfat_bug("impossible");
+#ifdef __UBOOT__
+	return 0;
+#endif
 }
diff --git a/fs/exfat/mount.c b/fs/exfat/mount.c
index 86fb84db244..c17a84735fc 100644
--- a/fs/exfat/mount.c
+++ b/fs/exfat/mount.c
@@ -25,8 +25,10 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <inttypes.h>
+#ifndef __UBOOT__
 #include <unistd.h>
 #include <sys/types.h>
+#endif
 
 static uint64_t rootdir_size(const struct exfat* ef)
 {
diff --git a/fs/exfat/platform.h b/fs/exfat/platform.h
index 9bd125a100a..668857607bf 100644
--- a/fs/exfat/platform.h
+++ b/fs/exfat/platform.h
@@ -26,8 +26,10 @@
 
 #if defined(__linux__) || defined(__GLIBC__) || defined(__GNU__)
 
+#ifndef __UBOOT__
 #include <endian.h>
 #include <byteswap.h>
+#endif
 #define exfat_bswap16(x) bswap_16(x)
 #define exfat_bswap32(x) bswap_32(x)
 #define exfat_bswap64(x) bswap_64(x)
diff --git a/fs/exfat/repair.c b/fs/exfat/repair.c
index 615b8d11f3c..9c91239b899 100644
--- a/fs/exfat/repair.c
+++ b/fs/exfat/repair.c
@@ -21,15 +21,19 @@
 */
 
 #include "exfat.h"
+#ifndef __UBOOT__
 #include <strings.h>
+#endif
 
 int exfat_errors_fixed;
 
 bool exfat_ask_to_fix(const struct exfat* ef)
 {
 	const char* question = "Fix (Y/N)?";
+#ifndef __UBOOT__
 	char answer[8];
 	bool yeah, nope;
+#endif
 
 	switch (ef->repair)
 	{
@@ -39,6 +43,7 @@ bool exfat_ask_to_fix(const struct exfat* ef)
 		printf("%s %s", question, "Y\n");
 		return true;
 	case EXFAT_REPAIR_ASK:
+#ifndef __UBOOT__
 		do
 		{
 			printf("%s ", question);
@@ -56,8 +61,16 @@ bool exfat_ask_to_fix(const struct exfat* ef)
 		}
 		while (!yeah && !nope);
 		return yeah;
+#else
+	default:
+		/* Do not attempt to repair FS in U-Boot. */
+		return false;
+#endif
 	}
 	exfat_bug("invalid repair option value: %d", ef->repair);
+#ifdef __UBOOT__
+	return false;
+#endif
 }
 
 bool exfat_fix_invalid_vbr_checksum(const struct exfat* ef, void* sector,
diff --git a/fs/exfat/time.c b/fs/exfat/time.c
index 3ab2a1561b8..f2217dd7986 100644
--- a/fs/exfat/time.c
+++ b/fs/exfat/time.c
@@ -159,6 +159,7 @@ void exfat_unix2exfat(time_t unix_time, le16_t* date, le16_t* time,
 
 void exfat_tzset(void)
 {
+#ifndef __UBOOT__
 	time_t now;
 	struct tm* utc;
 
@@ -170,4 +171,5 @@ void exfat_tzset(void)
 	   summer time is in effect. */
 	utc->tm_isdst = -1;
 	exfat_timezone = mktime(utc) - now;
+#endif
 }
diff --git a/fs/fs.c b/fs/fs.c
index 30a8e5010f2..01d69483e84 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -32,6 +32,7 @@
 #include <efi_loader.h>
 #include <squashfs.h>
 #include <erofs.h>
+#include <exfat.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -380,6 +381,27 @@ static struct fstype_info fstypes[] = {
 		.mkdir = fs_mkdir_unsupported,
 		.rename = fs_rename_unsupported,
 	},
+#endif
+#if IS_ENABLED(CONFIG_FS_EXFAT)
+	{
+		.fstype = FS_TYPE_EXFAT,
+		.name = "exfat",
+		.null_dev_desc_ok = false,
+		.probe = exfat_fs_probe,
+		.opendir = exfat_fs_opendir,
+		.readdir = exfat_fs_readdir,
+		.ls = exfat_fs_ls,
+		.read = exfat_fs_read,
+		.size = exfat_fs_size,
+		.close = exfat_fs_close,
+		.closedir = exfat_fs_closedir,
+		.exists = exfat_fs_exists,
+		.uuid = fs_uuid_unsupported,
+		.write = exfat_fs_write,
+		.ln = fs_ln_unsupported,
+		.unlink = exfat_fs_unlink,
+		.mkdir = exfat_fs_mkdir,
+	},
 #endif
 	{
 		.fstype = FS_TYPE_ANY,
diff --git a/include/exfat.h b/include/exfat.h
new file mode 100644
index 00000000000..7e43beeb348
--- /dev/null
+++ b/include/exfat.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _EXFAT_H_
+#define _EXFAT_H_
+
+struct disk_partition;
+
+int exfat_fs_opendir(const char *filename, struct fs_dir_stream **dirsp);
+int exfat_fs_readdir(struct fs_dir_stream *dirs, struct fs_dirent **dentp);
+int exfat_fs_ls(const char *dirname);
+int exfat_fs_probe(struct blk_desc *fs_dev_desc,
+		struct disk_partition *fs_partition);
+int exfat_fs_read(const char *filename, void *buf, loff_t offset,
+	       loff_t len, loff_t *actread);
+int exfat_fs_size(const char *filename, loff_t *size);
+int exfat_fs_exists(const char *filename);
+void exfat_fs_close(void);
+void exfat_fs_closedir(struct fs_dir_stream *dirs);
+
+int exfat_fs_unlink(const char *filename);
+int exfat_fs_mkdir(const char *dirname);
+int exfat_fs_write(const char *filename, void *buf, loff_t offset,
+		   loff_t len, loff_t *actwrite);
+
+#endif /* _EXFAT_H */
diff --git a/include/fs.h b/include/fs.h
index 54449faf2e5..731aaa02637 100644
--- a/include/fs.h
+++ b/include/fs.h
@@ -18,6 +18,7 @@ struct cmd_tbl;
 #define FS_TYPE_SQUASHFS 6
 #define FS_TYPE_EROFS   7
 #define FS_TYPE_SEMIHOSTING 8
+#define FS_TYPE_EXFAT   9
 
 struct blk_desc;
 
@@ -173,7 +174,7 @@ int fs_write(const char *filename, ulong addr, loff_t offset, loff_t len,
 #define FS_DT_REG  8         /* regular file */
 #define FS_DT_LNK  10        /* symbolic link */
 
-#define FS_DIRENT_NAME_LEN 256
+#define FS_DIRENT_NAME_LEN	CONFIG_IS_ENABLED(FS_EXFAT, (1024), (256))
 
 /**
  * struct fs_dirent - directory entry
-- 
2.47.2

