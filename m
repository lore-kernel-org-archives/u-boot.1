Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707B5C369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 01:06:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF4AD80F03;
	Thu,  1 May 2025 03:05:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bpUSgZDC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 424358056A; Thu,  1 May 2025 03:05:34 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 550218059D
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 03:05:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-861525e9b0aso37370839f.3
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 18:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746061529; x=1746666329; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xcOIdz4H9/lfoQxgg6bifc46tRhqsr8bwYLo3iijCQY=;
 b=bpUSgZDC0Z8I41YL3mxW2NP/a+W3I4QkcjMZjt5Z8cbEB6XLP5yGmH98+kUNV53um6
 hMSkVdsL0U/ZmL6GopPdQCz9FNJkW1x09W02zkE1RikNQjJ+S7iXajGGf2gzOLVNtZF3
 xp5BBbd5bhifftuC5DoCThKt2SwNjj/l5edZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746061529; x=1746666329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xcOIdz4H9/lfoQxgg6bifc46tRhqsr8bwYLo3iijCQY=;
 b=v/YGdoTNXui0DVxV7TyOZ3dseBMzkDkK4rwOf84xGuMdwnTqIrNTn/92Xf7xB87V69
 qqtQf0hTniU0QTPhXf/ahajDBU6Ss6+AjU2m+4Iexpawtn49hkTD63dkiTVmqIOxtLqE
 y3w25IuhAuD17FumvW+f+fU7H/hsR31YNO4ObVUGxsRUvw0e2jtyePBOzsq1smBm5pcO
 gDXYqdkSSCs84OsZ6FJXzfCoQoWOhP6w64iGVMxxGmU3ap6tHtQL8mWI8Wc/Hlx4T3xe
 +jt/s8Vd2vLLIY0IlpQ4j6DVsChp5rJC5/4I33GuX179rNsvdHhkAJjBROJPCeYtjRrK
 UGKw==
X-Gm-Message-State: AOJu0Yzd2386O3zdxQ//rVa2zEb11G4JVROjZezOdCs7JaGXiAPS5jS2
 ZJCkhRtcd5ekbOI9LXuEYiNctYVJCmmTzYR/QVrMeEgJIehRu2PZn3Vj/1eEVTlt5ql7rDfAYPE
 =
X-Gm-Gg: ASbGncsA60BIN5nPcYUyiCqZXkcPusa/SLZgR6Rg0amZ5auSuPfHHKZNP9smc815iDl
 qVoJKIg5NZ5URqe2OZjC1HLfvl3XnRB4QQWH018DqVvSRfXOyqsdaK0nvfugpKF/g0wMD41BBf4
 6FdI2H7riX+Dxg4bRojxaKf9LiDFua9MQjNr4JBjrijWpPyel3hK5jx1azBr67HszqkIPikw1ix
 mKbAU7lvLSJR/mS3s7LJ1bJ+U/eX0enQ2VtNfsmHdYWLCktWFZXLrU/UzxUey1/enIsppd2eZD3
 XpctX6cBV2YlcNXEsMmkTIP9mEnsmL8Ha+cRGmeRHIV1tfxjW9w1Tzuc1H7gOjrEhbhDxWVXYSR
 CCyUdAg4zmkfo
X-Google-Smtp-Source: AGHT+IFITHxlz3JbXlx9rTC4SWGHDWCbg2iW6jq6n6hx2GvNzJDxWh5H9NOuLNvxxpxHdCz73IZsyA==
X-Received: by 2002:a05:6e02:1a47:b0:3d0:19c6:c9e1 with SMTP id
 e9e14a558f8ab-3d9702287eamr7549275ab.13.1746061529359; 
 Wed, 30 Apr 2025 18:05:29 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d95f480a99sm10771855ab.68.2025.04.30.18.05.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 18:05:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v2 05/22] venice: Include env.h to permit reading the
 environment
Date: Wed, 30 Apr 2025 19:04:30 -0600
Message-ID: <20250501010456.3930701-6-sjg@chromium.org>
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

 board/gateworks/venice/venice.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/gateworks/venice/venice.c b/board/gateworks/venice/venice.c
index 98b33624f04..f9bcdd8496e 100644
--- a/board/gateworks/venice/venice.c
+++ b/board/gateworks/venice/venice.c
@@ -3,6 +3,7 @@
  * Copyright 2021 Gateworks Corporation
  */
 
+#include <env.h>
 #include <fdt_support.h>
 #include <init.h>
 #include <led.h>
-- 
2.43.0

