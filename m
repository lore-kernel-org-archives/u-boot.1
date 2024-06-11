Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438DEC27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 21:02:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C459F88701;
	Tue, 11 Jun 2024 23:01:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Noetu1nw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21FD988709; Tue, 11 Jun 2024 23:01:45 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C21AF88783
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 23:01:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6f8ef63714cso906178a34.1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 14:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718139701; x=1718744501; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=V28sbl+7O8HKe9UvpJOb0X2cnWy84IN6kMVGvY6xIPQ=;
 b=Noetu1nwCEd0lk8aE+30WodR24Q7XA/YRUXO+XzUU7Vn+gDFaBw6XZ+JYmE1dFUJjb
 ggfOIlnq9qFVcLOCYVGgTUylftFUygO0RU/CGPx9AmKC/bPYUw6orQQVBcsZSo8hxzST
 MMABqhD/KChT7cfSCC0/zZ166vRbW/uIY2L9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718139701; x=1718744501;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V28sbl+7O8HKe9UvpJOb0X2cnWy84IN6kMVGvY6xIPQ=;
 b=ilIKHjXtG0SN50dViyK5u7R88pQObcYqLDqS87dxY9V77X5vLBrGrT+0IVDP8Ys3yF
 i6Im3nhsA8u40A/DHLRKhBV0I7rtpEEaTpTLHm7ng7UlV0a8efBZwdXsjjiTobTh+F9U
 xX7cV2G6NMuQsMSHbfBuc+IcZchRW459ATKBhISZtediNK0B2Wi3LhOysGK4hO4hiFUB
 2SJWEQGALUl5fQjhYD8wdHl8F1her3oVsm1cak8FZHSrNSURhwiXaYNA8PiOSCf9WvAK
 T0e9vYNXcHskXRr72wEz8S3Q4jWWY1rNCpNZmxpAFpVOfFpE+q6fAQDm1zEgnrnFy1Ce
 qwmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDWuI3aER8NtEdEe+M0HLehjZtw+qRUw9TVAxLp0aOS42/s2AR9VDh7aGo+crROpFYZZ10eq/B3DNgOYjp97epBjQ5fA==
X-Gm-Message-State: AOJu0YybN1txsLnhHPf6PVK81JWonX0nPS545y8Yoygj553WlafJHPPq
 dqwuOVE3HNHgKNbmjAhfnbAQPkTP7vFiaDQ5uyy59Xbxpr6wKu1GRnCc72iw8m4=
X-Google-Smtp-Source: AGHT+IHQQnIgJSCiuwP2WjYWOsZz4tM7skBRMpq/gwiB3bD8HpOp81TRERZk0/Aqg+eaG9yvfuucWQ==
X-Received: by 2002:a05:6871:79a1:b0:24f:c95b:ab6 with SMTP id
 586e51a60fabf-25514b4d565mr5965fac.8.1718139701268; 
 Tue, 11 Jun 2024 14:01:41 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-254480d9c79sm3040337fac.52.2024.06.11.14.01.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 14:01:40 -0700 (PDT)
Date: Tue, 11 Jun 2024 15:01:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, u-boot@lists.denx.de
Subject: Re: [RFC PATCH 15/31] efi_memory: add an event handler to update
 memory map
Message-ID: <20240611210138.GL68077@bill-the-cat>
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-16-sughosh.ganu@linaro.org>
 <50d0efab-0df6-47ef-a4e9-b0e3d6ec2556@gmx.de>
 <20240611143635.GF68077@bill-the-cat>
 <CAFLszTiEWw0tey4zeqjPYe2TsSWH1P4Xakn8OrOKSwqDU+EM_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kAi8ujN4wSrvQZ9W"
Content-Disposition: inline
In-Reply-To: <CAFLszTiEWw0tey4zeqjPYe2TsSWH1P4Xakn8OrOKSwqDU+EM_A@mail.gmail.com>
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


--kAi8ujN4wSrvQZ9W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 12:52:19PM -0600, Simon Glass wrote:
> Hi,
>=20
> On Tue, 11 Jun 2024 at 08:36, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Jun 11, 2024 at 12:17:16PM +0200, Heinrich Schuchardt wrote:
> > > On 07.06.24 20:52, Sughosh Ganu wrote:
> > > > There are events that would be used to notify other interested modu=
les
> > > > of any changes in available and occupied memory. This would happen
> > > > when a module allocates or reserves memory, or frees up memory. The=
se
> > > > changes in memory map should be notified to other interested modules
> > > > so that the allocated memory does not get overwritten. Add an event
> > > > handler in the EFI memory module to update the EFI memory map
> > > > accordingly when such changes happen. As a consequence, any subsequ=
ent
> > > > memory request would honour the updated memory map and only availab=
le
> > > > memory would be allocated from.
> > > >
> > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > ---
> > > >   lib/efi_loader/efi_memory.c | 70 ++++++++++++++++++++++++++++++--=
-----
> > > >   1 file changed, 58 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memor=
y.c
> > > > index 435e580fb3..93244161b0 100644
> > > > --- a/lib/efi_loader/efi_memory.c
> > > > +++ b/lib/efi_loader/efi_memory.c
> > > > @@ -73,6 +73,10 @@ struct efi_pool_allocation {
> > > >   #if CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY)
> > > >   extern bool is_addr_in_ram(uintptr_t addr);
> > > >
> > > > +static efi_status_t __efi_add_memory_map_pg(u64 start, u64 pages,
> > > > +                                       int memory_type,
> > > > +                                       bool overlap_only_ram);
> > > > +
> > > >   static void efi_map_update_notify(u64 addr, u64 size, u8 op)
> > > >   {
> > > >     struct event_efi_mem_map_update efi_map =3D {0};
> > > > @@ -84,6 +88,34 @@ static void efi_map_update_notify(u64 addr, u64 =
size, u8 op)
> > > >     if (is_addr_in_ram((uintptr_t)addr))
> > > >             event_notify(EVT_EFI_MEM_MAP_UPDATE, &efi_map, sizeof(e=
fi_map));
> > > >   }
> > > > +
> > > > +static int lmb_mem_map_update_sync(void *ctx, struct event *event)
> > > > +{
> > > > +   u8 op;
> > > > +   u64 addr;
> > > > +   u64 pages;
> > > > +   efi_status_t status;
> > > > +   struct event_lmb_map_update *lmb_map =3D &event->data.lmb_map;
> > > > +
> > > > +   addr =3D (uintptr_t)map_sysmem(lmb_map->base, 0);
> > > > +   pages =3D efi_size_in_pages(lmb_map->size + (addr & EFI_PAGE_MA=
SK));
> > > > +   op =3D lmb_map->op;
> > > > +   addr &=3D ~EFI_PAGE_MASK;
> > > > +
> > > > +   if (op !=3D MAP_OP_RESERVE && op !=3D MAP_OP_FREE) {
> > > > +           log_debug("Invalid map update op received (%d)\n", op);
> > > > +           return -1;
> > > > +   }
> > > > +
> > > > +   status =3D __efi_add_memory_map_pg(addr, pages,
> > > > +                                    op =3D=3D MAP_OP_FREE ?
> > > > +                                    EFI_CONVENTIONAL_MEMORY :
> > >
> > > This is dangerous. LMB might turn memory that is marked as
> > > EfiReservedMemory which the OS must respect into EfiBootServicesData
> > > which the OS may discard.
> > >
> > > E.g. initr_lmb() is being called after efi_memory_init().
> > >
> > > Getting all cases of synchronization properly tested seems very hard =
to
> > > me. Everything would be much easier if we had only a single memory
> > > management system.
> >
> > Yes, Sughosh is working on the single memory reservation system for
> > everyone to use. This pairs with the single memory allocation system
> > (malloc) that we have. Parts of the code base that aren't keeping these
> > systems up to date / obeying their results need to be corrected.
>=20
> The EFI allocations don't happen until boot time...so why do we need
> to do this now? We can instead have an EFI function to scan LMB and
> add to its memory map.

We're talking about reservations, not allocations. So yes, when someone
is making their reservation, they need to make it. I don't understand
your question.

--=20
Tom

--kAi8ujN4wSrvQZ9W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZouy8ACgkQFHw5/5Y0
tyzgeQwArgqZlaFrzUnGPSpPZyPxpY/KyL0tsqi00mtLtHETiUoAw5ltKZ8BCz5M
G0S3Hle7tW82SbkKsKD4loV3A2YPMYVLKVWdxEK1AN93JBrZbdDg0yegxeaVzeb4
9Lu/8nTpgSsk7GvU2N22Dgc29mDL2Ym2Zm4KOvuaDYqwsK7iUYe5qZAnDWjffWtX
0Ezpp7UU5e9nesRHDPLB2bNj+WXMR15Q6YdemTnvSTl2xsJgUHbilANrgR7/9N/U
RhHhAcf5cb0Z6elRa2YRoPrEE5vsp5pMi8SIWq5Ip1W5EZmBNuC8BOuQp5J0Qv54
rOwWMDcsga97e+lMXqDMuJiTn3guUYcLPP7Ztkl5UE6GYx3waI4XObqO/pKzTLCU
S8B7aw1Yz3/CvK/JHG0V/TdRHYL6m7Y5NFMvWm1xKUc8rzPH7A/eqPidm2GiErxh
UlRdRcWeSrzDFR+mbT/To0xJBSy3yjuasi9iiT7I3sQHRar/ck9tF88Tstk8FO0U
uh87c4m8
=woEU
-----END PGP SIGNATURE-----

--kAi8ujN4wSrvQZ9W--
