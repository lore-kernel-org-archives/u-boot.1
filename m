Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B011C2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 13:30:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DEEC82BB4;
	Thu, 15 May 2025 15:30:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="R7Sntq73";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD32C82BC1; Thu, 15 May 2025 15:30:42 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9C8A82BA7
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 15:30:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-441ab63a415so10079205e9.3
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 06:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1747315840; x=1747920640;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zOFCEvCnXwwyTnmpoZ9LlIu/qCiOsWgQbQw6htAZrd0=;
 b=R7Sntq73RyWIDlAvnuuFnIExZNWi1Ovs7JWQBcv9O+EW8+m3kJrZ7g98jx/1dmO0Ls
 lPrWYxtaZdJDxcyRDiD29I2Das8L617H+w0+9dsiQT6iLtVF8/U6vsFqBek44jwOsZY8
 6KYfNihJMOEI22ppPFb3IUqDox5tju56Ar++k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747315840; x=1747920640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zOFCEvCnXwwyTnmpoZ9LlIu/qCiOsWgQbQw6htAZrd0=;
 b=h8O7aK+icHHcZscbKyfhHZG1jITzC/Ak7d2l4lgQco5ZwAeSJFvgVDwz7vrMAa9h+B
 Hi7i3rc5K0RQMJG+9Gie22REw4YISyMCMNDFjRehgH4W/GHUNXywtJI8Q/TGNm/K3rS+
 SlJNXr+2e/tICV8/kSEKUNJ3rx155ZYI4z/PQEw+C9PkPapHmwQMZNNJ0JIr3zPZG/TB
 GHx7ju1oPLtxyohPYO4ao9s7Gd1jCN/h9fNg+2AEVzJmwfIoO0AJfLBrQm9h5cusP7In
 JO5M28Nei97dwYzzgZXVtIA0kZ8i73ZbXpmMyU14bgmbGicsjfKKuDWq7ZJY5Kdh7a5I
 ojPw==
X-Gm-Message-State: AOJu0YwXF8rQ0WpzSDpDd9xrnT9RwQnuKsWADcP4QI+9zrOfeWGve2V9
 mahTWAJo9q0v4lSiyXKwlF5X9yHG0dcWQMXi01agCZkq5sxKPWCoomhEPPT6gRMwZN76pLmHbmB
 rtGk=
X-Gm-Gg: ASbGncup2X+BO8OYsjGpHNsn+K/Q3Y6oWidlODpizYx0kefg2Zlj9i9WJLrZRzT0hVF
 ho/RvWNNpSJ1K2BXo8lbfx8SKwRddEat8EsiJ01S26f7AJIIVPM1b6vA215QJ8thi6ofuyTgNnd
 RpMvx3kFET2NweD2o2g6SpM2fRIwYorixx/lmnb4GpgtlqbTBCs1oWC7/km8rOuZVoP8o3nPtCf
 biA6YGoU+RkKa8RhPU/o1CtWGfZD74FIRNCRuTuyirif6g2km3X55bWBPThUxC+iOFnRZUJf1jB
 Y+neU2ygcLSv0rG612TjrBDs6CLhnvQ+7uw+hVbrQ79CCSzYpWXniPtDXkc1hyuwcdlDnA/bNo5
 0C4c5fhrjKhssiRQs2H3sx5ixH/XfbnzzEmukHi76hHHB3DSiYTYvWQ==
X-Google-Smtp-Source: AGHT+IEmnN7CFxFXtVt+P+UA78kXqRNyD8WsQZ4N8YyLvpTUECAvn+NoiM38uY2Jn93KgwztD7uZ7w==
X-Received: by 2002:a05:600c:3d0b:b0:442:d9f2:c74e with SMTP id
 5b1f17b1804b1-442f2168ce4mr65321415e9.23.1747315839687; 
 Thu, 15 May 2025 06:30:39 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.client.m3-hotspots.de
 ([46.189.28.43]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f397b6fbsm70186185e9.39.2025.05.15.06.30.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 06:30:39 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Paul Geurts <paul.geurts@prodrive-technologies.com>,
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/2] arm: imx: imx8m: soc: replace ifdef by IS_ENABLED()
Date: Thu, 15 May 2025 15:30:23 +0200
Message-ID: <20250515133035.815572-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515133035.815572-1-dario.binacchi@amarulasolutions.com>
References: <20250515133035.815572-1-dario.binacchi@amarulasolutions.com>
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

Standardize on using the IS_ENABLED macro.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

(no changes since v1)

 arch/arm/mach-imx/imx8m/soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
index 806adcf145fa..6c53555d22bf 100644
--- a/arch/arm/mach-imx/imx8m/soc.c
+++ b/arch/arm/mach-imx/imx8m/soc.c
@@ -791,7 +791,7 @@ int boot_mode_getprisec(void)
 #endif
 
 #if defined(CONFIG_IMX8MN) || defined(CONFIG_IMX8MP)
-#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
+#if IS_ENABLED(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION)
 #define IMG_CNTN_SET1_OFFSET	GENMASK(22, 19)
 unsigned long arch_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
 						unsigned long raw_sect)
-- 
2.43.0

base-commit: 1b5e435102aa29a665119430196cb366ce36a01b
branch: fix-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
