Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EB6C54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 14:56:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE09582E8C;
	Mon, 26 May 2025 16:56:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jDNIUKCx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A126F82EA3; Mon, 26 May 2025 16:56:43 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4487982B07
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 16:56:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-400fa6eafa9so1343861b6e.1
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 07:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748271400; x=1748876200; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JoG7vHLqv2UhTtvCy71r6D8xtKOhpHUNskao/JjFu1w=;
 b=jDNIUKCxE/4vGVq0nNYWis/WRnJfSUhaSPFrbMdJ29pDsYRKswjCzh19cxxZSmTIwn
 MQW2iyFYEHMqyHy7o8egUJArnVpy5+reFkvUXEomom9uwhLevNdn1UshbSdaQTLT8t/3
 lI9PL97qhQB3c1/BhGTlG7RyfWn/2dBp8t/V4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748271400; x=1748876200;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JoG7vHLqv2UhTtvCy71r6D8xtKOhpHUNskao/JjFu1w=;
 b=qxVCE1iodZ6MMoI2IOkrdQsVl5qW/W9DfpuTmuf2PNHLqhRUC9jMfYA1t2o/A7EnD2
 N81aztQSmmhF5Is+7eLS0qAXkPBi9jQFKJt811kelTszt+92nTBa3aFCR7GepFOTXEec
 MAhy68GiKwLYbRbSQlcrwZEJk8hQ59CsScOiDQVs57pvFQx0XZHt+C3uiqE8I7El9r0L
 3sITfEVfyFua7QIIRfHomy97pfFHfyhOK6uKLAvDuIPCkl5zg5SapII5vu4zeONayhrW
 6sFZOf4wLj1nwjexEY7BC8eWEl/SHfHOgjhJW6iNHudVbhPFg7/POM5jn+Cgn4akSpYv
 JDng==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzOYx/jDFiMeU9kcP6Xn16wS+sMq+zW0Y4h2lUIOtVzQIUKg0X+qjZTzgkD4WR+Ie4mv1onxw=@lists.denx.de
X-Gm-Message-State: AOJu0YyQ1wwRTluVjzMefflEFZoX4PNeTXQvB4KehiaTyIw6x9/NpatK
 LsfPhkToaPAmRyG+dapM8YcMxkv6n/J9XpXLwZiPGtF6b0Yi7HzGuJMGlpI8ErGqkP8=
X-Gm-Gg: ASbGncs+N7EjnRzA0wRe8blPC/LJWNZMBsRf2hb0Zo/3aRxkZvEAPmRlRFGP6lLokrE
 X6D0RrF2CqtQ3eMf6LMkopHJEM64EEIlcnc0aNYZ4KepYLvFHfwwtY3k9Bz44Hry7V4QQOKo5Ll
 DLRZgkNnF3nFUw+lFRgruddcprEbVMmdiyziaLwoWRXg4zCW8e8+SORUgNWOXGoP/W5gA0k4UIP
 JDeNeYgAB4e0qwrXHZoqcyytKtgHv3KaFL/fb+2K7FhUMO7aq7S0Itoq5jqlKk3CECcpakFK6qj
 zz/9OXxN6bkDlG93TRnG9b7k5P0omJfWHapwoTXUWFyl/G0ABAfPGnlcGfit692yHqVAkqOpBVA
 x8z3kDD0U0XeY
X-Google-Smtp-Source: AGHT+IEmxT2oseNuHkppLAtAoWf8MYWBNJntb8LgxTY0E0e8CTQ8HR0O7tkXpSXOcDj5IWIW+e2RaA==
X-Received: by 2002:a05:6808:640e:b0:401:e7c0:62bd with SMTP id
 5614622812f47-406467c412fmr4953988b6e.3.1748271399836; 
 Mon, 26 May 2025 07:56:39 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-404d98b2785sm4258117b6e.33.2025.05.26.07.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 07:56:38 -0700 (PDT)
Date: Mon, 26 May 2025 08:56:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Conor Dooley <conor@kernel.org>
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Yao Zi <ziyao@disroot.org>, Leo Liang <ycliang@andestech.com>,
 u-boot@lists.denx.de, rick@andestech.com
Subject: Re: [GIT PULL] u-boot-riscv/master
Message-ID: <20250526145636.GX100073@bill-the-cat>
References: <aC2hyzxwKzO4k1im@swlinux02>
 <174785279069.2062062.17616710293064147131.b4-ty@konsulko.com>
 <20250522-eradicate-clip-538f48710ad7@spud>
 <aC9TmaY7w2PL8lbn@pie.lan>
 <CAN37VV4y58GeqbviFaJDCr1vqLc5tKaTcBLg4_PmeHF-As6tAw@mail.gmail.com>
 <20250526-disband-cover-cdc6567452f2@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NF2BiAr24Tge8P9u"
Content-Disposition: inline
In-Reply-To: <20250526-disband-cover-cdc6567452f2@spud>
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


--NF2BiAr24Tge8P9u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 10:17:54AM +0100, Conor Dooley wrote:
> On Mon, May 26, 2025 at 09:02:46AM +0530, Mayuresh Chitale wrote:
> > On Thu, May 22, 2025 at 10:11=E2=80=AFPM Yao Zi <ziyao@disroot.org> wro=
te:
> > >
> > > On Thu, May 22, 2025 at 12:28:18PM +0100, Conor Dooley wrote:
> > > > On Wed, May 21, 2025 at 12:39:50PM -0600, Tom Rini wrote:
> > > > > On Wed, 21 May 2025 17:50:03 +0800, Leo Liang wrote:
>=20
> > > > This PR seems to have made my CI blow up, and I'm not entirely sure=
 if
> > > > that's something intentional or not. I've not yet bisected, but sin=
ce
> > > > the error is "Image arch not compatible with host arch", I can only
> > > > imagine the patch in question is:
> > > > | Subject: [PATCH v2 1/3] riscv: image: Add new image type for RV64
> > > > | Date: Fri,  4 Apr 2025 14:48:55 +0000       [thread overview]
> > > > | Message-ID: <20250404144859.112313-2-mchitale@ventanamicro.com> (=
raw)
> > > > | In-Reply-To: <20250404144859.112313-1-mchitale@ventanamicro.com>
> > > > |
> > > > | Similar to ARM and X86, introduce a new image type which allows u=
-boot
> > > > | to distinguish between images built for 32-bit vs 64-bit Risc-V C=
PUs.
> > > > |
> > > > | Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> > > > | Reviewed-by: Maxim Moskalets <maximmosk4@gmail.com>
> > > > | ---
> > > > |  boot/image.c    | 3 ++-
> > > > |  include/image.h | 3 ++-
> > > > |  2 files changed, 4 insertions(+), 2 deletions(-)
> > > > |
> > > > | diff --git a/boot/image.c b/boot/image.c
> > > > | index 139c5bd035a..45299a7dc33 100644
> > > > | --- a/boot/image.c
> > > > | +++ b/boot/image.c
> > > > | @@ -92,7 +92,8 @@ static const table_entry_t uimage_arch[] =3D {
> > > > |     {       IH_ARCH_ARC,            "arc",          "ARC",       =
   },
> > > > |     {       IH_ARCH_X86_64,         "x86_64",       "AMD x86_64",=
   },
> > > > |     {       IH_ARCH_XTENSA,         "xtensa",       "Xtensa",    =
   },
> > > > | -   {       IH_ARCH_RISCV,          "riscv",        "RISC-V",    =
   },
> > > > | +   {       IH_ARCH_RISCV,          "riscv",        "RISC-V 32 Bi=
t",},
> > > > | +   {       IH_ARCH_RISCV64,        "riscv64",      "RISC-V 64 Bi=
t",},
> > > > |     {       -1,                     "",             "",          =
   },
> > > > |  };
> > > > |
> > > > | diff --git a/include/image.h b/include/image.h
> > > > | index 07912606f33..411bfcd0877 100644
> > > > | --- a/include/image.h
> > > > | +++ b/include/image.h
> > > > | @@ -138,7 +138,8 @@ enum {
> > > > |     IH_ARCH_ARC,                    /* Synopsys DesignWare ARC */
> > > > |     IH_ARCH_X86_64,                 /* AMD x86_64, Intel and Via =
*/
> > > > |     IH_ARCH_XTENSA,                 /* Xtensa       */
> > > > | -   IH_ARCH_RISCV,                  /* RISC-V */
> > > > | +   IH_ARCH_RISCV,                  /* RISC-V 32 bit*/
> > > > | +   IH_ARCH_RISCV64,                /* RISC-V 64 bit*/
> > > > |
> > > > |     IH_ARCH_COUNT,
> > > > |  };
> > > > | --
> > > > | 2.43.0
> > > > |
> > > > since it is changing the existing "riscv" image type to be the 32-b=
it
> > > > image and requiring the new entry for 64-bit. My CI job uses the sy=
stem
> > > > mkimage to create the image that U-Boot is loading, so it doesn't k=
now
> > > > about the new define etc. Maybe it's not considered a problem if a =
new
> > > > U-Boot cannot boot an old image, but the comment above the enum rea=
ds:
> > > > |/*
> > > > | * CPU Architecture Codes (supported by Linux)
> > > > | *
> > > > | * The following are exposed to uImage header.
> > > > | * New IDs *MUST* be appended at the end of the list and *NEVER*
> > > > | * inserted for backward compatibility.
> > > > | */
> > > > The overwhelming majority of existing supported boards in U-Boot are
> > > > 64-bit platforms, and the 64-bit platforms are the ones that have b=
een
> > > > supported for longer, so my thought would be that the compatibility=
 of
> > > > 64-bit platforms should be prioritised over 32-bit? Or even add exp=
licit
> > > > 32-bit and 64-bit entries and the existing one is a catch-all for
> > > > compatibility reasons?
> > >
> > > I've mentioned entries with bitwidth explicitly specified in my previ=
ous
> > > reply (and there hasn't been any response).
> > >
> > > > I'll consider IH_ARCH_RISCV32 a better idea, instead of implying 32=
bit
> > > > when no suffix attached. We (and the Linux kernel) mix 32-bit and 6=
4-bit
> > > > variants of RISC-V together, thus it's hard to tell the exact bitwi=
dth
> > > > of "IH_ARCH_RISCV" without inspecting the code around. To me, it so=
unds
> > > > more like "RISC-V, but no bitwidth specified".
> > > >
> > > > It will be nice if we could avoid this kind of ambiguity.
> > >
> > > (referring my own reply[1])
> > >
> > > I'll second explicit 32-bit and 64-bit entries, and keeping
> > > IH_ARCH_RISCV for compatibility consideration.
> > >
> > Are you suggesting something like this :
> >=20
> > { IH_ARCH_RISCV, "riscv", "RISC-V",},
> > { IH_ARCH_RISCV32, "riscv32", "RISC-V 32 Bit",},
> > { IH_ARCH_RISCV64, "riscv64", "RISC-V 64 Bit",},
> >=20
> > I tried to implement it like on ARM64. However the problem is that
> > while on ARM64 it switches to aarch32 if it encounters an IH_ARCH_ARM
> > kernel image, there is no equivalent mechanism for Risc-V yet.
>=20
> But we don't even want that, since the current behaviour on a 64-bit
> system is not to do anything 32-bit related, right? My 64-bit images
> created with my system mkimage use IH_ARCH_RISCV.
>=20
> > Another
> > option could be to disable this check in the bootm flow for now until
> > a similar mechanism is implemented on Risc-V.
>=20
> Why not just allow IH_ARCH_RISCV to retain the current "dumb" behaviour
> permanently, and only implement the strict checking when the explicit
> width types are detected?

This seems most reasonable to me for the current situation.

--=20
Tom

--NF2BiAr24Tge8P9u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg0gSQACgkQFHw5/5Y0
tyymVQv7B+3Spgb9wfsNF3rdLQ6uKToCVXZPz16C73/2DAPEI9/nAgmMeses5lqG
9gEkzW/OHSuwvhmjf+uLxNXRdf05txek+d/mjjfqHJ6XqVF20/RPf+QN2hT2tq2/
gE6dJUWDdfe6EcWGSZEQwku9cRLB3co5UiU0tW9wy1q+O4xzUuK5C9+6mPbxsInG
HxcY2mA3V6DM4ZccqcGqLArHOVZ5j2h9UXG0UP8N2FZm7Do2sj9tA3wuh1rRvY1+
OZUJPt3TMme1fn0GeQYnkkZS75/jAvPT/Lx0YlerHqzgKaX3JahMCi0B4b5hQLEA
eVi6491Y8cHaVRPxSP6D2PjVr4d1UD1EdI63U9zitzTf8/ljyaaRqPlac4GSDqDg
cjOHUFkGKg8BDu+BS+iTWZGCqRQN1NZzgrNDMdvplek8HRUb/qdylCExEjaHwJzR
NibGhqv/e3nwCbPu0/G4pF8dHUayktyG6oZlW8NEz6VQ9NYcsh8/uQTjAT2p8449
sp1Rtquo
=MASi
-----END PGP SIGNATURE-----

--NF2BiAr24Tge8P9u--
