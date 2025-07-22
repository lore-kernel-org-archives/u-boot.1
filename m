Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1B8C83F1A
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 20:08:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B8C4833F8;
	Tue, 22 Jul 2025 22:08:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VXlU0VLt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 486D28341C; Tue, 22 Jul 2025 22:08:39 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B52A8331F
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 22:08:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-740ecfff873so9807a34.2
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 13:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753214916; x=1753819716; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cauDPZiGF+Qtn3lILb3cVVv8aAA6E0a99F4NjJZcPT4=;
 b=VXlU0VLt6hiTF5D9286xrhoCNoB1YWjFwG/a12dgTqx0cPuLrDsf7Iqgm8sJKqMvEs
 wesCS0UiIQERrbILtx4YBOoZiLLY9ZAejB7kPEet9FIKEcvCDJAHd812EwIio/ty1XNK
 LKa62Ng7kpwKNIHNUwDYYlK54BaIXrIOd6suM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753214916; x=1753819716;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cauDPZiGF+Qtn3lILb3cVVv8aAA6E0a99F4NjJZcPT4=;
 b=nkrlToa5G0AB5JRevrIxq8/LhxYgm6ZH50y5Bp3oQY9who9xI7R1+O4/lua13eLZQC
 M593pPe1lQFSv1zz/JnmOfqmUdmNooKg+344N3ICTEO8tOfmbOehToHJ7DbnWQ+YTf5Y
 bR+VaCzdNuXreUzE1XybI6Yf8BB9NfvqB9zpxmNl32sTx8zKeFQeNt0Fx+RAjFX3n3Fx
 gkJChi9UVLEnbtImtRupARN4RruK/Qy+C1L0LSrvP0FeE+azkvxi9Tb98qyI9QFBRtCk
 lxwvR6xH/PWDaYIRHxqO364m0rA3lJQmAOda3sptvy9mfdayuE48TUgWrwlnRApeNQL7
 UlLg==
X-Gm-Message-State: AOJu0Yy8GrX+FZpMHo935ds46focJYuKzIi4YBj/0flBxlWvMBc8H84f
 HZRjp1dU9+sanM/FBIfBsDkq6lRyUfVQ7xAXxBAzigM2z33OWMkODFnQI5hT2Pmsn4VCagWthQg
 ysbYo
X-Gm-Gg: ASbGnctY+gfk0zQwsLMYaf0TthyqNvXk5gVkbV3hooSMhixx+xYBcFjg677pSd9Z6FC
 9Ui9PQhKnKJhOQroIY21s+mqDCz2aW+tw1C4cvyyOxLkX0HfRevev7jxBPe57WHvVht9PHbvwNO
 eBS3uN7B4IkdlFpUpxjxYlAj6dQFJutusdkO4+0hRTBawe0v9bTIthWsgxwULICnTUIbfzVfRqZ
 cqVJubvgw9NbX/hR5wIFlYrVuU0onIhBbETGxQ7455jb3TfszIzJsuRCMJi4XSUtdY5vOpagNDK
 dE0rGWh2gggNXGIlnP7WgLMQf+18EDtENb40HM+t0anJ87HV0g3sQQh9SeRVQn6LyucqeEhJJlw
 iE4nw0GRnaufVvtexQUVYHBsfzPGBDZ5zOYMeEpL/H8qM/tt8wuklc4Fn
X-Google-Smtp-Source: AGHT+IF12Gtn/RTf0j8G0vJSXkVQa8ncOBWCq4GZXsF/bKWmq/xqzb30cNipwY8+XXLtNeCknfLqCg==
X-Received: by 2002:a05:6830:3805:b0:73e:93a2:3a68 with SMTP id
 46e09a7af769-7408899af78mr374456a34.20.1753214915623; 
 Tue, 22 Jul 2025 13:08:35 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73e83bd975bsm3726144a34.60.2025.07.22.13.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 13:08:34 -0700 (PDT)
Date: Tue, 22 Jul 2025 14:08:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com
Subject: Re: [u-boot-test-hooks PATCH] travis-ci: Wire MB-V targets for CI
Message-ID: <20250722200832.GI2847763@bill-the-cat>
References: <82725079ee90362468fe8096db24ef2959725af9.1753181505.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YSWVia60rgtgrTRA"
Content-Disposition: inline
In-Reply-To: <82725079ee90362468fe8096db24ef2959725af9.1753181505.git.michal.simek@amd.com>
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


--YSWVia60rgtgrTRA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 12:51:45PM +0200, Michal Simek wrote:

> When QEMU v10 upgrade happens MB-V targets should be wired to add them to
> CI that's why add configuration for it.
>=20
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--YSWVia60rgtgrTRA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaH/vvQAKCRAr4qD1Cr/k
CjtGAP4ykW7sUNQUNRkkJP2/6u/cqMZlCMjN7eLl5yuw4PIYNgEAz3vBLHIO6w4m
As+E3FQWE/tnM0iCcry6OUaE3mdSIw4=
=v6rj
-----END PGP SIGNATURE-----

--YSWVia60rgtgrTRA--
