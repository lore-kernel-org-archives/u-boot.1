Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66674C44507
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 00:56:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5ACE684A95;
	Wed, 15 Jul 2026 02:56:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="M9pws8KU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01B4F84A95; Wed, 15 Jul 2026 02:56:34 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77AD084A8F
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 02:56:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7e6128bd9b3so2510529a34.1
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 17:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784076989; x=1784681789; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9XknWnR1leMWpeUk/NhjfikWTZ22G3RhdRH8wWizEac=;
 b=M9pws8KUuP4aqcy6ytgZiIzi8h6Ct0T0/Fj/oDm9D5x9/0BubIFaPttitT0x7clCx8
 mK/1sVrKWgIaquPTztPXd7Mr528YkHqpeoDLWq/aVThCUkDCzy+x2qWkRXfuRBTt88dW
 Syn0nWRxq+8hR1Y4c4FCQBzm0NWYChjK4+6FI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784076989; x=1784681789;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9XknWnR1leMWpeUk/NhjfikWTZ22G3RhdRH8wWizEac=;
 b=QxyAmusH7T3zyHYMhsCOD5tuafBpTUJ6S9wAaAJE87tHCno1DryhdsCxc8R+fZna8a
 j+hoasP1sQywCW3SRkKT5INnJmwKCqWh8og9kmOPZLl/Mfoj5BDVL6izjPuVccuCVcsM
 a9xkHQxEBR2GsOCTGYh/FsYMwOfZ2oF4H+QGGSwqQbXQXejbccQ88Jkjtv6zHck0iD+2
 WYJ7rsiI/ElR19hxxBu1bXhY/wPb4I1/a25pobI0U/KhXY5+8CeOnKuRtia7afWAeyvH
 P8nxXgpuirv60+cni2mmn7cnEY+pqzcHaWRs8aFM3MVhXeMTTKtOFmS+Bwld0NvALYBM
 /7Qw==
X-Gm-Message-State: AOJu0YzaCaBN5B9Sq6bIocNRH098E6dekGvItAcN17oLjnXFfocWSm0/
 w0jqIIe5G6wYoHQK9956lU7kU2Vlj7FurKN3hZfTBPpV2+vIBtwyWPUf2SMviBDpiJ0=
X-Gm-Gg: AfdE7cmmRkTzxolLg5bxlan+66i7QXhMnnlOsA8mAbC+np7uEnGGdmnO5vKfj1IbAen
 JNhZ0umg+2v6TTtWIOyXaO7SDcSW0WMD5JNImb6dmAk+0OvVcg1GQ70gJDjbpIzgfn3YXQvqcUP
 iFJYQGXwRvtoxcs5LiVLsa2Ze74eaI3WchwzM9jvDaifvg8C8eZ6+8E77OZhtvYq/ektQz6f7sK
 rv34VjW5ZnINXc0q59cYil5a3snPiMnTJ7AzQjoOF/CtRcVc2nDEM/8gm8QKrMHuR4Yg6g2Frzo
 GaXIwdOanggTbZ0ZXEZ4ScB6vtE5WVSWmuXq2DMy/rWiyi1lFLIpaRzhb8jHSNoTb275MOBZWOW
 D1kYRXGWJwdgLAdWBAoUI729lnjsrtzHCEjn8HrDq5UYZ5AsXzKsUn7H5KHOlN6r/nyjgOCh5W3
 xrijSYcPahmy0oIV43AusvZBISdOyVzXCCC2s3Va8jeHQ1Zmt9ot5cQxyj4lI3UR8+v6O1iLFrN
 1mGlCpMJnVcrNlj/qi4zwB80cBgOuFlnGpJcg==
X-Received: by 2002:a05:6830:2402:b0:7e9:e342:3dd with SMTP id
 46e09a7af769-7ec59d9f250mr490053a34.22.1784076989138; 
 Tue, 14 Jul 2026 17:56:29 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ebcb2631dfsm16239289a34.13.2026.07.14.17.56.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 17:56:28 -0700 (PDT)
Date: Tue, 14 Jul 2026 18:56:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Sean Anderson <sean.anderson@linux.dev>
Subject: Re: [PATCH v4 3/3] test: py: load: check null_dev_desc_ok dispatch
Message-ID: <20260715005625.GA4103122@bill-the-cat>
References: <20260601131311.1163914-1-vjardin@free.fr>
 <20260702144359.1583239-1-vjardin@free.fr>
 <20260702144359.1583239-4-vjardin@free.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NVpr60XuD2ymEIWG"
Content-Disposition: inline
In-Reply-To: <20260702144359.1583239-4-vjardin@free.fr>
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


--NVpr60XuD2ymEIWG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 02, 2026 at 04:42:14PM +0200, Vincent Jardin wrote:

> Some pytest modules exercising the dispatch added by
>   fs: dispatch null_dev_desc_ok filesystems before lookup
>=20
> test_load_semihosting.py:
>   "load semihosting - <addr> <file>" and the optional
>   [bytes] [pos] variant. Runs on qemu_arm64 with
>   CONFIG_SEMIHOSTING=3Dy; reuses test_hostfs.py's host-staged
>   fixture.
[snip]
> +@pytest.fixture(scope=3D'session')
> +def sandbox_fixture(u_boot_config):
> +    """Host-staged fixture file read by `load sandbox`."""
> +    path =3D os.path.join(u_boot_config.persistent_data_dir,
> +                        'sandbox-fstype.txt')
> +    with open(path, 'w', encoding=3D'utf-8') as f:
> +        f.write('Das U-Boot\n')   # 11 bytes, same as test_hostfs.py / s=
emihosting
> +    yield path
> +    os.remove(path)

OK, but this fails CI with:
https://git.u-boot-project.org/u-boot/u-boot/-/jobs/40773
and saying it read 34 bytes.

--=20
Tom

--NVpr60XuD2ymEIWG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCalbatgAKCRAr4qD1Cr/k
CiL/AP9PSRBIkxtAw+2q14VXP2YYAGbVjt80FpZrV5BxCP09RwD9G9Oduixi9ldN
3JBUVqePK0MIX2z6JZjCK+/gGsJd9g0=
=unmD
-----END PGP SIGNATURE-----

--NVpr60XuD2ymEIWG--
