Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 300F0D6A223
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 02:16:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7699C8969E;
	Fri, 15 Nov 2024 03:16:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=codewreck.org header.i=@codewreck.org header.b="N+CAoUHs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47742896A9; Fri, 15 Nov 2024 03:16:13 +0100 (CET)
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
 by phobos.denx.de (Postfix) with ESMTP id D609289304
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 03:16:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=asmadeus@codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
 by submarine.notk.org (Postfix) with ESMTPS id 29BB614C1E1;
 Fri, 15 Nov 2024 03:16:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
 s=2; t=1731636969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Sx48EYv9NA9H8dCcyhct5zxdcy6M75AqOCNrDpv3RKA=;
 b=N+CAoUHsDFlD0Nomah5s76r5cofgd1/r17JbfDElP6Jcm3yxiGF0xbrASiJPKabwpMhzFZ
 nC8dfeajIERdBq9qM/kDMOqo4+hFGGDbOzfNwjITWbaxLQ8Ci0VQqVUvusphlmIkT5DeQd
 d+5R8gYINjjTGSM8RKtgefaILx8r92sL5VeIIibPIz0HSIuIBQl9JcYrjTgD9n9f7C3mrU
 pe9JfspNolSwEUpXzwP/e+Z8OtbprKUpFpn8WxtzjlbmXxcyOqiaqtln64dHh+iDe/SiAK
 QP9CYxfkhkc3sLZ3FwRRnyeea7EBQN9VPov6j5nhqHXLKaRwGvfzRa2oCI71Ow==
Received: from gaia.codewreck.org (localhost.lan [::1])
 by gaia.codewreck.org (OpenSMTPD) with ESMTP id a9114616;
 Fri, 15 Nov 2024 02:16:06 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
To: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: Dominique Martinet <dominique.martinet@atmark-techno.com>,
 linux-btrfs@vger.kernel.org, u-boot@lists.denx.de
Subject: [PATCH u-boot v2] fs: btrfs: hide duplicate 'Cannot lookup file'
 error on 'load'
Date: Fri, 15 Nov 2024 11:15:47 +0900
Message-ID: <20241115021549.671932-1-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.46.1
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

From: Dominique Martinet <dominique.martinet@atmark-techno.com>

Running commands such as 'load mmc 2:1 $addr $path' when path does not
exists will print an error twice if the file does not exist, e.g.:
```
Cannot lookup file boot/boot.scr
Failed to load 'boot/boot.scr'
```
(where the first line is printed by btrfs and the second by common fs
code)

Historically other filesystems such as ext4 or fat have not been
printing a message here, so do the same here to avoid duplicate.

The other error messages in this function are also somewhat redundant,
but bring useful diagnostics if they happen somewhere, so have been left
as printf.

Note that if a user wants no message to be printed for optional file
loads, they have to check for file existence first with other commands
such as 'size'.

Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
v1: https://lkml.kernel.org/r/20241106012918.1395878-1-dominique.martinet@atmark-techno.com
v1->v2: reword commit message to account for the "new" fs/fs error
messages existing

 fs/btrfs/btrfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/btrfs.c b/fs/btrfs/btrfs.c
index 350cff0cbca0..f3087f690fa4 100644
--- a/fs/btrfs/btrfs.c
+++ b/fs/btrfs/btrfs.c
@@ -193,7 +193,7 @@ int btrfs_size(const char *file, loff_t *size)
 	ret = btrfs_lookup_path(fs_info->fs_root, BTRFS_FIRST_FREE_OBJECTID,
 				file, &root, &ino, &type, 40);
 	if (ret < 0) {
-		printf("Cannot lookup file %s\n", file);
+		debug("Cannot lookup file %s\n", file);
 		return ret;
 	}
 	if (type != BTRFS_FT_REG_FILE) {
-- 
2.39.5

