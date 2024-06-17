Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6CCC27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 16:49:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 234D488387;
	Mon, 17 Jun 2024 18:49:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1156E88398; Mon, 17 Jun 2024 18:49:22 +0200 (CEST)
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch
 [84.16.66.168])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F8838837D
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 18:49:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4W2wp759Lhz9PJ;
 Mon, 17 Jun 2024 18:49:19 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4W2wp66bsczB2x; Mon, 17 Jun 2024 18:49:18 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 17 Jun 2024 18:48:51 +0200
Subject: [PATCH next] power: rk8xx: fix display name for RK808
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-rk808-show-variant-v1-1-62143a89bafb@cherry.de>
X-B4-Tracking: v=1; b=H4sIAPJocGYC/x3MMQqAMAxA0atIZgNNESteRRyKpjYIVVJRQby7x
 fEN/z+QWYUz9NUDyqdk2VIB1RVM0aeFUeZisMY2piWHunamwxy3C0+v4tOBlizNoaHJBwcl3JW
 D3P90gMT3AeP7flgyP3xqAAAA
To: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.0
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

Commit 2ce40542e0eb ("power: rk8xx: properly print all supported PMICs
name") fixed all PMICs name that were broken but broke the only one that
was not broken already: RK808. This one is a special case because the ID
registers are marked as reserved and always return 0, so the variant
cannot be derived the same way it is done for other PMICs from Rockchip.

Fixes: 2ce40542e0eb ("power: rk8xx: properly print all supported PMICs name")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Tested on RK3399 Puma.
---
 drivers/power/pmic/rk8xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/pmic/rk8xx.c b/drivers/power/pmic/rk8xx.c
index 617bb511e4e..4d5a5ceafad 100644
--- a/drivers/power/pmic/rk8xx.c
+++ b/drivers/power/pmic/rk8xx.c
@@ -281,6 +281,8 @@ static int rk8xx_probe(struct udevice *dev)
 	show_variant = bitfield_extract_by_mask(priv->variant, RK8XX_ID_MSK);
 	switch (priv->variant) {
 	case RK808_ID:
+		/* RK808 ID is 0x0000, so fix show_variant for that PMIC */
+		show_variant = 0x808;
 		break;
 	case RK805_ID:
 	case RK816_ID:

---
base-commit: e242cd95130b64cf91692da41363ac59b25fc08d
change-id: 20240617-rk808-show-variant-2121df41caf7

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

