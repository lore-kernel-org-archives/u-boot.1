Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB40C48BC3
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 12:41:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 750F28780E;
	Wed, 21 Feb 2024 13:41:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="d9lctQEb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lXeCmxcz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1FA18786A; Wed, 21 Feb 2024 13:41:53 +0100 (CET)
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE021877AF
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 13:41:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=namcao@linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1708519310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=eVsuQZHSMWsglPjyBjGmOFxYixhbzgYDq4S3j0lVqjA=;
 b=d9lctQEbJX64joeB8VVichkVDDWQMJpPsRIN2TuCffNnRPJhodslvq1FVvP2yvMbakmCxo
 bp/d/FkDdfi+uYKVh55+1TdwpSW4rHWN3yxSmezUZ8zzMtiV02gDO5fIeWp/+vNjQtbr13
 +0z5kIrlzmV3mOynwWXjYJ9iZeqFqgGEVKl0WjMaL80gSiPDlvWaJ1hd4FmRtsdsSZYRjn
 NvQ5t+LKg8/pEVAByaeW2VZ9zornx9o/ggtNMUhavfsZIxSEJ7Ohhj6ZeZFR7mtchnsL1r
 pTht0XgMfwPbxZrfFtCCUJ+3jxWcD6QwYTHYiau+NjE08ALsMD5ZraGPzyYY/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1708519310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=eVsuQZHSMWsglPjyBjGmOFxYixhbzgYDq4S3j0lVqjA=;
 b=lXeCmxczck/HXNt86p9NbrdtWr/2xyVnFy8BHQpHAuNTrzrwOejOZSgJ/xEisKZzmxh2vc
 SYVCuMNcrkw0MlBQ==
To: sjg@chromium.org, bmeng.cn@gmail.com, mibodhi@gmail.com,
 xypron.glpk@gmx.de, namcao@linutronix.de, caleb.connolly@linaro.org,
 mkorpershoek@baylibre.com, i@shantur.com, u-boot@lists.denx.de
Subject: [PATCH] bootstd: support scanning a single partition
Date: Wed, 21 Feb 2024 13:41:44 +0100
Message-Id: <20240221124144.168711-1-namcao@linutronix.de>
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

The "bootflow" command currently doesn't support scanning a single
partition. This is inconvenient in setups with multiple bootable
partitions within a single disk, but only one is desired.

Support scanning a single disk partition. Specifically, support the
syntax:
	bootflow scan mmc1:4
which scans only mmc device 1, partition 4.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 boot/bootdev-uclass.c   | 35 +++++++++++++++++++++++++++++++++--
 boot/bootflow.c         |  3 +++
 doc/develop/bootstd.rst |  4 ++++
 include/bootflow.h      |  3 +++
 4 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index 35afb93c0e..64e09fa0d0 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -173,8 +173,10 @@ int bootdev_find_in_blk(struct udevice *dev, struct ud=
evice *blk,
 	 */
 	iter->max_part =3D MAX_PART_PER_BOOTDEV;
=20
-	/* If this is the whole disk, check if we have bootable partitions */
-	if (!iter->part) {
+	if (iter->flags & BOOTFLOWIF_SINGLE_PARTITION) {
+		/* a particular partition was specified, scan it without checking */
+	} else if (!iter->part) {
+		/* This is the whole disk, check if we have bootable partitions */
 		iter->first_bootable =3D part_get_bootable(desc);
 		log_debug("checking bootable=3D%d\n", iter->first_bootable);
 	} else if (allow_any_part) {
@@ -711,8 +713,37 @@ int bootdev_setup_iter(struct bootflow_iter *iter, con=
st char *label,
 	struct udevice *bootstd, *dev =3D NULL;
 	bool show =3D iter->flags & BOOTFLOWIF_SHOW;
 	int method_flags;
+	char buf[32];
 	int ret;
=20
+	if (label) {
+		const char *end =3D strchr(label, ':');
+
+		if (end) {
+			size_t len =3D (size_t)(end - label);
+			const char *part =3D end + 1;
+
+			if (len + 1 > sizeof(buf)) {
+				log_err("label \"%s\" is way too long\n", label);
+				return -EINVAL;
+			}
+
+			memcpy(buf, label, len);
+			buf[len] =3D '\0';
+			label =3D buf;
+
+			unsigned long tmp;
+
+			if (strict_strtoul(part, 0, &tmp)) {
+				log_err("Invalid partition number: %s\n", part);
+				return -EINVAL;
+			}
+
+			iter->flags |=3D BOOTFLOWIF_SINGLE_PARTITION;
+			iter->part =3D tmp;
+		}
+	}
+
 	ret =3D uclass_first_device_err(UCLASS_BOOTSTD, &bootstd);
 	if (ret) {
 		log_err("Missing bootstd device\n");
diff --git a/boot/bootflow.c b/boot/bootflow.c
index 05484fd5b1..68bf99329a 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -217,6 +217,9 @@ static int iter_incr(struct bootflow_iter *iter)
 		}
 	}
=20
+	if (iter->flags & BOOTFLOWIF_SINGLE_PARTITION)
+		return BF_NO_MORE_DEVICES;
+
 	/* No more bootmeths; start at the first one, and... */
 	iter->cur_method =3D 0;
 	iter->method =3D iter->method_order[iter->cur_method];
diff --git a/doc/develop/bootstd.rst b/doc/develop/bootstd.rst
index 496e24bc7a..a07a72581e 100644
--- a/doc/develop/bootstd.rst
+++ b/doc/develop/bootstd.rst
@@ -531,6 +531,10 @@ Then the iterator is set up to according to the parame=
ters given:
     `BOOTFLOWIF_SINGLE_MEDIA` is set. In this case, moving to the next boo=
tdev
     processes just the children of the media device. Hunters are used, in =
this
     example just the "mmc" hunter.
+  - If `label` indicates a particular partition in a particular media devi=
ce
+    (e.g. "mmc1:3") then `BOOTFLOWIF_SINGLE_PARTITION` is set. In this cas=
e,
+    only a single partition within a bootdev is processed. Hunters are use=
d, in
+    this example just the "mmc" hunter.
   - If `label` indicates a media uclass (e.g. "mmc") then
     `BOOTFLOWIF_SINGLE_UCLASS` is set. In this case, all bootdevs in that =
uclass
     are used. Hunters are used, in this example just the "mmc" hunter
diff --git a/include/bootflow.h b/include/bootflow.h
index 42112874f6..080ee85012 100644
--- a/include/bootflow.h
+++ b/include/bootflow.h
@@ -133,6 +133,8 @@ struct bootflow {
  * this uclass (used with things like "mmc")
  * @BOOTFLOWIF_SINGLE_MEDIA: (internal) Scan one media device in the uclas=
s (used
  * with things like "mmc1")
+ * @BOOTFLOWIF_SINGLE_PARTITION: (internal) Scan one partition in media de=
vice
+ * (used with things like "mmc1:3")
  */
 enum bootflow_iter_flags_t {
 	BOOTFLOWIF_FIXED		=3D 1 << 0,
@@ -148,6 +150,7 @@ enum bootflow_iter_flags_t {
 	BOOTFLOWIF_SKIP_GLOBAL		=3D 1 << 17,
 	BOOTFLOWIF_SINGLE_UCLASS	=3D 1 << 18,
 	BOOTFLOWIF_SINGLE_MEDIA		=3D 1 << 19,
+	BOOTFLOWIF_SINGLE_PARTITION	=3D 1 << 20,
 };
=20
 /**
--=20
2.39.2

