Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFABAC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 22:06:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECC4584ADD;
	Thu,  9 Jul 2026 00:06:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="wjh0VAJt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A08AB84AC3; Thu,  9 Jul 2026 00:06:09 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA0F584AC9
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 00:06:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=747f=FD=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1783548365; bh=QVcEANd0Bh6DO05/DSifVIUw08Kain2aP92ZNTXbu9I=;
 b=wjh0VAJtTnjxyZ/iXUKR708smW46byogYHQW8nDcCnvYFybvKpd5lm2Gr0lo102XXkFtx/KJb
 Pf7YQR59pKylzsNSE8aXGlnHafHWYdVCI01qdW0k0E3EzJy3/QLzNioZgqhCZnMspkIyszhjxnj
 Mei55Kqj0dxvuFNG5E8qoU7xsKsUv5HPi3rIoYQ0/XAJ57LWiBrxQm9rWjs5jOvd+UBUGBjcJpx
 UsMKELhYakDwe0IiYWyDSvgbw2Re0Ea5ecNqiS6VskiODHRKPKAKz3xzgZAzoEf/RFbIIhIOgFT
 /dRf8fBkITi0YgQ1YGYxLVrw8IhVi7iyvhScLrLq0kQg==
X-Forward-Email-ID: 6a4ec9cc2402b3ca75f904bf
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.10.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Tom Rini <trini@konsulko.com>,
	Heiko Schocher <hs@nabladev.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 08/11] Kconfig: i2c: Depend on correct xPL symbol
Date: Wed,  8 Jul 2026 22:05:34 +0000
Message-ID: <20260708220540.3368825-9-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708220540.3368825-1-jonas@kwiboo.se>
References: <20260708220540.3368825-1-jonas@kwiboo.se>
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

Change to depend on the xPL symbol instead of the SUPPORT_xPL symbol to
only make the xPL_SYS_I2C_LEGACY symbols available when xPL is enabled.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/i2c/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index ab5af17858c8..125dc84819e6 100644
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -78,14 +78,14 @@ config SYS_I2C_LEGACY
 
 config SPL_SYS_I2C_LEGACY
 	bool "Enable legacy I2C subsystem and drivers in SPL"
-	depends on SUPPORT_SPL && !SPL_DM_I2C
+	depends on SPL && !SPL_DM_I2C
 	help
 	  Enable the legacy I2C subsystem and drivers in SPL.  This is useful
 	  in some size constrained situations.
 
 config TPL_SYS_I2C_LEGACY
 	bool "Enable legacy I2C subsystem and drivers in TPL"
-	depends on SUPPORT_TPL && !SPL_DM_I2C
+	depends on TPL && !TPL_DM_I2C
 	help
 	  Enable the legacy I2C subsystem and drivers in TPL.  This is useful
 	  in some size constrained situations.
-- 
2.54.0

