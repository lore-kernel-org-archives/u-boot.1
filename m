Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19F0CD98E1
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 23:21:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 200CC84975;
	Wed, 17 Jun 2026 01:20:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="neonSyIb";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="JneTwRYA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F5068497A; Wed, 17 Jun 2026 01:20:17 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CD7684895
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 01:20:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gg2yk6CYCz9v0L;
 Wed, 17 Jun 2026 01:20:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781652014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+bKxIIqymE4cK7g7TePvcoRZ6uw+1c+UFotKrBiL374=;
 b=neonSyIbqRV4FavfAajSzyzyVEjbbC+qjN/KeEPvfE9RBL3IErVLrXHXWvjKlfJ50acnbo
 qfeH8pgZdkEByIkF5gy+75k30g7eia36CiiZC7DHJ7LAJo2Gh+4LuwpbMT2oEfX1g2vh1B
 EYcd0xM6XS1ur71iZIFONMzDv/4DRPv9zEZLmcznadCn5LQnO5lbDe8/8iuTsw+wBlfq9I
 IUYgBtaFr08dsr4zsZIvd7qdxuWHM+jRI1day9AZn5zEqrE4JmwjmUQKetJQjBLMCCMrqJ
 S5JS1OQRxBXwPV36KAy9WArM4CLfXWBkLo7XiS2P+c9tURDTvW7Ngij/QeCWMg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=JneTwRYA;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781652012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+bKxIIqymE4cK7g7TePvcoRZ6uw+1c+UFotKrBiL374=;
 b=JneTwRYArgHz3BtHDpBgYZJTWbMOupuD5I8mJYdXUJY7bmeFF4CXy3qA6xHses4oq6V24b
 xs2jBWM7qWd9XYkAXH4PWh33olappfxgTr7wpxZCdmB/5NUDRgCY5KDqJGahO87QVup/Ko
 Jzsh8fG/E7gyAoZEi3L8tEbFNrF92UcT/DVRGsTELRFR0wqBVJc/JhFddryUZJtDDHxNCk
 yt/AQxLps/TCDrbkF4L9PmaCsK4MQI3YRAfgE4rW3df5+QI99sJ4CwbaZHSJN5NUkOiSef
 BmxEyDEUuBW6Rng+fuOPRLPg6l1aIqpV+rea+Ecs5YoZW0ZWmfedsXuGMPhzig==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/11] doc: board: renesas: Document Renesas R-Car Gen3 D3
 Draak board
Date: Wed, 17 Jun 2026 01:18:48 +0200
Message-ID: <20260616231933.44392-8-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260616231933.44392-1-marek.vasut+renesas@mailbox.org>
References: <20260616231933.44392-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 3c8a0d1f93ef539a17a
X-MBO-RS-META: 51sn3qmpy3k1oyiguy8pn9ibzuxemmub
X-Rspamd-Queue-Id: 4gg2yk6CYCz9v0L
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
Renesas R-Car Gen3 D3 Draak board.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 doc/board/renesas/index.rst           |  1 +
 doc/board/renesas/rcar-gen3-draak.rst | 47 +++++++++++++++++++++++++++
 doc/board/renesas/renesas.rst         |  2 +-
 3 files changed, 49 insertions(+), 1 deletion(-)
 create mode 100644 doc/board/renesas/rcar-gen3-draak.rst

diff --git a/doc/board/renesas/index.rst b/doc/board/renesas/index.rst
index 21216912463..f04fd74cb17 100644
--- a/doc/board/renesas/index.rst
+++ b/doc/board/renesas/index.rst
@@ -14,6 +14,7 @@ Renesas
    rcar-gen3-ulcb
    rcar-gen3-geist
    rcar-gen3-ebisu
+   rcar-gen3-draak
    rcar-gen3-install
    rcar-gen3-install-hf
    rcar-gen3-install-sf
diff --git a/doc/board/renesas/rcar-gen3-draak.rst b/doc/board/renesas/rcar-gen3-draak.rst
new file mode 100644
index 00000000000..7b94eaa4b23
--- /dev/null
+++ b/doc/board/renesas/rcar-gen3-draak.rst
@@ -0,0 +1,47 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Renesas R-Car Gen3 D3 Draak board
+=================================
+
+- Renesas R-Car D3 Draak board: https://elinux.org/R-Car/Boards/Draak
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
+    $ make r8a77995_draak_defconfig
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
index 8aa868760d8..6aaf1b13f29 100644
--- a/doc/board/renesas/renesas.rst
+++ b/doc/board/renesas/renesas.rst
@@ -157,7 +157,7 @@ Renesas is a SoC solutions provider for automotive and industrial applications.
      - r8a77990_ebisu_defconfig
 
    * -
-     - Draak
+     - :doc:`Draak <rcar-gen3-draak>`
      - R8A77995 (D3)
      - :doc:`arm64 <build-env-aarch64>`
      - r8a77995_draak_defconfig
-- 
2.53.0

