Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85B4CD1288
	for <u-boot@archiver.kernel.org>; Sun, 31 Mar 2024 02:37:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70E3887F4B;
	Sun, 31 Mar 2024 04:37:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="shDwcmYN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9BCC87ECC; Sun, 31 Mar 2024 04:37:22 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 100D287F3A
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 04:37:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-245-032.um16.pools.vodafone-ip.de
 [62.143.245.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 6033140100; 
 Sun, 31 Mar 2024 02:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1711852640;
 bh=NJYm+voDDfzoHlLkPwrj7r6HjjMBGLmoY86DlNoFrio=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=shDwcmYN3cBI4M7Ca5+rn3yIFS+sixw+GI3e03INFZpOH3xNnFXDFLC8W9O60eJlL
 9auC7OzS71sZ/EYm7k3KJpOOmBGSOKFVG80m8rP/qNjuVkzhmitnf8KtK27kwom2dA
 xxyF3YCEDqy45lYxr0246TGtJmYkYZmYoWwPJYShfN86x8RNK2JhOQF5DTn9yjzlhe
 J9YxPfddOdo4EJ6YmWq4URTvXGx6kZtWv1ihFXUe/bceJ/ZPrXpMi94FInbsz1IJD8
 WNzVoO7hoej87MYDm4C6s9A3goNUrDnqrKv87gPiJdeF2UQhWd4IldYKSc2p1pMlz5
 3uowPWGNVkOSg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Tom Rini <trini@konsulko.com>,
 Samuel Holland <samuel@sholland.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/2] env: ENV_IS_IN_EXT4 should enable SYS_MMC_ENV_DEV
Date: Sun, 31 Mar 2024 04:37:16 +0200
Message-ID: <20240331023718.52064-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240331023718.52064-1-heinrich.schuchardt@canonical.com>
References: <20240331023718.52064-1-heinrich.schuchardt@canonical.com>
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

When enabling CONFIG_ENV_IS_IN_EXT4 the environment might be stored on
an mmc device similar to the CONFIG_ENV_IS_IN_FAT case.

Fixes: 7d080773347c ("Convert CONFIG_SYS_MMC_ENV_DEV et al to Kconfig")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 env/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/env/Kconfig b/env/Kconfig
index 7885c8bf831..b87d8f8dea8 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -655,7 +655,7 @@ config SYS_RELOC_GD_ENV_ADDR
 
 config SYS_MMC_ENV_DEV
 	int "mmc device number"
-	depends on ENV_IS_IN_MMC || ENV_IS_IN_FAT || \
+	depends on ENV_IS_IN_MMC || ENV_IS_IN_FAT || ENV_IS_IN_EXT4 || \
 		CMD_MVEBU_BUBT || FMAN_ENET || QE || PHY_CORTINA
 	default 0
 	help
-- 
2.43.0

