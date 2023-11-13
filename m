Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 289A6C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 01:46:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C65BC86B9A;
	Mon, 13 Nov 2023 02:46:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GUhUwaj5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B890586A4C; Mon, 13 Nov 2023 02:46:23 +0100 (CET)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1A1286A4C
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 02:46:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6bcef66f9caso678382b3a.0
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 17:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699839977; x=1700444777; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oIm1ox74onmt98qjUSRqoWgdAOK3GUZWQfBKhTWasy8=;
 b=GUhUwaj5Y0lEqMcwIGQLiD8syjG6kad7pRgEC1rm45UzbJsmjyTT+eiEPKnUY7mI+4
 UvAvSBiGfmqKyq+y3FFg71QSQascDVYDSi6hm9Aa0z97TP40W5bs0U/CKCdO6Ou4wr7r
 ssjniYZcJ0lOKWBpwh4R8Mr4VG2igznqQV/ZH5JQM/rA+xDSavr78Qxd0+27wBsrdzq5
 sLJZ2IWcIiaWFIswEoPbZvf/Ez9Ii40RdRsAyk9nA7CRWWIPDEk6J2XcEsEYFF4wPG0X
 2XNttDrtzLH5oBzPdXGNf8JQhQqNYMEDsvnoAgqhDZTx+5OvtezjyYxt24DgTdH/I0fZ
 ZLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699839977; x=1700444777;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oIm1ox74onmt98qjUSRqoWgdAOK3GUZWQfBKhTWasy8=;
 b=nkKXqVpHUJwUZaDIUQvYId+CkNIWKVRzMphPgkozrdCikUKZy3PK9z38ilt0TDhLRY
 CfXg5ZiiaayGPhNeDPfzq2/6LxbUwecC9/T21UZdH/6rUFA8wWScVGSCK3eIuvCaDFAU
 SK9YvZldiMMHDlydVNtpCjGUlx8fzIYVK501s68SWRzvsIZjzmECHvF2CMEfFEWayG8l
 fHNOYIyG5ROgDIfq6v+h7gDkYVzCFWa9g2nAwBnCdQj9zX2osSzJN7/Ln6EMro+oG3/W
 vXck47PYGtAH6zV3x2zuY/YW2P1VYo7QSz6g/8jkgHDUe9CE/ILDimifHBfMNbRyBjqH
 QrWA==
X-Gm-Message-State: AOJu0YzcZKR7lC2GIZeJG7irB1IVcjjhRXCmtU+9rhVmJnRegflXnYtB
 Q5GYzVdDJvdfB2cMuv/WKqyfRQ==
X-Google-Smtp-Source: AGHT+IGsHWxaVOioLD8QB7RDNBSIHknZJQPHshWlPQycm9/KWXz3w5bN8UYLSiv2DkTRC3z06PAcYw==
X-Received: by 2002:a05:6a21:7893:b0:183:e7bb:591b with SMTP id
 bf19-20020a056a21789300b00183e7bb591bmr6392394pzc.3.1699839977127; 
 Sun, 12 Nov 2023 17:46:17 -0800 (PST)
Received: from octopus ([2400:4050:c3e1:100:ba59:509b:48bc:9f1])
 by smtp.gmail.com with ESMTPSA id
 ja13-20020a170902efcd00b001c73f3a9b7fsm3088237plb.185.2023.11.12.17.46.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 17:46:16 -0800 (PST)
Date: Mon, 13 Nov 2023 10:46:13 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: sjg@chromium.org, etienne.carriere@st.com, michal.simek@amd.com,
 u-boot@lists.denx.de, Etienne Carriere <etienne.carriere@foss.st.com>
Subject: Re: [PATCH 5/5] test: dm: add scmi command test
Message-ID: <ZVF/5cYQJzj08aI9@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Tom Rini <trini@konsulko.com>, sjg@chromium.org,
 etienne.carriere@st.com, michal.simek@amd.com, u-boot@lists.denx.de,
 Etienne Carriere <etienne.carriere@foss.st.com>
References: <20231025051427.509602-1-takahiro.akashi@linaro.org>
 <20231025051427.509602-6-takahiro.akashi@linaro.org>
 <20231110182137.GA3824573@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="llWMiJbMhIKYpMi8"
Content-Disposition: inline
In-Reply-To: <20231110182137.GA3824573@bill-the-cat>
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


--llWMiJbMhIKYpMi8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tom,

On Fri, Nov 10, 2023 at 01:21:37PM -0500, Tom Rini wrote:
> On Wed, Oct 25, 2023 at 02:14:27PM +0900, AKASHI Takahiro wrote:
>=20
> > In this test, "scmi" command is tested against different sub-commands.
> > Please note that scmi command is for debug purpose and is not intended
> > in production system.
> >=20
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>
>=20
> The test part of this still fails:
> https://source.denx.de/u-boot/u-boot/-/jobs/732077
>=20
> I don't know why more output wasn't captured, when I run it locally
> instead I get:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D FAILURES =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> _______________________________ test_ut[ut_dm_dm_test_scmi_cmd] _________=
______________________
> test/py/u_boot_spawn.py:195: in expect
>     c =3D os.read(self.fd, 1024).decode(errors=3D'replace')
> E   OSError: [Errno 5] Input/output error
>=20
> During handling of the above exception, another exception occurred:
> test/py/tests/test_ut.py:502: in test_ut
>     output =3D u_boot_console.run_command('ut ' + ut_subtest)
> test/py/u_boot_console_base.py:266: in run_command
>     m =3D self.p.expect([self.prompt_compiled] + self.bad_patterns)
> test/py/u_boot_spawn.py:204: in expect
>     raise ValueError('U-Boot exited with %s' % info)
> E   ValueError: U-Boot exited with signal 11 (SIGSEGV)


The command uses global variables which hold pointers to 'struct udevice'
which are to be shared between the main and the sub-commands.
Since pytest framework executes ut tests twice, once with a (normal?) device
tree and once with a flat tree,  udevices will be *voided* between
two executions.

I will fix it in v2.

Thanks,
-Takahiro Akashi


> ------------------------------------ Captured stdout call ---------------=
----------------------
> =3D> ut dm dm_test_scmi_cmd
> Test: dm_test_scmi_cmd: scmi.c
> SCMI device: scmi
>   protocol version: 0x20000
>   # of agents: 2
>       0: platform
>     > 1: OSPM
>   # of protocols: 4
>       Power domain management
>       Clock management
>       Reset domain management
>       Voltage domain management
>   vendor: U-Boot
>   sub vendor: Sandbox
>   impl version: 0x1
> Denying access to device:0 failed (-13)
> Denying access to protocol:0x14 on device:0 failed (-13)
> Reset failed (-13)
> Test: dm_test_scmi_cmd: scmi.c (flat tree)
> SCMI device: Q
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D short test summary info =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> FAILED test/py/tests/test_ut.py::test_ut[ut_dm_dm_test_scmi_cmd] - ValueE=
rror: U-Boot exited...
>=20
> --=20
> Tom



--llWMiJbMhIKYpMi8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEjc56F+RxEkavfJvIJ6vpGq1myG0FAmVRf+AACgkQJ6vpGq1m
yG3DUQf/XJ/gHYeadrgIOCWaFxbE0UtPfbgxqU6RoLtVHfyQejo13jcY2zIcfY/q
t8iqUFr8SvuvYTBt2SYbGRxbr4MSPLmkqWqlgGK/WAjw732ZSBe++jGG59ZNnKNL
CYCxLGDgDKgKMFKMjACnP1kuFVYZcGb/abto17cc918sPN4WxwSYq0pS7ymnqPBg
7OyG6wh4uXLXJtUYHdk6dd4/RZyLDPA7iNf5WBbRQfmU2c21Xc1WJk8VCeCieRey
yvoG5TBMCieiJvcQYXxkLpSxLyE9pwSv23rv1n1Wk/rpf7MIFX/OM2MuI0SS3ovZ
1LnZsyUhFjpD8Qnr7hSpAKevZ1yScA==
=FkYu
-----END PGP SIGNATURE-----

--llWMiJbMhIKYpMi8--
