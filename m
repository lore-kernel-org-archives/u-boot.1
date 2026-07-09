Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FBF0C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 13:06:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 682C584B73;
	Thu,  9 Jul 2026 15:05:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="M0fBsLeI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CA6B84B39; Thu,  9 Jul 2026 14:58:11 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A884C84A3E
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 14:58:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-475881b9a4bso1598836f8f.3
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 05:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783601888; x=1784206688; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Mlz85fs2BB6M7gQj6gtL6Ts/IRrwVuzV6DULKBs1nVI=;
 b=M0fBsLeI9ydOvNJvX35ly2eie1vOGwWQavYxt3m0QskUK2keBiiRcRoATQw6QB0xgx
 C6vUqHw/omYlrhlQx39fki17+iLFrmefZQKOsAIp7Pt/NpfEzNwozfa4AryY1gDfu0PU
 KAlBmqYS2BW6w2xMAEqT6ylNUV0ORkq7QIhjJCuEIh0qrin/SZBDWx4R89G7aDZzeeMj
 l267QKyh46QZ9k+1MUXjBr2STErpaVS9OriGFEN2qevrUQqMJNCfTrbp/YFPl/pqtlbN
 h7X0JFddv79jY1KgKrYfvXtHfv5BsXPDTMusd7mrizYblQyy3vXyMWOSepSjxjmfkQYa
 rZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783601888; x=1784206688;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Mlz85fs2BB6M7gQj6gtL6Ts/IRrwVuzV6DULKBs1nVI=;
 b=HDhx1rG3o0LumcFP31Fg6A0fO81Buw8hw4Epdvd97U+nthiq6q8tFAZPhRjBxjYBaG
 f4dcoIjLkDVMNzwu9CV60H1R7aKbXzZPtrp7HGV7HAkcv9AeQ0G+c1TSabOoSDNvF3fG
 FMPJCQIxKwejLs4zbxp4y7cd01USGo9Lqc7obWMGT6k9N3CjPE08+AuKMJ0YYISPXI3Q
 BCyoS0FEe8G99d/Ex1y37zPV5jUrTk+bQPbBIrg9p98biA1kPWKkTm0f+1eEo/ZOHmHq
 bbVTyW6JgkHLGKGtL4YdBKVBF6qFQsA3zHvf08GynstKxZJpfyo0ez8yKrD/Gduh5bQ3
 uNlQ==
X-Gm-Message-State: AOJu0YwhaSy/VcGPb8RzHiIT+EbrCp4xrGgJROkC2I4apXGgI8xqGhWi
 ZXmq8mnVZdbMGjLNhI20t6der2SDWC0if12793aXzlJaVu2mq3p5mtiSu58YZXpTSK4=
X-Gm-Gg: AfdE7ckTHHrZVdh7mcyXzp1XaLh65+zc7xH+157Qb9qN2kvPHaWOT1HO5yts+Rk/oAH
 9rmGfsJW8UAs7RM7a/xQhVH7gHWLkM8QiUsPh7bbyB5NSizUm3pWTuBKVXSWOojdhNJcC5BYvb5
 3s005P0nUWdxDE8kfFqIhAPZSdFhDZpJl2qKjATNC6VioPKtaXVT6LR9mfwoJlsnQjFdPDPWqLJ
 C5+dRqTXKEs05xkwrvCmMfq3JFO6AdPxRnlR+l33rfZMFpPwTK9kVb585Dpx3GwHFxMObkcYHgZ
 EmNNh8CVe2UMxH2FJFaghV4Y71W6B76SGdw2YrY1v6fqJ0tAH95EVNp8cRUBYsqEOET/BPI34kC
 A2QrC9WU6pNn7sDEFXMqI5ld21M96zQB7HTlhg896b12VYx1DEOfU/Awfwcaqntrb5mZHhuovlo
 jAtm9vUYhld83Ikca1hixEgwzfv3SHnkdT95d5BuhEoyKz0wA/AHDZo61V77pVFZwdOEHo187R4
 ur39oviCRJ4Cv/D5DadmrAdF/xqrafV3rZjSBYMGX4V/uybw6rvAOtqf3Xm7rmo3QOkGso=
X-Received: by 2002:a05:6000:4020:b0:475:f100:35fb with SMTP id
 ffacd0b85a97d-47df077cadfmr7755635f8f.56.1783601888026; 
 Thu, 09 Jul 2026 05:58:08 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ad69519c2sm55165977f8f.37.2026.07.09.05.58.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 05:58:07 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 09 Jul 2026 14:58:09 +0200
Subject: [PATCH v2 03/14] power: domain: mediatek: use MT7622 naming
 instead of MT7629
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-mt8188-add-power-domain-v2-3-589ace7d30e2@baylibre.com>
References: <20260709-mt8188-add-power-domain-v2-0-589ace7d30e2@baylibre.com>
In-Reply-To: <20260709-mt8188-add-power-domain-v2-0-589ace7d30e2@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>, 
 Brian Sune <briansune@gmail.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Sam Shih <sam.shih@mediatek.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 David Woodhouse <dwmw2@infradead.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Marek Vasut <marex@nabladev.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Johan Jonker <jbx6244@gmail.com>, Carlo Caione <ccaione@baylibre.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Thu, 09 Jul 2026 15:05:30 +0200
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

Upstream DT bindings define "mediatek,mt7629-scpsys" to fall back to
"mediatek,mt7622-scpsys". Align the driver with this convention by
using MT7622 naming throughout.

This also allows the driver to use the upstream
dts/upstream/include/dt-bindings/power/mt7622-power.h header instead of
the local include/dt-bindings/power/mt7629-power.h, since both expose
equivalent power domain definitions.

Rename scp_domain_mt7629 to scp_domain_mt7622, remove the
SCPSYS_MT7629 enum, and switch all MT7629 power domain defines to their
MT7622 equivalents.

Also drop the explicit "mediatek,mt7629-scpsys" compatible entry and
rely on the DT fallback instead.

Suggested-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/power/domain/mtk-power-domain.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/power/domain/mtk-power-domain.c b/drivers/power/domain/mtk-power-domain.c
index 24dd540897d..dd45f63b763 100644
--- a/drivers/power/domain/mtk-power-domain.c
+++ b/drivers/power/domain/mtk-power-domain.c
@@ -16,8 +16,8 @@
 #include <linux/err.h>
 #include <linux/iopoll.h>
 
+#include <dt-bindings/power/mt7622-power.h>
 #include <dt-bindings/power/mt7623-power.h>
-#include <dt-bindings/power/mt7629-power.h>
 
 #define SPM_EN			(0xb16 << 16 | 0x1)
 #define SPM_VDE_PWR_CON		0x0210
@@ -64,7 +64,6 @@
 enum scp_domain_type {
 	SCPSYS_MT7622,
 	SCPSYS_MT7623,
-	SCPSYS_MT7629,
 };
 
 struct scp_domain;
@@ -138,22 +137,22 @@ static struct scp_domain_data scp_domain_mt7623[] = {
 	},
 };
 
-static struct scp_domain_data scp_domain_mt7629[] = {
-	[MT7629_POWER_DOMAIN_ETHSYS] = {
+static struct scp_domain_data scp_domain_mt7622[] = {
+	[MT7622_POWER_DOMAIN_ETHSYS] = {
 		.sta_mask = PWR_STATUS_ETHSYS,
 		.ctl_offs = SPM_ETHSYS_PWR_CON,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(15, 12),
 		.bus_prot_mask = (BIT(3) | BIT(17)),
 	},
-	[MT7629_POWER_DOMAIN_HIF0] = {
+	[MT7622_POWER_DOMAIN_HIF0] = {
 		.sta_mask = PWR_STATUS_HIF0,
 		.ctl_offs = SPM_HIF0_PWR_CON,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(15, 12),
 		.bus_prot_mask = GENMASK(25, 24),
 	},
-	[MT7629_POWER_DOMAIN_HIF1] = {
+	[MT7622_POWER_DOMAIN_HIF1] = {
 		.sta_mask = PWR_STATUS_HIF1,
 		.ctl_offs = SPM_HIF1_PWR_CON,
 		.sram_pdn_bits = GENMASK(11, 8),
@@ -323,13 +322,12 @@ static int mtk_power_domain_hook(struct udevice *dev)
 	scpd->type = (enum scp_domain_type)dev_get_driver_data(dev);
 
 	switch (scpd->type) {
+	case SCPSYS_MT7622:
+		scpd->data = scp_domain_mt7622;
+		break;
 	case SCPSYS_MT7623:
 		scpd->data = scp_domain_mt7623;
 		break;
-	case SCPSYS_MT7622:
-	case SCPSYS_MT7629:
-		scpd->data = scp_domain_mt7629;
-		break;
 	default:
 		return -EINVAL;
 	}
@@ -385,10 +383,6 @@ static const struct udevice_id mtk_power_domain_ids[] = {
 		.compatible = "mediatek,mt7623-scpsys",
 		.data = SCPSYS_MT7623,
 	},
-	{
-		.compatible = "mediatek,mt7629-scpsys",
-		.data = SCPSYS_MT7629,
-	},
 	{ /* sentinel */ }
 };
 

-- 
2.54.0

