Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA249D3C901
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 08:31:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0C7688E33;
	Sat, 19 Oct 2024 10:31:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="t19s+BxD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B74B888D61; Sat, 19 Oct 2024 10:31:16 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB9CD88E8C
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 10:31:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from rpi5.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 121753F1E8; 
 Sat, 19 Oct 2024 08:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1729326673;
 bh=YT9XwZizW6f+CPQRvjPC+0gRoo6gpdOmd9tRFF3q2A8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=t19s+BxD8oUKjGTZQRg2xYwp8f+k+M368DEUhXhTxiPtJFK52aiOhzwiSxHS2B/TB
 AnMyp3QLd+fJRpuqjbiZ/hyHCMMS4x7pOxa47g5DtrCh/BL5XxUTBNckXS1/9rpXuz
 qjKzoHDGfGekZyqmFLi2DAEQsCNwfbCtI/3uaYzXW2FF+VcIgKQ2CSFHgUhuU+RbVb
 NDIwWbwIx0hhn40HuvuIc/wFrsYkMGetjazI1GkrIOf+nlniC7/oyPksxduf1nDVyd
 gbnxEYm6GsI0RgFF0B4csON3KQFkkpLKLeEtmN5A1o3BKzmCOI5qmbiqpKFoeEH3A5
 trLs6LHWXLCtw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>, Rick Chen <rick@andestech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>
Cc: Chanho Park <chanho61.park@samsung.com>, Nam Cao <namcao@linutronix.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Aurelien Jarno <aurelien@aurel32.net>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] configs: visionfive2: enable CONFIG_CMD_ERASEENV
Date: Sat, 19 Oct 2024 10:31:09 +0200
Message-ID: <20241019083109.12113-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

When moving from vendor U-Boot to the upstream U-Boot it is necessary to
reset the environment.

Provide the 'env erase' sub-command.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 configs/starfive_visionfive2_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index 511645cebef..c3508926d6c 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -62,6 +62,7 @@ CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_SYS_PROMPT="StarFive # "
+CONFIG_CMD_ERASEENV=y
 CONFIG_CMD_EEPROM=y
 CONFIG_SYS_EEPROM_SIZE=512
 CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=4
-- 
2.43.0

