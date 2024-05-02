Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1FEAC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:34:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDCB188C21;
	Thu,  2 May 2024 03:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FH/slAcW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70EB788C14; Thu,  2 May 2024 03:32:04 +0200 (CEST)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFC2D88C09
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:32:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-439656c1b50so45047441cf.1
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613520; x=1715218320; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=orIzRa3wB/J5Z88n4Jf3F/v7THgJBD4xeL7nRJGLPIA=;
 b=FH/slAcWijT9XoGMeOU6eV1sJlIjTVBXZW4YMEmE98KyCjmzoXZMTypvdeOcWlCK7r
 SJrQjWxueqkR7VgijUUT89t2aWaPQqIOEmzCxtN69rAQW/CNT/go9XWZz/gfZZ8c+CCN
 xZx7+7sJiPf39QiF3jKga2v5rbAnuB81OMzEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613520; x=1715218320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=orIzRa3wB/J5Z88n4Jf3F/v7THgJBD4xeL7nRJGLPIA=;
 b=EvNQCRWYiVCoglNUnoH3XvVrht6s6C6xQkSnWl+rUuO/oRYiFrLi5cTooF3cbRTvxB
 cLkw0enY2yR4DlwcSbR7IMIG7mzobVael4YzL+JYpP/GZBny1V0n24nzPFMrgFxPlo2g
 u9FIhEUW6sahlqFivtPMsLWcpTsNBWa3qlgV6NrnOjKmuuPO4WCqzHxKmRgacAZa74lp
 ed0d1Xj0JZXi6PTTxgZ2MKonYftqK3UL9Z7xdjsVGI9b4QKfAtAXrp5exNauHL36/NGE
 oqrjdsbhGGb5Ucz0mDcTZCGYp+Bd7y10TxYbfiWGQiswwcgM4zYa/zSXIWdtSv/FVdwz
 dATQ==
X-Gm-Message-State: AOJu0Yz8B54HejMh4YdXnbq2TQVuONBdDhr3rYybLo1IfxjE/4w+VCV4
 KZiThceTihP+2PJw0+VE1kFbxDu+0/mRcADj8lzEaKRhHM1VwKsimoYUVmryQSpHmMZqYgkOApH
 y6ATO3wv0
X-Google-Smtp-Source: AGHT+IE1Cl3yWnKbQEeC1G3gO1USUFnQhQL94aXOd9oD9bmYIlyUOH7Ks42nue5bwUrJlF6S2xSP/g==
X-Received: by 2002:a05:622a:1313:b0:43a:c5b4:c079 with SMTP id
 v19-20020a05622a131300b0043ac5b4c079mr4170342qtk.52.1714613520667; 
 Wed, 01 May 2024 18:32:00 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.31.59
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:32:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 16/81] bus: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:30:33 -0600
Message-Id: <20240502013138.2383421-16-trini@konsulko.com>
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
 drivers/bus/ti-pwmss.c | 1 -
 drivers/bus/ti-sysc.c  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/bus/ti-pwmss.c b/drivers/bus/ti-pwmss.c
index 265b4cf83b59..d1f6f3bab00f 100644
--- a/drivers/bus/ti-pwmss.c
+++ b/drivers/bus/ti-pwmss.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2020 Dario Binacchi <dariobin@libero.it>
  */
 
-#include <common.h>
 #include <dm.h>
 
 static const struct udevice_id ti_pwmss_ids[] = {
diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 778c0654f6a3..5f9f0a0d0b7b 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2020 Dario Binacchi <dariobin@libero.it>
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <dm/device_compat.h>
-- 
2.34.1

