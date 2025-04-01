Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8CFC36017
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 22:53:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D2A581FFC;
	Wed,  2 Apr 2025 00:52:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lXWxcz3o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC1DB8209F; Wed,  2 Apr 2025 00:52:47 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C69C681F0D
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 00:52:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso44360475e9.1
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 15:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743547964; x=1744152764; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RDImM9a82VA8pWEoRtYbn7Vee5q0ZHM3NBCRt1kRJbE=;
 b=lXWxcz3oALqArcv1++RvcnDMfnn8mcMDnjeiH+gGN0bnfnICGqKMnC1M2RsFa1orwV
 ldjW4qdsZ+f/J0Xl+rQzrt6yp88i6bQKnG+Xg4mN7in/tkSJV4N8yZzKyZ4h9rwsCK4o
 DXOUQ+Iv2MIO7/xxOCMkaEX3ssPTUeu+546DzU8fovanlOeibEJpTHpWoAwES4BU7iFE
 MzIfrB/z6Co8olUmlXeRI1XyVdidiPc9lWBvOKaeZWs1Yk8+nMs2QtyQ3ewQcOC7aQTt
 570LYn/p6qABZATDtfZSXIugSyczx1DWvXwKgrHItJnDWv+2gcqR3yITkkQnV7RhJiDJ
 XoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743547964; x=1744152764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RDImM9a82VA8pWEoRtYbn7Vee5q0ZHM3NBCRt1kRJbE=;
 b=nZaVCWX+E+UIDJKw0gJoSw2tT4NyRbGWtjLm5HS2/DU7bnoZPO5FMMKvUo2V+Dfx+e
 NgVdPqSrWQG24at4hm2kYTFBNVvga91K6aDJ/Bjuv2NrxZ8ny2/2E3+6dOFuWbBCA4zA
 oh7Lw8r4yKp8EofEoYKV/tSKwDGknDZtfBj6lQTdaLClsUFBjcfxGC3xXxZpFo0X/uuD
 nS5/xLYB2PFnMyUoCNenzgF3DMMe+q7NDdKQ9D6dYO8kynv/mFEPU2B0+3p4zzRxuFtn
 zS8hzxDOJmABFlVnU4Cmp5rJodk555EKnM3jm+fJ889EfNKLDqoCx/ycQIvobqCpD70/
 nY/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVz+8Ngxt0ZO7nyTv273TbnUEIKgqwbXM1n3lkxJYhuZBIoRR3pDfg1osaQRbo5XH9Ul12pQfQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzvOSt+914wM5+hYrKAOkd1CYfpUtyMbZ3gQFXB3otaO7MDLMv7
 kN9VErctetiHh3UdOyC9U9z81FodyYzp1hzJ/wenao8/ZzqNzqJM
X-Gm-Gg: ASbGnctmJmKMLsr6zLnBIz93TgqI/3zBrS+Bovuu2r+GBfNLXISZ/NTRCAMAirNs0sg
 rTKWveMDLNzu/f6kGMOBvssFmp8m0mB3caOvT4cFAE5isU8/DSadAn6qUSffyxU99LnXoRFhpgT
 4Kz+EQ+/fKF60m7Qb7yIc4Q51aTCBZCvFEE5wr+mETspLWlhu0rlRCIW65XUKB9C9K1PmXnFLJl
 T+JkOK7Id9k2eYQK5P/8j5Og19EE9fVLe0Efb0Fig28W1Ge3t20pW957LNGWiDq66PZxB7BU4YE
 cA7+vuzRRDWs3kE1X94z9vOX/WNlDdyYK/0LfVV5WvuD+6WDgFRsS0o08EkSQSZrxZZUpOCYYZF
 YVNEMzrdBzDcGCyjPd5vuv8VD
X-Google-Smtp-Source: AGHT+IEQx1veiQllc8KeMXCpdYsNHYWJDCK+TzjHOPfvBJul7BKDDGsK91Yfz6dkPeAfL8ZoHHPabw==
X-Received: by 2002:a05:600c:83c3:b0:43c:ef13:7e5e with SMTP id
 5b1f17b1804b1-43db62bd98bmr118716985e9.26.1743547964271; 
 Tue, 01 Apr 2025 15:52:44 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43eb60cd77bsm2478625e9.19.2025.04.01.15.52.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 15:52:43 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Bruce Suen <bruce_suen@163.com>,
 u-boot@lists.denx.de
Subject: [PATCH 07/14] airoha: Add eMMC config to defconfig
Date: Wed,  2 Apr 2025 00:51:39 +0200
Message-ID: <20250401225156.25790-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250401225156.25790-1-ansuelsmth@gmail.com>
References: <20250401225156.25790-1-ansuelsmth@gmail.com>
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

Enable Mediatek MMC driver in Airoha AN7581 EVB defconfig to add support
for it in default images.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 configs/an7581_evb_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/an7581_evb_defconfig b/configs/an7581_evb_defconfig
index f5bd647cb6e..fa41a4bca97 100644
--- a/configs/an7581_evb_defconfig
+++ b/configs/an7581_evb_defconfig
@@ -77,3 +77,4 @@ CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_SHA512=y
 CONFIG_AIROHA_ETH=y
+CONFIG_MMC_MTK=y
-- 
2.48.1

