Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB55CAC5B8
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 15:32:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FE648383F;
	Fri, 26 Sep 2025 17:31:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IHXVImKa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F13E083857; Fri, 26 Sep 2025 17:31:47 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D8A08383F
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 17:31:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-911afafcc20so33398839f.3
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 08:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758900704; x=1759505504; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=FpJ3+FG6O8euyPeqcijPy8L9GZN638R0E5JSbUiPx/k=;
 b=IHXVImKaWddTmtJJc7ZBb7d/NWY8spydnRH47FeZREnPyqVdAUI1OrOLq41hqkIxsE
 bd4Ye809Bg0/4wLwRD43e/qTLOvu2ErWo+UsJfAij4sGXkLI/Yt6BDdLr3A/ddUsCXHP
 tOPLXgws19C5nbmuZRA6oSQbCUVrCg/nkTyc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758900704; x=1759505504;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FpJ3+FG6O8euyPeqcijPy8L9GZN638R0E5JSbUiPx/k=;
 b=Sdf1L6r13f6QFTBxyH38+zWuTgi8mKJmy/aKJfXviTTeberw+V9bruUwhYxEBIrzae
 Gfz3timxhs0HrJPZCBkK3kI0FLIXSKMmO6miwO1N5uwHVui5ai+XuFhWPEjX5jOuUJDB
 8jV4OlTZrjuRkqahRsGtFlXxPfuk3DUXDjEhgGXc/1Wz/4bxlIQVTIAAG9dgKn3hy5pA
 glJnpvaH3Y2ybSfwNmo5VIU37yc2JKChR2Zbovx0Qy4mTUdVBX3gOi9xGd6L04fVhWZT
 L6tllyVRQdJrKc5hoXPd+a8tEBjMWMTbERvk8hoXgDb0dDQkpjwO0lgIIxKcr0uBIKX3
 pUJQ==
X-Gm-Message-State: AOJu0YyUNQ2IqfnTvo1130/9GP+4vUm72VB0aKkFtzu+tG/ArFCQYJOd
 tGUt7AUPMBLvcaOwXrAzfHPFsn/hA+8AtMMTfq3ZFxHxOamZzsmKrvIuRxMFDqC6iexw8FfG6WQ
 jlBifV+o=
X-Gm-Gg: ASbGncvN/I653uMxszAwoBycgEDOr5yCT0/mO+eYoOmzf91XBhOKhgUe9kvJeD3v6wv
 U40FV4zQ6nY1Eh88ItaK6H+KD5el/p3gaezDyTRmDFhsTnvhXFYJBdI1PmDfTgneeno4RLgPwqL
 aq28UzyA5RR6RMswDTvSPRmqA5AHD8EhPmlP5viD4RBdBA3+pdhmdPYLakAdxYlS2R//UoRneGe
 74ev8UZO2EbO4gUZI8UGEs9SHsdaQTU2XSjRmcgr6Tpr6V9O6Jn6c16jluZXTHQwtOK+GUrBa4D
 KXMlaUJOkk+K9b9az9gXXEaTgnrjuBgy0a/i0henwAbH5mUGCWAHa+YD+rJD8oAgz2Zm2udzzIv
 CDBBkuThAVegdo3affybMXTK7gXi6my60ORrJ3VWj/BqvDq7ssEAy5E6P571/yrU3ayDs/g==
X-Google-Smtp-Source: AGHT+IEIFkyTXo3WRqSGUV8tdac2pkFDDWe79fp/JHNc50zT8/a5IMZQrIeIW+fSMK0oacm59aH84A==
X-Received: by 2002:a05:6e02:3e93:b0:425:2e8d:12c4 with SMTP id
 e9e14a558f8ab-425955fcf5amr112430865ab.3.1758900704161; 
 Fri, 26 Sep 2025 08:31:44 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-425c016c7f2sm22437215ab.36.2025.09.26.08.31.43
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 08:31:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] rng: Tighten some rng driver dependencies
Date: Fri, 26 Sep 2025 09:31:42 -0600
Message-ID: <20250926153142.3680917-1-trini@konsulko.com>
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

In this case, the NPCM RNG driver also provides some of the functions
that are implemented in the generic LIB_RAND file, so only allow this to
be built when that is disabled. The exynos RNG driver depends on ARM
SMCCC calls and so cannot be built outside of that. Express these
requirements in Kconfig as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/rng/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rng/Kconfig b/drivers/rng/Kconfig
index b35d8c66b9c6..19b2b7076774 100644
--- a/drivers/rng/Kconfig
+++ b/drivers/rng/Kconfig
@@ -40,7 +40,7 @@ config RNG_MSM
 
 config RNG_NPCM
 	bool "Nuvoton NPCM SoCs Random Number Generator support"
-	depends on DM_RNG
+	depends on DM_RNG && !LIB_RAND
 	help
 	  Enable random number generator on NPCM SoCs.
 	  This unit can provide 750 to 1000 random bits per second
@@ -122,7 +122,7 @@ config RNG_TURRIS_RWTM
 
 config RNG_EXYNOS
 	bool "Samsung Exynos True Random Number Generator support"
-	depends on DM_RNG
+	depends on DM_RNG && ARM
 	help
 	  Enable support for True Random Number Generator (TRNG) available on
 	  Exynos SoCs.
-- 
2.43.0

