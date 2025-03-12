Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D37C28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:10:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9AB281DD4;
	Wed, 12 Mar 2025 19:08:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cU2KxuZw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 973DB81D27; Wed, 12 Mar 2025 19:08:22 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2D1B817A5
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 19:08:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5e6c18e2c7dso91492a12.3
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 11:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741802900; x=1742407700; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0H5x8ovtosa95B92FkhvCVl4OcNkPeMbUdAIfexMGY4=;
 b=cU2KxuZwiTAo2QrlBgEf8gGirJqrbnEeL5EoruzYj5q4FERBIPzvRm0yybfm92xGXw
 w0fi3QsxqKwwfpV8bYj7PWug1RNPTSbr/IP+K7jkU3lt7u6B6nb5Mx0WDXJNy0UYRD4N
 gRcQZauKBlRZmzwdd9qu+ttx/YabZIL7kh7u7hYVckGuaR2OZACrWoCVT5n5J+GLSZT1
 OyA5fMzVimxhvugGqxXNWOADyISdB3QmtiKrijJ2q1VqK/vbyBK9Q7kamo0ydkJOy26v
 1nBsiQB+Fng3JPoDEPCWblgdcwtz/xy3wMb9R6ZLkL2VbqzwKGpWBuFQ6pusVeIR8bfJ
 tg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741802900; x=1742407700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0H5x8ovtosa95B92FkhvCVl4OcNkPeMbUdAIfexMGY4=;
 b=iCjT0Y0pm8Cm/DJZV+ieisF6DQl6AhNS+tRYelTjUozGMQfe304mlXkCl8JBmgMNX1
 H/ogDWB4JUMlnAyN64v5JBmSSV2njGixf3iU4aYVUijvLhYTYtMIr2EIw3WJA1wJiOWL
 5AHiWgLvAtaPYB5cftWErfImLFuTgv96k+V17lpc0QUqwDobfne60AR0RrrPGfuX1QC8
 AEuhRgZXMWHb70y2wjpHL5GvAuMgvbbD1Rz5AUnVewmxsEq6mUz9lywazxOWoPO7pL5v
 /eyoXMOoABhgfIJKYfg8Ar7BjB2JD3MHTZ29CAp0bmnZPsrF5zwRyGChb2p1uW08qqAY
 Rb9g==
X-Gm-Message-State: AOJu0Yz4B76+YmZa3BrkObcm5Pu2t4kAYhUSRPVpOCiXhNIp2svoOhfW
 SGuxyjSyYKi67giLvuqQ/fvVt2VQxNazA9+5S6VzClvNK0BYVa1C
X-Gm-Gg: ASbGncu5Ex1KzGhb0Kx2ZoBDhUXRKxQtFNnWkbgEokdnzW38Q2N/bIBPswsQq3thvC9
 eZqOVhAsRoyIjzQorJrUAgPKSlX0n0ZUpdrLPSE764BCwUZza+qZDvdyzkB494kRMxawwOvbqvE
 wZb0cL029rnI23aiBeRlyqdc3AZpeehxQoAZQ+3MBSCvbYowIagBFysXaKzOYR9AYo0NR2w5T2Z
 du1esOXJ5tfJfgqWkHp1Uqvf5m7T+IlPu+x+xamsGcVlGdoipBo1ra3MCp1ugW53HFcOZC6TT1N
 YBx3LehHZjlmj/kMlcwiKIj6zS1Hw2jVGb8J
X-Google-Smtp-Source: AGHT+IH2PxAE+UdZb5+GWzihdQ295m8imHwRTEGxhVVynmMH986vGznJSLYKlPLIrWHuNDdAT5MBAQ==
X-Received: by 2002:a05:6402:4020:b0:5e5:ea02:1230 with SMTP id
 4fb4d7f45d1cf-5e5ea021550mr32795744a12.28.1741802899972; 
 Wed, 12 Mar 2025 11:08:19 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e5c733fcd2sm9971635a12.2.2025.03.12.11.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 11:08:19 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 13/13] video: bridge: ssd2825: fix reset gpio direction
Date: Wed, 12 Mar 2025 20:07:54 +0200
Message-ID: <20250312180754.120946-14-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312180754.120946-1-clamor95@gmail.com>
References: <20250312180754.120946-1-clamor95@gmail.com>
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
 drivers/video/bridge/ssd2825.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/bridge/ssd2825.c b/drivers/video/bridge/ssd2825.c
index 2a49b895404..a307993377c 100644
--- a/drivers/video/bridge/ssd2825.c
+++ b/drivers/video/bridge/ssd2825.c
@@ -471,17 +471,17 @@ static int ssd2825_bridge_hw_init(struct udevice *dev)
 	}
 	mdelay(10);
 
-	ret = dm_gpio_set_value(&uc_priv->reset, 0);
+	ret = dm_gpio_set_value(&uc_priv->reset, 1);
 	if (ret) {
-		log_debug("%s: error changing reset-gpios (%d)\n",
+		log_debug("%s: error entering reset (%d)\n",
 			  __func__, ret);
 		return ret;
 	}
 	mdelay(10);
 
-	ret = dm_gpio_set_value(&uc_priv->reset, 1);
+	ret = dm_gpio_set_value(&uc_priv->reset, 0);
 	if (ret) {
-		log_debug("%s: error changing reset-gpios (%d)\n",
+		log_debug("%s: error exiting reset (%d)\n",
 			  __func__, ret);
 		return ret;
 	}
-- 
2.43.0

