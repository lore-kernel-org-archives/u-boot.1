Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C05AC54E58
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 20:16:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA84A87F33;
	Thu, 21 Mar 2024 21:16:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="MPOfCJR/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9194E88120; Thu, 21 Mar 2024 21:16:19 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8525387EEB
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 21:16:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-245-032.um16.pools.vodafone-ip.de
 [62.143.245.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 058CA421F6; 
 Thu, 21 Mar 2024 20:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1711052174;
 bh=lpSuZVJVFY92gIscQd/f7/9feWZvD5fMUCPNOom5s9o=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=MPOfCJR/NBj8e5VS/KMx/W2+5y7Rrx0mHJ0pxmCQBFs8FMy1dH5HRgaVfeusAqBwv
 Eynv0DUUU5BKbIKZr+83PxpUGEERrq1l7KcQeQNF2ZrzTPJixVG4bmdjIWCGlxF3kD
 pcmN9Czbth0U/N3KA7FcCRHshpdtqUrRED0+6n+U06D/nWrTTA+YsVZDRnX8CaK1x9
 wlfQ+dkHwx0xYik7YxmTVDrkgM0+wqW+7ExffXIlalkMPBQSIxA99a0D1ABqp1GeIn
 0pZPhRaulvcXt+LB+QwoEiQkczGFfUpfYQW/ClB66z50h7ZTTWaGpDc1w8zKctfsbQ
 Z69SnwTS+GjNg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] rtc: goldfish_rtc_probe should be static
Date: Thu, 21 Mar 2024 21:16:13 +0100
Message-ID: <20240321201613.13607-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

There is no need to export goldfish_rtc_probe().

Fixes: 2d6dc19fd25d ("rtc: driver for Goldfish RTC")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/rtc/goldfish_rtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/goldfish_rtc.c b/drivers/rtc/goldfish_rtc.c
index 1ace9903858..3231eb0daf8 100644
--- a/drivers/rtc/goldfish_rtc.c
+++ b/drivers/rtc/goldfish_rtc.c
@@ -72,7 +72,7 @@ static int goldfish_rtc_set(struct udevice *dev, const struct rtc_time *time)
 	return 0;
 }
 
-int goldfish_rtc_probe(struct udevice *dev)
+static int goldfish_rtc_probe(struct udevice *dev)
 {
 	struct goldfish_rtc *priv = dev_get_priv(dev);
 	fdt_addr_t addr;
-- 
2.43.0

