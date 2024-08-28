Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D8DC54EE3
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 12:11:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62C9688874;
	Wed, 28 Aug 2024 14:10:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xF+ijc7T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B614788B1B; Wed, 28 Aug 2024 14:10:51 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 956F488AC2
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 14:10:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42ba9b47f4eso1869925e9.1
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 05:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724847049; x=1725451849; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r30FER1u6ArC2MC1YI7nnZsRsMetzEXKpzkVRsNl8s0=;
 b=xF+ijc7TRfphJOHtxiG5d4Bc5Uwrdc+OoNzd8NQTWYVCvW7nNbMABTDcgcZvuk8Ou4
 wMBRUsh6gwKiChg3hyxrrxbx3Ui+XoWJ7zw9wLSpbIye+iN/gKP6lcjn70T5AhKLJ4eQ
 HIJQxy+BCQyXWfLFTMXzUIrYKzluaijezzb+TD3Sm0Nu0daJYPXqC0zN732GRLi5f76K
 e/Jh372LlTL1/rmdf8voytLrBOkCvjXQTxFRaU3udfJFU9AL/WsfNIvSPV8MnI+JnX7W
 Atb97SmtKW56Sj3N9OevRGoSil2Zdnse9n5NSjz8nP1yE6UHroPCA2qHxwSmXIkLre07
 9YuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724847049; x=1725451849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r30FER1u6ArC2MC1YI7nnZsRsMetzEXKpzkVRsNl8s0=;
 b=dPgSGCsq2Np2qFtJciv/9YSMJ0wh7bYwfQ1xs8Luccj2JyQ7nCAbD/zSl6KePAs+7k
 nlK8NiRN2+KjQLMw2h3eSN+7DtZlOAGWAkF6E35wA1iPgcj85BFLP15tRPry+gxoaWCb
 HWSwazdUgs9n3it2V1Z8c+O/8/3HBVborMzyoz3idOMbu92ecZcu0tc0yUL3GYfH7wtE
 DC8OGvB5t5XZ/RV5P8GWNjML1aDSxTRMWjC42ZESTq4P6Rot8FzfuvvqkDv6hS4WtSYh
 BmIRPPmUNkpkfWUMzMbBwWGCUKvLCZqqJrM+vGK6vOdhWatfVmxI9RBiYvpDl69qO8Tm
 NBTg==
X-Gm-Message-State: AOJu0Yz9M7SDDMi28ur4217M9WSpu0D0oRJ1+4YYcpvZMSEb9Keprpyt
 8xRrrX5qKhXEvF3drY36dEbRsvfDfngdSvjxEczldEZPt+7DeVRDWah256G4EMjUgxsbuLoKsxq
 42R7UDA==
X-Google-Smtp-Source: AGHT+IGgmROtls3CVYxfAnXNYT5kfhzdlNI0D5twiJO1n8M4k2sXPYm3yF0ip5n/so8osi964n3zNg==
X-Received: by 2002:a05:600c:35c3:b0:426:5b17:8458 with SMTP id
 5b1f17b1804b1-42ba56b9395mr11423195e9.12.1724847048915; 
 Wed, 28 Aug 2024 05:10:48 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:8ac3:aada:f033:985a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ba639687csm19470365e9.8.2024.08.28.05.10.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 05:10:48 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 07/13] net: phy: ncsi: depend on NET
Date: Wed, 28 Aug 2024 14:10:30 +0200
Message-Id: <898bcb397c26f6eb7b0750b91c6c6ad2783d5195.1724846454.git.jerome.forissier@linaro.org>
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

PHY_NCSI enables drivers/net/phy/ncsi.c which calls net_loop() and
net_set_timeout_handler(). That's the legacy NET stack (as opposed to
NET_LWIP). Therefore add the dependency to Kconfig.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 drivers/net/phy/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 73064b2af6..a9efc50981 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -368,6 +368,7 @@ config PHY_FIXED
 
 config PHY_NCSI
 	bool "NC-SI based PHY"
+	depends on NET
 
 endif #PHYLIB
 
-- 
2.40.1

