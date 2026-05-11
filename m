Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4BECD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 11:53:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77480800AE;
	Mon, 11 May 2026 13:53:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="ZQaGhCnK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A71C8801A9; Mon, 11 May 2026 13:53:53 +0200 (CEST)
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C43CD80086
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 13:53:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 78819B00592;
 Mon, 11 May 2026 13:53:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1778500431;
 bh=wZ+u8PDHBB50J3kfxAJRB9fB7v/fOACS2iSX0iPl4+g=;
 h=From:To:Cc:Subject:Date:From;
 b=ZQaGhCnKg1wUvKmGPuJB50PJEuvpJlqrG5FO6lyAhADmzWpi/jo8nsGgGL9FIxkkT
 tWdB8j5H1WqmuajXxHXWJ0znCUuRY2oaknuUQRKgY7xXq3kyFs//xckUld0Z52CrHA
 BQC+O9+bojV7BuCP84lPilI3v6v7HoO7HMdal7TlXS9udfnDR4hpybcneqFttStLWZ
 mDwvOQ7lGjHgDBJuG/unMOHtYfpjc9rXCZSN79M0VOfuSYoiXqx7qfQH+3Y3GBebRK
 USTvuwlftIF6rDD7WymXrpOQEwxEXMbXAy45wZZPKcZ3p0sMv7W8elgO/7BD+Y8uWp
 TXDinez/ozoJA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: Vincent Jardin <vjardin@free.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 =?UTF-8?q?Timo=20tp=20Prei=C3=9Fl?= <t.preissl@proton.me>,
 Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
Subject: [PATCH v1] fs: dispatch null_dev_desc_ok filesystems before block
 lookup
Date: Mon, 11 May 2026 13:53:35 +0200
Message-ID: <20260511115340.675883-1-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
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
command (example cmd/ubifs.c), which duplicates thue plumbing of
fstype_info.

Honour the opt-in directly: probe such entries with block_desc=NULL up
front, so "load semihosting <addr> <file>" works without a new
command.

Sandbox boards that exercise the existing fallback through "host
bind" stay unchanged.

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

 fs/fs.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/fs.c b/fs/fs.c
index 8ea50a6c13c..09295e95892 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -464,6 +464,24 @@ int fs_set_blk_dev(const char *ifname, const char *dev_part_str, int fstype)
 	struct fstype_info *info;
 	int part, i;
 
+	for (i = 0, info = fstypes; i < ARRAY_SIZE(fstypes); i++, info++) {
+		if (fstype != FS_TYPE_ANY && info->fstype != FS_TYPE_ANY &&
+		    fstype != info->fstype)
+			continue;
+		if (!info->null_dev_desc_ok || !info->name)
+			continue;
+		if (strcmp(info->name, ifname) != 0)
+			continue;
+
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

base-commit: bfe90a308a94caa9d855440683521ff04122ae2a
branch: for-upstream/fs-null-dev-desc-dispatch
