Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 593F6C3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:02:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 329D588676;
	Sat, 13 Jul 2024 15:02:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="HpO3E+Lf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD82A88511; Sat, 13 Jul 2024 10:12:56 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 407FB885F1
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 10:12:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: b3465734-40ef-11ef-959b-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id b3465734-40ef-11ef-959b-00505699b430;
 Sat, 13 Jul 2024 10:12:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=CCGOxP2AFBvY4UUrsh/lo4Z6HoBZ2rMzBLwCF+olgN8=;
 b=HpO3E+Lfj0FkikskKD7j+srZZzglQYCPkyBBje++fCVvJz8mkGt/GABQAqp7v6MlY6fUM3Vk26ddA
 yRFBcK5eBr4Jn2Zzd1kXv6csgbtsa7Vb0NY4kN0djfMeGc95p2FuhF80tj+1G83TIdqp+WApS+8Qu0
 K4oCwKD9AgWkSGjVQj2LfUygHYeqSWKeqQuXo2D/4Q8TFneF+BzQRZBJJrB0uGTm6PA2S3qOtHR2ha
 y2wUoNQv4kjMtnfy2Ynd+qs0ZeDUDNgHWCvZsH4AZpM4uhftd59DwkiK3v6HVH8ic49nc9MY7rZzDy
 +PDGv7vSMVTsRTRtOIPUUvbELsLJy3w==
X-KPN-MID: 33|MGRo/8gbfYekUQeOtkMbabEsOupxjiifEWIOlju/3l8Xv3TBH1r5dMikv6HAcHe
 CWHOp2CJdLp8MHlJtak3/vrKVNX65HZQ/bEPSfvSLpW8=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|FpN5I3YHz7ORBEziankPCUbjtU2R4eF6WjyycWD357dRld0lR608+lutSnAmO5A
 yro0OXlegpjNsnCrmuNOqvA==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id b28e3f18-40ef-11ef-815f-005056998788;
 Sat, 13 Jul 2024 10:12:52 +0200 (CEST)
Date: Sat, 13 Jul 2024 10:12:50 +0200
Message-Id: <87a5iliubh.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, seanga2@gmail.com,
 sheng.tan@9elements.com, sjg@chromium.org,
 akashi.tkhro@gmail.com, abdellatif.elkhlifi@arm.com,
 agendin@matrox.com, linux.amoon@gmail.com,
 andre.przywara@arm.com, afd@ti.com, artur@conclusive.pl,
 bmeng.cn@gmail.com, bb@ti.com, caleb.connolly@linaro.org,
 chanho61.park@samsung.com, devarsht@ti.com,
 eajames@linux.ibm.com, etienne.carriere@foss.st.com,
 francis.laniel@amarulasolutions.com, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org, vanbaren@cideas.com,
 mr.bossman075@gmail.com, jonas@kwiboo.se,
 jpewhacker@gmail.com, kever.yang@rock-chips.com,
 leon@georgemail.eu, lukas.funke@weidmueller.com,
 abbaraju.manojsai@amarulasolutions.com,
 marek.vasut+renesas@mailbox.org, marex@denx.de,
 mkorpershoek@baylibre.com, n-jain1@ti.com, nm@ti.com,
 oleksandr.suvorov@foundries.io, pbrobinson@gmail.com,
 rasmus.villemoes@prevas.dk, raymond.mao@linaro.org,
 semen.protsenko@linaro.org, samuel@sholland.org,
 yangshiji66@outlook.com, sughosh.ganu@linaro.org,
 sumit.garg@linaro.org, sunil@amarulasolutions.com,
 tom@tom-fitzhenry.me.uk, trini@konsulko.com, troykiskyboundary@gmail.com
In-Reply-To: <20240713070055.2172883-1-sjg@chromium.org> (message from Simon
 Glass on Sat, 13 Jul 2024 08:00:34 +0100)
Subject: Re: [PATCH v2 00/21] Universal Payload initial series
References: <20240713070055.2172883-1-sjg@chromium.org>
X-Mailman-Approved-At: Sat, 13 Jul 2024 15:02:33 +0200
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

> From: Simon Glass <sjg@chromium.org>
> Date: Sat, 13 Jul 2024 08:00:34 +0100
> 
> Universal Payload (UPL) is an Industry Standard for firmware
> components[1].

I think you have some trouble understanding the concept of industry
standard ;).  I guess you want this to become an industry standard.
Firmly https://xkcd.com/927/ territory if you ask me.

> UPL is designed to improve interoperability within the
> firmware industry, allowing mixing and matching of projects with less
> friction and fewer project-specific implementations. UPL is
> cross-platform, supporting ARM, x86 and RISC-V initially.
> 
> This series provides some initial support for this, targeting 0.9.1 and
> sandbox only.
> 
> Features still to come include:
> - Support for architectures
> - FIT validation
> - Handoff validation
> - Interoperability tests
> 
> This series is available at dm/uplb-working and requires the alist
> series at dm/alist-working[2]
> 
> [1] https://universalpayload.github.io/spec/
> [2] https://patchwork.ozlabs.org/project/uboot/list/?series=414642
> 
> Changes in v2:
> - Put the upl tests under their own subcommand to avoid bootstd init
> - Add a function to init the UPL process in SPL
> - Hang when something goes wrong, to avoid a broken boot
> - Add a runtime flag to enable UPL
> - Add a link to the spec
> - Add a link to the command
> - Support CI testing
> - Rework to use alist instead of fixed-length arrays
> 
> Simon Glass (21):
>   sandbox: Use const in os_jump_to_file()
>   sandbox: Fix a comment in os_find_u_boot()
>   test: Move some SPL-loading test-code into sandbox common
>   sandbox: Enable SPL_LOAD_BLOCK
>   fdt: Don't overwrite bloblist devicetree
>   sandbox: fdt: Avoid overwriting an existing fdt
>   sandbox: Return error code from read/write/seek
>   sandbox: Add ELF file to VPL u-boot.img
>   sandbox: Set up global_data earlier
>   upl: Add support for reading a upl handoff
>   upl: Add support for writing a upl handoff
>   upl: Add basic tests
>   upl: Add a command
>   upl: Add support for Universal Payload in SPL
>   spl: Plumb in the Universal Payload handoff
>   upl: Plumb in universal payload to the init process
>   sandbox_vpl: Enable Universal Payload
>   upl: Add initial documentation
>   sandbox: Add a flag to enable UPL
>   sandbox: Add an SPL loader for UPL
>   upl: Add an end-to-end test
> 
>  MAINTAINERS                       |  13 +
>  Makefile                          |   4 +-
>  arch/sandbox/cpu/cpu.c            |   2 +
>  arch/sandbox/cpu/os.c             |  30 +-
>  arch/sandbox/cpu/spl.c            | 116 +++++-
>  arch/sandbox/cpu/start.c          |  18 +-
>  arch/sandbox/include/asm/spl.h    |  15 +
>  arch/sandbox/include/asm/state.h  |   1 +
>  boot/Kconfig                      |  70 ++++
>  boot/Makefile                     |   4 +
>  boot/upl_common.c                 |  60 +++
>  boot/upl_common.h                 |  24 ++
>  boot/upl_read.c                   | 588 ++++++++++++++++++++++++++++
>  boot/upl_write.c                  | 622 ++++++++++++++++++++++++++++++
>  cmd/Kconfig                       |   7 +
>  cmd/Makefile                      |   1 +
>  cmd/upl.c                         | 118 ++++++
>  common/board_f.c                  |  22 ++
>  common/board_r.c                  |   2 +
>  common/spl/Kconfig                |   1 +
>  common/spl/Makefile               |   2 +
>  common/spl/spl.c                  |   8 +
>  common/spl/spl_fit.c              |  22 ++
>  common/spl/spl_upl.c              | 171 ++++++++
>  configs/sandbox_defconfig         |   1 +
>  configs/sandbox_vpl_defconfig     |   4 +
>  doc/usage/cmd/upl.rst             | 186 +++++++++
>  doc/usage/index.rst               |   2 +
>  doc/usage/upl.rst                 |  46 +++
>  drivers/block/sandbox.c           |   4 +-
>  drivers/usb/emul/sandbox_flash.c  |   2 +-
>  fs/sandbox/sandboxfs.c            |   6 +-
>  include/asm-generic/global_data.h |  19 +
>  include/os.h                      |   6 +-
>  include/spl.h                     |  16 +
>  include/test/suites.h             |   1 +
>  include/upl.h                     | 361 +++++++++++++++++
>  lib/fdtdec.c                      |   1 +
>  test/boot/Makefile                |   2 +
>  test/boot/upl.c                   | 436 +++++++++++++++++++++
>  test/cmd_ut.c                     |   3 +
>  test/image/spl_load_os.c          |  53 +--
>  test/py/tests/test_upl.py         |  38 ++
>  43 files changed, 3036 insertions(+), 72 deletions(-)
>  create mode 100644 boot/upl_common.c
>  create mode 100644 boot/upl_common.h
>  create mode 100644 boot/upl_read.c
>  create mode 100644 boot/upl_write.c
>  create mode 100644 cmd/upl.c
>  create mode 100644 common/spl/spl_upl.c
>  create mode 100644 doc/usage/cmd/upl.rst
>  create mode 100644 doc/usage/upl.rst
>  create mode 100644 include/upl.h
>  create mode 100644 test/boot/upl.c
>  create mode 100644 test/py/tests/test_upl.py
> 
> -- 
> 2.34.1
> 
> 
