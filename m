Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60AB6C48BC1
	for <u-boot@archiver.kernel.org>; Wed, 14 Feb 2024 18:36:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E01E787E01;
	Wed, 14 Feb 2024 19:35:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="UERoPtoU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27B8987E01; Wed, 14 Feb 2024 19:35:36 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 078788772A
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 19:35:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a34c5ca2537so2512266b.0
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 10:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1707935705; x=1708540505; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yMsPcd2xDlGpAiuUGS5EUyZVuzXo04S1B8JHfgKH9Fc=;
 b=UERoPtoUkrGMJv9+1Nz0QuRe/BGGCH6BiIqzKjuTsXA3d1fedDqap+c9zwEMxMDNHy
 KCng3vD/myh+9Bd39fCzHNVJfwPH9W3+9xyxA/kERu68TxGfXbTDC4YAeffazyRzadx8
 FjyFXmsNBig+BV2boBTIiuvo0m8Ks7ZRURblFCXv7uwKowgKgbx1GLLa4JEPDFTKWuii
 1ZFwpUg4ZO3eGUD19vwVHuJUtin++e6rHO8Am51ef2Tku7vTd0lyjnj2BWgL5PzdatPo
 uYJ5HTxRAWjK3Oytutfy31N6YEwcATimycDsmpHeapN863E1+KgjRTmf+F56SC3TtNVp
 3zwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707935705; x=1708540505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yMsPcd2xDlGpAiuUGS5EUyZVuzXo04S1B8JHfgKH9Fc=;
 b=WmCASczBp/4e6NCkSu8pB6a2Wfw8m3i1s6CpH6+LjST5g76/Jgx22ZQjJ2P22n3qVx
 wUfpY0nv7IQO+KTaekIDDzPuTTlbtz1y482xtkDInlK2gweEwaDXQg/a0bgUB2O6afd1
 ryJjveN5FpAlPsqYwDr5H17g1VqEWwvvoBk76/i2+6v22cH1EWm1bJpqkFPkN8uimjbc
 AVA34MCuJ0XrapIWSLTybicqJ6pbJ8WIJvtGR+sSjH+SuuTPfaSp4cOUEVLSPVw+csdT
 RDdJwOvT9WTkNASZBIarthttBZnncI2LDkA4y9/zoETeKkrsDFQQz8NaQNPxP0ytmEvi
 spOQ==
X-Gm-Message-State: AOJu0Ywouta2ccJD37AviYaNQAlRxPtc8NwEGhpcZoPVcyLG2f9ewyhw
 BqUQZzo8FoLgVsnicwcpwNlp4RXUHehP4xcz/1LsTZRNvbD8QEppgK0ZysIpqWbckwHLMxWeadF
 Yytc=
X-Google-Smtp-Source: AGHT+IH3JVKcf59txiiMh0ZU2sPzdd04y2SIek20GEDSlr3LNZl7ZiakLMiAly17nsQLKiboiGn+sQ==
X-Received: by 2002:a17:906:344f:b0:a3c:92c2:66e0 with SMTP id
 d15-20020a170906344f00b00a3c92c266e0mr2593548ejb.64.1707935705004; 
 Wed, 14 Feb 2024 10:35:05 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWVAgjS2V+wigFyBZcT+dCf5WMa/0va92EIB5qDsVuq9lcZGxhoDRXvh25mbrZHWj4lXm5xVoU8al625PjcZQj2BjH9Tqvk4GTvv3Q6mgscKwS4GUbv11JcWfcddwTV1s4wzGlHsVSVauyJdEKdQYizGQoi4P6fqFeglaAkNgSaZsqDrig1vkQ/WuLO/XuEXc9ywToKXBYpMCSJeqCsNllCA982DQ6Kx78/ce/BNFUjyCOJPozSjP61CmoS3cSk2eiOZvKnoitMALfS6ndJvgIvLF37Be4fYtvfOWw=
Received: from localhost ([185.186.156.113]) by smtp.gmail.com with ESMTPSA id
 tx7-20020a1709078e8700b00a3d76123920sm132968ejc.223.2024.02.14.10.35.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 10:35:02 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@foundries.io>
X-Google-Original-From: Igor Opaniuk <igor.opaniuk@gmail.com>
To: u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Jorge Ramirez-Ortiz <jorge@foundries.io>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 5/5] tee: remove common.h inclusion
Date: Wed, 14 Feb 2024 19:34:44 +0100
Message-Id: <20240214183444.493629-6-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214183444.493629-1-igor.opaniuk@gmail.com>
References: <20240214183444.493629-1-igor.opaniuk@gmail.com>
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

The usage of the common.h include file is deprecated [1], and has already
been removed from several files.
Get rid of all inclusions in the "drivers/tee" directory, and replace it
with required include files directly where needed.

[1] doc/develop/codingstyle.rst

Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---

 drivers/tee/broadcom/chimp_optee.c | 2 +-
 drivers/tee/optee/core.c           | 1 -
 drivers/tee/optee/i2c.c            | 1 -
 drivers/tee/optee/rpmb.c           | 1 -
 drivers/tee/optee/supplicant.c     | 2 +-
 drivers/tee/sandbox.c              | 2 +-
 drivers/tee/tee-uclass.c           | 1 -
 7 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/tee/broadcom/chimp_optee.c b/drivers/tee/broadcom/chimp_optee.c
index 37f9b094f76..c142ebd542f 100644
--- a/drivers/tee/broadcom/chimp_optee.c
+++ b/drivers/tee/broadcom/chimp_optee.c
@@ -3,9 +3,9 @@
  * Copyright 2020 Broadcom.
  */
 
-#include <common.h>
 #include <tee.h>
 #include <broadcom/chimp.h>
+#include <linux/errno.h>
 
 #ifdef CONFIG_CHIMP_OPTEE
 
diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 47f845cffe3..5fc0505c788 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2018-2020 Linaro Limited
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <dm/device_compat.h>
diff --git a/drivers/tee/optee/i2c.c b/drivers/tee/optee/i2c.c
index ef4e10f9912..e3fb99897c5 100644
--- a/drivers/tee/optee/i2c.c
+++ b/drivers/tee/optee/i2c.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2020 Foundries.io Ltd
  */
 
-#include <common.h>
 #include <dm.h>
 #include <i2c.h>
 #include <tee.h>
diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb.c
index 5bc13757ea8..bacced6af6c 100644
--- a/drivers/tee/optee/rpmb.c
+++ b/drivers/tee/optee/rpmb.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2018 Linaro Limited
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <tee.h>
diff --git a/drivers/tee/optee/supplicant.c b/drivers/tee/optee/supplicant.c
index f9dd874b594..8a426f53ba8 100644
--- a/drivers/tee/optee/supplicant.c
+++ b/drivers/tee/optee/supplicant.c
@@ -3,10 +3,10 @@
  * Copyright (c) 2018, Linaro Limited
  */
 
-#include <common.h>
 #include <log.h>
 #include <malloc.h>
 #include <tee.h>
+#include <linux/errno.h>
 #include <linux/types.h>
 
 #include "optee_msg.h"
diff --git a/drivers/tee/sandbox.c b/drivers/tee/sandbox.c
index ec66401878c..8ad7c09efdd 100644
--- a/drivers/tee/sandbox.c
+++ b/drivers/tee/sandbox.c
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) 2018 Linaro Limited
  */
-#include <common.h>
+
 #include <dm.h>
 #include <sandboxtee.h>
 #include <tee.h>
diff --git a/drivers/tee/tee-uclass.c b/drivers/tee/tee-uclass.c
index 52412a4098e..0194d732193 100644
--- a/drivers/tee/tee-uclass.c
+++ b/drivers/tee/tee-uclass.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_TEE
 
-#include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <log.h>
-- 
2.34.1

