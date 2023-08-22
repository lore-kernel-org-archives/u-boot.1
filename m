Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B87EE49AB
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 18:54:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A59DF855CE;
	Tue, 22 Aug 2023 20:54:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 713BE863E1; Tue, 22 Aug 2023 20:54:09 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 775B2846C0
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 20:54:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.01,193,1684767600"; d="scan'208";a="177306278"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 23 Aug 2023 03:54:03 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.37])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id ACD20409F986;
 Wed, 23 Aug 2023 03:54:01 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/2] doc: Explicitly list build dependencies for docs
Date: Tue, 22 Aug 2023 19:53:58 +0100
Message-Id: <20230822185359.366677-1-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
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

Highlight the packages which need to be installed in order to build the
docs.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 doc/build/documentation.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/doc/build/documentation.rst b/doc/build/documentation.rst
index 011cd34a57c0..20b0fefa2d88 100644
--- a/doc/build/documentation.rst
+++ b/doc/build/documentation.rst
@@ -5,6 +5,17 @@ Building documentation
 
 The U-Boot documentation is based on the Sphinx documentation generator.
 
+In addition to the Python packages listed in ``doc/sphinx/requirements.txt``,
+the following dependencies are needed to build the documentation:
+
+* fontconfig
+
+* graphviz
+
+* imagemagick
+
+* texinfo (if building the `Infodoc documentation`_)
+
 HTML documentation
 ------------------
 
-- 
2.34.1

