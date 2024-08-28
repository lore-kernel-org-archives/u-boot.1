Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C098EC54746
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 01:47:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA0E088BEA;
	Wed, 28 Aug 2024 03:46:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dMoTNTDa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 972D388BDC; Wed, 28 Aug 2024 03:46:00 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20A3488B31
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 03:45:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-82521c46feaso228313439f.2
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 18:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724809557; x=1725414357; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FMLiyX0SXrM6Uln6jkFYTY/cgvOT7BdgUYLbTXDjVZw=;
 b=dMoTNTDahn8KHlT7TA3xi3wxhL3opttXfFKq+aoh/ey91H8ISx0CLQLRpKZfbmWh7e
 tEPeg7eFR+6RneJU83BKgL/3/rWauZDVRTFSkli+WDz3M9MxKFxIVp8KM57r3oS5wss5
 EZ+iK0ImXUD7iD8/+GZejfkBi1eyI6Rk9bYro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724809557; x=1725414357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FMLiyX0SXrM6Uln6jkFYTY/cgvOT7BdgUYLbTXDjVZw=;
 b=qNtI9a00jLt27YIyaLlH+8HVfJ6tjaf+SLmKrdk1/DYOK1s1xfZsm7OlzUFOxylwX+
 tO14WI8C4Ir8KHjLpCT9V4QqYsnnKRKB7oWMmTB2X24+tfF43ezmeNFuAyaz7+NDjK3l
 YusOkTs095h/7eCVlWujMB8m++cTWr6SqOOoSPi8AnHGqnFX4J0sdL9V5hdT/OwoESBC
 hQVGjgoRGnOqqQUGuTh943Ig7YDAhKykbK4RoWkgCtdMOSGcc2mTNMlD7Iifxz+GqmjQ
 RNRT03JnmzkKbRJIFPuQoXB/jdmE5SojW0v5CbQmlQ3KCYwvQ2cGKcsvO8xQmPWyF7P8
 54Lw==
X-Gm-Message-State: AOJu0YwoD6IPYNtWIMTUMTRWz+46vzjyeTtX60Mwpb2haDh/MjnH1POK
 7LJJKg6UGn6tQ5fEMn9VdyBkQwpCBWw6XktgKRok3OcCy0euaiHE/87CN6dWzxWd0O4wvgYaC9M
 =
X-Google-Smtp-Source: AGHT+IGmw4n54V3HWGOCp+Ef/Tswu14cP2isfkY/2xxdYk+MphKHfd+MNa1Hz2a3YphOR15b/KwwUw==
X-Received: by 2002:a05:6602:3fcc:b0:81f:c103:3e5d with SMTP id
 ca18e2360f4ac-827881eb252mr1546925339f.15.1724809556751; 
 Tue, 27 Aug 2024 18:45:56 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ce70f5ca7csm2898342173.63.2024.08.27.18.45.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 18:45:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Albert Aribaud <albert.u.boot@aribaud.net>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 11/18] arm: Fix up a stale comment in sections.c
Date: Tue, 27 Aug 2024 19:45:30 -0600
Message-Id: <20240828014538.3322013-12-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828014538.3322013-1-sjg@chromium.org>
References: <20240828014538.3322013-1-sjg@chromium.org>
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

There are currently four symbols here, so drop the word 'two'.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/lib/sections.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/lib/sections.c b/arch/arm/lib/sections.c
index 07efabaa7dc..8955aa6111c 100644
--- a/arch/arm/lib/sections.c
+++ b/arch/arm/lib/sections.c
@@ -5,7 +5,7 @@
 #include <linux/compiler.h>
 
 /**
- * These two symbols are declared in a C file so that the linker
+ * These symbols are declared in a C file so that the linker
  * uses R_ARM_RELATIVE relocation, rather than the R_ARM_ABS32 one
  * it would use if the symbols were defined in the linker file.
  * Using only R_ARM_RELATIVE relocation ensures that references to
-- 
2.34.1

