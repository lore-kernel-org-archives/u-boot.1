Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA80CF6D28
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 14:53:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80BFD89112;
	Wed,  2 Oct 2024 16:52:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JGe7wG2B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 949498919C; Wed,  2 Oct 2024 16:52:49 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4269788DEF
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 16:52:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2fac6b3c220so46412011fa.2
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 07:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727880766; x=1728485566; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AFKi0j5xF5blKdyCG7iffX4LbNUzsEBmHGEAKQalLzg=;
 b=JGe7wG2BcuPL/3hNGddNh+22A/WZ6P8we8js34WpafV4OPscTAHDrXZ/7WG4Sh2b9k
 /I2QGPdgHaK4ibMYHPxHIaolsfx05w3oInXWScsQIn8PpKROhJQodZKOjsT6L9mLnuGE
 Uww8xPfv9C7SKcmIwC0j/iEMODLEb77ABGLOw8iqU8TrtqbPdCc3IwroDsxIG0jMT8ae
 LvcdoqqrluZrDllvDeCeeoTF7sReUNo0ua+jtiXWfD8ByH0/7rpvjfzokIsU5q+I5Z4H
 GxT3RhIlL2qoGwTLVpd/cAcsbmvyfpJPsZ7cPVbZePgPsw6QrXEH92aWlIGgacFx9fE6
 YJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727880766; x=1728485566;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AFKi0j5xF5blKdyCG7iffX4LbNUzsEBmHGEAKQalLzg=;
 b=gxkIH8z3ENOFEQWM5fnKAN/FF4cED9SkJvN3lqvMAbFsM+YpZVY9NT/PRbx+A11+Oh
 ORs2tRYKNxqd7IDsAvSKyccHAgMSkTC1ePuBgEm9yacg/KBS4gC24ChJgJR6N8eYe4nx
 E54fknGeYXIf5fyFtNF6soNjG2RDlBMXmx+vbzWtS/xCdCY1ogrXVsXcdJMefE75LCk4
 VtLmyR8rgquK/RN2F2ggZDmNoaalcq+vMAyq5FQ9GIySLT/JNGagydL33o4BHn0pazM3
 31jwt950jNlLQ0JEV2zq2b4ZxtpI7E5m/cfxlc4ZXIAGVYBpgUECoSKfMCzdXQYxjYtV
 Ac2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEbobSB90hhYTR2PfBm1PtSR7uhkLiV5WELlHqzs53f/269I4TL/w5XPv/LcQaEWybSDX9aSE=@lists.denx.de
X-Gm-Message-State: AOJu0YxOVlXUg9vOE1iWbsMJukQOktkHHDGsP7i1Fd4l5AVDJluiAc4F
 +6zS/RI8cPdMpSaZpMNV6+DAPaRx/Vu0cHwaX7dOiWEKjXP1UxtmSs4qOfghCf60f6B4IpnbS0W
 h
X-Google-Smtp-Source: AGHT+IEQ8D2oTmnja2b+sN5PX+3CcvQKR0n9nbovRA7XFxUts7OZDVmlt+5C3WNP+YtKpme8/gKYrQ==
X-Received: by 2002:a2e:bc1a:0:b0:2fa:d84a:bda5 with SMTP id
 38308e7fff4ca-2fae10224admr37542961fa.7.1727880766102; 
 Wed, 02 Oct 2024 07:52:46 -0700 (PDT)
Received: from [192.168.195.50] ([95.90.247.28])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93c297be12sm889785666b.179.2024.10.02.07.52.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 07:52:45 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20240911-topic-sm8x50-msm-gpio-special-pins-sm8250-v2-0-c49834055128@linaro.org>
References: <20240911-topic-sm8x50-msm-gpio-special-pins-sm8250-v2-0-c49834055128@linaro.org>
Subject: Re: [PATCH v2 0/2] qcom: allow msm_gpio to set special pins
 direction & value
Message-Id: <172788076498.935801.14687111194323775043.b4-ty@linaro.org>
Date: Wed, 02 Oct 2024 16:52:44 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev
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


On Wed, 11 Sep 2024 20:07:13 +0200, Neil Armstrong wrote:
> After struct msm_special_pin_data was introduced in [1], use the data
> to setup the pin direction and/or value if supported by the pin data.
> 
> Add the proper msm_special_pin_data for sm8250 after sm8550 and sm8650.
> 
> [1] https://lore.kernel.org/all/20240528-topic-sm8x50-pinctrl-pinconf-v1-0-54d1e9ad7dfa@linaro.org/
> 
> [...]

Applied, thanks!

[1/2] gpio: msm: add support for special pins
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/5fe73d1ecad4
[2/2] pinctr: qcom: sm8250: add special pins pins configuration data
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/43a6e47a5366

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

