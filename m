Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B92CD98E5
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 02:11:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B34886B29;
	Wed, 11 Oct 2023 04:11:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tv11bqpR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 381B786B29; Wed, 11 Oct 2023 04:11:41 +0200 (CEST)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10430864E7
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 04:11:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-d84d883c1b6so433732276.0
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 19:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696990294; x=1697595094; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VzXQY7H7oOkB3qbBpFQZDIliLcKyLrI1EP0XuUU3LpU=;
 b=tv11bqpRKFOBwrdF9dyAn0nkzR7CN6Hc+jC//lf9xyw+lTz6lE6KYpnWFL4RyBeQOv
 b2l2Ovsh14vMquTwTYXWqNbUy4y3uN2GHqeOsodB3OTQMN4xdzQah77sTgoehkcMehqB
 IiBRT9oLRynzOkTd6eEOZqswTv0oiWAT+hA8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696990294; x=1697595094;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VzXQY7H7oOkB3qbBpFQZDIliLcKyLrI1EP0XuUU3LpU=;
 b=GfHf39eFIj5ELmUxdj1+b0f7LzqoExt2HPbTaBcT9koryggcSsG6ZYs20S7IPNhDod
 DgpKm6aiVmLoD8hg9vACu0bp3MF5mmi7dtIG96ak0r3kXO8ToqBOJiuqE25czyD7G6YK
 Cx74KYVkFL5LamY7JuvIIQKzNQyr5s8pj1qeyOaftMpvuTbEQRe+UFdl441ipB76nZ48
 om62xpDR2JWtT5IqZkv5WZXtqLy1YFQ0yBqyFLD52eB/wuje0TCz16UFvxwBKQkeFeWJ
 PnOhiZs6im9WZLZPC4MBqTW6MtULeTA40FNj1CSH2DWQN1L4vXk1+OifghjgeLhQkvwU
 tBsQ==
X-Gm-Message-State: AOJu0YxfWrwBHa8czYH1gV1XAJb7wh3bW5TGT0Z8AwQpWvtN8x1PS4J2
 HbR27pizUpuJWiR8kNuRGY2RnA==
X-Google-Smtp-Source: AGHT+IF1nipv4qYLdVI3Yu75cMz7FJ16d7V7I21+sfY1evrsJfCw6np0/D8/PgxnYOvZQ6bGAeRXcA==
X-Received: by 2002:a25:c713:0:b0:d86:696d:bc0a with SMTP id
 w19-20020a25c713000000b00d86696dbc0amr10796459ybe.29.1696990293742; 
 Tue, 10 Oct 2023 19:11:33 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a369-3392-aca4-1f00.res6.spectrum.com.
 [2603:6081:7b00:6400:a369:3392:aca4:1f00])
 by smtp.gmail.com with ESMTPSA id
 v9-20020a25ab89000000b00bcd91bb300esm4196965ybi.54.2023.10.10.19.11.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 19:11:33 -0700 (PDT)
Date: Tue, 10 Oct 2023 22:11:31 -0400
From: Tom Rini <trini@konsulko.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, sjg@chromium.org,
 etienne.carriere@st.com, u-boot@lists.denx.de
Subject: Re: [PATCH v5 00/16] firmware: scmi: add SCMI base protocol support
Message-ID: <20231011021131.GC3119521@bill-the-cat>
References: <20230926065750.734440-1-takahiro.akashi@linaro.org>
 <20231010141909.GA5325@bill-the-cat> <ZSX8CzGFs9+kv1vE@octopus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pwUdGY/ieDcvNnXS"
Content-Disposition: inline
In-Reply-To: <ZSX8CzGFs9+kv1vE@octopus>
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


--pwUdGY/ieDcvNnXS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2023 at 10:36:11AM +0900, AKASHI Takahiro wrote:
> Hi Tom,
>=20
> On Tue, Oct 10, 2023 at 10:19:09AM -0400, Tom Rini wrote:
> > On Tue, Sep 26, 2023 at 03:57:34PM +0900, AKASHI Takahiro wrote:
> >=20
> > > This patch series allows users to access SCMI base protocol provided =
by
> > > SCMI server (platform). It will also be utilized in separate patches
> > > in the future to add sanity/validity checks for other protocols.
> > > See SCMI specification document v3.2 beta[1] for more details about S=
CMI
> > > base protocol.
> > >=20
> > > What is currently not implemented is
> > > - SCMI_BASE_NOTIFY_ERRORS command and notification callback mechanism
> > >=20
> > > This feature won't be very useful in the current U-Boot environment.
> > >=20
> > > [1] https://developer.arm.com/documentation/den0056/e/?lang=3Den
> > >=20
> > >=20
> > > Test
> > > =3D=3D=3D=3D
> > > The patch series was tested on the following platforms:
> > > * sandbox
> > > * qemu-arm64 with OPTEE as SCMI server
> >=20
> > I have two problems.  The first is that for sandbox, this series is not
> > bisectable as a commits fail to build due to needing a definition in the
> > test before it's added:
> > /home/uboot/work/u-boot/u-boot/test/dm/scmi.c: In function 'dm_test_scm=
i_clocks':
> > /home/uboot/work/u-boot/u-boot/test/dm/scmi.c:117:21: warning: implicit=
 declaration of function 'scmi_get_protocol' [-Wimplicit-function-declarati=
on]
> >   117 |         clock_dev =3D scmi_get_protocol(agent_dev, SCMI_PROTOCO=
L_ID_CLOCK);
> >       |                     ^~~~~~~~~~~~~~~~~
>=20
> [snip]
>=20
> Ah, I didn't notice this dependency.
> I will fix it by re-ordering the commits.
>=20
> > Second, the series causes this failure:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D FAILURES =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > _______________________________ test_ut[ut_dm_dm_test_scmi_cmd] _______=
________________________
> > test/py/u_boot_spawn.py:195: in expect
> >     c =3D os.read(self.fd, 1024).decode(errors=3D'replace')
> > E   OSError: [Errno 5] Input/output error
> >=20
> > During handling of the above exception, another exception occurred:
> > test/py/tests/test_ut.py:497: in test_ut
> >     output =3D u_boot_console.run_command('ut ' + ut_subtest)
> > test/py/u_boot_console_base.py:266: in run_command
> >     m =3D self.p.expect([self.prompt_compiled] + self.bad_patterns)
> > test/py/u_boot_spawn.py:204: in expect
> >     raise ValueError('U-Boot exited with %s' % info)
> > E   ValueError: U-Boot exited with signal 11 (SIGSEGV)
> > ------------------------------------ Captured stdout call -------------=
------------------------
> > =3D> ut dm dm_test_scmi_cmd
> > Test: dm_test_scmi_cmd: scmi.c
> > SCMI device: scmi
> >   protocol version: 0x20000
> >   # of agents: 2
> >       0: platform
> >     > 1: OSPM
> >   # of protocols: 3
> >       Clock management
> >       Reset domain management
> >       Voltage domain management
> >   vendor: U-Boot
> >   sub vendor: Sandbox
> >   impl version: 0x1
> > Denying access to device:0 failed (-13)
> > Denying access to protocol:0x14 on device:0 failed (-13)
> > Reset failed (-13)
> > Test: dm_test_scmi_cmd: scmi.c (flat tree)
> > SCMI device: ?n
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D short test summary info =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > FAILED test/py/tests/test_ut.py::test_ut[ut_dm_dm_test_scmi_cmd] - Valu=
eError: U-Boot exited...
>=20
> This seems to happen in the case of "flat tree", but
> I cannot reproduce it in my local environment with
>   $ pytest test/py/tests/test_ut.py -bd sandbox -k scmi_cmd ...

How about if you run all of the tests?  That's how I usually do it, and
CI as well.

> > Which I believe CI will also produce, once the issue with htmldocs is
> > fixed.  I can't bisect it exactly as the failure shows up once the new
> > test is added.
>=20
> Anyhow, "scmi" command is more or less a debug tool for my development.
> All the functionality provided by this patch set is tested at "function"
> level with "ut dm scmi_base" and the command is *not* needed.
> To avoid increasing the maintenance cost, I will drop the command
> (patch #14-#16) in the next version.

OK.  Please make sure CI runs and passes as well, thanks.

--=20
Tom

--pwUdGY/ieDcvNnXS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUmBEoACgkQFHw5/5Y0
tywHGwwAnYzCm3xZsf40KOOKhh/g8/Jr1dBZs2djXQVzZuK2I1uDqJkUm3XoEqr4
6Q+9C29n8LFonXw91cfUFCT7JKWwhSROWJzReC/ovyTwNOZjQhnr0WLMATdr/rJs
QPohHOi7N21PmCFvRLH3zU4WWLwK4rn0rAnhRQO9G8IDUmYJp99li6GenvfLxW5/
csUM9YcPgCHZlV6qDLhHGPky7fiV4ZkNuAP+7ZYN3hNBegxRBCDHjr/Lgs9KZXGL
YOxcruoEWMp88ip8ui1D8yKV+2ETh9XOyVIyIsXrL0ccugiNmLrYKQgJZp1yLHSU
w83pL5QpVeTLHDTOfi6IwJQPl0W2LPjA6G7jh7vOSVDWKMM4HyPPTU+tAydIIahE
J9jzpYORFhnkE+w4qHIp/P+QW/RLWcXegcsJZqKw7JHhooJfFgHFTpuawX7noZkH
GYFHX4hr2cgFnrFRu0JynuNhdKhY4/tR+DkPPEfgMLzE3Se0uC16N07GsdKmsm7R
+8baIBTW
=gQrN
-----END PGP SIGNATURE-----

--pwUdGY/ieDcvNnXS--
