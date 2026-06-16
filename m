Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFCECCD98E1
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 23:20:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39EC884979;
	Wed, 17 Jun 2026 01:20:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="W90z8xmc";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NMTqsQZ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5C2D8498B; Wed, 17 Jun 2026 01:20:13 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93EAB84975
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 01:20:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gg2yf2CYGz9vBv;
 Wed, 17 Jun 2026 01:20:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781652010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hFkYQnvkqKgFW1K4ihu5bU9hXKY+h/SH6G0jZX9FAjI=;
 b=W90z8xmccP+ksqGZzxTuQfHqR4ffdJX9A2bi1+j5FzfBIe6KWH/zSUiIdNA1+k24fIXXlq
 Vs4opiMx3eobnJXlH19T1tcBlHtgl+n/aiFWnMt5iVJPK3QJV/9A5tMC/AJJwC207BmleF
 dhAhpv07Tmevwi0+b1ieGV1lF4pAtqDDttYJrUsAXClUByiBWO4HiNc+TOlTFhdpnbVQxT
 XR7rhO5HgSrBCUzZJBnzBRwOsz1K4LZn2SX2kaxAgwfT3TA53iXGOljzXN00pVd6iygL7S
 pdansh9xXR2uK+Ns2NMwuoqu3IJe0rvEZtrnB2KLreHBq3vjq5wY7UuUjzghOg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=NMTqsQZ+;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781652008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hFkYQnvkqKgFW1K4ihu5bU9hXKY+h/SH6G0jZX9FAjI=;
 b=NMTqsQZ+kTAj4Qg7gy9mPYAGEVbZmKv+h/kbHHbmZPVDo8ZTC7k2UMA0saSvXkiK4HoLTg
 MvRl3pRC5CsgGmn2bOqtvvlhv0jz9cM0mbTsHgNQieyCut5CMx4HkRyDj2nB7NCKYLL11c
 pw47QB5pGryAp4LOn32b6/wyy6hcApPDoqpfA1buG8Ip2oZYr2g5/W1+LJj2xsgak/bkxM
 3pZLs8sNqsEYw1AkHCn6nPdGOl5kNH2gubAJfFd0D7rT9LQ4+uUZpPbOlzzf22lk4KXZVv
 JpJWyNKnmIDtm9QG01qO5Alnq2ERu1sbfyngITZE6ZfkIAEALKtGTEMvy8UHSA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/11] doc: board: renesas: Document Renesas R-Car Gen3
 H3/M3-W/M3-N ULCB board
Date: Wed, 17 Jun 2026 01:18:45 +0200
Message-ID: <20260616231933.44392-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260616231933.44392-1-marek.vasut+renesas@mailbox.org>
References: <20260616231933.44392-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: f282764b0307d0755bf
X-MBO-RS-META: 93rntwcgrmxd1jpefmpaq4rkr4b19fe7
X-Rspamd-Queue-Id: 4gg2yf2CYGz9vBv
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
Renesas R-Car Gen3 H3/M3-W/M3-N ULCB board.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 doc/board/renesas/index.rst          |  1 +
 doc/board/renesas/rcar-gen3-ulcb.rst | 49 ++++++++++++++++++++++++++++
 doc/board/renesas/renesas.rst        |  6 ++--
 3 files changed, 53 insertions(+), 3 deletions(-)
 create mode 100644 doc/board/renesas/rcar-gen3-ulcb.rst

diff --git a/doc/board/renesas/index.rst b/doc/board/renesas/index.rst
index eca06a13d0c..b9bbe1f82f6 100644
--- a/doc/board/renesas/index.rst
+++ b/doc/board/renesas/index.rst
@@ -11,6 +11,7 @@ Renesas
    build-env-aarch32
    build-env-aarch64
    rcar-gen3-salvator-x
+   rcar-gen3-ulcb
    rcar-gen3-install
    rcar-gen3-install-hf
    rzn1
diff --git a/doc/board/renesas/rcar-gen3-ulcb.rst b/doc/board/renesas/rcar-gen3-ulcb.rst
new file mode 100644
index 00000000000..88ec2276a36
--- /dev/null
+++ b/doc/board/renesas/rcar-gen3-ulcb.rst
@@ -0,0 +1,49 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Renesas R-Car Gen3 H3/M3-W/M3-N ULCB board
+==========================================
+
+- Renesas R-Car H3 ULCB board: https://elinux.org/R-Car/Boards/H3SK
+- Renesas R-Car M3-W ULCB board: https://elinux.org/R-Car/Boards/M3SK
+- Renesas R-Car M3-N ULCB board: https://elinux.org/R-Car/Boards/M3NSK
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
+    $ make rcar3_ulcb_defconfig
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
index 132605b0c33..7fcd0e455b3 100644
--- a/doc/board/renesas/renesas.rst
+++ b/doc/board/renesas/renesas.rst
@@ -91,7 +91,7 @@ Renesas is a SoC solutions provider for automotive and industrial applications.
      - rcar3_salvator-x_defconfig
 
    * -
-     - ULCB
+     - :doc:`ULCB <rcar-gen3-ulcb>`
      - R8A77951 (H3)
      - :doc:`arm64 <build-env-aarch64>`
      - rcar3_ulcb_defconfig
@@ -103,7 +103,7 @@ Renesas is a SoC solutions provider for automotive and industrial applications.
      - rcar3_salvator-x_defconfig
 
    * -
-     - ULCB
+     - :doc:`ULCB <rcar-gen3-ulcb>`
      - R8A77960 (M3-W)
      - :doc:`arm64 <build-env-aarch64>`
      - rcar3_ulcb_defconfig
@@ -115,7 +115,7 @@ Renesas is a SoC solutions provider for automotive and industrial applications.
      - rcar3_salvator-x_defconfig
 
    * -
-     - ULCB
+     - :doc:`ULCB <rcar-gen3-ulcb>`
      - R8A77965 (M3-N)
      - :doc:`arm64 <build-env-aarch64>`
      - rcar3_ulcb_defconfig
-- 
2.53.0

