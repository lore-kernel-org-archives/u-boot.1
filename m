Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83D8CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 19:22:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65909870A2;
	Thu, 19 Oct 2023 21:22:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HdIsrwsa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B73B87495; Thu, 19 Oct 2023 21:22:20 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33A9A87025
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 21:22:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6bcdfcde944so19169b3a.1
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 12:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697743336; x=1698348136; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2+IpJ/LNp+qp8i/qpFojg31fRJoScY/WoQ+ANygopNo=;
 b=HdIsrwsakAkgqvBoP2xyNU5aAysqyvj/Uoza1z8iS1mMUruLF4bDhQQczMvdL05e71
 8UcU3sguXMH5uSxPD3Zy5MDMolPcy4W/ktXCTYR56+2AUVFc+9ponnw35CP/VbezrCRs
 5cAUC/EI69GP4V52uCYlfagNODVxy3JPAKgIG4eQ5OiBoDqXX0gULHw9xHORMjVjQozs
 KvvYWF9qr2/R7rbpW0/41gMbcOMdlW9uP7Cb0AKRajwHtj+d84pRkQ+0bxHAyrUrhBo7
 6J5IujUasC2oZ1LVQc/h8R/K0tfBjY55ty1bifNEIgU/LPs1ZEgnbpW/mpfiqkPs1rvT
 /Dyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697743336; x=1698348136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2+IpJ/LNp+qp8i/qpFojg31fRJoScY/WoQ+ANygopNo=;
 b=JqP/shdDOL/kQqIf8boxT4sk3eF7+kbhRxuXI9YTA2oPyMh8m3yex35HPaDuEvchfa
 ZDRhVE8O3VUKvCkzPWEmclfcGKLk4ErDhr/HQjAzhDV9GYvOSRGfhDSDwb/QzN13D4Ko
 q/SSkFHe51ijxefS5vQUElrqaFeHOBoKYmGMY7ADBFrhmZQSVBjE3HbQZzMTUwSIjxDv
 kU8JoA56Gx+YXjXk7xHFjE1flH3CTGMMK3QXTzYtxQC/d+/BuQJGtuW7SQgSlAdFh/ne
 5y9l39cXxvnYZdr4FSN25i7iexGptjYUyTmWDivd3beSuHSPU5bWPFhIgRNkXnsikKO9
 UWFg==
X-Gm-Message-State: AOJu0Yx9c+8SvarrhrWIhgB+KB9jjWRrb8PMSRo2cvmMSfaZERfXyKXg
 jBq5gnGMwSAq8Y6vdc4mLvis+4Kpmac=
X-Google-Smtp-Source: AGHT+IHuAASWIDBMsNpIQSa1yIad8kXggKj9CuEymN7bCG3QkiYWAIF7xtz2aSqYy1yG2UCC8n0qrQ==
X-Received: by 2002:a05:6a21:8cc5:b0:16c:b95c:6d38 with SMTP id
 ta5-20020a056a218cc500b0016cb95c6d38mr2690749pzb.2.1697743336279; 
 Thu, 19 Oct 2023 12:22:16 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:845f:888e:bc51:273a])
 by smtp.gmail.com with ESMTPSA id
 f15-20020a63f10f000000b005af7ee01ab4sm121880pgi.6.2023.10.19.12.22.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 12:22:15 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, hugo@hugovil.com,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2 2/2] mx8mp_evk: Remove unneeded header files
Date: Thu, 19 Oct 2023 16:21:55 -0300
Message-Id: <20231019192155.1735199-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019192155.1735199-1-festevam@gmail.com>
References: <20231019192155.1735199-1-festevam@gmail.com>
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

Cleanup the file by removing unneeded header files.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- Newly introduced. (Hugo)

 board/freescale/imx8mp_evk/imx8mp_evk.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/board/freescale/imx8mp_evk/imx8mp_evk.c b/board/freescale/imx8mp_evk/imx8mp_evk.c
index 42291c958e39..e62e27db48d9 100644
--- a/board/freescale/imx8mp_evk/imx8mp_evk.c
+++ b/board/freescale/imx8mp_evk/imx8mp_evk.c
@@ -3,18 +3,8 @@
  * Copyright 2019 NXP
  */
 
-#include <common.h>
 #include <env.h>
-#include <errno.h>
-#include <init.h>
-#include <linux/delay.h>
 #include <asm/global_data.h>
-#include <asm/mach-imx/iomux-v3.h>
-#include <asm-generic/gpio.h>
-#include <asm/arch/imx8mp_pins.h>
-#include <asm/arch/clock.h>
-#include <asm/arch/sys_proto.h>
-#include <asm/mach-imx/gpio.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
-- 
2.34.1

