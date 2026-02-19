Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB69E9A04A
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 13:38:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E36C83F2A;
	Thu, 19 Feb 2026 14:37:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZT5IZxN/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93A8683A47; Thu, 19 Feb 2026 13:13:29 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C44182A9E
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 13:13:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-4362507f396so930283f8f.0
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 04:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771503206; x=1772108006; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Jls7aeWU9Cty/KoowWUKVX9UY0JBq8H/U2kjWu9XfsY=;
 b=ZT5IZxN//eec6s8uwDSWnxr4ljH0GuteDXBmH9lYEjQYDdQNuUAwIWlJSCv3UgcY9G
 1gpqYK8jdqbJe53XJ+vs55HCS3X/tXeJdqQRn/g0BCTYSxzBRvkIoq8hw/D5u+4P6yYo
 dnCn1axwGUoSPg6J6WxgBqP0CAUODV73VIL4HNcpOQ2ekyTnN+SWW93DQU2hAZjlQjkh
 1ClxmkOlIYgzGbdzb9s2qBuSchsp7sGgZwvXLQSD93FTZu2KIGpLKuo1c0tqhcpWx7yH
 +x08mk7+apb9ErZGjzZnfWXqvaCH8ertE7/3Ku9Qrzks+yeeRUzooxGP3wDls4HSXrFP
 AYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771503206; x=1772108006;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jls7aeWU9Cty/KoowWUKVX9UY0JBq8H/U2kjWu9XfsY=;
 b=tqj+hKPPqkjLIYrU/odMjvQtRIvC5NBG6hjj2pB+O7K1a/0R7cy108eXctpFa9KBpt
 yJ917stIeiQWuCwfUFulRVtMfDcsK05IMm1n9ZJ9qKvkZ821bMAufcVDt6InD0j6Yw09
 ceY6puASAt4TTk8zw0AX93zB1N5QchBhLRhCue2k8jiKl6PlcJWa2c3JYF8PiLzIuT/C
 y9F764fjv26WsqI5atroRunAdB6ClHgONeFWy5PkdCD67HAYvF+Q/rs7ebZQIubeUQPg
 Qz0AaSEegozybUrjvLtPxwmNaTL6CXcZuOsBXc2A7hxFW5zKGc5zd56+4a+uwjTQmZh9
 AjyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXC8Dvjj1xtYATCSei5YzmQJydikQZl2Y+Dyo1OPS6KXfJ6eLF03rXFmULG0uEwoy8UfIAgSgM=@lists.denx.de
X-Gm-Message-State: AOJu0YyhXNulA8XQ8AzkXMySsuqjmfxwYoZ2s55fKngyLWBWFT74DOPH
 vHs/GcAJswRX7Q/gLguBs3PQYEFk34c8roppNMP0vyaGU522XV8kbdtFDbsrn5wXFn8=
X-Gm-Gg: AZuq6aKFU/ICbQjEJ//xkdEO1RCeftIWxuvMkLq3pJVuI+SfFA7ePFZ+WkGHS7MSFDh
 exR7M5Jr5XicGtMlOUfDRAYfom9DLKWknpw06UYC6HDgaTcIXJT0bdx469gEZgIuErYdLuTX/Jc
 qSb8lobjRtLeWBwd1iktBNAKvZ0nuJsB4bwJxCTghchJZ0b2ULcBXF9MkbNWlkpb1xcGhah5W0m
 o3lnrr129jrTu9lYT9LCQCCl1Kyft/eSgQnJJmvqYLwD24oivJkdnkg9HpY5RWjcLUCJQ4RBRBO
 075o7dwnR0THlVu5Tv1+f+GiBVK5l15zJlm2LZbBKVXf5xtH6JGYAmhkZbpRaXCsWeK0me2usKN
 qeDOBvR7GrsQmN6Hjvkt4jl7qR56DXrSCwygToTa8J/I27fGAqmZGZriG29PsyFE2zC+5NdkSut
 0SPFU3G+mQ+4D4+ghqPdg/PXXci3aOcAAE
X-Received: by 2002:a05:6000:40cd:b0:437:712a:fab5 with SMTP id
 ffacd0b85a97d-43958e4048dmr9595668f8f.35.1771503206328; 
 Thu, 19 Feb 2026 04:13:26 -0800 (PST)
Received: from [10.11.12.108] ([79.115.63.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a6a5e5sm46085119f8f.9.2026.02.19.04.13.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 04:13:26 -0800 (PST)
Message-ID: <46b5a69c-f589-4c4e-99e8-6bf0c41be573@linaro.org>
Date: Thu, 19 Feb 2026 14:13:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFH] SPI and SPI-NOR patch help
To: Miquel Raynal <miquel.raynal@bootlin.com>, Tom Rini <trini@konsulko.com>, 
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Cc: Michael Walle <mwalle@kernel.org>, Conor Dooley <conor@kernel.org>,
 u-boot@lists.denx.de, Hiroyuki Saito <Hiroyuki.Saito2@infineon.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Prasanth Babu Mantena <p-mantena@ti.com>, Vaishnav Achath
 <vaishnav.a@ti.com>, Prasad Kummari <prasad.kummari@amd.com>,
 Pratyush Yadav <pratyush@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20260213164607.GI2747538@bill-the-cat>
 <20260214-sternness-cling-4259916a8f73@spud>
 <DGG8OA1O1UEL.12RR559TX4XX6@kernel.org>
 <20260216153110.GV2747538@bill-the-cat> <87bjhmv20f.fsf@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <87bjhmv20f.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 19 Feb 2026 14:37:09 +0100
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

+ Pratush,
+ Vignesh,
+ Marek,

On 2/18/26 11:23 AM, Miquel Raynal wrote:
> Hello Tom,
> 
> On 16/02/2026 at 09:31:10 -06, Tom Rini <trini@konsulko.com> wrote:
> 
>> On Mon, Feb 16, 2026 at 09:21:55AM +0100, Michael Walle wrote:
>>> On Sat Feb 14, 2026 at 7:58 PM CET, Conor Dooley wrote:
>>>> On Fri, Feb 13, 2026 at 10:46:07AM -0600, Tom Rini wrote:
>>>>> Hey all,
>>>>>
>>>>> To be blunt, U-Boot needs help with reviewing and maintaining the SPI
>>>>> and SPI-NOR subsystems. We haven't had someone with time to actively
>>>>> work in this area for some time. I'm going through the outstanding
>>>>> changes now, but it also seems a common problem is that with respect to
>>>>> device IDs, most of the new ones also aren't in the upstream Linux
>>>>> Kernel. Is there some better and generic solution we're missing so that
>>>>> we don't have large and often growing device ID tables? I'd rather not
>>>>> make that problem worse, so I've rejected two of those types of updates
>>>>> today and I'm just setting aside a large number of others.
>>>>
>>>> Dunno if your timing was cursed on sending this, but Tudor submitted his
>>>> resignation from spi-nor maintainership in the kernel about 10 mins
>>>> after.
>>>> I think Michael Walle might be responsible for what you're talking about
>>>> here, with his 773bbe1044973 ("mtd: spi-nor: add generic flash driver"),
>>>> but idk jack about spi-nor stuff.
>>>
>>> Yeah. Nowadays SPI-NOR flashes come with self describing tables,
>>> which are already supported by u-boot, I think. The only change that
>>> seems to be missing is the fallback to it if an id isn't found in
>>> the flashdb. Only thing is, the SFDP doesn't describe all features,
>>> most prominent example being locking. So if you need that, you'll
>>> still need to have an entry per flash.
>>>
>>> In fact, in linux I'm planning to change to make it probe SFDP first
>>> and then amend it with the flashdb information (if there is an
>>> entry).
>>
>> Thanks for explaining. So in that U-Boot does have SFDP support, the
>> first thing is platforms should likely be enabling that instead of just
>> adding IDs, at least for basic support.

Right.

SFDP is behind a config, because of size constraints I assume. And then we
also have a tiny duplicate version of the driver for stricter size
constraints. Are these size constraints defined somewhere? We need to know
them in order to choose a direction. 

Also, I'd argue that having the tiny version of the driver was ideal.
Instead we should have tried to modularize SPI NOR, by SFDP, static
initialization of flashes, manufacturer drivers.

> 
> Yes. There will be the need for IDs anyways, for those "extra" "non
> sfdp" features, but that should reduce the load. For example, shall we
> consider block protection in U-Boot or not? This is a useful feature,
> but at the same time, do we really need it in a Bootloader? This is open
> to discussion.

If you have write capability in u-boot, having block protection is useful
to avoid inadvertent writes.

> 
>> It still leaves us in a bad spot
>> about having SPI and SPI-NOR stuff reviewed and maintained, but at least
>> it's clearer in public now where it stands.

Takahiro recently accepted becoming a designated reviewer for SPI NOR
in Linux, and I think his expertise would be highly valuable in U-Boot
as well. Takahiro, if you have the bandwidth, would you be open to
becoming a designated reviewer here too? Or maybe see how things are
going in Linux first? No pressure.

Cheers,
ta

> 
> I guess spi-mem and SPI NAND is also in this kind of situation, even
> with the Amarula crew doing what they can to improve the situation.
> 
> Thanks,
> Miquèl

