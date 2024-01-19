Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F28ACC4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 21:33:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20E6687A2A;
	Fri, 19 Jan 2024 22:33:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KmEurgHP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E2EE87A2A; Fri, 19 Jan 2024 22:33:13 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FA8687920
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 22:33:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ralph.siemsen@linaro.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6817a470730so6041596d6.3
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 13:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705699990; x=1706304790; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q9Irad7bq9Na7d+aOFd0r7sLjoV9DLczJTXO97vMqPg=;
 b=KmEurgHPC8BgEGvLkFnx9b7yBUfXRwVBDKBT+wIGcR7CIsLcUmhRsRlagNccDQTzkB
 6ymLrS/RNzoxD1E55QEZNzHPq6zqfiR/HPi9kro0Scnkjm0t/y4bKNiQ0red9DA+kSaC
 TXr61qYgqiqDYwkeTr9wwNa87YMCkwdo1UrOnd5IDzbyphACm2UyYKOVGerFz4VaopMq
 1CmbAyZnNEfxz2RdjcmNA2d3uQhRfzLlW7BTOYhJM2JY1n4BzmdYeikHnfSBaIQbDgpL
 1JPxy50UZtdMcVMgf16pjuzdjU3Kb/GGnDrWhOBaJqOp0T0AnUtkDsN8KKk4DWQTwT3V
 0smA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705699990; x=1706304790;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q9Irad7bq9Na7d+aOFd0r7sLjoV9DLczJTXO97vMqPg=;
 b=jeTIwy+6V9DR+LtMz5/5/rEP8DdnUMvOEz2BGMLs1a9pPFa2r5clk14gUp1ca+DDRp
 Z6uQJyGb43AEni3aDPtxbivbOHtlKIGd7OB7QwXaHw3/GIRxOSDlHMefLBEJlK+GzONo
 Mtp83DXM2U2nStWylcrKgFtWkg2NVw6wnQPr3dKxY4FabIcHa8RN0kUPWHkovovDlcG6
 RIhjsBC5w2oRqyjmoKTZXLhPn77+5vGrgY10Y8gHi2ZE8uP47FCsfdRVctlsnKAYJODi
 cPLIbx1ygnaOMMmS0nKO3Oi8eyxt82Tuc1jumHfcoWLiCkEEMzEi1UKB4Txjs4FXdAsS
 AtCw==
X-Gm-Message-State: AOJu0YyXTmIulr/8jKMvyQ2f8QBrTGqWzZRv8w1Wq3yqFwAZeJgamPBo
 mHba9YCieUwcVxS4yLK9uRhF+BZY+3Q9o+tYP3YHYJEWwUddsq83E0bBjQQMpQ4=
X-Google-Smtp-Source: AGHT+IFBE/kNuBTTrVTvnR9xFNdx31u/CzvdONM1523lpMnnnJSPg8uFVJ4HJUGf0P6VekZwUxSReA==
X-Received: by 2002:ad4:5ecd:0:b0:681:7ba3:3649 with SMTP id
 jm13-20020ad45ecd000000b006817ba33649mr656721qvb.63.1705699989923; 
 Fri, 19 Jan 2024 13:33:09 -0800 (PST)
Received: from maple.home ([70.51.77.95]) by smtp.gmail.com with ESMTPSA id
 l15-20020ad44bcf000000b00684d962f0acsm39147qvw.83.2024.01.19.13.33.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 13:33:09 -0800 (PST)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
To: joe.hershberger@ni.com,
	u-boot@lists.denx.de
Cc: Ralph Siemsen <ralph.siemsen@linaro.org>
Subject: [PATCH] env: sf: report malloc error to caller
Date: Fri, 19 Jan 2024 16:32:17 -0500
Message-Id: <20240119213216.3811402-1-ralph.siemsen@linaro.org>
X-Mailer: git-send-email 2.25.1
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

In the non-redundant code for env_sf_save(), a failure to malloc() the
temporary buffer produces the following output:

    Saving Environment to SPIFlash... OK

This is misleading as the flash has neither been erased nor written.

Fix it to return an error to the caller, so the output will be:

    Saving Environment to SPIFlash... Failed (-12)

Note that there is another copy of env_sf_save() in the same file, for
handling redundant environment, and it already has the same logic.

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
 env/sf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/env/sf.c b/env/sf.c
index a425ecc11c8..8f5c03b00d3 100644
--- a/env/sf.c
+++ b/env/sf.c
@@ -210,8 +210,10 @@ static int env_sf_save(void)
 		saved_size = sect_size - CONFIG_ENV_SIZE;
 		saved_offset = CONFIG_ENV_OFFSET + CONFIG_ENV_SIZE;
 		saved_buffer = malloc(saved_size);
-		if (!saved_buffer)
+		if (!saved_buffer) {
+			ret = -ENOMEM;
 			goto done;
+		}
 
 		ret = spi_flash_read(env_flash, saved_offset,
 			saved_size, saved_buffer);
-- 
2.25.1

