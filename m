Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 008D0CA1013
	for <u-boot@archiver.kernel.org>; Thu, 18 Sep 2025 14:46:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46FF681E13;
	Thu, 18 Sep 2025 16:46:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZF/z6E2x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60EFF8309A; Thu, 18 Sep 2025 16:46:19 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 589DA80B9B
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 16:46:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-26799bf6a2eso10677965ad.3
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 07:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758206775; x=1758811575; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DkWzMDppI3P8BvLouJs+ECX/PPShDfnKr9VJXxdAOkY=;
 b=ZF/z6E2xNX5wfrAgP1s6H+uoHsdn1fou9n6Sv2+ZpXgPCrjjC9OZsObiaGtVkUCwAd
 i+J19U3OFkYJn+fjTFOj+xhpBx5omKaUFxeK/Q16bXwg1/4PPTOPdgKI6gl1D3B/lwNV
 48FvcswoUx0uVTEAfrPlkjG4jdnHfk8saATKzpBYBJlTD2ToVy2MO4D0qAzfTIEYaBpC
 e18XXpZsxJUsjqt+k99g5e+iG5nWEwqn7Sla8osuzmWIiqrGzKqbscYbB+WwTzdOQv3F
 4W8ANxq4kyMYzIMmSep3EC5yopjWtA9GbVN8MHK2/m3a+eBlf7/U9JrF1G18F9hQVu49
 0y4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758206775; x=1758811575;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DkWzMDppI3P8BvLouJs+ECX/PPShDfnKr9VJXxdAOkY=;
 b=t/gEOn/7Yper80SStiSx5WyyJ4FuuOPf6+MMPsSGV3wFTZe5ijaKgHEztgZVzIDprd
 1nmEROrMH9R8p1l2zyWDAk9pJzSQAH2Aj3ciuO9xo8D9HqpqT7XeZc9/MjB7i69ykRcE
 9h375RB4QEjFoubhOpOVcSEoKEPFaajGpX7lnkaGpQRWwYuTmkfNxnEzyBQufKtwfGVq
 dfqUuiGOQlEUrhLaXKp60cDQYl099IEBezedNHSVctCcVcKvM57rSfPuWsRpOhJb0Npn
 0MWo3Bo1OVz4P633lbGE7bBy2pWcsHn4o+DX9hYrLZq1/05R79H6618aZJ2jx4JfFIIN
 Hf8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtat0/aXLm0ynCX23YsYYhAM4osLmWD9FwAcIcwXg2ol7/J4CPrBpnr7mVdbc3jczQiziswYo=@lists.denx.de
X-Gm-Message-State: AOJu0YylwRFI8BbIE+m4d8xBktD+87K9HdmaFHr2L9JYuHOZAU0unDVe
 njqK2F1E9zLfaq39JkE+h5DlpeliAhB6EQMZftJRjfoSFlGtvbJkCF2unwdpilOEmcwPKKXOb6w
 7XaefKZlNs0/s/0KmSVRFHuy83VjCO4xLJ5sd5ab6MQ==
X-Gm-Gg: ASbGncu2ymK3+RGfFFNIfrNcI1ImQgIhaIH+d9Q0y7mvMmJmg80f9E0QRFPdzUMFOu1
 9Dhal9uGbFmtsuq/s/V0yIQhGvisWMKzeDxOzlsIvaHRGl+U+RHl9Vnq/jPCAeGwGfpM+wHi64d
 vtHew2+Iij5Tpe9ZQy+ozdGEuwS0i+mH7z/MkkjOkPt1jdE+CUSWRtO/Uq3evSqiIO3Rc3JXYey
 Gffh4HH4SXoq3bhqLbyXxbjdFbk
X-Google-Smtp-Source: AGHT+IECB2MKR29fxzzIQgfjGX77Eily0yov+U90ymy5dOyNeAP1Io45NU+Tkyg2XYuaU9IMT8yIZQNHjZYUyF/QzFQ=
X-Received: by 2002:a17:903:2448:b0:24c:a9c6:d193 with SMTP id
 d9443c01a7336-26811e8850dmr96665765ad.18.1758206774749; Thu, 18 Sep 2025
 07:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250916161230.32140-1-raymond.mao@linaro.org>
 <20250916161230.32140-2-raymond.mao@linaro.org>
 <20250916182729.GX124814@bill-the-cat>
 <CAEfUkULE=tHe+hyerxBW5MRarO+JeJb59B-1voTFVjGmuPaidA@mail.gmail.com>
 <20250917154503.GL124814@bill-the-cat>
 <3D57BD7A-AE77-4240-89C1-AF2BDD979B64@gmx.de>
In-Reply-To: <3D57BD7A-AE77-4240-89C1-AF2BDD979B64@gmx.de>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 18 Sep 2025 10:46:04 -0400
X-Gm-Features: AS18NWCzoAUPdGWYGmXS8UImV4EBucEMLRsi9c294JN64YmPEC3KLXjbQFE0x1M
Message-ID: <CAEfUkUJsyJGWFHhOXbRN+vw8Jv6koa7_Zvnoz0+JJx7hsjsKZg@mail.gmail.com>
Subject: Re: [PATCH u-boot-test-hooks 2/2] travis-ci: add config file for
 testing firmware handoff on qemu_arm64
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Heinrich,

On Thu, 18 Sept 2025 at 06:44, Heinrich Schuchardt <xypron.glpk@gmx.de> wro=
te:
>
> Am 17. September 2025 17:45:03 MESZ schrieb Tom Rini <trini@konsulko.com>=
:
> >On Wed, Sep 17, 2025 at 10:42:52AM -0400, Raymond Mao wrote:
> >> Hi Tom,
> >>
> >> On Tue, 16 Sept 2025 at 14:27, Tom Rini <trini@konsulko.com> wrote:
> >> >
> >> > On Tue, Sep 16, 2025 at 09:12:25AM -0700, Raymond Mao wrote:
> >> >
> >> > > The existing 'conf.qemu_arm64_na' uses 'u-boot.bin' as bios, but f=
or
> >> > > the case of TF-A, 'u-boot.bin' is BL33 and the assembled 'flash.bi=
n'
> >> > > is the bios instead, which will be built and assembled at run-time
> >> > > via a post-buildman script and copied to '/tmp'.
> >> > >
> >> > > Moreover, for running TF-A and OP-TEE on qemu, '-m 4G' and
> >> > > 'virtualization=3Dfalse,secure=3Don' are required, and '-semihosti=
ng'
> >> > > should be replaced with its modern alias
> >> > > '-semihosting-config enable=3Don,target=3Dnative'.
> >> > >
> >> > > Last, point to the new helper script 'swtpm-tfa'.
> >> > >
> >> > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> >> >
> >> > Lets fixup the current qemu_arm64 conf to have as much in common as
> >> > possible (4G, modern semihosting flags, etc). Next:
> >> >
> >> > > ---
> >> > >  .../conf.qemu_arm64_fw_handoff_tfa_optee      | 31 ++++++++++++++=
+++++
> >> > >  1 file changed, 31 insertions(+)
> >> > >  create mode 100644 bin/travis-ci/conf.qemu_arm64_fw_handoff_tfa_o=
ptee
> >> > >
> >> > > diff --git a/bin/travis-ci/conf.qemu_arm64_fw_handoff_tfa_optee b/=
bin/travis-ci/conf.qemu_arm64_fw_handoff_tfa_optee
> >> > > new file mode 100644
> >> > > index 0000000..9aa6d3b
> >> > > --- /dev/null
> >> > > +++ b/bin/travis-ci/conf.qemu_arm64_fw_handoff_tfa_optee
> >> > > @@ -0,0 +1,31 @@
> >> > > +# Copyright (c) 2025 Linaro Limited
> >> > > +# Author: Raymond Mao <raymond.mao@linaro.org>
> >> > > +# Based on conf.qemu_arm64 which is
> >> > > +# Copyright (c) 2017 Tuomas Tynkkynen. All rights reserved.
> >> > > +#
> >> > > +# Permission is hereby granted, free of charge, to any person obt=
aining a
> >> > > +# copy of this software and associated documentation files (the "=
Software"),
> >> > > +# to deal in the Software without restriction, including without =
limitation
> >> > > +# the rights to use, copy, modify, merge, publish, distribute, su=
blicense,
> >> > > +# and/or sell copies of the Software, and to permit persons to wh=
om the
> >> > > +# Software is furnished to do so, subject to the following condit=
ions:
> >> > > +#
> >> > > +# The above copyright notice and this permission notice shall be =
included in
> >> > > +# all copies or substantial portions of the Software.
> >> > > +#
> >> > > +# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,=
 EXPRESS OR
> >> > > +# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHAN=
TABILITY,
> >> > > +# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EV=
ENT SHALL
> >> > > +# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAG=
ES OR OTHER
> >> > > +# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,=
 ARISING
> >> > > +# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR O=
THER
> >> > > +# DEALINGS IN THE SOFTWARE.
> >> > > +
> >> > > +console_impl=3Dqemu
> >> > > +qemu_machine=3D"virt,virtualization=3Dfalse,secure=3Don"
> >> > > +qemu_helper_script=3D"swtpm-tfa"
> >> > > +qemu_binary=3D"qemu-system-aarch64"
> >> > > +qemu_extra_args=3D"-m 4G -cpu cortex-a57 -nographic -netdev user,=
id=3Dnet0,tftp=3D${UBOOT_TRAVIS_BUILD_DIR} -device e1000,netdev=3Dnet0 -dev=
ice virtio-rng-pci -d unimp -semihosting-config enable=3Don,target=3Dnative=
 -chardev socket,id=3Dchrtpm,path=3D/tmp/tpm/swtpm-sock -tpmdev emulator,id=
=3Dtpm0,chardev=3Dchrtpm -device tpm-tis-device,tpmdev=3Dtpm0"
> >> >
> >> > Can we line break this? Then make some functional groupings? Thanks.
> >> >
> >> I am thinking about to merge this script into the common one
> >> "conf.qemu_arm64_na", but do you mind to add
> >> "virtualization=3Dfalse,secure=3Don" as a common setting? even though =
It
> >> is only needed when running with TF-A/OP-TEE.
>
> Main U-Boot is meant to be running in EL2. So why should we start in EL3 =
without TF-A?
>
> Why do you want to disable virtualization?
>
1. That was my original motivation to make a separate config file for
introducing "secure=3Don", since it might lead to unpredictable
behaviours when without TF-A, even tests done normally.
2. You are right, virtualization=3Dfalse can be removed.

But then we need to make a decision from 2 options:
1. Use one set of config/helper scripts for all qemu_arm64 cases,
ignoring the unpredictable behaviour caused by starting from EL3/EL2.
2. Keep the current patch - use separate sets of config/helper to keep
the concept more clearer. (qemu_helper_script can be just one by using
args, but does not make too much sense when we still have two config
files).

@Tom Rini @Heinrich Schuchardt What are your thoughts?

Regards,
Raymond

> Best regards
>
> Heinrich
>
> >
> >So long as everything works in CI for the other cases, yes, that's fine.
> >
>
