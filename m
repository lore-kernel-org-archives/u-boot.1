Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A06B0C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:50:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82FAF88B18;
	Wed,  1 May 2024 04:44:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="akXmoA93";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB00688AF2; Wed,  1 May 2024 04:44:05 +0200 (CEST)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1BFB88AFE
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-43716ff5494so4366581cf.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531442; x=1715136242; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GADpF0ShezhJ7vld5OPbmpFjJgymFGp/0gVVzKz0Uac=;
 b=akXmoA93N4NXeMiDPujla3lYS3+DlGwQWpic0n0m0DGCw1z3a5rZ906QNP1aLF/pap
 VXzW+Ce3UDLW8PMYfa5UIennbpBRcwbhyzxtssJdjt5KnwlSIi8RQAZVGHKSV0NVv2SF
 77nAsTTnRls8axN8mH6wjQ+MofxgbVnnAr6Nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531442; x=1715136242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GADpF0ShezhJ7vld5OPbmpFjJgymFGp/0gVVzKz0Uac=;
 b=hXRPSS3KiwCpl2tuDLV2asoimqgH/Sq6v9skIBM/5i4e59MEEdX/k7acxWTnJRjZPd
 ti0Ah6/lINIU+g7Pjae0bW1YZU0FNdJt7yKE6Ilhv9b0ZPjhbepsR7lre3gp1SfA3lFr
 V3TjJMtaZ3hjwhe8XtJfKcCvuiFVBqoBWIkKPZss3779yKqBpnD3FembBKYCE4dUiEFC
 8WhkH86DHD/BHz+BbYM4p2EZUSEYSzjfDTZiglKINsLrRSX+KPU3CBms/KhEZi66OE63
 Qen4fQfCpMt5tCbXpsZkrAUv6ipMC0glDPKjsZ71XXZgLweqjdMjJ4pN4b1ZlTMGd2Jp
 J1+w==
X-Gm-Message-State: AOJu0YxebCQbhWTIc/87r3nZdLvgoQ6EOW4i4l/W8A5GMope83VYbPey
 2+9uKBIYSIDCZak21pdj1oF0HQKwZdIaD1TuNNmUzgSGZRffHN/gzvVTOOVk4XdYYwtuJODbBYl
 wZIAFgg==
X-Google-Smtp-Source: AGHT+IECkNW/5CRiQ5Zs2EtbV9K54XmZiu72S8WAVBLdhY+9SHVLslMNl7C+1kivPT/y0TfFFzV7Fg==
X-Received: by 2002:a05:6214:4c01:b0:6a0:e170:a1f5 with SMTP id
 qh1-20020a0562144c0100b006a0e170a1f5mr5000751qvb.2.1714531442506; 
 Tue, 30 Apr 2024 19:44:02 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@denx.de>
Subject: [PATCH 038/149] board: cloos: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:25 -0600
Message-Id: <20240501024316.1767971-38-trini@konsulko.com>
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
Cc: Fabio Estevam <festevam@denx.de>
---
 board/cloos/imx8mm_phg/imx8mm_phg.c | 1 -
 board/cloos/imx8mm_phg/spl.c        | 1 -
 2 files changed, 2 deletions(-)

diff --git a/board/cloos/imx8mm_phg/imx8mm_phg.c b/board/cloos/imx8mm_phg/imx8mm_phg.c
index bc4e984d5056..091c9a59a52b 100644
--- a/board/cloos/imx8mm_phg/imx8mm_phg.c
+++ b/board/cloos/imx8mm_phg/imx8mm_phg.c
@@ -3,7 +3,6 @@
  * Copyright 2018 NXP
  */
 
-#include <common.h>
 #include <env.h>
 #include <init.h>
 #include <miiphy.h>
diff --git a/board/cloos/imx8mm_phg/spl.c b/board/cloos/imx8mm_phg/spl.c
index 0c3a0135a860..b8892ed2fccd 100644
--- a/board/cloos/imx8mm_phg/spl.c
+++ b/board/cloos/imx8mm_phg/spl.c
@@ -3,7 +3,6 @@
  * Copyright 2019 NXP
  */
 
-#include <common.h>
 #include <command.h>
 #include <cpu_func.h>
 #include <hang.h>
-- 
2.34.1

