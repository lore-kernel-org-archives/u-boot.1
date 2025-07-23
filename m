Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4AB0C83F1A
	for <u-boot@archiver.kernel.org>; Wed, 23 Jul 2025 16:32:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F0B083542;
	Wed, 23 Jul 2025 18:32:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="odd1Zc11";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E91D83544; Wed, 23 Jul 2025 18:32:50 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CA02833D0
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 18:32:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4563cfac19cso14725e9.2
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 09:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753288366; x=1753893166; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=akn0anou6uRMihR6/sVRT6ZbTj2eWSSv7MLieSfatoE=;
 b=odd1Zc11oML2LFVQRvhzCKMZ/kYm1ZMi9REndPl9j7ojLuozHhFGr63t9nQEPW8N0G
 C/h+77MGd7DXQd+x2NOYzaQCLPLqdU9Qier/+F1RMV+hdqTX2ccJFFZYsaDxTgJs5PWf
 fjKPEqZBdHnzipyVmm9c1A+DsrAynzW+gOgkM8L/ISq/9Z5lREicBOEGJxdyRkItEn3i
 aPwy9ltxYCXYCeTCi2xkR9bLkceTLTNPBHT7nvghhGgpBcjBzUGq34w+XJg5jVb07qBB
 wk+xIqNvzbDvzyOR//kJpzDgJJJhlhwro32DsF1e+3j/qfBVu8Incd49RijV8ZeyKWPR
 Y9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753288366; x=1753893166;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=akn0anou6uRMihR6/sVRT6ZbTj2eWSSv7MLieSfatoE=;
 b=IdhCOXHc5+vCp2mjYLcAHH6CbK3th+1C3CLca6yEGOWcXlPfPEUSkCI8rh4hMzvGnp
 LUWlrBZFqJXhAtCLdMQPYzAg011dBwbH61GEPRiLqPYXQzdgiEubl6RelEAUIW2U58jO
 B+RFd+Uwrxks8etsQ0r2l/bzhmuMhBKJZoFRbQ1NHXAMcHmZ7gs3bl29glSzEcE3ap6I
 PQycnK9JN6WA08HJJ2ztJESpHA3H9DBsRVrZ5CDXsE/6ajmrb8TmFtg5x9xxAufYhmZ1
 IQH8ofjuIV64C9PYmyiXwTpoLoqq7J6hCqpaQufB5/pmVYmrEZAlaSue1iiyOSXQdzuD
 L4pA==
X-Gm-Message-State: AOJu0Yywt0J5rNg5mmmqvhGD5S4psYS9t7da0/wjM9B4DSdklGEif+4q
 VIRZZ6LVj1mPjXr8ZAAYFYQZ54ustUQ3qK8hDzfDE4rDi0XuYuXV955tADLQ7lkDOj4=
X-Gm-Gg: ASbGnctbdH+WkYgxoaeh/0kbPuqTPzSXY3vJ8e6Ipu7O/7EUrxfR+hcfu4A5tTjLAkv
 oO2WHEAGeP6z3raUAZuSVSIY+69LOzrkB2YvQ9v8F4DZK3zIxSXQ+L5xtkav00z+HXUKs9qodt/
 zXBy39Co+03BQsmimONVzpH5XNpCi5IrfoviYNEEfcH1+V2phMerDH/GejURDCNZPj/e3clEo7o
 EaLvU2SLM6y6B6EUj3cDBBhQBDILPjFY3iOyU1N5JrHiJ30O3QJz+Tttw7jfU42H83pIiP2xq5r
 QqCp9pyLbC5/DN/pAw49jcS2NHxIHiIwQGI1JkyzklPr1O9+td8zef5AhYvVK9FKLqGXyAll/v0
 uO9P+spd1B/2wuximdGEUVCev1KtjGy8nL00O/FCf+iT7abTAQu0=
X-Google-Smtp-Source: AGHT+IGL02EjdTHyJ0Mj6QH5+LN8f+/M1rPp/CODrCg/GyvYNxSAqHBVLP8dDrIKdT9H0KP7rI7N2A==
X-Received: by 2002:a05:600c:1554:b0:456:1b51:67fe with SMTP id
 5b1f17b1804b1-45868d33063mr38849845e9.16.1753288366122; 
 Wed, 23 Jul 2025 09:32:46 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:cdd8:a59a:1949:12ce])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45869198e5dsm28721335e9.9.2025.07.23.09.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 09:32:45 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 23 Jul 2025 17:32:45 +0100
Subject: [PATCH] clk: imx: Free pll on error path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-clk-pll14xx-v1-1-f7c865f81a06@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKwOgWgC/x2N0QrCMAwAf2Xk2UCXbQj+iviQttEFax2pSGHs3
 9ft8TiOW6GIqRS4dSuY/LXoNzfoLx2EmfNLUGNjIEeTu9KAIb1xSakfa0UX4+TjMDJ5glZ4LoL
 eOIf5aD5cfmKHWEyeWs/N/bFtOzGt+Bh2AAAA
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
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

For an unknown pll type the error path neglects to free the memory just
allocated. Add the free.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/clk/imx/clk-pll14xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
index 7ec78dc3a80..f9fcec18f9f 100644
--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -409,6 +409,7 @@ struct clk *imx_clk_pll14xx(const char *name, const char *parent_name,
 	default:
 		pr_err("%s: Unknown pll type for pll clk %s\n",
 		       __func__, name);
+		kfree(pll);
 		return ERR_PTR(-EINVAL);
 	};
 

---
base-commit: bd0ade7d090a334b3986936d63a34001d99722ad
change-id: 20250723-clk-pll14xx-0dd5bd34a2b2

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

