Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25FBFCA5FE6
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 22:26:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF3FB60DC7;
	Fri,  2 Oct 2026 22:26:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DjtsRHhZDIkZ; Fri,  2 Oct 2026 22:26:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A289460DB2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790979989;
	b=EpP1ZnJqDlrusSHBkAuYojqQiwciib3bDsXI8QDYewjHSqCPN8OQEhG9YVcagQKFpxZs
	 XTgF2F25OI/rhtgFKHDlZbY6KRVB6LxjtkCOAFpVHL4fXgNPrjjtl96YZ0pDaWSJszHIV
	 wNw7gyrGVhH6+lweLgPO8yR2I/AfQYu5a0kmBoTbJOzE3TWpC9Rl2p4HYPs/srXUI5kN1
	 tZtznZHOhtl2w7pNsgC/YCoKiZKcJcXU5PWmmuidDFqJAypySRR+cyQlSN7UYHfAzu6lW
	 wHmsI4UbQG6yFbYRXNKdjFapcIuKzev9CEhwhq86RIDOgokplI7rG7pBvtnfsAdZRTA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790979989;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VxwPxHjaxMjWqJGW7tnKnVTS+2pMb13ji5a7vVxxgPM=;
	b=POcF8trCq0pqLYv9pXEAVTMdTKjDWwAtIiIXaBxemzpcHaIGAP9458lrYqa5bQTk+t4f
	 L6IDqrPIcmm/q8ZbIgNTDv4WPsGYKECsI8P9jodiEbniw5YPlTvGDJlZGJWnsM7Lr1bHv
	 8cu7PV/Xv7SrTYKv5aFEX3GtT93aieBLMVGrAlL3i7T7EIcBmNN79eKxTE/C6CWuCLjvV
	 Neyk726IYSQi3afO+2E5ih0FK6Vlf6Hs7d/oFxp62UVbQXkBgEiGwtRPoinvb3FPiwoDS
	 j5aDXBTeUT+ACCeydCzGuyA2TaqfE7TC806uJG7cce2jhx38IDmwt4nKeJUl280AWNg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=KZMz+xeE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790979989;
	bh=VxwPxHjaxMjWqJGW7tnKnVTS+2pMb13ji5a7vVxxgPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lNjoV/RR0opAg4MOQ7UQgCpRD8rzARbzZv+bpaIrcLyvlPr0UtPmm1fLXRHimSQuN
	 UJt1FKQ+Hq4jyBa8aIot7cJmTXxJAabRe358HJWC7I3X57FEn9LGfutSAPWLQ2Q0Es
	 ZRcfCDKkQJvM/RVDnsPMGzoq+SMeNKIrHnO9XNF5zadaK2UJNCcFcUJwTpQQjMnLro
	 zDg/klCxV9XbBX11CrRVYcrDl8c2e3zlejfaZz/toCSLmI86RTNOAQAXjZW1D0YlLH
	 I0udUqkD1ixQiaukI2b3uKosD5cfUm38+WDomU8GNgCFlWI08I/vIasyx+KPv2gDWR
	 2KObAaFesYbqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A289460DB2;
	Fri,  2 Oct 2026 22:26:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AB2F5263
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 22:26:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 907C860DA9
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 22:26:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jZDNjtShXlKu for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 22:26:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9943E60DA7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::5"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790979986;
 b=lK3fdoRqU7zfD2pW95JSDRvI8LLC/SRwZFUwZd7m6YH0K4sj9aNk/UAAns3ZiCQ6zPKF
 kSEUQ1WhtVzhUKnSn4oyXtM00QhVwthQ+D8BJ+Cp+DSyO/3gJxi6H/yn+vUkFtHgzQTsz
 iWRu21PX18zHlbLJorVCGbJWneDst1HhLcXk/Y8r1sTBDfDS+KqZHlW14C05yJrcyxYNf
 S1NpY80YONAgHOZK7ScaYCbCU9LFQIWS9ehsLLYP5CZHSDsMfkuFACOT7a172m1+445Ty
 ylaFdQ51kZYqnJGNNKYDqlihETQXi44uD2BU7dAOaSRfo52ibNN4NrF7JOmBWaxb0iw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790979986;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=VxwPxHjaxMjWqJGW7tnKnVTS+2pMb13ji5a7vVxxgPM=;
 b=QOn2A7mLlxVtAGr4V4jKwTrDlqly3HtwHj+F3sZ5LrsGyjTMiTsdb60o6mGfFJAyDHM0
 xrwwy4o5gq5zhb2VAk/VSUrn0elEpK+uKTQOgrxT6VBh2HW2CtLwTFo9IICdW/7/Ehkyf
 /K07/QQv1D7y26fV/4AbUYJa2I/mw/B4OBg3Z+cb+5YUZ5Exdglx9DDbSw0sVwFeJoPim
 kSVj5fuVtQpwAfOWEBkp4uNoD3UWGo4qr/j1FekFjMnK+df39/sgS4wIKg0Ki+yLRCYtk
 uHphXR6L110lwBxGbtgT3UnpqD+mE1agqOrE8ZNBXBVID06tgr1X0KJe9dQRvLNTbow==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=KZMz+xeE; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::5"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::5;
 helo=mail-oo2-x05.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=KZMz+xeE
Received: from mail-oo2-x05.google.com (mail-oo2-x05.google.com
 [IPv6:2607:f8b0:4864:31::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9943E60DA7
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 22:26:26 +0000 (UTC)
Received: by mail-oo2-x05.google.com with SMTP id
 006d021491bc7-6ded5e60771so93202eaf.1
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 15:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790979985; x=1791584785;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VxwPxHjaxMjWqJGW7tnKnVTS+2pMb13ji5a7vVxxgPM=;
 b=KZMz+xeEURNk54OyXzln6mgZct87wbJySJLvzpcCO6J0FpNIuHYOFK3JQ2Odyk3N7Y
 RV2SJKcSnshjahtexqzwUmacXQi1NI7LkydNQQIkgE/SdgYUVWRsMAj8y+s/1v2evl9K
 0xwBQGoDEyeeaFalBuxhGslus2Rg0uERwzOgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790979985; x=1791584785;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VxwPxHjaxMjWqJGW7tnKnVTS+2pMb13ji5a7vVxxgPM=;
 b=Mh6KA5fkQZYIt9yT4MHwUvGAvM49G37e3VAZ6LzuFf01xaUQiXIAFhR4RmiVQvbfDR
 U9H+PQ01TYAVLyjj4dlLcBYJdEqUOgU/XecnaYD4ewaYjhFRQsw9ZuGVTRXhAbQcQ1w9
 SxqW3ArnejoUHHEUnEHliDERgdj0WLbVzPOdGrxwlBr1lrSYURG69S2WqbGRcyuH9xn9
 dTPQmaZ5Q9r/a2BX/KyVM21E43fOgxlXyd0MpXG6VbGyh53kphVc3Dh312ZYUByR7YEY
 1Hyfo41ECR6QyHXovIuEtft+Aj0o1oBKfqlMpsnxwujkKTj+trc1Fud0Z1A6XERP6MSz
 4yQA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwa+bEWO3xFW7vgwQiNYoN5q7DtsJrcjBbg+XsX5+G2Dl4VBfO5GTQbiPKxRPuaeyuYP8qcuzU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mFGRu1M3j0Q5pxZ9+y6GNWeV4uZ6Ch0P3pM+1H861xgquQPLAO
 UmFpoE8HDTJh+wAwjQ34tLRIq+Z09MGjZv2IZJHfPryuMvh1++sh0wLZ/WgjSk3TM7U=
X-Gm-Gg: AYBFou33x4O8zlSgQsKLH23mmamf4AuUBdI4TXpoRYiWkyQOJ/Z1op+PaoI4Eh/FT6W
 IznDHuH3UtLP0l37rT+fVniUpPNp0q0swqdS2D+n+ecLg4ZYTN7UkBFXcw4XIgnnG3vvyyadWWC
 UzoADv9hFY8ZwpudPS0W/CybHvmotRSzPPKAto0K+AVhoul/bhPrGXsSRlgduFQG33Yng9XWyZ/
 mWIzxFHdIh+hdFK5t4HcoHrMgpq8rPF2FPg1wg2mIRhQD/SxrISMxNZOnFbJ9++nQWgl2qyhK81
 OKaz1k3y3TyEvS8YJUvgOKJMov8AAdNu8e6gmeLzp8cdIbd7JQvFpe/4IgTBVK/xrvP7NypMADl
 q/3nwulntBK5GWKcjIbRim6m+pWlb6ZVxB53gGNnvE+8p9MXAnrMCKbXg/I/MHHQswfXEwG391E
 YlJe/O0WnwCKySe8J3L0IPgQJzqpWIGWbEf9pI/iaRwPXSwu31PiC0NKTwA7hULONr7+QZocjJe
 3mPqh7EidKyQfcGQp2DQhTabswZnU/uypN3wc8ShhtMu6IKZ8YAlJ4cYOJ2mvat3/8o8w52SUPc
 nhPWfJXNpvfLaynsfeg=
X-Received: by 2002:a05:6820:2006:b0:6cd:3ffc:e32b with SMTP id
 006d021491bc7-6e09eb5e490mr522614eaf.73.1790979985114; 
 Fri, 02 Oct 2026 15:26:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6df3a3bcd14sm3329911eaf.4.2026.10.02.15.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 15:26:24 -0700 (PDT)
Date: Fri, 2 Oct 2026 16:26:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Beleswar Padhi <b-padhi@ti.com>
Cc: sjg@chromium.org, afd@ti.com, bb@ti.com, anshuld@ti.com,
 hnagalla@ti.com, jm@ti.com, nm@ti.com, n-francis@ti.com,
 u-kumar1@ti.com, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v7 3/7] binman: openssl: Add boot and load extensions to
 x509 cert
Message-ID: <20261002222622.GA3038216@bill-the-cat>
References: <20260922084536.2477291-1-b-padhi@ti.com>
 <20260922084536.2477291-4-b-padhi@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="swdsix5RB8dTuI2a"
Content-Disposition: inline
In-Reply-To: <20260922084536.2477291-4-b-padhi@ti.com>
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


--swdsix5RB8dTuI2a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 02:15:32PM +0530, Beleswar Padhi wrote:

> The boot and load extensions in the x509 certificate are required for
> requesting the secure entity (TIFS) to boot a core. These fields are
> defined in the binman node for each core that must be booted by TIFS
> and must be included when generating the signed certificate.
>=20
> Add support to parse the boot and load extension properties from the
> binman node and populate them into the certificate. If any of the
> mandatory properties for an extension are missing, that respective
> extension section is NOT added to the certificate.
>=20
> Add test coverage for the boot and load extension functionality in
> ti-secure certificates. The test reads the generated config file and
> verifies the sysfw_boot_seq and sysfw_image_load sections contain the
> expected values from the DTS. The negative test verifies that partially
> specified boot/load extension properties trigger an error.
>=20
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Udit Kumar <u-kumar1@ti.com>
> ---
> v7: Changelog:
> 1. Carried R/B tag from Udit.
>=20
> Link to v6:
> https://patchwork.ozlabs.org/project/uboot/patch/20260831083347.1168880-4=
-b-padhi@ti.com/
>=20
> v6: Changelog:
> 1. None
>=20
> Link to v5:
> https://lore.kernel.org/all/20260720080114.775206-5-b-padhi@ti.com/
>=20
> v5: Changelog:
> 1. Log missing properties and raise exception rather than returning
> silently.
> 2. Squash [PATCH v4 07/11] and [PATCH v4 08/11] into [PATCH v5 4/7]
> 3. Document properties in function docstring.
> 4. Update tests to check the load and boot sections contain the expected
> values from test DTS. Add negative tests to check it raises an error
> when some of the properties are missing.
> 5. Add R/B tags.
>=20
> Link to v4:
> https://lore.kernel.org/all/20260425033742.1519298-8-b-padhi@ti.com/
>=20
> v4: Changelog:
> 1. None
>=20
> Link to v3:
> https://lore.kernel.org/all/20251231173621.1069988-8-b-padhi@ti.com/
>=20
> v3: Changelog:
> 1. New patch. Add support to sign HSM firmware here in U-Boot.
>=20
>  tools/binman/btool/openssl.py                 | 49 ++++++++++++--
>  tools/binman/etype/ti_secure.py               | 65 +++++++++++++++++++
>  tools/binman/etype/x509_cert.py               |  4 +-
>  tools/binman/ftest.py                         | 45 +++++++++++++
>  .../test/vendor/ti_secure_boot_load_ext.dts   | 23 +++++++
>  .../ti_secure_boot_load_ext_partial.dts       | 20 ++++++
>  6 files changed, 201 insertions(+), 5 deletions(-)
>  create mode 100644 tools/binman/test/vendor/ti_secure_boot_load_ext.dts
>  create mode 100644 tools/binman/test/vendor/ti_secure_boot_load_ext_part=
ial.dts

This leads to CI failures:
https://git.u-boot-project.org/u-boot/u-boot/-/jobs/105234
and:
tools/binman/etype/x509_cert.py:106:30: E1101: Instance of 'Entry_x509_cert=
' has no 'boot_ext' member (no-member)
tools/binman/etype/x509_cert.py:107:30: E1101: Instance of 'Entry_x509_cert=
' has no 'load_ext' member (no-member)

--=20
Tom

--swdsix5RB8dTuI2a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCasAvfgAKCRAr4qD1Cr/k
CghlAQDSdj+jZhz+WP8K7qYhEH6Io3BhXetU8S8IiHPKesBFhQD/VJWMIWLRkKXR
vnBnN/WEww1bPH/T6rcZ9RCaZnFh2AI=
=Mr6t
-----END PGP SIGNATURE-----

--swdsix5RB8dTuI2a--
