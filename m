Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B8ACF6495
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 01:50:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5C5288DEE;
	Mon, 30 Sep 2024 03:50:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HDPn0Szx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B77388DD1; Mon, 30 Sep 2024 03:50:14 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E415088DC8
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 03:50:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3a33a5a3b5cso13137055ab.1
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 18:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727661009; x=1728265809; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hWCOLs6q1sd+JMcJ/JvFoYh16u+7UnBf8tAvCNvw8mA=;
 b=HDPn0SzxecGeZcnXY7TK8Zhdp4ghYvzesZsYyaXg2wWN+dyZqDDTAQSXptggsJc2aX
 ZHsahrdSsKavgUigrHxLBRuuzt194OG0WIcRf/a4TqFtkmhSiqjWOcfjli9xloo7S0jp
 WSrkLRGiuCdOUSJXutH1ryxth67fHhO2S2ha8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727661009; x=1728265809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hWCOLs6q1sd+JMcJ/JvFoYh16u+7UnBf8tAvCNvw8mA=;
 b=NBzhPMHnfoyoD14HckneSQQ5v1NGwmLd8nnFX5hbzMHAgXb6klzlT7Ypjhb0EjAitl
 +QY9p0sudGC9xhLRQQA1xX1LXoO4w4W0JOxbKnW3fAWDkQTHNtSJSxxkZjPf3UQSV1JI
 qf780WFI9CuOHXaEb0JNu70s+dlKmcWAUWRdtVBexZlQn05zI16Ck9nlxwSAUQ2Of2JF
 Yj/pJqRkbmyEYKXcxdR61xDmNHObZ7bw1VqE2GIl39bUEtl6kQVZKF9yilZXEm2a+8Lu
 9vzDt+OdCTvzv+7U581Pm5EAuT7h5fRZm4KTTHYPHTeA69Z1R3nSb6kB4rVkWfjz6u8f
 hbXg==
X-Gm-Message-State: AOJu0YxeVVO+1N9kE4ueT2uuO7Ho2GXvQwKZroIkSEaoqoRg5d3GehAg
 XiS7rZFQWiIht/i2hy8sUnQKUDh9wK+yEG4p3P7Erk68SjuJWu8o/3gBUsnyyipo8UVErfiRJHd
 XkA==
X-Google-Smtp-Source: AGHT+IFayJNVGmtQO/wSTWnFdpqg8BI3/P7Cm2nnhnyZ/I11QwN5om3fG7VeSToyMq8U0hCpV+gU+w==
X-Received: by 2002:a05:6e02:1a0c:b0:3a3:4221:b0d3 with SMTP id
 e9e14a558f8ab-3a344fcc743mr79983565ab.0.1727661009517; 
 Sun, 29 Sep 2024 18:50:09 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a344de1d5fsm22074185ab.62.2024.09.29.18.50.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 18:50:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Boon Khai Ng <boon.khai.ng@intel.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Jonas Karlman <jonas@kwiboo.se>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Philip Oberfichtner <pro@denx.de>, Ramon Fried <rfried.dev@gmail.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Yang Xiwen <forbidden405@outlook.com>
Subject: [PATCH v3 04/33] net: freescale: Drop use of SPL_BUILD dependency
Date: Sun, 29 Sep 2024 19:49:27 -0600
Message-Id: <20240930014956.1434060-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930014956.1434060-1-sjg@chromium.org>
References: <20240930014956.1434060-1-sjg@chromium.org>
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

SPL_BUILD is not a Kconfig symbol. Perhaps the intent here is to use
SPL instead. However, this causes build errors, e.g. with T1024RDB_NAND

So drop the dependency on !SPL_BUILD since it does nothing.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/net/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index e7d0ddfe25a..403d7e1c679 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -891,7 +891,7 @@ config FEC2_PHY_NORXERR
 
 config SYS_DPAA_QBMAN
 	bool "Device tree fixup for QBMan on freescale SOCs"
-	depends on (ARM || PPC) && !SPL_BUILD
+	depends on ARM || PPC
 	default y if ARCH_B4860 || \
 		     ARCH_B4420 || \
 		     ARCH_P1023 || \
-- 
2.34.1

