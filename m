Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0CF0C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:01:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ABE588BE4;
	Wed,  1 May 2024 04:45:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZmjNDkD9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A02D588BF9; Wed,  1 May 2024 04:45:08 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5CED88BE4
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6a05f376effso49633986d6.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531504; x=1715136304; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oIYMhYdUOSOxXqSIs2afYazuolG8WHjKGtm5J7zRjb0=;
 b=ZmjNDkD94W6o4LB201aFj9KYjCuMZOMWr4xFWl7MLKVeJDWuPvttodZcHLtyqYqQTK
 CwxcdlCJpJOhN6K7T9dBigvlVHRAZ9Ux01JD2gupFbfomrjTKvPyCe+AqrrXBsGtYWVN
 qZnm8YeMj6kE0U/byMItR2jlTSnj6QZg+UF1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531504; x=1715136304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oIYMhYdUOSOxXqSIs2afYazuolG8WHjKGtm5J7zRjb0=;
 b=KDhb8JYbgItoTqK5ef11y+rRN8t9m2390FSY4XiblkhrozLqQNeNdLt+lQC48NUE24
 iE9af5Y+b0FTXkL0BVRGz5ZwczBPhuRR5L4IvZ+wvOKA7ygLWRgpKwoVlJS68va6gs2s
 8sPL+TNqkIIpd/6h1LoT0+jbqFRpjEwjZP1IRmMSySzODjq2DtKQmpLVNQcN+Y4TbkuX
 nzCEcciOOtY1WwNZf46gcQaseOvGfs+cvgR/5gcS0nb+RtRwntcy6fWALjqCm1uMNHjO
 orOkTaI3yCZ1WhMjTYnA6SxB5oFj18Kc/vC3l7kRqygluWzz6X75PMLJAWu5IVtXBMQz
 Ny2Q==
X-Gm-Message-State: AOJu0YwGUpuigIMkurAbK3A1mWm+IzkwKhf1SJKfTk0MlgiNfc1+Bswa
 jOGFBDlO59iw74OvL7WNRZznmO0fhdu7e+3zF7Js+nJbe/IcXxibLlUdf4boHlpIf93BEwMAUDB
 tvBs2N79g
X-Google-Smtp-Source: AGHT+IEMtQIIijfKNP0AFf2wPUT06KxAyn+eGzE2qe5/ipxSDaNZKwBg/LaRGz1fI01gd/4Crhx67Q==
X-Received: by 2002:a05:6214:4114:b0:6a0:7913:641f with SMTP id
 kc20-20020a056214411400b006a07913641fmr1078121qvb.62.1714531503934; 
 Tue, 30 Apr 2024 19:45:03 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Luka Kovacic <luka.kovacic@sartura.hr>,
 Luka Perkov <luka.perkov@sartura.hr>
Subject: [PATCH 091/149] board: mikrotik: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:42:18 -0600
Message-Id: <20240501024316.1767971-91-trini@konsulko.com>
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
Cc: Luka Kovacic <luka.kovacic@sartura.hr>
Cc: Luka Perkov <luka.perkov@sartura.hr>
---
 board/mikrotik/crs3xx-98dx3236/crs3xx-98dx3236.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/mikrotik/crs3xx-98dx3236/crs3xx-98dx3236.c b/board/mikrotik/crs3xx-98dx3236/crs3xx-98dx3236.c
index 315169ba661d..ae1c586277f9 100644
--- a/board/mikrotik/crs3xx-98dx3236/crs3xx-98dx3236.c
+++ b/board/mikrotik/crs3xx-98dx3236/crs3xx-98dx3236.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015 Stefan Roese <sr@denx.de>
  */
 
-#include <common.h>
 #include <i2c.h>
 #include <init.h>
 #include <asm/global_data.h>
-- 
2.34.1

