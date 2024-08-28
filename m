Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E4DC54F32
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 12:11:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0C0C88B29;
	Wed, 28 Aug 2024 14:10:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VMmwtSNp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC6BE88AFB; Wed, 28 Aug 2024 14:10:49 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3F5B88ABA
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 14:10:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-429ec9f2155so58292885e9.2
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 05:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724847047; x=1725451847; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wvelrrkYuX7sWh+UqcXejJvxNMf6tKNnDRAQQwpPslM=;
 b=VMmwtSNpbUd2rVZnnK1kHCQQpdQ7FFUSMKmlx8JflGQK4SpK1ZBL1zQHgqSRuOlS53
 nHVC36xOWvh7VeErNi5TF14tPx1Q84MYxLDdfyJz+8mh+E/MA2KxP/ltO/AHTOk+iomY
 gTU0c/nWH60HwXjNiIImXqf5FH0wNsqvPTgsFxAA2p7QZI0RsK08UKHjXENMz+K+V/lT
 FY3flgZH4YeM82VLscodrWSTZRiEoTLpStUQ3N9wmVTz45sLv7eXXGCQvVRybpBrEbBz
 Vu8R7MqJ66DmUFr3OqkFcMCbPDaGuVPnjk0iEi/ZnyJsHXX1MKv5Q2edOnDVPMZL2Yye
 dMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724847047; x=1725451847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wvelrrkYuX7sWh+UqcXejJvxNMf6tKNnDRAQQwpPslM=;
 b=gdtpj/Qex1xvVxKKuI2Ul1rVpJtStoXu09n6D2A3XfRJRgYZr2PP4L4SNXKCuAVcyU
 PaegkTSf2tWQ4fFYsl1f3jEo6q4nCHz3xfxwZbSV80IA+LFP4Q1FRBDK9wzfyldeLY1+
 XyGDxveh5c33CcHVwohGVrtBbwmxRiKUg1Yu8EN8vfY/AIA9+BOHWteExvTC7GFi+bTx
 SoFOCmjcKCU8983g1oht36UZNv6d2YwDXLoV4micreYWz007SWe0m63YyFILE7I0oel7
 eQMvHl4d5u7i8fF+1LBTaKkJqYGlXRvYI5dVKFo4ZM7RC34amTmUPHPNBWVxgtD47bIP
 AN4A==
X-Gm-Message-State: AOJu0YzceseNCbAbZkhJJnjJGKgsz9xkjAKtaeRiV7gwml92depQFSE8
 jkBcmVz+UhsmsVZspbY7KWHNjqZdIfD7DA+aeFjkgLm/mh5rZ4od30HvKc/Edtqi/zfZNx/t76k
 b5wsAtA==
X-Google-Smtp-Source: AGHT+IFMR6l+TAwuPCTaAnb+pkQbAXi+LdL7HPAKE6H2vI+ynGCHaVB8Yx5lVflYsfE0hT3wZ4Gl3Q==
X-Received: by 2002:a05:600c:354b:b0:427:d72a:6c26 with SMTP id
 5b1f17b1804b1-42acc8d5290mr110587355e9.6.1724847046971; 
 Wed, 28 Aug 2024 05:10:46 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:8ac3:aada:f033:985a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ba639687csm19470365e9.8.2024.08.28.05.10.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 05:10:46 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/13] net: fm: call dtsec_init_phy() only when it is defined
Date: Wed, 28 Aug 2024 14:10:28 +0200
Message-Id: <679e20bfd9ac3de6560e202f82452563b01fca7a.1724846454.git.jerome.forissier@linaro.org>
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

dtsec_init_phy() is defined only with MII so add the proper conditional
in the caller code.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 drivers/net/fm/eth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/fm/eth.c b/drivers/net/fm/eth.c
index 19f3f0fef0..e4ec769693 100644
--- a/drivers/net/fm/eth.c
+++ b/drivers/net/fm/eth.c
@@ -701,8 +701,10 @@ static int init_phy(struct fm_eth *fm_eth)
 		supported |= SUPPORTED_2500baseX_Full;
 #endif
 
+#if defined(CONFIG_MII) || defined(CONFIG_CMD_MII) && !defined(BITBANGMII)
 	if (fm_eth->type == FM_ETH_1G_E)
 		dtsec_init_phy(fm_eth);
+#endif
 
 #ifdef CONFIG_PHYLIB
 #ifdef CONFIG_DM_MDIO
-- 
2.40.1

