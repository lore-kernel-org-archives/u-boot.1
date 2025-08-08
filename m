Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E16C87FD3
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 10:47:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A7F8846AC;
	Fri,  8 Aug 2025 12:47:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rIoqsBqF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1878C846C0; Fri,  8 Aug 2025 12:47:49 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B66C846AA
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 12:47:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-459e1338565so18264125e9.2
 for <u-boot@lists.denx.de>; Fri, 08 Aug 2025 03:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754650064; x=1755254864; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KbOluKsUzqwU6H7qj/lqx8tgPzCN2ZrLXKNnn9DmWSw=;
 b=rIoqsBqFxepLAN5dZtxYBGpSD6dT89H19osid/0cHItG6RC7C1EWAMVQ59Zrwmuhp3
 2m/tjio5vlFEf/kO+DftvfatQAZzegVgMrQxfRTty2AU1/d7aDkZJ41+GgbDMsz1328X
 oGV7l1/6SXqfeTzGKtwBEV0ESjUJES3mP8GIRipCw6h2G/sIIN1kApt+MJHJ8itp9tgB
 PnvjYAMYw5LkieIitJgpp+RAAgRC9P3wd2ttHQi8IzDwX9y9/Z6tgrmYt4Uz8lUfh6dy
 MZmSQRyKaTyGAZNYpiRg0skyh8Qi32rLS6mqH2N4g9SRJW8xFT77SWKA+i90J+pP6SJj
 ymrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754650064; x=1755254864;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KbOluKsUzqwU6H7qj/lqx8tgPzCN2ZrLXKNnn9DmWSw=;
 b=ZM5xzJsEHY+GFp3FM0wILJ8zPwJZ0hq/s2JZLputcjqy5tNv7Ca6uMOmIJtThgygbZ
 HA9VF7NJy+9sDOXX20UQ1JKV92a4h2qg1T15Tx9z030DapQx9YvXGMIUXUAU/P68uF0q
 MOft6Ze7pActlmwZ+HXlCLMomQJe13iHCApWgDk6fgEYrm6xEzmpHykuGj2p0Y4oGJgG
 afe7/mnU3i4AbGh8P3u0WwRdo4KhspScRGQBXNA9IgsuNHtT1TYEYZoPhyJZM6DHsSnO
 2gFepjkix4o0omsxOLQmru9S6YTrBpi2HLnnoisuxqwaUIa65FMu2Pkt0ifFhqlCHdUH
 LHLw==
X-Gm-Message-State: AOJu0YyoSJpL0OLkC8FdC+z9xsgYvZCt0m2uXAtYvulCnSVpKAP6g0Ln
 H0pru4JcMz06gTVlQqrezdssvbdMUJ0ZuGcDzMV6ObTae5JSlQVJpzkoRa4JxYxUbnxZy39tkhR
 m/OBSjmI=
X-Gm-Gg: ASbGncuPvMmfwFsppawXlpWvkZKKryr+4RAhVC6kUKqs6f3Jb61oi2jFX+/reGUXKEP
 u5qbSguBoSeQG1mkPo8x3VQJgXWl+1eiHOvZ6s2GYatuZqhVSIWie7fjzxJqXn3oaXgkwzlyrrS
 uZatFFSxlylj0qdYTDULuKVpgi9q+DW6L11KMVrRUStm31DcjZtGLjHP2VXBf449N2SuWnGRr7v
 E3qBtJNd9rH+dN8AzbYZCDsyGZEpg025QwVxC1ozMTlcgxAQOKkIAMMFfGwJdi6RdvHyZ6rHlqL
 8SISCkwuRgrJh0m9VaiUlgv3TSctecjwqdlB2olM8iLlHCC+Vb1cufLU9iL0/W7mCLJdEsZ121O
 eIS31JRw1fok70R6ql0j90Wea63aLHuqkU9DfP4t2Hgql8I7eNb0=
X-Google-Smtp-Source: AGHT+IF8zeqG5HqREt4KdEgAsrnhsDm7bKY5L13gsb6RJ4EcL08Se+k7kSIL5m8kuBhV+U+4BmH9cg==
X-Received: by 2002:a05:600c:4449:b0:459:df25:b839 with SMTP id
 5b1f17b1804b1-459f4f2e2c1mr21872735e9.33.1754650064399; 
 Fri, 08 Aug 2025 03:47:44 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:e7fc:9a8d:4024:d186])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458b55b4b4bsm140393645e9.1.2025.08.08.03.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 03:47:43 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 08 Aug 2025 11:47:43 +0100
Subject: [PATCH] ram: k3-ddrss: Use logical and not bitwise
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-ram_k3-ddrss-v1-1-5f9ed1f5cdee@linaro.org>
X-B4-Tracking: v=1; b=H4sIAM7VlWgC/x2N0QqDMAwAf0XyvEDrJpb9ioyRtnEGsZNExkD89
 9U9HsdxOxirsMG92UH5IybvUsFfGkgTlRej5MrQurZzwQVUWp7zFXNWM0w+0phD7G++g5pEMsa
 oVNJ0RgvZxnqKVXmU7/8zPI7jB1fSknB3AAAA
To: Tom Rini <trini@konsulko.com>
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

The test for the interrupt LPDDR4_INTR_BIST_DONE is using a bitwise and
but the test is simple logic so use the more appropriate logical and.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/ram/k3-ddrss/k3-ddrss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index 6590d57ad84..b86e2448eb5 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -626,7 +626,7 @@ static void k3_lpddr4_bist_init_mem_region(struct k3_ddrss_desc *ddrss,
 	while (i < BIST_MEM_INIT_TIMEOUT) {
 		status = driverdt->checkctlinterrupt(pd, LPDDR4_INTR_BIST_DONE,
 						     &int_status);
-		if (!status & int_status) {
+		if (!status && int_status) {
 			/* Clear LPDDR4_INTR_BIST_DONE */
 			driverdt->ackctlinterrupt(pd, LPDDR4_INTR_BIST_DONE);
 			break;

---
base-commit: 123cd77122a13288e1552b5d9b7c22a6f19e2e02
change-id: 20250808-ram_k3-ddrss-c1bafd8b7415

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

