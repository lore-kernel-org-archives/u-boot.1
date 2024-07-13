Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7FC9C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 23:59:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B163F882AA;
	Sun, 14 Jul 2024 01:59:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="QmlO6lGH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C0A588765; Sat, 13 Jul 2024 21:41:18 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFA2F8855E
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 21:41:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1720899627; x=1721504427; i=xypron.glpk@gmx.de;
 bh=CTmCrXeqqA504h67pHgz8PShdAqkHL1+F0XDIVzZ3yI=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=QmlO6lGHHyUE9+g5Z/hzRuf2IkMLCl6jHH3/Tv9cm+FYyufLoSwzVpwshgelEhQv
 1vdmx0kRkJU7Xsy17Tc2W3felznQBejpQTNA1LKoGL6kgyelpz0QvGJlB1k7EaSqH
 de7XUzJdCW275EwMQjNQ1rxF/48m8qI+WPdgOPxieil9RrCXeFP38w8XVZhfvqpPP
 svby3nloREpHIz8DV4EMGUepv4iwNKUhCBQNGgRe0DQN6moBq2TPo2T2c5xh9w0Gr
 ec8/JFsAcb5TnTTidOxYylXmtCL8CJkBYVBA9d72mwhp0Vt29I5gMNuI6kFnkx+Gn
 8dDvXf+IEznNepRxwQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([62.143.93.80]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mlw7f-1s1wgy1N1H-00ao08; Sat, 13
 Jul 2024 21:40:27 +0200
Date: Sat, 13 Jul 2024 21:40:17 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>
CC: u-boot@lists.denx.de, michal.simek@amd.com, seanga2@gmail.com,
 sheng.tan@9elements.com, sjg@chromium.org, akashi.tkhro@gmail.com,
 abdellatif.elkhlifi@arm.com, agendin@matrox.com, linux.amoon@gmail.com,
 andre.przywara@arm.com, afd@ti.com, artur@conclusive.pl, bmeng.cn@gmail.com,
 bb@ti.com, caleb.connolly@linaro.org, chanho61.park@samsung.com,
 devarsht@ti.com, eajames@linux.ibm.com, etienne.carriere@foss.st.com,
 francis.laniel@amarulasolutions.com, ilias.apalodimas@linaro.org,
 vanbaren@cideas.com, mr.bossman075@gmail.com, jonas@kwiboo.se,
 jpewhacker@gmail.com, kever.yang@rock-chips.com, leon@georgemail.eu,
 lukas.funke@weidmueller.com, abbaraju.manojsai@amarulasolutions.com,
 marek.vasut+renesas@mailbox.org, marex@denx.de, mkorpershoek@baylibre.com,
 n-jain1@ti.com, nm@ti.com, oleksandr.suvorov@foundries.io,
 pbrobinson@gmail.com, rasmus.villemoes@prevas.dk, raymond.mao@linaro.org,
 semen.protsenko@linaro.org, samuel@sholland.org, yangshiji66@outlook.com,
 sughosh.ganu@linaro.org, sumit.garg@linaro.org, sunil@amarulasolutions.com,
 tom@tom-fitzhenry.me.uk, trini@konsulko.com, troykiskyboundary@gmail.com
Subject: Re: [PATCH v2 00/21] Universal Payload initial series
User-Agent: K-9 Mail for Android
In-Reply-To: <87a5iliubh.fsf@bloch.sibelius.xs4all.nl>
References: <20240713070055.2172883-1-sjg@chromium.org>
 <87a5iliubh.fsf@bloch.sibelius.xs4all.nl>
Message-ID: <09FB197A-06C8-4162-AAB6-3823BA2840B3@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lc11j8Nh6W5CXr/ngcY3TcJkLkiQja5B3Zj6v7Jpt+bNRD2MxCQ
 tWJ5M54noo4S3+fiXrTTl3hSsx+oGxdMexRfEeqrjH7FcDglIfVO6GJrv3SAwcmDJtJXlWu
 vzNSPr3WBTFbbxbLcmiCfYlEMrGTSoyYBWkXKhcSNd7buem++PF68DWCaC/HKvLUKjDNqFa
 M+1czmURBUiH6w/4ty87w==
UI-OutboundReport: notjunk:1;M01:P0:JB8F2lT2PWo=;leWTvZQ0BHVjLZruNroCApP2RJD
 JfFD7OuNNILUR9TeNx4fltyVyssLFcYiYZJ+GVM7KvW2DLcScjsoK1chesLVJG50yBUaVAC7e
 WngyBSgjD+sxGuoDdYiC/8ViaUX4EWoeCzw1rkixajBne4gmdvo2Y6I25c7QDAXxeeXW81Egp
 7r1j5wir6gr70RQt3U73msB2VRwMg7DsHFoQZIy8vEf+xbLcW8fPOycQae2IxK4uezgOVWkbf
 8nk0ub/bhNR7RcJ9WUVCM4qn6V7Jl7Zr9HprPxJhlZsDuEQYjuUF1dEpddzbZJUy9ZHZSYud0
 NlYzxn8bsywyXMHIto+sYLI1+B5jYb3/q/eiITILd4ynqssEgQZlycM8UW5QCsN0oLHeC0WYp
 GTtuDqnqynutOSzThxfO9ISj/33tGYjlb0O4rqmx2LM7RNEa76cRhQ3IpUu1yudSM/qEIz/h/
 cp9QDSFRtbX6ptaPxyy3fVi3W79iJV3Pz4QqAbwKrPqmYrKCSubJL/9KAhPzRGyFp8+89MtRp
 uORMlVk+AFoIidQk3vRxur5I2QTZsnZp08CPlb1i2KZrQPILOmD/89sOza9d1Lm+CmM53O6x4
 2FfES8n9prqVdD/jchgRasKsNuOLY9hniSnIgAjGajnYLOCRiZV8bXNrTQ3p3gua26ZqpHeJi
 8FyKDsErm3NBn4bAjWS4omTJQOG/Kn+zGHvK/OsVJxFrBZq5FvM6DEmw1TnM02xosnTn/sAD8
 EBpNUJNKIk8MQJ5cDMsZ2aw5YUXkvApbvIj5lUSiSvUyBzISC8AmGQAZyR7aJJ3ZZnGkyKQvb
 uqvwzmVbkPKjAXvIbus5jKcw==
X-Mailman-Approved-At: Sun, 14 Jul 2024 01:59:54 +0200
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



Am 13=2E Juli 2024 10:12:50 MESZ schrieb Mark Kettenis <mark=2Ekettenis@xs=
4all=2Enl>:
>> From: Simon Glass <sjg@chromium=2Eorg>
>> Date: Sat, 13 Jul 2024 08:00:34 +0100
>>=20
>> Universal Payload (UPL) is an Industry Standard for firmware
>> components[1]=2E
>
>I think you have some trouble understanding the concept of industry
>standard ;)=2E  I guess you want this to become an industry standard=2E
>Firmly https://xkcd=2Ecom/927/ territory if you ask me=2E
>
>> UPL is designed to improve interoperability within the
>> firmware industry, allowing mixing and matching of projects with less
>> friction and fewer project-specific implementations=2E UPL is
>> cross-platform, supporting ARM, x86 and RISC-V initially=2E
>>=20
>> This series provides some initial support for this, targeting 0=2E9=2E1=
 and
>> sandbox only=2E
>>=20
>> Features still to come include:
>> - Support for architectures
>> - FIT validation
>> - Handoff validation
>> - Interoperability tests
>>=20
>> This series is available at dm/uplb-working and requires the alist
>> series at dm/alist-working[2]

Why is this series needed?

SPL loading a FIT image as described in the "universal" payload spec is al=
ready implemented in U-Boot and for instance works fine for running EDK II =
on RISC-V=2E

I cannot see what functionality is missing in U-Boot=2E

The UPL seems to be half cooked:

The FIT file format is already described elsewhere=2E

The relocation chapter describes that it should better be removed=2E

The device-tree chapter duplicates content of the device-tree specificatio=
n and ignores the existing standardization via the Linux project=2E

The authors seem not to have given any thought to ACPI=2E

So let us wait if that UPL thing ever lifts off before wasting a code line=
 on it=2E

Best regards

Heinrich

>>=20
>> [1] https://universalpayload=2Egithub=2Eio/spec/
>> [2] https://patchwork=2Eozlabs=2Eorg/project/uboot/list/?series=3D41464=
2
>>=20
>> Changes in v2:
>> - Put the upl tests under their own subcommand to avoid bootstd init
>> - Add a function to init the UPL process in SPL
>> - Hang when something goes wrong, to avoid a broken boot
>> - Add a runtime flag to enable UPL
>> - Add a link to the spec
>> - Add a link to the command
>> - Support CI testing
>> - Rework to use alist instead of fixed-length arrays
>>=20
>> Simon Glass (21):
>>   sandbox: Use const in os_jump_to_file()
>>   sandbox: Fix a comment in os_find_u_boot()
>>   test: Move some SPL-loading test-code into sandbox common
>>   sandbox: Enable SPL_LOAD_BLOCK
>>   fdt: Don't overwrite bloblist devicetree
>>   sandbox: fdt: Avoid overwriting an existing fdt
>>   sandbox: Return error code from read/write/seek
>>   sandbox: Add ELF file to VPL u-boot=2Eimg
>>   sandbox: Set up global_data earlier
>>   upl: Add support for reading a upl handoff
>>   upl: Add support for writing a upl handoff
>>   upl: Add basic tests
>>   upl: Add a command
>>   upl: Add support for Universal Payload in SPL
>>   spl: Plumb in the Universal Payload handoff
>>   upl: Plumb in universal payload to the init process
>>   sandbox_vpl: Enable Universal Payload
>>   upl: Add initial documentation
>>   sandbox: Add a flag to enable UPL
>>   sandbox: Add an SPL loader for UPL
>>   upl: Add an end-to-end test
>>=20
>>  MAINTAINERS                       |  13 +
>>  Makefile                          |   4 +-
>>  arch/sandbox/cpu/cpu=2Ec            |   2 +
>>  arch/sandbox/cpu/os=2Ec             |  30 +-
>>  arch/sandbox/cpu/spl=2Ec            | 116 +++++-
>>  arch/sandbox/cpu/start=2Ec          |  18 +-
>>  arch/sandbox/include/asm/spl=2Eh    |  15 +
>>  arch/sandbox/include/asm/state=2Eh  |   1 +
>>  boot/Kconfig                      |  70 ++++
>>  boot/Makefile                     |   4 +
>>  boot/upl_common=2Ec                 |  60 +++
>>  boot/upl_common=2Eh                 |  24 ++
>>  boot/upl_read=2Ec                   | 588 ++++++++++++++++++++++++++++
>>  boot/upl_write=2Ec                  | 622 ++++++++++++++++++++++++++++=
++
>>  cmd/Kconfig                       |   7 +
>>  cmd/Makefile                      |   1 +
>>  cmd/upl=2Ec                         | 118 ++++++
>>  common/board_f=2Ec                  |  22 ++
>>  common/board_r=2Ec                  |   2 +
>>  common/spl/Kconfig                |   1 +
>>  common/spl/Makefile               |   2 +
>>  common/spl/spl=2Ec                  |   8 +
>>  common/spl/spl_fit=2Ec              |  22 ++
>>  common/spl/spl_upl=2Ec              | 171 ++++++++
>>  configs/sandbox_defconfig         |   1 +
>>  configs/sandbox_vpl_defconfig     |   4 +
>>  doc/usage/cmd/upl=2Erst             | 186 +++++++++
>>  doc/usage/index=2Erst               |   2 +
>>  doc/usage/upl=2Erst                 |  46 +++
>>  drivers/block/sandbox=2Ec           |   4 +-
>>  drivers/usb/emul/sandbox_flash=2Ec  |   2 +-
>>  fs/sandbox/sandboxfs=2Ec            |   6 +-
>>  include/asm-generic/global_data=2Eh |  19 +
>>  include/os=2Eh                      |   6 +-
>>  include/spl=2Eh                     |  16 +
>>  include/test/suites=2Eh             |   1 +
>>  include/upl=2Eh                     | 361 +++++++++++++++++
>>  lib/fdtdec=2Ec                      |   1 +
>>  test/boot/Makefile                |   2 +
>>  test/boot/upl=2Ec                   | 436 +++++++++++++++++++++
>>  test/cmd_ut=2Ec                     |   3 +
>>  test/image/spl_load_os=2Ec          |  53 +--
>>  test/py/tests/test_upl=2Epy         |  38 ++
>>  43 files changed, 3036 insertions(+), 72 deletions(-)
>>  create mode 100644 boot/upl_common=2Ec
>>  create mode 100644 boot/upl_common=2Eh
>>  create mode 100644 boot/upl_read=2Ec
>>  create mode 100644 boot/upl_write=2Ec
>>  create mode 100644 cmd/upl=2Ec
>>  create mode 100644 common/spl/spl_upl=2Ec
>>  create mode 100644 doc/usage/cmd/upl=2Erst
>>  create mode 100644 doc/usage/upl=2Erst
>>  create mode 100644 include/upl=2Eh
>>  create mode 100644 test/boot/upl=2Ec
>>  create mode 100644 test/py/tests/test_upl=2Epy
>>=20
>> --=20
>> 2=2E34=2E1
>>=20
>>=20
