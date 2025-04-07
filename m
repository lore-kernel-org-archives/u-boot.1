Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C444C3600C
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 01:35:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB6C182CB0;
	Mon,  7 Apr 2025 03:35:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DD93s9Zx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3697682CB8; Mon,  7 Apr 2025 03:35:53 +0200 (CEST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4427582B9D
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 03:35:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-223fb0f619dso34980435ad.1
 for <u-boot@lists.denx.de>; Sun, 06 Apr 2025 18:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743989748; x=1744594548; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AF5RmirvyfqxExHwFlY4cl7F6/Dei/Y1EJbGOnVapEs=;
 b=DD93s9ZxfFNfqqTfNA2HUTqzc0CX85hS2w24uF/S2ymcMYaxdhsQV9W853gKIcrvMR
 trW2a26Huwrr5Mm6dGLaBSMIVoxkDzNVHDO2Of3nVjOa96juVwI9KsOCJMD7k/ZqwPOE
 9pP0+BEj+9AMyUHf03WtPezP6J+x+etm0XQu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743989748; x=1744594548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AF5RmirvyfqxExHwFlY4cl7F6/Dei/Y1EJbGOnVapEs=;
 b=KFexpAFiFKon0zjhiu+9G8rFfCAau/98ZmY4vk4OwFxUu1yWnsyi4dlcM8Ct569BZB
 tSygOHYZ9P4WDpaMavg8oOhRXnEIMLO13d36nT7kSw8znyeVGDOoOQNuGxa4ox9ClQN+
 QyJ8Nb83G1X1N193AEWsp8ommYfqrgvcA2eKyZR726cK/oRyGYhnSC2n6Z0tvG0OtTqa
 mhnR+g5s4QyxpWSIitYwnBdDPP0JWuPAk1gttRv4749XfFSN6FW9ZUAdl52h4QfERPA/
 9oxIB6uREvuFLdJJK3cusmQ4DQtrXwDp6N8+zR4XW5zR3nK9GPfE+iCLYxw4TUIkT5/U
 QD7g==
X-Gm-Message-State: AOJu0YzN+tbUBv349UrqsFb/+eTanu5NYs2pNCPYXqcfEsQDuj2hVLUw
 eRHJNCHyjKc/8l9IzD0TK01XpOuyMpgfGcKj12IJVKS595Ma0X3a+CjZ9MqbcVXHHWWRTJA9x7L
 X3w==
X-Gm-Gg: ASbGncsmSYgXli5p5O2TFOq0K7cXoZUc46bjBhhoG6A1Ue4NN7LffrNbv3rUUE/zzi+
 VVOVy8cJuHV4hND1u1e1RpligGQL4UXKX9pbsTQt/i+Dgz479lIp32FJQdPimLi+1iNH/Jk8J9b
 FxKioK62dLRskSagk+km8EauAcR/oCkVy2BUxVBMBpi3M+K7A3CEltEJmcswAar6GC9jdGVzXGP
 ro1r0itx/zIdJthsbqp9DRhDP/967Zc2loN3Lq/TyL3Yc+bKgKRgJGKixslNFEWtFQd/j+u4cPi
 OvKIekZ6vZfC9fCpLr1uSjQyTBZLEd1bsUs/eZ+P6VxEvrT1
X-Google-Smtp-Source: AGHT+IHpIhp4Qn8PFp2jdifcudSZ3jmYyL/TiQCE104ERfL1RSlgE5ZNwZvJj7nytPrUyFZxx/NOZw==
X-Received: by 2002:a17:902:ef0b:b0:21a:8300:b9ce with SMTP id
 d9443c01a7336-22a8a0b59fbmr151111045ad.49.1743989748051; 
 Sun, 06 Apr 2025 18:35:48 -0700 (PDT)
Received: from chromium.org ([161.29.84.47]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785adad8sm69535765ad.35.2025.04.06.18.35.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 18:35:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 neil.armstrong@linaro.org, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, Jim Liu <jim.t90615@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Parvathi Bhogaraju <pbhogaraju@microsoft.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Ramon Fried <rfried.dev@gmail.com>, u-boot-amlogic@groups.io
Subject: [PATCH v2 2/4] net: designware: Mark drivers as having active DMA
Date: Mon,  7 Apr 2025 13:35:08 +1200
Message-ID: <20250407013513.638110-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250407013513.638110-1-sjg@chromium.org>
References: <20250407013513.638110-1-sjg@chromium.org>
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

Network devices which use this driver have DMA running while receiving
packages. Add the required flag to driver model so that they will be
removed before starting the OS.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add a new patch to mark drivers as having active DMA

 drivers/net/designware.c    | 2 +-
 drivers/net/dwmac_meson8b.c | 2 +-
 drivers/net/dwmac_s700.c    | 2 +-
 drivers/net/dwmac_socfpga.c | 2 +-
 drivers/net/gmac_rockchip.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index 5385849ea6b..9b2b0a5d602 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -885,7 +885,7 @@ U_BOOT_DRIVER(eth_designware) = {
 	.ops	= &designware_eth_ops,
 	.priv_auto	= sizeof(struct dw_eth_dev),
 	.plat_auto	= sizeof(struct dw_eth_pdata),
-	.flags = DM_FLAG_ALLOC_PRIV_DMA,
+	.flags = DM_FLAG_ALLOC_PRIV_DMA | DM_FLAG_ACTIVE_DMA,
 };
 
 static struct pci_device_id supported[] = {
diff --git a/drivers/net/dwmac_meson8b.c b/drivers/net/dwmac_meson8b.c
index bf94e50842d..95a99a98e99 100644
--- a/drivers/net/dwmac_meson8b.c
+++ b/drivers/net/dwmac_meson8b.c
@@ -162,5 +162,5 @@ U_BOOT_DRIVER(dwmac_meson8b) = {
 	.ops		= &designware_eth_ops,
 	.priv_auto	= sizeof(struct dw_eth_dev),
 	.plat_auto	= sizeof(struct dwmac_meson8b_plat),
-	.flags		= DM_FLAG_ALLOC_PRIV_DMA,
+	.flags		= DM_FLAG_ALLOC_PRIV_DMA | DM_FLAG_ACTIVE_DMA,
 };
diff --git a/drivers/net/dwmac_s700.c b/drivers/net/dwmac_s700.c
index e78193f3376..21df8e3ce81 100644
--- a/drivers/net/dwmac_s700.c
+++ b/drivers/net/dwmac_s700.c
@@ -64,5 +64,5 @@ U_BOOT_DRIVER(dwmac_s700) = {
 	.ops    = &designware_eth_ops,
 	.priv_auto	= sizeof(struct dw_eth_dev),
 	.plat_auto	= sizeof(struct eth_pdata),
-	.flags = DM_FLAG_ALLOC_PRIV_DMA,
+	.flags = DM_FLAG_ALLOC_PRIV_DMA | DM_FLAG_ACTIVE_DMA,
 };
diff --git a/drivers/net/dwmac_socfpga.c b/drivers/net/dwmac_socfpga.c
index dda33f90d65..9f262aaee60 100644
--- a/drivers/net/dwmac_socfpga.c
+++ b/drivers/net/dwmac_socfpga.c
@@ -145,5 +145,5 @@ U_BOOT_DRIVER(dwmac_socfpga) = {
 	.ops		= &designware_eth_ops,
 	.priv_auto	= sizeof(struct dw_eth_dev),
 	.plat_auto	= sizeof(struct dwmac_socfpga_plat),
-	.flags		= DM_FLAG_ALLOC_PRIV_DMA,
+	.flags		= DM_FLAG_ALLOC_PRIV_DMA | DM_FLAG_ACTIVE_DMA,
 };
diff --git a/drivers/net/gmac_rockchip.c b/drivers/net/gmac_rockchip.c
index 5c542d62bd8..52be3a5687f 100644
--- a/drivers/net/gmac_rockchip.c
+++ b/drivers/net/gmac_rockchip.c
@@ -760,5 +760,5 @@ U_BOOT_DRIVER(eth_gmac_rockchip) = {
 	.ops	= &gmac_rockchip_eth_ops,
 	.priv_auto	= sizeof(struct dw_eth_dev),
 	.plat_auto	= sizeof(struct gmac_rockchip_plat),
-	.flags = DM_FLAG_ALLOC_PRIV_DMA,
+	.flags = DM_FLAG_ALLOC_PRIV_DMA | DM_FLAG_ACTIVE_DMA,
 };
-- 
2.43.0

