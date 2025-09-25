Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08EFCAC5B0
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 20:44:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F0FC82A9E;
	Thu, 25 Sep 2025 22:44:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cauyYuQ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 034C083445; Thu, 25 Sep 2025 22:44:20 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA775809A5
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 22:44:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-74c7d98935eso726456a34.1
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 13:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758833056; x=1759437856; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tStO7K4fo3WQ1xnd72W+04FQ0hQ249S+sZzMVU0IcSE=;
 b=cauyYuQ/Sn1B2tKcnG9VZ8r/SvOodv63Yks4sydO+1xhye4rYnRD1iR9UAS5m+zGyf
 8vb42MheVA7+Fbi4baLd04PsFmhllkesEOq/i24X+GnHhlJRvgvqcoWKfGrrMSUY0Std
 cMNZ5AokmRP7yemQryxV3GIZgP0oypFjf87/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758833056; x=1759437856;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tStO7K4fo3WQ1xnd72W+04FQ0hQ249S+sZzMVU0IcSE=;
 b=Y12+vMDoQ19tNOx8utB8aJZOTQlJTOteoJlPzTuEfvoP+tk1XRsgaoAWJz9Z/2fykU
 iIbF+VRBScEO4VhM3K42KwKahRmCZtTUYahqnEUC+xuZFGNHerF9XRSkFnCghLKXJlXo
 Tr2zjyqmsJcGyvr6Cho35BvEyD23vk//BQKBQTtax5IdKMbz4R4vU6cx5za+ZbNos1Q1
 dqaGsbZO9/6L8ttLNk7a9dGuEzNHnvR0dbxHyOyb2DOW89hSqY3lk2f6UvPtAAo352Re
 yvaXtb02uaIkptECdX+DaAsFI3ko/O5zbTq0OTktsB1fjURW1xu87k+ZTr6MsNs2H24I
 D6XQ==
X-Gm-Message-State: AOJu0YzsWYn8nJVJE1DCjWr+aom0f9hgCbdJRHnVRZpqo+D2rPiB5XIG
 33bHfMnMk1HCKtcAlvcMFpTmGZzArLtELIKefeZkjSBrYg1bkKlFgap4kEyoY4LjZrKEYqhdnQq
 zMsRk9Bk=
X-Gm-Gg: ASbGnctqeymVXAP4PZw/Ab609m3MB+YMJzL/E4lT4+X1QS5SbGSZ35gnOhqNEWzEpMY
 9J/y9d7y0HrQUpNUcyY64ThkIz/teaWKZFxZyfGAbUgDGi0p25ACOYgm5I6cvq6HGkQjd+gJGfZ
 ma8bJNSrKsSXHc1JrCwOSK+SKCEiUlbVizEENkiCec26oUATkxYSFjbC2VatsrKedF5j4SNnZwI
 fTQutfZR5yvLisZeGxXKuO/NhPfuz8zQFebGZO4RMcj6A16WzBedTGXsK/jyNIYnWeVl86zBXiJ
 GYByRJAWxQAQqphL7qilPs4z7k5Lph2spkzo2WOH96DH6gBN58Yr/sG6gq7yN5iprDR4hexLFpd
 9XYoKuSkvBtsNNqz5p9ld+j2XVokwGgfyPcRlMcsim9sgY7W2nIE1NqinaUg=
X-Google-Smtp-Source: AGHT+IFQcDjEc3fJqb5EOGn6/LWDtjFhUiWKtZmK93QFqD+vfHgI05OhHFYYUKOZn1S/26G/L/sI5Q==
X-Received: by 2002:a05:6830:2783:b0:741:3929:31a with SMTP id
 46e09a7af769-7a03f673f9bmr2513159a34.12.1758833056272; 
 Thu, 25 Sep 2025 13:44:16 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7a23193d01bsm605790a34.8.2025.09.25.13.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 13:44:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>
Subject: [PATCH 1/4] arm: socfpga: Tighten a few more driver dependencies
Date: Thu, 25 Sep 2025 14:44:11 -0600
Message-ID: <20250925204414.3561033-1-trini@konsulko.com>
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

Some drivers which depend on SoCFPGA specific headers had not had
appropriate dependencies list in Kconfig. Add ARCH_SOCFPGA or
TARGET_SOCFPGA_SOC64 where appropriate.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Tien Fong Chee <tien.fong.chee@altera.com>
---
 drivers/net/Kconfig          | 4 ++--
 drivers/power/domain/Kconfig | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index d1cb69f85ad4..7c13055d606c 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -190,7 +190,7 @@ config DWC_ETH_XGMAC_SOCFPGA
 	bool "Synopsys DWC Ethernet XGMAC device support for SOCFPGA"
 	select REGMAP
 	select SYSCON
-	depends on DWC_ETH_XGMAC
+	depends on ARCH_SOCFPGA && DWC_ETH_XGMAC
 	default y if TARGET_SOCFPGA_AGILEX5
 	help
 	  The Synopsys Designware Ethernet XGMAC IP block with specific
@@ -376,7 +376,7 @@ config ETH_DESIGNWARE_SOCFPGA
 	select SYSCON
 	select DW_ALTDESCRIPTOR
 	bool "Altera SoCFPGA extras for Synopsys Designware Ethernet MAC"
-	depends on ETH_DESIGNWARE
+	depends on ARCH_SOCFPGA && ETH_DESIGNWARE
 	help
 	  The Altera SoCFPGA requires additional configuration of the
 	  Altera system manager to correctly interface with the PHY.
diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
index ebf5d828cb02..0ad885c9e8ba 100644
--- a/drivers/power/domain/Kconfig
+++ b/drivers/power/domain/Kconfig
@@ -20,7 +20,7 @@ config APPLE_PMGR_POWER_DOMAIN
 
 config AGILEX5_PMGR_POWER_DOMAIN
 	bool "Enable the Agilex5 PMGR power domain driver"
-	depends on SPL_POWER_DOMAIN
+	depends on SPL_POWER_DOMAIN && TARGET_SOCFPGA_SOC64
 	help
 	  Enable support for power gating peripherals' SRAM specified in
 	  the handoff data values obtained from the bitstream to reduce
-- 
2.43.0

