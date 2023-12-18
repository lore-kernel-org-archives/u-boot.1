Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88378C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 07:38:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBEA18773F;
	Mon, 18 Dec 2023 08:38:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=tkos.co.il header.i=@tkos.co.il header.b="nZL9nwhU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D40F8877A9; Mon, 18 Dec 2023 08:38:02 +0100 (CET)
Received: from mail.tkos.co.il (golan.tkos.co.il [84.110.109.230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56DDA876DE
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 08:38:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=tkos.co.il
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=baruch@tkos.co.il
Received: from sapphire.neureality.corp (unknown [10.0.4.11])
 by mail.tkos.co.il (Postfix) with ESMTP id 64E774406B7;
 Mon, 18 Dec 2023 09:36:14 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
 s=default; t=1702884974;
 bh=ySbCJAAkq5MfHwqa+WNvGCbtcD/RWvxQsjjBVDpO8ko=;
 h=From:To:Cc:Subject:Date:From;
 b=nZL9nwhUzRVmxWXMJ7R1WFii099R0ugCtBgGkkprEtk129frcvmLIYcNxlsNMffv/
 j6SXl4nCjMGs3ip5AsKl5kBBog8zHtvc0g33A1VATgz1iB84BlKTXPzXqm5rG/CoTu
 6vSkbNEU/lLFmnm9YDuSY4NIQgM5Mwd1ceIzgynugRE6Csh2JDpWFz85q72bvDpsXL
 7omAHt7erRoomztsxclbAxf3e9s65ZUWd+maw8rRtIZsRu0yc/08ShNjB8jLQm5vwo
 xatgl3XkbCTnb1HOog86apRNf+A/s+wOuMBi5IvvBoPf14sokD48vdM5zzKPS4K+7B
 Xkgm69Ov5AIzw==
From: Baruch Siach <baruch@tkos.co.il>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de,
	Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] net: fix NetConsole documentation reference
Date: Mon, 18 Dec 2023 09:37:53 +0200
Message-ID: <e418d8cdf88c8ecf8cf1b9d50ae53aacfe884f94.1702885073.git.baruch@tkos.co.il>
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

Fixes: d0253f7e5ca1 ("doc: move README.NetConsole to HTML documentation")
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 net/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/Kconfig b/net/Kconfig
index 4215889127c9..92a22ac1ea55 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -57,7 +57,7 @@ config NETCONSOLE
 	bool "NetConsole support"
 	help
 	  Support the 'nc' input/output device for networked console.
-	  See README.NetConsole for details.
+	  See doc/usage/netconsole.rst for details.
 
 config IP_DEFRAG
 	bool "Support IP datagram reassembly"
-- 
2.43.0

