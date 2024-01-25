Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3180CC48260
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 16:38:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 441D487A2A;
	Thu, 25 Jan 2024 17:38:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1706200708;
	bh=WfL8Wv1HNJg4CkkY/2zkg4GP3SWXhECsymKVEQQh1B4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=khZmAayepEvv2yeGSjRDwblVK3WUMdq4GaqNga7gM7wR8axpGqSyTQh8O8OyhI6on
	 L3AHaWUhYCfrRZZaj2GdrB0fOD3uFAaIa2UxNmzMl0VsrT7RS3bgDC5ecDrPAb4AO0
	 aVojZoUZhgB8qdk5q3/6L8/7NLU8wXNg/PTGeOpvnbsiVIwbEskZeaM0m+VnePGewO
	 Tv5kMpUPtcKSg1RS4vHQk58cuYp9GIij9HESsdK8jpogBD0l+16EFY00irQ0nQfnwb
	 FNVdY8G24CDwvln/MxoxuhtdilAUp1o9O/d4iCB7xs49hDIpGQRKWzOLR6LEVlsIoi
	 4tVR2Dxl8GheQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 87C24878C9;
 Thu, 25 Jan 2024 17:38:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1706200706;
 bh=WfL8Wv1HNJg4CkkY/2zkg4GP3SWXhECsymKVEQQh1B4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Pm3WPLTdsa/fy+aQ0Wf12Rom047UFPXlVG2jkROkLM5cIJKWW2ewVWIsM6M2rDJC6
 s34tuU5xmREC0aA+xfWWFE3gipw4U/LKU5QpbPkCsNT9uQoXV0PKoXizGPD/Dh5ZUP
 rFHUN4XpqfpnSSFKmii5qXgO/GssFto8JPB9uOiQPzYYo+RLehRy/mkGruyoT7XKn/
 f34BnoFpXNTLJpW/r+fTcotDe5oo4/0HQlgMP/m7rcAajEKpqP12RnOP669O+AaQhK
 LgQeREaOMgGxlDasxP0XR3FVhelZShPWprdbu97R6qwQ0VG8slzXVjrygWaqAHc79Q
 vXXbYZSgpr6Mg==
Message-ID: <79439bfb-5ae0-4492-a298-788fb46eafa3@denx.de>
Date: Thu, 25 Jan 2024 17:38:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/11] An effort to bring DT bindings compliance within
 U-Boot
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de, sjg@chromium.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, ff@shokubai.tech, daniel.thompson@linaro.org,
 dgilmore@fedoraproject.org, pbrobinson@gmail.com,
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com,
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com,
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com,
 rfried.dev@gmail.com, mibodhi@gmail.com, bb@ti.com, mark.kettenis@xs4all.nl
References: <20240110103547.719757-1-sumit.garg@linaro.org>
 <82d509de-3d47-4cc2-8217-c38dc78fad28@denx.de>
 <7b4ff8e8-2f21-4d07-9848-fb0d5652819e@linaro.org>
 <4d8aede8-5ea8-45a4-87fe-d555a025ef8e@denx.de>
 <CAFA6WYN1tFs1id7UxTwLEyp69zx2BPUP7bffVZn80FKPLx2yJw@mail.gmail.com>
 <48125705-e78e-438f-90ac-2816432cd747@denx.de>
 <CAFA6WYMuerS5YTsquGvc+OHr+0a3JXrM4AQ_ReV4tPhvxv9H0w@mail.gmail.com>
 <20240125150400.GM3652023@bill-the-cat>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240125150400.GM3652023@bill-the-cat>
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

On 1/25/24 16:04, Tom Rini wrote:
> On Thu, Jan 25, 2024 at 12:54:22PM +0530, Sumit Garg wrote:
> 
> [snip]
>> But at this point we have to move away from apprehensions about DT ABI
>> breakages and provide real examples of the DT ABI breakages in the
>> past. Are you aware of any DT ABI breaking change backported to Linux
>> stable releases? This is the sort of information we would like to make
>> DT bindings maintainers aware about.
> 
> Well, how far back are we going? There was a serial related one, but it
> was probably closer than not to 10 years ago and lessons have been
> learned from it already.
> 
> The real breakage comes in the form of (from the Linux kernel):
> commit 37685f6a63eeca2135d1f704e7638409a071b1f6
> Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Date:   Tue Feb 19 08:46:33 2019 -0800
> 
>      ARM: dts: am335x-evm: Fix PHY mode for ethernet
> 
>      The PHY must add both tx and rx delay and not only on the tx clock.
>      The board uses AR8031_AL1A PHY where the rx delay is enabled by default,
>      the tx dealy is disabled.
> 
>      The reason why rgmii-txid worked because the rx delay was not disabled by
>      the driver so essentially we ended up with rgmii-id PHY mode.
> 
>      Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>      Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> And this is of the style "the DTS was wrong before so we can break it".
> This is the specific example (as the board is in my lab) that comes most
> clearly to mind but there have been similar examples in 2022/2023.
> 
> The other just as painful examples I think may be where Marek is
> concerned and it's around nodes being renamed for correctness. We've had
> a number of cases where a - turned to _ (or vice versa?) and whoops,
> platform stops booting. Down the line, tooling would catch that, and
> it's a problem of not being able to use better tooling until we have the
> updates that might break the boards that need the better tooling.
> 
> And really this gets to the crux of the problem, how much testing do we
> insist happens prior to a re-sync being merged? Do we want to go with
> the whole of the dts files are re-synced, or do we leave it per vendor?

I'd much prefer to leave it per vendor, with the recommendation to use 
synced DTs. Eventually things will stabilize and vendors will start 
switching over.
