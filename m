Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CA6C00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 07:50:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6457E8714D;
	Tue, 24 Oct 2023 09:49:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bIK69JXI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C62AA8713C; Tue, 24 Oct 2023 09:49:31 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11C588714D
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 09:49:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-507c8316abcso5625875e87.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 00:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698133765; x=1698738565; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0yixJ95LD7IF33iObsix8fF4ui9f7tZ7u5fIJCclLZg=;
 b=bIK69JXI085mPft2vNC5UI2HdQMEkT+vyGISwsMURmisUozApLayuU8e7P06lNV94b
 IngvnHKPUM8kjwGaZj7nLqASMi+891EyGOV66PSP2gfy4d6OwOZUD0Vn/xklec/H2k5s
 H0RN1l+2/Uoewe19TqcQg0MIyf12jvHlMIMS4pstH61pw7+j0FSQC6MLMBKBpo/P/mOA
 iWl3fC7cVl/Rw03I6Te1WGchmNQcWthr8PlfBfUpDJSQx/hwqDIhP8h4wwZ+rVZVmRlF
 ZCYs64lNr2a072m7ijdQmzk84QbPC/gqn5iqrEs9lb66UTDwZGShRV+lJjWbOb+fXS0b
 0aZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698133765; x=1698738565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0yixJ95LD7IF33iObsix8fF4ui9f7tZ7u5fIJCclLZg=;
 b=QGBkZDhFNscwS5+bHBWvoW5YPy4WDyjqLmxel+73ZHGF9cwBIWSuqyhDQmQiERvbfv
 PUto4tIw7TKSPW69JMmR84u8wDnouI4pur3q2rq+3sManscoAopQXYHdjNlPHmsIM+6L
 BHjuj4AHQdkhZ3UuAxEJd3Km/8WQHP41Ut4Ah9jHFJvlxaWUtb5++lmm/qhWRPj9z69+
 59AgQUdlwjq2ruF3e2IsY/rErt0aYh+vPbokOxSk4Oy6AoXokttjl9abiVNy96Ab8hxt
 Hy/u8OKfjAlR95RuO6ceoPn7w1p0aWonkDGvhaGoHwqWxwn1gToocQ9WBzS974oAMiwZ
 5oBw==
X-Gm-Message-State: AOJu0YyyIRNM2E6nCSSdwNkgw2UKw5LYNUdKzekMZ8eLhkvVl2aZA5Q0
 CoA5GgUx4nqmJ1y4TpBftLw=
X-Google-Smtp-Source: AGHT+IGAapJS+382VIQvzJIkoYFTYvcl9i5RERI5WslyGqSpbsyARAj0n+gklXZai74ZVOvm6enn6A==
X-Received: by 2002:a19:ee16:0:b0:507:a5e7:724 with SMTP id
 g22-20020a19ee16000000b00507a5e70724mr7822096lfb.38.1698133765198; 
 Tue, 24 Oct 2023 00:49:25 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 v25-20020ac25939000000b00507a89ef9bbsm2011741lfi.166.2023.10.24.00.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 00:49:24 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v4 2/6] arm: mach-tegra: enable sysreset driver
Date: Tue, 24 Oct 2023 10:49:04 +0300
Message-Id: <20231024074908.199903-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231024074908.199903-1-clamor95@gmail.com>
References: <20231024074908.199903-1-clamor95@gmail.com>
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
index 464bd0798f..bbbab8624b 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -61,6 +61,9 @@ config TEGRA_COMMON
 	select MISC
 	select OF_CONTROL
 	select SPI
+	select SYSRESET
+	select SPL_SYSRESET if SPL
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

