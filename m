Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CA7C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 14:40:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E779C88831;
	Wed, 22 May 2024 16:40:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hIJwdMOv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC14E88836; Wed, 22 May 2024 16:40:54 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFB0E87E96
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:40:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3c9cc681ee4so2489499b6e.0
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 07:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716388851; x=1716993651; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Xg/CIIGhRDlDen4SZCwu5jBCKI3LlJW/egUN257VbjM=;
 b=hIJwdMOv7jNwtTYeDARm3lN5RzUmJSapSLTv/i8bQ7bq/aJy2oXmyrXv4suvKEa5h4
 iU9hB4sUYIU6DQSBlZD99JLCOp+OGdt47g0sC52peuksUrde2vHPeTcoj3bEWLagbORJ
 IHqdRBkhZYu8ke48PBG22bboUhfheTSQ/HQis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716388851; x=1716993651;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xg/CIIGhRDlDen4SZCwu5jBCKI3LlJW/egUN257VbjM=;
 b=UX5Jbl4ZXIkwsr9275PYG8oF/kO2+J+SfuM+FIAySKEU++H4Jb9lChuyTlg0tTGhMt
 C+FZI/gRiCnD4+fF+OnjDLe6CTdJz2eiolo/BlYc+55oHoYAsI1Ms3x40cW4corYOyz1
 kyriMDLPKjKI0C0ywqdgiKTnxWJcoxYv82rfpyhasrmwyDWxl45mKDtldd+d6AStJLKr
 MuixCPGzguVoSgm3q+64wtFNxN88qKD8vk2cz+1NzI+dEcxDyRTu6bAf+ZYo0Kp9gWoy
 6JDw47olH2I9OUtGYHvAHGysxv+UKx0TrKQwFggMOuF52JiPFSzEbPOkb3vn0X32i8BT
 6JjA==
X-Gm-Message-State: AOJu0YwdVjMvZ7Wg57KUsu+CFQIK43vpugoMfE0TDKZvsUAaEirduWB9
 YL7uNgcVwamWrTArd7uBFrw1srmpiZxhMD7Gfv8/F4Iw1wivNV4+MMSXXSc0cPo=
X-Google-Smtp-Source: AGHT+IHmlW0tVXn1nhCqZ4/YW/19DkUZ/OCbEg8s0BFZuy5WmZc2Dzpwgbysoela1JnTIRH8MqRv4A==
X-Received: by 2002:a05:6808:85:b0:3c9:966e:32ed with SMTP id
 5614622812f47-3cdb1cda139mr2557253b6e.5.1716388851369; 
 Wed, 22 May 2024 07:40:51 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7931777fdf2sm539494885a.78.2024.05.22.07.40.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 07:40:50 -0700 (PDT)
Date: Wed, 22 May 2024 08:40:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, swarren@nvidia.com, michal.simek@amd.com,
 git@xilinx.com
Subject: Re: [PATCH] test/py: Add support to enable check for bad pattern
Message-ID: <20240522144048.GJ2568172@bill-the-cat>
References: <60e9180b7eba8f97410a320d9ac69101479991d3.1716383488.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oVyCwTbSiGzvrpX2"
Content-Disposition: inline
In-Reply-To: <60e9180b7eba8f97410a320d9ac69101479991d3.1716383488.git.love.kumar@amd.com>
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


--oVyCwTbSiGzvrpX2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 06:45:13PM +0530, Love Kumar wrote:

> Executing a u-boot command may raise an error or extra bad pattern,
> beyond the default bad patterns. Providing a way to enable the console
> output error check in test.
>=20
> For example, description for OS boot test:
> import re
> check_type =3D 'kernel_boot_error'
> check_pattern =3D re.compile('ERROR -2: can't get kernel image!')
> with u_boot_console.enable_check(check_type, check_pattern):
>     u_boot_console.run_command('<boot command>')
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>
> ---
>  test/py/u_boot_console_base.py | 44 ++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)

Looks reasonable, please put this as a pre-req for the updated kernel
test, thanks!

--=20
Tom

--oVyCwTbSiGzvrpX2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZOA/AACgkQFHw5/5Y0
tywn/gv/SlLqJ0Yv1n0Yukx7DFZ8TDzPYVUtzCQZACZE+mhpWsQKVfMHR3e1We8A
IEOkDykvf4k+QZPXTJgajduNvTTfM+DumaOY6FHtXavzT9rCJdf0r7PByayaQttI
xXZqIEFl9YBwI+xINBEh6Jp23Ki7jidNoayte0gyX9QUYW+91u2gDA2djJ6YfhrY
91oqIEVQrGKFkq9yZ25odq345Ph3kPVb41MbX2dJ51nPyNvTvUc+hEXyJzTXu69Y
3tHOKTHKjANL0IK9x1pe6uXt43LCLVS8hGMo2f1EizLE6WI2bHQZ9mmF+ZBkCNpf
jq5Qs/Ie6QgKKx0BmVJquBGu8yWBKwHcEbXyJU0OpUxcanaz35LlYsVNxLfpWiBf
MZgRZk0qX1OScpYdrypWIw/4tNi8bArg4ngkoWM8JL6MhUTXnVLNL1WGkZYwKi3a
Zj78555xg6/8CIZ+P40RwJNz2i2JhQYNL7nB8aWRQJaj/wypPLfiT5JMTAnCVRxw
pJ88Hlkv
=v9UY
-----END PGP SIGNATURE-----

--oVyCwTbSiGzvrpX2--
