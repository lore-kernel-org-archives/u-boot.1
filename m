Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF057C5AC7C
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 08:47:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4BD28409F4;
	Fri,  7 Aug 2026 08:47:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SB84gEOupoRF; Fri,  7 Aug 2026 08:47:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0A0D2409C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786092428;
	bh=w8OXozstRqFHwJf2+VPjJfCeY2XGOiKLNTVdlSLdUPU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rQDiNymeOCoJKCkAUgbt4gqSXghzA/TxYGEEMHUhGbmakUK9xjfJdR+2S5m9CmZbd
	 T+plPdaERz4GHAWJCiCEtsQsW8GBLRH7DrTL9+dvAKK2lPKZZ/qCM7mj9Yb2VdelzZ
	 OV4ej+NzCXx3BlRiCh/fyqJiZU9EMZzG971GZvgCsoaJKIJNsTDJlzZKg7KTnMG60e
	 fReUVopDCxwWiTn5mx0Lr+AHQMuNoCCCb33Ioj2QWAd0CMxrCoyWmPMc2wm4tooWgD
	 icddsgpqEg1mEg2dCLFiXnV8GBUgqc7NSjIFnD2BvUBSmZOsKsAzLjibXqUN0mRhn2
	 9hTdoL6IRkTcg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A0D2409C9;
	Fri,  7 Aug 2026 08:47:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B75C723F
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 08:47:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9503C608CC
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 08:47:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VF7OKVpTloWi for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 08:47:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=165c=ga=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6B50960680
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6B50960680
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6B50960680
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 08:47:03 +0000 (UTC)
X-Forward-Email-ID: 6a759b84b8d98458e218e404
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.13.10
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <bae4b19a-9243-42fc-b77a-d8b91d6d76a5@kwiboo.se>
Date: Fri, 7 Aug 2026 10:46:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] include: linux: Import hw_bitfield.h from Linux
 v6.18
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
References: <20260803184314.2240153-1-jonas@kwiboo.se>
 <20260803184314.2240153-2-jonas@kwiboo.se>
 <5af6d8cb-64cd-43be-ab99-3a8daaaf7ca7@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <5af6d8cb-64cd-43be-ab99-3a8daaaf7ca7@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1786092423;
 bh=w8OXozstRqFHwJf2+VPjJfCeY2XGOiKLNTVdlSLdUPU=;
 b=eJXCZMceiHST1VSzXuD48/AzYRxc90FrQ9pc8ZpahHah0Yt1S4RWoHGS3FqGpM8zDgRPAqXqm
 DhQ6g495OOQcZmq/6HQAGXHWS/Sa41a4LQ+y3dZIEvjTzJ8NqsDLr4J3VzlQaLRTxwRRj3I8utN
 PF4KIJ4lKMfwHLtSTlg2mt1/r2/6BicJHFitI42EJcupz7u2wbtYUT5Tky6gQXapvOoS9pBWqxB
 A3K2ZxxGNofoKtKZJ/SbQ4o8d6v7mw6lvdEszfJjrUuVteEB6wrSbGJ3IY4OAdcoU06lnLTKx5D
 Pybdb3YJ9yYCRUye3PU99rxUvAtSHKTgaHXErC3GBptA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=eJXCZMce
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

Hi Quentin,

On 8/7/2026 10:14 AM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 8/3/26 8:43 PM, Jonas Karlman wrote:
>> Hardware of various vendors, but very notably Rockchip, often uses
>> 32-bit registers where the upper 16-bit half of the register is a
>> write-enable mask for the lower half.
>>
>> Add hw_bitfield.h with two macros: FIELD_PREP_WM16, and
>> FIELD_PREP_WM16_CONST. The latter is a version that can be used in
>> initializers, like FIELD_PREP_CONST.
>>
>> Import hw_bitfield.h from Linux commit 21368fcbb124 ("bitmap: introduce
>> hardware-specific bitfield operations"), first introduced in v6.18-rc1.
>>
>> This contains two changes compared to the Linux version:
>> - include of linux/limit.h was dropped
>> - use of const_true() in FIELD_PREP_WM16_CONST() was dropped
>>
> 
> Acked-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> The content in this patch is as described in the commit log.
> 
> I'm wondering whether we should try to get include/linux/limit.h (and 
> include/vdso/limit.h) in. Also wondering if we could also get 
> const_true() in somehow.

U16_MAX, used in FIELD_PREP_WM16_CONST(), is what would have been
imported by linux/limit.h, there is also a U-Boot specific limits.h that
defines U16_MAX but it felt wrong to depend on the U-Boot header inside
the linux header. Using the FIELD_PREP_WM16_CONST() instead of the non
const variant also never reported any missing U16_MAX define.

const_true() would have been nice to import, but that was a separate
issue, linux/compiler.h is very outdated and looks harder to sync
without risking introducing new possible issues.

Testing FIELD_PREP_WM16_CONST() without const_true() and mask > U16_MAX
do produce a compile time error, but the error message may look a little
bit strange:

  In file included from arch/arm/mach-rockchip/rk3576/rk3576.c:12:
  arch/arm/mach-rockchip/rk3576/rk3576.c: In function ‘arch_cpu_init’:
  include/linux/build_bug.h:15:50: error: negative width in bit-field ‘<anonymous>’
     15 | #define BUILD_BUG_ON_ZERO(e) ((int)sizeof(struct { int:(-!!(e)); }))
        |                                                  ^
  ./arch/arm/include/asm/io.h:178:38: note: in definition of macro ‘writel’
    178 | #define writel(v, c)    ({ u32 __v = v; __iowmb(); writel_relaxed(__v, c); __v; })
        |                                      ^
  include/linux/hw_bitfield.h:56:18: note: in expansion of macro ‘BUILD_BUG_ON_ZERO’
     56 |                 (BUILD_BUG_ON_ZERO((u64)(_mask) > U16_MAX) + \
        |                  ^~~~~~~~~~~~~~~~~
  arch/arm/mach-rockchip/rk3576/rk3576.c:200:24: note: in expansion of macro ‘FIELD_PREP_WM16_CONST’
    200 |                 writel(FIELD_PREP_WM16_CONST(BIT(16), 0),
        |                        ^~~~~~~~~~~~~~~~~~~~~
  include/linux/hw_bitfield.h:54:9: warning: conversion from ‘long unsigned int’ to ‘u32’ {aka ‘unsigned int’} changes value from ‘4294967300’ to ‘4’ [-Woverflow]
     54 |         (                                                                \
        |         ^
  ./arch/arm/include/asm/io.h:178:38: note: in definition of macro ‘writel’
    178 | #define writel(v, c)    ({ u32 __v = v; __iowmb(); writel_relaxed(__v, c); __v; })
        |                                      ^
  arch/arm/mach-rockchip/rk3576/rk3576.c:200:24: note: in expansion of macro ‘FIELD_PREP_WM16_CONST’
    200 |                 writel(FIELD_PREP_WM16_CONST(BIT(16), 0),
        |                        ^~~~~~~~~~~~~~~~~~~~~

> 
> No changes made to this file in Linux kernel since v6.18-rc1, so could 
> as well have said it's taken from 7.2-rc6 (which also means no missed 
> fixes).

Hum, I thought I mentioned that it has not changed up to v7.1, but looks
like that comment did not made it in.

Regards,
Jonas

> 
> I'll wait on Tom's Reviewed-by before merging this though since it's not 
> a straight import from the Linux kernel. I'm targeting the next branch 
> for this.
> 
> Cheers,
> Quentin

