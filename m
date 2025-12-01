Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB4FD116F3
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 18:27:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD0CB83D01;
	Mon,  1 Dec 2025 19:27:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Lk4aYAAI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BE6E83D01; Mon,  1 Dec 2025 19:27:36 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E03583CAA
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 19:27:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7c77ed036c3so2845555a34.0
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 10:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764613652; x=1765218452; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vmwAxuTQJaUodfsomcnFYuXztWWOo4o4n9olIlSYuNw=;
 b=Lk4aYAAI+Q5hgA4PV29CyYefMhya3EoOAwC1LEL6x5WOumCU/vfVUWZnMO83zR8UxB
 Wsbda30/r2kNCmSewZHOyYwsbYhcFpOAkqII6qxcvFmeWUBDAdj9jGCIwkMeDTy44s33
 dO8Mqg4va8fPGh35O0okwQtNYpEv3OGdDFhf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764613652; x=1765218452;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vmwAxuTQJaUodfsomcnFYuXztWWOo4o4n9olIlSYuNw=;
 b=io0ZP6amK9UhZBQsuw0t+evEL/1nU9jzk+WC8US3+0jsA6YtClF59DmVbEiQbLRCXj
 ueUsr6U0TAJuXKgN6swUGe/GF6CjXWZwVrdfEQg8CZosV4luRMyP4uJAvZdmZBGc28EB
 gkr9dFSFvtIzbIajC9mZ8/pbgjBxIl7FlXVtHor+tEowOd/jyeG3DHmXPIHpffk5xIoI
 GLIXjhKfVmrSH3JikiDpBqjiqYuEFbFRuuxE33/+wCOj353KwFA4FJgEg2MFsOGKmsWv
 6qHc8GBhEwzSllcEa/U2oaF1NABjJDbGHPvtrHv0AdwPtcuu2ypZulTjrqC23TGbU2FS
 gFPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVFVBO2BZyJjFmzIb4NWcwWPirkAb5CJixyFW4v0NrqDhewCFaT5U2P4rxu9EmXqxTOxbSrGI=@lists.denx.de
X-Gm-Message-State: AOJu0YzSfuLG5fKrcs2Wcv7yApDhNk7CcNig07SjA48P52jCtdLoe/at
 IapWil9dPnUc1agYZDFAaAmT9NsLdCRuWD4IsOorxt+QtNk4xWzEiqmUvT4pWOyyj+g=
X-Gm-Gg: ASbGncvSZiUL4pAaKusBCGx23iy9WbBqX9y/VD9GGep4XspYsodA515rNeA8C7WoeT4
 +Di0xXn0Q/KnMHBKNLnxGyjfJmBPepDPPVyJofNcyuUh7q6zceSWQPpIqSZApOjTy5M1WPfTUE0
 OYJjj4nSkJ49+/qJVLnNFZ2XegfJrCjyxDhKB4HygUrmB3Vx4BKSREvMQj2zDewZnhd0po4cYYV
 ITn0PwS9QL8mZwKUyzTi+Fxc1EoQyPch6fjFIczbhO6RsInLGfbyTYIL1JCNqzlTfcf3Jyty4uf
 FSkTkMO+/dKw914SWc0x1DbkqeL+MvTgv4ypq1i+U4FZtwXVU5PqK1tI6e+o/rTtD5J8dqctZKO
 Z94YUKHahZtPdjyEO4kcMl6thB83g/1HbLaI/0jxA/1U5rhYX3K/mQncLDwv/xlz9R0bNYkQ8aH
 2xxvQf2xzBYtwkHz8Am0r4FlOSBr26AHQY0K6Dqykxv72CY8k/gVI4M2mAJ+DA
X-Google-Smtp-Source: AGHT+IFCmmTwYvXGb00jKI9GcFRmzPyKVhyfVL0gXUbbT1TZ92c63f8NKjKAA6epQyiHzosw2vjuag==
X-Received: by 2002:a9d:760b:0:b0:7c6:9fc6:1346 with SMTP id
 46e09a7af769-7c78ea8a4a9mr16549527a34.8.1764613652086; 
 Mon, 01 Dec 2025 10:27:32 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c910025e06sm4924161a34.28.2025.12.01.10.27.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 10:27:31 -0800 (PST)
Date: Mon, 1 Dec 2025 12:27:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Sune Brian <briansune@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: Re: [PATCH v1 2/8] arm: Fix "file truncated" linker errors from
 empty built-in.a in SPL/TPL/VPL builds
Message-ID: <20251201182729.GP303283@bill-the-cat>
References: <20251128153130.GC2125796@bill-the-cat>
 <CAC_iWjKp1ztEW23e7rujk-oFuYS_qfMi+CF+VEdwcCHmXrtgkg@mail.gmail.com>
 <20251128164957.GD2125796@bill-the-cat>
 <CAN7C2SCpM4V3GL=_tox+9ePEx6DcVNK+pdfxn_ysiOyvYuEn+A@mail.gmail.com>
 <20251201164405.GG303283@bill-the-cat>
 <CAN7C2SBPwcPdUQeufJ+c3XxVKVmU4PE7nbYqLaNy9ynqkWhJgA@mail.gmail.com>
 <20251201165422.GI303283@bill-the-cat>
 <CAN7C2SBP7_kGmuXN2J5CF97ebxSpxtmtZ81_kGPjcV=_n-FyQw@mail.gmail.com>
 <20251201170938.GL303283@bill-the-cat>
 <CAN7C2SDmv=0gubdEy_ikENQWy47UGFa9JHv+E-QZO2GCZnz_Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7LY+6fmZHtH2m5Es"
Content-Disposition: inline
In-Reply-To: <CAN7C2SDmv=0gubdEy_ikENQWy47UGFa9JHv+E-QZO2GCZnz_Rw@mail.gmail.com>
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


--7LY+6fmZHtH2m5Es
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 02, 2025 at 01:59:53AM +0800, Sune Brian wrote:
> Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B412=E6=9C=882=E6=97=
=A5=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=881:09=E5=AF=AB=E9=81=93=EF=BC=9A
>=20
> >
> > On Tue, Dec 02, 2025 at 01:07:00AM +0800, Sune Brian wrote:
> > > Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B412=E6=9C=882=E6=
=97=A5=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8812:54=E5=AF=AB=E9=81=93=EF=BC=9A
> > > >
> > > > On Tue, Dec 02, 2025 at 12:52:06AM +0800, Sune Brian wrote:
> > > > > Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B412=E6=9C=882=
=E6=97=A5=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8812:44=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > > > > >
> > > > > > On Sat, Nov 29, 2025 at 08:46:14AM +0800, Sune Brian wrote:
> > > > > > > Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B411=E6=9C=
=8829=E6=97=A5=E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=8812:50=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > > > > > > >
> > > > > > > > On Fri, Nov 28, 2025 at 06:44:12PM +0200, Ilias Apalodimas =
wrote:
> > > > > > > > > On Fri, 28 Nov 2025 at 17:31, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > > > > > > >
> > > > > > > > > > On Fri, Nov 28, 2025 at 10:11:53AM +0800, Yuslaimi, Ali=
f Zakuan wrote:
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > On 27/11/2025 11:09 pm, Marek Vasut wrote:
> > > > > > > > > > > > [CAUTION: This email is from outside your organizat=
ion. Unless you trust
> > > > > > > > > > > > the sender, do not click on links or open attachmen=
ts as it may be a
> > > > > > > > > > > > fraudulent email attempting to steal your informati=
on and/or compromise
> > > > > > > > > > > > your computer.]
> > > > > > > > > > > >
> > > > > > > > > > > > On 11/27/25 3:12 AM, Yuslaimi, Alif Zakuan wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > Hello everyone,
> > > > > > > > > > > >
> > > > > > > > > > > > > I already have the referenced commit in my test b=
ranch, and I can
> > > > > > > > > > > > > confirm that the same compilation error still app=
ears on CycloneV when
> > > > > > > > > > > > > certain directories produce no SPL objects.
> > > > > > > > > > > > >
> > > > > > > > > > > > > The existing fix ensures that built-in.o is alway=
s present, but it does
> > > > > > > > > > > > > not prevent ar from generating empty built-in.a a=
rchives, which older
> > > > > > > > > > > > > ARM 32-bit linkers (such as CycloneV toolchains) =
reject as =E2=80=9Cfile
> > > > > > > > > > > > > truncated=E2=80=9D.
> > > > > > > > > > > >
> > > > > > > > > > > > Which toolchain is this ?
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > I am using Linaro arm-linux-gnueabihf GCC 7.5.0 to co=
mpile our SoC32 devices
> > > > > > > > > > > - CycloneV and Arria10
> > > > > > > > > >
> > > > > > > > > > Ilias, do you recall the solution to this problem from =
when it came up
> > > > > > > > > > on IRC a few weeks ago?
> > > > > > > > >
> > > > > > > > > Nop unfortunately not.
> > > > > > > > > Was this caused by the Kbuild bump? I remember the logic =
around
> > > > > > > > > builtin changing significantly.
> > > > > > > >
> > > > > > > > Yes, and I kinda thought we narrowed it down to something b=
eing missing
> > > > > > > > from the update, since the kernel does support this old of =
a toolchain
> > > > > > > > (or at least the 10.x? someone else this on).
> > > > > > >
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > Actually I am not sure u-boot itself have minimum requirement=
 on each tag
> > > > > > > or branch listed?
> > > > > >
> > > > > > We do not currently have a test for anything other than "newer =
than
> > > > > > gcc-6" for ARM, but should have the same minimum requirements a=
s the
> > > > > > linux kernel, but are lacking enforcement checks (but I also th=
ink the
> > > > > > kernel is?).
> > > > > >
> > > > > > --
> > > > > > Tom
> > > > >
> > > > > Hi Tom,
> > > > >
> > > > > Oops, missing the kernel version. Add it back for better debug.
> > > >
> > > > Sorry, what I meant was that it's a kbuild related issue as to what
> > > > version of gcc can be used. We don't have a check, and should, but =
also
> > > > the versions in question here should be expected to work. There's j=
ust
> > > > some change we're missing.
> > > >
> > > > --
> > > > Tom
> > >
> > > So long story short this patch itself should not introduce from begin=
ning.
> > > It is a GCC version depended issue.
> > > But how to pin-point down to which version is a bit hard.
> > > Distro link with GCC version and not all gcc version can easily check=
ed.
> > >
> > > Any idea how to easily check this?
> >
> > We can use the check we have today in arch/arm/config.mk under
> > "checkgcc6" to check for something much newer. But! It's a problem of a
> > missing kbuild change I think, based on when this problem was first
> > reported.
> >
> > --
> > Tom
>=20
> Tom,
>=20
> For GCC version sub-version do not matters?
> For example 6.x.x 7.x.x 8.x.x
> Or 9.3 9.4 etc also matters?
> So to determine the supported version it just need to pin-point to
> the major GCC version?
> Then the possible version break only <=3D10 or <10?
> Based on the previous build success case.
> 9.2.0 fails 11.4.0 passed.

Looking through logs now, I see the kernel says 8.1 or newer:
https://www.kernel.org/doc/html/latest/process/changes.html which is why
I have been saying there's an underlying kbuild problem (missing
change(s)) that needs to be resolved. I don't know if 10.x works or
fails, but that's still beside the point to me as 9.2.0 should work.

--=20
Tom

--7LY+6fmZHtH2m5Es
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaS3eBwAKCRAr4qD1Cr/k
CrV/AP0YnDNFjVGCNokFPLMBlYtgqTR2R5WIK55xkK7sWVsC/gD+Ph7XR7Bcwn4q
R1XFUvXRq6r3w6JcqYdj0Wx+fm30mAQ=
=oq5V
-----END PGP SIGNATURE-----

--7LY+6fmZHtH2m5Es--
