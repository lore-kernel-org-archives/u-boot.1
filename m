Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F5EECD13DD
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 16:57:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31BDC83CB9;
	Wed, 12 Nov 2025 17:57:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="o/z4/gUI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B92FC83CE3; Wed, 12 Nov 2025 17:57:14 +0100 (CET)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A077483959
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 17:57:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-3e0e4601faeso582555fac.1
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 08:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762966631; x=1763571431; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OlFW9m4Jvn6X0u19bJdk+v3gCRKm/7iP1oTbKVQ4FY8=;
 b=o/z4/gUIV9a1LdnFsZb06sWVswM9Av9rbceqEYNHBbnFU88sXeAGFvLjEXETbAb7nQ
 BbSMhgNvmX4pncOV8hJ6qUoPVE8nlxX8JDpvE6GavRuXynwpZbkBr2jEgagCjmdgqUXK
 Pglg+/zrT31L22gIK06aDXXU8JtPnk+LtXnfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762966631; x=1763571431;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OlFW9m4Jvn6X0u19bJdk+v3gCRKm/7iP1oTbKVQ4FY8=;
 b=HujWLc7Gzz/NzguE6+nWfpz52H+ghiXsZRVQMXEjKvz1JCyz1G20xSaoxrYTfH28u5
 sdV5eIjfU1Tt8F77FPSYRzL6jV8UMrpUQsEgTmOKHotsXJe3QcVZPqe/WZnezz7Dno/0
 MTtgqiJPku4ux3nRYhVUUGMDkZ2unnxlEl7XGG57XLSkBUCmwbXdiW2DmGHU3Gji7ZM5
 LnzO6wzCC0tt7RgQnOZi3TaF3FEsMHvnX1OekEXzmQTZgb9kuz6S1l5UvwpZcGwKj/H2
 RZHddiYkVgCYABb+a7ZTo9cNVTajNCoMzTrLJEkJM5WLuZfxGD9LuwrJsSP/HpCRC8dQ
 Cp/w==
X-Gm-Message-State: AOJu0YzzVPRCKk0JjM5p3692DkL3KUAbc6I1O5LQQcsvB4QWs0JHM1ch
 yu/IZRAh8xZpiovPY17Fc4RqapUCIZNrvTCJ/l6sSCRi+dghtIfiImkd1U3WpwYyD28=
X-Gm-Gg: ASbGncuhLIOieJml6vSLz3kC/qm7FxLimm+IAAWqT1EQefhSQR4HDCqDQZnVsoO9ffc
 Cd+guHS/4n3x9NoVzZ7D56bP/3CIvJGQBj0dK4vNfLUDWJ5CfQUoBVcVoIxmuDoheR53UvcF3U2
 szRJMQhzb1me2d5YRdh16p322cukk+Rxp/TNzqlky19tiKZcGCcjCD1G1qJ1gA3ansxofLbxa1P
 jr1TzF1opeHgtWr8DAEDGnE/NZTN1436Lgu450HZ+/dHpBjrJe2n//Owv3xGLMlhIwgvs+JCQbZ
 fcjwIiPGYMRA7Xo2ZkQ1SvyQ1/2hULc0R7Cv85lVcaZCbJjmy2OTIi8hfYt0VFiHoxjRYgNOJ13
 TbAg/maaBrsWvsAo2ja0ms15YeqqMdxQVQ2IVmxQaqByx0sVYwt3CthlrNyyIL6wjFwctLVp/Lo
 6UMlJjLVIarwBciTD6rng9UKuhtWAe1jRcJFNVJ+s=
X-Google-Smtp-Source: AGHT+IFcwIvDNfEA81ofSZeKIzVVA+Yi4Ou6e4amHtKGUaUG9l4fOpMw5yLE98aEkZsf1cya7SLNyA==
X-Received: by 2002:a05:6870:31cf:b0:3d4:5e0e:c8c6 with SMTP id
 586e51a60fabf-3e833f2e202mr1741869fac.10.1762966631310; 
 Wed, 12 Nov 2025 08:57:11 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e41eba8ce5sm9912549fac.4.2025.11.12.08.57.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 08:57:10 -0800 (PST)
Date: Wed, 12 Nov 2025 10:57:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Sune Brian <briansune@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v1] sync socfpga common u-boot dts
Message-ID: <20251112165708.GC6688@bill-the-cat>
References: <20251110050040.183-1-briansune@gmail.com>
 <CAN7C2SDGh+PZaP2DNOhn3=D9Stw680-7k=Tus_+2r9UQYoAOyQ@mail.gmail.com>
 <20251112164118.GB6688@bill-the-cat>
 <CAN7C2SB25LPkVWMKYFS=DURg2GkarHqo=n0ogOJVn4Ra0+CnAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/HppNgohKZFXzK6J"
Content-Disposition: inline
In-Reply-To: <CAN7C2SB25LPkVWMKYFS=DURg2GkarHqo=n0ogOJVn4Ra0+CnAQ@mail.gmail.com>
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


--/HppNgohKZFXzK6J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 12:55:04AM +0800, Sune Brian wrote:
> > > Do TIENFONG still handles patches on SoCFPGA? Seems like there are
> > > no action or response on all SoCFPGA related patches?
> >
> > Yes, he's Tien Fong is still active, it's just that most subsystems are
> > fairly slow moving.
>=20
> For patches that really affect normal boot should push back
> to mainstream. Those patches really fixes the boot and w/o it
> system completely stall.
> For those that are more less critical can be handle in slower pace.

If there's not a PR with them by rc4 or so, please do call out
individual patches that need to be picked up, that's typically how I
handle critical patches that haven't been grabbed yet. Thanks!

--=20
Tom

--/HppNgohKZFXzK6J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRS8XQAKCRAr4qD1Cr/k
CqS7AP0SdrKB59Q+o2dhqbAsUSMQQyQbK83zgHP6KdaiFeyTcQEAknlwPRL3aPd2
99cbwZX5VbCjaD9fr4iUFF3ODod3lg0=
=rR5A
-----END PGP SIGNATURE-----

--/HppNgohKZFXzK6J--
