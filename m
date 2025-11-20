Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D403CF9C40
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 16:22:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78CE983A6A;
	Thu, 20 Nov 2025 17:22:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="p/MBUfUZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0876C83B8A; Thu, 20 Nov 2025 17:22:34 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CF78836D1
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 17:22:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-477a2ab455fso12119135e9.3
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 08:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763655751; x=1764260551; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4rrU/s1DxPC1czpx+ecaNVrFFc1oBe+LmI4Vd1iDITw=;
 b=p/MBUfUZzasJ3XDkIoJQ/ggqXMCE4+aO8/ZQ4Tx331u+mrgqG6ihtySrxhnbIqkgkk
 iQS66rKco0AC9yYyMxNZY+hO55BGJmTzYEM52wC2GCjTxe0rmAbo49wKEQI2J06Hgjoh
 1kKBE3de5n/Axp3Kb5UDVZAiy8hau0imKtO9TF+FA0FL1xK9mzSl2IjKyrqq8BDnQ/zZ
 MYIcaEZ8KbpT8JqNtRMX+SCSWpsjJ+TE7BzWl2ym4aO8vpoJiEF7rHPXm+IsBUR3WMQr
 n6bjH1z6vl7cxUxhSSPS+LyExQIJaWOgSyr6SPOp66fYEGebJDECBbYcu15DCyQRfbGO
 yc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763655751; x=1764260551;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4rrU/s1DxPC1czpx+ecaNVrFFc1oBe+LmI4Vd1iDITw=;
 b=kO4/UcHLyJ9Wnh15phxLf8vq5l4cXTkBcsGfii8OOVMK3XhJvj4p0BrnuyU3JyUtvh
 lzb3JBCBzKVPlaakuzAOCkiGR+gizOeK8EW7jXewN2Qy+hhz1gC8pKscYOoWm7EAAfMO
 vg6shSaAD7OCmHyUJrQaH2UrNYcN0s57BmmnlL/3Tq8nTWfZS3CJ+e51BpIeK6zocf3x
 Dj6BigdMVNabP2IY38SdJamq1VkILQgmYMDrRGnHv29S3llOMdnaVRZMKiHrGnU6pnTB
 bo6wdkb4ANZZJVueu94M63dRffi7YbD6lbgDTSmz6HqJczrTOgJSXgIeuSK+4e9jTaJP
 NyPw==
X-Gm-Message-State: AOJu0YwqRWkJTsHNcT24UoK4t4+tX3Ydp2Ga4KUbdpwgr8xCC6y2PpNz
 LV0I21cLUGdwnji14lC8yxyknL3pIgqfsx9XmJFuZgIY26Uy3LPNDD96ifwvGbMb6lI=
X-Gm-Gg: ASbGncs3QOcC4iOxn2Ett3q5QiMON5dDbkosOVZjHVL7vTXT7wWMEkET4Q1qVft2+Fw
 mcM7JK8h8QZrYw4GLq5dN5wG1laAk24W/cFBFfBlw14nH2mIDTAZLfV4hVRFHjPUcv4h7Wylvd2
 4EeINOQArdNum63EjEcJnXRihleu0xoxEEK4IjVahgnnVbB+zxCiQTswa6Nc4MxhYOnHqC8oaVP
 NSzV6JUA8dkT395n8JAbW11FnNCbPa3Y7o00vJ4cq7GzDm7T2evWOSuDczEODK9bUpAiuCQDyMe
 cUekoyIVbPa1edtCvUne7G/L7aekNBER57biGCYMio947GP/kghBSDEBtjRnf3M/aWwdhjLYqEP
 nxMMKfPaBnEsq5IwK15QopR8mYh/s7PeEPlKIXZ98v+JkhYIAjxyOLdXvkGmkb78zef6oh6O0yf
 h8/UrTaMc4peO/EqkoYqMWHKFVZZ5gIIydcZjK356WHtUcwBiN5TZ1ZMU4l8ZQaYgJyc+Wc0wpQ
 X8n
X-Google-Smtp-Source: AGHT+IFxtThR3vaWNloS5y0UjjwhfnkT0ketlTiZaUwbAhxDo3vcrZ7TdkwECEMQAGDJgZ2HRFuG3w==
X-Received: by 2002:a05:600c:4fc1:b0:477:5ad9:6df1 with SMTP id
 5b1f17b1804b1-477b867133dmr39565565e9.3.1763655750896; 
 Thu, 20 Nov 2025 08:22:30 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:d859:4143:4a86:3caf?
 ([2a01:e0a:3cb:7bb0:d859:4143:4a86:3caf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b82d825dsm55263455e9.5.2025.11.20.08.22.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Nov 2025 08:22:30 -0800 (PST)
Message-ID: <b4ee3be5-fb26-4581-8f4b-be8938c683f9@linaro.org>
Date: Thu, 20 Nov 2025 17:22:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] Gitlab: sage: Add Pine64+ platform
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>
References: <20251118210015.624758-1-trini@konsulko.com>
 <20251118210015.624758-3-trini@konsulko.com>
 <2b123aec-d0bf-4cf8-9f4d-32ca2865d6ab@linaro.org>
 <20251120160619.GJ2125796@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20251120160619.GJ2125796@bill-the-cat>
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



On 11/20/25 17:06, Tom Rini wrote:
> On Thu, Nov 20, 2025 at 04:51:46PM +0100, Jerome Forissier wrote:
>> Hi Tom,
>>
>> On 11/18/25 22:00, Tom Rini wrote:
>>> This adds the Pine64+ platform to the sage lab, for both legacy and lwIP
>>> networking stacks. In order to build this platform we need to copy
>>> certain files that were built in the container to /tmp and then set
>>> BINMAN_INDIRS to /tmp in order to find them when building.
>>>
>>> For now, we disable the test_net_pxe_boot_config test on lwIP as it
>>> leads to a crash that needs to be investigated.
>>>
>>> Signed-off-by: Tom Rini <trini@konsulko.com>
>>> ---
>>> Cc: Andre Przywara <andre.przywara@arm.com>
>>> Cc: Jerome Forissier <jerome.forissier@linaro.org>
>>>
>>> Andre, Jerome, how would you like to handle looking in to this issue?
>>> https://source.denx.de/u-boot/u-boot/-/jobs/1303375#L2235 shows the
>>> crash and I don't have enough sunxi targets to know if this is more
>>> broadly breakable or not. But it doesn't happen on lwIP + Pi for
>>> example, nor lwIP + Hummingboard (mx6cuboxi defconfig). I can't at this
>>> point give remote access to the lab directly, but I can help come up
>>> with a gitlab job that'll acquire the board, build and try and boot
>>> whatever you have.
>>
>> Well the crash dump doesn't tell much on its own, except that we have
>> an invalid read at address 0x17. But we do have the ELR so it would be
>> helpful to have the u-boot.elf file. Could it be made available as a job
>> artifact, especially in case of failure (or always)?
> 
> We do not have a literal 'u-boot.elf' in this case, but we do have the
> full u-boot file gdb can read for example, would that help?

Let me check...

$ make pine64_plus_defconfig
[...]
$ make -j$(nproc) CROSS_COMPILE="ccache aarch64-linux-gnu-"
[...]
$ file u-boot
u-boot: ELF 64-bit LSB executable, ARM aarch64, version 1 (SYSV), statically linked, with debug_info, not stripped

So yes, it would definitely help locate the instruction causing the crash.
What would be even better is if we could enable a stack dump on exception,
but is that available in U-Boot?

> Given that
> we expire artifacts after a week, this is probably OK, or maybe a
> commented out section for "To debug things, add ..." if I don't see how
> to only save it on failures (there are options to do specific actions on
> failures, but, need to look in to it).

Yeah. Whatever allows to have an image file when we need to troubleshoot a
crash would be great.

Thanks,
-- 
Jerome
