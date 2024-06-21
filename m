Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 823DAC2BA1A
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 14:59:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C519C88596;
	Fri, 21 Jun 2024 16:58:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ac4nVkMy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1443588581; Fri, 21 Jun 2024 16:58:13 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5680E8854E
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 16:58:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6b50aeb2424so10577836d6.0
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 07:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718981889; x=1719586689; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XVjD6Z0j2yuqQs76YOwzzuT22W7+HJsWPSR7CHzRod4=;
 b=Ac4nVkMypWUCkXYGc2SE2bdA9h2SvUs4cTZmxpCIcXyaM2D4ImFpIG3cYouwZn2Q+Y
 hwSkx0Yk02Ulb8i3G7HLu5xRNnNQ3hcozG5DgKLdYu2wK6MIom37386X+jieWfYcWPQP
 13CQ63wV5GpzpVLJ/P9H8y0hkuWQzCnfJLR8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718981889; x=1719586689;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XVjD6Z0j2yuqQs76YOwzzuT22W7+HJsWPSR7CHzRod4=;
 b=BD8I06j352orWv88Ulz1mVwG1+0xCanKjGs+5mIcJnasMPxDIdsK49c+EnJK0qUF6C
 Z++kCIRfKN60P0A/T9a/47wOyCz1W5HpAZ01xS19rk9IuztdT3o2NNpSWSMHagxBirln
 gbUTn+jvV1/qHuQjJrWqGjBOmpKPrWWDTkDvvPPETh6vZUTBC90KBtjhfZlUTuFKgYW2
 +IUXwa3QCZqMb+WvFLFLMFot7P+t3KbyLmZum1SK5rl+SQhORTNwrBlfwcxFBSRhwptt
 tlmKhNYyZSjAuO5HOYvJwGoZSKtR06L4Tr3vEx2xrL+SOcklBjeT3wXfQdAxqqoktITH
 mNMA==
X-Gm-Message-State: AOJu0YyZC6X+OdVpCq4H6Mcc6hk3R7k0tMS4prkSTXXFoLp3yyuumgxg
 BT4qOJvVWD5DgguPoS2OmcNjrxaSMy9a/f5mdzmmUzyjyPMqW/DAumG8cfZG5mpimgcZN+KSMsg
 fIQ5ce0DcBB8tvsXin48owUGFpEBBwHwwRQbKn/GGE/Olh54=
X-Google-Smtp-Source: AGHT+IE8EtPJBheqYT55+a5F+xPKUNx6+udMzuwA5ExAkgxhUz3rUPvW3QSKfITjRvgk/0drXiDgEy1d9KoNO3FhKa4=
X-Received: by 2002:a0c:f2c2:0:b0:6b2:d007:886e with SMTP id
 6a1803df08f44-6b501eb15d4mr96611346d6.54.1718981889088; Fri, 21 Jun 2024
 07:58:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1718638104.git.jerome.forissier@linaro.org>
In-Reply-To: <cover.1718638104.git.jerome.forissier@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 21 Jun 2024 08:57:58 -0600
Message-ID: <CAFLszThnOH75DSqgGq_kuzkJc3RXdbU1HVdMGQWZAJvFBgErfw@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] Introduce the lwIP network stack
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>
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

Hi Jerome,

On Mon, 17 Jun 2024 at 09:33, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
> library for the network stack" [1]. The goal is to introduce the lwIP TCP/IP
> stack [2] [3] as an alternative to the current implementation in net/,
> selectable with Kconfig, and ultimately keep only lwIP if possible. Some
> reasons for doing so are:
> - Make the support of HTTPS in the wget command easier. Javier T. (CC'd)
> has some additional lwIP and Mbed TLS patches to do so. With that it
> becomes possible to fetch and launch a distro installer such as Debian
> etc. using a secure, authenticated connection directly from the U-Boot
> shell. Several use cases:
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
>  $  git subtree add --squash --prefix lib/lwip/lwip https://git.savannah.gnu.org/git/lwip.git STABLE-2_2_0_RELEASE
>
> The first patch renames some enums in order to avoid a conflict when a
> later patch enables the lwIP library.
>
> The second patch introduces a new Kconfig symbol: NET_LWIP, which selects
> the lwIP implementation instead of the current one (NET). Contrary to the
> approach chosen by Maxim in [1], NET_LWIP and NET cannot be enabled
> simultaneously. The rationale is we want to start from a clean state and
> not pull potentially duplicated functionality from both stacks. Note
> however that a few files are still built in net/, they are the ones
> related to ethernet device management and the ethernet bootflow.
>
> The third patch splits the net.h header into net-legacy.h, net-common.h,
> net-lwip.h, leaving net.h as a simple wrapper.
>
> The fourth patch introduces the Makefile to build lwIP when NET_LWIP is
> enabled.
>
> The subsequent patches implement various network-oriented commands and
> features: dhcp, dns, ping, tftpboot, wget.
>
> A number of features are currently incompatible with NET_LWIP: SANDBOX,
> DFU_TFTP, FASTBOOT, SPL_NET. All make assumptions on how the network
> stack is implemented and/or pull sybols that are not trivially exported
> from lwIP. Some interface rework may be needed.
>
> Due to the above and in order to provide some level of testing, a new QEMU
> configuration is introduced (qemu_arm64_lwip_defconfig) which is the same
> as qemu_arm64_defconfig but with NET_LWIP and CMD_*_LWIP enabled.
> Tests are added to test/py/tests/test_net.py for that configuration.
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
> - Drop "test: dm: dsa, eth: disable tests when CONFIG_NET_LWIP=y",
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
> "Bytes transferred =" message as in the legacy implementation (Tom R.,
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
> eth: disable tests when CONFIG_NET_LWIP=y"). I need some more time
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
> [1] https://lore.kernel.org/all/20231127125726.3735-1-maxim.uvarov@linaro.org/
> [2] https://www.nongnu.org/lwip/
> [3] https://en.wikipedia.org/wiki/LwIP
>
> CC: Javier Tia <javier.tia@linaro.org>
>
> Jerome Forissier (14):
>   flash: prefix error codes with FL_
>   net: introduce alternative implementation as net-lwip/
>   net: split include/net.h into net{,-common,-legacy,-lwip}.h
>   net-lwip: build lwIP
>   net-lwip: add DHCP support and dhcp commmand
>   net-lwip: add TFTP support and tftpboot command
>   net-lwip: add ping command
>   net-lwip: add dns command
>   net: split cmd/net.c into cmd/net.c and cmd/net-common.c
>   net-lwip: add wget command
>   cmd: bdinfo: enable -e when CONFIG_CMD_NET_LWIP=y
>   configs: add qemu_arm64_lwip_defconfig
>   MAINTAINERS: net-lwip: add myself as a maintainer
>   CI: add qemu_arm64_lwip to the test matrix
>
>  .azure-pipelines.yml              |   7 +
>  Kconfig                           |  41 ++
>  MAINTAINERS                       |  11 +
>  Makefile                          |  12 +-
>  board/cobra5272/flash.c           |  26 +-
>  board/freescale/m5253demo/flash.c |   6 +-
>  boot/Kconfig                      |   5 +-
>  cmd/Kconfig                       |  44 ++
>  cmd/Makefile                      |   7 +
>  cmd/bdinfo.c                      |   5 +-
>  cmd/net-common.c                  | 109 ++++
>  cmd/net-lwip.c                    |  45 ++
>  cmd/net.c                         | 115 ----
>  common/Kconfig                    |   2 +-
>  common/board_r.c                  |   4 +-
>  common/flash.c                    |  44 +-
>  common/spl/Kconfig                |   1 +
>  configs/qemu_arm64_lwip_defconfig |   4 +
>  drivers/dfu/Kconfig               |   1 +
>  drivers/fastboot/Kconfig          |   1 +
>  drivers/mtd/cfi_flash.c           |  36 +-
>  drivers/net/Kconfig               |   3 +-
>  drivers/net/phy/Kconfig           |   2 +-
>  drivers/usb/gadget/Kconfig        |   2 +-
>  include/flash.h                   |  20 +-
>  include/net-common.h              | 408 +++++++++++++
>  include/net-legacy.h              | 649 ++++++++++++++++++++
>  include/net-lwip.h                |  36 ++
>  include/net.h                     | 944 +-----------------------------
>  lib/Makefile                      |   2 +
>  lib/lwip/Makefile                 |  55 ++
>  lib/lwip/u-boot/arch/cc.h         |  43 ++
>  lib/lwip/u-boot/arch/sys_arch.h   |   0
>  lib/lwip/u-boot/limits.h          |   0
>  lib/lwip/u-boot/lwipopts.h        | 197 +++++++
>  net-lwip/Kconfig                  |  37 ++
>  net-lwip/Makefile                 |  18 +
>  net-lwip/dhcp.c                   | 108 ++++
>  net-lwip/dns.c                    | 117 ++++
>  net-lwip/eth_internal.h           |  35 ++
>  net-lwip/net-lwip.c               | 270 +++++++++
>  net-lwip/ping.c                   | 174 ++++++
>  net-lwip/tftp.c                   | 226 +++++++
>  net-lwip/wget.c                   | 269 +++++++++
>  net/Kconfig                       |  14 -
>  45 files changed, 3008 insertions(+), 1147 deletions(-)
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
>  create mode 100644 net-lwip/Kconfig
>  create mode 100644 net-lwip/Makefile
>  create mode 100644 net-lwip/dhcp.c
>  create mode 100644 net-lwip/dns.c
>  create mode 100644 net-lwip/eth_internal.h
>  create mode 100644 net-lwip/net-lwip.c
>  create mode 100644 net-lwip/ping.c
>  create mode 100644 net-lwip/tftp.c
>  create mode 100644 net-lwip/wget.c

Would it be possible to put net-lwip in net/lwip? We should try to
keep the directory structure clean / minimal.

Regards,
Simon
