Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FF1C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 14:51:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63B8882B81;
	Wed, 30 Apr 2025 16:51:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="huF+ijr3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02F1982B45; Wed, 30 Apr 2025 16:29:40 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A9008210E
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 16:29:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-601ad30bc0cso707136eaf.0
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 07:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746023376; x=1746628176; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tqcNOCSkhzK1zjyQOoyOqgMR1fcGamAducX/LuNEV/U=;
 b=huF+ijr36Jq3Z8iA6wcmrQBhcOKjyZwtg5fdhAOF39LTqiEREjzwlONeAfFZ5WnfMe
 v+bnpRYKhZEPPdXbiW0nLgwVLFmATD6TgZ0xy18KQR9s8qZu3gvDoFwDKNTSNuyZFzTj
 y3icxCPSr0sv++gN8XmfTxBaNvDeYfstiGqqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746023376; x=1746628176;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tqcNOCSkhzK1zjyQOoyOqgMR1fcGamAducX/LuNEV/U=;
 b=F8bRRwqIIB7Q77GsQBM26/7qz271k0QyJZ4fe4uNa1XoOQ3ZJk9VaOwXwiCiKoFKzV
 KJvgxOucIWOqkT4d2FGCxXjkh/l5zBRWuy255P4/TV8Bv6OBAU7kypE7NXVSHeBh8v7T
 2Id9ESFojYsvbuDSKAsfr+cln3fq4OpfNVmtkCODt25+j0XA0qCds6Dj9BcOpClem20n
 j+eBXSPtqblTnNhGiaI636mG2+hFiechU9FZpIZEhVDAM1kkQjsEGqNPqq6TrbOViWEn
 cblr1nr3OsCOu9yFL3uiK/UNvoRB8VkIllpnRDhv8eZm81xhJNduJcVapoK0ag1/Nd8D
 upQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyR7SZ+KrsZUvmNuu4IzrAchpwx9RVZnePrLwdoVJVS+HUEKrV5+c5XsCK1+kRDQX52H3wu6A=@lists.denx.de
X-Gm-Message-State: AOJu0YyQVII380a+LNHhNdbPIi1CkB/3ksEpaqP7AADGBit+p+TsSyQP
 5GwgGQ56ZT2vjnN2lso9lPct1nRdE57v7iapZRNCZyMg/x5X49Gt634kLtnxkqw=
X-Gm-Gg: ASbGncvazuOaLmv5fvPRNSMgrhO46Jd8rwvlkpIsIEWPfBnkHAmiIfNFAwi3fHru2IO
 w+XB4THRdg9G90FekEjm19xOQwST+S5+Uxrrte49yKEuKVwednjdJ1tyf2Pf/yfVsNjXyctwNt1
 QyPi1RwPwTCXiy0qG2KqpuVa20BhdCOtOhBWbZWFARBETye092gmjl7umdgQ1ZH4HR1M2crHRHg
 c5tXG5yMIdyrBTvA/2ItZgaqlXkSgcAduZdotfWIfKRvLbyX4Bj0xR6pVi3X/3E91/Por3l8Afa
 WIcoC9tK3iIZiQ4mMlY+f/iba0IC5Vai6CSU40xiWKozWRpg7ieA3w0rpbuZT7RjJgXknYfuBv7
 F5A==
X-Google-Smtp-Source: AGHT+IHYN3Eu1Yjg38UtE3FM1/Op9naYdTexDIf1kV5UtgvUh3HZt/e/Oblnvu2nIuFzCHKiU3WOTA==
X-Received: by 2002:a05:6870:d622:b0:29f:bdf0:f0f5 with SMTP id
 586e51a60fabf-2da6b5a79e0mr1697589fac.17.1746023376193; 
 Wed, 30 Apr 2025 07:29:36 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2da6e59fc79sm436956fac.48.2025.04.30.07.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 07:29:34 -0700 (PDT)
Date: Wed, 30 Apr 2025 08:29:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Peter Maydell <peter.maydell@linaro.org>,
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
Message-ID: <20250430142931.GQ1261075@bill-the-cat>
References: <20250417181613.1355024-1-sjg@chromium.org>
 <CAEfUkUJpT8YxOgdakCBbjBo_a6a6pQDR_wh=iqX5LC+cFAFJ0Q@mail.gmail.com>
 <20250429171154.GJ1261075@bill-the-cat>
 <CAFLszTjfq1TVjYSiCQmtSOZK7MoVUOFU5ycOzeBK4-5-zCKxFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eNgNFzjnRELmZry0"
Content-Disposition: inline
In-Reply-To: <CAFLszTjfq1TVjYSiCQmtSOZK7MoVUOFU5ycOzeBK4-5-zCKxFQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Wed, 30 Apr 2025 16:51:40 +0200
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


--eNgNFzjnRELmZry0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 07:55:01AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 29 Apr 2025 at 11:11, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Apr 28, 2025 at 10:41:25AM -0400, Raymond Mao wrote:
> > > Hi Simon,
> > >
> > > On Thu, 17 Apr 2025 at 14:16, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > >
> > > > This series adds a standard way of passing information between diff=
erent
> > > > firmware phases. This already exists in U-Boot at a very basic leve=
l, in
> > > > the form of a bloblist containing an spl_handoff structure, but the=
 intent
> > > > here is to define something useful across projects.
> > > >
> > > > The need for this is growing as firmware fragments into multiple bi=
naries
> > > > each with its own purpose. Without any run-time connection, we must=
 rely
> > > > on build-time settings which are brittle and painful to keep in syn=
c.
> > > >
> > > > This feature is named 'standard passage' since the name is more uni=
que
> > > > than many others that could be chosen, it is a passage in the sense=
 that
> > > > information is flowing from one place to another and it is standard,
> > > > because that is what we want to create.
> > > >
> > > > The implementation is mostly a pointer to a bloblist in a register,=
 with
> > > > an extra register to point to a devicetree, for more complex data. =
This
> > > > should cover all cases (small memory footprint as well as complex d=
ata
> > > > flow) and be easy enough to implement on all architectures.
> > > >
> > > > The emphasis is on enabling open communcation between binaries, not
> > > > enabling passage of secret, undocumented data, although this is pos=
sible
> > > > in a private environment.
> > > >
> > > > This series is available at u-boot-dm/pass-working
> > > >
> > >
> > > First of all, can you group those patches which are necessary for
> > > refactoring the "passage" concept into a smaller series for an easy
> > > review?
> > >
> > > Actually as I mentioned in our previous discussions, I don't agree to
> > > add a OF_BLOBLIST as this is duplicated with "BLOBLIST +
> > > BLOBLIST_PASSAGE_MANDATORY (aka PASSAGE_IN in the context of your
> > > patch - I am not sure the reason you prefer to rename it - do we have
> > > any other passage approaches other than using bloblist? And do you
> > > have any considerations to allow a fallback or not in case passage
> > > failures?)"
> >
> > As preamble, I am actively working to push the changes for
> > vexpress_fvp_bloblist to be available in CI and so provide an easier
> > testing path.
> >
> > At the high level, I don't see what the difference is between "BLOBLIST
> > + BLOBLIST_PASSAGE_MANDATORY" and "BLOBLIST + OF_BLOBLIST" or "BLOBLIST
> > + whatever v4 of this series ends up showing". Everyone seems wildly in
> > agreement that if the prior stage is supposed to give us information
> > then it must have done so.
> >
> > One of the long running "jokes" in computer science about naming being
> > one of the hardest problems applies here, too.
>=20
> I want to use OF_BLOBLIST as it clearly indicates that the devicetree
> comes from a bloblist. The BLOBLIST_PASSAGE_MANDATORY thing is a
> work-around to try to avoid having OF_BLOBLIST.

Or:
Other people want to use BLOBLIST_PASSAGE_MANDATORY as it clearly
indicates that the standard passage will be present and so include the
devicetree and any other required logs/blobs/content. The OF_BLOBLIST
thing is a work-around to try and avoid having
BLOBLIST_PASSAGE_MANDATORY.

It's a naming problem and I don't care as long as we end up with an
implementation that's useful. And *that* is where my list of what
bloblist needs to have, in the end, comes from.

> > > Secondly I prefer to keep the register convention code as a xferlist
> > > library that can be used for arm arches other than split them into
> > > different low level assemblies. In case of any firmware handoff
> > > specification update, we just need to maintain this library.
> >
> > Yes, if things can be written in a C file, they should be in a C file,
> > not assembler.
>=20
> In this case I disagree and if you look at the x86 code, this kind of
> approach is just not sensible. Please take a look at the contortions
> of xferlist_from_boot_arg(). It was written for one architecture only,
> yet purports to be a general API. My approach is simpler. Also, if
> save_boot_args() is implemented by the board, then standard passage
> will be broken for that board. It's a weak function!

I don't see why this has to be in assembly and not C, no. And it's a
weak function because it doesn't yet exist on other architectures and
everyone hates #if.

> More generally, please decide if you are willing to let me maintain blobl=
ist.

Can you be given substantive feedback? Or is only trivial feedback
allowed?

--=20
Tom

--eNgNFzjnRELmZry0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgSM8sACgkQFHw5/5Y0
tyww3wwApeCmgwM6YzGUM5cQI1NjvCWvAZ7ZKMbNwKtAwbX0q1HXiBI0Mv7a83Ff
++s4DXYs2itmR2Cfbl+fKDH4/AvVaOO8IZgfX1li4xIVmZvk6Ou2583jO8YEG+An
J2GdCD/0r8K6iDnolxHgItpCFyBLsoVt/TnIqjafacdaMo0IzgyUZPHuPs7hHIMR
O7ISKKFh4OLkPopFa5CmM71d8cxtVDgpgU6dKHMw11xT3oscGgwChwVDDHBTQiuJ
awzFJgX1zbxbftEd3GBqGwt0619C5Xltf6/EyfcOB/s4NtDwCEkcm3gBl2OB4k+E
NzWBfv9dy+qHjCzv3Q1TlQaBLVqt0EMoyvadpA9KWz6CV7nyZMywJUSGlbxtsZFH
knJy8Acb/CmIraGzMzPbSn1AJc6DrlDsTU7MPva4kDWRBjW0g4Ysn/UGlzhabnl2
gcdKDw23VrKGl2yIA3723eTNwAiJ1x6Bc4sKBJyuJbWCuey8Vuwi9YkfD5YTz8Tc
v3vF7SZ2
=gGJp
-----END PGP SIGNATURE-----

--eNgNFzjnRELmZry0--
