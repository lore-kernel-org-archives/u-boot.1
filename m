Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A1CC83F1A
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 14:01:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 921ED833BF;
	Tue, 22 Jul 2025 16:01:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aT5QwXho";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 243EF833D1; Tue, 22 Jul 2025 16:01:22 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EA5983339
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 16:01:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4561a4a8bf2so61848495e9.1
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 07:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753192879; x=1753797679; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PKctOPOSbw0we1zTvbsPmw9btTAMqXroFX68rrdyXqY=;
 b=aT5QwXhootG/47cghO4XRfp5eBTVesqUh5GLRHCMpC89RmWr+EtU+zF1s9cWn3uJHB
 wYrUrs2nmOi8KnQip7RdLe3vVm0g+QTahXTbDNwSthggMQA9WGXvuCHE/GgF4J/sRQxT
 taeYKSE7JNgiOo1TFXRi3yfFfkXaCMJYui0A6S/DIHJknVZ1gD36fQ8R5qgXJshMcsUR
 f95saOAhfCE2Al9hZ45I9iN9ouo6UorzJOuvkw9OdsBVwbBzWrwAUQPHTwwRKu4WHYYx
 5npMqW9mDCAXPGSGaHiQK1it42pZ6+XyaPTvE0LtOIoKwH8b081YHTGWfalD1PEoZI13
 6MdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753192879; x=1753797679;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PKctOPOSbw0we1zTvbsPmw9btTAMqXroFX68rrdyXqY=;
 b=rlAn4jriHpCHQcxIytVgUG/VnwDKvqPjuFbfcYXBT0++XKTVHJhjozfA+0axGNEodG
 DWvx9hL0JYyVe5C+bvbHYQfjcnCGHuGUPys5bhqxyr02JpPivc+YtCSZmtlwwLARASYU
 o74A75piwb22xRd6FV1wkLz2BoPttndMA7pd1FFgtSSUCg8bRwy1Erzy0uOhOe++d2AU
 77SB8GPKRSpnVul/qkTBPVa8C4EPK2QeEuI8HIY8a9paOUr9DRYIC6Wm5vyc8HmX7UEq
 9Bari6siCEjzwOK/XoKukTQE0yP211YWfTjZqchZ5w11Pw9C9dlxFKWvnvmdVmwzTJ24
 KCUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqZVyBMZNAfcV4glgvpvMXLJf4R1/oCflHZtXirmbFy/04XWAARFdQw6YdBbS4cgdCzoZDM5I=@lists.denx.de
X-Gm-Message-State: AOJu0Yw69YnrLNXrPD898DolbVmGpzywNaFhIyok99ljXZ5lzw7ooe+D
 uEGC0G4aQZmvmQPLklVaOLkQpsTbBUxe/ICs6HL46jUKVuR8QtjXJJrkqHumVcd5+HS18t0Ps9a
 oayeF
X-Gm-Gg: ASbGncsJ/g0uVxlrduVmiLYXeuQQAOnfXvcdgh3ALAvjuSKztRzQxWiu78viwoDZhe9
 X1aW74+/o1+JjJ0U84YKDx+A6Wqm67IteeS4tUoqnzMwvWBj0YPozSn/TAP01WSzd4sEXavM4ub
 i5yAnKGdIakpiLZbj4IWm0k8jprY5PS7G2W23aJUxfY/TTpXTxt5Nz/O/v9YJdvvGICPlW7duaD
 jmMWYAOL9V0IlyTb8nwhhhwKSSMC23bwpCqQThR4rrci7AM8l1dmh7PsZErlnqa8Hw4t6a4TP64
 eLBqjTW78Qpr+zqxQLbO2vVnsHy6T3UbV7Mfl3UBBNE+pz0mDZXEOdhIhBOmZql9VOnD/LRh0Sg
 xZ6DuDYZSlrSTSq7p9nZSYqvAMlyY2IYIs0a9+L6nc0To20Yq8VegawqGcoL3goQ=
X-Google-Smtp-Source: AGHT+IFw3+BLnLb5RkePxRnNqwpP/bgXOEf6zZ+qrlZsQ+IBIaIYbCkWtxNcHH3F0Bg1GWcYlm46Fw==
X-Received: by 2002:a05:600c:444f:b0:456:26d1:445d with SMTP id
 5b1f17b1804b1-4562e38007cmr256564385e9.31.1753192878141; 
 Tue, 22 Jul 2025 07:01:18 -0700 (PDT)
Received: from [192.168.1.36] (p549d4bd0.dip0.t-ipconnect.de. [84.157.75.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e88476csm196268365e9.21.2025.07.22.07.01.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Jul 2025 07:01:16 -0700 (PDT)
Message-ID: <705b32df-451f-4be9-aa09-4bcdc0cb3855@linaro.org>
Date: Tue, 22 Jul 2025 16:01:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFH] Future direction of the U-Boot project
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250602222738.GC100073@bill-the-cat>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250602222738.GC100073@bill-the-cat>
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



On 03/06/2025 00:27, Tom Rini wrote:
> Hey all,
> 
> Something I've talked about in release emails earlier this year, and
> promised a follow-up on but hadn't gotten to yet, was how to manage the
> project moving forward. The email I made last week about Simon also I
> believe highlighted some of the problems that we as a project and
> community face.
> 
> As a starting point, I want to thank all of the people (and companies)
> that have been working on the project and doing the less visible but
> important and expensive things that need doing. DENX has been running
> much of the project infrastructure since inception. Currently, all of
> the fast AMD64 build machines are from Simon. Linaro has been providing
> two of the 3 fast ARM64 build machines (the other is from Simon). Our
> patchwork project is on OzLabs group. A number of years ago, Simon
> picked up the u-boot.org domain. There's likely other things I'm
> unintentionally forgetting here.
> 
> So, what are the problems I see and would like to get some help and
> guidance in working on resolving? Well, in a lot of ways it all stems
> from one root cause. The project was founded on the "BDFL" model,
> which was quite common at the time, and a relatively reasonable option
> too.
> 
> But now? It makes getting resources harder. There are a number of people
> working in the background now trying to get things donated to the
> project (thank you, again) but I also know historically it's been a
> challenge not having some distinct entity for U-Boot. Individual
> contributions are best done as "I have a server" or similar. Conferences
> are a strictly individual thing.
> 
> Then there's the day to day parts of the project. I feel like I
> shouldn't complain about taking vacations where I just handle pull
> requests and not patchwork stuff too, or only doing a few things on the
> weekend. But it also means there's no real way to handle contentious
> issues other than what I say goes. Which isn't ideal.
> 
> What to do about it? Well, I've talked with the Software Freedom
> Conservancy (https://sfconservancy.org/) (SFC) earlier in the year (and
> before that, years ago at conferences). There are number of open source
> and community focused projects that they provide a legal entity for and
> help with administrative things. I've personally been a fan of what they
> do, and donated yearly for a long time. I think they would be a good fit
> for the project because they do this kind of work for a number of other
> big and important and community centric projects. I would encourage
> anyone interested to look at their website and look around.
> 
> But that is something like step two or step three. The first step is
> that I'm hoping some members of the community would like to formalize
> helping with the project. SFC can help us with creating some
> organizational structure for the project itself, but we need a few
> people to do it. And before we even get that far, help with the mailing
> list moderation queue and triaging patchwork assignments would be great.

Hi Tom,

I'd be interested in helping out too!

Kind regards,

> 
> Thanks for reading this, I look forward to finding a sustainable path
> forward for the project and the community at large.
> 

-- 
// Casey (she/her)

