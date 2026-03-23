Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6310F4610D
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 13:48:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36B7F8418C;
	Mon, 23 Mar 2026 14:48:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="nkwD6bmQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C190841DD; Mon, 23 Mar 2026 14:48:06 +0100 (CET)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8184784144
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 14:48:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Max.Merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=PIYMrE88u+S0LTwXWRCu+iJDKudKgWa5sdoxg8sKxC4=; b=nkwD6bmQyZ8g/XB7hagXLRTrHz
 sN1mN/lbyyk0WdFjG8Bb5k8j5xFd+Q72+BBcHhpazuC2Npkb6V5ERwaRtto1m/4OCtj3Uk0BrNCtL
 5xr/HWee6zH3OPQliofDuNqCyvYySGFP/kcofNOOVjhgC/T/pKJ1W8ZP5PQdHSVmNbcCcYyCJ5779
 YTFToIMRevranGVuSrmGQLAuirbrI1F7HpSW2+gy0dJ9IDZK+GfT2patKb2vd1DPZpQTEzifWGhQ+
 wbtPU4OpGjbATlJiamgGm5xTVzjZLZKXlPIcQvCEa158sONKrd9YuqLnBTvcc1Zrb7QaQxHCXiloG
 s1VApa2Q==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1w4fdR-0000dp-1b; Mon, 23 Mar 2026 14:48:01 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy08.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1w4fdQ-000M7t-15; Mon, 23 Mar 2026 14:48:01 +0100
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Subject: [PATCH v2 03/10] [cleanup]configs: tqma6.h: remove unused define for
 PFUZE100_I2C
Date: Mon, 23 Mar 2026 14:47:33 +0100
Message-ID: <20260323134746.787430-4-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323134746.787430-1-Max.Merchel@ew.tq-group.com>
References: <20260323134746.787430-1-Max.Merchel@ew.tq-group.com>
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

Remove the definition of CFG_POWER_PFUZE100_I2C_ADDR and
TQMA6_PFUZE100_I2C_BUS as it is not used.

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

