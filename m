Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A13FF47CD6
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 20:57:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFF3883F2D;
	Thu,  5 Mar 2026 21:57:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="RCZH0/oc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D605C83F2E; Thu,  5 Mar 2026 21:57:22 +0100 (CET)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DA85839A8
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 21:57:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1772744237;
 bh=phhWJK4y6KNZwtnzdlUKcEPK5TZJFx8KiG26hNxObU0=;
 h=From:To:Cc:Subject:Date:From;
 b=RCZH0/ocs7x/IDc3AvcSb4l4yw4lh/DwkMCqmZ5FMcA42DMdKqM89s/EgW+qjpRmh
 R2Npjcx6rwkW32cqo1EgiV58cKb9J7kGTINHMiEfJNvvE4Xr+/6WY5TFdlWe4Bb6KF
 NJ3Dcw8TyOC9+5HdFCuyUzZSd43O49A0tS7q0WYPq/cDBTXVWXcwf3YELTcA7dZLio
 zOZQVlMG6BxfnabkMLFzxFOViEF5xHmTFXaNgT6X6HLwfsas8b79nappEaZLVHFzVD
 z1rYYNZLZKqmlxVAGdzcZS9FrsF4erkptdBgDqyWbV4AdEA6Q78O4R2eKw9VUmbD66
 6GvT/A6lP4adg==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 4E55EB221056;
 Thu,  5 Mar 2026 21:57:16 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>,
 E Shattow <e@freeshell.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH] doc: board: starfive: jh7110 common give build output dir by
 env not arg
Date: Thu,  5 Mar 2026 12:56:40 -0800
Message-ID: <20260305205649.61100-1-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
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

Describe build with output directory as O=<dir> environment variable
and not unrelated -O <output sync> command line argument.

Fixes: 8304f3226700 ("doc: board: starfive: update jh7110 common description")
Signed-off-by: E Shattow <e@freeshell.de>
---
 doc/board/starfive/jh7110_common.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/doc/board/starfive/jh7110_common.rst b/doc/board/starfive/jh7110_common.rst
index 77102fcc189..b0b60da0dc3 100644
--- a/doc/board/starfive/jh7110_common.rst
+++ b/doc/board/starfive/jh7110_common.rst
@@ -162,8 +162,8 @@ Build U-Boot
        git -C opensbi.git checkout v1.7
        # always clean build directory when building OpenSBI due to incomplete
        # dependency tracking
-       make -C opensbi.git -O opensbi clean
-       make -C opensbi.git -O opensbi PLATFORM=generic
+       make -C opensbi.git O=opensbi clean
+       make -C opensbi.git O=opensbi PLATFORM=generic
 
 4.  Now build the First Stage BootLoader (U-Boot Secondary Program Loader) and
     Second Boot Loader (OpenSBI + U-Boot Main):
@@ -171,9 +171,9 @@ Build U-Boot
     .. code-block:: console
 
        git clone https://source.denx.de/u-boot/u-boot.git u-boot.git
-       make -C u-boot.git -O u-boot starfive_visionfive2_defconfig
+       make -C u-boot.git O=u-boot starfive_visionfive2_defconfig
        export OPENSBI=opensbi/build/platform/generic/firmware/fw_dynamic.bin
-       make -C u-boot.git -O u-boot
+       make -C u-boot.git O=u-boot
 
     This will generate the U-Boot SPL image object post-processed with StarFive
     SPL headers (u-boot/spl/u-boot-spl.bin.normal.out) as well as the FIT image
@@ -191,7 +191,7 @@ Build U-Boot
          --set-val SPL_DEBUG_UART_BASE 0x10000000 \
          --set-val DEBUG_UART_SHIFT 2
 
-        make -C u-boot.git -O u-boot olddefconfig
+        make -C u-boot.git O=u-boot olddefconfig
 
 Boot description
 ----------------

base-commit: b26cc03b7cecaabdb306c2f68eebde764161a545
-- 
2.50.0

