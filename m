Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E071C369A4
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 20:03:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6793983100;
	Mon,  7 Apr 2025 22:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QU3a0Sy1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6130B83121; Mon,  7 Apr 2025 22:02:44 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66AD782E76
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 22:02:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39c14016868so4290899f8f.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 13:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744056162; x=1744660962; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RDImM9a82VA8pWEoRtYbn7Vee5q0ZHM3NBCRt1kRJbE=;
 b=QU3a0Sy1Hi4DUkzPja3VNFxwixenS5DHFFmbamiam3/AVlwNuzcCsYylQHQ+LitH0P
 HhZrsmqQU/qgELnlnuoCsijmXICCsGYTxS+mjRBlXOqBtFVmDDqrApoLM/d2pqD+ztDR
 b4NlCN5sZWG9qbwViWqZSv6Uy3k1+3jGj/z7ZHH6ktxS8wMZYEBxxoVaqGd1h+AfStde
 fKVqGApYaiEq4/VTweeV+Yd6yweUqJh+wkpdAxCOIim4MxG1M5hoxoyVCXtskby3xR5z
 2Wm9bco4oldgLKlj6tycA5GjkVWyyNiuEhxoAdl9JiKHHNu+Z8wRaAe1eKu7g0QLNvRn
 Qcsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744056162; x=1744660962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RDImM9a82VA8pWEoRtYbn7Vee5q0ZHM3NBCRt1kRJbE=;
 b=pTzVYvGwqnuO/PZH6KLVTuEgWm4wDoXhZQMyClF/UFlL8RgljzBfOyqET1egg/DQN8
 Zn0Rq7JsJuR3XBjyo8bmAZqpodaUQBiKpzhxSrLJ78kAansE1I6pOsM9fhV4X6LoBiKt
 usZfJAkeqpDc5hFaehGYD9jy49ReBfaC21NlEVVLerReyDalgZ/aYV8Xnu1r1JBx1zP2
 x9bnLxppeFknrC+TTRyUdsJHSJhlDrlpu+A6FILnL137A2PtxE+HgrIEHZ6jBWc9aFMJ
 UrE1nRcG+yaAA0ZmS0EybZYYzJNckDeDXqwPlCgnry4Fg8lrd5FDIT6xdEl9Mx1mYgv+
 s6aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLPjk1gO3yR72WiFgGSofn0OVpLucFVXJQFYDfv5QIHT8uBBY+rBkFDNvH0/x4/hoxXLxNNug=@lists.denx.de
X-Gm-Message-State: AOJu0YxvFd+VJIbsILbfCzucxRkv0gN/lvy79ba88B3ObKdXGTjf2CaH
 7Uwwfcl3XCtXpANGGdi8jZWOR17/Udx6BISr8gfdVrf1Dhk4Lt0a
X-Gm-Gg: ASbGncv46rBMG3FPNBslHZf48FzYiggMXjBNxhE1BK8ypVMw+d+ERZPHgTkvIltxBY8
 6YOfu6AExO4yT3kEhAq5KaIyZ4YjcH2faaBu9ZnesGTW3HqMa4Q4z2y9HQ1JF/LYvRHlrehkU/v
 cmJJZ7XNuG1er7KrPf+FyFerOBxdIGwYDiN/u52qtPsfe8LEsqlltQdC5RW7kzA+SGsAvjSbGzf
 J8scWFqrbVXeenM4xp/it/Yy/wDiyTylKIllgH0qE7JUTWwfGF/h62LZjDroUWmNhK4xBi6J0Q/
 nVxtfqdq4jbgUn7r5J4c4oshEXZK5dXwc20xaN1AcgfBPT6IyZlIXSHbdNZJLt3FvxXIaLSmFWK
 GCekRPM9KEwk9+w==
X-Google-Smtp-Source: AGHT+IFkt9D/zyfIyBxgncCquKxVlxdFvehUCwc/daEfuucjzoZPzYl2e6yCMwdfKLw9MWgHyKYa9A==
X-Received: by 2002:a05:6000:420e:b0:39a:e71d:ee34 with SMTP id
 ffacd0b85a97d-39d0de67093mr10331424f8f.37.1744056161754; 
 Mon, 07 Apr 2025 13:02:41 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-39c301b9d55sm12723354f8f.42.2025.04.07.13.02.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 13:02:41 -0700 (PDT)
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
Subject: [PATCH v2 07/14] airoha: Add eMMC config to defconfig
Date: Mon,  7 Apr 2025 22:01:51 +0200
Message-ID: <20250407200208.25594-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250407200208.25594-1-ansuelsmth@gmail.com>
References: <20250407200208.25594-1-ansuelsmth@gmail.com>
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

