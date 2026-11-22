Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FA3606A320
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NfihaVHC;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=YJkP1dwM
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 443F14064C;
	Sun, 22 Nov 2026 14:10:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tnL_P8bsPboL; Sun, 22 Nov 2026 14:10:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4D7AC405F3
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795356602;
	b=IldVP09un9vEvlu5fnZ7R+4gCB7HNrKlfKYzs7uoFUngvlNy4VpvDRMfyKXtosPeiTs2
	 DNEduz2KdqAThYxn97ptwR9JsGSEM2g1sepLhxrssIZkZ1EW38bjWIRChk9Zm0ZDARLfQ
	 G3iakKeNIs+kdZdgETFYD/CgcTdR0L7UZYrEc9RSP3wYM1IyQbdHs6zKC7pjukXMT/mzQ
	 nQ7p8FAlHwT0EngUZn0/vgRx8j3S5+mcR5FT8jD4D3NqNKzxKj4CtFv1AmfjT7yEFjpgB
	 U5tRq/Qtu8qUe+Er+ttlbL93VWOYAHt1jl0WNh8ixv8UVHSAxuSD+39aTjOPaLV2a7w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795356602;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=a6h3Hgj3jrIAjvlYftlENqhstJIokn07Doh7FHmBnjY=;
	b=mre3Yd+4Bu9ora8JSfDWBDTOX3I20sSmiLK4y7Eju4whnflhoq+4Y9/5qTqIwYpwi04o
	 Aj5FAkgpE6PMA3JnjHQmMbQ7QJPHF4O1pCeYSTg9fIyXJMuKeoJWDDp916pgl6zrdgGkl
	 U38xOeCpTntdHlVIFxmwU2HqkiDzOkzRzHt68sVskS27HxLyD48HykfalzK3Nt0XjFUyV
	 pwBT4sBnj6fgVQ79xwXf+9E/Ul7q89sfF9I1N4F1vXxT65OUxeA2THEHpeajp0tkR+4cB
	 z8UDiXaOCiqdEugG5M8j/0Jjp08jHfHfh/pxUHfji2lFVltvWQAlgYCn/yXY9JZwI9w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795356602;
	bh=a6h3Hgj3jrIAjvlYftlENqhstJIokn07Doh7FHmBnjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NfihaVHCAXcF2w6iX2d7FVyoUAJxP05G7r/Smq+V2WTNvRXsu2Ln5JBU9MizW6v2x
	 RJBEKCYQoJMM99AL+rvh9SmDDcVh2fei+O9awOjxGpS+jR8PzaSSfw6v+sVhHYwogr
	 AUnc0/ypqscclD8HyO0hcFXW1FBCIuQ190Qu7H63BsW2g/Nqx8Nfc4jGGYBmHUL+bp
	 ZmkAblSMk1OK0Ol9CNhd4ArU1oC3s85ngmz4BguXigXEhfzbenKIj0AKVZOc7KTsqb
	 4yO3g8Jhm+MKjlseXnQq+Cg9qgII+YyxxCkhUhQfR147C6V23UXEn0ypM6tV7D5ye2
	 /uEpWnsx/y7rQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D7AC405F3;
	Sun, 22 Nov 2026 14:10:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 35D7F465
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 14:10:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1AFB380D5C
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 14:10:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hdzVSmEPBhzm for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 14:10:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2772580D5B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=YJkP1dwM
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2772580D5B
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 14:09:59 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-85a5455bd3cso1460622a34.3
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 06:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795356599; x=1795961399;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=a6h3Hgj3jrIAjvlYftlENqhstJIokn07Doh7FHmBnjY=;
 b=YJkP1dwMQSOiBdw9kwHuOaYGZAxFp/I0ywOVzSf4Aqx6wEPu9s4qStuUWZmpZIFPZj
 8Dhdl18qO7ZXQMs+LeOX6JP9APnrz/I+QDfgOYHV4TSp6uBzt0fC4EdhbF4z2Q4MjLqt
 nD+EYIUwnBly5kco23zNdCicNc4SzKOTNQESM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795356599; x=1795961399;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a6h3Hgj3jrIAjvlYftlENqhstJIokn07Doh7FHmBnjY=;
 b=Y0nH2ai75pEvgc/4Fow99X8ZqD2tb55kS/EfFyp0bPnO4Hr4JasANThAMMtN1/0qo8
 kksH20a9W6cup+yeMTSQzx4ZGbSEINBSOZWogfsPcKG3gsHixarhHWXittogerEgrb5r
 18YvVF7nS8hsvxEuQf23Xw24PSwR9IlfW/itdR2Q6FSyCCvfButurM85qhWhipPgn//p
 q0RxD4dmPWoUeymF3ovDSUyrIdtnETHjE01dtKj+u4R6CTrbbQK0aZadcCNgQugUVMLf
 RdkZxGpAGGRkso5eqL2CoDn1axOSOqqHFQJu4U0nTDZpGsWYtBH+E83KqoKQ3lNkqGNf
 cMbA==
X-Gm-Message-State: APuU4Z91pIh7w9KzWz7anJIktlUF13d/QPdjGB1lqFqAzEysge6oi9L6
 1HSltu23Qry4jDkWMRIzNQbNRqShCiZn7H/f0rejzvEcb7zmkafN+hEopUfniUz3nls=
X-Gm-Gg: AZFdTZc3Sft51dUXTSXl+0QMmi2QKwS0Yx53ruVUL2yrZrxWEn2FZ3Bk9ISuVllcoyY
 0Qb0wnDH1N02vIZ64pYdVY+6T+2532CnwJxdOcn1WTViylND/vhjKvaPYgysHfZMpXLnDIjJ66u
 AcPIgnyIxkUeLZpYJa3FUWzAxrVaYDO/hYbDwPsZpmxUQIRdv5OtahVzFk9fUl4WE+FRUM+6KD1
 811dKNdb/mNM3yw9hN7coPC7zOpEkXwyfVG/Pp+d+jcMD37VQHtjmcSYWxONCuj7s/BneqOGZYl
 zmfy2MnnaNj9lLzOZv60ds1T0URHpch2w5S7rWe7Dy8KUBWvadvAM5wWB/reUKXKntAfKqteSAo
 0C+oJCeWJ5q40ppLa7mwtwMS1PhUr+jx+lWsYba/1Kb5yb98XF2hjK7qVvvrooEirHkQ9fbYSnk
 jUPRWRjp6Cq4NcEulWfmkMG8gxstSfgJiRh3p1A0K2pzzExbYwPQ7Aiup6jh0+/2C4iN9rvs/oc
 7sbodchzr9eRIIKJ8wRsZ4/qG+gUwZlQ6I96u98iDuquE+cSLWg9KWG0+3flqoLfrQL/Y+JPSbK
 HZVTTJX48DdkJzu2xvoQdhXgKCMRy/c13huavtI4tI/GxvhIzeGlTJ1xezF4BYqRaPEDjStudTF
 /5jdyVSkcRm/Oi/1EmgL9nw5GMm2OVtZRUH3ByDpSy9dHU0VljduoAV3TCNpOtY+FO5gj/2LvAk
 EH9qMYo/ap66Yw6FuOFNz71guhLFfK4dI=
X-Received: by 2002:a05:6830:3141:b0:862:c6cb:2e22 with SMTP id
 46e09a7af769-8631537c5cdmr11209869a34.3.1795356596606; 
 Sun, 22 Nov 2026 06:09:56 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-863168dd6d8sm6391379a34.10.2026.11.22.06.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 06:09:56 -0800 (PST)
Date: Sun, 22 Nov 2026 08:09:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Francesco Valla <francesco@valla.it>, Anshul Dalal <anshuld@ti.com>,
 "Kumar, Udit" <u-kumar1@ti.com>
Cc: u-boot@lists.u-boot-project.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH] arch: arm: dts: k3-am67a-beagley-ai-u-boot: Mark
 regulators as bootph-all
Message-ID: <20261122140953.GK3176972@bill-the-cat>
References: <20261121-beagley-regulators-fix-v1-1-467ace9d717f@valla.it>
 <awL1l3x5U0GRhY-K@bywater>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AChAuoq3xoY6Dkct"
Content-Disposition: inline
In-Reply-To: <awL1l3x5U0GRhY-K@bywater>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--AChAuoq3xoY6Dkct
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 22, 2026 at 03:03:33PM +0100, Francesco Valla wrote:
> Hello,
>=20
> On Sat, Nov 21, 2026 at 10:35:13PM +0100, Francesco Valla wrote:
> > Commit 607d45d1e3b3 ("power: pmic: tps65219: fail if regulators node is
> > missing") changed the behavior of TPS65219 PMIC driver, which now fails
> > to probe if the regulators sub-node is missing. This leads to a hang if
> > a device marks as bootph-all the PMIC node but not the sub-nodes.
> >=20
> > On the BeagleY-AI, this results in no further messages after TF-A in
> > normal conditions or, if early debug is enabled, an explicit failure:
> >=20
> >   spl_early_init() failed: -6
> >=20
> >   resetting ...
> >   no sysreset
> >   ### ERROR ### Please RESET the board ###
> >=20
> > With the bootph-all property added to all regulators, the boot completes
> > successfully.
> >=20
>=20
> While preparing the corrsponding patch for linux-devicetree I stumbled
> upon the same done for the Beagleplay, and in particular the reply at
> [1]. Should we instead drop the bootph-all tag from the PMIC driver?
>=20
> > Signed-off-by: Francesco Valla <francesco@valla.it>
> > ---
> > I'll send the corresponding fix to the kernel as soon as possible, so
> > tit can be picked up at next DTS sync.
> > ---
> >  arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi | 24 ++++++++++++++++++++=
++++
> >  1 file changed, 24 insertions(+)
> >=20
> > diff --git a/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi b/arch/arm/dt=
s/k3-am67a-beagley-ai-u-boot.dtsi
> > index 0e810e7f492d..72f9284471e4 100644
> > --- a/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
> > +++ b/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
> > @@ -57,6 +57,30 @@
> >  	bootph-all;
> >  };
> > =20
> > +&buck1_reg {
> > +	bootph-all;
> > +};
> > +
> > +&buck2_reg {
> > +	bootph-all;
> > +};
> > +
> > +&ldo1_reg {
> > +	bootph-all;
> > +};
> > +
> > +&ldo2_reg {
> > +	bootph-all;
> > +};
> > +
> > +&ldo3_reg {
> > +	bootph-all;
> > +};
> > +
> > +&ldo4_reg {
> > +	bootph-all;
> > +};
> > +
> >  #if IS_ENABLED(CONFIG_TARGET_J722S_R5_BEAGLEY_AI)
> > =20
> >  &binman {
> >=20
> > ---
> > base-commit: c1958b5f6cce03956d309ce422b5d9f819955d4a
> > change-id: 20261121-beagley-regulators-fix-3306a2b896f2
> >=20
> > Best regards,
> > -- =20
> > Francesco Valla <francesco@valla.it>
> >=20
>=20
> Regards,
> Francesco
>=20
> [1] https://lore.kernel.org/all/04ef3762-86d5-4d61-93f4-202f0c120433@ti.c=
om/

Adding in Anshul and Udit...

--=20
Tom

--AChAuoq3xoY6Dkct
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCawL3rgAKCRAr4qD1Cr/k
CrRiAP4/kGlDAdmPGO+LFheUUGuFsmIJ7mhmRCgZylp3jsZteQEA+MzsdWr90cLa
Q5CEv0OFKYfYGsgknsaUXZLNOfTW7Ag=
=mzDF
-----END PGP SIGNATURE-----

--AChAuoq3xoY6Dkct--
