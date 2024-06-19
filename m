Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17FCEC27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 21:13:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73B3C8840F;
	Wed, 19 Jun 2024 23:13:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BECC9884A4; Wed, 19 Jun 2024 23:13:26 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFA9588363
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 23:13:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1sK2cN-00EK6f-Gb;
 Wed, 19 Jun 2024 21:13:23 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Fabio Estevam <festevam@gmail.com>,
	u-boot@lists.denx.de
Cc: Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] board: gateworks: venice: delay before reading GSC EEPROM
Date: Wed, 19 Jun 2024 14:13:22 -0700
Message-Id: <20240619211322.2068243-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
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

Extensive testing has shown that at higher temperatures operating
without a GSC backup battery, the GSC needs a small delay after
releasing the I2C SDA/SCL pins before it is ready to handle I2C
requests.

Add a delay to avoid errors such as:
wait_for_sr_state: Arbitration lost sr=93 cr=80 state=2020
i2c_init_transfer: failed for chip 0x20 retry=0

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 board/gateworks/venice/spl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/gateworks/venice/spl.c b/board/gateworks/venice/spl.c
index 9a22eeef36ba..ec3c394d24d8 100644
--- a/board/gateworks/venice/spl.c
+++ b/board/gateworks/venice/spl.c
@@ -303,6 +303,7 @@ void board_init_f(ulong dummy)
 				mdelay(10);
 			}
 			pinctrl_select_state(bus, "default");
+			mdelay(10);
 		}
 	}
 	/* Wait indefiniately until the GSC probes */
-- 
2.25.1

