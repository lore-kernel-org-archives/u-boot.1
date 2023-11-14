Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F52C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 21:11:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74CF286F6E;
	Tue, 14 Nov 2023 22:11:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JDV5WzWL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82CF286A4B; Tue, 14 Nov 2023 22:11:32 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F98A86552
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 22:11:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=knaerzche@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-53d9f001b35so9242383a12.2
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 13:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699996290; x=1700601090; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JnQeqieilFpw0apL4bF6PV41+UV94MsoTr5//JRu6aQ=;
 b=JDV5WzWLy2kbJjJa4HfiwQ4JPx6thS0GRt9j7/uLvk3nnzRjTlNS6EVrHyUUCDQcVi
 to01iyrjOCDcY2JnJzvQZItxmtPFuEnFwRpZbEQrrF2ct9X9Rt+QncjfTU8nyVWcPyVU
 YgChjSX9TzVbj6zdWe+FIogwRMtIMoOTNkb9PyOlGEm1PTpfvg3vh+jlgcTIbgyfvn+D
 zhJkgp5HWYiREfccyZ49Nx8QYa6rVPoi2WalBEqGUTx9LZ8Syer0PnUbPiuLEHvBFI7u
 0gdNsHN9Kxs0Rqvo9gi1tDLEzbep2iblVPa+dwWhu0SKaLZPLuP68/ZetHBdjcorNsSd
 bI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699996290; x=1700601090;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JnQeqieilFpw0apL4bF6PV41+UV94MsoTr5//JRu6aQ=;
 b=Q6bY8lfmU8wevFl81RhaIUUd8D10MGdXcuMhU7e410VxmH0pfbZzC6P5spYwYxhiCe
 X5z/To0mxdQcSl7zMEVtmw1mndqvyo6e8Myt2r/t7T/cXX4fYLbBWSBpOEu67xs29EYc
 kkRF/bEBNjXf1lk5iTUu8xwgW6I5oJE3FFfy49fFoVG87rh7kSfgqQst4rUClzovCMoy
 LE10cn5sJ2YpKKno7nKp4ttw5nmoFhHg2S6zmZieJBCgK5Js56vNDARF0Nyb01qTf5lL
 aG13G8uGU52sk1d/E7kcTLImTLz3SeKLmruqZRj4EgreUWPRK7l1/BPdgyiBG2w4hS+d
 3eTA==
X-Gm-Message-State: AOJu0YwK7tpIrgOgeisC3xyAtAudm2+1qJaTt7CHuhSjtjAEKkGJbPoZ
 cAMqthmJ5w5BjKpYHesGaslHJhBEVA==
X-Google-Smtp-Source: AGHT+IF4Wzbj6c0om73xm1YpLNZSqy/eX561StMZA9ffYkk/fKmtPKuYmx+x+gHVp7fIljRbGyHkNw==
X-Received: by 2002:aa7:d6c9:0:b0:542:d2c4:b423 with SMTP id
 x9-20020aa7d6c9000000b00542d2c4b423mr8067473edr.30.1699996289615; 
 Tue, 14 Nov 2023 13:11:29 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4310:aa7b:eda2:461e:e1fd])
 by smtp.gmail.com with ESMTPSA id
 p19-20020aa7d313000000b0053deb97e8e6sm5539403edq.28.2023.11.14.13.11.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 13:11:29 -0800 (PST)
From: Alex Bee <knaerzche@gmail.com>
To: Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Ovidiu Panait <ovpanait@gmail.com>
Cc: u-boot@lists.denx.de,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH] timer-uclass: Always use "clock-frequency" property as
 fallback
Date: Tue, 14 Nov 2023 22:11:27 +0100
Message-ID: <20231114211127.52443-1-knaerzche@gmail.com>
X-Mailer: git-send-email 2.42.0
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

Currently the "clock-frequency" DT property is only being considered as an
fallback if either there is no clock driver, the clock driver implements
the request-op correctly or there is no clock defined for the timer at all.

This patch makes "clock-frequency" also being picked as a fallback if
getting the clock-rate fails, since clk_get(_by_index) will return no
error, if a clock driver does not implement the request-op and does also
not support getting the rate of the clock in question.
timer_post_probe will take care if the property does not exist in the DT or
is defined as 0.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
This is currently an issue for Rockchip RK3188 and potentially also for RK3368:
The clock driver does not implement the request-op. Even if we would add it:
timer-uclass always picks the first clock and the DT bindings for Rockchip timer
requires us to place the pclk first and and the timer source clock second.

 drivers/timer/timer-uclass.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/timer/timer-uclass.c b/drivers/timer/timer-uclass.c
index 0c2018bfe3..60ff65529a 100644
--- a/drivers/timer/timer-uclass.c
+++ b/drivers/timer/timer-uclass.c
@@ -66,13 +66,13 @@ static int timer_pre_probe(struct udevice *dev)
 		err = clk_get_by_index(dev, 0, &timer_clk);
 		if (!err) {
 			ret = clk_get_rate(&timer_clk);
-			if (IS_ERR_VALUE(ret))
-				return ret;
-			uc_priv->clock_rate = ret;
-		} else {
-			uc_priv->clock_rate =
-				dev_read_u32_default(dev, "clock-frequency", 0);
+			if (!IS_ERR_VALUE(ret)) {
+				uc_priv->clock_rate = ret;
+				return 0;
+			}
 		}
+
+		uc_priv->clock_rate = dev_read_u32_default(dev, "clock-frequency", 0);
 	}
 
 	return 0;
-- 
2.42.0

