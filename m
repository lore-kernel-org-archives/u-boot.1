Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 652B3C27C48
	for <u-boot@archiver.kernel.org>; Sat, 28 Oct 2023 00:51:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A04F886CF7;
	Sat, 28 Oct 2023 02:51:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Qr2pHLFS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7753186C3B; Sat, 28 Oct 2023 02:51:04 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2276186758
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 02:51:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-778927f2dd3so178609785a.2
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 17:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698454261; x=1699059061; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TaRG/avuTv5thM0LVFZL6X7q5POE8HT5+/B9sVSvo2g=;
 b=Qr2pHLFSpV49o8YfI9dcajtqlqwTyYQnqawGoUGdxW7CH+VYu8WJ75HWI++R9nfvqB
 LdpPwKV2MiC9vmyLmlgx7vq3OBVnrDXsgLha3CF5sIF7y4HTQ+RD0KtDlG1qNmAG14uM
 QcAR1uEoNEv/fUyExOGPYbqSd1Tz96KnhKCno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698454261; x=1699059061;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TaRG/avuTv5thM0LVFZL6X7q5POE8HT5+/B9sVSvo2g=;
 b=UYW0tqgLjrs0QPa/x7huuIeUXr3pIHWghLcZDj2unODVTzSvbCStWgGFro7gx7msNH
 CTdYEjx8lLlBABhKaIVI0g4YBWDizZ6st2nEVarJ9Weo03x1ea+7gyHjgWaSEpZNQ30U
 4H1j+4etxJP6G9fWHUDyBSr/hMp8wJ4MQFDplveIE8Y+p7aEXueYjEXCqMCNbFH2dkrh
 2OVAcGYH62kGCPa5aITGb5hI2vZklB/DkTUHphFZXWT8AgpjhPcFG9TmbfoWbhKUzB9y
 rruT1hFOFg/1PHUS1tNqHTykvMpPnrA51oOgkQOvQD3deYgoJZLDyMg5LzPbYFoaZ1Bf
 6ywA==
X-Gm-Message-State: AOJu0YwUUXrIaRPpW0mYhh799oOUlZgB2OnPF3+DVH/1ieaHMtJ5dLoE
 JPsaEAaPkRQ9Z9rEoCmwRmiQxpcA0/EjUKDR3aBR5w==
X-Google-Smtp-Source: AGHT+IGxRFm2+7pkCkNa7RUCH8vf23NrppI3nzBPu1s9QmVO8xkn4AArjKLCDIG7QVD2Eau4gT4Cdw==
X-Received: by 2002:a05:620a:2a11:b0:774:3963:41a5 with SMTP id
 o17-20020a05620a2a1100b00774396341a5mr4523763qkp.13.1698454260926; 
 Fri, 27 Oct 2023 17:51:00 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6f2b-3a78-9e8e-d344.res6.spectrum.com.
 [2603:6081:7b00:6400:6f2b:3a78:9e8e:d344])
 by smtp.gmail.com with ESMTPSA id
 m12-20020ae9e70c000000b007770673e757sm1050695qka.94.2023.10.27.17.50.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 17:51:00 -0700 (PDT)
Date: Fri, 27 Oct 2023 20:50:58 -0400
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-amlogic-20231027
Message-ID: <20231028005058.GE496310@bill-the-cat>
References: <4839b54f-1e61-4c46-b1ed-40a2ea0f9c08@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rDcufPUt2JXHl2qo"
Content-Disposition: inline
In-Reply-To: <4839b54f-1e61-4c46-b1ed-40a2ea0f9c08@linaro.org>
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


--rDcufPUt2JXHl2qo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 10:38:41AM +0200, Neil Armstrong wrote:

> Hi Tom,
>=20
> A late PR to:
> - fix environment saving for new Android boot features on vim3*_android
> - Add SPIFC support for Amlogic A1
> - Add DFU RAM boot step when booting over USB, fixing full USB boot for G=
12/SM1 boards
>=20
> The CI job is at https://source.denx.de/u-boot/custodians/u-boot-amlogic/=
pipelines/18322
>=20
> Thanks,
> Neil
>=20
> The following changes since commit fb428b61819444b9337075f49c72f326f5d120=
85:
>=20
>   Merge branch '2023-10-24-assorted-general-fixes-and-updates' (2023-10-2=
4 19:12:21 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-20231027
>=20
> for you to fetch changes up to 892e04bc965400772e1b84e6450a7919deca0e0b:
>=20
>   ARM: amlogic: ad401: enable SPIFC (2023-10-26 17:56:58 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--rDcufPUt2JXHl2qo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU8WvIACgkQFHw5/5Y0
tywdNwwAlaoPyHh3HTSbXyohw2fq1XQCg38haLkcJkx3Db1zWm/FlZ+QOcJGknOD
3bcSAyX8HOzYFTb5IANVQIkZpo+8MgQhLE+GRysNTq0xKuwxnAl6l+EtAtbuyENy
NPdY0aCLtnHU6jmDr5+OF4vayMsauUwxMBpz2mIt9jgb7gs2hJDJ/HRSI6mbw/HS
GiHcszULP/1mxfKaNMKCuhpcPw+6uj6tcyb3CXEPjw/5Ayp/FcjtcpGINEIoP9/z
oaZioBR8UJ7W131hwRDQxUIbLx/UdVICuiRFdLaGcmAC6Ja8ljFcniHNEZpbmgBv
+EooI5ikjRFArkH7KwpNZp/J1H2kiCq3aMmtIAS8RiGO2kAep2MEWnArqoWTQc+f
MeBOWl9WFuzZnW17f3TzGiLSly9aLIyoWCKKVL4CGfMSel3XFSs9KERpy2/xq16G
GpIb2t+oW7T02lNlE0mXSAxvQgM2ur03a0erq9L72GY5Xw8zdK8J0vF3184kwzxf
Y1rnYxPs
=5MBd
-----END PGP SIGNATURE-----

--rDcufPUt2JXHl2qo--
