Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8BAC27C53
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 15:57:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7B448839C;
	Wed,  5 Jun 2024 17:56:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 172EF87A09; Wed,  5 Jun 2024 17:56:36 +0200 (CEST)
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch
 [185.125.25.14])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D9268813A
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 17:56:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VvXBn5G1GzdQq;
 Wed,  5 Jun 2024 17:56:33 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4VvXBn1pLWz8nC; Wed,  5 Jun 2024 17:56:33 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 05 Jun 2024 17:56:10 +0200
Subject: [PATCH next v2 5/6] power: rk8xx: properly print all supported
 PMICs name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-misc-tsd-v2-5-12479432c90f@cherry.de>
References: <20240605-misc-tsd-v2-0-12479432c90f@cherry.de>
In-Reply-To: <20240605-misc-tsd-v2-0-12479432c90f@cherry.de>
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

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 drivers/power/pmic/rk8xx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/power/pmic/rk8xx.c b/drivers/power/pmic/rk8xx.c
index 12ff26a0855..4d07e630579 100644
--- a/drivers/power/pmic/rk8xx.c
+++ b/drivers/power/pmic/rk8xx.c
@@ -277,10 +277,9 @@ static int rk8xx_probe(struct udevice *dev)
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
@@ -311,7 +310,7 @@ static int rk8xx_probe(struct udevice *dev)
 		init_data_num = ARRAY_SIZE(rk806_init_reg);
 		break;
 	default:
-		printf("Unknown PMIC: RK%x!!\n", priv->variant);
+		printf("Unknown PMIC: RK%x!!\n", show_variant);
 		return -EINVAL;
 	}
 

-- 
2.45.1

