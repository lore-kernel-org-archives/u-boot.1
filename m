Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44AD7C369D9
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 01:07:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 208B08212B;
	Thu,  1 May 2025 03:06:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="digXmvlM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24A2B82824; Thu,  1 May 2025 03:05:59 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A145E8214F
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 03:05:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3d8fc9dbce4so6069945ab.0
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 18:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746061554; x=1746666354; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EUUf0BS1ekd+giQf233eEtokOQmdZ32dhTqrDbPyY7o=;
 b=digXmvlM9lrBARv4SVmcs2/LkGJlH9JWrlRAXkV8VwK3bshkhrHAaPfMBc0/NNGKo0
 /sy34IWYSjuQyiqZ3Npyg1DSPp+twc/7OgbZxAyNwSwlRtaSy1f6qQ5YjfHiZdAXMCrr
 6R3+yo9/Zul8IIrkSGFBVt8S2IBiSLAbpypq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746061554; x=1746666354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EUUf0BS1ekd+giQf233eEtokOQmdZ32dhTqrDbPyY7o=;
 b=r+nFHiYLExgbOaY635DQ5ESyI9IsykZgRlz9gEZgx4qfsTJNZQoqKOeWC6eq7fK3/U
 5Asbw34fvPzxq6dK+RI5yZa+fgcmMD/ZG+QHdGjKdVegSz5Baib9oxG/sK/y1mGC4G8p
 mzFo8g4WoS3ZbdUl5e7df/kBIO2wHHNTTUFmKrjN8W5HkQYFQKExKPC2VOJ2Y1W0eWJm
 Po3+S8FcR2UsYaVviCabZE/GNqvsnskK1KzmoEVsxJBYh/qvKZdbhL0MhqmbDUN/p7BX
 K8VWIDPjwynpCq8j98YND0MWlsDwbQzqSWZeWpkd07xBupj74ybNoHbo1jcAlrOpOR7W
 KhXw==
X-Gm-Message-State: AOJu0Ywf1U4sj+dUJAjGXFDhjqhbSvTZSG0cIrul0HU/z1/WxmELform
 cQgQCKz22mN7qwJ2/ncUV8NjwnXC+jo55O9v09WzME5CfOmZodfQzz8JvTrjVq1a+tzUNarLTtI
 =
X-Gm-Gg: ASbGncsxDAy837sUR4u0yBkl9pDiTtyLRKjdafE6vXs3g1xV/4ULJ1udg6c1hGboien
 y6mATcH8G/R/lilWMyqimVoCk3gE7Z23fVaAmGlQsWAa7g6rTG2igpdosAkaeWlXEivr9b1DZtU
 R0gGyViitX8LzK0aHEHkiuWRJjliFtctPafksPKz/GrgtmXsOCbXCTNNhLvj7rkhbNgTk4Z/AjL
 1n66nNG1l68JszAIzRr2v8jo1aEMmZsC05nCOgUnLU9VSosjG6adN/e5WEqgrK/3ZwfdffzhKtg
 KZ7qFBughry/NWlFmMeXe+Wk7nxqup0iY6Zkw2PCmfPd9ZialrRK7iqKpP8SPB38hMHzzkbJQNY
 n9A==
X-Google-Smtp-Source: AGHT+IEOBNYgR8yr6RsPT1jxRgLxXdZ7hV3nITKpOkHTkHtFFMBmeZ550DXRD5Vie+N7spZUNp8W9Q==
X-Received: by 2002:a05:6e02:3707:b0:3d6:c2ff:eee2 with SMTP id
 e9e14a558f8ab-3d970b5dd79mr8017205ab.6.1746061553921; 
 Wed, 30 Apr 2025 18:05:53 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d95f480a99sm10771855ab.68.2025.04.30.18.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 18:05:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
Subject: [PATCH v2 14/22] google: Include env.h to permit reading the
 environment
Date: Wed, 30 Apr 2025 19:04:39 -0600
Message-ID: <20250501010456.3930701-15-sjg@chromium.org>
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

 board/google/chameleonv3/board.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/google/chameleonv3/board.c b/board/google/chameleonv3/board.c
index 4d3049689d3..d8ffdd25b38 100644
--- a/board/google/chameleonv3/board.c
+++ b/board/google/chameleonv3/board.c
@@ -2,6 +2,8 @@
 /*
  * Copyright 2022 Google LLC
  */
+
+#include <env.h>
 #include <net.h>
 #include <errno.h>
 #include "mercury_aa1.h"
-- 
2.43.0

