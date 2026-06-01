Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E930BCD6E57
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 13:14:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52C3B848B0;
	Mon,  1 Jun 2026 15:13:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="XLZcKhJG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEB25840CB; Mon,  1 Jun 2026 15:13:58 +0200 (CEST)
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3EB7848B9
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 15:13:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 4BCC1B0059C;
 Mon,  1 Jun 2026 15:13:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1780319636;
 bh=mZJdIDawiYg07Whz1/imikJe1NFSQ/4Sh1HO+/cYWH4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XLZcKhJGQiYxbtAOE2HhJU15Y/FOCAb7ZrICytFADxbxs4TO9fzMxilr3u8X0+sNW
 A6oiG4eJ5YJLwLULrx8TATg7n3QVB4VDEEcZW8Zsb2ZdwcL0BbM2u4yGXxsVDAYhgf
 GbgMgKqbuT09i/MmQYNdJeg0WMvmCAs7JORshkpJIhHvUTp6z0ZMC2ozLObYKNVqYM
 752y08ovpmrVpOW+wkbVi99hJIY1dX3mt/VfA+fqLLlqja3Kw+xl1H8hmGd3LA8y61
 rvh1kdmj80UaGm4wB7jhK+6wCx3O/0rJKdp9fhcv7CkU5i3IFABGXbsEMElS2aU74T
 zGKzraOU4x8yw==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: Vincent Jardin <vjardin@free.fr>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <simon.glass@canonical.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 =?UTF-8?q?Timo=20tp=20Prei=C3=9Fl?= <t.preissl@proton.me>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 1/3] fs: dispatch null_dev_desc_ok filesystems before lookup
Date: Mon,  1 Jun 2026 15:12:02 +0200
Message-ID: <20260601131311.1163914-2-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601131311.1163914-1-vjardin@free.fr>
References: <"<20260511115340.675883-1-vjardin@free.fr>">
 <20260601131311.1163914-1-vjardin@free.fr>
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

Filesystems that are null_dev_desc_ok (semihosting, ubifs) have
no UCLASS_BLK device under their ifname, so on real hardware
fs_set_blk_dev() always fails at the partition lookup.
The workaround was to add a per-filesystem
command (example cmd/ubifs.c), which duplicates the plumbing of
fstype_info.

Probe such entries with block_desc=NULL up front, so
  load semihosting <addr> <file>
works without a new command.

Sandbox boards that exercise the existing fallback through "host
bind" stay unchanged.

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

Changes in v3:
- Apply Simon Glass's v1 review:
    * Fix typo "thue" -> "the" in the commit body
    * Refactor the dispatch loop with a fs_lookup_null_dev_info()
      helper
- Add doc/usage/cmd/load.rst "Null-block-device interfaces"
- Add pytest regression tests for the `semihosting` and
  sandbox ifnames, verified passing on qemu_arm64 (with
  CONFIG_SEMIHOSTING=y) and on a sandbox build respectively. A
  ubifs test is intentionally not done.

Changes in v2:
- (v2 is my local iteration, not good for the list; the changes
  since v1 are captured in the v3 changelog below.)

 fs/fs.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/fs/fs.c b/fs/fs.c
index 8ea50a6c13c..56f3e0c9204 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -459,11 +459,53 @@ const char *fs_get_type_name(void)
 	return fs_get_info(fs_type)->name;
 }
 
+/*
+ * Some fstypes (semihosting, ubifs) have no underlying block device
+ * and ignore the block_desc argument of their probe hook. The legacy
+ * commands (ubifsload, semihosting via env macros) just pass NULL;
+ * for "load <iface> ..." to behave the same, the dispatcher opts
+ * those fstypes in by name here, before any block-device lookup is
+ * attempted.
+ *
+ * Returns the matching fstype_info if @ifname names a fstype that
+ * opts into null_dev_desc_ok dispatch and the caller's @fstype filter
+ * permits it. Returns NULL otherwise.
+ */
+static struct fstype_info *fs_lookup_null_dev_info(const char *ifname,
+						   int fstype)
+{
+	struct fstype_info *info;
+	int i;
+
+	for (i = 0, info = fstypes; i < ARRAY_SIZE(fstypes); i++, info++) {
+		if (fstype != FS_TYPE_ANY && info->fstype != FS_TYPE_ANY &&
+		    fstype != info->fstype)
+			continue;
+		if (!info->null_dev_desc_ok || !info->name)
+			continue;
+		if (!strcmp(info->name, ifname))
+			return info;
+	}
+
+	return NULL;
+}
+
 int fs_set_blk_dev(const char *ifname, const char *dev_part_str, int fstype)
 {
 	struct fstype_info *info;
 	int part, i;
 
+	info = fs_lookup_null_dev_info(ifname, fstype);
+	if (info) {
+		fs_dev_desc = NULL;
+		memset(&fs_partition, 0, sizeof(fs_partition));
+		if (!info->probe(NULL, &fs_partition)) {
+			fs_type = info->fstype;
+			fs_dev_part = 0;
+			return 0;
+		}
+	}
+
 	part = part_get_info_by_dev_and_name_or_num(ifname, dev_part_str, &fs_dev_desc,
 						    &fs_partition, 1);
 	if (part < 0)
-- 
2.43.0

