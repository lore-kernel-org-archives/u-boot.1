Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F25FC369D9
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 01:06:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 040DB826AD;
	Thu,  1 May 2025 03:05:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Wd2F0WA8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19A2A8056A; Thu,  1 May 2025 03:05:54 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87BBD8210F
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 03:05:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3d5e43e4725so1358605ab.1
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 18:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746061548; x=1746666348; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bh8WkGqcNYSMg1OhceCTKCkCT6M7wqBYjAYR+O4Jksk=;
 b=Wd2F0WA8Bg/3doDjU52ffOONDNU8hO9YcQiyWeejOY/4eKCFco70fhw1QzjCoJxf84
 q7QsY/AYQAvbkWe7695S/ZfKmYEXEkYkzHzQdQ1hi6A1CH7KsakhgV0SGswSPkYZ1yAX
 QtuRoN3G5UNQcAp5ufYjfoorViBxyR/jvcwZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746061548; x=1746666348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bh8WkGqcNYSMg1OhceCTKCkCT6M7wqBYjAYR+O4Jksk=;
 b=SbBPzmWxm/TGg+OxYe2Ru7Hml4M/JYPPP+6l74arwCPuXpDpFEV5ryro1/hQpiZUxO
 vcfLugvKsK13RKQux9SuSLKyCx7WTBcxuPFWtxWyx7m+2eh/HqWWfIZU7vWTzTNFNf0G
 RgzFkoEtGSjzbHOZ9PLd2kn6fNxmI11iyDzorGmypdCJZ6Cjc+8pQWvwiDGEfACXsu31
 DMga1Lmx2IbFru/BCv/7G3WPd9YjsXCQdbYY3GCdojgf+3w+j9KPtJjT5jic/rK62iFB
 E9yRQ6X3dD2kSCKvW27pWYk3B5ar3iwtc1E2KAzwrKhRosBRJV3ugB9lsLKovdOmCXbb
 Bssw==
X-Gm-Message-State: AOJu0Yy1xQ11+tYP4FvZW0/NxXR9ge+rP3fLPvyYVjnnFX5i4t1yyRyG
 JiQEkAMbaZlzaAd+JVQ1eVHqRgbY30+GF/VR9s+7ey9/Z1HxrV6dNAtAxPERFM4eeEGCkKIjDCA
 =
X-Gm-Gg: ASbGncttL0EgqS8pEn3/ab69e7NrZKo++lFxj396n+AIGHKmNd8b8VLZ0uOw4M2RbiO
 NOVJSSorXeazf/+uryoQJec1pXJBmPARUd5PiPCjK20EfkaGXOBQocyJaD9oQAwhaNJ3l0q/zss
 qzbi7TXz9jvJyxrhNfqN9yGA/lc+RRxT7YGSW3SUfhVDo/SMZ96ijb6Cj98BgP5DklKjqbgXZmr
 I9TkI4bydPaVwGgSoPg0tapLU1h/O3x8xnix/d73CU2ZETq43FAFhIxpYkhekJ22OHkIFGMC/gL
 dIgR9eQAqHLOmbFD5WM4NYAy5tw59HC/qpzeDKsiqrVpx60WoNMPByoG5t27S4NCR0vwTASgtT6
 oDxdUVNnN5Aev
X-Google-Smtp-Source: AGHT+IGOKrzRpJ91AjDAXZ7/Xcw667q4GmpbN21fEwQ9eyBqDvbOt3sfaFtzaIEMmC78QkEK9jQ/ew==
X-Received: by 2002:a05:6e02:1aaf:b0:3d9:24a7:db0c with SMTP id
 e9e14a558f8ab-3d96f1b20ddmr17130795ab.8.1746061548669; 
 Wed, 30 Apr 2025 18:05:48 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d95f480a99sm10771855ab.68.2025.04.30.18.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 18:05:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Viacheslav Bocharov <adeep@lexina.in>,
 u-boot-amlogic@groups.io
Subject: [PATCH v2 12/22] amlogic: Include env.h to permit reading the
 environment
Date: Wed, 30 Apr 2025 19:04:37 -0600
Message-ID: <20250501010456.3930701-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501010456.3930701-1-sjg@chromium.org>
References: <20250501010456.3930701-1-sjg@chromium.org>
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

This file reads from the environment but does not include the correct
header. Update it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 board/amlogic/jethub-j100/jethub-j100.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/amlogic/jethub-j100/jethub-j100.c b/board/amlogic/jethub-j100/jethub-j100.c
index b770a1f8c53..9e87fb9f9d7 100644
--- a/board/amlogic/jethub-j100/jethub-j100.c
+++ b/board/amlogic/jethub-j100/jethub-j100.c
@@ -5,6 +5,7 @@
  */
 
 #include <dm.h>
+#include <env.h>
 #include <init.h>
 #include <net.h>
 #include <asm/io.h>
-- 
2.43.0

