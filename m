Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 647CDC531DC
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 13:50:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2959988A99;
	Fri, 23 Aug 2024 15:49:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cW2w2u0j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 683E6889ED; Fri, 23 Aug 2024 15:49:21 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 707AC88A29
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 15:49:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3730749ee7aso1111114f8f.2
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 06:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724420959; x=1725025759; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JMKR9bGfM0t7gPRNHqzFhAKLlfcdWZvsACjtC+GS4O0=;
 b=cW2w2u0jof9XesCghFIF6gnMmNf/rPtGU4jfDoE9UiOwtd6Hp+wiiy8Jm9oINn47NN
 fPn7PIAALtHiTJIHoTHFIjSeXuZWk2IJ1xCBxFlWW6/Uw3l86hbz3cyMgFgmLfUNAhNA
 i+GhvwUSjckG7rp3FRAy7xMgIWfStEr9AnjFXu3y4DsjCf0d0IoTCC0zqE6FYKhxHkp+
 Tm0seB4mFGjWzWznE9f4k/5ehKZq5qBzH1nVYVPyxXsWnaT/ti0vim0jpfdoN7nGlNbV
 RpGDHRE7Ih6RMKZpsIEGPeV2wlwAzaxVuHLJRQJncMDquOPionGMIyc9v4PgA2IEEpDA
 3FOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724420959; x=1725025759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JMKR9bGfM0t7gPRNHqzFhAKLlfcdWZvsACjtC+GS4O0=;
 b=tMe98bzaB7WATdpC9u75xnI/GWllPMJCbC9KvRTpzFENYVBOaNpZio1i/UDSzAABdx
 WlaMkCeAvhGWlzxOByXybMnTWuQ7xDlV2byiPNM6KrNkayXdT+irEtV06xw6qFbZQMEU
 eecpRgev3byUBFQSl4EUhClUksQS+Ag3QMv9ZxE3+ZeQfpUUYNVwB5nAVShusdDJUDTK
 U9JMzz4H1l9dwcf/DwzBFyWAOReY5a4lq2O+YLXAGRKed4faX5muBRTmpX79lb30FlzU
 9RdELrSlHSCk0Mg3Aeno4UTHawgK6u8RBwMfnSvV7dWirBF8PSOEe9lJcWUO4KacJDe9
 +66A==
X-Gm-Message-State: AOJu0YwSWCAXa/uLduw/UwF/fB8l+FuHR3c4cEGwQrUID6QinNq1Jyrk
 en4GJP5q/YRSopMJ2CBln1w2CMDafdt5hb6jmCo5jnPVtwP9GETydzYJ0oKCZA9OBKX8eG2zAvq
 hQ1aR408z
X-Google-Smtp-Source: AGHT+IHAM0urLEvSFL1ZIKgEAlF410kC7fZteEmPBb5Fwmlaoc4KDdjEVrGu3IwtOJ4Yg4aC0hR/ug==
X-Received: by 2002:a05:6000:e52:b0:367:9d05:cf2a with SMTP id
 ffacd0b85a97d-373118d2295mr1537431f8f.42.1724420958621; 
 Fri, 23 Aug 2024 06:49:18 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:e668:dc94:35c7:8064])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-373081ffb40sm4201665f8f.76.2024.08.23.06.49.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 06:49:18 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yang Xiwen <forbidden405@outlook.com>, Gabor Juhos <j4g8y7@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Robert Marko <robert.marko@sartura.hr>,
 Boon Khai Ng <boon.khai.ng@intel.com>
Subject: [PATCH v9 08/37] net: ftgmac100: depend on NET
Date: Fri, 23 Aug 2024 15:48:12 +0200
Message-Id: <48e475e43d3e10d1d59cf55a09066460db05b7aa.1724419624.git.jerome.forissier@linaro.org>
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

FTGMAC100 enables drivers/net/ftgmac100.c which uses
PHY_INTERFACE_MODE_NCSI, which is defined only when PHY_NCSI is enabled.
Therefore FTGMAC100 depends on PHY_NCSI. However adding such a
dependency causes a "recursive dependency detected!" message, so
add a dependency on NET instead (PHY_NCSI depends on NET).
All in all, either the stack is NET and FTGMAC100 can be enabled,
or it is NET_LWIP (or NO_NET) and it cannot.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 drivers/net/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 69ae7c07508..3382e533f42 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -461,6 +461,7 @@ config FTMAC100
 config FTGMAC100
 	bool "Ftgmac100 Ethernet Support"
 	select PHYLIB
+	depends on NET
 	help
 	  This driver supports the Faraday's FTGMAC100 Gigabit SoC
 	  Ethernet controller that can be found on Aspeed SoCs (which
-- 
2.40.1

