Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F4B5C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 20:20:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31BA880FDA;
	Tue, 22 Apr 2025 22:20:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="SqlBQywX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BAD780FEC; Tue, 22 Apr 2025 22:20:32 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19C8A80FA8
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 22:20:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 105D541A21
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 20:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1745353229;
 bh=OL4igv2JELLUjDSiJy4zfoJIHnFTA+ZPVvk4w5eZ+/M=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=SqlBQywXt+zV+BhF42R9d6IepM7vwyIv7Qb2ozaYbWcNZItd4HbUETZs1U635XNNs
 dLiXIe/TWUzN8jrp0gTAqO7TyPI7XzhB7ZcAAwKb2qzdZggPhcomFrgID9cRRkKVg8
 voQ1uFEhFZVyOYbhuYW/0w1/RnvtU7dyCOG0lbEl6RuccOF2ucd0YPMYqMN3IATlCc
 V6s81TO93+PMNZHSEQyCfhaVqx+gh8JXU7iDnjRsTvY2bLkp3BittRPBHLKBAqKmAT
 TOqnA5GfKvWz/oeCP7gFpnxAcYBNSqBx5WAijEP42LVfkqS2JeGca+QGf2uk6HZ+r8
 LOREA9IaUjgnA==
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-acb8f9f58ebso242734866b.2
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 13:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745353228; x=1745958028;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OL4igv2JELLUjDSiJy4zfoJIHnFTA+ZPVvk4w5eZ+/M=;
 b=oj5m2hN3AFsk83PULB+tb/kzoXlT9vR2G6z6XdsO0ih2c6KPZyPD+af/BkVf9V1nV+
 shHCRNa4IgQrOuuFYGDaotphUD50ZhFbCWrq2Pv7PpNRdv/9+4vYiXpNOsoYViQUYsD6
 TjfcaM/1MA/jcQ3tyKUCVFWw/6No1qwJy9AFkCcMvU0wjMXezaXSk6fHo9ZJjhhADGR9
 KfU9N/4v8fp+HdLiMOtDrroW3ehTT4VHxcaxYA/pHZ+rFzc+dUsVQi44gzJzSh0veq+X
 8qqCWlq39ciFciqXryw6Zd/kCH/n2dt1yfI/pCfXyFVQEUeJaYrPDYts68+SCGMezxeM
 rmBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0a82m5Tvt0DU8F+pe/lMZi0/NiU481bLHDuSm23B+844gNg/4/yHQBGX0LllK0tcm2J3L6jU=@lists.denx.de
X-Gm-Message-State: AOJu0YwN4vJapJJOcHE+iyekiazMg+nU4Jm6ycvnxbyi7gH7trjrLQ88
 bglwyXRomjje5HYAz2Njb1UgsJh32SEnO9NK4nKPY+sLrPm0VngJBu9FxXS91SXtdGB0MIhqajx
 FaOoaL0ZVAsODg3hAjVKEoZYQN6ZbRKapduKTONWv008da3B7e6kvobKBdwvaEbhXpbI=
X-Gm-Gg: ASbGncsT1aoy+RZc8pvH6LM5ko6I9xdaluDshHPvNQn8NQN2F/IWczSyGsVhQUKr5sX
 FzHLJysI0F9ESTY9fQbmIdhG29j9ZbI8jjegck2T87qgiLLyjubg9PcUGH5JwljCO7tstsokAtE
 s8uP/W0d5lJraTiV+XlSxDkH6t/VEC9tJA4jZPGb4IczlMPoAxtMXNjEW6t46uw93iuwdycMS89
 OSdIiF3ViWqoMUIU1IpSr34fvjUynjvlxuEZmYdkxUELgCDPZF9N6+23fayOuPXP533Lbb5ZZ03
 fjXfM46rh58oHk1f5qH+iAvHlkIFyKSUCJW6lRhU9Ba0ROd0NIkwT5vjsz7lKBrcxiAAoQ92R1Z
 /OA==
X-Received: by 2002:a17:907:2d8a:b0:acb:32c5:43ff with SMTP id
 a640c23a62f3a-acb74744a0amr1653324466b.0.1745353228629; 
 Tue, 22 Apr 2025 13:20:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQtty+MsTjGfKSRMqKbsh/ZpqJjaDIF91NuDl9f39Qr6KU9hu6ZjpFUAin1GJlRJMBkheNHg==
X-Received: by 2002:a17:907:2d8a:b0:acb:32c5:43ff with SMTP id
 a640c23a62f3a-acb74744a0amr1653323266b.0.1745353228220; 
 Tue, 22 Apr 2025 13:20:28 -0700 (PDT)
Received: from ?IPV6:2a02:3035:6e0:69cf:9f40:eca1:e402:dddd?
 ([2a02:3035:6e0:69cf:9f40:eca1:e402:dddd])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acb905183a0sm529967666b.110.2025.04.22.13.20.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 13:20:27 -0700 (PDT)
Message-ID: <92ab7635-a6c8-4553-89b0-8eeeccec9eeb@canonical.com>
Date: Tue, 22 Apr 2025 22:20:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] configs: add UNIT_TESTS to big-endian Malta boards
To: Paul Burton <paul.burton@mips.com>, Paul Burton <paulburton@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20250422185510.11561-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250422185510.11561-1-heinrich.schuchardt@canonical.com>
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

On 4/22/25 20:55, Heinrich Schuchardt wrote:
> We currently only run the unit tests on low-endian boards.
> We should run them on big-endian, too.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Cc: Paul Burton <paulburton@kernel.org>

It seems U-Boot lacks a .mailmap entry.

Best regards

Heinrich

> ---
>   configs/malta64_defconfig | 1 +
>   configs/malta_defconfig   | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/configs/malta64_defconfig b/configs/malta64_defconfig
> index ec5df0b5a7a..d1211b07f8a 100644
> --- a/configs/malta64_defconfig
> +++ b/configs/malta64_defconfig
> @@ -46,3 +46,4 @@ CONFIG_PCI_MSC01=y
>   CONFIG_RTC_MC146818=y
>   CONFIG_SYS_NS16550=y
>   CONFIG_SYS_NS16550_PORT_MAPPED=y
> +CONFIG_UNIT_TEST=y
> diff --git a/configs/malta_defconfig b/configs/malta_defconfig
> index ca017c4865d..dfa37d1ddd9 100644
> --- a/configs/malta_defconfig
> +++ b/configs/malta_defconfig
> @@ -45,3 +45,4 @@ CONFIG_PCI_MSC01=y
>   CONFIG_RTC_MC146818=y
>   CONFIG_SYS_NS16550=y
>   CONFIG_SYS_NS16550_PORT_MAPPED=y
> +CONFIG_UNIT_TEST=y

