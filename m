Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6737FED2FC
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 09:58:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 714CE8419C;
	Thu, 12 Mar 2026 10:57:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="TubB32Ym";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7115184166; Thu, 12 Mar 2026 10:57:40 +0100 (CET)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A34EC84166
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 10:57:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Max.Merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=HH3ozbwGGagTcovrgnwBPHC8KJmnpDKPQ8lR9uLikE4=; b=TubB32YmBvnv6DO4o0MLZkTvKn
 pcFqAPKVp14CZdAEFIgltp4Ifzi1OyPVZjb0L6cMwudhZmD6bEqNr7EVX9Tr+mZmxxxFIGsstk+KH
 2eC7xTv+VQSzhQNbpmP7YPjH9h1txSZWdBVaXlns8PuXw1XbbOblnFaf2EzNIjrvGP67k79eF6vbl
 JmoVleF2gOjumu6g138yKpR9egXeqg350sCi7VeZZL107ric9GoKqB6gqeazl7uUdzXoBxowdIZL9
 CHe1ZNElnLHvOQcVkUe/VaoRWuLvhFPCSsx9d+M9kZhDhwSGnIBnXpUHoAEOi9O66Ue+Y5P4yRvcN
 oZyTrv2Q==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1w0cnR-0007xp-1I; Thu, 12 Mar 2026 10:57:37 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1w0cnR-000Fyo-0J; Thu, 12 Mar 2026 10:57:37 +0100
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Subject: [PATCH 05/13] [cleanup]configs: tqma6.h: remove unused define for
 PFUZE100_I2C
Date: Thu, 12 Mar 2026 10:57:01 +0100
Message-ID: <20260312095711.3219756-6-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312095711.3219756-1-Max.Merchel@ew.tq-group.com>
References: <20260312095711.3219756-1-Max.Merchel@ew.tq-group.com>
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

The definitions of CFG_POWER_PFUZE100_I2C_ADDR and
TQMA6_PFUZE100_I2C_BUS are not used and will therefore be removed.

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 include/configs/tqma6.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/configs/tqma6.h b/include/configs/tqma6.h
index 7c59b722e2f..bb335ee1b41 100644
--- a/include/configs/tqma6.h
+++ b/include/configs/tqma6.h
@@ -20,11 +20,6 @@
 
 #define TQMA6_SPI_FLASH_SECTOR_SIZE	SZ_64K
 
-#if !defined(CONFIG_DM_PMIC)
-#define CFG_POWER_PFUZE100_I2C_ADDR	0x08
-#define TQMA6_PFUZE100_I2C_BUS		2
-#endif
-
 /* MMC Configs */
 #define CFG_SYS_FSL_ESDHC_ADDR	0
 
-- 
2.43.0

