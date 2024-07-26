Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A44A0C3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 17:18:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6700885AE;
	Fri, 26 Jul 2024 19:18:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=short.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 046BF88648; Fri, 26 Jul 2024 19:18:05 +0200 (CEST)
Received: from mx01.ayax.eu (mx01.ayax.eu [188.137.98.110])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E315F885A8
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 19:18:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=short.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gszymaszek@short.pl
Received: from [192.168.192.146] (port=49304 helo=nx64de-b91e0e)
 by mx01.ayax.eu with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <gszymaszek@short.pl>)
 id 1sXOZt-000fLA-U9; Fri, 26 Jul 2024 19:18:02 +0200
Date: Fri, 26 Jul 2024 19:18:00 +0200
From: Grzegorz Szymaszek <gszymaszek@short.pl>
To: u-boot@lists.denx.de
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 2/3] doc: stm32mp1: fix literal block markers (::)
Message-ID: <789acb2e22e681aa86302d522c9385a4bae34582.1722014005.git.gszymaszek@short.pl>
Mail-Followup-To: u-boot@lists.denx.de,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 uboot-stm32@st-md-mailman.stormreply.com
References: <41ae952bf3f45545e3c6579463df3d0408f6343a.1722014005.git.gszymaszek@short.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41ae952bf3f45545e3c6579463df3d0408f6343a.1722014005.git.gszymaszek@short.pl>
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

Signed-off-by: Grzegorz Szymaszek <gszymaszek@short.pl>
---
 doc/board/st/stm32mp1.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/board/st/stm32mp1.rst b/doc/board/st/stm32mp1.rst
index 239e18b5e17..98167e80618 100644
--- a/doc/board/st/stm32mp1.rst
+++ b/doc/board/st/stm32mp1.rst
@@ -265,7 +265,7 @@ Build Procedure
      # make stm32mp15_defconfig
      # make DEVICE_TREE=stm32mp157c-ev1-scmi all
 
-    or without SCMI support
+    or without SCMI support::
 
      # export KBUILD_OUTPUT=stm32mp15
      # make stm32mp15_defconfig
@@ -796,7 +796,7 @@ You can update the boot device:
 When the board is booting for nor0 or nand0,
 only the MTD partition on the boot devices are available, for example:
 
-- NOR (nor0 = alt 20, nor1 = alt 26) & NAND (nand0 = alt 27) :
+- NOR (nor0 = alt 20, nor1 = alt 26) & NAND (nand0 = alt 27)::
 
   $> dfu-util -d 0483:5720 -a 21 -D tf-a-stm32mp157c-ev1.stm32
   $> dfu-util -d 0483:5720 -a 22 -D tf-a-stm32mp157c-ev1.stm32
-- 
2.43.0
