Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 845AACAC59A
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 14:18:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCBA4835CD;
	Wed, 17 Sep 2025 16:17:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="JxiJHIpJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E81E5835D0; Wed, 17 Sep 2025 16:17:57 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F32F9835CB
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 16:17:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 5158F4E40CBF;
 Wed, 17 Sep 2025 14:17:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 2544B6063E;
 Wed, 17 Sep 2025 14:17:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7CE6A102F1BAB; 
 Wed, 17 Sep 2025 16:17:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1758118672; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=7TnniF4l7evE+rV7uydB5p4OtYoz/hDQ+6zGVt/q708=;
 b=JxiJHIpJdl5lj5mATYtQaYphYBu1dF3b0A2bNyyz6PNBB36QWzM41y3cvK6oBIymQON5hz
 C3sWjx3oKgE6/3Td0wUqp3VgY07DEOdQgO2XwwuKuPGwWvwruci8o7CyU28RzXN14x3k1y
 QflmTCLYnwkz2xGY5z8JuPknX/Q+MG+/R4WNRapvyqvoQ3i52d7B2dhinAh/uYXcsQN5ty
 ktv9iJjp5xffEA5OrS1cbZ1r/E1h0/2emtMhBOYDH7+RAQabninXidMnnXiMwcJ+Ia51bI
 YdVkk/pXYzgV4UkEoK8GDIK0rFJEiBUFsyp7al6I+UNrxkXcHk7gwvBhpMiBXA==
From: Kory Maincent <kory.maincent@bootlin.com>
To: uboot-stm32@st-md-mailman.stormreply.com,
	u-boot@lists.denx.de
Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Kory Maincent <kory.maincent@bootlin.com>, thomas.petazzoni@bootlin.com,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH] Revert "board: st: stm32mp1: Clean env_get_location()"
Date: Wed, 17 Sep 2025 16:17:35 +0200
Message-ID: <20250917141736.59732-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.43.0
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

This reverts commit d37641c61ba212241c38e3fd22f0335fc0bebc96.

Restore support for environment storage in EXT4 filesystem on eMMC boot.
The previous cleanup incorrectly removed this fallback option which is
needed for boards that store their environment in an EXT4 partition.

This configuration is OS-specific rather than board-dependent and should
remain as it is configurable via menuconfig. Even if it is not described
in ST defconfigs people may have enabled it in their defconfig.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Debugging this issue raises another issue that need investigation.
If env_get_location return ENVL_IS_NOWHERE but CONFIG_ENV_IS_NOWHERE is
not set, U-boot stall without any log. There might be an ENV check issue
here.
---
 board/st/stm32mp1/stm32mp1.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/st/stm32mp1/stm32mp1.c b/board/st/stm32mp1/stm32mp1.c
index ab7af69d472..cb5cab9f36a 100644
--- a/board/st/stm32mp1/stm32mp1.c
+++ b/board/st/stm32mp1/stm32mp1.c
@@ -751,6 +751,8 @@ enum env_location env_get_location(enum env_operation op, int prio)
 	case BOOT_FLASH_EMMC:
 		if (CONFIG_IS_ENABLED(ENV_IS_IN_MMC))
 			return ENVL_MMC;
+		else if (CONFIG_IS_ENABLED(ENV_IS_IN_EXT4))
+			return ENVL_EXT4;
 		else
 			return ENVL_NOWHERE;
 
-- 
2.43.0

