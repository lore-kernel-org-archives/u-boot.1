Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08520CD3420
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 08:39:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AC3A88CD2;
	Tue,  3 Sep 2024 10:38:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QUfQgVb9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6710088CEB; Tue,  3 Sep 2024 10:38:57 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 449BA88CF0
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 10:38:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-374c7d14191so1065373f8f.0
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 01:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725352734; x=1725957534; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nMH3K6RMJfnQZ/B/a5WpOMKrLegix2UP4tjC+okn3SY=;
 b=QUfQgVb9NCS7VIOAuNahl5AhyRP8m40t1Omqv2wsB++BGjWZjmxejQdzMaH0pB/ckB
 8pJOG2s0himeDom54l2L8SYbRuONjthqyMg48i3W4Pbq4mOW14MnRLggAyG/OZtBhmQ4
 dmY4T6tYvz0+9Jhv+wk9sNuGFblX+qkvNPO7BAj/cwirbCy1g0DhL9N8h4pwbp7W/1L9
 smvKg9z7nRfBg0DM3/pJgRVd/RJck8gtHyBv275N0i46MY83330dcVU3sFAH8u9bJHIL
 ros5a5O+3i30qEm6PvLPSZ5Cjr9LlkyOJwAuqEjpZkP56L4ZGIvt2JK7lGQ87m6xvhRT
 mZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725352734; x=1725957534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nMH3K6RMJfnQZ/B/a5WpOMKrLegix2UP4tjC+okn3SY=;
 b=fl6+8k3C4OaKfc/JrpHyVHPFKFxYuuI3tcv6rl578lFXok3xW+F7vbXVPVLRPuNe5s
 sZjNsBih+QdIejkvi/Jm1dhVwnCF5CVDtcZ0HOpfOqACiYYCGP5kDXN6zWsQtVm8QFdg
 j8mTc7yavA3Kihrf2kSQe2ZvOF5yYCOpUXwfI3XBQyNkH6vbC/99tOAXa6g0hgDur5nj
 QR+LVWTw0/de8XDCyVOl9HAr0OBnGfAvVgqbv9pHCMGr6ED0P0EYVb9SAOGu5Vnn908L
 RUy2PhvgeHg6/ajPMMyLLBVwg/s9zzsazDagRL2fCvXBHxO5SsBg1P21dEKxC2JJ+sEA
 VwJA==
X-Gm-Message-State: AOJu0YzXpQYLftUJEga/Yur3qR9bFnKjoZxoXupCMItDGPV5WriAjInQ
 qfWszUB22xxeSTDoh/6P1zDVe7rTFucKDcm5khc+ZHMimbYjm9nQELjCjqZrYGnBJjv4Zr8S8AE
 s9Tj5Hg==
X-Google-Smtp-Source: AGHT+IGMRBYTCVWiUGR4nEosjVgUJy65VkZ99L2GAEVUQnAjjfuGj9pSUhXMiMbgMtkD8ne07eJvQA==
X-Received: by 2002:a5d:59a7:0:b0:374:c878:21f7 with SMTP id
 ffacd0b85a97d-374c87823fcmr4793397f8f.10.1725352733802; 
 Tue, 03 Sep 2024 01:38:53 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df795asm163103325e9.21.2024.09.03.01.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 01:38:53 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 06/16] net: fm: call dtsec_init_phy() only when it is
 defined
Date: Tue,  3 Sep 2024 10:38:03 +0200
Message-Id: <0313c96cea56acb5585f04bbf4da25145560de3b.1725351676.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1725351676.git.jerome.forissier@linaro.org>
References: <cover.1725351676.git.jerome.forissier@linaro.org>
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

dtsec_init_phy() is defined only with MII so add the proper conditional
in the caller code.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
---
 drivers/net/fm/eth.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/fm/eth.c b/drivers/net/fm/eth.c
index 19f3f0fef07..22025b6a273 100644
--- a/drivers/net/fm/eth.c
+++ b/drivers/net/fm/eth.c
@@ -26,7 +26,8 @@
 
 #include "fm.h"
 
-#if defined(CONFIG_MII) || defined(CONFIG_CMD_MII) && !defined(BITBANGMII)
+#if ((defined(CONFIG_MII) || defined(CONFIG_CMD_MII)) && \
+     !defined(CONFIG_BITBANGMII))
 
 #define TBIANA_SETTINGS (TBIANA_ASYMMETRIC_PAUSE | TBIANA_SYMMETRIC_PAUSE | \
 			 TBIANA_FULL_DUPLEX)
@@ -701,8 +702,11 @@ static int init_phy(struct fm_eth *fm_eth)
 		supported |= SUPPORTED_2500baseX_Full;
 #endif
 
-	if (fm_eth->type == FM_ETH_1G_E)
-		dtsec_init_phy(fm_eth);
+	if ((IS_ENABLED(CONFIG_MII) || IS_ENABLED(CONFIG_CMD_MII)) &&
+	    !IS_ENABLED(CONFIG_BITBANGMII)) {
+		if (fm_eth->type == FM_ETH_1G_E)
+			dtsec_init_phy(fm_eth);
+	}
 
 #ifdef CONFIG_PHYLIB
 #ifdef CONFIG_DM_MDIO
-- 
2.40.1

