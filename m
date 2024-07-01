Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B803BC3065A
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 06:51:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF17288671;
	Mon,  1 Jul 2024 08:50:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="TnlDVSd/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 682E288676; Mon,  1 Jul 2024 08:50:57 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29D9D88680
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 08:50:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-041-025.um47.pools.vodafone-ip.de
 [178.202.41.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 8848A3F355; 
 Mon,  1 Jul 2024 06:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1719816650;
 bh=ZI1DL+Oj72cWkRdTGwLXi7MP1mexyr6rbzpW8Le4quY=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=TnlDVSd/xcxfkYWHZ4NEcPjw0jC/7322Md7rT7yVyB+hmDKVvGsLPG0YNguuM3Fmn
 P3FeJBT8AI2ReCeIEFTfgLivoSpGgI1nUKjZmGGAligcNFFiboOaTgQJx70FcpPmIK
 rZ+CCJjIu1En+pNCfOGQRbJeksA+Na67evtsoL87yq8u+JSjOklD/+jFFr4CyLHEUC
 2H4TuvNgE49XIIBdJEBqN5J4Hcz2Nbx+SHrrcJAfFM6lrntdZXw8SLczyXcpi0Xob1
 YU2VzpG8Pc7dFah7nk67WjpTbp5ygCA4TWjJiUxnWnZDK0ArH9lziHICp91QZUJUBT
 OXoI5temowYzw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] rtc: fix the description of the Goldfish RTC driver
Date: Mon,  1 Jul 2024 08:50:24 +0200
Message-ID: <20240701065025.13296-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

Replace the incorrect description that was copied from another driver.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/rtc/goldfish_rtc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/goldfish_rtc.c b/drivers/rtc/goldfish_rtc.c
index 3231eb0daf8..e63a2766c76 100644
--- a/drivers/rtc/goldfish_rtc.c
+++ b/drivers/rtc/goldfish_rtc.c
@@ -2,7 +2,9 @@
 /*
  * Copyright 2023, Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
  *
- * This driver emulates a real time clock based on timer ticks.
+ * This driver supports the Google Goldfish virtual platform RTC device.
+ * The device is provided by the RISC-V virt machine in QEMU. It exposes
+ * a 64-bit nanosecond timer via two memory-mapped 32-bit registers.
  */
 
 #include <div64.h>
-- 
2.45.2

