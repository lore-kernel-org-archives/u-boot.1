Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B018C4706C
	for <u-boot@archiver.kernel.org>; Sat, 13 Jan 2024 00:40:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A4E987751;
	Sat, 13 Jan 2024 01:40:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eWtYwaI6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25AA787883; Sat, 13 Jan 2024 01:40:35 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1378785E44
 for <u-boot@lists.denx.de>; Sat, 13 Jan 2024 01:40:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-4299d95547eso26199471cf.0
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 16:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705106432; x=1705711232; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=f3p/X0CtN16HN+WrI39VzEfEZqO8JGm+dGSvksuUNDs=;
 b=eWtYwaI6SAuzXf71SOFsErQGk43JYKaR2kihQzPB83Yh36n9ZYX4Y2kw4ajK7uMXc2
 ml9DzGtEgHvpcATQlrP5Jzgg+qCXGVjOxCfbgrcaUnx6FR6BpUl+MgJMT0ecyxYEb9Yl
 HJ2dLFd2BaL9YQIU6j2kVoZSYhkDQO6A6fdZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705106432; x=1705711232;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f3p/X0CtN16HN+WrI39VzEfEZqO8JGm+dGSvksuUNDs=;
 b=mtmUeV5bQWpd/tJrAo+DkZSNpRRnDx+nxXAOjdNJS7XUhBXByNDqeN6d8F5XFVd/PB
 7bhEeDzaMRe2i4v1LIDlaPOvQrHgrXwSE1y+UbJTXMnistTBYuk2EOpim5y0wwkO0n0Q
 OsCN+Nq3gwlIXxatBIrnIdH2HMQeBl8RyFN1U/GFjS6KDMtnsPOn2HguRVn1PLv8hc79
 0q3L8Ub4wrW731iNbG2IbABG/a2NK1O1oehTkP24GHUSg2bMYPdE/6EerWG880iBIeMg
 SyYASVZmG3RI1uho81AXVLLyLkkgBJIPvEPRSF9VvBg5qMjVNN8hkm317yo7t3nYyaya
 eOSg==
X-Gm-Message-State: AOJu0YzWW1BhYUPpcslsa6BuAfiSgQ8mIuUuyBTIj1bbEKMLC75knfpg
 pHO1oDJ3LivAG7IYR0HAiN3R4G8fialrHQ==
X-Google-Smtp-Source: AGHT+IFeyrpebhNL3ybKGa7izj3p5d081Cf4fYzYFUnODCp/pMcJepJ20NCbrz4FVLKD5OeCcO2EiQ==
X-Received: by 2002:a05:622a:34e:b0:429:d94a:c016 with SMTP id
 r14-20020a05622a034e00b00429d94ac016mr505869qtw.68.1705106431536; 
 Fri, 12 Jan 2024 16:40:31 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 y11-20020a5b0d0b000000b00d974c72068fsm1601721ybp.4.2024.01.12.16.40.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 16:40:31 -0800 (PST)
Date: Fri, 12 Jan 2024 19:40:29 -0500
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH] test/py: reset: Add a test for reset command
Message-ID: <20240113004029.GG1610741@bill-the-cat>
References: <bef92835c3b6f0992382673a661f8390dfd4d06e.1704949216.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Uv25CmUMs6gw+CHP"
Content-Disposition: inline
In-Reply-To: <bef92835c3b6f0992382673a661f8390dfd4d06e.1704949216.git.love.kumar@amd.com>
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


--Uv25CmUMs6gw+CHP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 11:10:01AM +0530, Love Kumar wrote:

> Add a test for reset commands which performs resetting of CPU, It does
> COLD reset by default and WARM reset with -w option.
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>
> ---
>  test/py/tests/test_reset.py | 50 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 test/py/tests/test_reset.py

This fails due to "modeboot" not being set.

--=20
Tom

--Uv25CmUMs6gw+CHP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWh2/oACgkQFHw5/5Y0
tyw/oAv8DeReTXNLse0Tk8hm/y8wA+Kh3mmprnknddisrx6b6Kk9uKyp3k5rkrui
qeBEaKuWL5+chUl2KIZ9SgvFD+g+2IO6JsS+MVaL+N4qcDS8Ip1jVT5DXQZGWfW9
+HwlUkEZgJ9zUbgC/BseW1MJLfoyKmRoaLara6hhHO4dG5w3Ulzr1TVvYrpLSsQP
k+TM5z021UFyoOyaV7BlFvK/ni3UOC34U8T8CLwAK1naFPH0TVgQ0eQ5+23+2724
tAHWcAa3cQ4WdeIvxKqQUmJ+SQD5kF6wmHXfgguuALcxvadGgNTvZ5q265A69uB7
cL+35BCEJQwfWA4Hcmw4iHsoRS6ZHgyfx3q7sXmO6OZE1iKRRKtTAkKm3Ad/CGrp
p0KuP5RJYp7MulnvTEO+p+Li/AOphpLAa5awm8LjvDF7YwFlTlXfoJtAC7xThLSx
ruu+3d9kMqqe8uT0aa9skwiyzCWlal4j2/7UAk3zDdbrKBOQy/+dKOtdoTink2m4
PzaW0jp7
=CqxY
-----END PGP SIGNATURE-----

--Uv25CmUMs6gw+CHP--
