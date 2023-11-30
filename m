Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC31C4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 11:09:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4952386C47;
	Thu, 30 Nov 2023 12:09:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RH8fQGW1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B14068704E; Thu, 30 Nov 2023 12:09:48 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EC848615A
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 12:09:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-54b532b261bso810252a12.1
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 03:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701342585; x=1701947385; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cXoCPE+9TF+MfZr18lrzDdFim153gc/eAO/6Xu69KEo=;
 b=RH8fQGW1yltmF8ajfDj1n/RiHvlII2F5qbxOlWedoCiIAUZQ627uHQIdEvXguH443a
 zvOeyAHmsH/chf8fEm2Kf6rnnOAQT3+dcoSAaf7tvvIU1qkNm8cjYUxctBt4ub5kBm99
 LVnfXt9qOF2ODdAsK8XU43/rl8uoZeQZEZi2gj6Xke/BCClWWzJYwMqa0fMR39z6DU/t
 y6haKN1CDuSy0w/JcGLVB6bvAxw0CwsAecIi8Ywc++9AMyvdbIsDA8jTPGcvcmbKaGaW
 X5STm6h+6ZGcdSNFArYUXoXdlIyVyFMyTTNeLWk1aFz+CBhzBz+2YA89N2p49mxZb2k8
 oBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701342585; x=1701947385;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cXoCPE+9TF+MfZr18lrzDdFim153gc/eAO/6Xu69KEo=;
 b=MzlEFNbTCFvks7Z/sizyLbL7yZQyG9bK65AcMoCy4WgVoTKzvwo/Qg9NVSE3nbls4Z
 71QoibBvLzoQr/a2B+mspA8aqqoqHgrPPHE8l804e8piF1CQOuUAIDo8utEmH8LzGn8U
 kpNyU8OfGYl8JZ5QRMnFPUzYL6BpyNCZDPZGScVjxhZXqv21bioHwNHeHQQkxmzWWg77
 2K+bXLM9r83mzNRam9FNESZ0ldDCp+pNJrtSG0jCqNWgQCQmsEMazaBmtdJ/TZF6BCyr
 kxZgtp7rFpGsURdjcxq9csjlESZ9Zk18SKAMYYMZDolGJs8mTTHzW3C/rUo3Q9OZpwOL
 nhlw==
X-Gm-Message-State: AOJu0YzGsPqmPw+oQTnGSEr+TFn3B/am1n1K6rHIz8vBOQOGwupSx0ty
 jlpOkQZ1QoU7W0S4xBlbn+5NDKuE4exVnJfyO3gSW6dV
X-Google-Smtp-Source: AGHT+IFeYBfvAOEHB+acL7v+JAAWrAzDJr7D7/7artT4kfndFCFz9fuphbuiLjsSIyF9KIxjRrWJnvFm6ziocJJ59Zs=
X-Received: by 2002:a50:ef11:0:b0:54b:f6:fb23 with SMTP id
 m17-20020a50ef11000000b0054b00f6fb23mr14282851eds.23.1701342584904; 
 Thu, 30 Nov 2023 03:09:44 -0800 (PST)
MIME-Version: 1.0
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
In-Reply-To: <20231127125726.3735-1-maxim.uvarov@linaro.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 30 Nov 2023 11:09:33 +0000
Message-ID: <CALeDE9Oiw0xk7nnY3zts_p69aNnquWNX0zGWfS+9Gu=omBb0Fg@mail.gmail.com>
Subject: Re: [PATHv11 00/43] net/lwip: add lwip library for the network stack
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, trini@konsulko.com, 
 goldsimon@gmx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Maxim,

> Please find updated version of lwip patches. Changes are in the
> changelog bellow.
>
> Thank you,
> Maxim.
>
> changelog:
>         v11: - v11 is mosly respin of v10 patches with CI error fixes.
>                 Gitlab CI:
>                 https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/18368
>                 Azure CI:
>                 https://dev.azure.com/u-boot/u-boot/_build/results?buildId=7366&view=results
>                 (Azure CI, which is connected to github. Sometime I can see
>                  tftp timeout after some part of download there, but that can not be
>                  reproduced locally. While Gitblab CI is stable. Because of num tries in
>                  CI I suspect this CI was not always reliable.)
>                 Azure and Gitlab also have different toolchains and I
>                 would say Gitlab generates bigger code then Azure CI.
>
>                 Also many boards have a binary limit size of 800k (even
>                 qemu has limits). And increased limits to fit all the code. Specially did it
>                 patch by board config to show which boards are failing to build. There I have
>                 a question if we really want to support new functionality for old boards (mips,
>                 arm32 and etc...). I hope board owners can help me if
>                 it's valid to increase these limits.
>
>                 In this version I used git submodules and friend CI with
>                 submodules. But I don't mind if you decide to maintain it in a different
>                 way.
>
>
>         v10: - fix ping with following tftp command issue with incorrect
>                 ping timeout clear.
>              - Makefile on make will init submodules and if needed will
>                do git clone.
>              - wget - some minor code style changes.
>         v9: - added first patch describing git submodule for lwip. So
>               the build procedure is:
>                 git submodule init
>                 git submodule update
>                 make
>             - reworked a little bit dhcp cmd state polling
>             - fixed review comments for v8
>         v8: - comments for previous review
>             - removed lwip timeout callback pointer
>             - made lwip timeouts works, that also allowed to remove
>               static vars.
>             - setenv for filesize tftp and wget has to be in hex.
>             - Makefile changes always compile it tftp,dns,wget,ping due
>               to it can be used not only by CONFIG_CMD_.
>             - Kconfig changes - simplify lwIP settings and support only
>               one configuration.
>             - tested with mini debian.iso load over http or tftp, mount
>               and boot it (qemu, arm64).
>         v7: - more review fixes.
>             - support of multiply eth devices, were "ethact" selects the
>               active device.
>         v6: - fixed review comments for v5 (thanks Ilias and Simon).
>         v5: - fixed Iliases comments and split big patch on the small
>                 ones.
>         v4: - tested with tests/py/ did some minor fixes (out of tree
>                 build, variables set after downloads).
>             - accounted review comments for documentation.
>             - implemented dns command
>             - corrected wget command to not use serverip variable and use just
>                 url string.
>         v3: - use lwip commands for ping,tftp,wget,dhcp if this patch
>               applied. Drop CONFIG_LIB_LWIP_REPLACE_<COMMAND> option.
>             - docs: use rst variant and drop references to RFC.
>
> Maxim Uvarov (43):
>   submodule: add lwIP as git submodule
>   net/lwip: add doc/develop/net_lwip.rst
>   net/lwip: integrate lwIP library
>   net/lwip: implement dns cmd
>   net/lwip: implement dhcp cmd
>   net/lwip: implement tftp cmd
>   net/lwip: implement wget cmd
>   net/lwip: implement ping cmd
>   net/lwip: add lwIP configuration
>   net/lwip: implement lwIP port to U-Boot
>   net/lwip: update .gitignore with lwIP
>   net/lwip: connection between cmd and lwip apps
>   net/lwip: replace original net commands with lwip
>   net/lwip: split net.h to net.h, arp.h and eth.h

I think the patches below likely make sense to be split out, either
into individual patches or a fixes/cleanup series that the LWIP series
depends upon. A bunch of the patches below look like they would even
be reasonable fixes for the current release cycle.

Peter

>   test_efi_loader.py: use $filesize var
>   test_net: print out net list
>   net: sandbox: fix NULL pointer derefences
>   net/smc911x: fix return from smc911x_send
>   sandbox: eth-raw-os: successful return code is 0
>   driver/net/rtl8139: remove debug print
>   mach-socfpga: do not overlap defines with lwip
>   bcm_ns3: fix overlap define with lwip
>   rcar3_salvator-x_defconfig: increase binary size limit
>   lwip: omap3: rename mem_init
>   configs/turris_omnia_defconfig set limit to 0xf6000
>   configs/tbs2910_defconfig inc limit
>   configs/socfpga_secu1_defconfig: enable LTO
>   configs/turris_omnia_defconfig: enable LTO
>   configs/am335x_boneblack_vboot_defconfig: enable LTO and increase SPL
>     size
>   configs/sheevaplug_defconfig: enable LTO and inc size
>   configs/lschlv2_defconfig: enable LTO and inc size
>   configs/lsxhl_defconfig: LTO + size
>   configs/am335x_evm_defconfig: inc SPL size
>   configs/bk4r1_defconfig: inc size
>   configs/linkit-smart-7688_defconfig: increse size
>   configs/gardena-smart-gateway-mt7688_defconfig: increase size
>   configs/rcar3_ulcb_defconfig: increase size
>   configs/qemu-x86_64_defconfig: increase ROM size
>   Makefile: add dtbs to clean
>   .azure-pipelines: init submodules
>   mach-mtmips: inc SPL size limit
>   configs/linkit-smart-7688_defconfig: increase board limit
>   .gitlab-ci.yml: change ownership of the git files
>
>  .azure-pipelines.yml                          |  10 +-
>  .gitlab-ci.yml                                |  15 +-
>  .gitmodules                                   |   4 +
>  Makefile                                      |  12 +-
>  arch/arm/include/asm/arch-omap3/mem.h         |   2 +-
>  arch/arm/mach-omap2/omap3/board.c             |   2 +-
>  arch/arm/mach-omap2/omap3/emif4.c             |   4 +-
>  arch/arm/mach-omap2/omap3/sdrc.c              |   6 +-
>  .../mach-socfpga/include/mach/handoff_soc64.h |   6 -
>  arch/arm/mach-socfpga/wrap_handoff_soc64.c    |   9 +
>  arch/mips/mach-mtmips/Kconfig                 |   2 +-
>  arch/sandbox/cpu/eth-raw-os.c                 |   2 +-
>  boot/bootmeth_efi.c                           |  18 +-
>  boot/bootmeth_pxe.c                           |  21 +-
>  cmd/Makefile                                  |   1 +
>  cmd/net-lwip.c                                | 307 ++++++++++++++++
>  cmd/net.c                                     |  86 +----
>  cmd/pxe.c                                     |  19 +-
>  configs/am335x_boneblack_vboot_defconfig      |   3 +
>  configs/am335x_evm_defconfig                  |   1 +
>  configs/bk4r1_defconfig                       |   2 +-
>  .../gardena-smart-gateway-mt7688_defconfig    |   2 +-
>  configs/linkit-smart-7688_defconfig           |   2 +-
>  configs/lschlv2_defconfig                     |   3 +-
>  configs/lsxhl_defconfig                       |   3 +-
>  configs/qemu-x86_64_defconfig                 |   5 +-
>  configs/rcar3_salvator-x_defconfig            |   3 +-
>  configs/rcar3_ulcb_defconfig                  |   1 +
>  configs/sheevaplug_defconfig                  |   3 +-
>  configs/socfpga_secu1_defconfig               |   1 +
>  configs/tbs2910_defconfig                     |   2 +-
>  configs/turris_omnia_defconfig                |   3 +-
>  doc/develop/index.rst                         |   1 +
>  doc/develop/net_lwip.rst                      |  75 ++++
>  drivers/net/rtl8139.c                         |   1 -
>  drivers/net/sandbox.c                         |   5 +
>  drivers/net/smc911x.c                         |   2 +-
>  include/configs/bcm_ns3.h                     |   6 +-
>  include/net.h                                 | 197 +----------
>  include/net/arp.h                             |   9 +
>  include/net/eth.h                             | 194 +++++++++++
>  include/net/lwip.h                            |  73 ++++
>  include/net/ulwip.h                           |  67 ++++
>  lib/Kconfig                                   |   2 +-
>  net/Kconfig                                   |   3 +
>  net/Makefile                                  |   1 +
>  net/eth-uclass.c                              |  37 +-
>  net/lwip/.gitignore                           |   8 +
>  net/lwip/Kconfig                              |  34 ++
>  net/lwip/Makefile                             |  70 ++++
>  net/lwip/apps/dhcp/lwip-dhcp.c                |  86 +++++
>  net/lwip/apps/dns/lwip-dns.c                  |  63 ++++
>  net/lwip/apps/http/Makefile                   |   6 +
>  net/lwip/apps/http/lwip-wget.c                | 105 ++++++
>  net/lwip/apps/ping/Makefile                   |  12 +
>  net/lwip/apps/ping/lwip_ping.c                |  39 +++
>  net/lwip/apps/ping/lwip_ping.h                |  15 +
>  net/lwip/apps/ping/ping.h                     |  28 ++
>  net/lwip/apps/tftp/Makefile                   |   7 +
>  net/lwip/apps/tftp/lwip-tftp.c                | 132 +++++++
>  net/lwip/lwip-external                        |   1 +
>  net/lwip/lwipopts.h                           | 178 ++++++++++
>  net/lwip/port/if.c                            | 327 ++++++++++++++++++
>  net/lwip/port/include/arch/cc.h               |  44 +++
>  net/lwip/port/include/arch/sys_arch.h         |  10 +
>  net/lwip/port/include/limits.h                |   0
>  net/lwip/port/sys-arch.c                      |  13 +
>  net/net.c                                     |  44 ++-
>  test/py/tests/test_efi_loader.py              |   4 +-
>  test/py/tests/test_net.py                     |   2 +
>  70 files changed, 2113 insertions(+), 348 deletions(-)
>  create mode 100644 .gitmodules
>  create mode 100644 cmd/net-lwip.c
>  create mode 100644 doc/develop/net_lwip.rst
>  create mode 100644 include/net/arp.h
>  create mode 100644 include/net/eth.h
>  create mode 100644 include/net/lwip.h
>  create mode 100644 include/net/ulwip.h
>  create mode 100644 net/lwip/.gitignore
>  create mode 100644 net/lwip/Kconfig
>  create mode 100644 net/lwip/Makefile
>  create mode 100644 net/lwip/apps/dhcp/lwip-dhcp.c
>  create mode 100644 net/lwip/apps/dns/lwip-dns.c
>  create mode 100644 net/lwip/apps/http/Makefile
>  create mode 100644 net/lwip/apps/http/lwip-wget.c
>  create mode 100644 net/lwip/apps/ping/Makefile
>  create mode 100644 net/lwip/apps/ping/lwip_ping.c
>  create mode 100644 net/lwip/apps/ping/lwip_ping.h
>  create mode 100644 net/lwip/apps/ping/ping.h
>  create mode 100644 net/lwip/apps/tftp/Makefile
>  create mode 100644 net/lwip/apps/tftp/lwip-tftp.c
>  create mode 160000 net/lwip/lwip-external
>  create mode 100644 net/lwip/lwipopts.h
>  create mode 100644 net/lwip/port/if.c
>  create mode 100644 net/lwip/port/include/arch/cc.h
>  create mode 100644 net/lwip/port/include/arch/sys_arch.h
>  create mode 100644 net/lwip/port/include/limits.h
>  create mode 100644 net/lwip/port/sys-arch.c
>
> --
> 2.30.2
>
