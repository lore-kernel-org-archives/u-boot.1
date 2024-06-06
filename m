Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE67C27C55
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 08:46:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0F1D88414;
	Thu,  6 Jun 2024 10:45:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA8E78808B; Thu,  6 Jun 2024 10:45:47 +0200 (CEST)
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch
 [83.166.143.173])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE29588258
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 10:45:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VvybF4d1QzvBj;
 Thu,  6 Jun 2024 10:45:45 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4VvybF01kbz9Qj; Thu,  6 Jun 2024 10:45:44 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 06 Jun 2024 10:45:35 +0200
Subject: [PATCH next v3 5/6] power: rk8xx: properly print all supported
 PMICs name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-misc-tsd-v3-5-728d721c464a@cherry.de>
References: <20240606-misc-tsd-v3-0-728d721c464a@cherry.de>
In-Reply-To: <20240606-misc-tsd-v3-0-728d721c464a@cherry.de>
To: Klaus Goger <klaus.goger@theobroma-systems.com>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

The ID of the PMIC is stored in the 2 16b registers but the only part
that matters right now is the 3 MSB, which make the 3 digits (in hex) of
the part number.

Right now, only RK808 was properly displayed, with this all currently
supported PMICs should display the proper part number.

Additionally, when the PMIC variant is not found, print that value
instead of the masked unshifted value as all PMICs we support for now
have their LSB ignored to represent the actual part number.

Tested on RK806 (RK3588 Jaguar), RK808 (RK3399 Puma) and RK809 (PX30
Ringneck).

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 drivers/power/pmic/rk8xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/pmic/rk8xx.c b/drivers/power/pmic/rk8xx.c
index 12ff26a0855..617bb511e4e 100644
--- a/drivers/power/pmic/rk8xx.c
+++ b/drivers/power/pmic/rk8xx.c
@@ -6,6 +6,7 @@
 
 #include <dm.h>
 #include <dm/lists.h>
+#include <bitfield.h>
 #include <errno.h>
 #include <log.h>
 #include <linux/bitfield.h>
@@ -277,10 +278,9 @@ static int rk8xx_probe(struct udevice *dev)
 		return ret;
 
 	priv->variant = ((msb << 8) | lsb) & RK8XX_ID_MSK;
-	show_variant = priv->variant;
+	show_variant = bitfield_extract_by_mask(priv->variant, RK8XX_ID_MSK);
 	switch (priv->variant) {
 	case RK808_ID:
-		show_variant = 0x808;	/* RK808 hardware ID is 0 */
 		break;
 	case RK805_ID:
 	case RK816_ID:
@@ -311,7 +311,7 @@ static int rk8xx_probe(struct udevice *dev)
 		init_data_num = ARRAY_SIZE(rk806_init_reg);
 		break;
 	default:
-		printf("Unknown PMIC: RK%x!!\n", priv->variant);
+		printf("Unknown PMIC: RK%x!!\n", show_variant);
 		return -EINVAL;
 	}
 

-- 
2.45.2

