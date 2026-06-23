Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46DE7CDB46F
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 01:40:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C43BD849ED;
	Tue, 23 Jun 2026 03:39:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="U7n7Y9w0";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bm2EPrI6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D66C1849EA; Tue, 23 Jun 2026 03:39:47 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97D66848DC
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 03:39:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gknmx27nCz9tPB;
 Tue, 23 Jun 2026 03:39:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782178785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bs351B/u9CvmEaCzM1rqO41FiHhvJhx5kxqsajLpbwE=;
 b=U7n7Y9w0CMlhGmkZkPR2YkHfNbmJDId6eTy6JZTh/3FN3BYTgROKZJtQ/Lr0vfT4zsGKHv
 4hMYAnrWjCSpaiSbeDdMiZSR2YrK/Z6WUoh603CIKrpdHrrWNa/+u4cntekNaUbKdDyHoB
 bUtMQxf2LuV5MxG7dZlOfD7eA1WkzHdBajO/mAVW8eThiTwe5H77axDO+6h7JZi9J5Nmej
 4oUACxOtMCDBWF0/xdYY/7rPO/ofHJRJ2jyyd5QnGZfO/VA8ee5zfMdS94q546I73/M1Ob
 j6iQ+2+Z/muwIZx1BsQztA0JTthxnBcQF7GanMaQ9h+/Y7FSk54ysAas7tWIMA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=bm2EPrI6;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782178783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bs351B/u9CvmEaCzM1rqO41FiHhvJhx5kxqsajLpbwE=;
 b=bm2EPrI6mJNjiyVlxLKTPhNDf7IAKyILQLLG2IY5wbMDiEe/6k9HmS4mpq8oTxdbh30kJd
 BpKi3FDJDSPQg/AAkw6p5tFKSjPtlp7ZJfiKffuAIZE0Fa6IjPQJ8NbI+qffYqzSwAicNT
 BIt0CtGeshIJDLmxJUA5TFfs+x1AZry44Yu8MSgin/xPVvRoue1s9SNzsVycBr3K26PR73
 rOb6GCQO0citvmKi0q1aYkyZUXx7gQF4XrbhgukaRSUezkk1e05dVGrTMqJgSloCWEKuUR
 Rv6bSaQMAyOdS4BKg28OnJBweHXcu2kBiSvf/qp3NbkX+JF71Yq62qBRLYJAWw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 06/11] doc: board: renesas: Document Renesas R-Car Gen3 E3
 Ebisu board
Date: Tue, 23 Jun 2026 03:38:32 +0200
Message-ID: <20260623013929.114641-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260623013929.114641-1-marek.vasut+renesas@mailbox.org>
References: <20260623013929.114641-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: nzfn7c9u58ehrfj1uuqz7jpatdocei9w
X-MBO-RS-ID: f5df2c597828e527c6a
X-Rspamd-Queue-Id: 4gknmx27nCz9tPB
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
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: No change
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

