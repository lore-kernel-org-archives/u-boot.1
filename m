Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362F5D11195
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 22:46:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B399989030;
	Sun,  3 Nov 2024 23:46:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JKsO5JZi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D1F488EE1; Sun,  3 Nov 2024 23:46:46 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 312EB89152
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 23:46:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b1467af9dbso279422485a.0
 for <u-boot@lists.denx.de>; Sun, 03 Nov 2024 14:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730674002; x=1731278802; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=G/qdvM9+ROKPj7of82XICgyg/PQwDfq4MFOdCOkK6wI=;
 b=JKsO5JZiiHwq6/qhjSc0pfs93bNQVMXezM19QpRtH1Un8LIIXi0lejESrSJdG63UhU
 H6sLNiKcV1y1leIHg3u6rT0zk6+1SemzrRwc4Dc0v8NjCECAHvBsh/AW9jx/9/2kEDqn
 O+Ayr147FWCm/dHN6e0shPDS/OVgUuLO8W1ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730674002; x=1731278802;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G/qdvM9+ROKPj7of82XICgyg/PQwDfq4MFOdCOkK6wI=;
 b=lk9GwPwP7BfXcttIsWt6BXJwIzBpV21uGjg3vsakV7I9dm2o/ghysyw1sueQYMa9A4
 66l+CiqFRoaKKW7cLrxHktuINiQ1Hk0UNEWmMvp04s3WypWYBbCHSOEMjUD4+f7uDge4
 Krw11i1cLm4BNCWAH0KeAog9whivLcQ4tq3+XtB/LTALZak+U0PJEH9Ho0LvXCzTq0Wr
 79jW/2UOQdipp+L5hHGtJKr3p4ZYKlbZcGS2Ibv9MVUDOE6W0Da41G61kgCYii1J8EWU
 LpF5U22Adw5qlIGkj0EmBKtnMV+H7omcX0Vtm8Wyo6fWkLvQGafi2726jyhHlc6AsbtX
 YPaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgtvobqzYZ+F+eAZshWd+AoNPqy8fCC+jOkZuHNgzH7O0y4OLFKXYqARYWGnsMFegIAybOics=@lists.denx.de
X-Gm-Message-State: AOJu0YzpLBIIN9Y/lTd7HGPgF5ZtgwjGOYUpoyusJEdjDh09uLS7hQOs
 HtHNfIRN/BYqsHE/eyIoTKCI6twuUN+frM4L5Wl7eOkYLLYAfTliK5enLhM+stg=
X-Google-Smtp-Source: AGHT+IHGgfQnLK/n0IRwbHVZg6y04ivAMjBeNl/U56J94qnBCMbCNhCjzYyZgaCKMPfv8MIT5UFE1Q==
X-Received: by 2002:a05:620a:2445:b0:7b1:5185:b4da with SMTP id
 af79cd13be357-7b1aed96103mr2593242185a.23.1730674000472; 
 Sun, 03 Nov 2024 14:46:40 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b2f3a85233sm368311785a.119.2024.11.03.14.46.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 14:46:39 -0800 (PST)
Date: Sun, 3 Nov 2024 16:46:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 4/4] configs: enable UNIT_TEST on qemu_arm_defconfig
Message-ID: <20241103224635.GG3600562@bill-the-cat>
References: <20241103224223.195255-1-heinrich.schuchardt@canonical.com>
 <20241103224223.195255-5-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9RooG4/SN4Bl0I4H"
Content-Disposition: inline
In-Reply-To: <20241103224223.195255-5-heinrich.schuchardt@canonical.com>
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


--9RooG4/SN4Bl0I4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 03, 2024 at 11:42:23PM +0100, Heinrich Schuchardt wrote:

> The lib_test_uuid_to_le test fails on 32-bit systems. But we never caught
> this in our CI because we never ran any of our C unit tests on 32-bit.
>=20
> Enable CONFIG_UNIT_TEST on qemu_arm_defconfig.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--9RooG4/SN4Bl0I4H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcn/UsACgkQFHw5/5Y0
tyyf9Qv+PGc+TjNfFOtw9S0vLO7Qu3mZ9Oh/undwqkwq4wmytPLTvPTfp/ee117S
ypKJ6SSQBx05+135SkvXFVh4kLc5XAhclzqrpPcJeu6HRF5Ac3O7p3/J/GeY2vNV
wFLohF+n93Bp9TUMiDuwTfDBkijGNI/9K5YlAgM6wyT/ne64XTwp04nBPWpT7gxU
EUL1Shzs0wnSXFpxSTVvGZOVTlTMHreqWVT8Sp68YXEMwZf13dcsmkxsxPhm3YAD
wM2GdCXvut2RM4WL/FMKlCRH0309/1uqLR9xw4NsJMsFWEm50YJ7XTVFacxIYt2N
PBgabsoTh9NH7f+2gqlfzU4OwAG9n419vEhidwQT0EoJHz6ijs0SWzLNPC7oHY8E
vbkViCq9uWs8bvTvhblS1o5C1d7DXQ3bM3lRPbK6XSQ+dpNkXH9jz26Qa1Kxer8P
a4aKs4izULh3QYuuKPnRVMn74cc7aNTfdAjfMSjOigJvZvr7wUgsgqmnxQdgany3
HHWu15QI
=cGlO
-----END PGP SIGNATURE-----

--9RooG4/SN4Bl0I4H--
