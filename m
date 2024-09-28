Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696BECF6491
	for <u-boot@archiver.kernel.org>; Sat, 28 Sep 2024 20:02:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08CEC88CC8;
	Sat, 28 Sep 2024 22:00:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oWcKyAdX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BC9688CC7; Sat, 28 Sep 2024 22:00:55 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6F3188CEC
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 22:00:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-82cd869453eso117449939f.0
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 13:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727553651; x=1728158451; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ut7HIhYHM8eegh+J6/R4btpbH4fm6wFrWmk6mXL0360=;
 b=oWcKyAdXkO5RcAQpMc7J1oqEAiv/8EMArWpUpHfl1vbCF6G0aDYVIa6UQ48k7Hpwwd
 9vMIz3Q1lVEmrzfrEgYOOOYdYAtle76WWMQ5m+DV5vaV9OJR3pfQ0JT02cJ8Ub1cCc4U
 pMK9iCP2L4FlcJUwQc4JM550Rc6DFXiU2jP2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727553651; x=1728158451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ut7HIhYHM8eegh+J6/R4btpbH4fm6wFrWmk6mXL0360=;
 b=OdBblljspX0qH49eO6UwAcJH9B2TsQQWJquXh0J1z8+9OAE7sOL0S7kD6IaJtA8ZvD
 ZpUNtGEtNC6cRZbGoD7Mi+DNCgdC3YjFSqxOLi7+13NLMLBEi7uenpCqKRaezumtVk4U
 /uNjoCGW+r418ldZ5PfKIXG8xKs1vmWStT6NHSDNwIon6s5nty61ssP4jUnkET0TBtFc
 cTFFwjbjT8AgWoI/aF5f0PgO0x2FOUcASpaLK0URsKyC6O+k1VqG0EEgb47kCewUEFJI
 Hc0frLbVCSq6FKl5EzxHmSEt9ArT0tesCnrDbeCcE7Xh2WcgogAUcNKoU9sYjn4ZmDO4
 2QWg==
X-Gm-Message-State: AOJu0YyGAPrfWwZL0pScNRWtA7yHxQoSj4IOrrwy0lqRZw1C20O1NBmw
 r2MAe6SN3fTlD0nQw73dcZ/xzpca1gyBUL+XpETFHDMJVV9bS/e/LhOLQM1E+RrF5SP5e1AkzGF
 peg==
X-Google-Smtp-Source: AGHT+IH+eVWrAUGUOdHg+XiF4IT+0TBQQ20Z4aYLXnwBdfkJuSBZ6o0ZqfcLHEf6hj3C0DTL7AxW8w==
X-Received: by 2002:a05:6602:140f:b0:82d:314:23c0 with SMTP id
 ca18e2360f4ac-834931de761mr806586539f.6.1727553651400; 
 Sat, 28 Sep 2024 13:00:51 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4d888835307sm1242590173.2.2024.09.28.13.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Sep 2024 13:00:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Tom Warren <twarren@nvidia.com>
Subject: [PATCH v2 09/30] tegra: Use SPL instead of SPL_BUILD
Date: Sat, 28 Sep 2024 14:00:09 -0600
Message-Id: <20240928200030.194546-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240928200030.194546-1-sjg@chromium.org>
References: <20240928200030.194546-1-sjg@chromium.org>
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

SPL_BUILD is not a Kconfig symbol so perhaps the intent here is to
use SPL instead. But that changes the output size.

So drop the dependency on !SPL_BUILD since it does nothing.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/mach-tegra/tegra124/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/tegra124/Kconfig b/arch/arm/mach-tegra/tegra124/Kconfig
index fb016aa46c9..84c8f86bad0 100644
--- a/arch/arm/mach-tegra/tegra124/Kconfig
+++ b/arch/arm/mach-tegra/tegra124/Kconfig
@@ -21,8 +21,8 @@ config TARGET_CEI_TK1_SOM
 	bool "Colorado Engineering Inc Tegra124 TK1-som board"
 	select ARCH_SUPPORT_PSCI
 	select BOARD_LATE_INIT
-	select CPU_V7_HAS_NONSEC if !SPL_BUILD
-	select CPU_V7_HAS_VIRT if !SPL_BUILD
+	select CPU_V7_HAS_NONSEC
+	select CPU_V7_HAS_VIRT
 	help
 	  The Colorado Engineering Tegra TK1-SOM is a very compact
 	  (51mmx58mm) board that is functionally almost the same as
-- 
2.34.1

