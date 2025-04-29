Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E935BC369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 17:01:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9B1382AAA;
	Tue, 29 Apr 2025 19:00:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AsHZioQE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9281829A1; Tue, 29 Apr 2025 17:05:21 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C3FE82958
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 17:05:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-72c40235c34so1830321a34.3
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 08:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745939117; x=1746543917; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sh/x31PUnnhSaMKw/XJ23xytDYqha67XRktpJhGnFT8=;
 b=AsHZioQES4MT5502X0kKLxLXOy2B2q6TAnl43TqLEgIdemwCht4AzqyoT+is+worMT
 QMEnyGKV3DE0Mxqer2VnayvxZSAgHjRrYA9im3Md/QusholG0o//k6MHkZrZ6BDDL3YX
 YfBiFXq0TBL9HmepZmFMDYbVZitanniAkA6YA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745939117; x=1746543917;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sh/x31PUnnhSaMKw/XJ23xytDYqha67XRktpJhGnFT8=;
 b=WvIlNLCtKXwyFpHx6oJLFnZa19MB8wqK9ML4I8J/SDsdKLdJQYN7g2vRO9vL8hyNMt
 WQHqzizJo6qPsM3naqkDf+w2Zxmwavyafr/uYiYqEe/SBLRTnaQxbi8eeLwcisEBEjAo
 gEKC4xMgWRW37Y+jOwW7w+J5CUDuimFqPmIhY3qZyR/JFhGSuumeUY1MhFzmYIFdVS0f
 Jhel8ywF0D/s06RNtu5riKwDqb3j2XF9CXbC3uQooe/VVWOa3JmT3uwjDRxjGSb1wEm/
 fhOjnwOZcUdxa/rGKzHsgC2wPRObUReV1f50qurC08HCkAXy6RQwdMgm+gbjWSyIq5C4
 7EFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdTWVdfKa3hOydnPXaE+HsRevWqz57gXFiH4OCYAuoeTmS3kTpfnLtmtkiJg1mWzMNK3k+hvs=@lists.denx.de
X-Gm-Message-State: AOJu0YzW+h74e+3HsAgx2IT6Bg8gqntIMxlur3kDQ6KqW3baCbkuvduy
 iMBS6hpnfa+jaXVSqgtsulPilCS5FLhstoIA14Z3pnZ4GKK9s6+IFhAi0uPgufU=
X-Gm-Gg: ASbGncvlNnz/LctEGEivSko0m1MOgwUnrBj8gAVuW8kvidWD4fJIbSEFMGNVQcLYP0M
 lXIxtl3z0daVA+bno6xJpsq/6eLrkBgDKX4fplJ6RlCPH2Q3khBS3MnIoj15JzHFdYkjm3NOtjq
 +MgQbgnQtjjBrFMmD2BtoVGqt30Z6URFSbfLTSnf/CPYICEJDv535SVqUUQq+8zhR2/nax9wSGX
 VZ0TlPXFOeWfSRsDNLElBTIp3p5ccJp0lhYFU8I36XamyWbnjOPuGTzt9vcCmVNTuJ1oq+6ts+M
 YNLqQadqVIsc7VgnHPRBMh2hKJW38AliUKIU72uiVfzokxn4EMdogp7bFjSdpCn4qhOMpQG4dT3
 uVQ==
X-Google-Smtp-Source: AGHT+IEXGbZ21cZWAamam82Y4uLn8oi508tyi0bJKKuh8iowGo9eYXWVwUHe61rdil+IJi/6xCClzw==
X-Received: by 2002:a05:6830:3981:b0:72c:3235:3b97 with SMTP id
 46e09a7af769-73065263559mr8717397a34.22.1745939117091; 
 Tue, 29 Apr 2025 08:05:17 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b11b47esm312700a34.26.2025.04.29.08.05.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 08:05:16 -0700 (PDT)
Date: Tue, 29 Apr 2025 09:05:11 -0600
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
Message-ID: <20250429150511.GH1261075@bill-the-cat>
References: <20250417181613.1355024-1-sjg@chromium.org>
 <CAEfUkUJpT8YxOgdakCBbjBo_a6a6pQDR_wh=iqX5LC+cFAFJ0Q@mail.gmail.com>
 <CAFLszTjrv8hg=0QoHZM8Syu33nHuK7t9xQhAOmRk-xLGu=jrdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="biUmV8kLhONBkCPQ"
Content-Disposition: inline
In-Reply-To: <CAFLszTjrv8hg=0QoHZM8Syu33nHuK7t9xQhAOmRk-xLGu=jrdw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Tue, 29 Apr 2025 19:00:39 +0200
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


--biUmV8kLhONBkCPQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 08:33:16AM -0600, Simon Glass wrote:
> Hi Raymond,
>=20
> On Mon, 28 Apr 2025 at 08:41, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Thu, 17 Apr 2025 at 14:16, Simon Glass <sjg@chromium.org> wrote:
> > >
> > >
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
> > >
> >
> > First of all, can you group those patches which are necessary for
> > refactoring the "passage" concept into a smaller series for an easy
> > review?
>=20
> What do you mean by refactoring? I don't believe my series has much
> value unless it actually brings in 'standard passage' and everything
> that goes with that, e.g. the validation and documentation.
>=20
> >
> > Actually as I mentioned in our previous discussions, I don't agree to
> > add a OF_BLOBLIST as this is duplicated with "BLOBLIST +
> > BLOBLIST_PASSAGE_MANDATORY (aka PASSAGE_IN in the context of your
> > patch - I am not sure the reason you prefer to rename it - do we have
> > any other passage approaches other than using bloblist? And do you
> > have any considerations to allow a fallback or not in case passage
> > failures?)"
>=20
> This is how I would like it to work, i.e. that one specifically
> chooses OF_BLOBLIST. This split of bloblib and whether or not it is
> mandatory is just confusing.
>=20
> >
> > Secondly I prefer to keep the register convention code as a xferlist
> > library that can be used for arm arches other than split them into
> > different low level assemblies. In case of any firmware handoff
> > specification update, we just need to maintain this library.
>=20
> I don't agree with that, sorry. This should be a standard feature of
> U-Boot. It is easier to update three 'store' instructions in the
> assembler than to figure out what is going on with the xferlist
> functions. They are really just an obfuscation from the Arm point of
> view, the only current implementer of the spec.
>=20
> I have tried my series with your QEMU things but it doesn't work. So I
> went back to try your original instructions with your series and it
> didn't work either. Would it be possible for you to get the pending
> patches in the other projects submitted and then send me an update re
> the instructions? I would like to get the environment running again,
> but there are too many moving parts at present.

What I want to highlight here and now is that vexpress_fvp_bloblist also
uses standard passage and can be added to CI now:
https://patchwork.ozlabs.org/project/uboot/patch/20250422193657.512324-1-tr=
ini@konsulko.com/

I will apply this later today I think.

--=20
Tom

--biUmV8kLhONBkCPQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgQ6qIACgkQFHw5/5Y0
tyyvAQv+LMD36kCb37MAjTPuRXonG1SAsGbBzfw2UCfn0gZIi/w2rltcVLWbhwRl
TtubrTGJql2mJXafNI+xAVkMduxa3lMfrmzTB0IfkJvqGQp0lJscbkB3fopLSiYG
vsTX4yyPR3CjlPDhyo/tz75RyLSQVG9YhNXIdXJnAa05Nw4a2MG0zgjlNFuwk4Vo
J3hkCURWh2nTSDPORh7jNZWx5rffgYiiQlr9e1HEyoqGn/w4HK7tfLnmDt8GrCP+
n9cZdR1bo18uz1gEZX42MVnGDLz3F5odw63RtX8AvcA2qRoaWjbt23BuV2MiJIMg
eDkKfE3EAR4F4ONulIcd+JMs+VaZoArm/gAbKfrUvC5Swzpbzadu0xllPFZzVDgl
PCP84BcIbq5FNVylZFunh/mOy/RbH6TtCJxa3elSmn+YIRCNME4QeQvSSKrVD7uS
zEIsuZ+iTG4NpWlgiAk8ayPFMV4CYAJ2kEM1rC2DmS6zzNwGefLHm2a6TjsuuZM8
AQoofVA2
=87Uv
-----END PGP SIGNATURE-----

--biUmV8kLhONBkCPQ--
