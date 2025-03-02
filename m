Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD9DDC19F32
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 15:02:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E95F810EA;
	Sun,  2 Mar 2025 16:02:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="FVF3/6ZV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BA1781101; Sun,  2 Mar 2025 16:02:39 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C5FE806FC
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 16:02:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 0F72C3FB97; 
 Sun,  2 Mar 2025 15:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1740927756;
 bh=N5gmj4NrR9azRs565mQ6HpWujAv9KHjnaW+tAWaSmts=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=FVF3/6ZVQdUilVdYQjyLuykvQLdUdHLm5prJ0IMrVmDPs4VgGtSXUCAehPHj0W3ma
 XNl1SvhnEw3IHandwtlskFdP1UJxsdZcGYNCwtwIBL6a/9fRM6ssBz8sVN9U2yL6EN
 cL5V7SJP/1S3EcStM18lPyjuLq1ZckCkSA49412WbLuzdXERgV5u/LQvpIZovpp9NV
 hBOlvi6UZ4lbQLqkY0yxSC+m1jbwL8la3aF/o2Lm79mSQ/rkuRySXL9tm4ha+1Dsnh
 KcfdSbtfjjg0YVwMO+7FvEefsJgRPPM4te0Wmj5ZEc4R8HpNAD7dHD+AXjYoO/NAAS
 A9767YRKBOsmA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>, Sam Protsenko <semen.protsenko@linaro.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?q?Pawe=C5=82=20Kochanowski?= <pkochanowski@sii.pl>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH] lib: correct description of CONFIG_SYS_FDT_PAD
Date: Sun,  2 Mar 2025 16:02:31 +0100
Message-ID: <20250302150231.152179-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

CONFIG_SYS_FDT_PAD defines the number of unused bytes added to a
device-tree and not the total size.

Fixes: 40ed7be4af52 ("Convert CONFIG_SYS_FDT_PAD to Kconfig")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 1a683dea670..a21b3378fa7 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1008,14 +1008,14 @@ config OF_LIBFDT_OVERLAY
 	  This enables the FDT library (libfdt) overlay support.
 
 config SYS_FDT_PAD
-	hex "Maximum size of the FDT memory area passeed to the OS"
+	hex "Free space added to device-tree before booting"
 	depends on OF_LIBFDT
 	default 0x13000 if FMAN_ENET || QE || U_QE
 	default 0x3000
 	help
-	  During OS boot, we allocate a region of memory within the bootmap
-	  for the FDT. This is the size that we will expand the FDT that we
-	  are using will be extended to be, in bytes.
+	  The operating system may need a free area at the end of the device-
+	  tree for fix-ups. This setting defines by how many bytes U-Boot
+	  extends the device-tree before booting.
 
 config SPL_OF_LIBFDT
 	bool "Enable the FDT library for SPL"
-- 
2.48.1

