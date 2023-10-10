Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 338BECD8C89
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 14:20:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99D0286CAC;
	Tue, 10 Oct 2023 16:19:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dpC8YaHV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3AF786459; Tue, 10 Oct 2023 16:19:35 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 095F386CAC
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 16:19:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5a7a77e736dso18922647b3.1
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 07:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696947554; x=1697552354; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=n/qdy1F+tWgfGBIBiMShRorVg4YGEIWoctJYKQ+nwZ8=;
 b=dpC8YaHV3wt5L5cFsKium/PNgoSKtcvOmcDOLCftj5DAp523JwUEDziocOsq/nAprW
 qNh8Jinz7RmNcGh70MV+w/i+SDjUOD5YroituEE99exWckmYXPzmwqw91/E+9OfRAgNS
 /MqTBEsqafX56LYHn/jNldjcs/IBbg/k90/DA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696947554; x=1697552354;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n/qdy1F+tWgfGBIBiMShRorVg4YGEIWoctJYKQ+nwZ8=;
 b=O+C7Z5epgoRUtWvLa2rM64+2REHZSh6D5HiyGZG3K64MuFoEY4nfKAYDrtTMK6f6uG
 J1or8jD/vFlqVs61SKKlNUxaoGyxsOjEg//dkDaj8hEKIr8gd+MvPtUWtELZHDfSq71a
 kztHW3vLQLC8L+o3rRnL5p+hjdzZspvkVitFovd8fhIh5E3ajAamlrM9tabCErS5SVrt
 +UyxLMeg1UnSwm7Jwg9PdBXRQ0h3ET/omccIGBtg5/w7+AHG81l8DYVl8qZ1skWrabf9
 rh3iD3w6oUVnf0MoA2s+fxQYCyn9Z/7VkdwLiOvWFDCqO02kbgvbxFUG46sY32DGUrUB
 vEFA==
X-Gm-Message-State: AOJu0YxxXKslJc80uoDjgKKwiqwAIgUn9PIGpoVD6iRHufQLcvNRpfu+
 ZAf6cv8pMKRTcm3iixrlgJ0oHT4ZHs0qVOOnn7Xp4w==
X-Google-Smtp-Source: AGHT+IFu6gOxl5Xvj8LnH4nMU+ddGkn4jmOSLwGyc6ou0hKy9wJu5rI1t/EeD4XXBaGc+3c3lBr0Qg==
X-Received: by 2002:a81:ab42:0:b0:5a1:e4bf:ee5a with SMTP id
 d2-20020a81ab42000000b005a1e4bfee5amr18252086ywk.41.1696947553767; 
 Tue, 10 Oct 2023 07:19:13 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6c43-4eba-c113-e8cd.res6.spectrum.com.
 [2603:6081:7b00:6400:6c43:4eba:c113:e8cd])
 by smtp.gmail.com with ESMTPSA id
 h16-20020a816c10000000b005a7bf2aff15sm515868ywc.95.2023.10.10.07.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 07:19:12 -0700 (PDT)
Date: Tue, 10 Oct 2023 10:19:09 -0400
From: Tom Rini <trini@konsulko.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: sjg@chromium.org, etienne.carriere@st.com, u-boot@lists.denx.de
Subject: Re: [PATCH v5 00/16] firmware: scmi: add SCMI base protocol support
Message-ID: <20231010141909.GA5325@bill-the-cat>
References: <20230926065750.734440-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PVBKZ2aHO+8J4P1+"
Content-Disposition: inline
In-Reply-To: <20230926065750.734440-1-takahiro.akashi@linaro.org>
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


--PVBKZ2aHO+8J4P1+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023 at 03:57:34PM +0900, AKASHI Takahiro wrote:

> This patch series allows users to access SCMI base protocol provided by
> SCMI server (platform). It will also be utilized in separate patches
> in the future to add sanity/validity checks for other protocols.
> See SCMI specification document v3.2 beta[1] for more details about SCMI
> base protocol.
>=20
> What is currently not implemented is
> - SCMI_BASE_NOTIFY_ERRORS command and notification callback mechanism
>=20
> This feature won't be very useful in the current U-Boot environment.
>=20
> [1] https://developer.arm.com/documentation/den0056/e/?lang=3Den
>=20
>=20
> Test
> =3D=3D=3D=3D
> The patch series was tested on the following platforms:
> * sandbox
> * qemu-arm64 with OPTEE as SCMI server

I have two problems.  The first is that for sandbox, this series is not
bisectable as a commits fail to build due to needing a definition in the
test before it's added:
/home/uboot/work/u-boot/u-boot/test/dm/scmi.c: In function 'dm_test_scmi_cl=
ocks':
/home/uboot/work/u-boot/u-boot/test/dm/scmi.c:117:21: warning: implicit dec=
laration of function 'scmi_get_protocol' [-Wimplicit-function-declaration]
  117 |         clock_dev =3D scmi_get_protocol(agent_dev, SCMI_PROTOCOL_ID=
_CLOCK);
      |                     ^~~~~~~~~~~~~~~~~
/home/uboot/work/u-boot/u-boot/test/dm/scmi.c:117:50: error: 'SCMI_PROTOCOL=
_ID_CLOCK' undeclared (first use in this function)
  117 |         clock_dev =3D scmi_get_protocol(agent_dev, SCMI_PROTOCOL_ID=
_CLOCK);
      |                                                  ^~~~~~~~~~~~~~~~~~=
~~~~
/home/uboot/work/u-boot/u-boot/test/dm/scmi.c:117:50: note: each undeclared=
 identifier is reported only once for each function it appears in
/home/uboot/work/u-boot/u-boot/test/dm/scmi.c: In function 'dm_test_scmi_re=
sets':
/home/uboot/work/u-boot/u-boot/test/dm/scmi.c:182:50: error: 'SCMI_PROTOCOL=
_ID_RESET_DOMAIN' undeclared (first use in this function)
  182 |         reset_dev =3D scmi_get_protocol(agent_dev, SCMI_PROTOCOL_ID=
_RESET_DOMAIN);
      |                                                  ^~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~
make[4]: *** [/home/uboot/work/u-boot/u-boot/scripts/Makefile.build:256: te=
st/dm/scmi.o] Error 1

Second, the series causes this failure:
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
test/py/tests/test_ut.py:497: in test_ut
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
  # of protocols: 3
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
SCMI device: ?n
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D short test summary info =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
FAILED test/py/tests/test_ut.py::test_ut[ut_dm_dm_test_scmi_cmd] - ValueErr=
or: U-Boot exited...

Which I believe CI will also produce, once the issue with htmldocs is
fixed.  I can't bisect it exactly as the failure shows up once the new
test is added.

--=20
Tom

--PVBKZ2aHO+8J4P1+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUlXV0ACgkQFHw5/5Y0
tyz/cwwAjoMsH5WY3OAtfLoq+5khcb5xo3yLGJJZlJbuy56Ap8Rx3VYfQT8G/tM2
rp/a6BYOde8xAGan2ky4rtmeceRLYreHAkMHOcj4IS8VtFlZC91Azcy5ECrPCv7Y
AVRr85kem1UZ1bR6zZVIoBF9rLVI2CF+WIhfFprfWZxR2hAitQ4FPKOCDNsg7Qv9
VAMr80DlbJOlji6CriBpe+Huob4XCj/gvSF68SB8fEK0oCmD7VJZCA2Oz07L46i+
vaHUh5Ksg6rqPbCKdVxxMoELX3bPqXivtgShZVJopoHx83NpjHMYtYPxg4KkUi5e
wKQT7Lt7mPbswTJojwwSYZxVv2cZGXvuRwRGFnt9VI5N2s5h5pcnlDyXP1TDR/3M
++x39zWrgQia5m6p5Hm+kmQoZmM00z0sXMR2iabWHS9VIg4IhmVE+eMuTZ4sHz/D
2+pW4WNWc4uy9BE3s1S2AfX3uA8o9Bs6LYQRJM5bO658cfRMgrlBr8zmv3+g2WQ6
oyr/ZoZh
=PUON
-----END PGP SIGNATURE-----

--PVBKZ2aHO+8J4P1+--
