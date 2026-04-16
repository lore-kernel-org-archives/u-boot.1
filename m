Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDCBF8D753
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 14:58:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C001841D5;
	Thu, 16 Apr 2026 16:58:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="ZOZpMGdE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6FD184201; Thu, 16 Apr 2026 16:58:05 +0200 (CEST)
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com
 [91.218.175.177])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD2B4841F2
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 16:58:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1776351483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uLbYBT2EG7D2YM6oMHBZfORHA2itQkagDFDlcxMpcCA=;
 b=ZOZpMGdEq8UtPgw0p9IQI3LBzQjcrzOAtet6wG2OR8UVXQDEkxfq4+EoN52FxbyW/KUksz
 lC1gE82UuhP0aW94HUdNMmHwLkBJjGih1Re+nYhCosf5dJHWxglEW3w77yZmgZFScVvGyw
 54m4BUTisbvAbP8uFyZ9sv58NMePDXVk4GTp8OWqYPbQyq3303nJAcJ+RnftI5rVHNUCCd
 1soVVuMjI098LJLvXenj0z2oBJzNMHD5gserJ1oHLqB6FIEf5Ubj3rY50YS0s8MylNuyWs
 SgJrDXeX/xEH7dw1xP3kxERMWgI21okWEM3XWBMoh3VPXfesZbVoFjj2rEna1w==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Thu, 16 Apr 2026 14:57:44 +0000
Subject: [PATCH v4 4/4] doc: usage: autoboot: update content
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-ui-cosmetics-v4-4-b843ba661b3f@postmarketos.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2393;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=/DeVU7f3AUWC56X2u6n/1he9fNqr8g/wyFWxDJz8W48=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBp4Pj00bTonLyoIpeY8sIakOpwvJ96NupLJs87q
 shvYbJZcIuJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaeD49AAKCRCEr8vQ14ma
 A7EZEACC6seri3sMg4QyECAgeOumI55sSc0VGNs8Z8sNqEbsNCdQ2LHcBLxsWssOzRvvqz1ML8+
 1sFrmJTeLuL1TKts9RfcqHka4JQoe+nf3MmWsl0eC23UmsETJwvGJIV/b25E0kh203Nkh+fT2u7
 GK+37008kwMrXzUKTUXxnlDi16Taw9r7uo9jniocB14dkGjb4o2YYoEMNGplSB8Vr7YZflGg3Yv
 J+HsHlzIIKta3+21VsxIy1TTXR+4E7VDsB3ttr2BjPLUIm9FFWPLmK7aQnJDKKQhogfgwNg2vC8
 EgsFAtkNQ9naQoPYXHbpshlY6Z1OOnJGQsEnhALyXC77xBENsawCudN7tOghHBk2DbAMg6NrPx3
 do6hhmoCDD7GNym7YbKRjjdpTsMIEdwB9bJ0bgXFzSaoAG337AOdq+ZvcE7aQlz1Vge/E5rtOoB
 jwXAIiUiwTLDb8ycECchaY590mxa+nDB8f0hlgOQ2HVYMGH3MGU1sOTR3dVY3mxeAWYGl+CDurW
 v71Xa+1idLZd7iednTCrDu0BtKYziOW5eVKAbzeOxUOx39z0YV3JWUcmzZlasVgqgtRwuC37yM2
 jHiFNXKJQ0mNBGTf96MEDfx59fMPzgMvjXq+LjdvixGKUT4SN+CqWTKRrM5GJMG2vufefqn8Nhd
 y2ny5+x9COTbT+w==
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

The autoboot documentation is quite outdated. While converting to rST
for being publicly accessible in the docs website, document all basic
autoboot options in there instead of referring to the README (which
no longer mentions any autoboot configuration option), and don't instruct
defining CONFIG_AUTOBOOT_PROMPT with a C #define (as CONFIG_ options may
only be defined in Kconfig).

Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 doc/usage/autoboot.rst | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/doc/usage/autoboot.rst b/doc/usage/autoboot.rst
index 3b6f040008b..5d16fd2c3a2 100644
--- a/doc/usage/autoboot.rst
+++ b/doc/usage/autoboot.rst
@@ -3,18 +3,28 @@
 .. (C) Copyright 2001
 .. Dave Ellis, SIXNET, dge@sixnetio.com
 
-Using autoboot configuration options
-====================================
+Autoboot configuration options
+==============================
 
-The basic autoboot configuration options are documented in the main
-U-Boot README. See it for details. They are:
+The basic autoboot configuration options are:
 
-::
+CONFIG_BOOTDELAY, "bootdelay" environment variable
+    The "bootdelay" environment variable sets the delay in seconds
+    before automatically booting.
 
-        bootdelay
-        bootcmd
-        CONFIG_BOOTDELAY
-        CONFIG_BOOTCOMMAND
+    To disable the delay, it can be either set to 0 (to still accept key
+    input to stop booting) or -2 (to also disable listening for key input).
+    Setting to -1 has the effect of disabling autoboot.
+
+    The corresponding configuration option defines the default value of
+    the "bootdelay" variable.
+
+CONFIG_BOOTCOMMAND, "bootcmd" environment variable
+    The "bootcmd" environment variable defines the command that is run if
+    the user does not cancel the boot process.
+
+    The corresponding configuration option defines the default value of
+    the "bootcmd" variable.
 
 Some additional options that make autoboot safer in a production
 product are documented here.
@@ -84,8 +94,7 @@ CONFIG_AUTOBOOT_PROMPT
 
     ::
 
-        #define CONFIG_AUTOBOOT_PROMPT \
-                "\rBooting in %d seconds"
+        \rBooting in %d seconds
 
 CONFIG_RESET_TO_RETRY
     (Only effective when CONFIG_BOOT_RETRY_TIME is also set)

-- 
2.53.0

