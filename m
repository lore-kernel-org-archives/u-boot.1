Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A759C7115B
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 23:51:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DACA282F33;
	Tue, 24 Jun 2025 01:49:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XoecXc+M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A60882F03; Tue, 24 Jun 2025 01:49:51 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C22E82EAA
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 01:49:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a575a988f9so2337439f8f.0
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 16:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750722587; x=1751327387; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KzsnmOIZ4ldC754G/7gvrghKaHE2LVY2C80+VrWqBeE=;
 b=XoecXc+MWf7GAufVkqtKJkT5se26ioQ4lNBwkO98h84VJDZ/7BeBoHJQu1Q0wRWoTL
 IdGCYDexcK0iTVZKUA75DBLyNdN+4aTmLNvQs+hBHaHJGkpI9K8uJqJicAtAtg+glGKW
 tuGvY4P7QcqabW5tuWlnEAOo/1Uc0e5Exm1i3LIJ+8y7lXfGi/zEQ7MtO9l/6kF0oTQG
 DPf2rVYSOnQi7rMFOxCW3LCNVoKdtl4yzKeYCfC9sBeXZ1XNarPCiud1hGuGQhVrdQiU
 LeWkiaIe6J6gN5eVbch/m7k972swqG+AxH4tvaFlodNtIOrFlgb0Hgy3R7e+hJs/eqVj
 HkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750722587; x=1751327387;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KzsnmOIZ4ldC754G/7gvrghKaHE2LVY2C80+VrWqBeE=;
 b=PKzef7DuN5nr4fPfcI6aftlRHZ4cEXWv9QqpvtDWmjbEojlvL6zoR7y8DAvBrsuKH9
 ELO8loVnMKSsvYbbcLlaQkAEVTfFoe5mxtabNjWJ3k04DeEXmWMpDaUaQGvc+22pbPRH
 AlTQVerUEcCY47vE8pLOclFz+/zlWUDMiQnQo5mKHhItn8Cb/0wFhUTQHQ9uZRf6fs9j
 WQQo5pHRHPHs4MMjgj9XPXeF8197Tg07D3LBSc8sf8oc0XHd7RaJCX9tIrMHYrAHhBrM
 V8CI8AGFSv7Q7oOLYSqRh8KR1hOH4A0HtK1IWy2Umsj0p4age16sHvSx/xIFGow+xwjL
 1rng==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyS+SpBdGmjUKKRZLCOKPr+G/4isY9LH6kSVk1jmoaF+5JRKrgixYnXPSK+NdPTv7k9eNXU8E=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1KGVl4k72jgPvb2U5pq8mIO769ic/2mSotCLQuD1XUN56rpbV
 PNZxIsrO2tQQZKmaodKDwsXmr91h0M/KGF6uxNieQBcT0bJqOYJQgXE79bKzI78SlbLEFKfIFG7
 QioRq
X-Gm-Gg: ASbGnctWahgieTF4cfrxU3/bAEBiIdvoTP+ifBj/ppKkQ0KIev6NXr13OEAomch74HA
 17YGDYGQdJLmGflBBAc42Wd0zCMi6D7Ff4Q6aEBmTXLRCQeyMNhezOHQD5vWUzkuniHYFWL6qEu
 HFR2oXgbdLaHWuwgaWdkEHYAcRMsNjaUJaMsLF816JSvwYxlLA/w4mZLp7oN0DVKMhm5gKf0oo0
 Xib3NzevGAZFR8eIrktRssS0mETRxL+P+t2Vbf/Tw0dFfA1KQohmXWqqmWNL0a2Og2Xx8JsdviA
 ID85VyKGlDJrzkScapmZeteK0ZD947mxglj4T7RmPMy/sUMpopfVpx+GgQMym9aRtOvllaX6IbW
 14kfTMNRm8Qg=
X-Google-Smtp-Source: AGHT+IHeNmMfgAv3HvcMl7YRLDtL9TCk0wbZs7AOKN3cNzwKewVVZmy6R8J18n1d4wBW5bQB9L6wCg==
X-Received: by 2002:a05:6000:4021:b0:3a5:51a3:3a2 with SMTP id
 ffacd0b85a97d-3a6d12e62dcmr11447221f8f.45.1750722587351; 
 Mon, 23 Jun 2025 16:49:47 -0700 (PDT)
Received: from toyger.tail248178.ts.net ([213.240.182.16])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e7fb5716sm432284f8f.0.2025.06.23.16.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 16:49:45 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Luca Weiss <luca.weiss@fairphone.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20250611-qcom-clk-variable-names-v1-0-37615b74daad@fairphone.com>
References: <20250611-qcom-clk-variable-names-v1-0-37615b74daad@fairphone.com>
Subject: Re: [PATCH 0/2] Fix variable name of msm_clk_data in two drivers
Message-Id: <175072258513.128390.7059938176527362151.b4-ty@linaro.org>
Date: Tue, 24 Jun 2025 01:49:45 +0200
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


On Wed, 11 Jun 2025 14:08:43 +0200, Luca Weiss wrote:
> Just some fixes with no functional change.
> 
> 

Applied, thanks!

[1/2] clk/qcom: sc7280: Fix variable name of msm_clk_data
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/c98477fc15fd
[2/2] clk/qcom: sm8250: Fix variable name of msm_clk_data
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/6d0cdcfb4e34

Best regards,
-- 
Casey Connolly <casey.connolly@linaro.org>

