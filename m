Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDD0C88E4D
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 08:36:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B4C4840B7E;
	Fri, 11 Sep 2026 08:36:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qGBVVXzQmW8V; Fri, 11 Sep 2026 08:36:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 028B140B79
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789115813;
	b=g5HY/lv/sFk7LEXwB/1ePoTQ1Lee6C9L1l1+wunC90hsRUKMOV1NUtUfeJanTK0U+pxE
	 jk9kQth7DOGjc2RaFFNlbKJIjv1b0BgqNj812CA7Z2so61axzPo1PEwjzDz8kdyoE2anx
	 TvvmqZV/tMh6pUESxd29Rl4EnO2Hond/eQuz1EZiA3G3rKGC9Sf6w2CxOyeW/aX+imaU+
	 LF2/WLa5O2EEIW+FKb193TVPVZsWrcXr/0vYVNwf5D0BNrDLMSqa8STH1GP58f2rjoQOm
	 WF8/mylVYUKl7sfgVJE4hSY7Cv74FKygFdTEMHTgUpfrDM/DtEO3QfQSih530t050iQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789115813;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:X-Yandex-Fwd:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=tfeVOp6qHvPY60VUHdEQj5N48Rj+moqRmqMdZBtPepo=;
	b=IfoXtT8/L6qXOisrsjZ7xHQyjLIks9pwDytQnxLEgDzRgNqU/mIu9wAtwoWnlRnliCeY
	 bjrsFfoXutO7z4zmQBqFBeXi+PWWfowODMfQtOkYnEnFjiECM7gY5837wLigbwkdMARme
	 p57zbwn3GVsXJjyekhRKbYCS1VDfL6WzNgJXFYgHTPPehrdhOErqp6VbRNpgt1oqJO37p
	 +exoi/RI18DZ1kxKiohnR7mRZJ0HaapkU0rb0UUHJmCpyhm00Edb3w265qg5GWYVzrj1B
	 iFihsmx8EvJ6Sxc2+0qN3I2V4FbRMXGcj3YPoIm835lX1iFtGc3GsPBiN1mFk/MTOTg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=maquefel.me;
	dkim=pass header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256 header.s=mail header.b=o7cZWMBy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789115813;
	bh=tfeVOp6qHvPY60VUHdEQj5N48Rj+moqRmqMdZBtPepo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aqfDm3gVtJq/P/bwQZTu0NNRrtvul8wnub+Ym2JMkZ14xtRUtHNYijCjocAoIqqde
	 /x/2xXX6o58AzQuHP+xAv95SpiV+HVjw/f/UodBO48iCmZuXWCVb/Pn/6none2Mo+f
	 iXLs2LeKMyOb/akO4FxwXCU+IWUFze0Da9k6LxwrXUnMEAHjFmPl0aqfvZkn/DPyxJ
	 CyBhI6hB6plHT8mnwgJTcJ55fi5zMEsA7wZKELHNj4QZhzPQYVDA4i/gQ2Ev5U6lZ1
	 MhHI95K6GK8G0q5rkJ8q2GhAqqwThXCuWTVEqs/l1fYUbzLL5So54Kwu8kKqA4haXU
	 ZW62FnlNs0GfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 028B140B79;
	Fri, 11 Sep 2026 08:36:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6016D493
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 08:36:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5117A40B79
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 08:36:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f0lo1MrW-e-y for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 08:36:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 743A140B78
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a02:6b8:c0e:500:1:45:d181:d500"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789115810;
 b=OSveVkz5c9Ye0FkjfUHv9RCgvGiteKD9+eVm1Nr1GD0FhXD7dAYxlW9GeyHEKoBYOEem
 KfMy6w5AvIdbf6c+6DSpS46mHWThI9YSoGCILkS22DmrRdlkzoKWbzFaP7gQ1yPAh3xG7
 /ACyaOfObybuC9zqvCnc5/xbeltAeL/WgL3Rk0WzslNIsRz7URl2taPIxFiVjvYEEUrUp
 XG7NwKb8shQ7GgeoZfCQj1Jx+WqU26+BTHlnd9sdqfkE1R+N6ARfKYZ4G/LIPoBERVQ8B
 ZpGCkH94wBa9/eqz/Dcva0l9Zij3YW4Ep8GY3pw4h2ZtQtaB+CcFICaB6et+Td0Bq5w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789115810;
 h=Received-SPF:Received:Received:X-Yandex-Fwd:DKIM-Signature:
 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
 bh=tfeVOp6qHvPY60VUHdEQj5N48Rj+moqRmqMdZBtPepo=;
 b=YGV9uo27mvNh8/Hhcrc8t4k9s/s45vIeFNJm7O0DXphFJm0doiQXPyaeRj2+4tMIB79q
 BywzznSLrZxi2DsCqWZqa2fMvc4oqqSKZousNzCDbFIvXc5gQ7fXLcG6RJtUNwdwLiJiH
 3otOrO+kdVBBSOpMv+EzhdyzseqgrvayTX61w/UKvnuApcXkD6B78iH8k5wc2X93SZ2uk
 YT9k7ZFXo1Lyb+lW9zsvfFaz4Yd1Qy/Qw7d7hrqqEmYv9iNJVbwtzusFfSejzX7TwE9B2
 rB0T/9/qWnKKq1sSSXldViLxvgosBv+BgY8psMBb0gff9pJSY5R8vjVASwaGb9qMQWg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=maquefel.me; 
 dkim=pass header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=o7cZWMBy; 
 arc=none smtp.remote-ip="2a02:6b8:c0e:500:1:45:d181:d500"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a02:6b8:c0e:500:1:45:d181:d500; helo=forward500a.mail.yandex.net;
 envelope-from=nikita.shubin@maquefel.me; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me
 header.a=rsa-sha256 header.s=mail header.b=o7cZWMBy
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net
 [IPv6:2a02:6b8:c0e:500:1:45:d181:d500])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 743A140B78
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 08:36:47 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c0f:4c9f:0:640:5657:0])
 by forward500a.mail.yandex.net (postfix) with ESMTPS id 02A88C0189;
 Fri, 11 Sep 2026 11:36:42 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (smtp)
 with ESMTPSA id YaLJJUsg5Gk0-ObSlZJIK; 
 Fri, 11 Sep 2026 11:36:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1789115801; bh=tfeVOp6qHvPY60VUHdEQj5N48Rj+moqRmqMdZBtPepo=;
 h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
 b=o7cZWMByfzfFB8r55TPTikM5pNAf9El9o66FAsnKO4RtOKdOAWZQ5zslnFiFHdkb7
 2EswgoFpHgh0vubMTMufMMYe3PCti9ZCj0FD3VkXihnGDCmWFiFLt4JUEH7PFtlqwT
 JH6LG2KfNXczhMtsgbdfT7fXI5JpzhElSNK/WIWE=
Authentication-Results: mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
Message-ID: <62f45089b4898f390432fb189b3192c6e0a319de.camel@maquefel.me>
Subject: Re: [PATCH v4 2/2] riscv: timer: Enable early timer for
 =?UTF-8?Q?M=E2=80=91mode?=
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>
Date: Fri, 11 Sep 2026 11:36:35 +0300
In-Reply-To: <aqO7f1ON6WhT-EPH@pie>
References: <20260911-riscv_fix_early_timer_mmode-v4-0-87a7b5abf958@maquefel.me>
 <20260911-riscv_fix_early_timer_mmode-v4-2-87a7b5abf958@maquefel.me>
 <aqO7f1ON6WhT-EPH@pie>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
MIME-Version: 1.0
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

On Fri, 2026-09-11 at 08:27 +0000, Yao Zi wrote:
> On Fri, Sep 11, 2026 at 10:14:06AM +0300, Nikita Shubin wrote:
> > The generic RISC-V timer driver currently defines
> > timer_early_get_count() only when CONFIG_IS_ENABLED(RISCV_SMODE),
> > even though reading the TIME CSR is not inherently limited
> > to S=E2=80=91mode; it works in M=E2=80=91mode as well when the CSR is i=
mplemented
> > in hardware (e.g., with the Zicntr extension).
> >=20
> > Moreover, timer_early_get_rate() is missing entirely for M=E2=80=91mode=
,
> > causing early timer functions to be unavailable on such systems.
> >=20
> > Fix this by:
> > - Moving timer_early_get_count() out of the RISCV_SMODE guard
> > =C2=A0 so it is always available when CONFIG_TIMER_EARLY is set.
> > - Adding M=E2=80=91mode support to timer_early_get_rate(), returning
> > =C2=A0 RISCV_MMODE_TIMER_FREQ when running in M=E2=80=91mode
> > =C2=A0 and RISCV_SMODE_TIMER_FREQ in S=E2=80=91mode.
> >=20
> > This is also necessary because several functions
> > (e.g., net_random_ethaddr() via get_ticks()) rely on
> > timer_early_get_count() even if CONFIG_TIMER_EARLY is not
> > enabled.
>=20
> Is this description correct? net_random_ethaddr() does invoke
> get_ticks(), but the latter only delegates the work to
> timer_early_get_count() when CONFIG_TIMER_EARLY is enabled and gd-
> >timer
> hasn't been initialized,
>=20
> 	uint64_t notrace get_ticks(void)
> 	{
> 		u64 count;
> 		int ret;
>=20
> 		if (!gd->timer) {
> 			int ret;
>=20
> 			if (IS_ENABLED(CONFIG_TIMER_EARLY))
> 				return timer_early_get_count();
> 	...
>=20
>=20
> > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

Totally correct as this i how i came into fixing the RISCV TIMER, as=20
if (IS_ENABLED(CONFIG_TIMER_EARLY)) doesn't protect us from linking
error if timer_early_get_count() is missing (unless i am missing
something).

It could be simply avoided by turning on any kind of ACLINT/CLINT
MTIMER (everybody has one of some sort) - but why i need it if i can
rely on RISCV TIMER in SPL stage ?

It seems no RISC-V board is currently using BOOTP/TFTP boot in SPL.

>=20
> Otherwise this patch looks good to me.
>=20
> Best regards,
> Yao Zi
