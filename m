Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD1FDC55ABF
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 13:04:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 765DA83D5D;
	Fri, 20 Feb 2026 14:04:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bFy/zJcH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B60E683AC5; Fri, 20 Feb 2026 08:35:55 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 718C283936
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 08:35:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4806bf39419so20103015e9.1
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 23:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771572952; x=1772177752; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PEclFT5nF9BwPGuh7qX/ppGJbKKdCpFs+fT6xqb67hE=;
 b=bFy/zJcHle5PFceDt5twi0KkkUdAxpCYv1oCKmwY3c4UuZLGQn1HLLvpmpf51GWImJ
 /n7oYadFfhTb6PThy1DYvDYRSnl9gcUHATi22wKujV/Q3F2T2VZWI6kArl3BzKEbR8NT
 fSjrZUtJYTPcWcVFOXd33zlbhoIhkWXq0uilYNbJQQqddAsODZhEeugqRlDZK6lxt5WS
 JPQn0SIx1GBSEHg1GH9aiTJlnJBmVWdybUyc7tn1uVGIrSvS8XG9eb4k9yn21/zWdsif
 xojb/VujGGslA0W4kGxQC5Tafgkp3Aka4beOxLZGn4TTJDCyDoMVqDlJjHEDhP7yFZTZ
 R02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771572952; x=1772177752;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PEclFT5nF9BwPGuh7qX/ppGJbKKdCpFs+fT6xqb67hE=;
 b=chnbPzNmn5qiOLAKRf43nsKNic4xJgxmr/+EPM0tV1ebSewSXJUJUhhzaB029B5mHC
 jhOgtA6b1Xt4DSad2ziFMFNWTKSpGT/PmjMg/McLxefplnwFqVTVw+vPb0g/me9RX46/
 akR9xYRZSwcBC9aFEQSnBr7xqbln6qv1sUWni70iLEcoY6JYq616TRcpxdkJ8aSGTB/5
 w/ypMw2geQnNb1s6kKmLFAT7g7jfyT9mjSRzzZ/PUbdTWvkyrEh0sQnRs1zGZcw/fe8n
 d3hLEfEyjHPjZwKYX0Yt9QnSECeWaPuBXaMg9+aQqm1ON322pGGYt15VQoQOmTHawF+s
 381A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaa9KfOrBxDguywqccrGbipqn1h1AkbBhNwPNgDmGUyQnyaO3Qp2tTg2B9Si56TEFID3viZu0=@lists.denx.de
X-Gm-Message-State: AOJu0YzYS6DaIFl4SKsC+coxcZ2CCJrEA4U9qQqHTcBBIKxcDfAsloF1
 8wGQwSWR7whL+tHyJ3DNuIbmDcT3YZUsBUgmrerI2mGcmmiwtKEOKkwdM3NGLxaTP7c=
X-Gm-Gg: AZuq6aKOU27kHHSW8Cjh9d8E0d92T3z3K8QorvOW6FeKqW37lMOdMubEbePrmM1d+l1
 FMeDk4UyMdlLAFvgaV0poMP4ZBcGgPzA3FQCWLFaijpMw1hsYhQD3YerESMyNHQIiNtKCMbdKXh
 F0pD3R6rpzRU4IRf7KIokB11C0gVa06u4rck3OE1numNL/bOibia7bsFZKZ14tjRMaErsbn3Qu8
 S4lDhzwTFHfnWEe0t/7MvX1h0W53S3iwYNM7mX6APoFmMxJAaQf+Ysg/kMuG5IDNKja/b9vc+X7
 U/JztoOZm6H9QINXzf7aqdeaSGw2g5MiTnfiWo2tALk3FGuemoScEJX3NC3Arq78jQMOVkdIr9e
 EJpeycuJfPYibIqls7r/4Xl1UU2481Qka+00ENyV0B25j1lEa20GRAe8TY/dCneLP7XVV3RQsAm
 iyVYnH8gA+7o8HhuY322ECSZFGDLXg3nxTNvuS6c8VsdI=
X-Received: by 2002:a05:600c:6383:b0:477:9890:9ab8 with SMTP id
 5b1f17b1804b1-483a5621e7fmr12145455e9.3.1771572951784; 
 Thu, 19 Feb 2026 23:35:51 -0800 (PST)
Received: from [10.11.12.108] ([79.115.63.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31b0e63sm94080555e9.2.2026.02.19.23.35.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 23:35:51 -0800 (PST)
Message-ID: <c1d92200-1099-4d8a-aae1-293cd1ee3f41@linaro.org>
Date: Fri, 20 Feb 2026 09:35:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFH] SPI and SPI-NOR patch help
To: Tom Rini <trini@konsulko.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Michael Walle <mwalle@kernel.org>, Conor Dooley <conor@kernel.org>,
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
 <46b5a69c-f589-4c4e-99e8-6bf0c41be573@linaro.org>
 <20260219205726.GP3233182@bill-the-cat>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20260219205726.GP3233182@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 20 Feb 2026 14:03:59 +0100
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



On 2/19/26 10:57 PM, Tom Rini wrote:
> On Thu, Feb 19, 2026 at 02:13:24PM +0200, Tudor Ambarus wrote:
>> Hi,
>>
>> + Pratush,
>> + Vignesh,
>> + Marek,
>>
>> On 2/18/26 11:23 AM, Miquel Raynal wrote:
>>> Hello Tom,
>>>
>>> On 16/02/2026 at 09:31:10 -06, Tom Rini <trini@konsulko.com> wrote:
>>>
>>>> On Mon, Feb 16, 2026 at 09:21:55AM +0100, Michael Walle wrote:
>>>>> On Sat Feb 14, 2026 at 7:58 PM CET, Conor Dooley wrote:
>>>>>> On Fri, Feb 13, 2026 at 10:46:07AM -0600, Tom Rini wrote:
>>>>>>> Hey all,
>>>>>>>
>>>>>>> To be blunt, U-Boot needs help with reviewing and maintaining the SPI
>>>>>>> and SPI-NOR subsystems. We haven't had someone with time to actively
>>>>>>> work in this area for some time. I'm going through the outstanding
>>>>>>> changes now, but it also seems a common problem is that with respect to
>>>>>>> device IDs, most of the new ones also aren't in the upstream Linux
>>>>>>> Kernel. Is there some better and generic solution we're missing so that
>>>>>>> we don't have large and often growing device ID tables? I'd rather not
>>>>>>> make that problem worse, so I've rejected two of those types of updates
>>>>>>> today and I'm just setting aside a large number of others.
>>>>>>
>>>>>> Dunno if your timing was cursed on sending this, but Tudor submitted his
>>>>>> resignation from spi-nor maintainership in the kernel about 10 mins
>>>>>> after.
>>>>>> I think Michael Walle might be responsible for what you're talking about
>>>>>> here, with his 773bbe1044973 ("mtd: spi-nor: add generic flash driver"),
>>>>>> but idk jack about spi-nor stuff.
>>>>>
>>>>> Yeah. Nowadays SPI-NOR flashes come with self describing tables,
>>>>> which are already supported by u-boot, I think. The only change that
>>>>> seems to be missing is the fallback to it if an id isn't found in
>>>>> the flashdb. Only thing is, the SFDP doesn't describe all features,
>>>>> most prominent example being locking. So if you need that, you'll
>>>>> still need to have an entry per flash.
>>>>>
>>>>> In fact, in linux I'm planning to change to make it probe SFDP first
>>>>> and then amend it with the flashdb information (if there is an
>>>>> entry).
>>>>
>>>> Thanks for explaining. So in that U-Boot does have SFDP support, the
>>>> first thing is platforms should likely be enabling that instead of just
>>>> adding IDs, at least for basic support.
>>
>> Right.
>>
>> SFDP is behind a config, because of size constraints I assume. And then we
>> also have a tiny duplicate version of the driver for stricter size
>> constraints. Are these size constraints defined somewhere? We need to know
>> them in order to choose a direction. 
>>
>> Also, I'd argue that having the tiny version of the driver was ideal.
>> Instead we should have tried to modularize SPI NOR, by SFDP, static
>> initialization of flashes, manufacturer drivers.
> 
> Some platforms define their overall size constraints, and so we know for
> sure a hard limit even in full U-Boot. More platforms do this for SPL,
> but not all. So the general answer does end up being that we always care
> about if there is a more size-considerate solution with minimal
> trade-offs. Especially since we are also in a more minimal overall
> space.
> 

Thanks, Tom. I get this. I was curious about some numbers, but probably a
good reference is the size of spi-nor-tiny.o. My point is that if we try
to modularize the SPI NOR core we might get a chance to strip it to a
spi-nor-tiny equivalent. This would reduce code duplication and
maintenance cost. 

In what concerns the flash IDs array that keeps extending, that can be
indeed mitigated by implementing just the BFPT (Basic Flash Parameter
Table) from the SFDP (Serial FLash Discoverable Parameters) table. So for
SPL we would have a minimal core with a minimal SFDP (just BFPT or parts
of it) that can handle the basic support for all flashes that define BFPT.
We won't need to add new flash IDs for flashes where we want just basic
support.

Unfortunately I currently don't work with MTDs so I'm not interested in
implementing what I'm suggesting.

Cheers,
ta
