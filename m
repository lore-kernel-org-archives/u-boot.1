Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA1DC28B24
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 15:47:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0778480F4C;
	Thu,  6 Mar 2025 16:47:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a4ZDG9EM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48E8980FE1; Thu,  6 Mar 2025 16:47:24 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09FAE808A2
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 16:47:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-6f4bc408e49so7929697b3.1
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 07:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741276041; x=1741880841; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=P0Kcpp2xRhZo4h5IfRyHF0iSQx8RnU6Yw//b0jrcmx0=;
 b=a4ZDG9EMtHRibxS5NwsW+C60KQbGekWgyKJ4HejcGmkL8TEbe+XH2fvHWNOkSyNtee
 RnZ2IEwoS9ihjH1e2uEVXcZYZagqFllBcVDnd19y4fMpFvVMmPDTAKFAb8vr/74R6BH4
 PkirD9zfRxclk+YcB8UkfQZiW22FRmb2t6Twk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276041; x=1741880841;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P0Kcpp2xRhZo4h5IfRyHF0iSQx8RnU6Yw//b0jrcmx0=;
 b=JaBoCJjUOqNZmBJ4FUOOJIkDMtyLdeobMw/tc8mj7rQBfTHde9Hoq6ERi+IwrMslxk
 a1lzKZEdbV3ihWUxIJGal8P9vQeJUA1Ia4gIY/2cDeo9h7EHfzKL9qd3lQG9YHhiKz7A
 ZEJDVieE4TlAK935s7FcUqLbvKzFgOBpF9FeTfDqYERPXIlvZ1eExoTkjIjWW+X0orG4
 g/hQHWNUqJquBDR69vH/3DVAgYg36qQI3ThzFP7EA7Zx3/yZAZEPmrywCGzAqLC/Xt7k
 vciRo2nQwfF1R1Q6hsZNk8POzieTgPWtr4ekh21+429Lzt5UjUFkZQs719I7kivhPMgI
 htJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUt1/1m4KSa0W1CStR7fART38RjMd/x5wpkOf8Jsfsk+e201kjdFttm3aHwBaCYPRaMRW38yX4=@lists.denx.de
X-Gm-Message-State: AOJu0YyP+l/kOuq3kG0K6navQwjM+QfgZddZ3nviTqMx0Au2IWovSky1
 Vswh0C1SXqoYz6duX4AJW1lUuFKIoqxhaIx0vN3GQcpmIxkBe6mrhIQBH8AIaBk=
X-Gm-Gg: ASbGncuLkNueGI8ALNO/a+4XCJ9cbgnzbFQvzMmQQGlU7ipYY1P1L5DJCppyN0Cx+iJ
 r7R40W2W390xHieuWUqDgni+i3S7SHnv3dSjkMrUeEv2PjZshrG+ef9SgUs0h5gAUrNoRW2iqJE
 U9dqMuEmIWWrgWKKl8xLpBWMydB7Rnv9170yDNlSUFZMAN4s1V7nXBvnTOZuZatngDnging0CiN
 WMgYFyyZD1LyxoL9IOLMB2QmblDVyiz6rTJSTwG+nz24RQsZ6/P7pBGTDfLv89xPLFTazL37aH7
 f7L8o/Z/1Caq5+2vmGd5fj+xRap+5mT4opbWdw6kDxApng==
X-Google-Smtp-Source: AGHT+IGJxDQ9gE6MfLhfIiFjB62KgXpw8UogjhM3Y2KZ1+do2LzRa3xPgeXP0s7Dvbyn8zvLrD01/A==
X-Received: by 2002:a05:690c:6aca:b0:6f7:ae50:6edd with SMTP id
 00721157ae682-6fda30bea74mr111314337b3.30.1741276040788; 
 Thu, 06 Mar 2025 07:47:20 -0800 (PST)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6feb2a6b14bsm3072207b3.49.2025.03.06.07.47.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 07:47:20 -0800 (PST)
Date: Thu, 6 Mar 2025 09:47:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Sam Edwards <cfsworks@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH 00/17] Various toolchain compatibility fixes/improvements
Message-ID: <20250306154717.GE2640854@bill-the-cat>
References: <20250224055524.1334929-1-CFSworks@gmail.com>
 <CAH5Ym4isqLibOv97=9zgYFx-fok-sAa3QetfRgyrQmDQ4MHgmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kI6XMAz8a5zgf3P8"
Content-Disposition: inline
In-Reply-To: <CAH5Ym4isqLibOv97=9zgYFx-fok-sAa3QetfRgyrQmDQ4MHgmQ@mail.gmail.com>
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


--kI6XMAz8a5zgf3P8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 05, 2025 at 07:46:56PM -0800, Sam Edwards wrote:
> On Sun, Feb 23, 2025 at 9:55=E2=80=AFPM Sam Edwards <cfsworks@gmail.com> =
wrote:
> >
> > Long time no see, U-Boot folks!
> >
> > This patchset consists of various bug fixes and correctness improvement=
s that
> > I discovered while attempting to add first-class LLVM support to the bu=
ild
> > system. These patches are NOT related to LLVM support directly; rather,=
 they
> > address existing issues that should be resolved regardless of future ch=
anges.
> > For the most part, the patches are mutually independent and can be revi=
ewed and
> > applied separately. If any patch is not suitable for merging now, feel =
free to
> > skip it: I will incorporate feedback and revisit those changes as part =
of the
> > upcoming LLVM support patchset. I'd like this patchset to be evaluated =
on its
> > own merits, based on the current state of the code, without considerati=
on for
> > future LLVM support.
> >
> > Note that the issues addressed in this patchset do not occur when U-Boo=
t is
> > built using the GCC/GNU toolchain. These bugs seem to be specific to bu=
ilds
> > using other toolchains, like LLVM, and do not appear to affect users re=
lying on
> > GCC/GNU. Therefore, I see no need to rush these changes into the stable=
 branch.
> >
> > Again, these patches are mostly independent/reorderable...
> > ...except that: "arm: Add aligned-memory aliases to eabi_compat"
> > ...depends on: "arm: Add __aeabi_memclr in eabi_compat"
> >
> > Warm regards,
> > Sam
>=20
> Hi Tom,
>=20
> I noticed that all patches in this series have been marked 'Changes
> Requested' on Patchwork. While some patches do need changes, this
> series was intended as a set of independent submissions: each patch
> can be accepted, rejected, or reordered without affecting the others.
> Would it be possible to reconsider the remaining patches for review
> without resending the series?
>=20
> I'd like to withdraw the following patches:
>=20
> - [06/17] arm: Use -mstrict-align when the MMU is off (Incorrect approach)
> - [11/17] makefile: Fix symbol typo in binary_size_check (Will follow
> Simon's suggestion for a more comprehensive fix across architectures
> in a future submission)
>=20
> The feedback I've received so far was mostly requests for
> clarification, which I believe I've addressed in my replies. Please
> let me know if anything remains unclear or if further adjustments are
> needed.
>=20
> Thank you so much for your time!

It's *really* hard to track parts of a series in that way. If they
aren't intended to be applied all in one go, please post them
individually as v2s. The clarifications likely mean a bit more rewording
of the commit messages are in order.

If it's really hard on your end to resend things, I can go and poke
through the series (once Ilias has had time to do the reviews I see he
promised).

--=20
Tom

--kI6XMAz8a5zgf3P8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfJw4UACgkQFHw5/5Y0
tyyCawv+JjoTD1nVjf6U30liR2bPJEkmsX6p234dKuoB5v0f3gUp2mEjlCUhlr8p
pjUh3vs9HeJK04z1+5nbzPSVeToQP4pBGvZhctYcuxOueBiXuPSX+kxha5kaNkEk
ZdwmzXkXTUpR7Qu83qwVr0umkID6jZu/z+ulP0T0qwFo1m+354TnvDN/udG4Y4Cn
kptO7x//3EKt6HIHavoBkBAjRB5dDv/jcqWA6UYDJ65hO5Yb9iQUuuOoKkp3NBFQ
GLdSBUfxWqlI3Q1pzpi0+gA9PyEJdTl+Fqoehlf0sVw7a/szp88t6vqyBpeeOq86
YOsOBJP323Loszb1umXttOedR2wcmI0WUnv5rzcT0AA7eeQhiU4LE0L26tqw4PEY
6dNrShPVt6Q5cWpRHxF2025xq22GVuscA6nDVPkUKmRvrWrWaPiSjp6C+6/ierQ+
Vk+Z/+oI95azaQMUuTYwzmfm8VIzQtfQkIa3dDrDXp3KzT57WtiQIHdrUYjoEV9u
lKJjrtdn
=GFCa
-----END PGP SIGNATURE-----

--kI6XMAz8a5zgf3P8--
