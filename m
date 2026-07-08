Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C8BC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 16:11:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BA898497A;
	Wed,  8 Jul 2026 18:11:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="E+v2CfiB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F2858497A; Wed,  8 Jul 2026 18:11:50 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA59F8496E
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 18:11:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6a31c05e092so285208eaf.0
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 09:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783527106; x=1784131906; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=r44ekngQcy9VzYaQh/9grzQehduh6141yU2UxxJCcLc=;
 b=E+v2CfiBFLDZvPUGiPCm2Jsqj8+Jy06lVY85y66TC+hfOFeOgCr4Awoh4ivMlPQl1W
 XdKPTzfQGXY6kusXn4Y5ZiFDjVU/Sckt1MpVhYWOu8enmaEJMRTG4/SyWyGiZJ24/zjZ
 AszaIJl2Myprosdand17FI2IZ3DhIVpxJGvhnpCDqEA/WCxs+FQw5pFo4yU0Rvgw+uMV
 Bm7kPoOn1KNdODN5vGL7sVxJxKc1l3KnuSQ7XnQwwrl+5pS2B/7Zh8ogflLIg0TRqf3j
 9gjz9SudrQIddgixdO/Yyyb9iv0Z0yLlCbz1WPqSGnYIZYmY8IC/ceDUWFCgag4XYToU
 Ku7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783527106; x=1784131906;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r44ekngQcy9VzYaQh/9grzQehduh6141yU2UxxJCcLc=;
 b=IJbfekMNOvO5b586DiCAgM5KMusu24TV41Ys8UE9v+78DR72TRaZgS1siR7HTV+Znk
 gVGl8Wzchwke0H/up+uC7a6EQDJLZtoVgCnabMWOItKtCXJ6x0oREzQtwFeWRNALVthu
 5EwvTbQ2FZRbT9dCMI1tBtUUXnHE+5Q/pTNaBwqi2gPaJXvCmIQZhQ+RODfBixkA3Dh3
 QLzGmZ5MfDsPFVIlef448W8OdMFzgkOFuo7yofeqEvpRhFxbIApqWCzGVW+us03Tkz9h
 yyCRmgZujIopC6sWfSfkFILApb6tc2a8yDV8Z/h1YtKqb/v8QSxEiOFjGXeXkDBBbg8Q
 ViJA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+uHQMT7PoJfRYn8f0uw5e89ltcSLZb0luDxIMgFRyVuPWQ45Tyk3NkrTD3kXIRheHEYf5t0gY=@lists.denx.de
X-Gm-Message-State: AOJu0YzEEfiH6HGbcf9Lnu/YJV/KbZ61kP/aAB1jpbri7nE8TxtmkgpP
 niX9+3ZfIidnZoZzVdBV64FZtkRjpzzRHc/vCBWTkBU4HmAuHZuwuD9YsqYRSldGJls=
X-Gm-Gg: AfdE7cnPHoFA1sW+H4yh6lJYDmEHAyYeBsnHZRbFYYpImO8cPlsP076Kv+jOJkauzg/
 0885w/XfY4eXbisv39SQyQY+txMjZpFXQigc7kVS1sLFUJ95VXBsBox+UXqmDxOdNc7WzYYyjP6
 OP2Ff9omJwgP8g5bd+sv0ADQuDt8bctwsRtkMkqJevBqgpNgFxpDiPuWGqvBdG0g+5r+gSblT6+
 22NLPCu4e/QkNl+2i5GZCmk1UPHlUk5aBndXkMxIPHCTHaz+2tpapwybv6uSW1jhDEZ25S3/LIL
 E4J0EU1hDVTcNIs1g74LyJwtsMi/GMysD72xMQJ4m+Q2cOxldH+XU2SAK4woBebxy+J2KBO5wBF
 CC+gOhr5zp2+UCVo0Jy6jD8xhMAsdlZEiIy/EeJb/6MPFa4CB8lvuAG1RCHvOYAga/qR83SNCRZ
 E/dww8daw3MORjwHHkg7SP7dPTTYIJ0nQqZB1CzlRvDApoTn77pDVF8HNt53Nb57A=
X-Received: by 2002:a05:6820:60a:b0:6a1:4630:35db with SMTP id
 006d021491bc7-6a36da288eemr2070878eaf.51.1783527106063; 
 Wed, 08 Jul 2026 09:11:46 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:19a8:8ead:9ca9:cb30?
 ([2600:8803:e7e4:500:19a8:8ead:9ca9:cb30])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb5fa20fsm15755428fac.16.2026.07.08.09.11.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 09:11:45 -0700 (PDT)
Message-ID: <38d99cad-1a5a-45ba-8e6a-8e7f501cd930@baylibre.com>
Date: Wed, 8 Jul 2026 11:11:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/24] clk: mediatek: drop parent udevice field
To: Julien Stephan <jstephan@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260707-mtk-clk-parent-lookup-improvements-v1-0-65d24cc0d569@baylibre.com>
 <20260707-mtk-clk-parent-lookup-improvements-v1-19-65d24cc0d569@baylibre.com>
 <CAEHHSvatOuqzids0w1=OD29vYO4U1j_rypL3YVTNpMkEuxZVuQ@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAEHHSvatOuqzids0w1=OD29vYO4U1j_rypL3YVTNpMkEuxZVuQ@mail.gmail.com>
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

On 7/8/26 9:59 AM, Julien Stephan wrote:
> Le mar. 7 juil. 2026 à 17:10, David Lechner <dlechner@baylibre.com> a écrit :
>>
>> Remove the parent field from the mediatek clock private data structures.
>> This was no longer used other than debug prints.
>>
> 
> Hi David,
> 
> Looks like this commit is breaking mmc on me Genio 700 board.
> 
>   Card did not respond to voltage select! : -5
> 
> And then it fails to boot.
> clk dump output is equivalent to what I used to have on my Genio 700
> (without the parent debug print)

This is unexpected since in theory this commit should just be removing
dead code. I'll try to see if I can reproduce that.

> 
> One more minor comment inline below
> 
> Cheers
> Julien
> 

...

>>
>> -static int mtk_common_clk_init_drv(struct udevice *dev,
>> -                                  const struct mtk_clk_tree *tree,
>> -                                  const struct driver *drv)
>> +int mtk_common_clk_init(struct udevice *dev, const struct mtk_clk_tree *tree)
>>  {
>>         struct mtk_clk_priv *priv = dev_get_priv(dev);
>> -       struct udevice *parent;
>>         int ret;
> 
> ret is now unused
> 

Strange... buildman caught this in other cases where I made the same
mistake I wonder why not this one.


