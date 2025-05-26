Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8AB6C5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 18:16:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EA1682E25;
	Mon, 26 May 2025 20:16:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cbXP0o8B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76A2082E35; Mon, 26 May 2025 20:16:38 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2314C82D4A
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 20:16:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2d54b936ad9so969945fac.1
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 11:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748283395; x=1748888195; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WrzBhEB7paIiHrAMjBUc5aAQUHC99wduHRbtfxU9ZZs=;
 b=cbXP0o8BZWsyDmuI9BNy/ujpq/6r8Amaw5+L2SFp47qHcAr47MVltRCNRL4nY18xt0
 l+Wu1/4QkXInSmQAOhP1PeucPnw6fOgCivc/DnIKC4ygVl/6Nsfk2YusAjoOzQi1zEhz
 5X8WBL0RYY61UlVrX/7GvQHi0thVgRt/4yQrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748283395; x=1748888195;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WrzBhEB7paIiHrAMjBUc5aAQUHC99wduHRbtfxU9ZZs=;
 b=W3V+fWRNoMeBI5/DGdoBP8VEl4kyj78HR6Sil/663h6RpYFyy+sE4d77I9nEHFJYtp
 zpIJiuljIv2FP4kNTiK4Yi6X7/yo3+phkEdOuI3WfpezwNUAJPh/QxUH3r3T5Vs2DZf5
 02GNq6bicYFDuPI3aTE3Qv9pJ0Ak+U4MhGy6YW3qV1I1ApAGwSjyde+fk1ln2ie40BSZ
 6cCFX0kZRbs8/TcNIl1XEgW9mkFCI8YTeAoRuvF6Z/+BlIa7Jq3UoM2B7UkBnsIGxsKh
 4Z4yCP5E3IaqLhcB+VUNuUGmH32+QnujpzxezeKSUgA9fdXvdlWTgfjWxTbFSqauOvqq
 kZuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCMN26ucfZy56431cLsyBD3miqJbnPNDMPVXq8JbvcBlf3HDnqgVJRIRxsTUWjwjCd08LA6cA=@lists.denx.de
X-Gm-Message-State: AOJu0YzVLwHI95MDgzqWrve2lgseCV/xMud1GQ4LU7CHBuVLmiwsasRA
 4ohZSiLyje2zY28A+RS9bsQWXwQ8uNF7tBiZuej5YP8O+J5VN9PWcfCaJnVcSWsQWo8=
X-Gm-Gg: ASbGncsXZH793ZwmCrFge1N/Lr+dH7JLFXwoBXz25UcXjlF8nTS6NdZ64mX9jWWWpnw
 N7q3RR0fWys5CT1BcdEbPI7PU2meospv1H0lwhJEj6cXgWwLsuibzi3kVcTYeKLvB3Px2xWQolw
 UHVzGDMoTEhhU10f/jUbbaoqaPIR+Zf5Eji5vB5yt4k8AZunPlH9Qho7jX9k+kmzlJwHGHGpUrx
 SQeDqsYczh6xPe2v34tcZ5Nu9Yj4pm2R6EwWA4Yl8Hu8xjwRpNtkoSYntD0zixLV4gCAxUAk+xv
 vgAnRxhER+2ZRM8WoICbNE6nwrPUs9q6ey9wW6P2HFCn5+wFnGjgjXjHbSwrnTdwPexxqtcOofa
 f+pJeFlXkHNe2u4d6EJIoy0c=
X-Google-Smtp-Source: AGHT+IGnEKaLSRk+Dja8DeaEC1OoM4rgVDSM4Jh/chUa1i0kfOq/AEsqsaCqSA6V18tUuGL6qS9W2Q==
X-Received: by 2002:a05:6871:a691:b0:2e4:140:4b1f with SMTP id
 586e51a60fabf-2e86200b85fmr5018111fac.17.1748283394717; 
 Mon, 26 May 2025 11:16:34 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e3c0b21cb2sm4896820fac.46.2025.05.26.11.16.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 11:16:33 -0700 (PDT)
Date: Mon, 26 May 2025 12:16:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: Conor Dooley <conor@kernel.org>, Yao Zi <ziyao@disroot.org>,
 Leo Liang <ycliang@andestech.com>, u-boot@lists.denx.de, rick@andestech.com
Subject: Re: [GIT PULL] u-boot-riscv/master
Message-ID: <20250526181631.GA100073@bill-the-cat>
References: <aC2hyzxwKzO4k1im@swlinux02>
 <174785279069.2062062.17616710293064147131.b4-ty@konsulko.com>
 <20250522-eradicate-clip-538f48710ad7@spud>
 <aC9TmaY7w2PL8lbn@pie.lan>
 <CAN37VV4y58GeqbviFaJDCr1vqLc5tKaTcBLg4_PmeHF-As6tAw@mail.gmail.com>
 <20250526-disband-cover-cdc6567452f2@spud>
 <20250526145636.GX100073@bill-the-cat>
 <CAN37VV6SLVFmfxjbhs8YYEBpzdE8FqjstNh5Xw+DAUx5tC05FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cZEs7YTzMVc6xQ8s"
Content-Disposition: inline
In-Reply-To: <CAN37VV6SLVFmfxjbhs8YYEBpzdE8FqjstNh5Xw+DAUx5tC05FQ@mail.gmail.com>
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


--cZEs7YTzMVc6xQ8s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 11:04:02PM +0530, Mayuresh Chitale wrote:
> On Mon, May 26, 2025 at 8:26=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Mon, May 26, 2025 at 10:17:54AM +0100, Conor Dooley wrote:
> > > On Mon, May 26, 2025 at 09:02:46AM +0530, Mayuresh Chitale wrote:
> > > > On Thu, May 22, 2025 at 10:11=E2=80=AFPM Yao Zi <ziyao@disroot.org>=
 wrote:
> > > > >
> > > > > On Thu, May 22, 2025 at 12:28:18PM +0100, Conor Dooley wrote:
> > > > > > On Wed, May 21, 2025 at 12:39:50PM -0600, Tom Rini wrote:
> > > > > > > On Wed, 21 May 2025 17:50:03 +0800, Leo Liang wrote:
> > >
> > > > > > This PR seems to have made my CI blow up, and I'm not entirely =
sure if
> > > > > > that's something intentional or not. I've not yet bisected, but=
 since
> > > > > > the error is "Image arch not compatible with host arch", I can =
only
> > > > > > imagine the patch in question is:
> > > > > > | Subject: [PATCH v2 1/3] riscv: image: Add new image type for =
RV64
> > > > > > | Date: Fri,  4 Apr 2025 14:48:55 +0000       [thread overview]
> > > > > > | Message-ID: <20250404144859.112313-2-mchitale@ventanamicro.co=
m> (raw)
> > > > > > | In-Reply-To: <20250404144859.112313-1-mchitale@ventanamicro.c=
om>
> > > > > > |
> > > > > > | Similar to ARM and X86, introduce a new image type which allo=
ws u-boot
> > > > > > | to distinguish between images built for 32-bit vs 64-bit Risc=
-V CPUs.
> > > > > > |
> > > > > > | Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> > > > > > | Reviewed-by: Maxim Moskalets <maximmosk4@gmail.com>
> > > > > > | ---
> > > > > > |  boot/image.c    | 3 ++-
> > > > > > |  include/image.h | 3 ++-
> > > > > > |  2 files changed, 4 insertions(+), 2 deletions(-)
> > > > > > |
> > > > > > | diff --git a/boot/image.c b/boot/image.c
> > > > > > | index 139c5bd035a..45299a7dc33 100644
> > > > > > | --- a/boot/image.c
> > > > > > | +++ b/boot/image.c
> > > > > > | @@ -92,7 +92,8 @@ static const table_entry_t uimage_arch[] =
=3D {
> > > > > > |     {       IH_ARCH_ARC,            "arc",          "ARC",   =
       },
> > > > > > |     {       IH_ARCH_X86_64,         "x86_64",       "AMD x86_=
64",   },
> > > > > > |     {       IH_ARCH_XTENSA,         "xtensa",       "Xtensa",=
       },
> > > > > > | -   {       IH_ARCH_RISCV,          "riscv",        "RISC-V",=
       },
> > > > > > | +   {       IH_ARCH_RISCV,          "riscv",        "RISC-V 3=
2 Bit",},
> > > > > > | +   {       IH_ARCH_RISCV64,        "riscv64",      "RISC-V 6=
4 Bit",},
> > > > > > |     {       -1,                     "",             "",      =
       },
> > > > > > |  };
> > > > > > |
> > > > > > | diff --git a/include/image.h b/include/image.h
> > > > > > | index 07912606f33..411bfcd0877 100644
> > > > > > | --- a/include/image.h
> > > > > > | +++ b/include/image.h
> > > > > > | @@ -138,7 +138,8 @@ enum {
> > > > > > |     IH_ARCH_ARC,                    /* Synopsys DesignWare AR=
C */
> > > > > > |     IH_ARCH_X86_64,                 /* AMD x86_64, Intel and =
Via */
> > > > > > |     IH_ARCH_XTENSA,                 /* Xtensa       */
> > > > > > | -   IH_ARCH_RISCV,                  /* RISC-V */
> > > > > > | +   IH_ARCH_RISCV,                  /* RISC-V 32 bit*/
> > > > > > | +   IH_ARCH_RISCV64,                /* RISC-V 64 bit*/
> > > > > > |
> > > > > > |     IH_ARCH_COUNT,
> > > > > > |  };
> > > > > > | --
> > > > > > | 2.43.0
> > > > > > |
> > > > > > since it is changing the existing "riscv" image type to be the =
32-bit
> > > > > > image and requiring the new entry for 64-bit. My CI job uses th=
e system
> > > > > > mkimage to create the image that U-Boot is loading, so it doesn=
't know
> > > > > > about the new define etc. Maybe it's not considered a problem i=
f a new
> > > > > > U-Boot cannot boot an old image, but the comment above the enum=
 reads:
> > > > > > |/*
> > > > > > | * CPU Architecture Codes (supported by Linux)
> > > > > > | *
> > > > > > | * The following are exposed to uImage header.
> > > > > > | * New IDs *MUST* be appended at the end of the list and *NEVE=
R*
> > > > > > | * inserted for backward compatibility.
> > > > > > | */
> > > > > > The overwhelming majority of existing supported boards in U-Boo=
t are
> > > > > > 64-bit platforms, and the 64-bit platforms are the ones that ha=
ve been
> > > > > > supported for longer, so my thought would be that the compatibi=
lity of
> > > > > > 64-bit platforms should be prioritised over 32-bit? Or even add=
 explicit
> > > > > > 32-bit and 64-bit entries and the existing one is a catch-all f=
or
> > > > > > compatibility reasons?
> > > > >
> > > > > I've mentioned entries with bitwidth explicitly specified in my p=
revious
> > > > > reply (and there hasn't been any response).
> > > > >
> > > > > > I'll consider IH_ARCH_RISCV32 a better idea, instead of implyin=
g 32bit
> > > > > > when no suffix attached. We (and the Linux kernel) mix 32-bit a=
nd 64-bit
> > > > > > variants of RISC-V together, thus it's hard to tell the exact b=
itwidth
> > > > > > of "IH_ARCH_RISCV" without inspecting the code around. To me, i=
t sounds
> > > > > > more like "RISC-V, but no bitwidth specified".
> > > > > >
> > > > > > It will be nice if we could avoid this kind of ambiguity.
> > > > >
> > > > > (referring my own reply[1])
> > > > >
> > > > > I'll second explicit 32-bit and 64-bit entries, and keeping
> > > > > IH_ARCH_RISCV for compatibility consideration.
> > > > >
> > > > Are you suggesting something like this :
> > > >
> > > > { IH_ARCH_RISCV, "riscv", "RISC-V",},
> > > > { IH_ARCH_RISCV32, "riscv32", "RISC-V 32 Bit",},
> > > > { IH_ARCH_RISCV64, "riscv64", "RISC-V 64 Bit",},
> > > >
> > > > I tried to implement it like on ARM64. However the problem is that
> > > > while on ARM64 it switches to aarch32 if it encounters an IH_ARCH_A=
RM
> > > > kernel image, there is no equivalent mechanism for Risc-V yet.
> > >
> > > But we don't even want that, since the current behaviour on a 64-bit
> > > system is not to do anything 32-bit related, right? My 64-bit images
> > > created with my system mkimage use IH_ARCH_RISCV.
> > >
> > > > Another
> > > > option could be to disable this check in the bootm flow for now unt=
il
> > > > a similar mechanism is implemented on Risc-V.
> > >
> > > Why not just allow IH_ARCH_RISCV to retain the current "dumb" behavio=
ur
> > > permanently, and only implement the strict checking when the explicit
> > > width types are detected?
> >
> > This seems most reasonable to me for the current situation.
>=20
> Ok. In that case, I think the patch set needs to be reverted.

Please post a revert and Link: to this thread, thanks!

--=20
Tom

--cZEs7YTzMVc6xQ8s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg0r/8ACgkQFHw5/5Y0
tyw3eAv+JOfcCcV2pXRqR+H5oL5qjS6q+K66+onwP/ezGX841HNMoS0BFu3OWlo6
gQlkHLIcYCz1sQf/PWG2IWPoCGC3zMpbLQCBUd4ahOdVL8SisA1F39CNBfvkeBug
nZFuQM94vzXwQoHlPqYPC5n/HDhyAti2Fs4v0IrhwqtWtmXMTXwsqylysIsoIFvi
IRuq/RAnmG9piUw1x3HfjjlNFtOLQcSa7GZr8lDcHTYWhmcDtyB8mXL7bwNNSVZI
O362X85SynSTZi8BGO6k2DkGwBmNYWiO/TcTOSkjjKMDOIyxxWp2qc0p4+TvnM94
ZJT2fIqRjrgrfYp4O+4fLTdQ2pK/sLOl8uE8Twt01ZUt5hJzzDyX1Ct+k7S49CHg
Uz1FGuIA4Ocy13PFWbOlO838F0//TMUneb32crns1dOHgLi8kTaZ0yeqih0sfXDG
yy+A6k49117RJz37ExA9fso0m5AHb4wAfad1Xh03qlYpsrp9OfltdRmitCiHWYED
Uogvj69H
=psHM
-----END PGP SIGNATURE-----

--cZEs7YTzMVc6xQ8s--
