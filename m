Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C7B1C44512
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 16:22:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 841DE84E5C;
	Thu, 16 Jul 2026 18:09:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FZD7Q9d2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4D2F84CCF; Thu, 16 Jul 2026 15:45:05 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4A0E80433
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 15:45:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anders.roxell@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-698af3e3620so1000451a12.2
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 06:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784209503; x=1784814303; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1tzuK126gkqzE7hk+EKhTwWZwCqY6OqCcP/3T5D6Xig=;
 b=FZD7Q9d2DwVMpMw9vqGwB3mxUu35jJSs8NKVjmxezQHpL6loKQJIuYNnReDRz4SJKM
 DpIVXOoODrZd4BYqUW/Vcx9aLPrByXI3nuBkEIzYPHhcuSMJFnR3lQPG0QbXDHcNJgfk
 RX8a9btGhLshtwiwqxSuplrCyAelIJzNAs/yV2520LnA9ZM5VrnJH/g9l3UzVM70hx7p
 sjcip0l8Pe5WVjvxKbimnmzefwlmdgIlpLf4WB/sTD/OHRxbZDUYNg9Zu4Zgm4D5kKc1
 Kyjt725rQYECY31dR458fun6auUiwsaFLrO5jVwVTzscbVQ2Gpq7d6ewHHzwbV1HZMzY
 Mk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784209503; x=1784814303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1tzuK126gkqzE7hk+EKhTwWZwCqY6OqCcP/3T5D6Xig=;
 b=fzP7tGCvNFXkP/NFUCmRePYz15PxHoJmyoKTIzcr+LtCS7swjjQgMY9YJJgs/6hRdS
 HXBiA9ttW8zR+vWVxF2+gFARo5X7RVSuI/fZkMo1EdXvmg2VoSlqzx7I8DMy9uRtfKYV
 Y1TIODlAdIfdGhpTncU89w6inx29poHyaTQ2vn8Oa4rGZZBmqaM7DqhLefPPYT/Okrja
 4VnRrUQt9A59pmRw+Fv9bYwtsUcl9h5bxUzpjs0qi2vDa9enw6VxfXht4rFwN+WEN1Rc
 5tCtVLltPRsFsbVHIfBKxPYDD5wygrhYsDiUnp67JA1vnrOLqiI7U+gyKJipvsWbGPiJ
 UsKQ==
X-Gm-Message-State: AOJu0Yy1BgV3R5QHJs/Sy6G969/Hx11Dm71MxU85JvHcsnCAaz3VcGyQ
 gOtkwWF8G3wvyuhFia+sP2xT+QJJjXSY0qmks8qzuepe+oY1JD8cflAy9toQXp6w4mTPtQ8KNYO
 m5lqI
X-Gm-Gg: AfdE7ckm8etIxKduJNXcWkwYwWjKWUWsS5fCy4X8etiQnFjx3kbKPjIDIb9k4FFA2t6
 yf8yVNic6u4dmfISYFTyxAbrIf7+yUyqkdYJo89pieVIpV1kbGTXMXurKq7v345OQbjiK/r4O38
 IuhJeeMoCb+Junja913q97CrEsuhRdfBwEV82vtPYrKmnep9rkeRdSDXSAvPYlpdlplkE3huX41
 f+ueAFQfjy2bhsIP1uj8Lu5VovcCldrE9/kDhalxAOBi6K3nFHxvF5l95NUxIEp0JU8fLhvKEdU
 ZAxduOm33h05Fvdkj6ppt7U+cOurLaUd1d/s97uTBXYTSi3MylFerXGCk1azR75yldT5Ax0GoZn
 DFEGeLK3Yxp/6PAYgqtNiqi5NlUrWnoklICamA1y2Q2VQjh2RLHDhl9u2umTqGQPIlNORWJbV+s
 1ryKocM0y6di5xnaMCYPFTyR3ScMQyGH7EzSm4N9OROTtM12WJ
X-Received: by 2002:a05:6402:1463:b0:698:87ac:33a0 with SMTP id
 4fb4d7f45d1cf-69e2e5981dcmr1009566a12.3.1784209503286; 
 Thu, 16 Jul 2026 06:45:03 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69cd2922f9esm4701659a12.17.2026.07.16.06.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 06:45:01 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v5 75/75] usb: host: fix up xhci and cdns3 after the resync
Date: Thu, 16 Jul 2026 15:42:45 +0200
Message-ID: <20260716134305.614278-76-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716134305.614278-1-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 16 Jul 2026 18:09:05 +0200
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

Adapt the xhci dwc3 and exynos5 glue and the cdns3 ep0 code to the new
API.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/cdns3/ep0.c         | 8 ++++----
 drivers/usb/host/xhci-dwc3.c    | 4 ++--
 drivers/usb/host/xhci-exynos5.c | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/cdns3/ep0.c b/drivers/usb/cdns3/ep0.c
index acff79ae1ca1..40282cbc3234 100644
--- a/drivers/usb/cdns3/ep0.c
+++ b/drivers/usb/cdns3/ep0.c
@@ -341,10 +341,10 @@ static int cdns3_ep0_feature_handle_device(struct cdns3_device *priv_dev,
 			return -EINVAL;
 
 		switch (tmode >> 8) {
-		case TEST_J:
-		case TEST_K:
-		case TEST_SE0_NAK:
-		case TEST_PACKET:
+		case USB_TEST_J:
+		case USB_TEST_K:
+		case USB_TEST_SE0_NAK:
+		case USB_TEST_PACKET:
 			cdns3_ep0_complete_setup(priv_dev, 0, 1);
 			/**
 			 *  Little delay to give the controller some time
diff --git a/drivers/usb/host/xhci-dwc3.c b/drivers/usb/host/xhci-dwc3.c
index 8ad07a4b98c9..1b2fa569ab01 100644
--- a/drivers/usb/host/xhci-dwc3.c
+++ b/drivers/usb/host/xhci-dwc3.c
@@ -51,7 +51,7 @@ static void dwc3_phy_reset(struct dwc3 *dwc3_reg)
 	clrbits_le32(&dwc3_reg->g_usb2phycfg, DWC3_GUSB2PHYCFG_PHYSOFTRST);
 }
 
-void dwc3_core_soft_reset(struct dwc3 *dwc3_reg)
+static void _dwc3_core_soft_reset(struct dwc3 *dwc3_reg)
 {
 	/* Before Resetting PHY, put Core in Reset */
 	setbits_le32(&dwc3_reg->g_ctl, DWC3_GCTL_CORESOFTRESET);
@@ -79,7 +79,7 @@ int dwc3_core_init(struct dwc3 *dwc3_reg)
 		return -1;
 	}
 
-	dwc3_core_soft_reset(dwc3_reg);
+	_dwc3_core_soft_reset(dwc3_reg);
 
 	dwc3_hwparams1 = readl(&dwc3_reg->g_hwparams1);
 
diff --git a/drivers/usb/host/xhci-exynos5.c b/drivers/usb/host/xhci-exynos5.c
index 500696ccae71..10c38af675cd 100644
--- a/drivers/usb/host/xhci-exynos5.c
+++ b/drivers/usb/host/xhci-exynos5.c
@@ -91,7 +91,7 @@ static int xhci_usb_of_to_plat(struct udevice *dev)
 	return 0;
 }
 
-static void exynos5_usb3_phy_init(struct exynos_usb3_phy *phy)
+void exynos5_usb3_phy_init(struct exynos_usb3_phy *phy)
 {
 	u32 reg;
 
-- 
2.53.0

