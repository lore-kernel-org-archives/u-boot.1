Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569C7C83F01
	for <u-boot@archiver.kernel.org>; Sun, 27 Aug 2023 08:21:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E043784702;
	Sun, 27 Aug 2023 10:21:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BxLVCulP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BAEF86177; Sun, 27 Aug 2023 10:21:34 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02C3684B20
 for <u-boot@lists.denx.de>; Sun, 27 Aug 2023 10:21:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-99c4923195dso268291066b.2
 for <u-boot@lists.denx.de>; Sun, 27 Aug 2023 01:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693124489; x=1693729289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VWPD7jJgudMcQ465nZQXIm308+0rV5CUNp5J9ozOswI=;
 b=BxLVCulPH1zLfVC09San5kQLiT/A3jvOP8P2E9oi9yr/bXkDOM3Kxww2AD1X94mqC3
 dgFjJiTvlr4n8qf9Q0jMtqWOkppwBOQ7z++sCHIgUiJWjjyGU8D8VbZ9vGpeC6jkAdap
 YlQpHQ7Yq0tTtvjjfKxE0yfrjzTwk6fRHzLNAd4Yu9djdOa5hlrF00B+NadBES3CefuR
 ewyqHMaRjWcLv9t6+txD3b6LeaGaSWRK0t5sAE82wOCwJcSXyZVg0eP0ryTIG2iRulAA
 jec7QFMxELJstoxo1TzWJKoJ0ozhVmbXcTHK6/9dyIOLgUm1EqyeSA2lctS5zKfJClEI
 4gbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693124489; x=1693729289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VWPD7jJgudMcQ465nZQXIm308+0rV5CUNp5J9ozOswI=;
 b=NlpTv1yQGn7+uZlu7GRNfiuXKzEzgQNLIZQWK+P99z4oA5R3fLq8c/JoqhW5Wz7xv8
 +OmW2vch8zYy6FAkLxDeK1BRDdQZkL5z9nwQIb+nha9Izasq4eZYd5pInGJnlAMgIXLJ
 k/uBHHzElTlJfExXLS5/AjTpZBZfsQmQO/EO14131qzLP0+nl4oK6CQO3vNPXcJ17JZd
 IRfgBtIIpGmbHBPxAb3Jvd633C4OiAVZr/pA21uMdcW2DideMVXiRjP2OOWv1DTVEACU
 yKXUJgn+TQ60rYUs2KyS8KTrZmeUgv8BxUN1tPdSSXe9Omd2YBs9NC504ysLIwMy5bxZ
 S9Ow==
X-Gm-Message-State: AOJu0YwSwl/XH/8/N/Yrq12zv3FsbUZTD9RP6upn4JyC6obtXn7wkTwj
 qrcE8mN+lHzCAYe7UUwJ8cQ=
X-Google-Smtp-Source: AGHT+IG733jWDQNRCREv5iK0JmFupj15o9g7+TDtmRXeLJOb+4suhKtajZl6X3/ReKMGIJtH1TmNpg==
X-Received: by 2002:a17:906:18:b0:9a1:c42e:5e5e with SMTP id
 24-20020a170906001800b009a1c42e5e5emr11833257eja.42.1693124489225; 
 Sun, 27 Aug 2023 01:21:29 -0700 (PDT)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 i10-20020a170906250a00b0099b5a71b0bfsm3153433ejb.94.2023.08.27.01.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Aug 2023 01:21:29 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 2/6] arm: mach-tegra: enable sysreset driver
Date: Sun, 27 Aug 2023 11:21:02 +0300
Message-Id: <20230827082106.6255-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230827082106.6255-1-clamor95@gmail.com>
References: <20230827082106.6255-1-clamor95@gmail.com>
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

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/mach-tegra/Kconfig | 3 +++
 arch/arm/mach-tegra/pmc.c   | 9 ---------
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 464bd0798f..453f94bcf2 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -61,6 +61,9 @@ config TEGRA_COMMON
 	select MISC
 	select OF_CONTROL
 	select SPI
+	select SYSRESET
+	select SPL_SYSRESET
+	select SYSRESET_TEGRA
 	imply CMD_DM
 	imply CRC32_VERIFY
 
diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c
index 8d617bee63..c4f5106750 100644
--- a/arch/arm/mach-tegra/pmc.c
+++ b/arch/arm/mach-tegra/pmc.c
@@ -84,12 +84,3 @@ void tegra_pmc_writel(u32 value, unsigned long offset)
 
 	writel(value, NV_PA_PMC_BASE + offset);
 }
-
-void reset_cpu(void)
-{
-	u32 value;
-
-	value = tegra_pmc_readl(PMC_CNTRL);
-	value |= PMC_CNTRL_MAIN_RST;
-	tegra_pmc_writel(value, PMC_CNTRL);
-}
-- 
2.39.2

