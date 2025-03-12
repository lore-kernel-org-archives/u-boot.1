Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F74C28B2E
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:16:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C581B8175D;
	Wed, 12 Mar 2025 19:15:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d6nlutK9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B91D81E02; Wed, 12 Mar 2025 19:15:44 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 554A381BF4
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 19:15:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ac2bdea5a38so29158366b.0
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 11:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741803342; x=1742408142; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tHT116vCKeG4wyEWNqWaIcaF7Fo83mkYUTV84EDrT+Y=;
 b=d6nlutK9wmE9snSk4fD6UMV0WuUbdJ2IuxDrvcleLreA/wEeqaj6d56BEL5gxeguMS
 1ig4yVKzE2OKDoXwSwpN7eHrR7d9hElhHnPOAZpWWK3CVh5dL7u6wFdmGPYWhhJiaL1L
 WcpfAZpcoZVCPviVxARuyfcOvFKA2gcsiW0OhzmCnjMrHQWGH7uEhCkOVBme2iaiP3xV
 r0IwEVczU5Ep+D6PACWeUAsonJQzLsITO7jANCNgcbjSDfq21dTjme6/C+Dq/w43tawk
 WZ1wIAMZsm0bxH+Fii+lHT/VyvL0dfXgL78tt4myftUnjK02xLYX/e2T0lZV39LPViPq
 BMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741803342; x=1742408142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tHT116vCKeG4wyEWNqWaIcaF7Fo83mkYUTV84EDrT+Y=;
 b=DhYLFN4NcdYq5pl458TMj6v8UAoBMa6RRjmUA5LadjD4ilAWBLfHflRE5pMgudJXVp
 jh3JttohRuUtMAb5BYGv81shrZK2KuvUFD38fH0s9AnWbI0oQutxR0M5jgd5brlqEFRl
 CQ8BtFmeyBAnj0JViLCTvATyCiTlvugUDnkE4UXYHwbDXm7RdErovwMyqMn58niVUxdv
 66slfcHlP9VZH1m2DE80eXN3EY6urV5+ZM0DlYeeLaBA8k/YNjNcx1DqPCva3sgnd7pk
 2UFZ5ZmeFIl6BGWhHC3ku0DItyZyh9cfhlvTMmnhKtqhyOIJKQPaa82HsSZkml7JfthC
 iinA==
X-Gm-Message-State: AOJu0YwNGJs+lZNx9pNjG87O9GLezF+g6m6IaVtkDfXD5ldKfuJ022DN
 1QdiEA/oK6//PA9iXf3YOXd11mznsf0oBhvuit10MsBTbp5JufiJ
X-Gm-Gg: ASbGnct08himWR1qyS0+df21OW1lZq1gNdcAdjRFyj81/QKkZKq5Bd1vkkOt/c7jyMA
 OQl9BD3oC4ghPHss05ayYTpvQ0oOxv7p5/pd7NyXREV2p99Jcn1upS8sxIdZFUQShJs4T2SmhEY
 72tld+QvG4Fv03J2+fHygJ53wVyjrxntQEPiJQsBYq+lDyreu+iXbILpWWUd+CctNmRDoiWqene
 0JXOxS89Uv3vFk6PzMMd+IkVby2qkXVy0hxoSNBz/iVtX1F97ftPonXSqk8yxlTu6BOX9/dzE9/
 GfwdLmGWi904j3Kniqeez8p6ztDSLKRfSXRq
X-Google-Smtp-Source: AGHT+IFXcj+zzWtkeM/Zwx55TJLp9LnUpSG6341i/AG8JPD8B9T+PN/ECVr+MqrvlgW0OqN1SI1ugQ==
X-Received: by 2002:a17:906:f593:b0:abf:777d:fb7a with SMTP id
 a640c23a62f3a-ac252fa0ab5mr2769791066b.46.1741803341604; 
 Wed, 12 Mar 2025 11:15:41 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac28c11561dsm641906666b.145.2025.03.12.11.15.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 11:15:41 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 08/11] video: renesas-r69328: fix reset gpio direction
Date: Wed, 12 Mar 2025 20:15:20 +0200
Message-ID: <20250312181523.121313-9-clamor95@gmail.com>
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

The reset GPIO signal operates with a low-active logic. The driver
needs to be adjusted to correctly handle this.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/renesas-r69328.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/renesas-r69328.c b/drivers/video/renesas-r69328.c
index 1147785c1e2..164285e3c8e 100644
--- a/drivers/video/renesas-r69328.c
+++ b/drivers/video/renesas-r69328.c
@@ -189,17 +189,17 @@ static int renesas_r69328_hw_init(struct udevice *dev)
 	}
 	mdelay(5);
 
-	ret = dm_gpio_set_value(&priv->reset_gpio, 0);
+	ret = dm_gpio_set_value(&priv->reset_gpio, 1);
 	if (ret) {
-		log_debug("%s: error changing reset-gpios (%d)\n",
+		log_debug("%s: error entering reset (%d)\n",
 			  __func__, ret);
 		return ret;
 	}
 	mdelay(5);
 
-	ret = dm_gpio_set_value(&priv->reset_gpio, 1);
+	ret = dm_gpio_set_value(&priv->reset_gpio, 0);
 	if (ret) {
-		log_debug("%s: error changing reset-gpios (%d)\n",
+		log_debug("%s: error exiting reset (%d)\n",
 			  __func__, ret);
 		return ret;
 	}
-- 
2.43.0

