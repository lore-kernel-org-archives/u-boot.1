Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5254CC46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 08:24:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 984E3877E5;
	Wed, 27 Dec 2023 09:24:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oZY78j5M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B0E087884; Wed, 27 Dec 2023 09:24:18 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2231187884
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 09:24:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40d5b159350so8980875e9.2
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 00:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703665455; x=1704270255; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h7PvMEHuVFziKWQVFu/u7nEHCvuqsfymQ0JdDEPzaNc=;
 b=oZY78j5MEVFoIIvOUtThbg29qyrex/jF2aLo/a2ozjm0soYFhZUXGfrYHSJv0dZYxf
 k8+ZOeRkz0aCSvq35YedCiFv6Ulv7o9HPjupZyhSz9Ueu2pIecnO9HNGHBHZH8uVhDdN
 jN6dOwklyFgCa/ov95TaPyIXbEmHcLGzOh7vE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703665455; x=1704270255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h7PvMEHuVFziKWQVFu/u7nEHCvuqsfymQ0JdDEPzaNc=;
 b=aNGv84e3fYIz4F/IhQTGwlcqyvMt1zGmYJ9iFH56Rv6OGpRL1szg+GTZ4rGFCwEIun
 xZ6eM5uYPzZFrNzEsqzeKrxOw07xBJwQpycXlSk3DKs3LY3lvzav/3lxhZt9z1fnfR99
 7zbZeIJNt6qlRz8x/Jxz5g4c0hvMXvGJQY1fySgpWO9DVZptPPB48ridPlq8csU4V0Pr
 uFMNVRtIsU/m/6eazLxgy2h73ig6/RlDYr+PDAhTG1dMwbbgcwyJ9s3AFhvwYlLebliI
 dlS3i+sPp/icIwm4h9sq3uyP1uQl0S0k47EBmZljuBVVvRcdnOtS0tTM5rtdxd8XF8f6
 54Gg==
X-Gm-Message-State: AOJu0YyRzsHkmXWiR03Z8SbP7No+FudiuK6P1AcwXmlzAHkuO4aCJq7T
 r92mE+fHagRIn2H8UQVAYepPHZNnnZ6Tgd0LrxptIcZHWsnz
X-Google-Smtp-Source: AGHT+IF6LCftrWZljm8n2ra77cw+KpckFehX+PA2HaDRyf4N9ZG0urMDuoDd7o2N6iXlkj+pf/b8Ew==
X-Received: by 2002:a05:600c:4f04:b0:40d:53b9:36cd with SMTP id
 l4-20020a05600c4f0400b0040d53b936cdmr2765671wmq.81.1703665455560; 
 Wed, 27 Dec 2023 00:24:15 -0800 (PST)
Received: from tasman.chapterst.org (80-42-48-87.dynamic.dsl.as9105.com.
 [80.42.48.87]) by smtp.gmail.com with ESMTPSA id
 fl15-20020a05600c0b8f00b0040d5e7fa243sm1233552wmb.28.2023.12.27.00.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 00:24:15 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>,
 Simon Glass <sjg@chromium.org>, Scott McNutt <smcnutt@psyent.com>,
 Thomas Chou <thomas@wytron.com.tw>
Subject: [PATCH 2/9] nios2: dts: Use the normal build rule
Date: Wed, 27 Dec 2023 08:23:58 +0000
Message-Id: <20231227082405.2202246-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231227082405.2202246-1-sjg@chromium.org>
References: <20231227082405.2202246-1-sjg@chromium.org>
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

Build devicetree files using the normal SoC-generic rule. For
nios2 there is actually only one SoC.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/nios2/dts/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/nios2/dts/Makefile b/arch/nios2/dts/Makefile
index 2b29fa90f6c..66aac2cf942 100644
--- a/arch/nios2/dts/Makefile
+++ b/arch/nios2/dts/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-dtb-y += $(CONFIG_DEFAULT_DEVICE_TREE:"%"=%).dtb
+dtb-$(CONFIG_NIOS2) += 10m50_devboard.dtb 3c120_devboard.dtb
 
 include $(srctree)/scripts/Makefile.dts
 
-- 
2.34.1

