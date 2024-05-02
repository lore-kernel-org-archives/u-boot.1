Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE26C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:36:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5163388C66;
	Thu,  2 May 2024 03:32:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k+HWOLG1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D917888BDF; Thu,  2 May 2024 03:32:30 +0200 (CEST)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CE1F88BDF
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:32:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-43ab76cac73so12862081cf.1
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613547; x=1715218347; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=41Nz/u3j/efVd+aX44DOkZ7MgF4rWK3oZLCE+CpzlOI=;
 b=k+HWOLG12ZEh9JwdKlOZY57UpjU5Uq3O1CW2sh9QHlejSPfXKaPxkz0jjKr+0nOelW
 chw+o5CdE1IcQsFe1q26JADd+4wsPFwvPB6hv6p1kYIeN5UM9KudboEAR3zIccsv/zuC
 1BaMtY0rrkKPZpL/PZDVtCKo24YcsJ6zHu32Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613547; x=1715218347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=41Nz/u3j/efVd+aX44DOkZ7MgF4rWK3oZLCE+CpzlOI=;
 b=pooDq/2hBs2XWHvuWeKk/A86vhDiqNakpYAFx8ToWNij90uqzpC25AgeqVFLo+PB22
 HtpcawNmU8NEo+LcmK+DTS41QPkGztb44a7avzUtJP5K0kUtkddhdYmwvwmHzE9e5UEe
 fkD5hl26bdu3HYmWkF0yML9Xxj9Jy3KYO1xVcHC4c/C0a+nh/yIgSfNl3mIx14pu6LFs
 Rh1IUg2rkCBOCodZbR4V9Sdz/rlA/SWcBWw5VoDpP+JY76vH5FxAlQeJeyVL4qS/sHn4
 mBMOixVlwKVmK8+XRrBSU2WEm1h4J/O1AvmNjLWr8A+GvU8i5FQcd6t/IyF8pPogDuM+
 LxJQ==
X-Gm-Message-State: AOJu0YzS7WBu/9C1EESwXXiwHto9fl7cCO5cD/W20R87TwTOCQ7j+mKd
 wq/fsa9ZU9Xno/D4euxZ9by4/NH+LmaAKfb5RHO8ZOj6vReyr8jeHAEbrGLvov//FWa/bPlEs27
 8lpBYrTxs
X-Google-Smtp-Source: AGHT+IHg7psd12QUFFR+cNmX1DH5K+RMahZnqPkGOHy3BWWLUW5v7Opaq+5Cwtmhehhpg9222f0JrQ==
X-Received: by 2002:a05:622a:5497:b0:439:de9d:620c with SMTP id
 ep23-20020a05622a549700b00439de9d620cmr2444418qtb.20.1714613547365; 
 Wed, 01 May 2024 18:32:27 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:32:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Etienne Carriere <etienne.carriere@linaro.org>
Subject: [PATCH 32/81] fwu-mdata: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:30:49 -0600
Message-Id: <20240502013138.2383421-32-trini@konsulko.com>
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
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Etienne Carriere <etienne.carriere@linaro.org>
---
 drivers/fwu-mdata/fwu-mdata-uclass.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/fwu-mdata/fwu-mdata-uclass.c b/drivers/fwu-mdata/fwu-mdata-uclass.c
index 0a8edaaa418f..bab7a7e80d1d 100644
--- a/drivers/fwu-mdata/fwu-mdata-uclass.c
+++ b/drivers/fwu-mdata/fwu-mdata-uclass.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_FWU_MDATA
 
-#include <common.h>
 #include <dm.h>
 #include <efi_loader.h>
 #include <fwu.h>
-- 
2.34.1

