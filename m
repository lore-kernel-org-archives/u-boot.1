Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F14C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 15:17:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D244184B9C;
	Mon, 13 Jul 2026 17:17:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="N81AhbDn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BF8084BBE; Mon, 13 Jul 2026 17:17:00 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 502F084AED
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 17:16:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5a7b=FI=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1783955816;
 bh=LRalx2TkWzewyRCk87PE0ofYz8PXFuDs+5n9bhvfwoQ=;
 b=N81AhbDnjh6zlkw0sE7JmMIxxfbnF1MuyIuCT4WjaQiZ7Tk26iJ+MdrgU8TxC9n94Kf5+HRji
 M8mX+Yj3/JgTHGbg9tNK3oxS2Z9xu2JUS/T4tHZi/FF8cfs32uaw2pFIHLdtwzVCxptLdfr1tOd
 tABCeTFYQze1ukZmQ4HzY5mfZbO6h2UvKauIKHsQ1n3lCoKvOV3pPUYPX3ITSo5AvO3fYdM+4gU
 US94zp+iEyNFvQqALxQV26Mq91IIJMFccgud7WayRq5A+/q095TNQnFgMGz+cknc9yqW0//6XoX
 mxG7YtfV/CRYX+hW21uamLBouHn5vJunDX6W+Htvz20A==
X-Forward-Email-ID: 6a550164c414db019cbe5ec4
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.10.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <954080ab-9a91-4212-bc33-d24b00b2edc3@kwiboo.se>
Date: Mon, 13 Jul 2026 17:16:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] console: Use CONFIG_IS_ENABLED() for SILENT_CONSOLE
 checks
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 u-boot@lists.denx.de
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-11-jonas@kwiboo.se>
 <CAFLszTgeXz5eDB6T4DzE4FWr9JCJzZt8j==PhZa6g4AdmxTf9A@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAFLszTgeXz5eDB6T4DzE4FWr9JCJzZt8j==PhZa6g4AdmxTf9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Simon,

On 7/13/2026 4:29 PM, Simon Glass wrote:
> Hi Jonas,
> 
> On 2026-07-08T22:05:26, Jonas Karlman <jonas@kwiboo.se> wrote:
>> console: Use CONFIG_IS_ENABLED() for SILENT_CONSOLE checks
>>
>> The xPL_SILENT_CONSOLE Kconfig symbols are not fully respected for xPL
>> builds, instead common code is guarded by a mix of SILENT_CONSOLE and
>> xPL_SILENT_CONSOLE symbols.
>>
>> Change to consistently use CONFIG_IS_ENABLED(SILENT_CONSOLE) to make the
>> common code properly guarded by the intended Kconfig symbol.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> Reviewed-by: Tom Rini <trini@konsulko.com>
>>
>> board/friendlyarm/nanopi2/board.c |  4 ++--
>>  boot/bootm.c                      |  4 ++--
>>  common/autoboot.c                 |  2 +-
>>  common/console.c                  | 12 ++++++------
>>  include/env_callback.h            |  2 +-
>>  5 files changed, 12 insertions(+), 12 deletions(-)
> 
>> diff --git a/common/console.c b/common/console.c
>> @@ -736,7 +736,7 @@ void putc(const char c)
>> -     if (IS_ENABLED(CONFIG_SILENT_CONSOLE) && (gd->flags & GD_FLG_SILENT)) {
>> +     if (CONFIG_IS_ENABLED(SILENT_CONSOLE) && (gd->flags & GD_FLG_SILENT)) {
> 
> This slightly changes what SPL_SILENT_CONSOLE means. Previously the
> xPL symbol only dropped the boot-progress messages in spl.c at build
> time, but now it also gates the run-time GD_FLG_SILENT checks here
> when console.c is built for SPL (i.e. with SPL_SERIAL). The help text
> in common/Kconfig still says "The GD_FLG_SILENT flag is not used in
> SPL so there is no run-time control of console messages in SPL", which
> no longer matches. Please can you update the SPL_SILENT_CONSOLE and
> TPL_SILENT_CONSOLE help text?

Sure, I will drop the following part of the help text in v2.

  The GD_FLG_SILENT flag is not used in xPL so there
  is no run-time control of console messages in xPL.

> 
>> diff --git a/common/console.c b/common/console.c
>> @@ -72,7 +72,7 @@ static int on_console(const char *name, const char *value, enum env_op op,
>> -#ifdef CONFIG_SILENT_CONSOLE
>> +#if CONFIG_IS_ENABLED(SILENT_CONSOLE)
> 
> Just to check: there is no VPL_SILENT_CONSOLE symbol, so in a VPL
> build this (and the other converted checks) is now always false, where
> before it followed the proper symbol. I suspect that is fine since no
> in-tree board enables both VPL and SILENT_CONSOLE, but please mention
> it in the commit message, or add the VPL symbol alongside the SPL/TPL
> ones in common/Kconfig

Sure, I will mention the changed behavior for VPL in commit message in v2.

Regards,
Jonas

> 
> Regards,
> Simon

