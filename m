Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 215C4C27C40
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 17:59:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 743B586416;
	Wed, 23 Aug 2023 19:59:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qP3OtfHY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 600AA86411; Wed, 23 Aug 2023 19:59:23 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 568F586414
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 19:59:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3a81591c73dso818589b6e.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 10:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692813560; x=1693418360;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=p//zV1vGQNOwYQgahHfX8Dc5ck1+cqd1Sk9miLsy/hE=;
 b=qP3OtfHY26eNljvPsADulQEj+ie7MnfSQLYMgG5eSF4a9x87U3e7Bphd541tShdxdR
 GvsxHh7Y/hlLiLaWi5FVgvSkUZMk8EyeCck7ysF6FRcBKCfGKw9urinvFGxYomhsEzJn
 DSNdkq0meeI25FvrOXir59WUqwagSAys6V55n+gw6WT9Y8HeIr6YgQXxYPAr5cR8ldQh
 iV9zq4OapTiFMpy8x0WZQ16SV9DqZu3aTNz1f5zwTyYnDwhImCXqYzFIDjk3n7lyTuxJ
 OE7YrATjb4eYD/od2fmsQGVMJi4oucpUlnok86Zz+XH4J0RLRnYGRkiAzfr9jlElBRqU
 D2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692813560; x=1693418360;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p//zV1vGQNOwYQgahHfX8Dc5ck1+cqd1Sk9miLsy/hE=;
 b=aMIVveLpVwBn5PjdrBHtHzKnQGRSoEstiZyGvK2NyIXptdN1qvsvlzYRyIfCrFzSZQ
 pwkTglX3O5PXIfFkenX9RN7m7oWKeHpLl6dCiG8ahF5mRf3dU1gEeGu0gYnYpivQTuMV
 oel6K2aOjw3CxyB0XPrxymlAhUyZX5gPueNkgVOqKvohiPySr12wHfxdg42369hEAZXN
 32eP83Gh38f3XchV5Knr7Ya89WmeQqxhM2gApu3p/ThWDuXmXO/gNLjjpTwWB7e+bFCr
 jxz56E34mw7XYf+9aY5X19b5MOrvXJUErHd9oMzCx8tpTcc1xB1kY2YykGXif2D0dgox
 uASw==
X-Gm-Message-State: AOJu0Yzu6jZqCYMD2XLup77zdAuP+Y4GE6yq93TfaBPzgp/hk8EONFLm
 4oe4e2zo4uG0piTQMafkAME=
X-Google-Smtp-Source: AGHT+IFTTxj+oxLSGUmgLYB+2Mi5rQmmUeQNo3aex1MQW2fmpYxUz6sUza6/QwdW18q/4GKQ3+7dcg==
X-Received: by 2002:a05:6808:1a84:b0:3a6:f8e5:edad with SMTP id
 bm4-20020a0568081a8400b003a6f8e5edadmr12367430oib.4.1692813559805; 
 Wed, 23 Aug 2023 10:59:19 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:b51c:1cae:f70f:7819])
 by smtp.gmail.com with ESMTPSA id
 17-20020aca2811000000b003a842626b62sm5625271oix.22.2023.08.23.10.59.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 10:59:19 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: peng.fan@nxp.com, trini@konsulko.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2 1/5] imx8mm_evk_defconfig: Select CONFIG_IMX_TMU
Date: Wed, 23 Aug 2023 14:59:07 -0300
Message-Id: <20230823175911.319414-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@denx.de>

Select the i.MX8MM thermal driver as it is useful for displaying
the CPU temperature and its grading:

CPU:   Commercial temperature grade (0C to 95C) at 38C

It also prevents booting when the temperature is above the alert
point.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- None

 configs/imx8mm_evk_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/imx8mm_evk_defconfig b/configs/imx8mm_evk_defconfig
index ac9810fe1b..822c2fbfab 100644
--- a/configs/imx8mm_evk_defconfig
+++ b/configs/imx8mm_evk_defconfig
@@ -104,6 +104,7 @@ CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_DM_THERMAL=y
+CONFIG_IMX_TMU=y
 CONFIG_USB=y
 CONFIG_SPL_USB_HOST=y
 CONFIG_USB_EHCI_HCD=y
-- 
2.34.1

