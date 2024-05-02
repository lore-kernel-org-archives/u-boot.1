Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A4BC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:40:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C877488CCA;
	Thu,  2 May 2024 03:33:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AJi2G3Rc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C631988CCB; Thu,  2 May 2024 03:33:46 +0200 (CEST)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E72288CBD
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:33:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-43ca9047bd2so2683201cf.1
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613623; x=1715218423; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0xDviKt/yk9m2EbeUeQwQsMxj2plbCvXu++8fsKQNec=;
 b=AJi2G3RceAALQN40CvGEuiJqJqOo1flcSO9tC4z9Ximubyf44koqoW0VTTh8mRvT0D
 R3BXEFVuXVytyp8lo2PtU918PUhQQdCyN+RiG7eX3Aukl1z6Apj9IKj1DJbmJKELzkEC
 hGk8PLeQsxRIfMe1O+1OBEEWOoXPjMw7Kj4b8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613623; x=1715218423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0xDviKt/yk9m2EbeUeQwQsMxj2plbCvXu++8fsKQNec=;
 b=hqmI/ZexM9gyn6Hp64F2hn45FoCJZcf66rDzN/LdsRV/xUvyVrNrUM7WbQ430Yzuuq
 FJChziQu1gGOsA45pk5WOfsZd4dYSi6vwSHUl2dnTNMS8J44sX40fymNskiGCpypLULi
 Ezm53+jPm4c2uOB0Eh0wRe/oS1f328t3NDZ6tTr1oa0W8OCCRZxBY7ikDArm1KCSP1Cj
 m6RfVbZKsPB7eDFmgqBlvj01G9UQYmt2P/La+qKbinEEvLrKQCxU+qP+3g2m/W5eTIH6
 vGX6JzauRAUpLVL4HIYQMWcJrpYLbcf/XAbM3xPhKNJNIR5JIJq887MEbgs5ofPhiuS5
 BlWg==
X-Gm-Message-State: AOJu0Yz3BoKMyzt07TsoPbBpVxs8Fx9/1xaXdi2r5T0S5kvHExKB3HnQ
 cl1k6SbbuABZWLc6DtOUdVCxqSfjaCyF14ZBUdaunXkbi2QlC+1uI7azAT18t2DDPeEe9GllgHg
 WJTWgJbUd
X-Google-Smtp-Source: AGHT+IH96EYCeMFFLqpViRpOmIbnVk7nsyODsrk6RZwBsAGsT7TAiNBRVKVHUpvzVGXOTIYmW8wy1A==
X-Received: by 2002:a05:622a:580a:b0:43a:4b07:57ec with SMTP id
 fg10-20020a05622a580a00b0043a4b0757ecmr2778528qtb.9.1714613622997; 
 Wed, 01 May 2024 18:33:42 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:33:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 62/81] smem: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:31:19 -0600
Message-Id: <20240502013138.2383421-62-trini@konsulko.com>
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
Cc: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
---
 drivers/smem/msm_smem.c     | 1 -
 drivers/smem/sandbox_smem.c | 1 -
 drivers/smem/smem-uclass.c  | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/smem/msm_smem.c b/drivers/smem/msm_smem.c
index 17ee6c837c6a..ccd145f9afbb 100644
--- a/drivers/smem/msm_smem.c
+++ b/drivers/smem/msm_smem.c
@@ -5,7 +5,6 @@
  * Copyright (c) 2018, Ramon Fried <ramon.fried@gmail.com>
  */
 
-#include <common.h>
 #include <errno.h>
 #include <dm.h>
 #include <asm/global_data.h>
diff --git a/drivers/smem/sandbox_smem.c b/drivers/smem/sandbox_smem.c
index 7397e4407ad4..fec98e5611d6 100644
--- a/drivers/smem/sandbox_smem.c
+++ b/drivers/smem/sandbox_smem.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2018 Ramon Fried <ramon.fried@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <smem.h>
diff --git a/drivers/smem/smem-uclass.c b/drivers/smem/smem-uclass.c
index 8469076915e0..4dea5cc4bf1c 100644
--- a/drivers/smem/smem-uclass.c
+++ b/drivers/smem/smem-uclass.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_SMEM
 
-#include <common.h>
 #include <dm.h>
 #include <smem.h>
 
-- 
2.34.1

