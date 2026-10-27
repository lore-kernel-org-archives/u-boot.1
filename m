Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD718606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 18:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TSmPc1I4;
	dkim=pass (2048-bit key, unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=vL1nDX47
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD7FC60806;
	Tue, 27 Oct 2026 18:23:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7bJa08QBWG-l; Tue, 27 Oct 2026 18:23:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 693F7607EA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793125393;
	b=ReQ4HGBnXIKqCgZ5mbi4e+v/qffVZJsTPT582FlOWrKE+5hG6twMCqERdo/5lBd5Roc2
	 ZiZGMp4Fus0oGQ72YsOgsDEXtwm37GpKNmG8IClM58KAtywLYy9mxBkM8cXx2eVELTWNu
	 v14jqL26vAEuYuXD1vjF9iX/udeUhB8ROGNXuogV1JjkLGyd0PKM/vw6xskKRuRM/4WPp
	 cO4S9cdthjAiEQ2/sL+odLOZKyyvLYBb2jNBF1T/56z/PN+6beQWICQG00Je32oMjIG6q
	 e9Yj2Gk3R0neVBQjU9kHkHrofsFG9wYswKgObeLW9vdRZVdPcl4iaOirOr2HQpMPdZA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793125393;
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
	bh=jrVlmj67fkXtzypl8nt+oEIw8gnrMKwqlB+5Dn9DyA4=;
	b=THL/80jJ1gD0bRWe/YDs4GhHDCVD261n56Ipj5gBonILLl5VoN8q81fYJ8FtT1J5NDri
	 5B0gNrqVh7dpeWp0hkPdQwiK/PkBOm93EXNcc6hCeSKRvqq6k0HdimX70I52lCO6l7tGN
	 E8kVamNbsiMLEJTUDSf7Ki8L82h0jGwiubeyeWsybpPR89rjnqh9dmZ7iNcsd01Ga8I7n
	 FvvwQkh0qmYVmndPXLTzCSsD7Bjw6XORG1yhvzkTlL+TQxifovOscPZoO2X9lfK7h+UtI
	 yUkGVs6575qXwts+4FGo8TmVEm/kCoCoij8LawN2ForaIBqipPMnlLTtyfqaDoXWH5A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793125393;
	bh=jrVlmj67fkXtzypl8nt+oEIw8gnrMKwqlB+5Dn9DyA4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TSmPc1I4h1POqiy+A48PtAUZQoNvOPiALfShg0XG2zWhO9uNeoYf4exeoOu3VpZGF
	 uHn+GIczECNNbSSnMuO/RysSEovQ4aiT7wMFvPLqG3VNO3G+w/QR3OIzCKOEH8S7+V
	 CGytwDQCp62NCn1oOUXoRwebMkRuWdOTku1USgK2VT/AYUpy4LHHjRdI5RkQBHayTC
	 mu9m4jAz+CXylGHJWLRghdVGyCkBupSWR1hDfnceuZlNcv2khrJXX1Jsjue+DFk4FP
	 4AMYkf27T9sPaN+Ck9pBYV0cutUTYFQJsLqJydZF/orkYq1WVwevvWv+ZQYYirlhYh
	 UBtCsNAvYuJaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 693F7607EA;
	Tue, 27 Oct 2026 18:23:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B04084D1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 18:23:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 964F34016B
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 18:23:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rWU12GmBqNAh for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 18:23:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 575964006F
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793125390;
 b=W0bCKM5JgsR8dutqraKCh2GWgl1GRMDToV4QUTtoyNlyo8lyJscCsP/shwQajOUHDPtT
 +AXitdOF+6rX3DXpniiL4v2O42VeEKyItJCsNT57RG+zNjmRnWmX7pp9T+Lo78qHShnL5
 7SsRaUfuEIxjCF301QwJId6A2GB/1VJbJzZMs2lM8GkdE/J1Y+dHHBtK/U3CsZ4DSfjS7
 I0R3tMzJ1UfK0RVrJumMxJf+My/QbBh+9a1CqDdrLt+5IKgfehgLt7bJq5XS7K0J2FcEg
 yTnz6/X5Gbqv9qg2wyTUSgulJuMtpEUHG/t7P9eSlDACDwTDD42z3ExmnB2ety+Jc3g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793125390;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=jrVlmj67fkXtzypl8nt+oEIw8gnrMKwqlB+5Dn9DyA4=;
 b=Duisi6eo2kU9l7vCydbn/dwS5dOdfB0KSWPGFl+cAGEzMamj5VUFMFtvsehKxQtWNefN
 oxtdIynyMXY6YXxXygK2jXNNA7QyK8SUJYJMsM9CWd3Sxnbs+sNM23t5eN26m0gfHO7Qh
 ADx/1enRPODp5Av57Tw8U+R+whhBpiIv440dXJfzwRf++6wD0R0wh8fh3ybb966Ha6fD6
 U0JwiQl02DSDGl9OczAR8DifYS3xXa9whlk68GACkVXyOdcWk6/gzL5SGCXnpc8SCCCO4
 pPCczNcAkzvVZvcP6WwK3oPjVYcUJYFj9LN1d/DnTm2bseu3SfKmVOZ6WCzqoGrOKFw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=vL1nDX47; 
 arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=248a=is=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=vL1nDX47
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 575964006F
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 18:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1793125387;
 bh=jrVlmj67fkXtzypl8nt+oEIw8gnrMKwqlB+5Dn9DyA4=;
 b=vL1nDX479WSrFK3RSw5BgAQsAmaJe0qC97ttoAndjOGNNBj7znkj+ByIXdCqVUbF3oFRRY6FO
 PaVRd6VSEHUwKvAv09gl9PPWIHQP3a1z4sO3Tyv69CLFMYgkJ5Qk19hZogoeeOjw06KTgrqVxHZ
 TMFai6uEUpB8RrccpERTLn3nO9948812g0tbstkfd0PK7hCPG70xdDJW8FF39Z7q6+bcUlNQr5j
 5c6fVv4k4sjIAKskN2Uzgeige0tAoqP4qf1QmEdWIrmMqOxgDGp+BRBiFvpr0FxqOytjQgxFfAZ
 2wUx78G+rD1k/VPD5BgWhSXVRgItexxVelVi+Sj4C0wQ==
X-Forward-Email-ID: 6ae0ec09c9e603e316fbc047
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.18.11
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <a0787d5d-0973-4235-bd34-ff3596b00bc1@kwiboo.se>
Date: Tue, 27 Oct 2026 19:23:00 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rockchip: mkimage: Update init code size limit for
 RK3328
To: Quentin Schulz <u-boot@0leil.net>, Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, Kever Yang <kever.yang@rock-chips.com>
References: <20261004195853.59863-1-jonas@kwiboo.se>
 <20261004195853.59863-3-jonas@kwiboo.se>
 <dc849a75-9166-41af-9ba5-abe8a63be884@0leil.net>
 <c59af0e7-a265-4521-8258-01296de5fcf1@kwiboo.se>
 <d3ec0007-47bc-4e0b-b652-1bc1ba160003@0leil.net>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <d3ec0007-47bc-4e0b-b652-1bc1ba160003@0leil.net>
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Quentin,

On 10/27/2026 6:42 PM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 10/16/26 11:25 PM, Jonas Karlman wrote:
>> Hi Quentin,
>>
>> On 10/16/2026 12:31 PM, Quentin Schulz wrote:
>>> Hi Jonas,
>>>
>>> On 10/4/26 9:58 PM, Jonas Karlman wrote:
>>>> The RK3328 has 36 KiB SRAM at [0xff090000, 0xff099000). With 4 KiB of
>>>> the initial SRAM typically reserved for BootROM during early boot.
>>>>
>>>> BootROM will load init code of up to 32 KiB (0x8000 bytes) to address
>>>> 0xff091000 in SRAM, before jumping to it.
>>>>
>>>> BootROM typically jumps to init code with following registers:
>>>>
>>>>     x0: 00000000 ff091004
>>>>     x1: 00000000 32334b52
>>>>     x2: 00000000 ff520000
>>>>     x3: 00000000 ff500000
>>>>
>>>>     sp: 00000000 ff090f50
>>>>
>>>> mkimage is enforcing a 30 KiB init code size limit for RK3328.
>>>> However, the BootRAM can load up to 32 KiB of init code.
>>
>> s/BootRAM/BootROM/
>>
>>>>
>>>> Change the init code size limit to 32 KiB using the <size> - <reserved>
>>>> pattern to closer match the actual limit of BootROM on RK3328.
>>>>
>>>
>>> Downstream still uses 0x8000 - 0x800 so unless someone from Rockchip
>>> confirms this is safe, I would rather not modify what we have today.
>>
>> Maybe my commit message was unclear, but I have runtime confirmed that
>> BootROM is capable of loading binary code up to 32 KiB from SD-card and
>> eMMC and the code was fully functional even when padded so _reset was
>> placed at the very end of binary, in the last and lost 2 KiB.
>>
>> Most likely the mkimage size limit was used to impose limitations for
>> stack and malloc area, very similar to the issue with PX30/RK3326.
>>
>> Runtime test consisted of running a minimal <2 KiB TPL binary that only
>> initialized DEBUG UART and dumped passed x0-x6/r0-r6 and stack pointer.
>> The binary used no malloc area, its stack was pointed to PMU SRAM or at
>> half of BootROM reserved stack area, and the binary was .space padded to
>> push code to very end of the loaded binary.
>>
> 
> How can you be sure that we aren't corrupting the BootROM stack? Between 
> TPL and SPL we actually go back to BootROM so code from there run for 
> sure after TPL has run.

We cannot be 100% sure, however as stated in the commit message, the
BootROM stack is located in the initial 4 KiB of SRAM, [0xff090000,
0xff091000), and its stack-pointer is typically at 0xff090f50 when
entering into the init code, i.e. it matches the pattern used for all
other Rockchip SoCs where the BootROM stack is located before the init
code load address.

The issue with RK3328 is likely that some datasheets/TRMs mentioned
32 KiB of SRAM in some places and the correct 36 KiB in others. Right
now, we reserve initial 4 KiB for BootROM, allow 30 KiB for init code
and for no reason restrict use of the last 2 KiB of SRAM.

The limits imposed by mkimage should not care about what the init code
does, it should only impose real HW limits and not make assumption on
what U-Boot TPL is doing. Let's say I created a custom binary that takes
up entire load address to end of SRAM and can safely run, right now
mkimage cannot be used for such binary due to this self-imposed limit,
for all other Rockchip SoCs such binary would be accepted by mkimage.

Any limits e.g. due to use of TPL stack, malloc area or back to BootROM
feature is specific to the U-Boot TPL binary and should be limited using
TPL_MAX_SIZE or similar, not by the init code size limit of mkimage.

> 
>> I did similar runtime tests on all rk3288/rk33xx/rk35xx/rv11xx SoCs I
>> have access to and all current limits in rkcommon.c beside PX30 and
>> RK3328 matches the runtime limitations.
>>
>> On RK3288 (96 KiB SRAM) we can even load a binary up to full 96 KiB,
>> however from SD-card, only current limit of 32 KiB worked.
>>
>> Please reconsider and/or hopefully Kever is able to confirm my findings.
>>
> 
> I'm not sure we'll get to see Kever much anymore and I don't know who 
> exactly we should be asking. I've been told Chaoyi Chen might be a good 
> point of contact now, so trying this here.
> 
> @Chaoyi, can you confirm we can use 32KiB of SRAM on RK3328? See 
> https://lore.kernel.org/u-boot/20261004195853.59863-3-jonas@kwiboo.se/t/#u 
> for the whole context.

Would be nice to get a confirmation, however my runtime testing should
already help prove that we can load and run a 32 KiB binary on this SoC,
and that the limit imposed by mkimage is correct for all other SoCs I
could run same test on: rk3228, rk3288, rk3308, rk3326 (after patch 1),
rk3399, all rk35xx variants, rv1106, rv1103b and rv1126b.

Regards,
Jonas

> 
> Cheers,
> Quentin

