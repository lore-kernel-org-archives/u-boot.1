Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ADA6C5475B
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 18:50:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69D2887DE8;
	Fri,  1 Mar 2024 19:49:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yzlHHM39";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A1E987DE8; Fri,  1 Mar 2024 19:49:55 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F0BF87F00
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 19:49:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-412cf3c5cdeso1018165e9.2
 for <u-boot@lists.denx.de>; Fri, 01 Mar 2024 10:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709318991; x=1709923791; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xLChBSwKTcgCcac8L2xgBPyg3Y3xe4jwzvbLDkmBWz8=;
 b=yzlHHM3960jlCDjh+wmArRG2GtmHNVv5hvWJeWZ0jVvL0+wxAX9Irr4bFfqLTx5Gg3
 sf6boMgkYD/piqbNm/Z+tza13gHcpkR2fdntluZNaLQGTYx8Y93sd4E1fRQfRPgQF7tB
 Z/HBFyvpgAZ62thml4HuKoqQ3Fl9u1Ivzi7ZrxGlehx8NHNrOVnSvIfg4FQVDPNkBD7/
 B7gWEH6rhZvJXv/JaHIgAoKhwUHdBpdlVAX1nPLLvFcc/sdEKDUEDyJq+urdQ9Jm+k+m
 SWcwgzj3WLNdjKnjURVB3UGozhbH/x671oWkPyGy9kZBjTgrjS59MiCD8EbfskvuwUhF
 ipnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709318991; x=1709923791;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xLChBSwKTcgCcac8L2xgBPyg3Y3xe4jwzvbLDkmBWz8=;
 b=VlM0GJaUzqyC3mkMbXX2sIg0r/yDI11OL9ujCOh1uSP1EUy4Z6oPXFg0zewTwiRs/k
 7T2G1eVDq4UL8q7FtafmY0w3HIdrfTz6nMYzAhOxYgeMmzIbWD/RcSryL52+JDzTSzSU
 T1PGNpuS/z/ttAoZjyNRIrky1d7iAbYMG1iFeBJVBW7n+YXZxnRbezD76pvE7I3fYFPd
 aSAbnpLvXswZOTXBijC4wGbpKK7I/q0i8RFgu4twVkfj6yM64DH+Vxhnfe5Sf1I5N89d
 UHsLUw62v6mgaeI66vDJzBkmjTXqUuNA2sV/07cYrn7tI4v4YIR3zo+r/HMpYkUlq03Q
 Sr/g==
X-Gm-Message-State: AOJu0YzErbZBO98RRwL0cwTSE1jILeREBNtiMXAeHpDI2M53/lnNkTy+
 w06ZIAZV0OlJsSJdwPAW8JfZCBSFVye7w525js+FFjDTN4oVKJ8gwS2Eojutom4=
X-Google-Smtp-Source: AGHT+IEiYjDIY059HL/18W9Hl5n17Wq+WDD3ocLpJkrPOWzbrS2JIPBeZGravlPsOCz1UiCI4cFrAg==
X-Received: by 2002:adf:e690:0:b0:33d:3b72:d2c8 with SMTP id
 r16-20020adfe690000000b0033d3b72d2c8mr1690044wrm.71.1709318991477; 
 Fri, 01 Mar 2024 10:49:51 -0800 (PST)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 u20-20020adfcb14000000b0033b7ce8b496sm5209963wrh.108.2024.03.01.10.49.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Mar 2024 10:49:51 -0800 (PST)
Message-ID: <30138296-d0c8-4664-af34-94be5b84fa7a@linaro.org>
Date: Fri, 1 Mar 2024 18:49:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Add support for Qualcomm SA8155-ADP board
Content-Language: en-US
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Elmar Psilog
 <epsi@gmx.de>, Joe Hershberger <joe.hershberger@ni.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Ley Foon Tan <leyfoon.tan@starfivetech.com>, Lukasz Majewski
 <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>
References: <20240229142043.1263690-1-volodymyr_babchuk@epam.com>
 <dc97490e-4029-41e2-bbbd-b1351f5cf9eb@linaro.org> <87bk7x6c88.fsf@epam.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <87bk7x6c88.fsf@epam.com>
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



On 01/03/2024 18:25, Volodymyr Babchuk wrote:
> 
> Hi Caleb,
> 
> Caleb Connolly <caleb.connolly@linaro.org> writes:
> 
>> On 29/02/2024 14:21, Volodymyr Babchuk wrote:
>>>
>>> This patch series adds support for Qualcomm SA8155-ADP development
>>> board. Main motivation for this series is to allow running
>>> virtualization software on this board and U-Boot is a good way to
>>> break Qualcomm's boot chain at EL2 with more convenient ways for
>>> uploading and running the code. With this patches applied it is
>>> possible to upload and run Xen on this board. KVM probably should work
>>> too.
>>
>> This is really cool! I've experimented with this on SDM845 and SM8250
>> but never really did anything with it... I'd love to take a look at your
>> Xen branch?
> 
> Honestly, there is nothing to look at right now. I just implemented
> early printk serial driver for the qcom, made hacks to the device tree
> and trying to boot Dom0. I already expecting issues with the GPU,
> because it has own SMMU without virtualization support and Xen already
> complains about it. So I had to remove it from the DTS for a time being.

Hmm, I see. You'll also definitely start running into issues with the
DSPs and probably anything else that loads firmware. Qualcomm's
hypervisor seems to be involved in booting a lot of the peripherals. The
sc7180 Chromebook support is probably a good reference for how to do
this in Linux as they also run in EL2.
> 
> Anyways, right now my Dom0 does not want to boot due to some issues with
> UFS. I suspect that some power domain or clock is disabled or some
> other bit of initialization is missing in the mainline Linux. And
> reason why bare Linux kernel have no issues with UFS is because
> aboot/xbl does proper UFS initialization, while in my case I am skipping
> the android bootloader completely...

Oh that's always fun...
> 
> I'll publish my work when I'll get Dom0 running.

For sure, I'd love to try it out!

It's really exciting to know you're working on this :D
> 

-- 
// Caleb (they/them)
