Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75223C197A0
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 15:47:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 800FE86EC9;
	Fri, 17 Nov 2023 16:47:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Fvzh/MtM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 392B586F68; Fri, 17 Nov 2023 16:47:30 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E852486EB8
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 16:47:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5c6705515d8so11038107b3.2
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 07:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700236043; x=1700840843; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4Qd8cCsWLSo1+yA+Oe7nx2Vu7qqF2KSdBsO0SOFEbFQ=;
 b=Fvzh/MtM16fRdN2UjvxhXfqu8QC2YRIrD3dYPwcRndtgMQjrPhOlI5yzYOh01wsQL0
 Aw6oC/iElF/CvwA+IjiWhoAvoCVSUHFsgK03etONHFboeYBLx9SBWuXL3ZUF943mqXbX
 DyQ4BN52GhKpRzOAwi24xsufp85E6gAzwTmWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700236043; x=1700840843;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Qd8cCsWLSo1+yA+Oe7nx2Vu7qqF2KSdBsO0SOFEbFQ=;
 b=vD3s+ggucGAmAoWlgQvUVVKhbKYd8iAeIP1mXqTanwofhVdud+xoWfAfnJJbydvGgd
 qPdjhBhyS0G294Ftt+sqEwmEHmKEoSjtr+Gpu8MnxuMKLtrL8yCxGxbOey+N4/uaBv3x
 jj3wENP5y1LCHxPy4O3X85i1v/sW4IJP3cMnaVgIPfD29GJ4uxT8mdwtv0EU7MnRfgKL
 FR4kZdjeWnHWl8eO8HBUMY/rkCohE2qkDlPbiC9taGY1IoEV25b4zWUsQh/XHpCvkbgn
 Gcead+bTA7/BQ581A1YCj7ZffezawzLFp1LTcM4ChBLaJ8QItk+cPYGjMtRRL5h/Hv5C
 yx2A==
X-Gm-Message-State: AOJu0YxLOTT9DCOpp3RPwrt02jWYfH2sW7pbZhLBtM1wK40vunEueBTi
 0auYgs9IO07FnCWlbSG7fEaTp1C/EsYmRyFxYqWm4A==
X-Google-Smtp-Source: AGHT+IH8NO5zwGKBiSwolceSSpqvOFTIxwJRX2rQU90i66H+ktXuz7gdXokWyzjLkzr+sLXYE5DVJA==
X-Received: by 2002:a81:6d16:0:b0:5a7:bff3:6fe4 with SMTP id
 i22-20020a816d16000000b005a7bff36fe4mr20087737ywc.9.1700236043614; 
 Fri, 17 Nov 2023 07:47:23 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 t139-20020a0dea91000000b005a7ab32d454sm551671ywe.10.2023.11.17.07.47.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 07:47:23 -0800 (PST)
Date: Fri, 17 Nov 2023 10:47:21 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/4] fwu-mdata: Make FWU_MDATA_GPT_BLK depend on DFU
Message-ID: <20231117154721.GM170968@bill-the-cat>
References: <20230817174125.369849-1-trini@konsulko.com>
 <20230817174125.369849-2-trini@konsulko.com>
 <c91e201c-e902-4853-b224-d5ba4813cd2e@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oI4jfAYanU8r7mDw"
Content-Disposition: inline
In-Reply-To: <c91e201c-e902-4853-b224-d5ba4813cd2e@gmx.de>
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


--oI4jfAYanU8r7mDw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 04:35:22PM +0100, Heinrich Schuchardt wrote:
> On 8/17/23 19:41, Tom Rini wrote:
> > The implementation of this option in lib/fwu_updates/fwu_gpt.c is wholly
> > dependent on DFU, so make that a requirement here.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > I'm honestly not sure how to best proceed here as
> > drivers/fwu-mdata/gpt_blk.c doesn't need DFU, but both files are
> > controlled by this single symbol.
> >=20
> > Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>
> > Cc: Jassi Brar <jaswinder.singh@linaro.org>
> > Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > ---
> >   drivers/fwu-mdata/Kconfig | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/fwu-mdata/Kconfig b/drivers/fwu-mdata/Kconfig
> > index 42736a5e43b0..0bd5fef4abfa 100644
> > --- a/drivers/fwu-mdata/Kconfig
> > +++ b/drivers/fwu-mdata/Kconfig
> > @@ -15,7 +15,7 @@ config FWU_MDATA_GPT_BLK
> >   	bool "FWU Metadata access for GPT partitioned Block devices"
> >   	select PARTITION_TYPE_GUID
> >   	select PARTITION_UUIDS
> > -	depends on FWU_MDATA && BLK && EFI_PARTITION
> > +	depends on FWU_MDATA && BLK && EFI_PARTITION && DFU
>=20
> Hello Tom,
>=20
> This looks like the wrong level of configuration to add a DFU dependency.
>=20
> EFI_CAPSULE_FIRMWARE_FIT and EFI_CAPSULE_FIRMWARE_RAW select DFU and
> EFI_CAPSULE_FIRMWARE.
>=20
> We probably should let CONFIG_FWU_MDATA depend on EFI_CAPSULE_ON_DISK.

OK, but that doesn't address the dependency? The code in
lib/fwu_updates/fwu_gpt.c needs DFU and is under FWU_MDATA_GPT_BLK. It
provides fwu_plat_get_alt_num() which is called by fwu_get_image_index()
and is under FWU_MULTI_BANK_UPDATE and in turn called by
efi_firmware_raw_set_image() which is under EFI_CAPSULE_FIRMWARE_RAW. If
both lib/fwu_updates/fwu_gpt.c and drivers/fwu-mdata/gpt_blk.c should be
under the same symbol then it needs to depend on DFU, since it's a
direct dependency in the code. We could change it up to
EFI_CAPSULE_FIRMWARE_RAW I guess, but I'm not sure that's cleaner.

--=20
Tom

--oI4jfAYanU8r7mDw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVXiwMACgkQFHw5/5Y0
tyyeXwv9FAiMDncj9CsqaC3oGcjR6by98EpprS4eAGnGaywteXb20DqxTm7FbUYP
m9Weei7DE5vF7463CGpHGD7osF2mhV+9f7uDi1AddvAFYE1gFetdK4450TUPeKso
lRBdDxihW4+KAGY1fEqk57N4M5nzmlaYZ2F+Oh3XH7V7rYEMJ575FoTTYXNQt3su
n41n7mvIpV6en/n1VdAxbGgLCKhmvx1w+3NfbtJrXUQmiGcEz0tk1xXC91X3nhb1
A/lp3WYneMOJZMB3RB7zgFRa9T6fay0dU1/6uBarnt6qwNEmRKKbnFh9dcZ5XtX6
I2zp3ScFU3nTu55n1DIXuBmzf4bTU1cQkoJGOWYwV+flsScYar1ugKRpGnO8WFwn
caV6zXye0DxNHpyA+flV7zudgss5cG8+dqHIZ+xEXTKmJ5i4BZiC+HOM3VDCPDPZ
O+45kFzB0RtIgANNkNcZOWQDJKa6VUw5BfIuZqV4AhiPo0dKmxYtkq+cgYk5AUi0
6wjkeZ6G
=+SSe
-----END PGP SIGNATURE-----

--oI4jfAYanU8r7mDw--
