Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE8CE7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 06:33:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE57C8005B;
	Mon, 16 Dec 2024 07:33:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5667080104; Mon, 16 Dec 2024 07:33:44 +0100 (CET)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 506E68003E
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 07:33:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from hay.lan. (unknown
 [IPv6:2605:59c8:31de:bf00:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id DFFC5B4B29AE;
 Mon, 16 Dec 2024 07:33:40 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: Minda Chen <minda.chen@starfivetech.com>,
	Tom Rini <trini@konsulko.com>
Cc: E Shattow <e@freeshell.de>,
	u-boot@lists.denx.de
Subject: [PATCH] Revert "configs: JH7110: enable EFI_LOADER_BOUNCE_BUFFER"
Date: Sun, 15 Dec 2024 22:32:12 -0800
Message-ID: <20241216063220.627348-1-e@freeshell.de>
X-Mailer: git-send-email 2.45.2
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

("Enable EFI_LOADER_BOUNCE_BUFFER") is not the correct fix for the
problem it describes.

The change of memory addressing leading to side-effects in commit
22f2c9ed9f53 ("efi: memory: use the lmb API's for allocating and
freeing memory") is remedied by commit 1a48b0be93d4 ("lmb: prohibit
allocations above ram_top even from same bank").

This reverts commit 9c792ab336f7146e8d49bca6d9d093d2392ded5d.
---
 configs/starfive_visionfive2_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index 20f89ae6796..1c70d1d4b70 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -32,7 +32,6 @@ CONFIG_CMODEL_MEDANY=y
 CONFIG_RISCV_SMODE=y
 # CONFIG_OF_BOARD_FIXUP is not set
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
-CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
 CONFIG_FIT=y
 CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_BOOTSTAGE=y

base-commit: 50334151c02077f16613b0a082d95640800ba60e
-- 
2.45.2

