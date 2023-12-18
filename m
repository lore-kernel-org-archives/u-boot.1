Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1281EC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 09:00:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAD5E87DC5;
	Mon, 18 Dec 2023 10:00:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=siemens.com header.i=enrico.leto@siemens.com header.b="VW2sPqwk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5E4E87727; Mon, 18 Dec 2023 10:00:12 +0100 (CET)
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0EF687D65
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 10:00:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=enrico.leto@siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 20231218090010aec666cdf28e95da22 for <u-boot@lists.denx.de>;
 Mon, 18 Dec 2023 10:00:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=enrico.leto@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=vAEGqirI+gHY8cRKxMoy8aBtAk32XI/bbXY+2dhTuus=;
 b=VW2sPqwkH3vX1Ritn5fFWoSMLd6MJi0CW9jKylwSGuJcvoSWj6/L1FsQz5YcyzOGiShiW6
 asZbIg2KZ7u6X/WKAQWCYDSlK+9EzD0ehbkpZH5qgW1DpSCLGrAS3+7Y9Qr6gAYTlzfMpVJC
 G+jmI+pzn7Ow/CKNVtzsIi+zRUKPc=;
From: Enrico Leto <enrico.leto@siemens.com>
To: u-boot@lists.denx.de
Cc: Enrico Leto <enrico.leto@siemens.com>
Subject: [PATCH v3 6/6] siemens: factoryset: use correct config for soc
 specific implementation
Date: Mon, 18 Dec 2023 09:59:15 +0100
Message-Id: <20231218085915.3739975-7-enrico.leto@siemens.com>
In-Reply-To: <20231218085915.3739975-1-enrico.leto@siemens.com>
References: <20231218085915.3739975-1-enrico.leto@siemens.com>
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
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/board/siemens/common/factoryset.c b/board/siemens/common/factoryset.c
index 9adc42ce0b7..6d773a87075 100644
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
 #include "board.h"
@@ -197,7 +197,7 @@ int factoryset_read_eeprom(int i2c_addr)
 		cp1 += 3;
 	}
 
-#if CONFIG_IS_ENABLED(TARGET_GIEDI) || CONFIG_IS_ENABLED(TARGET_DENEB)
+#if CONFIG_IS_ENABLED(IMX8)
 	/* get mac address for WLAN */
 	ret = get_factory_record_val(cp, size, (uchar *)"WLAN1", (uchar *)"mac",
 				     buf, MAX_STRING_LENGTH);
@@ -305,7 +305,7 @@ static int factoryset_mac_env_set(void)
 
 	eth_env_set_enetaddr("ethaddr", mac_addr);
 
-#if CONFIG_IS_ENABLED(TARGET_GIEDI) || CONFIG_IS_ENABLED(TARGET_DENEB)
+#if CONFIG_IS_ENABLED(IMX8)
 	eth_env_set_enetaddr("eth1addr", mac_addr);
 
 	/* wlan mac */
-- 
2.30.2

