Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4060DC3DA49
	for <u-boot@archiver.kernel.org>; Sun, 14 Jul 2024 07:18:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D3B987DDF;
	Sun, 14 Jul 2024 09:18:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="IaklA0pd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B137E87DEB; Sun, 14 Jul 2024 09:18:09 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B273E87AEC
 for <u-boot@lists.denx.de>; Sun, 14 Jul 2024 09:18:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-093-080.um16.pools.vodafone-ip.de
 [62.143.93.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id C571F3F909; 
 Sun, 14 Jul 2024 07:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1720941485;
 bh=2iGta/WZFXCn9fklATieDYMQAJ/BgPVkYVJINoCOv6I=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=IaklA0pdcLNLjlZQ7azN79chh7SERj9IG11vESYOnF5alybqozWS0cP3h0qbwSosP
 TtQu/Y797bduwZw7NOz+c5YxRNVHtmMAlGTSbffZUXDtoeuq0DBbg6jv2/lbeVJCUS
 D8IxPHP3aU3iemxrbtM7FTD3FtyXYvZ4NoqjTppWXWJGYu7x3a3TLpBRH4naita/1z
 fBBxP4XGfuNPXSs1kHxobHF4n202tMFjuUmuh/9gDKmBHgRPj4nmGlnROgK23FxTiS
 569XeFInTgBEtoWPW/q/DWkKPRrPuRmkBOCSqp8InZuS8pomNr8Zbixwv56iSb2Me+
 N08eNMeb6X3Qg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <seanga2@gmail.com>,
 =?UTF-8?q?Milan=20P=20=2E=20Stani=C4=87?= <mps@arvanta.net>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: move out-of-tree building info to HTML
Date: Sun, 14 Jul 2024 09:18:04 +0200
Message-ID: <20240714071804.40534-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

Move the information about out-of-tree building
from README to the generated HTML documentation.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 README            | 20 --------------------
 doc/build/gcc.rst | 28 ++++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/README b/README
index b89768f1791..b76449b70a8 100644
--- a/README
+++ b/README
@@ -1684,26 +1684,6 @@ images ready for download to / installation on your system:
 - "u-boot" is an image in ELF binary format
 - "u-boot.srec" is in Motorola S-Record format
 
-By default the build is performed locally and the objects are saved
-in the source directory. One of the two methods can be used to change
-this behavior and build U-Boot to some external directory:
-
-1. Add O= to the make command line invocations:
-
-	make O=/tmp/build distclean
-	make O=/tmp/build NAME_defconfig
-	make O=/tmp/build all
-
-2. Set environment variable KBUILD_OUTPUT to point to the desired location:
-
-	export KBUILD_OUTPUT=/tmp/build
-	make distclean
-	make NAME_defconfig
-	make all
-
-Note that the command line "O=" setting overrides the KBUILD_OUTPUT environment
-variable.
-
 User specific CPPFLAGS, AFLAGS and CFLAGS can be passed to the compiler by
 setting the according environment variables KCPPFLAGS, KAFLAGS and KCFLAGS.
 For example to treat all compiler warnings as errors:
diff --git a/doc/build/gcc.rst b/doc/build/gcc.rst
index 3c646577272..abafe73206c 100644
--- a/doc/build/gcc.rst
+++ b/doc/build/gcc.rst
@@ -118,6 +118,34 @@ Assuming cross compiling on Debian for ARMv8 this would be
 
     CROSS_COMPILE=aarch64-linux-gnu- make
 
+Out-of-tree building
+~~~~~~~~~~~~~~~~~~~~
+
+By default building is performed locally and the objects are saved in the source
+directory. To build out-out-tree use one of the two methods below:
+
+Add O= parameter to the make command line:
+
+.. code-block:: bash
+
+    make O=/tmp/build distclean
+    make O=/tmp/build NAME_defconfig
+    make O=/tmp/build
+
+Use environment variable KBUILD_OUTPUT:
+
+.. code-block:: bash
+
+    export KBUILD_OUTPUT=/tmp/build
+    make distclean
+    make NAME_defconfig
+    make
+
+.. note::
+
+    The command line "O=" parameter overrides the KBUILD_OUTPUT environment
+    variable.
+
 Build parameters
 ~~~~~~~~~~~~~~~~
 
-- 
2.45.2

