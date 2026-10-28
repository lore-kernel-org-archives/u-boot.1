Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9848D606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 22:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kz8auSwP;
	dkim=pass (2048-bit key, unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=wJCCTpJZ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6757960766;
	Wed, 28 Oct 2026 22:53:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id begz_X68CimQ; Wed, 28 Oct 2026 22:53:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6B98C6073B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793228023;
	b=LVAnlgs05Sd3Xdrs+wKhj1GR0fzyI85VbW7M/x0uvNtbwHIG880+sC+X+K5ITQ8P/J+0
	 z78k+a4wKFqtK4NgcW/TZeMfFF1DAncPZyzbT1D32Pn50+eIX2tN90eS6SKqyRO6puoti
	 5km2E4l5sv1q5kKCPnwixNajg48FVS/B62+Yi6GwSyli7QwZSvA80GsreWklTn6McIDxC
	 9H4B0dr82oCSlQxDlmNrKIOAmtr5DSg6dsJBQqbiOGumxGAwsH/wLNSx+saJ5VA4iTk89
	 8vP0cXaDkuuXe9+I34EJd7B2awmdN+sq7WwzzSt89seI2tpcvxMJhn1gPNgt46T08oQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793228023;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=socwaKbqdKR7unT0OyBn6q/NivZm90t7MS4rD3EVz+w=;
	b=YTX0cR+QN8DvrE1IZ081m7LqcZx0yfHnyAAsccQRAeBS7eNPU86+yanc49VtkaMfwBIp
	 /D75gyku76J5F0ns8wxvu3YzEVwq6TE3BG6Dss7zOaPFhKPGweRHM5fzx8cBM7eJ0mGQ5
	 IGUW+acP0AzhnAPvrp86fWtyWsn/QkA5kZWEtmyYG9AckMROAWKzn9TcgJe0OP+4j376e
	 EYfzEbPxN7fNG+7WqLTwHsR69GS7Cd3iaaRrugFgzZaz7FKMjocAaMDP6BTeaLN+ceUPs
	 aTXwHlLvZTSm9yRFiZNsNaeLgFt7yGTPk21oFC27LD5lzdCIiecEvwq+lj/TPC5YivA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793228023;
	bh=socwaKbqdKR7unT0OyBn6q/NivZm90t7MS4rD3EVz+w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kz8auSwPULN5Sm8Do3LSX3jBhwUlQI+iiO90N+zloytbiuZJYt8zczvliQNJm5T16
	 53mfimRVqoHUWdx8yQnc3n4fynZAB5Km7+h3LiHiFZbm0bzlquwiXWGDJZZiRFr542
	 H4FXKZPbC70nTYyYCyFQHDYSxxmytFRaKudEI+kFCg1kKXWaYslN5ZreN8vYKvZ/+O
	 PD3kf4cbw31dAj1J59afuFE4fq3i30Pj1tQdfBc309wjH2yDeg/Hw0XCY9UINmhU3P
	 vpZW5zTwJXYoE3NhfdTpOOCU47HS0ZwkrFvuJoVPh7xgiNMgr22FomtpHzlW95zacA
	 8jPCgDkdTsuHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6B98C6073B;
	Wed, 28 Oct 2026 22:53:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7B5822A8
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 22:53:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 62163408C4
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 22:53:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vdl8dMkKeq2F for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 22:53:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 57E4B408C6
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793228021;
 b=rYAK7me7xe06Lr4AE9FmXv+jUp4egHEc6blKRhFj74Ajo+Bj7Pr7iNecBlO2587d4Q+r
 Z7KW78brlwL8vkjZLVgdjL0d6/cFF9m5mLKSm/y5qwPPiyQatc9B2NpEa9KYBCl6d3oJr
 yU7gJ50xoNxCXwzm5RpjWHl8fb83AOSOzvv0CM3x21X3c+pZrTgwtoe93ILj4BYheDWu9
 a2iIbhS88rFVCeJ6ZGYOaQ16hl3QqQ5b5u4lKo+Jb6fNVCwAoW5AlTiOICPOFkIZwDLnT
 Nj5+eObVsmVywq4OzYdQdMgxkBH/HLK/w78Uga3jC4t2xvbnCQMEreLggy1DbyJMGkQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793228021;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=socwaKbqdKR7unT0OyBn6q/NivZm90t7MS4rD3EVz+w=;
 b=HZiM2tUByR3I+1azNJSaZYV6Q9OdwWUGm80at1670/i8X7wiyKYl+QGJw6r8LFWRC8p7
 ZP8atkkqZIrALRc45TXjk2yx307AF5DmXU/Y9i1HE1BQVQsMz6BKygT/Tha4knms2HtLo
 ECARvZZivwRI66OyJghpdQCxl2IfnYm477nUgI2bCx5Th6YUuJ0tHygGOMROB7I8NRyD3
 6QYU/4izQa9Ei0Z9TMoWaPZenTDtAm/SveJYPEsEEqFPERGfmpKbf0sx8wlCi/CyusAe0
 C888FFmgEoF62KHb91xNmsZrex/3Zyv78gSMM5e3NI3h4Vnik7RSf32FlTlcYClEdmQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=wJCCTpJZ; 
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=340e=it=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=wJCCTpJZ
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 57E4B408C6
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 22:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1793228017;
 bh=socwaKbqdKR7unT0OyBn6q/NivZm90t7MS4rD3EVz+w=;
 b=wJCCTpJZ5EF0c0INtOzMufXeDs22om5wYe5ub5zhh+FwkroFn7P/jjpzQG+70enaPV/TvblYn
 JGMn4IQmAFbhbHbLq0Ic4rB7P4sQn1HM9xcTgVNH02zBPFs7/CtcdE+1YTrHhawSVSqCGxjOjNH
 u4j4KSVJDjpgWE3LDFRNzaOuaoNe/76J/qeSfNiAsikBPIQpttwzKpUnLkRQrXitEg20rlkTF6M
 5me6Om8aJ6b11+Tc9sZQx+9lreiHs1wp/t/TDLxBso1YvmgKvhF9vSShhdZvcH+unzFHkYtUBY3
 ejPtClu89sWtzBd8BGaPezjbuwsetsb6GlYInyu993MA==
X-Forward-Email-ID: 6ae27ce8f7a872489c113089
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.18.12
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <c5cf9db7-7d54-47b7-8cc0-2b677d17fbfc@kwiboo.se>
Date: Wed, 28 Oct 2026 23:53:23 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] clk: rockchip: rk3568: Ungate PCIE30PHY_REF clocks
 when PCI is enabled
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <20261015224222.1582607-1-jonas@kwiboo.se>
 <20261015224222.1582607-2-jonas@kwiboo.se>
 <16574e5d-6d1f-4419-8519-b1cc356797a3@0leil.net>
 <6a5e35fb-2bfb-4551-a9a4-2f51a1cbdaad@kwiboo.se>
 <179e0a6f-0dd9-48f1-a79a-3611ddb30cd8@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <179e0a6f-0dd9-48f1-a79a-3611ddb30cd8@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Quentin,

On 10/28/2026 7:23 PM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 10/28/26 5:57 PM, Jonas Karlman wrote:
>> Hi Quentin,
>>
>> On 10/28/2026 1:41 PM, Quentin Schulz wrote:
>>> Hi Jonas,
>>>
>>> On 10/16/26 12:42 AM, Jonas Karlman wrote:
>>>> The CLK_PCIE30PHY_REF_M and CLK_PCIE30PHY_REF_N clocks are by default
>>>> gated coming out from system reset. The probe() ops of the PMUCRU driver
>>>
>>> Are they? I don't have an RK3568 board so cannot test this, but the TRM
>>> says the bitfields are 0 at reset with "When high, disable clock", so I
>>> am not sure what exactly this is for (except after a reboot where the
>>> Linux kernel has disabled the PCIe clocks maybe?).
>>
>> I guess the TRM is incorrect, because as I mention in my commit message
>> these clocks comes gated out from system reset, or I would never have
>> phrased the commit message as such.
>>
> 
> Well, it could also be inferred from the fact Rockchip enabled it in the 
> CRU driver unconditionally. So I wanted to make sure it was indeed 
> checked rather than simply inferred. Thank you for the confirmation.

I would most likely have phrased the message very differently if the out
of system reset state was not tested, or at least mention that it would
have been a refactor based on current code if that was the case.

My expectation (and practice) are that when something is definitively
worded in commit message it has been verified to be true, else there is
a note and/or the wording is much more relaxed.

> 
>> See below runtime log on a Radxa ROCK 3B (from power off state):
>>
>>    DDR 5c7dbc4d49 kwin.chen 26/05/21-10:58:25,fwver: v1.26
>>    [...]
>>    out
>>    PRE: pmu_clkgate_con[2]=6000
>>    POST: pmu_clkgate_con[2]=6000
>>    
>>    U-Boot SPL 2027.01-rc1-00097-gec7e6bacaadc-dirty (Oct 28 2026 - 16:35:51 +0000)
>>    Trying to boot from RAM
>>    [...]
>>    U-Boot 2027.01-rc1-00097-gec7e6bacaadc-dirty (Oct 28 2026 - 16:35:51 +0000)
>>    
>>    Model: Radxa ROCK 3B
>>    SoC:   RK3568
>>    DRAM:  8 GiB (total 7.7 GiB)
>>    PRE: pmu_clkgate_con[2]=6000
>>    POST: pmu_clkgate_con[2]=0
>>
>> Using following code in probe() ops:
>>
>> 	printf("PRE: pmu_clkgate_con[2]=%x\n", readl(&priv->pmucru->pmu_clkgate_con[2]));
>>
>> 	/* Ungate PCIe30phy refclk_m and refclk_n */
>> 	if (CONFIG_IS_ENABLED(PCI))
>> 		rk_clrreg(&priv->pmucru->pmu_clkgate_con[2], 0x3 << 13);
>>
>> 	printf("POST: pmu_clkgate_con[2]=%x\n", readl(&priv->pmucru->pmu_clkgate_con[2]));
>>
>> I guess theoretically it could be the DDR init blob that gates the
>> refclks, however running bare minimal TPL on same board show same:
>>
>>    U-Boot TPL 2026.10-01297-g83bfcb8d6e91-dirty (Oct 28 2026 - 16:45:25)
>>    x0: 00000000 fdcc0098
>>    x1: 00000000 00000008
>>    x2: 00000000 fdcc1000
>>    x3: 00000000 00000006
>>    x4: 00000000 00000050
>>    x5: 00000000 00000000
>>    x6: 00000000 00020002
>>    sp: 00000000 fdcc0f30
>>    BOOTSOURCE_ID fdcc0010: 0000000a
>>    PMU_CRU fdd00000: 00004064
>>    PMU_CRU fdd00004: 000014c1
>>    PMU_CRU fdd0000c: 00000007
>>    PMU_CRU fdd00010: 00007f00
>>    PMU_CRU fdd00040: 00002063
>>    PMU_CRU fdd00044: 00001481
>>    PMU_CRU fdd0004c: 00000007
>>    PMU_CRU fdd00050: 00007f00
>>    PMU_CRU fdd00100: 00000080
>>    PMU_CRU fdd00108: 00000001
>>    PMU_CRU fdd0010c: 00000001
>>    PMU_CRU fdd00110: 00000800
>>    PMU_CRU fdd00118: 00000001
>>    PMU_CRU fdd0011c: 00000009
>>    PMU_CRU fdd00120: 0000050f
>>    PMU_CRU fdd00124: 00008bbb
>>    PMU_CRU fdd00188: 00006000  (pmu_clkgate_con[2])
>>    PMU_CRU fdd00240: 00040020
>>    DRAM init failed
>>
>> Above should hopefully make it clear that the reset value in TRM is
>> likely incorrect ;-)
>>
> 
> Wouldn't be the first nor the last time this happens :)
> 
>>>
>>>> unconditionally ungate these clocks to help ensure PCIe works in U-Boot
>>>> proper.
>>>>
>>>> Change to only ungate these clocks when the PCI Kconfig option is
>>>> enabled for current boot phase to delay the ungate as late as possible.
>>>>
>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>> ---
>>>> Changes in v3:
>>>> - New optional patch to help delay the ungate of PCIe ref clocks until
>>>>     U-Boot proper
>>>>
>>>> This patch is strictly not needed, however it seems very unnecessary to
>>>> ungate PCIe ref clocks in SPL when PCIe typically only is used in proper.
>>>>
>>>
>>> Considering the kernel seems (I had a cursory look) to be able to
>>> control those clocks and have them handled via the pcie node, it seems
>>> fine to me to possibly not have the clock enabled by U-Boot (e.g. with
>>> U-Boot proper or xPL not enabling PCI).
>>>
>>> So, I'm fine with the content of the patch, not the commit log. Can you
>>> please confirm that they are indeed not at 0 when reset (and/or that we
>>> do this to be safe when doing reboots) and rework the commit log?
>>
>> As mentioned above, the commit message has been correct from start, so
>> please be explicit about what you think is unclear and needs to change.
>>
> 
> You could have just said that it doesn't match the TRM, that would have 
> told me that it was checked IRL.

I did not even notice that the reset state in TRM was different, all my
changes are typically confirmed using runtime testing ;-)

> 
> I can reword the first sentence to
> 
> The CLK_PCIE30PHY_REF_M and CLK_PCIE30PHY_REF_N clocks are by default
> gated coming out from system reset unlike stated in the TRM.
> 
> when applying, does that work for you?

Sure, please feel free to make any change you see fit to any of my
patches :-)

Regards,
Jonas

> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Thanks!
> Quentin

