Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7795BCCA462
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 10:16:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 71A7960AB6;
	Fri, 16 Oct 2026 10:16:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AN0iwLZ4VzaO; Fri, 16 Oct 2026 10:16:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 477D560A83
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792145784;
	b=aoq3Dk+GEVZ003MROV6H3CY7D56YHySTTXikqJ19Co8CfAbpwv+zF1DPvSB06P8Upkgl
	 U6o0cEFZWXARpa21pTpygUJfBbhIqZCajM2vYqEs1ByP35gg9npG+eCJLCoAbDpBHYNQr
	 o8a3w6vL13l5C/E09Ljx9CZoLYztQKy9bEE5UubG+15OhaugL8d/Wfl+RIKWqhpr61EMz
	 G67kmlhGoE9S+Lq9dD/GF4zsGSKd1EY2V+u10bGZDx68tEU9P6JSkE6kEL18A/VKCCJKZ
	 gfSzz6ANl6SRT8PwAt7DrfIOPw6KAXxVYAQLCaY4pmPFQJ2Omogm9NBfFA61KEFtXaQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792145784;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wq8whGGWT4K3FhMUWwXIeGaab4d8RyiXEOexLLNWIpI=;
	b=rur2TAkXHlA1YK04/SX8OsJ2SWQODoB/SU6b70F2K0Z9P7CDs8GbtQu/aT/NHbpN7ybj
	 wxS93niontCUhncUSO2eNbOhoapDmnfxS2+p2gFZH9AfrGUMpfnrMqykTUbds5tP3eLNs
	 HPjZA073HggQgNh4z36fTRE7CKiLN1blEmGJXPYNioZcs5XGMF0gl6xMY0p44aAfFaGdH
	 ImVkSSjTogb6VYMuXxJ0RbI9NOT5NtM6l1xdEKV0dBLAchbcwLiqy8vQTlDmbSdbTwX10
	 sGFbBWqLh3RKMGECHwNhFU7d+MiyXLVPoT4pNgk+o2VZ8s74OjMH1TyuSq8AS0FW8Bw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792145784;
	bh=wq8whGGWT4K3FhMUWwXIeGaab4d8RyiXEOexLLNWIpI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rx3jo3cSUVrgqKVKkqdVvCWe78/Ui52SpYQOBsTEl7AlVSbBWuvZT0VWY3jgIZZaM
	 60bVn/QL+PIZac27R6vFWkhpPY7ArBxBd5FH9UmXcnprZ/USLr2p3EQUxFPmjQhlJA
	 hQSHT2OhNPH8Ib/JFJvRq4TeQQv00DjznItzElM9Xf7oCjp3vru66TwR1PakdMIxfy
	 2DZFfk1fex2BAyn2JDOkE7LfVx7nbUP+Xyk1rNHq9UoTwRJJ9xpoF9ncsGt7sABO4A
	 7Qe7fJjqZNWyN8W/FYPbrZdE1+oynO2EKlKdHMSlE5CNMbv0SUdEWHkCe5hMHVRBq/
	 JkunskQW2/z0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 477D560A83;
	Fri, 16 Oct 2026 10:16:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CF875263
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 10:16:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B5DFE409DD
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 10:16:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iInwk48mdqPd for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 10:16:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1B7E940990
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=84.16.66.175
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792145781;
 b=COWJFHNcT+N+1SZrrMqhh7swT/46GsTr2Vjb5E/LKneYupybM2sjxgnzM7IX1Xna/Vzf
 xDPSBxMRpFtiWdQ/BY25dTJMNsxdoqclPexqzMhJFvxZPq7dUKZ5ZSlrOyxgFS9eFeo6Z
 8pUzzYxddXe9tbzzM0Hq6ktVAYtPu8kGxk3nKGh4+7R8M/GJ8jDfC250VJAG6E/8HEgO7
 fcOVgYOyO01iQTN56Qlnbz4mHICU/lpcwiBCvfM1i0j5CCYJrTNIw5fNNV1Ce5RmjpCrH
 q6n2i4PWeHyLUSxLK7yyU0uvGrJp9ZPuPlM9T4n0/75NOTYV/joaMmt1ItiZNDeM8yA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792145781;
 h=Received-SPF:Received:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=wq8whGGWT4K3FhMUWwXIeGaab4d8RyiXEOexLLNWIpI=;
 b=B1byU/UUjMmovXGk0EYnXeM0pIw8DvFMCpPy+WArB3Sv6iZvGwPbr8Y5wN2f7GN+0D8n
 rfHa+4qWMFnaGXBgbgv1DWdmHrxfN1FYzjzswM8rJB1wo/5Q6QCnbQ+Ix4+FFjN7SvQ/Y
 YUDdv5oW/kkF6kazHSOk8VuKN0D6Jz9G+oKzl15R3aiwy5iBztB4LwMTJEE9K18Re95E5
 5tCA1qMXrjIsuPP+Ub9/YvW1zqaGNNkOJijMTjVpgiw/6JQELXBn273CMC9oQSfjZxpU+
 csFNRxl4vrBSsEnQ42WFgDjHx+HK7S2ehtJ6AEuQW9hZH2FCwf9B3SstDdvC8oecDUA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=XHSMlM8x; 
 arc=none smtp.remote-ip=84.16.66.175
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=84.16.66.175;
 helo=smtp-42af.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=XHSMlM8x
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch
 [84.16.66.175])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1B7E940990
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 10:16:19 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j5gnr4X1xzqC2;
 Fri, 16 Oct 2026 12:16:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1792145776;
 bh=wq8whGGWT4K3FhMUWwXIeGaab4d8RyiXEOexLLNWIpI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=XHSMlM8xP0vMAzb7GCdQsjFXBVuvELuWvRciAfH+1NyyrC9zXmj60jQjyKHX+7xSb
 cequhU+vGzhNpyVsDaX7kW1IjSbOM+//urE69isgKrPy1z3gKP8tuBULiUc45VvbGS
 AcacVY9V1F1fKFY2hiRcQ5p45XfGsuxRXohrV2c+Q2fXcuduFptGcuRwCxJqd+B1fl
 awIVut/0qgBc8Y12SXpH2jJ8ZCiFDg9+inuvLtwYdbShr/8+XhvlSHizqnlrhQhzfB
 9jENWeQpQZGWaUsoAZeKgEu02TEEUvegPykRz2/9khdYfR3oyrdiOUgtUEKbjqHn4r
 D/6Y3197X6/Jg==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4j5gnp3p88zP0b; Fri, 16 Oct 2026 12:16:14 +0200 (CEST)
Message-ID: <1c6f6e9c-9bf0-4117-9999-79143ac12281@0leil.net>
Date: Fri, 16 Oct 2026 12:16:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] lib: Let the decompressors use unaligned loads if
 platform allows
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Johan Jonker <jbx6244@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>, Vincent Jardin
 <vjardin@free.fr>, Michael Srba <Michael.Srba@seznam.cz>,
 Cole Munz <Munzzyy1@proton.me>, Kever Yang <kever.yang@rock-chips.com>
References: <20261002-unaligned-decomp-v2-0-675466ced78a@flipper.net>
 <20261002-unaligned-decomp-v2-1-675466ced78a@flipper.net>
 <9e0762c4-57b1-4e61-adb5-32031da77c93@0leil.net>
 <CAKTNdwFVRTjq14Sjn8MdAG4DCWTmDPs-81qfsJGcCNo_Ay+-tw@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <CAKTNdwFVRTjq14Sjn8MdAG4DCWTmDPs-81qfsJGcCNo_Ay+-tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
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

Hi Alexey,

On 10/16/26 11:58 AM, Alexey Charkov wrote:
> Hi Quentin,
> 
> On Fri, Oct 16, 2026 at 1:06 PM Quentin Schulz <u-boot@0leil.net> wrote:
>>
>> Hi Alexey,
>>
>> On 10/2/26 12:04 PM, Alexey Charkov wrote:
>>> ARM passes -mstrict-align (-mno-unaligned-access on ARMv7) to everything,
>>> because when the MMU is off any unaligned access there faults. The
>>> compiler then has to assemble every wide unaligned load out of single
>>> bytes: one ldr becomes eight ldrb and seven orr/lsl.
>>>
>>> This is especially painful for decompressors which refill their buffer
>>> in 64-bit words. On a Rockchip RK3576 SPL, zstd unpacks a 30MiB Falcon
>>> mode Linux kernel in 1947ms built this way and 596ms without the flag,
>>> and the SPL gets 2.3KiB smaller by cutting down on the byte-wise loads and
>>> ORs. gzip, whose inflate walks its input a byte at a time anyway, gains
>>> 6%.
>>>
>>> Add ASSUME_UNALIGNED_ACCESS_OK for a platform to state that the MMU is on
>>> by the time it unpacks an image, and let the decompression libraries drop
>>> the flag when it is set. The arch exports the flag it added rather than
>>> lib/ naming it, so this stays correct for anything else which adds one.
>>>
>>> No functional change anywhere until the symbol is selected.
>>>
>>
>>
>>
>>> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>>> ---
>>>    arch/Kconfig                 | 35 +++++++++++++++++++++++++++++++++++
>>>    arch/arm/cpu/armv7/config.mk |  3 +++
>>>    arch/arm/cpu/armv8/config.mk |  3 +++
>>>    lib/Makefile                 |  3 +++
>>>    lib/lzma/Makefile            |  8 ++++++++
>>>    lib/lzo/Makefile             |  8 ++++++++
>>>    lib/zlib/Makefile            |  8 ++++++++
>>>    lib/zstd/Makefile            |  8 ++++++++
>>>    8 files changed, 76 insertions(+)
>>>
>>> diff --git a/arch/Kconfig b/arch/Kconfig
>>> index 8d63afeb138e..606b9d79ecd8 100644
>>> --- a/arch/Kconfig
>>> +++ b/arch/Kconfig
>>> @@ -27,6 +27,41 @@ config SUPPORT_LITTLE_ENDIAN
>>>        bool
>>>        default y if !SUPPORT_BIG_ENDIAN
>>>
>>> +config ASSUME_UNALIGNED_ACCESS_OK
>>
>> I only see changes in ARM and ARM64 config.mk, should this (and SPL)
>> symbol depends on ARM/ARM64 maybe? I see in the second patch you're
>> adding another dependency on !SPL_SYS_DCACHE_OFF, any reason for it not
>> to be a dependency in the main symbol in this file here?
> 
> Given that it's strictly opt-in by each platform and not
> user-selectable, I don't think adding explicit dependencies in the
> main symbol helps much. As for !SPL_SYS_DCACHE_OFF, that's
> arch-specific. E.g. on ARM/ARM64 unaligned accesses fault by default.
> The exception is when both the MMU and D-cache are up and running - in
> which case they work just fine. For some other strict-alignment
> architecture the set of conditions would probably be different - and I
> have no idea about those, so I'd rather leave it to the respective
> architecture/platform code owners to assert, not add any direct hints
> which may or may not apply to their case.
> 

I guess the point is that this is an invisible symbol and it's up to the 
arch/soc maintainers to enable it via a select (so joining you on not 
adding the dependencies here).

I know I'm usually against going into implementation details in Kconfig 
symbol's helptext, but maybe it'd be nice to give an example for ARM64 
on which functions must be called before the code that can make use of 
that symbol is called? That could help other architecture maintainers to 
decide whether this could be applicable to them as well?

You also missed the -mno-unaligned-access in 
arch/arm/cpu/armv7m/config.mk, was this on purpose?

>> This is very compressor/decompressor-specific, should we rename the
>> symbol so it's clear only those would/should be impacted by this symbol
>> (hoping that its usage doesn't get extended in the future).
> 
> Compressors and decompressors are the primary beneficiaries and the
> only current users enabled by this patch, but the mechanism itself
> isn't strictly limited to them. I also hate overly long Kconfig symbol
> names, and the current one is already stretching it a bit :)
> 

Fair enough.

>>> +     bool
>>> +     help
>>> +       Assume that an unaligned access cannot fault by the time U-Boot
>>> +       proper unpacks an image, and build the decompression libraries
>>> +       without the architecture's strict-alignment flag on that basis.
>>> +
>>> +       Architectures whose unaligned accesses fault while the MMU is off
>>> +       pass such a flag to everything, which makes the compiler assemble
>>> +       each wide unaligned load out of single bytes. That is both slower
>>> +       and larger, and a decompressor refilling its bit buffer in machine
>>> +       words can spend up to four times as long for it.
>>> +
>>> +       The assumption holds only once the MMU is on, which on most
>>> +       platforms has not happened by the time an image is unpacked, and
>>> +       nothing checks it. Select it from code which enables the MMU
>>
>> Crazy idea, but should we add a flag that specifies whether the MMU (and
>> dcache?) has been set up, and then read that flag in places where we
>> have this assumption? Then we could at least clearly hard fail on this
>> flag not being set and tell the user something went wrong before the
>> system does a HW fault by itself?
> 
> Do you mean a runtime flag? I'm afraid that will add more global state
> affecting all platforms, and some platforms with tight SPL size
> requirements will not love it.
> 

gd->flags with a new flag in enum gd_flags?

Cheers,
Quentin
