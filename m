Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDB8CCF9EB
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 11:20:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36FE0836F0;
	Wed, 29 Oct 2025 12:20:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B724183710; Wed, 29 Oct 2025 12:20:39 +0100 (CET)
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch
 [45.157.188.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D61A48006D
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 12:20:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cxPtY3ldtz6rH;
 Wed, 29 Oct 2025 12:20:37 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4cxPtX67lZzJQM; Wed, 29 Oct 2025 12:20:36 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 29 Oct 2025 12:20:27 +0100
Subject: [PATCH] rsa: fix typo in $(PHASE_)RSA_VERIFY_WITH_PKEY help text
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-rsa-verify-with-pkey-typo-v1-1-e23f6c2bb2db@cherry.de>
X-B4-Tracking: v=1; b=H4sIAHr4AWkC/x3MQQqAIBBA0avErBswy0VdJVqYjTkEJRqVSHdPW
 v7F+xkiBaYIQ5Uh0MWRj71EU1dgnN5XQl5KgxRSNUL2GKLGqxib8ObTod8o4Zn8gUbZtpuJtOg
 MFO8DWX7+9zi97wdm70bxawAAAA==
X-Change-ID: 20251029-rsa-verify-with-pkey-typo-c5f34beea04c
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>
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

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 lib/rsa/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/rsa/Kconfig b/lib/rsa/Kconfig
index 9033384e60a..3eda4bc61b9 100644
--- a/lib/rsa/Kconfig
+++ b/lib/rsa/Kconfig
@@ -44,7 +44,7 @@ config RSA_VERIFY_WITH_PKEY
 	  This does not suit the use case where there is no way defined to
 	  provide such additional key properties in standardized form,
 	  particularly UEFI secure boot.
-	  This options enables RSA signature verification with a public key
+	  This option enables RSA signature verification with a public key
 	  directly specified in image_sign_info, where all the necessary
 	  key properties will be calculated on the fly in verification code.
 
@@ -62,7 +62,7 @@ config SPL_RSA_VERIFY_WITH_PKEY
 	  This does not suit the use case where there is no way defined to
 	  provide such additional key properties in standardized form,
 	  particularly UEFI secure boot.
-	  This options enables RSA signature verification with a public key
+	  This option enables RSA signature verification with a public key
 	  directly specified in image_sign_info, where all the necessary
 	  key properties will be calculated on the fly in verification code
 	  in the SPL.

---
base-commit: 4cad9faf8d2887b8851f0ced5194ffbaa92ca71e
change-id: 20251029-rsa-verify-with-pkey-typo-c5f34beea04c

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

