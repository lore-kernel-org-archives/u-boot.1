Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99039EF5862
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 06:36:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B2A98366F;
	Wed, 25 Feb 2026 07:36:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="C/HQcGKa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DDCF83DCB; Wed, 25 Feb 2026 07:36:04 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB26982A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 07:36:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id F25B33FC45; 
 Wed, 25 Feb 2026 06:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1772001361;
 bh=75gpR/4HZvyXpmS9N29OumsduVvGTSp97hyybtg8mnI=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=C/HQcGKajRSlmj+6vYpJ0KBZgIGHB8Io4vxW6ETcPzfwFq6pTMoRkh6Ys4VXDen13
 +ayifVeYg8UDBK3BEnfLjQTIpAYivwz0CkvSKUmvK7YocDxFC/jIlxXVj1WZ5vPAYg
 TToLTRh7Stbt17x8A1FEOJJWG+TZSQzP2odYUL38c0rXG5wFehKv3ZZVE99Rr3TxAN
 U893kOROLsh7BEkGV21g4BaKqb19EeUBoHChPpisrug5/OofQMk/aNSnKhjytAzd8i
 ahLIXZytUsSWbfZpvHxs56FVmM4wzbeOJ6buSdmLbu9up1iybHxYHctXQldqlOkc/J
 g+Sx1tlgG8qj7JxZszHnMr3udY6k3Sb8d1o30kHPsYCZSYcj4GpTKBMISVRreHu1C9
 MnB9BZwRBTLYEZWJ51cCCFnh9B8wTjzpNv//3oCIm8Kjjr0hdpYyEU6oWBD3p1SB2Y
 k46X4JenaGm8oDTbqLBJiPJeZz1cDUlxf/wjvQ0rOIT2sKU+u8N8/DKVXXrWq3cf2D
 wCZYuRzIVPJzJmpKmVcshSzNkykHuRkXJDx3Yprq6Ftt4/wo4WVs/40V4UZomqL/3j
 BLkI5nkQEfvVJsGLHvUFJAkV57/IkcSDS6ZoAnLfgk/N6fr9wHle9NMAjZj3Z0PK26
 B9BmMs+SHU/IgosiSXn+VIBE=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Michal Simek <michal.simek@amd.com>
Cc: Tom Rini <trini@konsulko.com>,
 Bernhard Messerklinger <bernhard.messerklinger@at.abb.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] board/BuR/zynq: don't select non-existent SPL_BINMAN_FDT
Date: Wed, 25 Feb 2026 07:35:59 +0100
Message-ID: <20260225063559.47481-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

Symbol CONFIG_SPL_BINMAN_FDT does not exist.
Don't select it.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 board/BuR/zynq/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/BuR/zynq/Kconfig b/board/BuR/zynq/Kconfig
index b450a21bd98..c7010fb26b3 100644
--- a/board/BuR/zynq/Kconfig
+++ b/board/BuR/zynq/Kconfig
@@ -7,7 +7,6 @@ config TARGET_ZYNQ_BR
 	bool "Support BR Zynq builds"
 	depends on SYS_VENDOR = "BuR"
 	select BINMAN
-	select SPL_BINMAN_FDT
 
 endif
 
-- 
2.51.0

