Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9455EC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:41:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FCBE88D01;
	Thu,  2 May 2024 03:34:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WRPs7TxP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27C5F88CB7; Thu,  2 May 2024 03:34:06 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B315A88CDC
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:34:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-43ca8e1f990so4018811cf.0
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613641; x=1715218441; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xjbavlt6m19P8uyC78oiZzqWHc2u2QNHiD1RCbFClsw=;
 b=WRPs7TxPYvnPAPHkPpr1lnKh+whRFmSz7qdq8tzUGosrvo/RBaA3bE2/ZmABNQasjC
 dGP4HpSnjE+3/FzXW1y49uYzoi5dnf1KYiN1/MQ0G7PPzyPVV/94BOCeNu1jHLRxkRJs
 6sSNBQ283jKDvRyEOBP3wpJseXppgXdZ2syzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613641; x=1715218441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xjbavlt6m19P8uyC78oiZzqWHc2u2QNHiD1RCbFClsw=;
 b=IzzGh8qErWsoNXDQpZnSsQhptIsocgwByNN7NKCiuH/+RUf0aWfG2fgOdaOm6SE6yn
 fHlLzg59R39y3FR55vAoWDI6Vs9m9KObbuItzYGImo38yYBKcdcBSPSvzcmvt0lvO29c
 +hUeCf2L1RC0/zkGKACJ5mWhrQnTqLCZ+0qkRE17hVlPDFWdPOeXwHBnwDSUgwq3x+dj
 ZhTUwG4uC9P58/vVC/14F1MOPWzr1xJ+IbRxY1zmrltQ4M8iRgIKpYmLRwb0Wqduo+ZJ
 Pt0z0VM6GkbnJ+nsa1ssbCKIjWClOhHgSNPSe1gvNB0cdNDN3kZTEThyl+QNIz8yBFQF
 bT1g==
X-Gm-Message-State: AOJu0YyeTZPjozQRfpA4CUGdDbJxNbrTmYA6rTmyEcszMZPnn7aCW+4H
 nNcFd8cqokdwlHfFmjLiEyNXlRhpUd96h+G5mMpnxHRCAe4226OBOIDZ3JO1ztAgf5dgqUBXvR/
 gjNtiLgUR
X-Google-Smtp-Source: AGHT+IGyR+QZxdw8ypN8VfZXcJB+cbWJKG+GgFav2mYFHkNaS+rVpnwSTOX4Y5QxrAVr5+JQ3VJgaA==
X-Received: by 2002:a05:622a:5497:b0:439:de9d:620c with SMTP id
 ep23-20020a05622a549700b00439de9d620cmr2448811qtb.20.1714613641400; 
 Wed, 01 May 2024 18:34:01 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.34.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:34:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>
Subject: [PATCH 72/81] ufs: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:31:29 -0600
Message-Id: <20240502013138.2383421-72-trini@konsulko.com>
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
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
Cc: Neha Malcom Francis <n-francis@ti.com>
Cc: Tom Rini <trini@konsulko.com>
---
 drivers/ufs/cdns-platform.c | 1 -
 drivers/ufs/ti-j721e-ufs.c  | 1 -
 drivers/ufs/ufs-pci.c       | 1 -
 drivers/ufs/ufs-uclass.c    | 1 -
 drivers/ufs/ufs.c           | 1 -
 drivers/ufs/ufs.h           | 1 +
 6 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/ufs/cdns-platform.c b/drivers/ufs/cdns-platform.c
index d1f346937c5d..510a6a6aa5dd 100644
--- a/drivers/ufs/cdns-platform.c
+++ b/drivers/ufs/cdns-platform.c
@@ -6,7 +6,6 @@
  */
 
 #include <clk.h>
-#include <common.h>
 #include <dm.h>
 #include <ufs.h>
 #include <asm/io.h>
diff --git a/drivers/ufs/ti-j721e-ufs.c b/drivers/ufs/ti-j721e-ufs.c
index 1860e0dca299..c5c08610ffd0 100644
--- a/drivers/ufs/ti-j721e-ufs.c
+++ b/drivers/ufs/ti-j721e-ufs.c
@@ -5,7 +5,6 @@
 
 #include <asm/io.h>
 #include <clk.h>
-#include <common.h>
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <linux/bitops.h>
diff --git a/drivers/ufs/ufs-pci.c b/drivers/ufs/ufs-pci.c
index ad41358727a5..871f3f50f5ca 100644
--- a/drivers/ufs/ufs-pci.c
+++ b/drivers/ufs/ufs-pci.c
@@ -4,7 +4,6 @@
  * Author: Bin Meng <bmeng@tinylab.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <pci.h>
diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index 92fcdf4e6cb7..334bfcfa06a4 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -7,7 +7,6 @@
 
 #define LOG_CATEGORY UCLASS_UFS
 
-#include <common.h>
 #include "ufs.h"
 #include <dm.h>
 
diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index e4400f319a78..be64bf971f16 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -10,7 +10,6 @@
 
 #include <bouncebuf.h>
 #include <charset.h>
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <dm/device_compat.h>
diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index 816a5ce0cafc..43042c294bba 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -2,6 +2,7 @@
 #ifndef __UFS_H
 #define __UFS_H
 
+#include <linux/types.h>
 #include "unipro.h"
 
 struct udevice;
-- 
2.34.1

