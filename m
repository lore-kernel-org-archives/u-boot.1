Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C32C021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 14:11:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D072C807F1;
	Mon, 17 Feb 2025 15:10:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uNRnazjY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CBAF80BAE; Mon, 17 Feb 2025 15:10:57 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25EC180104
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 15:10:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2fc0bd358ccso8872755a91.2
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 06:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739801453; x=1740406253; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mviwjkv+8ReKn3F4P/pTnXrMZ2SuGDP4XQtmwsj23po=;
 b=uNRnazjYLq/5gVITpsVcpoBlXqcOWmaBIpzNRjmisiuXjGlJfq7lZall4I/dI878X3
 MLBqmRQ6RqPOHgGxboVyejM7863umHLdRbTtMHHHTyhQhTto2iXYFGLM8hnhDbv2Bg9f
 HdAESQGAzVCq0g2hfw8CAjMINPNPRj3Q9NxKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739801453; x=1740406253;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mviwjkv+8ReKn3F4P/pTnXrMZ2SuGDP4XQtmwsj23po=;
 b=Edcpj2h0sfO7xab/t+EofxQi04iBM9xTTWs88MZxEa4Rxi/nkSMr177lWjHTKzHVUn
 XY12wxnKqbxwCRLXXV6McMy+gbQDTnZYtdVnct2agB0uWDX8ZpCwbe420/rdR1RmztW5
 OWVBlHUdJhEUEdEq1n9f5uRxrIqPGRlvRmuk9/8iILz+488NdhGt6em1qbb9UBXDh/FZ
 y83Nye+2gQPXYXuXNWirLW8K10MeaClp7YdTGVUXssDZzo76DzQ/Owt7vHWKld0iQgm4
 chW2nJJIHAX+m2Gb60tcamND2rKCYHphUHgnh2DhKTF7ZkxGJnWymzUetf+C+5lcGcIC
 M+qw==
X-Gm-Message-State: AOJu0Yz0DPD31qG5KZlGSBAMRUvxi8Xekq4BlJEpS61PHq5NmxXA52WW
 L9v1Kc71jPXYhm3mCujI6McXt8/ZOh8zqe6HhRyz/xRT+fjRvVsd6duUHNHlLYI=
X-Gm-Gg: ASbGncubtNjG8sUiPBMb/DLALz2Huk45Ggd6y+eBVq/f1cIQecSCv/5kwnvrMeDJ8ja
 xJi4+uivvyTEm6NacWU+65XeAdQVqY0YmbJtR59InZmCx+Gg9gQmUbH1NEIl1CzmH2/+ipTSsYq
 dtnQHgS38WzfKI0vBjQl/CBrFE15ILPX56TJQzLppYXKpAU1Kd7f9DqCOCWfEkkZNazaYpQqVnk
 z4jZtKbTO//a6K0K3/HqeTumTk9wZybvfPaScei1rNfURY7qKgzRhshFMf4fAIUy5pVc6XCPk4N
 1HYB6fiwLrnAHA==
X-Google-Smtp-Source: AGHT+IF/JGTd9F7Rkc1Ri9Cmxw/df9l4LVc75TAtk+3j6yGbvIYdAQF6u6mk41bk5V/T5Cmzu5bIJA==
X-Received: by 2002:a17:90b:1e46:b0:2ee:db1a:2e3c with SMTP id
 98e67ed59e1d1-2fc40c1b98emr15588076a91.1.1739801452610; 
 Mon, 17 Feb 2025 06:10:52 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad2f20sm8111018a91.23.2025.02.17.06.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 06:10:51 -0800 (PST)
Date: Mon, 17 Feb 2025 08:10:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: Re: [PATCH v2 33/35] RFC: Revert "bloblist: Load the bloblist from
 the previous loader"
Message-ID: <20250217141049.GI1233568@bill-the-cat>
References: <20250211135944.GZ1233568@bill-the-cat>
 <CAFLszThU+r-F_OUSM2rWVScfvgBTSCjDzxrYi5iBaBh7WNqHKQ@mail.gmail.com>
 <CAFLszThvdHTKoV3aWMSNBEV6zeg_kO=ca=tK2RJe-Rf8_UYivQ@mail.gmail.com>
 <20250215150116.GS1233568@bill-the-cat>
 <CAFLszThi7DzdheY7Cp3zQSNsV-4a1GBvB=CVQczdyrXjBBuSOA@mail.gmail.com>
 <20250215182847.GW1233568@bill-the-cat>
 <CAFLszThDsf322WQ1GCSFNmj=41yhBhLEZisXEaSTyHYjzG6TmQ@mail.gmail.com>
 <20250216150123.GX1233568@bill-the-cat>
 <20250216154801.GZ1233568@bill-the-cat>
 <CAFLszTgRaF-CLO=YN+9Uk3x-WMCg0LjTs3kUoxCwvcGe4F44-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gXarf4w6xRJiKtK1"
Content-Disposition: inline
In-Reply-To: <CAFLszTgRaF-CLO=YN+9Uk3x-WMCg0LjTs3kUoxCwvcGe4F44-A@mail.gmail.com>
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


--gXarf4w6xRJiKtK1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 06:15:19AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sun, 16 Feb 2025 at 08:48, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Feb 16, 2025 at 09:01:23AM -0600, Tom Rini wrote:
> > > On Sun, Feb 16, 2025 at 07:10:31AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Sat, 15 Feb 2025 at 11:28, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sat, Feb 15, 2025 at 10:24:50AM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Sat, 15 Feb 2025 at 08:01, Tom Rini <trini@konsulko.com> wro=
te:
> > > > > > >
> > > > > > > On Sat, Feb 15, 2025 at 05:11:45AM -0700, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Sat, 15 Feb 2025 at 05:06, Simon Glass <sjg@chromium.org=
> wrote:
> > > > > > > > >
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Tue, 11 Feb 2025 at 06:59, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > > > > > > >
> > > > > > > > > > On Tue, Feb 11, 2025 at 06:10:54AM -0700, Simon Glass w=
rote:
> > > > > > > > > > > Hi Tom,
> > > > > > > > > > >
> > > > > > > > > > > On Mon, 10 Feb 2025 at 07:33, Tom Rini <trini@konsulk=
o.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Sun, Feb 09, 2025 at 02:14:54PM -0700, Simon Gla=
ss wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > > The logic of this has become too confusing.
> > > > > > > > > > > > >
> > > > > > > > > > > > > The primary issue with the patch is that U-Boot n=
eeds to set up a
> > > > > > > > > > > > > bloblist in the first phase where BLOBLIST is ena=
bled. Subsequent
> > > > > > > > > > > > > phases can then use that bloblist.
> > > > > > > > > > > > >
> > > > > > > > > > > > > But the first phase of U-Boot cannot assume that =
one exists.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Reverting this commit seems like a better startin=
g point for getting
> > > > > > > > > > > > > things working for all use-cases.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Note: The work to tidy this up is apparently unde=
rway. For this series,
> > > > > > > > > > > > > a revert is the easiest path.
> > > > > > > > > > > > >
> > > > > > > > > > > > > This reverts commit 66131310d8ff1ba228f989b41bd88=
12f43be41c3.
> > > > > > > > > > > > >
> > > > > > > > > > > > > https://lore.kernel.org/u-boot/CAPnjgZ3hMHtiH=3Df=
5ZKXNniOfV_-vFryq1Gn7QZ5hKU8Wjo8igw@mail.gmail.com/
> > > > > > > > > > > > >
> > > > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > > > ---
> > > > > > > > > > > > >
> > > > > > > > > > > > > (no changes since v1)
> > > > > > > > > > > > >
> > > > > > > > > > > > >  common/bloblist.c  | 64 ++++++++++++++----------=
----------------------
> > > > > > > > > > > > >  include/bloblist.h | 10 --------
> > > > > > > > > > > > >  2 files changed, 19 insertions(+), 55 deletions(=
-)
> > > > > > > > > > > >
> > > > > > > > > > > > We aren't reverting this change so if you plan to m=
ove this series out of
> > > > > > > > > > > > your downstream fork you should start from that and=
 stop posting it,
> > > > > > > > > > > > that just leads to confusion.
> > > > > > > > > > >
> > > > > > > > > > > Who is 'we', and start from what?
> > > > > > > > > >
> > > > > > > > > > We, being the community, in here, the community mainlin=
e U-Boot project
> > > > > > > > > > tree.
> > > > > > > > > >
> > > > > > > > > > > My goal with this series is to have something that ac=
tually boots on a
> > > > > > > > > > > real board, so the bloblist changes are needed for th=
at, particularly
> > > > > > > > > > > as the 'vbe' board in the lab tests this on the hardw=
are. I
> > > > > > > > > > > deliberately put these two patches at the end of the =
series so you can
> > > > > > > > > > > ignore them if you'd like.
> > > > > > > > > > >
> > > > > > > > > > > But for now, as I understand it, there are no users o=
f standard
> > > > > > > > > > > passage in tree, so actually it would be fine to appl=
y them.
> > > > > > > > > >
> > > > > > > > > > And you can ignore all the feedback you like for your d=
ownstream fork,
> > > > > > > > > > sure.
> > > > > > > > > >
> > > > > > > > > > Part of the feedback in this series already was "Yes, w=
e can clean this
> > > > > > > > > > up a bit more if bloblist will do its own thing instead=
".
> > > > > > > > >
> > > > > > > > > So I see that Raymond's patch is a significant rewrite of=
 what is
> > > > > > > > > there today, with multiple aims and changes. I would rath=
er add my
> > > > > > > > > revert and start from a cleaner place.
> > > > > > > >
> > > > > > > > Also, I forgot to mention that U-Boot doesn't seem to suppo=
rt the
> > > > > > > > firmware handoff protocol in SPL? If so, could you point me=
 to the
> > > > > > > > code?
> > > > > > >
> > > > > > > Yes, you never implemented handoff between stages in U-Boot v=
ia
> > > > > > > register. That's not a use case for the platforms that don't =
use U-Boot
> > > > > > > for SPL.
> > > > > >
> > > > > > If you let me own bloblist, I'll own it, but for now I am stayi=
ng away.
> > > > >
> > > > > Would you be working against mainline again, and not breaking sta=
ndard
> > > > > passage (as it's been split off) ?
> > > >
> > > > Sure. The only reason I have my tree is because (I feel that) parts=
 of
> > > > U-Boot have become no-go for me. So if you'd like me to maintain
> > > > bloblist again, I would be delighted to do so.
> > > >
> > > > Steps I see:
> > > > - Get my boards working again
> > >
> > > Already done. I'm waiting for Kever to pick up Jonas' small series th=
at
> > > brings back output prior to that statement from DM.
> > >
> > > > - Add standard passage from SPL->PPL
> > >
> > > By who? PPL (and xPL) already reads standard passage via register.
> > >
> > > > - Figure out what to do on x86 to also use standard passage
> > >
> > > Standard passage, or bloblist?
> > >
> > > > I'm not quite sure that BLOBLIST_FIXED can be removed, as it needs
> > > > more thought. The phase that creates the bloblist initially needs to
> > > > know where to put it.
> > >
> > > When a phase is running it already has to know what memory is availab=
le
> > > right now or not, and can allocate as much of a list as it needs now.
> > > Later phases can move/grow it.
> >
> > Actually, let me elaborate and then concede.
> >
> > What I think the best design for BLOBLIST would be is:
> > - Uncouple "was I passed a bloblist" from "create a bloblist"
> > - Only allow passing bloblist via register(s).
> > - No bloblist contents can be globally mandatory until PPL.
> >   - Platforms may declare something mandatory (ie very first phase shall
> >     init certain clocks and hand that off to next stage) if necessary.
> > - A bloblist *should* be dynamically allocated but that's not required.
> >
> > I believe this solves problems such as:
> > - We don't need OF_BLOBLIST because if we were not passed a bloblist we
> >   don't go and create one at a possibly inaccessible location.
> > - With fixed locations discouraged we wouldn't be forcing ourselves to
> >   choose between limited on-chip RAM or DRAM for everything prior to PPL
> >   relocating it.
> >
> > With all that, if we untie standard passage from bloblist (and maybe we
> > want to revisit that in a year or two), bloblist can do what it likes so
> > long as standard passage isn't broken. And with it being uncoupled, it
> > should not get broken. I'll stop trying to convince you of a better
> > design.
>=20
> If you can convince people to let me act as maintainer (with the final
> say) for bloblist then I'm happy to do so and I can work towards the
> design above.
>=20
> I think we have the same end point, but perhaps disagree on whether it
> all needs to be done at once. The only question I have is about the
> 'mandatory' stuff. I worry that this is an attempt to make it
> impossible for U-Boot to use its own devicetree, even as an option. So
> long as it isn't, fine.
>=20
> My general issue with bloblist is that it has been broken for me for
> over a year and it just takes too much energy to get changes in. The
> OF_BLOBLIST thing was just the worst and I would rather not repeat it.
> I just looked at your tree and there is no OF_BLOBLIST.

If you're willing to let "standard passage" alone, I'll let you do
whatever you like with "bloblist". I too am tired of re-hashing
everything about OF_BLOBLIST.

--=20
Tom

--gXarf4w6xRJiKtK1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmezQ2kACgkQFHw5/5Y0
tyy1pgwAnY+FDCmjb0NDbM3R4dt3UjIT55Jvt3mQE25X2kTVR6jnm2ArSd2J8jWX
xsrO3YhfUPYJ/BLCGMLWsOafIJDFuJOHK2XoRI+HeWdVuPOARlH3X2nbmSUVHIxb
5Kcu7cSlpbR8GxfKrUECpRHmXDp57fI4pCT6En8IPKYctk1JST3QQNb2uu+tcNIi
uadT1UpayGNeE1moWsF0GBeCHFubrmTslNAR5jJvJyAd3Gpop5PynnDJVD7U8NGd
INZalJRX8MI15mgWVtR1JH/II+Ii3eOD12+/+XmaymR0nlE2wG7AvK8mPRAcgjlG
ri68GkPDJetx7lbL4yUL8rXtlTbooTxCVkr23aYDsErrAScd1T+6tbWJa6viRneA
6MnkkgwNq3mZivFMrFYY9ziv2RMwWy5987id5hlHv8Zl12NK8gjSrQkRfrLjls2D
xN5Ihv2/EgZ37CtOPzJpWgw6UuSiQpHyfStcFiBRc/kgIKC9lnR4rAtiju5W/vJJ
C6RQn/3R
=HQCh
-----END PGP SIGNATURE-----

--gXarf4w6xRJiKtK1--
