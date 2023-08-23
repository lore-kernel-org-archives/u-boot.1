Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D05C27C40
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 17:59:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4762C86413;
	Wed, 23 Aug 2023 19:59:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L75vXMrX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DC1B864AD; Wed, 23 Aug 2023 19:59:32 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1ED786415
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 19:59:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3a84c94f8ebso433618b6e.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 10:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692813567; x=1693418367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7QvKF0w58BkAkWlkW4RwfJfNdOh1NDrxdBQUk8F0sd8=;
 b=L75vXMrXl11m3Q9mbSc1rhojGXNElU2u6eZEap/8sdSip7jMbmpeEysBMc8GlDDO3C
 0RpfkmJsee7zWPVCjl/bVCngpYxxx2bkXmmDdWi4fSs6OyvO+F6yGfqFgiXUrvTiqDtl
 ITj2HhBofBLHCH/jBJQ7vPo8tYdUgJ5Qbsg3djgdp2+Pq67qenevweGEtJz+Mhe1WECt
 rMvQP2OWjxVRzL0E0dLHP2wt0wk+a9wDpJBI7uxrVGbuew62YZZgh+beX80GQ64kSnZI
 6hXX8Jm1L0ryUsL7jQjLzgQm1GulvkBDogxqMsrS8PruLdDaI4Zr5TrcVrJFAId08gWQ
 AcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692813567; x=1693418367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7QvKF0w58BkAkWlkW4RwfJfNdOh1NDrxdBQUk8F0sd8=;
 b=dMjnFy7plq3Z13QaH03OAorTQ+hVqJ7JJ5kPrdbIqvBK+77yEND9BISTl5Xt+o8xGw
 JBCMxi/+J7+N/BxjyEnYixZCXqTL9tkiLC2JTBwJZCFE5RIgJBJQWCZbLNgiYEOA8Y1K
 8CyH9ZgG+e8DMPYk6XRQxePPic9mlNe12RfYKUVWK4qapLyRJDl2BO/18leIJGqN4oMT
 AB//N7JMG9mqA0kUbM8iHVLn6t33JaYESnnXY72CodTsEnzThrVHdOPcZbS9on3zN0jr
 mjBA4dn6R2oCcwARpHftINzmRlh+1w4g+VGR7qNPZFcca518ZvrpJ4IJWUhJWlAbkB6r
 eR1w==
X-Gm-Message-State: AOJu0YxXKvTqFeEV4ujCaJapK4ND0hJua9N/eVbvfetSID7wkidPiXr2
 Ct7TT+vdYCas6mnJdK5vkz4=
X-Google-Smtp-Source: AGHT+IHVQm5+pHA7+9MZ2Su1XCGuGaiNOgSZtJexRbp+pymshEwu0ENn9hMwsHdc7bjrwGlsjU2dmQ==
X-Received: by 2002:a05:6808:3192:b0:3a7:76d2:50f6 with SMTP id
 cd18-20020a056808319200b003a776d250f6mr14174149oib.1.1692813567210; 
 Wed, 23 Aug 2023 10:59:27 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:b51c:1cae:f70f:7819])
 by smtp.gmail.com with ESMTPSA id
 17-20020aca2811000000b003a842626b62sm5625271oix.22.2023.08.23.10.59.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 10:59:26 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: peng.fan@nxp.com, trini@konsulko.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2 4/5] thermal: imx_tmu: Fix the temperature unit
Date: Wed, 23 Aug 2023 14:59:10 -0300
Message-Id: <20230823175911.319414-4-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823175911.319414-1-festevam@gmail.com>
References: <20230823175911.319414-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@denx.de>

The temperature unit is millidegree Celsius, so divide by 1000 to correctly
print the temperature values in Celsius.

While at it, also change a typo: "has beyond" to "is beyond".

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- Rebased.

 drivers/thermal/imx_tmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/imx_tmu.c b/drivers/thermal/imx_tmu.c
index d2ea084d2d2f..b877ee36878f 100644
--- a/drivers/thermal/imx_tmu.c
+++ b/drivers/thermal/imx_tmu.c
@@ -238,8 +238,8 @@ int imx_tmu_get_temp(struct udevice *dev, int *temp)
 		return ret;
 
 	while (cpu_tmp >= pdata->alert) {
-		dev_crit(dev, "CPU Temperature (%dC) has beyond alert (%dC), close to critical (%dC) waiting...\n",
-			 cpu_tmp, pdata->alert, pdata->critical);
+		dev_crit(dev, "CPU Temperature (%dC) is beyond alert (%dC), close to critical (%dC) waiting...\n",
+			 cpu_tmp / 1000, pdata->alert / 1000, pdata->critical / 1000);
 		mdelay(pdata->polling_delay);
 		ret = read_temperature(dev, &cpu_tmp);
 		if (ret)
-- 
2.34.1

