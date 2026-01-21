Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C44D262AD
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 00:37:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 589738341A;
	Wed, 21 Jan 2026 01:37:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OXCV/Qka";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5436A8397D; Wed, 21 Jan 2026 01:37:08 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C350182A9E
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 01:37:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42fbc305914so4838519f8f.0
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 16:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768955825; x=1769560625; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZssFPpYMFyXgz9n34iixGVx3tGI/ZwV1nAlA68XaX7k=;
 b=OXCV/Qka4j4RBz/nv26wi+XXD1iDxaaS/3GM6yu0EG6gUoRo5iIxgdqoIfs9i2w0AB
 peF9E8CzsjMwkxkWIofPih1ajx8pNQnWG0l1jv3VF2EG+Q5NCa5+mU/eesMIy4o/UVEF
 AcwAPNh/FJFUTbVvr2uI2t0EQSMnrlcJTOMcO2QN0QJHIR/05azoxveCxMxNSRbuMzHK
 TdXrc6Gnrz1g+7/HOdjCvuJL12Z6GRUnbZ9qs9HkVW9lE7lCiY5yY7j9KuCcrgR+J0NU
 uxsk5MkT7IhDTBrqQk2Mrojre1D54Sq7N2v7v4EIAgBbkxKpIXZXR1FF1uRQw2Cg75si
 iTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768955825; x=1769560625;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZssFPpYMFyXgz9n34iixGVx3tGI/ZwV1nAlA68XaX7k=;
 b=GP7GKxkll5Oo2ko8RkIUk9tGNOlgzEAerYAZLqGYPToEjdUuoH4ES20odEe5JECcWI
 QAhGfKsEXvQJFeL0RiVfQ9vFzz7KkK2wW0+5yPd1FU3BMia9vH7e7kcorUU3WMpLBYRv
 UHv/QIw+IR07bXqEYYHSfzVgI2u6XUxVSPvZhw+EQB2SouS9WvETtc2oFLoy17eIY99f
 w/iI4ypDYEsDgDAwGD/00UJULPIBg6Y7liY/vdkhpdAy7rjYd6TMX0ese5iDcstffawI
 aIYi3P+XZqZpJkyn30rfHX4Xr5ugdUI1jPuSyCgPzmg2gLTXw2CwEumSCtN3dAoPGHa0
 ktAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHkrb8wYdjVM7EPq1EXXgoCDiR9OSx+g3xYErNxGdDMcByRtZ8IaTOKr+9VifIa6P/OeCo35o=@lists.denx.de
X-Gm-Message-State: AOJu0Yzk+Ub4DQ0Rbq8GAO65/FVhvNYfIWYC+/zQjlle5Opw5ymVUW8g
 nV6NMNga+N4+/JswydfSVKMXwGScyp5nxEF5cD0x0Kziy5yW/6OFVQwyc3n20/lwEe4=
X-Gm-Gg: AZuq6aKEfjCpABSwR8YpWA//0l2ixDdlxGitfshM+p2elFom/iARwEc+aWhFXVFM2TW
 0P1N2oSgNNjKSORvoQONG/QZkeS2c6mhrhFwA9g8awo+2IzkljooqI0yURkNC+sSVk++vvZeSRV
 bJ9bL2+hMBWZ+1ecZngaHK3mqe3Og1+/CNxuob+nvtRDFTAaTtYOo7tGUndJxh7kPxBBtUZo0Jm
 EMel19Y4W3YkLIulM62AB2Ahc1goRSYNeYU2mFsr7IKtdgXXbf3RPsdLBjbE2uz9dFGKlLyltLv
 fPnZOc8bHxAD7nFZElaXdQQaG1Ta9sXievUyP1hwHEDcD6s4m6zX/7QlbaUUeD/blj1tVi7BiIb
 m2OykqAcMb/YP41c5CrG8t14kpyjs3Cu4+hSJU7Vtk+nScNRbGviR1QuOZSlaUCKQug01E8r7o2
 shQOlB+u/HsasX9d4JbiFbm5p1iqE7kboL5DuwSr6/XZnvQm+kNJoCrXxc5y/RAqwdiD/siQ==
X-Received: by 2002:a05:6000:2585:b0:430:f97a:6f43 with SMTP id
 ffacd0b85a97d-4358ff32885mr6006407f8f.53.1768955825127; 
 Tue, 20 Jan 2026 16:37:05 -0800 (PST)
Received: from toyger.localdomain (p4fc3dfd7.dip0.t-ipconnect.de.
 [79.195.223.215]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43596090493sm3970344f8f.25.2026.01.20.16.37.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 16:37:04 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
To: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Gopinath Sekar <gopinath.sekar@oss.qualcomm.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Shmuel Leib Melamud <smelamud@redhat.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Sumit Garg <sumit.garg@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: [PATCH] watchdog: qcom: stop watchdog by default
Date: Wed, 21 Jan 2026 01:36:51 +0100
Message-ID: <20260121003659.69305-1-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.52.0
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

Prevent the Qualcomm watchdog from autostarting and ensure it's stopped
when the driver probed. In some cases the watchdog is left running by
a previous bootloader stage. Disable autostart so it isn't left running
when we boot into the OS, this behaviour can be changed by enabling
autostart in the board defconfig.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/watchdog/Kconfig    | 1 +
 drivers/watchdog/qcom-wdt.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 35ae7d106b1a..416d29d256a2 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -15,8 +15,9 @@ config WATCHDOG_AUTOSTART
 	bool "Automatically start watchdog timer"
 	depends on WDT
 	default n if ARCH_SUNXI
 	default n if ARCH_STM32MP
+	default n if ARCH_SNAPDRAGON
 	default y
 	help
 	  Automatically start watchdog timer and start servicing it during
 	  init phase. Enabled by default. Disable this option if you want
diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
index e4ebb1f31d4b..a8d7e7a79508 100644
--- a/drivers/watchdog/qcom-wdt.c
+++ b/drivers/watchdog/qcom-wdt.c
@@ -128,9 +128,9 @@ static int qcom_wdt_probe(struct udevice *dev)
 		return rate < 0 ? (int)rate : -EINVAL;
 
 	wdt->clk_rate = (ulong)rate;
 
-	return 0;
+	return qcom_wdt_stop(dev);
 }
 
 static const struct wdt_ops qcom_wdt_ops = {
 	.start = qcom_wdt_start,
-- 
2.52.0

