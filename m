Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C92E95363
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 09:35:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AC1D83A47;
	Wed,  4 Feb 2026 10:34:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=forissier.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=forissier.org header.i=@forissier.org header.b="O2vy2zs7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B14683A24; Wed,  4 Feb 2026 09:03:57 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CD5C839A5
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 09:03:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=forissier.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome@forissier.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43615d9c507so846442f8f.1
 for <u-boot@lists.denx.de>; Wed, 04 Feb 2026 00:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=forissier.org; s=google; t=1770192234; x=1770797034; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uM3xH0JoA4xyUM0VJCAIDUr9nqi4mtRVtO46owdKwK0=;
 b=O2vy2zs7WjVkPF+lbWu4rfjRq6t7693VCPfdsm0S+AyIiP64Q9z3vhw9aBethh0EI9
 RP4/8wZwTXTwhgTDmlPuUBN0v5cvLhLNjipk13eKurN4tffRfgCbCPdsG4xprgjL62Ow
 MvJwrAliVcUSXQVYalR32GawHm9MaB23kUg3VGcXLhhYW1Ld4qn03NW9olGCK7Jmv/Xo
 FyvT0yJABsN32ca/ioDLAq57Lok5IQEAiI/VHRgaC9xMJB+EBQc3Zot70A+jlCKMHyvu
 sAkpK6gwAem49KriDNdelEutPUDv5jR4Kg7wXdbu3mB6XkOASlEmiC10vdjAafUprm88
 nh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770192234; x=1770797034;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uM3xH0JoA4xyUM0VJCAIDUr9nqi4mtRVtO46owdKwK0=;
 b=Zs1xz1GpcXDCjbxN3kr9S8VaBCtgIdKTIa3NdWmsJoxbWS/udTpAABY7BSPNgXblSP
 XntBD+YRNvIGd7qs5CGq+nugmUuLK70teSe7N4vYMQ3eGCmq/o2ABDM7gWsJSH0IHqxJ
 ry6x2SXLNbGd6sx44KrjDPP18vREi2lPP9OvGv7hUdDCjOX4ckj6S9cF7bk0GOw/v4/l
 m7L9DCJqGL1YtlZXWeNzs5rhXSa2Y+E+0zmu2KSksjV0l9+vOSMvzEOfULwWCmqTtSe8
 zK6wp9trBaYxx3f71v8E9sjrKslVHBF3l5SenvMrI4aBGhNuO/JVSISo7DLhRHF9RAlR
 njwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWz+DZqjEOy6cnD1nCK2G/yGQuO3nkDx2ZPqohcelei9+ix0i1vH3rSllrURNOTP7GPoW2tra4=@lists.denx.de
X-Gm-Message-State: AOJu0YwOidCaYLF2qcOQPhUg1RoOCpCFor3Hgpp1uPwfngsomJovyDnh
 P3FupaFYe2OVZUhl4eDYdq8qMJuUhA3GzOTKlCK495o9bFicrAj/ndY1kqWOzpWyUDQ=
X-Gm-Gg: AZuq6aLtj8EvNjnEvZLLycME9XX4gGQuMeWi0x898Z5ZGSaOfd7dOcnAyl/Cek8atpD
 cl+Qzuepw9i17ZW7F3Goj/gujdgXk1y7qZRUnzRc7oAiXIG0w34gIamYl/TtDd1sHUdcN5VF/rh
 P+vclBTZCNU8i9hz4VyLceXLXMCcnzWESOXjWpuONOKIMa5SISqHVMgtXllIkWP+ssJIlRR7NIn
 o31Xa9SKIwKaugDReCzaZ5Ly+0togjl9QeVY2rPSGQVqZpZMtSSJKfRvuYplr8NdA3BBghtsKu4
 Hmg24Pjn/KDWNZmZx0PWADvZ5WovxLc0v9IKGvMD5Pgr4fn1jLt7Ccq8g3yvv9LMC7eGqGce+Ff
 xDrSdbf8acylQYmzyIpm8H1M0ryswyi7VVXU9MqTY5HehZSl3x2kdt28gvWfveKoqVmWk/8S4YZ
 E4ADvowZxUlWaPrW16FMk77v1fS4O8sPEEJRmf8uFDFJeCivwsHcHL8MEstA==
X-Received: by 2002:a5d:5f92:0:b0:430:fb6d:1442 with SMTP id
 ffacd0b85a97d-43618063b88mr3005326f8f.62.1770192234264; 
 Wed, 04 Feb 2026 00:03:54 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:c8fa:a7c9:6b30:64b0?
 ([2a01:e0a:3cb:7bb0:c8fa:a7c9:6b30:64b0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4361805fbc5sm4049511f8f.34.2026.02.04.00.03.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Feb 2026 00:03:53 -0800 (PST)
Message-ID: <cb487632-d552-41cc-998d-0205732527a5@forissier.org>
Date: Wed, 4 Feb 2026 09:03:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] net: lwip: Do not write past end of buffer
To: Tom Rini <trini@konsulko.com>, Michal Simek <monstr@monstr.eu>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michal Simek
 <michal.simek@amd.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Martyn Welch
 <martyn.welch@collabora.com>, Benjamin Hahn <B.Hahn@phytec.de>,
 Simon Glass <sjg@chromium.org>, Tim Harvey <tharvey@gateworks.com>
References: <20260114-tftp_fix-v2-0-8de8e6ecf4e8@linaro.org>
 <CAHTX3dK6eybwR+FBcqS=qgFOpX2BVsg3gDQs=mTbshDMDS-imA@mail.gmail.com>
 <20260203183900.GR2603314@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome@forissier.org>
In-Reply-To: <20260203183900.GR2603314@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 04 Feb 2026 10:34:42 +0100
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

On 2/3/26 19:39, Tom Rini wrote:
> On Tue, Feb 03, 2026 at 07:35:19PM +0100, Michal Simek wrote:
>> Hi Jerome,
>>
>> st 14. 1. 2026 v 16:12 odesílatel Andrew Goodbody
>> <andrew.goodbody@linaro.org> napsal:
>>>
>>> Fix some cases where the trailing \0 written by sprintf is not allowed
>>> for in the target buffer resulting in writing past the end of the
>>> buffer.
>>>
>>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>>> ---
>>> Changes in v2:
>>> - Address review comments from Michal Simek
>>> - Add a second patch to address some more instances of sprintf writing
>>>   past the end of the target buffer found by code inspection while
>>>   looking for an issue.
>>> - Link to v1: https://lore.kernel.org/r/20260109-tftp_fix-v1-1-64bd50abc72b@linaro.org
>>>
>>> ---
>>> Andrew Goodbody (2):
>>>       net: lwip: tftp: Do not write past buffer end
>>>       net: lwip: dhcp: Do not write past end of buffer
>>>
>>>  lib/lwip/lwip/src/apps/tftp/tftp.c | 2 +-
>>>  net/lwip/dhcp.c                    | 6 +++---
>>>  net/lwip/net-lwip.c                | 6 +++---
>>>  3 files changed, 7 insertions(+), 7 deletions(-)
>>> ---
>>> base-commit: c05dba22f1f2b0b2655ee3971644acf1936cd07a
>>> change-id: 20260109-tftp_fix-3ab9bd66a6ad
>>>
>>> Best regards,
>>> --
>>> Andrew Goodbody <andrew.goodbody@linaro.org>
>>>
>>
>> Are you going to apply it? I would be good to get it in.

Sorry Michal your email ended up in my spam folder :-/

> 
> I'll second that ask since it's what's keeping:
> https://source.denx.de/u-boot/u-boot/-/jobs/1370910
> failing and not passing.

I'll send a pull request today.

Thanks,
-- 
Jerome
