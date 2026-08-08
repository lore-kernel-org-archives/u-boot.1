Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DFB5C5AD44
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 20:07:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 707196068C;
	Sat,  8 Aug 2026 20:07:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WeknG8gEPnhW; Sat,  8 Aug 2026 20:07:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9480660664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786219664;
	bh=ItqVYVvoTV2hhAKZxAexLi+5R68bS5wrsSna7iGIhYo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ygd4tTjgI+hzL6qWJA/piC4+umhnP1FaG6PRGvLK0FvZYw51h8nK4EzCZ3T+T2dH0
	 Kod0RUUyYmGAKBLt54uIeJ6nBcz9CE6dUwWdTKx+A7BT5Q6E44XeUjojm5p9carXRE
	 TSTqUkl2AflHkRw/PHWidIGLEhQkWiVeKIJlY6E67G9XmfDasR/9Gpe72DYgvFy+sI
	 GNBVXC8j+tmTaqri2oXfPTACn+RtJtZiVgUCg007rK2i/drM0GwW7aYQPxrl5CsSLq
	 uEuB0ks0HLBxUArFzOn/ciQBZvs6TqhpjEcklqI+Jz95g0mLTG/GoWPxAodXkyOVeG
	 ELTuq6IfDwy7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9480660664;
	Sat,  8 Aug 2026 20:07:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 28C711AF
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 20:07:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1A8BD80E13
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 20:07:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VKNL_qZv4hon for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 20:07:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=b70c=gc=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 462CE80E12
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 462CE80E12
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 462CE80E12
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 20:07:43 +0000 (UTC)
X-Forward-Email-ID: 6a778c8ad6d5f90d44f71509
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.13.10
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <9930d453-ee38-4322-9af9-a660a70bfbbc@kwiboo.se>
Date: Sat, 8 Aug 2026 22:07:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] rockchip: rk3506: Update ENV_MEM_LAYOUT_SETTINGS
To: Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang
 <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
References: <20260803190946.2259514-1-jonas@kwiboo.se>
 <20260803190946.2259514-3-jonas@kwiboo.se>
 <CAFLszTidbJMj-zHgu4WfidNRY-vJR6=L4vnjLjgpo0MSgF90ew@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAFLszTidbJMj-zHgu4WfidNRY-vJR6=L4vnjLjgpo0MSgF90ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1786219662;
 bh=ItqVYVvoTV2hhAKZxAexLi+5R68bS5wrsSna7iGIhYo=;
 b=BlWBnhOKFC0kwVM9AEcEqfdZnQQVa1MtuZK2gPm00KfBcGQs2+4lIO5gI/gKu9qMKP1C2pVBr
 n2zY7qfwOrz0XaATxbFDODgF/AuPyjg+dLGkVt0PTfanwlIuoPzdV6TYdX9IiCsELQprFK3tzyb
 RSRG2EFI66fiIVGH4PVhw6dcYt4Zdh5BFbmKJOsGzqh9xwjcRa+KuR59gWOwOEFs7TThdbT55OJ
 ukJwuXW+k8rK5fFBiP7L7yNC6XyAIe7CA0L9tTxoX67WO/l6uxVeZrR8365+2/gLUEZb/SjmCQg
 Ih5YAG8U4wfgASdAplLbzkIBZmvdJ/kOH5a1fR7544Jw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=BlWBnhOK
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Simon,

On 8/8/2026 7:35 PM, Simon Glass wrote:
> Hi Jonas,
> 
> On 2026-08-03T19:09:38, Jonas Karlman <jonas@kwiboo.se> wrote:
>> rockchip: rk3506: Update ENV_MEM_LAYOUT_SETTINGS
>>
>> The RK3506G1 has 64 MiB integrated DDR2, the RK3506G2 has 128 MiB
>> integrated DDR3 and the RK3506B support external memory up to 1 GiB.
> 
>> Change the default load addresses to also work on SoC variants with
>> limited memory, keep all default addresses in the 0-64 MiB range.
> 
> The addresses fit in 0-64 MiB, but kernel_comp_addr_r (48 MiB) +
> kernel_comp_size (32 MiB) reaches 80 MiB, past the end of DDR on the
> RK3506G1. Does this need separate values for each SoC ?

Please enlighten me on when kernel_comp_addr_r will be used when booting
ARMv7, I normally use zImage so the kernel handles decompression.

I do not think there is a big issue for normal operation, and users
likely have to adjust these values to fit their specific use-case.

The main issue this tries to solve is having decent space for a kernel
and a small ramdisk on these low memory devices. And my thinking is
that if you need a large kernel, you likely also need an variant having
more memory.

> 
>>
>> Current memory layout cause issues using compressed kernels or ramdisk
>> due to the default load addresses being used.
>>
>> Change the default load addresses to also work on SoC variants with
>> limited memory, keep all default addresses in the 0-64 MiB range.
>>
>>                          old             new
>>   scriptaddr            5 MiB           2 MiB
>>   pxefile_addr_r        6 MiB           1 MiB
>>   kernel_addr_r         32.5 MiB        8 MiB
>>   kernel_comp_addr_r    128 MiB         48 MiB
>>   fdt_addr_r            30.5 MiB        4 MiB
>>   fdtoverlay_addr_r     31.5 MiB        6 MiB
>>   ramdisk_addr_r        96 MiB          48 MiB
>>
>> [...]
>>
>> include/configs/rk3506_common.h | 14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
>> diff --git a/include/configs/rk3506_common.h b/include/configs/rk3506_common.h
>> @@ -18,15 +18,15 @@
>> -     "kernel_comp_addr_r=0x08000000\0"       \
>> -     "ramdisk_addr_r=0x06000000\0"           \
>> +     "kernel_comp_addr_r=0x03000000\0"       \
>> +     "ramdisk_addr_r=0x03000000\0"           \
>>       "kernel_comp_size=0x2000000\0"
> 
> kernel_comp_addr_r and ramdisk_addr_r are both at 0x03000000, so
> decompression will scribble over an already-loaded ramdisk. Every
> other rockchip *_common.h keeps these apart. Please can you space them
> so the kernel_comp window (0x03000000 + kernel_comp_size = 0x05000000)
> does not overlap the ramdisk?

Based on my testing the kernel will normally be loaded and decompressed
before the ramdisk is loaded, so having the addresses overlap seems to
be working fine.

Regards,
Jonas

> 
> Regards,
> Simon

