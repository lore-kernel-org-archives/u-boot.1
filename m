Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85565C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:10:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 718AE88CDE;
	Wed,  1 May 2024 04:46:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QLttEeoc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE90F88CD5; Wed,  1 May 2024 04:45:59 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCFEE88CA6
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-790e7c02430so293819185a.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531556; x=1715136356; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x+kl3HH4WbsmqWJHeZEObxxcbddRf0ewmmosjv7iqtM=;
 b=QLttEeocTBa3AZxLiRYK8DvCMMllTQGybSiRy4HUKkKjOrKWMHcPZ5ifQ3TXCX0Dp3
 0w38V5bgwTQR6lf4+y9wtH/aZl+ptAbtwiH8roM9x4xdbhkY/2oOgNZ+Wxyfn7+Jwa06
 MzWxUh5QR7fPQTbum1h2QUDFRxuv4JialvftE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531556; x=1715136356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x+kl3HH4WbsmqWJHeZEObxxcbddRf0ewmmosjv7iqtM=;
 b=Ecbd2C/CvQkAzKlsNoqkEkCTsHDbUZs72H/4rE3kfCYiyHByW3tuDKq3Z/6ifxu4Pg
 STTTmPVFL88nL7fKJ8Qd8OFp7cyTvpXc9w8ry7vr8anzfUe5yZrh7SyxtoLjGrYkie6N
 tNItqcnV09K0XFBcf9kSJd07g3/MEdHg91j9l9NNoLDT9GLHdd6hwXHrnrSnH6NGk/V/
 cZ+w5edTosxoig4Mvy4lfwpQjLCb5gbdLY1dwvYncn2NmXMaAlMlGJl3SB9iBzDCHVzh
 f14hr52t4uIUGg8IZ52ubEQ0NmHsHlC5jiLb15DmhSm1HzVEG/3auzI7mDf94OxvZF0+
 YLdg==
X-Gm-Message-State: AOJu0YzYJWGaGofdirB7X2UFLv3G1ICOZjtQiWV0+MlvQiS4550YcczL
 DI/mHqAi+gh9yU8KScHK4osKFqhinkADZ2mE5Ri63jdY1M4bGczZp8Qzj+rU8e6WZ4lPGEwCVUo
 1D+i0sDYG
X-Google-Smtp-Source: AGHT+IGhqRzkH/3iGfhiwc1GaF8kA8qAxXUYEQns/8P4oupCL5bKvLRjgc0e8Laz7DU59mD0XYRzYQ==
X-Received: by 2002:a05:6214:4116:b0:6a0:817f:7275 with SMTP id
 kc22-20020a056214411600b006a0817f7275mr1113236qvb.34.1714531556499; 
 Tue, 30 Apr 2024 19:45:56 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Markus Niebel <Markus.Niebel@tq-group.com>
Subject: [PATCH 139/149] board: tq: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 20:43:06 -0600
Message-Id: <20240501024316.1767971-139-trini@konsulko.com>
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
Cc: Markus Niebel <Markus.Niebel@tq-group.com>
---
 board/tq/tqma6/tqma6.c      | 1 -
 board/tq/tqma6/tqma6_mba6.c | 1 -
 board/tq/tqma6/tqma6_wru4.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/board/tq/tqma6/tqma6.c b/board/tq/tqma6/tqma6.c
index 1c2228c77ad0..92142c10ae5a 100644
--- a/board/tq/tqma6/tqma6.c
+++ b/board/tq/tqma6/tqma6.c
@@ -21,7 +21,6 @@
 #include <asm/io.h>
 #include <asm/mach-imx/mxc_i2c.h>
 #include <asm/mach-imx/spi.h>
-#include <common.h>
 #include <fsl_esdhc_imx.h>
 #include <linux/libfdt.h>
 #include <i2c.h>
diff --git a/board/tq/tqma6/tqma6_mba6.c b/board/tq/tqma6/tqma6_mba6.c
index 52851dd5b55e..877539e359e2 100644
--- a/board/tq/tqma6/tqma6_mba6.c
+++ b/board/tq/tqma6/tqma6_mba6.c
@@ -20,7 +20,6 @@
 #include <asm/gpio.h>
 #include <asm/mach-imx/mxc_i2c.h>
 
-#include <common.h>
 #include <fsl_esdhc_imx.h>
 #include <linux/libfdt.h>
 #include <malloc.h>
diff --git a/board/tq/tqma6/tqma6_wru4.c b/board/tq/tqma6/tqma6_wru4.c
index 5d239913fc5b..21c710188e09 100644
--- a/board/tq/tqma6/tqma6_wru4.c
+++ b/board/tq/tqma6/tqma6_wru4.c
@@ -23,7 +23,6 @@
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/mach-imx/mxc_i2c.h>
 
-#include <common.h>
 #include <fsl_esdhc_imx.h>
 #include <linux/libfdt.h>
 #include <malloc.h>
-- 
2.34.1

