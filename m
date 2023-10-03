Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 258AFE7542B
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 06:41:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 372F787462;
	Tue,  3 Oct 2023 08:40:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XelsUycP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2EF687458; Tue,  3 Oct 2023 08:40:57 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB10187240
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 08:40:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5031ccf004cso600795e87.2
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 23:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696315255; x=1696920055; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VWPD7jJgudMcQ465nZQXIm308+0rV5CUNp5J9ozOswI=;
 b=XelsUycPQ+Xr6S5OQyolk3tohpJAUPdPgbQRBHE7EdKEKSc146mjZafG2D18sBsFEu
 JpRPstwFNXV/TPRNiA3lLqJYZJTf+iA1mRcQKm55T/urRTWRHO1SqIK3PuDqOeDQihV/
 aMHtV7HyURpCF+fzPM+oqTpWiBXV/uV9amUuwZU/R9+3bzvKp4kFM+pSSDlSDvmqlw3i
 nt1guivv55UixZ40WZN1nc597JYTrZUQmWq3kEkpcn3f24xEJI/MWasHrHNHZhCbxaWy
 EIlouOHbwXdwjZYH29An2odzftgVwI6ddlGTCSj5liB09W5qc5axMxfs8ct8ZnE8JzkV
 peWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696315255; x=1696920055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VWPD7jJgudMcQ465nZQXIm308+0rV5CUNp5J9ozOswI=;
 b=nXX099kpvzlz3Gzu/lsufLSC6MjEu/bGmUgOGCKNT/Yz/1hvpReSrNdk6PwYZ9TAQi
 DUNZbHuUdLlWxwHZeVCd7dWPcJ79CiC7q4fLie7lFGihnWWg46uIi0yssHJfMpsEUObN
 M9akCkgfAAEIauRgEm9fnN2eZlwyp55XzRXb3VaVubbmDz70ZVivDpLhWcir0LuSNkcZ
 6rI5Pmz4YQlu8wRunHVAnfRi0oMfhEoNWhcw0zteM43oAaPp4NKbrxYCJk6zAQv1GmbE
 R+CH0/e6b4GxDs3Fh4ye/2sExefC4iwlIlba6WD9VCOJdcecnMNk4IPoBj5YdwoX2vkp
 UEzQ==
X-Gm-Message-State: AOJu0Ywhhqe47LcgwDtQ5j3/OycmCdxWzQJ5d7JgKJxX4Q3wAjnzGH5I
 hqURWq3E9smXxJhUjCqzi/M=
X-Google-Smtp-Source: AGHT+IEewskwgYrvDXSysVrTp/PnZTQRrQGZ0jFyGIGxUbrHwtL7PaWV4A6jJW2tDHd+G7Zeh9NG0A==
X-Received: by 2002:a05:6512:ac9:b0:4f3:9136:9cd0 with SMTP id
 n9-20020a0565120ac900b004f391369cd0mr12742227lfu.44.1696315255053; 
 Mon, 02 Oct 2023 23:40:55 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 x12-20020ac25dcc000000b004fe202a5c7csm79730lfq.135.2023.10.02.23.40.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 23:40:54 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 2/6] arm: mach-tegra: enable sysreset driver
Date: Tue,  3 Oct 2023 09:40:38 +0300
Message-Id: <20231003064042.43201-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003064042.43201-1-clamor95@gmail.com>
References: <20231003064042.43201-1-clamor95@gmail.com>
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

