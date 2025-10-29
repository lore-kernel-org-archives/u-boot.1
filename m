Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0FCBCCF9E9
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 11:17:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3338781E13;
	Wed, 29 Oct 2025 12:17:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D27DF81E13; Wed, 29 Oct 2025 12:17:57 +0100 (CET)
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::1909])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EADFD800D7
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 12:17:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cxPqR4sSfzXT;
 Wed, 29 Oct 2025 12:17:55 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4cxPqR0rMnzNL2; Wed, 29 Oct 2025 12:17:55 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 29 Oct 2025 12:17:43 +0100
Subject: [PATCH] serial: make VPL_DM_SERIAL depend on VPL_DM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-vpl-dm-serial-v1-1-7117f541511f@cherry.de>
X-B4-Tracking: v=1; b=H4sIANb3AWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyNL3bKCHN2UXF2QtsQcXaNUU1MTQ2PLZAsLCyWgnoKi1LTMCrB50bG
 1tQBXtPYXXwAAAA==
X-Change-ID: 20251029-vpl-dm-serial-2e554139c888
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>, 
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

I have a hunch VPL_DM_SERIAL should not be selectable if VPL isn't set
as implied by the prefix. Additionally, still based on the prefix, I'm
assuming VPL_DM should be a dependency. Since VPL_DM can only be
selectable when VPL is enabled, only depend on VPL_DM.

This mirrors SPL_DM_SERIAL and TPL_DM_SERIAL so seems right to me.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 drivers/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index bc05d2f1508..8d2ecdada49 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -194,7 +194,7 @@ config TPL_DM_SERIAL
 
 config VPL_DM_SERIAL
 	bool "Enable Driver Model for serial drivers in VPL"
-	depends on DM_SERIAL
+	depends on DM_SERIAL && VPL_DM
 	default y if VPL && DM_SERIAL
 	help
 	  Enable driver model for serial in VPL. This replaces

---
base-commit: 4cad9faf8d2887b8851f0ced5194ffbaa92ca71e
change-id: 20251029-vpl-dm-serial-2e554139c888

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

