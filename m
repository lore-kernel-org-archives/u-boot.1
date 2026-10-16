Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A08CCF2C4
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 21:26:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1C94840A21;
	Fri, 16 Oct 2026 21:26:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iUSIfj2lxcUV; Fri, 16 Oct 2026 21:26:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5666E40A22
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792185999;
	b=LEVIP7lRzMdR3aHLjG30Fo1PAWNJvH+6513pp6nC0o1IHiL5iEQs3KEdeuw5C9RTyFMa
	 espdGVA4fTXz0zOlJkXLAF8gs28HTc5WG+4Kx6zxUvHfkHZOg3boBANOFe8g2YIqw/dfc
	 CVIaUtE3gKI3lsxPuZKpo3t5P6kLBuHvmEUKEDjFWoO707NbxZ9Q3l7QNG6ScaRFP7HkG
	 U38WuOBeNnODrGe4JveXHiAQ8oNlQ5OvkRu8eaEEnVxEFMfLXVeYC0cH1WaieiDIJH+Ae
	 VC9RNDDt3ogUygbfTDHbK+38Hb7Y5mUN8SoAYFgJ1H3N/EHAGRqd6h4H/EaQyfZmr3A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792185999;
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
	bh=AGXr1VrCHpT8UcKCCpwW16wPVCgkDshgTMXTJPUxjuo=;
	b=sbLXLAmJVzV7K6jLh03dv9uwhdnJlQQNJ8dt6SjGQilZgGuGOQc75DGUpe8SNdyl2txL
	 m7adpWJTO7ub6oAWPDPBt0SCudL6gWJ0ylmrLcCOXpcmsnkghEYUoQWK7YJippINXPL2z
	 eghBWeV7mWZRE6n9pRQQzvxULO+J2Ao0fpMZ5BUfNlpg1kBQ0dgX4cbXFc7Cx1SKl4pCJ
	 RNqeqW3FkDHsklP7WpRdJ2Hl/WC8HFsx5BA/OcKqVcaAzMy7JjpvFkNdw22cL+UfrS7Y7
	 KVzWD+gQZdoL4JLZn04WiSnGsNBMQ8h4t5EoSiOvv8Jh68uVeWTQIp3I3b81MIKflIg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792185999;
	bh=AGXr1VrCHpT8UcKCCpwW16wPVCgkDshgTMXTJPUxjuo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=INn5riH+dlAellnbxeAjaMJ6uvZC3Noy9xrinl+fCK/Gdbu0AXeHXnrESthUQmd8t
	 +uTWgaaDRYc8tiZJW0u41zTRUCAp+kIYXmwtqq7TOv6o5vaVM/roUqRjWkwn7rKT00
	 qc6nflrN8MdrebE2BnX8sBv9kObBnb/IDyUTjFxn7CqdC3wEbo0aTZL96ghrn84n+6
	 8VNFH+zuvVt1yPW+nFVCwe/JE8SuEzPJhI5pzVQdBmNuN0HaYWdV8yIr+wH4EhG/cZ
	 9Vipae3P4621dIul9ciJjUwSEUaha4DfaCeanmhdgg7QA2fM0D8Ot7wsVdKWsCIThj
	 FfDPmCAG1J4VA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5666E40A22;
	Fri, 16 Oct 2026 21:26:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D8F4105
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 21:26:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6B444814EA
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 21:26:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xdqOZYnvY2dP for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 21:26:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 438E0814C4
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792185997;
 b=Y5M0l3lEOnd7QDxiPZFfvzoPH53sqjsM8rFHC0N22r5jnrlmK6CcT7++/L06aGZL3vmr
 X/PNEAC5s2Z3iHFntz3VeVczEOxOtDmG+eptO17mGrS4czoMwucqGLkc/bQJ4JB1HrD8S
 yr6hzqL9JznBT+ZNlxt4vlrf01ZPdhLTWcDMtsnyHsJQ/tpyycWU8pMO1NUjZAo9hKwju
 U3dZmPOzl19u/kK5Q/BqITAuhElEXUV8yz7c4AQ0Oay1w3Rv9CtoI90VfGNXLFbDtgEX8
 XWZD9Xfnytd3EfYUtw18L3G/z7b66zjvu5JoLGhsfLOLsWAIX/ekREnJ4o1w82u0qsw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792185997;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=AGXr1VrCHpT8UcKCCpwW16wPVCgkDshgTMXTJPUxjuo=;
 b=iBzXKotdjqlr7+EMJb+js7OsXDvLxiOQtILjSBCoTNPU96gKyqQAjjVogViMWpehxH1J
 a4foBw5UaatAdY7dLefskjbP4GBOnz+JSJb9Is18wNb9xc2zpMke0NBrMfWaWxZHHtMNY
 2PTW5pQxVOwdBaOgBHHMkfEgolqlcX6xgOrNZeFvaf5EwMYntvbC+HdTdoiys5eytVN6v
 3QgOe982Ff+Mi4jICqeK7xBSJR0B4rFESykFED2u7RkS/fhPw9eym0dMradB1hTGjPZFp
 /qyV2gB90ykEHA+eW4iqFLaajiDW3T1RUXNhVDTXPUYJPEarLVuYwwmay9Deo8Zs9EA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b="tjshiNN/"; 
 arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=a807=ih=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=tjshiNN/
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 438E0814C4
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 21:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1792185995;
 bh=AGXr1VrCHpT8UcKCCpwW16wPVCgkDshgTMXTJPUxjuo=;
 b=tjshiNN/M2l5htlHrwUaptIlWkU2HQ1wwJhKttn/JsPe/IEP36YW80NbrifnTb1PrZSXUWZVd
 IY97YcOIdnSpHrVS04BKrsNjGIr6LuMx+sk/g5aJWNEqn0dZFMmMn6aI28ddbTtgkzBEYupoRrN
 aKmP94ClCfXfbNmZV2ayALRCFPJHvyl90TE6bZQ1M2hBTaFw7WgnqTm0KS40qPO63lWUjace4uw
 3oLFZ86xa1zFbDdY+XrJqEwCQUiB9Q3Fjb1bZDP5FE12/QDsACTcUDPIsFHetl/NZFmWmZzXyJ9
 uh6EzH1Sesvn7tkKRULXDcWjCsnE9xP5m8iA1kDAzvpw==
X-Forward-Email-ID: 6ad296694db8ac7a00a17641
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.18.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <c59af0e7-a265-4521-8258-01296de5fcf1@kwiboo.se>
Date: Fri, 16 Oct 2026 23:25:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rockchip: mkimage: Update init code size limit for
 RK3328
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
References: <20261004195853.59863-1-jonas@kwiboo.se>
 <20261004195853.59863-3-jonas@kwiboo.se>
 <dc849a75-9166-41af-9ba5-abe8a63be884@0leil.net>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <dc849a75-9166-41af-9ba5-abe8a63be884@0leil.net>
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

Hi Quentin,

On 10/16/2026 12:31 PM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 10/4/26 9:58 PM, Jonas Karlman wrote:
>> The RK3328 has 36 KiB SRAM at [0xff090000, 0xff099000). With 4 KiB of
>> the initial SRAM typically reserved for BootROM during early boot.
>>
>> BootROM will load init code of up to 32 KiB (0x8000 bytes) to address
>> 0xff091000 in SRAM, before jumping to it.
>>
>> BootROM typically jumps to init code with following registers:
>>
>>    x0: 00000000 ff091004
>>    x1: 00000000 32334b52
>>    x2: 00000000 ff520000
>>    x3: 00000000 ff500000
>>
>>    sp: 00000000 ff090f50
>>
>> mkimage is enforcing a 30 KiB init code size limit for RK3328.
>> However, the BootRAM can load up to 32 KiB of init code.

s/BootRAM/BootROM/

>>
>> Change the init code size limit to 32 KiB using the <size> - <reserved>
>> pattern to closer match the actual limit of BootROM on RK3328.
>>
> 
> Downstream still uses 0x8000 - 0x800 so unless someone from Rockchip 
> confirms this is safe, I would rather not modify what we have today.

Maybe my commit message was unclear, but I have runtime confirmed that
BootROM is capable of loading binary code up to 32 KiB from SD-card and
eMMC and the code was fully functional even when padded so _reset was
placed at the very end of binary, in the last and lost 2 KiB.

Most likely the mkimage size limit was used to impose limitations for
stack and malloc area, very similar to the issue with PX30/RK3326.

Runtime test consisted of running a minimal <2 KiB TPL binary that only
initialized DEBUG UART and dumped passed x0-x6/r0-r6 and stack pointer.
The binary used no malloc area, its stack was pointed to PMU SRAM or at
half of BootROM reserved stack area, and the binary was .space padded to
push code to very end of the loaded binary.

I did similar runtime tests on all rk3288/rk33xx/rk35xx/rv11xx SoCs I
have access to and all current limits in rkcommon.c beside PX30 and
RK3328 matches the runtime limitations.

On RK3288 (96 KiB SRAM) we can even load a binary up to full 96 KiB,
however from SD-card, only current limit of 32 KiB worked.

Please reconsider and/or hopefully Kever is able to confirm my findings.

Regards,
Jonas

> 
> Cheers,
> Quentin

