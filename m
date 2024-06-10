Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5F3C27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 16:41:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9365E885FB;
	Mon, 10 Jun 2024 18:41:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mzBqmrad";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5D5E885DB; Mon, 10 Jun 2024 18:41:46 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E24188630
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 18:41:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6f980c89db8so1073736a34.1
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 09:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718037703; x=1718642503; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KzO/MUOiKve6mxfEorcWC31IgOEMthZAfJpqD9zIAGg=;
 b=mzBqmrad5FikM9w+xW7RWq7cDyMQ5Dg9AkjzuncWVox1+A59ljJhcXn+pR+Q3w2POG
 CpRW8N8PrePeUG7iwo5FboWHjNPVqT0bevU04w45Td3vJYusxuQ+Tv4h5UETvm1KsBTy
 r32QhzRWpl9Q6JCAWEWVtESYh3JvjwpHRjjB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718037703; x=1718642503;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KzO/MUOiKve6mxfEorcWC31IgOEMthZAfJpqD9zIAGg=;
 b=ILNeVus30bMY+cz3dPSXe1p/kWWGqbWvQDXUmBU3nNWnaETAlqIf3fdqm2qXcy1DBk
 jZ9tIcGiJG4nwo6oenqOeOmQALcTz99gCEQpKoNlsDNYnV9EIeMSCa7NwIYcELpvGA2r
 tq5WeMDkAKLgibQANv/esHN3+mXTqwExlyTnJxwgZqeG1fILSPzCjcQgKjkfgnQaBYeh
 xMOv0sk/W+JkutGg5i130dmH/R38oEJWO0Rg5snqSLojA1QU9fiKJ4Haqgqy5hlZs6g6
 6agCrvwMFk7HGsAHwkpuRmzgfpzIwCmTOoylILG1sE5N9nl1gnt94hz7NLKUuOiN8A9B
 c5BA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN1loChxssVhM/rFuKs9PhoODhncFcC4Glfi5t+GV2HTeXu1kTGu/+gJIg2ElYJ8/fe2Sr8eUdmDPVcqgUMr1Xo6ZJRQ==
X-Gm-Message-State: AOJu0Yzo9E7eeygdrg1UHpOjDWuGfSu4qB8ffXmX33zHJY/Y8V5yK7lh
 uv16c36RqvZgPc+dMqJUFrKwu8BC/B6YDoY9jREYonfqZ+JlpRBC63EqeX/zGKg=
X-Google-Smtp-Source: AGHT+IGGaNGP3FgVNRjgcO4aDOSujkWWx6cQgZ2++8eOMgyga3KbWaLXeBkO939MjRGA7h3+xkHNyQ==
X-Received: by 2002:a9d:6406:0:b0:6f9:5ba7:e64e with SMTP id
 46e09a7af769-6f95ba7ef76mr8199398a34.35.1718037703084; 
 Mon, 10 Jun 2024 09:41:43 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f9c9cd3ccesm290765a34.46.2024.06.10.09.41.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 09:41:42 -0700 (PDT)
Date: Mon, 10 Jun 2024 10:41:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shantur Rathore <i@shantur.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Bin Meng <bmeng@tinylab.org>, Mark Kettenis <kettenis@openbsd.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 0/9] efi_loader: improve device-tree loading
Message-ID: <20240610164140.GQ68077@bill-the-cat>
References: <20240610091057.64463-1-heinrich.schuchardt@canonical.com>
 <CAFLszTgcnftK=GqZ0LGue2Y8-YkRhOKzPuc4Yf1CvhzAGO+MTg@mail.gmail.com>
 <a9462414-c8f7-4a2a-9dd0-f39ee24876f8@canonical.com>
 <CAFLszThgyRrWnjDa9iXB14Lcm1LPeh+5M7p_YKDg9ZjFmr0JXA@mail.gmail.com>
 <b0eaacea-d1a4-4e6e-ad2e-01f87c18e177@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2O58AHOBPoz3upzI"
Content-Disposition: inline
In-Reply-To: <b0eaacea-d1a4-4e6e-ad2e-01f87c18e177@canonical.com>
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


--2O58AHOBPoz3upzI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 06:10:08PM +0200, Heinrich Schuchardt wrote:
> On 10.06.24 17:54, Simon Glass wrote:
> > Hi Heinrich,
> >=20
> > On Mon, 10 Jun 2024 at 08:00, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> > >=20
> > > On 10.06.24 15:53, Simon Glass wrote:
> > > > Hi Heinrich,
> > > >=20
> > > > On Mon, 10 Jun 2024 at 03:11, Heinrich Schuchardt
> > > > <heinrich.schuchardt@canonical.com> wrote:
> > > > >=20
> > > > > In U-Boot EFI boot options can already specify both an EFI binary=
 and
> > > > > an initrd. With this series we can additionally define the matchi=
ng
> > > > > device-tree to be loaded in the boot option.
> > > > >=20
> > > > > With the last patch the boot manager will fall back the device-tr=
ee
> > > > > specified by $fdtfile in directories '/dtb/', '/', or '/dtb/curre=
nt/'
> > > > > on the boot device if no device-tree is specified in the boot
> > > > > option or via a bootefi command parameter.
> > > > >=20
> > > > > v3:
> > > > >           Add missing '@' in EFI_LP_DP_PART_FDT description.
> > > > >           Use calloc() instead of malloc() in load_fdt_from_load_=
option().
> > > > >           Add missing '@' in load_fdt_from_load_option function d=
escription
> > > > >           Rename struct efi_initrd_dp to efi_lo_dp_prefix.
> > > > >=20
> > > > > v2:
> > > > >           Update efi_dp_concat() instead of new function efi_dp_m=
erge().
> > > > >           Carve out a function efi_load_option_dp_join() which we=
 can
> > > > >           use both for the eficonfig and the efidebug command.
> > > > >           Rename variables id_dp, final_dp_size.
> > > > >           Rename create_initrd_dp() to create_lo_dp_part().
> > > > >           Use enum as parameter for create_lo_dp_part().
> > > > >           Put all related changes into one patch.
> > > > >=20
> > > > > Heinrich Schuchardt (8):
> > > > >     efi_loader: allow concatenation with contained end node
> > > > >     cmd: eficonfig: add support for setting fdt
> > > > >     cmd: efidebug: add support for setting fdt
> > > > >     efi_loader: load device-tree specified in boot option
> > > > >     efi_loader: move distro_efi_get_fdt_name()
> > > > >     efi_loader: return binary from efi_dp_from_lo()
> > > > >     efi_loader: export efi_load_image_from_path
> > > > >     efi_loader: load distro dtb in bootmgr
> > > > >=20
> > > > >    boot/bootmeth_efi.c                        |  60 +---------
> > > > >    cmd/eficonfig.c                            |  83 +++++++++----
> > > > >    cmd/efidebug.c                             | 130 +++++++++++++=
++------
> > > > >    include/efi_loader.h                       |  24 +++-
> > > > >    lib/efi_loader/Makefile                    |   1 +
> > > > >    lib/efi_loader/efi_bootbin.c               |   2 +-
> > > > >    lib/efi_loader/efi_bootmgr.c               |  75 +++++++++++-
> > > > >    lib/efi_loader/efi_boottime.c              |   3 +-
> > > > >    lib/efi_loader/efi_device_path.c           |  40 ++++---
> > > > >    lib/efi_loader/efi_device_path_utilities.c |   2 +-
> > > > >    lib/efi_loader/efi_fdt.c                   | 117 +++++++++++++=
++++++
> > > > >    lib/efi_loader/efi_helper.c                |  44 +++++++
> > > > >    12 files changed, 445 insertions(+), 136 deletions(-)
> > > > >    create mode 100644 lib/efi_loader/efi_fdt.c
> > > > >=20
> > > >=20
> > > > Somewhat related, what work has been done to support FIT, or to loc=
ate
> > > > a DT using the compatible string?
> > >=20
> > > CONFIG_BOOTM_EFI allows booting a FIT image containing an EFI binary =
and
> > > optionally a device-tree. You can manually select a configuration when
> > > invoking the bootm command. I am not aware of any automation for this
> > > selection.
> >=20
> > Thanks for the info.
> >=20
> > Can we perhaps require FIT_BEST_MATCH and then provide a way? All this
> > filename stuff is missing the point, really. It isn't going to get any
> > easier, either.
> >=20
>=20
> Thanks for the pointer. FIT_BEST_MATCH would allow to select a matching
> device-tree from a FIT image. But any solution using FIT images will not =
not
> be compatible to other firmware.
>=20
> As a distro I would prefer a solution that runs on any EFI firmware, e.g.
> EDK II. Being able to use the same image on all boards of the same
> architecture was the motivator for Suse to start U-Boot's EFI
> implementation.

I'm pretty sure tianocore, grub and systemd takes patches too? And
everyone is going to need to do _something_ because all of the measured
boot stuff that distributions want starts from "we can't check the
measurement of 10000 files, we need to check one file". So it's pretty
handy then that there's an open and well known specification that
handles that problem. I'm still frankly a little baffled as to what
would prevent UKI from being "EFI application stub around a FIT image".

--=20
Tom

--2O58AHOBPoz3upzI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZnLMAACgkQFHw5/5Y0
tyw94wv/TE2jcauvlCjBO7RTOvf5xH3v1wOI9dMBpnFSEfNNK3ZuRAmPHbftPP/7
4Dalf9nsWx3JyK1bndViS6rOPl7RzdmMLt3vshRPFft7hEblStXkDipGGyoyeInE
ges9z3Az52WRiVEhBlyeCRr5bBUm+vQG+KpPCDUL0LQTXZWRGf6VvVaJtgMDqNz6
k8fu7kmaXefzb9avWeeXoNN3n2H/1/mdwm8e75wRRZzmI66P33IcNwbmn/M/wVpT
cdGURousPuZw0Gu24p4gzn0F6NpMcqdw61a0Wb6m04mJR3PO1SZGGTMI8pKAjxYV
UnDo7G3Y3CO/9e2G/OzXCCAH9VH96BpVBCwJ/aycV2SvDMYCybhIRu5PgC8aBdh4
IQYrl1bVqq6D5PJG478dSCkFypD7rczuAb6mDvT+xseU2RxceMvWUqiRtQ/aHrQW
6ibJodsq35yemMDB7s22Ev2O5wg94mf/NaDdoxGfFZLr6i1ixIYvjKtZfBttaRal
XAewazAA
=IgEm
-----END PGP SIGNATURE-----

--2O58AHOBPoz3upzI--
