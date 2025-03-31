Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386CBC3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 10:06:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9249E817C4;
	Mon, 31 Mar 2025 12:06:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SZ0ZSrwy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9217C8006D; Mon, 31 Mar 2025 12:06:37 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57C848171B
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 12:06:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso32496825e9.3
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 03:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743415595; x=1744020395; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zMr+S10cMOFvYBq4CEkhAoqJKwF7w1Otz4GPXeHdP/I=;
 b=SZ0ZSrwyEx9g5wRfjO+KeTiu1oZWK6B9t8sG3oXWIezhy+4Xu9fI+qusjpLPR7NHHD
 eJY0zfbbalFrPYj65hKU2UeIfLFURHkw0nHb6ge/mjVoA9Xs9NkA2MMqaOjf8diezC16
 fc0IJwKRxzBTBgJAnIZTETKfAKsTVs34sZ2EwzcaiY93/tNNwhzNTC96v+rJJMqq6T5g
 Vl1DwwT4P2jbdcpxXVNrBoJ8OFvgLPT9DAsCOu7USjJr5LN/9FM1VoTBTDV3c9uj4jg/
 rPHNxryz7d8IT1WQHSm8GLStjP2EQI0BhjjRw76/JWDl8+xpe7M0/VzjwjePlGMJJCqx
 Ysyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743415595; x=1744020395;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zMr+S10cMOFvYBq4CEkhAoqJKwF7w1Otz4GPXeHdP/I=;
 b=Sp/lpD54l0fo6BaX9dyfG51FY7i744Th4KCbcZFu4cNBe4o1dRjnbAKxvqtOqbWcMN
 gBzuCn4XpPWYaOL8hO/vKl+w3V0E2MDarEzGr0NYEwuPuImFDK4fVnXyBZSaI2daYox6
 xoZTZiP1yynhPvd5gEsy3OVLqui3OL//eX47hnmXdDOiznM6WEqcAZXHGUEsB8mDhfq5
 EEElFTZHz5wtTlX1UhvCG7+9nzg+O2ABLzhxWKuyavDRUFdr34mzeQs6ncXBiEXTEAph
 Mb0fktnoYf/0lSDwp42wQt5hqKTws9edbdR7g7LILNSu147xF6ajR3WyyP/EjK7Bkpnd
 M6+Q==
X-Gm-Message-State: AOJu0YyPSG+p1KZtobw6TN62bv5N6aTXLfWVjAHuBEQ8Mhz9SWKY6xCt
 lwbgtGm6IOtQk8Mh5H7R13c7MtcubPKkORpENV+XTrlEUgf5Ba4yIrLNGYJfRbE=
X-Gm-Gg: ASbGncsIKSH2wkMjc9uct1Lismr63f0AWNUttagdFukU6heQQSz0nBAYcfD9FsCqExF
 mBzqOSymT26aWuj2U51troWM6XxhD/HWNUFzq9m30OE4v01UE4ECy05bWp9jOmrfZyRFlCgF+SQ
 dphmaef71TcyZMhZPjKrp+WLCyLQN1kTUjmONdkxRZrTes/BTN9q7lw5Il87mjQcr/4JD0yWUNw
 euJMGI1IoLdtOQcKyEFwLEsYfv1ggIbwUfYL/JGrNtb5Y1PWJN0KZTxq9dGeOr5ZZvOrlww8Qqc
 ywLpOv0coeo1Xq5aFocV0rsSPrkSFSm3xu4jtqQ8JoSP0VTzwz/ip4mA4qpxV82FSA78/p7Qim8
 rFkvIipoeEA==
X-Google-Smtp-Source: AGHT+IFrzYRZWxXEJRuZEIScBjDrQl4dtFEv5Pebo0wj+YtLVHsRdICRbdrWwEDSIEs8RNCem8qbHQ==
X-Received: by 2002:a05:600c:310c:b0:43d:db5:7b1a with SMTP id
 5b1f17b1804b1-43db6228049mr59183295e9.12.1743415594744; 
 Mon, 31 Mar 2025 03:06:34 -0700 (PDT)
Received: from [192.168.1.38] (i5E863BED.versanet.de. [94.134.59.237])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b79e082sm11025681f8f.69.2025.03.31.03.06.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 03:06:34 -0700 (PDT)
Message-ID: <4a880d5c-5738-4602-a924-b94afcbc6fcb@linaro.org>
Date: Mon, 31 Mar 2025 12:06:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/56] expo: Various features and improvements
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Graf <agraf@csgraf.de>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Julien Masson <jmasson@baylibre.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Nikhil M Jain <n-jain1@ti.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Rasmus Villemoes
 <ravi@prevas.dk>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
References: <20250328130713.2612648-1-sjg@chromium.org>
 <20250330144709.GR93000@bill-the-cat>
 <CAFLszTiykZ4EaLz2oBmUduLm_OsdDxamANf0cbBFaOvzyMwmMg@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFLszTiykZ4EaLz2oBmUduLm_OsdDxamANf0cbBFaOvzyMwmMg@mail.gmail.com>
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



On 3/31/25 03:18, Simon Glass wrote:
> Hi Tom,
> 
> On Mon, 31 Mar 2025 at 03:47, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Fri, Mar 28, 2025 at 07:05:47AM -0600, Simon Glass wrote:
>>
>>> This series collects together some new features for expo to make it more
>>> useful for boot menus:
>>>
>>> - measurement and display of multi-line text objects
>>> - internal alignment for objects (e.g. centred text)
>>> - editable strings in text fields
>>> - new 'box' object to draw a rectangle
>>> - highlighting of menu items, rather than just relying on a pointer
>>>
>>> Expo's boot menu is restructured so that it is possible to iterate
>>> through various bootdevs and update the menu as new ones are found. This
>>> is more in keeping with how bootstd works.
>>>
>>> A new textedit object is added, intended to provide a simple text
>>> editor. Future work will complete this.
>>>
>>> With this series the boot menu has a better layout and appearance.
>>
>> Did I already say this for v2 and forget? It looks like you forgot,
>> again, to split the expo stuff out from everything else, which others
>> might review.
> 
> This series is all expo stuff. Can you please explain your objection
> more clearly? I still don't really understand.
> 
>>
>> [snip]
>>> base-commit: 37ef92a972663c6de1b81d24d2ca5cfd664fc6df
>>> branch: schd2
>>
>> Of course, not being on top of mainline, no one should spend much time
>> on this anyhow.
> 
> As I thought we agreed, it is helpful to review patches so we can keep
> the trees in sync so far as possible. I take your point that few will

Please at least make it clear which series you send don't apply on 
mainline in the cover letter.

> be interested in expo and there may not be many comments, but sending
> it makes it available for review and potentially sending a PR for your
> tree at some point.
> 
> Regards,
> Simon

-- 
Caleb (they/them)

