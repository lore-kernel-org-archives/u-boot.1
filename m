Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB0DD66B9A
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 23:40:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4D9989756;
	Wed, 27 Nov 2024 00:40:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="aPLDreU3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A3C189723; Wed, 27 Nov 2024 00:40:24 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3361989762
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 00:40:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-104-206.46.114.pool.telefonica.de
 [46.114.104.206])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 85F833F782; 
 Tue, 26 Nov 2024 23:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732664421;
 bh=+nhKaaghO0BJi0yzDLm+FNEc3ulRf02OeYBbKxNP500=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=aPLDreU32M914r6svePuMoReiVPxTrNiADXlXaWltPPiwv70vu13Ure2LFc8/c5KF
 TaN1RTGvZ8S/zoM3PNqq2kWKMUq4i6ookoEyZiHYykW8eN2CeeLXutNWzG35IVLsqy
 B2ZMdHZ8kFvxum1o/ySjZ9h6BHdmbgebReIEWzdI6EOYCtSUwUhWkEZ6iIKijFYS1U
 9Pa6tYAPBjiYr7s2oO9f3pu9dDS2geUzH7zVn/PPrE42a+ZnmOJWYH3N8JQ+D4Cy55
 q2FXwY6Iv3iY/13KqI7oU1cXLaqCZgGHuwpIEWO6tP4xddc0XpITjKsK/zdthh0otJ
 8vLIw/DYs4Ekw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: avoid writing message in Exit() boot service
Date: Wed, 27 Nov 2024 00:40:17 +0100
Message-ID: <20241126234017.29814-1-heinrich.schuchardt@canonical.com>
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

We should not write messages in UEFI API functions. This may lead to
incorrect screen layout in UEFI application.

For single statements after if clause we don't need braces.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_boottime.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index 080e7f78ae3..38b0af9d502 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -3495,10 +3495,9 @@ static efi_status_t EFIAPI efi_exit(efi_handle_t image_handle,
 	if (IS_ENABLED(CONFIG_EFI_TCG2_PROTOCOL)) {
 		if (image_obj->image_type == IMAGE_SUBSYSTEM_EFI_APPLICATION) {
 			ret = efi_tcg2_measure_efi_app_exit();
-			if (ret != EFI_SUCCESS) {
-				log_warning("tcg2 measurement fails(0x%lx)\n",
-					    ret);
-			}
+			if (ret != EFI_SUCCESS)
+				log_debug("tcg2 measurement fails (0x%lx)\n",
+					  ret);
 		}
 	}
 
-- 
2.45.2

