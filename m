Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C316C369C9
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 23:35:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E60ED830B4;
	Fri, 18 Apr 2025 01:35:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dygN8kG/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 520A882E8E; Thu, 17 Apr 2025 23:24:21 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1427F82CBC
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 23:24:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-601fcbff303so612062eaf.3
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 14:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744925058; x=1745529858; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KNsQ6EaEa64vqKdRUP7QAy6o0EhK2EWxHN2X0H09uGE=;
 b=dygN8kG/3d6/POR5yvxxGBZ3sPXg/FtPOOrXnM/Q6isvSrd+eKFsKROEkUX+ZM1UV8
 lfjPeHIvoKe7+1GMZRJVYO9pdSuJcYullnLI2JpOhasgn83oEclMzNfxS4NFkBNXMofb
 oQN1o/nozrQS+sEGtrBD3BKHV9K7NNBoXJol0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744925058; x=1745529858;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KNsQ6EaEa64vqKdRUP7QAy6o0EhK2EWxHN2X0H09uGE=;
 b=Qrm0W3A7AYedM9uYMj8LAmu6DPFeVTjR1yZ7qBtzh4Ooj21ElHqc5oCy6iNG+AUVAl
 aULF1Y8ZB98GytmEIhPWdprCTjN/xzG549Gag2qOGebeyCutMTB9SYHPVFStU5vq/iJG
 RDdKz/+1SxVXNFl+VnT98AFRnYsYb1INzUKrAo1bCEK6KtiwKHqLsm9p8RnZ0QYn3LOv
 aGijXNr0EX99Z1iGYz3cOGIHbsNX5Gy7noRcMMm7EDFQs3K2XpaBvgjx3bpkmCg+fx2d
 GcnKwe7ttpGfX1aRZ3rWJvaHQZa9sM3smAJPv7ntXfvpcGDWhJFhtQkRmn+DZEYT94sj
 bwfw==
X-Gm-Message-State: AOJu0Yzk+dKT6YeE1JIL7cQF20Zty/drF1u1gHP0M/Bp2n7ZqhW7us88
 wwCD6ircud8skMyiA7Xg3BzB3cTXy4a5YoIY8yZmf+CQbBn0O2KDCgRaRWyn4FE=
X-Gm-Gg: ASbGncuiVrFewImiBYmCSTjPzZbvpPDrSZ3CKOe9ZzFWgB9FhZII7o8YIrnsVuNZb2/
 WdhBEOjOoxY2E9TOQP1SI4nrMhiFpxdGi6ov5ksdQX6BoAvend1/N9c3OcV+wOdArScCkLMIeh0
 xoPjIiqTV6r3c2UjqJMztXquiS1q2ioyQ9Gkgq+BXsS3s9gbA9FNXqibEOCzLiujID6CxaCLcaK
 CVA5v+UAu4cQQDXgoKG4O2UbgPwncjjg2aSZoGCtRtX4zXDqbgkdQ/LOSA5UmPi+Iv14lpsZ/g7
 8T5kepV0MvJvcQIYG968VheJz3af4il2RDuDJrBBGhtIm045gO7XO1U68Kq857FqQHQEBxBv602
 zsA==
X-Google-Smtp-Source: AGHT+IF9rWTLtw6M43wWX/XO8gRBAHXV8i7eeB+Brkbn+Di6fnht6Mi5IAIp6mVafuzcEsg1DdVilA==
X-Received: by 2002:a05:6820:134f:b0:603:f820:7be4 with SMTP id
 006d021491bc7-60600569a1cmr336152eaf.8.1744925057584; 
 Thu, 17 Apr 2025 14:24:17 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-605ff69ca14sm110703eaf.26.2025.04.17.14.24.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 14:24:16 -0700 (PDT)
Date: Thu, 17 Apr 2025 15:24:12 -0600
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
Message-ID: <20250417212412.GA5495@bill-the-cat>
References: <20250417181613.1355024-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FO6WdQCPCfZ57YJf"
Content-Disposition: inline
In-Reply-To: <20250417181613.1355024-1-sjg@chromium.org>
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


--FO6WdQCPCfZ57YJf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 12:15:42PM -0600, Simon Glass wrote:

> This series adds a standard way of passing information between different
> firmware phases. This already exists in U-Boot at a very basic level, in
> the form of a bloblist containing an spl_handoff structure, but the intent
> here is to define something useful across projects.
>=20
> The need for this is growing as firmware fragments into multiple binaries
> each with its own purpose. Without any run-time connection, we must rely
> on build-time settings which are brittle and painful to keep in sync.
>=20
> This feature is named 'standard passage' since the name is more unique
> than many others that could be chosen, it is a passage in the sense that
> information is flowing from one place to another and it is standard,
> because that is what we want to create.
>=20
> The implementation is mostly a pointer to a bloblist in a register, with
> an extra register to point to a devicetree, for more complex data. This
> should cover all cases (small memory footprint as well as complex data
> flow) and be easy enough to implement on all architectures.
>=20
> The emphasis is on enabling open communcation between binaries, not
> enabling passage of secret, undocumented data, although this is possible
> in a private environment.
>=20
> This series is available at u-boot-dm/pass-working

Before I get into further feedback, my first bit of feedback is that
this breaks transfer list support. I didn't check this on Raymond's QEMU
but did test it on vexpress_fvp_bloblist and expect QEMU is also broken.
The most likely reason I think is:
>   passage: spl: Support passing the passage to U-Boot
[snip]
>   xferlist: Drop old xferlist code

These are not the same. And they should be. And they should be using
the register layout / values other projects use today.

And I am bluntly uninterested in who shuffled the registers around and
made them no longer agree. What TF-A is doing now is what's in the wild
now. And shame on them if there wasn't a good reason for changing things
either.

--=20
Tom

--FO6WdQCPCfZ57YJf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgBcXEACgkQFHw5/5Y0
tywlWgwArHKfd2SS0EVJXXPWzp3wJffQabVZAxwzbPFybLrrA/lk40OxxN+9UDH1
qRQnV4cYayeMWvWjkPnOnaA7vSoBwVgSQdQV4UEQALT4xuCxFZUpdfhoRhnOrtL0
dr9lAMGi+qWhjmGbJWVkZRHS4Qh6Z7Nv09Ol2ffSSd7NhZn6XZhfhxGB+Um52+7i
FGqnoyQcW3bBUucCsG+RD+TXnqkWk3OR0AWMLwkulu+lRdizC4GMwx89PyMPEgF3
Dm16DNivA3Zr7WLroj/bTXh/uFy1aCbt2JxkpWAB/4HZnsYFwrz3KnOJlrBbPezO
4sTHF3hX3/mc/AfA8EbrA3Yo7CruK3c1XF4tX8990hBDLJQyQA+ptPCSwTNfy36U
vBgHUZKqByqO8a1JP1sXzZLXdL95EQIQHJ8LqYiZi/3FY3IindJfqi5StlVPrqVL
9quvJq3dV/RZ8a12/38oqK2uOwwbVGsgjJ5v8P/vPJK/Zjes9tQbZ7qISfVEPR0U
OHVUajha
=zq/B
-----END PGP SIGNATURE-----

--FO6WdQCPCfZ57YJf--
