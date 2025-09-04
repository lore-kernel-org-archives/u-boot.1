Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092B7CA1012
	for <u-boot@archiver.kernel.org>; Thu,  4 Sep 2025 09:58:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 843B183B21;
	Thu,  4 Sep 2025 11:57:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="q/Qi6pcy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D89C83B03; Thu,  4 Sep 2025 11:57:38 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E082083804
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 11:57:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45b9814efbcso13712965e9.0
 for <u-boot@lists.denx.de>; Thu, 04 Sep 2025 02:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756979855; x=1757584655; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uH9lIj4KRAqS5ZvNAtgqdZC1DHLKUcfxSY8W3+02R1Q=;
 b=q/Qi6pcyhGqLs5NV+kPMSCzaTlHHFWZUPWmQz9gp4sKs/p88BN8jROI9LkgpwBpBRh
 9lm4v0a20utDkKJ59vN/VfzkOQNcr7fC+7imtrS+0dzlgDXWavXsIXSKr+K4n+Jc2qVe
 9PlFCb2iCaKn/xSuM/u8GUs7QLU4KPurCQlnTVUGEvTQDcQgZa/dSmP/x9drjBksZcnT
 LS+gA5GvKQmCOj8JtNXdyirgUsfNb9nD0Rsei/l5vxaTJvV8laP90OMUx7lqZnkUCp9G
 JIdEYYtu3zRDbvB299X5vWBqOxKr8t5EDgYb+sSDclzdVy7DMmlz+jspVFx1T5mnRrVR
 KtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756979855; x=1757584655;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uH9lIj4KRAqS5ZvNAtgqdZC1DHLKUcfxSY8W3+02R1Q=;
 b=uqYKXSgZe2+dlEfuT5Q7U56r4eBacSQn2Dvb8JC7YhpNFwLFKs3Qao5HRoSI0OPQhc
 bgCySQ39DgiK6beLzb2dBjcjKxeVb1/3dJFDN2CTetO7G8XcIlHe6piVbAfbk+4GuOLB
 5iLlMePCtPgWNPDJOUAluDKqitMtkw+w+uHrSEyEEQhfl+4Js4OSiLMUkBbuJcw+4pqR
 FkjYpyIsuQZFT5TCS7oFrnbAalGBjef1eoyRDvrkF9YqFR24GKTKtKGp5r9SU1CeKLDR
 DbXUnPYdP61rVtBSays3UkYbOAmTN/P49rgs1+ZG2M3lccoXW49UwndJeRdNr/KYm8J+
 bAcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOIZAohbmkjfZZ22nr8E/LnyM/hLS3I3bJ7ie5+Wq6DPMfCG06j9AqP1hqIRb6obKhp6ERNFQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxbRsigzyuPqlj4CLVm3Un6najLLSfgLJLvuJkiH0Z1onWqoeKG
 itmWlL9VK4RenreJxUzSaXlkCSQdLOXGADSELNLP1T5bzdt1vZwqGLYgdR2Sa7HxxQo=
X-Gm-Gg: ASbGncv1L/9baFEMa3enoOMS0coXWYEG4zKKp+LK982Ye20GMfWE+R0wKdDrRAW2O8n
 2my6yGNt67FA/ZbvF5Kw9Ahi5RSmiZDgwxCWhdq/7J9PYPUmslpgUrf76KvBzSA7HJxIdWYePsK
 QWIRCJ0H32ul5/DUAXi5Tbw8fqBZ2yOi5rbl3GoGCHANt9PRt6rZPYSmabe1+ReQAypV3XHiJc5
 5GVp1B+qkSdOkYY/9vFpva+XSvN33D3cK3FFh9FU7mMBdY37L7XIG7kJc69A1xhEkkGnaZ3kWdA
 nNNdzIaILd2if9mbuTes5Y6RMTfDYVA+o6HY+EhTTnP/7Kgpu1Kll6qGmB5vJsTM4HXlw08AiY3
 K7fN6vob+lSDfJjZ0vPkUDIEoXjNn7o4qkxcHm0sGuLXGIxhFte05mD6e4bNlHg50
X-Google-Smtp-Source: AGHT+IFIk6M2M5TKdRkOb/L9hpPVHuyMbk0VSo4H8rCXu1yZelD4gDeFgiNyU7Vn57/zD0V39TXQtg==
X-Received: by 2002:a05:600c:a45:b0:456:2139:456a with SMTP id
 5b1f17b1804b1-45b85599135mr158530685e9.15.1756979855330; 
 Thu, 04 Sep 2025 02:57:35 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0c6b99sm359057585e9.4.2025.09.04.02.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 02:57:35 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
In-Reply-To: <20250808-pwm_meson-v1-1-cddb7e5f76bd@linaro.org>
References: <20250808-pwm_meson-v1-1-cddb7e5f76bd@linaro.org>
Subject: Re: [PATCH] pwm: meson: Stop premature exit from for loop
Message-Id: <175697985489.2904655.1249756606342116521.b4-ty@linaro.org>
Date: Thu, 04 Sep 2025 11:57:34 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

Hi,

On Fri, 08 Aug 2025 10:34:43 +0100, Andrew Goodbody wrote:
> In meson_pwm_probe the for loop attempts to get the name of a clock but
> the following if..else statements only perform useful work if -ENODATA
> is returned from clk_get_by_name. If clk_get_by_name simply succeeds
> then this results in a premature exit from the for loop and the
> following code can never be reached. Make the else clause only apply for
> an error return from clk_get_by_name.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/1] pwm: meson: Stop premature exit from for loop
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/dfa8b39a6addc09697399c5204766958eb0dfb51

-- 
Neil

