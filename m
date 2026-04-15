Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D5FF4384C
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 15:41:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08E2584119;
	Wed, 15 Apr 2026 17:40:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="X8aaBGMo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEA12841C8; Wed, 15 Apr 2026 17:40:57 +0200 (CEST)
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BACE984105
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 17:40:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1776267655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/iKhnXumiWAvIt5tB3bahgiWoprzGPaoEPa0Kq2JmBc=;
 b=X8aaBGMo+m/MB2kXvDeBZ7WehxRl7AI5NyszTksTT4Hx3uIYHyitqScQ9tQicmYdcdbMda
 UpBwDuuMtwmUT5ybhMTM6KihA8ogeiOjk5NUxCX+5I9bsjHNSwQbkCxrdN63cypBbxz5Oe
 dPQnWFyVI9/oYu4xJKg4gsiwptADH88Yhrbcu495Vf73s9bw2jSO2yXlNbaSQVfKFZ24pH
 WuFc70Illn7wpMf8qlZiVMaxJs+N/T5LAfqfnD1Nu5iZG2Qu58niTPOwGv5k0+ClXIyxoc
 AXO4w15YNL49sB24BDsLjt9u7KMUCdiFYaVvqXSY+Ib8ko8+InnOlgOTBT4+dA==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 15 Apr 2026 14:32:31 +0000
Subject: [PATCH v3 1/3] autoboot: allow custom prompt without requiring
 AUTOBOOT_KEYED
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-ui-cosmetics-v3-1-aa8308a47e33@postmarketos.org>
References: <20260415-ui-cosmetics-v3-0-aa8308a47e33@postmarketos.org>
In-Reply-To: <20260415-ui-cosmetics-v3-0-aa8308a47e33@postmarketos.org>
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
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBp37GD66WJzK3Ns/bdFDYTHy4pF6siFPKYPRKtu
 TMkg0EOm1SJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCad+xgwAKCRCEr8vQ14ma
 A+5CEACVYd4k487T05vBirLKntE9M0AJ6kdSrUcYnywDtnASCpdtWUgFzJjLIB9KuuVJ5ODngRU
 aQJOLn+e3DWDPg2+g7xEoZNUUKamoWuukcLZE3TRusjA6BJx+17gclSfkHSpKToMFS0K/dBuBBL
 CenjoacPjCxivyF5LV+UQj0Gn+oUsuH/rkfx6Mt7aufi/0z19tKfLpl2rCEGT8T/io1cK4VYUCZ
 pzPZscOkmrWATuJ0W2R9Qlx5Ci25T3u7kToZf5jryzsacWpVz87DhKqg3U8Ns5UUxiccQb6r6ES
 3EbCELYcHLlwlVuI1IwE+IdMofpxAnz5kZJtFrsQ14lzpu35+UfhI5d+h0OFzn7/rblkRzyMZjd
 D3fzH5GMSRYj4wJNrra5pIlpQ+KBC4NsaoENV4uAYiJomWn3HCXj9LNnxo2l36wuUrbKL8EPJIT
 WUt2iLfKpIqzpVDXYM6rH5LSd5J/cUImq7frDJ0KPqu08ZwLgDaVbEA3guTVcup5FF58WYMGMiv
 rIhjDBIiovx2dUrVWVIJ/6T8+xfx/QNyx/BsFzjXvuGqOHvLny4hjnR1I2MskXichYwyBOA+3fd
 YPVld7a17Y4zRa5SPVt5KteX4X9v0HXnr5Q27FkKlL71/3/gsr5i2LAeIgfSfP9g+q95W8qCaLy
 YfGQqf7loGKxTHA==
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

