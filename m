Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03281C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 07:19:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5DC4832BE;
	Wed,  9 Apr 2025 09:18:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="BNiK54oW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D51082D1B; Wed,  9 Apr 2025 09:18:53 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63004820E2
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 09:18:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-104-207.46.114.pool.telefonica.de
 [46.114.104.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 12B83403A5; 
 Wed,  9 Apr 2025 07:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1744183126;
 bh=laa4zyswXvGgrn1Ko68wLQd0UDGRykmkVmmF/HHinXQ=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=BNiK54oWLY0srCApRBPOeFC2GD9Psqj7w/t69kNs4s3lTxlL1y7Zix/IROYYvjofZ
 LbN3DNiG3iREKMT65ZWOukroyyh6jn49ZeRuT4EpA3szNjVzCZwxluZa8lGv90GCLy
 txiGUGsGLw0SdVReALjBA/oy+LRoU3QNPLW8QTFVtCRxr8LwiDowcoUgmp9Dj8SGY2
 2yHUNa85TnvWPEGf001C7E2acTNHhgfEZwLtYWgzes1gg7ZarNC6Z7HbxRgE9oihXq
 NYlngSXEAKbfUFeNsKmK6mJQEDHBwPgbbBGboQvIAvTFAoWLPnIZMMfH2wLo9VFJe9
 pewXye/jV/abA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Hal Feng <hal.feng@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 E Shattow <e@freeshell.de>, Sumit Garg <sumit.garg@kernel.org>,
 H Bell <dmoo_dv@protonmail.com>, Matthias Brugger <mbrugger@suse.com>,
 Simon Glass <sjg@chromium.org>, Andreas Schwab <schwab@suse.de>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 1/8] configs: add jh7110-deepcomputing-fml13v01 to VF2
 defconfig
Date: Wed,  9 Apr 2025 09:18:28 +0200
Message-ID: <20250409071836.26629-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250409071836.26629-1-heinrich.schuchardt@canonical.com>
References: <20250409071836.26629-1-heinrich.schuchardt@canonical.com>
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

The DeepComputing Framework motherboard is a JH7110 device support by the
upstream kernel. Add its device-tree to the list of device-trees to be
included into the starfive_visionfive_defconfig.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
---
v3:
	no change
v2:
	rebased
---
 configs/starfive_visionfive2_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index 6a5b247c4b5..e145ced8db8 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -80,7 +80,7 @@ CONFIG_CMD_WDT=y
 CONFIG_CMD_WGET=y
 CONFIG_CMD_BOOTSTAGE=y
 CONFIG_OF_BOARD=y
-CONFIG_OF_LIST="starfive/jh7110-milkv-mars starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-starfive-visionfive-2-v1.3b"
+CONFIG_OF_LIST="starfive/jh7110-deepcomputing-fml13v01 starfive/jh7110-milkv-mars starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-starfive-visionfive-2-v1.3b"
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-- 
2.48.1

