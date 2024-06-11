Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 967FDC27C77
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 14:36:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2DBF885F2;
	Tue, 11 Jun 2024 16:36:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LYVH+YLN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9EA187E0D; Tue, 11 Jun 2024 16:36:42 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C21B885E3
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 16:36:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6f9b213ebf9so910653a34.1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 07:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718116599; x=1718721399; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SrpwJKFE0ln+t66SIrRr44L1gPmHbGpZrtGrWTFrpOo=;
 b=LYVH+YLN2QY70HkeJ4Aq4IGQ/CfpuOUzsKDhIr9PejVoydV2nVuRSiVHhA8lkDsd1u
 620w40dwi9GoddsbDvXjIKW/8diRnMouclyMw58Mvazg48ibW+dySpWmDZyIymAVOhIJ
 UnpFhUpdpP8FI3OUwUAW9yxBOOlfhHHeXCZRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718116599; x=1718721399;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SrpwJKFE0ln+t66SIrRr44L1gPmHbGpZrtGrWTFrpOo=;
 b=YDpmyr9SJbZSdX9VqL/6ummTpy30P1MRLNNRz+ELqVwtLY5cixoePzcNQmFB9SeSOu
 rD1LEs/GpXehyo92+8Ms97r3UNkcEO5qzKphrRw2vh0mRB26xOvzsMviUTN6WQBNkKeW
 eE+tDNOVLoXPGvyAQTi3l2yiZn7zCeXf1fnTnbEuLDLTFvzDZcJGdJHw6sOrvlOIuRaQ
 v/wXZPD+0If12yjIDzV1eC0UURbuM/gSYWtynRcSxqeIvegw/fONzEFHcnlusF27HPnQ
 Y2lV0iVEUUORA5+m+jVux5OYpVbmowG5q7luMWyjKGnzi9DQ9C4A0VkXugzGqxeVnvMY
 O5ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxtzmaY3uF8cPM9PE14IbpTb01BE3/keKlSSazsVREtdT4pYvWxnhQMR8d7wINLGQi7govKX7AjxMBJyM9tBfqB23gXw==
X-Gm-Message-State: AOJu0YyxDWJvyib3rB5tuNa612H0nBy4NgaQuLMBPgR5CbZUWRQSNxDf
 PPxgejEnKv0JoAiknY2PuoRrEBSlVg3OS0nbBr+jzraJHkLztyDOz1zUtGl9Z3E=
X-Google-Smtp-Source: AGHT+IFwse7BYB0Y6lv5hg8wf5CSbNQeEq+r8TaqRn4q7Lg2/NdAJEf+V9PlfqBKtTEBcJUgnMjFHA==
X-Received: by 2002:a9d:600e:0:b0:6f9:3cca:a25a with SMTP id
 46e09a7af769-6f9e97f3d8amr1127723a34.13.1718116598960; 
 Tue, 11 Jun 2024 07:36:38 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5bad1093abbsm1357470eaf.44.2024.06.11.07.36.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 07:36:38 -0700 (PDT)
Date: Tue, 11 Jun 2024 08:36:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, u-boot@lists.denx.de
Subject: Re: [RFC PATCH 15/31] efi_memory: add an event handler to update
 memory map
Message-ID: <20240611143635.GF68077@bill-the-cat>
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-16-sughosh.ganu@linaro.org>
 <50d0efab-0df6-47ef-a4e9-b0e3d6ec2556@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZTPGTo/QZorkv5KJ"
Content-Disposition: inline
In-Reply-To: <50d0efab-0df6-47ef-a4e9-b0e3d6ec2556@gmx.de>
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


--ZTPGTo/QZorkv5KJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 12:17:16PM +0200, Heinrich Schuchardt wrote:
> On 07.06.24 20:52, Sughosh Ganu wrote:
> > There are events that would be used to notify other interested modules
> > of any changes in available and occupied memory. This would happen
> > when a module allocates or reserves memory, or frees up memory. These
> > changes in memory map should be notified to other interested modules
> > so that the allocated memory does not get overwritten. Add an event
> > handler in the EFI memory module to update the EFI memory map
> > accordingly when such changes happen. As a consequence, any subsequent
> > memory request would honour the updated memory map and only available
> > memory would be allocated from.
> >=20
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> >   lib/efi_loader/efi_memory.c | 70 ++++++++++++++++++++++++++++++-------
> >   1 file changed, 58 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > index 435e580fb3..93244161b0 100644
> > --- a/lib/efi_loader/efi_memory.c
> > +++ b/lib/efi_loader/efi_memory.c
> > @@ -73,6 +73,10 @@ struct efi_pool_allocation {
> >   #if CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY)
> >   extern bool is_addr_in_ram(uintptr_t addr);
> >=20
> > +static efi_status_t __efi_add_memory_map_pg(u64 start, u64 pages,
> > +					    int memory_type,
> > +					    bool overlap_only_ram);
> > +
> >   static void efi_map_update_notify(u64 addr, u64 size, u8 op)
> >   {
> >   	struct event_efi_mem_map_update efi_map =3D {0};
> > @@ -84,6 +88,34 @@ static void efi_map_update_notify(u64 addr, u64 size=
, u8 op)
> >   	if (is_addr_in_ram((uintptr_t)addr))
> >   		event_notify(EVT_EFI_MEM_MAP_UPDATE, &efi_map, sizeof(efi_map));
> >   }
> > +
> > +static int lmb_mem_map_update_sync(void *ctx, struct event *event)
> > +{
> > +	u8 op;
> > +	u64 addr;
> > +	u64 pages;
> > +	efi_status_t status;
> > +	struct event_lmb_map_update *lmb_map =3D &event->data.lmb_map;
> > +
> > +	addr =3D (uintptr_t)map_sysmem(lmb_map->base, 0);
> > +	pages =3D efi_size_in_pages(lmb_map->size + (addr & EFI_PAGE_MASK));
> > +	op =3D lmb_map->op;
> > +	addr &=3D ~EFI_PAGE_MASK;
> > +
> > +	if (op !=3D MAP_OP_RESERVE && op !=3D MAP_OP_FREE) {
> > +		log_debug("Invalid map update op received (%d)\n", op);
> > +		return -1;
> > +	}
> > +
> > +	status =3D __efi_add_memory_map_pg(addr, pages,
> > +					 op =3D=3D MAP_OP_FREE ?
> > +					 EFI_CONVENTIONAL_MEMORY :
>=20
> This is dangerous. LMB might turn memory that is marked as
> EfiReservedMemory which the OS must respect into EfiBootServicesData
> which the OS may discard.
>=20
> E.g. initr_lmb() is being called after efi_memory_init().
>=20
> Getting all cases of synchronization properly tested seems very hard to
> me. Everything would be much easier if we had only a single memory
> management system.

Yes, Sughosh is working on the single memory reservation system for
everyone to use. This pairs with the single memory allocation system
(malloc) that we have. Parts of the code base that aren't keeping these
systems up to date / obeying their results need to be corrected.

--=20
Tom

--ZTPGTo/QZorkv5KJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZoYOwACgkQFHw5/5Y0
tywTmgwApIpNVOGpVRsJjO0d6D5YubdbGHC6POWTClYWxrVEGB72ZesaD1Hy8Xcq
Srls9awlMYZPgPcmJpEDND2gnaYtzsiXc/PgaI6GcM81aBbgOAwi4nz9B3M1E0xA
magVSY24XnTZnfJdjy2iNEffASXJg8Nn5w4lsp0B3fpeE3gTBvExGJqRNf3WoSln
BwPtySFBs2DzZZoAhBUos6OpMzasEh9WKAHnz6aZrUqnT1rz+CQ5AJP9tcHPDZCH
hcNoUI6ZZAsCLodiggdelMencjzWkTsH/G96BWfg45pUkxYzTxPpgQZH5NY1FhMJ
qMUyvQfMQ7bR49cFSNuXqT+9A2LIELS1k5hF3R0soVNVBykJ5GY1bcO9WaXJl5Gx
qb8fOUxB/1xnMTehyo4PM8eXSThA2q6+bTmXUgN/XVFJz51CSsTivXi063lfHMeu
dwdJNdFc9xpwaFj62cVbmdhUHPPEl6uPr6Q/YwGL3k7SW0U8B8V9oCc4gySAXXFH
+mrY3Bdt
=GkaT
-----END PGP SIGNATURE-----

--ZTPGTo/QZorkv5KJ--
