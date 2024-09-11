Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7EBEE498B
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 10:00:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B76D89258;
	Wed, 11 Sep 2024 11:59:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DTntYf4/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9069989251; Wed, 11 Sep 2024 11:58:58 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EDF789250
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 11:58:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42cbaf9bfdbso22445235e9.0
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 02:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726048735; x=1726653535; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/aZhjPOxUdNatWRE5U6jLTXqt2WXtbafXRW+DW+Zrno=;
 b=DTntYf4/rqVNUSN4c7E3zkTQVoPVa6m+Ln/j+KVNY1Ke47OU9MGJcfvg/j6NAgF3z3
 dnmH4ikBcVEGlD3bt+FVuUbAilEkXZfWr0BDDoTI45sXh1h/nBjIwKbbxYyAl6jjsrV5
 JSjb0YELcRXjmsaALiQPcknb9o3nd6MNHfn3Qj79n8sJG9Iso/vV2pC0hgS9jfAa6FFR
 +mGC/a3Odjz591/9CWB5MRNEHbJBoeCwu2yDhA+LIFxzY2bAY6hkhHo+QmipZmZ/DT49
 pxemOYZl9b6icuZJ5mDarOKcVpUFI/oCDpbt9HWUn90CJqscrE09jTNc3sHyA0LiMZbh
 FlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726048735; x=1726653535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/aZhjPOxUdNatWRE5U6jLTXqt2WXtbafXRW+DW+Zrno=;
 b=SU/9Gu63cTKGy294IDXmX2EQxbK92ES+3vMkvmX1v0ET8+hWYKiyjFBaZ/wMD1PtjC
 ls5+AL3acbAN2emCU+2UDF829a6XryQ85tKvJIZy1flfQoTjlmPGWQTIkhb0IwIiA8EI
 MFegfJDgRketengKVv3XRYOo8D2jJrgNEnOz0SCXrzqAvjRTwJ1hoEnmW+pJykIgv5qX
 pXQFEnS+2UYiPDYX2ZVecIJUy4m2oRyP0O02OemlIJrzMujDeWrKsdBGrQjzLrS3j0+q
 LqDCzdRX2ALjauYbl7PeOsTD2sdK2OYXdUM2Yt6yeIPu1o0Nr5QBFPPUTtAOUkaKhBVS
 b5pg==
X-Gm-Message-State: AOJu0YwwHeG1zzpuKN1/sgQ0NjuA4ppalWZJkCIkfF7hbcjRykxWdJiq
 4sefAgXhY5x2mOQkXu4NOG9vl7qA0aN9p7+FXpNrJRRvp4HcSWk0C62cAz/xs4pF9+a80SDDc3+
 CzyRYCfOi
X-Google-Smtp-Source: AGHT+IEigJ/QppwYHDcIOknKGncYKwJxp9Iub8ojwBNonwZtwDnrvjIKiOiZo0ChSDW1o4AgxycwkQ==
X-Received: by 2002:a05:600c:512a:b0:42c:b34d:720c with SMTP id
 5b1f17b1804b1-42cb34d7363mr84215625e9.4.1726048735444; 
 Wed, 11 Sep 2024 02:58:55 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:7d92:535d:cd3d:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37895649bafsm11300507f8f.7.2024.09.11.02.58.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 02:58:55 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Robert Marko <robert.marko@sartura.hr>, Gabor Juhos <j4g8y7@gmail.com>,
 Boon Khai Ng <boon.khai.ng@intel.com>, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v4 08/15] net: ftgmac100: depend on NET
Date: Wed, 11 Sep 2024 11:58:21 +0200
Message-Id: <d380f20107de4542adfc2bb51366b8c71c22b825.1726048404.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1726048404.git.jerome.forissier@linaro.org>
References: <cover.1726048404.git.jerome.forissier@linaro.org>
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

FTGMAC100 enables drivers/net/ftgmac100.c which uses
PHY_INTERFACE_MODE_NCSI, which is defined only when PHY_NCSI is enabled.
Therefore FTGMAC100 depends on PHY_NCSI. However adding such a
dependency causes a "recursive dependency detected!" message, so
add a dependency on NET instead (PHY_NCSI depends on NET).
All in all, either the stack is NET and FTGMAC100 can be enabled,
or it is NET_LWIP (or NO_NET) and it cannot.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 drivers/net/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 6ed325517c0..e7d0ddfe25a 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -468,6 +468,7 @@ config FTMAC100
 config FTGMAC100
 	bool "Ftgmac100 Ethernet Support"
 	select PHYLIB
+	depends on NET
 	help
 	  This driver supports the Faraday's FTGMAC100 Gigabit SoC
 	  Ethernet controller that can be found on Aspeed SoCs (which
-- 
2.40.1

