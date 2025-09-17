Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C73CAC59A
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 15:45:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F100983655;
	Wed, 17 Sep 2025 17:45:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AMVD+7+f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13E488365C; Wed, 17 Sep 2025 17:45:11 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECE2A83622
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 17:45:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-62189987b47so2872261eaf.1
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 08:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758123907; x=1758728707; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=z0g2IrEJUVuA5mz1pZJ7i5UakkiScipoQNcQI0ZRQhk=;
 b=AMVD+7+fMIpPecwJHudonlwSkYXpD5pr9KGP1384cJtrp5Sw3kVdocTqrWHOPtWb5v
 utzItHY5xColH4hnyq7WAIHwCPAPeccOdNF4ciz5JnWFOfc8H/bcjlTQNGItsLKGQZ3T
 cnNGCfjtoObFIKC9CK+8CxAbajhxqBVlwVoLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758123907; x=1758728707;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z0g2IrEJUVuA5mz1pZJ7i5UakkiScipoQNcQI0ZRQhk=;
 b=PErEYqdJxkm2X77kuMyscmLx/sMKmYur1VE0zqhIf+SnIuJ6Rw3sUpioskG0BIxQgw
 8heOSeAs1X3cvxlj2fqZPlalX4gJV13rgoEHoOfUSHqBgKEuSsnVYLXNZddA045JGoQg
 ycroLou9sz59tUM6dgZLgFfhMQOwOpCaMdK0NjG5Dth75VB/deFz92WDQa3mY2R8gv0d
 RSQxC2JG/Bc93joHw+3Q3HkGqrdkyV/Bg6WiISooEhHtCQ5XqJn/FNXJTT92MkTXp57M
 jFKx9JQjTlH8V+qk5INCFprBXSBZZztyHdQWXm9MmKMk3+A/YBdTOSrnH9ox83w4OpBJ
 SoXQ==
X-Gm-Message-State: AOJu0YzEm2w1S12hCnW9wlAIN25E1azuWDBifdZwl+bh371fUgRQGZZb
 O4+rzuvvq/6mxSUJWv6S8I9oKPPqs7KWkB23NGQiEg+ujLSCHf3TbY3nZHN/J1CeBGA=
X-Gm-Gg: ASbGnctWCLrh6WwOEJhVv9MiQ1mt+q1E4cV4DPQpk3evW8A4lYNlpccZ1UufOGAZHN9
 Sr+OO+hqCbbF41sQvnQIEcH1OasqHVFRINKylNUeYKIRTes5pDzIwXa7s0ACWtsXtzAmFBF60er
 qVc1DHbCBulwMiusqevb1LZgi0Zm6/wxM13JUKgk7T8b+vTIJgNtKt24cIeDmlX7hlfV0U7uQRj
 hBwdu345J1z9D/ZG8en4BxCYM1Gz5/kHsG1n7Es2VXQyHQaNjYT5A3xDP04eld5r9+7QOSSfhI3
 n945vMAkBtzffRCbhkmwFIKBQ6DtAFTVtFisF+FOPu4nZNjaFyomip7lziQ2UeSG3VG/3C8EPMl
 PzFG7Bkt2JaaTswLZB+m4iT+ncx+MfbVRYbEspm+v7XH6hUePKqP45TfD
X-Google-Smtp-Source: AGHT+IE7HVuHOTVWXZlnwaIj3YMMNdaLarDnu9ScUZZqB1FtiSuGeGkTDkMT1IdCxzBBHJsiu9X8qw==
X-Received: by 2002:a05:6870:320f:b0:321:28f7:77fa with SMTP id
 586e51a60fabf-335bf727901mr1431948fac.32.1758123906507; 
 Wed, 17 Sep 2025 08:45:06 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-32d35382f8asm6371962fac.19.2025.09.17.08.45.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 08:45:05 -0700 (PDT)
Date: Wed, 17 Sep 2025 09:45:03 -0600
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
Message-ID: <20250917154503.GL124814@bill-the-cat>
References: <20250916161230.32140-1-raymond.mao@linaro.org>
 <20250916161230.32140-2-raymond.mao@linaro.org>
 <20250916182729.GX124814@bill-the-cat>
 <CAEfUkULE=tHe+hyerxBW5MRarO+JeJb59B-1voTFVjGmuPaidA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="N4sWfWivfi94SqBT"
Content-Disposition: inline
In-Reply-To: <CAEfUkULE=tHe+hyerxBW5MRarO+JeJb59B-1voTFVjGmuPaidA@mail.gmail.com>
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


--N4sWfWivfi94SqBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 10:42:52AM -0400, Raymond Mao wrote:
> Hi Tom,
>=20
> On Tue, 16 Sept 2025 at 14:27, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Sep 16, 2025 at 09:12:25AM -0700, Raymond Mao wrote:
> >
> > > The existing 'conf.qemu_arm64_na' uses 'u-boot.bin' as bios, but for
> > > the case of TF-A, 'u-boot.bin' is BL33 and the assembled 'flash.bin'
> > > is the bios instead, which will be built and assembled at run-time
> > > via a post-buildman script and copied to '/tmp'.
> > >
> > > Moreover, for running TF-A and OP-TEE on qemu, '-m 4G' and
> > > 'virtualization=3Dfalse,secure=3Don' are required, and '-semihosting'
> > > should be replaced with its modern alias
> > > '-semihosting-config enable=3Don,target=3Dnative'.
> > >
> > > Last, point to the new helper script 'swtpm-tfa'.
> > >
> > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> >
> > Lets fixup the current qemu_arm64 conf to have as much in common as
> > possible (4G, modern semihosting flags, etc). Next:
> >
> > > ---
> > >  .../conf.qemu_arm64_fw_handoff_tfa_optee      | 31 +++++++++++++++++=
++
> > >  1 file changed, 31 insertions(+)
> > >  create mode 100644 bin/travis-ci/conf.qemu_arm64_fw_handoff_tfa_optee
> > >
> > > diff --git a/bin/travis-ci/conf.qemu_arm64_fw_handoff_tfa_optee b/bin=
/travis-ci/conf.qemu_arm64_fw_handoff_tfa_optee
> > > new file mode 100644
> > > index 0000000..9aa6d3b
> > > --- /dev/null
> > > +++ b/bin/travis-ci/conf.qemu_arm64_fw_handoff_tfa_optee
> > > @@ -0,0 +1,31 @@
> > > +# Copyright (c) 2025 Linaro Limited
> > > +# Author: Raymond Mao <raymond.mao@linaro.org>
> > > +# Based on conf.qemu_arm64 which is
> > > +# Copyright (c) 2017 Tuomas Tynkkynen. All rights reserved.
> > > +#
> > > +# Permission is hereby granted, free of charge, to any person obtain=
ing a
> > > +# copy of this software and associated documentation files (the "Sof=
tware"),
> > > +# to deal in the Software without restriction, including without lim=
itation
> > > +# the rights to use, copy, modify, merge, publish, distribute, subli=
cense,
> > > +# and/or sell copies of the Software, and to permit persons to whom =
the
> > > +# Software is furnished to do so, subject to the following condition=
s:
> > > +#
> > > +# The above copyright notice and this permission notice shall be inc=
luded in
> > > +# all copies or substantial portions of the Software.
> > > +#
> > > +# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EX=
PRESS OR
> > > +# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> > > +# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT=
 SHALL
> > > +# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES =
OR OTHER
> > > +# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, AR=
ISING
> > > +# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> > > +# DEALINGS IN THE SOFTWARE.
> > > +
> > > +console_impl=3Dqemu
> > > +qemu_machine=3D"virt,virtualization=3Dfalse,secure=3Don"
> > > +qemu_helper_script=3D"swtpm-tfa"
> > > +qemu_binary=3D"qemu-system-aarch64"
> > > +qemu_extra_args=3D"-m 4G -cpu cortex-a57 -nographic -netdev user,id=
=3Dnet0,tftp=3D${UBOOT_TRAVIS_BUILD_DIR} -device e1000,netdev=3Dnet0 -devic=
e virtio-rng-pci -d unimp -semihosting-config enable=3Don,target=3Dnative -=
chardev socket,id=3Dchrtpm,path=3D/tmp/tpm/swtpm-sock -tpmdev emulator,id=
=3Dtpm0,chardev=3Dchrtpm -device tpm-tis-device,tpmdev=3Dtpm0"
> >
> > Can we line break this? Then make some functional groupings? Thanks.
> >
> I am thinking about to merge this script into the common one
> "conf.qemu_arm64_na", but do you mind to add
> "virtualization=3Dfalse,secure=3Don" as a common setting? even though It
> is only needed when running with TF-A/OP-TEE.

So long as everything works in CI for the other cases, yes, that's fine.

--=20
Tom

--N4sWfWivfi94SqBT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMrXewAKCRAr4qD1Cr/k
Ckv/APwJwtPSNfkYbNddCisG8siSYe3YeG7csalxQgJwHi2g0wD/Rqv5LxpsuLs2
OmhUfGzjkAR5haexBlCr+hJbc3Q8pAs=
=Q45k
-----END PGP SIGNATURE-----

--N4sWfWivfi94SqBT--
