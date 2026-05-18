Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD9E1CD343F
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 05:58:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8262584150;
	Mon, 18 May 2026 07:57:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Gdrq+G9p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E04F84688; Mon, 18 May 2026 07:57:55 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FCE784150
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 07:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-046-114-109-175.46.114.pool.telefonica.de
 [46.114.109.175])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 9B11C416F0; 
 Mon, 18 May 2026 05:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779083872;
 bh=5zHUgAdevqUgcmdtpj2MuXNRgqlONo24CO8MVJlLQfA=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Gdrq+G9pQDqNAFesWmx6KXchQ9EUuzY/rVlBFPYB7DyVNv29kVF6Ymce1LgsdwyF4
 B1HLUnEdNgop4KPJUJB+6SKVsfAWNkOx3nIoZ25srMpEtCyekqoTOCJgDpkdRLmiaw
 nGNGXXIIb0JDSFD9pIYKlL1511Y9Yno4EXNqkJ+g+ov7++aJy26CL39sc3jvgv7OCV
 dknXl1IUE/+2KIHNBZkDMqm6P43ML/up4b58aSC9vvaduRRlFeQASnpZuiPv1CxLKh
 evK9RHqjuL2Mkv5hRP2L3eVie+eXkxhjfZkNmhssFH8RJlJe9Q7e+g6feGPntH3xrl
 3ZSKWm+XIzT2aZZvPns5FhQ4LfrOy/AYbjVhAdkXtC/KqYsGnKKv3hSIbQuRD5HSQ/
 CmGdh9UvqrW0v29ENdv81n86CLjDsaipwE3lMrij+GJE4iF2hIKI5sK5+Nzps9E7Uk
 vKmD5IPfVYrQDS5AeSvT87YRJHRsYPQfcccSD5NLz/b/8yvYj7z4FLzGJbhVMYS9sM
 yMZjV1KWGs0UQuJw5Hp7SAB2Oq1IVeDLUcdCfnVgWxrWl+VlAnEHYWomE/86gCGaCM
 fN0Snf2oy8Uj3Zcye9Wb2ZSG8G5SAT+PLSyD/9sNRVpdERVA91Unr8dbNsnHnFCngm
 0KxcsQrtGeNngxxyhsEVWYqk=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Huang Jianan <jnhuang95@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tony Dinh <mibodhi@gmail.com>,
 =?UTF-8?q?Timo=20tp=20Prei=C3=9Fl?= <t.preissl@proton.me>,
 Francois Berder <fberder@outlook.fr>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Daniel Palmer <daniel@thingy.jp>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.denx.de, linux-erofs@lists.ozlabs.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/9] fs: print change date in directory listing for FAT
Date: Mon, 18 May 2026 07:57:21 +0200
Message-ID: <20260518055728.178507-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518055728.178507-1-heinrich.schuchardt@canonical.com>
References: <20260518055728.178507-1-heinrich.schuchardt@canonical.com>
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

fs_ls_generic() displays file sizes but no timestamps. The FAT
filesystem stores a change date in every directory entry and already
populates fs_dirent::change_time in fat_readdir(). Print the date
alongside the file size for filesystems that provide it.

Add a u32 capability bitmap (caps) to struct fstype_info. Each bit
documents a property that the filesystem's readdir() implementation
guarantees:

  FS_CAP_DATE  BIT(0)  change_time in fs_dirent is valid

fs_ls_generic() tests FS_CAP_DATE once before the loop to select a
consistent output format for the entire listing:

  12345678  2024-03-15 09:30  filename.txt    (FAT)
  12345678   filename.txt                     (ext4, squashfs, ...)

Set FS_CAP_DATE for FAT. fat2rtc() loses the __maybe_unused annotation
since it is now called unconditionally outside XPL builds. The attr,
create_time, change_time, and access_time fields that were previously
only populated under CONFIG_EFI_LOADER are now populated whenever
CONFIG_XPL_BUILD is not set.

Extending the feature to another filesystem requires only adding
.caps = FS_CAP_DATE to its fstype_info entry and ensuring its readdir()
fills in fs_dirent::change_time.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 fs/fat/fat.c |  2 +-
 fs/fs.c      | 38 +++++++++++++++++++++++++++++++++++---
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/fs/fat/fat.c b/fs/fat/fat.c
index c1ccf30771a..7443f5952af 100644
--- a/fs/fat/fat.c
+++ b/fs/fat/fat.c
@@ -1539,7 +1539,7 @@ int fat_readdir(struct fs_dir_stream *dirs, struct fs_dirent **dentp)
 
 	memset(dent, 0, sizeof(*dent));
 	strcpy(dent->name, dir->itr.name);
-	if (CONFIG_IS_ENABLED(EFI_LOADER)) {
+	if (!IS_ENABLED(CONFIG_XPL_BUILD)) {
 		dent->attr = dir->itr.dent->attr;
 		fat2rtc(le16_to_cpu(dir->itr.dent->cdate),
 			le16_to_cpu(dir->itr.dent->ctime), &dent->create_time);
diff --git a/fs/fs.c b/fs/fs.c
index fe62b71c83c..f8e4794c10e 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -38,6 +38,11 @@ static int fs_dev_part;
 static struct disk_partition fs_partition;
 static int fs_type = FS_TYPE_ANY;
 
+/*
+ * define FS_CAP_DATE - readdir() populates fs_dirent::change_time
+ */
+#define FS_CAP_DATE	BIT(0)
+
 struct fstype_info {
 	int fstype;
 	char *name;
@@ -50,6 +55,10 @@ struct fstype_info {
 	 * filesystem.
 	 */
 	bool null_dev_desc_ok;
+#if !IS_ENABLED(CONFIG_XPL_BUILD)
+	/* Capability flags (FS_CAP_*) */
+	u32 caps;
+#endif
 	int (*probe)(struct blk_desc *fs_dev_desc,
 		     struct disk_partition *fs_partition);
 	int (*ls)(const char *dirname);
@@ -98,10 +107,19 @@ static inline int fs_ls_unsupported(const char *dirname)
 	return -1;
 }
 
+/* Forward declaration - defined after fstypes[] */
+static struct fstype_info *fs_get_info(int fstype);
+
 /* generic implementation of ls in terms of opendir/readdir/closedir */
 __maybe_unused
 static int fs_ls_generic(const char *dirname)
 {
+#if !IS_ENABLED(CONFIG_XPL_BUILD)
+	struct fstype_info *info = fs_get_info(fs_type);
+	bool has_date = !!(info->caps & FS_CAP_DATE);
+#else
+	bool has_date = false;
+#endif
 	struct fs_dir_stream *dirs;
 	struct fs_dirent *dent;
 	int nfiles = 0, ndirs = 0;
@@ -112,15 +130,26 @@ static int fs_ls_generic(const char *dirname)
 
 	while ((dent = fs_readdir(dirs))) {
 		if (dent->type == FS_DT_DIR) {
-			printf("            %s/\n", dent->name);
+			printf("          ");
 			ndirs++;
 		} else if (dent->type == FS_DT_LNK) {
-			printf("    <SYM>   %s\n", dent->name);
+			printf("    <SYM> ");
 			nfiles++;
 		} else {
-			printf(" %8lld   %s\n", dent->size, dent->name);
+			printf(" %8lld ", dent->size);
 			nfiles++;
 		}
+		if (has_date)
+			printf("%04d-%02d-%02d %02d:%02d ",
+			       dent->change_time.tm_year,
+			       dent->change_time.tm_mon,
+			       dent->change_time.tm_mday,
+			       dent->change_time.tm_hour,
+			       dent->change_time.tm_min);
+		if (dent->type == FS_DT_DIR)
+			printf("%s/\n", dent->name);
+		else
+			printf("%s\n", dent->name);
 	}
 
 	fs_closedir(dirs);
@@ -196,6 +225,9 @@ static struct fstype_info fstypes[] = {
 		.fstype = FS_TYPE_FAT,
 		.name = "fat",
 		.null_dev_desc_ok = false,
+#if !IS_ENABLED(CONFIG_XPL_BUILD)
+		.caps = FS_CAP_DATE,
+#endif
 		.probe = fat_set_blk_dev,
 		.close = fat_close,
 		.ls = fs_ls_generic,
-- 
2.53.0

