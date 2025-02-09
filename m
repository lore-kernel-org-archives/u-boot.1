Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84874C02198
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 00:05:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CBE8809A5;
	Sun,  9 Feb 2025 01:05:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mOx7BhuX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E708480805; Sun,  9 Feb 2025 01:04:01 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19BEF807D7
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 01:03:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e5b3dbd6732so2419698276.1
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 16:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739059438; x=1739664238; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5nUUKxdCywLuUDE2a/tJrULklDr0sRDUpVF393u/+Ug=;
 b=mOx7BhuXlrzHB/0M8H7F2XcPoTiDaVrlrnQbdAm5CyDP1ETCLzstvkEAFpvykSv2t7
 jK12nhqeCD5xn7l6ZukKV2uCj3UHEectdO5dR0fv1LRSaRNt12FUYYlhIvSowS1j7fjc
 hTSDj8+xQ+rU++aXRjZt6kUGTOeGgukYY5oLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739059438; x=1739664238;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5nUUKxdCywLuUDE2a/tJrULklDr0sRDUpVF393u/+Ug=;
 b=wyrpLpPrv8qbQsfAf7+p4L7gRUx53cmDuQQ/gFw0G7v+TF+SXuTfq/CqlMvcr5gBC3
 PUAKu0DBraX+yLTSnEmzUvKOBWJG8DZGYClUv00dQGmWF+fgke+nAc0v28qTtS9OsGhZ
 8a3s6sxo0f5mhNk3Np8kdCgQfrwRVAKOiob/Il/g5Wa3CeLCQ5kVhWDnpy6NEiaXHMPj
 KdBLCYT/TpRTqWiuWb/hX0MBWeJBL+C0YRfT/p9brLfQgk5dO4C+k2QRF+ByuWZBbLu9
 r0VZbvtIF6TWhLcQG53EgqRXbPR3mN2Tdl239I5jEsJAO9OtPOUZYK+AilDdqfJYvwP9
 Q73g==
X-Gm-Message-State: AOJu0YxgpmcuJ5qotHAMryqJBHjQD0kxQgL4zv/ftL6eUM1otV0mlGqA
 quARE3FWCqgwphXvO6g+fYXwN7KI72s5QLFudi0I7qKV1iUTGstWtS8UtdZKyK4=
X-Gm-Gg: ASbGncvsLLe5mw62z5vIW91QPNjmTDhn3H9Yiw7uFrHnPXZ1ClTDMf/DlLgEBa/u2Lq
 QBX6PZ0ljnjnaY1//S2iIeITYHujs3xaVlBuOKACtIX8P1YJ5SR6VWgwYOaJZme1ZkOlVhJKudW
 SzDJl2MUPXYkbPyIyrQS0c07OPdgLStRnbZzwpbV6Y0LQz1S8Q77RjCHtMuxXAnapfTj0dlyLeE
 a0fUAkwOnWgpDI28NFUzRuRt1mFhCHKHUwkzmc0BPWHKiZguEwsAccXKs8Pvu6EIU50xy6IghNZ
 JBFkHSQUoktzsUM=
X-Google-Smtp-Source: AGHT+IFD1h+yUId2rNX6jnQ92TmgeFDxD4mNMvbFM0F+eOd9/oJd11XwfDjlnTacCh+jmUpZc9eOpg==
X-Received: by 2002:a05:6902:1b8c:b0:e57:3a77:99b6 with SMTP id
 3f1490d57ef6-e5b461a035dmr6716506276.19.1739059437797; 
 Sat, 08 Feb 2025 16:03:57 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e5b3a207eecsm1681716276.24.2025.02.08.16.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 16:03:55 -0800 (PST)
Date: Sat, 8 Feb 2025 18:03:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Anatolij Gustschin <agust@denx.de>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Anton Bambura <jenneron@protonmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Greg Malysa <greg.malysa@timesys.com>, Heiko Schocher <hs@denx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jonas Karlman <jonas@kwiboo.se>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Leo <ycliang@andestech.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marex@denx.de>, Matthew Garrett <mgarrett@aurora.tech>,
 Matthias Brugger <mbrugger@suse.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Richard Weinberger <richard@nod.at>, Rick Chen <rick@andestech.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH v2 00/29] arm: Support building as an EFI app
Message-ID: <20250209000350.GJ1233568@bill-the-cat>
References: <20250208171154.1305761-1-sjg@chromium.org>
 <20250208212912.GE1233568@bill-the-cat>
 <CAFLszTg6oqMWK05Ldrk4wFUJ7Yr0Xha_z-RJpp1ez=3R5Jdn6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TIsngkdNz5Nxlf3J"
Content-Disposition: inline
In-Reply-To: <CAFLszTg6oqMWK05Ldrk4wFUJ7Yr0Xha_z-RJpp1ez=3R5Jdn6A@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Sun, 09 Feb 2025 01:05:23 +0100
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


--TIsngkdNz5Nxlf3J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 08, 2025 at 03:40:07PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 8 Feb 2025 at 14:29, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Feb 08, 2025 at 10:11:20AM -0700, Simon Glass wrote:
> >
> > [snip]
> > > Changes in v2:
> > > - Depend on CONFIG_EFI_APP instead
> > > - Drop change to u-boot-elf rule
> > > - Mention '64-bit ARM' here, rather than just 'ARM'
> > > - Drop the word 'Sadly'
> > > - Mention '64-bit ARM' here, rather than just 'ARM'
> > > - Add new patch to rename VENDOR_EFI to ARCH_EFI
> > > - Update to use ARCH_EFI instead of VENDOR_EFI
> > > - Mention '64-bit ARM' here, rather than just 'ARM'
> > > - Mention '64-bit ARM' here, rather than just 'ARM'
> > > - Rework the commit message to clarify the relationship to link-scrip=
ts
> > > - Expand commit message to explains that EFI_APP skips relocation
> > > - Mention '64-bit ARM' here, rather than just 'ARM'
> > > - Document the x86 field better and add a comment for ARM too
> > > - Mention '64-bit ARM' here, rather than just 'ARM'
> > > - Put the EFI-app case first in setup_mon_len(), for clarity
> > > - Use ARCH_EFI instead of VENDOR_EFI
> > > - Merge the linker-script rules into Kconfig in this patch
> > > - Drop patch 'Select the EFI linker script for the app'
> >
> > There's things that were mentioned for v1 that aren't in this list, did
> > you miss them or disagree with them?
> >
>=20
> The only one I think I didn't do was ' Drop exception code'. I'm not
> actually using / enabling an SPL symbol so I think you have the wrong
> end of the stick.

No, you missed my comments about copyright, and tidying up the
compile/link flags for EFI_APP, and the exceptions.o / exception_level.o
thing too. I forget if there was anything else.

--=20
Tom

--TIsngkdNz5Nxlf3J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmen8OMACgkQFHw5/5Y0
tyxH1AwAhcc04UQfl+QYxk+96huBRWSY/HPHgUMI9Kn5Y3zqYLJpadr81eSNFl6z
4ngfsOquYvSoM/NaHz/OddwIRWMccUYacyS2+6aM4opq3HYhCeYweHVJ51zSCjSy
A7LSPbY9OG6OjABS/TtUerC0Ud9rLKa2J0X2NXMcuxzagW1ebW7muHVk/jqmLIme
OBexWVXIPlzam6wvaiXxuFnOmCSXOAEI596hRMuIqhrIecp0dxe9OotasYYScSdp
Y5eBLiDzTIjcoL6QsFrtSdiqZF+cKKKNFALvEr9CWFdhPabcuko6vXs42/3yDRUO
3G3yb6X0ERmIbGIv62nrs5OpLDJqQPq5ZrXTCATRIQzGGjVAdi5Kd6iTGCKQ2JYB
QkT7jP0wyqFGOmUGXbzEa8ML96VtN6gfNVtgDHGPZZYlR4Fk2phhCU9y5il21xTH
GFtoB2/JxmFT3nn4bNOHJ0bkJpmo31qsC9ViJZRmQD9G/4hVB7Xd+6Oqqa3GQKFU
K1HCvST3
=9VfM
-----END PGP SIGNATURE-----

--TIsngkdNz5Nxlf3J--
