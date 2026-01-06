Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9955CEFCE2
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 17:15:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BBD583B9D;
	Tue,  6 Jan 2026 18:15:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RPfT6fMq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8967C83BC4; Tue,  6 Jan 2026 18:15:22 +0100 (CET)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E16C583B86
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 18:15:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-7c75a5cb752so817279a34.2
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 09:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767719718; x=1768324518; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0E6JctbCniyZawrXsrgEphYuPdMtspITLhnLsG02sCE=;
 b=RPfT6fMquNTks/vnrYIzCViLY8VcsKZSg8YEPGk356gfgmNXJNrVaqlVUKIA+j/z4/
 m51YxT9K286G7Mm7K5J7XimfMgB1MT+OubswjMeJ3VvC+PhB0LlzLs3dDJjJopFpbCzI
 gNShoP+8qam0z5mxQG668lTNBjmdLE3echMrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767719718; x=1768324518;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0E6JctbCniyZawrXsrgEphYuPdMtspITLhnLsG02sCE=;
 b=A3a0qSfwrnw0WEM1g2usnbtuxFV1BlJqCUc1keD18vwoduB3wVEzqRpSUCjmE1Oewr
 rtzMCZ8WW+5g1/VcJ5Jl72oH713zpAEJ45XNghUOfSipjZ31D234rp82YTO3k7qQUDCi
 gZD6XSgoljY738lZNZlm3HtsXmznQgPnbFD5O9UzO5XA5IPAomgA+dd3Tj+iG4iO5rcq
 kggxVEI2/5oO4swA9OHX+dATlHTYtyTDuqatd1SbQv+yVfKFvcipuFZbbG25DLfcEW2p
 EimZ5rxtEqa1xqXdrMOC9438QEgnbzkqbBSC919topJ77pcVhxxXFFKuOW4ywVbXDwOq
 w9iQ==
X-Gm-Message-State: AOJu0YxtcnU4TC6WrCNmYa4ksoEVpZHAAzji+lcFCGuChqnt1y96u7IY
 EOdLMw1RSNOU/QF54+tGAFVSLk6ddZPsYoyMecImna9TnN6bczT9kVHDmoer/RSbR0A=
X-Gm-Gg: AY/fxX5eNYgF6lVPkXWgJIGr1De1LUvGP86PWgI4VCvLT63NO7SfvY6MilXPNUFD1Wv
 yczDh0s1/g59NiEPs/y95hBxxvehZuOdqslh14ArnmeS2dPdF/KbCoSm0oliETpEgKLCEl1kJbi
 OZJZ4Sm4FzTTNdnEzQHhOpajP98KBRJUUsuGZQGxZerj+LCh/y5AZsxpj4Ho/hlMddd7flU2REJ
 oyQN7fcwlWEGUk485IqNRFFOEvLR0iJwKVA0rcaEkh97pl1uGD+TSD3V8tdh/UFvi6ExdJ+Gcr/
 Vk0tDSCdpAlx6AeF9C7y9bP+2SuyH2blG7AJWDbuCF8wmeNNEEAqzrKSX2yp2FyqeLvYidKc9XE
 bMDtKhsEhvZQp+lgXSsipaWXk6AqcmctQ2OS5wubhWZ1afD64FZFk0UHMxCz1kjdvr0cxG+il31
 8o0M0iZKIoTSXQ49Cf5GR1yRhY/aiwY6uYIuR6YSHLGa+WW2bCX3gr8ZbooosxPJKsPE8x8TPZP
 GlPrJr0q8RyoGdhyN0kSGTk4+CFWxEPYzH5/cc=
X-Google-Smtp-Source: AGHT+IFgFf0+7V1GnGnrmbIYvqRy6AOJHVJwrnz4oM54SX+/TJ4NuoPZKwizcPlWZrJD11d0tDf2yg==
X-Received: by 2002:a05:6830:268c:b0:748:8b42:77ab with SMTP id
 46e09a7af769-7ce46550da9mr2107071a34.0.1767719718532; 
 Tue, 06 Jan 2026 09:15:18 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce47801d58sm1805356a34.2.2026.01.06.09.15.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 09:15:17 -0800 (PST)
Date: Tue, 6 Jan 2026 11:15:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Dmitrii Merkurev <dimorinny@google.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heiko Schocher <hs@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20260106171515.GH3416603@bill-the-cat>
References: <20260105235813.GB3416603@bill-the-cat> <87tswzf5eb.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vCZgY7POVMdcZLLd"
Content-Disposition: inline
In-Reply-To: <87tswzf5eb.fsf@kernel.org>
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


--vCZgY7POVMdcZLLd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 06, 2026 at 10:37:48AM +0100, Mattijs Korpershoek wrote:
> Hi Tom,
>=20
> On Mon, Jan 05, 2026 at 17:58, Tom Rini <trini@konsulko.com> wrote:
>=20
> > Hey all,
> >
> > Here's the latest report, now that next has been merged to master. A few
> > of these are oddly showing up now, despite being in older code that
> > hasn't been touched and was being built before.
>=20
> For fastboot, some code has been moved from mmc only support to
> fb_block.c, which might explain the new errors.
>=20
> See: https://lore.kernel.org/all/20251121-topic-fastboot-blk-v7-0-9589d90=
2fc91@linaro.org/
>=20
> >
> > ---------- Forwarded message ---------
> > From: <scan-admin@coverity.com>
> > Date: Mon, Jan 5, 2026 at 3:24=E2=80=AFPM
> > Subject: New Defects reported by Coverity Scan for Das U-Boot
> > To: <tom.rini@gmail.com>
> >
> >
> > Hi,
> >
> > Please find the latest report on new defect(s) introduced to *Das U-Boo=
t*
> > found with Coverity Scan.
> >
> >    - *New Defects Found:* 15
> >    - 23 defect(s), reported by Coverity Scan earlier, were marked fixed=
 in
> >    the recent build analyzed by Coverity Scan.
> >    - *Defects Shown:* Showing 15 of 15 defect(s)
> >
> > Defect Details
> >
> > ** CID 640423:       Control flow issues  (DEADCODE)
> > /drivers/fastboot/fb_common.c: 112           in fastboot_set_reboot_fla=
g()
> >
> >
> > _______________________________________________________________________=
______________________
> > *** CID 640423:         Control flow issues  (DEADCODE)
> > /drivers/fastboot/fb_common.c: 112             in fastboot_set_reboot_f=
lag()
> > 106     	}
> > 107     	const char *bcb_iface =3D config_opt_enabled(CONFIG_FASTBOOT_F=
LASH_BLOCK,
> > 108     						   CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
> > 109     						   "mmc");
> > 110
> > 111     	if (device =3D=3D -1)
> >>>>     CID 640423:         Control flow issues  (DEADCODE)
> >>>>     Execution cannot reach this statement: "return -22;".
>=20
> I believe coverity is wrong here.
> we call config_opt_enabled() which by default returns -1 so it's
> possible to have device =3D=3D -1
>=20
> This can happen when both CONFIG_FASTBOOT_FLASH_BLOCK and
> CONFIG_FASTBOOT_FLASH_MMC are unset.
> (for example when we use CONFIG_FASTBOOT_FLASH_SPI)
>=20
> > 112     		return -EINVAL;
> > 113
> > 114     	if (reason >=3D FASTBOOT_REBOOT_REASONS_COUNT)
> > 115     		return -EINVAL;
> > 116
> > 117     	ret =3D bcb_find_partition_and_load(bcb_iface, device, "misc");
> >
>=20
> [...]
>=20
> >
> > ** CID 640421:       Possible Control flow issues  (DEADCODE)
> > /drivers/fastboot/fb_block.c: 138           in fastboot_block_get_part_=
info()
> >
> >
> > _______________________________________________________________________=
______________________
> > *** CID 640421:         Possible Control flow issues  (DEADCODE)
> > /drivers/fastboot/fb_block.c: 138             in fastboot_block_get_par=
t_info()
> > 132     					      CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, -1);
> > 133
> > 134     	if (!part_name || !strcmp(part_name, "")) {
> > 135     		fastboot_fail("partition not given", response);
> > 136     		return -ENOENT;
> > 137     	}
> >>>>     CID 640421:         Possible Control flow issues  (DEADCODE)
> >>>>     Execution cannot reach the expression "strcmp(interface, "")" in=
side this statement: "if (!interface || !strcmp(i...".
> > 138     	if (!interface || !strcmp(interface, "")) {
> > 139     		fastboot_fail("block interface isn't provided", response);
> > 140     		return -EINVAL;
>=20
> I believe coverity is wrong here as well.
> we call config_opt_enabled() which by default returns NULL for interface.
>=20
> And when we enable CONFIG_FASTBOOT_FLASH_BLOCK,
> CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME will be set to "" by default:
>=20
> $ rg 'FASTBOOT_FLASH_BLOCK_INTERFACE_NAME' .config
> 1097:CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME=3D""
>=20
>=20
> > 141     	}
> > 142
> > 143     	*dev_desc =3D blk_get_dev(interface, device);
> >
>=20
> [...]
>=20
> >
> > ** CID 640419:       Null pointer dereferences  (REVERSE_INULL)
> > /drivers/fastboot/fb_block.c: 144           in fastboot_block_get_part_=
info()
> >
> >
> > _______________________________________________________________________=
______________________
> > *** CID 640419:         Null pointer dereferences  (REVERSE_INULL)
> > /drivers/fastboot/fb_block.c: 144             in fastboot_block_get_par=
t_info()
> > 138     	if (!interface || !strcmp(interface, "")) {
> > 139     		fastboot_fail("block interface isn't provided", response);
> > 140     		return -EINVAL;
> > 141     	}
> > 142
> > 143     	*dev_desc =3D blk_get_dev(interface, device);
> >>>>     CID 640419:         Null pointer dereferences  (REVERSE_INULL)
> >>>>     Null-checking "dev_desc" suggests that it may be null, but it ha=
s already been dereferenced on all paths leading to the check.
> > 144     	if (!dev_desc) {
> > 145     		fastboot_fail("no such device", response);
> > 146     		return -ENODEV;
> > 147     	}
>=20
> Fair enough for this one. We can check that dev_desc is not NULL to make
> sure that the caller cannot call fastboot_block_get_part_info() with
> NULL as second argument.
>=20
> I'll submit a patch for this once I've cleared out my review queue.
>=20
> > 148
> > 149     	ret =3D part_get_info_by_name(*dev_desc, part_name, part_info);
> >
> >
>=20
> [...]
>=20
> For the first 2, do you want me to update the coverity database online
> with these explanations?
> It has been a while but I think I can do that myself.

Thanks for looking in to all of these. I've gone ahead and updated
Coverity, but in the future if you'd like to go in and do that while
composing the emails, please feel free.

--=20
Tom

--vCZgY7POVMdcZLLd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaV1DFwAKCRAr4qD1Cr/k
CvfPAQDioAiGtZEQhoi5SrEQ4Pw2UgPlIMI7j0fdnDJEatPPWgEAusGBU88FtS2M
Hp800e0XS+DZhmSYnJqdiCVVLUQ7Lw8=
=nDJv
-----END PGP SIGNATURE-----

--vCZgY7POVMdcZLLd--
