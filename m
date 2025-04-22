Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37967C369D1
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 17:29:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C397281E72;
	Tue, 22 Apr 2025 19:29:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RsS29yMN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCF98806FC; Tue, 22 Apr 2025 14:53:02 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73364803CC
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 14:53:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43edecbfb46so38119825e9.0
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 05:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745326380; x=1745931180; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Mtj8CcbOsJzorOkOas6bh2/mITg+imcCbFgwZbL3bmo=;
 b=RsS29yMNhVBJd4BQKJ/owHSP/I1WI9cbaVzwBrrNA5epJAwiE4hCy+h86EMcfrJGNg
 ArSvFqNTYfIgbbrLtUOew1qFv6hv2Wi+KXhLKIgxzM9WnJjsvxNtyqGWBiD7Phzv3xSm
 VAFCDJanxv6aRgy2p63Ly2DFoUNsMLncm9W7qS6wVAdF79mWZXtET750O3/xV5/Vxd6K
 LpzDLT780ECSNgmFf4zkRsUqIqNdzj4rgb/MBOnAb1N2Dii7Y8nfNex+66ExLXSKkAh/
 NKqONJT2yOt/EZQQHPuCn68ubaYls/jJabH2yYv31vha4iH6qTI9b1mzdJpsaRkX3pfL
 4FIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745326380; x=1745931180;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mtj8CcbOsJzorOkOas6bh2/mITg+imcCbFgwZbL3bmo=;
 b=NMCwt/llKlF7VjEH4ARWahrq1+2j+iTwUhtGqnBLiuXzYuv2akAfu/YXabze6vE1dd
 8cSdhSu8gwc63CKKi3koHQl9eRCbLoRw2yFGmRuZyO1zY8GbFx7r65smlxRWdvfDJqcF
 CKJxVfuy3uLJqg/pH6l5h0vWAUpBNAFkgDF2hC9CO9AL4EnBhPeHi/B7q3fS26lnUKZ0
 7XMEcvwAE0RxCSdJbGp1pRItt4+/QplgKM++5GBvsgWQCixIsx56m+eB8EmNBL/7WMp2
 LHPhRECYCi+GIlX9+CHNYtSu1s0urcYXz1+TnXFRaORGdMiWoAIpcQgbPBKY03xXQcTh
 Pj+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpiNL/1IPfGqw4lJ7GYW7LWa3RDN2usQItCMgcjhyu5Q3QwsSApubjJwcPwj+mlD8uiai77xE=@lists.denx.de
X-Gm-Message-State: AOJu0YxTYpIB8RXeAkEzFx24hKlY2mXM+sX2VLPhh8Bn8aooddX5J+z8
 kWCfv+WHnvtZHbHwbdlZ0U0CpCzklte/7AhyP5sACf00fOC170AUHQWJLnhsXHI=
X-Gm-Gg: ASbGnctUciXUdpMZ5Dv/TgYHn4JWUG3QtutpjfyYkZ22DWfVSDuWPtytM3WETJIPxh3
 sXZDoyv6q14qI1Ndx5Wsk/zXbHOAsYzIE6jgb/NHxJ8RDYr0/f53jmSJZ/0iwWwi/ZqKoG2a6Eq
 Ja7AKU9yiNokJq2BqP7gNcRtWaWAwr2SvtCZJ5SDTKBV4z8/yJzBcpfCtSkxHArpksrjvpD9ZfS
 BwP/5s1Z9QDGMZkuJ2YsG7flytdpQ07uKP86sR8E2BN0ZSmN3IYbx6id82SIqZFnI9AaYQJxkmU
 z3kJ0+1uliZ/FQa5bWf5786YzfVOA7nzTD80zYpNhFj92k6LHxp6MU5Ea0fbMDFO3Z/lmB0=
X-Google-Smtp-Source: AGHT+IGScsS35TiA9PLshrui52DutJE9Xp2qAiUTgnb9GjIfuB8gmh5C4mykqErcVj9nx/zjUb9/pw==
X-Received: by 2002:a05:600c:1ca8:b0:440:6a79:6df0 with SMTP id
 5b1f17b1804b1-4406abf94afmr93582895e9.22.1745326379885; 
 Tue, 22 Apr 2025 05:52:59 -0700 (PDT)
Received: from [192.168.1.47] (i5E863A78.versanet.de. [94.134.58.120])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5a9e1bsm180179425e9.8.2025.04.22.05.52.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 05:52:59 -0700 (PDT)
Message-ID: <0dea9195-0a48-4eec-8a22-640dc9f900b8@linaro.org>
Date: Tue, 22 Apr 2025 14:52:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] watchdog: qcom: introduce qcom-wdt driver
To: Paul Sajna <hello@paulsajna.com>, u-boot@lists.denx.de,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Stefan Roese <sr@denx.de>
Cc: u-boot-qcom@groups.io, Sam Day <me@samcday.com>
References: <20250421-b4-qcom-wdt-v2-0-b2250efa0f39@paulsajna.com>
 <hyAGyOfR_pMcdHIMj2CuW1rBYK5oe64oHYWsaLjYKeDjWB8_2btUC6pnRQLedixSVaHAWoGTvSV1JWrMdgIloYex0C4KjZq_4nX_sbvrrtc=@paulsajna.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <hyAGyOfR_pMcdHIMj2CuW1rBYK5oe64oHYWsaLjYKeDjWB8_2btUC6pnRQLedixSVaHAWoGTvSV1JWrMdgIloYex0C4KjZq_4nX_sbvrrtc=@paulsajna.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 22 Apr 2025 19:29:01 +0200
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

Hi Paul,

On 4/22/25 01:29, Paul Sajna wrote:
> Sidenote: I needed to update the devicetree for judyln to use usb high-speed instead of super-speed with recent changes, I noticed while testing this. Otherwise it crashed. I'd like to submit that separately, but I'm not sure what's best.
> 
> The options I see are:
> 1. copy my wip device tree from sdm845-mainline to the upstream folder
> 2. copy my wip device tree from sdm845-mainline to a u-boot-specific devicetree
> 3. only change the usb in the upstream folder
> 4. only change the usb and make a new u-boot-specific-devicetree
> 
> Please let me know what would be the best way to proceed with this.

I think 
https://lore.kernel.org/u-boot/20250411-livetree-fixup-v2-0-1236823377bb@linaro.org 
might fix this, I'm hoping to pick that up soon.

Could you explain the issues in more detail and what version of U-Boot 
you're running? The of_fixup code in mach-snapdragon should do this 
automatically (exactly so that we don't need to maintain DT overlays or 
forks).

Kind regards,>
> Thanks,
> Paul Sajna
> 
> On Monday, April 21st, 2025 at 11:20 PM, Paul Sajna <hello@paulsajna.com> wrote:
> 
>>
>>
>> This patch introduces a simple watchdog driver for Qualcomm devices.
>>
>> Some devices, including one I have been spending a lot of time with,
>> the LG G7 ThinQ (codename judyln, arch sdm845) will reset within 30
>> seconds if the watchdog is not serviced.
>>
>> I have tested this patch from Casey Connolly that is over a year old and has
>> not yet been upstreamed, and it is very useful to me. I can hardly use
>> u-boot on this device without it. I have received Casey's permission to
>> work on upstreaming this patch.
>>
>> This is my first contribution to U-Boot, and I am unfamiliar with
>> mailing list workflows, so please be patient :)
>>
>> Signed-off-by: Paul Sajna hello@paulsajna.com
>>
>> ---
>> Changes in v2:
>> - Add watchdog start
>> - Add watchdog reset
>> - Remove stop from the probe function
>> - Use dev_err instead of printf
>> - Update Casey's name
>> - Add myself as an author
>> -
>> - Link to v1: https://lore.kernel.org/r/20250413-b4-qcom-wdt-v1-1-db42cb93dff8@paulsajna.com
>>
>> ---
>> Casey Connolly (1):
>> watchdog: qcom: introduce qcom-wdt driver
>>
>> Paul Sajna (1):
>> watchdog: qcom: improve driver with more functionality
>>
>> configs/qcom_defconfig | 2 +
>> drivers/watchdog/Kconfig | 7 +++
>> drivers/watchdog/Makefile | 1 +
>> drivers/watchdog/qcom-wdt.c | 118 ++++++++++++++++++++++++++++++++++++++++++++
>> 4 files changed, 128 insertions(+)
>> ---
>> base-commit: 0eebdd17888005751cd77cf3794c5292d36f481a
>> change-id: 20250413-b4-qcom-wdt-e7b913fc375e
>>
>> Best regards,
>> --
>> Paul Sajna hello@paulsajna.com
-- 
Casey (she/they)

