Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F55D11141
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 15:46:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4526C88E41;
	Sun,  3 Nov 2024 16:46:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BtAUrL2R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8C9588E41; Sun,  3 Nov 2024 16:46:26 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7351A88DEE
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 16:46:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-83aad4a05eeso146098039f.1
 for <u-boot@lists.denx.de>; Sun, 03 Nov 2024 07:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730648782; x=1731253582; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rYuhAINBplXNRzl6vmd/f7dHuW+6BDIGPoqd693P28g=;
 b=BtAUrL2Rr+F7vhSWgz54ngVSDxp0wdZkGZfpdYaU6vxgb3PsiyZMPnuRg7kRctW41O
 9B4sP/iKXp5OVfv9ppc+NDoXXU41k4M7Du4Adj4lUgMRzv50YBm9sD4tgJdczUIVVsNo
 qTzeCyFQZHqZx4nwCi3PvEPSkMyst+Lp9DyIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730648782; x=1731253582;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rYuhAINBplXNRzl6vmd/f7dHuW+6BDIGPoqd693P28g=;
 b=llH3QhwrF+nl+oF/fwD4mw1d8/DwyJs2OJ412nbQrk+A3+yrawvcMIh5VAgsWOMPpk
 GVyuS9YCD84Wo86MyeqcdC9EcWGTdh7HbQPNci4wJ10aGNjql2VuoDpr6QLwwyURreWI
 JH4G3KyRkpOhoQVr4SeFTAKrVXM0eM2NiTCBwo3cs/SgaC9ydsOP7tbpAXag0WrpGJ30
 HLkPHlGwAKiMo0EqmzLrCUrwF/dGc0NiXeOGHXO7dVHIbyLYtdDbZkXCxfA7jXl/9tc7
 Sft+AJcLHXqIPrGTlsGcquLc8pqRMyNQf6Q3tiY9s5dhkyj4AeQWDW4nOdks73CSJQLl
 nGXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMEA5Ar3R2TmAVss379cQ3tTnzjLwg9nGXqjINg7a9a9BVC8o1Rwa6lgezWmxJj5Vr3a9grsc=@lists.denx.de
X-Gm-Message-State: AOJu0YxhTLOoaqsTsObLSHebbGGt2X9By/lArF2mL0DtgwWDP6t1m5yF
 i4Hf5leTdnI7gYCMeA224L1UA9veu9hLws+RBQe8m+HDKm/v6lO18a5VmFhXhJc=
X-Google-Smtp-Source: AGHT+IG6EirT/pxRvas3yl82X/E02aT8LeTlLX1qefnhnYh2zueoELeo+pwTuwe8vR3rkQ7uT+OyYA==
X-Received: by 2002:a05:6602:2cc8:b0:83a:f447:f0b9 with SMTP id
 ca18e2360f4ac-83b56712446mr1924493739f.9.1730648782152; 
 Sun, 03 Nov 2024 07:46:22 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de04ac93b3sm1582660173.162.2024.11.03.07.46.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 07:46:21 -0800 (PST)
Date: Sun, 3 Nov 2024 09:46:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Subject: Re: [PATCH 3/3] configs: enable UNIT_TEST on qemu_arm_defconfig
Message-ID: <20241103154617.GA3600562@bill-the-cat>
References: <20241103071200.82853-1-heinrich.schuchardt@canonical.com>
 <20241103071200.82853-4-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Aw0K+Sd+FcN0G2A4"
Content-Disposition: inline
In-Reply-To: <20241103071200.82853-4-heinrich.schuchardt@canonical.com>
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


--Aw0K+Sd+FcN0G2A4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 03, 2024 at 08:12:00AM +0100, Heinrich Schuchardt wrote:

> The lib_test_uuid_to_le test fails on 32-bit systems. But we never caught
> this in our CI because we never ran any of our C unit tests on 32-bit.
>=20
> Enable CONFIG_UNIT_TEST on qemu_arm_defconfig.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

And it would be good to follow-up and turn it on for all QEMU
defconfigs, I think at this point we should be able to. And if not,
that's a few more unit tests to adjust.

--=20
Tom

--Aw0K+Sd+FcN0G2A4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcnmsIACgkQFHw5/5Y0
tyzE3Av/f+rBu5wYze4K58Yycf/aPy+53HH1HBCnE0YDwFez+h3eR2hhrtaQcD9x
o/secwo/uJmUu6JwKOqeZhpNUREFfzirUDgz3ZkqhF9KSbjy+v9AsPRlEZGVeupt
Plc31Mb0wjD7C2GHSLCtvavJn+a/5u8bOLF6e2oVH/9EeWcMXSB0tcOausdFkb6f
K4ee/ohLC2TcLwXXxakNaQ/7MtaPHqhJxTlAOkj9CB6w/Z94cOiLGZZTYMQ+yMMr
oQHWHeb6DbxQFV9STFsTH51Z8KEk+GQNcJh79ygjJUgPGMUIUxT2ahrqYfj87dbO
QmggcdIfvd7N1rZxENFbpQaWHO6ZBHj80k+ZHya5kNzdm0C7nD4YrqoGQ2QpMTkY
QrNc1AUDhheUhWXQGK3dS4nCTp1DqOiEs2bG1hEKKrz/tSmqSl+C5GOlBdI272yI
hmAMN9sTv0fxYIZUoMDrmsBWc6L9n754c8GRSCMQjp1hWGMZBkVvf0v3l+ofPoBI
Nr5BBAa4
=wQRw
-----END PGP SIGNATURE-----

--Aw0K+Sd+FcN0G2A4--
