Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A098CE64018
	for <u-boot@archiver.kernel.org>; Sun,  5 Apr 2026 10:49:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE3D080433;
	Sun,  5 Apr 2026 12:49:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="CLLf6jcn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13C2B840BE; Sun,  5 Apr 2026 12:49:38 +0200 (CEST)
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com
 [91.218.175.181])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F8F1800AE
 for <u-boot@lists.denx.de>; Sun,  5 Apr 2026 12:49:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1775386175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ma+Kw8vbfQA6TMTBJJfSlJNa7LMMmnZFAogf6evXocQ=;
 b=CLLf6jcn9lhjAdu7rsba8lU6EuenCp1TaFBwNCzvpcIsPIzdHNi+blO0UIJ9hmj2eLVR6s
 XrOUeL3oYtXvTzk712/BxF0dP6AxdASmpSD3NOyBumZkYmV0YpSnuafWBnSA7iM7najRLP
 5wvLnf9raoppS6G7b9hYpnAeaou4z1e6qs2dv/5ta94kRuSphyOZn3h9kj9Ft6MZTQo7mt
 daWlpO0PFwEcet+MCpmrZyhpD2aD6Q+vab8G/S5XoKYzdAcb1VQzbFzOc/MyRq/1JhADNU
 IsCtucqFKdD+0YQ2UCT7aY6QWSPlgXMZgFW2AEwW8u+BomwJ1NljrQWnP0Qsjg==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Sun, 05 Apr 2026 10:49:04 +0000
Subject: [PATCH 1/2] autoboot: allow custom prompt without requiring
 AUTOBOOT_KEYED
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260405-ui-cosmetics-v1-1-bffec3cac741@postmarketos.org>
References: <20260405-ui-cosmetics-v1-0-bffec3cac741@postmarketos.org>
In-Reply-To: <20260405-ui-cosmetics-v1-0-bffec3cac741@postmarketos.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2987;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=ceBlH5AD2mi/U+/I7Vmaq8mCrvY8ROSyhcTklPyGFy0=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBp0j45lKpi0rzMlfSZAe75fvyr+bChKLrZd3W3g
 BLspWZSJE2JAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCadI+OQAKCRCEr8vQ14ma
 A7LLD/42APKYa/w7RZ58TifpX2c4zsb8q2ktdg2RHFkcNrAA8u/JdwMfNKlz9mjN4Ihbh8ghXM9
 QHNkl4802OKjNQ1o9mgCfav1B3+FpjqnjQvKUBtIwsPo3KKmtaBDPmmoWwkAB+gSIahLLM4HORp
 RGsqTovAhfDR/xdYW1F7dze50JnQ7lNXP/0Kkqmpgtf1u2Fithl4Jt3UHd6W2yWqssKXLvagjvE
 Rlvd5X9QIlgZQnC4h562+8G7lzp9iViUgzKU4pGEGzKnl3x03Vd4WD9+lOrYOTAOmYnYFKRnGBj
 mgymtNHD9CMAnD/6iaeYo7mK/VVKic0p5PcbdtzVHeB7K6VeIAjAm73SS95+iPpzTe4QNM1YtDS
 LgRH4l3JK7x6Q25yxZe3F31vSTRTe+3Cqe3OgO8VZmPgxwEYbIkbmQGNHz1hn2Z4/nMSvCRjKGz
 U65v9xXivqBRcZfMAo9sPr+APUCOiWMH71hOzDXPjPq4POWoQjgK+D2SMuUO38DbUrGIaIIXeA+
 VwL8nF2bSAZjOuWxh7ectZockiNfmJW6W4BeIFzHc03JM/DAlxkH8ncPs+mqQixK0NeX65KQvxQ
 Nk0msLtLbnrmS9JizIOLbJNvTHAjgiVP6lJBhOZXQZ+nR46CTTEWvSWuDmvQdl6umFLrHMD+RsD
 zDVxlgIOqPA6Tcw==
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
 boot/Kconfig      | 31 ++++++++++++++++---------------
 common/autoboot.c |  4 +++-
 2 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index bfed452d77e..6c8ec356996 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1560,6 +1560,22 @@ config AUTOBOOT
 	help
 	  This enables the autoboot.  See doc/README.autoboot for detail.
 
+config AUTOBOOT_PROMPT
+	string "Autoboot stop prompt"
+	default "Autoboot in %d seconds\\n" if AUTOBOOT_KEYED
+	default "\\rHit any key to stop autoboot: %d"
+	help
+	  This string is displayed before the boot delay selected by
+	  CONFIG_BOOTDELAY starts. If it is not defined	there is no
+	  output indicating that autoboot is in progress.
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
@@ -1597,21 +1613,6 @@ config AUTOBOOT_FLUSH_STDIN
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
index 1783ef92c94..d12d618fea3 100644
--- a/common/autoboot.c
+++ b/common/autoboot.c
@@ -379,7 +379,9 @@ static int abortboot_key_sequence(int bootdelay)
 
 static void print_boot_delay(int bootdelay)
 {
-	printf(ANSI_CLEAR_LINE "\rHit any key to stop autoboot: %d", bootdelay);
+#ifdef CONFIG_AUTOBOOT_PROMPT
+	printf(ANSI_CLEAR_LINE CONFIG_AUTOBOOT_PROMPT, bootdelay);
+#endif
 }
 
 static int abortboot_single_key(int bootdelay)

-- 
2.53.0

