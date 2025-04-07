Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 670BFC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 20:03:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC6958310F;
	Mon,  7 Apr 2025 22:02:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mLxkO/Gn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BDA28300F; Mon,  7 Apr 2025 22:02:42 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 477BB8300F
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 22:02:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-39c266c1389so3423791f8f.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 13:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744056160; x=1744660960; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NUquF9iuIp7lnMmDFY1KTqf87iUW2mnFLaVtn9tKXPY=;
 b=mLxkO/Gn/BqMgzm3ChQNd7P9YAXlT+yVuILjt0rNs+lQwe4HgmXqoNuTxmSDGifkE+
 +S48G/pzAoei03EzD/9QUF0KbBe+QoDTUxmdogQS9KWxFrWmagLWoI06j++LLseCvzl5
 rMGgQc8RrDUFxzfkQn02Rk1aIHWfe42mxod4fhoET39eJSFovXVOjvd/5Wh9+8qwAw+S
 wfCIKL9c5Ig7Qg+5Dvy1FEN4bh9UrUseqnZoKbb4j7GxWXrtKQmet43IcCVDyAPHIYYp
 nlS2iY/Kj8jExXSOtB1ShqPxQVU90Z9Mgr2vgXoMC7o+HEEj2u+7KzC/X5IT9l8zWMMT
 2iOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744056160; x=1744660960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NUquF9iuIp7lnMmDFY1KTqf87iUW2mnFLaVtn9tKXPY=;
 b=Uqt5WeryIVNN+omi7FaDQI1mXQZe0mirSbpdB+WcpYLn6rBbJdE4WsrMojVBO0vWSv
 4toGH29vTekVn5mhRIMstraHJyfEo7DpRZJOBUzogjZYAfjbn/PimsLWh8Wqm4Dg5ZNm
 hAV5PGmLVlV5fZ3dFl+ANzVMmZARFikWdQABbkCWTO9hP/61tb6qc/0yIeb43j0IHVgX
 7THqiVtuSSYd8tZaSKEgCuKq9pGHFAPHNZ5YsKMZA0bVhPFi6ajLupPzyuRQKA+x31W1
 IakDMyLGznoqLYkzVLH5bi5lMl1K/MfA2YPokUV87zi4LFRvRlFjpkx5VCJR3BRxlTuf
 QZ4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHUOkpsbXrpAF5zQH5oPq0ikaq04tF10tFbnUafdg1JXv+SfOE+D/14AkYi8MxRyWh88O79A8=@lists.denx.de
X-Gm-Message-State: AOJu0Ywz+oX8kpvhC2XH2TDY0ehQKfna3u01csaTZB+3SP7RGRAluKuB
 /h/XDiZ1eVIkX6jXEALOnViaVIQ/qO6AyS6/Vwjyr21t25NAgp0n
X-Gm-Gg: ASbGnctlZdD0zGuxSYdVJVuGzPDwgL7sf9tjxay1GI0At18i3DaZsECorLySXWpG1sD
 La8HS/Yd+F27UZkyHuWHPW2XFP5CBAFpfj2NeUC4nTQvR5AKY5dvSqHEkHx4tw+rHqLeV/p0rZj
 DIEh3faQozN0AFNiZXUYjxbeh1OW0upwIiZG9jAC6EU14mKNXsN1mKJH1PneekuzLsq2alxZdKP
 9aTMLmK++k4XjwCk5VI+qADDsQIlk0Usd11mqvbSb9Gv9UNOxv1hK/BGbXDnfFR/+EvgBjb6gw3
 8tDVEypRt0jMtL0CIzWjakleOsdUxvdCTX58SFV83xI9Hrd+xjnl++xmtykcMySPqRQ5aN2DA2r
 MKuOCK0nVGAN3jw==
X-Google-Smtp-Source: AGHT+IGxpr1Rr5swYMGj61V7IeMHbpqX/+Xgr94gm0eS1JPQfeO74HTRP2IXZKwVwjRICZI8HcwCaw==
X-Received: by 2002:a05:6000:18af:b0:391:2ab1:d4c2 with SMTP id
 ffacd0b85a97d-39d0de62221mr9759374f8f.37.1744056159671; 
 Mon, 07 Apr 2025 13:02:39 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-39c301b9d55sm12723354f8f.42.2025.04.07.13.02.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 13:02:39 -0700 (PDT)
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
Subject: [PATCH v2 05/14] mmc: mediatek: permit to also build for Airoha arch
Date: Mon,  7 Apr 2025 22:01:49 +0200
Message-ID: <20250407200208.25594-6-ansuelsmth@gmail.com>
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

Airoha new SoC implement the same Mediatek driver for MMC. Permit to
also build for Airoha arch.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/mmc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index 4827834b4aa..2e33dbd3fb7 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -860,7 +860,7 @@ config FTSDC010_SDIO
 
 config MMC_MTK
 	bool "MediaTek SD/MMC Card Interface support"
-	depends on ARCH_MEDIATEK || ARCH_MTMIPS
+	depends on ARCH_MEDIATEK || ARCH_MTMIPS || ARCH_AIROHA
 	depends on OF_CONTROL
 	help
 	  This selects the MediaTek(R) Secure digital and Multimedia card Interface.
-- 
2.48.1

