Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA37C87FCF
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 15:11:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D647783F8A;
	Mon,  4 Aug 2025 17:11:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Na7IZvU0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FB3D83E16; Mon,  4 Aug 2025 17:11:42 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4102083F58
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 17:11:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3b78310b296so2743882f8f.2
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 08:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754320300; x=1754925100; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wTuQU9lTLV3D0fl9PJLUM4cqSoflMCtZ9qTosYW/1JQ=;
 b=Na7IZvU0h/IRHNT5XWYrGoRQalzomlvZQ2ALlZEd4l6cGOdbnJrmIvKOq4ZzSFAiUJ
 3ehr44BjPwqBIgI31B50PnEv0eM9JvuCAYBxayWGRSkZp8bzdajLSDtWz7K8eVkkXeUX
 dlpwa0ps59gjc9BVOBLH0oBbwB/MVjiBRfi8kKk/Guf1YyvTSzBFiUeHmDsehXw1mqh+
 vigOTPXxlb34ONXBZL8+vJE0PlUodbKESY5s6Y/vd7V5VFYPeGGarggN//uIiKxIVLMk
 3CKAsN2JGaPoHUDxmbVvhbaRJkPLwniH7aUgbAcv2DtcEZABdUoiCyRerBAbaSI0sCEh
 QKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754320300; x=1754925100;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wTuQU9lTLV3D0fl9PJLUM4cqSoflMCtZ9qTosYW/1JQ=;
 b=oTGhdP7W6nQ2fcAuEJYv9k1X4odqzhVHBfmVBOU9KOERd0gK2voml/9rRMUuzGDGEc
 ZgVX2HZMSxQ4jEtffMkRz8Jyo7Swq4DV5a73VklK/C0OZ2wG89ndZ7tLXp1yx8MjkCGa
 2ywEwojSaH0E04tlKQmmJZXl/3ID3xBwvwFNUP3h3Ogg8508p2PHMb65c7YNGWLqdZIP
 +7GKaUIzJ49JnQemQW4oktLtjWetND5bY/V1q/2VYnSzcHD9VbJcVN3SWqlE0WMF99A0
 PUWAAJfOaNxnJkWTH7MvWiXJk3f0SaNiWMyLAABFebosCT+D5Etf6dHGYGUHXnFvH4RL
 /qVg==
X-Gm-Message-State: AOJu0YytnvGhdxxnMBu3TU5K/LAM0iYhlBQ1xCx6+hPEMSEWDrmpeSrn
 XCKXwSwXeJIE7nE0X36VhVGtsAKJKpyrDM5ihUeIis0xfqRS24ZnS9e6GJxJ9Yn4UHA=
X-Gm-Gg: ASbGncvaEI2iBCxRsw9Y5duO1KT86Tyujetd6zwQGpfq5Qboud1SWY+14boORM1S3qU
 ROS3njMYO5P6uIDfDDD78PKvqchYAbBudrI/Jv3WbQqZLanBaEWLRzR/2c8r7hHfLO7xwKf5wnq
 HX4Y49mmy8zyLZVBSj1w9LQYPKRpX9VdwVMSIiGYB9foqZ6giQs5KMe5914bqfbDAcIHehiVPNW
 D4wX4JEumCwP6t4yw8D8CJMbn0VRwS8WFo1HZAqOMk4TzgAvRAQIcJMoelDPX0y9MNFefVbqLdr
 8LJpnSd9i4WmJLNdjYzOqWnxQxOeQr1NjYnAVYBn+rm9hMVFCDw+G74hmCDFh44hpxSDUbMSRXb
 vFUDWYFpDBeaPcrLkkOkiaSdR/qOo56/NNBmjzeZ5kqcvInmgvgk=
X-Google-Smtp-Source: AGHT+IEm/rBeBM09LiWUM26LFDqMjd2q4nhiXWNwTeQwfMoeqAr2Qml1dVr9B4oiogCl7Cg15z3vHA==
X-Received: by 2002:a05:6000:2b11:b0:3b8:d4ab:fa25 with SMTP id
 ffacd0b85a97d-3b8d94ca025mr4689691f8f.42.1754320299491; 
 Mon, 04 Aug 2025 08:11:39 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:1ba5:34a9:feb8:a948])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458b866392csm63586455e9.2.2025.08.04.08.11.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 08:11:39 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 04 Aug 2025 16:11:37 +0100
Subject: [PATCH 1/2] net: dwc_eth_xgmac: Use unwind goto on error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-dwc_eth-v1-1-d2a652a69fcd@linaro.org>
References: <20250804-dwc_eth-v1-0-d2a652a69fcd@linaro.org>
In-Reply-To: <20250804-dwc_eth-v1-0-d2a652a69fcd@linaro.org>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In xgmac_probe there is a direct return after the point where unwind
gotos start to be used to undo actions performed by earlier code. Use
the appropriate unwind goto instead.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/net/dwc_eth_xgmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dwc_eth_xgmac.c b/drivers/net/dwc_eth_xgmac.c
index 03959ea95a5..d29d871ea8c 100644
--- a/drivers/net/dwc_eth_xgmac.c
+++ b/drivers/net/dwc_eth_xgmac.c
@@ -1102,7 +1102,7 @@ static int xgmac_probe(struct udevice *dev)
 	ret = xgmac->config->ops->xgmac_start_clks(dev);
 	if (ret < 0) {
 		pr_err("%s xgmac_start_clks() failed: %d\n", dev->name, ret);
-		return ret;
+		goto err_remove_resources_core;
 	}
 
 	if (IS_ENABLED(CONFIG_DM_ETH_PHY))

-- 
2.39.5

