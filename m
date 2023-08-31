Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA840C83F17
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 09:57:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 212D486558;
	Thu, 31 Aug 2023 11:57:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gTKsvT30";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE35386556; Thu, 31 Aug 2023 11:57:26 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6C608655E
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 11:57:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-31781e15a0cso444792f8f.3
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 02:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693475843; x=1694080643; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/rc0YMuA759+/2oRgVFMGxN8hXPb905Cbo0CXqBS7IM=;
 b=gTKsvT30HJhnMi5E4sXkbgpKw585KN/voOBqE/5PZW3fItmr7qrTtR0jrvdjom2bX7
 c4AWu60R6qHl/q785lj5uwPixC5aSIgN6gNjOMbd2Hdt8DKts+oE4Lcf9f0OFui/0dQk
 wzEEaPiSCNaAwcZxP1EbLlEKsHnW9OzWhMiwPXW3fpxp7VnUga/g5PRctahIH8ay6MiC
 IWQV/1KDNCy6/KsmAjV72WAtGvpoCtRMnnXAopKTQ7Klbq5gcAYACJimsvP6HV15iLTu
 cYUkIMzse3q5X0EAWV5osjR7Quzw0jfKGx4OFdn+fvmF6E4uiq+hjynYHEteusGoMbZv
 hr4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693475843; x=1694080643;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/rc0YMuA759+/2oRgVFMGxN8hXPb905Cbo0CXqBS7IM=;
 b=YaSTi974z8ohEwoE3bTlT/ebmTWRW3ys2nM8UQ9yYi+yikFecawElyfreOqm9jQUML
 LYswu7pWc34tcglJOqp/YxzPCTOzQW8nUooDp27NEepSRiDgM6sbXKw/yFezIol5N9IU
 O5R3KaMEFRhcifYsWQnBwvmi4M7cUsl8ja7SWdPobZtVxk1Hw95F18K7feKqhvd6nOXa
 /pqXyE5CO76xO+l2D544giPemWmOfm6GHq5gzT4cx1cJfVpZODvRLltGcLDQUwCVLR1k
 aZln4H2b0saGxDpnAyw2mvYJYfYrLqv+ePE9alEdFJ7tl2xA7StexIpM5weIrG48lgQC
 ishw==
X-Gm-Message-State: AOJu0YzFh6+EgYdTGpkplE4hDD3tUBR+oV2xWEDuxEpdGjkoQ8yHPdbx
 kGXZqk0B1v5rqRLB04hw6GU=
X-Google-Smtp-Source: AGHT+IFW0uLSZyEJZWLuwYD4qzPBEF/ADoqVY+SRZNE+Cm0+lqgrnm0Z2K/QLBbXEwB9JAxcrJXaIA==
X-Received: by 2002:adf:fc07:0:b0:31c:6697:6947 with SMTP id
 i7-20020adffc07000000b0031c66976947mr3322407wrr.69.1693475842926; 
 Thu, 31 Aug 2023 02:57:22 -0700 (PDT)
Received: from [192.168.0.84] ([178.233.24.1])
 by smtp.gmail.com with ESMTPSA id
 r5-20020a5d4985000000b00319779ee691sm1631876wrq.28.2023.08.31.02.57.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Aug 2023 02:57:22 -0700 (PDT)
Message-ID: <7dc5a62f-28e1-4318-a14a-53702c26a5c2@gmail.com>
Date: Thu, 31 Aug 2023 12:57:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] doc: qemu: arm: Add a section on booting Linux
 distros
Content-Language: en-US, tr, en-GB
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng@tinylab.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Bharat Gooty <bharat.gooty@broadcom.com>, Stefan Roese <sr@denx.de>,
 Qu Wenruo <wqu@suse.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Bin Meng <bmeng.cn@gmail.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>
References: <20230814173944.288356-1-alpernebiyasak@gmail.com>
 <20230814173944.288356-5-alpernebiyasak@gmail.com>
 <CAPnjgZ2d1mJp28UP2+zKC6+2pED_=YdovA_jaNJz2r+C=-jufg@mail.gmail.com>
 <8add4068-7b05-4f32-8eb7-31366fb396b9@gmail.com>
 <CAPnjgZ2=tgDhXhm70RXcdXdJctJVqhO1vmH_==1N5YyzNH5cDg@mail.gmail.com>
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
In-Reply-To: <CAPnjgZ2=tgDhXhm70RXcdXdJctJVqhO1vmH_==1N5YyzNH5cDg@mail.gmail.com>
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

On 2023-08-28 20:54 +03:00, Simon Glass wrote:
> Hi Alper,
> 
> On Sun, 27 Aug 2023 at 09:49, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
>>
>> On 2023-08-15 01:43 +03:00, Simon Glass wrote:
>>> Hi Alper,
>>>
>>> On Mon, 14 Aug 2023 at 11:40, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
>>>> I actually want to put the root.img device first so that the VM can boot
>>>> into the installed system when it reboots, but U-Boot can't find the
>>>> bootflow on the second drive. I tried e.g. `bootdev list -p; bootflow
>>>> scan -lab`, but it seems to only ever search the first virtio-blk.
>>>> However, `eficonfig; bootefi bootmgr` makes it boot somehow.
>>>
>>> Yes, this is annoying.
>>>
>>> The problem is that the scanning is getting so complicated. The
>>> boot_targets var lists things which can either be a uclass, or a
>>> uclass with a device number. The currently implementation sees
>>> "virtio" and moves on to the next thing in boot_targets once it has
>>> processed one virtio device. That is obviously not correct, but...
>>>
>>> Would it be possible to just drop the 'boot_targets' var? That is what
>>> is stuffing it up, but we don't actually need it now. The defaults end
>>> up doing the same thing, apart (perhaps) from the strangeness of
>>> virtio which can be both a network and a blk device.
>>>
>>> I believe it is possible to do the right thing, but I'll need to
>>> create a better test mechanism to handle all the cases.
>>
>> I think some kind of a "priority score" could help -- iterate over
>> boot_targets first just to generate bootdev priorities, then carry them
>> over as bootflows are discovered (adjusted for bootmeth order), then use
>> those scores as the order to boot / to show a sorted menu / to test?
> 
> We sort-of have that, in that bootdevs have a priority. We could add
> something to struct bootflow which takes that but adds more
> fine-grained information, e.g. based on some sort of filter function
> that can decide?
> 
> Bear in mind that we normally want to boot the first thing we find,
> and we also want to use lazy init (so no USB unless we need it). But
> yes for the case where we display a menu I think we could make more of
> the priority feature. What are you thinking of?

For the priorities, I'm thinking of ChromiumOS boot flow where there is
an in-method order that's different from the order we encounter things
in. And I'm also thinking of customizing boot order for same-uclass
device (I guess boot_targets="usb1 usb0" works?). And a bit worried
about if we would want to mix and match orders. If we say methA > methB
and dev0 > dev1, do we say methA-on-dev1 > methB-on-dev0 or the other
way? Not sure if I make sense here at all, need to think more on it.

In general, what I want is a graphical boot menu like rEFInd [1], but
more specifically with a better theme more like [2]. Or, at least to
support rEFInd better. (More bugs here, upstream builds don't start at
all with U-Boot, Debian builds boot on arm64 but not x86).

Regarding lazy init. If we don't init USB, rEFInd can't search USB
drives to boot things from it. Not sure if that's a fundamental problem
or there's some way for EFI apps to tell firmware to init USB etc.

[1] https://www.rodsbooks.com/refind/
[2] https://github.com/bobafetthotmail/refind-theme-regular

> BTW, even for the menu, my original vision was that the menu would
> display immediately, with new bootflows appearing as they are
> discovered.

Shifting list elements around while people are choosing from the list is
definitely not good, only way that could be OK is if the list was
append-only and not centered-in-append-direction.

We should be displaying a priority-sorted list, I'm not sure we can
guarantee we will add things in priority order, and I would like things
centered as personal preference...
