Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B2BC52D73
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 18:54:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 819E288C09;
	Wed,  7 Aug 2024 20:54:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Qe80ynku";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D7B788BFC; Wed,  7 Aug 2024 20:54:23 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC8DB88C23
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 20:54:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5ba43b433beso124066a12.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 11:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1723056860; x=1723661660;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tpcvanZlJrSSJU09/s4Lqw1OrNrFE7RDLO+X98EhpXM=;
 b=Qe80ynkuT80VduM+IFTohn86Q/rUxcJgKe27vWbSnS74P1CJKEW4spdeF0EgjczuD2
 VQvz1BNJXrDp5u+pDQky0hl5blvdCrbnuRqofSGvDPXYm1ub+2mcJUo4pi2q2qw9YwZG
 HQFYoUyjbIJbxvBjuVK9enr1rNGxkd7sFHZHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723056860; x=1723661660;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tpcvanZlJrSSJU09/s4Lqw1OrNrFE7RDLO+X98EhpXM=;
 b=EPMK2ifjBcNkipYVpXaLZt7F8Ao9goaozWm7KHREIbfR2RBtWfdLnB3G6iZnO48Y0v
 OHE53iMXVcd0k7Fitc1mgWmUn4Ql7HQ3/PExw9ypAgFS/uyTjF4zu3fHA03R8+fLc8wK
 xCBj0Wm5paxQ0xIubBekizWAZYw9DAR03lXQKP7/KcT0oK81O/Kb8hb2b25Pw6wYtEE1
 FCpbORah4xURiuEBalMj5/IqzbF10f0cFezQC8j14mbxtxYSc5gwkZAWEiblQcJd/S0S
 rgKEwZHjmPQe0Xl06/fQScniHO4SzHtscGKtZH9LhbQ1AZlh7sDDwrDAJcC+oIj/1bE0
 WQQA==
X-Gm-Message-State: AOJu0YxEpkiH6jsyDJggC85S3pLbYZv/XevYcSJnKnmCmYfMNcrtGFTs
 e/AmHN0Ny3QvQxqGeuAqBm4921qYgcYycx2Dh5roF6FeRhmUXXnfMvlQPpTb3IuyMRB2y4dSr90
 /7jzg393L3RztffjyZGesKK1m48g49+iL4XA/Bw8SSXdGY53n
X-Google-Smtp-Source: AGHT+IFIarkTW4vYS03SAvNUWK+Y9bjYdw8CbhM0E+6q1+C48LRLGzDe5whODSaMhyF3TJPyWRanKpWljARFw+j3zoQ=
X-Received: by 2002:a17:907:d92:b0:a77:deb2:8b01 with SMTP id
 a640c23a62f3a-a7dc4fd89c8mr1908343566b.1.1723056859846; Wed, 07 Aug 2024
 11:54:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1721910373.git.jerome.forissier@linaro.org>
In-Reply-To: <cover.1721910373.git.jerome.forissier@linaro.org>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 7 Aug 2024 20:54:08 +0200
Message-ID: <CAOf5uwkiTwsAPducOJxEBUHKYiT0+q_dH_ZCOdCd7e4b45DS0A@mail.gmail.com>
Subject: Re: [PATCH v5 00/20] Introduce the lwIP network stack
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>, 
 Maxim Uvarov <muvarov@gmail.com>
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

Hi Jerome

On Thu, Jul 25, 2024 at 2:58=E2=80=AFPM Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
> library for the network stack" [1]. The goal is to introduce the lwIP TCP=
/IP
> stack [2] [3] as an alternative to the current implementation in net/,
> selectable with Kconfig, and ultimately keep only lwIP if possible. Some
> reasons for doing so are:
> - Make the support of HTTPS in the wget command easier. Javier T. and
> Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to do
> so. With that it becomes possible to fetch and launch a distro installer
> such as Debian etc. using a secure, authenticated connection directly
> from the U-Boot shell. Several use cases:
>   * Authentication: prevent MITM attack (third party replacing the
> binary with a different one)
>   * Confidentiality: prevent third parties from grabbing a copy of the
> image as it is being downloaded
>   * Allow connection to servers that do not support plain HTTP anymore
> (this is becoming more and more common on the Internet these days)
> - Possibly benefit from additional features implemented in lwIP
> - Less code to maintain in U-Boot
>
> Prior to applying this series, the lwIP stack needs to be added as a
> Git subtree with the following command:
>
>  $  git subtree add --squash --prefix lib/lwip/lwip https://git.savannah.=
gnu.org/git/lwip.git STABLE-2_2_0_RELEASE
>
> Notes:
>
> 1. A number of features are currently incompatible with NET_LWIP: SANDBOX=
,
> DFU_TFTP, FASTBOOT, SPL_NET. All make assumptions on how the network
> stack is implemented and/or pull sybols that are not trivially exported
> from lwIP. Some interface rework may be needed.
>
> 2. Due to the above and in order to provide some level of testing, a new =
QEMU
> configuration is introduced (qemu_arm64_lwip_defconfig) which is the same
> as qemu_arm64_defconfig but with NET_LWIP and CMD_*_LWIP enabled.
> Tests are added to test/py/tests/test_net.py for that configuration.
>
> 3. The default QEMU networking doesn't work with NET_LWIP. wget
> pauses and resets the connection. Wireshark shows [TCP Window Full] and
> [TCP ZeroWindow]. Wen using an emulated e1000 however all is fine
> (that is "-nic tap,model=3De1000" on the QEMU command line, with a bridge
> configured on the host).
>
> Changes in v5:
>
> - Rebased on next
> - Refactor Kconfig options to avoid duplicates
> - Library functions use a more consistent naming (dhcp_loop(),
> ping_loop() etc.) and take a struct udevice * parameter (Heinrich S.)
> - Do not use net_process_receive_packet() for input anymore. Instead of
> calling eth_rx() which would invoke net_process_receive_packet(), we
> call a new net_lwip_rx(udev) function which invokes the device recv()
> and pushes the packets up the lwIP stack. Thus everything is tied to
> a udevice now. (Heinrich S.)
> - Add "configs: replace '# CONFIG_NET is not set' with CONFIG_NO_NET=3Dy"
> (Tom R.)

Here I have some questions. You can have CONFIG_NET with two alternatives a=
nd
the alternatives are exclusive. Why do we need a CONFIG_NO_NET definition?

Michael

> - tftp: unify display with legacy command: add throughput, 65 hashes per
> line, one every 10 blocks received (Tom R.)
> - Moved net-lwip/* to net/lwip/* (Simon G.)
> - Rename static function low_level_output() to linkoutput() since it is
> the name used in the lwIP netif struct.
> - Fixed off-by-one in parse_url() which could cause wget to fail when
> passed a URL with a host name (as opposed to a URL with an IP address).
> - Improved TFTP performance by adding support for the blksize option
> (patches "lwip: tftp: add support of blksize option to client" and
> "net-lwip: add TFTP_BLOCKSIZE) (Tom R.)
> - Add an optional port number to the tftp command for easier testing
> (syntax: tftp [[ip:[port:]]filename])
> - wget: display an "unsupported URI" error if uri is not http://
> (Jon H.)
> - Adjusted the lwIP TCP options in lib/lwip/u-boot/lwipopts.h for
> better performance, in particular TCP_WND.
> - Add "net: fec_mxc_init(): do not ignore return status of fec_open()"
> - Set the proper environment variables when DHCP succeeds (ipaddr%d
> etc.) and read the proper ones for the given device in new_netif(),
> allowing correct behavior when several adapters are available (tested
> on i.MX8M Plus).
> - Fix an alignment issue with outgoing packets (see the linkoutput()
> function). With that the i.MX8M Plus ENET1 interface works properly.
> (reported by Tim H.).
> - Add review tags
>
> Changes in v4:
>
> - Fixed the DHCP algorithm which was missing a sys_timeout() call in
> the "fine timer" callback. This should close the issue that Tom R.
> reported with his Raspberry Pi 3 (it does fix it on mine).
> - The DHCP exchange timeout is increased from 2 to 10 seconds
> - The DHCP exchange can be interrupted with Ctrl-C.
> - "net: introduce alternative implementation as net-lwip/": rework
> dependencies. A few symbols have 'depends on !NET_LWIP' and in addition
> 'NET_LWIP depends on !SANDBOX'. Sandbox, DSA and fastboot are
> unsupported, because they are deeply welded to the current stack.
> - All network commands (dns, ping, tftp and wget):
>   * Get rid of global variables (Ilias A.)
>   * Use printf() rather than log_info()
> - "net-lwip: add ping command": use packet count instead of
> timeout, fix code style (Ilias A.)
> - Add "net: split cmd/net.c into cmd/net.c and cmd/net-common.c"
> extracted from the wget patch (Ilias A.).
> - Add "net: split include/net.h into net{,-common,-legacy,-lwip}.h"
> (Ilias A.)
> - Add "flash: prefix error codes with FL_" which is required to
> avoid name clashes when splitting net.h
> - Reworked the initialization of the lwIP stack. One and only
> one network interface (struct netif) is added for the duration
> of the command that uses that interface. That's commit "net-lwip:
> add DHCP support and dhcp commmand".
> - Drop "test: dm: dsa, eth: disable tests when CONFIG_NET_LWIP=3Dy",
> not needed now that NET_LWIP depend on !SANDBOX.
> - qemu_arm64_lwip_defconfig now enables CMD_DNS and CMD_WGET (so
> that all the supported network commands are available).
>
> Changes in v3:
>
> - Make NET_LWIP a Kconfig choice in patch "net: introduce alternative
> implementation as net-lwip/" (Tom R.)
> - Drop the patch introducing lwIP as a Git subtree and document the git
> command in the cover letter instead (Tom R.)
> - "net-lwip: add TFTP support and tftpboot command": use the same
> "Bytes transferred =3D" message as in the legacy implementation (Tom R.,
> Maxim U.)
> - Drop "test/py: net: add _lwip variants of dhcp, ping and tftpboot
> tests" which is not needed anymore.
> - Add missing kfree() calls in cmd/net-common.c and fix the parsing of
> decimal address in net-lwip/wget.c (patch "net-lwip: add wget command")
> (Maxim U.)
> - "net-lwip: add ping command": drop the ICMP payload (Ilias A.). Set
> the sequence number to zero when entering ping_loop().
>
> Changes in v2:
>
> ** Address comments from Ilias A.
>
> - "net-lwip: add wget command"
> Implement the wget_with_dns() function to do most of the wget work and
> call it from do_wget(). This allows to simplify patch "net-lwip: add
> support for EFI_HTTP_BOOT".
>
> - "net-lwip: import net command from cmd/net.c"
> Move a few functions from cmd/net.c to a new file cmd/net-common.c
> rather than duplicating then in cmd/net-lwip.c.
>
> - "net-lwip: add support for EFI_HTTP_BOOT"
> Since wget_with_dns() is now implemented in "net-lwip: add wget command",
> just enable the wget command when the lwIP stack is enabled and
> EFI_HTTP_BOOT is requested.
>
> ** Address comments from Tom R.
>
> - "net-lwip: add DHCP support and dhcp commmand",
>   "net-lwip: add TFTP support and tftpboot command",
>   "net-lwip: add ping command",
>   "net-lwip: add dns command",
>   "net-lwip: add wget command"
> Do not introduce new CMD_XXX_LWIP symbols and use existing CMD_XXX
> instead.
>
> - "configs: add qemu_arm64_lwip_defconfig"
> Use #include <configs/qemu_arm64_defconfig>.
>
> - "net-lwip: import lwIP library under lib/lwip"
> Patch removed and replaced by the introduction of a Git subtree:
> "Squashed 'lib/lwip/lwip/' content from commit 0a0452b2c3".
>
> Note that I have not yet addressed your comments on "test: dm: dsa,
> eth: disable tests when CONFIG_NET_LWIP=3Dy"). I need some more time
> for that and I think running CI on this v2 will help better understand
> what is needed for v3.
>
> ** Miscellaneous improvements
>
> - "net: introduce alternative implementation as net-lwip/":
>
> * Make DFU_OVER_TFTP not DFU_TFTP incompatible with NET_LWIP. It seems
> quite natural to supplement "depends on NET" with "&& !NET_LWIP".
> * Make PROT_*_LWIP not visible by removing the Kconfig prompt.
>
> [1] https://lore.kernel.org/all/20231127125726.3735-1-maxim.uvarov@linaro=
.org/
> [2] https://www.nongnu.org/lwip/
> [3] https://en.wikipedia.org/wiki/LwIP
>
> CC: Javier Tia <javier.tia@linaro.org>
> CC: Raymond Mao <raymond.mao@linaro.org>
>
> Jerome Forissier (19):
>   flash: prefix error codes with FL_
>   net: introduce alternative implementation as net-lwip/
>   configs: replace '# CONFIG_NET is not set' with CONFIG_NO_NET=3Dy
>   net: fec_mxc_init(): do not ignore return status of fec_open()
>   net: split include/net.h into net{,-common,-legacy,-lwip}.h
>   net: eth-uclass: add function eth_start_udev()
>   net-lwip: build lwIP
>   net-lwip: add DHCP support and dhcp commmand
>   net-lwip: add TFTP support and tftpboot command
>   net-lwip: add ping command
>   net-lwip: add dns command
>   net: split cmd/net.c into cmd/net.c and cmd/net-common.c
>   net-lwip: add wget command
>   cmd: bdinfo: enable -e when CONFIG_CMD_NET_LWIP=3Dy
>   configs: add qemu_arm64_lwip_defconfig
>   lwip: tftp: add support of blksize option to client
>   net-lwip: add TFTP_BLOCKSIZE
>   CI: add qemu_arm64_lwip to the test matrix
>   MAINTAINERS: net-lwip: add myself as a maintainer
>
> Jonathan Humphreys (1):
>   net-lwip: lwIP wget supports user defined port in the uri, so allow
>     it.
>
>  .azure-pipelines.yml                          |   7 +
>  Kconfig                                       |  26 +
>  MAINTAINERS                                   |  11 +
>  Makefile                                      |   4 +-
>  board/cobra5272/flash.c                       |  26 +-
>  board/freescale/m5253demo/flash.c             |   6 +-
>  boot/Kconfig                                  |   3 +-
>  cmd/Kconfig                                   |  84 +-
>  cmd/Makefile                                  |   9 +-
>  cmd/bdinfo.c                                  |   5 +-
>  cmd/elf.c                                     |   2 +-
>  cmd/net-common.c                              | 109 ++
>  cmd/net-lwip.c                                |  45 +
>  cmd/net.c                                     | 115 ---
>  common/Kconfig                                |   2 +-
>  common/board_r.c                              |   4 +-
>  common/flash.c                                |  44 +-
>  common/spl/Kconfig                            |   1 +
>  common/usb_kbd.c                              |   2 +-
>  configs/LicheePi_Zero_defconfig               |   2 +-
>  configs/M5249EVB_defconfig                    |   2 +-
>  configs/am335x_pdu001_defconfig               |   2 +-
>  configs/am62ax_evm_r5_defconfig               |   2 +-
>  configs/am62px_evm_r5_defconfig               |   2 +-
>  configs/am62x_beagleplay_r5_defconfig         |   2 +-
>  configs/amcore_defconfig                      |   2 +-
>  configs/anbernic-rgxx3-rk3566_defconfig       |   2 +-
>  configs/ap143_defconfig                       |   2 +-
>  configs/ap152_defconfig                       |   2 +-
>  configs/apple_m1_defconfig                    |   2 +-
>  configs/astro_mcf5373l_defconfig              |   2 +-
>  configs/at91sam9rlek_dataflash_defconfig      |   2 +-
>  configs/at91sam9rlek_mmc_defconfig            |   2 +-
>  configs/at91sam9rlek_nandflash_defconfig      |   2 +-
>  configs/bcm7260_defconfig                     |   2 +-
>  configs/bcm7445_defconfig                     |   2 +-
>  configs/bcm968380gerg_ram_defconfig           |   2 +-
>  configs/bcmns_defconfig                       |   2 +-
>  configs/chromebook_samus_tpl_defconfig        |   2 +-
>  configs/cortina_presidio-asic-base_defconfig  |   2 +-
>  configs/cortina_presidio-asic-pnand_defconfig |   2 +-
>  configs/durian_defconfig                      |   2 +-
>  configs/e850-96_defconfig                     |   2 +-
>  configs/ea-lpc3250devkitv2_defconfig          |   2 +-
>  configs/efi-x86_app32_defconfig               |   2 +-
>  configs/efi-x86_app64_defconfig               |   2 +-
>  configs/emsdp_defconfig                       |   2 +-
>  configs/evb-px5_defconfig                     |   2 +-
>  configs/generic-rk3568_defconfig              |   2 +-
>  configs/generic-rk3588_defconfig              |   2 +-
>  configs/hc2910_2aghd05_defconfig              |   2 +-
>  configs/igep00x0_defconfig                    |   2 +-
>  configs/imx6q_bosch_acc_defconfig             |   2 +-
>  configs/imx6ulz_smm_m2_defconfig              |   2 +-
>  configs/iot_devkit_defconfig                  |   2 +-
>  configs/legoev3_defconfig                     |   2 +-
>  configs/mk808_defconfig                       |   2 +-
>  configs/mx23evk_defconfig                     |   2 +-
>  configs/mx28evk_defconfig                     |   2 +-
>  configs/mx6memcal_defconfig                   |   2 +-
>  configs/mx6ulz_14x14_evk_defconfig            |   2 +-
>  configs/mx7ulp_com_defconfig                  |   2 +-
>  configs/mx7ulp_evk_defconfig                  |   2 +-
>  configs/mx7ulp_evk_plugin_defconfig           |   2 +-
>  configs/netgear_cg3100d_ram_defconfig         |   2 +-
>  configs/nsim_700_defconfig                    |   2 +-
>  configs/nsim_700be_defconfig                  |   2 +-
>  configs/nsim_hs38be_defconfig                 |   2 +-
>  configs/openpiton_riscv64_defconfig           |   2 +-
>  configs/openpiton_riscv64_spl_defconfig       |   2 +-
>  configs/origen_defconfig                      |   2 +-
>  configs/pe2201_defconfig                      |   2 +-
>  configs/pinecube_defconfig                    |   2 +-
>  configs/pm9261_defconfig                      |   2 +-
>  configs/qemu_arm64_lwip_defconfig             |   5 +
>  configs/s5p4418_nanopi2_defconfig             |   2 +-
>  configs/s5p_goni_defconfig                    |   2 +-
>  configs/s5pc210_universal_defconfig           |   2 +-
>  configs/sama5d27_giantboard_defconfig         |   2 +-
>  configs/sama5d29_curiosity_mmc1_defconfig     |   2 +-
>  configs/sama5d29_curiosity_mmc_defconfig      |   2 +-
>  .../sama5d29_curiosity_qspiflash_defconfig    |   2 +-
>  configs/sama7g54_curiosity_mmc_defconfig      |   2 +-
>  .../sama7g54_curiosity_nandflash_defconfig    |   2 +-
>  .../sama7g54_curiosity_qspiflash_defconfig    |   2 +-
>  configs/sipeed_maix_bitm_defconfig            |   2 +-
>  configs/sipeed_maix_smode_defconfig           |   2 +-
>  configs/stemmy_defconfig                      |   2 +-
>  configs/stm32f429-discovery_defconfig         |   2 +-
>  configs/stm32f429-evaluation_defconfig        |   2 +-
>  configs/stm32f469-discovery_defconfig         |   2 +-
>  configs/stm32h743-disco_defconfig             |   2 +-
>  configs/stm32h743-eval_defconfig              |   2 +-
>  configs/stm32h750-art-pi_defconfig            |   2 +-
>  configs/stm32mp25_defconfig                   |   2 +-
>  configs/stmark2_defconfig                     |   2 +-
>  configs/th1520_lpi4a_defconfig                |   2 +-
>  configs/thunderx_88xx_defconfig               |   2 +-
>  configs/tools-only_defconfig                  |   2 +-
>  configs/topic_miami_defconfig                 |   2 +-
>  configs/topic_miamilite_defconfig             |   2 +-
>  configs/topic_miamiplus_defconfig             |   2 +-
>  configs/total_compute_defconfig               |   2 +-
>  configs/trats2_defconfig                      |   2 +-
>  configs/trats_defconfig                       |   2 +-
>  configs/xenguest_arm64_defconfig              |   2 +-
>  configs/xenguest_arm64_virtio_defconfig       |   2 +-
>  configs/xilinx_versal_mini_defconfig          |   2 +-
>  configs/xilinx_versal_mini_emmc0_defconfig    |   2 +-
>  configs/xilinx_versal_mini_emmc1_defconfig    |   2 +-
>  configs/xilinx_versal_mini_ospi_defconfig     |   2 +-
>  configs/xilinx_versal_mini_qspi_defconfig     |   2 +-
>  configs/xilinx_versal_net_mini_defconfig      |   2 +-
>  configs/xilinx_versal_net_mini_emmc_defconfig |   2 +-
>  configs/xilinx_versal_net_mini_ospi_defconfig |   2 +-
>  configs/xilinx_versal_net_mini_qspi_defconfig |   2 +-
>  configs/xilinx_zynqmp_mini_defconfig          |   2 +-
>  configs/xilinx_zynqmp_mini_emmc0_defconfig    |   2 +-
>  configs/xilinx_zynqmp_mini_emmc1_defconfig    |   2 +-
>  configs/xilinx_zynqmp_mini_nand_defconfig     |   2 +-
>  .../xilinx_zynqmp_mini_nand_single_defconfig  |   2 +-
>  configs/xilinx_zynqmp_mini_qspi_defconfig     |   2 +-
>  configs/zynq_cse_nand_defconfig               |   2 +-
>  configs/zynq_cse_nor_defconfig                |   2 +-
>  configs/zynq_cse_qspi_defconfig               |   2 +-
>  drivers/dfu/Kconfig                           |   1 +
>  drivers/fastboot/Kconfig                      |   1 +
>  drivers/mtd/cfi_flash.c                       |  36 +-
>  drivers/net/Kconfig                           |   3 +-
>  drivers/net/fec_mxc.c                         |   3 +-
>  drivers/net/phy/Kconfig                       |   2 +-
>  drivers/usb/gadget/Kconfig                    |   2 +-
>  include/flash.h                               |  20 +-
>  include/net-common.h                          | 413 ++++++++
>  include/net-legacy.h                          | 635 ++++++++++++
>  include/net-lwip.h                            |  37 +
>  include/net.h                                 | 944 +-----------------
>  lib/Makefile                                  |   2 +
>  lib/lwip/Makefile                             |  55 +
>  lib/lwip/lwip/src/apps/tftp/tftp.c            |  94 +-
>  .../lwip/src/include/lwip/apps/tftp_client.h  |   1 +
>  lib/lwip/u-boot/arch/cc.h                     |  43 +
>  lib/lwip/u-boot/arch/sys_arch.h               |   0
>  lib/lwip/u-boot/limits.h                      |   0
>  lib/lwip/u-boot/lwipopts.h                    | 157 +++
>  net/Kconfig                                   |  49 +-
>  net/Makefile                                  |  19 +-
>  net/eth-uclass.c                              |  38 +-
>  net/lwip/Kconfig                              |  34 +
>  net/lwip/Makefile                             |   8 +
>  net/lwip/dhcp.c                               | 136 +++
>  net/lwip/dns.c                                | 127 +++
>  net/lwip/eth_internal.h                       |  35 +
>  net/lwip/net-lwip.c                           | 292 ++++++
>  net/lwip/ping.c                               | 177 ++++
>  net/lwip/tftp.c                               | 276 +++++
>  net/lwip/wget.c                               | 272 +++++
>  157 files changed, 3311 insertions(+), 1321 deletions(-)
>  create mode 100644 cmd/net-common.c
>  create mode 100644 cmd/net-lwip.c
>  create mode 100644 configs/qemu_arm64_lwip_defconfig
>  create mode 100644 include/net-common.h
>  create mode 100644 include/net-legacy.h
>  create mode 100644 include/net-lwip.h
>  create mode 100644 lib/lwip/Makefile
>  create mode 100644 lib/lwip/u-boot/arch/cc.h
>  create mode 100644 lib/lwip/u-boot/arch/sys_arch.h
>  create mode 100644 lib/lwip/u-boot/limits.h
>  create mode 100644 lib/lwip/u-boot/lwipopts.h
>  create mode 100644 net/lwip/Kconfig
>  create mode 100644 net/lwip/Makefile
>  create mode 100644 net/lwip/dhcp.c
>  create mode 100644 net/lwip/dns.c
>  create mode 100644 net/lwip/eth_internal.h
>  create mode 100644 net/lwip/net-lwip.c
>  create mode 100644 net/lwip/ping.c
>  create mode 100644 net/lwip/tftp.c
>  create mode 100644 net/lwip/wget.c
>
> --
> 2.40.1
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
