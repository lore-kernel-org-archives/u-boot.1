Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF60CF887B
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 16:31:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B3098409E;
	Thu, 20 Nov 2025 17:31:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dRFPwI/W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0063840AE; Thu, 20 Nov 2025 17:31:35 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6762E84088
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 17:31:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47795f6f5c0so7779875e9.1
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 08:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763656293; x=1764261093; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tt2o1W7CZTXGgmt+9B6vzLa+1rtlNokv/0+sad3gNDg=;
 b=dRFPwI/W/Sbsw9Oh6iB130g6zQ5ekbGdHeS+Ql5rWHUlJE7hb7LkHrfRvYV+Pl97Yr
 jLeUCC3HZdeyv2tIseBwqbuqcGYCLsOuAUlPBhGUpPQxz6+TePQtm25z28i6nEUJuRZ1
 JW+PoAovPLqi0B/WXYk0kSAKMOVTJAqiLPRYxkAr2Ow7CEfsW+6UHhL42P5YddKXBCQG
 uxmV6xRTCTopyrVna5Viq4c09ukgrpxRXd0gquKWwIx9ofzrFwCS7gshPYDiZW7HW37s
 ZhbcQTmjaaWcP36NVckoHplfqlyEc7Z+6/AR2wE0MSzPcDhPV4odQ0AYUrr76s5/xfo1
 +OlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763656293; x=1764261093;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tt2o1W7CZTXGgmt+9B6vzLa+1rtlNokv/0+sad3gNDg=;
 b=JB6qd1OLQri58e5axkS1xTArsQppkMixWhO7U5sd1Ew8hxP2wurCZ1p7StZHxjlDi8
 uGlXDxCTN0vFJc4mW8x0p3tmbByzQn9cU7uaw67wHSViNmZpN4IAHwOV1S7BVR1WV+zg
 lGGwjxXtKX3sWUUbZFHnJKrNEWQFY707HuMm8DLWbfAIG/TCNngnkYQOwELftE9gSIzA
 qjiUI6L+O16Hnwtl0BKnIXoZHvhZ8hcIBYn/HZGxniW/JFYK5JJ+i/1TcGF7iQ/B/0cP
 fLG90cVgGUH9aMXWa16DyC/u4clajymZe1nxoiCkZ+exeEi+XuqwKjR1ulo6l2po8P78
 a1zg==
X-Gm-Message-State: AOJu0YyJPee+AYSv8dawa37RttH48xz+87zm+YjOLF3GNkuiGZ7bpPhd
 qKTn9wLW4XaX/R/t7ShjYv+0DBCaAqaktzLH4iEfdEaYAMIq0YZ7wwj0PtNv0p8shK2h9OwiQVp
 6llZ6
X-Gm-Gg: ASbGncvBb1sbgt/knNZ7ciPb3EdpINx7njzJciJ5/bhKPw+k+qfwDpsSq0jxEbbrnL2
 Gc+Jv4Q7Lyausm2HfG6La9N7ssHjrEqekYlhPwC4/nig9AnUBMZP1zEujTbJz5H6i3oh3Ff8lxh
 D/A5Hu2PDgNybLHWHZlHnCM9Vjy9mI4lL+yB3dxey0BNttuhil0XZaQRmkcm7rwIvlmZLDtV7WK
 VYCw1zbP/dULLdLgXyu2PH68IsL6y1IMLeQNSb5NfOiHjBRuIbqSqFyhZM1sLTCUrDQf/qmiq23
 gBoU5WKmdugqOAnZUAFQVryyjQ7SyWU0Kd7c5zMMSJEePdbdHEvVEtxj10HwpRxrvkBpcyB6TKv
 CiI1T4iKtfaS4VYVHOZNy3NFIHHq7pcwwTQyz6M38e5m26LwaXfrLe246e1LRtFkmzO8N3yyAsp
 eUXlXCPfLH2NW9BIQCGk/zNyHLGzKEc13kcU6AqVQhMdRjV0+z73N16rqre0ZaodLxMxMDY+QGw
 TIb
X-Google-Smtp-Source: AGHT+IFFUqB7KbQsnCDlN9lbMPRWJRlfPEePnu3IlT8M51zhm6bg2XY/kas+0LbJyXsSvZnSSV58zQ==
X-Received: by 2002:a05:600c:3b9e:b0:477:63dc:be00 with SMTP id
 5b1f17b1804b1-477bac1543amr27812275e9.25.1763656292727; 
 Thu, 20 Nov 2025 08:31:32 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:d859:4143:4a86:3caf?
 ([2a01:e0a:3cb:7bb0:d859:4143:4a86:3caf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bd1580cbsm7428105e9.2.2025.11.20.08.31.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Nov 2025 08:31:32 -0800 (PST)
Message-ID: <f23d50ae-dfe4-4fdf-b310-2a157fc05cb5@linaro.org>
Date: Thu, 20 Nov 2025 17:31:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] Gitlab: sage: Add Pine64+ platform
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>
References: <20251118210015.624758-1-trini@konsulko.com>
 <20251118210015.624758-3-trini@konsulko.com>
 <2b123aec-d0bf-4cf8-9f4d-32ca2865d6ab@linaro.org>
 <20251120160619.GJ2125796@bill-the-cat>
 <b4ee3be5-fb26-4581-8f4b-be8938c683f9@linaro.org>
 <20251120162721.GN2125796@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20251120162721.GN2125796@bill-the-cat>
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



On 11/20/25 17:27, Tom Rini wrote:
> On Thu, Nov 20, 2025 at 05:22:30PM +0100, Jerome Forissier wrote:
>>
>>
>> On 11/20/25 17:06, Tom Rini wrote:
>>> On Thu, Nov 20, 2025 at 04:51:46PM +0100, Jerome Forissier wrote:
>>>> Hi Tom,
>>>>
>>>> On 11/18/25 22:00, Tom Rini wrote:
>>>>> This adds the Pine64+ platform to the sage lab, for both legacy and lwIP
>>>>> networking stacks. In order to build this platform we need to copy
>>>>> certain files that were built in the container to /tmp and then set
>>>>> BINMAN_INDIRS to /tmp in order to find them when building.
>>>>>
>>>>> For now, we disable the test_net_pxe_boot_config test on lwIP as it
>>>>> leads to a crash that needs to be investigated.
>>>>>
>>>>> Signed-off-by: Tom Rini <trini@konsulko.com>
>>>>> ---
>>>>> Cc: Andre Przywara <andre.przywara@arm.com>
>>>>> Cc: Jerome Forissier <jerome.forissier@linaro.org>
>>>>>
>>>>> Andre, Jerome, how would you like to handle looking in to this issue?
>>>>> https://source.denx.de/u-boot/u-boot/-/jobs/1303375#L2235 shows the
>>>>> crash and I don't have enough sunxi targets to know if this is more
>>>>> broadly breakable or not. But it doesn't happen on lwIP + Pi for
>>>>> example, nor lwIP + Hummingboard (mx6cuboxi defconfig). I can't at this
>>>>> point give remote access to the lab directly, but I can help come up
>>>>> with a gitlab job that'll acquire the board, build and try and boot
>>>>> whatever you have.
>>>>
>>>> Well the crash dump doesn't tell much on its own, except that we have
>>>> an invalid read at address 0x17. But we do have the ELR so it would be
>>>> helpful to have the u-boot.elf file. Could it be made available as a job
>>>> artifact, especially in case of failure (or always)?
>>>
>>> We do not have a literal 'u-boot.elf' in this case, but we do have the
>>> full u-boot file gdb can read for example, would that help?
>>
>> Let me check...
>>
>> $ make pine64_plus_defconfig
>> [...]
>> $ make -j$(nproc) CROSS_COMPILE="ccache aarch64-linux-gnu-"
>> [...]
>> $ file u-boot
>> u-boot: ELF 64-bit LSB executable, ARM aarch64, version 1 (SYSV), statically linked, with debug_info, not stripped
>>
>> So yes, it would definitely help locate the instruction causing the crash.
>> What would be even better is if we could enable a stack dump on exception,
>> but is that available in U-Boot?
> 
> We have something I believe, yes. However, this particular platform is
> fairly constrained, I can't enable as much additional testing as I
> usually do as SPL chokes on memory and I haven't dug at the memory map
> enough to see if SPL can have more space.

OK
>>> Given that
>>> we expire artifacts after a week, this is probably OK, or maybe a
>>> commented out section for "To debug things, add ..." if I don't see how
>>> to only save it on failures (there are options to do specific actions on
>>> failures, but, need to look in to it).
>>
>> Yeah. Whatever allows to have an image file when we need to troubleshoot a
>> crash would be great.
> 
> Will do. I'll point you off-list to an updated failure job to see if
> it's got everything you'd like.

Excellent, thanks!

-- 
Jerome
