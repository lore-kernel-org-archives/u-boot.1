Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4240DEE49AB
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 18:54:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF43C86400;
	Tue, 22 Aug 2023 20:54:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF7D1846C0; Tue, 22 Aug 2023 20:54:09 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 4F7B3855CE
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 20:54:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.01,193,1684767600"; d="scan'208";a="177306282"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 23 Aug 2023 03:54:05 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.37])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id B11C1409F99D;
 Wed, 23 Aug 2023 03:54:03 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/2] doc: Highlight the most relevant u-boot talks
Date: Tue, 22 Aug 2023 19:53:59 +0100
Message-Id: <20230822185359.366677-2-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822185359.366677-1-paul.barker.ct@bp.renesas.com>
References: <20230822185359.366677-1-paul.barker.ct@bp.renesas.com>
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

The list of u-boot talks on elinux.org is quite long, so let's highlight
the talks which are likely most relevant for newcomers.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 doc/learn/talks.rst | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/doc/learn/talks.rst b/doc/learn/talks.rst
index 33bac483e178..0bb44aeabe55 100644
--- a/doc/learn/talks.rst
+++ b/doc/learn/talks.rst
@@ -3,9 +3,18 @@
 U-Boot Talks
 ============
 
-U-Boot is a topic at various conferences each year. These talkes might help you
-learn a bit about U-Boot.
+U-Boot is a topic at various conferences each year. These talks might help you
+learn a bit about U-Boot:
 
-See elinux_talks_ for a list.
+* `Tutorial: Introduction to the Embedded Boot Loader U-boot - Behan Webster,
+  Converse in Code <https://www.youtube.com/watch?v=INWghYZH3hI>`__
+  from Embedded Linux Conference 2020
+  (`slides <https://cm.e-ale.org/2020/ELC2020/intro-to-u-boot/intro-to-u-boot-2020.pdf>`__).
+
+* `Recent Advances in U-Boot - Simon Glass, Google Inc.
+  <https://www.youtube.com/watch?v=YlJBsVZJkDI>`__
+  from Embedded Linux Conference 2023.
+
+See elinux_talks_ for a more comprehensive list.
 
 .. _elinux_talks: https://elinux.org/Boot_Loaders#U-Boot
-- 
2.34.1

