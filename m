Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B08CD37BB
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 20:04:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45C9083D40;
	Wed, 12 Nov 2025 21:03:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="E5YnK5tc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4BB883D9C; Wed, 12 Nov 2025 21:03:30 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2EA583D40
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 21:03:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-74526ca79beso74319a34.0
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 12:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762977807; x=1763582607; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PhMBWlCL2dnBI3hWO1OgeP7YIyI1vbt9AdpeevCZNII=;
 b=E5YnK5tc4Gvu0d4XZg3+fAQRC2nXWcjlslYXlLbUJarnNTmxElp29R0Mk3WsKCXMQ5
 Q76TslFFS2PVo1NH8RT+95cqRAIl4A4ERo0ddwjrXCMcwVWO0eccSr8jLUClqAQzhCu0
 JO03FKhUqIEfk78cRFdsMazykEIfXcnT1Reww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762977807; x=1763582607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PhMBWlCL2dnBI3hWO1OgeP7YIyI1vbt9AdpeevCZNII=;
 b=rEpKx5N5JZSGNRAEkFq7517ppZznRwXGXOjIaKAPPjC5TLItWHeRTJzDr1Rdv1j26i
 zYXQ4WYzPKwtfFTuerv/7SnocLA4yabvDA4usSwFjK5jNX2E30QJzG1NqIEM/7VK6dsw
 i3r3FSlr9lN2va0GaZzKHkDTIQEQ4wo9Ny7iXW52CBB5r6XEb+0J3Y5XvEmHh0RVq8RM
 AMaqnM/BOoMuQmnT6jhR5s+MlIWj8yFrvdm2jDZeOh1//Sh5EpnG0kyiQt28O/VCZGTo
 a4eWqkvcjffw2CyzEYWu1ls5MChGrCRFFLSCkVP/2rgZDMbezCJvVGe7zAGNlbornEDS
 JPHw==
X-Gm-Message-State: AOJu0YzGwsx6k5JIV9EaaxsPzXC6wS5230To9at0D7O7gGlsIkbuiPzY
 VRrQms6IACDFt/72CvIZagy+12Wl7DL2Z5xa/l9X62HCdE3GcWC1EHiCd5h7dppqWc36IEF4/KW
 S4G/bFfLr5g==
X-Gm-Gg: ASbGnctts65J/4gWZFD+wsBu+jXfS1hlerTo4eaSVHhwDfAsgbmRBybtAoa+1XiKvXP
 tmb9pKxXfRWuuKQuV7vfSSJZ9/F7DPlKYQ54sFcxz2uxoLQdRAnY/NPYzyuk9Qn1HqRaGZgEOe6
 byppNpiZK0u89YLoAEBPEZ31SNjmggF+pZ7Xr+4PlFAJLShdAFOosFks0Qrmx1rRlHZBedNpSTy
 WwAGNbBHtvhyxziAJrffWF3DUMTOJUqH2Q9wrRSWwAPvU8kvuIY7ObRb46tZ7OhqeF8LG0pWo2N
 KYo/Hemm12qiWhGcLCCa71Y1/h5/1T6yzz5CQHRH6NQbh+q/eDVavyyg5CmfcEbtGj4Cs7PVsL3
 QGnIn8aSyo2F4TWBSDnVSu2kHkeP65nM9R2MusjNGwwCQgZ6z3sMAmmQOC6AUpIZj5UzgrLrGcd
 KwOJN5Tejyy0DveFyKyH2bRjTZ4YX2zX98dmiWmfUniQIukVWqtU7P
X-Google-Smtp-Source: AGHT+IEUpOvvr/6gKwblB2cwTAfzzrxMJUeq1EfNyUX1tx57xZfgVwuIgThKyzbXrHFpHe0DeCJ/Yw==
X-Received: by 2002:a05:6808:22a1:b0:450:4587:50af with SMTP id
 5614622812f47-45074428117mr2104042b6e.22.1762977807380; 
 Wed, 12 Nov 2025 12:03:27 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e83281c9bbsm2169596fac.18.2025.11.12.12.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 12:03:26 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>
Subject: [PATCHv2 5/7] video: ihs_video_out: Add missing <asm/io.h> to
 ihs_video_out.c
Date: Wed, 12 Nov 2025 14:00:06 -0600
Message-ID: <20251112200315.1111980-6-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112200315.1111980-1-trini@konsulko.com>
References: <20251112200315.1111980-1-trini@konsulko.com>
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

This driver references IO macros while relying on an indirection
inclusion of <asm/io.h>. Add the missing include directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/video/ihs_video_out.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/ihs_video_out.c b/drivers/video/ihs_video_out.c
index bf4d4995c36c..e2130274b491 100644
--- a/drivers/video/ihs_video_out.c
+++ b/drivers/video/ihs_video_out.c
@@ -15,6 +15,7 @@
 #include <regmap.h>
 #include <video_osd.h>
 #include <asm/gpio.h>
+#include <asm/io.h>
 
 static const uint MAX_X_CHARS = 53;
 static const uint MAX_Y_CHARS = 26;
-- 
2.43.0

