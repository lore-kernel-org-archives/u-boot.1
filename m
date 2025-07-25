Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF48C87FCE
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 11:10:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10DAA838E7;
	Fri, 25 Jul 2025 13:10:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yywda+td";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 466B58393E; Fri, 25 Jul 2025 13:10:02 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C481683693
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 13:09:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4555f89b236so17673815e9.1
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 04:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753441799; x=1754046599; darn=lists.denx.de;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xScjhapC4gH2f0AEcTP5tL7JlTYaUDWlR+3pQ9ESRSw=;
 b=yywda+tdEzTIa78axk8doz1PU/Qg89539+xwY1gXjAqC0QEqAT+K2mVsV6Bdsd7EFV
 GFRlNJLahylZvrOpo/clY0KjM8oPxq+OPoNc3Aljr/fItIXHz0Th3ASTwFgWq8/t1DWs
 mDWHTzUe80zeXsSRamHwgxIuTHjHQ1jPJyByOviuJcvY0kACFClnpHGCa0yLbv7ruv08
 oU8JrdG9I2QzuHeMkh/+Wj/ItmsnOqlBzwxCGTNRYmXvJXZPGxfT2jgzcJ8BP/+bKzxv
 CzaSsvmBJpWG9Fn0zOR9i1KRh//Sh/fd2CjIIfLtJETVV0F66U4vdBMVTFx6bLkV+c1j
 zmwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753441799; x=1754046599;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xScjhapC4gH2f0AEcTP5tL7JlTYaUDWlR+3pQ9ESRSw=;
 b=Ti0kKqj35LhJE49M13bd+h3KrhWxZCcR0eW/8IIn9PpcVDffvbouzv+QZPqlXR3sA3
 11HWm8QP+0qi5HvCzHxYEZ3emGIbVwHftZoaGRSXPWzpqXGEt1VfgRptYwXmDXQ49dVv
 yjt4wGuuHC/u7gNQZbC+z8cfKs3V5aZIC5ju4V3V+O8w/hwfKGNYrpRcoAt9IspDzBbq
 U/D2XO3Pug0JYVd7EFS5pkIroJ4VhMI09/sqyFj2NjOTfyYsIURIunSO5t6lvFbtWPTb
 Sao1JIvoRW8d5ABpq30WuuDOSZtotYig7vtWR3AcnlZcnpJQqa+4EWVHmdgAT6YTGKpq
 bQng==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRlOysfWoS2F5UfOe9PT/6zIcvDCQJjlLlxmVGy+cfrjiyrNLxLkqtzVr3iwBgZxKiuUcbPhg=@lists.denx.de
X-Gm-Message-State: AOJu0YwR457+db/Kjw9yOPJ1GKq5Vuy34OvSjfu+yURcIjPw8KHIvUqu
 wu42gp/brFhu8oQna9p28RU91OKGUm7wojSkE6gEvSGS/sCFq2vjlkRxqDeH4KCUYtc=
X-Gm-Gg: ASbGncvHkLDH7l5o7Dxk9o0zApUdkagp/1CIB//ZpoH/BTJIJHvvlxrvhh7TPav7LRo
 Z2pvg0l0dXnp7apQv6Uwyc/cd5wstPU4+YELNRdq/K6HdFcRj4MepAHwli2rc+/gzu/bJV91R1h
 /VKasRqH50gSmnE57KNjjF7cKDJPb2PsteTJVznkgYb7BlWreip862H1zkberUtucIsN3IJbhpa
 pxbRu0sXLCwT7/TvibrWaPjkvAKYmN8HIWl/LTaicRoxZdshB+6P78TPqdVGdTHe1lXn+kpAGn9
 VSDTpXm91OXIeNBHmk4RaW98aXTkMXLRrzobdBuM/9wTeTVUYfadmwJpU4uNcqMUVmnzj//gy0R
 VTvy5kT6epUXzFOZx9/uzyIcj4is2bzMRttBXxNQewXBtmv5su4LUctRq5ju3jBiLH2xyklqdOk
 4=
X-Google-Smtp-Source: AGHT+IHyNm/aetSIHkjFH1JoXVv0R4Eihsy0MdWkhmaE1hTzX1fcl/bIb3FmDxwzqsCdYqEGfRboLA==
X-Received: by 2002:a05:6000:40da:b0:3b5:f7a3:3960 with SMTP id
 ffacd0b85a97d-3b7767765aemr1224311f8f.33.1753441799047; 
 Fri, 25 Jul 2025 04:09:59 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:707a:1ff:4c94:1748?
 ([2a0a:ef40:f9e:3c01:707a:1ff:4c94:1748])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458705c4fcfsm50128765e9.29.2025.07.25.04.09.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 04:09:58 -0700 (PDT)
Message-ID: <31ac4742-d516-4b5e-8f7d-6f8d23b77119@linaro.org>
Date: Fri, 25 Jul 2025 12:09:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: "Simek, Michal" <michal.simek@amd.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: Smatch report for drivers/fpga/socfpga_gen5.c
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Smatch reports this issue

drivers/fpga/socfpga_gen5.c:135 fpgamgr_program_poll_cd() warn: 
duplicate check 'reg & mask' (previous on line 129)

Looking at the code I am not sure that it will work as intended. There 
are two if statements within the for loop that test for opposite 
conditions so could easily be combined into if..else with a single test. 
But also both if statements result in the for loop being exited, and one 
of them must be satisfied so the for loop can only ever be executed 
once. This surely must not be the intention. It is not clear to me 
whether the error test is wrong and should be changed to a different 
test or it should simply be removed. Could you take a look please?

Thanks,
Andrew
