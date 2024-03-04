Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 695D8C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 16:09:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E22CB87F9F;
	Mon,  4 Mar 2024 17:09:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="UbtehLxz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57902876A9; Mon,  4 Mar 2024 17:09:14 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C2D887FDE
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 17:09:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1709568537; x=1710173337; i=xypron.glpk@gmx.de;
 bh=ePyu4iXm8jC8SW66FKSr+AtjD6qpnn/AIizJeadqbQY=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=UbtehLxzS36e0UcJuNc7QjG+rnd6/3pym+LmADecWKTismHDSHdVkwzyVZXTotZ5
 JEeTjWOQ+mMEjM744mXabFr+XsBOx1AnWBJ4BPtNJDF9K1DSPdz/kIdOSZo13kNM4
 lBmsXsjxMNN119mYeYQ6uNS3KBoPvhJXDxa+GuQwJep3jb13i/fJcjSBtQWxlr6EJ
 DjToL/kmnCoDxFMwghCSW52ym/VG8KmiWIDl1fRtQdxYkoq6oaOcpCbzEBqbrHL+X
 JnSRtYsqWBZnDvoEqnmN+4uwHQR0JKilqFEqbRvMb+vdU79sUNXV8Zz838JOfn5Pb
 NGk0fnXuXdXC6yA51A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.101] ([109.42.176.242]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRTN9-1rSWIW0c7B-00NRRc; Mon, 04
 Mar 2024 17:08:57 +0100
Message-ID: <d729f99f-fbd2-440c-adf4-f2a25dc120bb@gmx.de>
Date: Mon, 4 Mar 2024 17:08:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] TEE: minor cleanup
Content-Language: en-US
To: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: u-boot@lists.denx.de, AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng@tinylab.org>, Etienne Carriere
 <etienne.carriere@foss.st.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Jorge Ramirez-Ortiz <jorge@foundries.io>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Roger Knecht <rknecht@pm.me>,
 Sean Edmond <seanedmond@microsoft.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240302220108.720637-1-igor.opaniuk@gmail.com>
 <CAC_iWjK+f-ZBKT=Mf6629HxV=NCgoZ_taRMFhGK04aA1Xw-BCA@mail.gmail.com>
 <CAByghJaHFxtQaZ3ZLSbR=qkeLP3GLfOZpMVcKkrkCUqmuhF94w@mail.gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAByghJaHFxtQaZ3ZLSbR=qkeLP3GLfOZpMVcKkrkCUqmuhF94w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tgw0L4V+Ibtlf7KSl1qkVirAaTnRA5gznyiNeojAjacg9IrzYLs
 4iNAorBhyC+CV2Vgypd2tdO++zxtpzPBClGXBqSOa3H0OuLFhnv4Z62656Q352HgibXFYG8
 ZyJxcGyXOcvb/iGHxYMY0q2TA237Bk1Xo3vzbajTG5XWfeuHVUb0o7ki3xpWgQN24KKtwi1
 oWJKBlPbfrszDxN4w6qNw==
UI-OutboundReport: notjunk:1;M01:P0:XCFm93CgIEc=;xoecyc73LaeXIX5s3q/HWIV69ou
 wDer94eqyN+DlSKNYB7rOgS8nNaFN/sZgj2avSeqVoAB9P6wviQdTubqSfuRWKO8xbwhW7VLK
 e0xK3857+Ft3gV6wnoLJRFYS0OVVKIq6II03hh5D0oB05ukHt3CZ16lI90Zo0WWVmYRx2SfMJ
 l6WATD8TRhB9vHh06pO62jwVWcJX/4eZ7cUpphZAQWh0Dymr1r+3gjoleuT85mL+s4HxD7MmA
 kAsaFUP3ZJ1QRARrIdK57X/G1OZX6MGw7kval03wPsHXsPaE4qZW3KndgqyMgx7mlK0MxABao
 QTytfCgmRmSdIFGSWmtGICa6Z1HnBjBhv/jzVjzSGQJOtPcDk4JIkxDH+wgf0AjqVFejMLySo
 U8Z2gWUx8V1I10wKiOCzJRKROpmmkYAni+UsIHswZSy7E5W3zSEnlfb6/3XW6xQ/2QAyXnKnX
 oznQ5x/FnRx8T1n/tCI/rFLy+7lf8vO8K9cxf69TXXbRVjevyUdgyjs6+LdITAMlAP7bVlrQr
 lnaLIc5Oq/IYEu3X+L7ldSnooLVzqy8g3FBBStZQ3zZDgctwHXKfrkBUDcSYHeA2yBW00iLjo
 uHmVo+20g7VTkG/ZUjNKYws58vaxvSFxZ/zP4+Mr5bdWna7Tb2gmVXQByUaUnNbC1sZFf+d6y
 erxDhK/KUy4mO+mGmZcqCSn7sHMFyermDtyNiqIbgf8IebZZ/6QfrMqMNWLZMQg2MRhF0q07n
 x3O/lOcCzjwA2tS5iFUn69T5DfF5WvIdqg2IxQvwzlSCxQr8pkY2kub02tIgBaTWhczyMmIvi
 RojGnDDziOIWWhbRkB7TSn9PDIngMwj0hlKw7Z4SfNHeM=
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

On 04.03.24 16:50, Igor Opaniuk wrote:
> Hi Ilias,
>
> On Mon, Mar 4, 2024 at 12:16=E2=80=AFPM Ilias Apalodimas
> <ilias.apalodimas@linaro.org <mailto:ilias.apalodimas@linaro.org>> wrote=
:
>
>     Hi Igor,
>
>     On Sun, 3 Mar 2024 at 00:01, Igor Opaniuk <igor.opaniuk@gmail.com
>     <mailto:igor.opaniuk@gmail.com>> wrote:
>      >
>      >
>      > - Address some spelling errors and typos
>      > - Support CMD_OPTEE_RPMB for SANDBOX configurations and add
>     python tests
>      > - Remove common.h inclusion for drivers/tee
>      >
>      > Changes in v2:
>      > - Fixed chimp_optee.c:37:9: error: implicit declaration of
>     function 'memset'
>      > - Applied R-b and T-b tags
>
>     https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/1980=
8 <https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/19808>
>     this seems to have a few failures
>
>     Cheers
>     /Ilias
>      >
>      > Igor Opaniuk (5):
>      >=C2=A0 =C2=A0tee: optee: fix description in Kconfig
>      >=C2=A0 =C2=A0tee: sandbox: fix spelling errors
>      >=C2=A0 =C2=A0cmd: optee_rpmb: build cmd for sandbox
>      >=C2=A0 =C2=A0test: py: add optee_rpmb tests
>      >=C2=A0 =C2=A0tee: remove common.h inclusion
>      >
>      >=C2=A0 cmd/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 +++-
>      >=C2=A0 drivers/tee/broadcom/chimp_optee.c |=C2=A0 3 ++-
>      >=C2=A0 drivers/tee/optee/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |=C2=A0 2 +-
>      >=C2=A0 drivers/tee/optee/core.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 1 -
>      >=C2=A0 drivers/tee/optee/i2c.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 1 -
>      >=C2=A0 drivers/tee/optee/rpmb.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 1 -
>      >=C2=A0 drivers/tee/optee/supplicant.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 2=
 +-
>      >=C2=A0 drivers/tee/sandbox.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 10 +++++-----
>      >=C2=A0 drivers/tee/tee-uclass.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 1 -
>      >=C2=A0 test/py/tests/test_optee_rpmb.py=C2=A0 =C2=A0| 20 +++++++++=
+++++++++++
>      >=C2=A0 10 files changed, 32 insertions(+), 13 deletions(-)
>      >=C2=A0 create mode 100644 test/py/tests/test_optee_rpmb.py
>      >
>      > --
>      > 2.34.1
>      >
>
>
> It looks like it's a side effect, the test I added revealed=C2=A0a bug i=
n
> "cmd/optee_rpmb.c" implementation, which I didn't touch (looks
> like it doesn't close the tee session automatically).
>
> I'll address it and add a fix to the patch series.
>
> Just a quick question, are Azure pipelines still used (so I can configur=
e
> my own account and run all these before sending patches, as explained
> in [1])
>
> [1] https://docs.u-boot.org/en/latest/develop/ci_testing.html
> <https://docs.u-boot.org/en/latest/develop/ci_testing.html>

Yes, Azure CI is in use (see https://github.com/u-boot/u-boot).

Creating a pull request for https://github.com/u-boot/u-boot may be the
easier way for a single test run.

Regards

Heinrich
