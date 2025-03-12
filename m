Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD6DC28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 08:25:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0791801FB;
	Wed, 12 Mar 2025 09:25:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Pevzf/pj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26F59805D7; Wed, 12 Mar 2025 09:25:20 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C233801BE
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 09:25:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43948f77f1aso38229145e9.0
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 01:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741767917; x=1742372717; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eqqEpYMfKgPvHDUCM1em51GUcIQFC6ePoA0Xkq0KdZA=;
 b=Pevzf/pjD2t4hHRAEv5mFMA5i88meSu4cP/0TxlgFQ0h1a6Om2oblTcSPqqnLwkuCw
 i845ZdIqF9x6tjvOnpwUT6YjofhmHnRan2frH+lkANPC1yKp0mKpjR9n2dspJTkzDa1j
 j0rNWIDa6P/q0Ru0igddtxBs8wXmefvIOKHsMZr7jo1FT1UZRhO/giNfHymVmE4lYGF5
 gQ+CC5VQqRfZqC2CDY62L5C6DSnqartY807Nuyd2EnOiO63lfCV5ERJ1a9p8qPEBz38P
 4AKoKGdl7llEVHHWfFQOu7s1CISbJqUWv34oYsQc1bBEfCJww6IRae5Ylnpl0HWO33df
 XjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741767917; x=1742372717;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eqqEpYMfKgPvHDUCM1em51GUcIQFC6ePoA0Xkq0KdZA=;
 b=oULrYqwJnokU3//XL1dMkrOcatXngISEf2w8A/fgtMMgQ5ahPaVfC1pU5CZ/1Kx66W
 xiM8RTBOsMbiaIR8P+OQwC496i9AO61PgQcCnYVyeBie+eFQP633C8D1lbI/CSS6wGE7
 XhUJ8UnovhY2tGscpi/OFiAfUsCG5WNF663jIpRCdtW63vhaSHu36t81c/8t2MqhPlIp
 rJZc+T+dhzMcViupLzhPSUgbi2ip6H4J+b9cfQA4xgInlM6hEPt/tYtfXodDzsPfgZGx
 VHrnf06xifEAMvr/LP/nn3ixziF5oXVdYtHwL11E5av5xC2sCenHBrIwacATyaGr6r2P
 4d5g==
X-Gm-Message-State: AOJu0Yw4eNvnPUjycSlN+FnaVOknBR/SyUsrcs7thP0WFseuJ68xZJal
 sramR2v3cDbNdT6V+Z+3YbFtxvsc8+DUKt2QZTpY/2XuBloGtBSKuZJ6pGT3SGs=
X-Gm-Gg: ASbGnctng/WVRntylSkbLJmolRtBDB9Sgo20zNN3JizND+nqReTuRLvM7LaaPiPJnsE
 b0RCdm/GSBqfu5kgtLINZlfeaSJ8DW5q3BDa1yzE3t9XEVo+tmgldHK4IjlLOgE9Oqq2xAL2l1/
 zHazsyeRf/C5Glqoo/xzBrgQfGa31/vDyLaa8be4Ck2YXD3TlXrb/7l7f25p6MFGa+zkjQ2n+dH
 zhTqJg14NHXFYRZoBmFmtniKxyVt/it+0bDLskylOOlzhW6RDx2P/KoIe7+OBvG7s703qRPp9Wa
 ZmiqZ34MckRpVXniOZJDItMYpLoYJ/hNJGYFHnKCg1+y1fvvtG/oRLCE6HI+Kpnqv0VjwWXrh+0
 PA40X6F/HBcoDllbnrLl/5g==
X-Google-Smtp-Source: AGHT+IHsUr9xWvPJ92t5pwJMt3qXazbAPdd08EpnJbIYtoNWA4QYMGEH/KqboHysj4qHjo+wiDLXug==
X-Received: by 2002:a5d:6c6d:0:b0:391:2b11:657 with SMTP id
 ffacd0b85a97d-39132da10f8mr17037165f8f.38.1741767916381; 
 Wed, 12 Mar 2025 01:25:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:30c0:6d8d:9e9:d83f?
 ([2a01:e0a:3cb:7bb0:30c0:6d8d:9e9:d83f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e4065sm20646629f8f.62.2025.03.12.01.25.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 01:25:16 -0700 (PDT)
Message-ID: <e429a347-7405-49a2-a9a1-960f8d767b1b@linaro.org>
Date: Wed, 12 Mar 2025 09:25:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] fastboot: lift restrictions on !NET_LWIP for USB
To: Michael Walle <mwalle@kernel.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250312073655.2281377-1-mwalle@kernel.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250312073655.2281377-1-mwalle@kernel.org>
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

Hi Michael,

On 3/12/25 08:36, Michael Walle wrote:
> Fastboot works either over TCP, UDP or USB. The latter doesn't have
> anything to do with networking, thus should work just fine with
> regardless which network stack is selected. In practice, header symbols
> are used inside common code paths. Add some ifdeffery to guard against
> that.
> 
> This will make fastboot over USB work with the new LWIP stack.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
> Alternatively, we could add the defines and stub functions to the lwip
> header.
> ---
>  cmd/fastboot.c               | 4 ++++
>  drivers/fastboot/Kconfig     | 1 -
>  drivers/fastboot/fb_common.c | 4 ++++
>  3 files changed, 8 insertions(+), 1 deletion(-)
[...]

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
