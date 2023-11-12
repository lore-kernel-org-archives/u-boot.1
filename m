Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4197CC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 18:23:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2131F86B75;
	Sun, 12 Nov 2023 19:23:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EBWgOkGS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E69A987036; Sun, 12 Nov 2023 19:23:09 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09C6486F44
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 19:23:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-77ba957043cso258237685a.2
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 10:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699813386; x=1700418186; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=e+lerEuS9BFEmRZC19T3yVV8cWASmfOyNFRPz7yJ3O4=;
 b=EBWgOkGSnvi/w0Sj0zv3tuJ2uChwUIt5whYm/2qrBedwQ7dfgTt6knN56hudQ/CZEb
 b4p+rfszTXddfwwvxi/8KTrl6Iff6/gPcbqsetjMLWCPXBodDsW/d57wFiJwGhGO2Yef
 itz9UjD7auHK942b3I7iU1RcsB5nkf/2lH1hE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699813386; x=1700418186;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e+lerEuS9BFEmRZC19T3yVV8cWASmfOyNFRPz7yJ3O4=;
 b=t6TziXEeOA4I4tbK2BiDteKSOjW4DO4GoUEwC1WaH+5T97VHjK0vqiUZH/EOiF0T6P
 GeWCyS3Nzg70jYBi6bII9nUfKWTOXTD5uAjRIiu61IkCYu0dMrE6bqZqCDIqppPtEGhQ
 DDDleXzxN6OKGPTZt30iR+URurULWARHTmn3VqK31ZuHWY2bZMdA/YGFxHXdP9KoZJxM
 MfOhLaaoHaYKnHn67IBEeyHOlzHsB2T3rkDZEI2+a5GL74W3fE55ZdwjL9SrKjjRodsC
 Q0lZxyCsfwd8GShqnO3d7XdjiqLIqVnogYOBd0JBbWzBMHtY8L3cO8pj0w7tWSGm93cZ
 IyIg==
X-Gm-Message-State: AOJu0YxTP6cGo7Q7QLG0Pxy7jAzLhvinpR6J9eoJagvN4pNaIJ56Yrfr
 MS5gXptBOwyB3DQDWe3KpBN1YaiSsb7PwxdstmJTnQ==
X-Google-Smtp-Source: AGHT+IEHh3psMr6ZoBBjvQN4zkup4J/9cAF8KeV3MX5t02KfSeeovUpDgxOG0qymIjI9hMVt/Syf6g==
X-Received: by 2002:a05:620a:2889:b0:774:13e:71cd with SMTP id
 j9-20020a05620a288900b00774013e71cdmr4969380qkp.56.1699813385844; 
 Sun, 12 Nov 2023 10:23:05 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-8be2-1560-728c-e0db.res6.spectrum.com.
 [2603:6081:7b00:6400:8be2:1560:728c:e0db])
 by smtp.gmail.com with ESMTPSA id
 su7-20020a05620a4b4700b007756c8ce8f5sm1293119qkn.59.2023.11.12.10.23.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 10:23:05 -0800 (PST)
Date: Sun, 12 Nov 2023 13:23:03 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>,
 Dylan Corrales <deathcamel58@gmail.com>
Subject: Re: Pull request doc-2024-01-rc3
Message-ID: <20231112182303.GG6601@bill-the-cat>
References: <a9431d19-29e3-4f3d-99d5-8a737085564a@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hgt2LtT8S91iar0r"
Content-Disposition: inline
In-Reply-To: <a9431d19-29e3-4f3d-99d5-8a737085564a@gmx.de>
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


--hgt2LtT8S91iar0r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 04:34:49AM +0100, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit da2e3196e4dc28298b58a018ace07f85eecd16=
52:
>=20
>   Merge patch series "arm: dts: k3-am6: Fix Ethernet/DMA" (2023-11-10
> 15:25:47 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/doc-2024-01-rc3
>=20
> for you to fetch changes up to cfaf05839f86ea387786c841c7f578be0fea247b:
>=20
>   doc: typo 'form' in qfw.rst (2023-11-11 01:44:09 +0100)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/18517
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--hgt2LtT8S91iar0r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVRGAcACgkQFHw5/5Y0
tyyr3gv+J18kbjgWLxZVs36ishKSc92coAxsGV+ZH54z3fQ9Lso0S53JPl6DgVUW
J+70E7endinzgtG5MXeHNVbD3CDs4sOvZ0qmviPfKgBG/37FlnRhFhL2tjFHv6AS
VzyFTWS9ZnhVpMA3eGggNZ3XiwdMgkj6ivnmCpkzsxGb7UsCcuFHkMN5Be0gkPqk
8860jUs7FsC6DUguYSBi3DbaMhXMLLm9JOixBV3Jg+773DZhM/eP/4jbLYVRswb3
kWXgVF2YGulLuClDn4DX9Xj4VtG03DW9xakyf62Tlc5cfsGVMFdxrIAmhUs69ZVO
39zzc+uavd5Pp2vb7IsqVZ31mtub5Df/cGkmWaChnTnhnJTR9OBArYIWxHVbprNp
16khQbrLR9Tr0jgHvOWd/VHdiAZQ9PqUO+1OFhUQY6aUqafjB3r0Dr6jI0axn8xe
3PsXGNW6ehgcgjZCV9A+dmyt7VYF6gete+aPpr76Ezuvg4IAyTpkolwyxPrDVXJm
2PzZ60jS
=hSu4
-----END PGP SIGNATURE-----

--hgt2LtT8S91iar0r--
