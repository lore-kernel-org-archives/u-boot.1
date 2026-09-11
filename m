Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7E9C88E50
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 09:03:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B9FB605F1;
	Fri, 11 Sep 2026 09:03:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BqU8coTH6gAW; Fri, 11 Sep 2026 09:03:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3212660607
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789117416;
	b=Sj0q9Z5XG4HfTzWtAVaTaBPhrTrUrosXIym3TciU19Lf86zUsjjvPGVZtjiSc7Gbn9eQ
	 EfZRCP5REfue/+eT8b0FoRIjHAGr8cGk+sxWm2yASoCYvPbSrOlK53Ld5tIN707i2SSXq
	 rhpXS8nyqaW26PLcR28ycqFj9XTaO6Bblhik+9iIQiF/73Ak/zVPrXJMq+/pWiOj0EA3J
	 C9D2vvzAy6MT4aKPSSFt3UeNw2bjJc4oI0UTm/+hO7XnyGnH3PrCH5Y7hSt4Z46Ebj8gN
	 FZOj1v+vc6VM9y9bda3wCH2B9XeIu6Nx6e40JZO2JtQA9KZ+Fm47zxATVj+U4lv5g+w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789117416;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Zoho-Virus-Status:
	 X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=okwrtP/oSSxKfjSh1iZtecwgjD6YSpz/soLvt9x9210=;
	b=Zmac1vjxSl/XNYJhW2SKgpw5eSHH2HL6LHGg7yo0C2/RaZDKAaZiqb3z+SB+mYBvuoRC
	 wGwBeVak9Vg6P74aQme01Kex5R6vktdoICNAtLC8fN/ZQNVOn77XeetgcRDkF7Fs1DF1E
	 611Bk/UGtUKrAWzQTsPQVHWSjrxm2I4uwRJ/dRDrUeJjWv2BYIHKxhXatECopv/ccdF+p
	 IEFCUQwaJMD5UtQIwaom/ORlFgsoU2iO//zXwwo41bkcQ8fZVz1Vwzo+OKiFBzrIC/eT8
	 /nNtVotXycyJ8+XEgUONdah7tNutjoMINROuBtwieowr/f1F94iZKdQJBRSDu2PywxQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=bHSxuPX9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789117416;
	bh=okwrtP/oSSxKfjSh1iZtecwgjD6YSpz/soLvt9x9210=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vD0MwmOossUricFP88lN6nKVit1V9NTQRJUBAkXldlo0z31Iddq+8VIiLuAAmZdmU
	 7QzxrG0Jr75ldTQdFv9FovR5v7BYvGgsgKUCv3Zzik4TmU4meM+fEPVYVFPKXJbb9X
	 RxSYt4pluSEIdscyeNl7m6vDayEI7b2DqVeO1moKHno4uT4M5FrmUk+ayVfq1OT6ll
	 X4igvVvmaWAWcoNREXyXpv7AyvQSbfi5Z6NmkxofNYmCzmiiosjvZRGVm0cH2RLUe0
	 cR1fgz41k03E6rRz0fDE+XqHLjG7+Vh4Al+ccQ1cWxFKe2DztPi/a/NBI5KWJPInId
	 z+B3lfV1acOIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3212660607;
	Fri, 11 Sep 2026 09:03:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 35F5329B
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 09:03:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3305560607
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 09:03:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MQK9Y07K_dJ3 for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 09:03:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 32056605F1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789117414;
 b=Cd7NnMDBWuoq5Y/yWMfBUwve9TxdbU8yx/ycURcUfMHC9wdfH+0hZQLdPxNk/sy1E0to
 9c/HbMeThQP/QvFy1UWzHMcKUo6UsuspNKvQ3mW9t50Ma+fJ2luxotByexrBZbikI7qC5
 lhsHQ2sd9oHsyFitXIEM3LaLXPCVNT8Btkni4t42eRzcWQwDgOpt5MsbWSiXdRSPMZVl1
 tvxYQIUr8mjh9BWLmXyHQwobYRqLcKkWOu6ZWeqpGbEPgnko2+8XBA/NQF8Q+v4ELtg7i
 0DZMkE0r0Ocywy0n8TWqzVJYazMFD/6lkxGVdgr8jCkMMpR9yMVhCYwie2e+xHi2mHw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789117414;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 Content-Transfer-Encoding:In-Reply-To:X-Zoho-Virus-Status:
 X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=okwrtP/oSSxKfjSh1iZtecwgjD6YSpz/soLvt9x9210=;
 b=npq83JkaN7LzgIH55yuYT4aerEs8pva1J5DS1WXm5/66v9dvKJqMmP8axiNMDcRsNDG3
 JlWB/SNnzJJQ1QhBlZxnHFGfpjhZ2Rygi1HB2hyWTfdXOg9PVSI4rGtfGfql+R+DxakZz
 bYFR4IWgdFMIP+dwdjz8Ft7K2GVyVbPzAJS8uYEinqGgnJUG4PQqgoe8lU2NQNt3p46dZ
 KPEYwfdniEK6FupiQ/DPeLkHZ0Y78bvLOTtVPXLmRQwxndxDBA3Ozl2CgbDqVUmTWJ06H
 tdH9UjteOflMRuVpid/cJSA5tMJGHC0vSCMsP02/v0I3f19glRYKgqzkqMQ24j+EWwQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=bHSxuPX9; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=bHSxuPX9
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 32056605F1
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 09:03:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789117404; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=iS4V8KJGWcm15i42I8CLIi/E3AIpOSySw6nXwPXcJF9/oqo20tfi/uz7A2ETW6Yv+CaXgspjgGnIpPEWWOU1FWLprRxXNtBzCUay/w2qAMowkTzP88ffc4qfzXes341kddOUBJhmzlhNrLhoWFbFjZVARRyrnUu5prSAfKfkcDQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789117404;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=okwrtP/oSSxKfjSh1iZtecwgjD6YSpz/soLvt9x9210=; 
 b=nvzVn6w0Wvg8nt89KXwEhF2/2Ik1gf5X4YbH1wPaj2JBNNLIZiC9JtvOcIFEnUC5ft8p75ZkPwH9DsZEaIIsXKRQFeLE4d+MBDso7cY+RkdAGtDFxMSvGBUyY+47swk6kwOVOYrvi1AlyDDJ0ny9NGXtWb2XUe/T81pGEd6YCks=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789117404; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=okwrtP/oSSxKfjSh1iZtecwgjD6YSpz/soLvt9x9210=;
 b=bHSxuPX94/Ku+hnU87JVC48e3Q2djUHrBkp2zaiDoYn19XxopLqmqZ/530421Eg2
 ob01c1JKDwytaLOEeo6zXqkzLNJga2DrWvq2WUwHC0OVKFBdOZekmjphcXmUG1PxxEh
 S4OAuoARt+EgVEuzrsTa0OydCIvqn0rSpgcPR0M4=
Received: by mx.zohomail.com with SMTPS id 1789117401057369.98788643971784;
 Fri, 11 Sep 2026 02:03:21 -0700 (PDT)
Date: Fri, 11 Sep 2026 09:03:12 +0000
From: Yao Zi <me@ziyao.cc>
To: Nikita Shubin <nikita.shubin@maquefel.me>, Yao Zi <me@ziyao.cc>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v4 2/2] riscv: =?utf-8?Q?timer?=
 =?utf-8?Q?=3A_Enable_early_timer_for_M=E2=80=91mode?=
Message-ID: <aqPD0KD-u7N425Ew@pie>
References: <20260911-riscv_fix_early_timer_mmode-v4-0-87a7b5abf958@maquefel.me>
 <20260911-riscv_fix_early_timer_mmode-v4-2-87a7b5abf958@maquefel.me>
 <aqO7f1ON6WhT-EPH@pie>
 <62f45089b4898f390432fb189b3192c6e0a319de.camel@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62f45089b4898f390432fb189b3192c6e0a319de.camel@maquefel.me>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/289.97.79
X-ZohoMailClient: External
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

On Fri, Sep 11, 2026 at 11:36:35AM +0300, Nikita Shubin wrote:
> On Fri, 2026-09-11 at 08:27 +0000, Yao Zi wrote:
> > On Fri, Sep 11, 2026 at 10:14:06AM +0300, Nikita Shubin wrote:
> > > The generic RISC-V timer driver currently defines
> > > timer_early_get_count() only when CONFIG_IS_ENABLED(RISCV_SMODE),
> > > even though reading the TIME CSR is not inherently limited
> > > to S‑mode; it works in M‑mode as well when the CSR is implemented
> > > in hardware (e.g., with the Zicntr extension).
> > > 
> > > Moreover, timer_early_get_rate() is missing entirely for M‑mode,
> > > causing early timer functions to be unavailable on such systems.
> > > 
> > > Fix this by:
> > > - Moving timer_early_get_count() out of the RISCV_SMODE guard
> > >   so it is always available when CONFIG_TIMER_EARLY is set.
> > > - Adding M‑mode support to timer_early_get_rate(), returning
> > >   RISCV_MMODE_TIMER_FREQ when running in M‑mode
> > >   and RISCV_SMODE_TIMER_FREQ in S‑mode.
> > > 
> > > This is also necessary because several functions
> > > (e.g., net_random_ethaddr() via get_ticks()) rely on
> > > timer_early_get_count() even if CONFIG_TIMER_EARLY is not
> > > enabled.
> > 
> > Is this description correct? net_random_ethaddr() does invoke
> > get_ticks(), but the latter only delegates the work to
> > timer_early_get_count() when CONFIG_TIMER_EARLY is enabled and gd-
> > >timer
> > hasn't been initialized,
> > 
> > 	uint64_t notrace get_ticks(void)
> > 	{
> > 		u64 count;
> > 		int ret;
> > 
> > 		if (!gd->timer) {
> > 			int ret;
> > 
> > 			if (IS_ENABLED(CONFIG_TIMER_EARLY))
> > 				return timer_early_get_count();
> > 	...
> > 
> > 
> > > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> Totally correct as this i how i came into fixing the RISCV TIMER, as 
> if (IS_ENABLED(CONFIG_TIMER_EARLY)) doesn't protect us from linking
> error if timer_early_get_count() is missing (unless i am missing
> something).

With optimization, this branch should be turned into dead code and
the reference is thus eliminated. But anyway, please improve the
description to mention it's only a possible linking time dependency. I'm
simply confused by "rely on" since this should be dead code without
CONFIG_TIMER_EARLY :)

> It could be simply avoided by turning on any kind of ACLINT/CLINT
> MTIMER (everybody has one of some sort) - but why i need it if i can
> rely on RISCV TIMER in SPL stage ?
> 
> It seems no RISC-V board is currently using BOOTP/TFTP boot in SPL.
> 
> > 
> > Otherwise this patch looks good to me.
> > 
> > Best regards,
> > Yao Zi

Best regards,
Yao Zi
