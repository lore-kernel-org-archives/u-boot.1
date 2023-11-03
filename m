Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219A6C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 20:13:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60DE887024;
	Fri,  3 Nov 2023 21:13:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="m+PPtJgX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0886C8711B; Fri,  3 Nov 2023 21:13:49 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB36D86B18
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 21:13:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6705379b835so14464786d6.1
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 13:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699042425; x=1699647225; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RwG27bdoJhs9Gu145hlirGovLyGPDmAEJ5WoiZZfIK4=;
 b=m+PPtJgX+Wis64IqCuw6L4/+jqmaNB51y+qrcu6eEi3BeKAgB6Mvu9f8j1NpLnR8yO
 3i6O/Qjykv9ekRc2mkHyQl6bP8/SD4Owqg/A3sE3zPBvKXHwxki88c/YMdI48tOJGYqn
 EWQMjvQRHJrEsKM6tq4n0dip9AhZUx+iXFZso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699042425; x=1699647225;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RwG27bdoJhs9Gu145hlirGovLyGPDmAEJ5WoiZZfIK4=;
 b=VCm6siP+4DuelxhVsdl1sUlMuwn4FaSxGMi4/K9IJbeDlvk/zV360t9V6Zdp2BjNPF
 Wf+9p/3Ew6bS8itAiga6H2JlUrUVybeSfjObG/uCKLzZ6p36oCh2im4My0FjWXoZu5dO
 yLlBmaqsAzYnzYltV8cB4wmVBgieNDFEW6Lec0f0DZwOUQ7hynDz2SD43vpV006T+MvS
 tf+63exy3gsNkqCEFBWZoOpe8iS5CSljFj3G61UOVRJT9GJ7/u7Ahi1HScLzqpUFqoF6
 14GYopXsWNUNadsrqRcVUVDgMLNmbopWqf/CUfNhcX0oNASIfc/qo+2PJ0f8TGPfHoCZ
 nOiQ==
X-Gm-Message-State: AOJu0YwTTKNlEun+VAroR0eZR1rvUrQGGk8rRtBfyz/s7D/bUClq5Y3x
 roUHysoWRIE9v2TyQByhdb+M1w==
X-Google-Smtp-Source: AGHT+IGcLgxKB6qsQ64mRZ9ex978Did6pvyQJUZGqOhea9n8F+1Hi3CdTYK0sSZhfM4c8jopq9QsYA==
X-Received: by 2002:a05:6214:2b08:b0:65a:fedd:3c69 with SMTP id
 jx8-20020a0562142b0800b0065afedd3c69mr27357583qvb.0.1699042424799; 
 Fri, 03 Nov 2023 13:13:44 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 cu8-20020a05621417c800b0066d1e71e515sm1045149qvb.113.2023.11.03.13.13.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 13:13:44 -0700 (PDT)
Date: Fri, 3 Nov 2023 16:13:41 -0400
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
Message-ID: <20231103201341.GU496310@bill-the-cat>
References: <20231025123117.v2.1.I054cad60e00f8cfde39256c7c7d9c960987fb9be@changeid>
 <734658D7-8081-44DC-8168-6EBDBA8D951D@gmx.de>
 <CAPnjgZ2ZFSbUYPVq+A1jQBy8s=DOO8Cz+epHGL++KSEN-pr-wA@mail.gmail.com>
 <32facf81-f2bf-460a-9104-cae1dcef0cbe@gmx.de>
 <CAPnjgZ20bRUP7KFwRpe7dmbxbQFMJmHB55dkXpEjv3fyX++M3A@mail.gmail.com>
 <CAPnjgZ1Ao_ikgwPR8-fGVzbBfzRQYm0bxz9LgVHs1FP7+HG3cw@mail.gmail.com>
 <CC91949C-3BBF-452B-906F-93520A314858@gmx.de>
 <CAPnjgZ0sgCtPXa5ZOOpW-zyCnVm_cNU3OyDjzPercdY1=Y1_dQ@mail.gmail.com>
 <20231103192548.GR496310@bill-the-cat>
 <CAPnjgZ1QhQ0Kx7S8nof4Hs6cX9b+tKyMOyzg2dod-WvjOkoMTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sIlYA1uFh/EGwhIL"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ1QhQ0Kx7S8nof4Hs6cX9b+tKyMOyzg2dod-WvjOkoMTg@mail.gmail.com>
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


--sIlYA1uFh/EGwhIL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 03, 2023 at 01:38:59PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 3 Nov 2023 at 13:26, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Nov 03, 2023 at 12:14:46PM -0600, Simon Glass wrote:
> > > Hi Heinrich,
> > >
> > > On Fri, 3 Nov 2023 at 11:52, Heinrich Schuchardt <xypron.glpk@gmx.de>=
 wrote:
> > > >
> > > >
> > > >
> > > > Am 3. November 2023 19:12:40 OEZ schrieb Simon Glass <sjg@chromium.=
org>:
> > > > >Hi,
> > > > >
> > > > >On Sat, 28 Oct 2023 at 12:41, Simon Glass <sjg@chromium.org> wrote:
> > > > >>
> > > > >> [unfortunately I am not receiving email from the list at present]
> > > > >>
> > > > >> Hi Heinrich,
> > > > >>
> > > > >> On Wed, 25 Oct 2023 at 21:39, Heinrich Schuchardt <xypron.glpk@g=
mx.de> wrote:
> > > > >> >
> > > > >> > On 10/25/23 04:49, Simon Glass wrote:
> > > > >> > > Hi Heinrich,
> > > > >> > >
> > > > >> > > On Tue, 24 Oct 2023 at 18:22, Heinrich Schuchardt <xypron.gl=
pk@gmx.de> wrote:
> > > > >> > >>
> > > > >> > >>
> > > > >> > >>
> > > > >> > >> Am 25. Oktober 2023 01:31:19 MESZ schrieb Simon Glass <sjg@=
chromium.org>:
> > > > >> > >>> U-Boot typically sets up its malloc() pool near the top of=
 memory. On
> > > > >> > >>> ARM64 systems this can result in an SMBIOS table above 4GB=
 which is
> > > > >> > >>> not supported by SMBIOSv2.
> > > > >> > >>>
> > > > >> > >>> Work around this problem by providing a new option to choo=
se an address
> > > > >> > >>> below 4GB (but as high as possible), if needed.
> > > > >> > >>
> > > > >> > >> You must not overwrite memory controlled by the EFI subsyst=
em without calling its allocator.  We should provide SMBIOS 3. SMBIOS 2 is =
only a fallback for outdated tools.
> > > > >> > >
> > > > >> > > That is not my intention and I don't believe this code does =
that. EFI
> > > > >> > > is not running at this point, is it?
> > > > >> >
> > > > >> > The function install_smbios_table() only exists if CONFIG_EFI_=
LOADER=3Dy.
> > > > >>
> > > > >> That is because ARM devices don't normally need it, right? Anywa=
y,
> > > > >> that option isn't related to this patch. If ARM devices started =
using
> > > > >> SMBIOS and had another way to pass it to Linux (other than EFI) =
then
> > > > >> we would want to install it.
> > > > >>
> > > > >> >
> > > > >> > We have:
> > > > >> > EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, install_smbios_table);
> > > > >> > This is invoked after efi_memory_init().
> > > > >> >
> > > > >> > The EFI specification requires that the memory area occupied b=
y the
> > > > >> > SMBIOS table uses one of a specific set of memory types where
> > > > >> > EfiRuntimeServicesData is recommended. So you must call
> > > > >> >
> > > > >> > u64 addr =3D UINT_MAX;
> > > > >> > ret =3D efi_allocate_pages(EFI_ALLOCATE_MAX_ADDRESS,
> > > > >> > EFI_RUNTIME_SERVICES_DATA, efi_size_in_pages(size), *addr);
> > > > >> >
> > > > >> > to allocate the memory. If the return code is not EFI_SUCCESS,=
 no memory
> > > > >> > below 4 GiB is available.
> > > > >>
> > > > >> The root problem here is that x86 and ARM used to work different=
ly.
> > > > >> When the ARM SMBIOS stuff was done, it worked by writing the SMB=
IOS
> > > > >> table as part of the 'bootefi' command. On x86, the tables were
> > > > >> written on startup, so you can examine them within U-Boot. Clear=
ly the
> > > > >> x86 approach is correct. For one thing, a previous-stage bootloa=
der
> > > > >> may set up the tables, so it simply isn't valid to write them in=
 that
> > > > >> case. So we need to separate writing the tables from telling EFI=
 about
> > > > >> them.
> > > > >>
> > > > >> So I have fixed that, so ARM now writes the tables at the start.=
 But
> > > > >> using an EFI allocation function is clearly not right. This is g=
eneric
> > > > >> code, nothing to do with EFI, really. In fact, the SMBIOS writing
> > > > >> should move out of efi_loader. The install_smbios_table() functi=
on
> > > > >> should be somewhere in lib, i suppose, with just efi_smbios_regi=
ster()
> > > > >> sitting in lib/efi_loader
> > > > >>
> > > > >> Also, why is efi_memory_init() called early in init? Is there an=
ything
> > > > >> that needs that in the init sequence? Could we move it to the en=
d, or
> > > > >> perhaps skip it completely until the 'bootefi' command is used?
> > > > >>
> > > > >> Another point I should make is that it should be fine for U-Boot=
 to
> > > > >> put something in memory and then call efi_add_memory_map() to te=
ll EFI
> > > > >> about it. What problems does that cause? It isn't as if EFI allo=
cates
> > > > >> things in the 'conventional' memory (is that the name for memory=
 below
> > > > >> 4GB?) This is how efi_acpi_register() works.
> > > > >>
> > > > >> (Aside: it is bizarre to me that CONFIG_EFI_LOADER appears in
> > > > >> drivers/video/rockchip_rk_vop.c and other such files)
> > > > >>
> > > > >> >
> > > > >> > >
> > > > >> > > The bit I am confused about is that we don't support SMBIOS3=
 in
> > > > >> > > U-Boot. I am trying to fix an introduced bug...
> > > > >> >
> > > > >> > I would not know why we should not use SMBIOS 3.
> > > > >>
> > > > >> Neither do I. Perhaps there are compatibility concerns? If it is=
 OK to
> > > > >> do that then we could go back to my previous series [1]. What do=
 you
> > > > >> think?
> > > > >
> > > > >Tom responded but I missed it. In part it says:
> > > > >
> > > > >"So, can we please start by just doing the minimal changes to get =
the
> > > > >SMBIOS table done correctly for memory above 4G, via EFI, and then=
 start
> > > > >the next steps?"
> > > > >
> > > > >I am OK to do an EFI hack for ARM so long as we agree that after t=
he
> > > > >release we will revert it and generate the table using generic mem=
ory
> > > > >allocation, not dependent on EFI. Does that sound reasonable?
> > > > >
> > > > >I don't seem to have received any response from Heinrich to the
> > > > >various points I made above. I cannot see any response on patchwork
> > > > >either.
> > > > >
> > > > >Regards,
> > > > >Simon
> > > >
> > > > All memory below the stack is controlled by the EFI subsystem. I no=
tified you of the function you need to call. I can't see what information y=
ou are lacking.
> > >
> > > That is fine when EFI is used, but what about when it is not? That is
> > > the piece I don't yet understand.
> >
> > We also don't have the use case for when EFI is not used defined and
> > understood, so it can wait until then?
>=20
> There is/was an argument going on where (for ARM) the SMBIOS table
> requires ACPI and EFI. So I am nervous about anything like that. EFI
> has become a huge impediment to booting with open source components.
> If there has been an agreement on how ARM can boot without EFI (but
> still provide SMBIOS), please can someone link to it?

I think you're missing things right now.  Are you sure you need ACPI for
SMBIOS on 64bit ARM platforms to be seen and used? That's not what was
hearing just yesterday but I don't have something I can double check
that on real quick. What is unclear is that ARM and SMBIOS without EFI
is something that's usable today as I suspect that nothing says where
the SMBIOS table will be found, as there's not some legacy case like x86
of a known hard-coded location.

> The fact is that U-Boot makes lots of allocations while it runs. None
> of them go through the EFI allocator, so far as I know. Certainly they
> shouldn't. Then at the end, EFI just adds allocations for them
> retrospectively. What change that?

It depends on what allocations you're talking about? If you want to
allocate something that will be preserved and untouched and passed along
to the kernel then yes, you're either doing what EFI does or you're
doing whatever else we do for special cases like initrd/dtb. Saying "and
smbios too" means that yes, it's either EFI (because that will in turn
do what needs to be done so the OS knows it exists and where it exists)
or it's a special case EFI isn't involved and however the OS knows to
not trample it is how it's not trampled.

> EFI is not in control of memory allocation in U-Boot. In fact, the
> efi_memory_init() call should probably be dropped, just done when
> bootefi starts. It seems to be creating a lot of confusion.
>=20
> My patch here does work, so far as I can tell. It adds an allocation
> correctly, in the same manner as is done with ACPI - see
> efi_acpi_register(). Given all the uncertainty I think we should
> consider taking this patch as it is for now. I see it is marked as
> 'changes requested' in patchwork so I have changed it to 'New', hoping
> that it will get another look.

The problem will then be that the table isn't preserved and used on ARM
with EFI? What cases have you tested here with all of this.

--=20
Tom

--sIlYA1uFh/EGwhIL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVFVHUACgkQFHw5/5Y0
tyzClAv8DdR6zmkHjC3EJROZvzdS8qGy7RA1zdPBwNdQP2xSBHZOdAtG+zVoIgo8
wVsWUdbDXusM47CFS1VUcQE04CGjP03fclTjBhKGuvUI8/eWCLUb0vS9q1fNoY9g
r0+TufUJAap4oWTqD8fl2zYLnT1vsOnbKZxSDb1KRaOWThjp/O+eCnZJTFCCyA1V
snI1UTLX+5+0Y5n8P0R8gnx77ND4Tatdv5qhe9m/woyFbJy7bB3ZDfLrUZQaKzrC
N4VlDrT/3Ht8qUWG+arqt68KgGB5lh9Clbs71RIc3EVYfK3d4D44sYIVS3EJMg2v
z01Q2Pv0DaGSioa2VjdJIwKRzEtzcJMNc9KEgHGqU5coBdFJLvTIb329rScGzn9/
2HFnQdD+eJgf6X3DGw20yMQqbHPOKcEnJqp+rgzkJTY5Ja4kDqnf+JlY5NV4vDGk
FVZGiq6DUNEVOy83/HLI7XfFT+n6q6cVHvfiRngApWGjsIpDMw9gd3m6fgyzMkmf
HAaUp6AG
=f8+r
-----END PGP SIGNATURE-----

--sIlYA1uFh/EGwhIL--
