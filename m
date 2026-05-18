Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE26CD343F
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 05:58:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F07098469F;
	Mon, 18 May 2026 07:57:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="rS8V2N0c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B18D845E3; Mon, 18 May 2026 07:57:56 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E75B83AA9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 07:57:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-046-114-109-175.46.114.pool.telefonica.de
 [46.114.109.175])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 7336F41789; 
 Mon, 18 May 2026 05:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779083874;
 bh=rZ34LCbq2pNFaDxGnKA6p3saaRkrcQKrSdAmHUrGc6A=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=rS8V2N0cQs2JYG9WVBHk9l9T7k9f0rg2/UOOuNDRlVOT48GNlsdyajHWOiX15EgUz
 2wuK8+UGrTjwSH11lyUPeUB/XMIwMOUR+a6ua8MpWmHIW5VQefIlGVCCtXZIRDiiry
 3z58xN/zvcpNwFazZzePE5zyJjptmRRlNydpKgvE/FLBLDqtfxjB1MctVXjaIRMB/Q
 kfKifQkhJxlUGjaA2sRlVLEoCqrayRfOFUBMVbMfOp4zH3KHy1MoBj7W7np7/EKTzw
 f7HO7+5jiT/pt8z0dFecrUvhHTP46ErbfTVssDeUhgnF0dqRcRrlauOkDrwDmxsf6F
 h9skGdW69R7NRfhWikbvSKbmiEasB0YGSMhhHDVuvq6dJG45EF6YNr+WzZv93Kgyx+
 MHBLUSFuaV6ivFL5OETwZDc4rIc4C1arQh6m1gwsNfb7BQUsKrMsNKdQxLUVLPb6av
 TkGcFNNMjQVaZM8rLQZx4Y6IDBQUcpS+KIrZyv6ENLpYM6sQAfj+ZOdqN9AaWA+wA9
 u5l+2M/h0I05e1ta9jXFmI5RyzkG80lKH9Gl+JHu0payNeq8HWNWQcBq98jxArNDdy
 u+8bBOzpv26Qh+jMzK6eWiHNZiunTAnbo/QwAPcI3cidprj4LbjFx5TpokUYpOrkQq
 dmmlQV51IvkpjU69P72pyV0c=
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
Subject: [PATCH 4/9] fs: ext4: don't read time fields in XPL
Date: Mon, 18 May 2026 07:57:23 +0200
Message-ID: <20260518055728.178507-5-heinrich.schuchardt@canonical.com>
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

The ext4 readdir implementation populates dent time fields in XML
builds though that information is never used.

Guard the three rtc_to_tm() calls with !IS_ENABLED(CONFIG_XPL_BUILD),
consistent with the FAT driver.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 fs/ext4/ext4fs.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/ext4fs.c b/fs/ext4/ext4fs.c
index 3c79a889bc2..abf4a9835bc 100644
--- a/fs/ext4/ext4fs.c
+++ b/fs/ext4/ext4fs.c
@@ -319,9 +319,11 @@ int ext4fs_readdir(struct fs_dir_stream *fs_dirs, struct fs_dirent **dentp)
 		dent->type = FILETYPE_UNKNOWN;
 	}
 
-	rtc_to_tm(fdiro.inode.atime, &dent->access_time);
-	rtc_to_tm(fdiro.inode.ctime, &dent->create_time);
-	rtc_to_tm(fdiro.inode.mtime, &dent->change_time);
+	if (!IS_ENABLED(CONFIG_XPL_BUILD)) {
+		rtc_to_tm(le32_to_cpu(fdiro.inode.atime), &dent->access_time);
+		rtc_to_tm(le32_to_cpu(fdiro.inode.ctime), &dent->create_time);
+		rtc_to_tm(le32_to_cpu(fdiro.inode.mtime), &dent->change_time);
+	}
 
 	dirs->fpos += le16_to_cpu(dirent.direntlen);
 	dent->size = fdiro.inode.size;
-- 
2.53.0

