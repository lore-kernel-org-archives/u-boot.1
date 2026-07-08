Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2604CC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 16:58:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A6BA8496E;
	Wed,  8 Jul 2026 18:58:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="jWJxJpjo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90B928497A; Wed,  8 Jul 2026 18:58:20 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03928843B6
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 18:58:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6a116bd18ebso469293eaf.1
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 09:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783529895; x=1784134695; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PsCF+8fw34RcQvCqPGcjdeQsaGM7khvGg4NqjQlE+eE=;
 b=jWJxJpjodBgwVEXHoqDd2skEjpPgrhHa9oIohCPBPVN/YzPG8rBw/5HJMCH4zLOuQW
 P8D7zELA5O9s8oF7Hp+E9rF25ILsKnLXvVb1k57NJfLvZz6DJ2ZIeBlnDBsRBPJoWs/7
 wOLbDYqageWoU06/LPHBDdkQ2FqdJWl84R7Duo23yD5Rkhe4uf7RFIanK4i77IuhGY11
 jyiws6uM2pLAYMKBMfUMj7B8YxN/CpAXkzftiLgqNK9/wwbQRxA6F2AHiORIUgsP+gzN
 R2oZskda6cXL1duyuTCY3DWGpTNePKBSao20eSrgXdfWFe4PpzNEtJ7q7XzMC8ZKyNhR
 3sEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783529895; x=1784134695;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PsCF+8fw34RcQvCqPGcjdeQsaGM7khvGg4NqjQlE+eE=;
 b=gbAvYQyCzySfT9h7d/o5Jx34MblzQhU9CYGGbp3wBfMUeZnfb0Raq0lFCCAv3HEKFy
 tD/lNlcEIIcaJCK0d7iDmv2DJ/BjSZ3qwwr1E4N6HYVc7iM3Ho7Axu89Swimd8wk7ZzQ
 GvfkHovRcCrODIy3d7nYb5q//83OCjg5SW6zVenGXosv6Q6sl4J/WO8ZA+8w8hWbMTv+
 TQL5EeQxGcVl4waVWupB5erRxAjbQKd3dAzg9yvS9zR6DZiqDWCXMDfePbGzKOar7YUN
 b4SF/vjn1bAVq0JTgdHqxq03cGFqmCwaEGz5LyrZbgACPgMZB2W9sCTbrmnyvPJGcto7
 PaLw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+5kAh36Z4CZyCsN4PoEiw9aiy1U6mGgne2JPYkJVTg1uNEoYdcl7AkcLG2ZeonMjLSpMf3ZvQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzgoZU1x4uSurz6pARn3JKsm7h6caFOKc/05k0Rfq1bR3MN0xF2
 2N9+T8QBFyrf4selUJCHK7eJT0Ql/1FtFh9ihfnWjeNYcdvMoxb+kyL95ZQnxO/WPh4=
X-Gm-Gg: AfdE7clUMGjzraG4jQ9voPx3TCx6tFt1iXjUq1FLusJx9xWXQ5r8VcYu+HxW5a2987v
 X35r+hcCw7UX1Ws4lMWYL/I6ZFYEA2mQUeu1u+Gk+pYn5ZW9x1seeMT1XCIpfJjthfArrBEKQ4A
 /vGPm47/zReKgk3/X/A71+LlpMddHIaQHiO5lZrFT3nrQvNEUQ8JreB12yv3KJHzCgezUoIFauW
 qbBBSBwa+cuppoKdcWWgtbicLh1NGYPzyFqC5LY1lMj3miBvZZKHaoOXi6lmjHUVIzzGFZJKMYq
 sJvjzqBAYEPorflgewuA0rcugNBDCsKITosR1ojisMtZVYlQsJpAOPfNWlQ/DB+QQ4OGISQsbK0
 wEOSJB5TtCiM6ImE3MvEj26u8hGpOMiKMzSwadWbELkFwOg/SEP48M7AueouYvrsvJF5A6YK5O9
 J8tthmUPs1KHyta3nEpzE0CKjdhKr0e5G0nD48ID6bSa9Pcwvuo4UGxvTGgDeWElg=
X-Received: by 2002:a05:6820:c2c8:10b0:6a3:7761:b50d with SMTP id
 006d021491bc7-6a37761b6ffmr454259eaf.55.1783529895685; 
 Wed, 08 Jul 2026 09:58:15 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:19a8:8ead:9ca9:cb30?
 ([2600:8803:e7e4:500:19a8:8ead:9ca9:cb30])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb5db92dsm16767613fac.13.2026.07.08.09.58.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 09:58:14 -0700 (PDT)
Message-ID: <4aee0aac-f7e4-457f-8613-a2e7da6953aa@baylibre.com>
Date: Wed, 8 Jul 2026 11:58:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/24] clk: mediatek: drop parent udevice field
From: David Lechner <dlechner@baylibre.com>
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
 <38d99cad-1a5a-45ba-8e6a-8e7f501cd930@baylibre.com>
Content-Language: en-US
In-Reply-To: <38d99cad-1a5a-45ba-8e6a-8e7f501cd930@baylibre.com>
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

On 7/8/26 11:11 AM, David Lechner wrote:
> On 7/8/26 9:59 AM, Julien Stephan wrote:
>> Le mar. 7 juil. 2026 à 17:10, David Lechner <dlechner@baylibre.com> a écrit :
>>>
>>> Remove the parent field from the mediatek clock private data structures.
>>> This was no longer used other than debug prints.
>>>
>>
>> Hi David,
>>
>> Looks like this commit is breaking mmc on me Genio 700 board.
>>
>>   Card did not respond to voltage select! : -5
>>
>> And then it fails to boot.
>> clk dump output is equivalent to what I used to have on my Genio 700
>> (without the parent debug print)
> 
> This is unexpected since in theory this commit should just be removing
> dead code. I'll try to see if I can reproduce that.
> 
I was able to reproduce something similar on Genio 520. Apparently
calling uclass_get_device_by_driver() has some side effect that was
being depended upon. I will keep investigating.

