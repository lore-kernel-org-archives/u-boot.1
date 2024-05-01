Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B63FC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:07:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D44D788C8F;
	Wed,  1 May 2024 04:45:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VoQF8z7r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D283088C71; Wed,  1 May 2024 04:45:42 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ACB988C32
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-78ecd752a7cso452831685a.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531538; x=1715136338; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ARj6w3EaRCJwvF01YFNKES2wOocwApm5UMji9+SHP5I=;
 b=VoQF8z7rxsinl5UbNAjJYQR2fyhjqFqCCK4hzSzLoK8GfyVTZuBxhbdmGzN9vtHQSZ
 TGVqb47PAoWwUwzJvcBXx6Qmgwn9UgpXTIxemfPAE5Ok9lwM8dDRlNcoU+zwtxcDl3uB
 UuXkCsjLofkLA3adujeBCKxQssatFWIXnU00Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531538; x=1715136338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ARj6w3EaRCJwvF01YFNKES2wOocwApm5UMji9+SHP5I=;
 b=EBBY6Lg5o+Wpgj1aegZi4lPTY2I9tnydGvmA+97JWlGpvGk8fTwKVuiHZC6DqHgqNE
 HEZ7stw7SUwDs8DtEvWu92a7RyeS7jN/FvmkS5qTSH4/LxIEQO8LmjLOrb2KaxLHZnWq
 h/cpVr6DNWpUb9uDpSFNoSe9keMsRu0K3OBlsKRuR8lpf5qdaLXkqxrBlhl4LYmfvIfp
 MgE1tjTVUyfTv58aewFU0MOsVTnuxrpqeT0jfAeUmLxmw01kFEeLynpTKlxMLlJbKxQw
 hIpK95WAOS2mrxY23aJL6t76F4yvClBZl+HfXyi8McAmkaXJtqfQDVgGXQkH8RK2isL1
 7AYg==
X-Gm-Message-State: AOJu0YwS1X74itEuR8iP42zacDmSiDlRLjr2EGjUAeMQkPvlNWlS5MF/
 CgaK/3jD4UIuQindkr8+nq91GKdsA06DohowmMSRrXIDEWsQdf3gTyreNnvpUt6sWO1GRbrmi3H
 P0hDwq3Bp
X-Google-Smtp-Source: AGHT+IE2DIpmd1IA+hTnaxZOLvMeATu/VhYbWj5iixGQnvPVDLfF2m2IoAC8FN1E3pVkS+GrSFRHIw==
X-Received: by 2002:a05:6214:27cb:b0:6a0:cd45:2584 with SMTP id
 ge11-20020a05621427cb00b006a0cd452584mr1376859qvb.20.1714531538398; 
 Tue, 30 Apr 2024 19:45:38 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Silvio Fricke <open-source@softing.de>,
	Marek Vasut <marex@denx.de>
Subject: [PATCH 122/149] board: softing: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:42:49 -0600
Message-Id: <20240501024316.1767971-122-trini@konsulko.com>
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
Cc: Silvio Fricke <open-source@softing.de>
Cc: Marek Vasut <marex@denx.de>
---
 board/softing/vining_2000/vining_2000.c | 2 +-
 board/softing/vining_fpga/socfpga.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/softing/vining_2000/vining_2000.c b/board/softing/vining_2000/vining_2000.c
index 4483bd7f7a38..a0dbf97524bd 100644
--- a/board/softing/vining_2000/vining_2000.c
+++ b/board/softing/vining_2000/vining_2000.c
@@ -24,7 +24,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/sizes.h>
-#include <common.h>
+#include <config.h>
 #include <fsl_esdhc_imx.h>
 #include <mmc.h>
 #include <i2c.h>
diff --git a/board/softing/vining_fpga/socfpga.c b/board/softing/vining_fpga/socfpga.c
index b3f9550742ec..2483fbcf2631 100644
--- a/board/softing/vining_fpga/socfpga.c
+++ b/board/softing/vining_fpga/socfpga.c
@@ -3,7 +3,7 @@
  *  Copyright (C) 2012 Altera Corporation <www.altera.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <eeprom.h>
 #include <env.h>
 #include <init.h>
-- 
2.34.1

