Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107DCC54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 08:09:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A28D8801A;
	Wed, 27 Mar 2024 09:09:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="It8OAM8/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 152A28801A; Wed, 27 Mar 2024 09:09:29 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4E3A88044
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 09:09:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-245-032.um16.pools.vodafone-ip.de
 [62.143.245.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D469A3F3BA; 
 Wed, 27 Mar 2024 08:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1711526966;
 bh=9ROpRIKUugFKrAg8fKAUj38MMG6SBpUlFH7C373Vh6o=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=It8OAM8/1hdmiaY4UzSl1ZGYJnlhJZaZbKC9tdRWA2aYeY2bphYSbQ5sM+RnPRIhy
 gK1kMjgrFFNfmemn+30rAKrPd3dbDaHRrTB0Kkxe21OVsp3o8uf6XVCeLqmpsTMLBb
 bnoF3oQ/bhH8ECqfmyC1w483lUpX8rLM8BeNlYtgk9g56K5VdLi2nLzYXKTpj0ab+T
 pcHSBGm9CB0PV/XUYfPr7tkNxDzt42Io2SMJD4dJE5bIHPvRSIraSK2W+m8b8+WXEb
 DZz8Z7+PBomcb+nqidwM8HDFv9B4RUAh7z5cH2afJZAdNP+Jc/p2wYKuc5hmomJYuC
 Xeshbl+at2dKw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Sean Anderson <seanga2@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] fs: ext4: all file paths are absolute
Date: Wed, 27 Mar 2024 09:09:27 +0100
Message-ID: <20240327080927.21401-1-heinrich.schuchardt@canonical.com>
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

U-Boot only knows absolute file paths. It is inconsistent to require that
saving to an ext4 file system should use a leading '/' while reading does
not. Remove the superfluous check.

Reported-by: Patrice Chotard <patrice.chotard@foss.st.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Tested-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
v2:
	fix typo in commit message
---
 fs/ext4/ext4_common.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/ext4/ext4_common.c b/fs/ext4/ext4_common.c
index 365c5147c4b..2ff0dca2495 100644
--- a/fs/ext4/ext4_common.c
+++ b/fs/ext4/ext4_common.c
@@ -765,11 +765,6 @@ int ext4fs_get_parent_inode_num(const char *dirname, char *dname, int flags)
 	struct ext2_inode *first_inode = NULL;
 	struct ext2_inode temp_inode;
 
-	if (*dirname != '/') {
-		printf("Please supply Absolute path\n");
-		return -1;
-	}
-
 	/* TODO: input validation make equivalent to linux */
 	depth_dirname = zalloc(strlen(dirname) + 1);
 	if (!depth_dirname)
-- 
2.43.0

