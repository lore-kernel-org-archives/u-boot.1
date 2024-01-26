Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26009C47258
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 02:12:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 825AC86D82;
	Fri, 26 Jan 2024 03:12:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1706235176;
	bh=Ptbl3flbo0eNj4Jv6mvKOn5hVHiG86xn0qRvc5mnCIo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QhWSSA6H00udUq/8KV9r1e0ziSeIloYusuknzIqZoLeTaYb9m5x3pqfbEYQIMvcwS
	 sNAOvwF0MAjHrmm7fyMVSPNda2wxXST4n3dqbTCABGFAlcLtpIUIAAqoOSk7VW8a4J
	 tfHIFQYV5ubIETr6uxsHG62mmH7stL/dn2J2UCugrh2GlwOn6skiT86Xy3XEcA0FvX
	 zL7CJm96BSYEahw9v7dnf3HU7CBOrv0OFVC10hxJL1tU790xpBg59cbUlnPC94llUT
	 dp8gp9XFgG4G7HwPXWR0VxbX/Tx3SjO+rNCGFKUaHfF7QlTHQhxzTl1efalDxTU4Or
	 kmlh9469ltTJw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0690F8657F;
 Fri, 26 Jan 2024 03:12:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1706235175;
 bh=Ptbl3flbo0eNj4Jv6mvKOn5hVHiG86xn0qRvc5mnCIo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=KQNk9d9K0l63gK90/dBvQewWwd+h5C00v3oOuwnGDxox5abnFYPjw1F253JBBG6+b
 HS8CZT1rgf/7I2kQ+rUeXboCp72symyc5WdXJLSH08cEasbhMAXkt6W1zfC3uDjaL7
 b+47qq0E5mTCb2nuRpzz4UN9srpJNN4ve0g1HmeQazatvxvo8kLavKu7bLo2PJeQF4
 DuRim/WlldedRxUoZCazdOONrXdZJ+7ayfQ9RctVPWqKtm2txYmjX5ZKZDMm4AXq2B
 2cyxpOZTRHGGMB+j0MTJ0Ggmt3NHd2gF9HmDzs8anwhZS7NgFGMl9/fQEhQGZtpSPJ
 +PRsKj1n9ogUw==
Message-ID: <0d4ed462-a5ec-4114-84ab-d2e2a6d79b69@denx.de>
Date: Fri, 26 Jan 2024 03:10:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/11] An effort to bring DT bindings compliance within
 U-Boot
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de,
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
 <79439bfb-5ae0-4492-a298-788fb46eafa3@denx.de>
 <20240125231933.GY3652023@bill-the-cat>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240125231933.GY3652023@bill-the-cat>
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

On 1/26/24 00:19, Tom Rini wrote:
> On Thu, Jan 25, 2024 at 05:38:23PM +0100, Marek Vasut wrote:
>> On 1/25/24 16:04, Tom Rini wrote:
>>> On Thu, Jan 25, 2024 at 12:54:22PM +0530, Sumit Garg wrote:
>>>
>>> [snip]
>>>> But at this point we have to move away from apprehensions about DT ABI
>>>> breakages and provide real examples of the DT ABI breakages in the
>>>> past. Are you aware of any DT ABI breaking change backported to Linux
>>>> stable releases? This is the sort of information we would like to make
>>>> DT bindings maintainers aware about.
>>>
>>> Well, how far back are we going? There was a serial related one, but it
>>> was probably closer than not to 10 years ago and lessons have been
>>> learned from it already.
>>>
>>> The real breakage comes in the form of (from the Linux kernel):
>>> commit 37685f6a63eeca2135d1f704e7638409a071b1f6
>>> Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>> Date:   Tue Feb 19 08:46:33 2019 -0800
>>>
>>>       ARM: dts: am335x-evm: Fix PHY mode for ethernet
>>>
>>>       The PHY must add both tx and rx delay and not only on the tx clock.
>>>       The board uses AR8031_AL1A PHY where the rx delay is enabled by default,
>>>       the tx dealy is disabled.
>>>
>>>       The reason why rgmii-txid worked because the rx delay was not disabled by
>>>       the driver so essentially we ended up with rgmii-id PHY mode.
>>>
>>>       Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>>       Signed-off-by: Tony Lindgren <tony@atomide.com>
>>>
>>> And this is of the style "the DTS was wrong before so we can break it".
>>> This is the specific example (as the board is in my lab) that comes most
>>> clearly to mind but there have been similar examples in 2022/2023.
>>>
>>> The other just as painful examples I think may be where Marek is
>>> concerned and it's around nodes being renamed for correctness. We've had
>>> a number of cases where a - turned to _ (or vice versa?) and whoops,
>>> platform stops booting. Down the line, tooling would catch that, and
>>> it's a problem of not being able to use better tooling until we have the
>>> updates that might break the boards that need the better tooling.
>>>
>>> And really this gets to the crux of the problem, how much testing do we
>>> insist happens prior to a re-sync being merged? Do we want to go with
>>> the whole of the dts files are re-synced, or do we leave it per vendor?
>>
>> I'd much prefer to leave it per vendor, with the recommendation to use
>> synced DTs. Eventually things will stabilize and vendors will start
>> switching over.
> 
> To be clear, every SoC (or really, board) has to opt-in to OF_UPSTREAM
> to start with. With that, I see switching to OF_UPSTREAM meaning that
> there's a commitment to keeping up with dts change in upstream dts that
> might lead to issues within U-Boot. Do you still feel it would be better
> to have the re-sync _also_ be per custodian tree? That might be a bit
> harder to handle.

Maybe the best thing we can do is just give it a try and see how it 
works out, esp. since it is opt-in per board .

It would still be good to solve the part about pulling in fixes from 
linux-stable though .
