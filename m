Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6A3C79F9F
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 13:15:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 311CE60B1B;
	Thu, 10 Sep 2026 13:15:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lSNx_V2ewg6f; Thu, 10 Sep 2026 13:15:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 29F9360869
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789046129;
	b=fCqJNEzSRtTQYh2V0n7qhl1+pcyWkw5Ifq9tL78iLV7L7M/ymu2hReQ605CtIQfNibg0
	 yrKSyQeY8BuWJYRYUFBYJw8ko1hFFafJgEg9mkkBVqi0AEYvr36SQ3WS0zvuyfS8qyQZ+
	 Gh2FqksVL/tl+Ajk5i6GKja1Gb3vBEM9VyHY2wr+9Pb9AnpSeoPGmu7ij2c2SZcb//Z9c
	 5xr7PFfP+foVmrMpYDaFpxwSf1+eNs1fF6w5zTpFrMTDElVerCB0EAlOh0HgQwHOjlD6s
	 Cf8rcNgQK/AM5yg1VgC5pbYK0zz1XOWEwNPIruNupRkS44hFMweYJNeunXnZ1S0ZA0w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789046129;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:X-Yandex-Fwd:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=4Tx+ph1xXMuAbtq+1MnH9VV+m2f7SCdcTFrDpbUwexc=;
	b=tg7yN/nAMsaG1Py9wJEJaHl20aBfzF6fD6tv7A+qBvCkeSFYD7bGhscMBDHwQfPOQACx
	 PNV03VQdrDKBBH/Wsv3fyFkHHs6cnqjUZSbgn2E+DHWPZ6m68PHoEd+tNu2DBFLa2mBZN
	 R/+jlyxCoeVjid5wNWM6fE2CmuAGUyYaui9ONSX0gZPMjbTqsTvUEIW/z/lG2LQxc1H3k
	 2qfDnckfQ1EcqvN0FTP7YKFyMvNwz7onhhIirg/DANF9yfkhMi6PJQYs7yY1bHzZIAXxv
	 xd55HmLYiXT8/nbiM/yJPjfq2gDxPSbwaUHJ9WDYAX6PEp+I8rMu+Cf4Dw4x+aPZEqw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789046129;
	bh=4Tx+ph1xXMuAbtq+1MnH9VV+m2f7SCdcTFrDpbUwexc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e2BH6tJOXbceZmqIMNwD0kjM30wUnnbfC9f+S3/uEn+03QbKas+Z6ETU3FmGriolK
	 8BlF0TZ9FoxPBgf5+FmdMy5jWtW6VjxpnBq6ICf0yue1e5iVWFy1uw6bnBmXAtzCwv
	 j5qbg/RTgETomQM8reIVdNPzJTceMGf2Kl7ihMy+yKDdB+O4WksYFOyx81JJ9KtMU6
	 p6R5gdqycUsl2mg8zlgFy0cFEvdN0LqwZTQMFBQQQNm+PBf1NCIXrRCD1PwrtGqRls
	 BRuwLW6jFhrqlUiX58SL/Qw6XatEzWGsGoPboakAj3ULx9D1ddUnd9gwB+fTD+MCyq
	 qQ7OR3fWYWOsw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 29F9360869;
	Thu, 10 Sep 2026 13:15:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 42CEE49D
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 13:15:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 28AC340090
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 13:15:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4_BKrOPOCLmS for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 13:15:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0840C40024
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=178.154.239.146
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789046126;
 b=ewjXN1HmW0g9695Kmg4szYIcLoCCdOGBEOQw41kZBgJU+R0jRGJMjIL9YdndfylLz7tS
 048LoPh1U9LFKIysGacvl+TsHYQzh/E7KBTbMg6TFeZj9Tep4pfb7qUKpaNFKTl6Ylkdq
 11fbrLQieuyRDXZlps7V/zc1RZtmLzC0qpY5BVsvfkQeCwYnX2WcDHalDJdaVYvV1mewM
 nkVs2ddhpUTIsPye03GH4KFaHE40zjmTWLoZAHG7kuxNGnEAD8sr1v8LKXMF2fEHq+D3b
 rAziWOZGmPgwo7Li4nSeQ8MZDBAezZsf5mCcFRGssPRhurdaG64rgrM9Zzr+7H9tAaQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789046126;
 h=Received-SPF:Received:Received:X-Yandex-Fwd:DKIM-Signature:
 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
 bh=4Tx+ph1xXMuAbtq+1MnH9VV+m2f7SCdcTFrDpbUwexc=;
 b=rml6qRdhtqWteAgrja1Osqyr4XTdmgyAGU/sozol2lAdrwTIPwTGD2GSN059rinedI9/
 pqo86Y11VIF7c7O/WpN/Udk1wxB0FXwhXWDAkmEIh+GRWKRHMQIfku7CzSa3YQy11culn
 EH3KmlnTopRYcSzqjNqlGFr8U6wf8EJ8qgYPfpyQG7anPJ86QYloBrOVr5y8Z81FFSILB
 rpO+1Hi0LJEDs9djdTkc8be0LJ7iEGpn7yJlUH+IikQ8PEG/gHu5tfYRSmXHzSZNhhrWU
 4KsDDDkHChNY8wVy+u0bc5a9JVj+EJUShsU/rArYl0HkDboT/PRDq21xJo7iozjvGtA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=maquefel.me; 
 dkim=pass header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=sG6fxKGw; 
 arc=none smtp.remote-ip=178.154.239.146
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.154.239.146;
 helo=forward502b.mail.yandex.net; envelope-from=nikita.shubin@maquefel.me;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=sG6fxKGw
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net
 [178.154.239.146])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0840C40024
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 13:15:23 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:1d28:0:640:bb6:0])
 by forward502b.mail.yandex.net (postfix) with ESMTPS id AAC3D8115E;
 Thu, 10 Sep 2026 16:15:17 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id AFP643rg4uQ0-CU7gaHWc; 
 Thu, 10 Sep 2026 16:15:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1789046117; bh=4Tx+ph1xXMuAbtq+1MnH9VV+m2f7SCdcTFrDpbUwexc=;
 h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
 b=sG6fxKGwianVpU8MLRQGaGbP5N41Rbb55g97wxJ+pRLizgTidko2YYP3ANMYKhFX/
 GcFZcc1xWQx4y4Vgp1Eei6y+XovMnDf4WOgWAvqeX4KQ+bqHBkPmtPm37XRrIndAsd
 o4iioadGVqWLJyGo5YdKlVUhTRA/IpX76W/9/0PE=
Authentication-Results: mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
Message-ID: <82d071f376c4ef190e6a3a263054780840faf7ed.camel@maquefel.me>
Subject: Re: [PATCH v2 1/2] riscv: timer: Enable early timer for
 =?UTF-8?Q?M=E2=80=91mode?=
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>
Date: Thu, 10 Sep 2026 16:15:10 +0300
In-Reply-To: <aqKhS6_w0Fqt8vsV@pie>
References: <20260909-riscv_fix_early_timer_mmode-v2-0-563bff2a50c5@maquefel.me>
 <20260909-riscv_fix_early_timer_mmode-v2-1-563bff2a50c5@maquefel.me>
 <aqKhS6_w0Fqt8vsV@pie>
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

Hi Yao Zi.

On Thu, 2026-09-10 at 12:23 +0000, Yao Zi wrote:
> Hi Nikita,
>=20
> Sorry for sending out this review late. My system crashed earlier
> this
> day and I forgot this mail in the draft folder.

No problem,=C2=A0all comments have been taken into account and will be
corrected.

>=20
> On Wed, Sep 09, 2026 at 09:30:59AM +0300, Nikita Shubin wrote:
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
> > =C2=A0 and RISCV_SMODE_TIMER_FREQ=C2=A0=C2=A0 in S=E2=80=91mode.
> >=20
> > This is also necessary because several functions
> > (e.g., net_random_ethaddr() via get_ticks()) rely on
> > timer_early_get_count() even if CONFIG_TIMER_EARLY is not
> > enabled.
> >=20
> > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> > ---
> > =C2=A0drivers/timer/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 13 ++=
+++++++++--
> > =C2=A0drivers/timer/riscv_timer.c | 12 +++++++++---
> > =C2=A02 files changed, 20 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/timer/Kconfig b/drivers/timer/Kconfig
> > index 500a25638a9..12c194ff74a 100644
> > --- a/drivers/timer/Kconfig
> > +++ b/drivers/timer/Kconfig
> > @@ -227,8 +227,17 @@ config RISCV_TIMER
> > =C2=A0	bool "RISC-V timer support"
> > =C2=A0	depends on TIMER && RISCV
> > =C2=A0	help
> > -	=C2=A0 Select this to enable support for a generic RISC-V S-
> > Mode timer
> > -	=C2=A0 driver.
> > +	=C2=A0 Enable support for the generic RISC-V timer driver using
> > the TIME CSR.
> > +
> > +	=C2=A0 This driver works in S-mode and also in M-mode if the
> > TIME CSR is
> > +	=C2=A0 implemented in hardware (e.g., when the Zicntr extension
> > is present).
> > +	=C2=A0 In M-mode, the timer frequency must be provided via the
> > macro
> > +	=C2=A0 RISCV_MMODE_TIMER_FREQ; in S-mode, use
> > RISCV_SMODE_TIMER_FREQ.
>=20
> This doesn't seem correct. These two constants are only used for the
> early timer implementation, and the non-early one looks up the rate
> from
> FDT blob (/cpus/timebase-frequency).
>=20
> > +	=C2=A0 On platforms that also enable CLINT/ACLINT MTIMER, both
> > drivers
> > +	=C2=A0 may provide early timer functions and cause linking
> > conflicts. Ensure
> > +	=C2=A0 that only one of them is selected, or adjust the
> > configuration to avoid
> > +	=C2=A0 duplicate symbols.
>=20
> Won't this issue fixed by PATCH 2? And I think this paragraph is too
> detailed to be included in the Kconfig help.
>=20
> Regards,
> Yao Zi
