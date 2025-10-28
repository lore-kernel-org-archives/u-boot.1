Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5531CCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 16:57:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E22F83906;
	Tue, 28 Oct 2025 17:57:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JaVIJ+y4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 740F5836D1; Tue, 28 Oct 2025 17:57:34 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3301783700
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 17:57:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-475dae5d473so37076345e9.2
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 09:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761670652; x=1762275452; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mtP+duf8UUU9id5zFywHWCp3fXygWSbXcFade2wvet8=;
 b=JaVIJ+y4JR+w+5+ukqnrsXTT3r2/6Hp22h8H51ShlBV3WzSl2MlgwLCZWrBMXK3tO3
 x2BsMSusvVkqziB5b/FmWML8abDpNB12K6zk2jYXVUVkhMkNHRGPWAc1G2QGam9a3pFP
 yQ53/gK0mHgri6rm0QMIULaGlq/eiR48OnUpw7Lp3PFtXkqnJWJJPXqwr+u94HG0vP0d
 8X6N0zBnOdlnU8AoAsSV6aCUlR0p4MR70LoBsuqUXRf6NhIUr3kETyIi/XVuURg3coka
 Fd6q4vGe1va0QLC206n5+T9DEdS0FFHZWf4UW4KN/sMV1JoEwRiKs+b6SyyfPof9A6Sp
 H3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761670652; x=1762275452;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mtP+duf8UUU9id5zFywHWCp3fXygWSbXcFade2wvet8=;
 b=UIRMbhL3PXz9l+MKoCOg7NFWrkIqQLCBOkK+SGsIT8H2Rh8Y7PGLF+GOIPAKjEWna1
 gel5rG0HbmcCHAGVRrwSsZb8GJy9T3I/mfEQxdas2tsJMT2dFtqAct2U2jidF0kH1R3C
 uXmB5yJ8EjY6K0baeQ43rAcuRShcHvm6xiuLj/0DhbMC3YmqLkj7zgZM41zzD/Kmv7sq
 CmlLZgqyoKz48M3pPFJltAjaWhbhcFy542mT3iARPysiNIMwWk2PIqa99mOWPrwdN6F4
 FRwSBpdhxYhLg/0jrbzOe9mFHzrjc7txE3YzKKtWaOAbKSjbaCidHpl600hWbWkJ2tCG
 za0Q==
X-Gm-Message-State: AOJu0YyFuHATELFJqC381OwmFffzopajT27TJ6/9vtj76yi/3TfSiVSn
 4V5AJm5uCEl+zzrrVwc7Nn8yz2hyejEuoo+D8luUZ/iRH2iLQ/z+ixoHk/8TzVdkOfrGdEAyd59
 qbl28Xb0=
X-Gm-Gg: ASbGnctnynUHFYB0RtdGU93T7qn0JYXNsdU1cLTxFVT762jPwqWQaIo7/ed3PIq48KB
 0Vp+wSQNWrbx6HVKIukNuMH/lnH4BJCy1AaX2Bp/jZ2xfg5sn6AQE6ENvsZyhEZJrGAo0yrYXHQ
 rkWSFP/adsZ4zSnkwYNtrTAT8eaVZrcSWQyvwSPspGfJHlmLJudzrvVeo5tqQ1Mv62d1lB3Q1Qt
 47gg6P/AqeJpaLxbZkYgfevnnpKjkk8ncPvuslP0n7jG9v9odMKMLaI6scry3zCE5/uc1if0KJM
 yUxNdHiGbFx1Z49EBG8jMvVPuTFjhTlmRHVLj7t4pOpF3tl7Nvn7QD/4ETECBdraL+4j6HjTou9
 +NWydCCYNrhCHGOVBzjo0nMBEgzpyDb6dv8jHR/eBbBhLfEBnPijkOuncIX9ut7y9MYpFZZMcMu
 o9iElF+FI2SfatY2Vi3rTm
X-Google-Smtp-Source: AGHT+IGAkG5sgCq7wUB/gYHH6+4E4rmJXneNtx5iNBQnwfgZk6nnD064e5JDurGl7i/gb6fwnBlI9w==
X-Received: by 2002:a05:600c:6286:b0:477:c1c:f645 with SMTP id
 5b1f17b1804b1-4771e34aa7dmr832535e9.11.1761670651632; 
 Tue, 28 Oct 2025 09:57:31 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e222ca5sm1971495e9.15.2025.10.28.09.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 09:57:31 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Anshul Dalal <anshuld@ti.com>, Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20251007-ufs_ti-v2-1-501f575b6947@linaro.org>
References: <20251007-ufs_ti-v2-1-501f575b6947@linaro.org>
Subject: Re: [PATCH v2] ufs: ti-j721e: Correct error detection
Message-Id: <176167065109.4104072.517909320047244448.b4-ty@linaro.org>
Date: Tue, 28 Oct 2025 17:57:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 07 Oct 2025 12:42:12 +0100, Andrew Goodbody wrote:
> In ti_j721e_ufs_probe there is a call to clk_get_rate but the code after
> that attempts to detect an error from that call incorrectly uses
> IS_ERR_VALUE.  Instead the test should just be for regular error codes.
> The call returns an unsigned long so that needs to be cast to a signed type
> first of all.
> 
> This issue was found by Smatch.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-ufs (master)

[1/1] ufs: ti-j721e: Correct error detection
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/6defecd943e92e4341cfa088ef4f4cc19ff2db8b

-- 
Neil

