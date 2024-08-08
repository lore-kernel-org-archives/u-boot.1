Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A70C52D7B
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 16:20:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7479A88AF8;
	Thu,  8 Aug 2024 18:20:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PJKvASmz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 878D688AF9; Thu,  8 Aug 2024 18:20:38 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 405D388AE8
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 18:20:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-261e543ef35so742716fac.3
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 09:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723134035; x=1723738835; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UYvyo3DSx9ifuHd6s08U1D4PCJp3B4hHZ7x7XyDeeh4=;
 b=PJKvASmzTb6cQ7QeNWiokSMxypILFPlgkdGJ5L5ZFD0Z/ak4xs16KQp1SPawm+ySCV
 u28WVFUej/AaPR337nE0Tjy9m3aZRlMmTIY15Gi+CHBDEGMTacMBUcZC2a0Ehs2f8rOg
 vuV7lbftl+KPjO9Rc1Vapnd/eFvrRkfYI/5Os=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723134035; x=1723738835;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UYvyo3DSx9ifuHd6s08U1D4PCJp3B4hHZ7x7XyDeeh4=;
 b=n0m4MOPdqbQWdr6Nl4JevnxQCVL3VxqRyoVBNmHl+9IWqozHX6BRUO89YUUjb1HWnw
 3FzMh70m1REPQbyX2aoHcym7kvCi461O776BDAPnXxaGtZ0Uns+0uVCZNMielJwSTKpq
 8etfPlFcLF3RLw1vVwkykCsP5t5QHkujGmATQvjb40R8URfOUlTI8ygRVRpjVjNGm2ql
 TSgYz/84leAhIFPPmLRJVn59X8CExZ96bSQVZ8rV8C4acDWcHSom+rYWfa1vPLnZhQND
 DjhaE3ity0qqqoAuQQsQkMthBcK4zUIZPn3hds63yhy8dNYTe2xxLxdM0es+wPycSgDE
 uC/g==
X-Gm-Message-State: AOJu0YwHMqurEf2fA+XQlzXh8piF6haL2vtttU1MwReCuW33GDOJ/UJH
 3QVLZ1OeWebz31+CuWRfe/qMNu8PaKULanPHtLVbjy92hdwXWxsjp8pEmFCWsw08UIszeCZyfsv
 C
X-Google-Smtp-Source: AGHT+IFm9KuqQqNq9aT6ny+LUbYVLSUWoQFkvMwvfJ/oAE6vTyAXBppBKMu65sgh1TXQS48mMW+cqA==
X-Received: by 2002:a05:6870:9e4d:b0:254:c512:88c6 with SMTP id
 586e51a60fabf-2692b8616edmr2411700fac.51.1723134034965; 
 Thu, 08 Aug 2024 09:20:34 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-236.totalplay.net.
 [187.191.8.236]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70a31d9dff9sm5527913a34.2.2024.08.08.09.20.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 09:20:33 -0700 (PDT)
Date: Thu, 8 Aug 2024 10:20:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v8 22/23] test/py: add HTTP (wget) test for the EFI loader
Message-ID: <20240808162030.GP1626301@bill-the-cat>
References: <cover.1723050310.git.jerome.forissier@linaro.org>
 <9b055b18f84755d775bf0cf4064e66801608839c.1723050310.git.jerome.forissier@linaro.org>
 <20240807175740.GH1626301@bill-the-cat>
 <fbe3c688-1d3a-4e07-8e20-1cefe1989752@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HRDB3oIPOTXu0YSX"
Content-Disposition: inline
In-Reply-To: <fbe3c688-1d3a-4e07-8e20-1cefe1989752@linaro.org>
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


--HRDB3oIPOTXu0YSX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2024 at 03:06:05PM +0200, Jerome Forissier wrote:
>=20
>=20
> On 8/7/24 19:57, Tom Rini wrote:
> > On Wed, Aug 07, 2024 at 07:12:06PM +0200, Jerome Forissier wrote:
> >> Add a test to test_efi_loader.py similar to the TFTP test but for HTTP
> >> with the wget command.
> >>
> >> Suggested-by: Tom Rini <trini@konsulko.com>
> >> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> >> ---
> >>  test/py/tests/test_efi_loader.py | 52 +++++++++++++++++++++++---------
> >>  1 file changed, 37 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/test/py/tests/test_efi_loader.py b/test/py/tests/test_efi=
_loader.py
> >> index 85473a9049b..64c994fdf95 100644
> >> --- a/test/py/tests/test_efi_loader.py
> >> +++ b/test/py/tests/test_efi_loader.py
> >> @@ -50,6 +50,8 @@ env__efi_loader_helloworld_file =3D {
> >>  import pytest
> >>  import u_boot_utils
> >> =20
> >> +PROTO_TFTP, PROTO_HTTP =3D range(0, 2)
> >> +
> >>  net_set_up =3D False
> >> =20
> >>  def test_efi_pre_commands(u_boot_console):
> >> @@ -110,10 +112,10 @@ def test_efi_setup_static(u_boot_console):
> >>      global net_set_up
> >>      net_set_up =3D True
> >> =20
> >> -def fetch_tftp_file(u_boot_console, env_conf):
> >> -    """Grab an env described file via TFTP and return its address
> >> +def fetch_file(u_boot_console, env_conf, proto):
> >> +    """Grab an env described file via TFTP or HTTP and return its add=
ress
> >> =20
> >> -    A file as described by an env config <env_conf> is downloaded fro=
m the TFTP
> >> +    A file as described by an env config <env_conf> is downloaded fro=
m the
> >>      server. The address to that file is returned.
> >>      """
> >>      if not net_set_up:
> >> @@ -128,7 +130,13 @@ def fetch_tftp_file(u_boot_console, env_conf):
> >>          addr =3D u_boot_utils.find_ram_base(u_boot_console)
> >> =20
> >>      fn =3D f['fn']
> >> -    output =3D u_boot_console.run_command('tftpboot %x %s' % (addr, f=
n))
> >> +    if proto =3D=3D PROTO_TFTP:
> >> +        cmd =3D 'tftpboot'
> >> +    elif proto =3D=3D PROTO_HTTP:
> >> +        cmd =3D 'wget'
> >> +    else:
> >> +        assert False
> >> +    output =3D u_boot_console.run_command('%s %x %s' % (cmd, addr, fn=
))
> >>      expected_text =3D 'Bytes transferred =3D '
> >>      sz =3D f.get('size', None)
> >>      if sz:
> >> @@ -147,16 +155,8 @@ def fetch_tftp_file(u_boot_console, env_conf):
> >> =20
> >>      return addr
> >> =20
> >> -@pytest.mark.buildconfigspec('of_control')
> >> -@pytest.mark.buildconfigspec('cmd_bootefi_hello_compile')
> >> -def test_efi_helloworld_net(u_boot_console):
> >> -    """Run the helloworld.efi binary via TFTP.
> >> -
> >> -    The helloworld.efi file is downloaded from the TFTP server and is=
 executed
> >> -    using the fallback device tree at $fdtcontroladdr.
> >> -    """
> >> -
> >> -    addr =3D fetch_tftp_file(u_boot_console, 'env__efi_loader_hellowo=
rld_file')
> >> +def do_test_efi_helloworld_net(u_boot_console, proto):
> >> +    addr =3D fetch_file(u_boot_console, 'env__efi_loader_helloworld_f=
ile', proto)
> >> =20
> >>      output =3D u_boot_console.run_command('bootefi %x' % addr)
> >>      expected_text =3D 'Hello, world'
> >> @@ -164,6 +164,28 @@ def test_efi_helloworld_net(u_boot_console):
> >>      expected_text =3D '## Application failed'
> >>      assert expected_text not in output
> >> =20
> >> +@pytest.mark.buildconfigspec('of_control')
> >> +@pytest.mark.buildconfigspec('cmd_bootefi_hello_compile')
> >> +def test_efi_helloworld_net_tftp(u_boot_console):
> >> +    """Run the helloworld.efi binary via TFTP.
> >> +
> >> +    The helloworld.efi file is downloaded from the TFTP server and is=
 executed
> >> +    using the fallback device tree at $fdtcontroladdr.
> >> +    """
> >> +
> >> +    do_test_efi_helloworld_net(u_boot_console, PROTO_TFTP);
> >> +
> >> +@pytest.mark.buildconfigspec('of_control')
> >> +@pytest.mark.buildconfigspec('cmd_bootefi_hello_compile')
> >> +def test_efi_helloworld_net_http(u_boot_console):
> >> +    """Run the helloworld.efi binary via HTTP.
> >> +
> >> +    The helloworld.efi file is downloaded from the HTTP server and is=
 executed
> >> +    using the fallback device tree at $fdtcontroladdr.
> >> +    """
> >> +
> >> +    do_test_efi_helloworld_net(u_boot_console, PROTO_HTTP);
> >> +
> >>  @pytest.mark.buildconfigspec('cmd_bootefi_hello')
> >>  def test_efi_helloworld_builtin(u_boot_console):
> >>      """Run the builtin helloworld.efi binary.
> >> @@ -185,7 +207,7 @@ def test_efi_grub_net(u_boot_console):
> >>      executed.
> >>      """
> >> =20
> >> -    addr =3D fetch_tftp_file(u_boot_console, 'env__efi_loader_grub_fi=
le')
> >> +    addr =3D fetch_file(u_boot_console, 'env__efi_loader_grub_file', =
PROTO_TFTP)
> >> =20
> >>      u_boot_console.run_command('bootefi %x' % addr, wait_for_prompt=
=3DFalse)
> >=20
> > Looking at this now that I've added wget to my Pi builds, erm:
> > U-Boot> wget 200000 EFI/arm64/helloworld.efi
> >=20
> > That's not going to work. That's what works fine for a tftp server. I
> > think the test is going to need to require some http specific
> > configuration added (and I'll locally start firing off the python
> > trivial http server or something, for tests).
>=20
> It should work because 'wget <addr> <file>' is a valid syntax for the leg=
acy
> wget as well as for the new one, now that I have added support for it. It
> takes the address of the http server from ${serverip}. Of course you need=
 a
> http server listening on the same host as the tfp server, yes.
> I have tested this on the RPi3.

OK, so problem. This is intermittent (first I saw it on rpi_3_32b built with
clang (LLVM-17) and lwIP and the second was rpi_3_32b with gcc and lwIP):
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D FAILURES =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
________________________________ test_efi_helloworld_net_http _____________=
____________________
test/py/tests/test_efi_loader.py:187: in test_efi_helloworld_net_http
    do_test_efi_helloworld_net(u_boot_console, PROTO_HTTP);
test/py/tests/test_efi_loader.py:159: in do_test_efi_helloworld_net
    addr =3D fetch_file(u_boot_console, 'env__efi_loader_helloworld_file', =
proto)
test/py/tests/test_efi_loader.py:139: in fetch_file
    output =3D u_boot_console.run_command('%s %x %s' % (cmd, addr, fn))
test/py/u_boot_console_base.py:288: in run_command
    raise Exception('Bad pattern found on console: ' +
E   Exception: Bad pattern found on console: error_please_reset
------------------------------------ Captured stdout call -----------------=
--------------------
U-Boot> wget 200000 EFI/arm/helloworld.efi
2320 bytes transferred in 0 ms (### ERROR ### Please RESET the board ###
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D short test summary info =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

My first guess is the "in 0 ms" leads to a divide by zero later on?

--=20
Tom

--HRDB3oIPOTXu0YSX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma08EgACgkQFHw5/5Y0
tywkqgwAki7pkkQWumZnLdPnlWRMkLTGp91iQzTndNySrkR3/tZNd/uVrpf4coUp
JqmXuLmCGGlOY6VFLjFjYlDc6MGavQsSa+A++MK5eiqAlnTVLvX97J0rHIMqtO+S
VvL/CT/3kI+1W5wRNKk1E+npx4Jg9C0aYl3kJr9xP8Vm2gWwerrxfblERNlxB4bL
B65hFKfPOdO5ykgRVOfM1kPofc0V8yFHui1LBBxM+wtDneJHR9ciXCMD0p9aTHNu
6NSUQujHwv2mXBRUtEhHSrc+1vu6vKASCy0xdtC16rkm5cHLcKwk72+FRAFiLzvY
M+qgfs6ZQ9NoqP4q2S88hNRB8v57OKaI7NVjZXcd5nkW/8BIIdYnjjUx1Mj31uhV
JygzYitBF3/vpRNnXFqK51CNKPXcEA47BMJRQ/pt3wD9rzMi4dKc+1eI6LTsqFeY
Z7NduWkLfUL3hZC2Hd2gNjbsT3k/QL1iNUcweqaDa/hXhnRCo/thTLccw0zok1wG
NtOkI82Q
=tAlE
-----END PGP SIGNATURE-----

--HRDB3oIPOTXu0YSX--
