Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6549CDB46F
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 01:40:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07F26849EB;
	Tue, 23 Jun 2026 03:39:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="R4WiwhpJ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hzJ0yeIm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C568848DC; Tue, 23 Jun 2026 03:39:48 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAFDC849D8
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 03:39:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gknmx5HY0z9v0Y;
 Tue, 23 Jun 2026 03:39:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782178785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6GU0Exk19UTid1WbkWTKciK3F6oEKxO8O2/EYYUAQGU=;
 b=R4WiwhpJmkZgPVAM6zg+rNDzizLd2EUbUI3Ztf8SwWX8B6aUQaAZVnM1mAZ/MToZaR7jW6
 cG6LANR+y7vXPG/p+4ToQ9NZmN+VHpqTV03Iaudv/fEgCnL34VdwR3/CxBsZ63K6xZx8LV
 iyeA1MB8pFJpImmEoGXbahYhsiRle6WTk5MqQmbb8VURofH91JmbCtYBn7hodpnIIlCUV2
 1F7Z8zM59uHsyVFdwrFTI73iXQI7xniD4lw/ROEDNu6pOAU70EVKnQVSm2OK5dZ1DqJou8
 lH9gZJnQL0yWz4LLk6/QhWgb+c1rd+NXej0oqNVIjUi3Pnkhi8ZzxHB0ki2wOg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782178784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6GU0Exk19UTid1WbkWTKciK3F6oEKxO8O2/EYYUAQGU=;
 b=hzJ0yeImjMPFNny8aX2gvNU5hBZOcrs3tlP5d8ZTVon50a/ISmViCCFeiMZ1Qawv7eodgG
 IUhVppf6YpRBEQIjOJ/CwPZt2PeZP4YvKcN3FDdxADXylW8waF0vQbVR6f6+DuSkhp9Op2
 owOKgmtYzloGhGAAu6DCDJ6GTapvDixlhMSc49qh6zuvLxRQJEzWiV4etP0RzfKXvVcJij
 Yd/bzP2n7YDo0FXK4zIGwJNYqR6hZFlNQVwtplL3fYEIR2IA3pWZQxKOdUJp8Rg8jee9Cd
 OZOMe6X9FaPjdKVsBS3SMoWTv8w2A9PvUBo+M4LQLs6N2iQCJ4P6HgyKZ4o9hA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 07/11] doc: board: renesas: Document Renesas R-Car Gen3 D3
 Draak board
Date: Tue, 23 Jun 2026 03:38:33 +0200
Message-ID: <20260623013929.114641-8-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260623013929.114641-1-marek.vasut+renesas@mailbox.org>
References: <20260623013929.114641-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e7a76c74596ef8f0d3f
X-MBO-RS-META: s1arm9uaud13bqxxxmyrtornmaadaotj
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
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: No change
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

