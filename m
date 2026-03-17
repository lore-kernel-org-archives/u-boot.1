Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBA5FD877E
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 14:25:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8A33843B9;
	Tue, 17 Mar 2026 15:24:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sIOEMhiu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB2E38439E; Tue, 17 Mar 2026 15:24:29 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C47C84399
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 15:24:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4853e1ce427so66152705e9.3
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 07:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773757465; x=1774362265;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=URqPLMMBrAVcWnyZFv9AwEV9hmNI6lT2K0Idl9niNd0=;
 b=sIOEMhiuHiFVUolyfs//S4dQhlimMY4VFOYRFauT3JZtrxiB2MjgD1bp+gihsD3uHZ
 6liYNWNeoxMXFqfeUZeIRPJGZI3xhn8aGH7Xo+JdKkOYR5B0p+6pJaqZ5GJKMkGezI6U
 ntJXEj8fmKYhNSVU2bvc2lqwiG4+4p4gTyOXZOH2kV/ru021OkYQD7lbjf6gV24y0ImP
 T/cbQ2H+s+NYFEE42meTYlOXp2Uq7FqV8CObXk1Nd/SS1q/T+w1K9rWrpn8bk24vyy2B
 t0LvM1f6eVQEceo9KhCqA3jIQN1KsKBzZWO2G8jRv+KN6qqu/IqDlyFJEXokt1ar1+YZ
 k7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773757465; x=1774362265;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=URqPLMMBrAVcWnyZFv9AwEV9hmNI6lT2K0Idl9niNd0=;
 b=hL0M/bakv4c2Nu21DGEjyO6Iq94zWfyUtBy7FXG6TlNLxPrB23gseecrbBQiJA919g
 4Ddm4TxCOfVDtuTVi4YaYmD3vAE7X5TyAgu4xKkZKMRixcOACun8dt/lPz0ilZUZ+TPJ
 tS0Obk+AQ/qLrgUHd2mVLRgkSQliX9M/pfcSutYbAl7JcIyflTpojT3/1RJnej7A9lGN
 vEZTG3x4H3x508QACokUdvuX3l7x9NfLhgpjxTlMJ0M6OgLgUDOZmMWHrhUZiE0I0r4Y
 ig74JOvHrYs76umNdLb2W5s+TPwemUqQlLddfXsXLC5yJvhxodaNGKHtGFW8u/3iRobj
 daag==
X-Gm-Message-State: AOJu0Yzem/HpKg3pdkQ9+BaPRerXE/BMMtMbNW0YKrBUeduAXZnfTG6v
 36DrcRxekm++1tZsgQz35Z4PNzGpXLu+V0C6AGofyDah5WavJZPNQ9SMBxtjPs2+7hI=
X-Gm-Gg: ATEYQzxfMRZc2fku6SvvmcbBG8t/esV1wY2iooeTrvl5xvb/PAxe71Rbg8RefBADGc3
 ELoLeYji/VdJoGvHxfUvz7YCvfbmcnz/e4FSWUbTDMdFqTs+FgHzyatwcPG0dRwc7HlfrWemgsb
 U5vW+UtbuBkBP2DU1xs7P3f/VEshTbc2aHqviWYLqzstUowbzzgCwV67euYH65sCVd10nrdv2Wf
 iwgA+0A406/nAFTHIB9HzXG+AjZ1FVyzEKwF391q1ilgoEjKseicyHc+RYp6LwmmXSZvRoBNocd
 gCU2VlIYHK2RX1GzUm3ixGwe3sNWb6YgwsFgPYDii2PpA6jTV0L0jN8qnTJvi/pcDeCD6tVm2Qf
 k+N+zHonbztH1oCpB2cAK3W+1bCwZ21IZzA+WxMAipNOxJ/Hx7DlvGFhj/NHT9QnISJx9g1mTAp
 Xg/eQgfmjAyGlOvvTDXqJp42LQrSaL2W2JxAQtv8qsuGNmR/nctT03JctSW0we+raWvMYM1pfjB
 JhEQOQFgLr68uFuOP52BWuUpvkFiPwcXE6F9h1sqDDfUCvcEmBkL6tmbIq7VQRcCxSQzwD5hSDr
 VJifoFA=
X-Received: by 2002:a05:600c:1388:b0:485:2fd9:3d4a with SMTP id
 5b1f17b1804b1-4855670283cmr283739705e9.22.1773757465429; 
 Tue, 17 Mar 2026 07:24:25 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-b535-6f9c-731f-0b89.rev.sfr.net.
 [2a02:842a:d52e:6101:b535:6f9c:731f:b89])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48556400f76sm125425675e9.1.2026.03.17.07.24.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 07:24:24 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 17 Mar 2026 15:24:25 +0100
Subject: [PATCH 07/11] drivers: phy: phy-mtk-ufs: do not alloc priv with
 priv_auto
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-mt8195-add-ufs-support-v1-7-7d731ec438ae@baylibre.com>
References: <20260317-mt8195-add-ufs-support-v1-0-7d731ec438ae@baylibre.com>
In-Reply-To: <20260317-mt8195-add-ufs-support-v1-0-7d731ec438ae@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
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

When priv_auto is specified, we should not manually alloc memory for
priv data.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/phy/phy-mtk-ufs.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/phy/phy-mtk-ufs.c b/drivers/phy/phy-mtk-ufs.c
index 0522e1ab683..c4c214dcde0 100644
--- a/drivers/phy/phy-mtk-ufs.c
+++ b/drivers/phy/phy-mtk-ufs.c
@@ -139,10 +139,6 @@ static int mtk_ufs_phy_probe(struct udevice *dev)
 	fdt_addr_t addr;
 	int ret;
 
-	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
-	if (!phy)
-		return -ENOMEM;
-
 	addr = dev_read_addr(dev);
 	if (addr == FDT_ADDR_T_NONE)
 		return -ENOMEM;

-- 
2.52.0

