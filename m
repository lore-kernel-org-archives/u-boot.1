Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E41E6ADDD
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 02:42:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 616608984B;
	Sat, 23 Nov 2024 03:42:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lUr7zqyM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B484E8984B; Sat, 23 Nov 2024 03:42:14 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C950891E8
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 03:42:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6d41b209858so17940376d6.3
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 18:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732329731; x=1732934531; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dREGbnZSJ8RVxEcB0DcjEYvUaYfZE76Je8JHHLn8IfE=;
 b=lUr7zqyMEksUssJDjcJjP7a4lmEve+1ab5jMiaUV2gpC4uHomJFy7A/s0WfjHZ/B/D
 zFzenZ7yLBIBU5/NPfNkAxDRhrmjCMRzMpD6e7q2oyhIlyUDxVvlGyNrnTjVxG8tiVvd
 ykiCAoE6NzhwYT1BRg+XjpFEXKtQIjjXsGadM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732329731; x=1732934531;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dREGbnZSJ8RVxEcB0DcjEYvUaYfZE76Je8JHHLn8IfE=;
 b=K3j7V1idSD90Uhsi/5zc0dlsRYXdliyOoEoM3B5OpSrRdeop37HiRiwqPU2RN2chNN
 fsgYox3X2yTsU63hLsjJSH5mqQupJvL2nCXjD4/7wDKrjKTF4gewaN3kbs6MP6wKsLWT
 nYNv9cNdIEvTVblhD07QIxDeHss+TpVfsNUQOrPINrG2efxiyzVLNGhDTyTIbqzePFT4
 rV2m3BHl00QzMyW7YE1Xzv5E9yWU8r1iGAq9Ar4bmET64X5/G8CTQ7qV5U710/41Mx5R
 KbMaaiE41SswMTvMBslprVziNqEExW5gVOKH+K9u4wlqrm6sgFzc830xI0t9ng/XbTBX
 DWSg==
X-Gm-Message-State: AOJu0Yz0j4yN0wb/95NJUo7EPbo1x4l/xnRgXoD/Beu66uc8HIYAEuO7
 Hn688gnVXzG2qyJiGUAoQ0iav0gR9T1BX8rzW+bA1VWhXu9WrjnsNQFFL0wPyYo=
X-Gm-Gg: ASbGncsM6eDKIOjVbwurGu6JthBO+NQEyXSghICOwxjwDDOfrLL+kzKzr3v0UhkNJGP
 l6qBlTlHQcsbs5DrEeOmanG/UY457nx+z7ppj+DsGlT4EV6IePDuusqmC/fi6nQyod/zKV1RXMy
 zSeiyYweAL9TaDaD6St9ZQ9YzmNxsmJd51mVuZc8TOhBzcYPZLtDW5b5php/FxUUf23XMMP1eax
 hbZDShUZXlMy5rU4lLjjytn65YeHSc7sy1+vV4J1lFuyb8o8A==
X-Google-Smtp-Source: AGHT+IHvUcz8gfENVK/C5fjMYoqHMipV8EbVMzJbnGRiOdxkGNNui+vuhC5g7UurpltYzbAmu0CPwQ==
X-Received: by 2002:ad4:5ba9:0:b0:6d4:21f6:a0d4 with SMTP id
 6a1803df08f44-6d451357443mr76600476d6.37.1732329730938; 
 Fri, 22 Nov 2024 18:42:10 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d451a8375dsm17258676d6.24.2024.11.22.18.42.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2024 18:42:09 -0800 (PST)
Date: Fri, 22 Nov 2024 20:42:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 E Shattow <lucent@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: Re: [PATCH v2] net: lwip: dhcp: support arguments for TFTP file
 download
Message-ID: <20241123024206.GS3600562@bill-the-cat>
References: <20241114172007.2074874-1-jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JMoXry7VwiNWiyOp"
Content-Disposition: inline
In-Reply-To: <20241114172007.2074874-1-jerome.forissier@linaro.org>
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


--JMoXry7VwiNWiyOp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 06:20:07PM +0100, Jerome Forissier wrote:

> The dhcp command is supposed to have the following syntax as per
> "help dhcp":
>=20
>   dhcp [loadAddress] [[hostIPaddr:]bootfilename]
>=20
> In other words, any arguments should be passed to an implicit
> tftpboot command after the DHCP exchange has occurred.
>=20
> Add the missing code to the lwIP version of do_dhcp().
>=20
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>

Applied to u-boot/master, thanks!

But please note, I believe this is what breaks
test_efi_helloworld_net_http now as we can no longer abuse "wget 200000
EFI/arm64/helloworld.efi" for example:
U-Boot> wget 200000 EFI/arm64/helloworld.efi
invalid uri, no file path
Invalid URL. Use http(s)://
U-Boot>

--=20
Tom

--JMoXry7VwiNWiyOp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdBQP4ACgkQFHw5/5Y0
tyzZCQv/TP5kolsxwC63wC2NA1Gqelw2Gf0vIhDI3j91kRZyiRPmnbOGVV+NYRVo
FB/4oIJ54Y6pOuwtJysSRejMdgvh5mMucGjGIGKWWqDcQwbCO4RkwGA8taAS27bK
UrcoFkGXIbU3x2rh8OIVbvnfHIg4FqHO2tDRTbdYGOFexnrvAySqlvD0jFFnjlUG
tn77D6paNjXIlVVN4tZN1r//awuAALFmctDmK+aANiS/+Re3kPmPVOIsvgpcBgPn
kPwS/2GiV/1sfmmoz3E66U00NCV81BhV1C4Wt8sgyocLkZD86gLjDpqdutHsi5kN
Qc6JX+BLaosjjN4iPC1eZYT0Gr/GJu+tL5ZsffLTkSKCqz3cnj9PHBoZ3gsbj1mB
xQiqj8LhHleLpse0wuUVXobHSDDTw6yxjacPJuZkqcW6wV9YXebKLTJsyUbLDcyo
yY1EDRk3EUyjLvCdiddg0NwzWeETLuj9T7IT53PKZlcngDGy5Aks29krXpAqZ5N1
VhYJmP5R
=5WmK
-----END PGP SIGNATURE-----

--JMoXry7VwiNWiyOp--
