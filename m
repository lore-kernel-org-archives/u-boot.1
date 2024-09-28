Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F5FCF6493
	for <u-boot@archiver.kernel.org>; Sat, 28 Sep 2024 20:01:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42B8388CC2;
	Sat, 28 Sep 2024 22:00:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TH2xJFxd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AA6E88D03; Sat, 28 Sep 2024 22:00:53 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E625588CBA
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 22:00:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-82ce1cd202cso181967739f.0
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 13:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727553649; x=1728158449; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hWCOLs6q1sd+JMcJ/JvFoYh16u+7UnBf8tAvCNvw8mA=;
 b=TH2xJFxdRPTRlpNiZiPCtadNi93r/Wem/Wo4dAuRIXlqNSQRdKEoF2Hx4JfAT3AFuQ
 mDik6cBm2afZtkSmCN5NO2ml/Dj+MhbEmvtNnHu6LHEvKZ8bioAg/BaRV8Hy0DGvBsuq
 u3ZFybvvDbLc3Ha0bjR6VPw/yv9DlVcmWe6bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727553649; x=1728158449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hWCOLs6q1sd+JMcJ/JvFoYh16u+7UnBf8tAvCNvw8mA=;
 b=cGEUOBHaRA3Qq7rqR0cRQNEhwhSZLY+qh04RtWDlbnWZ5+DktviMJViuLYmmOM8XII
 f/iCBLhmG+szos/0dJQJAr5u7dR4hYJHkO8zI+zy+yz3y3jnxLnLKS8ZDRrxuFneOWXm
 cSykAD8jd0yNzpPjJ5hh6t0/c1YgEi84fj4GyiUxVsu+PTQEiSRWtZGAXEP5wWKd1nIo
 JmAvzv5/Ib23GFMT66Vw9kEgIWTnqqfe3jEjZEAC8qlvG5KzH/A5eOqY2txhCT261vZe
 w1VJBYx7qGknHofdZMdIOQTvz5xCjEzUXj9b4WxhrFNViWN8TsJXtWAI7fXKRWZC3xkZ
 CJTg==
X-Gm-Message-State: AOJu0YwyUlXVw4TP3/GAk2Oq07xyG5tCln7A+oQvL0YYxL58xRuSrQdC
 c6IBQFD9rZzL3U2q9g6szPrOvkbeeVJFaZy3XmfeZr2y8UkV3ybF1CITeSsr0snNxxMsU7wk3So
 kGQ==
X-Google-Smtp-Source: AGHT+IGICYMDfpvzgOFvZdHKUfTRq1WrH/RVSwPp7AaaL4zgYCSJ/6E1nIGhXajslWJVTH6vFvRVmA==
X-Received: by 2002:a05:6e02:1d84:b0:3a0:9026:3b65 with SMTP id
 e9e14a558f8ab-3a3452d15c6mr59164045ab.25.1727553649165; 
 Sat, 28 Sep 2024 13:00:49 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4d888835307sm1242590173.2.2024.09.28.13.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Sep 2024 13:00:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Boon Khai Ng <boon.khai.ng@intel.com>, Gabor Juhos <j4g8y7@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Philip Oberfichtner <pro@denx.de>,
 Ramon Fried <rfried.dev@gmail.com>, Robert Marko <robert.marko@sartura.hr>,
 Yang Xiwen <forbidden405@outlook.com>
Subject: [PATCH v2 07/30] net: freescale: Drop use of SPL_BUILD dependency
Date: Sat, 28 Sep 2024 14:00:07 -0600
Message-Id: <20240928200030.194546-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240928200030.194546-1-sjg@chromium.org>
References: <20240928200030.194546-1-sjg@chromium.org>
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

