Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA2EC2BD09
	for <u-boot@archiver.kernel.org>; Sun,  7 Jul 2024 00:55:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD4FD884F1;
	Sun,  7 Jul 2024 02:55:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720313738;
	bh=ndP8+0nV+oaJjJuOJpAcmNQirEZAODAvZBVTUC1Pnd8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yXGmQcAI86gvJ8yrDqahziiJFyYmVvrEBXggQ/NSYm/gXx38Z7uRQ+3TmGCGlcgPX
	 g4ReDYHf+uimelnwPmbsUxBskr7NtHuK6aixmJt78/mJ0HAka8LJn/qRKyFtVvTrTn
	 jELGTHf34vJQ9h+qkQAQtUTD+Neg3b26xa21fiz1bafn03bPb3fugSK8Qa+6sguIdi
	 r7i8RANp9JvJbRYwSaDWBnz4CCRI2SAhB5LN/yLcQYLal2SMkvgPwc1vCQjMKuUdX1
	 O3p96riLjF4QeezPtu47c57rFRXp8p0TKBnIAH3/KCFfGnqu2NPfJpXv0A+LoosR7L
	 51wsaUPXGnwqw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 866908808B;
 Sun,  7 Jul 2024 02:55:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1720313737;
 bh=ndP8+0nV+oaJjJuOJpAcmNQirEZAODAvZBVTUC1Pnd8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=tkTNJwteSNOYeff4Hnv4l0KdMKMrLXsJ2EtS3bDbEY4/pILd/a/11z+kRQqFpNkh3
 tiAlDMgmyjpakeyb0S7g/soEsvHbn+e0QKDVeUIxJ6UyRipW5Tclbspg5+BpQErfvh
 QJFWW8G3t5mRyH3VgKmx30ADKmM6lsA83Lgz+RFFLIkBrTCVSHoExQROIjeWxq3Xpp
 ETxRQNcV3/b8uan8jjwXAwrz+WffrYqgdXNLJfd5nxtUOwX/F3lctJs99n2W3n5Z+F
 bQPbwa5fm4CnSp+zsvb/WVg6ytG9voaaDPbX0HCyPOLyOOljc3d7ByJxnL3iDFF6Ax
 GfxypSJX7DYyw==
Message-ID: <211b7562-c0ca-4d57-9fb0-0305b14b0b66@denx.de>
Date: Sun, 7 Jul 2024 02:29:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spl: fit: List DTOs applied by SPL in U-Boot control DT
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Suniel Mahesh <sunil@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
References: <20240626235857.272264-1-marex@denx.de>
 <d31b4e88-a59c-4ec7-aa05-1293ab8139d9@cherry.de>
 <7c53dff2-9703-4a59-9a90-ec2d64cdb3fa@denx.de>
 <274c876c-4d42-4af4-a68c-5b51c20bfdb8@cherry.de>
 <f873b919-a4de-4d06-9f6c-b964cf0699b7@denx.de>
 <d8d6995c-a66b-45dc-8d1c-3debbb9e757e@cherry.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <d8d6995c-a66b-45dc-8d1c-3debbb9e757e@cherry.de>
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

On 7/1/24 10:42 AM, Quentin Schulz wrote:
> Hi Marek,

Hi,

>>>>> Shouldn't this rather be in /config node?
>>>>
>>>> This is what I had there originally, but then I realized that some 
>>>> DTs might not have the /config node in them (or am I mistaken?), so 
>>>> I moved the new properties into the root node, which surely exists.
>>>>
>>>> It also keeps the code simpler, as it doesn't have to fiddle with 
>>>> creation of the /config node if it doesn't exist.
>>>>
>>>
>>> I don't think we should pollute the root node with this. If we want 
>>> to be able to expose this in a proper binding to the upstream DT 
>>> binding repo, I'm not sure this is going to fly :/
>>
>> The other option is to add more code into SPL, that's not great.
>>
>> I can check if /config node exists, and if so, add it there, otherwise 
>> do nothing. That should be some sort of compromise between bloat and 
>> config node. What do you think ?
>>
>> [...]
>>
> 
> Considering that we're trying to have the same DT for U-Boot and Linux 
> kernel in the long run and that `git grep "\s+config {"` returns nothing 
> in dts/upstream/src, I'm not sure this amounts to anything but 
> dead-code? We could also always insert this node as pre/post process of 
> the DT compilation? But I think some people want to reuse the exact same 
> DTB (like, the binary itself) between U-Boot and the Linux kernel.

In my case, the /config node is inserted via *-u-boot.dtsi , I don't 
think those DT extras are going away anytime soon, esp. because of the 
'bootph-*' properties.

> I guess we can start with checking if the /config node exists and we can 
> figure something smarter once we need it?
> 
> [...]
> 
>>> 2- Add info about which DTBOs were applied to the kernel DTB?
>>
>> SPL DTOs or DTOs applied from kernel fitImage ? Or a merging of those ?
> 
> DTOs that U-Boot proper applies to the kernel DTB either via fitimage 
> configs, maybe also via syslinux (via 
> `fdtoverlays`/`devicetree-overlay`) and the like?

Isn't that something that would be better (=more flexible and fixable if 
broken without bootloader update) done in a boot script which could be 
embedded in a fitImage ?
