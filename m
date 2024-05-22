Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C446C25B7C
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 23:31:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E42E884F3;
	Thu, 23 May 2024 01:31:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vJdEkLHB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F03E5884E5; Thu, 23 May 2024 01:31:41 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CE76884E7
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 01:31:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6f264d5dadaso2333149a34.0
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716420697; x=1717025497; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qk4MEihbGWfxaLEFo0FYucssWWst+FFB46S1A1fRD38=;
 b=vJdEkLHBCeJF8xGlfEJ/tVBeR0ZO4yd4MycBMiMlIlgW95yCY9yAQoqhoxBrIYqvR0
 1KlhqOzttt59wSyTV07X1GFihbhE5iXhnX+OIQzLu5Lsea4h2WBvvH2c19YsAc6OCdLS
 GxPZallwjFNsgYxwM3Pl5gVyOfqL8p75NNSxredNiU4tnIAWEc/5jxm/eL7mJ/SIcO1r
 QjscciD93EHBaxzGg/ODOPpJIFQUFrzV7HTJdu6Rwyk+KAwTzh0mDr4mkDWHmTUZaDto
 N3Jdi34qRImntLp0xxA0foSpaKwGZ1ZupS7QznWDUNXQxME6YWP4Dzs4y7+zsqitkF2H
 EcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716420697; x=1717025497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qk4MEihbGWfxaLEFo0FYucssWWst+FFB46S1A1fRD38=;
 b=a6sdVpN2Bh9EM3qV3iKxev1WtJIJpj3x1rowij/aAL2aJKY1pEjKkWPF5fHDgy9QyF
 uwIJhM7d4FuSLn6M1p1waUNd1xlHCUO7ElY7ArI6G1+1HA7VoT98tcgR7HNR/Y8kL8KG
 B58apd68dQVa/tZub6JR+7r0wEl+oMX5Z1badlgfdUstvb+nxepXyRoBOXINqz7CYmM3
 BtDNGUzaPXLz+rJ5yjacqmcwHrD0LyiM5SWrhdOM6slPd1Wfd3TBndmfte+vAaSQ4Zvc
 4Mjcs1IZTR2nzyD4oQAZmaPDXCu7xSbRTDIwxss2lJY6GTY2LnchwunNggg7g74/Nn/7
 tiPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnTRpd5CCNwNFPFYLh/iXLQRs6/137djb4PetKBgiEH4CryDhCEJH7C9L0WW/4jT5ii6Tf8raLHnxif3DfBDMHRuVM9Q==
X-Gm-Message-State: AOJu0YzNeMiDtBpwiHyaZcPYxPgSxlotMmVE1+fpsg4vg1GnXCxGG1Nt
 JoKACNLdXPhCb5Gm7DLefbRZLSREiHW/pZGtyHUAfhnLw/HRnyIJy3+fo9/2pCs=
X-Google-Smtp-Source: AGHT+IHiCqY/xLZWQDPMTbdI7kq2j+CmvcDJAM1UMvodTJ5vPbyLBdUKSGIknnhNJmlw5hzwmZpU5w==
X-Received: by 2002:a9d:6c81:0:b0:6f1:1b18:7442 with SMTP id
 46e09a7af769-6f666f7d387mr3438537a34.17.1716420696940; 
 Wed, 22 May 2024 16:31:36 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f0e022328csm5178553a34.61.2024.05.22.16.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 16:31:36 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH 01/42] mmc: dw_mmc: Remove common.h
Date: Wed, 22 May 2024 18:30:54 -0500
Message-Id: <20240522233135.26835-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240522233135.26835-1-semen.protsenko@linaro.org>
References: <20240522233135.26835-1-semen.protsenko@linaro.org>
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

common.h header is marked for removal treewide and shouldn't be used.
Remove it from DW MMC driver.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/mmc/dw_mmc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index e1036641452a..e6107c770fe3 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -6,7 +6,6 @@
  */
 
 #include <bouncebuf.h>
-#include <common.h>
 #include <cpu_func.h>
 #include <errno.h>
 #include <log.h>
-- 
2.39.2

