Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1A1CAC597
	for <u-boot@archiver.kernel.org>; Thu, 18 Sep 2025 10:44:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B50680B9B;
	Thu, 18 Sep 2025 12:44:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Yc14Ui3p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C706181E13; Thu, 18 Sep 2025 12:44:49 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A598E80107
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 12:44:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1758192274; x=1758797074; i=xypron.glpk@gmx.de;
 bh=GM77iG/NsWG265acdQoWw1qtO5DvgGOTQjseDRns6bM=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Yc14Ui3pL4kx0CJ0XALbpb1o68YRM/IvWt+ldGV+XNiUByB2LvVrs4UB6FfN1iHM
 oH4y/3SfVSAT8wqz4LiRwawzYYhYQOHbP1LN/ynhLpyBKh4EvVDUerZFuUfEuEW8c
 zpxUWsQi9wVxI+GpL8+WSLwbwUP795GjvYP6ip6swP+y7clf9Tm425fcpbNd/nlo+
 OswXpClTlQwdgepnhRgnuKVkqBv5DpHjGwQfDez00GqbH0sLx4GpoOJM2tLKtkzJP
 aLGi5SS11j3LcRp2F/GYmAf131y306Lk9R6k7IwB2Ufy4sXeowk3WGgHObLG5Uqwz
 LBCCU59ObVMeLzflZA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([61.8.154.227]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N9dwd-1uMChQ3u4r-010jY1; Thu, 18
 Sep 2025 12:44:34 +0200
Date: Thu, 18 Sep 2025 12:44:31 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>, Raymond Mao <raymond.mao@linaro.org>
CC: u-boot@lists.denx.de, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_u-boot-test-hooks_2/2=5D_travis-ci=3A_add_co?=
 =?US-ASCII?Q?nfig_file_for_testing_firmware_handoff_on_qemu=5Farm64?=
User-Agent: Thunderbird for Android
In-Reply-To: <20250917154503.GL124814@bill-the-cat>
References: <20250916161230.32140-1-raymond.mao@linaro.org>
 <20250916161230.32140-2-raymond.mao@linaro.org>
 <20250916182729.GX124814@bill-the-cat>
 <CAEfUkULE=tHe+hyerxBW5MRarO+JeJb59B-1voTFVjGmuPaidA@mail.gmail.com>
 <20250917154503.GL124814@bill-the-cat>
Message-ID: <3D57BD7A-AE77-4240-89C1-AF2BDD979B64@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WMtWrjEFLVdI4QGLOXHqMHeU1SaJkM0ZBODAKdfbAGU93hqkdWo
 DtehYni4fAmeGuQOcMbUWd7TUqtHPeo0B2XBcTgnOF8OTbLYmlVQlT3YIm+CZtP8sD5hQzL
 9pJqAdGGIKMNFHLMt4IfR0lIqs7yL2WkqxjB0kFUG5ur03LKXJLVoRBWMzFQpi1dFYzQnTT
 Plp3NbHOXjOFKllkQu0Pw==
UI-OutboundReport: notjunk:1;M01:P0:oHwyue1Dexo=;h+yBIDOfMvJFrBZQP3vhukWElD7
 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
 qQqHlydu1PIISQ1lvH0avECkHRMteSjQ==
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

Am 17=2E September 2025 17:45:03 MESZ schrieb Tom Rini <trini@konsulko=2Eco=
m>:
>On Wed, Sep 17, 2025 at 10:42:52AM -0400, Raymond Mao wrote:
>> Hi Tom,
>>=20
>> On Tue, 16 Sept 2025 at 14:27, Tom Rini <trini@konsulko=2Ecom> wrote:
>> >
>> > On Tue, Sep 16, 2025 at 09:12:25AM -0700, Raymond Mao wrote:
>> >
>> > > The existing 'conf=2Eqemu_arm64_na' uses 'u-boot=2Ebin' as bios, bu=
t for
>> > > the case of TF-A, 'u-boot=2Ebin' is BL33 and the assembled 'flash=
=2Ebin'
>> > > is the bios instead, which will be built and assembled at run-time
>> > > via a post-buildman script and copied to '/tmp'=2E
>> > >
>> > > Moreover, for running TF-A and OP-TEE on qemu, '-m 4G' and
>> > > 'virtualization=3Dfalse,secure=3Don' are required, and '-semihostin=
g'
>> > > should be replaced with its modern alias
>> > > '-semihosting-config enable=3Don,target=3Dnative'=2E
>> > >
>> > > Last, point to the new helper script 'swtpm-tfa'=2E
>> > >
>> > > Signed-off-by: Raymond Mao <raymond=2Emao@linaro=2Eorg>
>> >
>> > Lets fixup the current qemu_arm64 conf to have as much in common as
>> > possible (4G, modern semihosting flags, etc)=2E Next:
>> >
>> > > ---
>> > >  =2E=2E=2E/conf=2Eqemu_arm64_fw_handoff_tfa_optee      | 31 +++++++=
++++++++++++
>> > >  1 file changed, 31 insertions(+)
>> > >  create mode 100644 bin/travis-ci/conf=2Eqemu_arm64_fw_handoff_tfa_=
optee
>> > >
>> > > diff --git a/bin/travis-ci/conf=2Eqemu_arm64_fw_handoff_tfa_optee b=
/bin/travis-ci/conf=2Eqemu_arm64_fw_handoff_tfa_optee
>> > > new file mode 100644
>> > > index 0000000=2E=2E9aa6d3b
>> > > --- /dev/null
>> > > +++ b/bin/travis-ci/conf=2Eqemu_arm64_fw_handoff_tfa_optee
>> > > @@ -0,0 +1,31 @@
>> > > +# Copyright (c) 2025 Linaro Limited
>> > > +# Author: Raymond Mao <raymond=2Emao@linaro=2Eorg>
>> > > +# Based on conf=2Eqemu_arm64 which is
>> > > +# Copyright (c) 2017 Tuomas Tynkkynen=2E All rights reserved=2E
>> > > +#
>> > > +# Permission is hereby granted, free of charge, to any person obta=
ining a
>> > > +# copy of this software and associated documentation files (the "S=
oftware"),
>> > > +# to deal in the Software without restriction, including without l=
imitation
>> > > +# the rights to use, copy, modify, merge, publish, distribute, sub=
license,
>> > > +# and/or sell copies of the Software, and to permit persons to who=
m the
>> > > +# Software is furnished to do so, subject to the following conditi=
ons:
>> > > +#
>> > > +# The above copyright notice and this permission notice shall be i=
ncluded in
>> > > +# all copies or substantial portions of the Software=2E
>> > > +#
>> > > +# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, =
EXPRESS OR
>> > > +# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANT=
ABILITY,
>> > > +# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT=2E  IN NO E=
VENT SHALL
>> > > +# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGE=
S OR OTHER
>> > > +# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, =
ARISING
>> > > +# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OT=
HER
>> > > +# DEALINGS IN THE SOFTWARE=2E
>> > > +
>> > > +console_impl=3Dqemu
>> > > +qemu_machine=3D"virt,virtualization=3Dfalse,secure=3Don"
>> > > +qemu_helper_script=3D"swtpm-tfa"
>> > > +qemu_binary=3D"qemu-system-aarch64"
>> > > +qemu_extra_args=3D"-m 4G -cpu cortex-a57 -nographic -netdev user,i=
d=3Dnet0,tftp=3D${UBOOT_TRAVIS_BUILD_DIR} -device e1000,netdev=3Dnet0 -devi=
ce virtio-rng-pci -d unimp -semihosting-config enable=3Don,target=3Dnative =
-chardev socket,id=3Dchrtpm,path=3D/tmp/tpm/swtpm-sock -tpmdev emulator,id=
=3Dtpm0,chardev=3Dchrtpm -device tpm-tis-device,tpmdev=3Dtpm0"
>> >
>> > Can we line break this? Then make some functional groupings? Thanks=
=2E
>> >
>> I am thinking about to merge this script into the common one
>> "conf=2Eqemu_arm64_na", but do you mind to add
>> "virtualization=3Dfalse,secure=3Don" as a common setting? even though I=
t
>> is only needed when running with TF-A/OP-TEE=2E

Main U-Boot is meant to be running in EL2=2E So why should we start in EL3=
 without TF-A?

Why do you want to disable virtualization?

Best regards

Heinrich

>
>So long as everything works in CI for the other cases, yes, that's fine=
=2E
>

