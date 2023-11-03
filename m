Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCE4C4167D
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 17:42:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA3E2870E1;
	Fri,  3 Nov 2023 18:42:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BBnsl1cd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 384AF86E5A; Fri,  3 Nov 2023 18:42:16 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CBF986E09
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 18:42:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3b58d96a3bbso466122b6e.1
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 10:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699033329; x=1699638129; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uSSI8UIDZ4FFM093AQoageCJqW/HCKDE9R01HfjCxzg=;
 b=BBnsl1cdePj7lA8zeOAv2QC0UrHMI0+RtWwJFk60kxTeu3TPrIK5TCkoxQ2dVixlXY
 fiq5YjypQC3m1WnL36n/sZFOpi9DM84nExsRoANAt+Ip/g3KfzTlSzI/8wIBBZry+fzw
 AFY+qprnd9nQCSp+oamysK0IMv0iabZkVPqps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699033329; x=1699638129;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uSSI8UIDZ4FFM093AQoageCJqW/HCKDE9R01HfjCxzg=;
 b=c0Kf/+7mSpyS9Pi9xO/lJ9eNH43Kp+cLMorqzTYHAPDxD0yrPNltwgb969LUbZZdhk
 ZCXzG9TNmv0XR8SL8R0MhSIngMPj8cDBjV2bKDX+PmsWREgnWpD4v0nICTLZXLqR7xs/
 NuB/xTCXPvgSOcjt4/nUKCKY5q9C2HHa2YfcBGHYxAU47s8e9zfw70gf6B3a98/Lvcn6
 izBivNwL0P7/wdwHTzrspddzholEDxXh81q6SMCn0HLAs8l0B5WzqUcT/iwyBDRs24sg
 rs3Sm9/O40oqPsTHB6empvOYMTWyxg/ja/u6nKY8IZSjbs8FpjAl+t+VIIWbf+na7vsF
 HPvQ==
X-Gm-Message-State: AOJu0Yzst9TZDjk9wHmtX9qRiHwpo01qpl25PY91HLzrgkhsivHCe/Kb
 ndbs9KYT0AqbAgKQefpE697Mpg==
X-Google-Smtp-Source: AGHT+IG/XGfRKaWfaaLf0bZiZMSA+lisdeElnZN0nzwbl28rajG6suRaI7UXNK6Tgrp9BMWHzvnnlg==
X-Received: by 2002:aca:f11:0:b0:3ae:5442:ed1b with SMTP id
 17-20020aca0f11000000b003ae5442ed1bmr21717505oip.43.1699033329163; 
 Fri, 03 Nov 2023 10:42:09 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 l11-20020a05620a0c0b00b00767177a5bebsm909950qki.56.2023.11.03.10.42.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 10:42:08 -0700 (PDT)
Date: Fri, 3 Nov 2023 13:42:05 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Mark Kettenis <kettenis@openbsd.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Kautuk Consul <kconsul@ventanamicro.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: Re: [PATCH v2] smbios: arm64: Allow table to be written at a fixed
 addr
Message-ID: <20231103174205.GQ496310@bill-the-cat>
References: <20231025123117.v2.1.I054cad60e00f8cfde39256c7c7d9c960987fb9be@changeid>
 <734658D7-8081-44DC-8168-6EBDBA8D951D@gmx.de>
 <CAPnjgZ2ZFSbUYPVq+A1jQBy8s=DOO8Cz+epHGL++KSEN-pr-wA@mail.gmail.com>
 <32facf81-f2bf-460a-9104-cae1dcef0cbe@gmx.de>
 <CAPnjgZ20bRUP7KFwRpe7dmbxbQFMJmHB55dkXpEjv3fyX++M3A@mail.gmail.com>
 <CAPnjgZ1Ao_ikgwPR8-fGVzbBfzRQYm0bxz9LgVHs1FP7+HG3cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="u6vsrdzjXYzrPUV+"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ1Ao_ikgwPR8-fGVzbBfzRQYm0bxz9LgVHs1FP7+HG3cw@mail.gmail.com>
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


--u6vsrdzjXYzrPUV+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 03, 2023 at 11:12:40AM -0600, Simon Glass wrote:
> Hi,
>=20
> On Sat, 28 Oct 2023 at 12:41, Simon Glass <sjg@chromium.org> wrote:
> >
> > [unfortunately I am not receiving email from the list at present]
> >
> > Hi Heinrich,
> >
> > On Wed, 25 Oct 2023 at 21:39, Heinrich Schuchardt <xypron.glpk@gmx.de> =
wrote:
> > >
> > > On 10/25/23 04:49, Simon Glass wrote:
> > > > Hi Heinrich,
> > > >
> > > > On Tue, 24 Oct 2023 at 18:22, Heinrich Schuchardt <xypron.glpk@gmx.=
de> wrote:
> > > >>
> > > >>
> > > >>
> > > >> Am 25. Oktober 2023 01:31:19 MESZ schrieb Simon Glass <sjg@chromiu=
m.org>:
> > > >>> U-Boot typically sets up its malloc() pool near the top of memory=
=2E On
> > > >>> ARM64 systems this can result in an SMBIOS table above 4GB which =
is
> > > >>> not supported by SMBIOSv2.
> > > >>>
> > > >>> Work around this problem by providing a new option to choose an a=
ddress
> > > >>> below 4GB (but as high as possible), if needed.
> > > >>
> > > >> You must not overwrite memory controlled by the EFI subsystem with=
out calling its allocator.  We should provide SMBIOS 3. SMBIOS 2 is only a =
fallback for outdated tools.
> > > >
> > > > That is not my intention and I don't believe this code does that. E=
FI
> > > > is not running at this point, is it?
> > >
> > > The function install_smbios_table() only exists if CONFIG_EFI_LOADER=
=3Dy.
> >
> > That is because ARM devices don't normally need it, right? Anyway,
> > that option isn't related to this patch. If ARM devices started using
> > SMBIOS and had another way to pass it to Linux (other than EFI) then
> > we would want to install it.
> >
> > >
> > > We have:
> > > EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, install_smbios_table);
> > > This is invoked after efi_memory_init().
> > >
> > > The EFI specification requires that the memory area occupied by the
> > > SMBIOS table uses one of a specific set of memory types where
> > > EfiRuntimeServicesData is recommended. So you must call
> > >
> > > u64 addr =3D UINT_MAX;
> > > ret =3D efi_allocate_pages(EFI_ALLOCATE_MAX_ADDRESS,
> > > EFI_RUNTIME_SERVICES_DATA, efi_size_in_pages(size), *addr);
> > >
> > > to allocate the memory. If the return code is not EFI_SUCCESS, no mem=
ory
> > > below 4 GiB is available.
> >
> > The root problem here is that x86 and ARM used to work differently.
> > When the ARM SMBIOS stuff was done, it worked by writing the SMBIOS
> > table as part of the 'bootefi' command. On x86, the tables were
> > written on startup, so you can examine them within U-Boot. Clearly the
> > x86 approach is correct. For one thing, a previous-stage bootloader
> > may set up the tables, so it simply isn't valid to write them in that
> > case. So we need to separate writing the tables from telling EFI about
> > them.
> >
> > So I have fixed that, so ARM now writes the tables at the start. But
> > using an EFI allocation function is clearly not right. This is generic
> > code, nothing to do with EFI, really. In fact, the SMBIOS writing
> > should move out of efi_loader. The install_smbios_table() function
> > should be somewhere in lib, i suppose, with just efi_smbios_register()
> > sitting in lib/efi_loader
> >
> > Also, why is efi_memory_init() called early in init? Is there anything
> > that needs that in the init sequence? Could we move it to the end, or
> > perhaps skip it completely until the 'bootefi' command is used?
> >
> > Another point I should make is that it should be fine for U-Boot to
> > put something in memory and then call efi_add_memory_map() to tell EFI
> > about it. What problems does that cause? It isn't as if EFI allocates
> > things in the 'conventional' memory (is that the name for memory below
> > 4GB?) This is how efi_acpi_register() works.
> >
> > (Aside: it is bizarre to me that CONFIG_EFI_LOADER appears in
> > drivers/video/rockchip_rk_vop.c and other such files)
> >
> > >
> > > >
> > > > The bit I am confused about is that we don't support SMBIOS3 in
> > > > U-Boot. I am trying to fix an introduced bug...
> > >
> > > I would not know why we should not use SMBIOS 3.
> >
> > Neither do I. Perhaps there are compatibility concerns? If it is OK to
> > do that then we could go back to my previous series [1]. What do you
> > think?
>=20
> Tom responded but I missed it. In part it says:
>=20
> "So, can we please start by just doing the minimal changes to get the
> SMBIOS table done correctly for memory above 4G, via EFI, and then start
> the next steps?"
>=20
> I am OK to do an EFI hack for ARM so long as we agree that after the
> release we will revert it and generate the table using generic memory
> allocation, not dependent on EFI. Does that sound reasonable?
>=20
> I don't seem to have received any response from Heinrich to the
> various points I made above. I cannot see any response on patchwork
> either.

Drop it right after the release? No. We will replace it with what's more
appropriate once we figure out what that is. And please don't call it a
hack, unless I'm missing something I don't see yet how to make use of
the SMBIOS table on ARM without EFI.  I see something that implies MIPS
can (and loongarch and ia64).

--=20
Tom

--u6vsrdzjXYzrPUV+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVFMOoACgkQFHw5/5Y0
tyyWbAwAgjdTTuZ7NY+AueqdH6IjdHutW/weod10dPODVSJwxAuyNooIe/sIsiqu
w69BJpz6G2VpQ54Izhas+cMT6d7SCPbynTdaXfTP+4CcZskJEoyIojie7cRmSBg3
fPZO0N1RTItr6JPtTGK3cuz85XZ7s/WERjJpHXYHYTZs9I48Pqlj14U8f2N4XNFP
pYrsE9pQfCKjhBiX3jvl1ZI8cxZC1/F87w+dibmM0saSU/e8WOvFPTtprptV8UNA
L1mDOO4nOj0DGpyWqpqkDW4Qov99/pxXUAaMrMxcykZM/K07f88odygbO0Mwhsv9
SDp6Dpq2+nTJ46RI6McovZVfYh61e0AeEhrfxmY3074DqDceHlPRTb4ULdA7lfzK
1cZDqiXkDeHNagQrX5Xaf5mQWgrgYrkGduqBRc7Cm+Fls3Oe/1sQoXUKwZ5MSeJn
AbXO+aI9Z/SF1Od6mtWve9sgWe6SkYoV7TNV1WGcbAlFkNiTJj6vecapmB4F+vv6
P+Y9irHr
=XB7F
-----END PGP SIGNATURE-----

--u6vsrdzjXYzrPUV+--
