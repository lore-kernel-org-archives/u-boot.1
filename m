Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E8ECAC59A
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 14:43:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 238D3835CB;
	Wed, 17 Sep 2025 16:43:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sYCJCD9P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DDC9835EA; Wed, 17 Sep 2025 16:43:08 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A925835B3
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 16:43:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-267dff524d1so13845225ad.3
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 07:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758120184; x=1758724984; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3LT7JT4hC0/cKNI+OIc8DcCQfCVmiRYp1WMZqBbiHok=;
 b=sYCJCD9PxfzNnpVbIKYoRvgIKHH0Y79UgE9+gEq0JMBJr7OtPzTqJjVh2ofg8+S/29
 s4y+aw1N4Pxukj5Yx3zu8+6zww6bKx/4yL6R+6X/MqakTuQnE9+NGJ7w5OuWKg/uVbqg
 HKBCr0Rw6xZJSD6oce1MK0QfOqCwMDlB5cw4AuQnzxCpH4+gFk2kB8G5WS1EAeibe6BV
 GfZZHk4XSe+lOMAH+S+OkHw7+sw/ugyZ9H3nLt5L/B0D2uxViWfqcIqrRFTVcHazO3qx
 tzKB1puX2f/TXkgAulSzmDL3ehGg2FRxmqk3lgEGO6wukyiBVH7OvjmwshvYmFR0ySx/
 3WDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758120184; x=1758724984;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3LT7JT4hC0/cKNI+OIc8DcCQfCVmiRYp1WMZqBbiHok=;
 b=Td1pGexcEuAGgOj8JXkcPmKtFHkPxubJzL5K9sfyLuuTm+MlGnRwfDXauGKhnw+CpB
 rLB4sTnE3IuzZ9n/E7E63ak+PeytHBI873fnB1RnYlRAgr4cLelDr07HJIkKiHiomILj
 9r0UhQ1wECH4+9z/nfuM8KF7c5+Ok0yajhPfGA5+nG5xGekHFWuwSK7JC08V5HgeMFuA
 P+QGXbZmbIU9w5SRmfvkKo1WqF44WAWyysPhvgekX6ok+BaDeFb8RFmUAZ0SUNb1GkFV
 nkR/jOlpVfu08ZZWuYNVdqC8OWxlLboiB4A6SIudY17tRzDFg26lTCBqurwuzTEqadRr
 CakQ==
X-Gm-Message-State: AOJu0YxK75bxMPgUpLNtDXXZbMwAbN/KtST1njug68mThzp7DFCFa9j9
 +Y3JmkYNWo5h7el/hMgx9sPWAMRM2Vl4ixG0BewIYNgPZ4OPqVcxf8ZOVkhWadfWLjMdK1xKMl5
 Gw2cad5lzc/wWWcalAaWtbXMf2EJngIz/2m8RA4t4mQ==
X-Gm-Gg: ASbGnculGQudhcT8TbMVcm8FMSxkEXi3d6pg3VSnzVkumtySJggVO9WGPeLHt64HyVX
 zoabbHbYM4JLbKK4bmElT4ykDfL3YoRDbO2wOqGIryi86mp8MHDYaJK0OVEKHRWXISemXf1Agpe
 UetSdtsNl6k8R4kgc7M6QU4XsGOjSaNQ1qqOgigVAUMZctoLEN2Rjl1zRwHRjO7vH8TNhWQ5KYD
 7B58xVBbN6WwSUaWDJq
X-Google-Smtp-Source: AGHT+IE1kzQOl+Zhn93jUkW3lgM/ghZdrI/41LJlPkMno/quekQXueFQH1V6GiS8nVCc3LPavyJLjNo0cVjkPd/uwlQ=
X-Received: by 2002:a17:902:db0d:b0:265:c476:9a53 with SMTP id
 d9443c01a7336-26813cf234fmr25288335ad.41.1758120183906; Wed, 17 Sep 2025
 07:43:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250916161230.32140-1-raymond.mao@linaro.org>
 <20250916161230.32140-2-raymond.mao@linaro.org>
 <20250916182729.GX124814@bill-the-cat>
In-Reply-To: <20250916182729.GX124814@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 17 Sep 2025 10:42:52 -0400
X-Gm-Features: AS18NWCpBldcOLUh9EzVd5lv1IeFd4krMYHwV6K1O2WAjqGJBx-8l9seuQtKYdM
Message-ID: <CAEfUkULE=tHe+hyerxBW5MRarO+JeJb59B-1voTFVjGmuPaidA@mail.gmail.com>
Subject: Re: [PATCH u-boot-test-hooks 2/2] travis-ci: add config file for
 testing firmware handoff on qemu_arm64
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Simon Glass <sjg@chromium.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
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

Hi Tom,

On Tue, 16 Sept 2025 at 14:27, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Sep 16, 2025 at 09:12:25AM -0700, Raymond Mao wrote:
>
> > The existing 'conf.qemu_arm64_na' uses 'u-boot.bin' as bios, but for
> > the case of TF-A, 'u-boot.bin' is BL33 and the assembled 'flash.bin'
> > is the bios instead, which will be built and assembled at run-time
> > via a post-buildman script and copied to '/tmp'.
> >
> > Moreover, for running TF-A and OP-TEE on qemu, '-m 4G' and
> > 'virtualization=3Dfalse,secure=3Don' are required, and '-semihosting'
> > should be replaced with its modern alias
> > '-semihosting-config enable=3Don,target=3Dnative'.
> >
> > Last, point to the new helper script 'swtpm-tfa'.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
>
> Lets fixup the current qemu_arm64 conf to have as much in common as
> possible (4G, modern semihosting flags, etc). Next:
>
> > ---
> >  .../conf.qemu_arm64_fw_handoff_tfa_optee      | 31 +++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >  create mode 100644 bin/travis-ci/conf.qemu_arm64_fw_handoff_tfa_optee
> >
> > diff --git a/bin/travis-ci/conf.qemu_arm64_fw_handoff_tfa_optee b/bin/t=
ravis-ci/conf.qemu_arm64_fw_handoff_tfa_optee
> > new file mode 100644
> > index 0000000..9aa6d3b
> > --- /dev/null
> > +++ b/bin/travis-ci/conf.qemu_arm64_fw_handoff_tfa_optee
> > @@ -0,0 +1,31 @@
> > +# Copyright (c) 2025 Linaro Limited
> > +# Author: Raymond Mao <raymond.mao@linaro.org>
> > +# Based on conf.qemu_arm64 which is
> > +# Copyright (c) 2017 Tuomas Tynkkynen. All rights reserved.
> > +#
> > +# Permission is hereby granted, free of charge, to any person obtainin=
g a
> > +# copy of this software and associated documentation files (the "Softw=
are"),
> > +# to deal in the Software without restriction, including without limit=
ation
> > +# the rights to use, copy, modify, merge, publish, distribute, sublice=
nse,
> > +# and/or sell copies of the Software, and to permit persons to whom th=
e
> > +# Software is furnished to do so, subject to the following conditions:
> > +#
> > +# The above copyright notice and this permission notice shall be inclu=
ded in
> > +# all copies or substantial portions of the Software.
> > +#
> > +# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPR=
ESS OR
> > +# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABIL=
ITY,
> > +# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT S=
HALL
> > +# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR=
 OTHER
> > +# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARIS=
ING
> > +# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> > +# DEALINGS IN THE SOFTWARE.
> > +
> > +console_impl=3Dqemu
> > +qemu_machine=3D"virt,virtualization=3Dfalse,secure=3Don"
> > +qemu_helper_script=3D"swtpm-tfa"
> > +qemu_binary=3D"qemu-system-aarch64"
> > +qemu_extra_args=3D"-m 4G -cpu cortex-a57 -nographic -netdev user,id=3D=
net0,tftp=3D${UBOOT_TRAVIS_BUILD_DIR} -device e1000,netdev=3Dnet0 -device v=
irtio-rng-pci -d unimp -semihosting-config enable=3Don,target=3Dnative -cha=
rdev socket,id=3Dchrtpm,path=3D/tmp/tpm/swtpm-sock -tpmdev emulator,id=3Dtp=
m0,chardev=3Dchrtpm -device tpm-tis-device,tpmdev=3Dtpm0"
>
> Can we line break this? Then make some functional groupings? Thanks.
>
I am thinking about to merge this script into the common one
"conf.qemu_arm64_na", but do you mind to add
"virtualization=3Dfalse,secure=3Don" as a common setting? even though It
is only needed when running with TF-A/OP-TEE.

Raymond


> --
> Tom
