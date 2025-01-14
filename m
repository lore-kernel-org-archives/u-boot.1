Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9FB0E77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 14:50:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 873DD8069D;
	Tue, 14 Jan 2025 15:50:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Znk7k5y8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65F7880716; Tue, 14 Jan 2025 15:50:07 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 262D280657
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 15:50:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=cnsztl@gmail.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2ee86a1a92dso7678844a91.1
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 06:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736866203; x=1737471003; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ACzOXp4xvWYpWNi+inhX5U0cuxe3RjmOzFDfzkN8aPs=;
 b=Znk7k5y8v71vgR3MmLKDuBt0mV3+Gc+Ywd2+ukbQaL5aJSBCB6pqvnYKPPClpNxJcO
 4hSo4ZgfdoeEi1jc3kOz8mfz6UY/mTGw3Hgt89LyRNA2t4uoXbAWEDcNHV2rDq1l79tg
 0Jp1hrCsLPPYpz5JD/boxBdRzTgNm5p+fSEdQ64f4bAml61nu4yzRbTe9wuGafw9EvOd
 wB/un31hFZliIpkpS3yc45UEU/2YNLaolDHdrNFEXiN/fYBQaf3HZ7JgUUhLPD7ADuva
 QJ6KEb8aHo/TZhXNMwHvcPVOD5dbSiy/5MK6+DMEOv/5S9AbDomtJ8MPUUgiNarFRDii
 9SmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736866203; x=1737471003;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ACzOXp4xvWYpWNi+inhX5U0cuxe3RjmOzFDfzkN8aPs=;
 b=q13d0NLKlDXqWiROuYHXSb91jAFsnKyL7VIaA2NhWzXOOeoRC3IfRf/JS/qOCSb2iS
 9vy6zK1VdoAy1U3RdHAydTegPKHAYwXbtoDEwZSwLGgQ0eRbRu1uR8Gp/YyBtu0QWdSW
 0t/Xzf0l1QJ6gaU2OfPUMCBDFJ+SuwF0akr8fpsO/mfdjulg5SOlLvMy9AyeIRQSubIA
 5THlao01tqDJzsccXF6sNLHFzxy8TFji0BVihTsQcGMGsF4AuCxP8V5bnLdRbXmub6Ne
 /4F8awDUrRplYJ2x3dSQJwnaN876H9xyix79062yzfCbSZwP2WOdV1yn1QR76rMPV7Q4
 /5AQ==
X-Gm-Message-State: AOJu0Yx1RKSQ5lVJq8Wm6tDW0Cgk79xF/1SPumO7TFvRNycYEOWO3byE
 ChuHUR5fSmlZsWa9Y2nEzHQNZydxxWJZJp+bPEHFyD4aSGa4L9sT
X-Gm-Gg: ASbGnctSXztzy84jLlriWkjQnhXyHC/DqJ5++wujr7xR+2My2kHFNVjCuX2rK4WlNBm
 UXAXrFBe0o5et0kgmjO2peAAnlJEZSuEPmVB12MmtIheAEZ8hsamkhEAXJKBp4rDqrB59cZ1+Xd
 eFF9eSOe7H5M6KPRnE2GG9++MwDJqtDhX0LCrme/lb5D5CqmKhtOzs5UlRF7VlWCKmJRmNxrLYr
 RPOPNqkU50TDboLvLjtowO3DPHWU+z0D2pFHwhXFJf6BYQFJUmb9kQC0ouSkeR8LdNYSMhU86oq
 9rIkTSyf/x9Cu7J+5rNF8JI=
X-Google-Smtp-Source: AGHT+IEwvdoJcKAMLFepsXjAy8/4+oRv7U0LmDO40lJh1BfUXxxyF64T1kxQhn+/8EDnya9OCDR1XA==
X-Received: by 2002:a17:90b:1f92:b0:2ee:693e:ed7a with SMTP id
 98e67ed59e1d1-2f548f429e3mr35234793a91.35.1736866203200; 
 Tue, 14 Jan 2025 06:50:03 -0800 (PST)
Received: from ?IPV6:2408:8362:245d:4738:bc4b:53ff:fead:2724?
 ([2401:b60:5:867d:3631:b7db:c3f4:aae2])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7085261dcsm874473a91.0.2025.01.14.06.50.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 06:50:02 -0800 (PST)
Message-ID: <5d2fb256-cd0a-4a94-ba9f-f13a928656ed@gmail.com>
Date: Tue, 14 Jan 2025 22:49:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] board: rockchip: add FriendlyElec NanoPi R3S
To: Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass
 <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
References: <20241226092043.419511-1-cnsztl@gmail.com>
 <2b658c60-480f-4488-8c40-f781a849cb32@cherry.de>
From: Tianling Shen <cnsztl@gmail.com>
In-Reply-To: <2b658c60-480f-4488-8c40-f781a849cb32@cherry.de>
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

On 2025/1/14 22:39, Quentin Schulz wrote:
> Hi Tianling,
> 
> On 12/26/24 10:20 AM, Tianling Shen wrote:
>> The NanoPi R3S(as "R3S") is an open source platform with dual-Gbps
>> Ethernet ports designed and developed by FriendlyElec for IoT
>> applications.
>>
>> Tianling Shen (7):
>>    arm64: dts: rockchip: Add FriendlyARM NanoPi R3S board
>>    arm64: dts: rockchip: fix model name for FriendlyElec NanoPi R3S
>>    arm64: dts: rockchip: replace deprecated snps,reset props for NanoPi
>>      R3S
>>    arm64: dts: rockchip: sort props in pmu_io_domains node for NanoPi R3S
>>    arm64: dts: rockchip: enable eMMC HS200 mode for NanoPi R3S
>>    arm64: dts: rockchip: reorder mmc aliases for NanoPi R3S
> 
> How did you backport the above patches?
> 
> ./tools/update-subtree.sh pick dts <commit>
> 
> is the tool to be used, it should have added a
> 

Thank you for the tip! I did not know there's such a script and
I just copy&paste the commit message from linux tree manually.

Thanks,
Tianling.

> (cherry picked from commit ...)
> 
> in the commit log.
> 
> Cheers,
> Quentin

