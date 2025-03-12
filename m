Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9299DC28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:15:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D1628198F;
	Wed, 12 Mar 2025 19:15:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IAzRiu64";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3C6380017; Wed, 12 Mar 2025 19:15:37 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B43CF80017
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 19:15:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ac2bb7ca40bso27273166b.3
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 11:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741803335; x=1742408135; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hm6v7OznZRstx8O7vL+GPbaMszDPMV9+fC/Xrocqn+s=;
 b=IAzRiu64SyMTeWze8xnPKDe4cYkbNz6TM0vkMB0kf5xTnyPwrUpL/7iiG32uAcQCd9
 +P470BDzBO6JnMxUSZi/euFh+n2+NqQW9VXSvoDjUHjq+U1keGFlVLRHAu9Yt/T1fkL2
 rNNk2N0gH/1ljoyLXXUM3cDEQwas/Dc+8uzaEBa5s/duOiZXN1P5ffZyDb2tjfiNZfW9
 2ZmDOqYt1vkyrMdV26Gq7/s2zpVCExX9eryhIeurycg+ByDdUBPmKdZXpP4jFVHcXrR8
 woJbtz+3QwQy4HaynAJWooBDKC9KksJq7J9iaITsskbL312CUizsjyftCiVUGqHQFNj/
 2y5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741803335; x=1742408135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hm6v7OznZRstx8O7vL+GPbaMszDPMV9+fC/Xrocqn+s=;
 b=o8lfYAfbff768wNHwyvG0aNDoqdyJrQJqvwhq+KnkNFrDyd3Y02QnHe2AqjznlRTdc
 AGhhve7kLZubKLDzAEwVRYDFE9s293p6jWHGZ2FdOqjINjRRXBnl8mSmW4xWFPVMBsW8
 OtjfszmNNB+fQuopLs2yD1ldYBmjrwQHON40E0ceo2VQ7iKDJ634wjy8XdwtkkYizQK4
 vc3m89czN5GsQXHaLxAOWwItKifn2XFv6OigOK93uyBUzOezubr95V6hAWAIRrfE1ll3
 YDL6q4X6EfqrhNGwZe9mz2S7ENReRdtkqTDwX/NJVt6ibUeSy/RQ/DHk+ALaC9AnOGvL
 +dVQ==
X-Gm-Message-State: AOJu0YyF695gMXcngrGCen9R2K4roOF8QFzupngCaXFFrDOw39vE676D
 PO9b4hMzpl0lras9pIQbIUFucop8fv+v1KbV5dbevnnsZk618swr
X-Gm-Gg: ASbGncvN/vzuy+XCuhbiyIi5ujGlZz0vci3RTAQYIPxUWTPKpS8wKB1HnymrJk3Ly8P
 pdqBu0vhubJYRt4tyrtesbfq1aZWxEwLq9joPKp+p7XHFOzZyZBFnwHmbxvxHyRBHLodCwwAhwN
 CLYRcZK+xRIoOfPFEwKjBCkQJLMtZq5jAhzf8aUsFtMcpNumlQ9c/o9MDQmkORxL+OxSdcA9zyV
 /Gpc7vCTu0DSRkNSQWJbil3f1F56Hz4XxI7dfb5lTFea2eUz+H3YnVLvBM1s6+nvxskGzfvgrj6
 J+KrNO/7X8SIgMG5VwiD1G0/HkRC+zrcza9v
X-Google-Smtp-Source: AGHT+IGBIWkOMGWemS79VaA/ZYbN9M5EV2e9eG6cEuL94fRg8R7uKRPANtgv4Zv4BUx9t/3buF2kMg==
X-Received: by 2002:a17:907:9382:b0:ac2:7a3b:31ef with SMTP id
 a640c23a62f3a-ac2b9ea17e1mr954440866b.41.1741803335011; 
 Wed, 12 Mar 2025 11:15:35 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac28c11561dsm641906666b.145.2025.03.12.11.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 11:15:34 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 01/11] video: endeavoru-panel: move backlight request after
 probe
Date: Wed, 12 Mar 2025 20:15:13 +0200
Message-ID: <20250312181523.121313-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312181523.121313-1-clamor95@gmail.com>
References: <20250312181523.121313-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Due to the use of the Tegra DC backlight feature by the HTC ONE X,
backlight requests MUST NOT be made during probe or earlier. This is
because it creates a loop, as the backlight is a DC child.

To mitigate this issue, backlight requests can be made later, once the
backlight is actively used.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/endeavoru-panel.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/video/endeavoru-panel.c b/drivers/video/endeavoru-panel.c
index d4ba4d8b6da..90f838ecc20 100644
--- a/drivers/video/endeavoru-panel.c
+++ b/drivers/video/endeavoru-panel.c
@@ -117,6 +117,18 @@ static int endeavoru_panel_set_backlight(struct udevice *dev, int percent)
 	struct endeavoru_panel_priv *priv = dev_get_priv(dev);
 	int ret;
 
+	/*
+	 * Due to the use of the Tegra DC backlight feature, backlight
+	 * requests MUST NOT be made during probe or earlier. This is
+	 * because it creates a loop, as the backlight is a DC child.
+	 */
+	ret = uclass_get_device_by_phandle(UCLASS_PANEL_BACKLIGHT, dev,
+					   "backlight", &priv->backlight);
+	if (ret) {
+		log_err("cannot get backlight: ret = %d\n", ret);
+		return ret;
+	}
+
 	ret = backlight_enable(priv->backlight);
 	if (ret)
 		return ret;
@@ -136,13 +148,6 @@ static int endeavoru_panel_of_to_plat(struct udevice *dev)
 	struct endeavoru_panel_priv *priv = dev_get_priv(dev);
 	int ret;
 
-	ret = uclass_get_device_by_phandle(UCLASS_PANEL_BACKLIGHT, dev,
-					   "backlight", &priv->backlight);
-	if (ret) {
-		log_err("cannot get backlight: ret = %d\n", ret);
-		return ret;
-	}
-
 	ret = uclass_get_device_by_phandle(UCLASS_REGULATOR, dev,
 					   "vdd-supply", &priv->vdd);
 	if (ret) {
-- 
2.43.0

