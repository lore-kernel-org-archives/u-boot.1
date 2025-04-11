Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD51EC369A2
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 17:37:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEB08841E3;
	Fri, 11 Apr 2025 19:37:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ehelqgTn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20204841EE; Fri, 11 Apr 2025 19:37:11 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70C8A841DF
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 19:37:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-603fd257386so535779eaf.1
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 10:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744393027; x=1744997827; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=j9DRE4XSvXiNvPnVvG6PYoKrKXBm355R1HCxnvwDHdk=;
 b=ehelqgTnngtR43VQV5xw/qEZGRAEIyAhnrbXc9krjK+jFoZ2FkdUj7dbM+QuKst4eq
 CiDLjHMpK+2tZIHG0VG2ME6HV4iJ4jiM1g35U8uYsy66XX3vwOA/RJgl/oKLUwz+aPAz
 f0m8wmjgw7HXr5rdlb1uquVxvOOWK7M1M7SAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744393027; x=1744997827;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j9DRE4XSvXiNvPnVvG6PYoKrKXBm355R1HCxnvwDHdk=;
 b=EuSe64Ee6EF7lvI+CdkGqKxk7G8tbFA7m4tmV4mqnp/vZ2D9YSwKsCWrtraaXLYG6n
 /4uSyMfB2ZaPJ+ea6K4hwSFCXtqI6i8dovJ4DHrSAkuTv+4INuyh2hMKJBDnrx36Nrkn
 jnAyUB6qlGvq3CWEIm6eXGHEiVjV/nJNUaq+FIuqPzp/SbXPfiDL0WnMI9Om1ZqNPnDG
 BY4CgxLWJ3RFg0OQxSihzZ33stTXWPEIX96eCRESbGVvGJPGZH8BF6zFOz6gluzi4lCy
 Jia26UT5xm3BEfO5ms7eXPXVxuvvBCFOIxPH7Dun+ZRDLp2EPGCLmaTKwvwAArHy8vlR
 9rJg==
X-Gm-Message-State: AOJu0Yx+V2+/l+x2DMluHktGPSSuAGgBZGHfQIPpI3Dcs0ZWKpUXvY4i
 WiWvsVMhlkRbw3OdmB1w/JP+ELa5lrYcZzddLvpB18OOv1cTBlp2gbShISvYkUg=
X-Gm-Gg: ASbGncu6UAkHXNiS0VXosSw0yQxRP/uDE4PSchSWxe+WlbjqAKIWdo2DETZVU5T6vCU
 t3iJyPappS/j3F8pP8aTukqEadAe3OUFR7qkdfkMCYraVpm3gX4g4Td+4gjzX3jRzVepRJil5sk
 Gevojq3nQNDFn58P8UyrNXcpcps1/dAr4+AlBeBx/LqpzwQxy9FvpL39YXb3q+QZPrf0vTPlGJ/
 5NjlIGnzjJvWfSiGZMOiUvMF+p+kxiyr2dngmVUVKXcOg0vNUa0Fd34657Pydif92rNf3jb545N
 pQpbzNiLRxN2ToTFHHGui766U5Q2cd+aHz1/ZS1S3rhi6s0NXcuB3s2dPAcHMQfY7X8IyWc2tfa
 fOg==
X-Google-Smtp-Source: AGHT+IE8AXxPot1Uknr1KC0pD69i6MBGncqwqhrMiJE2czR0gMtdRsTGW8PJlp4VfNl31jR6IYIazw==
X-Received: by 2002:a05:6808:2f0f:b0:3fa:8bfd:7748 with SMTP id
 5614622812f47-4008507dc90mr2462751b6e.22.1744393027058; 
 Fri, 11 Apr 2025 10:37:07 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-400763bf343sm1022283b6e.50.2025.04.11.10.37.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 10:37:06 -0700 (PDT)
Date: Fri, 11 Apr 2025 11:37:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot mailing list <u-boot@lists.denx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>, Jonas Karlman <jonas@kwiboo.se>,
 Love Kumar <love.kumar@amd.com>, Marek Vasut <marex@denx.de>,
 Mario Six <mario.six@gdsys.cc>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Weinberger <richard@nod.at>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Yao Zi <ziyao@disroot.org>
Subject: Re: [RFC PATCH v1 0/7] Bootstage reports for CI
Message-ID: <20250411173703.GU5495@bill-the-cat>
References: <20250411153040.1772000-1-jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+LAKFCyHX5Zr2coT"
Content-Disposition: inline
In-Reply-To: <20250411153040.1772000-1-jerome.forissier@linaro.org>
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


--+LAKFCyHX5Zr2coT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 05:29:26PM +0200, Jerome Forissier wrote:

> The BOOTSTAGE Kconfig symbol allows to record boot time information
> which can be consumed in several ways:
>=20
> 1) Printed to the console just before the OS is booted (when
>    BOOTSTAGE_REPORT=3Dy)
> 2) Printed to the console by the "bootstage report" command (when
>    CMD_BOOTSTAGE=3Dy)
> 3) Passed to the OS in the Device Tree (when BOOTSTAGE_FDT=3Dy)
> 4) Written to some memory location in binary format before the OS is
>    booted (when BOOTSTAGE_STASH=3Dy)
>=20
> None of these options are convenient for use in CI. Suppose we want to
> monitor a set of boards for boot time regressions -- in other words,
> make sure the boot time does not degrade unexpectedly as the code
> evolves. For that, we'd like to be able to record the bootstage data in
> some kind of database or persistent storage and possibly draw graphs
> showing trends over time.
>=20
> This RFC is a step in that direction. It introduces two new output
> formats for the bootstage data. The two are independant, they are simply
> two options I considered:
>=20
> 1) JSON
> 2) InfluxDB v2 line protocol [1]
>=20
> Both depend on BOOTSTAGE_REPORT and are enabled by BOOTSTAGE_REPORT_JSON
> and BOOTSTAGE_REPORT_INFLUXDB respectively. Each format comes with its
> own test in test/py/tests. The InfluxDB test is special in that it is
> able to upload the data to a cloud database, provided the environment
> variables BOOTSTAGE_INFLUXDB_URI and BOOTSTAGE_INFLUXDB_TOKEN are set
> properly.
>=20
> I have been able to run a boot test on rpi4 in the sjg-lab with
> BOOTSTGE_REPORT_INFLUXDB enabled. The CI log [2] shows that the data
> were indeed uploaded to my InfluxDB Cloud test account.
>=20
> This is published as an RFC since it is just an investigation. If
> someone finds this useful I may folloow-up with a non-RFC series.
>=20
> Comments are welcome.
>=20
> [1] https://docs.influxdata.com/influxdb/v2/reference/syntax/line-protoco=
l/
> [2] https://source.denx.de/u-boot/custodians/u-boot-net/-/jobs/1097039#L1=
16

This is very interesting. One thing I wonder about wrt reporting is if
what would be in the JUnit XML report already is enough, or if we need
more granularity? Something like the following might work to get them
saved for Simon's lab like they are for the emulated targets:
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index e54bdd6c4bec..8ec5dfbb2528 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -558,6 +558,7 @@ coreboot test.py:
     - export USE_LABGRID_SJG=3D1
     # export verbose=3D"-v"
     - ${SRC}/test/py/test.py --role ${ROLE} --build-dir "${OUT}"
+        --junitxml=3D"${OUT}"/results.xml
         --capture=3Dtee-sys -k "not bootstd ${TEST_PY_TEST_SPEC}" || ret=
=3D$?
     - U_BOOT_BOARD_IDENTITY=3D"${ROLE}" u-boot-test-release || true
     - if [[ $ret -ne 0 ]]; then
@@ -568,7 +569,10 @@ coreboot test.py:
     paths:
       - "build/${BOARD}/test-log.html"
       - "build/${BOARD}/multiplexed_log.css"
+      - "build/${BOARD}/results.xml"
     expire_in: 1 week
+    reports:
+      junit: build/${BOARD}/results.xml
=20
 rpi3:
   variables:

--=20
Tom

--+LAKFCyHX5Zr2coT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf5UzQACgkQFHw5/5Y0
tyxhwwwAs9hsJgcldvNB2vyD/AZ5HUtA59IJCeVVVan5muw8sP3q0VkjEP7xA2nG
OzlqEGJpjTH2ZJa3JLRWKPzFubMSgqvZe03FNE9IQu3kjwYftkQLPDLVBU2Tv9dE
n85A3q+gnPj3UMME6W7UUE/qflbdzou2XZe/VhZiU9ooKr6j5lQznP6w/pQJioGs
KYzPqlA3BUFzL1Zh5zj2jRWmsmLTniUgRE70xo19fKhy1zu49jzEX7mo+kqXG+pE
avCyFL/AZKs22sXHVrJKyefh3axcyjb6Tad+YJQQZmKcO1gKciLc0y08gr2wKNUw
qKJOGHtNgUOLERCSTRzfXSTj0DfPeCp6HjLFd4785jEpgyx4cT+Og+nz1KpitVdZ
t9qUihrXHVCcbyHzbjwV5ZiwTYjTfolGMlw6Kt+Am3nf1daKcFtGm4T3PTzDUSlx
uGdMiyFDvJ4BI5NkANdurJDClWo7tOdMB0Y48NKm6E6u+gMMJhw7dLudduIg9N1n
QKYB2q3A
=qz45
-----END PGP SIGNATURE-----

--+LAKFCyHX5Zr2coT--
