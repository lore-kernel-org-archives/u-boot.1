Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F4FC021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 15:59:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B46E80843;
	Mon, 17 Feb 2025 16:59:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="btCDRfLP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F69A80BAE; Mon, 17 Feb 2025 16:59:21 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 191AF80843
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 16:59:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21f61b01630so85321255ad.1
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 07:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739807955; x=1740412755; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XLgwXZl4fCaSuT3uPKOdB/lVQRJCkS55WwfFCT6bY6M=;
 b=btCDRfLPzeAgCxTabjGuNI7AhXLsPNnY14KjyMCwQFnY/3S0e2ZwmSA/R1sHGbm6fh
 I27O7MfiLiHL7L576uzdiB/EcQUvVCUJqvBgEHFrYm4fUsscunifuN+OveauT5q/YEix
 3lUc+DiXwjErra5Lqgtz1+Flb0QvxQ/6FfpDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739807955; x=1740412755;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XLgwXZl4fCaSuT3uPKOdB/lVQRJCkS55WwfFCT6bY6M=;
 b=Wi5HsWnwE5BcCXQsm/Hl+OqXpqZuw/lF6abJsT4Qb7QyYdrmNj8iyESvhihNmi1s5s
 2TXEctlLkqgmCdkX0AuQagwgpYFcPpavar3MvzNLwbllK8Pjn1xrxvEhJjjNc+fynw60
 KeGMinv/eTgFVaR1/oYPAwtnKXWuOEZvjk51MxRAoe/nEwVxzggoyYaVAZ/gmsRQz1nx
 Q6XNlHO6/iqQquc0If7nex9NERfzD44aOKvXgVTxAfo69V95zwv/oSVO/kyJFmKfno9S
 fN3K/XVFqifpgO4ZpR/ayxV0hx8UOB1+nhku9f7ejstCG4z2eKraC7joK6Bz8FfMKkXb
 axkw==
X-Gm-Message-State: AOJu0YyedPsyCtGV/8nGTuT3oPx0Ys0EBB1hqE187JimFh5ohAaLMBnI
 SOhLSKqwrYopD13INI1m6CWTdXU/qGy1dTmIXULPfhfCnwONIiJF5qbiZ8Z70MjPL/N+4QsrGoR
 D
X-Gm-Gg: ASbGnctFI8dAOfNGf8VE1R+banyhSsxbw5BXURKKj5Kj+rayqNoVDx3JpJGaOjPVgNu
 TE7IPTKOSLrn+q4y0LoMJmunNqf0D23hr/kcCIt8fDk6s/Lf+HO9CkE3BHth7LbMgN4DxZY/BYF
 HhN9rKmVulEL7+wUvhzp2VZvXlaWVtqrt/WfN85grPu6EKL4FToPv89VPHFk5GcJPMRtkLxV8hY
 YpWBoiWv5Ivk/gaIwL+3VSx+m+YLE+U8K8E328P6dVGULQtQXf8zdEUEMPVKUzSEYsSF1XdFtzx
 QwDKMjqQYFWFXA==
X-Google-Smtp-Source: AGHT+IEgnqD3H1FNiZKug4RfueIug8VQOWhEfo/yfWCG8LRQxmRBFiz2TUmvn44kYfxLseRwAL5Qdw==
X-Received: by 2002:a05:6a00:3e0c:b0:728:f21b:ce4c with SMTP id
 d2e1a72fcca58-73262178bc9mr18785383b3a.5.1739807954848; 
 Mon, 17 Feb 2025 07:59:14 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73266fd6438sm4691516b3a.142.2025.02.17.07.59.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 07:59:14 -0800 (PST)
Date: Mon, 17 Feb 2025 09:59:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: xPL Proposal
Message-ID: <20250217155911.GN1233568@bill-the-cat>
References: <20250214143928.GG1233568@bill-the-cat>
 <CAFLszTg0yeOu13h1bxq2KiqVqwUQ-DdiJc+nhhknf5_JGygXgw@mail.gmail.com>
 <20250214211652.GI1233568@bill-the-cat>
 <CAFLszTi=abpaGi0CnnNoKYsT9M0H-9xrGaQtdLORvM8J7usX1Q@mail.gmail.com>
 <20250214234354.GJ1233568@bill-the-cat>
 <CAFLszTghcMz1mnu_jZOi9=TQpTgjyOQV-4sT=p=Q=dUBo3pQ_Q@mail.gmail.com>
 <20250215011403.GK1233568@bill-the-cat>
 <CAFLszTiNMr085kpwrtWrhJv6pMRd2_ODX0wmUNvW+D7EY8ighw@mail.gmail.com>
 <20250217141957.GK1233568@bill-the-cat>
 <CAFLszThS3DyApKjuNHWE=7Xwh_DZEHPeBDOwutuziSzsZFdjXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cNstQPGVeo+iLV4i"
Content-Disposition: inline
In-Reply-To: <CAFLszThS3DyApKjuNHWE=7Xwh_DZEHPeBDOwutuziSzsZFdjXw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--cNstQPGVeo+iLV4i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 08:08:58AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 17 Feb 2025 at 07:20, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Feb 14, 2025 at 06:43:30PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 14 Feb 2025 at 18:14, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Feb 14, 2025 at 04:52:04PM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Fri, 14 Feb 2025 at 16:43, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Fri, Feb 14, 2025 at 03:46:30PM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Fri, 14 Feb 2025 at 14:16, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Fri, Feb 14, 2025 at 12:48:33PM -0700, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Fri, Feb 14, 2025, 07:39 Tom Rini <trini@konsulko.com>=
 wrote:
> > > > > > > > > >
> > > > > > > > > > On Thu, Feb 13, 2025 at 05:09:47PM -0700, Simon Glass w=
rote:
> > > > > > > > > > > Hi Tom,
> > > > > > > > > > >
> > > > > > > > > > > On Thu, 13 Feb 2025 at 15:59, Tom Rini <trini@konsulk=
o.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Thu, Feb 13, 2025 at 02:57:59PM -0700, Simon Gla=
ss wrote:
> > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Thu, Feb 13, 2025, 11:03 Tom Rini <trini@konsu=
lko.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Thu, Feb 13, 2025 at 05:50:13AM -0700, Simon=
 Glass wrote:
> > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Wed, 12 Feb 2025 at 15:58, Tom Rini <trini=
@konsulko.com> wrote:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On Wed, Feb 12, 2025 at 01:05:11PM -0700, S=
imon Glass wrote:
> > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > On Wed, 12 Feb 2025 at 11:35, Tom Rini <t=
rini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > On Wed, Feb 12, 2025 at 10:41:45AM -070=
0, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > On Wed, 12 Feb 2025 at 09:40, Tom Rin=
i <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > On Tue, Feb 11, 2025 at 03:54:21PM =
-0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > On Tue, 11 Feb 2025 at 14:22, Tom=
 Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > On Tue, Feb 11, 2025 at 08:03:2=
0AM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > > > > > Hi,
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > I just wanted to send a note =
to (re-)introduce my ideas[1] for the
> > > > > > > > > > > > > > > > > > > > > > > next iteration of xPL.
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > A recent series introduced 'x=
PL' as the name for the various
> > > > > > > > > > > > > > > > > > > > > > > pre-U-Boot phases, so now CON=
FIG_XPL_BUILD means that this is any xPL
> > > > > > > > > > > > > > > > > > > > > > > phase and CONFIG_SPL means th=
is really is the SPL phase, not TPL. We
> > > > > > > > > > > > > > > > > > > > > > > still use filenames and funct=
ion naming which uses 'spl', but could
> > > > > > > > > > > > > > > > > > > > > > > potentially adjust that.
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > The major remaining problem I=
MO is that it is quite tricky and
> > > > > > > > > > > > > > > > > > > > > > > expensive (in terms of time) =
to add a new phase. We also have some
> > > > > > > > > > > > > > > > > > > > > > > medium-sized problems:
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > a. The $(PHASE_), $(SPL_) rul=
es in the Makefile are visually ugly and
> > > > > > > > > > > > > > > > > > > > > > > can be confusing, particularl=
y when combined with ifdef and ifneq
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > b. We have both CONFIG_IS_ENA=
BLED() and IS_ENABLED() and they mean
> > > > > > > > > > > > > > > > > > > > > > > different things. For any giv=
en option, some code uses one and some
> > > > > > > > > > > > > > > > > > > > > > > the other, depending on what =
problems people have met along the way.
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > c. An option like CONFIG_FOO =
is ambiguous, in that it could mean that
> > > > > > > > > > > > > > > > > > > > > > > the option is enabled in one =
or more xPL phases, or just in U-Boot
> > > > > > > > > > > > > > > > > > > > > > > proper. The only way to know =
is to look for $(PHASE_) etc. in the
> > > > > > > > > > > > > > > > > > > > > > > Makefiles and CONFIG_IS_ENABL=
ED() in the code. This is very confusing
> > > > > > > > > > > > > > > > > > > > > > > and has not scaled well.
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > d. We need to retain an impor=
tant feature: options from different
> > > > > > > > > > > > > > > > > > > > > > > phases can depend on each oth=
er. As an example, we might want to
> > > > > > > > > > > > > > > > > > > > > > > enable MMC in SPL by default,=
 if MMC is enabled in U-Boot proper. We
> > > > > > > > > > > > > > > > > > > > > > > may also want to share values=
 between phases, such as TEXT_BASE. We
> > > > > > > > > > > > > > > > > > > > > > > can do this easily today, jus=
t by adding Kconfig rules.
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > I agree with a through c and fo=
r d there are likely some cases even if
> > > > > > > > > > > > > > > > > > > > > > I'm not sure TEXT_BASE is a goo=
d example. But I'm not sure it's as
> > > > > > > > > > > > > > > > > > > > > > important as the other ones.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > OK. No, TEXT_BASE is not a great =
example in my book either. But it is
> > > > > > > > > > > > > > > > > > > > > true that SPL needs to know U-Boo=
t's text base.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > Here's another:
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > config SPL_SYS_MALLOC_F_LEN
> > > > > > > > > > > > > > > > > > > > >    default SYS_MALLOC_F_LEN
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > config TPL_SYS_MALLOC_F
> > > > > > > > > > > > > > > > > > > > >    default y if SPL_SYS_MALLOC_F
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > config TPL_SYS_MALLOC_F_LEN
> > > > > > > > > > > > > > > > > > > > >    depends on TPL_SYS_MALLOC_F
> > > > > > > > > > > > > > > > > > > > >    default SPL_SYS_MALLOC_F_LEN
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > Alternatively:
> > > > > > > > > > > > > > > > > > > > config SYS_MALLOC_LEN
> > > > > > > > > > > > > > > > > > > >    ... current default X if Y
> > > > > > > > > > > > > > > > > > > >    default 0x2800 if RCAR_GEN3 && !=
PPL
> > > > > > > > > > > > > > > > > > > >    default 0x2000 if IMX8MQ && !PPL
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > PPL means (in my book) that we have a=
 PPL, i.e. it is always true. It
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > And in my proposal you're choosing betw=
een PPL, SPL, TPL, VPL.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > is the same today, with SPL. We have =
CONFIG_SPL_BUILD which indicates
> > > > > > > > > > > > > > > > > > > which build it is. If you are suggest=
ing that SPL means that this is
> > > > > > > > > > > > > > > > > > > the SPL build, then which thing tells=
 us whether or not we have an SPL
> > > > > > > > > > > > > > > > > > > build? I'm just a bit confused by thi=
s.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > And we wouldn't have CONFIG_SPL_BUILD b=
ecause we would either be
> > > > > > > > > > > > > > > > > > configuring for SPL=3Dy or SPL=3Dn, the=
re's no confusion anymore.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > But how can I make the TPL value of S=
YS_MALLOC_F_LEN the same as the
> > > > > > > > > > > > > > > > > > > SPL one, with your scheme?
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > If your question is "how do I set an ar=
bitrary but consistent value in
> > > > > > > > > > > > > > > > > > SPL and SPL" that's not enforced. But t=
hey also shouldn't be arbitrary
> > > > > > > > > > > > > > > > > > and we should have sane defaults set in=
 Kconfig, regardless of either
> > > > > > > > > > > > > > > > > > proposal. While I'm trying to not get l=
ost in the details today we have
> > > > > > > > > > > > > > > > > > 80 matches on "git grep SPL_.*_LEN=3D c=
onfigs/" and 2 for TPL and I would
> > > > > > > > > > > > > > > > > > encourage someone to verify those are n=
eeded. My initial recollection is
> > > > > > > > > > > > > > > > > > that most of these are from when we bum=
ped SYS_MALLOC_F_LEN or so up to
> > > > > > > > > > > > > > > > > > the commonly used default and had the f=
ew platforms that didn't use the
> > > > > > > > > > > > > > > > > > new default previously switch to the ol=
d one.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > In other words, I don't think there's a=
 problem here that isn't solved
> > > > > > > > > > > > > > > > > > today, outside of either proposal.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > So I'm still not understanding how yo=
u handle Kconfig dependencies
> > > > > > > > > > > > > > > > > > > between phases with your scheme. Are =
you saying you don't and they are
> > > > > > > > > > > > > > > > > > > not important?
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Basically. The majority of the cases of:
> > > > > > > > > > > > > > > > > > config SPL_FOO
> > > > > > > > > > > > > > > > > >    default y if FOO
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > config TPL_FOO
> > > > > > > > > > > > > > > > > >    default y if SPL_FOO
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Just go away because FOO is already def=
ault y or select/imply'd by
> > > > > > > > > > > > > > > > > > TARGET_BAR or ARCH_BAZ.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > Also, is there a single Kconfig tree =
for U-Boot, or are you saying you
> > > > > > > > > > > > > > > > > > > want a different set of Kconfig files=
 for each phase?
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Just the Kconfig files we have today. L=
ikely with less overall lines
> > > > > > > > > > > > > > > > > > since for example we could drop:
> > > > > > > > > > > > > > > > > > config SPL_FS_EXT4
> > > > > > > > > > > > > > > > > >         bool "Support EXT filesystems"
> > > > > > > > > > > > > > > > > >         select SPL_CRC16 if EXT4_WRITE
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Since we already have fs/ext4/Kconfig.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > Proposal
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > 1. Adjust kconf to generate s=
eparate autoconf.h files for each phase.
> > > > > > > > > > > > > > > > > > > > > > > These contain the values for =
each Kconfig option for that phase. For
> > > > > > > > > > > > > > > > > > > > > > > example CONFIG_TEXT_BASE in a=
utoconf_spl.h is SPL's text base.
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > 2. Add a file to resolve the =
ambiguity in (c) above, listing the
> > > > > > > > > > > > > > > > > > > > > > > Kconfig options which should =
not be enabled/valid in any xPL build.
> > > > > > > > > > > > > > > > > > > > > > > There are around 200 of these.
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > 3. Introduce CONFIG_PPL as a =
new prefix, meaning U-Boot proper (only),
> > > > > > > > > > > > > > > > > > > > > > > useful in rare cases. This in=
dicates that the option applies only to
> > > > > > > > > > > > > > > > > > > > > > > U-Boot proper and is not defi=
ned in any xPL build. It is analogous to
> > > > > > > > > > > > > > > > > > > > > > > CONFIG_TPL_xxx meaning 'enabl=
ed in TPL'. Only a dozen of these are
> > > > > > > > > > > > > > > > > > > > > > > needed at present, basically =
to allow access to the value for another
> > > > > > > > > > > > > > > > > > > > > > > phase, e.g. SPL wanting to fi=
nd CONFIG_PPL_TEXT_BASE so that it knows
> > > > > > > > > > > > > > > > > > > > > > > the address to which U-Boot s=
hould be loaded.
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > 4. There is no change to the =
existing defconfig files, or 'make
> > > > > > > > > > > > > > > > > > > > > > > menuconfig', which works just=
 as today, including dependencies between
> > > > > > > > > > > > > > > > > > > > > > > options across all phases.
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > 5. (next) Expand the Kconfig =
language[2] to support declaring phases
> > > > > > > > > > > > > > > > > > > > > > > (SPL, TPL, etc.) and remove t=
he need for duplicating options (DM_MMC,
> > > > > > > > > > > > > > > > > > > > > > > SPL_DM_MMC, TPL_DM_MMC, VPL_D=
M_MMC), so allowing an option to be
> > > > > > > > > > > > > > > > > > > > > > > declared once for any/all pha=
ses. We can then drop the file in 2
> > > > > > > > > > > > > > > > > > > > > > > above.
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > With this, maintaining Kconfi=
g options, Makefiles and adding a new
> > > > > > > > > > > > > > > > > > > > > > > phase should be considerably =
easier.
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > I think this will not make our =
life easier, it will make things harder.
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > I think what we've reached now =
shows that Yamada-san was correct at the
> > > > > > > > > > > > > > > > > > > > > > time in saying that we were goi=
ng down the wrong path with how we
> > > > > > > > > > > > > > > > > > > > > > handled SPL/TPL.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > You've mentioned this quite a few=
 times over the years. Is there a
> > > > > > > > > > > > > > > > > > > > > reference to what he suggested we=
 should do? Or perhaps it is what you
> > > > > > > > > > > > > > > > > > > > > have below.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > I don't recall what he proposed ins=
tead, just that when it became clear
> > > > > > > > > > > > > > > > > > > > that I wanted to move from the "S:C=
ONFIG_FOO.." syntax for how SPL was
> > > > > > > > > > > > > > > > > > > > handled to how we're doing it today=
, he thought that was the wrong
> > > > > > > > > > > > > > > > > > > > direction.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > Yes, IMO he was right about that.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > My request instead is:
> > > > > > > > > > > > > > > > > > > > > > - Largely drop SPL/TPL/VPL (so =
no DM_MMC and SPL_DM_MMC and so on, just
> > > > > > > > > > > > > > > > > > > > > >   DM_MMC) as a prefix.
> > > > > > > > > > > > > > > > > > > > > > - Likely need to introduce a PP=
L symbol as you suggest.
> > > > > > > > > > > > > > > > > > > > > > - Make PPL/SPL/TPL/VPL be a cho=
ice statement when building a defconfig.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > Good idea.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > - Split something like rockpro6=
4-rk3399_defconfig in to
> > > > > > > > > > > > > > > > > > > > > >   rockpro64-rk3399_ppl_defconfig
> > > > > > > > > > > > > > > > > > > > > >   rockpro64-rk3399_spl_defconfi=
g rockpro64-rk3399_tpl_defconfig
> > > > > > > > > > > > > > > > > > > > > >   and add Makefile logic such t=
hat for X_defconfig as a build target but
> > > > > > > > > > > > > > > > > > > > > >   not configs/X_defconfig not e=
xisting, we see if any of
> > > > > > > > > > > > > > > > > > > > > >   configs/X_{ppl,spl,tpl,vpl}_d=
efconfig exist and we run a builds in
> > > > > > > > > > > > > > > > > > > > > >   subdirectories of our object =
directory, and then using binman combine
> > > > > > > > > > > > > > > > > > > > > >   as needed.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > This means splitting the existing=
 file into a separate one for each
> > > > > > > > > > > > > > > > > > > > > phase. I believe that will be har=
d to manage.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > Do you mean initially, or long term=
? Initially, it should be a bit of
> > > > > > > > > > > > > > > > > > > > shell scripting. The consolidation =
(ie most/all rk3399 having an
> > > > > > > > > > > > > > > > > > > > identical _spl_defconfig) can't be =
automated. Long term I'm not sure it
> > > > > > > > > > > > > > > > > > > > would be any different. Most of the=
 maintenance is on resync'ing which
> > > > > > > > > > > > > > > > > > > > is automated.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > Long term. How does 'make menuconfig'=
 work in this case? Won't you
> > > > > > > > > > > > > > > > > > > have to run it three times for SPL, T=
PL and PPL?
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Yes, you would run configure for what y=
ou're building. This is a good
> > > > > > > > > > > > > > > > > > thing as it will no longer be so confus=
ing to hunt down where SPL or TPL
> > > > > > > > > > > > > > > > > > or VPL options for a specific thing res=
ide.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > >   - Maybe instead the Makefile =
logic above we would parse X_defconfig
> > > > > > > > > > > > > > > > > > > > > >     and see if it's a different=
 format of say PHASE:file to make it
> > > > > > > > > > > > > > > > > > > > > >     easier to say share a singl=
e TPL config with all rk3399, have a few
> > > > > > > > > > > > > > > > > > > > > >     common SPL configs and then=
 just a board specific PPL.
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > This solves (a) by removing the=
m entirely. This solves (b) by removing
> > > > > > > > > > > > > > > > > > > > > > the ambiguity entirely (it will=
 be enabled or not). As a bonus for (b)
> > > > > > > > > > > > > > > > > > > > > > we can switch everyone to IS_EN=
ABLED(CONFIG_FOO) and match up with the
> > > > > > > > > > > > > > > > > > > > > > Linux Kernel again. This solves=
 (c) again by removing it entirely.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > The scheme I propose removes a-c =
also. I should have made that clear.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > Er, ok. That's not how it looked be=
fore, but I guess I'm just mistaken.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > Yes I think so...it was a major goal =
to remove this stuff. [1] [2]
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Thanks.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > There is not a huge difference be=
tween your scheme and mine. My
> > > > > > > > > > > > > > > > > > > > > question is, how do you handle (d=
)?
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > Well, either (d) isn't important as=
 for example MMC wasn't a good choice
> > > > > > > > > > > > > > > > > > > > in your proposal as virtually every=
one "select MMC" today or it's
> > > > > > > > > > > > > > > > > > > > handled more easily as my example a=
bove in SYS_MALLOC_LEN.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > The way I see it, both schemes re=
move the ambiguity. Mine retains a
> > > > > > > > > > > > > > > > > > > > > single deconfig file and a single=
 'make menuconfig' for each board.
> > > > > > > > > > > > > > > > > > > > > Yours feels more like building in=
dependent U-Boot images.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > It is explicitly building independe=
nt U-Boot images, yes. With a wrapper
> > > > > > > > > > > > > > > > > > > > around "make all of the images for =
a given platform". So much of our
> > > > > > > > > > > > > > > > > > > > confusing and messy code is because=
 we aren't doing that. And since most
> > > > > > > > > > > > > > > > > > > > modern SoCs can work as (mostly )ge=
neric SPL selects correct DTB for PPL
> > > > > > > > > > > > > > > > > > > > we really could have fewer overall =
build configurations.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > I'd really like to see a generic aarc=
h64 U-Boot for PPL, although it
> > > > > > > > > > > > > > > > > > > would be quite large with all the dri=
vers. Perhaps we could start by
> > > > > > > > > > > > > > > > > > > having a generic Rockchip one, for ex=
ample.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > Still I don't see this being strongly=
 related to the discussion about
> > > > > > > > > > > > > > > > > > > these two different schemes.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Well, in your scheme how do we have say=
 generic-aarch64_defconfig
> > > > > > > > > > > > > > > > > > function on either chromebook_bob or am=
62x_beagleplay_a53 ? In mine,
> > > > > > > > > > > > > > > > > > since everything is a separate build, g=
eneric-aarch64_defconfig has
> > > > > > > > > > > > > > > > > > PPL=3Dy, ARCH_K3=3Dy and ROCKCHIP_RK339=
9=3Dy. And then
> > > > > > > > > > > > > > > > > > chromebook_bob_defconfig would say to u=
se chromebook_bob_tpl_defconfig,
> > > > > > > > > > > > > > > > > > generic-rk3399_spl_defconfig and generi=
c-aarch64_defconfig. As a bonus
> > > > > > > > > > > > > > > > > > instead of am62x_beagleplay_a53_defconf=
ig and
> > > > > > > > > > > > > > > > > > am62x_beagleplay_r5_defconfig we would =
have am62x_beagleplay_defconfig
> > > > > > > > > > > > > > > > > > that would say to use the appropriate S=
PL/PPL for R5, and appropriate
> > > > > > > > > > > > > > > > > > SPL/PPL for A53.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > But the one big huge caveat I want to m=
ake here is that "generic" images
> > > > > > > > > > > > > > > > > > are useful in some use cases (I'm sure =
all of the regular F/OSS
> > > > > > > > > > > > > > > > > > distributions would love a single actua=
lly common PPL if they can fit
> > > > > > > > > > > > > > > > > > it) will strip things down. Whatever th=
e IoT edge device closest to you
> > > > > > > > > > > > > > > > > > now really won't want to ship with all =
the platforms enabled. Image size
> > > > > > > > > > > > > > > > > > still matters.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > OK thanks for the details. I think I have=
 a reasonable idea of what
> > > > > > > > > > > > > > > > > you are proposing, now. It would work, bu=
t is quite radical, IMO.
> > > > > > > > > > > > > > > > > That's not necessarily a bad thing, but i=
n my mind I see a sequencing
> > > > > > > > > > > > > > > > > possibility.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > A few points from my side:
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > 1. I would love to see the defconfig file=
s reduce in size, with more
> > > > > > > > > > > > > > > > > and better defaults. One way to do this w=
ould be to enforce a maximum
> > > > > > > > > > > > > > > > > length. I added a feature to qconfig to a=
llow finding common options
> > > > > > > > > > > > > > > > > among boards (the -i flag), but I'm not s=
ure if many people use it.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > I don't see reducing defconfig size as impo=
rtant honestly. Should we
> > > > > > > > > > > > > > > > have more and better defaults? Yes. But alm=
ost everything is under 200
> > > > > > > > > > > > > > > > lines with the biggest (non-sandbox) ones b=
eing the generic zynqmp
> > > > > > > > > > > > > > > > platform(s?).
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Agreed.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > 2. Generic boards is something I have bee=
n pushing for years (in fact
> > > > > > > > > > > > > > > > > it is why I originally introduced devicet=
ree), but I'm not seeing a
> > > > > > > > > > > > > > > > > lot of traction.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > I don't think generic boards are universall=
y helpful. Even if what I'm
> > > > > > > > > > > > > > > > proposing would allow for more of it, below=
 the PPL stage I'm not sure
> > > > > > > > > > > > > > > > it's both feasible enough and useful enough=
 for production. At the PPL
> > > > > > > > > > > > > > > > stage it still has to be small enough and n=
ot overly burdensome. What we
> > > > > > > > > > > > > > > > talked about on the call yesterday about us=
ing more multi-dtb images is
> > > > > > > > > > > > > > > > a step in the right direction, yes.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Agreed. Anway, we can create separate targets=
 for generic boards if we want to.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > 3. Iit seems that you want to remove all =
the 'if SPL' pieces and just
> > > > > > > > > > > > > > > > > rely on the current PPL configuration. Bu=
t how will that work? There
> > > > > > > > > > > > > > > > > are tons of features which don't work in =
SPL, or are not relevant, or
> > > > > > > > > > > > > > > > > have special 'small' versions. That is a =
*lot* of Kconfig refactoring
> > > > > > > > > > > > > > > > > just to get something working, isn't it? =
With my scheme there is no
> > > > > > > > > > > > > > > > > Kconfig change needed initially - it can =
be done later as needed /
> > > > > > > > > > > > > > > > > desirable.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > I don't think we would remove most "if SPL"=
 cases. Taking part of the
> > > > > > > > > > > > > > > > current stanza for ROCKCHIP_RK3399 as an ex=
ample:
> > > > > > > > > > > > > > > > config ROCKCHIP_RK3399
> > > > > > > > > > > > > > > >         bool "Support Rockchip RK3399"
> > > > > > > > > > > > > > > >         select ARM64
> > > > > > > > > > > > > > > >         select SUPPORT_SPL
> > > > > > > > > > > > > > > >         select SUPPORT_TPL
> > > > > > > > > > > > > > > >         select SPL
> > > > > > > > > > > > > > > >         select SPL_ATF
> > > > > > > > > > > > > > > >         select SPL_BOARD_INIT if SPL
> > > > > > > > > > > > > > > >         ...
> > > > > > > > > > > > > > > >         select SPL_CLK if SPL
> > > > > > > > > > > > > > > >         ...
> > > > > > > > > > > > > > > >         select CLK
> > > > > > > > > > > > > > > >         ...
> > > > > > > > > > > > > > > >         imply TPL_CLK
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > This would become:
> > > > > > > > > > > > > > > > config ROCKCHIP_RK3399
> > > > > > > > > > > > > > > >         bool "Support Rockchip RK3399"
> > > > > > > > > > > > > > > >         select ARM64
> > > > > > > > > > > > > > > >         select SUPPORT_SPL
> > > > > > > > > > > > > > > >         select SUPPORT_TPL
> > > > > > > > > > > > > > > >         select SPL_ATF if SPL # TBD: Does '=
ATF' make sense outside of SPL?
> > > > > > > > > > > > > > > >         select BOARD_INIT if SPL # Not TPL_=
BOARD_INIT here
> > > > > > > > > > > > > > > >         select CLK # imply was likely wrong=
 before? Would need to check
> > > > > > > > > > > > > > > >         ...
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > I was more talking about the large blocks of =
'if SPL' - e.g. we have
> > > > > > > > > > > > > > > common/spl/Kconfig and common/spl/Kconfig.tpl
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I would vastly reduce the contents within those=
 'if' blocks, but there
> > > > > > > > > > > > > > are still options that are xPL-centric without =
a PPL counterpart, such
> > > > > > > > > > > > > > as SPL_ATF (I suspect, but if not I'm sure othe=
rs).
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > But just the level of thought required in you=
r small example above
> > > > > > > > > > > > > > > suggests it is a large effort.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Yes, restructuring our Kconfig logic and then r=
emoving our xPL logic is
> > > > > > > > > > > > > > some work. So was, I suspect, all of what you d=
id already.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > 4. My scheme splits the config into separ=
ate files. Yours makes the
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > I don't see yours as splitting the configs =
in to separate files, I see
> > > > > > > > > > > > > > > > it as generating some intermediate objects.=
 The configs don't change and
> > > > > > > > > > > > > > > > that's one of our problem areas.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > So you mean a big problem area is the current=
 Kconfig?
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I mean it's a problem for users a board develop=
ers to make valid
> > > > > > > > > > > > > > configurations and update them as needed. Files=
ystems are in the
> > > > > > > > > > > > > > filesystem menu, unless they're SPL and then it=
's all under the big SPL
> > > > > > > > > > > > > > menu.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Mind generates
> > > > > > > > > > > > > > > out to an include/generated/autoconf_xxx for =
each phase. Yes they are
> > > > > > > > > > > > > > > intermediate files and auto-generated, but ea=
ch 100% controls its
> > > > > > > > > > > > > > > phase, so there is no confusion and CONFIG_IS=
_ENABLED() / odd Makefile
> > > > > > > > > > > > > > > rules anymore.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Yes, removing CONFIG_IS_ENABLED and $(PHASE_)/$=
(XPL_) from Makefiles is
> > > > > > > > > > > > > > good. But the intermediate files aren't going t=
o help (nor hurt) any of
> > > > > > > > > > > > > > the problems themselves. If you're reading thos=
e to figure out a
> > > > > > > > > > > > > > problem, it's like when you're reading a .i fil=
e to figure out a
> > > > > > > > > > > > > > problem, it means you're already in a complex t=
roublesome spot.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > But I don't know that CONFIG_SPL_FS_FAT=3Dy mea=
ns that CONFIG_FS_FAT=3Dy for
> > > > > > > > > > > > > > SPL builds leads to "no confusion". But I do th=
ink that CONFIG_SPL=3Dy and
> > > > > > > > > > > > > > CONFIG_FS_FAT=3Dy does.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > split earlier, at the Kconfig level. So i=
t seems that we could go with
> > > > > > > > > > > > > > > > > my scheme to get us to a split config, th=
en, after that, decide
> > > > > > > > > > > > > > > > > whether to move that split earlier to Kco=
nfig itself. The choices
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > I don't think so. Yours makes things compli=
cated by making the build do
> > > > > > > > > > > > > > > > even more (and from the RFC, the implementa=
tion tooling diverges from
> > > > > > > > > > > > > > > > upstream).
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Yes it makes the kconf tool generate those se=
parate files for each phase [3]
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Mine makes things differently complicated b=
y doing less for
> > > > > > > > > > > > > > > > most things, but needing some thought on ho=
w to know that say
> > > > > > > > > > > > > > > > chromebook_bob needs chromebook_bob_tpl_def=
config,
> > > > > > > > > > > > > > > > chromebook_bob_spl_defconfig and chromebook=
_bob_ppl_defconfig to be
> > > > > > > > > > > > > > > > built, before asking binman to go put thing=
s together.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Yours seems feasible in a fully Binman world,=
 but given the difficulty
> > > > > > > > > > > > > > > we (or I) have completing a migration, I hone=
stly don't believe this
> > > > > > > > > > > > > > > is feasible in today's U-Boot. The other prob=
lem is that it all has to
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I'm not 100% sure it's everything needs binman =
actually. Or even if we
> > > > > > > > > > > > > > do take this as a reason to push for more binma=
n, it's just some trivial
> > > > > > > > > > > > > > types already handled in the Makefile that's mi=
ssing.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > be done at once. We need to rewrite the Kconf=
ig and flip over the
> > > > > > > > > > > > > > > board. Will we carry people with us? That is =
a huge risk to the
> > > > > > > > > > > > > > > project IMO.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I'm not sure, actually, that it couldn't be don=
e in stages. We might
> > > > > > > > > > > > > > need a little bit of fakery around being able t=
o just build SPL without
> > > > > > > > > > > > > > PPL in the interim.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Anyway, yes my schema makes the build do even=
 more (with 400 lines of
> > > > > > > > > > > > > > > kconf additions and a patch that can likely b=
e upstreamed). But
> > > > > > > > > > > > > > > otherwise, it is a one-off improvement, witho=
ut any changes to the
> > > > > > > > > > > > > > > existing Kconfig.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I thought Yamada-san rejected changes going in =
this direction before?
> > > > > > > > > > > > > > But either way, no it's not likely the final ov=
erburden in terms of
> > > > > > > > > > > > > > divergence.
> > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > Yes. Masahiro will make his own decisions and I a=
m confident he will
> > > > > > > > > > > > > reject any future changes I send
> > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > So my point is that we could go with the firs=
t part of my scheme to
> > > > > > > > > > > > > > > resolve the 'medium' problems then decide whi=
ch way to continue after
> > > > > > > > > > > > > > > that. From your side you won't have lost anyt=
hing towards where you
> > > > > > > > > > > > > > > want to head. The two options would then be:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > - exhance kconfig language to build in the no=
tion of phases
> > > > > > > > > > > > > > > - split the defconfigs for each board, redo t=
he Kconfig rules and
> > > > > > > > > > > > > > > teach the build to combine images
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > If things go down your proposed path instead, n=
o, I don't see that as
> > > > > > > > > > > > > > making it meaningfully easier to go the way I p=
roposed later. The only
> > > > > > > > > > > > > > commonality is dropping $(PHASE_)/$(XPL_)/etc a=
nd CONFIG_IS_ENABLED ->
> > > > > > > > > > > > > > IS_ENABLED. And (almost) all of that is a scrip=
t'able change.
> > > > > > > > > > > > >
> > > > > > > > > > > > > To be frank, the difference is that I have actual=
ly put in the work to
> > > > > > > > > > > > > try this. It is more than 50 and perhaps as many =
as 100 patches. Quite
> > > > > > > > > > > > > difficult work. Honestly, compared to that, the l=
ogic changes are not
> > > > > > > > > > > > > that large.
> > > > > > > > > > > > >
> > > > > > > > > > > > > That is why I believe this work is a prerequisite=
 for both schemes
> > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > would then be to use your scheme (Kconfig=
 refactoring, splitting
> > > > > > > > > > > > > > > > > defconfigs and some rework), or to do my =
scheme (which would require
> > > > > > > > > > > > > > > > > enhancing the Kconfig language a bit just=
 for U-Boot and some optional
> > > > > > > > > > > > > > > > > rework over time). Both schemes would nee=
d a small amount of
> > > > > > > > > > > > > > > > > build-logic changes, but I'm not sure yet=
 what that would look like.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Does that sound right?
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > With what I said above, yes I think we're c=
loser at least to
> > > > > > > > > > > > > > > > understanding each other.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Yes.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Well, with that, what now?
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > What makes the current situation untenable is V=
PL. And I gather I
> > > > > > > > > > > > > > haven't convinced you to put that on hold long =
enough to instead rework
> > > > > > > > > > > > > > how we build things, have I?
> > > > > > > > > > > > >
> > > > > > > > > > > > > Which VPL thing?
> > > > > > > > > > > >
> > > > > > > > > > > > That it exists. When it was just SPL, it's manageab=
le. With TPL, well,
> > > > > > > > > > > > it was supposed to be tiny and so just a few more t=
hings. And with VPL,
> > > > > > > > > > > > that makes 4. It's too much. Something needs to be =
done. Four times is
> > > > > > > > > > > > too many. If solving Marek's desire for PSCI-from-U=
-Boot means we need
> > > > > > > > > > > > number 5 that becomes even worse (and I also suspec=
t that's a case of
> > > > > > > > > > > > one build covers the SoC or family of SoCs dependin=
g on hardware
> > > > > > > > > > > > changes).
> > > > > > > > > > >
> > > > > > > > > > > Yes, that's why I took on this effort a few years bac=
k.
> > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > > You have convinced me that you have a solution. I=
t makes a lot more
> > > > > > > > > > > > > sense to me than previously and it may be that it=
 is better in the
> > > > > > > > > > > > > end. For example, with VBE it I would make a lot =
of sense to build 20
> > > > > > > > > > > > > boards as just TPL and use a generic rock chip bo=
ard for everything
> > > > > > > > > > > > > else. That would be a lot tidier with your scheme=
=2E It is very hard to
> > > > > > > > > > > > > predict the future and VBE is still not finished,=
 some two years in.
> > > > > > > > > > > > >
> > > > > > > > > > > > > I don't want to be tied to your scheme today thou=
gh.
> > > > > > > > > > > > >
> > > > > > > > > > > > > So if you can accept my going ahead with 1-4 and =
helping me with that,
> > > > > > > > > > > > > then we can stop and discuss which way to go, per=
haps by prototyping
> > > > > > > > > > > > > the two options?
> > > > > > > > > > > >
> > > > > > > > > > > > I want to start by saying I do appreciate you put i=
n a lot of work in
> > > > > > > > > > > > this direction already, and I do see some of the en=
d goals it achieves
> > > > > > > > > > > > as being important, and I'm glad you see my idea ha=
s some good parts
> > > > > > > > > > > > too.
> > > > > > > > > > > >
> > > > > > > > > > > > I want to figure out how to move forward on this pr=
oblem. My other part
> > > > > > > > > > > > of this thread, this morning, was also part of me l=
ooking harder, again,
> > > > > > > > > > > > at the RFC series you posted before. And that's whe=
re I still have large
> > > > > > > > > > > > reservations. There are *so* *many* symbols we need=
 to now have 4
> > > > > > > > > > > > variants of, instead of 1 variant of. Take:
> > > > > > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/20=
230212231638.1134219-58-sjg@chromium.org/
> > > > > > > > > > > > for example. It adds SPL_PARTITION_TYPE_GUID but we=
 include <part.h> in
> > > > > > > > > > > > files built in TPL (and likely VPL) so aren't we go=
ing to need that
> > > > > > > > > > > > every time? And with a quick size-check on pinebook=
-pro-rk3399 it looks
> > > > > > > > > > > > like it's not working as intended either? I checked=
 and part_get_info
> > > > > > > > > > > > shrinks because CONFIG_PARTITION_TYPE_GUID is not s=
et, or rather:
> > > > > > > > > > > > #ifdef CONFIG_PARTITION_TYPE_GUID
> > > > > > > > > > > >                 info->type_guid[0] =3D 0;
> > > > > > > > > > > > #endif
> > > > > > > > > >
> > > > > > > > > > Oh, I get it now. Previously CONFIG_PARTITION_TYPE_GUID=
=3Dy but now
> > > > > > > > > > CONFIG_SPL_PARTITION_TYPE_GUID=3Dn and while I'm not su=
re that's a good
> > > > > > > > > > thing I see what happened. And now I see my problem fro=
m yesterday
> > > > > > > > > > morning was similar but different.
> > > > > > > > > >
> > > > > > > > > > > > is not true and checked. And I can't see why. And t=
here's other size
> > > > > > > > > > > > reductions (this time in tpl) on pinebook-pro-rk339=
9 that I didn't dig
> > > > > > > > > > > > in to more, but wasn't that symbol:
> > > > > > > > > > > >                tpl-u-boot-tpl: add: 0/-4, grow: 0/0=
 bytes: 0/-344 (-344)
> > > > > > > > > > > >                  function                          =
         old     new   delta
> > > > > > > > > > > >                  dev_get_uclass_plat               =
          12       -     -12
> > > > > > > > > > > >                  simple_bus_post_bind              =
          92       -     -92
> > > > > > > > > > > >                  _u_boot_list_2_uclass_driver_2_sim=
ple_bus     120       -    -120
> > > > > > > > > > > >                  _u_boot_list_2_driver_2_simple_bus=
         120       -    -120
> > > > > > > > > > > >
> > > > > > > > > > > > And I'm not bringing this up to badger you about bu=
gs in an RFC series
> > > > > > > > > > > > (it's RFC, there's bugs) but rather because I think=
 it highlights some
> > > > > > > > > > > > core issues with the approach as implemented.
> > > > > > > > > > >
> > > > > > > > > > > But surely you can see that both schemes have exactly=
 the same issues?
> > > > > > > > > > >
> > > > > > > > > > > My point is that the work to tidy up things and then =
get to a 'clean'
> > > > > > > > > > > source tree and Makefiles is the hard bit here and ha=
s to be done with
> > > > > > > > > > > both schemes.
> > > > > > > > > > >
> > > > > > > > > > > Just let me know which way you want to go. I don't ha=
ve anything ready
> > > > > > > > > > > to send, but I could probably drag it over the line b=
efore too long,
> > > > > > > > > > > if you are keen.
> > > > > > > > > >
> > > > > > > > > > Once I figured out what was the cause of the problems I=
 saw in the RFC,
> > > > > > > > > > I had to rewrite this a few times. Your approach needs =
even more symbols
> > > > > > > > > > added than were in the RFC, and the newly added symbols=
 need further
> > > > > > > > > > auditing to make sure we have the same behavior as toda=
y at least by
> > > > > > > > > > default.
> > > > > > > > >
> > > > > > > > > This is the idea that we need to clean up a, b and c. You=
r scheme is
> > > > > > > > > the same in this respect. If we have CONFIG_FOO today, th=
en your
> > > > > > > > > scheme may need that duplicated to each defconfig file. E=
ither you
> > > > > > > > > resolve the ambiguity or don't. But if you do, then you h=
ave to add
> > > > > > > > > symbols, with both schemes.
> > > > > > > >
> > > > > > > > There is minimal pain in saying a defconfig needs to list C=
ONFIG_FOO
> > > > > > > > there is pain in saying that we need to list
> > > > > > > > config PARTITION_TYPE_GUID
> > > > > > > > ...
> > > > > > > > config SPL_PARTITION_TYPE_GUID
> > > > > > > > ...
> > > > > > > > config TPL_PARTITION_TYPE_GUID
> > > > > > > > ...
> > > > > > > > config VPL_PARTITION_TYPE_GUID
> > > > > > > > ...
> > > > > > > >
> > > > > > > > In what I'm saying it's not generally an issue because:
> > > > > > > > $ git grep -l PARTITION_TYPE_GUID configs | wc -l
> > > > > > > > 21
> > > > > > > >
> > > > > > > > And we don't have to do additional upkeep on having N symbo=
ls.
> > > > > > >
> > > > > > > Well we only need to add those extra symbols if 1) we want th=
at
> > > > > > > feature in a particular xPL, *and* 2) we don't want it everyw=
here.
> > > > > >
> > > > > > Yes, and the problem is adding more of them. Again, we would ne=
ed to
> > > > > > duplicate drivers/usb/gadget/Kconfig with your scheme.
> > > > > >
> > > > > > > There is nothing in my scheme which requires us to add option=
s that
> > > > > > > don't currently exist...but there is a problem if some code u=
ses
> > > > > > > CONFIG_IS_ENABLED(FOO) today and some code uses IS_ENABLED(FO=
O). My
> > > > > >
> > > > > > That's good because that wasn't (how it seemed?) previously.
> > > > > >
> > > > > > > conf_nospl file helps with that and avoids changing Kconfig. =
But
> > > > > > > again, if we are using both, then who knows what it means tod=
ay, and
> > > > > > > I'd like to clean it up.
> > > > > >
> > > > > > What we have today, with respect to CONFIG_IS_ENABLED(...) /
> > > > > > IS_ENABLED(...) is clearer than IS_ENABLED(CONFIG_FOO) that is =
really
> > > > > > checking for CONFIG_SPL_FOO or CONFIG_VPL_FOO if it's in SPL or=
 VPL.
> > > > > > It's easy to get *wrong* yes, but it's also clear. You're check=
ing for
> > > > > > what it says.
> > > > > >
> > > > > > > > > > On the one hand, this is at least a well defined techni=
cal
> > > > > > > > > > problem and if you do the language extension *first* th=
e code changes
> > > > > > > > > > aren't so bad.
> > > > > > > > >
> > > > > > > > > There are no significant Kconfig changes in my scheme, ot=
her than the
> > > > > > > > > conf_nospl file. The language extension is quite separate.
> > > > > > > >
> > > > > > > > $ git diff pre-RFC-migrate-to-split-config..RFC-migrate-to-=
split-config
> > > > > > > > \
> > > > > > > >         | filterdiff -i "a/*/Kconfig" | diffstat -p1 | tail=
 -n 1
> > > > > > > >  25 files changed, 316 insertions(+), 3 deletions(-)
> > > > > > > >
> > > > > > > > And that is largely duplication of existing symbols. And ag=
ain, it
> > > > > > > > wasn't enough duplication.
> > > > > > >
> > > > > > > I wonder if that is stuff that was already applied? Here is w=
hat I have today.
> > > > > > >
> > > > > > > $ glo ci/master..splg4  | filterdiff -i "a/*/Kconfig" | diffs=
tat -p1 | tail -n 1
> > > > > > >  0 files changed
> > > > > > >
> > > > > > > You can use the u-boot-dm/splg-working tree to see the origin=
al
> > > > > > > version. From memory, the splc tree is very old and was mostl=
y applied
> > > > > > > or dropped.
> > > > > >
> > > > > > The splc-working tree is the RFC you pointed at earlier and so =
yes, what
> > > > > > I was comparing with. If you were able to drop some of the prob=
lems,
> > > > > > that's good.
> > > > > >
> > > > > > > > > > But for the user running menuconfig / etc? That's not
> > > > > > > > > > going to be pretty. And we still won't have fixed the p=
roblems like "why
> > > > > > > > > > is TPL even trying to build DWC3?" without reworking mo=
re symbols.
> > > > > > > > > >
> > > > > > > > > > So I don't think this is the right approach as it doesn=
't reduce
> > > > > > > > > > confusion and may increase it (why do I need to set
> > > > > > > > > > CONFIG_SPL_PARTITION_TYPE_GUID when the code checks for
> > > > > > > > > > CONFIG_PARTITION_TYPE_GUID?
> > > > > > > > >
> > > > > > > > > Because it is an SPL build...I actually think that makes =
a lot of
> > > > > > > > > sense. You just need to understand that CONFIG_SPL_ means=
 the SPL
> > > > > > > > > build, which in fact is what we have been using for years.
> > > > > > > >
> > > > > > > > And it's no longer clear in the code, is the problem.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > But why is CONFIG_SPL_FRAMEWORK still there?
> > > > > > > > >
> > > > > > > > > Not relevant to the discussion, IMO.
> > > > > > > >
> > > > > > > > It's an example symbol. Why does the code have:
> > > > > > > >
> > > > > > > > #ifdef CONFIG_PARTITION_TYPE_GUID
> > > > > > > > ...
> > > > > > > > #endif
> > > > > > > >
> > > > > > > > And that's true for SPL builds. But the code also still has:
> > > > > > > > #ifdef CONFIG_SPL_FRAMEWORK
> > > > > > > > ...
> > > > > > > > #endif
> > > > > > > >
> > > > > > > > Which is only true for CONFIG_SPL_FRAMEWORK being set.
> > > > > > >
> > > > > > > OK I think I understand your question. The tools work by iden=
tifying
> > > > > > > options which are in PPL and may or not be in other builds. T=
here is
> > > > > > > no CONFIG_FRAMEWORK so all of this migration doesn't apply.
> > > > > >
> > > > > > No, you entirely misunderstand me. I am not talking about the t=
ool. I am
> > > > > > talking about the developer.
> > > > > >
> > > > > > > If there were a CONFIG_IS_ENABLED(FRAMEWORK) or a CONFIG_FRAM=
EWORK
> > > > > > > then the discussion would be different.
> > > > > > >
> > > > > > > BTW, I wonder if we could drop that symbol, or switch it arou=
nd so
> > > > > > > that boards which don't use it have to set CONFIG_SPL_STRANGE=
 or
> > > > > > > similar.
> > > > > >
> > > > > > Touching the PowerPC TPL/SPL stuff is very low on the priority =
list. If
> > > > > > you want to file an issue for it, please do. But that (roughly)=
 is why
> > > > > > there's SPL_FRAMEWORK.
> > > > > >
> > > > > > > > > > Oh..). The main thing it does is drop $(PHASE_) and I h=
onestly think
> > > > > > > > > > that's more confusing. We still have one build where we=
 need to do or
> > > > > > > > > > not do different things for FOO && PPL, FOO && SPL, etc=
 but the code
> > > > > > > > > > just references CONFIG_FOO but doesn't always mean CONF=
IG_FOO=3Dy/n in the
> > > > > > > > > > .config / defconfig.
> > > > > > > > >
> > > > > > > > > Yes, that's the conf_nospl file which I have dealt with.
> > > > > > > >
> > > > > > > > OK? My point is that the code is now more confusing, not le=
ss confusing.
> > > > > > > > Because the code says CONFIG_PARTITION_TYPE_GUID. Not
> > > > > > > > CONFIG_SPL_PARTITION_TYPE_GUID. And not IS_ENABLED(PARTITIO=
N_TYPE_GUID)
> > > > > > > > which is at least a hint that one needs to look harder, and=
 oh,
> > > > > > > > CONFIG_SPL_PARTITION_TYPE_GUID maybe matches somehow.
> > > > > > >
> > > > > > > If you are saying that it is better to have CONFIG_IS_ENABLED=
(FOO),
> > > > > > > IS_ENABLED(CONFIG_FOO), obj-$(CONFIG_$(PHASE_)FOO) etc., then=
 I don't
> > > > > > > agree, sorry. That is problems a-c in my original proposal an=
d my
> > > > > > > understanding is that both our approaches resolve this proble=
m.
> > > > > > >
> > > > > > > Otherwise, you've just lost me and we should probably give up=
 on this point.
> > > > > >
> > > > > > Yes, I am saying that what we have today is less confusing than=
 what you
> > > > > > are proposing. Because with your proposal:
> > > > > >
> > > > > > obj-$(CONFIG_FS_FAT) +=3D fat/
> > > > > >
> > > > > > Can refer to CONFIG_SPL_FS_FAT, CONFIG_FS_FAT or CONFIG_VPL_FS_=
FAT. That
> > > > > > is not good for humans.
> > > > >
> > > > > Let's just stop on this point. We seem to be going backwards. Now=
 you
> > > > > are saying that you *want* to keep:
> > > > >
> > > > > a. The $(PHASE_) stuff in Makefiles
> > > > > b. The CONFIG_xxx / CONFIG_IS_ENABLED(xxx) split
> > > > >
> > > > > and you believe that
> > > > >
> > > > > c. the ambiguity I mentioned with CONFIG_FOO
> > > > >
> > > > > are all actually a good thing?
> > > >
> > > > No. I'm saying that what we have today is LESS confusing than your
> > > > proposal in splc-working. I can't evaluate splg-working because it
> > > > doesn't work enough to be clear if it does or doesn't still solve a=
ll
> > > > the problems that splc-working does. Various things don't build any=
more
> > > > in splg-working and T2080RDB_NAND as a first example (as the powerpc
> > > > part of the world build failed first) has massive size changes.
> > > >
> > > > I do not like splc-working, but splc-working is a few bugs away fro=
m 1:1
> > > > functional binaries from before your changes.
> > > >
> > > > I do not like what we have today because it's tricky to get things
> > > > right. But the macros are visible in the code / Makefiles so humans
> > > > still find things.
> > >
> > > OK, well I am still lost, sorry.
> >
> > OK, in splc-working what is untenable to me is that the following line
> > in a Makefile:
> > obj-$(CONFIG_FS_FAT) +=3D fat/
> >
> > Is unclear if it refers to PPL or some xPL. This is worse for humans
> > than what we have today.
>=20
> We're really heading in completely different directions then.
>=20
> At the moment, if we have:
>=20
> obj-$(CONFIG_FOO) +=3D foo/
>=20
> we know this is used in all builds. If we have:
>=20
> obj-$(CONFIG_$(PHASE_)FOO) +=3D foo/
>=20
> then we have to look at Kconfig to figure that out.
>=20
> My change makes it entirely dependent on Kconfig, in both cases.
>=20
> For source code, we can have both CONFIG_FOO and
> CONFIG_IS_ENABLED(FOO), so again Kconfig does not control things. It
> is merely a hint.
>=20
> To my mind, $(PHASE_) and CONFIG_IS_ENABLED() are hacks, to work
> around the unified config, which I want to split.

This is why we need a TSC. I think $(PHASE_) and CONFIG_IS_ENABLED() are
better than having to remember that CONFIG_SPL_FOO is no longer a
meaningful value (CONFIG_SPL_FS_FAT), except when it is a meaningful
value (CONFIG_SPL_TEXT_BASE). You disagree. We've both presented our
technical reasoning and neither of us seems swayed to go another
direction instead. You are also unwilling to accept my No as the head of
the project.

> > > We are trying to discuss a change to how CONFIG options are handled in
> > > the source tree. It sounds like you are saying that you cannot review
> > > it until it fully works. But you already did that two years ago and
> >
> > I cannot comment on what's in splg-working, which is also about two
> > years old, because while it has the same problem I object to above with
> > splc-working, it looks like you just dropped adding Kconfig symbols from
> > splc-working and showing that well actually some number of those symbols
> > were needed afterall.
>=20
> That could well be true.
>=20
> >
> > > rejected it. So I don't see any way forward here. Do you?
> >
> > Well, I'm once again back to wondering if you ever plan to stop having
> > your own downstream fork and so how much effort I should even put in
> > again.
>=20
> My plan is to run it for a year and then review it.  The more effort
> we put in, the less the delta, which is why I am sending patches out
> and responding to feedback.

So you want to run a downstream fork for a year, and then what? How can
I get you to stop? Or convince you to just hard fork and give the domain
to the project? As I do not see how this gets better in a year unless
you expect your tree to just become mainline.

--=20
Tom

--cNstQPGVeo+iLV4i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmezXMQACgkQFHw5/5Y0
tywPZgwAgYHbB5tb2fvgEGRtwZ22ZpV4XvFOErMfJ2nbWH2GwrqSF5f+S/Q3y+0/
0cRcHW1O16ZhUvpM9NMv/7rIK0YkVSBn56O+s6RCEEz+7XXXx3sjBKmnN8pIG3m6
Dj1u3OGq1jBKG/kM85Cm2MasqAcGxpcmpMW5Wz+7Jj6GrAjGe3vepJzmsfzUjrHO
THCW61yBHeyRCBgnVN+zki26Y2ayiTUHNRjJ++7MYeNEhnR4XZby4bxdIysqDgUo
yILki5jnVUw4PPGG6U9TUqAge7x++5aKcEfnw1iLOESOlyaFrfsHqEZbF0EgybKZ
oOs7i8qw0FFG2XRWR65hQByXMHGHwe2wTF/hv8Uc2hXBzs4Dtrcp3roCdMp3b7Dw
FwRHBE0vsdRA13YgfnQO78OeFJND73zhfT9hRq4MoWsoG4atfdB29dViV5jpPJgV
qj63bzxDvJcVb3AptRo3aJp3STNygOqlKL3fC0tTBkTmyukRMV3Esu5lD/SW8IBH
HMpLhldv
=OL91
-----END PGP SIGNATURE-----

--cNstQPGVeo+iLV4i--
