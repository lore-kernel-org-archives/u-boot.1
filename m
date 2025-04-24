Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E997C369C2
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 12:40:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBE9881F7E;
	Thu, 24 Apr 2025 14:40:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cxkV0AIa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1FBD8082A; Thu, 24 Apr 2025 14:04:05 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D6D680194
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 14:04:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso6348325e9.3
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 05:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745496243; x=1746101043; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JpNjZU5EjlClzaenQgcUpe5m9+Oy/4IWgWZLNIfJGXE=;
 b=cxkV0AIaLXjT+ls/xqCGn+GjNCfzh0/6gK3TIQwk7NlZQFwdZzvGdtVdmeYZZkUUoI
 bBFtt5rl0m8SdqSoa3X14aI1l8vmf7bWIi7S1QUtp0Wi9zh+qC1rYojVnzXgeGbAg27I
 QF9wOM55as1N4oZXSnTC5nVU5DmBffqZLHm8rQNUjqNtWmdd/pIyMyV/ZzmKECDN4Aga
 UttcTZymus6EOr2zXB219++EIotMqPpAHikOhKeA0aPCXLBRLqIfiZ5vPj8j+JhrP8al
 dRKWnnloHncYGWcYWaob5HRtMWubG0gGyclDSI9GcZNfhDWpuRHNLyIN1ffd+5o+U5vj
 Dfwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745496243; x=1746101043;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JpNjZU5EjlClzaenQgcUpe5m9+Oy/4IWgWZLNIfJGXE=;
 b=KoJcyC003T5mZ+cTxHvy+73tU+1kq8bGPYDA112UG79fBxJfM/8UZkEGV+1zjC4Wej
 FvwGfcxvTRXVfe3m+RmhDVJjLpZvAvpEpc3D64prYe0kEcwf+dweA3VI3pADHyRn+xL2
 WIjdJAJ9BLiWFLXIUAs18wC2wGLJ9iDM7knhI3yoDQ16iZJM7bvbO5n9WNRSG46iFbBq
 r+gdLMfyG+GUmGOHeKr00PXTN9z1Sv2ZkFaVHHtwZy0RjOfUZM6JG0TNpFgDRKtbS0sB
 LRYIV7po7Q9aRlvAf3PtFHGCeIhB5oDme1mLVTToIUsg8ulIUZIYtwRH1oc2mZWLzKk/
 MFbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMt0CvyCE/HRp5+c8kCVcaWmAK1D7quJX9XtPVIdssWrM+gWCycKLn5gqsA+0o5kSxVqc7i/k=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1ZHnHenIVJ7kn0c61eWX1MQ0z2PScjB42cESr9GQ7xFsTNpvH
 qJZZGqMXTQSsBefpl4Z3e/wspqsbmBYLRmLZwytN0u4zOj9BsCUq08ElQnMckTU=
X-Gm-Gg: ASbGnctV0iwkV1ixt/R223kU+m1pOwakjUT+au7KWDisjX2bvgoRLvb2GODmVUY26of
 OKyXdFSA2RcQAUd6nNFPI3/ZWvTeWid+jHXPhgllJQEsS5vyU/I3vKgFKB0nHdC/u4NJ7MiDzxF
 dxfCBe2WzlzlmGGSXn2PtC6jOE34BMX7dkju5PYGv5I+KqGGTh+PY4kPqvUfYPwlu5w8NQQGX2B
 ORfASgG/VsWRbgKdsiUrTtHAq/vcPzQEh5DOLZkHvGzvJ4D/JULgI0qO7kBdJv5fPdae5p8l5XM
 Q8NqucGdwOGuccpXSeKydukEVghm1jf9229soG3lkVqvGgj0i726rjRHQApN/8KpnfE21tU=
X-Google-Smtp-Source: AGHT+IFhHbcINP1CmKd3T1Ac2WT4A7rHbN9EX180aISu9l6GbqiP8ZadhNb7wR/xBHA1EOGUbzOvbw==
X-Received: by 2002:a05:600c:4ec8:b0:43d:a90:9f1 with SMTP id
 5b1f17b1804b1-4409bd051e3mr19528145e9.6.1745496242683; 
 Thu, 24 Apr 2025 05:04:02 -0700 (PDT)
Received: from [192.168.1.47] (i5E863A78.versanet.de. [94.134.58.120])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2c3b0asm18763175e9.40.2025.04.24.05.04.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 05:04:01 -0700 (PDT)
Message-ID: <8b0ceef0-8e3c-4f77-9568-a72dcafea5a4@linaro.org>
Date: Thu, 24 Apr 2025 14:04:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] clk: qcom: apq8016: Clock fixes for U-Boot v2025.07
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Sam Day <me@samcday.com>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250424-apq8016-clock-fixes2-v2-0-fcc371c9e45f@linaro.org>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250424-apq8016-clock-fixes2-v2-0-fcc371c9e45f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 24 Apr 2025 14:40:20 +0200
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



On 4/24/25 11:16, Stephan Gerhold wrote:
> Fix some issues in the clock-apq8016 driver that I noticed while testing
> U-Boot v2025.07-rc on the DragonBoard 410c. Make it possible to poll the
> clock status with GATE_CLK() to avoid potential race conditions.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

Thanks!> ---
> Changes in v2:
> - Rename BRANCH_CLK() -> GATE_CLK_POLLED() and clarify with comment (Casey)
> - Add R-b tags from Neil (I assumed the rename is minor enough to keep them)
> - Link to v1: https://lore.kernel.org/r/20250422-apq8016-clock-fixes2-v1-0-bfc9dd933da6@linaro.org
> 
> ---
> Stephan Gerhold (6):
>        clk: qcom: apq8016: Fix SDCC clock addresses
>        clk: qcom: Move qcom_gate_clk_en() to C file
>        clk: qcom: Use setbits_le32() for qcom_gate_clk_en()
>        clk: qcom: Allow polling for clock status in qcom_gate_clk_en()
>        clk: qcom: apq8016: Convert GATE_CLK() to GATE_CLK_POLLED()
>        clk: qcom: apq8016: Fix SDCC clock warnings
> 
>   drivers/clk/qcom/clock-apq8016.c | 17 ++++++++---------
>   drivers/clk/qcom/clock-qcom.c    | 27 +++++++++++++++++++++++++++
>   drivers/clk/qcom/clock-qcom.h    | 26 ++++++++++----------------
>   3 files changed, 45 insertions(+), 25 deletions(-)
> ---
> base-commit: 233fda6af674736dbc6ff37a9ef003b9fa4b8074
> change-id: 20250419-apq8016-clock-fixes2-66ace5b26ab4
> 
> Best regards,

-- 
Casey (she/they)

