Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28AA3CA0EC5
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 10:18:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBCEF88960;
	Fri, 30 Aug 2024 12:17:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IwqSgkS4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1758D889E2; Fri, 30 Aug 2024 12:17:36 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20DB18817C
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 12:17:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-37198a6da58so1302889f8f.0
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 03:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725013053; x=1725617853; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O2nppkZ7lk3cUfvEJ+mophz5SDTsLLYc7GttlWMGBkU=;
 b=IwqSgkS4xxICAyLAs5CaMotjCHXq7gk+pGItgwMiDtLV8UANjre2xM3fOcOTRNg1ac
 CLmQTZsZxXdjFy4+x1eVKkda2NGwgpfGuwrESsKPMqz293vpdEzicpMXXWddEJBA8ZOK
 yB1vjPwxA/XNRdQ1WdRAQMX3aizP+qEDBOSU3EbtJFFqlTPtGSN24sDtd2ujoHwnRvVu
 sdT6lry5ExI+20k4Kl6to2dR5/VgnCnYoBE61C4QdufAHYSxQDxyGBc09V64clOlk64I
 JXvAPA/5ewZar1P6tw3UQZgXPsHn3DQkjcORAw4sT5FIuD6PPpy+6pe7bk7S0YtZyo1E
 +qWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725013053; x=1725617853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O2nppkZ7lk3cUfvEJ+mophz5SDTsLLYc7GttlWMGBkU=;
 b=m9UnjECo2AhqjviyjCS+LJel9FOn6cnxW30QZEehjuzBFafHSKzYfGe0FMVDfUtwZs
 8d0ybpGIK63A+lJNtZjh6YdEcQ5f/StIQOtqQheOANN8dW7jsOnxS0iu6coep7wMpuLd
 Tqsqnu/Ps43d0ksQ53xpGwEXlZnEUXu0INvdfx5rTmA+u4x3aqmeO5FwohyCtieu46fw
 USNzgIxx4VrfCGyxh1WnlayQ51P6F06hw92bOJ6opkxS0bV4folhdRLte6XwbctwMroX
 zN4mCNYCCVWuBztLjxrf98vjZs3WcqYnerCYLnu2fQnNpHwCuwcKHGIJEKO37z2vX9Ul
 QpZg==
X-Gm-Message-State: AOJu0YyMlOnGiavgLcxDDBDDks7xegn/0bxNPF4v9Hb0/PLJj/P8uPmS
 vqEXwnR5/I+VpQGbaNpqOc/M2ICDLwKwZA4JXZJ8Ko9QiQ+FZaOXMQLuNWpzx8vkb3j5mjHw+2K
 S2GOeT8Jl
X-Google-Smtp-Source: AGHT+IFWDXUO0ZO7TJZROMm3J1GvSc7UVwcjpQwS3klFA3k8SgzKnn0jXsUqvSdXnyQtJbs8P30JbQ==
X-Received: by 2002:adf:f74d:0:b0:36b:3395:5363 with SMTP id
 ffacd0b85a97d-3749b54481emr4578966f8f.16.1725013053172; 
 Fri, 30 Aug 2024 03:17:33 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374b6a3d27fsm472728f8f.59.2024.08.30.03.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 03:17:32 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Boon Khai Ng <boon.khai.ng@intel.com>
Subject: [PATCH v2 09/16] net: ftgmac100: depend on NET
Date: Fri, 30 Aug 2024 12:16:52 +0200
Message-Id: <3db716e4924a9cf48feca84b327fd232c4336304.1725012294.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1725012294.git.jerome.forissier@linaro.org>
References: <cover.1725012294.git.jerome.forissier@linaro.org>
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

