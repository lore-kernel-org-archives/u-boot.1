Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E83C4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 18:21:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 088E18782A;
	Fri, 10 Nov 2023 19:21:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="M+xFb/nG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D1BC8782E; Fri, 10 Nov 2023 19:21:44 +0100 (CET)
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com
 [IPv6:2607:f8b0:4864:20::e35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92E11874B7
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 19:21:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-45e777af839so1044435137.3
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 10:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699640500; x=1700245300; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lHW2KoX0S9eoWozlpfWtfsSfbGpQ16VFenzdqwpB9KI=;
 b=M+xFb/nGPCl41zFT04yRRkckBOIXtBwp92N6uiKDv4UPisUzd50O6irxQBp5P33zw0
 LfRf6QPNjqWmpYkduSyw+LCBMXDgALXBainkVaD5pxBOxK1PvskBZR2i8RS1ioB2vQkI
 bKY0hbOPz1zl2BCbvzEK8Q+BonE1D2l7i7eFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699640500; x=1700245300;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lHW2KoX0S9eoWozlpfWtfsSfbGpQ16VFenzdqwpB9KI=;
 b=iPoFUgPq4hKto3DGGkISYkyptUA0h/e37LyAm47Do0aUtlJy4BiRZYMkZ0wxWrQVYr
 FVgccP7x7v7oqbxoogaxX7iaWt5vkaI0W26yUqS9mShWbC9CZLc2mlVm23xWu34idsfP
 oaELLl7EpQuYBbwRJEeDkBndU/lDSXHjn1fVaGnxcB3HffKEVhqObBw8uybg9l7WB4W3
 aSorosNrgh+O4CFwXmSZVOBm3BQGGeUt3c+Ovk7/2lFa9ahL4V9rMRCMPdNXAxExOcGn
 dp8O9kV5Q+4GvUUAlURO5yRzvRF9xuguczRni4fI2yexhqnpH7wlAgffaIJZxZTnqbrj
 NZxg==
X-Gm-Message-State: AOJu0YzGrgl5SzGUZba2iaq/EtqqFd+tyKIliUxng24GcPOd9EFarleF
 6jqcgfoCVrK9fS+/RZ8bjs6mkw==
X-Google-Smtp-Source: AGHT+IFYKYSlqX0LtwekkauGtAaBXKqad8rPkEqPjzjU4pJfvVnIe/6hHnqxvFlrarGqKPcR0wcerA==
X-Received: by 2002:a05:6102:1009:b0:45f:77f5:a60a with SMTP id
 q9-20020a056102100900b0045f77f5a60amr147449vsp.33.1699640499974; 
 Fri, 10 Nov 2023 10:21:39 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-046c-8850-3cc9-4453.res6.spectrum.com.
 [2603:6081:7b00:6400:46c:8850:3cc9:4453])
 by smtp.gmail.com with ESMTPSA id
 j16-20020a0cc350000000b00670867d7bdfsm18368qvi.122.2023.11.10.10.21.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 10:21:39 -0800 (PST)
Date: Fri, 10 Nov 2023 13:21:37 -0500
From: Tom Rini <trini@konsulko.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: sjg@chromium.org, etienne.carriere@st.com, michal.simek@amd.com,
 u-boot@lists.denx.de, Etienne Carriere <etienne.carriere@foss.st.com>
Subject: Re: [PATCH 5/5] test: dm: add scmi command test
Message-ID: <20231110182137.GA3824573@bill-the-cat>
References: <20231025051427.509602-1-takahiro.akashi@linaro.org>
 <20231025051427.509602-6-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="586n1biuiplz75jy"
Content-Disposition: inline
In-Reply-To: <20231025051427.509602-6-takahiro.akashi@linaro.org>
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


--586n1biuiplz75jy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 02:14:27PM +0900, AKASHI Takahiro wrote:

> In this test, "scmi" command is tested against different sub-commands.
> Please note that scmi command is for debug purpose and is not intended
> in production system.
>=20
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>

The test part of this still fails:
https://source.denx.de/u-boot/u-boot/-/jobs/732077

I don't know why more output wasn't captured, when I run it locally
instead I get:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D FAILURES =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
_______________________________ test_ut[ut_dm_dm_test_scmi_cmd] ___________=
____________________
test/py/u_boot_spawn.py:195: in expect
    c =3D os.read(self.fd, 1024).decode(errors=3D'replace')
E   OSError: [Errno 5] Input/output error

During handling of the above exception, another exception occurred:
test/py/tests/test_ut.py:502: in test_ut
    output =3D u_boot_console.run_command('ut ' + ut_subtest)
test/py/u_boot_console_base.py:266: in run_command
    m =3D self.p.expect([self.prompt_compiled] + self.bad_patterns)
test/py/u_boot_spawn.py:204: in expect
    raise ValueError('U-Boot exited with %s' % info)
E   ValueError: U-Boot exited with signal 11 (SIGSEGV)
------------------------------------ Captured stdout call -----------------=
--------------------
=3D> ut dm dm_test_scmi_cmd
Test: dm_test_scmi_cmd: scmi.c
SCMI device: scmi
  protocol version: 0x20000
  # of agents: 2
      0: platform
    > 1: OSPM
  # of protocols: 4
      Power domain management
      Clock management
      Reset domain management
      Voltage domain management
  vendor: U-Boot
  sub vendor: Sandbox
  impl version: 0x1
Denying access to device:0 failed (-13)
Denying access to protocol:0x14 on device:0 failed (-13)
Reset failed (-13)
Test: dm_test_scmi_cmd: scmi.c (flat tree)
SCMI device: Q
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D short test summary info =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
FAILED test/py/tests/test_ut.py::test_ut[ut_dm_dm_test_scmi_cmd] - ValueErr=
or: U-Boot exited...

--=20
Tom

--586n1biuiplz75jy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVOdKsACgkQFHw5/5Y0
tyzk2AwAtKuOJBbLkbM41Nd8KAd08K2UtK/6eNmnguquDNGI/pNRlurGP/t5O5Ka
LRQ/p+VwvwLFKZiLGjiMGwRyR72ITkBmMOhVkHeMimYKAk3MlNcexqo9Ro/clUgA
5KbaKsbrptKUfOmJ1PKo4gzRHX9c3dA+i7mnFcGeR0/gXtGhjhFJ+XULk3Iky4hI
u3Cr3iS1QC4sXt4LfuO1O/azKxKbLSbVHrZtOvmBEAdzQU8dlMemAljsGQ0gjuwo
NyxADJ9X7gBauHM1OCPN2r/zZWG/dUMJTQVdU5yZNYm0Ld55JdBP78kSFdC9LNll
q6F/pT5U8OZvZx3ZjlVI6hQkL/i9KfffM1zux4vYQGNMPwemZGeKEfjqIIcaKse8
8GcIn1iz50N9h5a0KJzVWejm/Y5vLwfYB1pWqeIh8wmR0uDILZabiYjgxRL0k38u
TYh0xROXlrev9u9Jbx3zc69+EmHa9qA+1IowF1/Gk8YmiIqdRECNlUdUAqFrsrqX
PPGuXbCM
=GlP4
-----END PGP SIGNATURE-----

--586n1biuiplz75jy--
