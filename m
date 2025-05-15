Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7837CC3ABC9
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 23:43:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 944F882B07;
	Fri, 16 May 2025 01:42:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ck88OCCr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7692A82AFD; Fri, 16 May 2025 01:42:16 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F3B080107
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 01:42:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-72b0626c785so1590631a34.2
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 16:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747352533; x=1747957333; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0IJ8HKpmKUfP5Nvw2u0e1TeX4RBXq72MBhnix6xoA+k=;
 b=ck88OCCrWLHAqYsGe5tKamrn5tBI92egJ25QZRfL1+j3Pt5OYN7U8QdwbfrMe9vOqr
 CPRfFT+2YDKsgHDQbEZGeCHkwXSO4A3PBR5i4EgF8EsScOD1rJ5hEFc1nTm9BySyf59z
 yJXqhHdoWdMsOJISTRjHrTeA55v6eMIpnRgnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747352533; x=1747957333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0IJ8HKpmKUfP5Nvw2u0e1TeX4RBXq72MBhnix6xoA+k=;
 b=bMGR68cKleavkGuT/LLovRAKhTThbt8pNVxf9seoaQXqNOAWNr2wCEPVzUG47kHFD9
 QGOskbZ05KyNh97+mWdcps1nqOBetSzDhLWDXtvDVY5+A7V7mI9hOYmNEz0uLqXPnetB
 52LiQ3sB2Sh0j4H9ff2t7LjzvtBPbG7dU0JGEBBKpootVLQL7IG61BSMUiEbyvXF/2yJ
 2kw9HD7AAMWJA2IUda5q/K090BtVjtTfkEJ2TRI7CK0kt4Yc7jDqQZe6HxNuOBJyisT0
 uuGvgkur3FNm6vRvzjLlX9dWThMbBq7KpjoIxoS3uF6kllCAhhR83dE/P+tPEShKfYhb
 fiEw==
X-Gm-Message-State: AOJu0YwzahyRBtYCe2O9IkFOF/FsppXxDNcV0EXppaksjObV2+XnfzID
 sAY0KvNOYjwDzYjiDUJB0AnzzWUR0FRgI/ro5H4DfeqjTLCM3BMsQBLl9PZvfExJEJFF0zPY0QB
 T/ochP18=
X-Gm-Gg: ASbGncsqtrYjW/vd8XNkGrL0NI4uKD1qk+/umhLG1t+8pCYOdGZ78JNfa+TsWh6TwYY
 hfxMezV80TxfdfFAyf0aFm9gCUVYvYrWrsviUcYwz44DU+jPwZJMIE4GJY4CcmI1tgbGKIW2Riu
 5zBO/RKGFk0d53DLd4x64rjHmwt+zV3MLsWrs7HfuBg7MXFVR+2R6yXr+u9z7YVaotGrlzGcpMT
 3nadAJMaiGLiycwfkz/SI5BHdrfTo7ymSsIepEMswqsNJH/1DTG1fv5phi01k5KhNE/ETLgWwhv
 gXoPkzUW2p03q/hPOJznDB70pxPWSp2nXxBnbL80aLaOcCP1CtnCQHW2weHcYFOa0IiG2XscpTJ
 2ghzEqphjx8nrY1U=
X-Google-Smtp-Source: AGHT+IFB/QxmPMmLKAmevTqllAnlPL5NU5fUPRtnkvy+pup55qxlEI8g5/DwrdIieDwXWwnc7Ga8fQ==
X-Received: by 2002:a05:6830:681a:b0:72b:9c34:1361 with SMTP id
 46e09a7af769-734f6b0465cmr1147090a34.15.1747352533204; 
 Thu, 15 May 2025 16:42:13 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6b3a9b3sm147559a34.52.2025.05.15.16.42.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 16:42:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH v3 12/22] synology: Include env.h to permit reading the
 environment
Date: Thu, 15 May 2025 17:31:41 -0600
Message-ID: <20250515234154.1859366-13-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515234154.1859366-1-trini@konsulko.com>
References: <20250514225002.15361-1-trini@konsulko.com>
 <20250515234154.1859366-1-trini@konsulko.com>
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

From: Simon Glass <sjg@chromium.org>

This file reads from the environment but does not include the correct
header. Update it.

Reviewed-by: Stefan Roese <sr@denx.de>
Reviewed-by: Tony Dinh <mibodhi@gmail.com>
Signed-off-by: Simon Glass <sjg@chromium.org>
---
Changes in v3:
- None
---
 board/Synology/ds414/ds414.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/Synology/ds414/ds414.c b/board/Synology/ds414/ds414.c
index 1a4cea87e1a7..02d6a4a1ea8a 100644
--- a/board/Synology/ds414/ds414.c
+++ b/board/Synology/ds414/ds414.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2015 Phil Sutter <phil@nwl.cc>
  */
 
+#include <env.h>
 #include <init.h>
 #include <miiphy.h>
 #include <asm/global_data.h>
-- 
2.43.0

