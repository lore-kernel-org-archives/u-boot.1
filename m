Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCC9D65C6C
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 10:59:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D13A488E41;
	Thu, 14 Nov 2024 11:58:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="G//fvg+J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6296E895EB; Thu, 14 Nov 2024 11:58:58 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B2CE88E41
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 11:58:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-37d538fe5f2so335611f8f.2
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 02:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731581935; x=1732186735; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cM5CY9hi6psuyTtKzp6FSrYBTmQp9E1G8Xi0aQ9UqF8=;
 b=G//fvg+JnUQs8OVWzqnsv4yio1EajGnMMRNw/TAJFRa1XpZZ5cwS+QcTBLQWqKzMVB
 EcI7NbLyhs5kSdjeQs61U+mR7kLF+7tbZwcPnysNXYkSMy21mXT8W4m3EWHtRHIs7MG5
 DwaU3MnAl8sOERwEo/w6aZ8RIb8nPyMS+J2wfhNXX8Kr4tBFm/h7UVTSTncQ5HhkCVDh
 tCqRKbAGy6bztgPSTLhG6CwTU+6nxDiIf912zpImryjJJrKbaQkw/OqFYq48tsFANSmm
 c1RLLHKKH+KxSQ51xnDl4yGZkIfeYMO87Cw+ug16womY1BaBcXhm9xsRCPvh2vHN9+YH
 GK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731581935; x=1732186735;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cM5CY9hi6psuyTtKzp6FSrYBTmQp9E1G8Xi0aQ9UqF8=;
 b=KGihqEjbntYfaVV0q9QxijAzUKB1Pyd2LmS71qk0M79LVFbaxwbrJ5LmJzVIcSLL8b
 5IvbO1shOQoktDBYajdrtfFI3W87WbEklBMwLaJj5cnrmlTtKNUKw9LYoHjFhHkx3Yi+
 hYOL4E6Mf/23FUozHIfxm/tbVZcdQPzO1Wtc+5DUkVkhtiVsJkhFtnyFUPnf/gxZZ3CM
 Kp9OpOp24u6EZP06LrCbsbqtjHSL40oaR3UhHY/XgzQekFzGY2khcWseuvPLvX7q/MV4
 IN4m0cEMACu76vo8rNzznnR05DkSQSsAR3mecfYtVAuTJa+Sm2Aa18Q46QpS5C9rCMh9
 7ZRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5DKIRkEWYO2fQBt7p8omQ3aMDOlXbs4wzv/5TaCM2p5ttazDlIhNRm7+l/5V++VfAqLkm6kI=@lists.denx.de
X-Gm-Message-State: AOJu0Yy5sCKD+2sSX/sliQhPzCVxzaPhMfEOJQ9/dhxdPe5lLhuBOi16
 0SvN+i1ULwHn1xglPSy8ie4uNB4ASrAv1z5a7Z5L0EKxtpKAOgx0o7vtaGZw2lc=
X-Google-Smtp-Source: AGHT+IGJamxHioZl/sQ9+X3Mu5WHcpGONRTYm5UF89ZzdjrBWsNPiQxW/O5ndVf+vNuKm2NDr96eCw==
X-Received: by 2002:a5d:47c7:0:b0:37d:50e1:a2c1 with SMTP id
 ffacd0b85a97d-3820df88693mr5186893f8f.46.1731581934691; 
 Thu, 14 Nov 2024 02:58:54 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:6dc2:e776:8a06:3912?
 ([2a01:e0a:3cb:7bb0:6dc2:e776:8a06:3912])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821adadf8fsm1141833f8f.39.2024.11.14.02.58.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 02:58:54 -0800 (PST)
Message-ID: <f7bbfb0e-1ed6-4e83-a3a5-44647c3deb8f@linaro.org>
Date: Thu, 14 Nov 2024 11:58:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Makefile: detect HOST_ARCH properly when CROSS_COMPILE
 is multi-word
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>
References: <20241114102138.1977060-1-jerome.forissier@linaro.org>
 <f12cedb7-51cc-42b6-abe9-f3b99d3e1956@cherry.de>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <f12cedb7-51cc-42b6-abe9-f3b99d3e1956@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 11/14/24 11:49, Quentin Schulz wrote:
> Hi Jerome,
> 
> On 11/14/24 11:21 AM, Jerome Forissier wrote:
>> When CROSS_COMPILE contains multiple words, HOST_ARCH is not properly
>> detected and the build may fail. It typically happens when using
>> ccache. For example:
>>
>>   $ make qemu_arm64_defconfig
>>   $ make CROSS_COMPILE="ccache aarch64-linux-gnu-"
>>     CC      lib/efi_loader/efi_helper.o
>>   lib/efi_loader/efi_helper.c:26:15: error: operator '==' has no left operand
>>      26 | #if HOST_ARCH == HOST_ARCH_X86_64
>>         |               ^~
>>   [...]
>>
>> Fix the issue by considering only the last word in $(CROSS_COMPILE).
>>
> 
> I suggested another fix here: https://lore.kernel.org/u-boot/20241111-mk_arch-ccache-v1-1-e27f5f605bc4@cherry.de/

Ah, missed that, sorry.

> We just need one or the other, in in time for v2025.01 :)

Agreed. I would argue my version is a bit more flexible as
it does not assume "ccache", but yours is certainly good enough!

> Tested-by: Quentin Schulz <quentin.schulz@cherry.de>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Thanks!
> Quentin

Thanks,
-- 
Jerome
