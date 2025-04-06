Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90FA0C36002
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 22:35:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4AC082B8E;
	Mon,  7 Apr 2025 00:35:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tngvv2lq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BB5C82C2B; Mon,  7 Apr 2025 00:35:14 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A615182B45
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 00:35:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-72bd5f25ea6so852569a34.1
 for <u-boot@lists.denx.de>; Sun, 06 Apr 2025 15:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743978910; x=1744583710; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CRz46eZGwNfrwtIwdINTC2O291DjI/XDT0jE6lUqFJQ=;
 b=tngvv2lqaLAAKwKp4iK+/yN84W5PEFEtCAgagfuG6N0wMu4BCvscuKYnkP9mA4pSJj
 SUvXWijQHljj5nrE8938qmGZVpzbMzUCmqzaREUcX/oGfJkJonFZjIv0SFWQQOrLdO6V
 753TYNq+WTDK8f9HflexT+NecSeN3LBmZ4tHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743978910; x=1744583710;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CRz46eZGwNfrwtIwdINTC2O291DjI/XDT0jE6lUqFJQ=;
 b=WkZ+ZTaYZYklEvsAiKDeVBVyJAq6Z/dmhhbHmPMKt5EvUz8BENu168gN52eXeT7mXm
 g4lyjgG7B1YhD38rTK2ZYPklb7vQe8RerUxKmA53KVp7dxyAf9ORmr1dFl1flXAd2lKR
 9PsL/1mk8KxsVU8UExAWjUbA3ae+pI07xkIwVZaqQBDoOxNWduqIL4v+2oent4fNY0bk
 k0quZOw/+3WHzenBbj61TTQTirpJkJOYwRrBX+M7UrIcRFlivT/Nlvr52hWGGCbzJlIB
 RLCoHgVci6uxvKKucvUDDFDIjbNUCA6aWks9/cG3XqbzEdbutB7iAutvDKogVYlHZdV9
 fmmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5ahv4YcXPt1MSHVYmyFjskysB+BfGxlSug8AeVOLmSxqLRgjqKPN42xiy9PGdwsbsWhJi/a4=@lists.denx.de
X-Gm-Message-State: AOJu0YyX8OwP5u2Op/pmGxtJ9sGFr/NaM6MwxSktfFRZwN00kTGXIpQY
 K1mH51kTEW9cqXQR1bgFtODKQK70n6TedGeP0kf8DzgvXdVPqGBlqoIdKimxxMc=
X-Gm-Gg: ASbGncsOGuLt+igJq23hwit+4riMYDvk0Vme4fnieBBqSij3/WNX0IYdHDZO3puUWa8
 ljLZ7p4kSKE0kNyUkck5aXtnTqgfIDVPAmOQJQFU8kacqD3qgwuv+qQZZB0tVJZF7S+4h8sMl7r
 lJOAATIv+NYnKusA4I9eMduPT9b1/ov9U3WkA8iDWVRRkI/YNyRVcoPY3SKBpyAEvZ2OBR6oJvq
 yqTfT7pxGLXxHYqrmAjCNd2maQxuUnQIFITkfci/B17CD38zo05NzyWdSnqk6DDFzRQhjYcFTKQ
 70ZP5M5ufnN87D2ELDz2lZO1e+lGZJosC64ELt/OazmVJqUf2Qy4x1eYajpivGbcqmCHnOAn7z3
 Xrxx91g==
X-Google-Smtp-Source: AGHT+IGjsf7fi6EdvPEylGwvJSaYm6Vt0013yQjqtDAyBnYEXEacbhwwT9ctfzcLpbHkspEj9b2T8Q==
X-Received: by 2002:a05:6830:6011:b0:72a:327:eed3 with SMTP id
 46e09a7af769-72e36658f38mr7272883a34.5.1743978910262; 
 Sun, 06 Apr 2025 15:35:10 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e305b6412sm1490841a34.59.2025.04.06.15.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 15:35:09 -0700 (PDT)
Date: Sun, 6 Apr 2025 16:35:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Levi Yun <yeoreum.yun@arm.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marex@denx.de>, Matthias Brugger <mbrugger@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sumit Garg <sumit.garg@kernel.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 mason1920 <mason1920@use.startmail.com>
Subject: Re: [PATCH 0/4] bloblist: fdt: Clean up the code
Message-ID: <20250406223506.GD5495@bill-the-cat>
References: <20250328154401.3563921-1-sjg@chromium.org>
 <20250328161845.GB93000@bill-the-cat>
 <CAFLszThKn0xTmLdR7Hs_oKO_paYTtr-Y1xA_eoNY2rcjeuHX9g@mail.gmail.com>
 <20250329000211.GH93000@bill-the-cat>
 <CAEfUkUJo6AA_SESSYj6Bgq=tUHRc5MQ+sAqtURkbNRafK+=SiA@mail.gmail.com>
 <CAEfUkUJOu_nw0j3EvSpAgrSZ+wy_g=CLdY5yo9uWuc6j3NfnbQ@mail.gmail.com>
 <CAFLszTjo8HEzKbZAbO=neF57e69vGbWYsDVV_dD=kO6j_VH39w@mail.gmail.com>
 <CAEfUkUJNUhoyRY6S9-eYV5i9RT_GgYLRs+HRWocch8jYfVj2Lw@mail.gmail.com>
 <CAFLszTj-pQSK_aKNoLUcLFBk+wAjgC_5=-5YRPGt_7DDFRL3Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="M/PncWX4a3LZO4KM"
Content-Disposition: inline
In-Reply-To: <CAFLszTj-pQSK_aKNoLUcLFBk+wAjgC_5=-5YRPGt_7DDFRL3Dw@mail.gmail.com>
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


--M/PncWX4a3LZO4KM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 07, 2025 at 10:06:04AM +1200, Simon Glass wrote:
> Hi Raymond,
>=20
> On Sat, 5 Apr 2025 at 07:09, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Fri, 4 Apr 2025 at 13:40, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Raymond,
> > >
> > > On Sat, 5 Apr 2025 at 03:49, Raymond Mao <raymond.mao@linaro.org> wro=
te:
> > > >
> > > > Hi Tom and Simon,
> > > >
> > > > On Fri, 28 Mar 2025 at 21:00, Raymond Mao <raymond.mao@linaro.org> =
wrote:
> > > > >
> > > > > Hi Tom and Simon,
> > > > >
> > > > > On Fri, 28 Mar 2025 at 20:02, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Fri, Mar 28, 2025 at 11:38:14PM +0000, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Fri, 28 Mar 2025 at 10:18, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Fri, Mar 28, 2025 at 09:43:54AM -0600, Simon Glass wrote:
> > > > > > > >
> > > > > > > > > The bloblist code took what I consider to be a wrong turn=
 a year or so
> > > > > > > > > ago. As discussed with Tom, this series proposes a way to=
 arrange things
> > > > > > > > > so that it is simpler to understand and manage.
> > > > > > > > >
> > > > > > > > > - Unwind some of the nesting in bloblist_init()
> > > > > > > > > - Avoid needing to init the bloblist just to get the FDT
> > > > > > > > > - Create a deterministic OF_BLOBLIST option rather than u=
sing guesswork
> > > > > > > > >
> > > > > > > > > It is to be hoped that we can get a platform which uses O=
F_BLOBLIST into
> > > > > > > > > CI at some point. In the meantime, the standard passage s=
eries[1] could
> > > > > > > > > be resurrected to give some coverage.
> > > > > > > > >
> > > > > > > > > [1] https://patchwork.ozlabs.org/project/uboot/list/?seri=
es=3D281465&state=3D*
> > > > > > > >
> > > > > > > > Based on how it's documented to be run in
> > > > > > > > doc/board/armltd/vexpress64.rst in the next branch, have yo=
u confirmed
> > > > > > > > that platforms using the handoff spec still work?
> > > > > > >
> > > > > > > I believe so, yes. I don't have that board to test it though.=
 Raymond
> > > > > > > may be able to test this series on QEMU?
> > > > > >
> > > > > > I was pointing you at the docs so that you would have access to=
 testing
> > > > > > it. That's part of the docs, running the emulator.
> > > > > >
> > > > >
> > > > > I can help to test the firmware handoff on qemu.
> > > > > I have all the necessary changes and unit tests for the OP-TEE re=
po
> > > > > qemu v8 build to test this.
> > > > > I will try to find some time early next week to review and test t=
his
> > > > > series before turning back to you.
> > > > >
> > > >
> > > > Just a follow-up on the testing with TF-A and OP-TEE.
> > > > Unfortunately, the patch series breaks the transfer list handoff to
> > > > U-Boot completely and just end up with below error when U-Boot boot=
s:
> > > > ```
> > > > No valid device tree binary found at 0000000000000000
> > > > initcall failed at call 0000000060097bcc (err=3D-2)
> > > > ### ERROR ### Please RESET the board ###
> > > > ```
> > > >
> > > > U-Boot test version:
> > > > 'next' branch + this series + my patch [1] to point fdt_addr to gd-=
>fdt_blob.
> > > >
> > > > [1]: https://lore.kernel.org/u-boot/20250331224011.2734284-2-raymon=
d.mao@linaro.org/
> > >
> > > I suppose the FDT address in the register is not being read correctly.
> > >
> > > Do you have a test case for this, e.g. in QEMU? Even if it is just
> > > binary blobs for now, not suitable for CI, I'd like to get it in my
> > > lab.
> > >
> > > I did create a test back when I did standard passage, but that series
> > > seems to have not been applied. I'll see if I can resurrect it.
> > >
> >
> > I am using the OP-TEE repo [1] qemu_v8 build to test. You will also
> > need my patch [2] for enabling transfer_ist in all components.
> >
> > [1] https://github.com/OP-TEE
> > [2] https://github.com/OP-TEE/build/pull/821
> >
>=20
> Tom's email seems easier to follow. I got as far as building:
>=20
> build/fvp/release/fip.bin
>=20
> But I'm not sure how to run that in QEMU. The docs mention some sort
> of FVP thing and running FVP_Base_RevC-2xAEMvA -C which I don't seem
> to have.

Yes, you need to download the linked emulator, it's not QEMU.

--=20
Tom

--M/PncWX4a3LZO4KM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfzAY8ACgkQFHw5/5Y0
tyyfTgwAufbT6XDcKYrHDr7pMlwCWhhYRLr2A803fO/1mFjFbEepqEqX96fCMZz0
S46kKoFuf3hkD5ZDK2kxRh0PbeUKWUW/Zv/cDehrwqwj4nQ6IXwbYCxYMvcTm+35
r6eEjJFlOGTYe8dRrjpMYo6UwoIWEBxTICh2CBGqTGVe8F8n/K7S+m7u1tLAOQai
imXEQL40Ang7pBfo5cuMH3W77oyzE985yzw4xE3NsSMO2KXPMC4ZaDLbD4Nt7+H8
gmE7p9tV4tg7plwrKvDdW6Cn1KD6aA7dzmTWAwPjB35H54jxFO/VfAX9n8i5SDzL
gFBDxToqaEPsJOMr8WDiIgKLh7h1/WbdZXy68ffjfKP2tq3Q7kUkMO5nz56hta8Y
NQtznxYKaIuYZFk0XTPIcVD5JYW4kSQA3VcSJvh7PB9R4nWEbkxcXThc5HTsiqdL
mfeESVPs4tFAlCgrPYxiuihBuuEqC//hzcX1QHnR+S3SBAzqX1P5q08r5NYV6kQ7
YGdG6uGq
=NzlP
-----END PGP SIGNATURE-----

--M/PncWX4a3LZO4KM--
