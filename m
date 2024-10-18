Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F892D374BF
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 16:39:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAFC3885C5;
	Fri, 18 Oct 2024 18:39:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EnzwO0jU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0159F88B16; Fri, 18 Oct 2024 18:39:24 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91B9F8657F
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 18:39:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6cbceb321b3so15946976d6.3
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 09:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729269560; x=1729874360; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UggB8AJ5E3HemnHlfoRIc54A6XCek4iuQwZbcVrha/0=;
 b=EnzwO0jUMNb2FezaFQT/OKnu8NprrfHbCe6oL/gEaGxpicCs0w+PBA/utzeABHnNFY
 UX3Nu0WVU663sTRWsZnmVgnBbqctO9el708iEz9poUjYMx4tSSz4TPe/CSFl8AnUueGc
 ti6tVBHGZvd+fRNWXGyLsQXAspt3dk++6m//E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729269560; x=1729874360;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UggB8AJ5E3HemnHlfoRIc54A6XCek4iuQwZbcVrha/0=;
 b=UhYpw0ts675qf4jf3mi9QPj6N4P7YAh+toF8n4uvOXe6XKeXFNHiyiLU8Ao2O9aBr/
 77rX/prcabnrS/aVur5NdGw+YCcAa5d+As4KPNHKO8cRnItpAVZDozZe6WLnc7Ps+Y9u
 wBZKoGhWEnWLp1vzjQmu5V9GQ+ddnkGE+uTPle72b127DpBMZl5dNoYx6yJHB6H+v4Qs
 JOACpcenntDP6BVMtT0EeQ00HbH0/kqgm0Aq0g4EGEpYmGtbXvDBGV/x97n7kxnXU9MM
 084sR+0HuXmUngttKWYRTNyvu05KQKOJd7T9NC/h+gs3v7bBQwqB/M3mOdeQEueh/SCS
 XVSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbC0phJZ7wPhCisShY7GYIkCi9FzhncdCKG+asL5CRbXYGqHLxXbs38wQ8iMSSUVuyZp99Co8=@lists.denx.de
X-Gm-Message-State: AOJu0YxdhOh5zM0cCIRfIMBBw5ydGxp1hfjpOlAJS137SZva64gDsiHd
 Y1SLcBl/ylOBTJWkUejhDF1ULkl8YsV7fPn/T0KRTY302lrqRPPHQto3yzo0YL4=
X-Google-Smtp-Source: AGHT+IHJGJqPZfy6VKjdgxE7BUbSyVC9gISQI7sTkgh2z/CTVZSFJAh6bXSoVMA+7564xed4v0M9NQ==
X-Received: by 2002:a05:6214:4403:b0:6cb:ef1b:33d2 with SMTP id
 6a1803df08f44-6cde14b965emr36597546d6.3.1729269560423; 
 Fri, 18 Oct 2024 09:39:20 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cde122b078sm8474566d6.77.2024.10.18.09.39.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 09:39:19 -0700 (PDT)
Date: Fri, 18 Oct 2024 10:39:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Stefan Roese <sr@denx.de>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/3] x86: coreboot: Add timestamps from coreboot to
 bootstage
Message-ID: <20241018163916.GA4959@bill-the-cat>
References: <20240828201355.1111764-2-sjg@chromium.org>
 <20240828201355.1111764-1-sjg@chromium.org>
 <CAFLszTjk+LtGFUBb-Xgn_QX-W-QP+yCJ+E1C=V04VGcpi0mVng@mail.gmail.com>
 <f6cfcdee-e7a2-4564-a1f3-473fb47cb3cb@kwiboo.se>
 <CAFLszTi9U=QFqekG93SoQmDrCE=vH3=N3BvZ8sQ8_yFBkv62RQ@mail.gmail.com>
 <c3fa880f-989d-4283-b0ed-5719562dc154@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QWokHM997LOXN904"
Content-Disposition: inline
In-Reply-To: <c3fa880f-989d-4283-b0ed-5719562dc154@kwiboo.se>
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


--QWokHM997LOXN904
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 06:30:54PM +0200, Jonas Karlman wrote:
> Hi Simon,
>=20
> On 2024-10-18 16:59, Simon Glass wrote:
> > Hi Jonas,
> >=20
> > On Fri, 18 Oct 2024 at 01:44, Jonas Karlman <jonas@kwiboo.se> wrote:
> >>
> >> Hi Simon,
> >>
> >> On 2024-10-18 01:12, Simon Glass wrote:
> >>> Receiving timestamps from coreboot was unceremoniously dropped some t=
ime
> >>> ago. Add it back.
> >>>
> >>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>> Fixes: 8ad01ce36f7 ("x86: Remove x86 specific GD flags as they are...=
")
> >>> ---
> >>>
> >>>  arch/x86/cpu/coreboot/coreboot.c | 2 ++
> >>>  1 file changed, 2 insertions(+)
> >>>
> >>> Applied to u-boot-dm, thanks!
> >>
> >> I was under the impression that you would rework this to prepend the
> >> coreboot bootstage records instead of adding the preceding coreboot
> >> records in the middle of existing U-Boot records.
> >>
> >> Or did I misinterpret your response [1] to my "bootstage: Do not sort
> >> records" patch [2] and you instead wanted me to do this?
> >=20
> > I decided to worry about this later. There is a coreboot update as
> > well in this lot of patches. Once that is applied I have some more
> > pending patches and I will take a look at this.
> >=20
> > I sort-of agree that sorting shouldn't be necessary...it's just that
> > with the boot sequence getting so complicated these days, I'm not
> > sure. But let's go with unsorted and worry about it later when we have
> > other cases (i.e. other than a prior stage) to worry about.
>=20
> Does that mean you will merge my patch [2] to remove the sorting? It is
> currently marked as 'Changes Requested', yet there is no request to
> change anything. Only a request to insert the coreboot records in
> correct order, something that is more related to this patch in my mind.
>=20
> Regards,
> Jonas
>=20
> >=20
> > Regards,
> > Simon
> >=20
> >=20
> >=20
> >>
> >> [1] https://lore.kernel.org/u-boot/CAFLszTjz9dX2UzUHgbmsr2no4seK07oo2P=
C++hS2t7CP7z8khA@mail.gmail.com/
> >> [2] https://patchwork.ozlabs.org/project/uboot/patch/20240803124149.29=
16030-3-jonas@kwiboo.se/

Moving this patch back to "New" for now so it's not so easily lost, I'm
sure I marked it as Changes Requested at the time based on how the
thread was reading to me then.

--=20
Tom

--QWokHM997LOXN904
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcSjzQACgkQFHw5/5Y0
tyxDlAv8Cj0ZOqHRkpsFl8EPxm5dW450J953Qmw8ze1S6GBgYcitOPnTWpNmPNg9
UQntjyhBmH4uiYfRLpLKNXO84R9XievscOTMyky9XX7F48ZifB+jOR5pRRByemRE
BUXVc5Rz8A1lJLzLZ9uA932iGZ9c5FjMpMzgy8O6TyXCplCnQhUg2DHaEh2Fg55U
Qe0HwDWdsUBUFqlhv3HdeAhlUXr/NskEf67gGxcuM0eEAfWIwR0SZZDnIBxarQvo
exrBpL1hjlnPtwhFS/CZsvd3/Grcj2xhjOJbx5pZO+SpfsGzU5P8zJ/cZDXs2Z8/
BAckxGXQEc5HmgDdjzzg3C+EjWpxIYmFsYzVn+BXgm1uvGyX3p0JQgAkXHS2SKS9
MmOgVALrdE3ujVpiwERLvl+pcLfqS0jfisxXe3pfhR9tjhf1LwyBF0q5y/ALcs+s
pPxdn0BvTRoJHG9qy00U5n7Li/fsdXL1fkhOBZI4ZMe6P8YX4DyaG3N7d5HiAw4i
FQ7ZN0hk
=uVMy
-----END PGP SIGNATURE-----

--QWokHM997LOXN904--
