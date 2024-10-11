Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1383D24470
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 17:34:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32F56893AF;
	Fri, 11 Oct 2024 19:34:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ameW2ngt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C968893AF; Fri, 11 Oct 2024 19:34:35 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72262893B2
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 19:34:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-717cf9c6297so869867a34.1
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 10:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728668072; x=1729272872; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lJAxpQEqy1nZQ0IfO4aa5lIxYkzmjT/n10oow3ruTXA=;
 b=ameW2ngt5zHWlDgMbNNKimpljF7lnHsnIpxfuHFdG02bSCeFvf9cgiZTxSpKb0IGqf
 sWueFNwfJwfelLsVGR0D1M9AkGPWttvYx5foz4jkYHpsmF3TycftNh9tbqiOu7hvOucU
 qu97NS1sHafNun0s8OURHEXBFgOahOY6YPegY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728668072; x=1729272872;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lJAxpQEqy1nZQ0IfO4aa5lIxYkzmjT/n10oow3ruTXA=;
 b=rkqzbCsozE+hxzAzF/ifM2y9NojIlKWsFQ9JJvy4yyDsx1oCM5N7Zvon1BJT9KLLPE
 K3MaIEbann4E36KbyZwYfmZSacN0UtgPC9Z2I4ly5HsvNrmpMzgwAHAqqB7I9fdeeJxG
 zIPHvD9dBNRBEneEEVzL7PpbB5o0gqFaIsxRIyvEiK179SEZP8H3Byad5Nt5d9PpROvr
 sLDo4MjNSxITdXyiG2xAMi3px3F7em63+pLD7fkPiAeqvN0GOQUPyPOULLmany9MC6S6
 mJTCN/WHP8XZyBy+34UOBGeK8BWHX5E2ToCMwBFlTPuz3EQSeMnkM5yFhWITnEBQ5igb
 GuZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtILx0bIAYj1tnorytFBMOmEjCFRbIzXcnD5lzlq5aGiKFgMMkMYDwptkgb9HrbwLRFLO2XxM=@lists.denx.de
X-Gm-Message-State: AOJu0YzqYECuWCtgzDdxuel2HF5RtqQ9in5Q3xORWTtB2CV5f5iKHTpS
 D3T8AcfvejFPJ4dSBCL0R8T7q6DLtqueEYybnZeFUvbgz8uC9zfx4b6IxlRche8=
X-Google-Smtp-Source: AGHT+IFV3QkTiv8YaYDmnEbGsLqxbRgCp4n8v6in9omXHQBfqx2vQ9DHTAfPp3KRqlKXfYMxMpXWEQ==
X-Received: by 2002:a05:6358:783:b0:1bc:4589:dcae with SMTP id
 e5c5f4694b2df-1c32bcb749bmr187399455d.21.1728668072213; 
 Fri, 11 Oct 2024 10:34:32 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbe85b9545sm17310646d6.57.2024.10.11.10.34.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 10:34:31 -0700 (PDT)
Date: Fri, 11 Oct 2024 11:34:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc: sjg@chromium.org, bob.wolff68@gmail.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/4] aspeed: ast2700: Add Caliptra ECDSA driver
Message-ID: <20241011173429.GA527278@bill-the-cat>
References: <20240927030726.2211297-1-chiawei_wang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hzq3eDtTLx0h9PVf"
Content-Disposition: inline
In-Reply-To: <20240927030726.2211297-1-chiawei_wang@aspeedtech.com>
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


--hzq3eDtTLx0h9PVf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 11:07:22AM +0800, Chia-Wei Wang wrote:

> Aspeed AST2700 SoCs integrates the Caliptra secure IP, where an ECDSA384
> signature verification HW interface is exported for SoC crypto needs.
>=20
> This patch series firstly extends the FIT image signing/verify common
> code to support the ECDSA384 algorithm. For better convenience, the
> device tree for ECDSA public key storage is also revised by referring
> to RSA implementations.
>=20
> After the FIT common code revision, the driver is implemented for
> AST2700 to leverage the Caliptra ECDSA384 signature verification.
>=20
> These are verified by signed FIT images with the algorithm "sha384,ecdsa3=
84".
>=20
> v2 change:
>   - revise the commit message of padding check removal for better explana=
tion
>   - remove redundant check in static function
>   - revise errno and error message as suggested by Simon
>   - collect Reviewed-by tags

Please rebase on top of current master, thanks.

--=20
Tom

--hzq3eDtTLx0h9PVf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcJYaUACgkQFHw5/5Y0
tyyfWQv/X17krqhqEL67RlRMMuT/SdtOZ3GOQAM0RCnjnd5Uuq65IbdLZM9/xjfj
kkzpfVv7lvs6qtVGFfDCvmEdRnV7xHnHhx5dxg4WkUz9F1ascbCnSPmoAYLHBILl
igsJqx9NzKeUIhQhyfdXm/pmE6egxpMeVXmIWfrbSMMvexc/i32jZvtFYI6Fz5Cs
LNrvd46+9ECZIqQrEN1YBcvtUczwE5rOUMYVUJNIhJs79wJAaTavh7BU4T76f6OE
7g4u3NmW8Nyi6IS5XGml65S6XKwbN3ocDjwMLjfP4XkbX4iIgiQrppPdp1kakTee
oAb3se823PnvaiM7rclgvD4pQ8Vl0EwAT+8X0NiX5tI9LAYMw32Fg8gqdXqdWjeZ
9ESaC7d+9qCo89skADlx1CYkdjIn//jK6QcsJa8vqNKgoFkj9fOtZzydcRnbpkxq
J4VvQffH4JNPm61JNA01/0e95h5YFjtc5akJxOyLExPPITrzQeJnTih2y58HuMbY
obnj+SVc
=byxp
-----END PGP SIGNATURE-----

--hzq3eDtTLx0h9PVf--
