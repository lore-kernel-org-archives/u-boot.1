Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E75A3109C058
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 19:02:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFF2F84120;
	Wed, 25 Mar 2026 20:00:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Izv7mqrs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E2708410C; Wed, 25 Mar 2026 20:00:47 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0301783A1B
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 20:00:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-46726528f1cso97403b6e.0
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 12:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774465244; x=1775070044; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ABPkWaf0Cqmsau+j4YHECueH0VZByuEaTLUXbjC32K4=;
 b=Izv7mqrsjpPeSoxgiNd9EmJUiY7MYv2TVwjfDte+V+xq2j3BliX+cLIfyOEujnzvVc
 TJyByWFbzI5A9W/3CR7L/FUJJ5qhSGJlux7RkWDp4kKdn0OqN/Ncvwl2aaK5mMTLloXQ
 InGMlFdMFKeze8wA8dwcbF49xkbwGxpMT0SUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774465244; x=1775070044;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ABPkWaf0Cqmsau+j4YHECueH0VZByuEaTLUXbjC32K4=;
 b=C/uuWqk5ulUZ+zGdqVNpoXszKRTOSpNLFwJLrN3pRihCYTlI3/Cf1HUrv8TJtQrUr7
 S40tct5dsg5SmjdU6U7sZk4T8wYdfq0727iM4bhfyywfmXS58Vv1f+lTvxeO6aA6iWYU
 aY9Rp3SBVc2B2R7RksngLYAnwMy+yaKBBrit8BVq03og3z8Yt1po0fEfQDs8VB6cds38
 YdcpPX9aNJcovLDc6Y3osQkjZJUJypJoM4fIj0AdxvOiRSHgWhhQ+p0On9q1wY8KsZaO
 bvTXCWWg1JiSor4jzUdQAx4N0m81cMzBc1+8+oer2Dc4RUZAlRRU8J4jiM1ZbyxRb5fr
 QS8Q==
X-Gm-Message-State: AOJu0Yx8Z4yM47lwtVMDHMph689JxwrgL2jxzc0MfZrBMqBIQ/iZloJP
 bg58ItTElay5hJJy+0ByVsoB5ZhKMGeVyjorWQDWLhSBdU6iTc66e3aMYBNbIei9c6vQigiVoef
 sl/bgxY8=
X-Gm-Gg: ATEYQzwF47JIkUhvne0funjPdBSm/Zh1M3+VkUmAHp5yPU+kMTywQ57DG5qcKGqIs1u
 U8rZSvwRMgQp2W1OhQsmNce0PYWwbIC4sNiQ0gFMuQ0RGq4RXLtjbu3Ymjq0ch6ln46jViVFQcg
 0rVJgBQLtUzJdMRvo8hOTC8YAYRYmlfOrzpgjG2lm2JlG1b3vdR1eepbOvKSxDvQvcoOYBXXRwP
 Cgbo1FBHmcv4nFBNw2G0sTgFiquIwNcvGoj6dWJgnRyJPtBh7sgQAYWv3b7qanjCKofQ323GRkx
 uwSd+Q6jjRGUOcWnTZZNBt1Pz2kCV3ZzuC2njespSJWKFNzkhcI1vm6RRJ3QQSyPYSQGg5PJPdM
 lNDVPxl6Hkl9Usx3kbTpp1bFgNGcTZvfv7Vp6iNVaMVI8pn/ByAfeg+o6bFwngviMJAEaEgNZZ8
 LGTedQAAMrLMpUUty/mSg9stjeQMwwPFftk/6uc2qJabMtQKGLJGLDOKzTY0fC16L7sCHTCubr9
 Nm9XodfbRCiGIvrtl2+GvhMdGtQGMJz2wjcQpIu20f6BqlL3oc=
X-Received: by 2002:a05:6808:152b:b0:467:1376:1cde with SMTP id
 5614622812f47-46a5c69ba0fmr2065119b6e.17.1774465243572; 
 Wed, 25 Mar 2026 12:00:43 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46a70aefb70sm215978b6e.18.2026.03.25.12.00.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 12:00:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] mx6sxsabreauto: Drop unnecessary BOARD_EARLY_INIT_F usage
Date: Wed, 25 Mar 2026 13:00:41 -0600
Message-ID: <20260325190041.3428742-1-trini@konsulko.com>
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

This platform enables CONFIG_BOARD_EARLY_INIT_F and then has a
do-nothing board_early_init_f function. Change to not enabling the
option and so not needing an empty function.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Stefano Babic <sbabic@nabladev.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/mx6/Kconfig             | 1 -
 board/nxp/mx6sxsabreauto/mx6sxsabreauto.c | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/arch/arm/mach-imx/mx6/Kconfig b/arch/arm/mach-imx/mx6/Kconfig
index 552537895fcf..d198d9932f45 100644
--- a/arch/arm/mach-imx/mx6/Kconfig
+++ b/arch/arm/mach-imx/mx6/Kconfig
@@ -419,7 +419,6 @@ config TARGET_MX6SXSABRESD
 config TARGET_MX6SXSABREAUTO
 	bool "mx6sxsabreauto"
 	depends on MX6SX
-	select BOARD_EARLY_INIT_F
 	select BOARD_LATE_INIT
 	select DM
 	select DM_THERMAL
diff --git a/board/nxp/mx6sxsabreauto/mx6sxsabreauto.c b/board/nxp/mx6sxsabreauto/mx6sxsabreauto.c
index d80cfd4ab27c..ac91da3f4f63 100644
--- a/board/nxp/mx6sxsabreauto/mx6sxsabreauto.c
+++ b/board/nxp/mx6sxsabreauto/mx6sxsabreauto.c
@@ -199,11 +199,6 @@ int board_ehci_hcd_init(int port)
 }
 #endif
 
-int board_early_init_f(void)
-{
-	return 0;
-}
-
 #ifdef CONFIG_FSL_QSPI
 int board_qspi_init(void)
 {
-- 
2.43.0

