Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1F4CD6E55
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 13:45:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A706783A03;
	Thu, 13 Nov 2025 14:45:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="aAKPbVzu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA61C83C62; Thu, 13 Nov 2025 14:45:44 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 564D583956
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 14:45:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A3C63402D5
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 13:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763041540;
 bh=AtJzfdCmO7EXBQTKq/YmIDgcjVKYkeeV282TBe6s6lg=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=aAKPbVzuAvmBHm4Mq3s2ocMQrKgmR338cMoX/6mRD94G58wcQK/25moa5hynXgnqT
 my7O1hpZ5zeG4ePnptPQg1MEseIlAr/Cq/X5AP2nkDOap6sVfUZeGckijl1XOff4mj
 O+kSIeFgUV1XBb21i3JY1o1NsymlGMFE7PiqtSPSYUAcmAFjAefpZbncrKltmJzpBc
 vZFxDLuJ1TWLGNsK8VqfuzC6ovNmzzZvE53T+U9o35Yd5atJ57KnXkt0f4BHTdHUXF
 5afpqn9GGAHvzMpqrpHfEIWMexMUHcWkU3d2jARtDt9MF7wKmCXr7UhUOIVVO+2z4F
 Xus0hTkrC43J3ElKpNXMFSx4IhYT6WQdDglhR6kheNRUj+eoPhw49icvpzrupcGU0N
 oRXRSQVqIENeSEol4rtBtpe+sA9qpiZmBcbx0Q2DkquCI6PF6GYOiw3q4oMb+lbcTo
 HbZjoCmWsUNrI9vhEswRVAY8HfwoSZRP+tlcN1T+qtNFcIik5ENWF08WQ7PaKYVIsx
 +BDqXucyEN8/ZrzsrLViwwgSoyFDdECcfQLgC8I5ghSRSMZnmJioeWVmbEzWzx6cRK
 ZId3uKfTXE6WHqkSgvEqxniy62lwK4VCBH/5RgemqWlWBiKYcwWsRxjOrEZWLiEdkR
 ZD4FBXtsUcF+BvzXwdIHj9Nc=
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-42b2ffbba05so618347f8f.0
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 05:45:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763041540; x=1763646340;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AtJzfdCmO7EXBQTKq/YmIDgcjVKYkeeV282TBe6s6lg=;
 b=MQLoKNu96UXxgBQ13obhWMvzKv/CsEI4Xvz0/YH4xKGgrknH+DPPGQctxi5O00KuqX
 RLhd9mZ3rL+A/BEJDiLvJt5X+0JUjMUF2YD/lu/XNuPSQA2r8mhTm+otO3s73B5/+5a5
 q76LscoSEYyQ5hVTn6jAemCnhmPijTK8tj5hQvlyvdsQVp2CAoUtN5TGNRV02JbQCM5y
 SHRCuHxyGtGeB4h6NlX2kkZAT7/9455Q+tGri7BsMg2ZtTfpysCn9PLqrmY/0tC+Pw0P
 U7RCgnDG8KnUH90dhJEDEeRbV9sLtmVLF2qF7j9HPiHWxOckltHhecaYr2hE3D2Wi4hh
 5khw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUJBPY5zuvG3B7w6iLhw063e7d9Zj3kX6W2Z7N77CkpvIQhF/Dpm+/fBbNuzEsBKqXgdvl/bY=@lists.denx.de
X-Gm-Message-State: AOJu0YyMmFSY66YDkZ7rxVu6PxFhem6b37M7qHd1yUmHXQi7yJ3iHrtf
 MdyZP0M3ufy8V40oDXDOpyu+/1Je4OCGvic+3cY/DEfYsUS3na7bDhmHjo6tU/9W4mob2DB08/q
 D8BhXccLhwhvZ2htJN3LWneRedJeabTCFsIES7urMYnRfRMzfM4sSyLsFrCMEfLT5dJQM+Ow=
X-Gm-Gg: ASbGncsn/qb1ZW0JkqPt+pMZw3pbMV0m5XTAZK2LidajazROeRtnpowDXYwnF5Frr2r
 7MNm4ZiN2dJc9XmBZeJDVP7B9BTqg1wmCfj2NOKy7vvzoBZE3nBQpRrM0YfegXoDDsRPAGuWv9l
 NrLEIKkgjnD5E6BwZ6EHxQm+FaCd09x61IzXlpJIgy0EHeymqcP2UBHjJ/G+WhBzDzFS5CZUHDI
 pYZocRMBF8yGvQ4yLwVwT7pvT0AVP7j0XCJz9lUTHQy8yZa9qiPI9WFS6IeYZyH6oY0MGgW4Yyi
 O81NSvnGwtLGemzyD6Rhrrt+TSlqTeMI2tZhWt7VShOQS003Z1cdx8ZjF1AyrIKNL5mxnbbgjsl
 OvmXAdnfqUzNFoACIiRPjTgzArdLrlw3i5H/u8/K2e3lMkLGGdzp/O6jPfkmgI9aDqw==
X-Received: by 2002:a05:6000:1847:b0:42b:3592:1b88 with SMTP id
 ffacd0b85a97d-42b4bdb8f2amr5959173f8f.50.1763041540118; 
 Thu, 13 Nov 2025 05:45:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPeRpbO12DEx4T87Z1f8dPyJ32GNN4zQPx58wF+Z7XsZOmZxOxkLLDSwMoxxi4I6i/qIodaQ==
X-Received: by 2002:a05:6000:1847:b0:42b:3592:1b88 with SMTP id
 ffacd0b85a97d-42b4bdb8f2amr5959111f8f.50.1763041539206; 
 Thu, 13 Nov 2025 05:45:39 -0800 (PST)
Received: from ?IPV6:2a02:3035:6e0:3316:1a1d:9588:a86e:c9e4?
 ([2a02:3035:6e0:3316:1a1d:9588:a86e:c9e4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e7b12asm3979597f8f.10.2025.11.13.05.45.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Nov 2025 05:45:38 -0800 (PST)
Message-ID: <deef0753-517e-4dc4-b2c0-9d25b1e56e5f@canonical.com>
Date: Thu, 13 Nov 2025 14:45:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] fat: Some code improvements
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <simon.glass@canonical.com>,
 Gabriel Dalimonte <gabriel.dalimonte@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
References: <20251113064656.245394-1-heinrich.schuchardt@canonical.com>
 <20251113133038.GF6688@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20251113133038.GF6688@bill-the-cat>
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

On 11/13/25 14:30, Tom Rini wrote:
> On Thu, Nov 13, 2025 at 07:46:50AM +0100, Heinrich Schuchardt wrote:
> 
>> From: Simon Glass <simon.glass@canonical.com>
>>
>> This is an attempt to improve the structure of the FAT code, since it
>> doesn't fully follow the U-Boot conventions:
>>
>> - fat_write.c includes fat.c which is odd
>> - use of __u32 and its ilk
>> - use of typedef
>> - old-style struct comments
>>
>> This series resolves these problems, making it easier to take on other
>> improvements in future.
> 
> We don't have an AI policy for the project at this time. My current
> inclination is we should follow:
> https://docs.postmarketos.org/policies-and-processes/development/contributing-and-ai.html

I cannot see that Simon's work would violate a policy like the one above.

> So I'm inclined to defer this until there's some "other improvements in
> the future", that are both useful

Could you, please, describe what you dislike about the content of the 
changes.

 > and hopefully only human developed.

With your reaction you will probably push contributors to simply not 
mention which tools they have used.

Best regards

Heinrich

