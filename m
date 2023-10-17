Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5555CCDB482
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 19:47:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7E7A864D4;
	Tue, 17 Oct 2023 21:47:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=arvanta.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2243486F35; Tue, 17 Oct 2023 21:47:07 +0200 (CEST)
Received: from fx.arvanta.net (93-87-244-166.static.isp.telekom.rs
 [93.87.244.166]) by phobos.denx.de (Postfix) with ESMTP id 2C12F86308
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 21:47:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=arvanta.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=mps@arvanta.net
Received: from m1.arvanta.net (m1pro.arvanta.net [10.5.1.5])
 by fx.arvanta.net (Postfix) with ESMTP id B1A188B27;
 Tue, 17 Oct 2023 21:46:57 +0200 (CEST)
From: =?UTF-8?q?Milan=20P=2E=20Stani=C4=87?= <mps@arvanta.net>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Milan=20P=20=2E=20Stani=C4=87?= <mps@arvanta.net>
Subject: [PATCH] doc: build: update description of build dependencies for
 Alpine Linux
Date: Tue, 17 Oct 2023 21:46:58 +0200
Message-ID: <20231017194703.16448-1-mps@arvanta.net>
X-Mailer: git-send-email 2.42.0
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

---
 doc/build/gcc.rst | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/doc/build/gcc.rst b/doc/build/gcc.rst
index a0650a51db..e73f24a304 100644
--- a/doc/build/gcc.rst
+++ b/doc/build/gcc.rst
@@ -60,8 +60,28 @@ For building U-Boot on Alpine Linux at least the following packages are needed:
 
 .. code-block:: bash
 
-    apk add alpine-sdk bc bison dtc flex linux-headers ncurses-dev \
-      openssl-dev perl python3 py3-setuptools python3-dev sdl2-dev
+    apk add alpine-sdk bc bison dtc flex gnutls-dev linux-headers \
+      openssl-dev py3-elftools py3-setuptools python3-dev swig util-linux-dev
+
+Dependeing on the build target further packages may be needed
+
+For build sandbox with lcd
+
+.. code-block:: bash
+
+    apk add sdl2-dev
+
+For build riscv64 targets
+
+.. code-block:: bash
+
+    apk add opensbi
+
+For build some arm64 targets
+
+.. code-block:: bash
+
+    apk add arm-trusted-firmware
 
 Prerequisites
 -------------
-- 
2.42.0

