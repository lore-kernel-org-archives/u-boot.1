Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A233D3176B
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 17:22:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 707CC88D09;
	Tue,  5 Nov 2024 18:22:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0696891DD; Tue,  5 Nov 2024 18:22:13 +0100 (CET)
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch
 [45.157.188.13])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80E7D8919A
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 18:22:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XjZry1GRZzVsf;
 Tue,  5 Nov 2024 18:22:10 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4XjZrx4ThHzyF7; Tue,  5 Nov 2024 18:22:09 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 05 Nov 2024 18:21:55 +0100
Subject: [PATCH next RFC 1/5] ram: rk3399: allow to fail DRAM init if
 pctl_start fails
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241105-rk3399-dram-init-v1-1-1e29acdf0966@cherry.de>
References: <20241105-rk3399-dram-init-v1-0-1e29acdf0966@cherry.de>
In-Reply-To: <20241105-rk3399-dram-init-v1-0-1e29acdf0966@cherry.de>
To: Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Dragan Simic <dsimic@manjaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
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

pctl_start() can fail but how this is handled currently is by calling
hang() directly in the driver instead of propagating the error and
letting other code handling it.

This prepares for a future commit which removes the hang() in favor of
letting Rockchip's arch code handle it in a common place.

No change in behavior expected in this commit.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 drivers/ram/rockchip/sdram_rk3399.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
index 6fa8f268770d1c6d69431857e115264957d75703..63d7852555cea3296b7cd9eed422c4d5d1c9776b 100644
--- a/drivers/ram/rockchip/sdram_rk3399.c
+++ b/drivers/ram/rockchip/sdram_rk3399.c
@@ -791,9 +791,9 @@ static void set_ds_odt(const struct chan_info *chan,
 	phy_io_config(denali_phy, denali_ctl, params, mr5);
 }
 
-static void pctl_start(struct dram_info *dram,
-		       struct rk3399_sdram_params *params,
-		       u32 channel_mask)
+static int pctl_start(struct dram_info *dram,
+		      struct rk3399_sdram_params *params,
+		      u32 channel_mask)
 {
 	const struct chan_info *chan_0 = &dram->chan[0];
 	const struct chan_info *chan_1 = &dram->chan[1];
@@ -892,6 +892,8 @@ static void pctl_start(struct dram_info *dram,
 					params->phy_regs.denali_phy[937] &
 					0xFF);
 	}
+
+	return 0;
 }
 
 static int pctl_cfg(struct dram_info *dram, const struct chan_info *chan,
@@ -2940,7 +2942,8 @@ static int sdram_init(struct dram_info *dram,
 			}
 
 			/* start to trigger initialization */
-			pctl_start(dram, params, 3);
+			if (pctl_start(dram, params, 3))
+				return -EINVAL;
 
 			/* LPDDR2/LPDDR3 need to wait DAI complete, max 10us */
 			if (dramtype == LPDDR3)

-- 
2.47.0

