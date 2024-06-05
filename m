Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4960CC25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 03:27:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C02E88353;
	Wed,  5 Jun 2024 05:26:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DU4EcThK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0C5A8834D; Wed,  5 Jun 2024 05:26:46 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2ABE88348
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 05:26:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7eb3a84d7a9so30369339f.0
 for <u-boot@lists.denx.de>; Tue, 04 Jun 2024 20:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717558003; x=1718162803; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NR0x9vQRdE3oDY4vc9ChwdE89C5zggcLj16gc1fwFd0=;
 b=DU4EcThK0Oteh841CN1NpuupexY5RUo7nSdXp7JUaQtDaW4coKMDBR9z7ustMyBlom
 CYuosrsnmNUHHeb06cqvR/EZb1bnCijG3SELwZZk4KX9RvX22OxQPDyawlJPYMQys0xT
 En2NvLzQXU6FoNqgP3UaXSqwP3xJidvuz6cac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717558003; x=1718162803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NR0x9vQRdE3oDY4vc9ChwdE89C5zggcLj16gc1fwFd0=;
 b=jIDKFBZdITk3SJPA7/1OytTxumPE0JNG5hA65U+ziz2NVcPnHLZnL4Wv8+mk/91E96
 WNchPrOf8icLk3aXZj2362YHxwMhgecNo3xiWuKvUQKO7dDV0YTw7iB2G8GzveE1Ax0E
 NIwLDzWYvZU/FMBbdfBv5fxZlzifvMYHgHB0gUq8K5o/voV0Af5SJ/lRb38upttCCxWm
 d7GNoZzDqA3FNGRd42IV+/DrT2KgLbzym9Io8fGxumCEqgNzSlPKVVSN5dL+k2Q7NgXm
 pn9ZY+f+swsFMr0gf+gQkrpUgj87Y9d1AeLmU1dwjyFTYTm7/JnOtXqhEwnVTx6cOMqh
 YTGA==
X-Gm-Message-State: AOJu0YyxGmZ5475S8A2Jp8CmLg9ZoNPp+pI4P3u4JttrveCdcc22/mrN
 1h99pW3QabMgEjjdcQcU2x+czGFum/KUNysXF6aXHNcHTXJV6N2yJEIs6t1PzCDnZMH+/FWUKic
 Jww==
X-Google-Smtp-Source: AGHT+IE8FIIzRgmktOm7eZhw/odxwMq5rewD1nFDo5bQiJKnFBB+YlEQV3RWX2ss81/hmZxiKyDmCw==
X-Received: by 2002:a05:6e02:1c2c:b0:373:7f12:bc20 with SMTP id
 e9e14a558f8ab-374b1ef3017mr14351505ab.9.1717558003429; 
 Tue, 04 Jun 2024 20:26:43 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-374af0e3ef1sm3691495ab.34.2024.06.04.20.26.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 20:26:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jonas Karlman <jonas@kwiboo.se>,
 Joseph Chen <chenjh@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 William Wu <william.wu@rock-chips.com>, shengfei Xu <xsf@rock-chips.com>
Subject: [PATCH 8/9] regulator: rk8xx: Fix incorrect parameter
Date: Tue,  4 Jun 2024 21:25:20 -0600
Message-Id: <20240605032521.1142768-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605032521.1142768-1-sjg@chromium.org>
References: <20240605032521.1142768-1-sjg@chromium.org>
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

A recent change introduced a bug whereby a PMIC device is used in
place of the regulator device. Fix it.

This fixes a hang after 'Loading Environment from nowhere... OK'
on chromebook_jerry

Fixes: f047e4ab976 ("regulator: rk8xx: add indirection level for some..")

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/power/regulator/rk8xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/regulator/rk8xx.c b/drivers/power/regulator/rk8xx.c
index 1bd4605d43a..bffc5d2dd65 100644
--- a/drivers/power/regulator/rk8xx.c
+++ b/drivers/power/regulator/rk8xx.c
@@ -1240,7 +1240,7 @@ static int ldo_set_suspend_value(struct udevice *dev, int uvolt)
 	int ldo = dev->driver_data - 1;
 	const struct rk8xx_reg_info *info = get_ldo_reg(dev->parent, ldo, uvolt);
 
-	return _ldo_set_suspend_value(dev->parent, info, uvolt);
+	return _ldo_set_suspend_value(dev, info, uvolt);
 }
 
 static int nldo_set_suspend_value(struct udevice *dev, int uvolt)
-- 
2.34.1

