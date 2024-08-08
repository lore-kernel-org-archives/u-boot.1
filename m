Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7E2C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 15:52:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7A7C887D3;
	Thu,  8 Aug 2024 17:52:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tc/oGb2k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE4B488B6B; Thu,  8 Aug 2024 17:52:24 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E7968857D
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 17:52:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3db157cb959so785419b6e.0
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 08:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723132340; x=1723737140; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Bkpvt8ZN59WXduS9fyOnDrnJraP6oEhz5fNbBmqRnog=;
 b=tc/oGb2kJ1g+cdvrj47dDUl8/wuIam6LWajjZ7s07/ky+iEFaljx0XMTpKl3x+DNtv
 TVbtA6RthDBVvkGL4q+IBk7PRPys4tl7b2nggoex7NrhEaQVHgHudTR2qcJcGVW5xEez
 rymEZ04fIL8BFOyuHk70eUuDNKfbLaMg86opU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723132340; x=1723737140;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bkpvt8ZN59WXduS9fyOnDrnJraP6oEhz5fNbBmqRnog=;
 b=G1ygzuNcPHUpt2sSL9KPMvvsDVDuElU+1VDwtsZRjhd32SOfbaSwGKTNCA3xkTyQPp
 0Di7sy/mAPgXNs7/tkT45WS5b9nFLD2hpJQIH8gnU8u/XBOLV+Y+7RhMOpGD3D6IogOF
 em4a7R7skd5r28GxhVhNvL02v1aO69EdnNb5s2Fk9UDK4LBpm8Vm+j46EK48EWIWjd/x
 tHoAdB+Q3MHYV5Q7mSx/PcNbXXbNUfTqsaJFnswXWpaXaHj3Hdzc5/johbVajrIiAXPK
 r49zTB3fVk7CL/qRV4S7sMahDfE+ZR7+GfOGK8lVndn3/MDcNakqUXzjQqKEtyUlPU5/
 PX9Q==
X-Gm-Message-State: AOJu0YwEgrJSVJcmfzIXVtoGcoeozuCv6tdN+IytSbFpIQ9xzZ/71OoZ
 pCf7oC4rHe/MNQnCbUpeIrdMOmqKDhvvgeH6ZtiqgK/NEuZ3UWACYTsoJALuCSk=
X-Google-Smtp-Source: AGHT+IHVJdi2YIq1iLGyPcO9+wMF/X07ajRdTJc5+BAMRysXabAiQ0V3TTEj1bomG6uvXq2DuuzGag==
X-Received: by 2002:a05:6808:140e:b0:3db:2865:ca41 with SMTP id
 5614622812f47-3dc3b4617d1mr2595686b6e.46.1723132340269; 
 Thu, 08 Aug 2024 08:52:20 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-236.totalplay.net.
 [187.191.8.236]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db5637b670sm4987284b6e.32.2024.08.08.08.52.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 08:52:19 -0700 (PDT)
Date: Thu, 8 Aug 2024 09:52:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v8 22/23] test/py: add HTTP (wget) test for the EFI loader
Message-ID: <20240808155217.GO1626301@bill-the-cat>
References: <cover.1723050310.git.jerome.forissier@linaro.org>
 <9b055b18f84755d775bf0cf4064e66801608839c.1723050310.git.jerome.forissier@linaro.org>
 <20240807175740.GH1626301@bill-the-cat>
 <fbe3c688-1d3a-4e07-8e20-1cefe1989752@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EmwF6Y2qlaHiiMGV"
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


--EmwF6Y2qlaHiiMGV
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

Oh, neat, OK, thanks. The lack of error message was confusing, does lwIP
wget say something when it fails to fetch? Throwing the trivial http
server up lets me pass the test.

Tested-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--EmwF6Y2qlaHiiMGV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma06bEACgkQFHw5/5Y0
tyypTAv7BQOmUZ2wUH0Taks6goyr4NnOqogGPWU402+c/Vr5JP1qvv4z7CVCeIQA
0xVmMI71LNu17xTKf6t5R8HEkuCDDo690eYvjRaD9z2tF3oT8zU9CQWqWXH/zSr7
sUfa6abqcXSqrqxDag6se/pOQwKVdXL9fhL+w7FClvG8ymK9tq1Ek7JlhjdpOtru
1kjLvifw04IGZPQZyotRVt4NSJAUd/DZ15Ns2AMFHcKxd6+jj737jeHUBTEReamj
CH44hx1BWYDaTxPtz2qCeSv77zMu0HvPd0/zwfKlaEJYQKmkqNkcJmT8bIYqQgdo
wpYA+nsm/fFw9rBFBL8BWEMilMDjkk2JZboNEYO3SZq3LUYJn89g0D8l45yrnTba
iG0xqlzQLcIZtsxFP+pWHUkOMGAOJIoEjdY9qn7SPUeuwYJoyrYaThC1d1BTcEao
ZBrQr4v4PFRhM8NHEXNRsWV9LhuvTfBW4HvvjiCQhi+ft988PJNRmcHn2j1BXOMA
uAQLvve/
=6OXg
-----END PGP SIGNATURE-----

--EmwF6Y2qlaHiiMGV--
