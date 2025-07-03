Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C94C77B7C
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 11:53:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 631A882103;
	Thu,  3 Jul 2025 13:53:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="s+HCd2tY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B65EB82A76; Thu,  3 Jul 2025 13:53:47 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB3E482063
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 13:53:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45363645a8eso55952755e9.1
 for <u-boot@lists.denx.de>; Thu, 03 Jul 2025 04:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751543625; x=1752148425; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=z8cjCxnQ706sV+EUP5q4kmCa2HG4dLN0k5OtQ5426ao=;
 b=s+HCd2tY7cHEalP2em2CB2hSWonhXukaQMJEpkzEDhhUXU9JYDrObfXrVCE7ZDqiGj
 1xy9jwLy1/YiXpBLd0YA1jjZd/VvtZDuBAZgNleHY5j/zxXXHufPUkt9MDa08sZ7RLUa
 WWte37zB4wK8NtlEnleENMH2z+QINl8Cu4ZixqBfhVI4a5iuZo158WsubjiPIMhSyyAJ
 TUG3VejoTpKqu7uzfhfqszP8xv8sx8yEAaOi/V9aFyp0cT4YcVGwTjIuNNVNin6s3zXn
 Ce7XSNzlyws/x2PTVdi5qyh1oymiy00SQdgC9oP3sopMHfuc8aR+DU0rfhyny5YkdlLU
 8ENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751543625; x=1752148425;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z8cjCxnQ706sV+EUP5q4kmCa2HG4dLN0k5OtQ5426ao=;
 b=Kelwv3kel8/wBexBhiI7gy4iYOK4E180cFZ4LLh7Vsna69SyBtasxV/SFZ702IBHU6
 22R/swvMEVW+o2h3d4FSIuTsmveYnbsVvkKS1GBHHKl8xQ0iB571Z09oKHTiq/LLzNwF
 yLUhv4eVe2IB87wTqPXpBQ1f6+rxkZ/CVG7aWIMxBaZTNyxlVWKweRGGM7b10yMaunGV
 8dJZ4Imsma/TqZiZ+/WNQR91GRj4gAfMWgPNZ8FhJEEuTjaReeePW9s0xccNy9uxSTh6
 TdVmRcp9LIlfVETeyFr8wdXcmdNVDIcrGAeUDIOr7YfUk/++eunZwg4obxLF0C7hl72W
 HqGQ==
X-Gm-Message-State: AOJu0YyVr41TTQtZHL1MCuANl/5dZgWolj7Ckc7xPeWbQV0CY23TtFHH
 nm7lw9j6D6ZcqAYKiRXv1aiVgBRj+1Mk8bUUvloMFXBD0XMPmi6+rBxR1bh83JN1+LU=
X-Gm-Gg: ASbGncvNekvHEixKgFNIDe6nd8osu1ccXEZY99PyJBmrCI3TY7/sYGoIUrsh1F0N3Ba
 xbU84CPQwKTxgXxqN/kjNl85CG3NnUobseOH6nDB6DmIY26br7OVVyMzFglVKXk/QnZIsYT1T1C
 Ai64U+byrJgdZogqAt7NOF+tIdOohV3b5Ueot2ZHo6/a8vT3+vJw25yRtAc86Q/UeeTjkVZih2M
 sKtgVg7JSGYUtBPoIOHHN9UohiyKSFCy6HdqXGz16oGs/k5PKo8Je8C0GADTrc1nysaUGTS5WIJ
 gP9SbHRgu7Q4l5V9KJayig0jl+G0nUPY3/KsA3jN0kGuo9ZCVuX5kSaW7L79XnNh9Zcs4If43NU
 ai8ms3/xzPNyF
X-Google-Smtp-Source: AGHT+IEVmWjeSXgZUU/FMzsCY+BoBnjYBzctOdemQP0DePX50f4p8Aal4uSdh6h+fMJb7wGbJHgbkw==
X-Received: by 2002:a05:600c:3f15:b0:453:9317:8aa0 with SMTP id
 5b1f17b1804b1-454a9ce2841mr28431415e9.32.1751543625040; 
 Thu, 03 Jul 2025 04:53:45 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:e07:801:b5c8:44f:55cc:3182])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453b3542838sm49213025e9.1.2025.07.03.04.53.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 04:53:44 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 03 Jul 2025 12:53:42 +0100
Subject: [PATCH] power: regulator: Fix incorrect use of binary and
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-regulator_uclass_fix-v1-1-8bce90b7e07a@linaro.org>
X-B4-Tracking: v=1; b=H4sIAEVvZmgC/x2NUQqDMBAFryL73UBqlWCvUoqs8UUDNpZdlYJ4d
 2M/h3nD20khEUrPYifBFjXOKcP9VpAfOQ0wsc9MpS1r6+zDCIZ14mWWdvUTq7Yh/kzfVLVDCC6
 goZx2rDCdcPLjFX9YF8glvoK8//+93sdxApZSQA5/AAAA
To: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
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

In regulator_list_autoset there is a test for ret being non-zero and
error being zero but it uses the binary '&' instead of the logical '&&'
which could well lead to unexpected results. Correct this to use the
logical '&&' instead.

This issue found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/power/regulator/regulator-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
index 09567eb9dbb..fbd1f69ac72 100644
--- a/drivers/power/regulator/regulator-uclass.c
+++ b/drivers/power/regulator/regulator-uclass.c
@@ -389,7 +389,7 @@ int regulator_list_autoset(const char *list_platname[],
 		ret = regulator_autoset_by_name(list_platname[i], &dev);
 		if (ret != -EMEDIUMTYPE && verbose)
 			regulator_show(dev, ret);
-		if (ret & !error)
+		if (ret && !error)
 			error = ret;
 
 		if (list_devp)

---
base-commit: 7027b445cc0bfb86204ecb1f1fe596f5895048d9
change-id: 20250703-regulator_uclass_fix-d9457eff7fe9

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

