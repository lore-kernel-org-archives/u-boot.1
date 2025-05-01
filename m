Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE6AC369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 01:06:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68B2D81E72;
	Thu,  1 May 2025 03:05:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PMjrYNn8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D176781E72; Thu,  1 May 2025 03:05:44 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F3738056A
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 03:05:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3d91db4f0c3so2404415ab.3
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 18:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746061540; x=1746666340; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7orvDPClTzsdz15YEFx4ho3ndLyC8bvJ/Q3yKysGN2A=;
 b=PMjrYNn8yg8YmqtSKjk/mpCcquhir2qIi5HsW/NIMa4UmwzaKL4B8ppusJJIe0BChB
 GXXfFWtj865QGK6e85G8Y6xwFFzrZIASf2abcWlN2E95+ZikqsBukZZDQI7weQHlYVuK
 1qfrNkJYDq2RWFTPiytJL7Sdnirtjhdapp4jQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746061540; x=1746666340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7orvDPClTzsdz15YEFx4ho3ndLyC8bvJ/Q3yKysGN2A=;
 b=EnbNL6PVKDYi41xHviq1vSlojUmvv/uUodU4PrlVYdIAs4cKPDE59udcS2mPSAXWgJ
 3Y/0kzxwbZFuW0aEOw523I6rYrwdvFFwsyz2B5eIcMV58zzv+KG1lsrezvVEW0hcmdX0
 ufCj0dvrE1NMkM8SgA/QUKVaREmISymLBsCt7xDwXxssiVRhdDHBXPJr5KjVMcgkrzLO
 b8Cfr5vPJDRV4rFoR55nKXG4FD3kYJwgYE4x8Q1fqiL62uGvt9s5st8DoNUV3tc4K7xY
 89PW5dF3hQcSEuXyTu+VUpUaVbh8r4ifIEMMZuNdH83gEJ2z0/QzzzWnI5GpJzCg0Gtz
 Od1w==
X-Gm-Message-State: AOJu0YwIoreCl0zis3RV4zr/7iSKlVTt+QG7irU8fLxBuRd9Zp1oLcwx
 MrCrCMzlTxTf88yhK2NW/dSd2Qjs/pWG8F9Dt8p2cAjPzidr+7nJmDDrUduKPR+X47SGalWjWtQ
 =
X-Gm-Gg: ASbGncvCBGMyJZOTGY14RWvxwEm3xKf64oJBb85hehgIlqsS5cb9b4GvMA/X6/KaUsB
 JLfdSUBNlGILKRSx/e0t9GHvhc2KIg8qbzj2Bd46NIAM2MiGqWAGVKJ/EF1urlyAC47JT6lpgIW
 bLm9gmP8bcQfteGLUN9siSX8EkTnQYyLL0HPrFVW6TJWnw3Rrq9tpUow0ldlGoHkpBlNBMQGrq7
 NyStZpk07uzUYU3zQuiKqe+DyQN/1sjBIuK88f1CF7HbL/BxZKRAjd52iAK7ig4gRlzUoFUp1s+
 WWfp2siPp5YSXxMHil4lEaqBcYF3rqun14mOBgcnCTQuz/5tcP2SDMddzpCgcLZYQa5aNZKWAGy
 U/Q==
X-Google-Smtp-Source: AGHT+IEbOa3k4/0L2607tMWoASdZ23fIIcjRLJtOQ7/tPTx32Pburmh1fj0bEp246kfjmxLAe61NZQ==
X-Received: by 2002:a05:6e02:2707:b0:3d8:1ed0:e167 with SMTP id
 e9e14a558f8ab-3d967ffec72mr45017575ab.14.1746061540366; 
 Wed, 30 Apr 2025 18:05:40 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d95f480a99sm10771855ab.68.2025.04.30.18.05.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 18:05:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Oliver Graute <oliver.graute@kococonnector.com>
Subject: [PATCH v2 09/22] advantech: Include env.h in imx8qm_dmsse20_a1
Date: Wed, 30 Apr 2025 19:04:34 -0600
Message-ID: <20250501010456.3930701-10-sjg@chromium.org>
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

This file uses the environment but does not include the header file.
Update it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c b/board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c
index 50b35db5f6c..accd300df04 100644
--- a/board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c
+++ b/board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c
@@ -4,6 +4,7 @@
  * Copyright 2019-2023 Kococonnector GmbH
  */
 
+#include <env.h>
 #include <errno.h>
 #include <linux/libfdt.h>
 #include <asm/io.h>
-- 
2.43.0

