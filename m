Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B5BC47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 03:50:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C999C877FE;
	Thu,  4 Jan 2024 04:49:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="s9+KcCpa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 403A587866; Thu,  4 Jan 2024 04:49:57 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E01BB8771E
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 04:49:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id EB8C1413BB; 
 Thu,  4 Jan 2024 03:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1704340194;
 bh=w+ShWYVe5J9PdDbKE1YROLH/2RmUtdaOZrM5QJPpVV4=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=s9+KcCpaZ0efgzWXCSqaFI/loHiC9JFUoIdqy1ZxoRVH0g17eBfpXzmq5Z+Qs/xa6
 /QRdE9MQf58lk6qM4rw/FWUh0Ll7zI8DwcBWHUmV62DAoGEnvFY+S6prihVs2DVsm8
 3de7dJYlAH3vzoc99Xh3258Pywa4C8Cyvz5p9dRxLUtiJqlSTXmVIb0vRRm6EYWe9Q
 x806dANy7d+6mBgUoMumVcRLFaQA2mDv2xh/cHQ4o2eeKIXXqIAqFBe1ue5S4KXYPN
 a30gTarLH/ohFcb2p83mFexyNiTn2vDAyovV2Dqopx28+TD78japCJynu6WtDWa0DK
 W2hdrG+zgby4A==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Peng Fan <peng.fan@nxp.com>,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, Eugeniu Rosca <erosca@de.adit-jv.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] mmc: Avoid buffer overrun in mmc_startup()
Date: Thu,  4 Jan 2024 04:49:42 +0100
Message-ID: <20240104034942.102500-1-heinrich.schuchardt@canonical.com>
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

If the CSD register contains a reserved value (4 - 7) in bits 0:2 of the
TRAN_SPEED field, a buffer overrun occurs. Resize the mapping table.

According to the original report
https://lore.kernel.org/u-boot/20180826231332.2491-11-erosca@de.adit-jv.com/
reserved values have been observed resulting in a buffer overrun.

Reported-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Fixes: 272cc70b211e ("Add MMC Framework")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/mmc/mmc.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index d96db7a0f8..00f4964aae 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -1570,13 +1570,20 @@ static int sd_read_ssr(struct mmc *mmc)
 	return 0;
 }
 #endif
-/* frequency bases */
-/* divided by 10 to be nice to platforms without floating point */
+/*
+ * TRAN_SPEED bits 0:2 encode the frequency unit:
+ * 0 = 100KHz, 1 = 1MHz, 2 = 10MHz, 3 = 100MHz, values 4 - 7 are reserved.
+ * The values in fbase[] are divided by 10 to avoid floats in multiplier[].
+ */
 static const int fbase[] = {
 	10000,
 	100000,
 	1000000,
 	10000000,
+	0,	/* reserved */
+	0,	/* reserved */
+	0,	/* reserved */
+	0,	/* reserved */
 };
 
 /* Multiplier values for TRAN_SPEED.  Multiplied by 10 to be nice
@@ -2560,6 +2567,8 @@ static int mmc_startup(struct mmc *mmc)
 	mult = multipliers[((cmd.response[0] >> 3) & 0xf)];
 
 	mmc->legacy_speed = freq * mult;
+	if (!mmc->legacy_speed)
+		log_debug("TRAN_SPEED: reserved value");
 	mmc_select_mode(mmc, MMC_LEGACY);
 
 	mmc->dsr_imp = ((cmd.response[1] >> 12) & 0x1);
-- 
2.43.0

