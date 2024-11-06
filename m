Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6932BD44D58
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 12:42:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E77B6891F1;
	Wed,  6 Nov 2024 13:42:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OrJLQKwx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E85E891E1; Wed,  6 Nov 2024 13:42:37 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A64C891D1
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 13:42:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43161c0068bso56071515e9.1
 for <u-boot@lists.denx.de>; Wed, 06 Nov 2024 04:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730896955; x=1731501755; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zDSmmQ7JpxYpExm7Nxqkz3oKn41m/E9kwpBlObVeFu0=;
 b=OrJLQKwx7fM0PiKxojaZNbwfLvruqJR6lXpooUH2SM9yEgD9oyp+l6yoZSAzNMhgXY
 8hJOMNmWPk5NYGOb96UWIOHgwfqSZRxMLgCh3j4AptHFpZdhNpR1J6PQZoOmraOIiZ8A
 XtRJTgt7qqNHqg16QgkjlHD3wCtH66cprREsGLFfUZD5ZyG94dx4OPas+I9Va0cURNHj
 HeUhRGfH01ENicIY5pCg3jYg2StXxgmi6piSueX1SW4MRbE74NxeOitoFRyNmbLRcqpJ
 PCVae/xIZ6YBqKuMrJBbhwyxVP78yT8gmWMfIwqzvOK18PeFX2Uz/XSn76KWLPOVXyxS
 9oaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730896955; x=1731501755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zDSmmQ7JpxYpExm7Nxqkz3oKn41m/E9kwpBlObVeFu0=;
 b=RcLAI83BgnhArdkVvOdGKaFQyRabKy3hvAgKFdWcVNYbcAn5ZdGgn0YNcD41vMwMap
 NdCsq+A/mROVAB4Yebl5aylA4gyyzJqeCYMAQV5wWc1acBryfS5jUVBxPVtKNkIOEcq9
 kRpPdEnpAXGph6R4q6MWZ50UdTso2ole4QAv8FfKgxb7D71vsN2/3iWysFkePUHYCFBw
 xc+ATU8nyKYj/Gvnsuvq4DEyU1cY+hdNOK7wH2Lz1q5Y/i/eYtT4Fd2Mr7xN9C3XzJ9f
 lqZZExTy4qmqFdBS2PJvEY+R1DZ+CqHV52OoOOPt+WMSBVbE5erpHzpOhPHd8ygpHWSk
 icOw==
X-Gm-Message-State: AOJu0YwX4hlHGwNcgIYcBYzIcEtIAWdklR5K9IDoTyoEjw7TI9NyHA6x
 lm2TJ0ZjIW540xMr1gDbHGbqgPiv+eSMCfrvmJ8R9QuRmEbhWYdJCaFUzc8r3q6UDFNncAH18cA
 kk48Vs7Bo
X-Google-Smtp-Source: AGHT+IF2h8pToEQclwYZw/uWGnLI9yHJu24UEnlvpyh3y85KRtyGA3KTbD+j+UxNtioxseIORCpxLg==
X-Received: by 2002:a05:600c:4ed1:b0:42f:7ed4:4c25 with SMTP id
 5b1f17b1804b1-43283249aa9mr170415065e9.14.1730896954665; 
 Wed, 06 Nov 2024 04:42:34 -0800 (PST)
Received: from artemis2.elfringham.co.uk ([89.101.241.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c116c13asm18884765f8f.109.2024.11.06.04.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 04:42:34 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
To: u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/2] sandbox: select CONFIG_64BIT for SANDBOX64
Date: Wed,  6 Nov 2024 12:42:14 +0000
Message-Id: <20241106124215.677519-2-andrew.goodbody@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241106124215.677519-1-andrew.goodbody@linaro.org>
References: <20241106124215.677519-1-andrew.goodbody@linaro.org>
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

Select CONFIG_64BIT so that we pass the -m64 option (instead of -m32) to
static analysis tools.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---

Changes in v2:
Resubmitted by Andrew Goodbody with changes requested by reviewer
Moved select of CONFIG_64BIT from SANDBOX64 to HOST_64BIT as
suggested by reviewer.

 arch/sandbox/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sandbox/Kconfig b/arch/sandbox/Kconfig
index 1c8353d615..db29ca14bd 100644
--- a/arch/sandbox/Kconfig
+++ b/arch/sandbox/Kconfig
@@ -46,6 +46,7 @@ config HOST_32BIT
 
 config HOST_64BIT
 	def_bool $(cc-define,_LP64)
+	select 64BIT
 
 config HOST_HAS_SDL
 	def_bool $(success,sdl2-config --version)
-- 
2.39.5

