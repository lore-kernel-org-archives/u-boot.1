Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59FC8C61DC4
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 19:54:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 21B3140843;
	Thu, 27 Aug 2026 19:54:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lXVzm5h9Y3w3; Thu, 27 Aug 2026 19:54:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787860457;
	bh=PJ+Oa9l4ewy23LotSTRb38JLJeXIAvqAOOCQ5EKtPiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zBivwnER5ltUV8jp0snK79q64AMnm9ZVqrR8YRcYIlfsvRl58p4H0zcPJpHX1gFPw
	 GZeBVOnhKTNd25OWxQR4ya7VbE+h3xOyV3G+nrGKGUSqjO3EIUtHZQ2N6ToXx2TSwa
	 S2RpHnKBB8ys9RjdFsfp60cnZU9KdjmUbitzno3aypFajvu4k7pdevrlQqDEWFSTa4
	 w+TtBmQ0qmchCIMlD+mufFp0JkTqCVKn4ru6yBfOi+LZjXH9Y/X07heKwssZ6RDiHH
	 wObyrh6aGoSx+xZWbLbLQQVI2x41W8aeCeHz+J4R1BOxiDKLAZeoxrCPBgpfclU8Yy
	 MoU9HKDMsMNDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0FBD74084A;
	Thu, 27 Aug 2026 19:54:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 31757334
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:54:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 15E7280F00
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:54:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3j0aOC9-2C1e for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 19:54:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=84.16.66.175;
 helo=smtp-42af.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=bPCJrchU
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch
 [84.16.66.175])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CC78880EFA
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:54:04 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hWBzZ3tySz2hV;
 Thu, 27 Aug 2026 21:54:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787860442;
 bh=PJ+Oa9l4ewy23LotSTRb38JLJeXIAvqAOOCQ5EKtPiQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bPCJrchU7bZ9MbxIaXAczJqC0a0yvLrCH3z5FPNTRH44Fpx3QYtiutL/YsdQu5cpA
 0Ro7/R2E7hE81mulmWnG8nMvNnlGRMPkJdZMlxpb6vguGwol+Gg0lVyVlANzUoswGa
 dh0Wc58zhVYSAdJtRHz/DP+vKBUHNp6Mo1wv7lYKIk3gLvja//xS2J0w9TOo1UhCh2
 r9keDLqv3r86O75LHiiwaOR8dhvg6Bi4SsbHT7cnKl+YDUPX0Nvd2liCAJ7ERV6Fv8
 lVE2uCJyQhOOEu2ZbKZW6OnGWsyj3Sv0dvga/fDl9A8cIBH2L62cDUupDyvLEg2sva
 6vDQcwc2BDuYw==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hWBzX6P9RzQb7; Thu, 27 Aug 2026 21:54:00 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
To: u-boot@lists.u-boot-project.org,
	u-boot-amlogic@groups.io
Cc: uboot-imx@nxp.com, trini@konsulko.com, sjg@chromium.org,
 neil.armstrong@linaro.org, marek.vasut+renesas@mailbox.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, adeep@lexina.in,
 sbabic@nabladev.com, festevam@gmail.com, smoch@web.de,
 alpernebiyasak@gmail.com, le.jin@siemens.com, jan.kiszka@siemens.com,
 iwamatsu@nigauri.org, pbrobinson@gmail.com, seanga2@gmail.com,
 bmeng.cn@gmail.com, lukma@denx.de, mkorpershoek@kernel.org,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH 36/45] doc: board/renesas: update clone instructions to use
 new GitLab
Date: Thu, 27 Aug 2026 21:53:04 +0200
Message-ID: <20260827195313.129994-15-foss+uboot@0leil.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Quentin Schulz <quentin.schulz@cherry.de>

While source.denx.de still resolves at the moment, it's not guaranteed
it'll do so forever. So migrate the instructions to the new GitLab at
git.u-boot-project.org.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/board/renesas/rcar-gen3-draak.rst        | 2 +-
 doc/board/renesas/rcar-gen3-ebisu.rst        | 2 +-
 doc/board/renesas/rcar-gen3-geist.rst        | 2 +-
 doc/board/renesas/rcar-gen3-salvator-x.rst   | 2 +-
 doc/board/renesas/rcar-gen3-ulcb.rst         | 2 +-
 doc/board/renesas/rcar-gen4-sparrow-hawk.rst | 2 +-
 doc/board/renesas/rcar-gen5-ironhide.rst     | 4 ++--
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/doc/board/renesas/rcar-gen3-draak.rst b/doc/board/renesas/rcar-gen3-draak.rst
index 7b94eaa4b237..061ecd05291a 100644
--- a/doc/board/renesas/rcar-gen3-draak.rst
+++ b/doc/board/renesas/rcar-gen3-draak.rst
@@ -16,7 +16,7 @@ newly cloned source directory:
 
 .. code-block:: console
 
-    $ git clone https://source.denx.de/u-boot/u-boot.git/
+    $ git clone https://git.u-boot-project.org/u-boot/u-boot.git
     $ cd u-boot
 
 Configure U-Boot:
diff --git a/doc/board/renesas/rcar-gen3-ebisu.rst b/doc/board/renesas/rcar-gen3-ebisu.rst
index f9632705abcf..a41f736a767f 100644
--- a/doc/board/renesas/rcar-gen3-ebisu.rst
+++ b/doc/board/renesas/rcar-gen3-ebisu.rst
@@ -16,7 +16,7 @@ newly cloned source directory:
 
 .. code-block:: console
 
-    $ git clone https://source.denx.de/u-boot/u-boot.git/
+    $ git clone https://git.u-boot-project.org/u-boot/u-boot.git
     $ cd u-boot
 
 Configure U-Boot:
diff --git a/doc/board/renesas/rcar-gen3-geist.rst b/doc/board/renesas/rcar-gen3-geist.rst
index 7bedb3a79cb5..63abb3e22b4d 100644
--- a/doc/board/renesas/rcar-gen3-geist.rst
+++ b/doc/board/renesas/rcar-gen3-geist.rst
@@ -14,7 +14,7 @@ newly cloned source directory:
 
 .. code-block:: console
 
-    $ git clone https://source.denx.de/u-boot/u-boot.git/
+    $ git clone https://git.u-boot-project.org/u-boot/u-boot.git
     $ cd u-boot
 
 Configure U-Boot:
diff --git a/doc/board/renesas/rcar-gen3-salvator-x.rst b/doc/board/renesas/rcar-gen3-salvator-x.rst
index 37f009452e5d..a6ef15a6da40 100644
--- a/doc/board/renesas/rcar-gen3-salvator-x.rst
+++ b/doc/board/renesas/rcar-gen3-salvator-x.rst
@@ -17,7 +17,7 @@ newly cloned source directory:
 
 .. code-block:: console
 
-    $ git clone https://source.denx.de/u-boot/u-boot.git/
+    $ git clone https://git.u-boot-project.org/u-boot/u-boot.git
     $ cd u-boot
 
 Configure U-Boot:
diff --git a/doc/board/renesas/rcar-gen3-ulcb.rst b/doc/board/renesas/rcar-gen3-ulcb.rst
index 88ec2276a366..01e15fa29b67 100644
--- a/doc/board/renesas/rcar-gen3-ulcb.rst
+++ b/doc/board/renesas/rcar-gen3-ulcb.rst
@@ -18,7 +18,7 @@ newly cloned source directory:
 
 .. code-block:: console
 
-    $ git clone https://source.denx.de/u-boot/u-boot.git/
+    $ git clone https://git.u-boot-project.org/u-boot/u-boot.git
     $ cd u-boot
 
 Configure U-Boot:
diff --git a/doc/board/renesas/rcar-gen4-sparrow-hawk.rst b/doc/board/renesas/rcar-gen4-sparrow-hawk.rst
index a1b92ecab57d..af1eb6c6f6f7 100644
--- a/doc/board/renesas/rcar-gen4-sparrow-hawk.rst
+++ b/doc/board/renesas/rcar-gen4-sparrow-hawk.rst
@@ -17,7 +17,7 @@ newly cloned source directory:
 
 .. code-block:: console
 
-    $ git clone https://source.denx.de/u-boot/u-boot.git/
+    $ git clone https://git.u-boot-project.org/u-boot/u-boot.git
     $ cd u-boot
 
 Configure U-Boot:
diff --git a/doc/board/renesas/rcar-gen5-ironhide.rst b/doc/board/renesas/rcar-gen5-ironhide.rst
index 0e775a88f8d6..31a5bb14ae68 100644
--- a/doc/board/renesas/rcar-gen5-ironhide.rst
+++ b/doc/board/renesas/rcar-gen5-ironhide.rst
@@ -22,7 +22,7 @@ newly cloned source directory:
 
 .. code-block:: console
 
-    $ git clone https://source.denx.de/u-boot/u-boot.git/
+    $ git clone https://git.u-boot-project.org/u-boot/u-boot.git
     $ cd u-boot
 
 Configure U-Boot:
@@ -71,7 +71,7 @@ newly cloned source directory:
 
 .. code-block:: console
 
-    $ git clone https://source.denx.de/u-boot/u-boot.git/
+    $ git clone https://git.u-boot-project.org/u-boot/u-boot.git
     $ cd u-boot
 
 Configure U-Boot:
