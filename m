Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C55C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 17:57:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D92A188A5C;
	Wed,  7 Aug 2024 19:57:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iXW5dlag";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2834488BDB; Wed,  7 Aug 2024 19:57:47 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA22188A5C
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 19:57:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5d5b986a806so548841eaf.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 10:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723053463; x=1723658263; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=60GDInb2h4otaSVe0/G6m920e1Lwz4wVSnBp+FlTXtc=;
 b=iXW5dlagfBH5o+XZbUk2bFF4YL+uE+bJ0rwL2JCUI6AvLS/FGY0JZivyBXYrEnernB
 0VnDNdD/o5egAuGxh/jLEE9LugLFgUD3l9XakyvZYAFyAua7YtXAET3a96tRUhY6ccrQ
 H4l0onETUGR8iq142Xe9z/diYkTPbf8wgE+FE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723053463; x=1723658263;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=60GDInb2h4otaSVe0/G6m920e1Lwz4wVSnBp+FlTXtc=;
 b=Tg5U5zrOqmKR57zg1jggVgGnITuCfWt4vFG6rI8CYbohR0eTn+6kRMbjyl2TNm4mxa
 OhDCvZdClcVEmZoMCREv4I8GzG8nmWohc3zMzSZOXugEDU8vd9GN92cL92jADStfQggl
 yb0t6E0U+pnrqJcfw6i0+jR9M3Cf4/ZPMOoZF3N71YyfZPa6zK5E/rROvAGifinZFWuk
 qok6VhOIT/RqOtn/4cvhCBPuGU+VYRuMvGEcpIDYW50kn/UvDbRZ80j09sn6BcTTC5GN
 ZH3Lb0tus5oqRRachAe809Ydr/laZyHmj6g4cvcx1TTDL/oYnQNHq8Uln/s7XCoGqctk
 xw/Q==
X-Gm-Message-State: AOJu0YyalUXO5zvWBdbXw/nlwEBBQ2N/OL8pUKhzxKbguQ8wVOtBqPmL
 VFi4MKjjBiPAU7fcYNzrHs3uda1X57kwxnErUVmnqsIMFbG/j8PIHMG0wQMDGVI=
X-Google-Smtp-Source: AGHT+IG68siUNeeD8tKMDtFH8hV63fxF6OgbMXGxl8M+YA0M3R+3ZYRtQ8bqayw8BfA1+9Wna38YCA==
X-Received: by 2002:a05:6870:9a0c:b0:22a:57da:6fec with SMTP id
 586e51a60fabf-26911745244mr1352318fac.16.1723053463552; 
 Wed, 07 Aug 2024 10:57:43 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-236.totalplay.net.
 [187.191.8.236]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2689a2f368bsm4029449fac.20.2024.08.07.10.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 10:57:43 -0700 (PDT)
Date: Wed, 7 Aug 2024 11:57:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v8 22/23] test/py: add HTTP (wget) test for the EFI loader
Message-ID: <20240807175740.GH1626301@bill-the-cat>
References: <cover.1723050310.git.jerome.forissier@linaro.org>
 <9b055b18f84755d775bf0cf4064e66801608839c.1723050310.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nJTd4ORcRZN0qucz"
Content-Disposition: inline
In-Reply-To: <9b055b18f84755d775bf0cf4064e66801608839c.1723050310.git.jerome.forissier@linaro.org>
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


--nJTd4ORcRZN0qucz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2024 at 07:12:06PM +0200, Jerome Forissier wrote:
> Add a test to test_efi_loader.py similar to the TFTP test but for HTTP
> with the wget command.
>=20
> Suggested-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  test/py/tests/test_efi_loader.py | 52 +++++++++++++++++++++++---------
>  1 file changed, 37 insertions(+), 15 deletions(-)
>=20
> diff --git a/test/py/tests/test_efi_loader.py b/test/py/tests/test_efi_lo=
ader.py
> index 85473a9049b..64c994fdf95 100644
> --- a/test/py/tests/test_efi_loader.py
> +++ b/test/py/tests/test_efi_loader.py
> @@ -50,6 +50,8 @@ env__efi_loader_helloworld_file =3D {
>  import pytest
>  import u_boot_utils
> =20
> +PROTO_TFTP, PROTO_HTTP =3D range(0, 2)
> +
>  net_set_up =3D False
> =20
>  def test_efi_pre_commands(u_boot_console):
> @@ -110,10 +112,10 @@ def test_efi_setup_static(u_boot_console):
>      global net_set_up
>      net_set_up =3D True
> =20
> -def fetch_tftp_file(u_boot_console, env_conf):
> -    """Grab an env described file via TFTP and return its address
> +def fetch_file(u_boot_console, env_conf, proto):
> +    """Grab an env described file via TFTP or HTTP and return its address
> =20
> -    A file as described by an env config <env_conf> is downloaded from t=
he TFTP
> +    A file as described by an env config <env_conf> is downloaded from t=
he
>      server. The address to that file is returned.
>      """
>      if not net_set_up:
> @@ -128,7 +130,13 @@ def fetch_tftp_file(u_boot_console, env_conf):
>          addr =3D u_boot_utils.find_ram_base(u_boot_console)
> =20
>      fn =3D f['fn']
> -    output =3D u_boot_console.run_command('tftpboot %x %s' % (addr, fn))
> +    if proto =3D=3D PROTO_TFTP:
> +        cmd =3D 'tftpboot'
> +    elif proto =3D=3D PROTO_HTTP:
> +        cmd =3D 'wget'
> +    else:
> +        assert False
> +    output =3D u_boot_console.run_command('%s %x %s' % (cmd, addr, fn))
>      expected_text =3D 'Bytes transferred =3D '
>      sz =3D f.get('size', None)
>      if sz:
> @@ -147,16 +155,8 @@ def fetch_tftp_file(u_boot_console, env_conf):
> =20
>      return addr
> =20
> -@pytest.mark.buildconfigspec('of_control')
> -@pytest.mark.buildconfigspec('cmd_bootefi_hello_compile')
> -def test_efi_helloworld_net(u_boot_console):
> -    """Run the helloworld.efi binary via TFTP.
> -
> -    The helloworld.efi file is downloaded from the TFTP server and is ex=
ecuted
> -    using the fallback device tree at $fdtcontroladdr.
> -    """
> -
> -    addr =3D fetch_tftp_file(u_boot_console, 'env__efi_loader_helloworld=
_file')
> +def do_test_efi_helloworld_net(u_boot_console, proto):
> +    addr =3D fetch_file(u_boot_console, 'env__efi_loader_helloworld_file=
', proto)
> =20
>      output =3D u_boot_console.run_command('bootefi %x' % addr)
>      expected_text =3D 'Hello, world'
> @@ -164,6 +164,28 @@ def test_efi_helloworld_net(u_boot_console):
>      expected_text =3D '## Application failed'
>      assert expected_text not in output
> =20
> +@pytest.mark.buildconfigspec('of_control')
> +@pytest.mark.buildconfigspec('cmd_bootefi_hello_compile')
> +def test_efi_helloworld_net_tftp(u_boot_console):
> +    """Run the helloworld.efi binary via TFTP.
> +
> +    The helloworld.efi file is downloaded from the TFTP server and is ex=
ecuted
> +    using the fallback device tree at $fdtcontroladdr.
> +    """
> +
> +    do_test_efi_helloworld_net(u_boot_console, PROTO_TFTP);
> +
> +@pytest.mark.buildconfigspec('of_control')
> +@pytest.mark.buildconfigspec('cmd_bootefi_hello_compile')
> +def test_efi_helloworld_net_http(u_boot_console):
> +    """Run the helloworld.efi binary via HTTP.
> +
> +    The helloworld.efi file is downloaded from the HTTP server and is ex=
ecuted
> +    using the fallback device tree at $fdtcontroladdr.
> +    """
> +
> +    do_test_efi_helloworld_net(u_boot_console, PROTO_HTTP);
> +
>  @pytest.mark.buildconfigspec('cmd_bootefi_hello')
>  def test_efi_helloworld_builtin(u_boot_console):
>      """Run the builtin helloworld.efi binary.
> @@ -185,7 +207,7 @@ def test_efi_grub_net(u_boot_console):
>      executed.
>      """
> =20
> -    addr =3D fetch_tftp_file(u_boot_console, 'env__efi_loader_grub_file')
> +    addr =3D fetch_file(u_boot_console, 'env__efi_loader_grub_file', PRO=
TO_TFTP)
> =20
>      u_boot_console.run_command('bootefi %x' % addr, wait_for_prompt=3DFa=
lse)

Looking at this now that I've added wget to my Pi builds, erm:
U-Boot> wget 200000 EFI/arm64/helloworld.efi

That's not going to work. That's what works fine for a tftp server. I
think the test is going to need to require some http specific
configuration added (and I'll locally start firing off the python
trivial http server or something, for tests).

--=20
Tom

--nJTd4ORcRZN0qucz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaztZQACgkQFHw5/5Y0
tyymBQwAjKmQJHC+mg/uBRIeNDa5XIyUG2WHABIK5GE/g738LO04eTqNHJ5TLFd8
RJaiTQz3NK/IHBaU+NdONUqO3zQjpdDzGnScGcR03DUUAroz2jJZJiyCVLze1QuP
+AFeT/ndiU+SXd4g3eyHFr6eKYR5p8SVJKvah95jJL/BYvcgLTO4/g23xxviFJCM
anBUk5IxyOn/MoYKuU7qY9HP3/xwlkS/h456G6wgE2wGWOw8tABAFROKUGF0fVnL
vdrSppacGn6UAOm6oIj43v8on+3THUawFAKIhBpi8Oz7YxD0Y+mSxSPklok4+bKX
1W1xC6M7bGNECfbudnuM3IJ4m+pOlAkQxsGLRzkuSO8crbHwqnAOPJggCa+mfpye
oA95qGrJhBYvndJwyfB63Sa6LIDG43ZUI9tDNqg1ClzlrMl53FHLraCdXgc2TboP
jfVyLWvPfwEzxtixni3RmAZNuPehYKsQazb6pS2ZyWgGjLsuZKi2j9jFAGpHG6BI
NcReVIph
=bcfp
-----END PGP SIGNATURE-----

--nJTd4ORcRZN0qucz--
