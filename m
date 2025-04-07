Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CEFBC3601A
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 09:55:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F90782D0C;
	Mon,  7 Apr 2025 11:54:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SMe1qAkr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C61D82E25; Mon,  7 Apr 2025 11:54:44 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FAFD82D59
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 11:54:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ac29af3382dso670617566b.2
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 02:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744019682; x=1744624482; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3rzF3NfM1y6Oc4r44AN4BIVdQ3u2wvwlzNck9ocuwp0=;
 b=SMe1qAkragfM0XfaX0gx3YLtfT8MXyiqiG21AlazpKpxL7NQuBXWjAhMkX5NAYujxq
 OPtrpUHM6F9nl045t1mp7260ohJvC9j2fC9+1RhyZSG7SUfkqcD40qJxNGqA6NeLKzRA
 EvFLX3CnYA7o/64AaFoUcMzaS8BeIKdcruEYKHSWz6YvRrAyNV05cgOJry0K881NEUFl
 OJoQgnuLOec9rSFZ267NzYdyWj/PWimrMGkcDDxGEDG4+bBgMltzNsgvoJ+08Sr9yVz4
 sR+cm0Mit0PfLS42RNY+VI8TABj4+QAcODLwLINVuYjimSCOT0fSQLuW0OZcHN5KouLz
 Uasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744019682; x=1744624482;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3rzF3NfM1y6Oc4r44AN4BIVdQ3u2wvwlzNck9ocuwp0=;
 b=NV0t6FHU5h5++ToudWaHJonCFYSIMa/aR/o0RBJIybTCrr/suGocv4Ioi7lAWGptXE
 8sgJ4N1pCNVa8KwX0YkSJ7V9eqCBoVM7XoB+fL3CPeZC6lReAb5ePMWt+34QORicrShE
 eSIw73nFu1DGHdykL1qPGxIn2uBL+nbkXnNu2d0lliVAHa0dkm/ye8u7llERrGOBMysC
 JQIyuTnZjrNCxVmXELJS5AkZqda+4sLmIDygLx7sy5Fhu2jv08GHZcgBZUkZiu12dYTY
 Pe0tzM3RdWrVTqwscerWc6HtHHKHQlGUuWQ/6XVRSPeeNKkBlRzyD9g2OwCgMG+oTxvM
 CMSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnUFrQJehux18OwHAnLfVJy++xrDHnNHp26oJZ/Lv7O88cItcfNwD+RWRfG5vP1dGKGK2T+7A=@lists.denx.de
X-Gm-Message-State: AOJu0YwnXpm03BxFcx0uHyswJ5DNlRBByTvUX8Lgv2n7HhlCayhpzEYV
 5SIPaYtLwuh18P6oLEQRX9O7m9nFX6CTsJmkD9AAEsV+GtAq81yC1KGeEFsF1gU=
X-Gm-Gg: ASbGnctxWkCIRgv4hyvO4QIgZ6Oia4I2icDtlHhVWHJh6xKGoKISCHaFKEsliEPkWKj
 rzfpfhQ0L67KFoSrQ2oPxh4mg7NAGEJe0C2RJs+DzG2t0LpcXYR8VvL9dEagLBjBAa9R+wjJ3MU
 bslxwggsTM2ozjq6twPhQ0czV2+DBtCV05RBThNiia/uvMi4hyTBGEE8GgRMdOk24mVbSS/C6Kl
 tkjpQxzIHldMJFEMlEvsW2TgbYdLa9cGAmEYaVTBNHE7+g3DzZTb/PPvSKekKOUcWfzmLFpHDyP
 BE3uIq+vuUKcIVvhQZyRIegK7KP1RXOd37UIQFXhHclj8OSebElXjG4Yww==
X-Google-Smtp-Source: AGHT+IHAd/+bTs3hogKEcPKe9S8LSxR4+RaDDdpZiXRi0Mj/DB9F02BOUUs0J59JkV1d+wJ1ZowzbA==
X-Received: by 2002:a17:907:3e9f:b0:ac7:81b2:c6e5 with SMTP id
 a640c23a62f3a-ac7d6f1b74amr1188200066b.55.1744019681580; 
 Mon, 07 Apr 2025 02:54:41 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:7d3f:b102:5311:c65b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7c013f6b5sm735733766b.109.2025.04.07.02.54.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 02:54:41 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 07 Apr 2025 11:54:24 +0200
Subject: [PATCH 4/6] usb: host: ehci-msm: Use clk bulk helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-ehci-msm-fixes-v1-4-f8b30eb05d07@linaro.org>
References: <20250407-ehci-msm-fixes-v1-0-f8b30eb05d07@linaro.org>
In-Reply-To: <20250407-ehci-msm-fixes-v1-0-f8b30eb05d07@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>
Cc: Sumit Garg <sumit.garg@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Jianfeng Zhu <JianfengA.Zhu@sony.com>, Jacky Cao <Jacky.Cao@sony.com>, 
 Sam Day <me@samcday.com>, u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14.2
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

The enable order for the clocks does not matter much, we just need to
enable all the USB clocks. Use the clk bulk helpers to simplify the code.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/usb/host/ehci-msm.c | 36 +++++++++++-------------------------
 1 file changed, 11 insertions(+), 25 deletions(-)

diff --git a/drivers/usb/host/ehci-msm.c b/drivers/usb/host/ehci-msm.c
index bf46e89104ecd594587eb9132b8d10d566feb766..17cfff8380c3953900fe6383bee396b147287592 100644
--- a/drivers/usb/host/ehci-msm.c
+++ b/drivers/usb/host/ehci-msm.c
@@ -25,8 +25,7 @@ struct msm_ehci_priv {
 	struct ehci_ctrl ctrl; /* Needed by EHCI */
 	struct usb_ehci *ehci; /* Start of IP core*/
 	struct phy phy;
-	struct clk iface_clk;
-	struct clk core_clk;
+	struct clk_bulk clks;
 };
 
 static int msm_init_after_reset(struct ehci_ctrl *dev)
@@ -55,25 +54,15 @@ static int ehci_usb_probe(struct udevice *dev)
 	struct ehci_hcor *hcor;
 	int ret;
 
-	ret = clk_get_by_name(dev, "core", &p->core_clk);
-	if (ret) {
-		dev_err(dev, "Failed to get core clock: %d\n", ret);
+	ret = clk_get_bulk(dev, &p->clks);
+	if (ret && (ret != -ENOSYS && ret != -ENOENT)) {
+		dev_err(dev, "Failed to get clocks: %d\n", ret);
 		return ret;
 	}
 
-	ret = clk_get_by_name(dev, "iface", &p->iface_clk);
-	if (ret) {
-		dev_err(dev, "Failed to get iface clock: %d\n", ret);
-		return ret;
-	}
-
-	ret = clk_prepare_enable(&p->core_clk);
-	if (ret)
-		return ret;
-
-	ret = clk_prepare_enable(&p->iface_clk);
+	ret = clk_enable_bulk(&p->clks);
 	if (ret)
-		goto cleanup_core;
+		goto cleanup_clocks;
 
 	hccr = (struct ehci_hccr *)((phys_addr_t)&ehci->caplength);
 	hcor = (struct ehci_hcor *)((phys_addr_t)hccr +
@@ -81,19 +70,17 @@ static int ehci_usb_probe(struct udevice *dev)
 
 	ret = generic_setup_phy(dev, &p->phy, 0, PHY_MODE_USB_HOST, 0);
 	if (ret)
-		goto cleanup_iface;
+		goto cleanup_clocks;
 
 	ret = board_usb_init(0, plat->init_type);
 	if (ret < 0)
-		goto cleanup_iface;
+		goto cleanup_clocks;
 
 	return ehci_register(dev, hccr, hcor, &msm_ehci_ops, 0,
 			     plat->init_type);
 
-cleanup_iface:
-	clk_disable_unprepare(&p->iface_clk);
-cleanup_core:
-	clk_disable_unprepare(&p->core_clk);
+cleanup_clocks:
+	clk_release_bulk(&p->clks);
 	return ret;
 }
 
@@ -127,8 +114,7 @@ static int ehci_usb_remove(struct udevice *dev)
 		return -ETIMEDOUT;
 	}
 
-	clk_disable_unprepare(&p->iface_clk);
-	clk_disable_unprepare(&p->core_clk);
+	clk_release_bulk(&p->clks);
 	return 0;
 }
 

-- 
2.47.2

