Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58708C5ACD1
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 21:42:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE9D44087D;
	Fri,  7 Aug 2026 21:42:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id adjmSF1LTb45; Fri,  7 Aug 2026 21:42:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5E2CB4085F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786138938;
	bh=0jXLPHRB4BJ9dpx1+xafBlLcP11iyMGGaW+5q1Tco2w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qqefYEh9gzehWZ7ty4ScIUq2rgCkubO9QIFL6MCTbVgCikHxMcM9Lz62D8PudFVSB
	 asUQqcaFjSVU6/K6IwUekTvrW5D5HVkXF2YoV/RIGuEtXLxXjDFAwlZDZWQYpga82U
	 sVuvWTieCowC06qe5qjJvNf5/icqFhE/ai/4oRqsPvSY3Fk/WdYGoVdb5x0YdLUtro
	 xaGo7eIS1pImbmToIxKcg5r2Ukvb5UjoqIU3UVHlkGRdLWejuLXO6STiqNvgyRQQiP
	 A1aYHnp0ZoRNNlXCWUbJJcH8um3Mr6AnPzV60eK+8gZwbzI18iO2XI0kmB2qI7G2IR
	 22QHi4r3h5uaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5E2CB4085F;
	Fri,  7 Aug 2026 21:42:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C09A296
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 21:42:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7DEC44005E
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 21:42:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ea1k-YyGsGxp for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 21:42:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=bda0=gb=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 858484031E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 858484031E
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 858484031E
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 21:42:15 +0000 (UTC)
X-Forward-Email-ID: 6a7650edcd6642dfb8869751
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.13.10
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <a1436f49-823c-4708-b640-92c67fc6362d@kwiboo.se>
Date: Fri, 7 Aug 2026 23:40:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: px30: Fix TPL_STACK overflow into BootROM
 reserved region
To: Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang
 <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
References: <20260807090431.464978-1-jonas@kwiboo.se>
 <CAFLszThA3502QnQxSGyQL+WPEz3tovqE8VA7512gjVKUPSBMEg@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAFLszThA3502QnQxSGyQL+WPEz3tovqE8VA7512gjVKUPSBMEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1786138934;
 bh=0jXLPHRB4BJ9dpx1+xafBlLcP11iyMGGaW+5q1Tco2w=;
 b=hOpNCZopE3D16HIjH8vmrc5kW8CE14ekxam1wiMTt5xc1fsHBKEPjE7ln9KWlNcnvwTe4u/lC
 Q6uWVqfHtrlzLlSuQnttmTZc9oVCSkCWjj65ox1e7/43wJLqA1TzTUgw/4CtqiBQjAeQzBX2xAa
 hWO9dbRUBGXDqdcxmRZOVxXjuYJd2s+20SUB9pOtvpIMG+/rM/3jHhm58G7WWCNtwYRtIrRYmJX
 CWGP/Yk64VgAgvcaSxGNieHhHjo4jVnp+3M+e+x0jCCA0I5GROtHD0R5HbcIRtKuVrCNmj15NJu
 UEshS1N1MlL21woW5UtKqsD2wvqnfZOs2+CYjqLK66ng==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=hOpNCZop
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

On 8/7/2026 10:40 PM, Simon Glass wrote:
> Hi Jonas,
> 
> On 2026-08-07T09:04:31, Jonas Karlman <jonas@kwiboo.se> wrote:
>> rockchip: px30: Fix TPL_STACK overflow into BootROM reserved region
>>
>> The PX30/RK3326 has 16 KiB SRAM at [0xff0e0000, 0xff0e4000), with the
>> initial 4 KiB at [0xff0e0000, 0xff0e1000) reserved for BootROM at boot.
>>
>> SRAM addressing only seem to use 14 bits, meaning that reading from
>> 0xff0e4000+ wraps around and instad reads back data at 0xff0e0000+.
> 
> Typos: 'seem' -> 'seems', 'instad' -> 'instead' and 'possible looks'
> below -> 'possibly looks'.

Thanks, will update in a v2.

> 
>>
>> Using a TPL_STACK at 0xff0e4ff0 (16-bytes aligned) means TPL use BootROM
>> reserved region for its global data, malloc area and runtime stack.
>>
>> TPL on PX30/RK3326 does not have any use for the malloc area and the
>> generated GD_SIZE is typically around 304 bytes.
>>
>> Current memory layout possible looks something like:
>>
>>   [0xff0e0000, 0xff0e4000)          16 KiB   SRAM
>>     [0xff0e0000, 0xff0e1000)         4 KiB   BROM area
>>       [0xff0e09f0, 0xff0e0ff0)    1536 bytes  malloc area (unused)
>>       [0xff0e08c0, 0xff0e09f0)     304 bytes  global data
>> [...]
>>
>> arch/arm/mach-rockchip/px30/Kconfig | 4 ++--
>>  common/spl/Kconfig.tpl              | 2 +-
>>  tools/rkcommon.c                    | 2 +-
>>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
>> diff --git a/common/spl/Kconfig.tpl b/common/spl/Kconfig.tpl
>> @@ -129,7 +129,7 @@ config TPL_MAX_SIZE
>> -     default 0x2800 if ROCKCHIP_PX30
>> +     default 0x2c00 if ROCKCHIP_PX30
> 
> Just to check, the layout shows [0xff0e3c00, 0xff0e3ed0) as pure
> stack, but BSS (e.g. dram_info in sdram_px30.c) sits after
> __image_copy_end and is not counted by the TPL_MAX_SIZE assert in
> u-boot-tpl-v8.lds, so with an image close to 11 KiB the real stack
> headroom is a bit less than 720 bytes.

You are correct, current BSS is 72 bytes, will update the commit message
to mention that the 720 bytes must fit both BSS and the stack in a v2.

What is interesting is that global data is so large, especially when in
this case nothing here is really using global data. We could save 16
bytes by fully disable CONFIG_TPL_SYS_MALLOC_F, but that was too
intrusive to be part of this fix.

Regards,
Jonas

> 
> The rest checks out: crt0_64.S does bic sp, x0, #0xf then
> board_init_f_alloc_reserve(), so with 0xff0e4000 the GD ends up at
> rounddown(0xff0e4000 - sizeof(gd), 16) and nothing writes at or above
> 0xff0e4000, and px30-board-tpl.c uses no malloc, so a zero
> TPL_SYS_MALLOC_F_LEN is safe.
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> Regards,
> Simon

