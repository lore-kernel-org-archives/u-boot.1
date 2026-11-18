Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCE460A2604
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 17:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QqqBryXN;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=YqbO0jh/
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 594CE409BA;
	Wed, 18 Nov 2026 17:04:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r6WtNusFv8BQ; Wed, 18 Nov 2026 17:04:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6BEB8405D1
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795021471;
	b=VK9OqTTPvRtlro+sJxpzQyXEkzdLO7XkhYk0l5pt5eVJ9SeaFqztJUbCSQQXPdaNXbVR
	 wlxjnyHsL4WA3vl11DzMwT6Cy4wOxBbMrtjRWXugw1jd0KJ57o9mh8HgGO7Tb8c1rZtJJ
	 sh8yZ7/Da9/Nu5PRpVf2K6V9dHmTw5BPFtaoCsa9oVzBNtk1nD13Py7g9MiJyMtdvojl7
	 bsjRDDvx0GpSRcK1PVtS30IGoACnCpnlV6N/bv7zDJWNWgEUqudK4FSKuzW3X+NA6N8V9
	 ELQmejA9WUZq6dXSz6xv0YgEr/kJExhyEOo7MGhpdp1p0oayelg1Kx1dZzbyARR8RIg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795021471;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=FUYg9Arin4J8vuRsOX+VTAK6DEeQrDki/VQCPDsilgE=;
	b=rdeWyzYdDGFakTfuFKeDNFLwllb1gTIK6OKeo3pLVsrPoxTIeM/uHiMeaifGWvOjcSU2
	 wGBq2kfL/LIlil0+EtsSIqCL+2fnmNDKBCKeEHNPK1hFpFhNzapRpOVrKxIgFJdSvhNvM
	 mYoa7/NTdOUbx22nVRDQ2SiLt8s2x4dkGuf2/cLYIngMpjYFmff7rCYgEtzKC05Eq7fdo
	 st+96/1AWahLzpAhnss+WKnA+z6to5u0o91Xn4r99pOFgDGLfECsi165O9h2wSMOr61mC
	 EY26csNJoyltgyu+WBZ2FTHFt3IZud1GxSOk6Jw7EgZ/dvuR7jlfiJWURGvbiSCUcig==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795021471;
	bh=FUYg9Arin4J8vuRsOX+VTAK6DEeQrDki/VQCPDsilgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QqqBryXNyeAryI2d2KmUbT9RKweSporHlQavuC0gSTEXlGG4fwpHCt8TE2tC9e7DG
	 V7mzm8ph6HcXoPs45yPd8r8DNlIJTOOiQ49uhZbSaal5eGIQMx8ditKHWQf/Xg+oVJ
	 iL704gvm9oZST4re/QeZPW2f2FeH5EcC/JGtkVotH570Fxb/pMcfOecJMRwEDkVlWV
	 g/y/WxY7sJWlaHTOtJjopePqjx+Oi7xYNaTJJKXcwcVYjwbsUr2qBjKeUOoAHfEMKE
	 YgzndV0TLWYLv7Nrr+TNeNkOPGG4DQl1f/a8UG8l8SExW4wuEBbsmqcy99v8YMYt3S
	 upwQTCRUfbpOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6BEB8405D1;
	Wed, 18 Nov 2026 17:04:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C09EF28C
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 17:04:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B23D080E63
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 17:04:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sSTI3_POkvNU for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 17:04:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B667580E6A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c35; helo=mail-oo1-xc35.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=YqbO0jh/
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B667580E6A
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 17:04:28 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-71ad047710aso833586eaf.3
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 09:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795021467; x=1795626267;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FUYg9Arin4J8vuRsOX+VTAK6DEeQrDki/VQCPDsilgE=;
 b=YqbO0jh/y5QRk30cwiovnGJCziFIl0rop2Km5SwgyEcLAXRp8i0jJDD0UV7+Cdk9jm
 FaADKYk79+NzlE+jBc5PFDrXbbUlRVl6C5lTAkaJQDPIxwUMCWOPnC+9Hn7v0+b5vheB
 2lqfc7F0vomSGcEyrlOwRYl3LyqkURJ9V/fkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795021467; x=1795626267;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FUYg9Arin4J8vuRsOX+VTAK6DEeQrDki/VQCPDsilgE=;
 b=LpHGQ8OQB0oXYOmgJ+4wJe5OS3uXwkZqucf6+BlTWMpoZFXVLAWHCEMZzwOpRaz3Ul
 oVZhByhjhu6LdTHIqkIi+W1nj9IxKUZn3KGrgygk0DkTkfiZ9JspVanroKKExmRkBpah
 W2m7odexeiSbC5r1+L+XS/yuCTjTbggAaHbrMjfJnIZKXLqlr+zbXKDGjBNnDx5BAz2v
 ifYX9s5qNZjnM6Q4qNZ483gCBNyigri/LhV7CvwMR4cRu4t012EIyZQCFwWK9ALj4XBl
 40Wmrb38Y+/3UWwL6921ZzllUonePGvpeopw1HOwNBV/9svgLdehfq9prsrnOomttYZ2
 aAVQ==
X-Gm-Message-State: APuU4Z+OoEBonGDJcnfXDJ0R6HNEBtPHt79dRt/Yrh6Ek9u9QlxyXyUB
 rKD4o3oGbwgBF2sTlEWNkB3PYlfw2kd+ECVs4JwEfBG1+YvhrRd2y9ULFu/+1ANs9B4=
X-Gm-Gg: AYBFou2VaJp83wFg9WKwckoSMQd4oKCi7594k59K24DFx2vuSldWhg2DLgnz1RZoi8W
 f8Iqlem/IszbPtG3AJXjDmLBvUH2lPw53ekBwq9mc3Ix7oiudbFI0zV0A1QRTt3WnJP6Q02XcJZ
 uuVDA1OSDCZWtcxGKiVU/4HRtwlAQwpiCI8LNYvVIAGEt/aURSzYA4aozPdWM7HQIxVUzqVQ59G
 10iE0SCIlSpsOMJw08D4utFJwMMj6jUAUE96bk6w9PEDlnYZQx0EweCmBNDuEg7nnlhrcLg9URm
 0nqK9R7z79Q+kKXE8PPajuHOwtMsng/E80sPd82Mab4ymkrovwKp5ef9wNKG/0/KHV2MFGM3MBp
 +zXGq7gGEYycFER/yNymFILKG84NNSBfjJUxl709QYekQVtNAPLOjq29XYfNCTCSEMEZkxdtJqb
 AH3hZKWcoD89EUPTSALOM9siJNDIXlsQ8/cTGpQkl9VFzf5IhxLUE75MlBZuTOi21O5qWuSAdYB
 P6TsIbbYAGEJUQ22gY5Gc+CF7f+HwnDcEQ9HWMTKUbZnjfNhJBFNWhSUJYiQ8wKZdF+Kd56B7at
 jnuam+ZF0y1cKQq2E16vrVzR1Pd9PkwGEwjim36u1LmY3ly8l/n7YOp3uPhgiImucAmBr4afHwn
 sO/m0uJ/moDm5BCPsPHNWdWRptBOrNhfpvHpKqY0LxI7murxse94PSOb+eY4TBb4Efrg6kjA1Oa
 ed5i7e5kabV63XW1smP39MzRFCGQVl4KM=
X-Received: by 2002:a05:6820:f035:b0:6f5:6ba1:aeff with SMTP id
 006d021491bc7-71b185ec30cmr2643466eaf.37.1795021467045; 
 Wed, 18 Nov 2026 09:04:27 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4b74560e8b7sm2613382fac.17.2026.11.18.09.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 09:04:26 -0800 (PST)
Date: Wed, 18 Nov 2026 11:04:24 -0600
From: Tom Rini <trini@konsulko.com>
To: CVD <cvd-mailbox@cisa.dhs.gov>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Subject: Re: CISA Coordinated Vulnerability Disclosure: Das U-Boot -
 CASE#740545
Message-ID: <20261118170424.GY554944@bill-the-cat>
References: <SA0PR09MB7017E1D9AAD585327316F230C37A2@SA0PR09MB7017.namprd09.prod.outlook.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="C8hZF5Ynlie3cU1x"
Content-Disposition: inline
In-Reply-To: <SA0PR09MB7017E1D9AAD585327316F230C37A2@SA0PR09MB7017.namprd09.prod.outlook.com>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--C8hZF5Ynlie3cU1x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 04:56:37PM +0000, CVD wrote:

> My name is Kevin Harwood, and I support the Department of Homeland Securi=
ty=E2=80=99s Cybersecurity and Infrastructure Security Agency (CISA) Vulner=
ability Disclosure Program. One of CISA=E2=80=99s responsibilities is coord=
inating the responsible disclosure of cybersecurity vulnerabilities affecti=
ng industrial control systems and other technologies that support critical =
infrastructure.
>=20
> I=E2=80=99m reaching out because CISA has received a report from a cybers=
ecurity researcher regarding a potential vulnerability affecting Das U-Boot=
=2E We would like to coordinate directly with the appropriate contact at th=
e U-Boot project so we can securely share the technical details and work wi=
th your team throughout the coordinated vulnerability process.
>=20
> Could you please direct me to the appropriate contact or product team for=
 this issue?
>=20
> Thank you for your time. We appreciate your assistance and look forward t=
o working with you to address the reported issue.

Hi. First, per the project documentation at
https://docs.u-boot-project.org/en/latest/develop/security.html we
prefer public disclosure instead. And second, I (at this email address)
am in the VINCE system already as well as the "NG" version of it, if the
submitter insists on coordinated disclosure. Which in this point in time
is generally a terrible idea with everyone throwing both frontier models
and open weight models at everything to try and find security issues.

--=20
Tom

--C8hZF5Ynlie3cU1x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCav3alQAKCRAr4qD1Cr/k
CvS3AP0WA7fCiSQWthc4c6CCO9xlbpB2DvknRpCG89RLK07QKAEAw6Z0m24PeCWr
KKIv9v8WdvgRFBGqQuC9Y2XT00YDRw4=
=X+JE
-----END PGP SIGNATURE-----

--C8hZF5Ynlie3cU1x--
