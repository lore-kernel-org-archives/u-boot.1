Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A77C27C4F
	for <u-boot@archiver.kernel.org>; Sun, 30 Jun 2024 21:26:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68E3A88630;
	Sun, 30 Jun 2024 23:26:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 121FA8863B; Sun, 30 Jun 2024 23:26:04 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08F078824C
 for <u-boot@lists.denx.de>; Sun, 30 Jun 2024 23:26:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=richard@nod.at
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id A25B36195FC4;
 Sun, 30 Jun 2024 23:26:01 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id dYTBbaeuKW86; Sun, 30 Jun 2024 23:26:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id 2148764943E1;
 Sun, 30 Jun 2024 23:26:01 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id fdfNvnTTRsVR; Sun, 30 Jun 2024 23:26:01 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
 by lithops.sigma-star.at (Postfix) with ESMTPSA id C8FD164943DB;
 Sun, 30 Jun 2024 23:26:00 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: u-boot@lists.denx.de
Cc: Jixiong.Hu@mediatek.com, sjg@chromium.org, patrick.delaunay@foss.st.com,
 ilias.apalodimas@linaro.org, seanga2@gmail.com, xypron.glpk@gmx.de,
 trini@konsulko.com, upstream+uboot@sigma-star.at,
 Richard Weinberger <richard@nod.at>
Subject: [PATCH] ext4: Improve feature checking
Date: Sun, 30 Jun 2024 23:25:56 +0200
Message-Id: <20240630212556.5627-1-richard@nod.at>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

Evaluate the filesystem incompat and ro_compat bit fields to judge
whether the filesystem can be read or written.
For the read side only a scary warning is shown so far.
I'd love to about mounting too, but I fear this will break some setups
where the driver works by chance.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
After facing ext4 write corruptions and read errors I checked
the ext4 implementation briefly.
Hopefully this patch helps other users to detect earlier that
they're using ext4 features which are not supported by u-boot.

To make feature checking possible I had to figure what this
implementation actually supports.
I hope I got them right, feedback is welcome!

Thanks,
//richard
---
 fs/ext4/ext4_common.c |  8 +++++++
 fs/ext4/ext4_write.c  | 12 ++++++++--
 include/ext4fs.h      | 55 ++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/ext4_common.c b/fs/ext4/ext4_common.c
index 2ff0dca249..7148d35ee0 100644
--- a/fs/ext4/ext4_common.c
+++ b/fs/ext4/ext4_common.c
@@ -2386,6 +2386,14 @@ int ext4fs_mount(void)
 		fs->inodesz =3D 128;
 		fs->gdsize =3D 32;
 	} else {
+		int missing =3D __le32_to_cpu(data->sblock.feature_incompat) & \
+			      ~(EXT4_FEATURE_INCOMPAT_SUPP | \
+				EXT4_FEATURE_INCOMPAT_SUPP_LAZY_RO);
+
+		if (missing)
+			log_err("fs uses incompatible features: %08x, failures *are* expected=
!\n",
+				missing);
+
 		debug("EXT4 features COMPAT: %08x INCOMPAT: %08x RO_COMPAT: %08x\n",
 		      __le32_to_cpu(data->sblock.feature_compatibility),
 		      __le32_to_cpu(data->sblock.feature_incompat),
diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
index d057f6b5a7..4aae3c5f7f 100644
--- a/fs/ext4/ext4_write.c
+++ b/fs/ext4/ext4_write.c
@@ -869,6 +869,7 @@ int ext4fs_write(const char *fname, const char *buffe=
r,
 	ALLOC_CACHE_ALIGN_BUFFER(char, filename, 256);
 	bool store_link_in_inode =3D false;
 	memset(filename, 0x00, 256);
+	int missing_feat;
=20
 	if (type !=3D FILETYPE_REG && type !=3D FILETYPE_SYMLINK)
 		return -1;
@@ -882,8 +883,15 @@ int ext4fs_write(const char *fname, const char *buff=
er,
 		return -1;
 	}
=20
-	if (le32_to_cpu(fs->sb->feature_ro_compat) & EXT4_FEATURE_RO_COMPAT_MET=
ADATA_CSUM) {
-		printf("Unsupported feature metadata_csum found, not writing.\n");
+	missing_feat =3D le32_to_cpu(fs->sb->feature_incompat) & ~EXT4_FEATURE_=
INCOMPAT_SUPP;
+	if (missing_feat) {
+		log_err("Unsupported features found %08x, not writing.\n", missing_fea=
t);
+		return -1;
+	}
+
+	missing_feat =3D le32_to_cpu(fs->sb->feature_ro_compat) & ~EXT4_FEATURE=
_RO_COMPAT_SUPP;
+	if (missing_feat) {
+		log_err("Unsupported RO compat features found %08x, not writing.\n", m=
issing_feat);
 		return -1;
 	}
=20
diff --git a/include/ext4fs.h b/include/ext4fs.h
index d96edfd057..01b66f469f 100644
--- a/include/ext4fs.h
+++ b/include/ext4fs.h
@@ -34,12 +34,65 @@ struct disk_partition;
 #define EXT4_TOPDIR_FL		0x00020000 /* Top of directory hierarchies*/
 #define EXT4_EXTENTS_FL		0x00080000 /* Inode uses extents */
 #define EXT4_EXT_MAGIC			0xf30a
-#define EXT4_FEATURE_RO_COMPAT_GDT_CSUM	0x0010
+
+#define EXT4_FEATURE_RO_COMPAT_SPARSE_SUPER  0x0001
+#define EXT4_FEATURE_RO_COMPAT_LARGE_FILE    0x0002
+#define EXT4_FEATURE_RO_COMPAT_BTREE_DIR     0x0004
+#define EXT4_FEATURE_RO_COMPAT_HUGE_FILE     0x0008
+#define EXT4_FEATURE_RO_COMPAT_GDT_CSUM      0x0010
+#define EXT4_FEATURE_RO_COMPAT_DIR_NLINK     0x0020
+#define EXT4_FEATURE_RO_COMPAT_EXTRA_ISIZE   0x0040
+#define EXT4_FEATURE_RO_COMPAT_QUOTA         0x0100
+#define EXT4_FEATURE_RO_COMPAT_BIGALLOC      0x0200
 #define EXT4_FEATURE_RO_COMPAT_METADATA_CSUM 0x0400
+
+#define EXT4_FEATURE_INCOMPAT_FILETYPE  0x0002
+#define EXTE_FEATURE_INCOMPAT_RECOVER   0x0004
 #define EXT4_FEATURE_INCOMPAT_EXTENTS	0x0040
 #define EXT4_FEATURE_INCOMPAT_64BIT	0x0080
+#define EXT4_FEATURE_INCOMPAT_MMP       0x0100
+#define EXT4_FEATURE_INCOMPAT_FLEX_BG   0x0200
+#define EXT4_FEATURE_INCOMPAT_CSUM_SEED 0x2000
+#define EXT4_FEATURE_INCOMPAT_ENCRYPT   0x10000
+
 #define EXT4_INDIRECT_BLOCKS		12
=20
+/*
+ * Incompat features supported by this implementation.
+ */
+#define EXT4_FEATURE_INCOMPAT_SUPP ( EXT4_FEATURE_INCOMPAT_FILETYPE \
+				   | EXTE_FEATURE_INCOMPAT_RECOVER \
+				   | EXT4_FEATURE_INCOMPAT_EXTENTS \
+				   | EXT4_FEATURE_INCOMPAT_64BIT \
+				   | EXT4_FEATURE_INCOMPAT_FLEX_BG \
+				   )
+
+/*
+ * Incompat features supported by this implementation only in a lazy
+ * way, good enough for reading files.
+ *
+ * - Multi mount protection (mmp) is not supported, but for read-only
+ *   we get away with it.
+ * - Same fore metadata_csum_seed and metadata_csum.
+ * - The implementation has also no clue about fscrypt, but it can read
+ *   unencrypted files. Reading encrypted files will read garbage.
+ */
+#define EXT4_FEATURE_INCOMPAT_SUPP_LAZY_RO ( EXT4_FEATURE_INCOMPAT_MMP \
+					   | EXT4_FEATURE_INCOMPAT_CSUM_SEED \
+					   | EXT4_FEATURE_INCOMPAT_ENCRYPT \
+					   )
+
+/*
+ * Read-only compat features we support.
+ * If unknown ro compat features are detected, writing to the fs is deni=
ed.
+ */
+#define EXT4_FEATURE_RO_COMPAT_SUPP ( EXT4_FEATURE_RO_COMPAT_SPARSE_SUPE=
R \
+				    | EXT4_FEATURE_RO_COMPAT_LARGE_FILE \
+				    | EXT4_FEATURE_RO_COMPAT_HUGE_FILE \
+				    | EXT4_FEATURE_RO_COMPAT_DIR_NLINK \
+				    | EXT4_FEATURE_RO_COMPAT_EXTRA_ISIZE \
+				    )
+
 #define EXT4_BG_INODE_UNINIT		0x0001
 #define EXT4_BG_BLOCK_UNINIT		0x0002
 #define EXT4_BG_INODE_ZEROED		0x0004
--=20
2.35.3

