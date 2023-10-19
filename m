Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD2CC001DF
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 21:51:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F0CF870A1;
	Thu, 19 Oct 2023 23:51:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IF4GQhVV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C8A8871BD; Thu, 19 Oct 2023 23:51:32 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5381A870A1
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 23:51:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1c9ba72f6a1so270765ad.1
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 14:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697752288; x=1698357088; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9NS0LNvYp0EjtgAo/n1l0a+AhHqoyEZka2YjsYANDek=;
 b=IF4GQhVVzN03946+LJlwquiCqkm+fRMVOuYFUAxvXiV5ZUzKkWX7vDWsQPx05MwFoO
 WQ8l8hSGZQx5qRQC3vxkOtxuk6U3R0MPcUg6JIWuoWvnItJXVbP4TVL6XIJd78argiQE
 9/B5y7PGnU0SDNeDlLUvhGHcRjd+RwMLH2vnLpGoDZEAjjYs9DDHFst+qiPU/MlykJET
 lAkcp6+RESni6bUsaeazX/XHYou7jYfn6725egT5MGTm29F6ga5PfYlkG+SqT3oFpVHg
 Ruh+Qkhpnn4dJQlO4WvY/hvIZ3XIv/rDjzyOuui/oj3Snh9sOJ8nWTGmamLe4jvM3s66
 6LiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697752288; x=1698357088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9NS0LNvYp0EjtgAo/n1l0a+AhHqoyEZka2YjsYANDek=;
 b=ImVlz+Xee9kWWq6IztcSysfCEFyZ166uvAVvJuVU/UuyOpyKpSoEIGpbYeKXS21g4L
 SI+M++b8xrpmMpwf7fFn9RxtGkBlsFvw82UeZPFa3RYgn69MqtZluBaIYJH47MoH5bR9
 KZ2xN3ZlStO00lmLi4bMrrQn8Yabk+IQR9yoK4HTCtep1pFpywyNPhw+UkQKi+A2KiIG
 ql1j5cAyX8LoSdzrpg8fWxavwQ4aNwaqWSXIztHSBIybfRH/t9MgkA9OtqkJY6japRea
 I1qb8zImJoHxhgGwsmx63XQq7CfzehlDNXVbIugHcy06wwRY5Qvd1/ODUfjTTG1abMqZ
 c+Kg==
X-Gm-Message-State: AOJu0Yyip/zdctnnbd4B1KdAGrUqPNPwUs+WjX1pbStB4oCuspmweC8e
 HrA9aKF9jY+CSdmHcLZW0e0=
X-Google-Smtp-Source: AGHT+IGpicOLi8AAPryJbSLmqrSqgQgYwB4Dd3bhZgWdG/qqmVS2IltUjbmEtA5m+HP09o6OBZkBcA==
X-Received: by 2002:a17:903:2783:b0:1b8:9fc4:2733 with SMTP id
 jw3-20020a170903278300b001b89fc42733mr129659plb.3.1697752288626; 
 Thu, 19 Oct 2023 14:51:28 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:845f:888e:bc51:273a])
 by smtp.gmail.com with ESMTPSA id
 x4-20020a170902ec8400b001bc6e6069a6sm177371plg.122.2023.10.19.14.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 14:51:28 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, hugo@hugovil.com,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH v3 2/2]  imx8mp_evk: Remove unneeded header files
Date: Thu, 19 Oct 2023 18:51:13 -0300
Message-Id: <20231019215113.1833803-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019215113.1833803-1-festevam@gmail.com>
References: <20231019215113.1833803-1-festevam@gmail.com>
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
Changes since v2:
- Also remove <asm/global_data.h> and DECLARE_GLOBAL_DATA_PTR. (Hugo)

 board/freescale/imx8mp_evk/imx8mp_evk.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/board/freescale/imx8mp_evk/imx8mp_evk.c b/board/freescale/imx8mp_evk/imx8mp_evk.c
index 42291c958e39..024b46ef8bc2 100644
--- a/board/freescale/imx8mp_evk/imx8mp_evk.c
+++ b/board/freescale/imx8mp_evk/imx8mp_evk.c
@@ -3,20 +3,7 @@
  * Copyright 2019 NXP
  */
 
-#include <common.h>
 #include <env.h>
-#include <errno.h>
-#include <init.h>
-#include <linux/delay.h>
-#include <asm/global_data.h>
-#include <asm/mach-imx/iomux-v3.h>
-#include <asm-generic/gpio.h>
-#include <asm/arch/imx8mp_pins.h>
-#include <asm/arch/clock.h>
-#include <asm/arch/sys_proto.h>
-#include <asm/mach-imx/gpio.h>
-
-DECLARE_GLOBAL_DATA_PTR;
 
 int board_init(void)
 {
-- 
2.34.1

