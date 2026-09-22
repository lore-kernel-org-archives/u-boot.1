Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15B5C982FA
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 13:28:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 82727607A5;
	Tue, 22 Sep 2026 13:28:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WRDwF-4K87cb; Tue, 22 Sep 2026 13:28:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5368D6069E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790083689;
	b=STVz8SPcxjuhXh81XNcRy/S1w7ZgbqCRvEUnBL85o/buD+8DwwXim+rDycSEnFlwV5yK
	 +41139EBGx79x589yPlFFb6hY7KGghb991jUfJ6D18myy4Cgs+NMC8ue4LRJoUPfukhMg
	 ONNTXYCIpkVi0ucStYrxYZPm2B6MGQ1pz9jxnOIu3Z6OdXmZYJCmtQo2E4Gki1phrC41F
	 Sj++qIjzkFQWVX1GU9PlYptBQmztakVLfJkphF3w4z09yPgm1gn/eWy5k99cb257OOsML
	 bDfjrmyS1rmRhmo9k/qRWncXKW0X6zrG5m0sU8nru4G2z1Vx1vYJr6I0sYUFKNLzt2w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790083689;
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
	bh=OewELTLOwe/eB7ppawSLVQJuT7b3zDqpARACfmgqRuI=;
	b=N3BYV73OleTDKgBxWYJpf9wgKdeVjRa/vsvu2wL0dKUfXAEWMhdXUY5ENcg/ixLp0+8v
	 pLbcTgbfsSbfBhfm5Dg1PfIlnQBs1bcgCgq3n7kN+EfwCLAt1+GB3qWX5BxvVAdiGt/cO
	 D0nwTTyIzWRBu1iLt2h/41lhk+L2uB/MFcb7e8j9k/FnCsggGdzfPczqNWMSlQ0NMaCt6
	 i8MCVsu83G0lOuwmd/znT7jI6tdOwdUANZqjWmvUxQ92Bom/dEIXyLT2T7ZzMmNViBNzm
	 Ejc5WXqfd7L1yXe0jY/OWfcy+Bm8EWQ9XW0FL8fLCk+bEfpAzUAcMRV/jmr9vJLSfkg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790083689;
	bh=OewELTLOwe/eB7ppawSLVQJuT7b3zDqpARACfmgqRuI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D1BPI4id9kdjuSV8iNOr81KdrQZpRpM5tyObBxJaTz6KjyIEsEmhJrsuUOXSNHDYm
	 HD0fu5EIMGCjDqykpDRY4aV3UzboW7I0PQAXntZsprdssbwKc//bnsD0Fjp64LDj4T
	 lKxPZV3wB+IN3+zW8X9cntAAyI1bt37GvQLrmHaxbDuV7GB/1qkkdwoJe2f4ai+M4L
	 aydknZYVcxVoirg48r5FJFXoul6QAdlyCwI9AzJr6RMFlg6+t00gjBfViIuAzLtAi1
	 njfHjhQ2UNbs4GeSgLqQ84YT46SIW5s4WZWS8N+M9S1fcjtqiNT3w+R8eeMFqKDd+C
	 hd+MMMUhhuH7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5368D6069E;
	Tue, 22 Sep 2026 13:28:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C963712C
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 13:28:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AF2E7406F2
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 13:28:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tjQtT2UeDmRR for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 13:28:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4C18F406EF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790083686;
 b=PAnPUhSrXkFxscTqf8TKqCz/ND014hZ0lkiWRcoc5WnCYkdIQ94lVEwfYnSlffN527eR
 J1aomiYetyiEudNjuruZyA/Jr8eU4dWE7TdoTOShKWvvvemMtwWvrZuMsjNYTqldTZSne
 KWABw1w6fZEIIzvxsGeiRNcadtFNzNqUF4M1JAaMkvVK02dAPaJcFGLJHGIgcgBC2cNFj
 Sx3EV3Hbv8yynCqfx7jUOzy5D/C4CeuoLh1ZLVsCZ82VRSmixk2DkWHF03q5G2rMgkSr3
 Qga3LZCa41BoIHWQ/1pd1v7DZC5TpHUoMuhgCMBE0++05hOejLBAg4+qtJx+Y/+ghlQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790083686;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=OewELTLOwe/eB7ppawSLVQJuT7b3zDqpARACfmgqRuI=;
 b=U0QgupyPaMZAWBFt/IHrxXzutPpr11LXgltuLBmbKsbrT7xpzsJvXfeOE6DSWa/msfmV
 RGIdfU2JSbXRzkM7NNYCAbomvH1nu7IPP75ej+XGqR4O5Srn3p+C9glqot6NSQ5ZggaA4
 dm1AdfgSOqI7afmlCs7EflZtF9h8SoVKRDfLDZjeIZ43gwMI+u+uFNBZ3E6ycZJ0MtSJO
 kNAVc8uk4o5yb0rW7GS0zVCHqdkSSL/WJX+eYZ9utShTr9CjrHyf7G6Dh1REHCi2rRjKz
 roPcsj1j1rMjQrWF5/TBXGYeW2JhhJ6xNBGswy+1yxKPzTLswaeu/WKQtQr3nwst3jA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kwiboo.se; 
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=YoR6Ucdn; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=0f3a=hp=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=YoR6Ucdn
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4C18F406EF
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 13:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1790083683;
 bh=OewELTLOwe/eB7ppawSLVQJuT7b3zDqpARACfmgqRuI=;
 b=YoR6UcdnDS1qco//sKALnmSOX8uD/CHA3KiWapG3WrJh9hBM3YKUfNTuEaYqqzZ0qQi7Ysjdz
 R6Jb5utZPUg55F0FJk7mRERhuLD9FF3GRYlXfPurNL/cEgNc/lzkRDKw25jM2vRVRrRWORmqr18
 wY9IVWDKk5lUvTK2R3D4+jy0vrxd406I/AcQ6TAJj9lW4cY3qeOSveBPlPiSyJjjEoByIkO8cGe
 +bStlP3sl0QzYCnm2A43xm3oJ0ULcql2YmhENq5HRPATKmJ0fLu9w7flHQjBbSAZeo3kEHl7+ac
 x+IiSdqsmKJVQ7yPxkyb4KCVnD8UPw+z5QBYLDEGQ2GA==
X-Forward-Email-ID: 6ab2825f51a0861ba43c136d
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.15.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <ca280adf-19dd-437b-946e-8e5e7f700464@kwiboo.se>
Date: Tue, 22 Sep 2026 15:27:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rockchip: px30: Fix TPL_STACK overflow into BootROM
 reserved region
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
References: <20260920161930.1880133-1-jonas@kwiboo.se>
 <CAC928Hb3HdGURxLFhxocpQAWGVB2morvpLP=GEsRs_w1iE0oig@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAC928Hb3HdGURxLFhxocpQAWGVB2morvpLP=GEsRs_w1iE0oig@mail.gmail.com>
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

On 9/22/2026 1:35 PM, Massimo Pegorer wrote:
> Hi Jonas,
> 
> Il giorno dom 20 set 2026 alle ore 18:19 Jonas Karlman
> <jonas@kwiboo.se> ha scritto:
>>
>> The PX30/RK3326 has 16 KiB SRAM at [0xff0e0000, 0xff0e4000), with the
>> initial 4 KiB at [0xff0e0000, 0xff0e1000) reserved for BootROM at boot.
>>
>> SRAM addressing only seems to use 14 bits, meaning that reading from
>> 0xff0e4000+ wraps around and instead reads back data at 0xff0e0000+.
>>
>> Using a TPL_STACK at 0xff0e4ff0 (16-bytes aligned) means TPL use BootROM
>> reserved region for its global data, malloc area and runtime stack.
>>
>> TPL on PX30/RK3326 does not have any use for the malloc area, the
>> generated GD_SIZE is typically around 304 bytes and BSS around 72 bytes.
>>
>> Current memory layout possibly looks something like:
>>
>>   [0xff0e0000, 0xff0e4000)          16 KiB   SRAM
>>     [0xff0e0000, 0xff0e1000)         4 KiB   BROM area
>>       [..., 0xff0e08c0)                       stack area
>>         [0xff0e08c0]                           stack pointer
>>       [0xff0e08c0, 0xff0e09f0)     304 bytes  global data (zeroed)
>>       [0xff0e09f0, 0xff0e0ff0)    1536 bytes  malloc area (untouched)
>>     [0xff0e1000, 0xff0e4000)        12 KiB   TPL area
>>       [0xff0e1000, 0xff0e3800)      10 KiB    code
>>       [0xff0e3800, 0xff0e3848)      72 bytes  BSS
>>
>> TPL currently does not touch the malloc area, instead the reserved
>> TPL_SYS_MALLOC_F_LEN bytes help push the zeroed global data struct and
>> the TPL stack addresses deeper into the BootROM reserved area.
>>
>> Using current offsets for global data and stack does not seem to cause
>> any known issue for BootROM after TPL returns to BootROM to load SPL
>> into DRAM, however any change to TPL_STACK, TPL_SYS_MALLOC_F_LEN or code
>> could theoretically change this and cause issues for BootROM.
> 
> Here with "any change to [...] code" I suppose you mean any change of global
> data and/or BSS sizes, correct?

Not only, the change to TPL_STACK, TPL_SYS_MALLOC_F_LEN or 'struct
global_data' would affect where the TPL stack ends up. However, and any
change to the code may change how the stack is used and thus possible
write to more/less/other data inside the BootROM area.

> As code size itself is checked against
> TPL_MAX_SIZE at build time. Regarding build time checks, I have a couple
> of doubts about [1]:
> - shouldn't we check for less than or equal against TPL_MAX_SIZE, instead of
>   strictly less than?
> - shouldn't be more correct to check the TPL "footprint" size against the 10
>   (or 11 or 12) KiB limit, instead only the code size?

Correct, this was also briefly discussed/mentioned in the v2 thread. However,
this patch only tries to address the issue with TPL stack being placed inside
BootROM reserved area.

> 
> With the new layout the check should be:
> code size + BSS + GD_SIZE + TPL_SYS_MALLOC_F_LEN + <min_stack> <= 12 KiB
> 
> [1] https://github.com/u-boot/u-boot/blob/main/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
> 
>>
>> Update TPL_STACK to use the top of SRAM address and reduce MALLOC_F_LEN
>> to 0x200 to avoid overflowing global data, malloc area and stack into
>> the BootROM reserved region.
> 
> The new layout is certainly safer, but I wonder if we are losing the
> opportunity for TPL to have approximately 2 extra KiB as they are not used by
> BootROM once TPL returns to it. I mean, it would be useful to know where
> initial values of TPL_STACK and TPL_SYS_MALLOC_F_LEN came from, and the
> rationales behind them. If Rockchip were to assure that preserving only the
> first 2 KiB of SRAM is enough for SPL loading, keeping these 2 extra KiB on
> the radar could be useful for future TPL development and/or maintenance.

Please look at v1/v2, they safely allowed for up to 11 KiB TPL. However,
that change should be handled in a separate patch/series.

Some of vendor ddr blobs continue to use the BootROM stack, and others
setup a dedicated stack at end of SRAM. Mainline U-Boot use a dedicated
stack, and it is placed at end of SRAM for all other Rockchip SoCs.

This patch tries to align PX30/RK3326 to use TPL stack at end of SRAM,
ahead of a future pending TPL consolidation/refactor series, see [2] or
deep in my work-in-progress branch at [3].

[2] https://git.u-boot-project.org/u-boot/contributors/kwiboo/u-boot/-/commits/tpl
[3] https://git.u-boot-project.org/u-boot/contributors/kwiboo/u-boot/-/commits/rk3562

Regards,
Jonas

> 
> Regards,
> Massimo
> 
>>
>> With these changes the memory layout looks something like:
>>
>>   [0xff0e0000, 0xff0e4000)          16 KiB   SRAM
>>     [0xff0e0000, 0xff0e1000)         4 KiB   BROM area
>>     [0xff0e1000, 0xff0e4000)        12 KiB   TPL area
>>       [0xff0e1000, 0xff0e3800)      10 KiB    code
>>       [0xff0e3800, 0xff0e3848)      72 bytes  BSS
>>       [0xff0e3848, 0xff0e3cd0)    1160 bytes  stack area
>>         [0xff0e3cd0]                           stack pointer
>>       [0xff0e3cd0, 0xff0e3e00)     304 bytes  global data
>>       [0xff0e3e00, 0xff0e4000)     512 bytes  malloc area (unused)
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>> ---
>> The overflow/wrapping was runtime validated on a RK3326 ODROID-GO Super
>> by printing out content of [0xff0e0000, 0xff0e5000] and comparing the
>> initial 4 KiB with the 16-20 KiB and the data matched 1:1.
>>
>> Changes in v3:
>> - Drop TPL_MAX_SIZE change
>> - Keep a small 512 byte malloc area
>> - Update commit message to reflect changes
>>
>> Changes in v2:
>> - Mention BSS in commit message
>> - Update spelling in commit message
>> - Collect r-b tag
>> ---
>>  arch/arm/mach-rockchip/px30/Kconfig | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-rockchip/px30/Kconfig b/arch/arm/mach-rockchip/px30/Kconfig
>> index adba1b49a52b..0088d436d36f 100644
>> --- a/arch/arm/mach-rockchip/px30/Kconfig
>> +++ b/arch/arm/mach-rockchip/px30/Kconfig
>> @@ -81,10 +81,10 @@ config TPL_TEXT_BASE
>>         default 0xff0e1000
>>
>>  config TPL_STACK
>> -       default 0xff0e4fff
>> +       default 0xff0e4000
>>
>>  config TPL_SYS_MALLOC_F_LEN
>> -       default 0x600
>> +       default 0x200
>>
>>  config DEBUG_UART_CHANNEL
>>         int "Mux channel to use for debug UART2/UART3"
>> --
>> 2.55.0
>>

