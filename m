Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC7B510F995D
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 16:35:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E00E84129;
	Wed,  8 Apr 2026 18:35:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="Kl+5yQQd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B598F83D8A; Wed,  8 Apr 2026 18:35:29 +0200 (CEST)
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com
 [91.218.175.182])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFF0B8404A
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 18:35:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1775666127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1PAEKyaLQKb2CBbC8hZ+Bx+eqwEO2/dROd/+XyqQWQM=;
 b=Kl+5yQQdaktAzuVPWKMUpmZm9LFYt0zyqGuFSrY4SEgFOwHrgFE1nIs/Jc/SnIyjFqgcpF
 RustuoD5MxZDg2GYU24UGNceoN0eA/btwpbZpD75LpxiU0A7lJBlpQGgqKlV3alfkpwriq
 /HF80ixwn7XiRIWgnNOo6MupAnuktMRnAWZxF2UoiRB01Kr5TUTdQpkq+iZ5OOAxfKu2fx
 xf2VDe6KqjL+323/57gdWcP5LuCQl/1u4DdQer5OauJB+W3X0P3r3Zc7A9MImnEgYvWEk3
 iAzOTx48g5VuLDt0FSLDH25CNUlcpf1hMv1esRZGM5n34qNxuXXI7mxtoFab/w==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 08 Apr 2026 16:34:56 +0000
Subject: [PATCH v2 1/2] autoboot: allow custom prompt without requiring
 AUTOBOOT_KEYED
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-ui-cosmetics-v2-1-721dc6d2116a@postmarketos.org>
References: <20260408-ui-cosmetics-v2-0-721dc6d2116a@postmarketos.org>
In-Reply-To: <20260408-ui-cosmetics-v2-0-721dc6d2116a@postmarketos.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Anshul Dalal <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Martin Schwan <m.schwan@phytec.de>, David Zang <davidzangcs@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2857;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=ey3vCyQ8NMB9oiAJiQONLnCGOS4NPjWQFpjKpgMbNIA=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBp1oPMjEto+5MgR+g5iFoAvy5Mp/SWwlSiw695z
 vmN2SmoW+SJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCadaDzAAKCRCEr8vQ14ma
 A4ArD/47WDybYkeT9DHyAZgsP2QthEj3t/8U4a6RLnaDwaSvokty7WNCNfCi6pDXB1eASDc4Jze
 lc72ktJTo9abhi8dgdmtwRpep3Jv39/I/zQPjVR6TSoyNgY+LmtMSbAYiwm8mGn50CYoSgERrMX
 vZDZuYazCAb2g9cWQ4it45kfDVdYa9pm5irda4gPoQp9+kdfUYadWfDx3RMlTwQkfTbYHovQquU
 YDUP23sE7dGPJaUMP0gSDHYbzFfslMvLJDw2xwQy+g9K8pXFKDkW/qDoCd0dJZK8x6CSP/5DvEa
 0pmDwsK0t7jOVz968z35FIwWgPCf4jLin5U8YxiiqThBfd/fSPhMGJUuMH3ARHf1ACYEp/xEp3P
 BbjvUOFEVrC3G8Lxbs8ih8fvWNeycNZGrBZ2ajrkCp37srz9AkpNC+rdxmYx7R26AirRHcNnYia
 SetHmIZdAXuKiCW6ALhPDF+wWmFVAT4oRzm89GHe92vf7e8d2d1Dsl7BdFj5fvBXcb42MO3Rz1o
 JAopgh9W0QDvOyPbEhHmAu7nEGlGlypaDFLZ0Y3HOOl/b2KzUiMZQuXJGdFryAnbieO8dzJ8tBC
 qtABv2M2IfIXOaWMA78oRxN5xTi+ok2Zpc/1UWlImmOhY+bg10kTRoLMsFuz2CZBr8IMSxWjtIl
 GktPFRpra7crjNQ==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
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

The autoboot prompt used to only be customizable in Kconfig when
AUTOBOOT_KEYED was enabled. For a usecase such as having a nicer
autoboot prompt alongside a splash screen, there is no reason for
AUTOBOOT_KEYED to be required for this.

Remove the dependency to AUTOBOOT_KEYED, and use AUTOBOOT_PROMPT in
print_boot_delay() instead of a hardcoded string.

Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 boot/Kconfig      | 30 +++++++++++++++---------------
 common/autoboot.c |  2 +-
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index bfed452d77e..039c5acc023 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1560,6 +1560,21 @@ config AUTOBOOT
 	help
 	  This enables the autoboot.  See doc/README.autoboot for detail.
 
+config AUTOBOOT_PROMPT
+	string "Autoboot stop prompt"
+	default "Autoboot in %d seconds\\n" if AUTOBOOT_KEYED
+	default "\\rHit any key to stop autoboot: %d"
+	help
+	  This string is displayed before the boot delay selected by
+	  CONFIG_BOOTDELAY starts.
+
+	  Note that this define is used as the (only) argument to a
+	  printf() call, so it may contain '%' format specifications,
+	  provided that it also includes, separated by commas exactly
+	  like in a printf statement, the required arguments. It is
+	  the responsibility of the user to select only such arguments
+	  that are valid in the given context.
+
 if AUTOBOOT
 
 config BOOTDELAY
@@ -1597,21 +1612,6 @@ config AUTOBOOT_FLUSH_STDIN
 	  This can't be enabled for the sandbox as flushing stdin would
 	  break the autoboot unit tests.
 
-config AUTOBOOT_PROMPT
-	string "Autoboot stop prompt"
-	default "Autoboot in %d seconds\\n"
-	help
-	  This string is displayed before the boot delay selected by
-	  CONFIG_BOOTDELAY starts. If it is not defined	there is no
-	  output indicating that autoboot is in progress.
-
-	  Note that this define is used as the (only) argument to a
-	  printf() call, so it may contain '%' format specifications,
-	  provided that it also includes, separated by commas exactly
-	  like in a printf statement, the required arguments. It is
-	  the responsibility of the user to select only such arguments
-	  that are valid in the given context.
-
 config AUTOBOOT_ENCRYPTION
 	bool "Enable encryption in autoboot stopping"
 	help
diff --git a/common/autoboot.c b/common/autoboot.c
index 1783ef92c94..7114ee58f47 100644
--- a/common/autoboot.c
+++ b/common/autoboot.c
@@ -379,7 +379,7 @@ static int abortboot_key_sequence(int bootdelay)
 
 static void print_boot_delay(int bootdelay)
 {
-	printf(ANSI_CLEAR_LINE "\rHit any key to stop autoboot: %d", bootdelay);
+	printf(ANSI_CLEAR_LINE CONFIG_AUTOBOOT_PROMPT, bootdelay);
 }
 
 static int abortboot_single_key(int bootdelay)

-- 
2.53.0

