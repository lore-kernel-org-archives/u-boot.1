Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29C3C02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 02:07:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8F1B806FB;
	Wed, 15 Jan 2025 03:07:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LipUcXth";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC758806FB; Wed, 15 Jan 2025 03:07:42 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 597F4806FB
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 03:07:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6d8e8445219so54886496d6.0
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 18:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736906859; x=1737511659; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rOLQUoLgXZV8xkRvSRYHbZkxaBxVKWjPEGa68lA4g3Y=;
 b=LipUcXthM9qCEn3OmNPG3BWDRBLuhIlb2tDKnjHMuVLrA8s0lu6EOx7z2EL1BsMUpY
 9q0nw8X40UEDicajVh7+0QiZR2iX8xzQAi8rTO8f9v/r/rMnRysem9uBRMs0IA4YKLUH
 J4DF/HiEuSWFJMVDZOhIzUz8MrE6R4JUL9Q6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736906859; x=1737511659;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rOLQUoLgXZV8xkRvSRYHbZkxaBxVKWjPEGa68lA4g3Y=;
 b=A2gwBoO+wq/rr6MZrkYcbd9CCDhkVDpdmsR2oNLWWOVoHv5ztvMfsoDx6pU7pES9tt
 0qaak1+K9NXIlaMYRL0Uca5OloTIq5V+MshTlr0bfOleqa4BX3OxK4DE5zTREpRyQ04N
 h2R4ONDVDA8uFaiNLiQzJRNt2wuRKAiHUslbkcZMB+n4XLzbe1git2aXYiq3VWadmUjq
 M587cSYFVwo3meFdTUpKJse/pySw6AW6nDDL+pW56VaS0H/c7/QlBvDJb0ObulFgy/Ca
 wF7FPOMB8swAHqR56V7nZyiIezzXlyHYbWPE6OIZ25eMDwWtNe4Jzl7ufEaXYDMtBvnz
 E/wg==
X-Gm-Message-State: AOJu0YzC/rdjnxOPHlfqcCHMgbUYHLdE3FI6DqSziBvcqj8d9bbNoWcD
 0t+8fY9mM4ylJNxGSBp4vNMQvhIeIncvmMeNdDhsuqYZUioUmRVCMXiKbsSh5aPy61cab8LWJYW
 E
X-Gm-Gg: ASbGncskt8oKk7zLJhZGWhrdJHKtdp/kA7p1n6tUnUg4T8s+teXD5H7J76lOWL1aaGS
 eAHQcy27jo5pLZ2JoZzvEi9CNi3cXApDiSNmnQ/sqb1rVgpaLxKXyEPi0tgESoxDl49MGQXCbfe
 Vr1Cz99640d+dRwgLxLaNZO9ULsr40LqGjTl6vVHxbcupPRwnSc3hxtB/qMXbpxNnaOpHdwFfet
 rWJ88xMEBI/jpdxib3Sy6akIzIQ8ndQHJxGOgYmbLTia6WvUiQZ54hAI2mJDql95Qaq/7hAEXC4
X-Google-Smtp-Source: AGHT+IGNU6vDW1Jit+CQ3JeTyRZztXRqeh4RY3KFBoLb55LLD+0yWnPigONFCBa99xzAkTrBotMcRA==
X-Received: by 2002:a05:6214:1d0a:b0:6d8:9e9d:c223 with SMTP id
 6a1803df08f44-6df9b1cee68mr495899916d6.7.1736906859350; 
 Tue, 14 Jan 2025 18:07:39 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.16.9])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfadeb3e69sm59388056d6.124.2025.01.14.18.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 18:07:38 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>,
	Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: Kconfig: Correct dependencies SDHCI ADMA options
Date: Tue, 14 Jan 2025 20:07:36 -0600
Message-ID: <20250115020737.230558-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

The option MMC_SDHCI_ADMA_FORCE_32BIT is only tested or used when
MMC_SDHCI_ADMA or SPL_MMC_SDHCI_ADMA is enabled. And for
MMC_SDHCI_ADMA_64BIT the same is true except we also require
MMC_SDHCI_ADMA_FORCE_32BIT to be disabled.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index f4fdf15242ce..6dc8d3bf9fe2 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -527,6 +527,7 @@ config SPL_MMC_SDHCI_ADMA
 
 config MMC_SDHCI_ADMA_FORCE_32BIT
 	bool "Force 32 bit mode for ADMA on 64 bit platforms"
+	depends on MMC_SDHCI_ADMA || SPL_MMC_SDHCI_ADMA
 	help
 	  This forces SDHCI ADMA to be built for 32 bit descriptors, even
 	  on a 64 bit platform where they would otherwise be assumed to
@@ -536,6 +537,7 @@ config MMC_SDHCI_ADMA_FORCE_32BIT
 
 config MMC_SDHCI_ADMA_64BIT
 	bool "Use SHDCI ADMA with 64 bit descriptors"
+	depends on MMC_SDHCI_ADMA || SPL_MMC_SDHCI_ADMA
 	depends on !MMC_SDHCI_ADMA_FORCE_32BIT
 	default y if DMA_ADDR_T_64BIT
 	help
-- 
2.43.0

