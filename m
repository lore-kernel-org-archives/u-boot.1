Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 003B1CAC592
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 18:27:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FFB7832F0;
	Tue, 16 Sep 2025 20:27:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eYhBYS+5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77D28803CC; Tue, 16 Sep 2025 20:27:36 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2930C8331B
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 20:27:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-62347d880feso1514483eaf.3
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 11:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758047253; x=1758652053; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YfWFPlTsMCBCoG5S5Nju9e1HKcAMyss5N+WJTAUj4A0=;
 b=eYhBYS+5xeF6krZTv6z/GS/Lktlhb83sDjyMCNsKmuxUZ9hktyc16e19eZ64bbeh5c
 FZmvwn59Pk4R3fChHLppGwWomxtrgVz6SnLe4F3FP0ygadcN7deO29sYx68v6dcPX9+J
 t/JQbVnZlUZIe4acMCjJsWe2F74aljbVjcZDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758047253; x=1758652053;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YfWFPlTsMCBCoG5S5Nju9e1HKcAMyss5N+WJTAUj4A0=;
 b=cpHRBe2LNIqE4tIlGhZmatWCvqZ0cBrYCYnwtArAV8+oLzMaVpRbDHpIt1XVN1CYrN
 MugcmZpvPw6kwtNJlY4YP4OhGBrKPU9MR57C6MhhzYaFlNvl7cXMnnpkSg7G2FogTWMB
 KtT7ecS7QgGqr/HWw7m0RuAwtNvKhqGMO2rLZEDIheeqpW9T0EoK6cruyW50wwLJabUn
 ssxn8w+LjShueG2PCPBz8OePzMNNOGj/kCn2yuP117LWyTmb07BzuJ1n/BvA6upMklBR
 fxZKft1Z99pbAVuC4FP5DnLh8rT75/n9TJIFBkb5BI3U1QhXJNKBN7JUyNS5dlbjVMez
 k/Zg==
X-Gm-Message-State: AOJu0YxraVTraXzqPrgpg0oEmSbXf08t3VPasLoyhpe9mtynTM6DUKSV
 KA/umoBQ4Hy8KbZjX4IqMauNJaTtSNaOlxCqRsytAO9sPe83LM7bWx4Pxh9ltzog+7E=
X-Gm-Gg: ASbGncthSx5mP2JfBXCfEsjxo2rbuIAGcnoNe7m3y+mC/0VaLwNhxZiOMMpCU6aQk+J
 3BCppo/SVPVdcpolZNfv7O9HKoqHh9eAQYmh9pO3A3WgJC4Q8bjoS/ppZdYyTtbvQQHY+Bl6FE8
 +crFdGL3ypMqu6fjPlUyg3aVRZ+Pxd6TZVNHKmN16OnTXrs3hgf9hpYyWGz36V51TjbekAIu3MP
 s8eK/PN3+xdYtzsclLZYAfiVY/DfHPWphqeCAaHICmCI8eFO0xTjZU1hPGFukDpLfPjgaOq8MuO
 n+p1XFgy5Fo6PXTE7FcMhKDEQWD0cwUwsFwaOFz2mB8E/8mKBl0MgFemsk4dQHXgFDKK4j/+4xm
 klDmUU7BVAMhsVegQBwPmRVyZoEx5y2gpqxBflO0YI5JLGQn2wqp8U40Y
X-Google-Smtp-Source: AGHT+IE2pLLidZAG/ym+BIF775AzUMBquWJxems1DnT+ztURxKsJlMnM+tPTHRKbhwJjAfwqb9qO9g==
X-Received: by 2002:a05:6808:6a89:b0:439:27db:51e5 with SMTP id
 5614622812f47-43b8d8e527dmr7240319b6e.18.1758047252761; 
 Tue, 16 Sep 2025 11:27:32 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-43d20e4fa88sm1940952b6e.24.2025.09.16.11.27.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:27:31 -0700 (PDT)
Date: Tue, 16 Sep 2025 12:27:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: Re: [PATCH u-boot-test-hooks 2/2] travis-ci: add config file for
 testing firmware handoff on qemu_arm64
Message-ID: <20250916182729.GX124814@bill-the-cat>
References: <20250916161230.32140-1-raymond.mao@linaro.org>
 <20250916161230.32140-2-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VXbgkX6I8tIhHI2m"
Content-Disposition: inline
In-Reply-To: <20250916161230.32140-2-raymond.mao@linaro.org>
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


--VXbgkX6I8tIhHI2m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 09:12:25AM -0700, Raymond Mao wrote:

> The existing 'conf.qemu_arm64_na' uses 'u-boot.bin' as bios, but for
> the case of TF-A, 'u-boot.bin' is BL33 and the assembled 'flash.bin'
> is the bios instead, which will be built and assembled at run-time
> via a post-buildman script and copied to '/tmp'.
>=20
> Moreover, for running TF-A and OP-TEE on qemu, '-m 4G' and
> 'virtualization=3Dfalse,secure=3Don' are required, and '-semihosting'
> should be replaced with its modern alias
> '-semihosting-config enable=3Don,target=3Dnative'.
>=20
> Last, point to the new helper script 'swtpm-tfa'.
>=20
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>

Lets fixup the current qemu_arm64 conf to have as much in common as
possible (4G, modern semihosting flags, etc). Next:

> ---
>  .../conf.qemu_arm64_fw_handoff_tfa_optee      | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 bin/travis-ci/conf.qemu_arm64_fw_handoff_tfa_optee
>=20
> diff --git a/bin/travis-ci/conf.qemu_arm64_fw_handoff_tfa_optee b/bin/tra=
vis-ci/conf.qemu_arm64_fw_handoff_tfa_optee
> new file mode 100644
> index 0000000..9aa6d3b
> --- /dev/null
> +++ b/bin/travis-ci/conf.qemu_arm64_fw_handoff_tfa_optee
> @@ -0,0 +1,31 @@
> +# Copyright (c) 2025 Linaro Limited
> +# Author: Raymond Mao <raymond.mao@linaro.org>
> +# Based on conf.qemu_arm64 which is
> +# Copyright (c) 2017 Tuomas Tynkkynen. All rights reserved.
> +#
> +# Permission is hereby granted, free of charge, to any person obtaining a
> +# copy of this software and associated documentation files (the "Softwar=
e"),
> +# to deal in the Software without restriction, including without limitat=
ion
> +# the rights to use, copy, modify, merge, publish, distribute, sublicens=
e,
> +# and/or sell copies of the Software, and to permit persons to whom the
> +# Software is furnished to do so, subject to the following conditions:
> +#
> +# The above copyright notice and this permission notice shall be include=
d in
> +# all copies or substantial portions of the Software.
> +#
> +# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRES=
S OR
> +# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILIT=
Y,
> +# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHA=
LL
> +# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR O=
THER
> +# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> +# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> +# DEALINGS IN THE SOFTWARE.
> +
> +console_impl=3Dqemu
> +qemu_machine=3D"virt,virtualization=3Dfalse,secure=3Don"
> +qemu_helper_script=3D"swtpm-tfa"
> +qemu_binary=3D"qemu-system-aarch64"
> +qemu_extra_args=3D"-m 4G -cpu cortex-a57 -nographic -netdev user,id=3Dne=
t0,tftp=3D${UBOOT_TRAVIS_BUILD_DIR} -device e1000,netdev=3Dnet0 -device vir=
tio-rng-pci -d unimp -semihosting-config enable=3Don,target=3Dnative -chard=
ev socket,id=3Dchrtpm,path=3D/tmp/tpm/swtpm-sock -tpmdev emulator,id=3Dtpm0=
,chardev=3Dchrtpm -device tpm-tis-device,tpmdev=3Dtpm0"

Can we line break this? Then make some functional groupings? Thanks.

--=20
Tom

--VXbgkX6I8tIhHI2m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMmsEQAKCRAr4qD1Cr/k
ClKpAPkBgc0ol2E/Siu7OeQOjHulGQsZ/EN9xofl03aZsOglGAD/UaLGl670GSiR
m47EBJGggmbu9fT50s7fjw7n9ysfJwI=
=F/X7
-----END PGP SIGNATURE-----

--VXbgkX6I8tIhHI2m--
