Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E431C0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 20:04:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D03580F0E;
	Sat, 25 Jan 2025 21:04:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a+q0Oqap";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C64280F0B; Sat, 25 Jan 2025 19:28:10 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4F8080836
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 19:28:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7b8618be68bso307015585a.3
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 10:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737829687; x=1738434487; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NSHGgQJ6fn5HWIddNLdHy+q/3wpNVZJZVxY7L4MumhY=;
 b=a+q0Oqap8vtzLb6AfCxSf4HkKRfC+aLvvhYVotN3DGOiEM4t9lYupsQVDGxSACTx5E
 toKi7TlmSe2ySesUFakCPacHNg60TFFwlaWYsuU0LccXhm4EAV6tJfQGZwl6aj8CMCOM
 LorG0cwUfiL2UGAGuuG1n/yOuX8HF2QxheLFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737829687; x=1738434487;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NSHGgQJ6fn5HWIddNLdHy+q/3wpNVZJZVxY7L4MumhY=;
 b=tOTbTTds3DmmsY9VTtL7aBM8fSXbXArR7D241bsNgfqEhDPMg8Cwa3IRNX2yHWSbq0
 I0ayc8jInyoYVrBkHM+5E1+eNGm5txG0/gCWBzn8MagOldLhWRlk/vIdJACPG/uS3YeG
 x5txz9pxOXsBdTBaY5HfHwgJ6G3Qp55iYqTUWOvzLYoPdZ028Um8Vj3nlYl1BUSjWhYY
 jUw6c20foSh45OYBNfy4eMaJXBt/Uhr/XyaQ5VBqDTXAfGw0JU3vfee08jTSHaAV4jd6
 xRceR7yCeZ+GVy8usi1St0ZjeaCAf3B3putJaGSRlqMYuKd/NqANWX/80hIHHs2YIQ9V
 VpJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnV+HajrwAecTN3Hu54BdBTuUznNn+d8pLQtpkIi+SX8IFnb+61j0FqvkmBb2mvkFivj4nRUU=@lists.denx.de
X-Gm-Message-State: AOJu0YwwMFher+MBa3oFriDXDjhUMxvXn41NGBSHjOoGevVa9OoHe7hr
 Z6hFmlNU3itiPQ0teyli10x8eOaSGLcwmxzjg2I+q4VM57vAlajbvnhDx+7V6hc=
X-Gm-Gg: ASbGncvI+rOClTi1j8W/WKZpYn7EXPKLk4ppnpmp3ifo3VDxwwj0f/GuAqrbtcSdOcR
 q/0u/qNkKyKvYyos5fsgHToL/4X1N1UOfBB/RYnuaSDmf5ZN6D1gkNs9y4YkmOp2dK0Rg3Fc5Us
 V9cyLkHxsonJ29lEl9+44nFDudTbEm/Z85krwcYMEclHP6M7TrnSoi8/GWl1G+4SYGeSdeZAJzw
 v8knrx7cvM6CH60QwzNBkMHHkI0USp4J4QLy5+sb49DBTOgFqU3edQaeZw6+dH/Q3abTEUq/Ali
 e8Xx
X-Google-Smtp-Source: AGHT+IFtNls7MCx/bqoYsBJZRqmPx4bXxWjXBDj8+4dN0VO/5eSq4pVvBCDlbRA1YXagV2LaZPLO3g==
X-Received: by 2002:a05:620a:838e:b0:7b6:c540:9531 with SMTP id
 af79cd13be357-7be6321bca4mr5888740185a.18.1737829686689; 
 Sat, 25 Jan 2025 10:28:06 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be9aeedbbasm217109185a.67.2025.01.25.10.28.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jan 2025 10:28:05 -0800 (PST)
Date: Sat, 25 Jan 2025 12:27:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tony Dinh <mibodhi@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ion Agorria <ion@agorria.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mark Kettenis <kettenis@openbsd.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 Moritz Fischer <moritzf@google.com>, Nam Cao <namcao@linutronix.de>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Sean Edmond <seanedmond@microsoft.com>,
 Shantur Rathore <i@shantur.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
 Tim Harvey <tharvey@gateworks.com>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>
Subject: Re: [PATCH v3 00/19] bootstd: Support recording images
Message-ID: <20250125182759.GA60249@bill-the-cat>
References: <CAFLszTiSSq-+cSxVgxLJ8atAAjjxRP2AEQmXMbrf+c3FOepnFQ@mail.gmail.com>
 <20250115233157.GE3476@bill-the-cat>
 <CAFLszTga3RD95M2ujLfuXQor39sfcQrEUe3hwRKABiWx04PiZg@mail.gmail.com>
 <20250116172159.GH3476@bill-the-cat>
 <CAFLszTigN+s1T0hjJXnkE4ucYafHCtabPFHh=gCFpro2WrLnpg@mail.gmail.com>
 <CAJaLiFw3j1FTT25mNd_5Pk-UTCaNL=R2GmK0+m_VoCc7Yc2PRQ@mail.gmail.com>
 <20250118144132.GW3476@bill-the-cat>
 <CAFLszTi_5s9L9zYz-EZpdM9YVdV7TdhrnxPm9K8VeZEa0tHpag@mail.gmail.com>
 <20250123171708.GN60249@bill-the-cat>
 <CAFLszTjNLDbhOiE-_f7igzMkz3db_0YtwGN4t04tf9SsAbCeMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oCUt1CwCOVt668g8"
Content-Disposition: inline
In-Reply-To: <CAFLszTjNLDbhOiE-_f7igzMkz3db_0YtwGN4t04tf9SsAbCeMQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Sat, 25 Jan 2025 21:04:21 +0100
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


--oCUt1CwCOVt668g8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 10:13:54AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 23 Jan 2025 at 10:17, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Jan 23, 2025 at 07:38:04AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Sat, 18 Jan 2025 at 07:41, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Jan 17, 2025 at 09:49:43PM -0800, Tony Dinh wrote:
> > > > > On Fri, Jan 17, 2025 at 8:32=E2=80=AFPM Simon Glass <sjg@chromium=
=2Eorg> wrote:
> > > > > >
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Thu, 16 Jan 2025 at 10:22, Tom Rini <trini@konsulko.com> wro=
te:
> > > > > > >
> > > > > > > On Thu, Jan 16, 2025 at 08:52:38AM -0700, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Wed, 15 Jan 2025 at 16:32, Tom Rini <trini@konsulko.com>=
 wrote:
> > > > > > > [snip]
> > > > > > > > > I'm referring to the whole bootmeth/bootflow/etc thing. I=
s this going to
> > > > > > > > > be put to use by anyone / anywhere on PowerPC? M68K? MIPS=
? 32bit ARM is
> > > > > > > > > a harder question there, which is also where this particu=
lar overflow
> > > > > > > > > was.
> > > > > > > >
> > > > > > > > I'm still not sure what you are saying. Are you wanting to =
disable
> > > > > > > > bootstd by default / go back to distro scripts / force ever=
yone to use
> > > > > > > > EFI_LOADER / ?
> > > > > > >
> > > > > > > Yes, I'm asking where it's appropriate to enable this new fun=
ctionality
> > > > > > > by default.  It certainly should be enabled on arm64 (there's=
 new
> > > > > > > designs) and riscv (there's new designs). It still ought to b=
e enabled
> > > > > > > on arm32 because we otherwise lack a easy way to say "new" ar=
m32 (say
> > > > > > > i.MX7) and not "old" arm32 (say i.MX23). What is the point of=
 enabling
> > > > > > > this on PowerPC for example? The active users there are (gene=
rally)
> > > > > > > supporting legacy hardware and I have no idea how much they w=
ant to
> > > > > > > change their boot process, once bootstd supports flash for ex=
ample.
> > > > > > > There's similar questions for everything else under arch/ as =
well.
> > > > > >
> > > > > > To me this is in fact two different questions.
> > > > > >
> > > > > > 1. For PowerPC, m68k, MIPS, I suppose we can just disable BOOTS=
TD and wait for them to go away, if you are saying that they are behind on =
migrations will never catch up
> > > >
> > > > On what migrations? A board that has a boot command is not some leg=
acy
> > > > non-migrated case. That's a valid regular use case.
> > >
> > > I'm referring to a board that uses distro scripts.
> >
> > OK. Just FYI, "distro scripts" weren't a thing outside of ARM (and maybe
> > RISC-V, and just turris_1x_sdcard on PPC?).
>=20
> OK. If those boards don't boot distros then I suppose it doesn't
> matter what they do. It would still be nice to get rid of/reduce the
> scripts, but we shouldn't require it.

The complex "distro boot" script should be phased out. Ad-hoc boot
commands are a valid regular use case.

> So where are we with bootstd migration?

Waiting on Heinrich to have time to post what he and I talked about for
how to untangle "here's how the EFI custodians want to handle starting
EFI payloads" so that the sunxi series can be rebased on top of master
(which now has the BLK related problem solved) and that.

--=20
Tom

--oCUt1CwCOVt668g8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeVLS8ACgkQFHw5/5Y0
tyzjBgv/XQEC6bLE6yN7L2vt5NaeVfUpSLjqBcHa7RtM6j6KxQNibxCgMlsdvQ/x
vy8D8+DdXaJE09NNELatdRazLGWB54xDKlD1fk3wCnVz3CA+9LdALZlaOeaXEXf5
8XyqpvZorBkcsfzN9HBanhBMyrs7X6yB2dhxjODfMW9BYdYfJXTy95UKns6GBRfC
UaGQXEvCbrGSXYGnFhJVRM3Wy45JDsP2fib0rbgujNwl1Rdeu6mQB3N2HFX/+MkR
FhJy41muI+9Bb6uK1NYyvQztMoGrYQBfefMG816/NEeR2ap3Sn0GxOw48zsoZn4G
+SQRFxa0NSPceG+BtjNYc4ZwnVliDRayU6pxfoJ742V0avbUU4uo8iR0GygbKi+M
s8kXxW/jepA1zuuAQsAzVRHHuehQHym1Ax4UlArK3Cs1hWSPuzZ/NQlTi/+tx7DY
y6HkUADIS0U2XEOmx0BN5G/5zEb8BaMofctmnbT4eUmodPT5E1jCivf/zyf928yV
6qS5dpOg
=02nW
-----END PGP SIGNATURE-----

--oCUt1CwCOVt668g8--
