Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37EF5D2FFFD
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 12:33:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76DB38916E;
	Fri, 18 Oct 2024 14:32:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GJTBix7G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E0FC89241; Fri, 18 Oct 2024 11:55:20 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2019B89215
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 11:55:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43055b43604so20135915e9.3
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 02:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729245317; x=1729850117; darn=lists.denx.de;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8WgsBQTo+Bdgu1eIFOd8b0KLpQMJ7vYtvZjTI2EOl7U=;
 b=GJTBix7GQlI8v51t8FKP36UsrS4TaLawMls7q12QSMk/tLfAbqRMVKAkLSPNUfPtY2
 REKmyhSxOJ8y1Yf8QM9bbVPDfFx8amINJxgVo7rKCm76FLfBtp23G6Jw1O/1H1HrfBMp
 st3ctWQtWvKX4ZxNHYz69lQ007Gddnukvsm6vsVAkjwy0XIt/vdhXlke2rD5FdEDEdFr
 X/L+JBXOSud9foP6NKahLj9kDbvw/b3slDH8eMdLsSe0I/zJekPulGv6HmHhqlPNfJww
 nQLxEXAvYYPz2JLNCWTKIvE2UhXg7BHcvV02D+SPZ2vz+SXefGUw1TAwPRPYuHwt1J67
 u/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729245317; x=1729850117;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8WgsBQTo+Bdgu1eIFOd8b0KLpQMJ7vYtvZjTI2EOl7U=;
 b=Uw25Tfne4PMIR80z5XGLL4Lgl1Ls5nYJGR3GcZPJb3185XqCkEBXdoNU4yKgVAKDi0
 uoJVbYK4zgaz+NpHn2OVLqYl++qPrd+FlkpnWMiOpJ7dv/bAGcAswBadOQsjCJYZ6psZ
 U0RpxoB2s6GmLqy+9/AxNGSyRHvP6B8NTtmcCZibyfCmQJ03fIOczoIofejhcnqF+5AV
 cZ68VorGND9PguG7+VPkwrbbOvOiQayzyCMYYnCw/msZE9IgwEnbLMUZDE8He2YKx621
 9VMdRqP6EcXgHkwodpNPACl9nDMJPfWzw21R3qJ8TBvuWpVH52ojf9gaGIO5ioLWchFc
 nC9A==
X-Gm-Message-State: AOJu0YwSQzD+XtD9LgnsbV0VBATtbSh6TPIMrIuYmTzhdtqrI6CuP+a5
 6lJcST4W4gnBdT7gU5ntn4I37FU7CyeULSWIMiRF3WdIRwb/E5O/hkQgGgRWuoI=
X-Google-Smtp-Source: AGHT+IG0CSwI6CO+h3wzTZP/yttpa/m4YYZ+LtQaZlzvp6XIJegYdFhalXKNpINrfK5/TXJTo+SD8A==
X-Received: by 2002:a05:600c:1e28:b0:42c:b750:1a1e with SMTP id
 5b1f17b1804b1-431615991f4mr14275135e9.0.1729245317353; 
 Fri, 18 Oct 2024 02:55:17 -0700 (PDT)
Received: from [192.168.0.140] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ecf0ed791sm1479948f8f.77.2024.10.18.02.55.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Oct 2024 02:55:16 -0700 (PDT)
Message-ID: <4cfd93f1-84c4-445d-82e3-73ade26afd4c@linaro.org>
Date: Fri, 18 Oct 2024 12:55:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
From: Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PULL] u-boot-at91-fixes-2025.01-a
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 18 Oct 2024 14:32:49 +0200
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


Hello Tom,

Please pull tag u-boot-at91-fixes-2025.01-a , the first set of fixes for 
the 2025.01 cycle.
This small set includes the maintainer e-mail update and a missing 
header that was causing some build issues.

Thanks,
Eugen


The following changes since commit d2061828a4c1b60b44cd2307b6a782ac2efbffbe:

   dts: Deduplicate dtbs target (2024-10-14 19:32:04 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-at91.git 
tags/u-boot-at91-fixes-2025.01-a

for you to fetch changes up to 684939089a31b8a5bedbbb4c2f2bcf935da7d9c6:

   ARM: at91: clock: Add missing include of asm/io.h (2024-10-18 
10:10:41 +0300)

----------------------------------------------------------------
First set of u-boot-at91 fixes for the 2025.01 cycle

----------------------------------------------------------------
Alexander Dahl (1):
       ARM: at91: clock: Add missing include of asm/io.h

Eugen Hristev (1):
       .mailmap: update e-mail address for Eugen Hristev

  .mailmap                              | 3 ++-
  arch/arm/mach-at91/include/mach/clk.h | 1 +
  doc/git-mailrc                        | 2 +-
  3 files changed, 4 insertions(+), 2 deletions(-)
