Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E39C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:51:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C63988B2F;
	Wed,  1 May 2024 04:44:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jFN8NFCw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 700FD88AFA; Wed,  1 May 2024 04:44:12 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F0C888AB6
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-79100a90868so189344585a.2
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531449; x=1715136249; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SvPciHnFD5/bR5S8s2Go1AKllo7K9GsXGwFe4scAqC0=;
 b=jFN8NFCw/Jh5Pc0otSrPZkwhkbgbGKa0zTsU6IPGSph575R36czttlaVCKjgpdl/2w
 mz1RbtROscpxXEICtQGp2BrzjiZBBN+6DA9D2vrgn/372kPUY8ylHSG65BVAW/BeT+6o
 9nlxzxyU2Rhi3FaS/w1ymPSYq8XhQjhYwc5R4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531449; x=1715136249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SvPciHnFD5/bR5S8s2Go1AKllo7K9GsXGwFe4scAqC0=;
 b=Rfl5hBNaBfzSXEHcIey3Kw02UHZPlByxgoQfZ+lnaf6ooVbG7GuqkksftMRrNa0NpB
 MguGI31eUDmvggMXajpiVmsgS8uixdbxHovKmEzg9I/4r8t9NiDP3SUXE4YqOtwUJgfw
 G539vS2tXmyUjCU/hAX4MgdSSNnebSaLb1plRWM8rkYKPCaJvdlMvcKbqNjOWXqySlTw
 IBoL/pB/fk8tminVZ5X2WQk6VUMX/vhkwUsCUimVXBE9jScj2crHueqL1JmMCpvJw2Kb
 cQLvvL0ZN/x2ca9dFKeyg13nJTEcMnSy14IIZ25lXI3bMSspV9Yn0yCIeTUw899+3OJ/
 Tv4w==
X-Gm-Message-State: AOJu0Ywe3tcT4h4Z/s6ZBXJNggB2GrXsQUvfnEUeudvakJbj4WMQsYod
 QPieWOg56wn4pI9FSFhmJ+318vfpDsEz1HzRvK9wCzeBSHR91xDVvIzvfK0EOG50/QRrujzahp4
 EMHQ8mA==
X-Google-Smtp-Source: AGHT+IEAjKrgwpZaFRYUAwBn9k5YJzl51E9oNxiSj5e5UlY510sQBg6XeKo5BrzRtmezTjiWkmfU6A==
X-Received: by 2002:a05:6214:529a:b0:6a0:b746:870d with SMTP id
 kj26-20020a056214529a00b006a0b746870dmr1281111qvb.33.1714531448780; 
 Tue, 30 Apr 2024 19:44:08 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Oliver Graute <oliver.graute@kococonnector.com>, Stefan Roese <sr@denx.de>
Subject: [PATCH 043/149] board: congatec: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:30 -0600
Message-Id: <20240501024316.1767971-43-trini@konsulko.com>
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
Cc: Oliver Graute <oliver.graute@kococonnector.com>
Cc: Stefan Roese <sr@denx.de>
---
 board/congatec/cgtqmx8/cgtqmx8.c                           | 2 +-
 board/congatec/cgtqmx8/spl.c                               | 1 -
 board/congatec/common/mmc.c                                | 3 ++-
 board/congatec/conga-qeval20-qa3-e3845/conga-qeval20-qa3.c | 1 -
 4 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/board/congatec/cgtqmx8/cgtqmx8.c b/board/congatec/cgtqmx8/cgtqmx8.c
index d8e5b1d69633..99c33a1943e0 100644
--- a/board/congatec/cgtqmx8/cgtqmx8.c
+++ b/board/congatec/cgtqmx8/cgtqmx8.c
@@ -3,7 +3,7 @@
  * Copyright 2018 congatec AG
  * Copyright (C) 2019 Oliver Graute <oliver.graute@kococonnector.com>
  */
-#include <common.h>
+#include <config.h>
 #include <errno.h>
 #include <linux/libfdt.h>
 #include <fsl_esdhc.h>
diff --git a/board/congatec/cgtqmx8/spl.c b/board/congatec/cgtqmx8/spl.c
index b432ce27459f..242e794981b7 100644
--- a/board/congatec/cgtqmx8/spl.c
+++ b/board/congatec/cgtqmx8/spl.c
@@ -4,7 +4,6 @@
  *
  */
 
-#include <common.h>
 #include <dm.h>
 #include <fdt_support.h>
 #include <init.h>
diff --git a/board/congatec/common/mmc.c b/board/congatec/common/mmc.c
index bb7a3d4a9aa0..74a189ab4d7f 100644
--- a/board/congatec/common/mmc.c
+++ b/board/congatec/common/mmc.c
@@ -4,7 +4,8 @@
  * Copyright 2018 NXP
  *
  */
-#include <common.h>
+
+#include <vsprintf.h>
 #include <linux/errno.h>
 #include <asm/io.h>
 #include <env.h>
diff --git a/board/congatec/conga-qeval20-qa3-e3845/conga-qeval20-qa3.c b/board/congatec/conga-qeval20-qa3-e3845/conga-qeval20-qa3.c
index 315b6dc54295..4197e88fb6ff 100644
--- a/board/congatec/conga-qeval20-qa3-e3845/conga-qeval20-qa3.c
+++ b/board/congatec/conga-qeval20-qa3-e3845/conga-qeval20-qa3.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2016 Stefan Roese <sr@denx.de>
  */
 
-#include <common.h>
 #include <i2c.h>
 #include <init.h>
 #include <winbond_w83627.h>
-- 
2.34.1

