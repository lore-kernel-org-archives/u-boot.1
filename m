Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0780D46BF5
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 19:26:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02FCE83C2B;
	Wed, 28 Jan 2026 20:26:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z3nAY4Yh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B4CA83CF2; Wed, 28 Jan 2026 20:26:24 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C6F483B95
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 20:26:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-45c89d754dfso98148b6e.1
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 11:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769628380; x=1770233180; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KUUHRHvi4Opjov9QofTWjzOUsf9EmdO4vdwVeii2Ez4=;
 b=Z3nAY4Yht3hr1ptn7TTx2hwkoRLMcZJfPrblR8QgM5Mt7JK3paistP2ivPe6OM5Mm5
 7CwLqEoumNZnby9G+rEJ517iF3Usbq7cuRKFKjOoGZfcjgPPFi6uLrJIEEI2KVbxsYwt
 xZBmuGlBaNsmQ6UyBi7kZAejvpmgyJ8fD+VaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769628380; x=1770233180;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KUUHRHvi4Opjov9QofTWjzOUsf9EmdO4vdwVeii2Ez4=;
 b=Jq/NVASTOuiM/zzgi8V/t1MO3lznEXYlna/OhIe0A9HPvObMvwE4IbhDg47jsj8+fv
 lQzKkSu0DDDhzUv2joca2N/3swgTmKBmkCZeVoxyH2e7aY6XpgSZbKd90Pbkz4GMbB9w
 NCAn5P/Nmq1iR2oVAQJI2qq4kWGgMJZR2AC13h9ouW+70ro98AhAeOUMC2veVvmU0BZB
 9C98PGilrxyFXMSIU4TkFBCwMcemEmYWanw9q6s97l+ocyy50WcqOiotw3/MX4y2eyF0
 zzJPF4Vuql3C+F/c5zc4EYmXxSyT3HOlm3UYmNeGjDMy25x7qEPQqX+0q04W4LWcxLAf
 gIbg==
X-Gm-Message-State: AOJu0YwpEPS2VC+6oR4V+PYfcIgT+y+bqtXpJ9bZepEB1Ot7IaXTuzuI
 nFZwuW79+8PNYGft6FfSry/v1bmZAA00lQiVDJxyfHSDOlo9Lu8eF2RHWByzxPUzpz82etoPm/0
 IUTv2ReQ=
X-Gm-Gg: AZuq6aIgD0reEvmkoN2Uaf7nRMNeAd3qpjFkQrDKPk+1S6bDHxCVpbJEcihl2MPAFtd
 KQaPtmZtQ3uipsnIsKpffiNuZPGdZX8XGAuH+3jhG1BKOTvrJWcNvCWpQyNzktDrKx+mObO6WST
 hBg3dauTscjSYRhQ0kVgbEBkpyhT47sj7yjrGHSc+/sBg3pRzrEqUoSVHPiJMq1enNKEeKInh/O
 o7MVIaBuFZ8oHyyRgg4+4AOYMZxedTT4ES0tWIn0rA43KNVM1iLniL7esRD3IJO4+RdRESpDFhM
 AqNZ8gmfk1/F7xSDutR8TBFpoKpQLxFkJs6DFwk12OgrUWESkpn/LD0RgancodtJRrP+hk2ybUH
 bh9vUAWkufuHzXZCNqvEMKavcE3o70GV/HHZ0TUbhtGDfFRfQrGyFnEq4momausdsJex5IQlEdG
 56LthzFHkntdSLgoGkZiAvFisZgUzMMl+dZfK/UUhpV4KshkgYqLq8u6EWM7ICYLZ11EIDN5eip
 cpYcmnekqDpjtt8dz933Vs2Af1V7LZpUR8aqFjTpg==
X-Received: by 2002:a05:6808:1455:b0:45c:98c8:70ee with SMTP id
 5614622812f47-45efc603246mr3621064b6e.26.1769628380006; 
 Wed, 28 Jan 2026 11:26:20 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45f08f769e8sm1777364b6e.19.2026.01.28.11.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 11:26:19 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Mateus Lima Alves <mateuslima.ti@gmail.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] misc: Keep FSL_IFC available on PowerPC as well
Date: Wed, 28 Jan 2026 13:26:17 -0600
Message-ID: <20260128192617.1724570-1-trini@konsulko.com>
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

This symbol is used on a number of PowerPC platforms as well, so make it
available there again.

Fixes: 424b324165ea ("armv7: Add CPLD support via IFC to the ls1021a-iot board.")
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Mateus Lima Alves <mateuslima.ti@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
---
 drivers/misc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index be7fdab56d14..a0aa290480eb 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -695,7 +695,7 @@ config ESM_PMIC
 
 config FSL_IFC
 	bool "Freescale Integrated Flash Controller"
-	depends on ARM
+	depends on ARM || PPC
 	help
 	  This driver is for the Integrated Flash Controller(IFC) module
 	  available in Freescale SoCs. This controller allows to handle
-- 
2.43.0

