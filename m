Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F96DCA0EDC
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 17:00:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B845839D7;
	Thu, 14 Aug 2025 19:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MWEOOMQp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BB72839E8; Thu, 14 Aug 2025 19:00:54 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C5A7839C7
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 19:00:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-32326e71c31so1265393a91.3
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 10:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755190850; x=1755795650; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AQ+oZ20YlsmqCEV7jL5OAtmKbyJcVxuGJQqKLDsPvl8=;
 b=MWEOOMQpd3kmFVR/C/W8S4h19rSvPPW+ELKO6RNxTCfZykCgnKHeo4hAoNvdMg4U0b
 +qutFPCYiD0HHvVmGq2bG1jK0v/5886tsRoQqgmLTAPb6herDn59QFFN7+UxBCVCbjva
 44sNq4+GBpd2wpDPLuxVl9fT7gZ+yva1OzaO0gPnbpsFcP0inKrTVrf9jdnOaRAlepku
 pxgK9u1SpHNRqjudv9M1rz5v4+PhcrYPWrh6hgyHp1jpW48xV81F9OAO8SUX1cjyaHk/
 Z9nuM9RpprFx5gjPX1a7M75xCizvqgZpyMNHPkZYKC0bcAS0PBFV6rBmdx/rm1cVWhnM
 Oguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755190850; x=1755795650;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AQ+oZ20YlsmqCEV7jL5OAtmKbyJcVxuGJQqKLDsPvl8=;
 b=rm6zB5TgQWPlqYHx3f3VqWjxi4J2DSSD22ansBF8lGdCPCx62AqozJgU+gNAolwO5w
 AAFx/5TYBILBJCnXntPEMi2JnOzZisjb1Z3CNGTf8raGDymF4B+nLv3BdSFIvRtU4cAU
 /vGEmqLANm0Kh2yK+RFCh040PePuFs2Ww6IE8VFhDvYNgHrY8zb9J8mWzMiJzaMGVklB
 LLG2icWV6WnsOeuSatW4QOaFp+ruxVHnbm+/hBn0dqB1/xdNiCVzwNsgebeOmWTmcJSl
 J5y6ns7KdLnQm4flJyPzewTvpX6ci6efwl9i0m+I08b9NAo+YZpxAsboQ7z2BUgEV0+c
 LCzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxA85iu/YHOvjBJCtW08lBvCkQNa+1TV9dbATau4Qfyt7yc5wInUsAndbzb4SLYFUCV9qezzw=@lists.denx.de
X-Gm-Message-State: AOJu0Yzx5ZWvh0hV59ca8rbimP85w07obLHc24/EJZtLNIzvydJzpsTx
 Nox+BxJkiHWlu6ZlIrEvp6rtQqRFUVhzz0MaFCUVyucn72dr6gEKdUz7
X-Gm-Gg: ASbGncuOQX/ud0cp3MG4ZENeRgxvZZ4daU/LhUVhqynJtdy6QJQh/31VAduWMGqroJg
 Ch9fZPGIYOfhrOpBb0/0YtbDnck4yVRuhT2qNp6Xlg7hAZTX2JoHSYi5KlaknDf7k32QuYH8hgM
 XDZgsin3ORa9Wk4HYrxpmBWj3sPgR6tCHTeYYahFm7O/G0oUazsHCh6F4DdBnnPoiD/zARfu/G4
 bSAiokFZmPSOnxORfp9UzwdKUuAKnl8pbx0xiyB+p2VoZ5tZQOVU+8BtXdkIz79gsOSeRCKaGeo
 bJ0q3FPZukwNwlOQztJRy5geSUVWtq1kyumg99iC9LWrLE+1bGHX5GgjBAeyde6+lZRcQrddIwp
 azPzewkpo0TpSLuC4smNfyrqhaLJZ6KCUXxk=
X-Google-Smtp-Source: AGHT+IEaw9J5cHoPPk0iNsPE1kKTlQueHvj69TN3Ph6ai2u9jZjn9W5bLrzMVrc/3THKnOW9ygFN6Q==
X-Received: by 2002:a17:90b:3912:b0:31f:32f:3a87 with SMTP id
 98e67ed59e1d1-32327a8b9d6mr5687138a91.26.1755190850413; 
 Thu, 14 Aug 2025 10:00:50 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:f50d:900e:961:a245])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32330fc986asm2374382a91.14.2025.08.14.10.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 10:00:49 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: tuomas.tynkkynen@iki.fi, jan.kiszka@siemens.com, u-boot@lists.denx.de,
 heinrich.schuchardt@canonical.com, mark.kettenis@xs4all.nl,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/2] Kconfig: Convert SYS_EARLY_PCI_INIT to Kconfig
Date: Thu, 14 Aug 2025 13:59:31 -0300
Message-Id: <20250814165932.1584854-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The CONFIG_SYS_EARLY_PCI_INIT symbol is currently not supported
by Kconfig.

Make it a Kconfig symbol so that users could select it via defconfig.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 common/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/common/Kconfig b/common/Kconfig
index a2f653f7e722..cb17f0561537 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -833,6 +833,13 @@ config PCI_INIT_R
 	  case of DM PCI-based Ethernet devices, which will not be detected
 	  without having the enumeration performed earlier.
 
+config SYS_EARLY_PCI_INIT
+	bool "Enumerate PCI buses early during init"
+	depends on PCI
+	help
+	  Do early PCI configuration before the eMMC gets initialised,
+	  because PCI resources are crucial for eMMC access on some boards.
+
 config RESET_PHY_R
 	bool "Reset ethernet PHY during init"
 	help
-- 
2.34.1

