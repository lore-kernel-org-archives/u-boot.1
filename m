Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DDBDC83F03
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 14:03:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 406C982063;
	Thu,  3 Jul 2025 16:03:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EifTQSq4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE6948206E; Thu,  3 Jul 2025 16:03:35 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA24280E9A
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 16:03:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4539cd7990cso6544905e9.0
 for <u-boot@lists.denx.de>; Thu, 03 Jul 2025 07:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751551413; x=1752156213; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=H0N+EGbXJIFTx6/chCG2UYIN/cbCjTjHeUaOWOGmKJ4=;
 b=EifTQSq4hk95WNTlT/8rwfc652krlU3e5x6xt1tCXlvPhl31pgPVftLFYSmFabkeWl
 GMNiqKmRqRbRpAPkhdjGOmiLDiMSUDrEf8QC3hgZrlXLSUoj+Fc8vspa2vJVr4fvaCko
 T1BTF61czHBLBfM4BfSpTchrfJ5avXXZ26s/X3t3ev47rfMVEprIEqGHkpspyqZkIoHt
 82ay6dnr4uZi0UJws223pSHOf/D7ITMq/ANs2uwctFHbkoxLgUeWRmnUTIffGyCQdRXN
 gZjqVhnWMSLpXYyPd/ZvKq/HLE9R37QEvKayRt+OAs2ijvMFsIAidhdwOOlWqRvXAb0W
 PLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751551413; x=1752156213;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H0N+EGbXJIFTx6/chCG2UYIN/cbCjTjHeUaOWOGmKJ4=;
 b=oTENFIJ2dML0NQNx7RgrU7UArURE+/EqrIIPAx2aoJR84MfmEihkt9GET5QxgZVdgY
 YkglurPWEVzmYSn6/knnO9U/impWptc9LufKTsRyj0mQsi8Mp6DS8lAoSKcEKEPe8wGL
 zLYFaMc0TWR4/XTIDob07/U1lGULYKHeYi16clOq1Z27d2abNjDQ5b0YD5YiwEW75chn
 inT2QngwCg6JYNV9tgpr39EVbv/+8BHNWqpu3bnCBNRRjkFkG7y7oJJO7zH4uu9si7T8
 Bh8JH4Hm4bHGfwDHruNf1F1Y2caqeJSYKZwZzAHpD6GazkzEqYAgDUHlQmFgoK3OKLcd
 X5lA==
X-Gm-Message-State: AOJu0YyaUgUPcVn7TMBgPLhxNCIiV0jLgHlK5PX5auHpqoL4A23fRG2n
 qRL1nP065XFlIQyjdR6BIc0/hztCtkbgYDFaxoQ0zM5X+vsPJKLzoZBwxLs8lIU26HPWXES0KYA
 RoAKH
X-Gm-Gg: ASbGncsyEYtc5TV5CdA9zFqG+wtvmi6iVieqLqV/j6DP2q7qqq8Eh6DECokfIwfRUxf
 3HFRIBwNVQRwpMlax9sUYtxxX8051r4pzP7w8unOOlyXsmOoEC/aAjbPJirmhmlikwgWQfKrn9W
 j/FOAZZ1IQ2xtgTFE0NlvDtXWoEdsaoFAo21n7Q2kMzMqFv7aFdPvwkIjtYHB2F1uK8Y9TB/UHB
 xTt/tmQ/Kb5yU/RrpfD6cPADV61gDbfA3kBjJERXh2JgAbyIzj3lZ0iSKIAsFY72PGyjWHGJIRa
 fQtk7AJuoXX44bHiX0LVYaUkrU4PtfLftijZDxBjplDRv6ocpNdG3RzvIsByWkx1O66cFiG6ZD0
 UNvxbXaQLHmHcSQSYMUEiNt8=
X-Google-Smtp-Source: AGHT+IH/TZ0a4X0EMv5TkHIX62SkO6WfJToja7lb1778RROYjouN6RtSDNQGcLbHql/cbi89VmtcYg==
X-Received: by 2002:a05:600c:c170:b0:442:f904:1305 with SMTP id
 5b1f17b1804b1-454ab3200f4mr27833395e9.6.1751551411326; 
 Thu, 03 Jul 2025 07:03:31 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:e07:801:b5c8:44f:55cc:3182])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bac48esm27425635e9.37.2025.07.03.07.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 07:03:30 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 03 Jul 2025 15:03:30 +0100
Subject: [PATCH] mmc: Take cleanup path to free memory on error exit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-mmc_driver_fix-v1-1-4fc57fded698@linaro.org>
X-B4-Tracking: v=1; b=H4sIALGNZmgC/x2N0QqDMBAEf0XuuYFEEdv+SilyJmu9h6TlrkhB/
 HdjH4fZYTcyqMDo3mykWMXkXSqES0Nx4fKCk1SZWt/2fvCdyzmOSWWFjrP8HIbbdQ6JETpQjSY
 2uEm5xOXMMtsXeoqPou7/T4/nvh/cPm//eQAAAA==
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

Instead of returning -EINVAL directly which will not call the cleanup
path to free memory, fix the code to set the error and then goto the
cleanup code.

This issue found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/mmc/mmc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index cdcf2e0c8fe..eddcf86bb32 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -2364,8 +2364,10 @@ static int mmc_startup_v4(struct mmc *mmc)
 		return -ENOMEM;
 	memcpy(mmc->ext_csd, ext_csd, MMC_MAX_BLOCK_LEN);
 #endif
-	if (ext_csd[EXT_CSD_REV] >= ARRAY_SIZE(mmc_versions))
-		return -EINVAL;
+	if (ext_csd[EXT_CSD_REV] >= ARRAY_SIZE(mmc_versions)) {
+		err = -EINVAL;
+		goto error;
+	}
 
 	mmc->version = mmc_versions[ext_csd[EXT_CSD_REV]];
 

---
base-commit: 7027b445cc0bfb86204ecb1f1fe596f5895048d9
change-id: 20250703-mmc_driver_fix-e798f1dae13e

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

