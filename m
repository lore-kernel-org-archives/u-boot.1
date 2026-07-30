Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D90BEC55167
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 22:06:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 879B9811F8;
	Thu, 30 Jul 2026 22:06:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SH9ic2RhrKCZ; Thu, 30 Jul 2026 22:06:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6005E8120D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785449192;
	bh=AHa+37S/qhedhw4AxPkBV8l8Uq/a/Dlu4vWfBun7/oQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JInEuQLwEGYjX6A4Xc9taTYmNgrqj/nZhiDIdJAvUUE/pKllI2mKobi78Zsnpi99/
	 wCiZRa9kruDTEJMeeBgjtHVmZK4r2LSLiRtV6oGLD4vJUHsSefYfrBNDSVSvItZzBp
	 q7uLJABlyU3QKik80WHXW3ZB4pUQ5fW1+vicmCsNagin+Fc8LNR4iG4SaydP2s3I9Y
	 UCIaXiLTRsQDN9AEpj9JeEDJ8R+i414rEfQFuLrHolZwGhEGsKWPEmmfmrGXQYjmtl
	 OCAkTUNRnLGqo4A4AkCfik5iW6uCIko40vpg4ksYuXkHqhGBxSqxCb7afqikUg97Hx
	 bW2krHRExueSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6005E8120D;
	Thu, 30 Jul 2026 22:06:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 32685218
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 22:06:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 15073811FD
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 22:06:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5X-3Xz7fLPek for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 22:06:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2B688811F8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2B688811F8
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2B688811F8
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 22:06:28 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7ec3b429a3aso277303a34.1
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 15:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785449187; x=1786053987;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AHa+37S/qhedhw4AxPkBV8l8Uq/a/Dlu4vWfBun7/oQ=;
 b=Fb+s7edcdZayCxBWfskyHQB4d6EQq63dpVAct4kdZ+IlZxQpXIS9zjZRnN8v/iR64P
 gNwW2UMkXO9P/YCBN9BExpO1C5Jp7sMzjfdF8Z/aXnCgtAmgPqGZMuAWOP2Tnx9H+GjM
 nw2aEr5unwUIesOjdtHOiDAv3Px7c6L0ESeTJ+Mrud1RWP+Y/XrfS+31CMUU+XPKL+Vy
 V/pDP5im+L3dS9kOv9mDHH7cheGBEbnulZZfrsO8JwLL+gAqg8Nmo3p6qr5BkKfuzCga
 /P9XqjtXBPaVw4oR5jcfRmpgdFGi16nofUC0UnDzhTRllq2bEw39nf4P+cFWC1yB1ps7
 lLXw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqFfNdqYEDZtUZVuK3/5A7DDOvoV/RlgO++svoEQl01ZxZhwyh8/CClVAOMVvyljo+8AJk/K2M=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yyqe8IPuxfzDnjAE4ZgfA5nFbBEFaiwNp03aLLbiGevbBdcmMfL
 UyR8M+nRLtMAxwBlmUgeB//J3mNNO59WXQujVOzADanUWbwjBdJDLEI2TiweAPeD/DI=
X-Gm-Gg: AR+sD13l3Nls/TTxTNNh84+dmoj3w2rKLE7/Fs3ariGZzM01iLFQXCMb+GRiFCOCf8f
 SecROfVL8wyeJnJx6UwApIPalxBkdot1H4bJOrFN6K/HLWGpsyHd6Oi/GXmIOPWAPlUx898wbmc
 z6GWyJJfu8hESOzG6fgghqJpQQN+7PE2ntSnh0PJZBcOeZsmHhd//tyKIvew7rKWjWgXRdCzX/r
 NyHkdTg7hOIfc3OuTTvAHY+grp4AUzyU+VskbohtZiB5rcc9azyV292k2Dpud8YQ4saJjPIw+sG
 IPdOeBY+7i6Xl4Rcq/3MwfmlDlsC6IWFh9+t9oNu9n6lyDcOv+XKjSaH55KFINajCKoz10ZkqQL
 6a9xgcoRMYBW8u3rrtV1fhjubgSq5x0hDB/llfhaXIHzVyXIW4wTwBGlruqABgzQ8zR+uPiOJ4h
 AFqX+DzqGI6/st8gTXbJ3O0hvIzKev8BHP0qvPTsiHjVfaWQAZGgj3sTjLMM/F2TIcgEAoqU0JS
 AJl9Ah6Un/LWoHaQUXPbjcVVIqPlXGpE3iJ8mVaAdxZrR262DVvGtz1Sy1CVERjbxOW8CPsKQyZ
 MDzJcial1Q==
X-Received: by 2002:a05:6820:198d:b0:6aa:ff04:9a2d with SMTP id
 006d021491bc7-6ad0cb62933mr1332999eaf.72.1785449186916; 
 Thu, 30 Jul 2026 15:06:26 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-458c29d51f9sm3303089fac.16.2026.07.30.15.06.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 15:06:25 -0700 (PDT)
Date: Thu, 30 Jul 2026 16:06:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Johan Jonker <jbx6244@gmail.com>, kever.yang@rock-chips.com,
 sjg@chromium.org, ilias.apalodimas@linaro.org,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v1] rockchip: spl: replace ifdef by IS_ENABLED for
 timer_init() call condition
Message-ID: <20260730220623.GI1773261@bill-the-cat>
References: <cded3ae1-b908-49c6-af92-30b931d160c1@gmail.com>
 <c6530788-e823-4cb4-905a-5473d9c00914@cherry.de>
 <6e43369a-832e-40d3-af23-a0981af84d75@gmail.com>
 <75f48c14-bad9-4250-a4b5-321cc17bc1ec@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Nc6nMlCL5OGjeoq0"
Content-Disposition: inline
In-Reply-To: <75f48c14-bad9-4250-a4b5-321cc17bc1ec@cherry.de>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785449187; x=1786053987;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AHa+37S/qhedhw4AxPkBV8l8Uq/a/Dlu4vWfBun7/oQ=;
 b=fhvXyTfeU0rO1JvukrvYdGj8TqCH75y6MhE6/tr5x+1xqkAGBKYab6hJUjkiY7n84R
 scXEtFr4+irLFOxXZVw+pZkC6ELb2f/2TCDYUpzV6rVTajTkOXBrqA257IQbdHmJvyVE
 hEDx5B4A9d3I6kq1pXePGE1OVi7U+zeN70ueM=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=fhvXyTfe
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--Nc6nMlCL5OGjeoq0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 05:37:52PM +0200, Quentin Schulz wrote:
> Hi Johan,
>=20
> On 7/24/26 11:53 AM, Johan Jonker wrote:
> >=20
> >=20
> > On 7/24/26 10:45, Quentin Schulz wrote:
> > > Hi Johan,
> > >=20
> > > On 7/24/26 12:17 AM, Johan Jonker wrote:
> > > > Not all Rockchip SoC models use the ARM arch timer.
> > > > Call the function timer_init() only when
> > > > CONFIG_SYS_ARCH_TIMER is available.
> > > > Replace the ifdef call condition by IS_ENABLED
> > > > to increase build coverage and make the code easier to read.
> > > >=20
> > > > Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >=20
> > > > Previous version not needed for serie, so resend separate.
> > > > https://patchwork.ozlabs.org/project/uboot/patch/20220403230659.120=
39-5-jbx6244@gmail.com/
> > > >=20
> > >=20
> >=20
> > Hi Quentin,
> > > You didn't answer Kever's question in the linked patch and I have the=
 same question.
> >=20
> > Yes we end up the same code. But...
> >=20
> > >=20
> > > This is essentially the same code, so what's the benefit, are you try=
ing to fix a specific issue? How does this improve the situation?
> >   > How does doing that increase code coverage... etc :)
> >=20
> > This patch originates around the time this concept as introduced.
> > We are changing all code to the new norm and we leave this as it is...
> > Fix this as well as a favor to Simon as part of the review. As we are t=
here then fix them all as this is the new norm.
> > https://patchwork.ozlabs.org/project/uboot/patch/20220403230659.12039-6=
-jbx6244@gmail.com/
> >=20
>=20
> This doesn't point at what Simon could have said that prompted this patch.
> The pointed patch did actually fix something, and instead of using
>=20
> #ifdef CONFIG_SYS_ARCH_TIMER
>=20
> you used
>=20
>     if (IS_ENABLED(CONFIG_SYS_ARCH_TIMER))
>=20
> which is absolutely the correct and "modern" way of doing it.

Right, and when it makes sense to and improves the readability of the
overall code. If it not a must-do every time. There is a judgement call
to it.

> > The concept:
> >=20
> > Currently with #ifdef the compiler sees this code:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > 	rockchip_stimer_init();
> >=20
> > 	ret =3D dram_init();
> >=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > Now the compiler sees this code:
> >=20
> >=20
> > int timer_init(void)
> > {
> > 	gd->arch.tbl =3D 0;
> > 	gd->arch.tbu =3D 0;
> >=20
> > #ifdef CFG_SYS_HZ_CLOCK
> > 	gd->arch.timer_rate_hz =3D CFG_SYS_HZ_CLOCK;
> > #else
> > 	gd->arch.timer_rate_hz =3D read_cntfrq();
> > #endif
> > 	return 0;
> > }
> >=20
> >=20
> >=20
> > 	rockchip_stimer_init();
> >=20
> > 	if (IS_ENABLED(CONFIG_SYS_ARCH_TIMER))
> > 		timer_init();
> >=20
> > 	ret =3D dram_init();
> >=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > By using IS_ENABLED and CONFIG_IS_ENABLED the compiler is able to look =
further into code and catch possible errors or warnings.
>=20
> I don't know anything about compilers but I'm surprised this would actual=
ly
> do anything different than what we currently have.
>=20
> If CONFIG_SYS_ARCH_TIMER is not set, then you get
>=20
> if (0)
>     timer_init();
>=20
> which the compiler will (hopefully) see as a non-reachable branch and
> discard it.
>=20
> Otherwise, it'll be:
>=20
> if (1)
>     timer_init();
>=20
> which hopefully the compiler will simply replace without the branch:
>=20
> timer_init();
>=20
> Maybe Simon or someone else can teach me something here because my naive
> view on this is: does not make a difference. What kind of benefits do we
> have, what do you run to see those benefits?

The compiler benefit that using IS_ENABLED provides is that we will make
sure that timer_init is declared in a header that is included. That's
it. It can be useful for more generic code, but it's of course imperfect
if the include chain brings it on some platforms, but not others (as a
warning pointed out on IRC today reminded me).

> > There is even a warning for it in ./scripts/checkpatch.pl
> >=20
>=20
> I'm aware, I quite often trigger it :)
>=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > __weak void rockchip_stimer_init(void)
> > {
> > #if defined(CONFIG_ROCKCHIP_STIMER_BASE)
> >=20
> > #endif
> > }
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > There are exceptions like in rockchip_stimer_init where certain defines=
 are missing, so that's still allowed.
> > In all other settings we use IS_ENABLED and CONFIG_IS_ENABLED.
> > Hope that explains your questions.
> >=20
>=20
> Not really no, sorry.
>=20
> The commit log is misleading and needs rewording. As far as my understand=
ing
> goes, it's clean-up. Maybe there's something helpful for the compiler but
> you need to prove it because I don't see it (I'm interested to know if it
> does, so please tell us!).

I agree, at minimum, the commit message isn't clear that we're just
replacing #ifdef with if (IS_ENABLED()) as a clean-up. I'll defer to
Quentin on if that's worthwhile doing here, or not.

--=20
Tom

--Nc6nMlCL5OGjeoq0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCamvK2wAKCRAr4qD1Cr/k
Cl+1AP4vzuBMzpHcxOtJUBHR3hWRA4eXvzhRA9mRwroD9vMrXgD+N5UCL6rMIE5G
ua3S4EAYpvafZMNDb10+6fZPIbK/kQY=
=m54Z
-----END PGP SIGNATURE-----

--Nc6nMlCL5OGjeoq0--
