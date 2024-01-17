Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C1CDC47422
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 19:36:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00261879F3;
	Wed, 17 Jan 2024 20:36:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ptKUkdwM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE9ED879A9; Wed, 17 Jan 2024 20:36:48 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04EA1878B3
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 20:36:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5ff6245c1deso14792247b3.1
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 11:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705520204; x=1706125004; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2k8X4RYarm6g5xof2GZCC2cPfNfrF6lDCS/WWz7CTfk=;
 b=ptKUkdwMz5xArjK9XOQLBGlxVOMGRQ4jMz8iPchDQ6pyCKHIohtTA8NPCiZFoTvLjA
 TrdKpy4nJSUY7vfWKVl9idp4YfS9HppzRSm6uwrQmnnczapNDbm22t2I9YOd7T7vZTvD
 vjP5nkFzS1z0Dv47N0YMnVFZqp/kFDuEsS31c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705520204; x=1706125004;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2k8X4RYarm6g5xof2GZCC2cPfNfrF6lDCS/WWz7CTfk=;
 b=S5r5x/vxLb0gdXnq5xKOA2xjaBHvmaAb0oLhbnrDIiEPu0O+sMi6o2i7kJWliT9gdU
 TZqqGQQw7HXU1BIol5xDQ6DClrlWQSU2Rc8J0BMqQc5Eec+zmdxkWv+vA0d0CQjs+nex
 +qIclwBYmA6AieoQnlzDFRBuz/ZdTJTHBp2sTWKs1OMGMJkfnqr7xeD+Br1czVlkdU52
 vx3Pe9JhO82YHo5mR+VFTli4Og6X4B3M3TOK4mHsiGvBCVuluFR8qh3Zcn0LyTdOWfkV
 OvUIFAtEft2pX7WG1/otqR4IWxwmka8pesgtOMYaYqMsHYn6qEU+pxazsnFUaX8drp2l
 PXbw==
X-Gm-Message-State: AOJu0YzS3Tc7wDBv8VI1ybqSuC2mX3aEHi3LauLcor2LQOa2dalNyJ1Z
 zFVYv+XI7orWjpN01R2UB23HbAxzhEbG2Y6dEzScD64TSfM=
X-Google-Smtp-Source: AGHT+IFnQt0BTktgjBca/GTP1OttVUpM+MxWrj8cAPDKiV3Eg9PQEwv1xBu62HArObZlZM3Uv58Gjw==
X-Received: by 2002:a81:4802:0:b0:5ff:8409:f468 with SMTP id
 v2-20020a814802000000b005ff8409f468mr23206ywa.35.1705520203724; 
 Wed, 17 Jan 2024 11:36:43 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 s5-20020a0dd005000000b005f9673cb763sm6093647ywd.126.2024.01.17.11.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 11:36:43 -0800 (PST)
Date: Wed, 17 Jan 2024 14:36:41 -0500
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <monstr@monstr.eu>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [GIT PULL] xilinx patches for v2024.04-rc1-v2
Message-ID: <20240117193641.GY12635@bill-the-cat>
References: <02d7eee4-f480-4abd-9610-3ccff08c268e@monstr.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WebCiQHtIwERnALF"
Content-Disposition: inline
In-Reply-To: <02d7eee4-f480-4abd-9610-3ccff08c268e@monstr.eu>
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


--WebCiQHtIwERnALF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 02:53:40PM +0100, Michal Simek wrote:

> Hi Tom,
>=20
> please pull these patches to your tree. They are mostly targeting DT for
> fixing issues against DT schema and SR IR certification. I can't see any
> issue from buildman or Gitlab CI.
>=20
> Thanks,
> Michal
>=20
> The following changes since commit c5e461fbf7cc72f0c1c8a79226b6a5170e56cb=
4d:
>=20
>   Merge tag 'u-boot-imx-master-20240108' of
> https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2024-01-08 13:39:43
> -0500)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-microblaze.git
> tags/xilinx-for-v2024.04-rc1-v2
>=20
> for you to fetch changes up to 0a4595b538cc601563e828270ca822720c6eb6fe:
>=20
>   configs: zynqmp_kria: Enable CONFIG_OF_BOARD_SETUP (2024-01-17 08:12:21=
 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--WebCiQHtIwERnALF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWoLEkACgkQFHw5/5Y0
tyxeTAwAo4G9MZG27fRm9OUVMsO1/ic03qelZ0/qz/xIuq3uasQrSYptQr2vz5W0
KOfL5qNIMGEvCa6HM0S6T6cwyjfJTrPsyolHTuWJnEyf64JdQP+KvalxhA3fSOxs
zOIOwisEg7QvzMs2vTQMssdj2wBXGUV1lNU9u8bmsLvwXNaxPBwwfUJ21k+Qbhhb
NHSeqgaD9F666LjLzhGkWmUUKAiBB9uGJuxC8SYNFJHkHQNhSMM+1NKXa+NLk497
Bnb5ruV+dH9QfwOmVFe3D5k7DmGRUHgLD5lYdlrQCj47LPkc6IQ/zveQZXLsoEtL
zxQ74QCn85gUm9XnT4oTaorPxsi0Z3bNCh7BUeFEZTf1My9sNeKuxErIwVJqw4Cj
sTAs4RF468izvhA7aLrbSlvXUDnX2ylqXUDwfcKvmPnYmPHPrRGGSBoJmN4asd05
LNRSHHGWy3te2YYqlnI5WeooXdqucJSMB9F+Cz90aNTMGtSNbxmoCoLDsDZpPl+H
Fz+iMxl3
=dBM9
-----END PGP SIGNATURE-----

--WebCiQHtIwERnALF--
