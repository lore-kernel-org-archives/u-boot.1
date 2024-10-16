Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C9DD1AD41
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 10:17:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C88F88EDE;
	Wed, 16 Oct 2024 12:17:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="RhPpFp3w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADA3288EEB; Wed, 16 Oct 2024 12:17:47 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A539480245
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 12:17:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 96B5F3F122; 
 Wed, 16 Oct 2024 10:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1729073864;
 bh=CY6oICIqduIFc/Vs3iSKiGLabi7AyNyeJJxpuljqFks=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=RhPpFp3w22xCuA6Y66/smEoe/JwtXO+PQMFiOe5Rkb5vc+kwfzX8M+nD17GMDvqXO
 yrLmYdEjSuRu+0WceasNEzEDiglNdgACaiz766Df9trmKsOLCxotiTaCLIhvW1Btwn
 QVxEmv7dzV3ldmLObMpxJ9r+SRbG9vpTsKQMtNYeLZBxpNHZa+ZZpJD1DYq/Sdn2pN
 pHk3QqRxF8r+3LW9ff5JCtOvUx/NpPFM1jrhGeI0eHd0cSLNP6zX4T9HALUK+YkcVH
 qLNO+5nIqagKFObYq5/Ph/31491GLdwWAzPWy0SHJ5bm7eD3ArEBdsVDTx0D1pnXW+
 BDzYmvJKlVphg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Joao Marcos Costa <jmcosta944@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Simon Glass <sjg@chromium.org>, Raymond Mao <raymond.mao@linaro.org>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: avoid #ifdef in efi_setup.c
Date: Wed, 16 Oct 2024 12:17:39 +0200
Message-ID: <20241016101739.62408-1-heinrich.schuchardt@canonical.com>
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

We prefer `if` over `#ifdef` in our code.

Eliminate #ifdef statements in efi_setup.c.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_setup.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index a610e032d2f..aa59bc7779d 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -86,7 +86,6 @@ out:
 	return ret;
 }
 
-#ifdef CONFIG_EFI_SECURE_BOOT
 /**
  * efi_init_secure_boot - initialize secure boot state
  *
@@ -112,12 +111,6 @@ static efi_status_t efi_init_secure_boot(void)
 
 	return ret;
 }
-#else
-static efi_status_t efi_init_secure_boot(void)
-{
-	return EFI_SUCCESS;
-}
-#endif /* CONFIG_EFI_SECURE_BOOT */
 
 /**
  * efi_init_capsule - initialize capsule update state
@@ -302,9 +295,11 @@ efi_status_t efi_init_obj_list(void)
 	}
 
 	/* Secure boot */
-	ret = efi_init_secure_boot();
-	if (ret != EFI_SUCCESS)
-		goto out;
+	if (IS_ENABLED(CONFIG_EFI_SECURE_BOOT)) {
+		ret = efi_init_secure_boot();
+		if (ret != EFI_SUCCESS)
+			goto out;
+	}
 
 	/* Indicate supported runtime services */
 	ret = efi_init_runtime_supported();
@@ -322,11 +317,11 @@ efi_status_t efi_init_obj_list(void)
 		if (ret != EFI_SUCCESS)
 			goto out;
 	}
-#ifdef CONFIG_NETDEVICES
-	ret = efi_net_register();
-	if (ret != EFI_SUCCESS)
-		goto out;
-#endif
+	if (IS_ENABLED(CONFIG_NETDEVICES)) {
+		ret = efi_net_register();
+		if (ret != EFI_SUCCESS)
+			goto out;
+	}
 	if (IS_ENABLED(CONFIG_ACPI)) {
 		ret = efi_acpi_register();
 		if (ret != EFI_SUCCESS)
-- 
2.45.2

