Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AADC88E4C
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 09:15:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7072540A50;
	Fri, 11 Sep 2026 09:15:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xS13yMAzHh4T; Fri, 11 Sep 2026 09:15:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 991FA40AC6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789118132;
	b=p3YfM2/0KnYR0kOqPb+dGOqL06RDQi11Gos6De+eTnvHgr1/Hs0nJ8aeVLGB7Yfc9VHF
	 LAeinslzg+mUYPjNKj0SizV0/SxTnGLZAJ5sm/WTkVT3uozGw8qW1WTK/OcJtrf5RctYO
	 CRJ/9dfKdYmunK6oqpz0fZBRWuTBTh5ZepLVMpycuZzE5bvIFkAEVPy4HCDigbm0imISe
	 TjBOiRjLhNlyCz0urnoQVPiCqtYYKL/Itc9swSYKbda8CnEwrJ4Pd5vMeEKjDiCNds3Qj
	 pv1uFcPwtwLiC7uWk/PeijbdEeGRrL3lL9pr9EPzlkrxKtCIariatvrzfj3isrOwStw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789118132;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:X-Yandex-Fwd:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=sGEPIqSQO8jReGWdEX/FJKZRpyjrSTsAXNb6sJFDRSQ=;
	b=nWjXSdX4Vidyo6dxkQBZjkYAv2M0usvs6VAEE9Py9u3p1RzvIsHor0koTUKc8G9xgkHM
	 LQhryOEUfcVbfcyDKeuoZ2++pKf/Of3nnQBRpulexYKZtGlsAn1RmHSi02QfXC3SJGvhY
	 n0wzccl0+sTT/o+cKwxfv/tLKWVfWDSiVXyJs4SMb45ookxbz7lRNIKG9iE1usgU/GaF+
	 G/jZlGYVggxIGqX4Go/zX3bQvwK0mil5crSYnPW/K6UuQ9JD5mF+IXgkfJboj9xhf2/7H
	 JbWdD35ZR6U+1pusqEeIdIDj5zQ4umBrCs2gk15X7FMmj8vJVv9vGCNcmbwrPMIF54Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789118132;
	bh=sGEPIqSQO8jReGWdEX/FJKZRpyjrSTsAXNb6sJFDRSQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WjAeD1gn4xypXg7R39KJIo3+UjJN52soKjqnCeDUWq2dGE31L/yeT39snzu1svAt3
	 +dEw2e+PCPdBBKz6CjTEQY32uahiJ4uv9VA5Xg/radUCn71jUDcloBE7qer2zOQdaB
	 wi+SV3Vzn1TdbOydIh078HW7jGvGn+TCiCK6TaauMM/pRaEfS5nFVUmwOdSpAYJnNe
	 YZ9YuUaVXn0guzGTiwqcYKLKIiNehmOGgLCtbwPxN+vDI0BavrnKilxO52yO2owmez
	 v8se8ekwiYbceZvcSz6iOGyIONlOoJhZqkz/9a3TInf7tUHGnXPT4lZe90EpR/mjrO
	 SWVGWLk8/aXDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 991FA40AC6;
	Fri, 11 Sep 2026 09:15:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 721DF49D
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 09:15:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 585D380ED3
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 09:15:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0prJ3ErGsOGR for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 09:15:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AED3B80ED1
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=178.154.239.146
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789118130;
 b=SBNAen1oKnyLzrMXCRwg/tj/+i1KOTMQWJi881BrprxOqAzVPRFx/oBB/RP4nF0OtEg6
 RVlXpY731sHwMe9qQEGhNV9pi4aDgNZ6MVVe0Y5X+mNNQYWN9OEQhhJhW4Kwos2GIUvQr
 2D1bCFX7cjCOVd7CKLsndFJAmQ2Cjf+k5dE/wlCqi6BnA5tVQCP33elN0YWBh7dWRkS2s
 jGx0fyWDEiaGpEIBJ0KaVbUehL1aGFa03b6/CJNXx4ODVXXdSoD/AeFAncjmdlIe47pGv
 MtXZBFM7WJu9nojtmrrOlQGP2PLhnDqlGhlycgn1gjmGD3Nc0wX4rna5AAC/px3/Tyg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789118130;
 h=Received-SPF:Received:Received:X-Yandex-Fwd:DKIM-Signature:
 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
 bh=sGEPIqSQO8jReGWdEX/FJKZRpyjrSTsAXNb6sJFDRSQ=;
 b=nT3fe37tHI5c4pNGUCzLUKQSFbgbr9TlkFd5SJM2tccL5PyBPeICRgIF+h8IBbUnncsV
 upFOOW4vW3v6vzP09rH2rCoJmKErrp9/jUOY0nGcVLqVEywbuJQPbQbcHLdQJ8Fthu2U/
 cD0cVyd9/a/p5zBSKS0KE5P47882CLWRhNhZqZQQDM2YvDEWi/m1kgtqEcfA3Ndq3+7RQ
 ZRpOVqFJAa61t32D32mwHXcA2lw4GWuiCou7jCWsOs5i1kjD2PQ6xgORNpVRsbTc4inGC
 pCyCB3xBLuvgiGfYJ5CVF5/17k7B+9Zl4efwjz9SXFUlWpRvPfGvQb+jZAUOg4mAcNg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=maquefel.me; 
 dkim=pass header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=JgHciIdD; 
 arc=none smtp.remote-ip=178.154.239.146
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.154.239.146;
 helo=forward502b.mail.yandex.net; envelope-from=nikita.shubin@maquefel.me;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me
 header.a=rsa-sha256 header.s=mail header.b=JgHciIdD
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net
 [178.154.239.146])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AED3B80ED1
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 09:15:27 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-main-92.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-92.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:f25:0:640:1f20:0])
 by forward502b.mail.yandex.net (postfix) with ESMTPS id A880D833EF;
 Fri, 11 Sep 2026 12:15:20 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-92.iva.yp-c.yandex.net (smtp)
 with ESMTPSA id DFMVilFeK4Y0-Y3v0xoC3; 
 Fri, 11 Sep 2026 12:15:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1789118120; bh=sGEPIqSQO8jReGWdEX/FJKZRpyjrSTsAXNb6sJFDRSQ=;
 h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
 b=JgHciIdDo9UJ1sT0nUEt2Fiifo2DoKqfTttGil2gY0FUHH5efx/uaWFeFGQhkdMGP
 7JfxI7hqCj45Udasxg2AGF48jHtkMrvLdM/l/lOOCW95kJLkwRweL8M1XyakxaS86F
 Ny7tsSNbRQDcvKJzlEVPThGYQDFuVA71FABZ8eTY=
Authentication-Results: mail-nwsmtp-smtp-production-main-92.iva.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
Message-ID: <2b5d0a43909efc4d25e448e9dfae89edd4bfa63e.camel@maquefel.me>
Subject: Re: [PATCH v4 2/2] riscv: timer: Enable early timer for
 =?UTF-8?Q?M=E2=80=91mode?=
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>
Date: Fri, 11 Sep 2026 12:15:14 +0300
In-Reply-To: <aqPD0KD-u7N425Ew@pie>
References: <20260911-riscv_fix_early_timer_mmode-v4-0-87a7b5abf958@maquefel.me>
 <20260911-riscv_fix_early_timer_mmode-v4-2-87a7b5abf958@maquefel.me>
 <aqO7f1ON6WhT-EPH@pie>
 <62f45089b4898f390432fb189b3192c6e0a319de.camel@maquefel.me>
 <aqPD0KD-u7N425Ew@pie>
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

On Fri, 2026-09-11 at 09:03 +0000, Yao Zi wrote:
> On Fri, Sep 11, 2026 at 11:36:35AM +0300, Nikita Shubin wrote:
> > On Fri, 2026-09-11 at 08:27 +0000, Yao Zi wrote:
> > > On Fri, Sep 11, 2026 at 10:14:06AM +0300, Nikita Shubin wrote:
> > > > The generic RISC-V timer driver currently defines
> > > > timer_early_get_count() only when
> > > > CONFIG_IS_ENABLED(RISCV_SMODE),
> > > > even though reading the TIME CSR is not inherently limited
> > > > to S=E2=80=91mode; it works in M=E2=80=91mode as well when the CSR =
is
> > > > implemented
> > > > in hardware (e.g., with the Zicntr extension).
> > > >=20
> > > > Moreover, timer_early_get_rate() is missing entirely for
> > > > M=E2=80=91mode,
> > > > causing early timer functions to be unavailable on such
> > > > systems.
> > > >=20
> > > > Fix this by:
> > > > - Moving timer_early_get_count() out of the RISCV_SMODE guard
> > > > =C2=A0 so it is always available when CONFIG_TIMER_EARLY is set.
> > > > - Adding M=E2=80=91mode support to timer_early_get_rate(), returnin=
g
> > > > =C2=A0 RISCV_MMODE_TIMER_FREQ when running in M=E2=80=91mode
> > > > =C2=A0 and RISCV_SMODE_TIMER_FREQ in S=E2=80=91mode.
> > > >=20
> > > > This is also necessary because several functions
> > > > (e.g., net_random_ethaddr() via get_ticks()) rely on
> > > > timer_early_get_count() even if CONFIG_TIMER_EARLY is not
> > > > enabled.
> > >=20
> > > Is this description correct? net_random_ethaddr() does invoke
> > > get_ticks(), but the latter only delegates the work to
> > > timer_early_get_count() when CONFIG_TIMER_EARLY is enabled and
> > > gd-
> > > > timer
> > > hasn't been initialized,
> > >=20
> > > 	uint64_t notrace get_ticks(void)
> > > 	{
> > > 		u64 count;
> > > 		int ret;
> > >=20
> > > 		if (!gd->timer) {
> > > 			int ret;
> > >=20
> > > 			if (IS_ENABLED(CONFIG_TIMER_EARLY))
> > > 				return timer_early_get_count();
> > > 	...
> > >=20
> > >=20
> > > > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> >=20
> > Totally correct as this i how i came into fixing the RISCV TIMER,
> > as=20
> > if (IS_ENABLED(CONFIG_TIMER_EARLY)) doesn't protect us from linking
> > error if timer_early_get_count() is missing (unless i am missing
> > something).
>=20
> With optimization, this branch should be turned into dead code and
> the reference is thus eliminated. But anyway, please improve the
> description to mention it's only a possible linking time dependency.
> I'm
> simply confused by "rely on" since this should be dead code without
> CONFIG_TIMER_EARLY :)

Yep it's true - should be rephrased into:

"This is also necessary because several functions
(e.g., net_random_ethaddr() via get_ticks()) rely on
timer_early_get_count() and we should provide one if CONFIG_TIMER_EARLY
is enabled."

>=20
> > It could be simply avoided by turning on any kind of ACLINT/CLINT
> > MTIMER (everybody has one of some sort) - but why i need it if i
> > can
> > rely on RISCV TIMER in SPL stage ?
> >=20
> > It seems no RISC-V board is currently using BOOTP/TFTP boot in SPL.
> >=20
> > >=20
> > > Otherwise this patch looks good to me.
> > >=20
> > > Best regards,
> > > Yao Zi
>=20
> Best regards,
> Yao Zi
