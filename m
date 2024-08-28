Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51313C54EE3
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 12:12:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDBBA88AA7;
	Wed, 28 Aug 2024 14:10:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HzYaQyxw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D5D288B40; Wed, 28 Aug 2024 14:10:53 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91F9988874
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 14:10:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4281c164408so57192675e9.1
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 05:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724847050; x=1725451850; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dT3eVdcZ7+yTL3gKrjedSQI9zhitj9PAgp3LECTzRy0=;
 b=HzYaQyxwGKjuUxgzIiFzL7bxPMUUDMJ8oIpoQG+FtIAlTXtrwK2YIO5xgjNLgO89+3
 SMrRBSXiHJPq/WaE5NAIQo6pX3zQEHz0aKu3LsLsCfnl8UtV1VnRnPuu8CltM1sjz6VG
 5k4UzxK8jw1IOq6lomkSHWCEgZDds0zIvdVH1XC+7yCfOuRqkzhStZlWxTf338IXFEbt
 uJSkGQi2YMLEkxjABTten4HjlSWlaQnkczklou5abSnINWo5TkCZvnL3eL1rJ30fVhcO
 lwzMIkxb0PnOkXhzhoS05ELFK/4y4Aoa8HwhOlQb7dO53swco23WVHWptsJWknAr1ph8
 Ss5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724847050; x=1725451850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dT3eVdcZ7+yTL3gKrjedSQI9zhitj9PAgp3LECTzRy0=;
 b=BzWiPhe5o0mbYmeFIqpOwNivCs7s+Z2sNmDPFMCdlv9Hc6KPpoQN1vG8BXuLNhJrs4
 hpW7xw64P0c2sNxF7Yu5rHf/707x0NP0OVGFoOmSauiz3EsA68DVxsrGoxu3WbIV2r7o
 1yiUHdxqPdtNQc/4Q9vlPGNuna+vbv1iPXOx6yr8kBpMPFdftHGq9P8eyCnF9Mj/0+9v
 WyIjUnuTmXcdIfgHkVjcDpdNQiNZlyVD7ryg2JEOjwppVs7qd3QWOgH2SaZkVrCr12I/
 rRoCsWd+hX1sgSk85f0XLcH33wyRmXq5620k/LYOQgXpQqtjuyVyvbZdWzDUeferpHa1
 4iuQ==
X-Gm-Message-State: AOJu0YzeQagJz+SWryeFvFyuj4j+6hnlii86iTmmyEp+FrMccxs6gFlc
 t/HavepnN5KcqdOMg/Vd6DmmLUjVlJHxuh0kLipV1EfUC1C1CyKxpInIGs7MTKBdxiD9E9BRSdh
 lBNi3m2i+
X-Google-Smtp-Source: AGHT+IFHwHfXrG1XAYVS6A5DXeJ/GWoET5RnkkZyFw/ScCbbBHXBCr0ANbAle0b6r36ONKIrdFQijg==
X-Received: by 2002:a05:600c:19cd:b0:427:ff7a:794 with SMTP id
 5b1f17b1804b1-42ba6692269mr12315785e9.4.1724847049817; 
 Wed, 28 Aug 2024 05:10:49 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:8ac3:aada:f033:985a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ba639687csm19470365e9.8.2024.08.28.05.10.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 05:10:49 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Robert Marko <robert.marko@sartura.hr>, Gabor Juhos <j4g8y7@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Boon Khai Ng <boon.khai.ng@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 08/13] net: ftgmac100: depend on NET
Date: Wed, 28 Aug 2024 14:10:31 +0200
Message-Id: <3112cb1127580bf714f50a199b4ec9e998322202.1724846454.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1724846454.git.jerome.forissier@linaro.org>
References: <cover.1724846454.git.jerome.forissier@linaro.org>
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
index 69ae7c0750..3382e533f4 100644
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

