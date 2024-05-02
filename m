Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A37CC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:42:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53F0A88D08;
	Thu,  2 May 2024 03:34:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l0DtJtmF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86B0788CFA; Thu,  2 May 2024 03:34:15 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3F7D88CDB
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:34:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4376e3fd7e4so42032821cf.2
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613650; x=1715218450; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TL1AWX4OPa5lQ0Fssr2KUaiBRxc4nH8KJITpa94UXkE=;
 b=l0DtJtmFaLti/g6M36O3AfRVoz301GqR6AmtwUVqjy6tNJkOsdY4Jc5IqWrOQX+wSN
 CbfVC5wdti+Kn6aOeBsy8sFVtjJZu4ClgyeD8P942vjnh1celqJtppKbX/q8V8t/+Vtl
 YasWU/bgfEt3yQY9awddMHJ5jHRKazOuEare4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613650; x=1715218450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TL1AWX4OPa5lQ0Fssr2KUaiBRxc4nH8KJITpa94UXkE=;
 b=YGTTH5orLyJVLLbBpLdVRRnQuSFkynwh2a6cFV4R0vQ7RMuL1+fyWqasYNGYzuXfFi
 OGZd7voRfwObO5UxzAaN14qlucUDto63vQmWOG5zqh8bCsPnFUnkine1Q28HosNFBZ28
 fCZbt8QV26ijvxt4OQeU8VuHCEEFc6eRZNFUzavtPBu3eG/sISu6NsryNI/4vGQScsKZ
 7p3Euxdu7yyGtrhufrpGgDF7kI56FUGTuKuNQsNLs3ePrMHsIpjaZjZzFQ48AjadgxkD
 KFPS2aklcNouwQbiqAKMDttQ3XXn5SOW0qXwM9EaE6Ldqn1xrolgpOQSg2gj1CyyyIEf
 RPhw==
X-Gm-Message-State: AOJu0YzzwxP4YtqO8ezUusDWMOfy3fpreAP6/Sxm0rqZUV+QfPFX8Dy3
 C7VChJ5HnFRFStMLKaPwPqPwV3zj1sTd/KLiuAKnPzY/7eMEBacwoE9F/QiM6mu57kKxWwtssUm
 wuP6oPBNQ
X-Google-Smtp-Source: AGHT+IH0oJ3Yhx2H1LgcfIrNytvCSOYMNV62F2zQSSf1RnsFBCiyz+r2opGJX5cTA+e09ZFWPOWesw==
X-Received: by 2002:a05:622a:38f:b0:43a:bd5b:3ff1 with SMTP id
 j15-20020a05622a038f00b0043abd5b3ff1mr5232882qtx.63.1714613650544; 
 Wed, 01 May 2024 18:34:10 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.34.09
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:34:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 76/81] w1: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:31:33 -0600
Message-Id: <20240502013138.2383421-76-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502013138.2383421-1-trini@konsulko.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
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

Remove <common.h> from this driver directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Tom Rini <trini@konsulko.com>
---
 drivers/w1/mxc_w1.c    | 1 -
 drivers/w1/w1-gpio.c   | 1 -
 drivers/w1/w1-uclass.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/w1/mxc_w1.c b/drivers/w1/mxc_w1.c
index b96c1a00bf24..9ebfc13c83aa 100644
--- a/drivers/w1/mxc_w1.c
+++ b/drivers/w1/mxc_w1.c
@@ -17,7 +17,6 @@
  * Martin Fuzzey <martin.fuzzey@flowbird.group>
  */
 
-#include <common.h>
 #include <asm/arch/clock.h>
 #include <dm.h>
 #include <dm/device_compat.h>
diff --git a/drivers/w1/w1-gpio.c b/drivers/w1/w1-gpio.c
index 9346f810ce11..759f94e224e4 100644
--- a/drivers/w1/w1-gpio.c
+++ b/drivers/w1/w1-gpio.c
@@ -7,7 +7,6 @@
  *
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <w1.h>
diff --git a/drivers/w1/w1-uclass.c b/drivers/w1/w1-uclass.c
index a4247ecd6233..9637ed242573 100644
--- a/drivers/w1/w1-uclass.c
+++ b/drivers/w1/w1-uclass.c
@@ -14,7 +14,6 @@
 
 #define LOG_CATEGORY UCLASS_W1
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
-- 
2.34.1

