Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE39CC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 17:37:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D52A84A95;
	Wed,  8 Jul 2026 19:36:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="mNyN7tlH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7819684A29; Wed,  8 Jul 2026 15:07:26 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7327F849F6
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 15:07:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-493c55d5c7aso6741725e9.1
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 06:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783516044; x=1784120844; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3Kuq380tgQRzYdHP+0Yh9ZXvxX9X98Y/fsnQJGMzPOQ=;
 b=mNyN7tlH5C8+Eam8pyoXyLJ1uFy3C0DBFHBhm9n1Blw5EIHBs8rzLq17Tqr5p1os+r
 SJj4l2lg8LJPnbkSJBgBrVh/LJTi/S7OUSXOFrl8xGejMQ4ehsbR+lHlggHq++dTWWEM
 3XoxE8O7jg8RI5b5Oxn2sR52LbI3PONC03UwnC/CX47aNDZxHaUxA2QvA4rmlonIq5R4
 lO342doNHQ8ogcblbskrK/X37TJqM9aU/yvCGB549UJWGBFj8CTF+xrEkDfdYeySDm+V
 xAk3V+2IOaPahJ86J8RwcQ6vpfeatnXKBUTjISxg60L3l2zj4fwUXEEY7mH6U46WuRjn
 YgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783516044; x=1784120844;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3Kuq380tgQRzYdHP+0Yh9ZXvxX9X98Y/fsnQJGMzPOQ=;
 b=kW9Ci0BKrJE7WXNymAdzrsKCWTu0OWW/NFRS6H5ITTm6LRRAOgipThpf2ulfwWxYRE
 U4nLf+f1CWILbOqEORliEtJFEOmELvep4yRMG9DYaLY5xCo4HkDOL87HHKE7sN7lvfrq
 SC9hEMQhanu3Xud2VZxhtPWKc9FaO6PZcDIehyrjW7UNOid0PIUqkFpo/wTYYXGBDLCh
 VfaNJLngqyqYjTalM/EbdznXelwzvAqbN0b5Q1afvB9ee+Jk0R+5PNfMNEwc+n5r0t9W
 3b62ylt8jMRb7ReUz+TTkiPmNq6OTuqchvwXcXGQFwJ37yc3tfteEaAg+cRT0fW+gDHN
 fDRw==
X-Gm-Message-State: AOJu0YwbCqYEfCJw7kH+NN+8x876hAhbe1sCzl85tBlUaJBa+CV44BCT
 rRXFyiLpFXyHQlFUdU05cLTp6ElVv/nDV5nr2smw93oCxspScXwuA3azzV9j5talTfc=
X-Gm-Gg: AfdE7cnslzW768LsKpD6zZNGimShtu7JbKlAHY40HRb2oztfSQLS3tMsBY1ULin76Ao
 33af/WPPDt0KFH8G/60bLzXYhZt1htKHuOlO3jyvLaZDijzzurJp21/EGIqX9Ce4COJQ0cpSing
 OuJms5kvUVHTPhhGse4z3lilX33Nv/Tj+mm1sUOYIRwrqXMn1BluiGPu2TG8C+K+0iiVQ56IuJM
 jnLQxGDvEYsa2dFdZKLHhx9aPeOAtJOO9zm+6R1Le3lxlRVKf317OUwmXipGtnws5jbDpYAO7wn
 1+TsubYYcOgMvVHSCbmkFKZWWowH7w7pDwo6UzzEAlVjx5LrHxb7elV/LprTuKY8TfR9/dW0x28
 +z17cov4YUbyoFYk8gCwvOznCDLwBXydM80M4Yhq4aMqxDbLTCuNO4jus1c2axvPCUz40BR0bSx
 +3LmpKqXI/9qfcQUZjrlL/cz3ilyJ8pJNJbPSKOaqs9XwLeK/OKfCrkmyB4lbl6HwZ0TFMe9UI+
 rm6uXD6iGOLSE0MueFTWj4/WIq5I60kQMG8XOs8meWdRBotTkW38x0iYBdbFLyKlJ+EZ4s=
X-Received: by 2002:a05:6000:1849:b0:47d:f01e:83cf with SMTP id
 ffacd0b85a97d-47df07b4b51mr2849271f8f.58.1783516043868; 
 Wed, 08 Jul 2026 06:07:23 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039af67sm49000664f8f.17.2026.07.08.06.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 06:07:23 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 08 Jul 2026 15:07:14 +0200
Subject: [PATCH 08/12] power: domain: mediatek: rename
 mtk_power_domain_probe to mtk_scpsys_probe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-mt8188-add-power-domain-v1-8-0e930b4f714e@baylibre.com>
References: <20260708-mt8188-add-power-domain-v1-0-0e930b4f714e@baylibre.com>
In-Reply-To: <20260708-mt8188-add-power-domain-v1-0-0e930b4f714e@baylibre.com>
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
X-Mailman-Approved-At: Wed, 08 Jul 2026 19:36:37 +0200
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
 drivers/power/domain/mt7623-power-domain.c | 2 +-
 drivers/power/domain/mt7629-power-domain.c | 2 +-
 drivers/power/domain/mtk-power-domain.c    | 2 +-
 drivers/power/domain/mtk-power-domain.h    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/domain/mt7623-power-domain.c b/drivers/power/domain/mt7623-power-domain.c
index 03dd20e7bc1..318f0fc8e76 100644
--- a/drivers/power/domain/mt7623-power-domain.c
+++ b/drivers/power/domain/mt7623-power-domain.c
@@ -79,7 +79,7 @@ U_BOOT_DRIVER(mt7623_power_domain) = {
 	.name = "mt7623_power_domain",
 	.id = UCLASS_POWER_DOMAIN,
 	.ops = &mtk_power_domain_ops,
-	.probe = mtk_power_domain_probe,
+	.probe = mtk_scpsys_probe,
 	.of_match = mt7623_power_domain_ids,
 	.priv_auto = sizeof(struct mtk_scp_domain),
 };
diff --git a/drivers/power/domain/mt7629-power-domain.c b/drivers/power/domain/mt7629-power-domain.c
index a4456f399bb..6cc413b7a89 100644
--- a/drivers/power/domain/mt7629-power-domain.c
+++ b/drivers/power/domain/mt7629-power-domain.c
@@ -54,7 +54,7 @@ U_BOOT_DRIVER(mt7629_power_domain) = {
 	.name = "mt7629_power_domain",
 	.id = UCLASS_POWER_DOMAIN,
 	.ops = &mtk_power_domain_ops,
-	.probe = mtk_power_domain_probe,
+	.probe = mtk_scpsys_probe,
 	.of_match = mt7629_power_domain_ids,
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

