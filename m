Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F1FE64AAE
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 14:00:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 654A6895C7;
	Tue,  3 Dec 2024 15:00:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jf6vJ3wH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C0D489362; Tue,  3 Dec 2024 15:00:35 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 855CF895C7
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 15:00:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6d891ec719bso25720976d6.1
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 06:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733234431; x=1733839231; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BvULFFUZVduawCB2SSOc3UatFhCZ5BsV5WCdAaMfDK4=;
 b=jf6vJ3wH6046k92QLpGqh9t0Z8DieZ67KoKiIyzI78nlosZqkR/Qt813wqSRpolnQy
 1tfSxDxS4vEb7g7k5Ay5EiCzWr37PvVJlFyy7HjliW/8Xb9Zwsq9e03+HQ/sM8tGFJeE
 CExYPAW29Atl61QWJmVmYb01GE3PZFh+k5MJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733234431; x=1733839231;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BvULFFUZVduawCB2SSOc3UatFhCZ5BsV5WCdAaMfDK4=;
 b=UH/M5aTYh92pAWw8NoYCIC1XUPlmIqUOpx+hqkesICYRHebH18c6fWQH2X+guZ7u2F
 KZXBIwprd+TKcax2NQB5aMHwY+ENE0W171xWfSir+LKx+f3uGufo+Tx8CDVNL64Sf6cm
 SOfkO8uF0enc6qUgCgmWaLtZ6mA9DzNTDXcV3np6AnjK2t5QThHxpuGwhzBYP0Ht+N5V
 synRQGGI41QAdrd8GUSzLQgQITB251SuvILzUt8YKjVtsMj0wNKrCNX9c9cmujd8QeJU
 9QoESlHwyxhcVAjM9UWOHQ1V/6RFcKLbFJWF1BESz11FdsorbA8pOM9ryrFFS3M2bZVH
 Uq9A==
X-Gm-Message-State: AOJu0Yyp60/RYFaZEERXCPFXrWBWP7Sz44nx7TfSIiR+XcJG7wS1rE9g
 tw8UQvxMb6xfgluh91OAH7eG6Xmg0FmnAHhhefDpoojKen+AVERdvsRtwc7BxuM=
X-Gm-Gg: ASbGncs9NIn3fU4EGEzjJnZKAejsimfqMbktrfjJBxSoIHulU1ATwFISGPMA/koXVeA
 Sta/av7xISrQLbeDcm5kiJtdfOtpA0gTmIJ+w6IKMj0UZSnqtwP7JdA3OYyhJ4z5MlsxMvPcUq3
 okNPQFD2VB1PHZJ5EkohPGhU1oCvQL41oxZcnocheGfvMFakhwMcxVouQw9GwRpL1q0M/X8LxPh
 ISargM40ZOBwUpQ92I+ELdrTMoJ3al6iHHZ8cbHa03iazQGAg==
X-Google-Smtp-Source: AGHT+IHSIa9xs5b+RMPWjZkS+otzBAfS9Xk8z0Y8P74lyLL7c8suiSaJ/KABtGYjNOGgvVikiKNbvw==
X-Received: by 2002:ad4:5aee:0:b0:6d8:8f3d:4d82 with SMTP id
 6a1803df08f44-6d8b740ef3emr31503096d6.46.1733234431197; 
 Tue, 03 Dec 2024 06:00:31 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8a3ac437esm27646666d6.6.2024.12.03.06.00.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 06:00:30 -0800 (PST)
Date: Tue, 3 Dec 2024 08:00:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Devarsh Thakkar <devarsht@ti.com>, Jonas Karlman <jonas@kwiboo.se>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: Re: [PATCH v5 3/9] board_f: Correct stack reservation
Message-ID: <20241203140026.GS2457179@bill-the-cat>
References: <20241201152815.1668093-1-sjg@chromium.org>
 <20241201152815.1668093-4-sjg@chromium.org>
 <20241202215922.GI2457179@bill-the-cat>
 <CAFLszTgfPnJCi=Q+-ROMd2dU_z49C2h4wHgmFrq80TQ0kD_BFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LaHV/dKXNyCZ4PSX"
Content-Disposition: inline
In-Reply-To: <CAFLszTgfPnJCi=Q+-ROMd2dU_z49C2h4wHgmFrq80TQ0kD_BFA@mail.gmail.com>
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


--LaHV/dKXNyCZ4PSX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 03, 2024 at 06:53:55AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 2 Dec 2024 at 14:59, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Dec 01, 2024 at 08:28:05AM -0700, Simon Glass wrote:
> >
> > > The reserve_stack_aligned() function already ensures that the resulti=
ng
> > > address is aligned to a 16-byte boundary. The comment seems to suggest
> > > that 16 is passed reserve_stack_aligned() to make it aligned.
> > >
> > > Change the value to 0, since the stack can start at the current addre=
ss,
> > > if it is suitably aligned already.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > Er:
> > /*
> >  * reserve after start_addr_sp the requested size and make the stack po=
inter
> >  * 16-byte aligned, this alignment is needed for cast on the reserved m=
emory
> >  * ref =3D x86_64 ABI: https://reviews.llvm.org/D30049: 16 bytes
> >  *     =3D ARMv8 Instruction Set Overview: quad word, 16 bytes
> >  */
> > static unsigned long reserve_stack_aligned(size_t size)
> > {
> >         return ALIGN_DOWN(gd->start_addr_sp - size, 16);
> > }
> >
> > is what the code is today.
> >
> > > ---
> > >
> > > (no changes since v1)
> > >
> > >  common/board_f.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/common/board_f.c b/common/board_f.c
> > > index 98dc2591e1d..677e37d93c0 100644
> > > --- a/common/board_f.c
> > > +++ b/common/board_f.c
> > > @@ -601,7 +601,7 @@ __weak int arch_reserve_stacks(void)
> > >  static int reserve_stacks(void)
> > >  {
> > >       /* make stack pointer 16-byte aligned */
> > > -     gd->start_addr_sp =3D reserve_stack_aligned(16);
> > > +     gd->start_addr_sp =3D reserve_stack_aligned(0);
> > >
> > >       /*
> > >        * let the architecture-specific code tailor gd->start_addr_sp =
and
> >
> > And this is the last call to reserve_stack_aligned(). So, this is going
> > to save us between 16 and 0 bytes of memory. If we're going to make a
> > change here we need to comment in the code more what we're up to at this
> > point, and the commit message should be more authoritatively worded too.
>=20
> So, other than that, what do you think? Should I respin it? Note that
> this is part of a series which I doubt will be applied to your tree.

I mean, yes, I've given you review comments. If you want this applied to
mainline someday then you need to address them.

> It would be nice if other archs could weigh in, but I see that I have
> not copied them. Still, the current code is confusing (in that the
> comment doesn't match the code), so we can likely figure this out in
> -next

Yes, my comment was that you need to make the comment match the code and
expand upon the common since I expect it's been that way for a decade+
at this point.

> Heinrich expressed some concerns with RISC-V, but there doesn't seem
> to be any breakage in CI. meminfo reports that the devicetree is above
> the stack and it semes intact:

Yes, I too was concerned about why exactly we're changing something here
with a commit message that sounds unsure if it's correct to make these
changes, only probably correct.

--=20
Tom

--LaHV/dKXNyCZ4PSX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdPDvoACgkQFHw5/5Y0
tyzK0Av/aWRVExqNbQBbsJ/02AXRofQsN3v+0Agu19+y7jjtFW+3mX2rgzeLullF
6aJqbhXsCEl86FGpkyNHlemYZL9ibdwchCKDzey2Nshm/7HtKIeu86wF1bcUyGuq
J0oAEBHcFIqBSJSIFTB3xtxuGqaMd2isrz7vUocJ5D5odfGEEZlYUKPX24twR07r
qqLG7KP2uxtCHW8n21JkZNvjdQGddQj/vp3Qxw+eIhsbuD0c/Nv5WLTNTHdjMSSY
GINKdlGVXHkbTTY7z++7U3jTz+ULlgOG/kxMiGlgCqgdA+iSMzLAN+7HU1nEnZ80
n51zeDiRMldD0AmDbcH4X1hDQrkwlxuoj5RuHVAOEWbxZXvNTGOZ2RdKVKQ9vUJ/
qtC1htgOJrdiH4pvoWe2JivfKJlX6gUhALVT206o9DXo03R3QSY45BBV70XYJyI5
ii7iKYFhLhU1dMlvooVE/NEFH1lFBYb1x9UhywmyCHm9zKwP4pbN+Bj8cduDgB0m
s3DMP3D+
=fXsn
-----END PGP SIGNATURE-----

--LaHV/dKXNyCZ4PSX--
