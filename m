Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E16C77B7C
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 15:56:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DD8282D83;
	Wed, 25 Jun 2025 17:56:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1750866985;
	bh=lKKsqjnF7poCDAojJsA1hxiPXc7BBdWxPQeBr0Fg8vw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=C8E+sAxee0tLtnUNbzB3dhPxUftBr/eNpX80N7q9W4F0JlupfCWL1AvcmJA4auHzE
	 hzqBOaWqqUsMvxuGj5TGiBItbjX/PvFQ4pz7ynADmhogzOLck/iZPXHFhod3LAMtGP
	 O8WpDOGVY7VuDhM0YmE6BKX1iJUWfFOMg/e4lcGTqPgFumI4GbZMsMglEOpY/88r64
	 3r654fAnvVXDVZg1wH3yKZ2oE8WqCNT0NLKRoNO4A3hgdFo7Zb1HVGeq4q6GXSP5H0
	 WCPpJ1hwTrxi6dhuUwlxOrRUD1uMT/Yqmt55eNHVY8oimnxdpAzAvlaz35ktuyghCo
	 8JgHANoivzqhg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1DF582D88; Wed, 25 Jun 2025 17:56:24 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A038D82CFA
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 17:56:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lukma@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="ejCDP2dw"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1CDDA1039BD02; 
 Wed, 25 Jun 2025 17:56:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1750866973; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=lKKsqjnF7poCDAojJsA1hxiPXc7BBdWxPQeBr0Fg8vw=;
 b=ejCDP2dwHgMN6NOrh6lCrkqSd6+muH4pT+N3/eBo8OozZSAyWyAADkWZjIdJl19gkSScV6
 eUqMhQwxlsqqfJdyAIhIFX6oD1QmlaJPuMYgnkIPvqG4GBMkzhJBckIHLx93iyYCTotMhk
 JIITEeMshzkMSTGqEiuVlG+dAJ4eOClO549eO65dHPy3uJ1+jpoMunnF3OoTvIgpjm/7R2
 kVFKdgAtrs9fxcfTz1Z56UyNkisX7d4LTIUZAlgoAIT8SotjmInEjerimTCUinxU3BeYe3
 5138HmcmrwKQ16t6x8+tndTYqmCWiI1/koqliYiYqRKWMIauWkhbH4QLV6JRCg==
From: Lukasz Majewski <lukma@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@nabladev.com>, uboot-imx@nxp.com,
 Tom Rini <trini@konsulko.com>, albert.aribaud@3adev.fr,
 Alison Wang <alison.wang@nxp.com>, Anatolij Gustschin <agust@denx.de>,
 u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH] config: nxp: vf610: Remove CONFIG_SYS_MALLOC_F_LEN
Date: Wed, 25 Jun 2025 17:55:51 +0200
Message-Id: <20250625155551.1759399-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

The commit c69103218ee4 ("i2c: mxc_i2c: add DM_FLAG_PRE_RELOC flag")
has enabled by default the i2c initialization in the pre-relocation
phase.
It turned out that vf610 based boards had too small SYS_MALLOC_F_LEN
pool size.

As a solution the explicit value of CONFIG_SYS_MALLOC_F_LEN for all
vf610 based boards has been removed from their configs.

Instead, the default value of 0x2000 is now used, which causes boards
to work correctly again. This approach has been tested on BK4 device.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 configs/bk4r1_defconfig         | 1 -
 configs/pcm052_defconfig        | 1 -
 configs/vf610twr_defconfig      | 1 -
 configs/vf610twr_nand_defconfig | 1 -
 4 files changed, 4 deletions(-)

diff --git a/configs/bk4r1_defconfig b/configs/bk4r1_defconfig
index 3ed587a1060..2d9fd914900 100644
--- a/configs/bk4r1_defconfig
+++ b/configs/bk4r1_defconfig
@@ -4,7 +4,6 @@ CONFIG_SYS_THUMB_BUILD=y
 CONFIG_ARCH_VF610=y
 CONFIG_TEXT_BASE=0x3f401000
 CONFIG_SYS_MALLOC_LEN=0x402000
-CONFIG_SYS_MALLOC_F_LEN=0x800
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0x200000
diff --git a/configs/pcm052_defconfig b/configs/pcm052_defconfig
index d0d558ab11a..81d703ec679 100644
--- a/configs/pcm052_defconfig
+++ b/configs/pcm052_defconfig
@@ -4,7 +4,6 @@ CONFIG_SYS_THUMB_BUILD=y
 CONFIG_ARCH_VF610=y
 CONFIG_TEXT_BASE=0x3f401000
 CONFIG_SYS_MALLOC_LEN=0x202000
-CONFIG_SYS_MALLOC_F_LEN=0x400
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xA0000
diff --git a/configs/vf610twr_defconfig b/configs/vf610twr_defconfig
index c823cb0a30e..8129484513d 100644
--- a/configs/vf610twr_defconfig
+++ b/configs/vf610twr_defconfig
@@ -4,7 +4,6 @@ CONFIG_SYS_THUMB_BUILD=y
 CONFIG_ARCH_VF610=y
 CONFIG_TEXT_BASE=0x3f401000
 CONFIG_SYS_MALLOC_LEN=0x202000
-CONFIG_SYS_MALLOC_F_LEN=0x400
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xC0000
diff --git a/configs/vf610twr_nand_defconfig b/configs/vf610twr_nand_defconfig
index 84e73c0c665..51365990d0f 100644
--- a/configs/vf610twr_nand_defconfig
+++ b/configs/vf610twr_nand_defconfig
@@ -4,7 +4,6 @@ CONFIG_SYS_THUMB_BUILD=y
 CONFIG_ARCH_VF610=y
 CONFIG_TEXT_BASE=0x3f401000
 CONFIG_SYS_MALLOC_LEN=0x0220000
-CONFIG_SYS_MALLOC_F_LEN=0x400
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0x180000
-- 
2.39.5

