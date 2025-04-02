Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42C0C28B20
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 14:01:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09CE980FDA;
	Wed,  2 Apr 2025 16:01:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lSG43R/S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29A7A81703; Wed,  2 Apr 2025 16:01:06 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E883980584
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 16:01:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-603f54a6cb5so676576eaf.0
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 07:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743602461; x=1744207261; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gd5aex1bo4b5cFmqQH2yULbr36zCn3sJoMIRtkpPeKc=;
 b=lSG43R/SVgAFqXUFnhUvuAEyzIaxSqZggiqb49wRVbjwaqr7GQ352mG24tavuNW5Le
 IWrIBx+tYskny6qtfkALaSxWj0VbI5pB2lQobE3O5eiCocDYLzMluLI4Jx9PE/KPESPs
 QiQ6dvYFynSeRjSvR1wd9Xg2YkE9Kxhr8AOQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743602461; x=1744207261;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gd5aex1bo4b5cFmqQH2yULbr36zCn3sJoMIRtkpPeKc=;
 b=XO9lPnhBwEzjPMFWK/GXA7p+jYiTSu4RfYjou+YR6SaO56M7Zs6P7tMp72CyCqI3x+
 ppQxKHB7rzI/2W1PtRBc2BWkHr9QUwGnMm/b+/WwyM0r5nF0WEjNEBb+cIDyL1rnFh8T
 WE5Pff86srMno6/ka5f6/crTWRsvvf4i3gMoMxc1RQOsdDt85deWdDW20J779dMPIKMx
 klk/0B1gDMi+cOV906EUlu+tJdiAH5HNjtDgXE8uaCAf/eUlWmyKe9WLZW6fyzpa9wgG
 g6ZnzkM/fTgX/PLXPu1jyq2S5HqyfmfOvJlUORZIRikJbwcKSqyXKVX56hJdd0T85tIO
 OdzA==
X-Gm-Message-State: AOJu0Yy1dFFrWhSxvC5M9F0rxS9xQA4OIX6PUQv/hqj4zizXGClF68kJ
 BCzG9QhpSI0O3cfUGMvk+GEXNwe70/V/4Erc/MJwtjrKplbTRcwh8uxIHv2V5qY=
X-Gm-Gg: ASbGncsOOl7I6P5A53e87la6UBTzu9+D7B3gSKwBEpezDeBOLeotij1psaMS0erjEbs
 l+2vLc9kwNULl4AiVqh0CkLUZEqsoVmGVYRR2WYbMHhk7Sg//FOzSf6WMfk5ECdnvxwgzMGakw9
 wvlD1p6PvWSoEmjs5IW5Fy8p+S9TBaeLFNz75dkrHusRCEWKScBe9sNIqpAR0zg4Ew0pfB5eD1I
 6h0KlfFLodsQgaIN7fVLskhBhrQ6BLWddjSo46EUaZ0Bw1o9pjS8jlxEcKaTK98xQ/rgGssRhYT
 /0ny158xAuBF5KrzmV8TFp3YgFfMqWv5YrUsqPsj38C9HUKrcggsce3178Ht6svHMcrGrftWjxA
 SYkH+6agFkbA73mjH
X-Google-Smtp-Source: AGHT+IFDSkSGd3MYEVoyY7MRZjIqy+C+WSPqbxE6YOfQGlZNNMpr6ekAGNVzDh2iFHByz0hvgc4L/Q==
X-Received: by 2002:a05:6870:7182:b0:29e:290f:7af4 with SMTP id
 586e51a60fabf-2cc382d2af9mr4197846fac.34.1743602460845; 
 Wed, 02 Apr 2025 07:01:00 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2c86a855cdcsm2863555fac.33.2025.04.02.07.00.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 07:00:59 -0700 (PDT)
Date: Wed, 2 Apr 2025 08:00:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com
Subject: Re: [PATCH v5] spl: remove usage of CMD_BOOT[IZ] from image parsing
Message-ID: <20250402140057.GQ5495@bill-the-cat>
References: <20250314035505.4029331-1-anshuld@ti.com>
 <20250331230301.GA30101@bill-the-cat>
 <D8W300ZGJI6M.1COATVFQ1OTPT@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4n4OYk7nhbyCd1f5"
Content-Disposition: inline
In-Reply-To: <D8W300ZGJI6M.1COATVFQ1OTPT@ti.com>
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


--4n4OYk7nhbyCd1f5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 02, 2025 at 04:00:01PM +0530, Anshul Dalal wrote:
> On Tue Apr 1, 2025 at 4:33 AM IST, Tom Rini wrote:
> > On Fri, Mar 14, 2025 at 09:25:04AM +0530, Anshul Dalal wrote:
> >
> >> Using CMD_* configs from spl doesn't make logical sense. Therefore this
> >> patch replaces the checks for CMD_BOOT[IZ] with newly added configs
> >> SPL_HAS_BOOT[IZ].
> >>=20
> >> SPL_HAS_BOOTZ is enabled by default for 32-bit ARM systems and
> >> SPL_HAS_BOOTI is enabled by default for 64-bit ARM and RISCV. This
> >> ensures configs relying on CMD_BOOT[IZ] in falcon boot still work.
> >>=20
> >> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> >
> > OK, so this needs to be introducing some library symbol which then both
> > CMD_BOOTx and SPL_...something select.
>=20
> I was thinking of chaning the Makefile with the following diff:
>=20
> -obj-$(CONFIG_CMD_BOOTI) +=3D bootm.o image.o
> +obj-$(CONFIG_LIB_BOOTI) +=3D image.o
>  obj-$(CONFIG_CMD_BOOTM) +=3D bootm.o
> -obj-$(CONFIG_CMD_BOOTZ) +=3D bootm.o zimage.o
> +obj-$(CONFIG_LIB_BOOTZ) +=3D zimage.o
>  else
>  obj-$(CONFIG_$(PHASE_)FRAMEWORK) +=3D spl.o
> -obj-$(CONFIG_SPL_HAS_BOOTI) +=3D image.o
> -obj-$(CONFIG_SPL_HAS_BOOTZ) +=3D zimage.o
>  obj-$(CONFIG_OF_LIBFDT) +=3D bootm-fdt.o
>  endif
>=20
> This would simplify the Makefile by not having duplicated configs for
> image/zimage and the removed bootm.o for non-spl builds should be fine
> since except for colibri_vf, all defconfigs with CMD_BOOTx already have
> CMD_BOOTM enabled. And for colibri_vf, we can safely enable CMD_BOOTM?
>=20
>=20
> > What we have here introduces
> > failure to build on some imx8 platforms such as=20
> > mx8mp_evk and then size growth on others such as imx28_xea.
>=20
> The imx8mp_evk build should not fail since the patch should only effect
> falcon mode. Only difference this patch makes is now image.o would not
> be compiled for the spl which is not used in non falcon boot anyways.
>=20
> For the imx28_xea and 3 other (imx6qdl_icore_mipi|mmc|rqs) defconfigs
> that use falcon mode but don't make use of CMD_BOOTx. Their size growth
> is expected since SPL_HAS_BOOTx is default y in falcon boot. To keep the
> same size, the SPL_HAS_BOOTx can be explicitly disabled for those 4
> configs.
>=20
> For future reference is there any CI tests I can run to detect any
> regressions before posting patches upstream?

To run CI please see
https://docs.u-boot.org/en/latest/develop/ci_testing.html

And yes, please re-work the symbols and logic so there's no size growth
until the K3 R5 platforms enable things, as the default should not
change behavior. Using
https://source.denx.de/u-boot/u-boot-extras/-/blob/master/contrib/trini/u-b=
oot-size-test.sh?ref_type=3Dheads
might make it easier to compare various platforms before/after.

>=20
> Regards,
> Anshul

--=20
Tom

--4n4OYk7nhbyCd1f5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmftQw0ACgkQFHw5/5Y0
tywRKgv/We0TQgM8O8gdr8qAi9xnbBPimjWZl0WYR6TloUqJER7qMg22g2mt3RrW
c1uRMnaa72AUfJhMeiH2lleJObqOAUbx0b9G7ERy24msVbg2qVeEwbe2O/i6yFcm
3BTEw8ZU5mK3cnaFRC0xlzmPvECFuP1x1utJV2057OqFu2BaZHVyV8wEtZ6T1zE6
ZGJZqa0rGhsYpVEpfEy+U38MTLw+5BwbQ4vQPEUUjwAZsLmgJNdWi6/WtTJaMB2e
Waf8+m8D3zG9UcsMEcX8q3PN5CyCB5C6b//PkQtPynJ/bfzH3GaPNoNo5iIZoFZA
Hlp0U/ctBsMeIxkRzS1IzoIq1qvrAtYVKVCY1saIYafaZVk8Tt2qFXiLTu9jJPJ3
JuBKoZBGn7B/yH0ueS35J2kl30i+Qls7+GxZ9CZ65Y7vZktFTo0QVASyIldx1b6n
W3swK8pJ8kf/QonBuWLFMOwpWFLxp4tQ1A6oXs6uL09x0mchFMrdTHTlzmmz3+NJ
vqLnsOjM
=wFmp
-----END PGP SIGNATURE-----

--4n4OYk7nhbyCd1f5--
