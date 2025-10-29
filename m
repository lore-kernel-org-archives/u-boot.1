Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7097CCF9EB
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 11:09:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21B1A8004F;
	Wed, 29 Oct 2025 12:09:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 703988006D; Wed, 29 Oct 2025 12:09:17 +0100 (CET)
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::1908])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F26618003E
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 12:09:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cxPdQ1wmVzSFl;
 Wed, 29 Oct 2025 12:09:14 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4cxPdP2BgpzSB5; Wed, 29 Oct 2025 12:09:13 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 29 Oct 2025 12:08:58 +0100
Subject: [PATCH] boot: specify SPL_FIT_FULL_CHECK applies to SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-spl-fit-full-check-desc-v1-1-ebb42c9d97bd@cherry.de>
X-B4-Tracking: v=1; b=H4sIAMn1AWkC/x3MQQ5AMBBA0avIrE2ipQmuIha0UyYapINIxN01l
 m/x/wNCkUmgzR6IdLHwtiaoPAM7D+tEyC4ZdKGNKnSDsgf0fKA/Q0A7k13QkVhUxlVlWdVuNAZ
 SvUfyfP/nrn/fD4AayxNpAAAA
X-Change-ID: 20251029-spl-fit-full-check-desc-15d43348db55
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Martin Schwan <m.schwan@phytec.de>, 
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

SPL_FIT_FULL_CHECK currently shares its description and help text with
FIT_FULL_CHECK which is quite confusing, so let's specify this applies
to SPL.

Fixes: 6f3c2d8aa5e6 ("image: Add an option to do a full check of the FIT")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 boot/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 9adb051400f..db114baa077 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -193,13 +193,13 @@ config SPL_FIT_PRINT
 	  Support printing the content of the fitImage in a verbose manner in SPL.
 
 config SPL_FIT_FULL_CHECK
-	bool "Do a full check of the FIT before using it"
+	bool "Do a full check of the FIT within SPL before using it"
 	depends on SPL_FIT
 	help
-	  Enable this do a full check of the FIT to make sure it is valid. This
-	  helps to protect against carefully crafted FITs which take advantage
-	  of bugs or omissions in the code. This includes a bad structure,
-	  multiple root nodes and the like.
+	  Enable this do a full check of the FIT within SPL to make sure it is
+	  valid. This helps to protect against carefully crafted FITs which take
+	  advantage of bugs or omissions in the code. This includes a bad
+	  structure, multiple root nodes and the like.
 
 config SPL_FIT_SIGNATURE
 	bool "Enable signature verification of FIT firmware within SPL"

---
base-commit: 4cad9faf8d2887b8851f0ced5194ffbaa92ca71e
change-id: 20251029-spl-fit-full-check-desc-15d43348db55

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

