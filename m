Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390DBD2CDE6
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 23:12:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ABEF841C9;
	Fri,  5 Dec 2025 00:10:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Lkz25Utt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10ECD841B9; Fri,  5 Dec 2025 00:10:44 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98E3F84199
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 00:10:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7c6d3676455so765734a34.2
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 15:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764889839; x=1765494639; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a9qDpTL4+0Ac3GmxUPHwMxL5ZojbBoIxfmENdLYbSI4=;
 b=Lkz25UttcE8L5aF035U2yUg+eK6OjjbM161euWXmnaYv29hzBahW+BnjJ6LMx+DaZN
 FSFkVhm9bVKgqKKnMGIxsqPw5YZhdjuMrmCUPrFz5zGfJi8pwwY0vZGGMNoaj1URd4To
 MpbQNIOkaoY88NA9ZEpPx+nwdYMXXr5HlpTH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764889839; x=1765494639;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a9qDpTL4+0Ac3GmxUPHwMxL5ZojbBoIxfmENdLYbSI4=;
 b=WvoYOCdkYHeZA956guzhZLL7z20g5mlQVQELPq07QiFKh/0cKCK4aMdFz0VtIB5NVG
 SVQsd2lc/Aq4rr00vShU3hG1fXh7LDAKlGPmuJ3OSLp/5KHm8LwVtCFVJPWH9iCXy2Vz
 wpLulQVmzgO3oiCzGZ+xQUmNDZm07EqiexR4NPmQTCxmN5p7rDvke1O1Xbm+79VyqTed
 jejYfTtMHJDy1z3ewmW306ZY4DJZ8r2PjIFAHHvg4rHJpJAn7oXhHe6praVpzr9fH/S3
 TorYeIif/V61EKdvRECN0cBm6LWFMdLYfQ7sLAEzjl4DgNBmGG34lCP0kvnV6pdActK/
 F30A==
X-Gm-Message-State: AOJu0YzZC3hgKTTEX1HVZUlxGza5mRyCisVG9nZ+PoDaVF+OUokqmTLx
 GrkQ4qXWTlf2gWuu6El6jKhKDWFeXFT3i0+yCV5EVlpjcH22Z9fvuytVsSg0XQZFxwg=
X-Gm-Gg: ASbGnctft7ZOpckJnT7xfo+fnyxaJOBGlJADIQ+aU7U6sjEseTRENQVDkSmfYs6Iu2o
 ENEFpvLSOIFsEf/vwLT0ADA5Kwe2af+hSSB9nq6WrqawRrURfQ3bymjVlOCOJzv6DYkUc46SPkC
 2VuxqIRheCLLOvEP5Ado+6hlETRD4jhXC3UxnG/u2EiwMNG44aWnFvtKezEu84cK5hLTwLKJn54
 ixdwA5oYgc5yYeN5ilkjw0FoTCn/s+Ctx+4sQ0Gow35VyXpCqC55iW6O1N9EeoZpGpGI1xgSplW
 lvc5oMIiR9IKAixiDbJAHYUVJK2R+fd9cIRj9bKZ7mrgUeF5pNVKj0Dp0LedcdCIXGz+lQSsSww
 sc1ZD2/XbkzErT0jIxQklP5VPKRUbG0WhdsCjZi1S2hEflJ8flIjY9sCgQXuYtBq87CnzbBTdVm
 Cs8/2qhntQ9R6TiG/HprhjvNbG9+i376XaNzscgq2EQ7w1qFyb
X-Google-Smtp-Source: AGHT+IG0EQ5KzrpcO1xJlqXUKtI6cfhxu8LC2uZsHbRVN4M+vJHDJoRHPNiU2CLf+lVyR+FA4xdEBw==
X-Received: by 2002:a05:6830:6502:b0:7c5:3045:6c6f with SMTP id
 46e09a7af769-7c94dc04ca3mr7445094a34.20.1764889836339; 
 Thu, 04 Dec 2025 15:10:36 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95acfafeasm2360264a34.29.2025.12.04.15.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 15:10:35 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
In-Reply-To: <20251119145527.843268-1-trini@konsulko.com>
References: <20251119145527.843268-1-trini@konsulko.com>
Subject: Re: [PATCH] hikey960: Stop disabling device tree relocation
Message-Id: <176488983567.2091996.5338318033638129539.b4-ty@konsulko.com>
Date: Thu, 04 Dec 2025 17:10:35 -0600
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

On Wed, 19 Nov 2025 08:55:27 -0600, Tom Rini wrote:

> Remove setting of fdt_high to ~0, which disables device tree relocation,
> from the default environment. Doing so prevents U-Boot from correcting
> problems such as having an unaligned device tree and leads to various
> failure modes in the OS.
> 
> 

Applied to u-boot/next, thanks!

[1/1] hikey960: Stop disabling device tree relocation
      commit: dd3f5eac8c0e060751502813303b5736b4fc646e
-- 
Tom


