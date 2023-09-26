Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C86E7E649
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 15:53:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CFE486D5F;
	Tue, 26 Sep 2023 17:53:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Tsp65KX7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 769B486D73; Tue, 26 Sep 2023 17:53:37 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6718686D75
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 17:53:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-59bf1dde73fso116161347b3.3
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 08:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695743614; x=1696348414; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YqOMWpRpbjXUMMMmWIiw/a5vfCCl63TAx2FSwodo7UA=;
 b=Tsp65KX7/0ZdaEUBpvtWD+SxY8rApVmc+awNDiyt1riMeuYZk4Hmc5cDzc/VbwmNWg
 6SAgqFq7WpnALYRj8p4/q5+ofoFhHhSNHlW/GTCcW5lDFhrxANk8QrucMHpO0duz4L6w
 CHsFTRWcOmSHnZfDjIqn6MVLpRsnc6JVtiXTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695743614; x=1696348414;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YqOMWpRpbjXUMMMmWIiw/a5vfCCl63TAx2FSwodo7UA=;
 b=ixqQH4P92IWlyGrIMLYDPlPjHryRML9mAdcV4GdMARroQ5GlU+2wYrCTFPFvKEq4bC
 qv2B5HVAzoQWTD3azizA/MB8YwSMyMM6U8ea+EjIxR7LHOgOR76uQZlHJ9X/85gsia0q
 APKMz3ZXKlbwy+Gp7ek3Hiq6vkWSrQW3F7b/i99xVY0GSGAYJm6AUkup5Ke+j3Lg0amQ
 WcLWgElaI89tdq8vD+vb5CfQ+FUMSPbq8KF/k+fYqebn7ITluun8QhSaCnQUwHDEjofu
 cagYpcK8kUKgkS608KZTqaIIGHjwrMAllXkH+EdhJAmNsBa3nZ2cIZFoU2kOu/Hm4jdn
 WhAQ==
X-Gm-Message-State: AOJu0Yz+Hcg48p56BlCgdpwicgdoMreeFFoW6WwY41PJ4I885Xecldmp
 Vpysx+/W4Y0j+IFuu/MaXE8kzw==
X-Google-Smtp-Source: AGHT+IHY8fxEvhDRCYEp5VjvPMJhpQmpCvSUlG7bwqaxS7agPKB8AmsLmlmKnJJ6kDj6vgM7qDD/Rw==
X-Received: by 2002:a81:5245:0:b0:595:733b:387 with SMTP id
 g66-20020a815245000000b00595733b0387mr10741715ywb.2.1695743614023; 
 Tue, 26 Sep 2023 08:53:34 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a080-e51b-f064-cf67.res6.spectrum.com.
 [2603:6081:7b00:6400:a080:e51b:f064:cf67])
 by smtp.gmail.com with ESMTPSA id
 t8-20020a818308000000b0058ddb62f99bsm3061194ywf.38.2023.09.26.08.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 08:53:33 -0700 (PDT)
Date: Tue, 26 Sep 2023 11:53:31 -0400
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH] test/py: sleep: Add a test for the time command
Message-ID: <20230926155331.GX305624@bill-the-cat>
References: <acb9a1175427a1a7fba80f9dfe9d90278850ae90.1695728179.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qhLChMwmZgbD+f1T"
Content-Disposition: inline
In-Reply-To: <acb9a1175427a1a7fba80f9dfe9d90278850ae90.1695728179.git.love.kumar@amd.com>
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


--qhLChMwmZgbD+f1T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023 at 05:08:35PM +0530, Love Kumar wrote:
> Execute "time <sleep cmd>", and validate that it gives the approximately
> the correct amount of command execution time.
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>
> ---
>  test/py/tests/test_sleep.py | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/test/py/tests/test_sleep.py b/test/py/tests/test_sleep.py
> index 392af29db224..388f544d07df 100644
> --- a/test/py/tests/test_sleep.py
> +++ b/test/py/tests/test_sleep.py
> @@ -41,3 +41,23 @@ def test_sleep(u_boot_console):
>      if not u_boot_console.config.gdbserver:
>          # margin is hopefully enough to account for any system overhead.
>          assert elapsed < (sleep_time + sleep_margin)
> +
> +def test_time(u_boot_console):
> +    """Test the time command, and validate that it gives approximately t=
he
> +    correct amount of command execution time."""
> +
> +    sleep_skip =3D u_boot_console.config.env.get("env__sleep_accurate", =
True)
> +    if not sleep_skip:
> +        pytest.skip("sleep is not accurate")
> +
> +    if u_boot_console.config.buildconfig.get("config_cmd_misc", "n") !=
=3D "y":

We should use @pytest.mark.buildconfigspec('cmd_misc') on the function
def itself.

--=20
Tom

--qhLChMwmZgbD+f1T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUS/ngACgkQFHw5/5Y0
tyy0DQv+PHkfvkSlmTepLNF+DuIguYydVAZpvpkpqrtseuHZ2Bqz3eb13LvtiaI/
zqzFBpZXBWwLre+g2idpU8HKq8MZjiWjSNb6vKBW4GKHetQ/HJbUzycC/I/e84v6
GyhLrjY97avSyRy7R4oDBRZY7W+7ewwjxY07295bTqz1UmFLoRZRpw1foNoj9yHb
SnIPNWoAy0iqkUeGdjt1nljq1Lk/vNnKdfZJzOfnCnAyqx1xrGL0HOLC8+SSqUYm
ir6ga81RD1ltyU/CbOMehcrglUJPK5IrtqOs3O5mzXYxf4ZUyDdsaW9PXjDm3V8T
Fiw0Dw9yj0lPi2+dcuoVo+KJgk3jOLufswP5gYhhIUTAwxWlnlUo7L8bPBVAVmOK
o2MZJ/tnr2jamzik/dS5LgiIwxMU/zLcONoRnE6z/p6GzKS7GBNPXE9kZfld08FP
aW+7/98puhKL6xHafHFM9pqmXhrD0yv/+og/gaXXGroRudnjOckV854gOMWxopEG
7MS/U76Q
=QKzN
-----END PGP SIGNATURE-----

--qhLChMwmZgbD+f1T--
