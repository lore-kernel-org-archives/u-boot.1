Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9977C606B452
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 18:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=D9TdDjif;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=nxB0LqXU
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6620C408CD;
	Wed, 28 Oct 2026 18:13:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HAaqoqWOt2dO; Wed, 28 Oct 2026 18:13:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8CB71409EE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793211200;
	b=hAAtThE5JXm38GEOzAJtC3FGQx4aS/a+jjNZ/GLUtZ1Di2tXk5vCibnr2TyyB6kmK1LN
	 3YeHEbYyerZTfUSkLl0kFxcYiNoa7+//xYwtoRfUhQZ2oaxI9TsJU87uDnHrSCfvHLNDs
	 knlUudl8aLHxZ3f4FASCrGRDCu2qV++9+Jx1nJJt+q/fZ/nS0GvKzcX0c7eVIZMnlqoTW
	 z+ajHSoHDwNeSBgaCU68JI9Jnpt4+nxrWea678yRu9r1SCCEzvgTk3GxN00Xpp/WzNH9k
	 Pja0fLycTMbFuzUzPhh5YuAn/dGx04dr01rRPtjEQPDxUYL0fWDrzl4eR3m3nNC36SA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793211200;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=/Ci/Z/SuHNGNNUprVrPCehJKqjWBvdqcoPagSunzlag=;
	b=hSN9ca81uC5e8e/B4buKgGasUsBHqgAUD8Xn+IpZGXR/dQXiUlAsvdGBVujGflneTz9q
	 4VSJoA26A1Pwq1RGD70RtCIp10SDX+2SLcMjbDMB9wRRfM/DTptN4diEfC24gtz17IbHc
	 qTzJPBMiKjEp22EfFfTHd6VYNIaQO+gAjwNDnMEZWI3PS1ZDkvwHgPcbSu/nUiic47Zls
	 UpXCXegyGLpTqCyadbEhw25ZPiQXgImG/ax6oc6N0RD9ncEx8Zi2Zuts4xgScoMohRXI3
	 cn5N2CPMa3T6m6sXOgNIxcT6W2Na0NkDF+/PKTsP3JQqDvmms0bW3/zbZsKQwR3a2Pg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793211200;
	bh=/Ci/Z/SuHNGNNUprVrPCehJKqjWBvdqcoPagSunzlag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D9TdDjifvAI8seICb7/+drmZtU6QopvjKOzSlc6/Q/xjfqnqPbbILtogqwyTgh859
	 cEH7XFn4u+nHF8MbA9CH6j13u4Rf+qGMwxV3oNYK8oYyqupSufqOKNL184csK6k/ko
	 xtjeOwUSSdlqNWKqPBHJ6I/YIHyLgIniov8hujTQAMH2FxKwUj0tTkvNvIiqjews8P
	 d5pyR8yB+mMh/vKwm9mvMakRDy3BOSBsZJyiIZPnnLTr/x7vruYbfrYBwlhQ7p1+Z8
	 LQvYeb5dmotQ7hp/N6t0mwSAKRg64IcSmICNRetatjyDCq64v9QJ8jBrOA3uUJKCSV
	 ALuIf8D0mEXHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8CB71409EE;
	Wed, 28 Oct 2026 18:13:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 879BC362
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 18:13:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 791F0404CF
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 18:13:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2-be0e-M0xBV for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 18:13:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C18834031A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c36"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793211199;
 b=lEMv331x8g1OandNfLpD7QWjqsu5ahwSbiEQVJwsPFGKJ3jpA4j0FP83ApiDP0hUAzka
 tO9cDU+yhGWdT9nFXnsobAQT8K5ytjwqbjECsb/47B/YteYbuL7Xpr90MobOfmTqPESc8
 dupC2ir2aouLH/7TmIMk2wtuVJoC49wW8ld0OVkStlPwRPkt1CLmp+Jdgc3bK3HAfTwju
 CKByNzuYXfulmFBGKm7+FIwpBoFE6G9KmaQBVrf7PiUboFc+6vkGGInJC+L9MuTVtpbjR
 e9qZEXxtzyHWOfcgB0T/5AbGTfWPz7PqKXckwB9kqk81uF4WpJ7+UEjm+oG8xP6T5Wg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793211199;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=/Ci/Z/SuHNGNNUprVrPCehJKqjWBvdqcoPagSunzlag=;
 b=WVdZ5oRQGhWaWBRBEAwz8KgOExKlqm8wvzzWktd01B0+DD5w6AqJ/r10k/Riju7CbmNH
 et6Ju2TU0Bh28NFoQMP+/5nH9/m/w/d3SxcOM+Ya0uWpt7CofcTdk9b+bVC3gNYXSJ+c8
 ZD4Ibg0kdNg/FKKvYjomx05di5nnj+4xJ9Wn+8e7MP4zXiC+IjviR3TJztGI/yyFNTRGn
 pwD1h0rdDA0ZwnqjpEdTcCTTzXCIQFXWtjxel276s0M1+ZNdZB0FtKnJfz5fPbQFFc0lO
 Y0H8RThwpvptKgf42OKJ51AA6vM0hX4EDiPK4eC7RVThHqG2lrT7RPzDC0eOL4e3PiQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=nxB0LqXU; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c36; helo=mail-oo1-xc36.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=nxB0LqXU
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C18834031A
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 18:13:18 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-70059e4dab6so884909eaf.3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793211197; x=1793815997;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/Ci/Z/SuHNGNNUprVrPCehJKqjWBvdqcoPagSunzlag=;
 b=nxB0LqXUT9/mScmYS/1ijuceXijbnV5xHGbTVgexz/rn9Kz0BUKwbamzT4ssd/WRuX
 FxIa4Z9NCiI5rov3X+lg3poddnDgimvebEiO0uc8bEyC8Zpn68BWzmOIeoak9JtOJS0d
 CwPsRLLbRXJp6to6V9DgTR2R19L1WU7At7k0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793211197; x=1793815997;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/Ci/Z/SuHNGNNUprVrPCehJKqjWBvdqcoPagSunzlag=;
 b=c8W05zRgEtLZouU3cBOb0OjcGPW0BfWUVyGHE05plS1j8h2SUsY6lM05V+VaX2NYbG
 EYNv7UDaf4kvxxvAgY3ccKYfOX6lRa2OOquv54p7xLVhUA6Yo+tag2GBFCM93Y+9+YLF
 Bun1HPdJ5nBNSgnH/ZMrGGMx0n4yaCs+9t0mpfwDZvFukfOq0MI+cXyia/tsg5WainWI
 XCQN0+07a9haalWOqPBRi/2/aoGAslcjLxT242unT5Vlh/LlIxoRlfgqbXEzAmtpqCa8
 chY7luOxTcklH/SAXCTF6M+CX6j4LVLhyMxp4o2pADTCZvhu6t5ntJdkPjV6cl8UxEM/
 TKvA==
X-Gm-Message-State: AFq9FYKzE57eva6DhyzhQGdIiNiIlPnzCoEJeWsAnWQpy6n4E2O8tTfL
 fMafUsfqqFtdJupSjeKlEdq58bz+mTQgQs3jHd/ZoDYXORXBZHsg3Hnx7vmfRD4BnR4=
X-Gm-Gg: AYBFou3q/eQ8hGdQR8vW0sMxQxxZx5B7Ho1tQKEYLP18KqH4SxPwqH56XEv2ahuhGMF
 K0S3gDanIn0patyx+5BasSakkOncoVx9/MIDsZgFoKsD88IHi7l7zOidDH2eUCNnlGve6Kvo8aa
 r7nnAqbIIzL4LK+3v3kho5lRa33BFPWgddvleNgyXZbcO2AJYtjO9EpeD5lzG7lD2VAoHCFknlN
 GgtewCLixKeeaUO4Ss6ke3+9RmgmR/dcuS/5qHIZKqW+Sp7oC3vmq4yOKe9NmCvLdDUtqqsi/bh
 tWMPbsisxNen3zc1mgNrTQrPQ7pwSD1noiHgRUud8XjktDIIds+kT/6BBU1gV6SuTcrbMMLnMJc
 GnQOkrYT02tSKfpi1X332yzbCRasjU393o2K7pQst1rkGA6Yj1UNHlhvnuxJ0VlfIX0Iy5K71hG
 CIM22y4aRNYoq/8A+X0QM1rvPqLvyAzOGAnkrzJyxcOnX6dj0zp/elFNERiYKhhQVWALSjsljWX
 JKtlhm0O3hyR+CVFQ9rr51viLeAezSkf4BSkYkBSY1wmaYnOwcdII384jgsVlkirWyp+FknqaEi
 vpeurU4VT+sag7DZUI/vq6CDr8EJPuCp6HwtI0ZZsvaSRarWyrJBGeBc25eb7XGPlVH+6h3Mb47
 hyXnY8O2q/u6RV+//11UWI49qIFXJq6aFpCamDxvLrgZHP2Bs7vGICzEkq36H0ATMtOCiPdIueO
 gzmX9fUcGV8pc0gRFZ7utTHl993fcAhSyS9UTUZpKL9yK520Kn1145
X-Received: by 2002:a05:6820:1797:b0:6f8:8385:52a with SMTP id
 006d021491bc7-713f1d51266mr1999713eaf.58.1793211197412; 
 Wed, 28 Oct 2026 11:13:17 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-7142bb765a3sm2235359eaf.4.2026.10.28.11.13.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 11:13:16 -0700 (PDT)
Date: Wed, 28 Oct 2026 12:12:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Stefan Roese <stefan.roese@mailbox.org>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 0/3] macOS improvements
Message-ID: <20261028181244.GD2677024@bill-the-cat>
References: <20261028121258.572-1-pepe.schlehofer@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eEsYB2EYkyPihUf7"
Content-Disposition: inline
In-Reply-To: <20261028121258.572-1-pepe.schlehofer@gmail.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--eEsYB2EYkyPihUf7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 01:12:55PM +0100, Josef Schlehofer wrote:

> With HOST_TOOLS_ALL=3Dy, the U-Boot host tools do not build on macOS.
> crc8.o does not compile and kwboot does not link. The kwboot link error
> also stops board builds such as turris_omnia.
>=20
> Patch 1 links kwboot with the system libncurses, patch 2 removes an
> unused function warning in kwboot, and patch 3 keeps the sandbox
> asm/sections.h out of the host build of crc8.c.
>=20
> Tested on macOS 27.0.1 with Apple clang 21: tools-only with
> HOST_TOOLS_ALL=3Dy and the host tools of turris_omnia_defconfig now
> build, and kwboot boots a Turris Omnia over UART. On Linux (Debian
> trixie, GCC 14.2) the same tools-only build and a full turris_omnia
> build still pass, and kwboot still links against libtinfo.

Interesting. I guess since our Azure builds are (wow, I need to check if
there's newer VMs..) on macos-14, and we do:
$ brew install make ossp-uuid
$ gmake tools-only_config tools-only \
            HOSTCFLAGS=3D"-I/usr/local/opt/openssl@1.1/include" \
            HOSTLDFLAGS=3D"-L/usr/local/opt/openssl@1.1/lib"
is why we hadn't hit this?

--=20
Tom

--eEsYB2EYkyPihUf7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauI7GQAKCRAr4qD1Cr/k
CuKLAQDLlILbvjpWQFibcTSevSmA9FTapvdMc8kVzVazL7wYMgD8Cf3rd3g2+6LC
nOa1gj6Ipq7dwJx4qi4dnUXUFm36lgk=
=ahLe
-----END PGP SIGNATURE-----

--eEsYB2EYkyPihUf7--
