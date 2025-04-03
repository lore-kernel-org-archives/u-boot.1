Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 952ADC3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 17:43:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA90081FEE;
	Thu,  3 Apr 2025 19:43:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Yb2A1p++";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C771182006; Thu,  3 Apr 2025 19:43:18 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7379181F69
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 19:43:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-72c14138668so355609a34.2
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 10:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743702195; x=1744306995; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6kxr+zspOLvWK3KNEUaA9z8wjL6XWUxF3ftjz1QN460=;
 b=Yb2A1p++4/wAihdzXlTPoy9lFA0NKzWaUt/p01ojclvN4nH6SI/IycUIsATfmSDGMf
 9StGy7F+zpWaU4guA5Bg+3/DC6GeUvbH4cIi4jglIY0K14c1hyiw7JbtXZtBnLZaQhey
 xtZjlQGNnXXzHzFI+eWlQZpUOBtbdYMdzBMiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743702195; x=1744306995;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6kxr+zspOLvWK3KNEUaA9z8wjL6XWUxF3ftjz1QN460=;
 b=GWl3R/dFeztYgVYIA3240PJW9jRcVs6uf+/SwWGm2Q40rkXZdbNNW6dYmkNEDWZ7X3
 OL1yiFdHCVqVwQ71rI0x0FvV8C6WgWlqnqHkqJQnhD4pcxQxCKBZduov7yzmige3s0c5
 N+fPMqWmx8IJvyK23l5B2cNC0YzpLyAU/nGuePdj+UjxBdk60dwnDAqtlW6pnyszgGJ8
 onnW8c9vqyu/B1AU0sGBNt4vcr85tcvkXFOpSV8nqwukpaWN2vpAc7Lk4d/pn97mKTxu
 fSWKFov3uYi62n8w3P/pO1g0ZHBDTkizFbrZQiGwdfKG5BppX/wnhOfJgkgSbZQF3yKJ
 NHjQ==
X-Gm-Message-State: AOJu0YxlwlTLWw5AW5YVyZJ7NiEM0X0Fke7BMd5rbK3GOcbdv3ZaESDE
 RYJOKOEpLIkw+RpNAjDh9dBsMZe1JmzKTH5hd0qzC0Cq+VP0YebkfTwZjfEcdsc=
X-Gm-Gg: ASbGncvW+BalATZytKcO911pEQn0FP4zK8aie8zQYnA8wCzwRe0xUb7/q7KoUp8E7uU
 KxokWbXzQ33PhS8MIhLfEJYtMQbbBuGTi4XP41Y0qj2qYIwhqB7ZPc8KZvYG/HW2yKqrtIibnjp
 3ivu2YrTTAlh73shubzFtP5CEz8ZTCuxFVZyyqTWjGz7tsqx7lqu/p/EMQY4zYA+S230UUEh8ga
 DBisF6nrC5UeLeQWlPlXhVhQpc77ihR3GuhLPer/YEfZrglJiTc4QMOi7/2e8jOFK1Bg195Carj
 ZwcUl6mpcawxMctfCmLddV8wuLWgfdaAuAkdvjGrUEvxDdJOVkcadpYp3IkPH8IyPJEspMasvfj
 FxCQ/GQ==
X-Google-Smtp-Source: AGHT+IHUdQELvmg0/qFQ+GriygbZdQpLXLYah5v6ILy2l/K5HUWlhnkfaio4tzYlixIRoZDPSVyXLQ==
X-Received: by 2002:a05:6830:3908:b0:727:423c:95ea with SMTP id
 46e09a7af769-72e368495e4mr307501a34.19.1743702195080; 
 Thu, 03 Apr 2025 10:43:15 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2cc8463aafbsm342840fac.26.2025.04.03.10.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 10:43:14 -0700 (PDT)
Date: Thu, 3 Apr 2025 11:43:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Julius Lehmann <lehmanju@devpi.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v5 38/46] boot: Consider non-bootable partitions
Message-ID: <20250403174311.GL5495@bill-the-cat>
References: <20250315142643.2600605-1-sjg@chromium.org>
 <20250315142643.2600605-39-sjg@chromium.org>
 <20250402142851.GS5495@bill-the-cat>
 <CAFLszTjmrn0_idbmmS53dgbK45YsZHHNYN+38i5OhtrRBWHijg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GCAR7LcQ/XBrRPAp"
Content-Disposition: inline
In-Reply-To: <CAFLszTjmrn0_idbmmS53dgbK45YsZHHNYN+38i5OhtrRBWHijg@mail.gmail.com>
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


--GCAR7LcQ/XBrRPAp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 03, 2025 at 08:22:30AM +1300, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 3 Apr 2025 at 03:28, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Mar 15, 2025 at 02:25:58PM +0000, Simon Glass wrote:
> >
> > > Any 'bootable' flag in a DOS partition causes boostd to only scan
> > > bootable partitions for that media. This can mean that extlinux.conf
> > > files on the root disk are missed.
> > >
> > > Put this logic behind a flag and update the documentation.
> > >
> > > For now, the flag is enabled, to preserve existing behaviour. Future
> > > work may provide a command (or some other mechanism) to control this.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > (no changes since v4)
> > >
> > > Changes in v4:
> > > - Rewrite the commit message
> > > - Enable the flag by default
> > >
> > > Changes in v3:
> > > - Add new patch to consider non-bootable partitions
> > >
> > >  boot/bootdev-uclass.c            | 4 +++-
> > >  cmd/bootflow.c                   | 2 +-
> > >  doc/develop/bootstd/overview.rst | 5 +++--
> > >  include/bootflow.h               | 2 ++
> > >  test/boot/bootdev.c              | 1 +
> > >  test/boot/bootflow.c             | 5 +++--
> > >  6 files changed, 13 insertions(+), 6 deletions(-)
> >
> > Having spent another 10 minutes just now trying to understand things,
> > again:
> > - The commit message, and the implementation are either in disagreement
> >   or just too vague. Saying "to preserve existing behaviour" is unclear
> >   about which behavior is being preserved, since we're setting the flag
> >   to continue to only check bootable flagged partitions
> >   (BOOTFLOWIF_ONLY_BOOTABLE). But then we would continue to miss
> >   extlinux.conf files on root filesystems, which would seem to be the
> >   bug that needed fixing?
>=20
> How about 'to preserve the existing behaviour of bootstd which is to
> ignore non-bootable partitions so long as there is at least one
> bootable partition on the disk"  ?

Yes, that's better. I've reworded the commit message with that.

> > - It's still unclear if this makes bootstd match the exiting distro
> >   script behavior or not, and from your other emails it sounded like you
> >   were expecting someone else to dig around.
>=20
> The distro scripts include the code below. My reading of it is that it
> only considers bootable partitions, except that if there is none, then
> it always scans partition 1.
>=20
> "scan_dev_for_boot_part=3D"                                         \
> "part list ${devtype} ${devnum} -bootable devplist; "     \
> "env exists devplist || setenv devplist 1; "              \
> "for distro_bootpart in ${devplist}; do "                 \
> "if fstype ${devtype} "                           \
> "${devnum}:${distro_bootpart} "   \
> "bootfstype; then "               \
> "part uuid ${devtype} "                   \
> "${devnum}:${distro_bootpart} "   \
> "distro_bootpart_uuid ; "         \
> "run scan_dev_for_boot; "                 \
> "fi; "                                            \
> "done; "                                                  \
> "setenv devplist\0"   \
> \

OK, thanks, I agree with your reading of that as well.

--=20
Tom

--GCAR7LcQ/XBrRPAp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfuyKsACgkQFHw5/5Y0
tyyyBQwAutJRQsWZf14YmmDZbIvoZ2uxG0IH/InlpV48BErLd627E3QwLGCYwM7g
mf29fNq2GSjL4mlW3GKmaW+/Dh18tKNrndfJy73rvmlt2jgfqE8BYIEhTtRPKKUj
hNcJr38MhcUC0uKTJGxEfqpcBj5FmWK7KaQVuTNGIfeOo3T9lWdqTFAJZ7tGXhb7
4rsssrRU96AIcIf2qOyDAyDjiAl4dceZXKL3VAqbi3JPv8ALNAnCADMnytyR38l3
t0Yvkng4WQ1KKA2st3/sYUQmivazCzLPcczT1ASSTXklpbSaNW7IpnCvYHOkHz9U
xmJ45o+0Ac8ncODQ7mXyRgBQb+tfkTc++MINbX5Cg3dsc8z7ljJRr7MEVuZnQ6Pi
zcxCQGmCztduom5DCd0ASEurcSIBvUwhuaDJFCouop6viJxwCFWtvG0YDKqJnx2M
d0Fq3CU7azNMHdW5IAsoYmguIuj5NCnQWrG3W5p/hFhEzQpsr8BBZhWtJRNUVHZ0
E0znghlj
=PTT9
-----END PGP SIGNATURE-----

--GCAR7LcQ/XBrRPAp--
