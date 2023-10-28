Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 575C9C27C47
	for <u-boot@archiver.kernel.org>; Sat, 28 Oct 2023 13:27:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1223878FA;
	Sat, 28 Oct 2023 15:27:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L0+GS7oZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB969878F1; Sat, 28 Oct 2023 15:27:13 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E159E87790
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 15:27:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-777754138bdso220293785a.1
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 06:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698499630; x=1699104430; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=L0bv6sDeUzbLgXkOSQ50mNMC8jRLw2xsCyxmYv55898=;
 b=L0+GS7oZ5T96iCrg2x1MPlFvyIxgEWI8qIXQTeHx5B2o1QSKSm8EgijUoxEpYC/rZV
 IwM6oJbPWMMQm7QgXbEn3YOTdOckpmmVHrxcj9+wzGtJ+kkZV2CAI6LgAMzegOaSpz+2
 CeWydI0KBh5LF7aU8i2nJRT1T3fOLVecbCYXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698499630; x=1699104430;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L0bv6sDeUzbLgXkOSQ50mNMC8jRLw2xsCyxmYv55898=;
 b=QMN+nFWC8i93jKRJDAEdxz4KXQfmvhPTtDp+cqc7TwLj0a95nSvtGVAWSx3ELtoHqs
 nzr0Qh7HjSDpb7dZZi1krWDZhttLwIBCETPzJCikepY5BrDUe0ed7uKtKMShHGzpAVD+
 6ifIXAwEdsHmSqKQo9I4LJ8R1qptXIyEvLd28Mp07aLs9lFhHKDkpE43MIbX+OSh4I51
 o7GvizYKreaenk78IaWhacOcxUIFNfNzuR7Q/2LxeYt1IXTbwyiWibAZpYoZHbG25GNo
 zCBa/HYuUnfgiHPRaQ+2xMTBkHvDwZsQXK0dDWHtPaVSII0aP+nDO/GrV6KzDEQszRUt
 29Hg==
X-Gm-Message-State: AOJu0YybQKFeD4IYM+Pf32kt0W4vYdvsuZl+yXd9rB0qCHcBHt7UweYe
 x2jRwpfMIiYTPFEtQIRxkkdDbg==
X-Google-Smtp-Source: AGHT+IEwrZLKAocXil0YeEMWjznn6PBoqWOqecVIyPOSMeXgoUfKtkrj7XE8hTQXMALi2Xu366ohbw==
X-Received: by 2002:a05:620a:2953:b0:778:91c3:f497 with SMTP id
 n19-20020a05620a295300b0077891c3f497mr6198693qkp.39.1698499630619; 
 Sat, 28 Oct 2023 06:27:10 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6f2b-3a78-9e8e-d344.res6.spectrum.com.
 [2603:6081:7b00:6400:6f2b:3a78:9e8e:d344])
 by smtp.gmail.com with ESMTPSA id
 k8-20020a05620a414800b007743382121esm1550900qko.84.2023.10.28.06.27.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 06:27:09 -0700 (PDT)
Date: Sat, 28 Oct 2023 09:27:08 -0400
From: Tom Rini <trini@konsulko.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2] iot2050: Allow for more than 1 USB storage device
Message-ID: <20231028132708.GK496310@bill-the-cat>
References: <63976e53-eb68-4aa0-b407-2936e8d9f47a@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="p1XqJbXGvSgGQDvp"
Content-Disposition: inline
In-Reply-To: <63976e53-eb68-4aa0-b407-2936e8d9f47a@siemens.com>
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


--p1XqJbXGvSgGQDvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 22, 2023 at 08:07:26PM +0200, Jan Kiszka wrote:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> This was lost in refactoring while some users of the IOT2050 expect it
> to work: Make sure that up to 3 USB storage devices are probed.
>=20
> Fixes: 53873974a4b0 ("include: armv7: Enable distroboot across all config=
s")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Applied to u-boot/master, thanks!

--=20
Tom

--p1XqJbXGvSgGQDvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU9DCwACgkQFHw5/5Y0
tyyVfAv+M3zQF+pGzgPjY5tKVJZjj5uvP05D3Isv76B+yPNEI+jyjj+c1cbcaPVj
3wHUMgwWnnOL92CGB3MwrJZK/r2U2SPCbJjnCKxbQiw3FvMX9mb4BRBt5cFePwyb
pspAVnTUMfTtjmPCiPSa/JCloomgLVWh94/qHNow9udrTuTzdB4WwIvUI7bWk2d7
Di14lHrScZhUZGxku0Nr1dWbF0K9hol4nFQsmxKGHmIckrkmPjKp3seLley2fxoq
19Ag8phF26+nQIwkJapR0p5iRJcqhz6l1c8qNERkCSORyMvnemrI00heuMRXZAbF
G5lM37pwjjM8BsNYkvhA+++eOh9TiuhXBcombvcK19QA2L1txksZt3UBitfGhQBg
EMMW8JUHjnxhYxQF3MXnbD6O2wqCLTL8kH9l+SzJVKquxKn4aCtVevJVqrSYdF6G
J1Vhf+Bbe+UFqE4AjgnFKIWUGwD33+0TefkZg93TiCjI53L4EHRAb/fswvNYVvD4
9l+rqIxh
=bx9H
-----END PGP SIGNATURE-----

--p1XqJbXGvSgGQDvp--
