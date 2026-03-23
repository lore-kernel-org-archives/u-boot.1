Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B409F483F8
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 20:59:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 971A58063E;
	Mon, 23 Mar 2026 21:59:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XCumGEsW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB5A983AC5; Mon, 23 Mar 2026 21:59:14 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B3BE80077
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 21:59:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-467166cb638so1009918b6e.2
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 13:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774299551; x=1774904351;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lRu9BQBrJ2ILePxFLzp9y/1/Tn69bLiQmPJHRqhjmhc=;
 b=XCumGEsWZGrMT9jWcK0x1x0jShFFNeqqjRmABxG2g4iQJl7qFRlErOD8qDvVz0pqBc
 45PROO+lQLagAN8uvUuYR2bORj22lQc+LDf98iH1DxA9CXv3Je7bKFXKSVtBnsU0vUp9
 KG9tAvHnXPEnfnG9uB+E8Bt/vUo8qNvsTf0dl/k0Sewlk9HSbxwwponrhaDfQyNi+VjA
 FC4ve32BuoY8vlnGHu1NHQnrNXKoKIH5FebonblD0+XMWPzasSWk9763O/+L3ut27Eg3
 wbkBgJhqngspFIPNjbatyyFmDx8MSHjBu4dDY8VMQa2cp5Y+M3P6f8Vd4aXE3EG/AJ9q
 CrFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774299551; x=1774904351;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lRu9BQBrJ2ILePxFLzp9y/1/Tn69bLiQmPJHRqhjmhc=;
 b=c5Cl7S5iBAai17ph3GEbgek8yYF8gueGgVobFTr6oTrqEI7FdYHcS2U+giA3tfF09L
 dA4w7o1yIP8heLhMb/KeHdUNXFrmEfj93g3pwxiA++xAk3RewWvcr7n717zqE+RS3ref
 QrrOCqNKOCGS2YzVdZ8vGAUeFls1IGry1erAuTiQcURDIoVzLb7YcV1MLpnauchKpUbo
 CZccNqr1M29PxYy0r25LRl0vwY/gkPWl10nKEx/XGO/Bqnbz/vmbELXv2n+0vay7JeCZ
 NfeWCQRoOhWuk8p9LGYZ3C7U598utudWuvgdo14nurzDhPbia8w8F2U4MIcA+wdV/tT9
 iiXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiOnVOw+wlwTzVww9kcgl6pUo0VfWiAjjLwgmyKaexkSuIdCXWMFb0h3cDUKrHYQuKZCfl+ig=@lists.denx.de
X-Gm-Message-State: AOJu0YzbVt8ysCt3+jjuO4+KYcB3MasOl7PL3MES2eupU+f8cF+mhBTm
 F6SEGh9nwqgan604mpYbyGAFmHJImDyBWK3yKoLSEow2+SHrvIGXuiv1FnKtOR3ySa0=
X-Gm-Gg: ATEYQzw6eoGenW+pYs8d1LnTBa5jT41y/dXBE52QotP3jH7zdvsXooqM9WmZeuimsMp
 vFRnSmhKvdT6x+bII/0i/Ye77+62KzYVrIv02r9mRRv9KVttdyw07AoRZnBbwHmSp1bJSRHyrnn
 OVaMcqP2iD8Uyzy+SxHy9J9zHIC21fDjpw51kD8A8KZgLlWaVtf5n2uLlVANhu5I9sFEG+BZMFp
 0kiyy/GFH1q/9KexcgDWw5Rd9bEmGH9suq0tgZ3wEUUOiIUzF2lWmAI2O6FwM08kjhz1K0/T+mz
 KFAJ/Kt9Wc32VOfkcRi2zE2BPI4aTm4YPr0UgV63jTk580eqLK/EsExdxav1N9titsdjvuTJTNJ
 L+ZQQNEHqRG05FfEjzHiATNH0Pal29gi2rshaXtgPFXjwm9W5WuhGS7pvH/UnjrrmHn/F8mVrFJ
 +YxvcNDG/fnAtNS7fjuyJEaYzdZc8ksJqUM0qE9dFst2SteSLOSCV5gI84Ps3fZmp7uUKBny8=
X-Received: by 2002:a05:6820:982:b0:67d:e6fa:444f with SMTP id
 006d021491bc7-67de6fa46d3mr4741562eaf.71.1774299550879; 
 Mon, 23 Mar 2026 13:59:10 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:964:f712:dbc7:4119?
 ([2600:8803:e7e4:500:964:f712:dbc7:4119])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67c252ac65fsm6838727eaf.2.2026.03.23.13.59.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 13:59:10 -0700 (PDT)
Message-ID: <8ffb6e52-d161-49fd-b815-2eff4e864bd4@baylibre.com>
Date: Mon, 23 Mar 2026 15:59:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] clk: mediatek: mt8189: add some VLP clocks
To: Tom Rini <trini@konsulko.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, Lukasz Majewski <lukma@denx.de>,
 Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
References: <20260323-mtk-mt8391-initial-support-v3-0-19dd92f4543f@baylibre.com>
 <20260323-mtk-mt8391-initial-support-v3-1-19dd92f4543f@baylibre.com>
 <20260323202358.GM502704@bill-the-cat> <20260323203333.GN502704@bill-the-cat>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260323203333.GN502704@bill-the-cat>
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

On 3/23/26 3:33 PM, Tom Rini wrote:
> On Mon, Mar 23, 2026 at 02:23:58PM -0600, Tom Rini wrote:
>> On Mon, Mar 23, 2026 at 03:16:52PM -0500, David Lechner wrote:
>>
>>> Add some VLP clocks needed by the PMIC on MT8189 and similar SoCs.
>>>
>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>>> ---
>>>  drivers/clk/mediatek/clk-mt8189.c | 289 ++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 289 insertions(+)
>>
>> I'm working on a series now to fix this globally, and it's not a
>> MediaTek only problem, but:
>>
>>> @@ -1733,6 +2012,16 @@ U_BOOT_DRIVER(mtk_clk_topckgen) = {
>>>  	.flags = DM_FLAG_PRE_RELOC,
>>>  };
>>>  
>>> +U_BOOT_DRIVER(mtk_clk_vlpckgen) = {
>>
>> This is a bad name to use. I bet in other parts of the series you re-use
>> it. These names need to be unique within a binary, and while today they
>> will be I bet (since all the other examples are fine), someday we'd like
>> to be able to compile test (and so static analyize) more code, and it
>> will clash and fail to link. A better one would be
>> "mt8189_clk_vlpckgen".
> 
> Ugh, and I just hit the build problem where I see these re-used names
> are important. So, thinking about things harder now.
> 

I assume you are referring to the use in mtk_find_parent_rate() and
a few of the mtk_common_clk_*_init() functions.

FYI, I would like to get away from that usage eventually. It seems
pretty fragile. And now you've give another reason to motivate that
change as well. I have so many other MediaTek clock refactor patches
that I'm juggling right now, it will take a while to get around to it
though.

As it happens, mtk_clk_vlpckgen is actually globally unique, so I will
just keep it to be consistent for now and work towards unique naming
for all of the MediaTek clocks later.
