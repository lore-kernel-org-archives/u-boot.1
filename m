Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6643EC4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 13:54:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39660871DF;
	Wed,  8 Nov 2023 14:54:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z0MkSdmG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 452BC871DF; Wed,  8 Nov 2023 14:54:14 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21E97871AF
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 14:54:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-da819902678so5576100276.1
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 05:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699451647; x=1700056447; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZNHApKmcmMPlbgyEZr/McklJSs94ifAEyFlStBEVbaw=;
 b=Z0MkSdmGQN5E4GtQ8try+XQPPtmGhPkMdeGOOCr8Fmv8OAmx2ci+8Z8rli5W+U3BuN
 uVpLBKyhR+X2zZ9T6epJ4qPgi61FiHh12jVfZaApI8OgLfw3bMdDjKkLisUjNYKvGblP
 iwoAu+Gn8w2knf8RfI997ZSSGEN7vRrrBrjFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699451647; x=1700056447;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZNHApKmcmMPlbgyEZr/McklJSs94ifAEyFlStBEVbaw=;
 b=DTX5RnJXEOL7y/cYwuG1aC2rLCaElIey5Xxd6xkg2k0QMf+e9KTPotUdVYnPS7CirE
 GkM23oyLKeECZa9NwwPPTF5ugKB+c3ssZN2QydrAKquKMMbz2u6EfZNzFzFw+ejSEQ9L
 QaJ5KaqMFnFMxBdi46yROy/bf5/zNbqnvHmJoiEaPXAihR06MUn9J8jzZcIiUizUFjDq
 i59cKkjToS8yvTacvXdDlWui6uHdqEyrUv0c2yiGdKIVjGZqZpWsovj4FuXYHzelqpHa
 zFLLOvcMFgHVy+vpp3L4Bp66MG6vGgtaTGbMFTD3x59AQ1PdcJVGxFFHxZlvbpdMeY29
 7NOA==
X-Gm-Message-State: AOJu0Yz2sM0Dagme8xv337ZeshPjL2ZrUkjKQhflEl8MbTuKL44HqMy1
 0KPs9zlZ0xfZn9cLuGdJqwWf+w==
X-Google-Smtp-Source: AGHT+IFyppYULx8O5XL82qGm62o+Dxu7gHnXhyPXjLumjNqVA4EF3kb9OS0ZkLOySQ/Z1x8Bib4xFg==
X-Received: by 2002:a25:23cd:0:b0:da0:c938:c79f with SMTP id
 j196-20020a2523cd000000b00da0c938c79fmr1722151ybj.38.1699451646833; 
 Wed, 08 Nov 2023 05:54:06 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5409-8f3c-5603-0314.res6.spectrum.com.
 [2603:6081:7b00:6400:5409:8f3c:5603:314])
 by smtp.gmail.com with ESMTPSA id
 o14-20020a25ea4e000000b00d0b0bbe574asm6403935ybe.44.2023.11.08.05.54.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 05:54:06 -0800 (PST)
Date: Wed, 8 Nov 2023 08:54:04 -0500
From: Tom Rini <trini@konsulko.com>
To: Johan Jonker <jbx6244@gmail.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Alexander Gendin <agendin@matrox.com>
Subject: Re: [tom.rini@gmail.com: Fwd: New Defects reported by Coverity Scan
 for Das U-Boot]
Message-ID: <20231108135404.GJ6601@bill-the-cat>
References: <20231106202752.GH496310@bill-the-cat>
 <c1d533e1-1d54-0fc6-1ed3-6adf8c6497e7@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="k0zxR3uPjqoUu91z"
Content-Disposition: inline
In-Reply-To: <c1d533e1-1d54-0fc6-1ed3-6adf8c6497e7@gmail.com>
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


--k0zxR3uPjqoUu91z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2023 at 12:18:05AM +0100, Johan Jonker wrote:
> Hi Tom, Simon,
>=20
> Please have a look some comments below at 3 issues that are introduced by=
 meself. ;)

Thanks for looking.

>=20
> On 11/6/23 21:27, Tom Rini wrote:
> > Hey all,
> >=20
> > Here's the latest report. I _think_ I passed the right options to
> > get_maintainer.pl such that it would only look far enough back in git to
> > find the likely authors (along with listed maintainers of the files).
> >=20
> > ---------- Forwarded message ---------
> > From: <scan-admin@coverity.com>
> > Date: Mon, Nov 6, 2023 at 2:58=E2=80=AFPM
> > Subject: New Defects reported by Coverity Scan for Das U-Boot
> > To: <tom.rini@gmail.com>
> >=20
> >=20
> > Hi,
> >=20
> > Please find the latest report on new defect(s) introduced to Das
> > U-Boot found with Coverity Scan.
> >=20
> > 13 new defect(s) introduced to Das U-Boot found with Coverity Scan.
> > 5 defect(s), reported by Coverity Scan earlier, were marked fixed in
> > the recent build analyzed by Coverity Scan.
> >=20
> > New defect(s) Reported-by: Coverity Scan
> > Showing 13 of 13 defect(s)
> >=20
> >=20
> > ** CID 467411:  Memory - corruptions  (OVERRUN)
> >=20
> >=20
> > _______________________________________________________________________=
_________________________________
>=20
> [..]
>=20
> > *** CID 467407:  Uninitialized variables  (UNINIT)
> > /drivers/scsi/scsi.c: 612 in do_scsi_scan_one()
> > 606
> > 607             bdesc =3D dev_get_uclass_plat(bdev);
> > 608             bdesc->target =3D id;
> > 609             bdesc->lun =3D lun;
> > 610             bdesc->removable =3D bd.removable;
> > 611             bdesc->type =3D bd.type;
> >>>>     CID 467407:  Uninitialized variables  (UNINIT)
> >>>>     Using uninitialized value "bd.bb".
> > 612             bdesc->bb =3D bd.bb;
> > 613             memcpy(&bdesc->vendor, &bd.vendor, sizeof(bd.vendor));
> > 614             memcpy(&bdesc->product, &bd.product, sizeof(bd.product)=
);
> > 615             memcpy(&bdesc->revision, &bd.revision,  sizeof(bd.revis=
ion));
> > 616             if (IS_ENABLED(CONFIG_SYS_BIG_ENDIAN)) {
> > 617                     ata_swap_buf_le16((u16 *)&bdesc->vendor,
> > sizeof(bd.vendor) / 2);
> >=20
> > ** CID 467406:  Memory - corruptions  (OVERRUN)
> >=20
> >=20
>=20
> Scsi devices are not my thing.
> I'm forced to poke in drivers, because someone else is plumbing bounce bu=
ffer code to our block class.

OK. So I think Marek might be better able to comment on why yes, we need
bounce buffers more often than we used to, for sanity sake. But...

> Introduced by:
> [PATCH v5 4/8] rockchip: block: blk-uclass: add bounce buffer flag to blk=
_desc
> https://lore.kernel.org/u-boot/ee332375-8812-8e12-da1c-9973d10a41af@gmail=
=2Ecom/
>=20
> static void scsi_init_dev_desc_priv(struct blk_desc *dev_desc)
> {
> [..]
>=20
> #if IS_ENABLED(CONFIG_BOUNCE_BUFFER)
> 	dev_desc->bb =3D true;
> #endif	/* CONFIG_BOUNCE_BUFFER */
> }
>=20
> [..]
> 	struct blk_desc bd;
>=20
> 	scsi_init_dev_desc_priv(&bd);
>=20
> 	bdesc->bb =3D bd.bb;
> =3D=3D=3D
> https://www.kernel.org/doc/html/latest/dev-tools/checkpatch.html
>=20
> GLOBAL_INITIALISERS
>=20
>     Global variables should not be initialized explicitly to 0 (or NULL, =
false, etc.). Your compiler (or rather your loader, which is responsible fo=
r zeroing out the relevant sections) automatically does it for you.
> INITIALISED_STATIC
>=20
>     Static variables should not be initialized explicitly to zero. Your c=
ompiler (or rather your loader) automatically does it for you.
>=20
> =3D=3D=3D
> I assumed that variables are always zeroed in the blk_desc structure.
> The value of bb only matters if IS_ENABLED(CONFIG_BOUNCE_BUFFER).
>=20
> For scsi:
> 	dev_desc->bb =3D IS_ENABLED(CONFIG_BOUNCE_BUFFER) ? true : false;
>=20
> The scsi block class worked fine for years without bounce buffer. Do all =
scsi devices need that buffer all of a sudden? What didn't work then?
>=20
> Please advise what is the best approach.

Popping back to do_scsi_scan_one(), 'bd' isn't a global variable, it's a
function variable. And before bounce buffers, scsi_init_dev_desc_priv()
which is called a bit earlier in the function that Coverity is talking
about here would initialize every member, as you note in your analysis.
But it doesn't set bb in the case of CONFIG_BOUNCE_BUFFER=3Dn. A simple
fix to this would be for that function to memset everything to 0 an then
change any values it needs to set. I've done that locally and will post
and CC you for sanity testing all the same.

> =3D=3D=3D
> There is a patch in review that changes this file. Better let that go in =
first before changing something here. What's the status?
>=20
> [PATCH] scsi: Forceably finish migration to DM_SCSI
> https://lore.kernel.org/u-boot/20231028005951.1187616-1-trini@konsulko.co=
m/

I've merged that to next this morning, but it doesn't change this part
of the code (it was removing legacy code).

> > _______________________________________________________________________=
_________________________________
>=20
> [..]
>=20
> > _______________________________________________________________________=
_________________________________
> > *** CID 467402:    (CHECKED_RETURN)
> > /drivers/block/rkmtd.c: 737 in rkmtd_init_plat()
> > 731
> > 732             debug("starting_lba           : %llu\n",
> > le64_to_cpu(plat->gpt_e->starting_lba));
> > 733             debug("ending_lba             : %llu\n",
> > le64_to_cpu(plat->gpt_e->ending_lba));
> > 734
> > 735             memcpy(plat->gpt_e->partition_type_guid.b,
> > &partition_basic_data_guid, 16);
> > 736
>=20
>=20
> >>>>     CID 467402:    (CHECKED_RETURN)
> >>>>     Calling "uuid_str_to_bin" without checking return value (as is d=
one elsewhere 9 out of 11 times).
> > 737             uuid_str_to_bin(plat->uuid_part_str,
> > plat->gpt_e->unique_partition_guid.b,
> > 738                             UUID_STR_FORMAT_GUID);
>=20
> Comment 2:
>=20
> 	gen_rand_uuid_str(plat->uuid_disk_str, UUID_STR_FORMAT_GUID);
> 	uuid_str_to_bin(plat->uuid_part_str, plat->gpt_e->unique_partition_guid.=
b,
> 			UUID_STR_FORMAT_GUID);
>=20
>=20
> The function uuid_str_to_bin() gets a string from gen_rand_uuid_str() whi=
ch is guarantied correct.
> Checking the output is unnecessary.=20
> =20
> 	if (!uuid_str_valid(uuid_str)) {
> 		return -EINVAL;
> 	}
>=20
> This is more a false positive. What should we do with it?

In Coverity scan terms "I know what I did here and it's right" is I
think "Intentional" and not "False Positive" (where that's supposed to
mean the tool is wrong and should have known better). Thanks for
explaining, I'll go mark it as such in the dashboard for both cases.

--=20
Tom

--k0zxR3uPjqoUu91z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVLkvYACgkQFHw5/5Y0
tywVigwAoOBgJ3q6uaGIsZMVOUX30dlDgscE8eRU+QgfpSIQThTpw4YaIq56ResT
wVCIwLUlJh13sH0BzeDUimsAKcuQM8s/txP6wzOkxDzHN4kSLLDoygiLoPKt2Jbh
DWU69tahgswpQajJ9+IktkCTFv1ayZh0kn1SDo0ynAx+pwbG9XkSbS4Mm+O6rW0G
nGO0DGfkBDdQhT/DvtQ+HXJwolC6YW7XTFcVXPrBwmkoB15kwAvDLJZg7NWMR+A5
8uNvAW0zZrKU2BNrJw+hW/Mi21qfM1YtneIjKZN5p6kgHam1aiH5OAnsoyIkh4hX
w/uR0GL2Jv/uCbrnIYAYMyObAxr876o2bn3IG84QnU0QkR3XKktgQNqMFmkLIvwR
1oKZu1IoFn0QmBDqw+RJ8QirvDqCL9VNC4eFMbqdhAikAmwm3NXrIrjWwGN2nm2J
HN34LRT4fbMkvmBaVnoX7/MsBj5tN/5MdkBaQfgZiCe1drsgDZqKOLMch843AXh3
zBTzIC7U
=GvL6
-----END PGP SIGNATURE-----

--k0zxR3uPjqoUu91z--
