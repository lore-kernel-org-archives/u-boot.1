Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C9AAF8D757
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 14:58:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2D1384223;
	Thu, 16 Apr 2026 16:58:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="lCXo6cei";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31F9D840AB; Thu, 16 Apr 2026 16:58:02 +0200 (CEST)
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com
 [91.218.175.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18B03841D5
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 16:58:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1776351479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/iKhnXumiWAvIt5tB3bahgiWoprzGPaoEPa0Kq2JmBc=;
 b=lCXo6ceiTyLy7mRc10NKF9atVo5hpA4ah4y52Egr1RVIb2nuKfgTyF1naSrugVKHApdFDL
 t/h5VJmbE9VslrgWBxsYatMy0dNNxhMKwEhZQQCDObwnKJszLyoeO1pgL6T8DqUAhxzCNI
 cmet21VszZcu7OtlsuqXp09c3GkHxRkD/X8Kh0SgImjxUiXpsLPfCQ47XK8XQRpqX4V6N3
 DdW/0yobg6HC8zFvJjr3q4mzIiYvetkJxFX+nu37wjzGNAEMSU3IMqJt9Pj65gp52gXaT4
 993L+ZDhRku9PEVjaC6qS0huOVCLEgYQI91K93hgQBleQWwPgh5LEbD+uBX5Cg==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Thu, 16 Apr 2026 14:57:41 +0000
Subject: [PATCH v4 1/4] autoboot: allow custom prompt without requiring
 AUTOBOOT_KEYED
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-ui-cosmetics-v4-1-b843ba661b3f@postmarketos.org>
References: <20260416-ui-cosmetics-v4-0-b843ba661b3f@postmarketos.org>
In-Reply-To: <20260416-ui-cosmetics-v4-0-b843ba661b3f@postmarketos.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2946;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=W78OJh6lLsKhVjq1BgDGzcNc1Ap3s5X1sVTHGBV6qo0=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBp4Pj0OvVP2IwNrzwgfauLEWTMQino98ILBJE5Q
 FpLM8R5wZiJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaeD49AAKCRCEr8vQ14ma
 A4mTD/9BwRfDQaueGWILV+aPIwrdpGreflKBRHPsZaJW2h5/rk/JZ7TgFQ2S4wxzLIjdjjEZ6Nl
 xiLjp3joSoJMP+urlqQPpbfhxNLcNQvvrByzT3T8A/R0Xg4XfQ0Po1G7izEo/E4jA9nIUgdxqBo
 3VVJWhP+veLxogRE1ozpnLKnmZDrwAIewkd/vHhzakSAn5Tmq0lMnGw7aiQbKEIiDMhBCBqx33j
 KJnT1ZhG4jWSCHo2UNTBOam4/93gFK49x8U390Sn7viN7KBTkxgBCXNoMy7DOzQ4ew8ydr/LKwx
 p/V+zczcfnayGpLE4ZD1a5NypokeHo1gvdoW6SuLf4sil7sBvxHK3thZFY9yonNMj+M59MTJmht
 LNsUJ0c8xnBs0WXCQn0oG0a/QRVryOrMjhwoDHcu3hDdhT94TpaXWSR4yQ/IUM1RLHzh7tsTLy2
 pYZay1kzDmOBriU7wMTI2WPwS+9Sekb+eDFcI1AenRVs7J/kwwhYCXT9aF9EB1uBwHfRdx2Swzz
 CiB/o8SsSv7JOfuiQw4QNgGHDB8oH8aUFpckIHfBz319ukG8loPdklEKhC7V2xTxXSaTT8OGKRt
 1dJ7Kdm9oMAzGhUrZl/keBg+utYSvq0JCh66Ts4hbtKs2KdBIDwODAHhqW8QwThWmml/eXhkfp/
 5JWyZ78jc88qhvQ==
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

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
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

