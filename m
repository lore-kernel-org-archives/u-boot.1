Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04130C27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 22:54:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DCC7886F1;
	Wed, 12 Jun 2024 00:54:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HHOsKsBr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B316A886F1; Wed, 12 Jun 2024 00:54:24 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86E9B88744
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 00:54:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-24c9f892aeaso770041fac.2
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 15:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718146460; x=1718751260; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MkJWS6chFMiHif58X/MnAYba+4Ayp25EJMzL2s5fDn8=;
 b=HHOsKsBrXCAZYvgE6MwKaD6eQ9hilFS2D8mGmyi8iDkN09WhMHx20u7Wy5ikDpdN8N
 80K63frqMMgtt5W83br0lJ4OOT9ZwL38USI9fXXy8vLXz8Az3znd4ElZSHA9PTd2xmUs
 yZTGnWHRphYvc0twavvikEAofMBskhKdvTgUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718146460; x=1718751260;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MkJWS6chFMiHif58X/MnAYba+4Ayp25EJMzL2s5fDn8=;
 b=H4f8j1YEktVr1atcZ3WTjP9dpzKfB97U1Mxp3LxouKxwcP4I2alR/I2SPonRDljpAF
 swKxNziY/40Rss8jjlF/XG3ghsYtE5u6Jbt8deu5IIQ1PJUYyQECgMUX4UQZFpZssQy/
 ZjgV8Mo3f/W6/hdq3i9LWX6x8s82PJ1ZsfW8Mq8EpNs9TusJwodOM+cvaS9A+FoMDOn/
 lF1VJrE38t7avZ8ajoUysyvofpSrv/EdfSYWUUOsqhQ+swnbHQEttSWeUxiyTX4krsKQ
 taery09swYIdJgnwJ3wS2SMsw9mY6kSMPS2SfjWKdBN7cKnH01Ch8SDnt+2v/fPomCY1
 +iVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5NTKLesTtsC+g9P2GnB1tseGFVGwtQNpSLA8plc/Wk0eMK3LaKw8r6YYcc5dwBP67n550/bzoTJLAEgcDTXF6s1MmyQ==
X-Gm-Message-State: AOJu0YzAshvLRDjHl8wkYqgchYbmiU6mJlml5V2xppYYX6MRkJLdFN3Y
 NF737KL4yyZpmZTnjSR7ypBbw8/EHRdhkIXSM2QIMlT3HLlnmCYooNlNuvupcRE=
X-Google-Smtp-Source: AGHT+IE6ofTZqKBUFIBITEgFSoXcnszhSgRibtC825BZLa5zf5MJFn1JnSam5LpjPEnzT4wjkBK9gQ==
X-Received: by 2002:a05:6870:a116:b0:254:c08d:cb54 with SMTP id
 586e51a60fabf-25514b4ae44mr233007fac.1.1718146459984; 
 Tue, 11 Jun 2024 15:54:19 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-254a8de199asm1720153fac.22.2024.06.11.15.54.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 15:54:19 -0700 (PDT)
Date: Tue, 11 Jun 2024 16:54:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, u-boot@lists.denx.de
Subject: Re: [RFC PATCH 15/31] efi_memory: add an event handler to update
 memory map
Message-ID: <20240611225417.GN68077@bill-the-cat>
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-16-sughosh.ganu@linaro.org>
 <50d0efab-0df6-47ef-a4e9-b0e3d6ec2556@gmx.de>
 <20240611143635.GF68077@bill-the-cat>
 <CAFLszTiEWw0tey4zeqjPYe2TsSWH1P4Xakn8OrOKSwqDU+EM_A@mail.gmail.com>
 <20240611210138.GL68077@bill-the-cat>
 <CAFLszThcanoRd=8A8wq0RWzSHerPPZxYdvyT8AjLNfH1QvyDiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="okHPy4+GYPr3OYwk"
Content-Disposition: inline
In-Reply-To: <CAFLszThcanoRd=8A8wq0RWzSHerPPZxYdvyT8AjLNfH1QvyDiw@mail.gmail.com>
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


--okHPy4+GYPr3OYwk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 04:22:25PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 11 Jun 2024 at 15:01, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Jun 11, 2024 at 12:52:19PM -0600, Simon Glass wrote:
> > > Hi,
> > >
> > > On Tue, 11 Jun 2024 at 08:36, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Jun 11, 2024 at 12:17:16PM +0200, Heinrich Schuchardt wrote:
> > > > > On 07.06.24 20:52, Sughosh Ganu wrote:
> > > > > > There are events that would be used to notify other interested =
modules
> > > > > > of any changes in available and occupied memory. This would hap=
pen
> > > > > > when a module allocates or reserves memory, or frees up memory.=
 These
> > > > > > changes in memory map should be notified to other interested mo=
dules
> > > > > > so that the allocated memory does not get overwritten. Add an e=
vent
> > > > > > handler in the EFI memory module to update the EFI memory map
> > > > > > accordingly when such changes happen. As a consequence, any sub=
sequent
> > > > > > memory request would honour the updated memory map and only ava=
ilable
> > > > > > memory would be allocated from.
> > > > > >
> > > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > > ---
> > > > > >   lib/efi_loader/efi_memory.c | 70 ++++++++++++++++++++++++++++=
++-------
> > > > > >   1 file changed, 58 insertions(+), 12 deletions(-)
> > > > > >
> > > > > > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_m=
emory.c
> > > > > > index 435e580fb3..93244161b0 100644
> > > > > > --- a/lib/efi_loader/efi_memory.c
> > > > > > +++ b/lib/efi_loader/efi_memory.c
> > > > > > @@ -73,6 +73,10 @@ struct efi_pool_allocation {
> > > > > >   #if CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY)
> > > > > >   extern bool is_addr_in_ram(uintptr_t addr);
> > > > > >
> > > > > > +static efi_status_t __efi_add_memory_map_pg(u64 start, u64 pag=
es,
> > > > > > +                                       int memory_type,
> > > > > > +                                       bool overlap_only_ram);
> > > > > > +
> > > > > >   static void efi_map_update_notify(u64 addr, u64 size, u8 op)
> > > > > >   {
> > > > > >     struct event_efi_mem_map_update efi_map =3D {0};
> > > > > > @@ -84,6 +88,34 @@ static void efi_map_update_notify(u64 addr, =
u64 size, u8 op)
> > > > > >     if (is_addr_in_ram((uintptr_t)addr))
> > > > > >             event_notify(EVT_EFI_MEM_MAP_UPDATE, &efi_map, size=
of(efi_map));
> > > > > >   }
> > > > > > +
> > > > > > +static int lmb_mem_map_update_sync(void *ctx, struct event *ev=
ent)
> > > > > > +{
> > > > > > +   u8 op;
> > > > > > +   u64 addr;
> > > > > > +   u64 pages;
> > > > > > +   efi_status_t status;
> > > > > > +   struct event_lmb_map_update *lmb_map =3D &event->data.lmb_m=
ap;
> > > > > > +
> > > > > > +   addr =3D (uintptr_t)map_sysmem(lmb_map->base, 0);
> > > > > > +   pages =3D efi_size_in_pages(lmb_map->size + (addr & EFI_PAG=
E_MASK));
> > > > > > +   op =3D lmb_map->op;
> > > > > > +   addr &=3D ~EFI_PAGE_MASK;
> > > > > > +
> > > > > > +   if (op !=3D MAP_OP_RESERVE && op !=3D MAP_OP_FREE) {
> > > > > > +           log_debug("Invalid map update op received (%d)\n", =
op);
> > > > > > +           return -1;
> > > > > > +   }
> > > > > > +
> > > > > > +   status =3D __efi_add_memory_map_pg(addr, pages,
> > > > > > +                                    op =3D=3D MAP_OP_FREE ?
> > > > > > +                                    EFI_CONVENTIONAL_MEMORY :
> > > > >
> > > > > This is dangerous. LMB might turn memory that is marked as
> > > > > EfiReservedMemory which the OS must respect into EfiBootServicesD=
ata
> > > > > which the OS may discard.
> > > > >
> > > > > E.g. initr_lmb() is being called after efi_memory_init().
> > > > >
> > > > > Getting all cases of synchronization properly tested seems very h=
ard to
> > > > > me. Everything would be much easier if we had only a single memory
> > > > > management system.
> > > >
> > > > Yes, Sughosh is working on the single memory reservation system for
> > > > everyone to use. This pairs with the single memory allocation system
> > > > (malloc) that we have. Parts of the code base that aren't keeping t=
hese
> > > > systems up to date / obeying their results need to be corrected.
> > >
> > > The EFI allocations don't happen until boot time...so why do we need
> > > to do this now? We can instead have an EFI function to scan LMB and
> > > add to its memory map.
> >
> > We're talking about reservations, not allocations. So yes, when someone
> > is making their reservation, they need to make it. I don't understand
> > your question.
>=20
> As I understand it, this is used to tell EFI about a memory reservation.

This patch, or this series? This series isn't about EFI. This patch is,
yes.

> But the EFI code can scan the LMB reservations just before booting and
> update its tables. I don't see a need to keep them in sync before the
> boot actually happens.

But that wouldn't work. If something needs to reserve a region it needs
to do it when it starts using it. It's not about the EFI map for the OS,
it's about making sure that U-Boot doesn't scribble over a now-reserved
area.

--=20
Tom

--okHPy4+GYPr3OYwk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZo1ZUACgkQFHw5/5Y0
tyzbjwv+LaIm/PsV+2s2jhT/NP49DyaGctgDsOo4NaIjO5lrOfqn2AAHn+Hn+zye
xpYDbO3MSqnHVx+TBhCEPFLhlYjrWnpF8NR/O2//9qW4TdsrCwYok95refD6bCkD
1cK+P+PAIVyO/ZQdQC183cOiEHtbdjXMB5VXbAkax01nFMxCfYKTJ+jICyTYHwLD
vE6WW/lYYjFrAZRsKEJrJvjqCUiVm6lwA68RVa5RN2AH2vC3vmHtkl9uUdZW2n9c
kZ7R8r+19+WwVfBSo+qiOqCYbL5HL4vxNLMkCHbO5SH5H7lhe1vS5R2WRcgl6Hpn
2bGqEAq9GGdGyTEMWlG+s7Oz71fN57TavlMZBPPfLoaUbPcJAwpXNvXvMAAaONNW
XowuGOPYQAFmV0Xuef3XHLkKswZcv8ln+R0d2cYftQ4wMMyRtSsAr9ImW/nMAgRz
5HxpqR6NO0ckO0hJ0dMdYQ08QmehKeFTFMJ9SyEnJznkaLua2ED5n1zkjldioUfF
v/c6cImo
=hMIm
-----END PGP SIGNATURE-----

--okHPy4+GYPr3OYwk--
