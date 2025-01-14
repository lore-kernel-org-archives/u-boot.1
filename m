Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADE4C02183
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 17:33:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B50948060C;
	Tue, 14 Jan 2025 18:33:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="c/GhuYzh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB0FB80657; Tue, 14 Jan 2025 18:33:50 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A80C08022E
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 18:33:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-4678afeb133so129291cf.0
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 09:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736876027; x=1737480827; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HjAL24VX5WdtIwf+8b3heHJlxvl1XUFFilTfhW8Ev0g=;
 b=c/GhuYzhjmpzUFIw9jeWIUEwkEekkxU+x74JVQirXCJhrl7mmtmCvwXnALVFCSQgcm
 yN6H4jZFnCFSulzk6eCdE5P7THNtdThxqz4fB5e0pZYnVLNVGsAXnWMpslO8y08UahtQ
 azqFZ+Eox1Cvalh0vrdZ3KB/wEmzZiLrM4+CQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736876027; x=1737480827;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HjAL24VX5WdtIwf+8b3heHJlxvl1XUFFilTfhW8Ev0g=;
 b=YQ5PZm83E5g88SNeZFsbFPsGhS9FVUn/Qa+KcXw645krs8JjgbeniOCgBFOXoODw5z
 cIrwbtAh3m/oILUj3Zda840Ud5nVJ+KRP1mR/yMCoZ5SwR1CSjKCAtUrXz+6Xbr7tll/
 ILFKaTe1UA6rT56XnKE7TckKGaZ9cVyz5QC9jIwD0TUcUk+kWv2xSkRoMMBuXBaKx1Y7
 UTRs78reM8VvJeT54ddPm8wWzrxzSY1/XukCrgJt1jvcjo87tQ/OVYLdi2SLAwyna12p
 fKvadjIgw1fhjLpI/8kakyGN1c6AwA/hFTXl3xaMLHMkvOp/BttsT/XBzP6zbxRJoMxw
 c9qQ==
X-Gm-Message-State: AOJu0YyCnt4bZK1AbnvyjLRnY/+Z8yxd/H65hHbCGaM6IrZxsd16SsVV
 YIUQFDAX0X4fKgLMDn4y1h3//1iPwFfBmdy3UbfHKd8HxixpIZv754EWVRlIYco=
X-Gm-Gg: ASbGncs80LzwAAJtHq7074yR/tPP6KjejtBzAKjb3caw661aI8bOrm8sxwijmqcQGn7
 ZqY+0oXu/gDhj6hssdN6HzcHsdetTvoyYX/yphKG/WSKvmXMgFQWWsSFIucaaJWXk+3WSGekDhY
 XhqfFyb4wlTBibp2oF6PbuCakneEtNcjyV//qyBeI0zeBmVaRN6va/VfT9oFmK/38TCJokW3ex3
 94ysVIgq3fyAa/lMD2DJ5P+UwHnFenS0SdyAx//cGkE+5MvhwUSIw==
X-Google-Smtp-Source: AGHT+IGVyV8ZFA+OccA9Ea7UTIN0c2ekG1aFD6SBQ59CL0461wiuZohc5gX23i7TioUha8RtofvQgw==
X-Received: by 2002:ac8:7d45:0:b0:46b:1c07:12c5 with SMTP id
 d75a77b69052e-46c7b06dfbcmr350588601cf.17.1736876027411; 
 Tue, 14 Jan 2025 09:33:47 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46c8732fbd8sm55145911cf.27.2025.01.14.09.33.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 09:33:46 -0800 (PST)
Date: Tue, 14 Jan 2025 11:33:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: Re: [PATCH 01/15] vbe: Split out some VBE code into a common file
Message-ID: <20250114173343.GO3476@bill-the-cat>
References: <20250109123010.4005298-1-sjg@chromium.org>
 <20250109123010.4005298-2-sjg@chromium.org>
 <20250114012226.GG3476@bill-the-cat>
 <CAFLszTj9zAE_KniCZ2xHGHt1fK7jhTBHzfkdSif6XNuzKtWOTA@mail.gmail.com>
 <20250114165801.GJ3476@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZGY/SVXTt7Z9nZcf"
Content-Disposition: inline
In-Reply-To: <20250114165801.GJ3476@bill-the-cat>
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


--ZGY/SVXTt7Z9nZcf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 10:58:01AM -0600, Tom Rini wrote:
> On Tue, Jan 14, 2025 at 05:58:04AM -0700, Simon Glass wrote:
> > Hi Tom,
> >=20
> > On Mon, 13 Jan 2025 at 18:22, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Jan 09, 2025 at 05:29:56AM -0700, Simon Glass wrote:
> > >
> > > > Loading a FIT is useful for other VBE methods, such as ABrec, so st=
art
> > > > a new common file. Add functions for reading the version and nvdata.
> > > > Also add a function to get the block device.
> > >
> > > This is not a good commit message when you're also introducing
> > > functional changes (blk_dread -> blk_read).
> >=20
> > Yes, I did not actually notice this size change at all, as mentioned,
> > as I only built for a few boards (firefly rk3399/rk3288 and a few
> > sandbox ones). The blk_dread() function is the old API for reading
>=20
> You have much faster build machines available than I do, it would be
> good to run a world build before/after (it might take an hour on
> alexandra) before posting these big series.
>=20
> > from a block. It didn't occur to me that blk_dread() would bypass the
> > cache.
>=20
> Yes, how is that happening? That's what doesn't make sense.
>=20
> >=20
> > > Further, this functional
> > > change seems to introduce some other code being pulled in very
> > > unexpectedly, and that needs to be explained. For example,
> > > phycore_am62x_r5_usbdfu is another case and that has
> > > CONFIG_BLOCK_CACHE=3Dy but CONFIG_SPL_BLOCK_CACHE=3Dn, and yet the si=
ze
> > > growth is in full U-Boot.
> >=20
> > This board currently uses blk_dread(), but not blk_read(), so the
> > addition of a blk_read() call in non-SPL causes the BLK cache to be
> > pulled in.
>=20
> But, how? I mean, this sounds like some underlying bug that needs to be
> fixed. The platform sets CONFIG_BLK=3Dy and CONFIG_BLOCK_CACHE=3Dy and
> drivers/block/blk-uclass.c has:
> ulong blk_dread(struct blk_desc *desc, lbaint_t start, lbaint_t blkcnt,
>                 void *buffer)
> {
>         return blk_read(desc->bdev, start, blkcnt, buffer);
> }
>=20
> Or perhaps the answer / problem here is that I need to track down what's
> going wrong here instead of asking you to track this down.

So, digging in to this, what's going on is that the platforms I've noted
here (and a few others) don't actually enable any block devices. That's
why, today, with VBE on still, they discard all of the code still. Your
rework means that while there's still no block devices, we're now
including the code. What to do? Both of:
- These platforms *should* disable the assorted block device related
  library options they have enabled if / when possible (it might not be
  a neat and easy un-tangle).
- VBE needs to handle the case where there's not a block device enabled
  and not fail the build. Part of this requires the Kconfig rework I
  linked to earlier (so that we can have BLK off) to be complete, but
  having the VBE code check for BLK being enabled either in Makefile or
  C code should be the same regardless.

--=20
Tom

--ZGY/SVXTt7Z9nZcf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeGn+wACgkQFHw5/5Y0
tywU1Av/ZSTwm4XNmYA6MN9FZd6cZ/iipkNMwJLfnXVi+u0wobmt0iab7v8sXbk6
GC5D9XYZM34E/xRNMrgcOob9kvr0LT9LtXkmLr6RospwDJJtQP7KZ8wLgZP1sXY0
NpN0mRkWX0CVJdxVmKGxtEgLxwk6KO+f8AnGykSVSp7UccbhfzpOERy8uYNr0bKl
AkUf7/WUvy9g51E+KaCnlFtKw35YQTOzkOS1bay9qumJwIerK5KOLi6I/dr3V4TC
LWQnPprAvTMOG6jxBgpWpmuHVpgn/hZZPtPLHmOnFSvhELqk0vNlmHMP4PP+6tNJ
j77hg86YruCYorjtvEkIebrve0YCZ93GcqxOGVhIwT5TBoxQftl6CMSuXWxkmCBP
U43IsyyeV3hJ8dERYxImq/8bJ/9DaGOofW0C9bpsKkLZcSxsNGoW7+T4x/kPQLAg
BSNclfiHx0mnLQcW2AOWSOXRamD2j+eLJGpXUU7JciClXGyOVhWhS0/y143kUhKt
Sm5WxKQY
=AE9A
-----END PGP SIGNATURE-----

--ZGY/SVXTt7Z9nZcf--
