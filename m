Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0DCC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:38:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6867388BEF;
	Thu,  2 May 2024 03:33:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gcaxBxxd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 670A088C64; Thu,  2 May 2024 03:33:13 +0200 (CEST)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D46D88BEF
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:33:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-43a14bce92dso48042541cf.0
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613590; x=1715218390; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TNx9S1yKskQeKTOeSZfT/bW4jhGP3MHnSCFF8zUST5c=;
 b=gcaxBxxdU5xRvNsC1FA890Z+2+gCG3qqrkJDKyUr38Du1big9bXs2Y7bBv5KJFFY0i
 s9Vtq/6ufngZR1LUTZHYrKJS0zDW2FaVJxumrQhQCwHT1bopsTnxO3LkntJ4VLCe1ArX
 QjPB9ps1j3MS4GJ/jZ5E/2Kq/FdHYcOHuIYEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613590; x=1715218390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TNx9S1yKskQeKTOeSZfT/bW4jhGP3MHnSCFF8zUST5c=;
 b=ikzfYytO6Q9aJ+BOPf6mR9lrtTMRb9N+r7bmVtOn2KytFhDUqSYp5BnJLBQGQNKjbR
 529ptgg1bCYtNeRW4VpnLfbFpqGz6ECZhjBd7BOTOFx9DV3kmkE0omqCpwb0ppBSLJHF
 1au23/pHZPrsnxSW+1s7WlbyvM9Jq32ghldpir9khVR5N547e3ukHQnCJoDocqnQguZR
 5jaz8qUn6JFLMmtZC+wYZT9q6yXBcdRwl4g3GP7rIurfDiRZmjaqdi8L7mwW2wF1p2Gq
 wnWC3I4LM86U1SVpNhN6+Z7+203WvgOE5NXQ385tJMaka18Yel6EA0vhucxJdZJDqBnV
 luAw==
X-Gm-Message-State: AOJu0YxAdWHu4rfl5PWxs3k/IAImDbX1mms/WvrjhDH8MINnhpkrysRg
 t7tCYLAZ6FQ82I/j+3iOIJBgItl13MXpzo5pB7UBM3Vf9Tf+X9Q72tb3JqdMAEh2AGlvmzJkruQ
 bhVUs1qFP
X-Google-Smtp-Source: AGHT+IG2FZiPMSB3D7T/kPsJ/M0VKMunyM05xT43fKfIG/InZGcDif+NRFTVsSiJbHewMQe9nUU35g==
X-Received: by 2002:a05:622a:64e:b0:436:5f58:84d5 with SMTP id
 a14-20020a05622a064e00b004365f5884d5mr608886qtb.21.1714613589750; 
 Wed, 01 May 2024 18:33:09 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:33:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Ramon Fried <rfried.dev@gmail.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 49/81] pci_endpoint: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:31:06 -0600
Message-Id: <20240502013138.2383421-49-trini@konsulko.com>
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
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
---
 drivers/pci_endpoint/pci_ep-uclass.c   | 1 -
 drivers/pci_endpoint/pcie-cadence-ep.c | 1 -
 drivers/pci_endpoint/sandbox-pci_ep.c  | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/pci_endpoint/pci_ep-uclass.c b/drivers/pci_endpoint/pci_ep-uclass.c
index 6ee4cfbdb4a8..902d1a51eaa3 100644
--- a/drivers/pci_endpoint/pci_ep-uclass.c
+++ b/drivers/pci_endpoint/pci_ep-uclass.c
@@ -11,7 +11,6 @@
 
 #define LOG_CATEGORY UCLASS_PCI_EP
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <asm/global_data.h>
diff --git a/drivers/pci_endpoint/pcie-cadence-ep.c b/drivers/pci_endpoint/pcie-cadence-ep.c
index d58c64982b27..e02ea14e4e4a 100644
--- a/drivers/pci_endpoint/pcie-cadence-ep.c
+++ b/drivers/pci_endpoint/pcie-cadence-ep.c
@@ -4,7 +4,6 @@
  * Written by Ramon Fried <ramon.fried@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <pci_ep.h>
diff --git a/drivers/pci_endpoint/sandbox-pci_ep.c b/drivers/pci_endpoint/sandbox-pci_ep.c
index de148cddb91e..aa623fa357d5 100644
--- a/drivers/pci_endpoint/sandbox-pci_ep.c
+++ b/drivers/pci_endpoint/sandbox-pci_ep.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2019 Ramon Fried <ramon.fried@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <pci.h>
-- 
2.34.1

