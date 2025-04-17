Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF9BCC369C2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 23:36:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16B7B831C2;
	Fri, 18 Apr 2025 01:35:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UxpLX1UZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 502C4830A0; Fri, 18 Apr 2025 00:19:28 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C88982E38
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 00:19:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-72c7332128eso627766a34.0
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 15:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744928364; x=1745533164; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UlKtpAjF9w8cfqEaIizEVcCgDCdyL+DItWl1tMHbWMY=;
 b=UxpLX1UZvJcxj+OAaSnhpbESK6ml3KGSI0wzDTZZRgMvo0a+Qa7lDcEx70q9cQZ6I3
 nyPYnWAzwZEvp1swaHSCc+vSQstkK717eGd6mpiYu0yno+ZtYQoBgmWPJBfcXVF9pl7V
 g8qYMBOGK3zR6T08OL2N+dWQq2uajDmE2ssDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744928364; x=1745533164;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UlKtpAjF9w8cfqEaIizEVcCgDCdyL+DItWl1tMHbWMY=;
 b=aetFfnSC9q9IlMfeoQtANh92oRsfVzfxHReQpGiQKd2t6+GwozuwZAog2yvpAD9yiG
 dCcF5aKem1yG2x62W8hu/pSx+wL0/beSa6PWVrE761PthTU00rv7AKPva8lp4GzfT0pB
 ZTJ7kVACpePoiW28F0eELGrRcNbmC7EdFtZIw7ZeSISddauPxy8QRdhwXsGEn/r0BYy/
 X0ltAj2yHD4DKN+mDq1xI5Sm3J6RWoiqHRPtoQ8KZnlzxJs47sB62XRSvYZro0SCqw/O
 4eQ1btvS8EM5ZTKCS/z0ijpY/gSonM369cVnPo+Nc0ByX8eeMco8nI0tbjF7Ytk1yN8n
 LfGA==
X-Gm-Message-State: AOJu0Yye0zvtmwHGI67vinlNiQlWGJxUzPtNzU84IKTFB5ge4nV/KYyN
 LCXrQ0xYmbwPvfWU0gDCDZR/4ZJ/sr3xuTuKRLZ1z/TC1JI9aMNh1fIjgHMEfuI=
X-Gm-Gg: ASbGncvVprghjMvbSnP3GrUkMp7TVo5xRghXAK9giXFHUSgFMuye+ggPK6CT+/HIB1v
 8rp+vodLJ8lIw2kOme9c7TfOq91XAwx+2ssrRhWPXF+P3UH7cpa06bBgJ8XaTdxw60kdlIsiq41
 z0fkYguC8zKUr1RT7puj+95ljGeFcFFylE1ecbrCoxY0vWG3G7UdMSbnbUC3DBttWlsP4RSn3Cj
 hEWqA4z2i+8AS8GfopGJXWURjx/9JIcJ8nhvXG7aHG+OlxvO6+SvvVXNIxhhRu1ohrLA4rhubX9
 f8vJnyhADNAFnlArRQJO/7zyI2nxdE0axpizvEsPGe3Ycjocbmsjj0GIJeziMGnBnB/B0FMPveT
 gzg==
X-Google-Smtp-Source: AGHT+IGU4r65pR7t/3lPJNM/SHkFiS1uek4LLrBP+FMM0Plhi5U9YZKP6OVQpM5x1VmpeHaq+L3FsQ==
X-Received: by 2002:a05:6830:6e93:b0:72b:946e:ccc9 with SMTP id
 46e09a7af769-73006210f9dmr357584a34.8.1744928364147; 
 Thu, 17 Apr 2025 15:19:24 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-730047cd9desm113577a34.41.2025.04.17.15.19.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 15:19:23 -0700 (PDT)
Date: Thu, 17 Apr 2025 16:19:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?iso-8859-1?Q?Fran=E7ois?= Ozog <francois.ozog@linaro.org>,
 Bill Mills <bill.mills@linaro.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Alex Shumsky <alexthreed@gmail.com>,
 Alexander Dahl <ada@thorsis.com>, Bin Meng <bmeng.cn@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Fabio Estevam <festevam@gmail.com>,
 Harrison Mutai <harrison.mutai@arm.com>, Jason Liu <jason.hui.liu@nxp.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Joshua Watt <jpewhacker@gmail.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Levi Yun <yeoreum.yun@arm.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Marek =?iso-8859-1?Q?Moj=EDk?= <marek.mojik@nic.cz>,
 Mario Six <mario.six@gdsys.cc>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sean Anderson <seanga2@gmail.com>, Stefan Roese <sr@denx.de>,
 Stefano Babic <sbabic@denx.de>, Sumit Garg <sumit.garg@kernel.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>,
 Xu Zhang <423756212@qq.com>
Subject: Re: [PATCH v3 00/22] passage: Define a standard for firmware data flow
Message-ID: <20250417221919.GG5495@bill-the-cat>
References: <20250417181613.1355024-1-sjg@chromium.org>
 <20250417212412.GA5495@bill-the-cat>
 <CAFLszThWv+jUQ9cDZBPNvZAj89me-zFHJV4RmNhJ5Jbp+JZgzw@mail.gmail.com>
 <20250417215420.GC5495@bill-the-cat>
 <CAFLszThBLF=Put6QyhmM_yJ=Hq0g+fUW+=E4a0j7LO8VisuUKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dFFhE3lDwj2NaPiR"
Content-Disposition: inline
In-Reply-To: <CAFLszThBLF=Put6QyhmM_yJ=Hq0g+fUW+=E4a0j7LO8VisuUKg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Fri, 18 Apr 2025 01:35:40 +0200
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


--dFFhE3lDwj2NaPiR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 03:59:13PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 17 Apr 2025 at 15:54, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Apr 17, 2025 at 03:38:07PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 17 Apr 2025 at 15:24, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Apr 17, 2025 at 12:15:42PM -0600, Simon Glass wrote:
> > > >
> > > > > This series adds a standard way of passing information between di=
fferent
> > > > > firmware phases. This already exists in U-Boot at a very basic le=
vel, in
> > > > > the form of a bloblist containing an spl_handoff structure, but t=
he intent
> > > > > here is to define something useful across projects.
> > > > >
> > > > > The need for this is growing as firmware fragments into multiple =
binaries
> > > > > each with its own purpose. Without any run-time connection, we mu=
st rely
> > > > > on build-time settings which are brittle and painful to keep in s=
ync.
> > > > >
> > > > > This feature is named 'standard passage' since the name is more u=
nique
> > > > > than many others that could be chosen, it is a passage in the sen=
se that
> > > > > information is flowing from one place to another and it is standa=
rd,
> > > > > because that is what we want to create.
> > > > >
> > > > > The implementation is mostly a pointer to a bloblist in a registe=
r, with
> > > > > an extra register to point to a devicetree, for more complex data=
=2E This
> > > > > should cover all cases (small memory footprint as well as complex=
 data
> > > > > flow) and be easy enough to implement on all architectures.
> > > > >
> > > > > The emphasis is on enabling open communcation between binaries, n=
ot
> > > > > enabling passage of secret, undocumented data, although this is p=
ossible
> > > > > in a private environment.
> > > > >
> > > > > This series is available at u-boot-dm/pass-working
> > > >
> > > > Before I get into further feedback, my first bit of feedback is that
> > > > this breaks transfer list support. I didn't check this on Raymond's=
 QEMU
> > > > but did test it on vexpress_fvp_bloblist and expect QEMU is also br=
oken.
> > > > The most likely reason I think is:
> > > > >   passage: spl: Support passing the passage to U-Boot
> > > > [snip]
> > > > >   xferlist: Drop old xferlist code
> > >
> > > CI passes for me:
> > >
> > > https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/25806
> >
> > Sure, good, I was wondering about some of the other changes.
> >
> > As a reminder there are a number of CI labs (of which none are "Linaro",
> > they still need to get moving on that, yes I'm calling them out here as
> > a reminder to them) that monitor mainline directly (I push a tree, it
> > triggers, they speak up if there's specific breakage) and indirectly
> > (Toradex has given talks about their CI which includes weekly mainline
> > U-Boot builds) those reports are equally as important as our GitLab and
> > Azure pipelines.
>=20
> I think my QEMU test is a good approach, since we can make it work on
> any arch in CI, without need particular hardware.

It's one of those "yes, and" cases. QEMU is good. This test platform is
just a different emulator, not QEMU.

> > > > These are not the same. And they should be. And they should be using
> > > > the register layout / values other projects use today.
> > > >
> > > > And I am bluntly uninterested in who shuffled the registers around =
and
> > > > made them no longer agree. What TF-A is doing now is what's in the =
wild
> > > > now. And shame on them if there wasn't a good reason for changing t=
hings
> > > > either.
> > >
> > > They are the same and any difference is a bug, quite possibly in my
> > > code. I am hoping that Raymond can point it out, as I believe I am
> > > following the spec that we created.
> > >
> > > The xferlist is a little harder to maintain and it has a bit of an
> > > unusual API. It's better to use global_data for this case.
> >
> > Yes, I'm not completely sure where the bug is but your code breaks the
> > other platforms and you should have enough information at this point
> > to run and reproduce it. If it's weirdly only vexpress_fvp_bloblist that
> > breaks, I can tell you how that's run with transfer list. I can't just
> > point CI at it because... nasm.us is down which means that coreboot
> > can't build from source which means I can't rebuild our docker
> > containers to include the TF-A blobs too.
>=20
> Yes, I gave up with the TF-A thing, but when I hear from Raymond I'll
> give it another crack. It can't be that hard. There are just too many
> 'in flight' things at present.

Well, the good news would be that vexpress_fvp_bloblist needs nothing
"in flight". It's already in U-Boot. It's already in TF-A (build as
documented in U-Boot for vexpress_fvp, add TRANSFER_LIST=3D1). It's just
not in our CI right this second for reasons I mentioned above.

--=20
Tom

--dFFhE3lDwj2NaPiR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgBfmcACgkQFHw5/5Y0
tywt2Av/c3CpNEydJVs7t1vdG54zTyG6z5xRhM3ORT6hzLmnVqSi3Owu4Mth9X4b
O6twfbrgaFj+/o45fTP1CCbLv7jAxYDHyGFkZVUjtG2RVq86LbsoI9z8HpefI2fu
TL71xrTsmMydZxEhZbzgKloAaNpIR3uZu2Fo7MUtWpiBoX2OaOaoFXlSYggz50qn
P+UDUKXPZqJzz9Y8n1CdzqKOGUi2A3xC548ThzcUSMuBjLGdAFakFkVTZw6Cwthi
+SLj32AtsmTobHRWIM2nQp9ORxZP7EIymYSa9JCjXsf5maVLE75pBx/ofMM0bMwl
oxhQLC3Jr5gBrvGnNMvzav8ZfuYZd/j8h0Gt89U5Id56pUpiTVup77lUZYS+u2JK
ENTkFmZQqmX7K5eoy1y3ZoYG241lmcWoGMhST7FLXxyXdZZLCCHqXHfwQxO4ly3A
nOtE7HlQqozrDv9qLlFp+8GxRkM5eDO8MlVzx6rBHPYzZjMk/CQlVBTNr5Ml304i
l4gYuruP
=dVPB
-----END PGP SIGNATURE-----

--dFFhE3lDwj2NaPiR--
