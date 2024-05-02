Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7766C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:37:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A3BF88C84;
	Thu,  2 May 2024 03:32:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XG4gVoT0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07BEA88C84; Thu,  2 May 2024 03:32:47 +0200 (CEST)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE51988C38
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:32:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-43ab76cac73so12863451cf.1
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613563; x=1715218363; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ksn/kuOOK+RxTJ7+xk/UKSj9QCHp7sWLyWL0En2PFdU=;
 b=XG4gVoT0jNh1UYfXFytezWQ3hp+z5i6dyliVpbNCIcRYXZnQ85NyupX6U9WWFW2CpW
 khITLgDorav8sJb2QCNVZ6nHmHZlnYqssSLiaop5HDxNwy53zgtI0nk9GFvR9EmsrG4Q
 CZFtf4duOnEZpvbCD/kiNEzAH9KMV8AtVLEf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613563; x=1715218363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ksn/kuOOK+RxTJ7+xk/UKSj9QCHp7sWLyWL0En2PFdU=;
 b=gUabfsOfSsO+joOdr2rC/LEUb2krQhscW+xYMSp0hssn5omBI8BJoSke3Cern1mfWS
 uWuveJ9KFYMHZWGlWAGfa1o4QHqwKkGe3txi7D23XPyRmg6RPBfqdg9tjCr5Vt1d516A
 Ls6tElCCLW6ftFrwJupAeGmQmhDYgqquSaiva9iABQblbm13+2WM3hxTXJnxUmgbTOdC
 LxJ+DWG/gd/3UqH02iesJtgsh+STdFX4AuDdrqFriq1LuON0apCbLzuy2F1fJ6Fgc5be
 WlWZBq+ke6IduizhVewn5o/+XbXKBvTQV7Mv7jrROse0p/xld4fLvEa4uuBeOWRpVXlq
 doNg==
X-Gm-Message-State: AOJu0YzL1iSm5aRiWAg4Tq0y7XasKsnB2grEjwKq7kOrQUofL6EYlwcF
 EcTqV3qcRAgKobLwlIwvvh4n9soa8eZIf9gm4McJAh6oQvzHKTb3Cr+jcHUeGwd9RU97TNvChnJ
 hKxoByKN4
X-Google-Smtp-Source: AGHT+IEs4/BVRE6LdEbazpCbKse0+qyyDDxgdb7IoSc1DyIjlzPUEnq33+hm3xFkw8Orx8I6QukrEg==
X-Received: by 2002:a05:622a:4a0e:b0:437:9c7e:ab1f with SMTP id
 fv14-20020a05622a4a0e00b004379c7eab1fmr2955950qtb.33.1714613563665; 
 Wed, 01 May 2024 18:32:43 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.32.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:32:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Christophe Kerello <christophe.kerello@foss.st.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Roger Quadros <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 40/81] memory: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:30:57 -0600
Message-Id: <20240502013138.2383421-40-trini@konsulko.com>
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
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Christophe Kerello <christophe.kerello@foss.st.com>
Cc: Eugen Hristev <eugen.hristev@collabora.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Igor Prusov <ivprusov@salutedevices.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Nishanth Menon <nm@ti.com>
---
 drivers/memory/stm32-fmc2-ebi.c | 1 -
 drivers/memory/ti-aemif.c       | 1 -
 drivers/memory/ti-gpmc.c        | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/memory/stm32-fmc2-ebi.c b/drivers/memory/stm32-fmc2-ebi.c
index 1ce960778586..713dead5c572 100644
--- a/drivers/memory/stm32-fmc2-ebi.c
+++ b/drivers/memory/stm32-fmc2-ebi.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_NOP
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <reset.h>
diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
index 41325eb0f941..29131f536a66 100644
--- a/drivers/memory/ti-aemif.c
+++ b/drivers/memory/ti-aemif.c
@@ -6,7 +6,6 @@
  *     Texas Instruments Incorporated, <www.ti.com>
  */
 
-#include <common.h>
 #include <asm/arch/hardware.h>
 #include <asm/ti-common/ti-aemif.h>
 
diff --git a/drivers/memory/ti-gpmc.c b/drivers/memory/ti-gpmc.c
index 8877b8f4385b..8af48e199a74 100644
--- a/drivers/memory/ti-gpmc.c
+++ b/drivers/memory/ti-gpmc.c
@@ -7,7 +7,6 @@
 
 #include <asm/io.h>
 #include <clk.h>
-#include <common.h>
 #include <dm.h>
 #include <dm/device-internal.h>
 #include <dm/device_compat.h>
-- 
2.34.1

