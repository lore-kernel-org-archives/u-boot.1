Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C82C021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 23:20:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3835880F91;
	Sat, 22 Feb 2025 00:20:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OmXUY93I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7609A806FE; Sat, 22 Feb 2025 00:20:15 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13C5880F53
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 00:20:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2fbfa8c73a6so5330053a91.2
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 15:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740180010; x=1740784810; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jAzGHmdTJx4VRy1cc6Lcz0qpmtrlVVNHMq9pp8B3F6Y=;
 b=OmXUY93I87r9Di9is1ACsWXn5Z1u15bdCgPStpOpnPOV2XuKybkLo8yJf4cOOQTTYi
 Ni26whhh06XJmhu7PAb73gs/pufVX5oI9d5zGOc/yu3iPs212Bw9/K7v1b5TG19KveWB
 6X9sEhMnkiIXSOe99Q/YhR42es4VCFd5+3QVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740180010; x=1740784810;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jAzGHmdTJx4VRy1cc6Lcz0qpmtrlVVNHMq9pp8B3F6Y=;
 b=jRNIbEqqzlq0Dj+cg6S9h9+Tor962BjRT5z/4GB6KCkufwkNnR2B0LkLaIA7+6AP8W
 RpNl5mBpG3D9feyoRv0Z8bN2kybu8rPTUmI8NbBJ6aY5C+vo1bl9KUD1b9aZdrFQsCom
 xITS8kUChq0uXN1oGgwE+AHBHyL1XOdqbR7RK3Z5/zJu729IfdRdAX5X+Tln4p1jRwSF
 /uH1xqxJIO8yJ6gZFjVJen2DGhm1iwwWfMQpm+0hQBTVHKCjMkEnKOMtPpAdyrgyH58z
 ZWAHHIGpOSXY79JcF+qgN1pdFfU8Ms5IDIwAR9f85DPCMfsOsMhNeenu7ECBTPwCCdbL
 qoBA==
X-Gm-Message-State: AOJu0YzIi5ubIeIXpiosr7LW1HuzG8z1ny18wFECdfEENp3carbbdYXG
 mkK1xWqQ1oNdu+orAhPUpsz5kHukSfglFdGbE+QjwKwQWXhuRvCCnGZGo5BvNxs=
X-Gm-Gg: ASbGncvhp8fG/FSgs2pA72r0hHiT9KqVuvoUmFeWXPlU+uVhgEv8PWsiGGHosEdTput
 TkvB3wV5qwCRs2f4MxVyhgnLOr9fxcVDdFQv6QPGKy6w7ND5Ysq2P/xE2OgNeVfuO7LMLbe21W0
 LXqGkDrdhne5p/YQMDD9TmBCpLN+rQBFcKCS87iiSlwscrCjY+mkMWC1F5Uh1cIdt2Q8pfKhdK1
 nezsqME2oT7mFWa9yO1clD7jSSNZbq/56J7InrxscOhlukh0m7vtBtgnUclYOeB1IaYOe/uawJJ
 5HCUWtPlpeyhergs5BY9DxSO
X-Google-Smtp-Source: AGHT+IG7tLKvNiNpqqMUb//LmJCkAdQfPsBJ30zLdi96Equ5e+63Q1/DMJ1Gjqr9eDTlPOtEpQuzxQ==
X-Received: by 2002:a05:6a00:b8c:b0:730:957d:a7fe with SMTP id
 d2e1a72fcca58-73426c90ac0mr6966969b3a.1.1740180009046; 
 Fri, 21 Feb 2025 15:20:09 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ae5eddbcbe1sm5065953a12.50.2025.02.21.15.20.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 15:20:08 -0800 (PST)
Date: Fri, 21 Feb 2025 17:20:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: xPL Proposal
Message-ID: <20250221232005.GV1233568@bill-the-cat>
References: <CAFLszTgnP7wGymh58coQBP=Rbui2O=ggXDT+Yu1pcgvCoLuFXw@mail.gmail.com>
 <20250220151643.GZ1233568@bill-the-cat>
 <CAFLszTiKbg2twYpJJTFb9bFya+5D2DsVPBGKXuw9pw6Y+cvUbg@mail.gmail.com>
 <20250220174005.GA1233568@bill-the-cat>
 <CAFLszTh=Mn9Hxe41KBB+8xjBBxVv=spV=g26tY+Hq6q43EM4=w@mail.gmail.com>
 <20250220204001.GC1233568@bill-the-cat>
 <CAFLszTjx1uQU+O=XrS6BBijpiSNtdR_-X_9LCjYZCSe+A0HC8g@mail.gmail.com>
 <20250221141940.GG1233568@bill-the-cat>
 <20250221192556.GP1233568@bill-the-cat>
 <CAFLszTicfTaAih-h6zgUD2ND2584quCmiayOZ__3t2Y+Ps0Lpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Oji3i5HPCo5AuMn5"
Content-Disposition: inline
In-Reply-To: <CAFLszTicfTaAih-h6zgUD2ND2584quCmiayOZ__3t2Y+Ps0Lpg@mail.gmail.com>
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


--Oji3i5HPCo5AuMn5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 03:54:52PM -0700, Simon Glass wrote:
> Hi  Tom,
>=20
> On Fri, 21 Feb 2025 at 12:26, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Feb 21, 2025 at 08:19:40AM -0600, Tom Rini wrote:
> > > On Thu, Feb 20, 2025 at 06:30:18PM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Thu, 20 Feb 2025 at 13:40, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Thu, Feb 20, 2025 at 11:13:34AM -0700, Simon Glass wrote:
> > [snip]
> > > > > I will look at "splg4" once it's somewhere on source.denx.de and =
I can
> > > > > look at it, and refrain from otherwise assuming how it solves the
> > > > > problems I had seen previously.
> > > >
> > > > I pushed an updated version to dm/splg-working but it is not very
> > > > updated. Still needs more work.
> > >
> > > Thanks.
> >
> > So, after doing the remaining CONFIG_TEXT_BASE -> CONFIG_PPL_TEXT_BASE
> > changes, here's another example of the problem with your approach. What
> > stops xilinx_zynqmp_kria from building in splg-working is that
> > BUTTON was missing from scripts/conf_nospl. Annoyingly, a mrproper (or
> > since I always use O=3D, rm -rf) is needed for changes there to be pick=
ed
> > up, but that's maybe just a missing Makefile dependency line. But that
> > just makes it easier to see the next problem, which I don't see the
> > answer to. For PPL, we can build drivers/spi/zynqmp_gqspi.o just fine.
> > For SPL however:
> >   CC      spl/drivers/spi/zynqmp_gqspi.o
> > /home/trini/work/u-boot/u-boot/drivers/spi/zynqmp_gqspi.c: In function =
'zynqmp_qspi_of_to_plat':
> > /home/trini/work/u-boot/u-boot/drivers/spi/zynqmp_gqspi.c:203:22: warni=
ng: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> >   203 |         plat->regs =3D (struct zynqmp_qspi_regs *)(dev_read_add=
r(bus) +
> >       |                      ^
> > /home/trini/work/u-boot/u-boot/drivers/spi/zynqmp_gqspi.c:205:26: warni=
ng: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> >   205 |         plat->dma_regs =3D (struct zynqmp_qspi_dma_regs *)
> >       |                          ^
> >
> > And I don't see, really, what's even getting us down this error path.
>=20
> It's the FDT_64BIT in conf_nospl - that symbol needs to be the same
> across all phases.
>=20
> I pushed a new tree which builds without the warning. Note that
> SPL_SPI is enabled.

So, the "what" is FDT_64BIT wasn't correct. I think this is showing that
scripts/conf_nospl is going to be a problem in and of itself, and likely
as confusing if not more-so than any of the in-the-end visible changes.

--=20
Tom

--Oji3i5HPCo5AuMn5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme5CiIACgkQFHw5/5Y0
tyx+ZAv7B+rR8cOkRYLo+Nn6/uZZn6PtVjeruJcYvlojBkIKcRkW9FTMRKWPkKIi
NNrnDipBNuAIQFBlVabkQi82VCZpD+fgg20uFr0rqHp9I9R3R6EmdgOKWw+0AmBl
lqGW6xgD04KtGjL0eQlPoRCkT+WVImANcJ3FeW7nchuRLIjr85XI5jtP1EtbpEww
iGVjxNIJWolnTBlsauBH3aQ02A8pNNDqQg08jvlC2OqCDr9Zv+RX8EKfTqc8+5gm
Rv5XQx9NoWRVtaohvwrknVvUOEuQwQC5DMBep3df/aHoj8icyUOX8Bi9nmZ107wV
0QOqr7rijLBaIz3O1sfs5OBKzYsbuZ/2mFH3HGwyIa0TFQACIZEPd0/v1ljUMlu3
YbX8SA8FO8Zw6cc9TdqCkQrQzBa5f+/1SmQuok/ilOaPh/zYBbuLfCnyIzUrQJo3
PDZYmsMe8GcLVzKyK/tojSUHI/qZtrufDeCjrals630R4Y9ANX+NUnxe/450ogIW
BjqhFKIX
=ij21
-----END PGP SIGNATURE-----

--Oji3i5HPCo5AuMn5--
