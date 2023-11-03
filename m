Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FC5C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 19:26:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C61487438;
	Fri,  3 Nov 2023 20:26:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q+V27TPo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF7C487444; Fri,  3 Nov 2023 20:26:21 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E99986E6C
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 20:26:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5a82f176860so29334167b3.1
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 12:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699039576; x=1699644376; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=p29PqIqR+THMEloLzPFQ6qO4/rmVZZqkfg7Mm0mPqQI=;
 b=Q+V27TPo+sCFlO8FKQCG9oBvDkGsTxZQb0GyR8GzwuE2OCns4bkK2c/40IYzQAEt1u
 zq+Dw/MJ/t4d2GvsbhrL6Af8MpHTrESJ/iD79KfGnspjvEhONEYGHWTj/AqllFMnUMHY
 4b5EH6Yz2EcOzhRJVih9OUEvmVkNFzlEjiCUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699039576; x=1699644376;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p29PqIqR+THMEloLzPFQ6qO4/rmVZZqkfg7Mm0mPqQI=;
 b=PMra4lj4y/k/9lTqz92hna8w54l2HMc+zn0tbexuCm/mR/+/G1YA4RO4aWKqK3pxeT
 IYrUJTDgC9ACYKkSc4WXR+fPMC4x+4cgEAOFdqN5wqVOIxrzQoIznLVIB4Zofsi+ux21
 zK5rSdfmxeMqNG2qt6HdI9EoJdXKneI/MDJwJ77gvG33f7dbs1Tkxv3o9g2s+ty6SzQ7
 s2c/cgj/xEDCKU3Y0BPkOb8Wu1rTvJW0yNJYu91OXBqcbQtXyncDkIseAsUC2nIdIbWr
 MZnnFuza8ZCmUYU7GdiwFDxoIkugXxZx+eEPhFyrMjyqwpPiGjhFg+2hIr6mUdnVlblD
 VpkQ==
X-Gm-Message-State: AOJu0YySFtZBn+hARfEo25Oi2qW/o8grvaEB4b2ghVat8gEKJoag9Ltb
 nlKktH1aful1csmrf4PJBjAYqw==
X-Google-Smtp-Source: AGHT+IHeSjEFUESVkLFACQU/rWp7MDyYiWNV6TnD9o673kg/xeXVlcFMnNaV/0F0nbZ7m9dtKInA+w==
X-Received: by 2002:a25:d709:0:b0:da0:442f:988e with SMTP id
 o9-20020a25d709000000b00da0442f988emr20610118ybg.19.1699039575806; 
 Fri, 03 Nov 2023 12:26:15 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 t9-20020a0cef49000000b0066d12d1351fsm1000071qvs.143.2023.11.03.12.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 12:25:55 -0700 (PDT)
Date: Fri, 3 Nov 2023 15:25:48 -0400
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
Message-ID: <20231103192548.GR496310@bill-the-cat>
References: <20231025123117.v2.1.I054cad60e00f8cfde39256c7c7d9c960987fb9be@changeid>
 <734658D7-8081-44DC-8168-6EBDBA8D951D@gmx.de>
 <CAPnjgZ2ZFSbUYPVq+A1jQBy8s=DOO8Cz+epHGL++KSEN-pr-wA@mail.gmail.com>
 <32facf81-f2bf-460a-9104-cae1dcef0cbe@gmx.de>
 <CAPnjgZ20bRUP7KFwRpe7dmbxbQFMJmHB55dkXpEjv3fyX++M3A@mail.gmail.com>
 <CAPnjgZ1Ao_ikgwPR8-fGVzbBfzRQYm0bxz9LgVHs1FP7+HG3cw@mail.gmail.com>
 <CC91949C-3BBF-452B-906F-93520A314858@gmx.de>
 <CAPnjgZ0sgCtPXa5ZOOpW-zyCnVm_cNU3OyDjzPercdY1=Y1_dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2VHKUw9uykRhR5Xp"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ0sgCtPXa5ZOOpW-zyCnVm_cNU3OyDjzPercdY1=Y1_dQ@mail.gmail.com>
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


--2VHKUw9uykRhR5Xp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 03, 2023 at 12:14:46PM -0600, Simon Glass wrote:
> Hi Heinrich,
>=20
> On Fri, 3 Nov 2023 at 11:52, Heinrich Schuchardt <xypron.glpk@gmx.de> wro=
te:
> >
> >
> >
> > Am 3. November 2023 19:12:40 OEZ schrieb Simon Glass <sjg@chromium.org>:
> > >Hi,
> > >
> > >On Sat, 28 Oct 2023 at 12:41, Simon Glass <sjg@chromium.org> wrote:
> > >>
> > >> [unfortunately I am not receiving email from the list at present]
> > >>
> > >> Hi Heinrich,
> > >>
> > >> On Wed, 25 Oct 2023 at 21:39, Heinrich Schuchardt <xypron.glpk@gmx.d=
e> wrote:
> > >> >
> > >> > On 10/25/23 04:49, Simon Glass wrote:
> > >> > > Hi Heinrich,
> > >> > >
> > >> > > On Tue, 24 Oct 2023 at 18:22, Heinrich Schuchardt <xypron.glpk@g=
mx.de> wrote:
> > >> > >>
> > >> > >>
> > >> > >>
> > >> > >> Am 25. Oktober 2023 01:31:19 MESZ schrieb Simon Glass <sjg@chro=
mium.org>:
> > >> > >>> U-Boot typically sets up its malloc() pool near the top of mem=
ory. On
> > >> > >>> ARM64 systems this can result in an SMBIOS table above 4GB whi=
ch is
> > >> > >>> not supported by SMBIOSv2.
> > >> > >>>
> > >> > >>> Work around this problem by providing a new option to choose a=
n address
> > >> > >>> below 4GB (but as high as possible), if needed.
> > >> > >>
> > >> > >> You must not overwrite memory controlled by the EFI subsystem w=
ithout calling its allocator.  We should provide SMBIOS 3. SMBIOS 2 is only=
 a fallback for outdated tools.
> > >> > >
> > >> > > That is not my intention and I don't believe this code does that=
=2E EFI
> > >> > > is not running at this point, is it?
> > >> >
> > >> > The function install_smbios_table() only exists if CONFIG_EFI_LOAD=
ER=3Dy.
> > >>
> > >> That is because ARM devices don't normally need it, right? Anyway,
> > >> that option isn't related to this patch. If ARM devices started using
> > >> SMBIOS and had another way to pass it to Linux (other than EFI) then
> > >> we would want to install it.
> > >>
> > >> >
> > >> > We have:
> > >> > EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, install_smbios_table);
> > >> > This is invoked after efi_memory_init().
> > >> >
> > >> > The EFI specification requires that the memory area occupied by the
> > >> > SMBIOS table uses one of a specific set of memory types where
> > >> > EfiRuntimeServicesData is recommended. So you must call
> > >> >
> > >> > u64 addr =3D UINT_MAX;
> > >> > ret =3D efi_allocate_pages(EFI_ALLOCATE_MAX_ADDRESS,
> > >> > EFI_RUNTIME_SERVICES_DATA, efi_size_in_pages(size), *addr);
> > >> >
> > >> > to allocate the memory. If the return code is not EFI_SUCCESS, no =
memory
> > >> > below 4 GiB is available.
> > >>
> > >> The root problem here is that x86 and ARM used to work differently.
> > >> When the ARM SMBIOS stuff was done, it worked by writing the SMBIOS
> > >> table as part of the 'bootefi' command. On x86, the tables were
> > >> written on startup, so you can examine them within U-Boot. Clearly t=
he
> > >> x86 approach is correct. For one thing, a previous-stage bootloader
> > >> may set up the tables, so it simply isn't valid to write them in that
> > >> case. So we need to separate writing the tables from telling EFI abo=
ut
> > >> them.
> > >>
> > >> So I have fixed that, so ARM now writes the tables at the start. But
> > >> using an EFI allocation function is clearly not right. This is gener=
ic
> > >> code, nothing to do with EFI, really. In fact, the SMBIOS writing
> > >> should move out of efi_loader. The install_smbios_table() function
> > >> should be somewhere in lib, i suppose, with just efi_smbios_register=
()
> > >> sitting in lib/efi_loader
> > >>
> > >> Also, why is efi_memory_init() called early in init? Is there anythi=
ng
> > >> that needs that in the init sequence? Could we move it to the end, or
> > >> perhaps skip it completely until the 'bootefi' command is used?
> > >>
> > >> Another point I should make is that it should be fine for U-Boot to
> > >> put something in memory and then call efi_add_memory_map() to tell E=
FI
> > >> about it. What problems does that cause? It isn't as if EFI allocates
> > >> things in the 'conventional' memory (is that the name for memory bel=
ow
> > >> 4GB?) This is how efi_acpi_register() works.
> > >>
> > >> (Aside: it is bizarre to me that CONFIG_EFI_LOADER appears in
> > >> drivers/video/rockchip_rk_vop.c and other such files)
> > >>
> > >> >
> > >> > >
> > >> > > The bit I am confused about is that we don't support SMBIOS3 in
> > >> > > U-Boot. I am trying to fix an introduced bug...
> > >> >
> > >> > I would not know why we should not use SMBIOS 3.
> > >>
> > >> Neither do I. Perhaps there are compatibility concerns? If it is OK =
to
> > >> do that then we could go back to my previous series [1]. What do you
> > >> think?
> > >
> > >Tom responded but I missed it. In part it says:
> > >
> > >"So, can we please start by just doing the minimal changes to get the
> > >SMBIOS table done correctly for memory above 4G, via EFI, and then sta=
rt
> > >the next steps?"
> > >
> > >I am OK to do an EFI hack for ARM so long as we agree that after the
> > >release we will revert it and generate the table using generic memory
> > >allocation, not dependent on EFI. Does that sound reasonable?
> > >
> > >I don't seem to have received any response from Heinrich to the
> > >various points I made above. I cannot see any response on patchwork
> > >either.
> > >
> > >Regards,
> > >Simon
> >
> > All memory below the stack is controlled by the EFI subsystem. I notifi=
ed you of the function you need to call. I can't see what information you a=
re lacking.
>=20
> That is fine when EFI is used, but what about when it is not? That is
> the piece I don't yet understand.

We also don't have the use case for when EFI is not used defined and
understood, so it can wait until then?

--=20
Tom

--2VHKUw9uykRhR5Xp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVFSTkACgkQFHw5/5Y0
tyxZ3wwAiWXT1eKXk1pScVx1fXQBkEFbRrBcREtx640Zq5kyHZCN1OPTDwlUIJvw
nEiemuTVL2jNUnzOvPG0Z+W0XoP/yIsj4k91G/UBzceu2e8nEFFE4NSumlX/iEaW
DcTKPadd/qxj4nvez/QOTiKHxBIogwTM5NfpKbiOd2LORMEvz5xRCpitSNAe4X3G
OVART0TylwY29P8bkNf+SGNs12ejeC/2EfhJstznfUyGnsfKRqURd6/sau4gDVJg
4q6wJmoWLIvf4P3vQzDaZ4QD/SH9BAX7edTqUtH0OYunnKi6lg7pwgaYw18ShMdp
N1Smzv7a/iMGVb5taCQ92Lo1EplC628E9+HsfW9tA7msA5dXvJFB/bv1eFfZ0SO8
BRcKPZQincuhiC1w1ZYxXMEKBnf/jem1o6an0rA4RfED2iIr+FNLBcRWUwWyy8zL
wf5Am848iedzpMjP3DElksR8an7tm+jQ2P8dU/OcE9yEddktZ0IFD+JyFInRpkjZ
vAHJLxT4
=4JDo
-----END PGP SIGNATURE-----

--2VHKUw9uykRhR5Xp--
