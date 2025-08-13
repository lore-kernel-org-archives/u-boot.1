Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8181BC87FCF
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 10:40:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAFC282CEA;
	Wed, 13 Aug 2025 12:40:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yP3SGZua";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6669882CEA; Wed, 13 Aug 2025 12:40:12 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B00E6831C6
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 12:40:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-459d7726ee6so33970645e9.2
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 03:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755081608; x=1755686408; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VNrqnTw1L1sLUUCiNhRhq69FhIhlRRBFV5fGtOEQv/0=;
 b=yP3SGZuahgbJ6aaKT/Zz/16GXNW3cM3iIGPATLgZBA8auLlyyHU5OilQcdM4jTJ56+
 F451FEXaujEKD9qAjZL12CfphsN0D2mPXqNhA8bE0mp88hHp9xxBOx3pxr/EuQMeKFVM
 1uXZuDgaCupLtv7CA/lpWDm2ZVucKCEzxJyK20zAY2lopSyFigtwzakspHqol27/BF8j
 YJBIuvGHKwnX96qLUpnm0s7AVAR9I37W4aWIw36Er12BrI6duqSx5b6hvxpb/Fyc7Edl
 j6q80jzX1Is4S+SeAaFWFgWf2Wp6T8tl2kFUhhBM2INuI93e7QeV0SSp2clRf+uyvkQy
 uIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755081608; x=1755686408;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VNrqnTw1L1sLUUCiNhRhq69FhIhlRRBFV5fGtOEQv/0=;
 b=KGNCgoxCHdNoshS52eq2rlWvpXjKUVDbfOinJFEW6wMrb5uTfDdQ3kgOdig4Yjyr5p
 SbbSMunoE6vyWg3x5+Z9qpiYEdUab24p81bxyJZ7ZyAHumWIXA9vc83OVULo4RN4lSN5
 xcYDkRqxm935S3TO48GFp50iM9IO6+yxtpCzPAE+4XWdzdo4koaQAbJALN/KMwoLUJQw
 MUqUjdIrkbsHQt5/RjWKe0i+bfj9j1zA2kMorHXhiB80wm+x1F1NAMiyGW5DIIwLPyaj
 rJc2QyYSRYxlZs5TO0x2NW1ljARc1nzg0GOm/lRdLmUkwOb8SO78cftQrU+WXlA3vL0s
 9ptg==
X-Gm-Message-State: AOJu0YyVBC7Caud7Ju+XzGSw9q4EQrUf20Wluhxo7uX4ZrJV0g8yTIkk
 CE0JVh14+6mkiApqmfDEEe6yqmul6z43af6O2vjlZ+lPuCi27SO2coKTFch/FlVIHpeAf/Y2G0v
 5KYel
X-Gm-Gg: ASbGncuKYCiRya2gAPLaUMimCjXMeoSDyU9Pb45Qkbb4EYuphBq6Oqgb3EVpRrlz32b
 jqCXAbBoRerQ3rUtKSHFWrv5JUcqkrQqDDFdA7YCzRR/XD3j70eQoPxBHj7smUJlfeETIFIKqgp
 f3UoDBfZYeG3lCuIQuLNbCpcJ8w9rMXFDhPtruQgtrgXV76AtoDaiYkKGBXOfyBuLr9iIcmFhOl
 neryGHqqnXnwvF1mzl5WCuhTbHwqsFrsXVHRtUIdYGkMG5NHRYVHadVKipXIjYNxcFy0b05JIwQ
 MXb5ZU+GeCryNJp51w8TBo62iA+vuIjL3A6b0LvceE6i3cI0J2/7Q3rw5Ay30yvsRVh9IDrZa/R
 Y16egxSfZvjdc0TeZE3iimO+JGoZue1lsza3UJza+BQmnByL6
X-Google-Smtp-Source: AGHT+IEFI0r0ZhKmPA+m6+j9r8nb263Fb0Yn2tRJVexVuU6BhrTKNt6eJEazfaVoDzt5RmdCj2sX3A==
X-Received: by 2002:a05:600c:1d20:b0:456:8eb:a35c with SMTP id
 5b1f17b1804b1-45a1660aa3fmr23828875e9.31.1755081607715; 
 Wed, 13 Aug 2025 03:40:07 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:f76:d65c:a81:fe01])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a16dcb8e4sm24610095e9.1.2025.08.13.03.40.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 03:40:06 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 13 Aug 2025 11:40:05 +0100
Subject: [PATCH] tpm: tis_infineon: Cannot test unsigned for being negative
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-tpm_tis_infineon-v1-1-c95434a98efd@linaro.org>
X-B4-Tracking: v=1; b=H4sIAIRrnGgC/x2NwQqDMBAFf0X2bCBJ1Up/RUSifdY9dJVsKIL47
 8YeZ2CYgxSRofQqDor4sfIqGVxZ0LQE+cDwOzN562vbuodJ23dIrAPLzIJVTOOtq8ITjatbytk
 YFGaMQablDgV7uvUWMfP+P3X9eV4nWoiTeQAAAA==
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>
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

tpm_tis_i2c_get_burstcount returns a size_t but also returns -EBUSY if
the TPM is surrently busy. As size_t is an unsigned type simply testing
for < 0 will not work so change the test for being equal to -EBUSY which
will work. Also remove the trivial comments.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/tpm/tpm_tis_infineon.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tpm/tpm_tis_infineon.c b/drivers/tpm/tpm_tis_infineon.c
index e2f6238cbc7..180bcf4f938 100644
--- a/drivers/tpm/tpm_tis_infineon.c
+++ b/drivers/tpm/tpm_tis_infineon.c
@@ -353,8 +353,7 @@ static int tpm_tis_i2c_recv_data(struct udevice *dev, u8 *buf, size_t count)
 	while (size < count) {
 		burstcnt = tpm_tis_i2c_get_burstcount(dev);
 
-		/* burstcount < 0 -> tpm is busy */
-		if (burstcnt < 0)
+		if (burstcnt == -EBUSY)
 			return burstcnt;
 
 		/* Limit received data to max left */
@@ -449,8 +448,7 @@ static int tpm_tis_i2c_send(struct udevice *dev, const u8 *buf, size_t len)
 
 	burstcnt = tpm_tis_i2c_get_burstcount(dev);
 
-	/* burstcount < 0 -> tpm is busy */
-	if (burstcnt < 0)
+	if (burstcnt == -EBUSY)
 		return burstcnt;
 
 	while (count < len) {

---
base-commit: 7807ed921314cd7af83fd88162d0b8c6fb20a9ca
change-id: 20250813-tpm_tis_infineon-62014a7e6158

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

