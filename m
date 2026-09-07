Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA86CC79F9E
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 07:23:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9009C6063A;
	Mon,  7 Sep 2026 07:23:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dje0G9fqHndt; Mon,  7 Sep 2026 07:23:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A38C9605FC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788765796;
	b=mKPQ7ogQIDCW4Bog8rq1nmU1d2+VBODnbEf7QpVrHJbzuJoA+ayBZHXeKYPJ9QySGFnz
	 DLs3QMVgy8/BgIpcTTMr2ucVS3FuI73jHzeRch+EBBIx6Nda7YfDRfq4RWVa4JIEWayGb
	 YKROohJbVOK2QMIs64sICqiZyaVbVOE2qCOikx1jlpyEDcCB3nffVVfnX2DqAovms4NbM
	 sRanAGkv16+a8MNb+5KC2+7NRXcthP5cfP/kwkDeszSqDd9VdzOZKPu5+PuTnHQvHC+vz
	 5a7EAmcT5VMIoeIzDkc5XAPD/FOFM22dO00Gxil/lXRF9rwNCxHVZmGfNANURFBReig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788765796;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:X-Yandex-Fwd:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=qcKL/WP4kl+diKgXl1KHQB280Gh7pbi9ifWMjidFFdM=;
	b=bXXjahD/LRcMfRpAFxDf6bBCpi+ghIBzaKKBYrgBDMs2bLVzoHJTXfshDIp/H5As+fR6
	 fuPbxtLLEqooXUKOp08gqt8eFjPpSNA0quNCD1nnDiNAxJk+aVcU5PT2IqqFvlMWt24e4
	 baEm4Y/iqboj2KEVwMXTLcVC4FGqFJlrcnIIU9pZL6bXR4OYR5WtL0wkLlD8SqDSJ9xRO
	 pxLy6tPL2y0fwgC0vxlvY/YtTh8MhVpN531FCFRqU5rRbIHlse6xV86nCqodOoHKXvzkZ
	 oOAE2WbDP6JAzpgyqi0ldDk4hscl6JVKlDPmMLtPix+H12+1boUW6DOTvBV+63qUO1g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788765796;
	bh=qcKL/WP4kl+diKgXl1KHQB280Gh7pbi9ifWMjidFFdM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nHhCXnLmkUmgSidQ2x1lpmT2+2uv4QMo6iorQCbmkw9Sh/84NvpbAHL3dKKfFrh4h
	 vJ2eaDv8apdqTiftZkCHmRYNameyLT5Bzaa8uF+X9rfMggJg6/RrmND7jlx7BURSNQ
	 tLNPWIM5KNZzhvTGsZ8M2OMXIBBc7CTC7FXSgZ2moi9M3xsKU/0boqPfE1EZMmEflM
	 5bw0gw3nOS1p+fo6n0KQSu0odjbpWn0A8PE2IEFFBgY2m5XlB52onD62zV6OWv7izv
	 EVs89Jk+Fk42bbuA/YBUHMDY214qihlTF0+d45K08+NLp4Ndw/BrThHCYFT06XdCnj
	 Os2iZVW9BLIYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A38C9605FC;
	Mon,  7 Sep 2026 07:23:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 459C4970
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 07:23:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3708D80937
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 07:23:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iYThIJKD3MAL for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 07:23:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CA290808D8
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2a02:6b8:c0e:500:1:45:d181:d502"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788765793;
 b=aj4zotiUNZqKc8KcRpRU9FzGD5n+CNT2Ims1/7TwISwIP4FRZzWBbEd2BAUUlogoYAiE
 7dK9/FxD4gyJsJrhTW9lerBlfaaWU3Z4etEA/IAxtA7A9somhmw9mYhArQdzGgsjGW8oZ
 EjAUyFH50AWr5PjOen1SO1ylbP5j+znpODWlJ08lGj3kLHrHMHZhhOr+ECRbVMjZ/Ng8t
 WfvbQkmaJb5chyXUxKKaUcyejzHShFmHxrbmMTikH6oLOh47qwNOBHKFKEbfC1/6xsGLu
 1EzQwCYh2+JdnWVRr7wkUdcCwAz0Kt4nCE2HorknCVm3GIZ3H9Rm9cgHuGTw6igAtCw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788765793;
 h=Received-SPF:Received:Received:X-Yandex-Fwd:DKIM-Signature:
 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
 bh=qcKL/WP4kl+diKgXl1KHQB280Gh7pbi9ifWMjidFFdM=;
 b=ZOw8PEal3HjSy+n86uoSp7pnLMrH73E42Y0d+RJXTt2saFz5HRJOlzi6b7ZHt1IhL5Cm
 MW/xYr7IN0RiogBExOzIw3oF9vYGwFH987lQvKLosJPpVHZBDcJWpj6f+inxBQntU6aq5
 5Gl0Zi/nI5tc2thCgwp2TmooaAy/6xOtMX7rXyyxBGdy066C6u9tvyv59ytb/u/cTa3Yd
 pgWfWGkn7P+JodXnK0p/EqIxzTMrtYkYY+2fTjK+ea0xJPsCiELj3v8gHJAyfufnRQhRv
 6XK1gdCcUdoHEmS3cTBh+bk0tCZvIfUFCCUbFQj2Esf3yeY4EuzhxDgNDtX/tMQ0B7A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=maquefel.me; 
 dkim=pass header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=SPPKtAq9; 
 arc=none smtp.remote-ip="2a02:6b8:c0e:500:1:45:d181:d502"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a02:6b8:c0e:500:1:45:d181:d502; helo=forward502a.mail.yandex.net;
 envelope-from=nikita.shubin@maquefel.me; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=SPPKtAq9
Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net
 [IPv6:2a02:6b8:c0e:500:1:45:d181:d502])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CA290808D8
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 07:23:06 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-main-92.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-92.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c15:2e00:0:640:496c:0])
 by forward502a.mail.yandex.net (postfix) with ESMTPS id D7AF882AAD;
 Mon, 07 Sep 2026 10:22:59 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-92.vla.yp-c.yandex.net (smtp)
 with ESMTPSA id rMGeWp7eIeA0-HTIj9nvt; 
 Mon, 07 Sep 2026 10:22:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1788765779; bh=qcKL/WP4kl+diKgXl1KHQB280Gh7pbi9ifWMjidFFdM=;
 h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
 b=SPPKtAq9c32iRmkoMDlAyEepShREBeD4dzICiPU7Yt2dFeWRMmzz1/S9HYafWcJhe
 HaYGZkngwuuZHDrjREcYVf+eUlUYMRSSYJQ1CqNeJHOL64DK59kQYauM88vJPKWXW8
 g9Oquc/88Pje5ef0SOqOvsuPpdlArRzfHY7IBY88=
Authentication-Results: mail-nwsmtp-smtp-production-main-92.vla.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
Message-ID: <37844d7d5ff5ff7e391cdc226ad58884621c9271.camel@maquefel.me>
Subject: Re: [PATCH] riscv: timer: Fix M-Mode timer
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
Date: Mon, 07 Sep 2026 10:22:54 +0300
In-Reply-To: <apsZY2QgTXuJUivy@pie>
References: <20260904-riscv_fix_early_timer_mmode-v1-1-210e769b0ac2@maquefel.me>
 <apsZY2QgTXuJUivy@pie>
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

Hi Yao Zi,

> https://lore.kernel.org/all/Z7dMY_GqLHsC-5gl@pie.lan/

> TIME CSR only when Zicntr extension exists,

Indeed, also TIME CSR obviously is available for M-Mode in that case.

> - Remove the timer-binding code in drivers/cpu/riscv_cpu.c

There is a caveat that, we have "riscv,timer" compatible which is
defined in documentation, but never used anywhere.

So we must manually instantiate it somewhere. May be it's a good idea
to move it into `riscv_cpu_setup()`, we can also check extension there
(in case they specified in dts for those who rely on it).

> - Correct help text and comments for riscv_timer.c, just like what
has
> been done in this patch.

Agree.

> - Rename RISCV_SMODE_TIMER_FREQ to RISCV_EARLY_TIMER_FREQ, clean up
>  preprocessor instructions that limit some functions to S-Mode only.
>  They shouldn't be S-mode only stuff.

Agree. But still RISCV_SMODE_TIMER_FREQ/RISCV_MMODE_TIMER_FREQ in
theory might differ, if, for example we are switching clock source
somewhere in SPL phase.

> - For future RISC-V cores that are capable of reading timestamp from
>  TIME CSR, we could either register the compatible string of its
timer
>  to riscv_timer.c (T-Head case, the underlying CLINT isn't a real
>  SSTC-capable device) or add a "riscv,timer" node.

> +	{ .compatible =3D "thead,c900-clint" },

I think Zicntr is orthogonal to a particular CLINT implementation.
There might be some cases when MMIO access is compatible with some
existing CLINT implementations, but the hart lacks Zicntr.


On Fri, 2026-09-04 at 19:17 +0000, Yao Zi wrote:
> On Fri, Sep 04, 2026 at 09:12:55AM +0300, Nikita Shubin wrote:
> > RISC-V timer is missing timer_early_get_rate() for M-Mode.
> >=20
> > Also timer_early_get_count() is guarded by RISCV_SMODE for no
> > clear reason.
>=20
> This driver is described as "support for a generic RISC-V S-Mode
> timer
> driver", which should be the original reason to mark it as S-Mode
> only.
> It should be intentionally to split M-mode (riscv_aclint_timer.c,
> guarded by CONFIG_RISCV_ACLINT) and S-mode timers, since
> riscv_timer.c
> reads ticks from TIME CSR, while at least SiFive cores miss it in
> M-mode, and rely on OpenSBI to emulate them.
>=20
> But this separation is indeed unnecessary, there are as well cores
> implementing TIME CSR, so riscv_timer.c works on them even in M-mode,
> too, e.g., T-Head ones.
>=20
> I've summarized the situation here[1], but didn't find enough time
> and
> energy to send out a series to fix issues up...
>=20
> Anyway, please fix the Kconfig help text, too.

Agree.

>=20
> > Make timer_early_get_rate() use RISCV_MMODE_TIMER_FREQ in M-Mode
> > and
> > move timer_early_get_count() out of define.
> >=20
> > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> > ---
> > =C2=A0drivers/timer/riscv_timer.c | 11 +++++++++--
> > =C2=A01 file changed, 9 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/timer/riscv_timer.c
> > b/drivers/timer/riscv_timer.c
> > index 1f4980ceb38..65f174fb879 100644
> > --- a/drivers/timer/riscv_timer.c
> > +++ b/drivers/timer/riscv_timer.c
>=20
> At start of the file, a comment mentions "This driver provides
> generic
> timer support for S-mode U-Boot". Please update it along the way.
>=20
> > @@ -33,14 +33,22 @@ static u64 notrace riscv_timer_get_count(struct
> > udevice *dev)
> > =C2=A0	return ((u64)hi << 32) | lo;
> > =C2=A0}
> > =C2=A0
> > -#if CONFIG_IS_ENABLED(RISCV_SMODE) &&
> > IS_ENABLED(CONFIG_TIMER_EARLY)
> > =C2=A0/**
> > =C2=A0 * timer_early_get_rate() - Get the timer rate before driver mode=
l
> > =C2=A0 */
> > +#if IS_ENABLED(CONFIG_TIMER_EARLY)
> > +#if CONFIG_IS_ENABLED(RISCV_SMODE)
> > =C2=A0unsigned long notrace timer_early_get_rate(void)
> > =C2=A0{
> > =C2=A0	return RISCV_SMODE_TIMER_FREQ;
> > =C2=A0}
> > +#elif CONFIG_IS_ENABLED(RISCV_MMODE)
> > +unsigned long notrace timer_early_get_rate(void)
> > +{
> > +	return RISCV_MMODE_TIMER_FREQ;
> > +}
> > +#endif
> > +#endif
>=20
> For platforms like starfive_visionfive2_defconfig where both
> CONFIG_RISCV_TIMER and CONFIG_RISCV_ACLINT are enabled, riscv_timer.c
> and riscv_aclint_timer.c would each provide their own early timer
> symbols and causing linking errors when building with defconfig.
>=20
> These platforms might depend on the IPI functionality provided by
> aclint_ipi.c, which is also guarded by CONFIG_RISCV_ACLINT; and
> riscv_timer.c might not work on them, either, thus simply disabling
> CONFIG_RISCV_ACLINT isn't an option.
>=20
> Regards,
> Yao Zi
>=20
> [1]: https://lore.kernel.org/all/Z7dMY_GqLHsC-5gl@pie.lan/
