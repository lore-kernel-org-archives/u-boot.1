Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B10A2C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:12:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D19988CFF;
	Wed,  1 May 2024 04:46:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cEGr7vCF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D2F588CFA; Wed,  1 May 2024 04:46:09 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E1FD88CF3
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:46:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-79100a90868so189438085a.2
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531566; x=1715136366; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H543sPjaNC6UbygU3e45BLFkXCpFmvAWiBXffU39Yzo=;
 b=cEGr7vCFlAHbBHNlapGBNv4S3+w6oBgjJAQ/PTxyJ8JO4nJAYeqq7OpwxSOZ85LfN1
 25XrT8B22Smgmqv4qGXhyDt3TQZBxP3YAoATm39udXJ1NU+E4Se+eV1FYY2tEW47SEov
 rEGjkkoMDMGK1YCpPGh0KXyz6zZs66NfbULx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531566; x=1715136366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H543sPjaNC6UbygU3e45BLFkXCpFmvAWiBXffU39Yzo=;
 b=IeIr6Lm3h0+KRE0OnXfSWN/yEuAkx7yEU5CBPQRPRlWD5wlr+Hi0oorL2C8Wre5i4M
 PYOmQeiI88xyF1ni88CZ4/f04zp+SBu8hRTTLS8KrJQEu4dlEmjqIxhPhVDmoqbN13Ry
 ejMGLHoZkuJRyyArtCuYj04m7a2doK46vNYCYXYYrnTdk5uDKiTaB2tdQlKeDaKHMCMS
 R8Vyjty8RqXyybdFEtaE2Z3OUamc9xeU7BHr8pQG/rrk85Jbl5Lotz3VhQpo+hYehXQX
 50+SdPHo1XG6Gf7I4J2iEQaZhlqGwMh/VtvIDBsvaxrOK0roNwG5aDnpOm0PpT/0JwmN
 gwnw==
X-Gm-Message-State: AOJu0Yw5PImZ8YZSVr2Si4mJD3CLXSsbgvjRBWr++pYYG/IwnAD234iE
 YEgJ7rViGdQS42X64PmDrip5Ar5g8FquEMM9Fz8Uuzoyw61ejVhdJChA8s7u22Jy9OelmA8PdQp
 ANbm7/69U
X-Google-Smtp-Source: AGHT+IH8iqQOU+ZS3Co/CvO2E7DB0791yJsJ8gDCjtwW/b0twhEJoddz/YM5HOOImnSsSGmUBDg+FA==
X-Received: by 2002:ad4:5f86:0:b0:6a0:cc6b:1a70 with SMTP id
 jp6-20020ad45f86000000b006a0cc6b1a70mr992868qvb.45.1714531565831; 
 Tue, 30 Apr 2024 19:46:05 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.46.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:46:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Tony Dinh <mibodhi@gmail.com>,
	Luka Perkov <luka.perkov@sartura.hr>
Subject: [PATCH 149/149] board: zyxel: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:43:16 -0600
Message-Id: <20240501024316.1767971-149-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501024316.1767971-1-trini@konsulko.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
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

Remove <common.h> from this board vendor directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Tony Dinh <mibodhi@gmail.com>
Cc: Luka Perkov <luka.perkov@sartura.hr>
---
 board/zyxel/nsa310s/nsa310s.c | 1 -
 board/zyxel/nsa325/nsa325.c   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/board/zyxel/nsa310s/nsa310s.c b/board/zyxel/nsa310s/nsa310s.c
index b3ea6608914a..d018b5738242 100644
--- a/board/zyxel/nsa310s/nsa310s.c
+++ b/board/zyxel/nsa310s/nsa310s.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2015 Gerald Kerma <dreagle@doukki.net>
  */
 
-#include <common.h>
 #include <init.h>
 #include <netdev.h>
 #include <asm/arch/cpu.h>
diff --git a/board/zyxel/nsa325/nsa325.c b/board/zyxel/nsa325/nsa325.c
index f5f63ee5d3b0..38340b33c8bf 100644
--- a/board/zyxel/nsa325/nsa325.c
+++ b/board/zyxel/nsa325/nsa325.c
@@ -14,7 +14,6 @@
  * Marvell Semiconductor <www.marvell.com>
  */
 
-#include <common.h>
 #include <asm/arch/soc.h>
 #include <asm/arch/mpp.h>
 #include <netdev.h>
-- 
2.34.1

