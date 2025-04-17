Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD433C369C2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 23:36:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76BA183190;
	Fri, 18 Apr 2025 01:35:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KZaAPK2w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6794182E08; Thu, 17 Apr 2025 23:54:29 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C64F081F7E
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 23:54:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-72c3b863b8eso767727a34.2
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 14:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744926865; x=1745531665; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qkZAy0+uTLzU/1r+wNs980p5EhQ8gKd00Uo836u3w70=;
 b=KZaAPK2whjTcG0ecBex9UP8a1aQN/9vhWGQTI/5+QFZ5kK7+CXSFHNSfvMylq3X9Yj
 Z9sZ1JG6a8vE7B7rjIJE8XjTZq+Zkh7lN/bjg5OrNV+Zgt2OdEhQ2h0WgO1bRrTejMaX
 FT/dDnQ01ckfHcpKShcmJMz2v+NwkWf33CQHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744926865; x=1745531665;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qkZAy0+uTLzU/1r+wNs980p5EhQ8gKd00Uo836u3w70=;
 b=tOG1MJPt+3m6Z3KK2Ia2CY3YNUdvVKJ1QgRmOs36Iv1x7XfqbqN5qpAu8u7aLLPu3Z
 iNGJpl4xePavBIvOCXClErEsoDtcOOQfiG3OfVMc6+TRmwjzFPcdv5Q97Ja8BAj4liYo
 dBy6mXq4TZ+tguc2//7hOeMWvEzA/H+X30FU89CIurKCrTHJw8oYwkw3iZMwnj8vHlGm
 2bOjnGC2WqOod3Ab0DTOmySaTc2uqA3yD73/wyc8wz3spF2IBl/JBsY9XVn+2vPO0CH9
 de6Hfp+hia9eIS6TJHBY1uXsEp0pY2Wr93geoe1Tx9ZLHp82aEFPERC8vzN0Xwva5G9i
 4hSQ==
X-Gm-Message-State: AOJu0Yy1oBiAT7t0K11UobpbHs9xn88kiSBL6iLaZl7ze82EKHKvv0dZ
 tz/Sh1CSRug2iIkMd9Pt73bMRPFvKZeXjf6luo2+PJP/GwRChqIVz8smRTNsbL0=
X-Gm-Gg: ASbGncvqM+1oX5lyXm+slwUwGRPaymsXnHHkimyKbi0pFyjBTANNF4Wryf2W8cxVc/Q
 Tp9UtissMTv+LzczwXCIbAJa2+hxAOKIzweKkAfjzCp8yw5VCxQj0O9DuUjHrzztm33cKfTrGKL
 YB6AN+eM2OlwfZ/C/TAWmkHa49Y2da+wxv/gHKtGcHJ6VOe3rIdhNKbbpseCbpMZpGpxENz5g2p
 uKvR0erZsWyRoF0LznkMaf/tvmnyNuzdP5tsbXgety/hdXdIcK3Jflw+MHlv8gCnjPJFGb2QFpD
 +CZ5K24Qq+P4HDGufn1AYtzVMTEQRK2Wq43hhxTkrdY2sGY3+ohixmhZCIHxGLR4zdT0SwVM9qL
 BBA==
X-Google-Smtp-Source: AGHT+IFUJ+zK6vK3W7wXesSBdlUj71clowESL3IOkf/OSrcMgA365vt9kdS9ND/vKP010TzM8Lo7tA==
X-Received: by 2002:a05:6808:8516:b0:3f8:55b7:87a0 with SMTP id
 5614622812f47-401c0a7cec4mr216385b6e.14.1744926865353; 
 Thu, 17 Apr 2025 14:54:25 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-401bf09cb7csm90603b6e.49.2025.04.17.14.54.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 14:54:24 -0700 (PDT)
Date: Thu, 17 Apr 2025 15:54:20 -0600
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
Message-ID: <20250417215420.GC5495@bill-the-cat>
References: <20250417181613.1355024-1-sjg@chromium.org>
 <20250417212412.GA5495@bill-the-cat>
 <CAFLszThWv+jUQ9cDZBPNvZAj89me-zFHJV4RmNhJ5Jbp+JZgzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GLIqTej5buwvyVPB"
Content-Disposition: inline
In-Reply-To: <CAFLszThWv+jUQ9cDZBPNvZAj89me-zFHJV4RmNhJ5Jbp+JZgzw@mail.gmail.com>
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


--GLIqTej5buwvyVPB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 03:38:07PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 17 Apr 2025 at 15:24, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Apr 17, 2025 at 12:15:42PM -0600, Simon Glass wrote:
> >
> > > This series adds a standard way of passing information between differ=
ent
> > > firmware phases. This already exists in U-Boot at a very basic level,=
 in
> > > the form of a bloblist containing an spl_handoff structure, but the i=
ntent
> > > here is to define something useful across projects.
> > >
> > > The need for this is growing as firmware fragments into multiple bina=
ries
> > > each with its own purpose. Without any run-time connection, we must r=
ely
> > > on build-time settings which are brittle and painful to keep in sync.
> > >
> > > This feature is named 'standard passage' since the name is more unique
> > > than many others that could be chosen, it is a passage in the sense t=
hat
> > > information is flowing from one place to another and it is standard,
> > > because that is what we want to create.
> > >
> > > The implementation is mostly a pointer to a bloblist in a register, w=
ith
> > > an extra register to point to a devicetree, for more complex data. Th=
is
> > > should cover all cases (small memory footprint as well as complex data
> > > flow) and be easy enough to implement on all architectures.
> > >
> > > The emphasis is on enabling open communcation between binaries, not
> > > enabling passage of secret, undocumented data, although this is possi=
ble
> > > in a private environment.
> > >
> > > This series is available at u-boot-dm/pass-working
> >
> > Before I get into further feedback, my first bit of feedback is that
> > this breaks transfer list support. I didn't check this on Raymond's QEMU
> > but did test it on vexpress_fvp_bloblist and expect QEMU is also broken.
> > The most likely reason I think is:
> > >   passage: spl: Support passing the passage to U-Boot
> > [snip]
> > >   xferlist: Drop old xferlist code
>=20
> CI passes for me:
>=20
> https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/25806

Sure, good, I was wondering about some of the other changes.

As a reminder there are a number of CI labs (of which none are "Linaro",
they still need to get moving on that, yes I'm calling them out here as
a reminder to them) that monitor mainline directly (I push a tree, it
triggers, they speak up if there's specific breakage) and indirectly
(Toradex has given talks about their CI which includes weekly mainline
U-Boot builds) those reports are equally as important as our GitLab and
Azure pipelines.

> > These are not the same. And they should be. And they should be using
> > the register layout / values other projects use today.
> >
> > And I am bluntly uninterested in who shuffled the registers around and
> > made them no longer agree. What TF-A is doing now is what's in the wild
> > now. And shame on them if there wasn't a good reason for changing things
> > either.
>=20
> They are the same and any difference is a bug, quite possibly in my
> code. I am hoping that Raymond can point it out, as I believe I am
> following the spec that we created.
>=20
> The xferlist is a little harder to maintain and it has a bit of an
> unusual API. It's better to use global_data for this case.

Yes, I'm not completely sure where the bug is but your code breaks the
other platforms and you should have enough information at this point
to run and reproduce it. If it's weirdly only vexpress_fvp_bloblist that
breaks, I can tell you how that's run with transfer list. I can't just
point CI at it because... nasm.us is down which means that coreboot
can't build from source which means I can't rebuild our docker
containers to include the TF-A blobs too.

--=20
Tom

--GLIqTej5buwvyVPB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgBeIQACgkQFHw5/5Y0
tyyBmQv+JdgMTq5PyodZ+ai03BBa5nNnMnf3JaqDjgTPZl31WWpLyiva/sHwYtd6
fHfbYNtAADTMaIlG3LPkKGqrc8lHMcKHl0wc6X2pguPIeTtaMXoA7oXxvaHkWwSr
8rD3oI8u2GytNBk3YmL3WSKtE7Z2Nz9tbVz5x5oOxtMBgQyewjsGdufo7vdPffXe
zootZhBOmhfkUGaB55kG0uJzJUdptiU/uDbKkAqya1kq5JAl6HmFc+mBgrUQhiJR
tnS/m/ou6gz9DiWCuJDNcV63CXOF/KfKbqWrvfVIJKo5IAZEFPesmB4c8f1ZnRmJ
daEusHMSFguHCyxeOEkYj3Axjqn7HntjgxyPokVwJ6+dw38n3/205yPrt/dO8vGN
UOjzzOln00PsiFB9Ru3f81L9jAq0TVdxnP4O9iuONr12edgu62b4GGPUSIb8faMy
K9izefAWawZM6Rbio+j9PrU69GolRBog68ZSNDVBqNRZpwX7hWisllZ5ayU3mfvX
Qe5F+Qqh
=Cb0C
-----END PGP SIGNATURE-----

--GLIqTej5buwvyVPB--
