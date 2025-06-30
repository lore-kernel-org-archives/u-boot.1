Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9B9C83030
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 11:57:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81B3681E13;
	Mon, 30 Jun 2025 13:57:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="x6kDRbJa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7278981FEE; Mon, 30 Jun 2025 13:57:17 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20EA080B9B
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 13:57:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-450cfb79177so24753745e9.0
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 04:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751284632; x=1751889432; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5Abc31VTsS5dizrx+rbrfCg48IdYQ7sY01jfG0QZCpc=;
 b=x6kDRbJa5xhhB0VgBZzZ1WdvIquorEP9QxOBVZcPPuUnnG/VaJKAJloxQ41nJc0wbB
 kXDXtRRe2pfJAJ3FHtSd5o6tRL9rCkx8eWqeKDwh24ilqya56hSEQdxCNJGIpe7Mp5F7
 vieofRvyvtHQfmTrmpB6LJ+Nq6CW1cW+AjWsHNaRdtDodrPGvoc7LxK6CmpSVF6v5NLY
 zRYjYG1tp0QFfru3Y6Lbaw1QPVLI/KbYNwsJuy9kHPH3y6Jcc6SgCeZuHmzMwegzTXv7
 uX3ZRTAcsREPgjIqIUgt73tMnOGrTq+9F1JnZSWBQw/EauCnusEo9EhreMFhj7kyffDI
 Lkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751284632; x=1751889432;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5Abc31VTsS5dizrx+rbrfCg48IdYQ7sY01jfG0QZCpc=;
 b=wEftwo4CksZnk4NWDGPyxKN6443hCj4stQlJEcn6tsAgwO3f56yJzVnNze8jkfvbKU
 1v58DCLgoFen00u0qqr4veuSIF7K2tHegHDa7Q+EO2e3MzAGcObF4iq4fBZoLZB+b14b
 kt+NclCGxZvUcTf/HUrrvXMSCQzVVGlTAs4xMUfX2t/LtN78qN6O1/WkFWTHpDYn2UhQ
 +BOzXBd4wZxYUm+D1zF6iwq11gMho1uN+yu/m9U3OYcAS4YvBCDHLpQdL7rL4UWsup/N
 KmoZGecwT/jsciAw5cmD9Vg4mxrgIjTMr6Jlw15jAXgvCsmTfOtIP0qIG4ShHMuz5Wi8
 hSkw==
X-Gm-Message-State: AOJu0YzFFPMqaF8bz7rJjRnEXULBd5BHP/5R8A4LDKYwAbVQdOMh8CA2
 9+cknFHE5BQt782Wv79fkxE4m7rH6Ouz8Kr7OuPazx+Fr02TOYo5uT0D9pd9KIZOJDBj4E2OZWo
 77btCdMM=
X-Gm-Gg: ASbGncti5tXUyjR6aKuPVwtt3B9R4ocYe0TF4mQ5Ri+VcqiQPx6hnJim/e8LKOaec/Y
 BcaPqz5KIHyVpIzyX8p4D2TXAMEHs4OhBIQ6BhLz9pBPXLBnyjWi9vP62d3dHwPi4ADQlosMXwN
 Vch3VJ5kGeU0J6YJGDZhiYHKmav8cj3RvGDA8hP0R1Fa6OPD6YOxRHSBWcMGtHYbUsZ/0tGw4LA
 4H4kmyu/NCaJ1OWD5P45vtHgqGae4uI4E5a3SEeGHJ7By0/2CK4RxHF0Ttlp2hlMsRolfRX53q5
 xNslStKc7+SQJwBZas6ayMFHvL3eBsL5V3iUhXQzf79XGfJWWjd0fbzdwFvHCW8CtwwoShC4VxJ
 8bnWCQrXRYUZDzxk=
X-Google-Smtp-Source: AGHT+IHwXv71DFZgDM2nUepbiHuZJLiF6H6b4q/3FYTm58brQfGzvFQY+m1FZbCmkhpGXVhqbqpMrg==
X-Received: by 2002:a05:600c:3b8c:b0:453:c39:d0a7 with SMTP id
 5b1f17b1804b1-45396072f4cmr79474735e9.5.1751284632441; 
 Mon, 30 Jun 2025 04:57:12 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ee3:2301:10fb:ba4d:cfb6:8c75])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538233c05csm163653755e9.5.2025.06.30.04.57.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 04:57:11 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 30 Jun 2025 12:57:10 +0100
Subject: [PATCH] boot: pxe: Prevent evaluation of uninitialised variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-boot_pxe_fix-v1-1-e1f077dd4e58@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJV7YmgC/x2NSwqEMBAFryK9nkD8jBnmKoNIJ7baCxPpFhHEu
 xtnWdQr3glKwqTwLU4Q2lk5xQzlq4AwY5zI8JAZKlu9bVtb41Pa+vWgfuTDuI9zSOXYhKGFnHh
 UMl4whvmJFtSN5BGrUN7/f37ddd15m0pZdwAAAA==
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

In the case where parse_sliteral returns an error then label_name
will not have been assigned to. In order to prevent evaluating
label_name in this case add a check for the return value of parse_sliteral.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 boot/pxe_utils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 82f217aaf86..eb4d7723481 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -1348,7 +1348,7 @@ static int parse_pxefile_top(struct pxe_context *ctx, char *p, unsigned long bas
 		case T_ONTIMEOUT:
 			err = parse_sliteral(&p, &label_name);
 
-			if (label_name) {
+			if (err >= 0 && label_name) {
 				if (cfg->default_label)
 					free(cfg->default_label);
 
@@ -1360,7 +1360,7 @@ static int parse_pxefile_top(struct pxe_context *ctx, char *p, unsigned long bas
 		case T_FALLBACK:
 			err = parse_sliteral(&p, &label_name);
 
-			if (label_name) {
+			if (err >= 0 && label_name) {
 				if (cfg->fallback_label)
 					free(cfg->fallback_label);
 

---
base-commit: 7027b445cc0bfb86204ecb1f1fe596f5895048d9
change-id: 20250630-boot_pxe_fix-7877ae1f4cd6

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

