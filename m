Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0BECD4F3C
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 05:58:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 445AC84687;
	Mon, 18 May 2026 07:57:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="r8cJO79y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AECD83AA9; Mon, 18 May 2026 07:57:54 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21B7083AA9
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
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id C50264169F; 
 Mon, 18 May 2026 05:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779083871;
 bh=ZHFBD2/sqEw9xpJcKE8cdnHV7auLGJSwUvjfJFOe0Tc=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=r8cJO79yDUUyy692JX9u891ulpEWKw/UNz0m8iuemGgP2ib1N9/vo1nFj1IYlPbJC
 RSys4bRXoS/LxHA1iN/rlEM+v9m4AeBX4OZzyGZ/maPzERx/mP49H2HfnKQWh7zz+a
 dR+5Azu9Z/vOosVswT7d9SCtdV0z0pvJXPE6qLh5zDklFjh1lL6CJZ6+b1Ri8Vhxf4
 o4MywqllpqNg6YU/GC9z1fvDkrgYBlvd7ErxBEdRfR2beBSNEOP0v6zEoMhq8CjU64
 ai4Gzt9H4JezgWcDw3aXzTP8USfciC1h2XQjLangQ/e8dy5gPLLaZa9z2GgRQO5IPd
 cOm9+8Q5o4X7PqcxtHEV6bnGjyF2Fik+OAh6kM0aUPGbM1DU1GXCUBUbYSL9yhSgll
 slFNDWYadLu0zH/PjfXQMJY2vhR4+3CBNNQU8rvCGZw++eOTNFDi+/ajw50gQioYk5
 bJUT+kU4MwJCFvJmKaXPKF290jtFH8Ri2I1EARmazuFkFwWh0pWJm3U0LnYuuNVApT
 q4biid57V/yU6DSO+yNvHvJcXmu65U1CZwwvgXJTYdlsPdjVKR5BzOvvo8TkMI006o
 xznUfhCqPYF2TzBN8CmLJ+GPRrFROGPasn1fdCMMIKeYB92PkFEavfAoKvzG4Hmnht
 6XQuNSP+lKe0+3wIacMij8wg=
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
Subject: [PATCH 1/9] fs: move struct fstype_info definition to top of file
Date: Mon, 18 May 2026 07:57:20 +0200
Message-ID: <20260518055728.178507-2-heinrich.schuchardt@canonical.com>
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

Structure definitions should precede code using them.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 fs/fs.c | 86 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/fs/fs.c b/fs/fs.c
index 8ea50a6c13c..fe62b71c83c 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -38,6 +38,49 @@ static int fs_dev_part;
 static struct disk_partition fs_partition;
 static int fs_type = FS_TYPE_ANY;
 
+struct fstype_info {
+	int fstype;
+	char *name;
+	/*
+	 * Is it legal to pass NULL as .probe()'s  fs_dev_desc parameter? This
+	 * should be false in most cases. For "virtual" filesystems which
+	 * aren't based on a U-Boot block device (e.g. sandbox), this can be
+	 * set to true. This should also be true for the dummy entry at the end
+	 * of fstypes[], since that is essentially a "virtual" (non-existent)
+	 * filesystem.
+	 */
+	bool null_dev_desc_ok;
+	int (*probe)(struct blk_desc *fs_dev_desc,
+		     struct disk_partition *fs_partition);
+	int (*ls)(const char *dirname);
+	int (*exists)(const char *filename);
+	int (*size)(const char *filename, loff_t *size);
+	int (*read)(const char *filename, void *buf, loff_t offset,
+		    loff_t len, loff_t *actread);
+	int (*write)(const char *filename, void *buf, loff_t offset,
+		     loff_t len, loff_t *actwrite);
+	void (*close)(void);
+	int (*uuid)(char *uuid_str);
+	/*
+	 * Open a directory stream.  On success return 0 and directory
+	 * stream pointer via 'dirsp'.  On error, return -errno.  See
+	 * fs_opendir().
+	 */
+	int (*opendir)(const char *filename, struct fs_dir_stream **dirsp);
+	/*
+	 * Read next entry from directory stream.  On success return 0
+	 * and directory entry pointer via 'dentp'.  On error return
+	 * -errno.  See fs_readdir().
+	 */
+	int (*readdir)(struct fs_dir_stream *dirs, struct fs_dirent **dentp);
+	/* see fs_closedir() */
+	void (*closedir)(struct fs_dir_stream *dirs);
+	int (*unlink)(const char *filename);
+	int (*mkdir)(const char *dirname);
+	int (*ln)(const char *filename, const char *target);
+	int (*rename)(const char *old_path, const char *new_path);
+};
+
 void fs_set_type(int type)
 {
 	fs_type = type;
@@ -147,49 +190,6 @@ static inline int fs_rename_unsupported(const char *old_path,
 	return -1;
 }
 
-struct fstype_info {
-	int fstype;
-	char *name;
-	/*
-	 * Is it legal to pass NULL as .probe()'s  fs_dev_desc parameter? This
-	 * should be false in most cases. For "virtual" filesystems which
-	 * aren't based on a U-Boot block device (e.g. sandbox), this can be
-	 * set to true. This should also be true for the dummy entry at the end
-	 * of fstypes[], since that is essentially a "virtual" (non-existent)
-	 * filesystem.
-	 */
-	bool null_dev_desc_ok;
-	int (*probe)(struct blk_desc *fs_dev_desc,
-		     struct disk_partition *fs_partition);
-	int (*ls)(const char *dirname);
-	int (*exists)(const char *filename);
-	int (*size)(const char *filename, loff_t *size);
-	int (*read)(const char *filename, void *buf, loff_t offset,
-		    loff_t len, loff_t *actread);
-	int (*write)(const char *filename, void *buf, loff_t offset,
-		     loff_t len, loff_t *actwrite);
-	void (*close)(void);
-	int (*uuid)(char *uuid_str);
-	/*
-	 * Open a directory stream.  On success return 0 and directory
-	 * stream pointer via 'dirsp'.  On error, return -errno.  See
-	 * fs_opendir().
-	 */
-	int (*opendir)(const char *filename, struct fs_dir_stream **dirsp);
-	/*
-	 * Read next entry from directory stream.  On success return 0
-	 * and directory entry pointer via 'dentp'.  On error return
-	 * -errno.  See fs_readdir().
-	 */
-	int (*readdir)(struct fs_dir_stream *dirs, struct fs_dirent **dentp);
-	/* see fs_closedir() */
-	void (*closedir)(struct fs_dir_stream *dirs);
-	int (*unlink)(const char *filename);
-	int (*mkdir)(const char *dirname);
-	int (*ln)(const char *filename, const char *target);
-	int (*rename)(const char *old_path, const char *new_path);
-};
-
 static struct fstype_info fstypes[] = {
 #if CONFIG_IS_ENABLED(FS_FAT)
 	{
-- 
2.53.0

