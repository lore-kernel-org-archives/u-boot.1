Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9376AD35E5D
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 01:38:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D462688113;
	Wed,  6 Nov 2024 02:38:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=codewreck.org header.i=@codewreck.org header.b="1CCJyX+n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2CF28904D; Wed,  6 Nov 2024 02:38:01 +0100 (CET)
Received: from submarine.notk.org (submarine.notk.org
 [IPv6:2001:bc8:3310:100::1])
 by phobos.denx.de (Postfix) with ESMTP id E78D188D8D
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 02:37:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=asmadeus@codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
 by submarine.notk.org (Postfix) with ESMTPS id F16C114C1E1
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 02:37:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
 s=2; t=1730857079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id; bh=MYb5l0YiRJp0SycPDaSi57iMv5LQosOFkuOOElLbt4k=;
 b=1CCJyX+nyJELGjyfm1BU4Yk0T3Gq8yfPNv2mfFLmD8b6yuQ9d4LIunfgcp0XmhKvNyf4hl
 QDNjOOATdQUcjpotneEO4o5hutHDyBSHIyzcAx4/vDRb3ASlhvw19pN37PgEAdP+Gdku3I
 N6mOaGF79N/aRyAWpgmr402glkLNQ6C0hslz5dWx+zqvTVUhu+HPOMKjy1fKagB6wWi1Qu
 hrBhjwp2bfwmSnWA/UasJA4yImXFjPpEegfvCDHS/5hjLf7npNEWJf5TfC6VDm7DjL0tLU
 CB16yeiT0vh/VdabLO9Q7e5aGn/tJjNsBcwqT2I78GfkZERC+Rkany+Z6K4XzA==
Received: from localhost (gaia.codewreck.org [local])
 by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 6e521da0
 for <u-boot@lists.denx.de>; Wed, 6 Nov 2024 01:37:57 +0000 (UTC)
Resent-From: Dominique Martinet <asmadeus@codewreck.org>
Resent-Date: Wed, 6 Nov 2024 10:37:42 +0900
Resent-Message-ID: <ZyrIZgacDFi0pBuP@codewreck.org>
Resent-To: u-boot@lists.denx.de
Received: from localhost (117.209.187.35.bc.googleusercontent.com.
 [35.187.209.117]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e99a525494sm211251a91.10.2024.11.05.17.29.38
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Nov 2024 17:29:39 -0800 (PST)
From: Dominique Martinet <asmadeus@codewreck.org>
To: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Qu Wenruo <wqu@suse.com>, Tom Rini <trini@konsulko.com>
Cc: Dominique Martinet <dominique.martinet@atmark-techno.com>,
 linux-btrfs@vger.kernel.org, u-boot@lists.denx.de
Subject: [u-boot PATCH] fs: btrfs: hide 'Cannot lookup file' errors on 'load'
Date: Wed,  6 Nov 2024 10:29:17 +0900
Message-Id: <20241106012918.1395878-1-dominique.martinet@atmark-techno.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TUID: ipWaBPS5zHrz
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
exists historically do not print any error on filesystems such as ext4
or fat.
Changing the root filesystem to btrfs would make existing boot script
print 'Cannot lookup file xxx' errors, confusing customers wondering if
there is a problem when the mmc load command was used in a if (for
example to load boot.scr conditionally)

Make that printf a debug message so it is not displayed by default, like
it is on other filesystems

Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---
iirc this also used to trip up some test in test/fs but I don't recall
what.

It might make sense to print that error but I think we ought to be
coherent and either print it for all fs or none; but if we print it
we'll need to prepare a new command to test file existence before
loading it.

Thanks!

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

