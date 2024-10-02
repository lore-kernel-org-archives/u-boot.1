Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE83DCF31A9
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 09:51:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9CA688F99;
	Wed,  2 Oct 2024 11:51:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="QQHR/CmN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBD3E88FA4; Wed,  2 Oct 2024 11:51:22 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8443A88F1F
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 11:51:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BF7E2148579F; Wed,  2 Oct 2024 11:51:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1727862679; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=vVZn8/F32bmksg5JLQxU4vShkBXX3CTHYtIiW2+P9Ts=;
 b=QQHR/CmNZoq7RUYD68SaX1OwJtWlDkP9e95rpReZRVSJFuSzVEQ/dwoJ55ymu0hAbBOgp8
 8uOCB2ZJCRtd0LCoYLaS9UiIKMtFuBP1H7M/zDJUntnfRisiiwI5nHTg1qbuH6RpSCWV+L
 7+XKk9Trq2wpWUanWL7GvA7vVz2U+SjSRF7FDAuGUq6gew2dSVM0nqD1CsYlCaLm6M5QQo
 DRRRcjuKATsyAr4L4tzGcGW6uAu2QYrxuSockza2SHt1sCEK0yufZxnV/brv7CVMmZJraq
 sS5IyrZTax5bFyw/hUbhT6Qco3qDLeui5+mRKs/B8vhWLtDu10i6Uum9wuoPsA==
Date: Wed, 2 Oct 2024 11:51:16 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Dario Binacchi <dariobin@libero.it>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 3/4] dm: core: migrate debug() messages to use dm_warn
Message-ID: <20241002-wrecker-commute-f1fc4ae3df71@thorsis.com>
Mail-Followup-To: Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <foss+uboot@0leil.net>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Dario Binacchi <dariobin@libero.it>, u-boot@lists.denx.de
References: <20240611-misc-20240610-v2-0-028e82b0b620@cherry.de>
 <20240611-misc-20240610-v2-3-028e82b0b620@cherry.de>
 <20241002-caption-saline-d00d342af087@thorsis.com>
 <cd12220e-a111-4576-87d1-e838f1c5998e@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd12220e-a111-4576-87d1-e838f1c5998e@cherry.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Quentin,

thanks for you quick reply, see my remarks below.

Am Wed, Oct 02, 2024 at 11:25:38AM +0200 schrieb Quentin Schulz:
> Hi Alexander,
> 
> On 10/2/24 10:37 AM, Alexander Dahl wrote:
> > Hello Quentin,
> > 
> > sorry for being late to the party, but I just tested v2024.10-rc6 and
> > my console output looks like this now:
> > 
> >      ofnode_read_bool: bootph-all: true
> >      ofnode_read_u32_array: ranges: ofnode_read_bool: bootph-all: false
> >      ofnode_read_bool: bootph-some-ram: false
> >      ofnode_read_bool: bootph-pre-ram: false
> >      ofnode_read_bool: bootph-pre-sram: false
> >      ofnode_read_bool: u-boot,dm-pre-reloc: false
> >      ofnode_read_bool: u-boot,dm-pre-proper: false
> >      ofnode_read_bool: u-boot,dm-spl: false
> >      ofnode_read_bool: u-boot,dm-tpl: false
> >      ofnode_read_bool: u-boot,dm-vpl: false
> >      ofnode_read_bool: bootph-all: false
> >      ofnode_read_bool: bootph-some-ram: false
> >      ofnode_read_bool: bootph-pre-ram: false
> >      ofnode_read_bool: bootph-pre-sram: false
> >      ofnode_read_bool: u-boot,dm-pre-reloc: false
> >      ofnode_read_bool: u-boot,dm-pre-proper: false
> >      ofnode_read_bool: u-boot,dm-spl: false
> >      ofnode_read_bool: u-boot,dm-tpl: false
> >      ofnode_read_bool: u-boot,dm-vpl: false
> >      ofnode_read_bool: bootph-all: true
> >      ofnode_read_u32_array: ranges: ofnode_read_bool: bootph-all: true
> >      ofnode_read_u32_array: ranges: ofnode_read_bool: bootph-all: true
> >      ofnode_read_bool: bootph-all: true
> >      ofnode_read_bool: bootph-all: false
> >      …
> > 
> > This goes on for several screen pages, and clutters the usual output.
> > I first thought I messed up CONFIG_LOGLEVEL or CONFIG_LOG, but no.
> > All I had done was setting CONFIG_DM_WARN …
> > 
> > Am Tue, Jun 11, 2024 at 03:04:26PM +0200 schrieb Quentin Schulz:
> > > From: Quentin Schulz <quentin.schulz@cherry.de>
> > > 
> > > Prior to that, seeing the debug() messages required to enable DM_DEBUG
> > > which defines DEBUG (and then _DEBUG) which in turn makes failing
> > > assert() calls reset U-Boot which isn't necessarily what is desired.
> > > 
> > > Instead, let's migrate to dm_warn which is using log_debug when unset or
> > > log_warn when set.
> > > 
> > > While at it, reword the DM_DEBUG symbol in Kconfig to explain what it
> > > now actually does.
> > 
> > CONFIG_DM_WARN currently reads like this:
> > 
> >      Enable this to see warnings related to driver model.
> > 
> >      Warnings may help with debugging, such as when expected devices do
> >      not bind correctly. If the option is disabled, dm_warn() is compiled
> >      out - it will do nothing when called.
> > 
> > Instead of just useful warnings, users get debug messages all over the
> > place now.  Is this actually intended behaviour?  Can this be fixed
> > before v2024.10 release please?
> > 
> 
> There are basically less than 3 working days left before v2024.10 is
> released and I'm inclined to say this is annoying rather than a bug, so I am
> not entirely sure this will 1) make it in time if we agree on a fix (needs
> to include review process in those 3 working days) 2) be acceptable for a
> late addition in the release cycle. Let's try though, maybe we can figure
> something out.

Well yes.  And today is my last working day before I return back to
office on October 14th, so I won't answer anything you all discuss from
tomorrow until after release.  Sorry. :-/

> Enabling DM_WARN actually changes the loglevel of dm_warn calls from debug
> to warning, c.f.
> https://elixir.bootlin.com/u-boot/v2024.07/source/include/dm/util.h#L11
> 
> There seems to be no available dm-specific log function other than dm_warn
> at the moment.

Ack.

> The issue I had was that in order to be able to see those messages, I had to
> to select DM_DEBUG, which does much more than just enabling the debug log
> level to be printed and eventually makes my boot unsuccessful (see original
> commit message), which is not acceptable :)

It just adds -DDEBUG to driver core cflags, so DEBUG is defined in
preprocessor.  What you call "much more" are only implications from
defining DEBUG, right?

You wrote in your commit message assert() calls fail.  In my
understanding those should not fail, and I would look to fix things
leading to failed assertions.  IIRC standard C lib help texts say,
assert() is only recommended for helping programmers finding bugs,
because it's a noop in non-debug code, which would just hide problems
and making things blow up elsewhere.  IMHO if code fails due to
assert() you have some serious problems you should debug, not "solve"
it by disabling debug.  In other words: your boot should also be
successful with DEBUG/assert() enabled, shouldn't it?

> Can you explain what you're trying to achieve with DM_WARN enabled so we
> have some idea how to properly fix address your concern?

The help text promises warnings I wanted to see in my own drivers or
drivers I patched (very few), so I don't mess up things accidentally.
Up to 2024.07 this seemed to work fine.

> In the short term, i guess we could simply define a dm_dbg macros which does
> log(LOGC_DM, LOGL_DEBUG, ##fmt)
> which would also replace those instances of log(LOGC_DM, LOGL_DEBUG, in
> drivers/core/uclass.c.
> 
> However this means that all those messages would only be available if we
> reach the global log level to debug, which is very verbose. I have not
> looked deeply into all those messages and their contexts and wouldn't be
> able to quickly differentiate a debug message from a warn message, so
> replacing only some of them is not a small thing to do and is error prone.
> 
> I guess what we could do is have some sort of kconfig option for log level
> per logging category? Or in some way define log filters at compile time?
> 
> I'm not entirely sure how to go forward with this.
> 
> [...]

Not sure either.  I certainly won't mess with driver core.  My
short-term solution will be to disable CONFIG_DM_WARN for now.

> 
> > > @@ -508,17 +509,17 @@ int of_read_u16(const struct device_node *np, const char *propname, u16 *outp)
> > >   {
> > >   	const __be16 *val;
> > > -	debug("%s: %s: ", __func__, propname);
> > > +	dm_warn("%s: %s: ", __func__, propname);
> > 
> > This is no warning at all.  And there are tons of those changed by
> > this patch.  It ended up in master as 6afdb1585112 ("dm: core: migrate
> > debug() messages to use dm_warn") by the way.  Please review again and
> > assign reasonable log levels for all converted messages, otherwise
> > the destinction between DM_WARN and DM_DEBUG is useless?
> > 
> 
> They are not exactly related, that's the issue. DM_DEBUG is not about the
> log level, it's about enabling all debug functionalities (of which is
> enabling the debug() calls), which renders the boot unsuccessful on my
> machine (see original commit message).
> 
> The second issue is, we could assign different log levels for DM, but they
> would be printed only if the global log level would be raised above the
> level of said DM log message's level. This means to see those I would need
> to see ALL debug messages using the logging framework. I think something
> more finegrained would be much more useful, but that's also not a 5min thing
> to do I guess.

Isn't the logging framework capable of this already?  TBH I usually
add '#define DEBUG' to modules I want to see all messages for, and
remove that again when done with whatever the current task is.  DM
just makes this easier simply by hooking it to Kconfig.

> Thank you for testing an RC though and filing a report, not many people do
> (me included) and we end up fixing a lot of stuff in the early days of a new
> release which is not the ideal workflow :)

Usually I don't do this for each release, but I had the opportunity
this time. ;-)

Greets
Alex

