Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6C3CD98D2
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 23:21:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B482C84995;
	Wed, 17 Jun 2026 01:20:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ujU5Yfj8";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="HAKbPXZr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32DB284942; Wed, 17 Jun 2026 01:20:16 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6897C8499D
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 01:20:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gg2yj0m3dz9t6D;
 Wed, 17 Jun 2026 01:20:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781652013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OAb6BLTjU9zMb7aDiKW9jUsQe18D4/vfP1KB1YytqqQ=;
 b=ujU5Yfj8uKxvW/BQoeI616nm0PNk2fBlyVuvDbCc9Yr8iJrLBSGeL+Nv3KRehQdLDWF71b
 5310RTKb0w/i/gImF3IFvtrI13mc+9A7GP2xmc2GLyxmicAmZ1gNpZkEgFl8ShmBkE/xFU
 FHd49bIn0JqBDtpqSxf6FCvWxHLaz5Z+HLjHgfKV4DVkloUIRiU5pRvJmaa3A6rlQdSQR4
 +2BBdOypRWbkpSVONdIUfds7Q48SwjRnKLIZ0xLunG2u3dJbCEfSz9Udx8tLvbzN/ioynQ
 gWlMF7ShRT5m290pNCT6vLLOOdze1xUJnK5//6HNd0JuS5vwnTCO54Q0uD9IUw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781652011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OAb6BLTjU9zMb7aDiKW9jUsQe18D4/vfP1KB1YytqqQ=;
 b=HAKbPXZr6WwWXLJpyQx3frXpIlcHwD7HhKT43YSoqNBpb4TbPcp7OKBEvJ8xQp1E5Dbj9s
 O/o7snMMK666SvhYh+YLKlh4oGIDye1IWm8cCq5wD5CBMMB4/aTq+VKbfNptBFqK32OsP4
 FOmRg6IJ4QBDlV4vSSxEmn0PYfU2w8ka6U9ZBmM06EGcuyp9uLE5qFWC1vk8z7hLXber+g
 NDNoMFhS+Vj5X3XcGLWsBSEF7k0fUwm00P1UpPXQx5qhXG1SFZ+/8Lw8RL7bZ9EOCfBtwP
 qpy7+JkfqBGM/zGTG+eLHfVGXNZ4JeNdvKzqQwooCAMuC9YIsUMQrowgMyNUMA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/11] doc: board: renesas: Document Renesas R-Car Gen3 E3
 Ebisu board
Date: Wed, 17 Jun 2026 01:18:47 +0200
Message-ID: <20260616231933.44392-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260616231933.44392-1-marek.vasut+renesas@mailbox.org>
References: <20260616231933.44392-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 4d468uxkyd4y9jiqxsj47p9r3kjyqx94
X-MBO-RS-ID: f7ead0d4c9f77cef0f2
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

Add document which clarifies how to build and install U-Boot on
Renesas R-Car Gen3 E3 Ebisu board.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 doc/board/renesas/index.rst           |  1 +
 doc/board/renesas/rcar-gen3-ebisu.rst | 47 +++++++++++++++++++++++++++
 doc/board/renesas/renesas.rst         |  2 +-
 3 files changed, 49 insertions(+), 1 deletion(-)
 create mode 100644 doc/board/renesas/rcar-gen3-ebisu.rst

diff --git a/doc/board/renesas/index.rst b/doc/board/renesas/index.rst
index a75c9f08a4c..21216912463 100644
--- a/doc/board/renesas/index.rst
+++ b/doc/board/renesas/index.rst
@@ -13,6 +13,7 @@ Renesas
    rcar-gen3-salvator-x
    rcar-gen3-ulcb
    rcar-gen3-geist
+   rcar-gen3-ebisu
    rcar-gen3-install
    rcar-gen3-install-hf
    rcar-gen3-install-sf
diff --git a/doc/board/renesas/rcar-gen3-ebisu.rst b/doc/board/renesas/rcar-gen3-ebisu.rst
new file mode 100644
index 00000000000..f9632705abc
--- /dev/null
+++ b/doc/board/renesas/rcar-gen3-ebisu.rst
@@ -0,0 +1,47 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Renesas R-Car Gen3 E3 Ebisu board
+=================================
+
+- Renesas R-Car E3 Ebisu board: https://elinux.org/R-Car/Boards/Ebisu
+
+Build U-Boot
+------------
+
+Please follow :doc:`Renesas 64-bit ARM SoC build environment setup <build-env-aarch64>`
+to correctly set up the build environment before attempting to build U-Boot.
+
+Clone up to date U-Boot source code and change directory into the
+newly cloned source directory:
+
+.. code-block:: console
+
+    $ git clone https://source.denx.de/u-boot/u-boot.git/
+    $ cd u-boot
+
+Configure U-Boot:
+
+.. code-block:: console
+
+    $ make r8a77990_ebisu_defconfig
+
+Compile U-Boot:
+
+.. code-block:: console
+
+    $ make
+
+To speed up build process, -jN option can be passed to make to start
+multiple jobs at the same time, this is beneficial especially on SMP
+systems. The following example starts up to number of CPUs in the
+system jobs, which is the recommended amount:
+
+.. code-block:: console
+
+    $ make -j$(nproc)
+
+Install U-Boot
+--------------
+
+Please follow :doc:`Renesas R-Car Gen3 U-Boot installation <rcar-gen3-install>`
+to install U-Boot into HyperFlash.
diff --git a/doc/board/renesas/renesas.rst b/doc/board/renesas/renesas.rst
index e0c09798dbd..8aa868760d8 100644
--- a/doc/board/renesas/renesas.rst
+++ b/doc/board/renesas/renesas.rst
@@ -151,7 +151,7 @@ Renesas is a SoC solutions provider for automotive and industrial applications.
      - r8a77980_v3hsk_defconfig
 
    * -
-     - Ebisu
+     - :doc:`Ebisu <rcar-gen3-ebisu>`
      - R8A77990 (E3)
      - :doc:`arm64 <build-env-aarch64>`
      - r8a77990_ebisu_defconfig
-- 
2.53.0

