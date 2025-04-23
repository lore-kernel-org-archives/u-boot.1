Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE1BC369D3
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 08:43:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C7C2810EB;
	Wed, 23 Apr 2025 10:43:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bmoHjVbE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B91A80FDA; Wed, 23 Apr 2025 10:43:01 +0200 (CEST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E783D8082A
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 10:42:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sbellary@baylibre.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22c336fcdaaso67870845ad.3
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 01:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745397777; x=1746002577;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a/k3qcg3NXWLNpC+dxBUR02rXS6WOuB1F3mrmZ1BD3w=;
 b=bmoHjVbE+wi0xTpFFvN9V3Gnsox/XHopfhoQtS8WGsWhT706JyKB0aHdZMC0BI9Vql
 alXAPwdxdeoH4FuqA32kFrpmIc6uH6D7zRLzqjwsVqqzFfidWcTxO24mitm6MuMLCqkO
 tg2P5S3RH/MuQ52dbifBiecDkk10Gurld+P47SNMwQ2QqGw6bkK42gabH86Nvc0umhzA
 Fo/5x07qwk7T1FhfUiOVR9Lr6dRR7qMr9IFUTVgniUSc1/8l375L9mhK7Coa8LnONKa3
 +xhESKskHeSruOwD2AG8xuw2Qv679edgz4xVguNqS1p3bP6jAoFbYWpRNOVAhWTCegrv
 zQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745397777; x=1746002577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a/k3qcg3NXWLNpC+dxBUR02rXS6WOuB1F3mrmZ1BD3w=;
 b=gJq+G6FpJDxAzp5idKp3cKw6QCmQ20FY8V7er+cMmRHd7sqA8z3qaRoGFuhAd/0Sjk
 oGYkYZpU8K4xhyXfq6rb3r+ACBR8V3fPSgw+3fDSriG7B6Yg38Uq+LyoRQUoCaU23nu1
 gJieTmYXbznz6Ghp4tZ/JtudOXwufRtYZA3qPM3vyFNB2Np+8D0dtjU8xaIICLqsmChc
 blLvRwxkQIuzjcyvK2Svi5X9tUo6qETrWGrerRzc3G/bdFZUclGqC6QTlD1raxHKPu5T
 dB6vMLtyhgwq3BUb4/ZFQs76Og0LelWYTFj5cm0N6NFSFAnZTGIvjK/Ldj6fO22yns05
 oIvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZ0DQRf8wZEVkhSsqjjk4Fi+EJh8qFm/vdbnVcgM01Qzt8jr6DfCVdkad4K8vKod9OxBrGLAo=@lists.denx.de
X-Gm-Message-State: AOJu0Yzcw0znVGY8gbWxV/NWTo6fIkJBRNgYseyAm+vcaqmm3CU3zk2e
 K+QNwsYcXflgoUIqsSK3uMio52fwwSuQ6OQ62P63+zu8DDKix07TrbtSyuk7Fv0=
X-Gm-Gg: ASbGncvCsTUr4gpRECPZvqFLoviWNzXirvtv8tbMbBk4W0WL2CNLXFGymu5JN7HIJHF
 KsPxElL44dlpPK4fL+HMCfFSMd5Tg3keds+Pblrgv5Yjfpov1ywF2o0Oewf0keBtJmL3hFs5I98
 qwb+DQ/yk95Maj/Pg+yNwEITfewJ6XrR9J0ovCAnoErEde5KCukPQl/+xFvZ4mQfsI594k6ql8Z
 zHneAeb83RCfSU8ryh3j5CEQ9JBDBG7ceX3ltHl8EQIu+rRK3uEoHVGl2DS5kaEEDMIdxy+EUUg
 wFYuSgRtarupfIFSYa+rnNHJKX765nVLkvB61VCsYF29e/YUXjnA5mwC4Rg4jSJja8HiCKqYcyZ
 zEoYWebjqGm44sg==
X-Google-Smtp-Source: AGHT+IHmD7Xgq13QdLx+dvZ3Hc2G+uMqy8f4KB6nka/rHpBjwbWanL7D7K9C97B4qjZd0z5RQeeypg==
X-Received: by 2002:a17:903:28d:b0:21f:507b:9ad7 with SMTP id
 d9443c01a7336-22c535bf895mr288758975ad.25.1745397777507; 
 Wed, 23 Apr 2025 01:42:57 -0700 (PDT)
Received: from dev-linux.. (syn-076-088-115-008.res.spectrum.com.
 [76.88.115.8]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdae69sm98860085ad.1.2025.04.23.01.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 01:42:56 -0700 (PDT)
From: Sukrut Bellary <sbellary@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: Sukrut Bellary <sbellary@baylibre.com>,
 Kevin Hilman <khilman@baylibre.com>, Bajjuri Praneeth <praneeth@ti.com>,
 Raghavendra Vignesh <vigneshr@ti.com>, u-boot@lists.denx.de
Subject: [PATCH 2/3] pwm: ti: am33xx: Fix build warnings in dev_dbg()
Date: Wed, 23 Apr 2025 01:42:48 -0700
Message-Id: <20250423084249.197101-3-sbellary@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423084249.197101-1-sbellary@baylibre.com>
References: <20250423084249.197101-1-sbellary@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

If CONFIG_PWM_TI_EHRPWM is enabled, it throws the build warning
in dev_dbg() due to incorrect format specifier as,

"warning: format ‘%lx’ expects argument of type ‘long unsigned int’,
but argument 4 has type ‘fdt_addr_t’ {aka ‘unsigned int’}"

Fix this with the correct format specifier.

Signed-off-by: Sukrut Bellary <sbellary@baylibre.com>
---
 drivers/pwm/pwm-ti-ehrpwm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-ti-ehrpwm.c b/drivers/pwm/pwm-ti-ehrpwm.c
index 563109ef0f80..135ea3b43212 100644
--- a/drivers/pwm/pwm-ti-ehrpwm.c
+++ b/drivers/pwm/pwm-ti-ehrpwm.c
@@ -399,7 +399,7 @@ static int ti_ehrpwm_of_to_plat(struct udevice *dev)
 		return -EINVAL;
 	}
 
-	dev_dbg(dev, "regs=0x%08lx\n", priv->regs);
+	dev_dbg(dev, "regs=0x%08x\n", priv->regs);
 	return 0;
 }
 
-- 
2.34.1

