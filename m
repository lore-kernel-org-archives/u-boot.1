Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BBFEEE498A
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 10:00:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93A498926C;
	Wed, 11 Sep 2024 11:58:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hCeTzT43";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3631389256; Wed, 11 Sep 2024 11:58:57 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 533F18923B
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 11:58:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42cb6f3a5bcso40871005e9.2
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 02:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726048734; x=1726653534; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8i3lBROvhfrY82vIccP41xA0yhZbBOfEI92vYpX/wGs=;
 b=hCeTzT43HA+a1PfRqaqdJAj/J6kf7PpPHDEM36wMMvTh3lBPLq/SQnL2R2b0dYo5bF
 OGsxi7yEEXrxlDuUgsOfTiqlNKE5xIVif3YSI5yh9eokcmqoOevl6VmYnQTGIyI+hWFG
 OqKsTYWn3D6RV71D4XXZAv27jMttDkST/o+nIX15+s3eb4a5pMc/H78zsIeaA99pc/5j
 rv6zmCELZcjZHwGi9oF80eHsIX/gP66K2DSvZa9cOWczaBqiLSqtAIkmoHrQGerWdOjS
 Vab+qJ8igYdlJLjm7xTnpVplVC+9zVR8HHRso1sY0doushBDmUhnlsi77gMQLOXC5dvR
 UlnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726048734; x=1726653534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8i3lBROvhfrY82vIccP41xA0yhZbBOfEI92vYpX/wGs=;
 b=gIFtcNtjGK6PD2bADb+D2Pun0qUhKEoB8EJ5fSrVVnIfTw5+oZ0hAfFQMQ7NN3L0nf
 LPs2n1if8hZ5tJbU7haNDW0jVIwMvkakp5cZCCzJwErH5jZ6CAeM6hOnxof3eUU169NN
 a0uUaNt637fIE7ADyuLpXb9O7SVdFQBWgUEFAxIEglJ7E4jkSVHMZkkdI7oBsmQqBXse
 yrCIxD42MszROUs+2gsLTWlBSNoia9v2tNNs+lvyvhzm9oAeqDKNTFYeOKmjJD/9r0pi
 zmjsRpJeUrdJprJgO2A+qNjNFjdLj6ilHNJHn3dQp9uWK3gWT7r/5B9hwMfy4sf6T1FP
 iYQw==
X-Gm-Message-State: AOJu0Yw+/h8qxW8KcdiaV+JW5XRgAPBOHPEGvE5gAxB8HgFpkGfz63sQ
 9VP5CZMTflAhu3aBANBx8nJOxORpQgPlmdUffHmHEx5KhfpEbnbgwQgIb0RFwnwIp9nQ0bMeia2
 ahePL+g==
X-Google-Smtp-Source: AGHT+IEOanyWiaHqcekbxG6MBbqeamRJNQ6rKPdCMO7MlMDcyGn2I479gNsWWM3SA/uZAY8IefhFBA==
X-Received: by 2002:a05:600c:548e:b0:42c:c401:6d6f with SMTP id
 5b1f17b1804b1-42cc4017032mr48157255e9.16.1726048734541; 
 Wed, 11 Sep 2024 02:58:54 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:7d92:535d:cd3d:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37895649bafsm11300507f8f.7.2024.09.11.02.58.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 02:58:54 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v4 07/15] net: phy: ncsi: depend on NET
Date: Wed, 11 Sep 2024 11:58:20 +0200
Message-Id: <de9f791bc516c5d2ed50a250589e357e77a94355.1726048404.git.jerome.forissier@linaro.org>
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

PHY_NCSI enables drivers/net/phy/ncsi.c which calls net_loop() and
net_set_timeout_handler(). That's the legacy NET stack (as opposed to
NET_LWIP). Therefore add the dependency to Kconfig.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

