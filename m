Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B67CD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 15:02:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D492C846FA;
	Fri, 15 May 2026 17:02:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bLEaa+n4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2F0084706; Fri, 15 May 2026 17:02:35 +0200 (CEST)
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A260846CC
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 17:02:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x241.google.com with SMTP id
 5614622812f47-47cbd445021so5947134b6e.1
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 08:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778857352; x=1779462152; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kU9LbzXsbKQQRC22RUNRvyEldvbF7UJEibLi759fbyw=;
 b=bLEaa+n4V1wEwuAy+pCbq1jHFmT/liRM/Oq6B9VKQoq8PHdt5NI2U4clgRhdVw0FNN
 yHSz5Z4eebpaGNX2IRvZ6RiSqae6NL3qsqIfKuBKNvaX6cXDuDgDQRxfFivnIWaC3UdB
 q42XM/3J6oSxYC54NpUYHEc9fFYhsx+hbUqi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778857352; x=1779462152;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kU9LbzXsbKQQRC22RUNRvyEldvbF7UJEibLi759fbyw=;
 b=JilJROwa+EdX7j532NOq4CDh+1q/XsWcAad5TEc3rpvCYIpm9CdBSiDypYPMBMJ+IV
 5U7hDCX0+qrfwWda8cs+5okb9g0isYenqiea9q5BsJgwj/K6aNXSRNS35nSFucPRDMTD
 jE6YagB6GHJK+vsKFVTEIXK+yPpmGTSpfNq9zfQFGYRkJBxNnvQWi3zbrpMpXGW3fGRi
 RBovXxEAm/G3hK6A+yF7tCRClvL6/Td/r277eQEpUN6JoI5NDe6+YolS7Eb7AtAxKMpR
 Vas/oBUefWSLUI7RfrNC3R0iRaTRKWtpuhZk7XG9tPAoB33GW/68U7WXjJgr/DGtaDZ2
 BuvA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9EnujZjIxMg+9orYOzzoC4FIqU/H4+rU0zf5y3ebjF9SpXoMuw5XyliP1iumD/Hlwbicq94DM=@lists.denx.de
X-Gm-Message-State: AOJu0Yz/QvNr3Vgv3mwG4SUBxpLDE2N6/lCJ8iuZiS+mf/myQod/KbDv
 DhhQodc2/T/8dE/bn/0GBlxZ9qlEwfSOK2VM5r1KFVxYGF1BnU9MYW0pS/tRNa0FRK4=
X-Gm-Gg: Acq92OGy4yWWVp6bb2HkRoOk9Cyrf80KwBaqiLY1r8faqTzjkann4hJd9e6BPTx53Lf
 Ck/oIR/RgqtjGSsai4pBzHvC9KfXbpY0Si3yAEaT2Dxq92+5S726oDhrs3ZP/1JrxOgyBHY9IC1
 LHzEvrNzf1301sYrXLQUTftCOs/x0/Nl9nO95tUzqMlU4aPqe2y0p3Ab62+emBwmhQhjta6I5x4
 LDMZELKHfjBmQRKJKozBq7ViSbC0EPsaZL1W0Io/0Jknw+wssjEaNNIIHRoXpeXguhF6h3W1I2Q
 gqU1eYFldztWsq4BaxvmOLiLM7cjrjK9wP6NMtt5uL4KTwhl2HS/oC8SX+EgzM4VhIIHptzpM6o
 53uPaXVEgtpTyCvPhPH5SW4NDqKFn8eaBcyxTQGCzZmx3Gr6FRuj62G+mJQex/N02dgbs4mXHTW
 sqiGn1i5I6XrJ/Ppnow12aqf/nSBCR6D2yBgL6aVLziLVubNprFit6pgCg6wFN6O+YWlLgKIyVe
 d9TH2yulrA2F83iUDMkQBQg/Z4WY++J3l/s8bs8urgzI4Js3WQ=
X-Received: by 2002:a05:6820:6ac4:b0:67e:294b:7246 with SMTP id
 006d021491bc7-69c942ff872mr2765294eaf.14.1778857351368; 
 Fri, 15 May 2026 08:02:31 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d045e6567sm1029608eaf.3.2026.05.15.08.02.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 08:02:30 -0700 (PDT)
Date: Fri, 15 May 2026 09:02:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Sune Brian <briansune@gmail.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, Conor Dooley <conor@kernel.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: U-Boot patch submit standard and requirement
Message-ID: <20260515150227.GC1858239@bill-the-cat>
References: <CAN7C2SCYCwE=BRoeCedqQYjv-Gf6x6ETOdKeeDBE=CG=-rSk9w@mail.gmail.com>
 <CALeDE9PU0-fW_+erR9QHK1ST8fcStx0FWWk_0M8ELjtADugd7Q@mail.gmail.com>
 <CAN7C2SCATJL_rhpBZWwZuQVpLdnbDh5+DRFbtGHoxCXu62AVmw@mail.gmail.com>
 <CALeDE9PesKLwzt=uu_b8+pq5QXFnnK1YAO9WL3f8=CHx93w61w@mail.gmail.com>
 <CAN7C2SC_YwotE2-PS=eAFEnMOXp7jVrhaOSbKsuChLVr4zEa8A@mail.gmail.com>
 <20260514-spotted-happier-0ccb77ca8f24@spud>
 <CAN7C2SAVWp23mKeG77MoV6kUKQDBN_Ge3CUMa_quAXP5YbV6UA@mail.gmail.com>
 <20260515-finished-womanly-675afb9b0c7c@wendy>
 <CAN7C2SDDjM+MJbx2d0N8zC74bytb6gKvjw_6auMPLLNGJVwvfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="J8bCdK0rvUHjBLrA"
Content-Disposition: inline
In-Reply-To: <CAN7C2SDDjM+MJbx2d0N8zC74bytb6gKvjw_6auMPLLNGJVwvfA@mail.gmail.com>
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


--J8bCdK0rvUHjBLrA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 04:23:49PM +0800, Sune Brian wrote:
> On Fri, May 15, 2026 at 3:46=E2=80=AFPM Conor Dooley <conor.dooley@microc=
hip.com> wrote:
> >
> > On Fri, May 15, 2026 at 08:46:25AM +0800, Sune Brian wrote:
> > > On Fri, May 15, 2026 at 12:14=E2=80=AFAM Conor Dooley <conor@kernel.o=
rg> wrote:
> > > >
> > > > On Thu, May 14, 2026 at 07:46:46PM +0800, Sune Brian wrote:
> > > > > On Thu, May 14, 2026 at 6:37=E2=80=AFPM Peter Robinson <pbrobinso=
n@gmail.com> wrote:
> > > > > >
> > > > > > Hi Brian,
> > > > > >
> > > > > > You have made a very generic statement about levels of accounta=
bility
> > > > > > on patch sets and consistency in reviews.
> > > > > >
> > > > > > Can you be more specific?
> > > > > >
> > > > > > Ultimately there are subsystem maintainers and each maintainer =
has
> > > > > > variation on how they deal with their subsystem. You reference =
one doc
> > > > > > three times in your statement.
> > > > >
> > > > > Hi Peter,
> > > > >
> > > > > Now I understand what you mean.
> > > > > Simply one sentence is a bit hard to read what your thoughts are.
> > > > >
> > > > > That document I am quoting does not refer to the entire docs but =
only one
> > > > > section of the docs with that link.
> > > > >
> > > > > Before quoting, my declarations as follows:
> > > > > 1) I am not referring to specific people or party
> > > > > 2) I experienced reviewer which again not being specific to one t=
hat
> > > > > mentioned this docs is a supreme rules to follow otherwise patch
> > > > > that is committed is not able to push to mainstream
> > > > > 3) I simply do a quick check on u-boot mailing pool and do see a =
lot
> > > > > of uncompiled reviewed patches that are not following that supreme
> > > > > docs.
> > > > >
> > > > > As such I will being to quote:
> > > > >
> > > > > The mailing that are reported as not passing the standard of [1]
> > > > > Full mailing:
> > > > > https://patchwork.ozlabs.org/project/uboot/patch/20260423042824.3=
480-1-briansune@gmail.com/#3684415
> > > >
> > > > patchwork isn't loading for me, but it's on lore here:
> > > > https://lore.kernel.org/all/20260423042824.3480-1-briansune@gmail.c=
om/
> > > >
> > >
> > > Hi Dooley,
> > >
> > > Well I am sure you did not have the full picture.
> > >
> > > The request had nothing to do with under the --- line if this is
> > > really the case:
> >
> > > Let me bring you back to the history of wonders:
> > >
> > > https://patchwork.ozlabs.org/project/uboot/patch/20260421004719.73491=
-1-briansune@gmail.com/#3680232
> > >
> > > https://patchwork.ozlabs.org/project/uboot/patch/20260422065910.5398-=
1-briansune@gmail.com/
> > >
> > > None of those reviewers had mentioned this issue once "---" rather th=
ey all
> > > just alarmingly repeated the wordings.
> >
> > The first mail in the thread mentions it:
> > https://lore.kernel.org/all/CAFLszThg=3DEamyRohxNA7V+nk+OMVK356nUjAVSbu=
4+kokOJpdA@mail.gmail.com/
> >
> > >
> > > > The comment about the changelog format seems to be very harsh, I do=
ubt
> > > > it really makes any difference. What you did and what the maintainer
> > > > requested are effectively the same thing at the end of the day.
> > > >
> > >
> > > Of course after reading the docs I got it immediately.
> > > However did those who request contributors quote this from first plac=
e?
> > >
> > > > The real problem with your patch is that you put the changelog into=
 the
> > > > commit message itself, rather than under the --- line.
> > > > None of the examples you quote below do that.
> > > >
> > >
> > > Well after 4 patches of ridiculous request and logic change.
> > > I guess you will do the same. At least I am not doing it at the
> > > first moment on replying to the mails who or whom you had mentioned.
> >
> > I think this is a reply to the comment below?
> > The aggressive/antagonistic responses begin in your first reply to
> > Simon:
> > https://lore.kernel.org/all/CAN7C2SAdg1MX3ZfEt5-68iiw3pdjyqva48F_uJjNws=
HAhdmY3Q@mail.gmail.com/
> > "So forgive me I really don't give a damn on whatever the header
> > requirements." "There are many better things to do rather than complain=
ing
> > about the patch headers."
>=20
> Hi Dooley,
>=20
> You are a bit off topic here sorry if you don't think this is the case but
> please do finish reading.
>=20
> For what the accused I will give out specific mailing dialogs to explain
> [HERE].
>=20
> The major discussion or query is all about the standards or rules.
> There is nothing to do with the reply.
>=20
> Meantime, I cannot see this as "aggressive/antagonistic responses".
> When the request changes it is ridiculous as you also agree:
> The header text /  wordings from the updated patch itself
> had zero impact on the patch itself.
>=20
> You are just simply telling me that if you get hit by someone 4 times,
> the man who stands out and responds is "aggressive/antagonistic".
>=20
> Again we are NOT discussing any mailing dialogs but the U-Boot
> patch header standards and rules.
>=20
> Meantime you had failed to respond or comment the entire mailing
> dialogs do mention any "---" header requirements nor the
> necessaries of following docs supreme rule / standard from first place.
>=20
> [HERE]
> Allow me to quote the request of header and modifications mail history:
>=20
> No docs cited nor clearly mentioned the need of specific wordings:
> https://patchwork.ozlabs.org/project/uboot/patch/20260420074601.24988-1-b=
riansune@gmail.com/#3680096
>=20
> No docs cited nor clearly mentioned the need of specific wordings:
> https://patchwork.ozlabs.org/project/uboot/patch/20260421004719.73491-1-b=
riansune@gmail.com/#3680232
>=20
> So now you are telling me after at least 2 versions of modifications
> reviewers suddenly think oh this is not good enough (by my rules)
> I think it should be other styles etc.
>=20
> Now "LOOK INTO MY EYES" and tell me what is the actual U-Boot
> header standard? Reviewer mood or docs that are given out?

Brain, I understand being frustrated with the process. Ultimately,
everyone here is a volunteer and trying their best. Which means that
yes, we are not entirely consistent about some parts of the review
process. I would ask you to please be kind to everyone, and expect being
kind in return.

--=20
Tom

--J8bCdK0rvUHjBLrA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagc1gwAKCRAr4qD1Cr/k
CvDDAP4/wkrax007B3KFfwld0dbszPn6eYbENueusWvgw56t1AD48TrD2qFvSkKO
VCKjV6mrZ3k7BJIvTJWT0yECLlD7AQ==
=Evvc
-----END PGP SIGNATURE-----

--J8bCdK0rvUHjBLrA--
