Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB4D1C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 14:45:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C05C87E68;
	Wed, 24 Jan 2024 15:44:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=siemens.com header.i=enrico.leto@siemens.com header.b="Kn6xlKjv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31FAB87C71; Wed, 24 Jan 2024 15:44:10 +0100 (CET)
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45B3287D94
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 15:44:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=enrico.leto@siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 20240124144402263e092b4ed8490543 for <u-boot@lists.denx.de>;
 Wed, 24 Jan 2024 15:44:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=enrico.leto@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=6UD2LWhbx3Df2e47huKbfbcDdj5ZEnhIPZ6rkHKeFYc=;
 b=Kn6xlKjvUJKa1QPUbNy3BNFUf60tu01oiN4nR1PQ/ItFY7it+Go/gQIlXmASdXq6L7FzbK
 is/44m6HK2MYeFQTwuo660A2TMaaaEdQERKxiQhj3F0cgo5kgRBqrRCLeFKfNlfoRP3GOSQ8
 6J1pCaPqWOcKTsPI+cMlEhBfvn9ws=;
From: Enrico Leto <enrico.leto@siemens.com>
To: u-boot@lists.denx.de,
	alexander.sverdlin@siemens.com
Cc: trini@konsulko.com,
	Enrico Leto <enrico.leto@siemens.com>
Subject: [PATCH v6 7/7] siemens: factoryset: use correct config for soc
 specific implementation
Date: Wed, 24 Jan 2024 15:43:55 +0100
Message-Id: <20240124144355.2040380-8-enrico.leto@siemens.com>
In-Reply-To: <20240124144355.2040380-1-enrico.leto@siemens.com>
References: <20240124144355.2040380-1-enrico.leto@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320603:519-21489:flowmailer
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

Adding the capricorn board family some parts diverge from draco family.
The switches used were not pertinent and need to be enhanced for each new
board of the capricorn family. Replace them through the SOC name 'AM33XX'
and 'IMX8'.

Signed-off-by: Enrico Leto <enrico.leto@siemens.com>
---
 board/siemens/common/factoryset.c | 6 +++---
 board/siemens/common/factoryset.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/board/siemens/common/factoryset.c b/board/siemens/common/factoryset.c
index b20af95d13d..a250ccfe252 100644
--- a/board/siemens/common/factoryset.c
+++ b/board/siemens/common/factoryset.c
@@ -11,7 +11,7 @@
 #include <g_dnl.h>
 #include <net.h>
 #include <asm/io.h>
-#if !CONFIG_IS_ENABLED(TARGET_GIEDI) && !CONFIG_IS_ENABLED(TARGET_DENEB)
+#if CONFIG_IS_ENABLED(AM33XX)
 #include <asm/arch/cpu.h>
 #endif
 #include "eeprom.h"
@@ -197,7 +197,7 @@ int factoryset_read_eeprom(int i2c_addr)
 		cp1 += 3;
 	}
 
-#if CONFIG_IS_ENABLED(TARGET_GIEDI) || CONFIG_IS_ENABLED(TARGET_DENEB)
+#if CONFIG_IS_ENABLED(IMX8)
 	/* get mac address for WLAN */
 	if (get_factory_record_val(cp, size, (uchar *)"WLAN1", (uchar *)"mac",
 				   buf, MAX_STRING_LENGTH) > 0) {
@@ -304,7 +304,7 @@ static int factoryset_mac_env_set(void)
 
 	eth_env_set_enetaddr("ethaddr", mac_addr);
 
-#if CONFIG_IS_ENABLED(TARGET_GIEDI) || CONFIG_IS_ENABLED(TARGET_DENEB)
+#if CONFIG_IS_ENABLED(IMX8)
 	eth_env_set_enetaddr("eth1addr", mac_addr);
 
 	/* wlan mac */
diff --git a/board/siemens/common/factoryset.h b/board/siemens/common/factoryset.h
index 8fa6c3b3d3b..ee8bcd0f20d 100644
--- a/board/siemens/common/factoryset.h
+++ b/board/siemens/common/factoryset.h
@@ -11,7 +11,7 @@
 
 struct factorysetcontainer {
 	uchar mac[6];
-#if CONFIG_IS_ENABLED(TARGET_GIEDI) || CONFIG_IS_ENABLED(TARGET_DENEB)
+#if CONFIG_IS_ENABLED(IMX8)
 	uchar mac_wlan[6];
 #endif
 	int usb_vendor_id;
-- 
2.30.2

