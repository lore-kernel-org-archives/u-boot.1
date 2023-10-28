Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E42C4332F
	for <u-boot@archiver.kernel.org>; Sat, 28 Oct 2023 22:00:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73CE18786F;
	Sun, 29 Oct 2023 00:00:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gcMluy4t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 180F08756F; Sun, 29 Oct 2023 00:00:40 +0200 (CEST)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9350B8786F
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 00:00:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-418201cb9e9so24409211cf.0
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 15:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698530428; x=1699135228; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uLubGZLLZ76xU0zbFG2SEKH4/ZYpY7W+auoWCm10G7E=;
 b=gcMluy4tSZ3sUjrptM7y7Kk8eBD7ie3J4MmKHsw++vRoSqbtdI9yZF5Jio3kR1u8/j
 R2WWrNKVNf2CiIRmvo8M8SU0kKjbpzIWJJf+USWxSsfAKg5Yeapf0TbrhGBcYSeJmLZa
 rru4pba3jwVaIbO8H5bGozloAOVRteT9+ILmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698530428; x=1699135228;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uLubGZLLZ76xU0zbFG2SEKH4/ZYpY7W+auoWCm10G7E=;
 b=V1/yDswl5isW1tkj5fDZTtLjLyGnEdfZz3NfbIR/eLI8pzHPhJdyx2xkRVMat8JY5Z
 Uh6oW4alVjvKgsLikH+Drf12rCkfY9aN6QqliwcSGrhCnNqnBEcV6zvWzjzAjvJvT1ks
 Y4dqmN1J/wNyC7c85hVfeY43P45nesir2FSPVECMOAAPudlS0JJvZbOJ6y6vrK3nkyQF
 X6c5n0DJ0Tqvo80TxlpUDMImYNEmPeccqiy5qAfGm+3Jo20keR1Nq5NDPM41S8wCnHLZ
 BEXQMxmKDkVF6+RVruWiQHw9qm6rCwRXNfzJ6hAK5P/0ifArcIaVhhH/ifS4t9U1FHKt
 Cpsg==
X-Gm-Message-State: AOJu0YyUDTAmcTHsf+cnytxojIlu4oePrc0X252mcnAf6AMH18DQU/32
 z0Tt366LN4eoSV4LF1wF4kVluA==
X-Google-Smtp-Source: AGHT+IHy0/PBGCnUuzHNCmcMxz3zgLyrhvNPcI1geJHy8IMtFXIlMLnrl+UkJzh4Ey4mAwc7CMT7DA==
X-Received: by 2002:a05:622a:1c7:b0:41e:23e6:baaf with SMTP id
 t7-20020a05622a01c700b0041e23e6baafmr7657079qtw.68.1698530428302; 
 Sat, 28 Oct 2023 15:00:28 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 c18-20020ac86612000000b004181aa90b46sm1939112qtp.89.2023.10.28.15.00.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 15:00:26 -0700 (PDT)
Date: Sat, 28 Oct 2023 18:00:24 -0400
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
Message-ID: <20231028220024.GR496310@bill-the-cat>
References: <20231025123117.v2.1.I054cad60e00f8cfde39256c7c7d9c960987fb9be@changeid>
 <734658D7-8081-44DC-8168-6EBDBA8D951D@gmx.de>
 <CAPnjgZ2ZFSbUYPVq+A1jQBy8s=DOO8Cz+epHGL++KSEN-pr-wA@mail.gmail.com>
 <32facf81-f2bf-460a-9104-cae1dcef0cbe@gmx.de>
 <CAPnjgZ20bRUP7KFwRpe7dmbxbQFMJmHB55dkXpEjv3fyX++M3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KUIHLJRCGGM7vmJB"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ20bRUP7KFwRpe7dmbxbQFMJmHB55dkXpEjv3fyX++M3A@mail.gmail.com>
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


--KUIHLJRCGGM7vmJB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 29, 2023 at 07:41:27AM +1300, Simon Glass wrote:
> [unfortunately I am not receiving email from the list at present]
>=20
> Hi Heinrich,
>=20
> On Wed, 25 Oct 2023 at 21:39, Heinrich Schuchardt <xypron.glpk@gmx.de> wr=
ote:
> >
> > On 10/25/23 04:49, Simon Glass wrote:
> > > Hi Heinrich,
> > >
> > > On Tue, 24 Oct 2023 at 18:22, Heinrich Schuchardt <xypron.glpk@gmx.de=
> wrote:
> > >>
> > >>
> > >>
> > >> Am 25. Oktober 2023 01:31:19 MESZ schrieb Simon Glass <sjg@chromium.=
org>:
> > >>> U-Boot typically sets up its malloc() pool near the top of memory. =
On
> > >>> ARM64 systems this can result in an SMBIOS table above 4GB which is
> > >>> not supported by SMBIOSv2.
> > >>>
> > >>> Work around this problem by providing a new option to choose an add=
ress
> > >>> below 4GB (but as high as possible), if needed.
> > >>
> > >> You must not overwrite memory controlled by the EFI subsystem withou=
t calling its allocator.  We should provide SMBIOS 3. SMBIOS 2 is only a fa=
llback for outdated tools.
> > >
> > > That is not my intention and I don't believe this code does that. EFI
> > > is not running at this point, is it?
> >
> > The function install_smbios_table() only exists if CONFIG_EFI_LOADER=3D=
y.
>=20
> That is because ARM devices don't normally need it, right? Anyway,
> that option isn't related to this patch. If ARM devices started using
> SMBIOS and had another way to pass it to Linux (other than EFI) then
> we would want to install it.

No one "needs" it, but it can be helpful. And yes, a future discussion
should be about what we should put in an SMBIOS 3 table, and when. But
for today, being part of EFI (outside of X86) is fine.

> > We have:
> > EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, install_smbios_table);
> > This is invoked after efi_memory_init().
> >
> > The EFI specification requires that the memory area occupied by the
> > SMBIOS table uses one of a specific set of memory types where
> > EfiRuntimeServicesData is recommended. So you must call
> >
> > u64 addr =3D UINT_MAX;
> > ret =3D efi_allocate_pages(EFI_ALLOCATE_MAX_ADDRESS,
> > EFI_RUNTIME_SERVICES_DATA, efi_size_in_pages(size), *addr);
> >
> > to allocate the memory. If the return code is not EFI_SUCCESS, no memory
> > below 4 GiB is available.
>=20
> The root problem here is that x86 and ARM used to work differently.
> When the ARM SMBIOS stuff was done, it worked by writing the SMBIOS
> table as part of the 'bootefi' command. On x86, the tables were
> written on startup, so you can examine them within U-Boot. Clearly the
> x86 approach is correct. For one thing, a previous-stage bootloader

I don't think the X86 approach is right, certainly for ARM. We'll be
populating the table with what we're also getting from the device tree
that we're passing to the OS. On x86 I don't know if we'd be loading
anything that might correct/change what goes in the table but on ARM we
have a bunch of places that set the serial# so some function, so some
function in the actual OS boot flow that creates and populates the table
makes sense. I don't know on x86 how we can examine the table.

So, can we please start by just doing the minimal changes to get the
SMBIOS table done correctly for memory above 4G, via EFI, and then start
the next steps?

--=20
Tom

--KUIHLJRCGGM7vmJB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU9hHQACgkQFHw5/5Y0
tyx96Av/SVa1YUN4HnZXL//BhsS7Ih3MJyeFmVu4+sii7H7Nj3uquvQSER7U+X7U
qCxjEkIUWJIhEtw6w+8EhbccUoy406PScxTYXgNBzgD9dR9u7xHWat8MFqy+pJ1D
P3cxxtwBXPcn558wMNvDUeqM84iuLR4+b7cYgEjFq4XfevR1m9hd8GP7ZgbqHfj3
4SZLjmC3dobDdMJuDZKNV+3m+P8K0sU3j3/N4cVEE3Y7aslvPgEgl88WxhvpYRL0
k9JhRGtUnRQCHHNIetJXSmPRI+YabLR/DLS/iwatwdk3HVz6WVzzglvERBOgO+/l
/avu+svpSYFQ5iy34pyG3oXH5xVai2OGek85Qnr6HSgrI0V7yg4SxqoLAyCRz0co
KQ/MRTDe6h4kd7en72ipkgGWYtfp3BZEQ6uOgy0CKoCt4SMOJsfXmXuMGJAWGUan
+nxc/Rf0mV+nvYN6v1ZNQgnFLzrcPdD348tQFRq6ZbwV9wpFAhX5CmL/G+YjSmhY
LvZPRE44
=E+CL
-----END PGP SIGNATURE-----

--KUIHLJRCGGM7vmJB--
