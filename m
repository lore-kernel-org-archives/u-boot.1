Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E876C369D9
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 01:06:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B1A682132;
	Thu,  1 May 2025 03:05:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="n6AiqUdC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EB9680FDA; Thu,  1 May 2025 03:05:37 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9321A8056A
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 03:05:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3d5e2606a1bso3937065ab.0
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 18:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746061532; x=1746666332; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t5qI7oB+dbLd1G0XkAJ6kobwv6jUwwkxuWvnOiYhelA=;
 b=n6AiqUdCFHNquGrqPC27nU3j53kcfY9gKRcCepco22FweaLLRQE+i05k4VtO/nPmAT
 dUjcI4BP1dEHUbBU0dZmlDSTNUfoTfiv0EXIvtFCxWfmOqNbREx+AUZQ9IZwHXbEJUnU
 Wuqyb5qGOOTLCZtl41qnoBWmPEeP8lFeoVkE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746061532; x=1746666332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t5qI7oB+dbLd1G0XkAJ6kobwv6jUwwkxuWvnOiYhelA=;
 b=nDvrdcMbHXXMH33+icQ0mN4RcWrRilttFk8pFreoY0S3KMbP9NAeywuvaf+97VtZIB
 Xp9PPGlMkyueap2+lDC/pdfTDD6W0ZhoisWtYdrf5x1uH1IcGwPEo31UHUGyCYzZ8KKE
 ZmK1M1PibhvWpEEU1zF9QTz5LUVRlnTKRkDTeiOFOQUI60Sp70/TfrUEOpEbv0NOr0b/
 yNjTyTbi4rKtN+V7jpFo/TsPF4HdYignk+IgPNPMZAQ4L4RHw1f8bICTyLQ9B/aJIGxl
 cCkasBxRfJPKRVkFfkvn/hISz3BB0zGTuutKjCJgbY8DUhrVNH9845lSUZVe3srhdrYl
 xXxQ==
X-Gm-Message-State: AOJu0YztvlioHQc+PawGF6e9Pn4hrE6kHLzwILHkrmbTFQjZUwkLxxvU
 LpMla1gNb8UxLqBnygRBtc6kFvmp2GRfb6IgC9GFcMRwlCUQPLVTK2/vp6ZN/iDzXQ9Rvv9/0JA
 =
X-Gm-Gg: ASbGnctLDXB/qgsTA5Pd3CwBA0nTCB7JGs8dsvpjb7p+QKCZHdkGpeWwkLJPGQjaOLC
 Q3H/yz+zPJR1OKO9PzlMa5laJZhMiI5bLfmgqH2RmX824XIjXeRuQMwNLTpdJWbI53gM/BoTdAb
 h9hZ9PvKHMpn5cccSDPIAHmI8eZ7ABdd53U8CPpW698jBct8rPhv2/OAnfvowTf+Kmivdnai+bZ
 eLU+uD/d5yMNzIsMa8trLB8PN2AyMakMevpSWw73eKCk7JS6ZYNqwIY1YEm8iPYJAU41EgZ3JRt
 otdoG4JKwHrEpk+dPymZKQu7kEjfcx6qoQZPuQxVbW9y/2M1wGaXGCKOPt2um1F5BeifKRZMRT1
 EGmqmU0LCBmk+
X-Google-Smtp-Source: AGHT+IH/KTvFlnvY0bCdcVfFmzAdHHbYVr2bv8Pp07Nqo7X3AfUU+/yJ2J6jAiu7QJZiQzkBC/GXnQ==
X-Received: by 2002:a05:6e02:1aaf:b0:3d3:d28e:eae9 with SMTP id
 e9e14a558f8ab-3d9701fa90bmr7863475ab.7.1746061532361; 
 Wed, 30 Apr 2025 18:05:32 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d95f480a99sm10771855ab.68.2025.04.30.18.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 18:05:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH v2 06/22] phytec: Include env.h to permit reading the
 environment
Date: Wed, 30 Apr 2025 19:04:31 -0600
Message-ID: <20250501010456.3930701-7-sjg@chromium.org>
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

 board/phytec/common/phytec_som_detection_blocks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/phytec/common/phytec_som_detection_blocks.c b/board/phytec/common/phytec_som_detection_blocks.c
index 5f3c27ef0c2..b44ff85972f 100644
--- a/board/phytec/common/phytec_som_detection_blocks.c
+++ b/board/phytec/common/phytec_som_detection_blocks.c
@@ -4,6 +4,7 @@
  * Author: Daniel Schultz <d.schultz@phytec.de>
  */
 
+#include <env.h>
 #include <malloc.h>
 #include <u-boot/crc.h>
 #include <net.h>
-- 
2.43.0

