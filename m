Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E178DE77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 16:14:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DB858060C;
	Tue, 14 Jan 2025 17:14:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SFJQf5DQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB8788022E; Tue, 14 Jan 2025 17:14:56 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 394D78022E
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 17:14:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=cnsztl@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2164b1f05caso101479095ad.3
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 08:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736871293; x=1737476093; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v2u58ssit771NMsId1nthOUvRo/vKSKLzTMUGdR2QG0=;
 b=SFJQf5DQbwqnGUu9P8iR1ltVFc+bNHX2TO7OvzccjWFargLffXO9V/ipMWukdmd2I0
 +9b5OCBwlbtnud0wFjp783dFw0EjgTZzvLDelrawWA9Z8jR+HlKKMmGQHE9z6J1BnmxE
 Fo9st1Ow3yp+AcHIGQTlcyspsUFBf7ehHGZgt2nxFNPy2WalpkMpVPoo/MNnSftEyhl0
 8rKvTv887fzfGLdOj9uxPQ5xcpJm84qgyBcHrfj+CRF0hh/We68UDGYzF9iD1RuRgPa8
 JXPRSgPZK5yY/C4i/HZdIYXSL2uh+1lN5BcJNUi0iD58Gj17Njw1vkzh0DO7j1U6pnjS
 mF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736871293; x=1737476093;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=v2u58ssit771NMsId1nthOUvRo/vKSKLzTMUGdR2QG0=;
 b=A4GZ59FQF/c+A3wNBx6/Kr2CH/x51QOZKnQUw2i7yE4sv9bxIFRszq7SJ41kHz4Ai8
 Uef/z+QVpnBFrhBlFXpCa78H5yaXWfzApr8TE+h69SlRJO1+Rm5XdsIvgr6H0WG4tOKn
 GoC4Khs59WqHgHl4XvnYJMj+UUBjo1bijIr7y2No/pFKH+9C3OOWsKfgO8UZzA7Za+Da
 nBiXe61xEjcjxquUGBuKOAZj9ndZdZA9T/qIFjv0EkBMtHYzXnoe3jSh1cRBV24SJ2i7
 VOp3htEOuUoFvczdq4uL/HXfcV668YFFjyLNjrUzPGv9YSt/rZ3ppYTzsrHbzk+Y4wt6
 /jMQ==
X-Gm-Message-State: AOJu0YwFHof+EXzR6VfwJr1NP3zVYGHlhIhxB1Q7gLUyklnAp/ajpUtY
 KCvj6SHspoYp1B4TGddOaXbhVov+N2cpLDPKx2JDBgcMowsiigWU
X-Gm-Gg: ASbGncug5L5Adyp2G4YhAUVYhUjEGoCZezBT4dM5widDuByrnQjGXCmatGbFf6DUHQf
 lp70x1HHtO0hmr86lhzp2pKjumhpseLNgyRuZS4nrmI86eNAvJUmKdORbazINmFEs0Z/xBullDV
 o54RTGA5EBgHso8ZG1ofRRnMBczoZaQJWDUnptLQ4oK/lxdOdYzyh8O6S68FrPhIucpq/je0ooB
 WXGiqj3oYkZRxsrwqw1/K4EKEQBtc4oa/McEYDYKuq9HiGaPE65J9RCXsCnq0SZB/l8bfVrPnOF
 YThPm0RyJP27UmAF9mPrNPI=
X-Google-Smtp-Source: AGHT+IGNuYgjhgoLFWTvrFbU96loXKB2WwdUBw6ZBfS5qayAGuGaH5WQjv6RHIuJftv41pXRR2DTPw==
X-Received: by 2002:a05:6a21:3a42:b0:1e1:b12e:edb8 with SMTP id
 adf61e73a8af0-1e88d0a9373mr47321800637.30.1736871292230; 
 Tue, 14 Jan 2025 08:14:52 -0800 (PST)
Received: from ?IPV6:2408:8362:245d:4738:bc4b:53ff:fead:2724?
 ([2401:b60:5:867d:3631:b7db:c3f4:aae2])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72d406587a1sm7822966b3a.105.2025.01.14.08.14.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 08:14:51 -0800 (PST)
Message-ID: <b0af95e7-1e4b-4630-8355-d4218896ace6@gmail.com>
Date: Wed, 15 Jan 2025 00:14:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] board: rockchip: add FriendlyElec NanoPi R3S
To: Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass
 <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
References: <20241226092043.419511-1-cnsztl@gmail.com>
 <2b658c60-480f-4488-8c40-f781a849cb32@cherry.de>
 <5d2fb256-cd0a-4a94-ba9f-f13a928656ed@gmail.com>
 <5f42abef-4aad-4f57-8396-6d8d17a89285@cherry.de>
From: Tianling Shen <cnsztl@gmail.com>
In-Reply-To: <5f42abef-4aad-4f57-8396-6d8d17a89285@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Quentin,

On 2025/1/14 23:21, Quentin Schulz wrote:
> Hi Tianling,
> 
> On 1/14/25 3:49 PM, Tianling Shen wrote:
>> Hi Quentin,
>>
>> On 2025/1/14 22:39, Quentin Schulz wrote:
>>> Hi Tianling,
>>>
>>> On 12/26/24 10:20 AM, Tianling Shen wrote:
>>>> The NanoPi R3S(as "R3S") is an open source platform with dual-Gbps
>>>> Ethernet ports designed and developed by FriendlyElec for IoT
>>>> applications.
>>>>
>>>> Tianling Shen (7):
>>>>    arm64: dts: rockchip: Add FriendlyARM NanoPi R3S board
>>>>    arm64: dts: rockchip: fix model name for FriendlyElec NanoPi R3S
>>>>    arm64: dts: rockchip: replace deprecated snps,reset props for NanoPi
>>>>      R3S
>>>>    arm64: dts: rockchip: sort props in pmu_io_domains node for 
>>>> NanoPi R3S
>>>>    arm64: dts: rockchip: enable eMMC HS200 mode for NanoPi R3S
>>>>    arm64: dts: rockchip: reorder mmc aliases for NanoPi R3S
>>>
>>> How did you backport the above patches?
>>>
>>> ./tools/update-subtree.sh pick dts <commit>
>>>
>>> is the tool to be used, it should have added a
>>>
>>
>> Thank you for the tip! I did not know there's such a script and
>> I just copy&paste the commit message from linux tree manually.
>>
> 
> Mmmm, how did you apply the patch in your tree then? Trying to figure 
> out how we can avoid this in the future.

I fetched the patches[1] as-is from kernel and applied them by `git am 
-3` with path correction, then maually added the line "[ upstream 
commit: xxxxxx ]" to commit message.

1. 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/patch/?id=50decd493c8394c52d04561fe4ede34df27a46ba
  
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/patch/?id=b5bf84206a5c77528f9dd4cbca4e72caa063c102
  
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/patch/?id=82b2868937883b65732da498b26366d34db61510
  
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/patch/?id=17e150fdd983c7e59b9240e34a166285f3c3fb39
  
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/patch/?id=1b5365034410f1ca21adadadd492b99bdf4f2c55
  
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/patch/?id=b7cd1115456d312f8c5e60c80fdc35fd35ea6eab

> 
> I'm wondering if we shouldn't have tooling in place to detect when 
> things aren't done the proper way (for maintainers I mean). We 
> **really** want to have dts/upstream be upstream + some patches that 
> were already merged in devicetree-rebasing tree. I don't know enough 
> about subtree merges that Tom does when updating to a new tagged release 
> to know if it's actually safe or if the possible mistake made when 
> applying a commit by hand can persist without us noticing. I guess a 
> mistake made in a manually applied patch would be caught by Tom during 
> the merge from the next release with a merge conflict, but then that's 
> pain for him to debug.

I'm really sorry for that. All of those commits were already landed on 
devicetree-rebasing tree so hope everything would be fine.

Thanks,
Tianling.

> 
> Cheers,
> Quentin

