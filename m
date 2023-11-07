Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA979C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 19:06:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CA76875BF;
	Tue,  7 Nov 2023 20:06:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hKOEScBT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87F7C875C3; Tue,  7 Nov 2023 20:06:06 +0100 (CET)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65B8787584
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 20:06:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1eb39505ba4so3670155fac.0
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 11:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699383963; x=1699988763; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R/gKGvRzJKAN1ayEoH4r8x99az9Qr4AgjxYYn4lt5lQ=;
 b=hKOEScBTYPMyYFutSUcuCwnDm6CoIYtuaUBiycxWDLlIpUW0Jovesf+m/PX2xhlo6z
 nJsWlI46Ku19T7NFt6Vc3IblyJu/QXwwiRiszkp91IZEaqFxYHQ8VihYgLJziZn0Vk0F
 08mHIUBMlzcgs0mwMWm0MT+cJc97df7q8fdBeTVNxwVwx7my50/4IVbqLesTG1oVEZZG
 k/uiG6adwCFQYZ/LWmEbuay1TX1jQsickwzH2xPXYcYYTTqCUT9RUhNzhIchfqs/U8Ap
 VZexmcmD+T4Ix62NH1+9MhPwNQQhT0sV8maJ72WL0bMifGsLFJrBsSsTWihP2Vjj3Ll5
 Mqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699383963; x=1699988763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R/gKGvRzJKAN1ayEoH4r8x99az9Qr4AgjxYYn4lt5lQ=;
 b=JAzMocXLd8sK1N94qwEOfVAOj/HJFVTW8d+lVWCIaXUnIj0HfKj3snJj8DjPY6S8JY
 JedJbPJJLLzvcGG6Xaoip2b3iwzWFDSEUiPfV6KhikG7cvQUjQddOzR/cQgpzpeynV6D
 nlD8je2I52Zke9dbVQmEfJaKK7xFREpSLGHvc3O4niM8LgA5J7fq9iUtLZ46+k9xHSfn
 tkWyA4UNdo6R7VGMnkpSD/b09kGhaq79LQrlS/BIs8oQYdCWWcOWci8Q3j5nzTxCCRrY
 0V0iRSGS1reituwTP2dCFgBXsOsNEIsy0tctCWk6vrqhpOB+rjp3JLarjxQAEzTCtsdk
 VpJg==
X-Gm-Message-State: AOJu0YyF595J7/2NtrCFt8/M5N4ah+4+wkGULabSPAAhrYeZhBxNGpN/
 4vJUMOSEjk5dqG13bvSNzI768g==
X-Google-Smtp-Source: AGHT+IG9eVlyg/RBfrcrhbsXBb/21ZdH5kRDXwpLqgT0ikXNRqXV6LvFwvO4irrHdbjDn9lXno9gAA==
X-Received: by 2002:a05:6871:7283:b0:1e9:f0fe:6ba4 with SMTP id
 mm3-20020a056871728300b001e9f0fe6ba4mr517001oac.11.1699383962953; 
 Tue, 07 Nov 2023 11:06:02 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 g3-20020a056870214300b001c02f12abd0sm1827006oae.38.2023.11.07.11.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 11:06:02 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Cc: Mark Kettenis <kettenis@openbsd.org>,
	u-boot@lists.denx.de
Subject: [PATCH 1/4] serial: s5p: Remove common.h inclusion
Date: Tue,  7 Nov 2023 13:05:58 -0600
Message-Id: <20231107190601.17151-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107190601.17151-1-semen.protsenko@linaro.org>
References: <20231107190601.17151-1-semen.protsenko@linaro.org>
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

It's not really needed here anymore. Remove it, as common.h is going
away at some point.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/serial/serial_s5p.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/serial/serial_s5p.c b/drivers/serial/serial_s5p.c
index fe52580d64de..177215535676 100644
--- a/drivers/serial/serial_s5p.c
+++ b/drivers/serial/serial_s5p.c
@@ -7,7 +7,6 @@
  * based on drivers/serial/s3c64xx.c
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <fdtdec.h>
-- 
2.39.2

