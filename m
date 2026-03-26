Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C02E210AB82A
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 23:00:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B69D83F14;
	Fri, 27 Mar 2026 00:00:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="urrmZPkb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4589B83FAF; Fri, 27 Mar 2026 00:00:25 +0100 (CET)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5949A83DBF
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 00:00:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-41c4d660b19so517772fac.1
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 16:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774566019; x=1775170819;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rc3NgXdMBvpmNOC/KcF/QYIs48+iT62MmwaAzRh1Omw=;
 b=urrmZPkbMm8VUmQZY19PT+G5py7hBH/AUuXvEBr0yCU12N+w1yL5sAqhqjWcLuV+KE
 8sE4I03SMnv0B/0crreGrGHmy4k2yy50ULL3BePD/m/053A/geKe1yQNoXnt0DQCMpfD
 4l73GFIj6yVORU9jVQhLDUwlI/LMYxqonl3CobY4BSGetRgfMkkl3vFtVRSV0xZu2CXV
 W5X2NiKjZ3QZ0S+FIcM42ucOCopDLo213RSfGGI3gpsz6wvV0oetFjCQutyOYOjQRUH/
 3bTYVe4ANbQptuHBS5SMvGbMd+GxN5YlktKH9HESU6Ct3y6/m1itUHN1325XjMCLGwJr
 ZaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774566019; x=1775170819;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rc3NgXdMBvpmNOC/KcF/QYIs48+iT62MmwaAzRh1Omw=;
 b=Vtv9PyS8QA/1IldQiIi/32Ag7IpvQySbn5IE0X4+vQBn4rXk9GKwT4VGeDJ6YrrXUz
 y6RjhXP8yJ2uPPmwPuGNGTLQ1So33qq1o01RGZrHmo1Fmt6t+kF4Nus6hPJE8VEd+0Hx
 PrAejT/N9E2+v7oEAdQPFu01EPERKbaWxbWmkwubtuglpjZM1Q6y+yCVO36g88nOxC+T
 7VsTp60OOXm3bS3vbqKE68EqUqFpWLitwMSy87c6+AXe4g0sQzOxr39zgd8aoudhRquj
 ibewHOs5ju1M81JcIKMRNqmofgQeudj9K0eNgrEH7gej/aiY5RIfVQn8qhR7y4XqFP8z
 NPLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWN00BEVAti3TN+TZaoP2oLriHON87hptqY+5bpPfw8nvR/n2Tl+TGm2WF+kOVF8r0lkVLWggE=@lists.denx.de
X-Gm-Message-State: AOJu0YyrrZsXfzFGGNoXodqTLKCGHf8KehFS7psD1TeQWvvlS3RbqX/t
 ioGijN/1jxzUJzxBNeE/nBnMCnMrGWlJbIPR3s9inzMlRf2+FR26kZMCzF8GLYrRMDI=
X-Gm-Gg: ATEYQzzEnc5HnDTOkedzl4LuCdqMBA6LWBJeLRpRUv96Z3WQbAxbhXiBjFkjwrIxuy4
 OJF3ThIEpdolLSb9f0tJWG6z9lH+mi252mvV1O2Z9Hi17shEzQ9sYYDRaTFWMZ5P7bt1lRTmpPI
 1Vlps1PHEQFurXEWti3Zfc/CTIZLkKO2QzUjSs45QhiG/GPOxo5aj5JUZ+uaCttnSzhQdFPldbw
 LZOiq/nnAZ917qrFjNQRAWLKlv0l/7OQgpzbRcxM3E1lvwGBFpRb+pRUAN33L7xzYXwuYsLJPig
 w7enVbz02PZMSYoOlHPmiSSpuzneb0CnmZJB4JbC/WVGw9/VO0EjdARmT9fLHgH2bY1Ja/gf4cH
 GrJUKDm56D4HvAPkzE8uaML4Mwef0L/bJHl2J/rqUCMnD2Yp+g3aUaF29aHnZzNMaEv4abaOrMz
 WRiij9yUjD83R9nlH5dtbZyfXGbcsx
X-Received: by 2002:a05:6870:d376:b0:417:9244:d180 with SMTP id
 586e51a60fabf-41cec375cc6mr77949fac.46.1774566018894; 
 Thu, 26 Mar 2026 16:00:18 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:54a7:4cbc:7d2e:3b99])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41ccb6b1d25sm2742836fac.16.2026.03.26.16.00.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 16:00:17 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 26 Mar 2026 17:59:24 -0500
Subject: [PATCH 2/6] scsi: return ENODEV in scsi_get_blk_by_uuid()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-env-scsi-hw-part-support-v1-2-55c9dd07a2cb@baylibre.com>
References: <20260326-env-scsi-hw-part-support-v1-0-55c9dd07a2cb@baylibre.com>
In-Reply-To: <20260326-env-scsi-hw-part-support-v1-0-55c9dd07a2cb@baylibre.com>
To: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=798; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=xondRZaH8ZcCROETMdpwVwcwTqqDVRhk5DmYmR0Wqqw=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpxbpcgeGZp+WaJJHhMjyYebcG7rJcFJ61HkNdM
 PfWMaTtAQKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCacW6XBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A6tYIAI86wQOqSMRb4DMyjXvwHjPG9o9BVHqNaBAKF/h
 UaJ/NtaD0R7gAQ0INCoY7aupzlTFF6LfniiKsbuAi+T7UR391Gf3Ine31YH4bNCi+2rvr0v63gn
 yYQUQpdu5DY81y+lsse+GsSQTRMhNM0ssq3n4Q37EGC+QHgPe7qKLIcHRCopkl48jdB9XAxSMRU
 X6tuxb0zjwSNHVHpnudqAqgrrTjbSeZp5S5X3FCHIiZBPJI86IXR3eJ1dlQNHYkvLCbo+yijuCG
 kH6vVgAvGoUpyCpu2ZBVGCCv6rP6AtrVrdFvPnB9X+XrZa87Px7CaCg6LlM6f8jKziZ73kuaS2x
 d1bY=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Change scsi_get_blk_by_uuid() to return -ENODEV instead of -1 on error.
Other scsi_* functions return an error code rather than -1.

1 is EPERM, which doesn't make sense here. So we use ENODEV instead. The
only caller only checks for !success, so changing the value has no
effect on the caller.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/scsi/scsi-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi-uclass.c b/drivers/scsi/scsi-uclass.c
index 3eb6069649f..e7870d7f831 100644
--- a/drivers/scsi/scsi-uclass.c
+++ b/drivers/scsi/scsi-uclass.c
@@ -50,7 +50,7 @@ int scsi_get_blk_by_uuid(const char *uuid,
 		}
 	}
 
-	return -1;
+	return -ENODEV;
 }
 
 int scsi_bus_reset(struct udevice *dev)

-- 
2.43.0

