Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E56D3C4725D
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 16:04:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 637D98798D;
	Fri, 12 Jan 2024 17:04:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="af//vmja";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCBAC8798D; Fri, 12 Jan 2024 17:04:30 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7797D87981
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 17:04:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-dbf2737bd48so3082683276.2
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 08:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705075467; x=1705680267; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mP5TDaJws7FyW3VvSN4FG10MjtWLtLN7JdmrdiThAp8=;
 b=af//vmjaH7s06XsZtwJaXpvQ/H0e9kL6Ayi+lZ+0s+XUyGYGNK79e0TG9yocgASOX+
 /dt3SA6GCWf0Ryu4xvZ7aOgkSuMJFlONgIDOOeFVTksJ0r8AT+PbvJsFRHRcWrijy6wo
 Loy8o0zF4SyCxkTUd92wAY3nkvHgdbyBgOrPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705075467; x=1705680267;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mP5TDaJws7FyW3VvSN4FG10MjtWLtLN7JdmrdiThAp8=;
 b=k3Maxt307t7vd5MYm0DFuKiQpHlDZcHUfxjsdXnPlvXo6uG+haodpLuRfUji3knTZP
 pmLw4r9utzZWM3aBm8w2k7cTcKzMJWfvArK5t2cnQuJbreNyt1RDwvSPaT7ODGzwNLHn
 Vt66jjZyW5QwehFGmUEMlvyWmr9UTCTKk1ppTdgE0FB6NzyXGYsoRLMIVkAn5Br2j06M
 hyIxqFAvQDBkwVjtPO3ex8iWUmCcgMJ90bOLT/6avqRcbPURlwziPAv7sFjocoSpKvsx
 S3ww5TFvgkCVFjfUtzQVXiC/Y2RlwomUZHdOAqwUIGyEN2yQhIF7FvWyjsgZWcWHZz36
 9vPw==
X-Gm-Message-State: AOJu0Yw0MZN51v+toqXW83eKwOlK7NLBXwQRM9OQMNkUh6a7ALzSc1DN
 xG+qv+swaCBGdwX5FldZrjW2zOkMVDm1DftEa29qhzkDdfw=
X-Google-Smtp-Source: AGHT+IF7R0o9S7TEpPgnjedFFt5NVu8iqYaZVjDFAacKzBzxCYwy0YwCnDi6Xvwce100L74yVt3fdQ==
X-Received: by 2002:a05:6902:2007:b0:dbc:cbda:adda with SMTP id
 dh7-20020a056902200700b00dbccbdaaddamr884833ybb.105.1705075467009; 
 Fri, 12 Jan 2024 08:04:27 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 t44-20020a25aaaf000000b00dbdaf9a60e9sm1302590ybi.37.2024.01.12.08.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 08:04:26 -0800 (PST)
Date: Fri, 12 Jan 2024 11:04:24 -0500
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH] test/py: saveenv: Add a test for saveenv command
Message-ID: <20240112160424.GD1610741@bill-the-cat>
References: <ad2d0f038a9547ff0e6cba6a496ddec73c6a0e88.1704976608.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="h5yGudPNqnNNTd3Z"
Content-Disposition: inline
In-Reply-To: <ad2d0f038a9547ff0e6cba6a496ddec73c6a0e88.1704976608.git.love.kumar@amd.com>
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


--h5yGudPNqnNNTd3Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 06:12:25PM +0530, Love Kumar wrote:

> Add test case for saveenv command in non-JTAG bootmode which saves the
> u-boot environment variables in persistent storage.
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>
[snip]
> +# Setup the env
> +def setup_saveenv_env(u_boot_console):
> +    if u_boot_console.config.env.get('env__saveenv_test_skip', False):
> +        pytest.skip('saveenv test is not enabled')
> +
> +    output =3D u_boot_console.run_command('print modeboot')
> +    m =3D re.search('modeboot=3D(.+?)boot', output)
> +    if not m:
> +        pytest.skip('bootmode cannnot be determined')
> +
> +    bootmode =3D m.group(1)
> +    if bootmode =3D=3D 'jtag':
> +        pytest.skip('skipping saveenv test due to jtag bootmode')

This doesn't handle the case of "modeboot" being unset, which is how my
hardware is.
--=20
Tom

--h5yGudPNqnNNTd3Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWhYwgACgkQFHw5/5Y0
tywxbgv+POCBax6FCi9qm4kzN1aRzeBCWhmnTL6Uot68ZejuyyaWotm46uqTExZl
0aUOrZTpNb4o2/43x8Y3vKxuuFbHlNVcTQqpeFIPewOQCTzN7aXPtNAkwUJxvM+D
ZuM4fAw56E0HaMaQL1CM4A4Huvxb8o/MSW4nB5OlXhEk5328nywQb1p4o59ZApyG
Ry/0fPXUPhFRIyhedenhfLxd8prCzr73dNMFO3lRCQRC+aTvNxXe2YYPjXtlTqOl
7TNRU9dBQzcTk1uJNF8syddb4tT/ut0h/co9UPhJ0YnzbtYyu/VqDwewnuvJyh8H
vsCUS8d7P81cIIgwBCGmjSdiLuvmno3dM7RleUWYTYVWvp/X9h9UUL1sbvLfLT6k
9fhyZAciZd4iCGCKsOMBLHOCXXEJ4n9EMQM3ornq1VVLIIW5cCf8tP5EYOgd5R1s
KH9StUd1dz74pQEzomr8JpBBdB0OvOSntEoMD1bUHF5NrTFH7VhXVC/lYMr+H2hN
RNF0Vemq
=I5FC
-----END PGP SIGNATURE-----

--h5yGudPNqnNNTd3Z--
