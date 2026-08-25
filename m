Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95050C61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 14:24:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 57DB980B97;
	Tue, 25 Aug 2026 14:24:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LlPoGTewRr4x; Tue, 25 Aug 2026 14:24:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787667879;
	bh=ZBiiBc/hFUtAm393JsxnqeNQHt5z8PDm7kF4FpbFI6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xRiwbXaUUAuoGE09lPr4f2U90H/gktNC+nya8rxZOtXK15sXh5aZz3n3JTLJmq0k0
	 qaXS9rDe2vJB344z4+ru+tDjUYW4l/0mAbKynoGnV8Q90kHjeK+8nARtoYx/zIgojS
	 IewmC2leQRjadmhLeNzIAo7SuMyfS9TgEPyo6QxDwbmF1fHNEMxEyWb/81yJt9gN+K
	 weqSel48EK2lu25pkoYycbdbBbmAKg1iZVWpeW8H2uyBAKgmznQ649oY3okhgJ1mtI
	 POsrSsicd2XavS83OgZfOPv2gyDZRBLyRpBa7fSEdv91xexo8EdabPmmq6ChqQOXlz
	 +lJfZ3Utbh5mw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5926080C68;
	Tue, 25 Aug 2026 14:24:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4525A118
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 14:24:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 367E660603
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 14:24:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4HrXEQdvE5P9 for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 14:24:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::1;
 helo=mail-oa2-x01.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=SI03wxFw
Received: from mail-oa2-x01.google.com (mail-oa2-x01.google.com
 [IPv6:2607:f8b0:4864:30::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 18919605F7
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 14:24:35 +0000 (UTC)
Received: by mail-oa2-x01.google.com with SMTP id
 586e51a60fabf-4569f25c19dso1658620fac.0
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 07:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787667874; x=1788272674;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZBiiBc/hFUtAm393JsxnqeNQHt5z8PDm7kF4FpbFI6Q=;
 b=SI03wxFwMk+RIr4Ea1FRgfCjDpW92VcqXtyOJftQK6Z4DGAcXaXwpUSzrI8WE9zFHB
 fyJfsEOQyvOHUSrKof+Fsr1grYaARhFfRJ/nn/SmXIObUfBUywmUjt5G8O7iK6xfzxgK
 cCjRhPxzavDbXVJBm0jAHsBPOaMTbh9j8dILA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787667874; x=1788272674;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZBiiBc/hFUtAm393JsxnqeNQHt5z8PDm7kF4FpbFI6Q=;
 b=DnTDfEU1x4VX61rr30DQ2M8aFkjdorJCmOAQJVGnjf7rGixQz71MP1/ZPqF5ACnudz
 NU+0wOq5OhLdKiFKDImmM8HFAFqPg2FcZYN/0E1vnnYePAGxWXBux4Hi3mTEH8boj1DO
 bx4hQguJCNKZ/i9c4ehdv8Z3UOlqitrqqshCMQfUZTqiTDcc9MdBGsZYv5cdBBlaubw4
 fa4dNR390HeZJEbm3G6Vylgf89Fc+42lYHeM/UuDHwA9yMWhKR/+quHWWuvagsL0ng1P
 tySPLrjYwomBV8V+LRc9GeThoXmDyqVB4BZbrCMYfGtO38sTQq0Mw2QONbbkpSiP46pu
 d99w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqsYbmx1+TrZawCRYgH66hvZ8UnxvWX9OnAWzM/nfNatJCLB6szad9Ex7uQvYbhg1uUN0I3Rss=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mk46nPkWfdvQbMT51yK5ownrESQlBWW5vkkYGGRBodCDHMS+m3
 NZhwAKtYtZEn32D0oDLHhnUXmm7DfLQRLGrs8gHzB2gFv4THbEExVZoWKV14yWtof3c=
X-Gm-Gg: AR+sD1183/ALBn/q+iJ1wvMlEbLObhVk5QNYwGdqJiyg6O8q32Flym19MGO8Sbxrvcd
 ISE0bkLQn78/5PbyH5GpXxf/kXtqMUyyUBWhDza+w/ZOXn649GBxMxhfurO75RSIbEjvXFHtp/K
 JiO70kZpnMCFePs1Vu4BKiYWFLSsGqYaLyNHgJ2Y/lJ1gGFL8gmYcQXlM/3OPDyqYvwbj24LZru
 sVSLrYoQFEhlzO6MWFfcZXRHvvksVG7NGsGli19U2y7Z7dnT1kPIowQyTbpTuUs1uxges5UOwmv
 mlSAq3lbnGcWGItmUnS5KF+5TWlSG7KQjd94D6MktsneyEp5CyuPDzezCmukShlIPVIwmeuv93X
 qplCMM+MCE1Afzv+TGimuB2HzohQnAAvsZVNC9b0RGl1iG+GNVBTEoBY4KWu7MMJWdrDPdCuidT
 J36ZfPIS3HYobGRVxCIvLVsIz8sMs4wqHYhki1tJ3aEECcRTdwa6NK/EwZ4WiBhrbC+wBu20CpO
 gzfNveSw5I+VRKidw9mrHsNWNrw+a92w6B7fd7cvWegGKASbO7P8BHZM/wpXqrR6ptJ9RM+YfTq
 ejkYlnHJKZ9ZKkhvFJo5
X-Received: by 2002:a05:6820:4b13:b0:6b1:4806:f218 with SMTP id
 006d021491bc7-6b1903d1959mr5842765eaf.14.1787667874480; 
 Tue, 25 Aug 2026 07:24:34 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b17c703cf8sm6590652eaf.0.2026.08.25.07.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 07:24:33 -0700 (PDT)
Date: Tue, 25 Aug 2026 08:24:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: valentinliu@icloud.com, u-boot@lists.u-boot-project.org,
 mkorpershoek@kernel.org, igor.opaniuk@gmail.com,
 alchark@flipper.net, quentin.schulz@cherry.de,
 marek.vasut+renesas@mailbox.org, daniel@makrotopia.org, rs@ti.com
Subject: Re: [PATCH v1 1/2] boot: android: Add Android 13+ bootflow support
 to bootmeth.
Message-ID: <20260825142431.GU523975@bill-the-cat>
References: <20260818175301.818739-1-valentinliu@icloud.com>
 <CAFLszTj8g4xxzt9A7txOhDMU6hLe2=twZoZPo_sr7Z5m=6BC4A@mail.gmail.com>
 <20260820151021.GI523975@bill-the-cat>
 <CAFLszTg=e3-bpWB7_Q8UFcB-pL=DJvPXji3yTtF2DFWkzPz0gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fiPqGDsCKfcijvzU"
Content-Disposition: inline
In-Reply-To: <CAFLszTg=e3-bpWB7_Q8UFcB-pL=DJvPXji3yTtF2DFWkzPz0gQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--fiPqGDsCKfcijvzU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 07:16:04AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 20 Aug 2026 at 09:10, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Aug 20, 2026 at 06:31:18AM -0600, Simon Glass wrote:
> > > Hi Valentin,
> > >
> > > On 2026-08-18T17:53:00, Valentin Liu <valentinliu@icloud.com> wrote:
> > > > boot: android: Add Android 13+ bootflow support to bootmeth.
> > >
> > > Please drop the trailing period and keep the subject under 60 charact=
ers.
> > >
> > > >
> > > > The devices launching Android 13+ were using a new partition
> > > > named init_boot to store generic ramdisk.
> > >
> > > >
> > > > In the new bootflow, kernel still be stored in boot image,
> > > > however, the First Stage files in ramdisk were moved to
> > > > init_boot image. We should load it to memory and verify it
> > > > so that the kernel can execute init program to continue booting.
> > > >
> > > > Currently, we have supported loading the init_boot image by
> > > > abootimg command, but we still need bring this ability to
> > > > bootmeth, so that booting Android 13+ will be more easily.
> > >
> > > Please use present/imperative tense throughout: 'were using' -> 'use',
> > > 'kernel still be stored' -> 'the kernel is still stored', 'were moved'
> > > -> 'are moved', 'we still need bring' -> 'we still need to bring',
> > > 'more easily' -> 'easier'.
> >
> > We do not have any sort of grammar rules and requirements like that in
> > the project, please stop giving people feedback like this.
>=20
> As far as I am aware, as a project, we have followed these guidelines
> for a long time:
>=20
> https://www.kernel.org/doc/html/v7.0/process/submitting-patches.html#desc=
ribe-your-changes

Guidelines, sure. We do not have any sort of formal grammar rules and
requirements and the feedback you've been providing has not been helpful
but rather causing conflict between contributors and custodians, so stop
providing it. We should only be telling people to reword things when
it's truly unclear.

--=20
Tom

--fiPqGDsCKfcijvzU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCao2lnwAKCRAr4qD1Cr/k
CoTIAQDn6rDuxo8uDImzJhifcv/pBFKdG+sEC2ocoyMyYEjs1wEAjg+r2zNJZD3A
+F5i88hWtR2UQZJAfsDtA2xvcgRiNgI=
=xDwV
-----END PGP SIGNATURE-----

--fiPqGDsCKfcijvzU--
