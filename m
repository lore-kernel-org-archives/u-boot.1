Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E74DBCC6B12
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 21:01:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9359480C16;
	Tue, 13 Oct 2026 21:01:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c-OksDKoRVlo; Tue, 13 Oct 2026 21:01:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A321180A80
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791925277;
	b=CwdZ9JuYGKmiJ2qsyo5cr8KH0lGBbwj784rkVT/fDpVvYRfUk4F0c0xP0/Q+L5FeunTD
	 V2CZcWSwVuwIjERMX36XzBBScAhGUbYTaX/7HgfRuFiYMvMwl9PgO8LrfuC0FrSbbOJbc
	 NEoiqLlLZzcDCR344r+UyfaluWbOtA/b18gqkoOKKpw1N53Kr+x8sGcY8LpPRjX41CDbd
	 OLM1j2TQ6xShbMr7YdtMc5MNDZH0zkZ7ywWWdttusiWAkIRgSf9AG1YTWfljPR6lwBlj4
	 cTdzn5ZkjbClujEGHp3+etdqXHAPECRThHZbFr8R24dSJ+4eH8h3nAj1NmGqlEXEaVQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791925277;
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
	bh=SLXSWRERnAEmLRVCrCtf7u8sQw7gjb/GxbvpVoWcn9k=;
	b=snHkm4qF5Qy1Ozo3FqvBlTLJBV/2rqNpAYJr07vJUP76fKhhZFubNsf7hDRzqswPw7rT
	 80V1TjR1UfQK7heQD+bbmwql+jSIj4xbJSsjL9ZDDOQDFkfyf+Qv3Tf6BlDnuP4i0fz1K
	 bzgaYjcxYEqGGDfv5c+tPUJngD3mUrQ2kYkafZ9YSDC3TqYvePAFo7C0SkG7pxs1NQqJL
	 ARS3Zrtj0RFOBQJdkMG3swZyebPMK8Xfv7gtxApp2D0e19xb25OnKf2OpEg9gXFA+E4D6
	 77EqW/sJGIPZf0GcEZ17OzQMbEQPs8xq/LKHjYf9D9cI3ZsVWiQnlwJzIxwXIVwWPgg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791925277;
	bh=SLXSWRERnAEmLRVCrCtf7u8sQw7gjb/GxbvpVoWcn9k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EdHfLbG6VKYFNIMhFKZ3bZboG7CEXdCPHHQTke5HZR+pT5G1xsjj9um9fLCuH0kD2
	 LCGHcwk+AE06c4+MZUJxDGxYcdz/7lPgm+IUykvlKGOB2fnfWlc45i29TjZ72GujpK
	 HojHg7fRJPt5izE7xZQIpMYbV/1IyfcqOCRYtTgm+PGNHbXZi+W3SKlQ6JdJ0TqPox
	 mbdm0nnuwLx7ILuVA0T0g/YEMX6kxlh+cLtKH0aTbuL0Gd5wDjNejgX+AFHRrmijok
	 5diXg1J+Q8NNT3wclek9Qlp+AoPnp7laZ0bfHy8UaCPtoL83GdRiM+b58qZLKJ6o17
	 abLZFrwJWooPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A321180A80;
	Tue, 13 Oct 2026 21:01:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EFC9D2AC
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 21:01:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D332B607EF
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 21:01:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6HSbjKe6xe7p for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 21:01:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DBF97607A9
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791925275;
 b=emkLpRnDBMjGGEcb3QUfhnt69Op6NxVVFe5YgnFr/yD+/YT9T56MhuWLFqd3RhbTw/w2
 V3yLI6L/4y/WY2pi7iRN0oXdCwpVZJLMUEbNkfgxms4kRhZ4Q2CL0qx+hDJ0+fBEVeVGZ
 wXoaRRvcaOSpcqkMHXTBbbnngci25rW9I1Gqy4XKgzEMPGvJMiVTIq+a1PfD3Hog7jROR
 2FfhRMopbI3XQ/DOSU1MbEsIpK4dXP7xlj4F7YqbUHiU/QTv4AzkGFKtbyzn/Smk8Xcut
 EwU5xsRg2OcBgqH6e+U9LmGmuGPPFB5zhK6UvF6mfbMb7ELXyADZW/+ntQw3a++P6DQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791925275;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=SLXSWRERnAEmLRVCrCtf7u8sQw7gjb/GxbvpVoWcn9k=;
 b=PjYh5dp6RtPr6+VpZGzdsUFCmTD+AE99Yyd9K0m/2tl39wqXJ6Iept5whA5rYoc1PZGC
 dnaY+WHfReMq18SdMTtn0/U7u3lbgz/j5hTsloEakeSe5xTps8bzVTvx4iAcmuh/f6NKC
 EoCne2bA09uSofhzej9w7GVDkd3ZSVytSQ9tNXTDlmyWM42/IHciYRX2vlq519OZsLF+g
 Ec8Tk+sDNnU9hzOjEIFoc2n3E0cDDHP132qZjXmSXe6rWblIE8QJCtNw9JkigovNoQFWi
 AqVrgBi5zBvA85v4KStB7pzLuWRKqFjDZNSDH2uTKmiyUIeqWAId5xFP3UHlXlf67GQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=XlnrxgFc; 
 arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=6b17=ie=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=XlnrxgFc
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DBF97607A9
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 21:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1791925272;
 bh=SLXSWRERnAEmLRVCrCtf7u8sQw7gjb/GxbvpVoWcn9k=;
 b=XlnrxgFcLM37MR2y8izOhg2BUnwmg/CUa3dZ2pY4pDV9f3Pa+IHFZgLFXGkfS3Bk+LC7+Pmxi
 vzYQTmLJ+58LExZ+gp1M/FuGbSgpRz4ODdi/56KPCqmzhTacpHJ4Rdm9XV8+U0kxOmk9JZu2KaM
 eEOTvrbDJAgUyWo1vOREVg4+WtAb3nnuDVCZBQOro3qJL5gtDY0+ddKAn1LpPAsCP6X3XKCn9k+
 Tb9bpuy6uV+q/ijOU2lxPBVu3NC7AldJFNzbE9Wbo0nGPkhQwa7kf1uZncZTx1xNe6f1PpTyrQG
 z/HyrGbsZV98S3RSfVgUHTD0/ZD46D/iTStCiB3YTFow==
X-Forward-Email-ID: 6ace9c0e238e9ab748518d2a
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.18.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <8e917d4c-4c0b-46bd-bf0f-84e75c865c8f@kwiboo.se>
Date: Tue, 13 Oct 2026 23:00:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm: rockchip: Avoid BSS SPL config options when
 unneeded
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: Quentin Schulz <u-boot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Kever Yang <kever.yang@rock-chips.com>,
 Johan Jonker <jbx6244@gmail.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
References: <20261002-config-v1-0-11bb20983682@gmail.com>
 <20261002-config-v1-3-11bb20983682@gmail.com>
 <d4dd19c0-2243-4f31-8693-02a25bd4a6c5@kwiboo.se>
 <CAC928HYDGxPsRWz3SatjTP7-d4GPo5ie6EdRpijxF6GUKEVOGQ@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAC928HYDGxPsRWz3SatjTP7-d4GPo5ie6EdRpijxF6GUKEVOGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Massimo,

On 10/5/2026 1:44 PM, Massimo Pegorer wrote:
> Hi Jonas,
> 
> Il giorno dom 4 ott 2026 alle ore 20:54 Jonas Karlman
> <jonas@kwiboo.se> ha scritto:
>>
>> Hi Massimo,
>>
>> On 10/2/2026 6:36 PM, Massimo Pegorer wrote:
>>> The configuration options SPL_BSS_START_ADDR and SPL_BSS_MAX_SIZE are
>>> guarded by SPL_HAS_BSS_LINKER_SECTION and SPL_BSS_LIMIT options in the
>>> common/spl/Kconfig file where they are originally defined. Addition of
>>> a second config statement without 'depends on' guard causes these two
>>> options to be put in the configuration even when the guard is not
>>> selected, which is unneeded and sounds wrong.
>>>
>>> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
>>> ---
>>>  arch/arm/mach-rockchip/Kconfig | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
>>> index 1a2e7847c9e..5ed774159be 100644
>>> --- a/arch/arm/mach-rockchip/Kconfig
>>> +++ b/arch/arm/mach-rockchip/Kconfig
>>> @@ -836,11 +836,13 @@ config SPL_HAS_BSS_LINKER_SECTION
>>>       default y if ARM64
>>>
>>>  config SPL_BSS_START_ADDR
>>> +     depends on SPL_HAS_BSS_LINKER_SECTION
>>
>> This change is causing make to prompt for SPL_BSS_MAX_SIZE when building
>> e.g. tinker-s-rk3288_defconfig.
>>
>>   Maximum size in memory allocated to the SPL BSS (SPL_BSS_MAX_SIZE) [] (NEW)
>>
>>>       default 0x63f80000 if SPL_TEXT_BASE = 0x60000000
>>>       default 0x43f80000 if SPL_TEXT_BASE = 0x40000000
>>>       default 0x03f80000 if SPL_TEXT_BASE = 0x00000000
>>>
>>>  config SPL_BSS_MAX_SIZE
>>> +     depends on SPL_BSS_LIMIT
>>>       default 0x8000 if SPL_BSS_START_ADDR = 0x63f80000
>>>       default 0x8000 if SPL_BSS_START_ADDR = 0x43f80000
>>>       default 0x8000 if SPL_BSS_START_ADDR = 0x03f80000
>>
>> Possible adding something like following?
>>
>>         default 0x8000 if !SPL_HAS_BSS_LINKER_SECTION
> 
> What about selecting SPL_BSS_MAX_SIZE default based on SPL_TEXT_BASE instead of
> SPL_BSS_START_ADDR?

Unsure, the original intent of the BSS_START_ADDR dependency was to only
affect boards that had transitioned to use the common bss and stack
addresses introduced in the commit 008ba0d56d00 ("rockchip: Add common
default bss and stack addresses").

Not fully sure about current migration state for AArch64 targets, I do
not have any rk3368 boards so never tried to migrate targets for that
SoC to use these common addresses. Most/all other AArch64 targets should
now use these defaults so it is likely these checks can be simplified.

> 
> This seems to me more straightforward. As this configuration states, there are
> cases where SPL_HAS_BSS_LINKER_SECTION (and thus SPL_BSS_START_ADDR) is not
> needed, but SPL_BSS_MAX_SIZE is. Therefore, I would avoid a default definition
> based on SPL_BSS_START_ADDR.

It is likely these complex conditions have overplayed its need now that
most AArch64 targets have been migrated to use these defaults.

> 
> On the other hand, I've just noticed that the value is the same in the three
> SPL_BSS_MAX_SIZE default statements, so it would probably be even clearer to
> have something like (not tested yet):
> 
> config SPL_BSS_MAX_SIZE
>     default 0x8000 if SPL_BSS_LIMIT
> 
> What do you think? Thanks for your revision.

Please check current values used for ARCH_ROCKCHIP boards using the
qconfig.py tool. If all boards use this value, we can likely just move
this default to normal "config SPL_BSS_MAX_SIZE" in common/spl/Kconfig.

	default 0x8000 if ARCH_ROCKCHIP

One goal should be to continue migrate as many boards/SoCs to use the
common bss and stack addresses. It should mostly be older ARMv7 SoCs
that I do not have access to that never have been migrated. I do have
access to rk322x boxes, and have some early work for that SoC, but too
much other work to try and upstream before circling back to rk322x :-)

Regards,
Jonas

> 
> Regards,
> Massimo
> 
>>
>> Regards,
>> Jonas

