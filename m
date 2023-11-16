Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA1FC47071
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 16:30:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6B3A86F56;
	Thu, 16 Nov 2023 17:30:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="APZXMKHi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 594578744B; Thu, 16 Nov 2023 17:30:46 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AB5C86F32
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 17:30:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-66d0169cf43so5479966d6.3
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 08:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700152240; x=1700757040; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NK9RQvi9Qypw+En/5C9K/oGh47Xp1Yn/5F/fb7cziGE=;
 b=APZXMKHitRuLh2eew9WBEiEnxr1yG2piGD6UKkJd1OosbaQKqWA39dsrY14y07Dqcz
 Uk5XuhcktKrAk4tpCKyvPETUuskBQYYZhw298FTFLUyENoeWaHTeIafTHtuh3iKChkmb
 aQYfEVbqsxl6ZO9m/36tdxfA9ZbQBETc8X4KE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700152240; x=1700757040;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NK9RQvi9Qypw+En/5C9K/oGh47Xp1Yn/5F/fb7cziGE=;
 b=SL72ljwpFoDgclyVbsg8lmRhc+0yarMpDTFUzcAw70RqS05O4I9bXK74DR00/EQvXl
 4iXwcHamCINdtvWAp3c/I/nyhy0ZKxXuU2vPiQxrWIXJmjgKSlwXkUThs0AwvObtNjMn
 S27u5IyRpzYY0l/F0M0rxWzkytMDYbwwpb/KdF72DqliA0AyPtl3/sWuQfLbgxGI+uS4
 XK2UcemYgMv6vVc82VUHWqin98SF6Z7v1TVnHTJEfdrr1RHd+hhk05IM/PMl+3XWWz07
 PSNfNFjdcxbm3iy5Ufj+Uvvgxtwqaq7JMJVW+qmtsPjYTFYrrODuNbcWXsP/ztA9WhrJ
 dpLQ==
X-Gm-Message-State: AOJu0YzcLOR2SPrUT//mVJCDR7w6xy1YoI5iw36424Vc/0/bNuOR1chn
 g+PtZZ+hso13u18wa8GdpiP98A==
X-Google-Smtp-Source: AGHT+IEzqDXXgX1AKllog46zg3NIPhEyJrn3+7pG8/YpHONNndhPqmj2QY5d0RNAOcYWTXYfo1mdVA==
X-Received: by 2002:ad4:414a:0:b0:66d:50a6:da72 with SMTP id
 z10-20020ad4414a000000b0066d50a6da72mr9390933qvp.26.1700152240121; 
 Thu, 16 Nov 2023 08:30:40 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6602-bbee-fb68-4a56.res6.spectrum.com.
 [2603:6081:7b00:6400:6602:bbee:fb68:4a56])
 by smtp.gmail.com with ESMTPSA id
 mn10-20020a0562145eca00b0063d5d173a51sm1493089qvb.50.2023.11.16.08.30.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 08:30:39 -0800 (PST)
Date: Thu, 16 Nov 2023 11:30:37 -0500
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH] test/py: i2c: Add tests for i2c command
Message-ID: <20231116163037.GU6601@bill-the-cat>
References: <5a86ff75b3ca210227e3a2a1d034afadce9ac209.1700030275.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8J6JnOhti69/dxpb"
Content-Disposition: inline
In-Reply-To: <5a86ff75b3ca210227e3a2a1d034afadce9ac209.1700030275.git.love.kumar@amd.com>
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


--8J6JnOhti69/dxpb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 12:08:38PM +0530, Love Kumar wrote:

> Add below test cases for i2c commands:
> i2c_bus - To show i2c bus info,
> i2c_dev - To set or show the current bus,
> i2c_probe - To probe the i2c device,
> i2c_eeprom - To test i2c eeprom device,
> i2c_probe_all_buses - To list down all the buses and probes it
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>
> ---
>  test/py/tests/test_i2c.py | 107 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 107 insertions(+)
>  create mode 100644 test/py/tests/test_i2c.py

I'm mostly happy with this test. I enabled it for one of my platforms
with an EEPROM and:

> +@pytest.mark.buildconfigspec("cmd_i2c")
> +def test_i2c_eeprom(u_boot_console):
> +    f =3D u_boot_console.config.env.get("env__i2c_eeprom_device_test", N=
one)
> +    if not f:
> +        pytest.skip("No I2C eeprom to test!")
> +
> +    bus =3D f.get("bus", 0)
> +    if bus < 0:
> +        pytest.fail("No bus specified via env__i2c_eeprom_device_test!")
> +
> +    addr =3D f.get("eeprom_addr", -1)
> +    if addr < 0:
> +        pytest.fail("No eeprom address specified via env__i2c_eeprom_dev=
ice_test!")
> +
> +    # Enable i2c mux bridge
> +    u_boot_console.run_command("i2c dev %x" % bus)
> +    u_boot_console.run_command("i2c probe")
> +    val_int =3D random.randint(0, 255)
> +    value =3D format(val_int, "02x")
> +    u_boot_console.run_command("i2c mw %x 0 %x 5" % (addr, val_int))
> +    expected_response =3D f"0000: {value} {value} {value} {value} {value=
} "
> +    response =3D u_boot_console.run_command("i2c md %x 0 5" % addr)
> +    assert expected_response in response

So this is a destructive test, yes? That's fine for QEMU but on real
hardware that's a problem. Doubly so since I need the contents to be
correct as they already are. Can we change this such that we probe the
eeprom and then read back the configured correct value instead?

--=20
Tom

--8J6JnOhti69/dxpb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVWQ6oACgkQFHw5/5Y0
tyy8YAv8CxrNUlj17NnIp+PeZ6OTnA3kEdei9PgB02Rz2s8uOd6uANh16sjI4QnK
zuZq1Sl8R/HtSupAz49eZg5Km8WvkvDPS4cvj4Tsa/i7KjHhYAb0ii0yFYYC3xk6
P5uk8t16/8skO12z6gDFUBkIe+/FTu9SGAjU2pGB4i05+p2a4RmgP8PWjcsbSBf0
FpfLYnX2QzSOb/nZGfAmEVIjJi9a/vuRckzLoY35x6S1T5mKviCJqgMugvrJpsvF
n7jxurWVTADDN8UKvUpuUAnIgIVBGYIWeJd4GSZWJ7V2+abylNLFSuwHnikZR8gz
8/1tRMvAd+Dgo6gzPIFJMuM+zuDNcCiHvXafZZY9z52Wauifc6RMXzBgMLmUyl9q
UYSv4P1KHaWtdr2drrgIHJh66FTg/OibpzB4fxdhtS5cyMvQEsD5tFsIJCIfRdHy
nm8bIRpXHpuD9YdPqwYDS5HrMRyPhGvVBVGqq0rpPpoTDqYInCdA7oy0x2AiC9J2
9kQXUlEA
=qik9
-----END PGP SIGNATURE-----

--8J6JnOhti69/dxpb--
