Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA1F7C4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 19:13:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DE4A87701;
	Tue, 28 Nov 2023 20:13:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qy3QPwuH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F9FB87701; Tue, 28 Nov 2023 20:13:21 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A6F9876B5
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 20:13:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a00cbb83c82so842310066b.2
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 11:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701198796; x=1701803596; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=veyJS7g3GNxpFqceno5mTfzXK/pVl/q3/5WjCIpYVOo=;
 b=qy3QPwuHJFDu6V5jr0BGMzg7FjO1SGPM6IZuht/YVCIewIRt4Feje6EG4CzcRELI3m
 h6UVrNrmO7K0ZOVHdaAP6JYAxpZtoq1tkME0R4R0FPecFVFqnFVDm7MjZLPKiDLvCfuR
 xm2q+TsWhn05ZwdBftJFB9Oi6K/chur6NG7XSd1tqRvwGyC9t87/tvDQJ4kGM/W63p34
 zewF0lRFHN5NLqj+FCKAYlftZ3S2X0dP8Y5hRI5S2+UxuUF1cW4tQ0mh1RNFwD8pQ04u
 5Dk3VMZHTGhMh3BlRqRNX0UJ/ZhvvdEGyRR5KPSd2MqI9CbHIO9K0lkrGxNRd1bcxTHD
 /o4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701198796; x=1701803596;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=veyJS7g3GNxpFqceno5mTfzXK/pVl/q3/5WjCIpYVOo=;
 b=nM5g04/ahgMVO8E6PuVqUXilQW/0stGBxIW9zEfpONxbA6PFqaIAX/qMkrPBYPZVtB
 +dAP9aceb/bfhMeoqbI0y5c0km6QvAmAhBeZEpPbaN0NRoya/3UgvpV1UgYhvuxMvyH4
 szMtE17WaOKkXOt8tTIl2GU6vFzyTci9x6clA8baYdIBgAZSlgJOGwRmjdN9zLg14usP
 dnJt8ct8vfYeu1NoYe6OzbFwuUJfZZRKy79fLXEsPc7aS6r9y0LaGOkKZ6hXvESYPeEY
 1qyroLt10TroNm37Tv2bk1D7nddi1DjeFvr7D1EMjcWQOxRmxHq9x7dRfH/ZaF8TEy11
 QsIw==
X-Gm-Message-State: AOJu0YxzDqpBipoqeJfQClNjhhE1b19pFBbiTcYol4WQg2/OTfbsjOl5
 EdostkjMxRqCKUvYUWNXV9a8fpj+yIa8D6+rJpQzyQ==
X-Google-Smtp-Source: AGHT+IHyZhCwSa/kZBcVNNShBsavNyVKEvZTDENsOjDxgWcAAWLTyzUGMwlwIiQ2bMPCWktXOu00C/hMvF4gboZ0Bls=
X-Received: by 2002:a17:906:3f92:b0:9e0:4910:166a with SMTP id
 b18-20020a1709063f9200b009e04910166amr9699052ejj.32.1701198796479; Tue, 28
 Nov 2023 11:13:16 -0800 (PST)
MIME-Version: 1.0
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <bf3c4f05-db8f-4643-9335-53e511aeff86@linaro.org>
In-Reply-To: <bf3c4f05-db8f-4643-9335-53e511aeff86@linaro.org>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Wed, 29 Nov 2023 01:13:03 +0600
Message-ID: <CAD8XO3bn06C3qrO91hRbuCwrrbU_6Vu-smXbk-Ent-tOqM_Fvw@mail.gmail.com>
Subject: Re: [PATHv11 00/43] net/lwip: add lwip library for the network stack
To: neil.armstrong@linaro.org
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org, 
 trini@konsulko.com, goldsimon@gmx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Tue, 28 Nov 2023 at 16:37, <neil.armstrong@linaro.org> wrote:

> Hi,
>
> On 27/11/2023 13:56, Maxim Uvarov wrote:
> > Hello,
> >
> > Please find updated version of lwip patches. Changes are in the
> > changelog bellow.
>
> I've ran it on the libretech-cc board, and tried to load grub over tftp,
> and I got this strange EFI boot error:
>
> ========================================================================================
> U-Boot 2024.01-rc3-00056-g10d85cb3e3 (Nov 28 2023 - 11:17:24 +0100)
> libretech-cc
>
> Model: Libre Computer AML-S905X-CC
> SoC:   Amlogic Meson GXL (S905X) Revision 21:d (84:2)
> DRAM:  2 GiB
>
> <snip>
>
> Net:   eth0: ethernet@c9410000
> Hit any key to stop autoboot:  0
> => setenv autoload no
> => dhcp
> ethernet@c9410000 LPA corruption - aneg restart
> ethernet@c9410000 Waiting for PHY auto negotiation to complete.... done
> Speed: 100, full duplex
> eth0: ethernet@c9410000 3e:a6:23:c0:39:4b active
> dhcp_tmo 20/20
> dhcp_tmo 19/20
> DHCP client bound to address 10.34.56.105
> => tftpboot 8080000 grubaa64.efi
> init already done for ethernet@c9410000
> Speed: 100, full duplex
> TFTP from server 10.34.56.1; our IP address is 10.34.56.105
> Filename 'grubaa64.efi'.
> Load address: 0x8080000
> Loading:############
> done
> Bytes transferred = 4288512 (0x417000 hex)
> => crc32 8080000 0x417000
> crc32 for 08080000 ... 08496fff ==> c79bc066
>
> ========================================================================================
>
> - DHCP OK,
> - transfer OK
> - CRC32 value OK
>
> but then trying to run the EFI binary:
>
> ========================================================================================
> => bootefi 8080000
> No EFI system partition
> No EFI system partition
> Failed to persist EFI variables
> No UEFI binary known at 8080000
>
> ========================================================================================
>
> This is what I get on the current master without this patchset:
>
> ========================================================================================
> U-Boot 2024.01-rc3-00013-gacae7eb5fe (Nov 28 2023 - 11:29:38 +0100)
> libretech-cc
>
> Model: Libre Computer AML-S905X-CC
> SoC:   Amlogic Meson GXL (S905X) Revision 21:d (84:2)
> DRAM:  2 GiB
>
> <snip>
>
> Net:   eth0: ethernet@c9410000
> Hit any key to stop autoboot:  0
> => setenv autoload no
> => dhcp
> ethernet@c9410000 LPA corruption - aneg restart
> ethernet@c9410000 Waiting for PHY auto negotiation to complete.... done
> Speed: 100, full duplex
> BOOTP broadcast 1
> BOOTP broadcast 2
> BOOTP broadcast 3
> DHCP client bound to address 10.34.56.105 (1008 ms)
> => tftpboot 8080000 grubaa64.efi
> Speed: 100, full duplex
> Using ethernet@c9410000 device
> TFTP from server 10.34.56.1; our IP address is 10.34.56.105
> Filename 'grubaa64.efi'.
> Load address: 0x8080000
> Loading: ##T #T T
> ##############################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          ##########################################################
>          199.2 KiB/s
> done
> Bytes transferred = 4288512 (417000 hex)
> => crc32 8080000 0x417000
> crc32 for 08080000 ... 08496fff ==> c79bc066
> => bootefi 8080000
> No EFI system partition
> No EFI system partition
> Failed to persist EFI variables
> Booting /grubaa64.efi
> Welcome to GRUB!
>
> <snip>
>
> grub> net_ls_addr
> efinet0 3e:a6:23:c0:39:4b 10.34.56.105
>
> ========================================================================================
>
> I don't see what's wrong, crc32 is good and env variables are the same:
> fileaddr=8080000
> filesize=417000
>
> Neil
>
>
Ok. You provided a small fix for this use case. Will take it into a new
version.



>
> >
> > Thank you,
> > Maxim.
> >
> > changelog:
> >       v11: - v11 is mosly respin of v10 patches with CI error fixes.
> >                  Gitlab CI:
> >
> https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/18368
> >                  Azure CI:
> >
> https://dev.azure.com/u-boot/u-boot/_build/results?buildId=7366&view=results
> >                  (Azure CI, which is connected to github. Sometime I can
> see
> >                   tftp timeout after some part of download there, but
> that can not be
> >                   reproduced locally. While Gitblab CI is stable.
> Because of num tries in
> >                   CI I suspect this CI was not always reliable.)
> >                  Azure and Gitlab also have different toolchains and I
> >                  would say Gitlab generates bigger code then Azure CI.
> >
> >                  Also many boards have a binary limit size of 800k (even
> >                  qemu has limits). And increased limits to fit all the
> code. Specially did it
> >                  patch by board config to show which boards are failing
> to build. There I have
> >                  a question if we really want to support new
> functionality for old boards (mips,
> >                  arm32 and etc...). I hope board owners can help me if
> >                  it's valid to increase these limits.
> >
> >               In this version I used git submodules and friend CI with
> >               submodules. But I don't mind if you decide to maintain it
> in a different
> >               way.
> >
> >
> >       v10: - fix ping with following tftp command issue with incorrect
> >               ping timeout clear.
> >            - Makefile on make will init submodules and if needed will
> >              do git clone.
> >            - wget - some minor code style changes.
> >       v9: - added first patch describing git submodule for lwip. So
> >             the build procedure is:
> >               git submodule init
> >               git submodule update
> >               make
> >           - reworked a little bit dhcp cmd state polling
> >           - fixed review comments for v8
> >       v8: - comments for previous review
> >           - removed lwip timeout callback pointer
> >           - made lwip timeouts works, that also allowed to remove
> >             static vars.
> >           - setenv for filesize tftp and wget has to be in hex.
> >           - Makefile changes always compile it tftp,dns,wget,ping due
> >             to it can be used not only by CONFIG_CMD_.
> >           - Kconfig changes - simplify lwIP settings and support only
> >             one configuration.
> >           - tested with mini debian.iso load over http or tftp, mount
> >             and boot it (qemu, arm64).
> >       v7: - more review fixes.
> >           - support of multiply eth devices, were "ethact" selects the
> >             active device.
> >       v6: - fixed review comments for v5 (thanks Ilias and Simon).
> >       v5: - fixed Iliases comments and split big patch on the small
> >               ones.
> >       v4: - tested with tests/py/ did some minor fixes (out of tree
> >               build, variables set after downloads).
> >           - accounted review comments for documentation.
> >           - implemented dns command
> >              - corrected wget command to not use serverip variable and
> use just
> >               url string.
> >       v3: - use lwip commands for ping,tftp,wget,dhcp if this patch
> >             applied. Drop CONFIG_LIB_LWIP_REPLACE_<COMMAND> option.
> >           - docs: use rst variant and drop references to RFC.
> >
> > Maxim Uvarov (43):
> >    submodule: add lwIP as git submodule
> >    net/lwip: add doc/develop/net_lwip.rst
> >    net/lwip: integrate lwIP library
> >    net/lwip: implement dns cmd
> >    net/lwip: implement dhcp cmd
> >    net/lwip: implement tftp cmd
> >    net/lwip: implement wget cmd
> >    net/lwip: implement ping cmd
> >    net/lwip: add lwIP configuration
> >    net/lwip: implement lwIP port to U-Boot
> >    net/lwip: update .gitignore with lwIP
> >    net/lwip: connection between cmd and lwip apps
> >    net/lwip: replace original net commands with lwip
> >    net/lwip: split net.h to net.h, arp.h and eth.h
> >    test_efi_loader.py: use $filesize var
> >    test_net: print out net list
> >    net: sandbox: fix NULL pointer derefences
> >    net/smc911x: fix return from smc911x_send
> >    sandbox: eth-raw-os: successful return code is 0
> >    driver/net/rtl8139: remove debug print
> >    mach-socfpga: do not overlap defines with lwip
> >    bcm_ns3: fix overlap define with lwip
> >    rcar3_salvator-x_defconfig: increase binary size limit
> >    lwip: omap3: rename mem_init
> >    configs/turris_omnia_defconfig set limit to 0xf6000
> >    configs/tbs2910_defconfig inc limit
> >    configs/socfpga_secu1_defconfig: enable LTO
> >    configs/turris_omnia_defconfig: enable LTO
> >    configs/am335x_boneblack_vboot_defconfig: enable LTO and increase SPL
> >      size
> >    configs/sheevaplug_defconfig: enable LTO and inc size
> >    configs/lschlv2_defconfig: enable LTO and inc size
> >    configs/lsxhl_defconfig: LTO + size
> >    configs/am335x_evm_defconfig: inc SPL size
> >    configs/bk4r1_defconfig: inc size
> >    configs/linkit-smart-7688_defconfig: increse size
> >    configs/gardena-smart-gateway-mt7688_defconfig: increase size
> >    configs/rcar3_ulcb_defconfig: increase size
> >    configs/qemu-x86_64_defconfig: increase ROM size
> >    Makefile: add dtbs to clean
> >    .azure-pipelines: init submodules
> >    mach-mtmips: inc SPL size limit
> >    configs/linkit-smart-7688_defconfig: increase board limit
> >    .gitlab-ci.yml: change ownership of the git files
> >
> >   .azure-pipelines.yml                          |  10 +-
> >   .gitlab-ci.yml                                |  15 +-
> >   .gitmodules                                   |   4 +
> >   Makefile                                      |  12 +-
> >   arch/arm/include/asm/arch-omap3/mem.h         |   2 +-
> >   arch/arm/mach-omap2/omap3/board.c             |   2 +-
> >   arch/arm/mach-omap2/omap3/emif4.c             |   4 +-
> >   arch/arm/mach-omap2/omap3/sdrc.c              |   6 +-
> >   .../mach-socfpga/include/mach/handoff_soc64.h |   6 -
> >   arch/arm/mach-socfpga/wrap_handoff_soc64.c    |   9 +
> >   arch/mips/mach-mtmips/Kconfig                 |   2 +-
> >   arch/sandbox/cpu/eth-raw-os.c                 |   2 +-
> >   boot/bootmeth_efi.c                           |  18 +-
> >   boot/bootmeth_pxe.c                           |  21 +-
> >   cmd/Makefile                                  |   1 +
> >   cmd/net-lwip.c                                | 307 ++++++++++++++++
> >   cmd/net.c                                     |  86 +----
> >   cmd/pxe.c                                     |  19 +-
> >   configs/am335x_boneblack_vboot_defconfig      |   3 +
> >   configs/am335x_evm_defconfig                  |   1 +
> >   configs/bk4r1_defconfig                       |   2 +-
> >   .../gardena-smart-gateway-mt7688_defconfig    |   2 +-
> >   configs/linkit-smart-7688_defconfig           |   2 +-
> >   configs/lschlv2_defconfig                     |   3 +-
> >   configs/lsxhl_defconfig                       |   3 +-
> >   configs/qemu-x86_64_defconfig                 |   5 +-
> >   configs/rcar3_salvator-x_defconfig            |   3 +-
> >   configs/rcar3_ulcb_defconfig                  |   1 +
> >   configs/sheevaplug_defconfig                  |   3 +-
> >   configs/socfpga_secu1_defconfig               |   1 +
> >   configs/tbs2910_defconfig                     |   2 +-
> >   configs/turris_omnia_defconfig                |   3 +-
> >   doc/develop/index.rst                         |   1 +
> >   doc/develop/net_lwip.rst                      |  75 ++++
> >   drivers/net/rtl8139.c                         |   1 -
> >   drivers/net/sandbox.c                         |   5 +
> >   drivers/net/smc911x.c                         |   2 +-
> >   include/configs/bcm_ns3.h                     |   6 +-
> >   include/net.h                                 | 197 +----------
> >   include/net/arp.h                             |   9 +
> >   include/net/eth.h                             | 194 +++++++++++
> >   include/net/lwip.h                            |  73 ++++
> >   include/net/ulwip.h                           |  67 ++++
> >   lib/Kconfig                                   |   2 +-
> >   net/Kconfig                                   |   3 +
> >   net/Makefile                                  |   1 +
> >   net/eth-uclass.c                              |  37 +-
> >   net/lwip/.gitignore                           |   8 +
> >   net/lwip/Kconfig                              |  34 ++
> >   net/lwip/Makefile                             |  70 ++++
> >   net/lwip/apps/dhcp/lwip-dhcp.c                |  86 +++++
> >   net/lwip/apps/dns/lwip-dns.c                  |  63 ++++
> >   net/lwip/apps/http/Makefile                   |   6 +
> >   net/lwip/apps/http/lwip-wget.c                | 105 ++++++
> >   net/lwip/apps/ping/Makefile                   |  12 +
> >   net/lwip/apps/ping/lwip_ping.c                |  39 +++
> >   net/lwip/apps/ping/lwip_ping.h                |  15 +
> >   net/lwip/apps/ping/ping.h                     |  28 ++
> >   net/lwip/apps/tftp/Makefile                   |   7 +
> >   net/lwip/apps/tftp/lwip-tftp.c                | 132 +++++++
> >   net/lwip/lwip-external                        |   1 +
> >   net/lwip/lwipopts.h                           | 178 ++++++++++
> >   net/lwip/port/if.c                            | 327 ++++++++++++++++++
> >   net/lwip/port/include/arch/cc.h               |  44 +++
> >   net/lwip/port/include/arch/sys_arch.h         |  10 +
> >   net/lwip/port/include/limits.h                |   0
> >   net/lwip/port/sys-arch.c                      |  13 +
> >   net/net.c                                     |  44 ++-
> >   test/py/tests/test_efi_loader.py              |   4 +-
> >   test/py/tests/test_net.py                     |   2 +
> >   70 files changed, 2113 insertions(+), 348 deletions(-)
> >   create mode 100644 .gitmodules
> >   create mode 100644 cmd/net-lwip.c
> >   create mode 100644 doc/develop/net_lwip.rst
> >   create mode 100644 include/net/arp.h
> >   create mode 100644 include/net/eth.h
> >   create mode 100644 include/net/lwip.h
> >   create mode 100644 include/net/ulwip.h
> >   create mode 100644 net/lwip/.gitignore
> >   create mode 100644 net/lwip/Kconfig
> >   create mode 100644 net/lwip/Makefile
> >   create mode 100644 net/lwip/apps/dhcp/lwip-dhcp.c
> >   create mode 100644 net/lwip/apps/dns/lwip-dns.c
> >   create mode 100644 net/lwip/apps/http/Makefile
> >   create mode 100644 net/lwip/apps/http/lwip-wget.c
> >   create mode 100644 net/lwip/apps/ping/Makefile
> >   create mode 100644 net/lwip/apps/ping/lwip_ping.c
> >   create mode 100644 net/lwip/apps/ping/lwip_ping.h
> >   create mode 100644 net/lwip/apps/ping/ping.h
> >   create mode 100644 net/lwip/apps/tftp/Makefile
> >   create mode 100644 net/lwip/apps/tftp/lwip-tftp.c
> >   create mode 160000 net/lwip/lwip-external
> >   create mode 100644 net/lwip/lwipopts.h
> >   create mode 100644 net/lwip/port/if.c
> >   create mode 100644 net/lwip/port/include/arch/cc.h
> >   create mode 100644 net/lwip/port/include/arch/sys_arch.h
> >   create mode 100644 net/lwip/port/include/limits.h
> >   create mode 100644 net/lwip/port/sys-arch.c
> >
>
>
