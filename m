Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 729E3C87FD2
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 10:29:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD656846AC;
	Fri,  8 Aug 2025 12:29:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wX3HE716";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9E0D846AD; Fri,  8 Aug 2025 12:29:37 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E449846AA
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 12:29:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-459d62184c9so11971835e9.1
 for <u-boot@lists.denx.de>; Fri, 08 Aug 2025 03:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754648975; x=1755253775; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aDdtvr2xFN3+Vpw26hbG+Q8dOfUnIVYSft4vNq3xLDw=;
 b=wX3HE716eW9y+Mut18js+1sESLqHbtv1rB//8J/WvMZTjZ1LtvU8FpVujqcCCJHu8N
 bd6O1KaYRspwPJCbVn8OfDbL22bWux5tNa95r/g7bkqJzZE8Gnv5edR1sJAttNlc+jME
 Mcxa6qJisUva0muhdB34IFubeedCt+6dXmWjUIiyYRkKn3CNL5YuUGKfHML0GEhM9BWv
 k+87ZZRpx9fkInsllQhjDKaHrAPcUFDb3IWSblV3pJ42IKrtXTl9B8lGR0io6Ik+bYTM
 b4Ps8G4iXFzbRZv+ZErm/Ydfzr/v+0ZJbJXmRisE8I4G3YfWx3AWJmKTAb0xJK0v+tB/
 vIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754648975; x=1755253775;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aDdtvr2xFN3+Vpw26hbG+Q8dOfUnIVYSft4vNq3xLDw=;
 b=QC8d4PSSd4UjcQWlJu5J0NH5UXFdDUjI/DRownBTM2XZbMmJbk5qNMN4lw+XuwyJX1
 vak69IJCfXFqL32uCMLJ8e7K1PjqhFxB//KciCoRQ7FnSG2YqpOnH34EIVXKSZF0xfdd
 g2WzGtJSZt2z+NsDOWwBwV/E88OXc8VtzLUU9WXMKKx39fJq0oQwqF4wbZlMicuS5k6b
 GCevgYrIT0aiXDrSei3Hk8x6SGA4b6jHWwYnqLhzHuQOdpfHEKbZVgfXMbHS2hweI1/I
 jiN5f0AkI0Tduzx3Au+lwgPRZa1ZLs3IsW7Ig/iEAxMgRLzHE7EzdtnoZ6lweOaFJRGK
 Uklg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgfA6IcDQpjssvtfvzP7rGn2htvRzTJCAIBBduAjYFXoRNMpEh4IHeOpRb2X8w/XuBijsPo0w=@lists.denx.de
X-Gm-Message-State: AOJu0Yyj/mScPOTLaBvbKPE3fYe1uYHEnkL+F4vp0MVmFMTKiDbcfue4
 w4lRquipp1v5t1svwmrQha81fYLml2nd49SreWE2AnKpnAq1kczSV69u+4N68AAbJ9902BuRUN2
 blNlvA/s=
X-Gm-Gg: ASbGnctn9hS7cUEqCiMrMLctByRMByGzI8tgOlzzTo4Na5RzKH9bXfh8lfyizsMbNMq
 Z+nyTDtAf4jD/mdUbcz9jQeD10iq5DD63mFoWxaasZ/ySqTf1OZtCwItmUQlY52DdBedFnh4pNb
 NcMD1dnGuK0StbJOiAxUKb1eAgsPYEJWvUW8Z6NRxH21haS39uhsU8FSkOoyPV2ovk29ilnplJt
 YuAVCTHTSzNzOJJGno9kNYU+TnUNYYzCgTL8+V4R7Bpsr17SvJOZd+lxQBZsLIESy/tZ47SE/ap
 MVnHbSpuGqcl1vKmOCQZKijvCmPx/IslBC7JfSXDX2aNpvtmSrXlI9xYbVDf4EMpbWLoTqOyF8/
 hsavn3NXEzEuhzzENjpiRMfgHiNyWvnQgZmMIhG4JGcCUQvure6M=
X-Google-Smtp-Source: AGHT+IFyedp5nzR8aaorLvNlFKg8z9wqVzpx34pLxeTgDEnW36rkobWO/m6BmchHkjpiq1608my+Lw==
X-Received: by 2002:a05:600c:3b1f:b0:43c:f0ae:da7 with SMTP id
 5b1f17b1804b1-459f4ea0e52mr20634465e9.7.1754648974748; 
 Fri, 08 Aug 2025 03:29:34 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:e7fc:9a8d:4024:d186])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459dc900606sm194134685e9.15.2025.08.08.03.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 03:29:34 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 08 Aug 2025 11:29:33 +0100
Subject: [PATCH] drivers: qe: avoid double free()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-qe-v1-1-7b62b9229128@linaro.org>
X-B4-Tracking: v=1; b=H4sIAIzRlWgC/x2MQQ5AMBBFryKz1qQaEnUVsRg1mIViRkQi7q4s3
 /sv/wYlYVJoshuETlZeY4IizyDMGCcyPCQGZ11la1ubnUyPWHrvg6PCQwp71CQFY5i/dEE9SL5
 hExr5+t/b7nlez1AJPW0AAAA=
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
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

Avoid calling free(addr) twice if the device for ucode is not found.
This patch repeats a similar fix but that only applied to code without
CONFIG_TFABOOT enabled. This patch applies to the code with
CONFIG_TFABOOT enabled.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/qe/qe.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/qe/qe.c b/drivers/qe/qe.c
index 69b7de084e5..25880db37cf 100644
--- a/drivers/qe/qe.c
+++ b/drivers/qe/qe.c
@@ -255,7 +255,6 @@ void u_qe_init(void)
 		struct mmc *mmc = find_mmc_device(CONFIG_ENV_MMC_DEVICE_INDEX);
 
 		if (!mmc) {
-			free(addr);
 			printf("\nMMC cannot find device for ucode\n");
 		} else {
 			printf("\nMMC read: dev # %u, block # %u, count %u ...\n",

---
base-commit: 123cd77122a13288e1552b5d9b7c22a6f19e2e02
change-id: 20250808-qe-baa4999c2e19

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

