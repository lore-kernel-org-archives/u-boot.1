Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4DE4C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 13:07:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E73A984BA1;
	Thu,  9 Jul 2026 15:05:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="KsKydaui";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 711AC84B01; Thu,  9 Jul 2026 14:58:25 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80E4084A3E
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 14:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-493b27c7451so11283355e9.0
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 05:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783601903; x=1784206703; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=czbsg4YLlDvbBgF6UyG2abk9M767PnmJssHrAYKpZeM=;
 b=KsKydaui/+r6NPkuDwTJEQcerZJC5saYkZoWmnXWBkIdjaS/TloGgIrJVQdjOwJZ6N
 Ll8Stv2F9vBp+Acu5zuC1m++EQUBZ5+wt7QNwqvt9VDg+WiOE78qmQ/FUsjSvDfsVi5G
 3k+TsXeMtfRmZ16Gh9IlWm8PmIEqF20YXXbyr4IzfhoLYDRo+NF2EjhNRE/puPI/4IaR
 z9vTekW9+Li13XtXz+2dLn9QxrfUIeXH8N+oH2XB6n6OblcIYF5ObvfCa2ajib8z8WAf
 qklAGyHsp0T7dqVLiY9pTgkbf6P5w+lKz6+04RMU/m4Chbe5Wl+xn/c4j6HMANHT+2yG
 eAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783601903; x=1784206703;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=czbsg4YLlDvbBgF6UyG2abk9M767PnmJssHrAYKpZeM=;
 b=mQNCr2y+buhJUFpG6u2suyyFIux+rRxu0bhC0bDEl6HM6FJI7aUph1oFP1NcFWGw/n
 gQy3JratoOob6RcfYmDGXdRMjRsWQm/zHonbn8wydcbByMb+7E08jhtJSbcZmCI3+y5w
 2IoHgeu/KFAvtOh1pjs8nq9tydsSKlEog4J/Msn5CNvnqb8DAEQfHbKrmdMHwNYAmG17
 yS4J3NB9945itMu23jfPRrzXOHJQV5efQ1Mz55jvG/d7O7u7Ku7cup2IIPBwq52HY+pg
 wnbb+g/CLCQVAWGo3/RVGxLmrMeJ7MVzRYFMu1U8a0xRxmgoOwueuPtHYw46EH5zBT61
 dUJg==
X-Gm-Message-State: AOJu0Yxy+lBHhFF6J05RdCxANQAjvelVShVt/eI/+PjwDp+WPH0n2XTV
 mNboTSEL/XbOg6GO3rW45KixEbEWp+65dLXUcepYopkRcioz7iyefNYk6Fp/UXBELMI=
X-Gm-Gg: AfdE7clze5G1yTpYyziC9mVzBkmG0dgkEx2Wxh7QW6iBPTPnAFUFuHR1wyMCNuPJmFi
 pJQ5rWgkzZ8eGEZAjZNVVyET7r3icGyAmhe5E0mMy7FHJMNgq9pzVTiZmkfvvctH0TSvwP/uo+w
 6144Fcqv3XhO65N02Uu+doq7L6wuTOxMfXYhy2Eu9cenm7FEL1j6NhBKJ4sZNf2ED1MHZoBHnLQ
 NbMvmerje4AV1W1ukBE0my/xoTu6zm+gGrQPFt3epvcyf1AMYBfn0EDp0GF64BE44A+qqmv7k5A
 JHtusg7klrTTbeEDDDu8L5hQBb2gAeYbhWvJp7OHTK2nEuZVNjpe6XdsSe4JDzeIPwHbZy8x9/L
 WywP8r8hsSrxQU+sjU/fkS26zYKLySoYl7bJOAf1b7OabRccjYrccTACZFbfy6pikGjYDNUkFnt
 RRezRmTJVu8bWTKp4ahFmMFIaelI2T+nWmoCIeXvO//oHus89tY04CHRhyYthyMTZAfveEneL/z
 oVzIutknuyYWB1HVdNEHIJ5amzS36462gwUIDStteq0kNmYRouXKhht1NpD9BChNqO6Ckk=
X-Received: by 2002:a05:600c:4341:b0:493:e49f:1541 with SMTP id
 5b1f17b1804b1-493ec565c21mr18315345e9.6.1783601902732; 
 Thu, 09 Jul 2026 05:58:22 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ad69519c2sm55165977f8f.37.2026.07.09.05.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 05:58:22 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 09 Jul 2026 14:58:16 +0200
Subject: [PATCH v2 10/14] power: domain: mediatek: rename
 mtk_power_domain_probe to mtk_scpsys_probe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-mt8188-add-power-domain-v2-10-589ace7d30e2@baylibre.com>
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

Rename the flat, single-node probe to mtk_scpsys_probe so that the name
mtk_power_domain_probe can be reused for an upcoming nested
(power-controller) probe. Update the MT7623 and MT7629 drivers
accordingly.

No functional change intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/power/domain/mt2701-power-domain.c | 2 +-
 drivers/power/domain/mt7622-power-domain.c | 2 +-
 drivers/power/domain/mtk-power-domain.c    | 2 +-
 drivers/power/domain/mtk-power-domain.h    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/domain/mt2701-power-domain.c b/drivers/power/domain/mt2701-power-domain.c
index 58ef47c3001..a6297401f6a 100644
--- a/drivers/power/domain/mt2701-power-domain.c
+++ b/drivers/power/domain/mt2701-power-domain.c
@@ -83,7 +83,7 @@ U_BOOT_DRIVER(mt2701_power_domain) = {
 	.name = "mt2701_power_domain",
 	.id = UCLASS_POWER_DOMAIN,
 	.ops = &mtk_power_domain_ops,
-	.probe = mtk_power_domain_probe,
+	.probe = mtk_scpsys_probe,
 	.of_match = mt2701_power_domain_ids,
 	.priv_auto = sizeof(struct mtk_scp_domain),
 };
diff --git a/drivers/power/domain/mt7622-power-domain.c b/drivers/power/domain/mt7622-power-domain.c
index b98c384c3b1..339a896e19d 100644
--- a/drivers/power/domain/mt7622-power-domain.c
+++ b/drivers/power/domain/mt7622-power-domain.c
@@ -50,7 +50,7 @@ U_BOOT_DRIVER(mt7622_power_domain) = {
 	.name = "mt7622_power_domain",
 	.id = UCLASS_POWER_DOMAIN,
 	.ops = &mtk_power_domain_ops,
-	.probe = mtk_power_domain_probe,
+	.probe = mtk_scpsys_probe,
 	.of_match = mt7622_power_domain_ids,
 	.priv_auto = sizeof(struct mtk_scp_domain),
 };
diff --git a/drivers/power/domain/mtk-power-domain.c b/drivers/power/domain/mtk-power-domain.c
index 752ca404875..e0293aadfd8 100644
--- a/drivers/power/domain/mtk-power-domain.c
+++ b/drivers/power/domain/mtk-power-domain.c
@@ -158,7 +158,7 @@ static int mtk_scpsys_power_off(struct power_domain *power_domain)
 	return 0;
 }
 
-int mtk_power_domain_probe(struct udevice *dev)
+int mtk_scpsys_probe(struct udevice *dev)
 {
 	struct ofnode_phandle_args args;
 	struct mtk_scp_domain *scpd = dev_get_priv(dev);
diff --git a/drivers/power/domain/mtk-power-domain.h b/drivers/power/domain/mtk-power-domain.h
index ade77af8f33..830d6947962 100644
--- a/drivers/power/domain/mtk-power-domain.h
+++ b/drivers/power/domain/mtk-power-domain.h
@@ -86,7 +86,7 @@ struct mtk_scp_domain {
 	const struct mtk_scp_soc_data *soc_data;
 };
 
-int mtk_power_domain_probe(struct udevice *dev);
+int mtk_scpsys_probe(struct udevice *dev);
 
 extern const struct power_domain_ops mtk_power_domain_ops;
 

-- 
2.54.0

