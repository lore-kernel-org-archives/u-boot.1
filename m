Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15848C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 16:00:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86B9388180;
	Tue, 30 Apr 2024 18:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=rivoreo.one
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA5AB889AD; Tue, 30 Apr 2024 18:00:53 +0200 (CEST)
Received: from tianjin2.rivoreo.one (unknown [60.25.139.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAA55880AD
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 18:00:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=rivoreo.one
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=whr@rivoreo.one
Received: from [10.1.105.1] (localhost [127.0.0.1])
 by tianjin2.rivoreo.one (Postfix) with ESMTP id 2578B7230D;
 Wed,  1 May 2024 00:00:42 +0800 (CST)
Received: from 10.1.107.31 (SquirrelMail authenticated user whr)
 by _ with HTTP; Wed, 1 May 2024 00:00:42 +0800
Message-ID: <db1fdfc216d720c7ce02e249e83d7147.squirrel@_>
Date: Wed, 1 May 2024 00:00:42 +0800
Subject: [PATCH] zfs: recognize zpools formatted with features support
From: "WHR" <whr@rivoreo.one>
To: u-boot@lists.denx.de
Cc: "Tom Rini" <trini@konsulko.com>,
 mwleeds@mailtundra.com
User-Agent: SquirrelMail/1.4.23 [SVN]
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20240501000042_39236"
X-Priority: 3 (Normal)
Importance: Normal
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

------=_20240501000042_39236
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Currently no features are implemented, only the zpool version 5000 that
indicating the features support, is recognized. Since it is possible for
OpenZFS to create a pool with features support enabled, but without
enabling any actual feature, this change enables U-Boot to read such
pools.

Signed-off-by: WHR <msl0000023508@gmail.com>



------=_20240501000042_39236
Content-Type: text/plain;
 name="0001-zfs-recognize-zpools-formatted-with-features-support"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="0001-zfs-recognize-zpools-formatted-with-features-support"

diff --git a/fs/zfs/zfs.c b/fs/zfs/zfs.c
index 4896cc18ef..3575c23a42 100644
--- a/fs/zfs/zfs.c
+++ b/fs/zfs/zfs.c
@@ -336,6 +336,12 @@ vdev_uberblock_compare(uberblock_t *ub1, uberblock_t *ub2)
 	return 0;
 }
 
+static inline int
+is_supported_spa_version(uint64_t version) {
+	return version == FEATURES_SUPPORTED_SPA_VERSION ||
+		(version > 0 && version <= SPA_VERSION);
+}
+
 /*
  * Three pieces of information are needed to verify an uberblock: the magic
  * number, the version number, and the checksum.
@@ -348,6 +354,7 @@ static int
 uberblock_verify(uberblock_t *uber, int offset, struct zfs_data *data)
 {
 	int err;
+	uint64_t spa_version;
 	zfs_endian_t endian = UNKNOWN_ENDIAN;
 	zio_cksum_t zc;
 
@@ -357,14 +364,12 @@ uberblock_verify(uberblock_t *uber, int offset, struct zfs_data *data)
 		return ZFS_ERR_BAD_FS;
 	}
 
-	if (zfs_to_cpu64(uber->ub_magic, LITTLE_ENDIAN) == UBERBLOCK_MAGIC
-		&& zfs_to_cpu64(uber->ub_version, LITTLE_ENDIAN) > 0
-		&& zfs_to_cpu64(uber->ub_version, LITTLE_ENDIAN) <= SPA_VERSION)
+	if (zfs_to_cpu64(uber->ub_magic, LITTLE_ENDIAN) == UBERBLOCK_MAGIC &&
+		is_supported_spa_version(zfs_to_cpu64(uber->ub_version, LITTLE_ENDIAN)))
 		endian = LITTLE_ENDIAN;
 
-	if (zfs_to_cpu64(uber->ub_magic, BIG_ENDIAN) == UBERBLOCK_MAGIC
-		&& zfs_to_cpu64(uber->ub_version, BIG_ENDIAN) > 0
-		&& zfs_to_cpu64(uber->ub_version, BIG_ENDIAN) <= SPA_VERSION)
+	if (zfs_to_cpu64(uber->ub_magic, BIG_ENDIAN) == UBERBLOCK_MAGIC &&
+		is_supported_spa_version(zfs_to_cpu64(uber->ub_version, BIG_ENDIAN)))
 		endian = BIG_ENDIAN;
 
 	if (endian == UNKNOWN_ENDIAN) {
@@ -1790,7 +1795,7 @@ check_pool_label(struct zfs_data *data)
 		return ZFS_ERR_BAD_FS;
 	}
 
-	if (version > SPA_VERSION) {
+	if (!is_supported_spa_version(version)) {
 		free(nvlist);
 		printf("SPA version too new %llu > %llu\n",
 			   (unsigned long long) version,
diff --git a/include/zfs/zfs.h b/include/zfs/zfs.h
index 17b93c10c8..72d87452dd 100644
--- a/include/zfs/zfs.h
+++ b/include/zfs/zfs.h
@@ -15,6 +15,7 @@
  * On-disk version number.
  */
 #define	SPA_VERSION			28ULL
+#define	FEATURES_SUPPORTED_SPA_VERSION	5000ULL
 
 /*
  * The following are configuration names used in the nvlist describing a pool's
------=_20240501000042_39236--


