Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58553FF8855
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 14:14:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E46E84948;
	Tue,  5 May 2026 16:14:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Z+p/T9aL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 061EA84956; Tue,  5 May 2026 16:14:29 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 808E2848B7
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 16:14:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso56279745e9.3
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 07:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777990465; x=1778595265; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nOY9q1UAbC6+8jnArKq2yhK+g8yvkyMjiTg4qAN9N2w=;
 b=Z+p/T9aLV9XIxUkAtrNJjmYQxtInVvjxNjuKfZVputIqD5rKSIWnWffzE4dcQfveCN
 d0p+UuO4Lich2lRqkxQh4oXDbppOy2wp977mNnvYghqswu5Nk23A1KICyihxiTB8fDzk
 rtWyS3jPMXl8Zbjy6QGwrrJqKL25z8K4hpcE6S1qosoLUiW6VnayxhOnjdH5uGhBR6Ck
 seRijvSAPYqeLv/SsztVzHpMjlOU7flZrSSwDA6RGqCuk0PoGV4OfGntOUGZzul9GFQx
 lCIYmdjyvt+OmrbCnsmLTDLS8Facn0MSZ4hVdmtL1pmtMvOA4hxTYqPclrr9cdttN24c
 kvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777990465; x=1778595265;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nOY9q1UAbC6+8jnArKq2yhK+g8yvkyMjiTg4qAN9N2w=;
 b=hkoJtIiXV3De/Au1zcA1satS1va5ysawQf6hYLVUXuH2XtY2Ixph8R58VDo41GpXs5
 spHeCgrjWdAUTYwWcDqZeo2zyyBS5M98hSMQ7xGJW0b3B7NeEMN5lUzxQNhcYY+3dppt
 d4T4gt4w7a71DxAXceeMsUdud/+7egRMCAW+gubFay0LiqV7hvrQhqNRqfYsY8wOdUtr
 SqyjESvDUR3Fa0lFZ5FmyWyYqLt3tkBk6baD7cZYwFcyq3U75wiX6tfa08kUI4ap96tb
 95dcjBynTS7Ce7lTEctcE8Rz90MMRuGmkQs2JOWeJKzqLM1f5ELqFfbhz92LFC9II/1n
 WhrQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9kI2cNiVbS2vwsZfDrD4UxsiDQC4rD7/jkbKj9m8Zs7IfMhc50AOKLml9HxdlejFvQQk30nks=@lists.denx.de
X-Gm-Message-State: AOJu0YxqIOxA0HVspbopEH6nH3bRDtMKtDSdyyyUll2K1banb7qH3X8O
 SDmXQSaWMUeA+A6fu9ABFJO5P9IxbFP9AlCbK+uC6+CL0SlgwnBHsbH/KXi71Txv5a8=
X-Gm-Gg: AeBDiettwByn1SPLF9/nd8tj7sH8hSvin2Mp+ATx1dEuDcVc9BQ79De2mHYu3kddWjZ
 MPO5VlMb3NFGpOOuEZdL+wygVLgx79BdyWZULPS29DM7CrfvhngUdwGchI2uhnnhyoTM6CEUeqa
 kGr134UaJMWTmmVBg5EdsTHgNRviIXMjIN6AvFXrbQ1C3zRX71K1eJmjLasspYTSLgrlt/LrzAq
 ehyjQLvSAJIOhMDs9vqmxtglxjT4/EGSU4chy+wI4kEwd5bcZWfYxPVw0h+/J2+MXf6UBMuL5oe
 LtEqmcTZwlaJTJnwi8R7BQxL2Iulfde5Hs6YHrTN7/inFtx3ZOK/hUsSlFQZ0U0tsngA6y6n9dS
 4yfyXasw7N4Y5eyasBtpPIcO1OZErtB2CkGqUt2nUvWJ5ELVGpTFAw2MoOnq5WfUI7g30btX0aR
 SOxY4AoKnlccq4e9wvzn6YKAO+4HJU+DkFv0h/D75xp1K9eSRsCsbhMGCzptpzMJbMhQ5iLV3Ds
 FirSV8=
X-Received: by 2002:a05:600c:a085:b0:485:4eaf:eb53 with SMTP id
 5b1f17b1804b1-48a986631afmr260612885e9.19.1777990465581; 
 Tue, 05 May 2026 07:14:25 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8eb3427fsm581408135e9.0.2026.05.05.07.14.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 07:14:24 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: neil.armstrong@linaro.org, sumit.garg@kernel.org, peng.fan@nxp.com, 
 jh80.chung@samsung.com, trini@konsulko.com, loic.poulain@oss.qualcomm.com, 
 u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
In-Reply-To: <20260416051151.2825532-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260416051151.2825532-1-varadarajan.narayanan@oss.qualcomm.com>
Subject: Re: [PATCH v2] mmc: msm_sdhci: Use max-frequency to get clock rate
Message-Id: <177799046436.839461.11492877346203001828.b4-ty@b4>
Date: Tue, 05 May 2026 16:14:24 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
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


On Thu, 16 Apr 2026 10:41:51 +0530, Varadarajan Narayanan wrote:
> msm_sdc_clk_init() uses clock-frequency to get the clock rate for SDC
> clocks. However, the DT files seem to use max-frequency for the same.
> Since msm_sdc_clk_init() doesn't find clock-frequency in the DT, it sets
> 201500000 as the clock rate and this results in timeout errors on IPQ
> platforms.
> 
> Additionally, clock-frequency is not DT bindings compliant. Hence, get
> clock rate using DT bindings compliant max-frequency.
> 
> [...]

Applied, thanks!

[1/1] mmc: msm_sdhci: Use max-frequency to get clock rate
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/9fa7744c43ea

Best regards,
-- 
// Casey (she/they)


