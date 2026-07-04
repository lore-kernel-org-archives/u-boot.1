Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377F3C43458
	for <u-boot@archiver.kernel.org>; Sat,  4 Jul 2026 14:35:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 908FA83FEE;
	Sat,  4 Jul 2026 16:35:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yk8MelQB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DEB48341A; Sat,  4 Jul 2026 16:35:07 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8510F846F8
 for <u-boot@lists.denx.de>; Sat,  4 Jul 2026 16:35:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-493c733f15aso14729415e9.0
 for <u-boot@lists.denx.de>; Sat, 04 Jul 2026 07:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783175702; x=1783780502; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JlYbksk89+YGWTqppj9ijMTYClwOqIhwgOcQaR36jQI=;
 b=yk8MelQBs6SaFb0L46eMSq2QUBTfzGZy1/NCPGCNL0FiEJstMrOZH86gAjQOt6HcYM
 aCaL3ScuwPBNCWlIy7F1w2zyGIzPcC7uDb6hCycDHpoIQL1HWTizZXSS+6vj68FSJegC
 cDSD1IuyC+AUmiKvOhdhiHgR8walixck15CURLW6OXlEk/rlhC4DtjwpViVde/eB4uSf
 mHN2JSsQqSSbZCkWRD9t9BLImaI8S/Vx8qL+VnkKvzXnsij+1ZKPp5fGCPGsMi4UljvT
 DeWNFUPoQOCeHIMcC8VR/7LaGGsXAI7T9eRP4E4Mi0UZsFW1/O3WTbeveYGG9G1wcgYK
 fWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783175702; x=1783780502;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JlYbksk89+YGWTqppj9ijMTYClwOqIhwgOcQaR36jQI=;
 b=gT28P9oMB7gRo1VIr9q9Zp5GyQEZVa/Jtr8EhgdeGGX3SbbrToqhSwPeNiH1cpSpG7
 Swg0pTb9fPLLwq09kyVRDBJsPuFkxkNHUlnopVODBbtWvXewViKnvsAsd+VnTwLBUqBi
 i62tML4QB7hHXw5pCWbpfOhvj7/HMmATmX133Z9Dds0ZNQBhWaKgKYVHckr39XlznBQP
 mOD0HTsksxcMcN71JpQojO2QJ1s7sXJa9lcFiXVJdovxzzzlUzZECtfW2oTcGhSNtAtV
 +9UECpUsaR/oAT/s0X4Elxdw12kSJcIRbha42LTC5C66SP2s+pZuCX6fqkv+nnm5bldH
 3Jyw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ztn82VgOurRIwKDZ5qqtE+3cUG+KwtQY4z3GLwk4NTOmX24u16yWg/6YL9pX3jig05jDBvAw=@lists.denx.de
X-Gm-Message-State: AOJu0Yy3beNvJVSpoWpzDE4S+9Nj1hJ7gziNqAfhE53zPy3yqfgaJT2R
 hPYZKYQkXpXikZfekIH2QQKwPkREkdCTwi6wS2VEwAi1AyzO5yt2yn/pioD7sdjXhrA=
X-Gm-Gg: AfdE7cmJLq/O/DPKaCy6/PLEZmVwIAaZnGRXF6lvGAvEaM2QksSheZZwobVxUmwhgVV
 b21X+V6q7fv7yKFIFq2QUeGOVEVU07IK2WgYdbhIqVG3jYh9QCt6s004CwjHztSyLiifPea9w2j
 MKRtwIRP+kzgEwHGXrZ/9u5DoyktHRasC/SJ1ZNeHpRXPAXVuJ/IpoBaU3XmhJdGAjIxT4CwahY
 9TlBehbSa8q/RXZbaN1E54akfTL9KQ6JZeAggNO09Ri6IyoZ+EyZNgOIdps/tk5sgDHQCkTT6NY
 Y3urW6hbMCzgoGtnhnVOudrhwxuKthK1lDaJcCo3S/UFmFeAHxwM83Eb4YJQVpQMluwLtqHWpTT
 6OeWhf+/5E3Su2qYZL7+7IUpyelJl79xFLZ57ZNTDi39qwlItuZd8D1euzNHJCqfaEpLUB8tU51
 PBcvLtRscVdtx6i9uZUbeKdekWRjBN2UHNVlSAsoIOdpURzut9zwEO
X-Received: by 2002:a05:600c:5309:b0:493:c0c1:3930 with SMTP id
 5b1f17b1804b1-493d11cef15mr42976845e9.1.1783175701622; 
 Sat, 04 Jul 2026 07:35:01 -0700 (PDT)
Received: from [192.168.1.36] (p5b29e120.dip0.t-ipconnect.de. [91.41.225.32])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ccdab27dsm125880025e9.4.2026.07.04.07.34.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jul 2026 07:34:58 -0700 (PDT)
Message-ID: <7273c6f7-0108-4ed2-a79f-855073609362@linaro.org>
Date: Sat, 4 Jul 2026 16:34:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] qcom: Enable CONFIG_SKIP_EARLY_DM for Faster Boot
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 varadarajan.narayanan@oss.qualcomm.com, luca.weiss@fairphone.com,
 andrew.goodbody@linaro.org, swboyd@chromium.org, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20260704053452.761684-1-aswin.murugan@oss.qualcomm.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260704053452.761684-1-aswin.murugan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Aswin,

On 04/07/2026 07:34, Aswin Murugan wrote:
> Enable CONFIG_SKIP_EARLY_DM on Qualcomm platforms to improve
> boot time by approximately 50%. Address a serial driver
> crash seen with CONFIG_SKIP_EARLY_DM enabled by properly
> handling error pointers returned from clock operations
> during early boot.

Thanks, I've been meaning to enable this for a while now.

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> 
> Aswin Murugan (2):
>   configs: qcom_defconfig: Enable CONFIG_SKIP_EARLY_DM
>   serial: msm_geni: Fix clock enable on error pointer
> 
>  configs/qcom_defconfig           | 1 +
>  drivers/serial/serial_msm_geni.c | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 

-- 
// Casey (she/her)

