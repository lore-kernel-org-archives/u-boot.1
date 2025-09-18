Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D35CAC59A
	for <u-boot@archiver.kernel.org>; Thu, 18 Sep 2025 20:16:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABDBB81E13;
	Thu, 18 Sep 2025 22:16:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="h2djBruZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 280798206E; Thu, 18 Sep 2025 22:16:11 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEC4B80B9B
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 22:16:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-752f88e0b59so1026354a34.1
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 13:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758226567; x=1758831367; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qOmRNIDlO6EUjXhfBY9glSPINWPsQltUCsfH9OZPag4=;
 b=h2djBruZnIJgXwDs2UfqGMHsL/neWydC7oz1MviJPAo8zdKqayxWA3jWr5oblDkOb1
 jRmQGVnBXEnkW0iumBrPlqWcU+XjwSQpV+GkN+ST7XFzy73KmksxB5M4Jp9vtA33w/YM
 GOMmxghk4qhna25bEWXDhIBxrzBBYISp7iaHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758226567; x=1758831367;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qOmRNIDlO6EUjXhfBY9glSPINWPsQltUCsfH9OZPag4=;
 b=LlxuB0Io26a1aY/klivjPzqLi8vbIfXnu3pdlpamVv3XvIatdyb8CmnJDXJvMK7FFD
 FnN9GBnP0QcbTyXLetZrweoz1Y6SahWCz+zNYWFKN8ttUQ2zVkjUfBiSKGS1P3fxh1LN
 wjfaMaa+aRZoXCVtRDPFdOlaM8+hg16NeUymKerhSV/f/M1BpdyvSOdAKARN8WC8sU5V
 UgA9cHOAazijXaCC6bAowxlU9yK3U0t0oXWxCXckDJgd4RRKUcPrDz6iGgRQPVVLNU1c
 BJb9rCMSySKfLk4sKgHDBSwHkX8SuriWWuuIRXlZpVE7BWh+m4zRYJkDOl93D6/CXUHm
 weEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgffkFgtjyIS19iciLUAzoxfYTEApPKaJgi2UPSOHxaOFiEUPz34dadi7aMectpbZ4/lRTfYs=@lists.denx.de
X-Gm-Message-State: AOJu0Yx++BrSWL17lilOVRnVEb+yk5WIk22+4ei2oFMQ5ZZAy9scFjbX
 3Nw9Ex2rhZHq3q9lP6VmDzqSm7/A8ljLAGmGjYW0IPMeu0OEOZfpFGQbIFXuhehRiHk=
X-Gm-Gg: ASbGncsnY0VYDA3BkQSgb5hrv/QyQoJkoLj7pn2HvoWMFqN0Cm17XOlD0vU++EkMNX7
 B1sLhEA/zIN0ezx/sPomTctXVNfh3phWk0YSbSMIKx7N8e7OiQcsYnJhT7sihOFv8GUCGo9ldS6
 JlaCnsWREi2nkNAshGMSFqTrxe4VdeGxXBfbcwZXpN23kpHSjAtQDe8u4ozOEV5Y2ou3qyu5Sgg
 k+5YS0f0I6WKk8SXmxMUUb0vN3i/htFtpz61Rxcyc4oskL5hJIHKNjNcH4Kuaryiyb4IMxrCMCF
 aSVUVxGMwuhewRwzf1IYbXNrfLPUvB4gVCtjcqsbL7m+/+hN3vLSgrN0fvRSQw2kTVoxdIZJtd4
 xn6hZfAygdHJWHwnlNb68I4mW6m8UcVQu6zAYWoUWeV3ARLahBPKkNUtawAiyVxOJZKYE7+qjaC
 paxmSOdiifgA==
X-Google-Smtp-Source: AGHT+IFJ5lxZLNnT26NSDQVTC9TTrI4ZBRM+MrAFTxnSQty95GPmnOEJ1fjsvazJaHLxwoyrdIFNHQ==
X-Received: by 2002:a05:6830:d09:b0:745:9769:ea51 with SMTP id
 46e09a7af769-76f7830a61cmr788392a34.9.1758226567436; 
 Thu, 18 Sep 2025 13:16:07 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-76929180d4csm1436448a34.27.2025.09.18.13.16.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 13:16:06 -0700 (PDT)
Date: Thu, 18 Sep 2025 14:16:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: Re: [PATCH u-boot-test-hooks 2/2] travis-ci: add config file for
 testing firmware handoff on qemu_arm64
Message-ID: <20250918201604.GP124814@bill-the-cat>
References: <20250916161230.32140-1-raymond.mao@linaro.org>
 <20250916161230.32140-2-raymond.mao@linaro.org>
 <20250916182729.GX124814@bill-the-cat>
 <CAEfUkULE=tHe+hyerxBW5MRarO+JeJb59B-1voTFVjGmuPaidA@mail.gmail.com>
 <20250917154503.GL124814@bill-the-cat>
 <3D57BD7A-AE77-4240-89C1-AF2BDD979B64@gmx.de>
 <CAEfUkUJsyJGWFHhOXbRN+vw8Jv6koa7_Zvnoz0+JJx7hsjsKZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="e9oFRpYquIq7EaQn"
Content-Disposition: inline
In-Reply-To: <CAEfUkUJsyJGWFHhOXbRN+vw8Jv6koa7_Zvnoz0+JJx7hsjsKZg@mail.gmail.com>
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


--e9oFRpYquIq7EaQn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 10:46:04AM -0400, Raymond Mao wrote:
> Hi Heinrich,
>=20
> On Thu, 18 Sept 2025 at 06:44, Heinrich Schuchardt <xypron.glpk@gmx.de> w=
rote:
> >
> > Am 17. September 2025 17:45:03 MESZ schrieb Tom Rini <trini@konsulko.co=
m>:
> > >On Wed, Sep 17, 2025 at 10:42:52AM -0400, Raymond Mao wrote:
> > >> Hi Tom,
> > >>
> > >> On Tue, 16 Sept 2025 at 14:27, Tom Rini <trini@konsulko.com> wrote:
> > >> >
> > >> > On Tue, Sep 16, 2025 at 09:12:25AM -0700, Raymond Mao wrote:
> > >> >
> > >> > > The existing 'conf.qemu_arm64_na' uses 'u-boot.bin' as bios, but=
 for
> > >> > > the case of TF-A, 'u-boot.bin' is BL33 and the assembled 'flash.=
bin'
> > >> > > is the bios instead, which will be built and assembled at run-ti=
me
> > >> > > via a post-buildman script and copied to '/tmp'.
> > >> > >
> > >> > > Moreover, for running TF-A and OP-TEE on qemu, '-m 4G' and
> > >> > > 'virtualization=3Dfalse,secure=3Don' are required, and '-semihos=
ting'
> > >> > > should be replaced with its modern alias
> > >> > > '-semihosting-config enable=3Don,target=3Dnative'.
> > >> > >
> > >> > > Last, point to the new helper script 'swtpm-tfa'.
> > >> > >
> > >> > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > >> >
> > >> > Lets fixup the current qemu_arm64 conf to have as much in common as
> > >> > possible (4G, modern semihosting flags, etc). Next:
> > >> >
> > >> > > ---
> > >> > >  .../conf.qemu_arm64_fw_handoff_tfa_optee      | 31 ++++++++++++=
+++++++
> > >> > >  1 file changed, 31 insertions(+)
> > >> > >  create mode 100644 bin/travis-ci/conf.qemu_arm64_fw_handoff_tfa=
_optee
> > >> > >
> > >> > > diff --git a/bin/travis-ci/conf.qemu_arm64_fw_handoff_tfa_optee =
b/bin/travis-ci/conf.qemu_arm64_fw_handoff_tfa_optee
> > >> > > new file mode 100644
> > >> > > index 0000000..9aa6d3b
> > >> > > --- /dev/null
> > >> > > +++ b/bin/travis-ci/conf.qemu_arm64_fw_handoff_tfa_optee
> > >> > > @@ -0,0 +1,31 @@
> > >> > > +# Copyright (c) 2025 Linaro Limited
> > >> > > +# Author: Raymond Mao <raymond.mao@linaro.org>
> > >> > > +# Based on conf.qemu_arm64 which is
> > >> > > +# Copyright (c) 2017 Tuomas Tynkkynen. All rights reserved.
> > >> > > +#
> > >> > > +# Permission is hereby granted, free of charge, to any person o=
btaining a
> > >> > > +# copy of this software and associated documentation files (the=
 "Software"),
> > >> > > +# to deal in the Software without restriction, including withou=
t limitation
> > >> > > +# the rights to use, copy, modify, merge, publish, distribute, =
sublicense,
> > >> > > +# and/or sell copies of the Software, and to permit persons to =
whom the
> > >> > > +# Software is furnished to do so, subject to the following cond=
itions:
> > >> > > +#
> > >> > > +# The above copyright notice and this permission notice shall b=
e included in
> > >> > > +# all copies or substantial portions of the Software.
> > >> > > +#
> > >> > > +# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIN=
D, EXPRESS OR
> > >> > > +# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCH=
ANTABILITY,
> > >> > > +# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO =
EVENT SHALL
> > >> > > +# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAM=
AGES OR OTHER
> > >> > > +# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWIS=
E, ARISING
> > >> > > +# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR=
 OTHER
> > >> > > +# DEALINGS IN THE SOFTWARE.
> > >> > > +
> > >> > > +console_impl=3Dqemu
> > >> > > +qemu_machine=3D"virt,virtualization=3Dfalse,secure=3Don"
> > >> > > +qemu_helper_script=3D"swtpm-tfa"
> > >> > > +qemu_binary=3D"qemu-system-aarch64"
> > >> > > +qemu_extra_args=3D"-m 4G -cpu cortex-a57 -nographic -netdev use=
r,id=3Dnet0,tftp=3D${UBOOT_TRAVIS_BUILD_DIR} -device e1000,netdev=3Dnet0 -d=
evice virtio-rng-pci -d unimp -semihosting-config enable=3Don,target=3Dnati=
ve -chardev socket,id=3Dchrtpm,path=3D/tmp/tpm/swtpm-sock -tpmdev emulator,=
id=3Dtpm0,chardev=3Dchrtpm -device tpm-tis-device,tpmdev=3Dtpm0"
> > >> >
> > >> > Can we line break this? Then make some functional groupings? Thank=
s.
> > >> >
> > >> I am thinking about to merge this script into the common one
> > >> "conf.qemu_arm64_na", but do you mind to add
> > >> "virtualization=3Dfalse,secure=3Don" as a common setting? even thoug=
h It
> > >> is only needed when running with TF-A/OP-TEE.
> >
> > Main U-Boot is meant to be running in EL2. So why should we start in EL=
3 without TF-A?
> >
> > Why do you want to disable virtualization?
> >
> 1. That was my original motivation to make a separate config file for
> introducing "secure=3Don", since it might lead to unpredictable
> behaviours when without TF-A, even tests done normally.
> 2. You are right, virtualization=3Dfalse can be removed.
>=20
> But then we need to make a decision from 2 options:
> 1. Use one set of config/helper scripts for all qemu_arm64 cases,
> ignoring the unpredictable behaviour caused by starting from EL3/EL2.
> 2. Keep the current patch - use separate sets of config/helper to keep
> the concept more clearer. (qemu_helper_script can be just one by using
> args, but does not make too much sense when we still have two config
> files).
>=20
> @Tom Rini @Heinrich Schuchardt What are your thoughts?

We should at least make them as common as possible, and more easily
human-readable. They're also just bash shell files so we could source
one and extend the variables in another (and comment on what we're doing
/ why in the file).

--=20
Tom

--e9oFRpYquIq7EaQn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMxohAAKCRAr4qD1Cr/k
CgGIAQDg/V507wfZMOHUBiXqowsX7Mi+VDFFczfF8GBWgaIYLQEAzXqOcGVa+1h5
8h1TzFsM60IMAbKjd9Q3CPuhuHS2/A4=
=j+xu
-----END PGP SIGNATURE-----

--e9oFRpYquIq7EaQn--
