Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8832C83F33
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 19:55:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAC07864EA;
	Mon,  4 Sep 2023 21:55:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SQidj9iT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DB9586886; Mon,  4 Sep 2023 21:55:25 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 590C2864E8
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 21:55:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5922b96c5fcso16997587b3.0
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 12:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693857321; x=1694462121; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zwwagpE/jlDK+2aSCIKavz+ZutPtv7kdztXlFzkb71A=;
 b=SQidj9iTF+t4otgd9upuXro3Ym/yKQ02YuePY4Ign9nLRJ37Vxjf1WEE6uRne+2Keg
 2eXbTyH0zGwfL9j4lbF/kKK1VHL5BPZ3bVVZ99dQC9SIl/rFps0N+XIzsCG5OMAYYRmd
 7ufuFvSo6ClopZVVyM3mqZKHYLc/+3Yk+YB1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693857321; x=1694462121;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zwwagpE/jlDK+2aSCIKavz+ZutPtv7kdztXlFzkb71A=;
 b=K3syuGKV8D/C/2dpBqoYjjTcskQ2vkxtASC3U8uu/Mr/cASQA1OcO3EnlqpfXmS1KR
 pGiSFgxKNM2+MQWf+05ntEgmHMGz5yX/XglPfWR9dyU/+TC4y0sANqdr7MhlNvuB1aSv
 aKWU+HY45f+FpYPz8nKGxMvoB2FrcRCc074etYwIioXgeS0QIYO2e4Q3c9dbnQu4iT17
 yUsTG3b/dzzEyhbx/8GFseQEiRHhWa6ZSm6Rl5Nlc9XXPJdQI4zXUEghEy+jfjsd9RY0
 4OabWwoqGmEx7XJPvmAFNu144YyGWyJa/zdxuki3zoW+d2GN038AtRVyQcVyd+GZxV86
 aXyw==
X-Gm-Message-State: AOJu0Yx7MpUvlDGSCpy/NyNrzPXMGJ/3wCCdu9WY+0+qcbiPv62XW4zQ
 JM+W5/QWizyW7mQ/JmihHlJ3nA==
X-Google-Smtp-Source: AGHT+IFtlrwexRvGa+DqORWTIxxU/YSgfJxZWdyVJus1uIBmihZ9J3ertB6uf9A4S2O1NqGkoh+mcw==
X-Received: by 2002:a81:9110:0:b0:579:16e0:b1bf with SMTP id
 i16-20020a819110000000b0057916e0b1bfmr11745584ywg.12.1693857321011; 
 Mon, 04 Sep 2023 12:55:21 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-977e-7fa5-b64a-ed15.res6.spectrum.com.
 [2603:6081:7b00:6400:977e:7fa5:b64a:ed15])
 by smtp.gmail.com with ESMTPSA id
 b6-20020a0dc006000000b0058fc7604f45sm2805134ywd.130.2023.09.04.12.55.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 12:55:20 -0700 (PDT)
Date: Mon, 4 Sep 2023 15:55:18 -0400
From: Tom Rini <trini@konsulko.com>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 32/32] pci: serial: Support reading PCI-register size
 with base
Message-ID: <20230904195518.GG3101304@bill-the-cat>
References: <20230830191036.hecw3vyabdsczxrb@pali>
 <20230830194157.GF3101304@bill-the-cat>
 <20230830194409.a7acogmn54gajmk6@pali>
 <20230830205145.t75fkjhnc7kjux3z@pali>
 <20230830210842.GG3101304@bill-the-cat>
 <20230830211316.5ywrzq6gmxzvdl4o@pali>
 <20230830212620.GH3101304@bill-the-cat>
 <20230830212934.tl2bnmmls2ajdj46@pali>
 <20230830214201.GM3101304@bill-the-cat>
 <20230903203615.ncyjug2prctiufk2@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QzvL0qGjcgLaHJrj"
Content-Disposition: inline
In-Reply-To: <20230903203615.ncyjug2prctiufk2@pali>
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


--QzvL0qGjcgLaHJrj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 03, 2023 at 10:36:15PM +0200, Pali Roh=E1r wrote:
> You are not saying truth here, you are lying and you know it. mvebu
> changes? ignored, no answer. ppc changes? ignored no answer in 10
> months. mmc changes, no answer at all. rx-51 bug reports and regression
> which you and your people broke? you wrote me: fuck you and fix it
> yourself. So what does compromise means for you? Just "Pali has to do
> anything". So yes, I'm refusing to do all this dirty jobs for you. This
> is not any compromise, maybe just in your head or your language.
> Compromise is something like, you will fix regression what you and your
> people caused and I then I will look at some of the pending patches for
> which I'm listed as reviewer. Helping do debug? Nobody helped me with
> anything. Do you still you think that I'm such idiot who is going to
> review more and more of your code and you continue ignoring me?? No.

No, I'm still speaking the truth. Your MMC changes broke other
platforms, and you didn't respin the whole patch, you just posted
another patch instead despite me asking you to respin things to include
it.  What I summarized there is exactly what happened with the powerpc
changes, and a similar but shorter timeline for the rx-51 report that
you still refuse to further debug after being repeatedly told that no
one else can reproduce the problem anywhere else.

And Simon contacted you on this thread because you're the listed
maintainer of one of the files changed here.

>=20
> On Wednesday 30 August 2023 17:42:01 Tom Rini wrote:
> > On Wed, Aug 30, 2023 at 11:29:34PM +0200, Pali Roh=E1r wrote:
> >=20
> > > There were no answers.
> > >=20
> > > On Wednesday 30 August 2023 17:26:20 Tom Rini wrote:
> > > > I'm trimming the CC list. All of those points you list were address=
ed
> > > > and answered in your last long running argument. You need to decide=
 what
> > > > is best for you moving forward and I would ask that it not involve
> > > > complaining that you're being asked to review code that you're a li=
sted
> > > > maintainer of.
> > > >=20
> > > > On Wed, Aug 30, 2023 at 11:13:16PM +0200, Pali Roh=E1r wrote:
> > > > > Seems that you completely miss the point of the argument, then th=
e only
> > > > > option for such people is to repeat them. Or have I repeat you ag=
ain
> > > > > that you have not answered the first question, why you are asking=
 for
> > > > > review from somebody who you are ignoring and not taking into acc=
ount?
> > > > > You do not want to answer this question, right? So you rather cha=
nge a
> > > > > topic and talking about something totally different.
> > > > >=20
> > > > > On Wednesday 30 August 2023 17:08:42 Tom Rini wrote:
> > > > > > I don't think it's worth re-hashing the same arguments over and=
 over.
> > > > > > There is no "my persons", there is the public community.  If yo=
u no
> > > > > > longer wish to participate, I can remove you from the maintaine=
rs
> > > > > > entries you're listed in.  But please stop with the long argume=
nts
> > > > > > unrelated to the patches at hand when there's a dozen people an=
d other
> > > > > > lists on CC.
> > > > > >=20
> > > > > > On Wed, Aug 30, 2023 at 10:51:45PM +0200, Pali Roh=E1r wrote:
> > > > > > > So lets recap what you and your persons have done in last 6 m=
onths:
> > > > > > >=20
> > > > > > > * Ignored my changes
> > > > > > > * Ignored my reviews
> > > > > > > * Ignored my reminders
> >=20
> > Not ignored, changes requested and refused.  Compromises refused.
> > Apologies from others who had said they would pick up the platform and
> > push it, but did not have time ignored.
> >=20
> > > > > > > * Ignored my regression reports
> >=20
> > Not ignored, debugged, problems with your platform implementation
> > reported and questions asked, patches provided to help you debug the
> > problem on the single place that seems to show a problem which no one
> > else can reproduce ignored.
> >=20
> > --=20
> > Tom
>=20
>=20

--=20
Tom

--QzvL0qGjcgLaHJrj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT2NiIACgkQFHw5/5Y0
tywgSwwAs7R1x+ZKlDEzUp0BSBLR5j7ulnFeMK3uhSS6QTnsHDcmy7LgfzrI9/a7
4hG2QSye0ezwRC3sH4LTIhwM/TEdOA9Y6V40EihcCh/HfGO1sAG5+I6jYh7q9zSu
MrDFm1yiDstx9BvTYAUah8cFhA16oIM2zpWRQNRK7NjcPpoY2SHFguDr36UfNm/D
bOAhc+P+VtXd18s54gzuwRkqtWCNwfxAsOlkEizjmvSrLi6FfETrEPnQcmpVkYy1
31y7qgwfp+JMiDoiRSvWW9Z/T7kPQhACBz/npZYYmy1qV9BZb3juT9UdVQYsKA/G
L+EPSpUtdiBeITVnXAnNyrjoV03TnPIQpcd8IOXXTZIYXcyThzlw6VrcnoAt7sDe
u08nO2NZlTVID9XteplR+T4JtLMfH4sV1w1/Ixlf4m/AEa6aHWxlWAyRv+W2ZME+
yN6sdwL28MpHvwYT167mlorvW0awlRe7WRqmxZ9H6K7J6e01mFR+9mrTyT1lfkHF
IyjiUxrg
=lLxT
-----END PGP SIGNATURE-----

--QzvL0qGjcgLaHJrj--
