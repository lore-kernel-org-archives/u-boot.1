Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD07C282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 14:07:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA2978164E;
	Mon, 10 Mar 2025 15:07:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hqYZHsX7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 261358164E; Mon, 10 Mar 2025 15:07:52 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA6C381417
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 15:07:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2240b4de12bso68614585ad.2
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 07:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741615668; x=1742220468; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mK5cKr7Ok7RFu3py47mO0sbOL5tkJP3fw2KrQiVhPwU=;
 b=hqYZHsX7G3LcHXudrqErBUXhKaWWohoQLRSAGdnGsPRR89lnEzA/vHSw6ViDfYXl4y
 ucc/dQ+7RNKYcd/Xp08mlGq/cdTAdSpRnMAXSxGHca1jqt7VAI1qSNkXagsOCED9jRTp
 mqzxNo726m9Cy5jMaRt2A/gOSgUHqOLGzmJ80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741615668; x=1742220468;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mK5cKr7Ok7RFu3py47mO0sbOL5tkJP3fw2KrQiVhPwU=;
 b=Zqcl4w5o4l4NOY8pOfTrx8w77jod1y73pnSWnwPDquu/97csc5xUP01jAZaxU9+TVw
 g/decF2nZpQHX2FR79z9Ma4WxYdDuNvQUr464OZCVOJC8HAZ/eW1lRugF/+8KPhWIv2a
 vJ9cukra1+x2apnjn9NDs6I131ufgYrvq7NVSdJUtAz/yUyG087XWOSG8e7qIeuDRbPF
 rW6T5zYtuUPEDs1QOQfs/ll8gQzXq3h2ms/M7odUkXLetiXjGRm3URRe/N3is1hHYMo5
 2Y3Ac3dEl+4ThxaOnN4TREtfRuJSKhrhkFOJF3uNahVyUhn5qzgA+T8ZI/sUOkl5/Db8
 7oMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1mI5hiRSgV+Gxs4DupXzvU3j5VTtjQi1SF2oXyxzaoQUZNuaysxpwoXqApGxLtOwzjtCIw0Q=@lists.denx.de
X-Gm-Message-State: AOJu0YyOcoxVTrhZ70fWU7t+T15g/p2i5Pf7vku+3DFOHkCm3br3Xa/z
 62rsX3+XWQb4iyOgSJllmiEBUbW24vmg1rqrS4wIqKGT2xsMdfFcmKgYuZMnbQw=
X-Gm-Gg: ASbGncuPgTMBJK9YnqoV5DWUB7TWXZt5NZ5XnHoxsTZJqDaF46FP1F2a9PV0J2g9OYr
 GDG7/MwHeNPq5N/NsMMCPLoRK/j2SewUBmb8Mxgry5Xr4IO6YEbMx1f8XJGKQXqrnbSS0AugI7g
 /0eQKjqjkgTmYrsJS8ZPC1MlJTOEbEeco6QL4EVLb7IlC8eJghPhGGDZ1/QnhCnw1O7RrGoOq4y
 2f0D6Bs8U4zy013et2zutPuFw26yS3oTWb5mCJTBIFBpOWo1xMydX3QQnoW2twfcA1Vey0t0kQ0
 VDcUlMSF1FCOPIuNzO3SjmO+9j+66WDT0+hgKW2+gSKV5A==
X-Google-Smtp-Source: AGHT+IF5nkSYP1qz83z2wSRWEIj9K6mDJUelqZjyc4V+EHPszWel2a+II4/REM0o5YgtWy/fI5n33A==
X-Received: by 2002:a05:6a00:3cd5:b0:735:d89c:4b8e with SMTP id
 d2e1a72fcca58-736aa9bc83bmr17930585b3a.5.1741615668204; 
 Mon, 10 Mar 2025 07:07:48 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736b5cef0f1sm5788805b3a.25.2025.03.10.07.07.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 07:07:47 -0700 (PDT)
Date: Mon, 10 Mar 2025 08:07:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Sam Edwards <cfsworks@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH 00/17] Various toolchain compatibility fixes/improvements
Message-ID: <20250310140744.GY2640854@bill-the-cat>
References: <20250224055524.1334929-1-CFSworks@gmail.com>
 <CAH5Ym4isqLibOv97=9zgYFx-fok-sAa3QetfRgyrQmDQ4MHgmQ@mail.gmail.com>
 <20250306154717.GE2640854@bill-the-cat>
 <CAH5Ym4iVdMk9C3qyuOasM7spNU4XzohuYVZ7Z-+OmG3FGm2jzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="R3DLQfMmRlxTOPop"
Content-Disposition: inline
In-Reply-To: <CAH5Ym4iVdMk9C3qyuOasM7spNU4XzohuYVZ7Z-+OmG3FGm2jzg@mail.gmail.com>
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


--R3DLQfMmRlxTOPop
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 07, 2025 at 10:48:11PM -0800, Sam Edwards wrote:
> On Thu, Mar 6, 2025 at 7:47=E2=80=AFAM Tom Rini <trini@konsulko.com> wrot=
e:
> >
> > On Wed, Mar 05, 2025 at 07:46:56PM -0800, Sam Edwards wrote:
> > > On Sun, Feb 23, 2025 at 9:55=E2=80=AFPM Sam Edwards <cfsworks@gmail.c=
om> wrote:
> > > >
> > > > Long time no see, U-Boot folks!
> > > >
> > > > This patchset consists of various bug fixes and correctness improve=
ments that
> > > > I discovered while attempting to add first-class LLVM support to th=
e build
> > > > system. These patches are NOT related to LLVM support directly; rat=
her, they
> > > > address existing issues that should be resolved regardless of futur=
e changes.
> > > > For the most part, the patches are mutually independent and can be =
reviewed and
> > > > applied separately. If any patch is not suitable for merging now, f=
eel free to
> > > > skip it: I will incorporate feedback and revisit those changes as p=
art of the
> > > > upcoming LLVM support patchset. I'd like this patchset to be evalua=
ted on its
> > > > own merits, based on the current state of the code, without conside=
ration for
> > > > future LLVM support.
> > > >
> > > > Note that the issues addressed in this patchset do not occur when U=
-Boot is
> > > > built using the GCC/GNU toolchain. These bugs seem to be specific t=
o builds
> > > > using other toolchains, like LLVM, and do not appear to affect user=
s relying on
> > > > GCC/GNU. Therefore, I see no need to rush these changes into the st=
able branch.
> > > >
> > > > Again, these patches are mostly independent/reorderable...
> > > > ...except that: "arm: Add aligned-memory aliases to eabi_compat"
> > > > ...depends on: "arm: Add __aeabi_memclr in eabi_compat"
> > > >
> > > > Warm regards,
> > > > Sam
> > >
> > > Hi Tom,
> > >
> > > I noticed that all patches in this series have been marked 'Changes
> > > Requested' on Patchwork. While some patches do need changes, this
> > > series was intended as a set of independent submissions: each patch
> > > can be accepted, rejected, or reordered without affecting the others.
> > > Would it be possible to reconsider the remaining patches for review
> > > without resending the series?
> > >
> > > I'd like to withdraw the following patches:
> > >
> > > - [06/17] arm: Use -mstrict-align when the MMU is off (Incorrect appr=
oach)
> > > - [11/17] makefile: Fix symbol typo in binary_size_check (Will follow
> > > Simon's suggestion for a more comprehensive fix across architectures
> > > in a future submission)
> > >
> > > The feedback I've received so far was mostly requests for
> > > clarification, which I believe I've addressed in my replies. Please
> > > let me know if anything remains unclear or if further adjustments are
> > > needed.
> > >
> > > Thank you so much for your time!
> >
> > It's *really* hard to track parts of a series in that way. If they
> > aren't intended to be applied all in one go, please post them
> > individually as v2s. The clarifications likely mean a bit more rewording
> > of the commit messages are in order.
> >
> > If it's really hard on your end to resend things, I can go and poke
> > through the series (once Ilias has had time to do the reviews I see he
> > promised).
>=20
> Hi Tom,
>=20
> Well... that's "hard" but not "really hard" for me, so I think what
> I'll pitch is this: let's let Ilias (and others if so inclined) have a
> week to pick through the series (thanks Ilias!) and offer feedback;
> I'll resend any patches that get no/positive feedback as a v2 series
> (where the "just skip any patch deemed objectionable" option will
> still apply), and any patches that need reworking can be part of my
> upcoming LLVM support series. Would that work?

Yes, thanks!

--=20
Tom

--R3DLQfMmRlxTOPop
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfO8igACgkQFHw5/5Y0
tyy8fgv+Kw9GT/kTS+RQckDGvz5Ba2YyKVHNJU5JZreO3v48Oywys27dE/a2pONR
xUV/f2Yl3RFh/gKyOl382i4CXT5VTjhrzTrVapW0JSomNlLe9eay2QGA4DSgxZNp
VLYlr3K6SRQ2jiZPUINwrXi3ajcdPNJwbWXtrAoQIJ0PnOLSPjNyG8pLoyXfi59b
QaA2plJnEJCfshJWUuJR6CjAEwcL4UHLwRFGKAoUATJTTPVFINF0hVxxA6z8YIgg
JYhKtXNFzZBfTHTrM/7dcZUzwXtU602gHP2avfq3YiqGlkdq++5UONVK7uYLGKsj
zPIOwg7UjYHz1kaC3X/07HnJSFLyGG5Xpdw8x9P8JU5r9/wmrqs2Q7PDkrL5PpVN
34Jdl7m6igjV69+6RH2Q9b4VFbRTIcXqfixBjMOLLGI1rv2N+AvA7y+BKqvH9FN4
u1HLQciJdhIJqqfnRgzDdbXcE6d2VYO++WgOt244y645lOp8mSRrSqbBk/N0YFYS
a9E1cBVo
=QBME
-----END PGP SIGNATURE-----

--R3DLQfMmRlxTOPop--
