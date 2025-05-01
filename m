Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80506C369D9
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 01:07:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B31E8210F;
	Thu,  1 May 2025 03:06:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LMTwisxt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56DBB8283E; Thu,  1 May 2025 03:06:04 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 079EC826F3
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 03:05:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3d9327d0720so3863905ab.3
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 18:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746061557; x=1746666357; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tmdO3aFCqIMT7KKCBRXLK0ghhP012dF8KwAkZxZ72Zg=;
 b=LMTwisxt1ZyHzajxsHYZ8TF+nZ2ZJn6x+6ZfVcUDCa+k0N3t5P0IKQ+8UtENvWYKH6
 YKBSV/KqcyfpvYPSI2lFEUA2vivxg9Ps5SfHdk0uKMWjw+uSUCAk0hvi+o8C/Bv4rZb8
 mpB8laew+TiEriqBVzAL5eag8KjoIdekUxwHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746061557; x=1746666357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tmdO3aFCqIMT7KKCBRXLK0ghhP012dF8KwAkZxZ72Zg=;
 b=nFiqBY2mWA3quOm8sj+0ECvIM49pukb2e3fzHjRJ0rZJaht9m/ws6pT11CJnyyHuZc
 OszPGFTrkWcYOyHTbX4MhGTnpsjuqSriK03HGsH14RJaYLC6BJCpPFsjt6Gfx8QuJs1R
 AD9NWIzdf+zKnoXS6mbbwz+8i1cJ0SDSCBSHacR4ONMZyxkvVJz+L+k/0mH3ZUWSOLaq
 IZEXO0pM0VZN50MxBoRMcwDWNtl8JLIhfGdQTy0hPAVHc1GEyFbZBqcoWUUAq3a/YUmY
 V/MbLQyMIOQsQRwCoYrMWYHGxuzJ2Ny7OVY94OWl+gR5RPNXViFIazLa9s4DOqGKl21Q
 dOOA==
X-Gm-Message-State: AOJu0YxYMij3pWVlyZJGZgM+gG3JnnBao11vDUWGnVlZDzdbTW+3aHIF
 UIVljrlhtQd4b3A4wLvMVsa+CD5O0fFAqoimx7+08L7CexQ8PZyRtsrK39htfix4c2ov/fH+00A
 =
X-Gm-Gg: ASbGncuuenIokxdx/0HyrliBya/IePjsLibSNduLXuWkCG5sKAEAWuHEoG9qqQRLOUH
 GHYoZHhzOo3dk0T3OxhJbFxGH3SowlWeVTsxRSrKuPlHYzHpBJwEuRtvOUAx2AJ4xgczmr5HhtY
 tSTN7VUbRHy+wi769I0H7Vllg0oI2syjhrPzgR2uV9pf0rf/FJRiZBtcUU68q0/lOE7k/TTsVx/
 PYaZlKfwqp4fgAeXFVY9sHOKVdj3Iu1si5c2ggUO3atR8NB5ydne7SPVid8Jy88UNE2c6HLWZiv
 Vo3JhiYlsjc2EbJZOSdtmulxheaMGJhTqvLBWPf9I2LI7njVzpfjuq/NrqpO/26rTNiGBOC8Tyr
 ZQg==
X-Google-Smtp-Source: AGHT+IFtdjcoBt5QK5Mxr/tKIwN8/888netRZUYwN4jFr3lziDQCAx6GYcDrD4cM4NOXmdhquCgc2g==
X-Received: by 2002:a05:6e02:2141:b0:3d9:5d50:e3b1 with SMTP id
 e9e14a558f8ab-3d96771bc0bmr70789025ab.18.1746061556807; 
 Wed, 30 Apr 2025 18:05:56 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d95f480a99sm10771855ab.68.2025.04.30.18.05.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 18:05:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v2 15/22] liebherr: Include env.h to permit reading the
 environment
Date: Wed, 30 Apr 2025 19:04:40 -0600
Message-ID: <20250501010456.3930701-16-sjg@chromium.org>
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

 board/liebherr/xea/xea.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/liebherr/xea/xea.c b/board/liebherr/xea/xea.c
index 1d4f165fd13..9630e7f576b 100644
--- a/board/liebherr/xea/xea.c
+++ b/board/liebherr/xea/xea.c
@@ -13,6 +13,7 @@
  *
  */
 
+#include <env.h>
 #include <fdt_support.h>
 #include <init.h>
 #include <log.h>
-- 
2.43.0

