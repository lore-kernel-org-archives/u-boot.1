Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95969C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 06:46:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A60F9815D1;
	Tue, 22 Apr 2025 08:46:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A79BF819D2; Tue, 22 Apr 2025 08:46:27 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6D8481026
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 08:46:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from hay.lan. (unknown
 [IPv6:2605:59c0:20f3:a400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id BA1F5B4C0866;
 Tue, 22 Apr 2025 08:46:23 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Tom Rini <trini@konsulko.com>, Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Cc: E Shattow <e@freeshell.de>,
	u-boot@lists.denx.de
Subject: [PATCH v1 1/2] doc: board: starfive: Drop setting of $fdtfile
Date: Mon, 21 Apr 2025 23:45:25 -0700
Message-ID: <20250422064541.635210-2-e@freeshell.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250422064541.635210-1-e@freeshell.de>
References: <20250422064541.635210-1-e@freeshell.de>
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

Information about setting $fdtfile is covered by generic U-Boot docs. Drop
the redundant section.

Signed-off-by: E Shattow <e@freeshell.de>
---
 doc/board/starfive/milk-v_mars.rst   | 18 ------------------
 doc/board/starfive/pine64_star64.rst | 16 ----------------
 doc/board/starfive/visionfive2.rst   | 18 ------------------
 3 files changed, 52 deletions(-)

diff --git a/doc/board/starfive/milk-v_mars.rst b/doc/board/starfive/milk-v_mars.rst
index 554932ecfd4..9cfd5d7bddd 100644
--- a/doc/board/starfive/milk-v_mars.rst
+++ b/doc/board/starfive/milk-v_mars.rst
@@ -39,24 +39,6 @@ Now build the U-Boot SPL and U-Boot proper.
 This will generate the U-Boot SPL image (spl/u-boot-spl.bin.normal.out) as well
 as the FIT image (u-boot.itb) with OpenSBI and U-Boot.
 
-Device-tree selection
-~~~~~~~~~~~~~~~~~~~~~
-
-Depending on the board version U-Boot set variable $fdtfile to either
-starfive/jh7110-starfive-visionfive-2-v1.2a.dtb or
-starfive/jh7110-starfive-visionfive-2-v1.3b.dtb.
-
-To overrule this selection the variable can be set manually and saved in the
-environment
-
-::
-
-    setenv fdtfile my_device-tree.dtb
-    env save
-
-or the configuration variable CONFIG_DEFAULT_FDT_FILE can be used to set to
-provide a default value.
-
 Boot source selection
 ~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/doc/board/starfive/pine64_star64.rst b/doc/board/starfive/pine64_star64.rst
index 52e9a907917..1fdd1660a31 100644
--- a/doc/board/starfive/pine64_star64.rst
+++ b/doc/board/starfive/pine64_star64.rst
@@ -39,22 +39,6 @@ Now build the U-Boot SPL and U-Boot proper.
 This will generate the U-Boot SPL image (spl/u-boot-spl.bin.normal.out) as well
 as the FIT image (u-boot.itb) with OpenSBI and U-Boot.
 
-Device-tree selection
-~~~~~~~~~~~~~~~~~~~~~
-
-U-Boot will set variable $fdtfile to starfive/jh7110-pine64-star64.dtb.
-
-To overrule this selection the variable can be set manually and saved in the
-environment
-
-::
-
-    env set fdtfile my_device-tree.dtb
-    env save
-
-or the configuration variable CONFIG_DEFAULT_FDT_FILE can be used to set to
-provide a default value.
-
 Boot source selection
 ~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/doc/board/starfive/visionfive2.rst b/doc/board/starfive/visionfive2.rst
index 2c68df3ce4d..abda8ac21bc 100644
--- a/doc/board/starfive/visionfive2.rst
+++ b/doc/board/starfive/visionfive2.rst
@@ -71,24 +71,6 @@ Now build the U-Boot SPL and U-Boot proper
 This will generate the U-Boot SPL image (spl/u-boot-spl.bin.normal.out) as well
 as the FIT image (u-boot.itb) with OpenSBI and U-Boot.
 
-Device-tree selection
-~~~~~~~~~~~~~~~~~~~~~
-
-Depending on the board version U-Boot set variable $fdtfile to either
-starfive/jh7110-starfive-visionfive-2-v1.2a.dtb or
-starfive/jh7110-starfive-visionfive-2-v1.3b.dtb.
-
-To overrule this selection the variable can be set manually and saved in the
-environment
-
-::
-
-    setenv fdtfile my_device-tree.dtb
-    env save
-
-or the configuration variable CONFIG_DEFAULT_FDT_FILE can be used to provide
-a default value.
-
 Flashing
 ~~~~~~~~
 
-- 
2.49.0

