Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E41C71153
	for <u-boot@archiver.kernel.org>; Sun,  3 Sep 2023 20:49:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59F8A86867;
	Sun,  3 Sep 2023 22:48:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="RfsVElQ7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C934F86813; Sun,  3 Sep 2023 22:48:57 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E914786504
 for <u-boot@lists.denx.de>; Sun,  3 Sep 2023 22:48:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-99bcf2de59cso125397366b.0
 for <u-boot@lists.denx.de>; Sun, 03 Sep 2023 13:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1693774134; x=1694378934;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7v/T47c4cyvP0ZBQxSABDrZzKs6stbyxJ2yX9+Ibn8w=;
 b=RfsVElQ7lw3jTdN/nhkydQSfy7TthFSxeCg9kSljmzG76JUJgBow8h7xyNb+2JQ2EZ
 14ypElKoXnEeweFQw7AcItQpryj+aiYT88dMUPf9yKBtKP7OwKi7ipvUTn6Nv7E64pLh
 pMVa+H7Lrub7gWeh80obwuwimYHezIIcTK0sI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693774134; x=1694378934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7v/T47c4cyvP0ZBQxSABDrZzKs6stbyxJ2yX9+Ibn8w=;
 b=L5LdMXZ56NUSuBI5hLCuw8aha8kNAT0gk238ZKAYyevU8VPmxHQcHABfRKuanmE9Ld
 ozhoqq30UrZRTyXDp8JfApaxjm0MCuUPaQPnM21IlVh2bZSJUCAA7C9eahyOuva5Noa6
 /qxFCKMAryomQJNSCRFUWuDwVO92RrulHwjuH1Bkj/FkcjBHO2bjp1GWFzaAg551x099
 DX57mSDA2Tiy7OJ4IgaWDC7MWbJvxhNU8PZSz6HUfRwx9BwaaKlnKN6DgBnjm63ATPEV
 eGIO0hRbwDCc/Ha7UvEFcaT6ghDM6GNkfo3xnJwLGpBaoCHyHYY9HECi8ymI/s7dTxCX
 1hGw==
X-Gm-Message-State: AOJu0Yzhbu1ktxuy/80Qb35+8VjJY7kGMeyN4mdABvik3bBR2ZIG9QTS
 7Fquv2euuNdN/uOO873c1u7KoYhMxTCYxrDavuArzw==
X-Google-Smtp-Source: AGHT+IEd+voLKr49j9NBJ2ZPx0YBVE/q6iq3Wj+HRes2K0jTK2A5HB0gttgtu5yF3yXaQBMeOm04ng==
X-Received: by 2002:a17:906:1009:b0:9a5:db06:4264 with SMTP id
 9-20020a170906100900b009a5db064264mr6718778ejm.72.1693774134022; 
 Sun, 03 Sep 2023 13:48:54 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-79-54-71-141.retail.telecomitalia.it. [79.54.71.141])
 by smtp.gmail.com with ESMTPSA id
 w22-20020a170906131600b0099d9b50d786sm5182466ejb.199.2023.09.03.13.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Sep 2023 13:48:53 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Lee Jones <lee@kernel.org>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 01/10] dt-bindings: mfd: stm32f7: Add binding definition for
 CAN3
Date: Sun,  3 Sep 2023 22:48:40 +0200
Message-Id: <20230903204849.660722-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230903204849.660722-1-dario.binacchi@amarulasolutions.com>
References: <20230903204849.660722-1-dario.binacchi@amarulasolutions.com>
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

commit 8f3ef556f8e1a670895f59ef3f01e4e26edd63e3 Linux upstream.

Add binding definition for CAN3 peripheral.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/r/20230423172528.1398158-2-dario.binacchi@amarulasolutions.com
Signed-off-by: Lee Jones <lee@kernel.org>
---

 include/dt-bindings/mfd/stm32f7-rcc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/mfd/stm32f7-rcc.h b/include/dt-bindings/mfd/stm32f7-rcc.h
index ba5cb7456ee4..a4e4f9271395 100644
--- a/include/dt-bindings/mfd/stm32f7-rcc.h
+++ b/include/dt-bindings/mfd/stm32f7-rcc.h
@@ -64,6 +64,7 @@
 #define STM32F7_RCC_APB1_TIM14		8
 #define STM32F7_RCC_APB1_LPTIM1		9
 #define STM32F7_RCC_APB1_WWDG		11
+#define STM32F7_RCC_APB1_CAN3		13
 #define STM32F7_RCC_APB1_SPI2		14
 #define STM32F7_RCC_APB1_SPI3		15
 #define STM32F7_RCC_APB1_SPDIFRX	16
-- 
2.34.1

