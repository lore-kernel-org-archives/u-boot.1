Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7424C606A32C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 20:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TVr6Eazr;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=pkjHKA5W
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C2DA6082A;
	Mon, 16 Nov 2026 20:42:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y3zmC3b8RUza; Mon, 16 Nov 2026 20:42:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0996360811
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794861734;
	b=DsJ0D81vIPFnf0176liJBPOlcFIg7omUibxKXQ1UeNq+0uxCekpeZxugQPiDkQwy1mvu
	 C19DJK5/GsOqUQYsg2azgTEU99LF+FAzGQNtQeBS7If1EcXGg8cYZKpgVkqmEpZAdLUlF
	 fInbcndpn4F/eqMjeS1WCo4grYmEWqdntZywpWv1wM7Uz9x1rTxxk1TOsgGymq/Tzeojm
	 l0/5P3M69VN0zDPNPCm8pcgEXys9DHvyJN9hh1686a6RG+ER333fhYymdexPTOEceIQn0
	 wx3pkkMb9xT67a9Bir7E8FukXYQ56hlIHfhy118tQAtFNQ1MuXHEdG+Wb9Mie2N5JkA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794861734;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TzVFzNEACMOIzVzzXb+FKsQ848tlXrLYpoRcUy0y9Lw=;
	b=qK4rrkhiqNUoJL2ra+B8j3gM5d8FiVCD+eV0a1x+AEFbc+SblU3cKK5xX7pX8DGnA9ib
	 F9CYHLgNocSlTUrdcclM8/jNI8fvXalkTVbUpaK5z9CgzfzTzWFu2YChNI0bO3Aw4PRXZ
	 1WW8mb5m53VqiUv8NZqcDb4TOyKiMYlOqDa1QER0bLi0oz81YLHSk1odsEy2NSYAYroEW
	 rQ62sAKEA67LCfoN3bl9Bu4wTq58npMHpyL1gPaZVDDBqUbVGOhSzPnV+K/Raz8LXDf6u
	 Itw8uD9Fgvqvd+oVRfrRgPOvYALSFbnuv8OkU2AccYTZJxVz61EqHe1nqsGXGUYjXpg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794861734;
	bh=TzVFzNEACMOIzVzzXb+FKsQ848tlXrLYpoRcUy0y9Lw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TVr6EazrNR6hZgjQ257N+RM9mPCEIcnp12IzomO3FyRvVUxtMy7/EBkvwjxQo0FsC
	 80wLeEvqFlFI2A7ArfabsplOLy+EW1x1nKqurMZulwrksbkCYToKREJR9BuOJKKdvl
	 SqkXVXAo5cft+Qx0j3dMD4EXzTzfv3CC/IFuZcCyt1WvzlVSmqF6Ss8pC3WR1v0sd/
	 62cX1iTQesmF3CJRPZZNklHp214SFSkl4AKVAo7l9bben+jX1TlhICgE1Xoagqiooz
	 T9mNXHgoeOzxEKLSjLx6undlpHzXmKDr/+l1VPel3CSf96d9guOnTrtcMytZPpJgF9
	 tiCCjm5PGExSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0996360811;
	Mon, 16 Nov 2026 20:42:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4967828C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:42:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 32ED6405ED
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:42:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id REYrw0k02860 for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 20:42:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D20C1405DD
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::35; helo=mail-oa1-x35.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=pkjHKA5W
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D20C1405DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:42:09 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-4a76f0cce5fso2123689fac.2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 12:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794861728; x=1795466528;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TzVFzNEACMOIzVzzXb+FKsQ848tlXrLYpoRcUy0y9Lw=;
 b=pkjHKA5WWYTiGqZa7SuH3UUmy3exDIKGRjCwxERbiekWId0GMjQEAwaojgaKB/e/Ot
 i4QRILXM2apmd+qExur/XqH3CI9ykAlYPrbSUAdZcW50cFTzxCPnim7atUQ55aEeGkhq
 r0c+HFKRojRdfVq8M9sDK4ieJ90qHghenpHmw9tg1EjvQ4fOu65ZkIbCFAU1026XoHho
 UR1QS6yIBoe8IrimwvN44lzpcIX/UetJcAkec515YnTxq3n2PIrQ6C+3DxE5CrLUI6P6
 o1IUz6lreU8PPV5bsPXV3wvKpmdEJmn2NoGDCZ4aC3hH5L4RhxkzQF0EWpD7ZJvktjNQ
 xpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794861728; x=1795466528;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TzVFzNEACMOIzVzzXb+FKsQ848tlXrLYpoRcUy0y9Lw=;
 b=JJQWv92fsIwlylrBDlKXHKCiEpnhz2YIpMqWrn5a79ExdWdb7JM1znjPV8doOI0yC8
 Er4YbwRjSqbzOmqAuRRrnDdqxxW+PheBn2zRT8g8Xe3YSy6hyKy7xszyEBQq86wAco0+
 e9fyw/y20yKssLj46/+K3AoncLhuy4IH+3RFlZ71O6uSTqwmSVYseJH3aCVDHgFVAnQN
 eaVxYcGqlbol+WMnfKsLD3d0UG07mpUg0Etr3f1FzR+/YZORJY+svbFFx3sslPF5rb1v
 TfNfNXm9MgXKb7FOpP0lWl37WIOVjygIq8wxu8TTNNga00QUKMiv7aNNMxSrSJlTjsDT
 rQQg==
X-Forwarded-Encrypted: i=1;
 AL+hErF6fsDgdfmmqnKdEMUdIuf1WecmupzsNieuEbKican1Ac5Ja0BNRM39d0PagWczD7zy3iUTaqE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9OiN9TfkI9QWxPNEl3EhOg+eGuO4Ys8/8oH2hiAZCjhuS7jUs7
 EPoyFNUOqGBkJWEXheW0DzstzzPyPlERSqYpJ4Gv5F9LQNyx064lfwPYbSuaAZc2YgY=
X-Gm-Gg: AYBFou2Yu8291z5YoJG7u5jnwYqhfbKc/quigFGPbdMeXyMcuKMk7QcPchycTtmDn0I
 91vaLxSACNvLmQA6XyUCNzpm45+7oA/XZVRhXbnVrjT1HIrWcOzlwzFgUlk4HkK9fg6sJnJElCE
 1XXNZ7CUzqoRxtBWcTH+jVb558JTmiYpLIlt6hSYKmBam7JS6feVbMQcvihwLF/PWZqLi1sgNEq
 YmsEnptGFidFW9x4Dc6iphXQRT1FChyX1Ucz3zOcQ5fZjwsnxMWdeV/Uo++dqLc8TnX9gExgrMo
 4QsnywmxI4VqLE6vFe7P6b6L8GTAGA01CPOB/gdJVBW5dtHNkcJOZivzYOS2TuOQT9CCx81tN7P
 Oc3FXRzbS3CXyXOYgADBFpmI8obnMzHSp1X0vHUmgjqfOyE5hOfyEHmlDLAfncuaX8+1ZLJFsm6
 VL1Jld9ij9JX8+Rpd42HYJpGGmkKH1FkZYq7zOJAqV213pcGYiBsIWxnnJm7+PFYpmmi6Xcvy8y
 O2IUk37GW68zsGpI6ywNixVmRLBiP8N98akk2fN5iSUzCO3b8NCegFtzX/F4WwlGoix7TNy+qxT
 deOTSUgxhZ6OxTDcmWEhH1gfFVodi1ix1TIdDQnGblRo8pkwsD6ZQOMbK+7zJNx+Nfd4i53FCgb
 Vrdk=
X-Received: by 2002:a05:6870:d07:b0:48f:e363:5cc8 with SMTP id
 586e51a60fabf-4afdf795d7dmr10184061fac.54.1794861728003; 
 Mon, 16 Nov 2026 12:42:08 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:7056:3b5b:7d85:4921?
 ([2600:8803:e7e4:500:7056:3b5b:7d85:4921])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4afe2011c25sm7608243fac.2.2026.11.16.12.42.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 12:42:06 -0800 (PST)
Message-ID: <f0352e86-58bd-4e6f-aa8f-5253a9c29a55@baylibre.com>
Date: Mon, 16 Nov 2026 14:42:05 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] binman: support separate binman devicetree from
 control devicetree
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Michal Simek <michal.simek@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Carlo Caione <ccaione@baylibre.com>
References: <20261112-mtk-genio-binman-dtb-v1-0-65cfc9329c50@baylibre.com>
 <20261113174852.GN554944@bill-the-cat>
 <CALeDE9PvZgwiAUxdX=-tN1fgDveNOkeM__xCCJeZrK3Di0WxjA@mail.gmail.com>
 <1b9f2a45-4ceb-48d0-afdb-b406404d98bb@baylibre.com>
 <01408c47-2928-48e3-ba37-34b835a3b98e@cherry.de>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <01408c47-2928-48e3-ba37-34b835a3b98e@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/16/26 12:45 PM, Quentin Schulz wrote:
> Hi David,
> 
> On 11/16/26 6:17 PM, David Lechner wrote:
>> On 11/14/26 3:16 AM, Peter Robinson wrote:
>>> Hi David,
>>>
>>>      > Anyone who has worked on hardware that uses a devicetree for the
>>>      > hardware description should know the mantra "the devicetree describes
>>>      > the hardware, not the configuration"
>>>
>>>
>>> Thank you for this, I never agreed with describing these in the DT at all.
> 
> We probably should do some digging on the mailing list because I believe this was brought up back then. I also disagree (mainly because the Linux kernel will never agree to this in upstream DT, so this prevents us from the dream of running pristine DT from upstream). I vaguely recall there are a few things that are binman-specific and available at runtime by parsing some stuff. It's very vague, because I don't remember. But I wouldn't dismiss binman use of the DT as simply being a configuration format, I believe we use some of its things at runtime too.

The two users of binman nodes at runtime that I found are lib/binman.c which
is only used by x86 AFAICT and board/BuR/zynq/common/board.c (to locate the
FPGA bitstream).

> 
> EDIT: ah I see now reading patch 6/10 that you're aware of that. But phew, is it really worth it to do this incomplete split? I fear we'll split the ecosystem once more.

Which "split" are you referring to? File format, file location, something else?

> 
>>>  
>>>      > Binman is describing configuration and not the hardware itself,
>>>      > therefore it doesn't belong in the control devicetree that describes
>>>      > the hardware. So we propose encouraging the separation of these two
>>>      > descriptions into separate devicetree files. In most cases, binman
>>>      > info is not needed at runtime anyway, so combining it with the control
>>>      > devicetree is unnecessary, takes up space, and causes DTS validation
>>>      > to fail because binman is not part of any standard devicetree schema.
>>>
>>>
>>> This is great, and I look forward to this landing.
>>>
>>> Forward looking and just a little thinking out loud here, forward looking is the device tree format the most straight forward way to describe the requirements for this? I wonder whether something like toml or even the in tree env format [1] might be better suited?
>>
>> I was having these same thoughts. And if we were starting from scratch, yes
>> I would have advocated for a different source file format as well. Changing
>> it now though would be quite disruptive to those depending on it. I think we
>> would need some motivation more than "devicetree is not the best choice" to
>> justify changing it at this point. And even then the devicetree format would
>> need a long phase-out period to give people time to adapt.
>>
> 
> You can always have a conversion tool from DT to whatever format you want as a way out.
> 
>> At the very least though, it could be nice to eventually move the binman dts
>> source files out of the arch dts folders to make the separation more clear.
>>
> 
> I loathe magic stuff and it's already confusing that -u-boot.dtsi files are automatically added based on some patterns (that most people are unaware of, hence the bunch of -u-boot.dtsi files that only include another -u-boot.dtsi file). So, from yet another location? Don't know if it's a clear win for user experience.
> 
>>>
>>> To be absolutely clear here, I think this series should proceed and I'm not necessarily asking you to do it, more just gathering ideas/opinions.
>>>
>>> Peter
>>>
>>> [1] https://git.u-boot-project.org/u-boot/u-boot/-/blob/main/board/raspberrypi/rpi/rpi.env?ref_type=heads <https://git.u-boot-project.org/u-boot/u-boot/-/blob/main/board/raspberrypi/rpi/rpi.env?ref_type=heads>
>>>  
>>>      > Currently, only Xilinx is doing this kind of separation. This series
>>>      > makes it possible for more platforms to adopt this separation. The first
>>>      > patches fix binman so that the image gets the U-Boot control devicetree
>>>      > rather than the binman one when the two are separate binaries. And they
>>>      > make BINMAN_DTB work with OF_UPSTREAM, and document the recommendation.
>>>      > The remaining patches update the MediaTek Genio targets to make use of
>>>      > all of this.
>>>      >
>>>      > Signed-off-by: David Lechner <dlechner@baylibre.com <mailto:dlechner@baylibre.com>>
>>>
>>>      My more direct concern with this series is, who has some review cycles
>>>      to step up and co-maintain this tool? It's already been privately
>>>      suggested to me that we could drop the lofty "one tool for every project
>>>      to rely on" goal since most projects continued to develop their own tool
>>>      for assembling binaries anyhow. And that in turn reduces the scope. But
>>>      it's still an important part of the project and so needs some people
>>>      looking after it with a more global eye.
>>
>> I might regret this as I am as overwhelmed as anyone else with reviews these
>> days. And this is my first time touching/using the binman code so I don't
>> know much about it yet. But it seems like this is relatively low volume and
>> I know Python very well and this seems like pure software so I don't need
>> any specific hardware to validate it. So I could try to help here for the
>> time being.
>>
>> As a fair warning, I do tend to want to be a bit heavy-handed with my own
>> changes when I am the maintainer. The current binman code looks to me like
>> Java written in Python 2, which I find a bit painful to read. I would want
>> to "clean it up" with modern automatic code formatters and linters as well
>> as add type hints to make it easier for me to read and understand so that I
>> could maintain it with less effort and also to find latent bugs.
>>
> 
> Please be mindful of the minimum Python version we should support. I think we still support OpenSSL 1.x for example (also by the fact that it's the interface used by LibreSSL I think?). I have no clue what version of Python we want to support, but we're typically supporting stuff well past their end of support date.

Of course. I saw (like Tom already pointed out) that 3.7 seems to be the
current minimum.

I would not have though about SSL versions, so thanks for pointing that out.

> 
> The code is extremely convoluted. Fortunately, there's good test coverage, so doing incremental changes and still having the various tests pass should help refactoring stuff.
> 
> Type hints will be an issue as there are some (notably list) that were added only in very recent version of Python.

The typing_extensions package helps with backporting new typing features to
older Python. And with `from __future__ import annotations` a lot of it isn't
evaluated at runtime anyway, so shouldn't break things either. 

> 
> What I would like you (or anyone) taking over Binman to do would be to actually document how binman works internally, not only the user interface. It currently takes too long to even know how to start patching Binman, which makes people unable or not wanting to get involved with Binman at all, let alone review or maintain it. I for example discovered that Binman generates four times the same image, c.f. https://lore.kernel.org/u-boot/04fd00f4-1bb6-4a29-8e1e-83cdc1b03b74@cherry.de/ and I couldn't figure out quickly why so.
> 
>> I also see there is an active fork of binman at [1]. So I would be in favor
>> of letting that be the ambitious project and trimming down the in-tree code
>> to only what U-Boot needs.
>>
>> [1]: https://github.com/deinde-dev/binman
>>
> 
> FYI, deinde-dev is managed by Simon.
> 
> Cheers,
> Quentin

