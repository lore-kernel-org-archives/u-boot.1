Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E812CC531DC
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 13:50:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCC1688A39;
	Fri, 23 Aug 2024 15:49:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XpJ74JWW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44A9B88915; Fri, 23 Aug 2024 15:49:20 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DC4A889EF
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 15:49:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-428243f928fso20845935e9.0
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 06:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724420958; x=1725025758; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t6qIzHMrkEoZi8QUyqXpjxbu96j54T34fC2s8Z+8lnY=;
 b=XpJ74JWWM5vmkEfVEIq5H0O3Wq5nmAxZcaiteKqsLVWnFhuRKgX71Bwd2RxO2jVc8c
 VyFqeJHf67kLKFoz/wX4zuIdJzZyYFGaiVybIMWT4MO4J5k3N5vjHifwTUn46vzRBG9t
 xdJi3zYmw3wxJf9Gb/WnlGgTx45qIjzvugCsiJ4ZSdpryDObL8p9++34LMETd94gYFkw
 ospeYZAi4V11eU0V/N4yUyNdUnLBb0oKJSbT6z0hzOHaGKnK62CaqD8EqRPakk4yjmoS
 SnVKpLKZ/CCmP64xBkTaCzBnoT3nGrhexDJKegN4FIHam7k81feuI3DxvqTh+Jm8ljez
 4G+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724420958; x=1725025758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t6qIzHMrkEoZi8QUyqXpjxbu96j54T34fC2s8Z+8lnY=;
 b=sRvwU/nfSFRBF8o9C1KYr0zIreBWDnLEPVJYiStqlHO7ii2BtFZAAq6vItCLxerv7V
 F/6X0Y1/dv4iAyXyoksbnObP+nR04VTxPE/eWA8bMMalGlz8OIW6fJnfYFhM6wzX8QXy
 RCdvUdRvGDdTLNKUzt7C/cIAfcIlVlf0YLQ5UKgbHTahA6RMwU+15xLdiZQ1piX70Ggt
 mGSK6tYa0MpWW02Euk299NAN0YZFY8ejcMlFjfSZbFit/hBPSYPwGroX0RHFyZUgealk
 ORgZNRyZ+v8IMg0M1k8nvQO5dWmQzJXit3Rub/i0Zm8xdkmK40525f+bdkw2IUgLz6I9
 Vd9A==
X-Gm-Message-State: AOJu0YyQoDbgRxQ8lt4DpP3oms67mHRvE6PZMFd3qhfx3NhdmHPlLcu+
 BLWNvFi3uxBeJjgdV3647RKGo8TVm7r5m6yciYBOI3ppZ6t1JLCagLBR4GTucy5cNxA1fSFyq5A
 bgOmq5ffb
X-Google-Smtp-Source: AGHT+IFR7L0CP//JazFHt3fBwi50kQzlsrbzxmAyLUZ/xQL1zpCEvbGqx/JnmhV0AiQrhaYYnLQcEg==
X-Received: by 2002:a5d:648f:0:b0:371:8b49:f49c with SMTP id
 ffacd0b85a97d-3731184038fmr2504530f8f.5.1724420957615; 
 Fri, 23 Aug 2024 06:49:17 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:e668:dc94:35c7:8064])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-373081ffb40sm4201665f8f.76.2024.08.23.06.49.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 06:49:17 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Subject: [PATCH v9 07/37] net: phy: ncsi: depend on NET
Date: Fri, 23 Aug 2024 15:48:11 +0200
Message-Id: <66dfc851661d3b5e9e3a09142190f2dd3ebb4b3e.1724419624.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1724419624.git.jerome.forissier@linaro.org>
References: <cover.1724419624.git.jerome.forissier@linaro.org>
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

PHY_NCSI enables drivers/net/phy/ncsi.c which calls net_loop() and
net_set_timeout_handler(). That's the legacy NET stack (as opposed to
NET_LWIP). Therefore add the dependency to Kconfig.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 drivers/net/phy/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 73064b2af68..a9efc509814 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -368,6 +368,7 @@ config PHY_FIXED
 
 config PHY_NCSI
 	bool "NC-SI based PHY"
+	depends on NET
 
 endif #PHYLIB
 
-- 
2.40.1

