Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9105C2BA15
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 15:33:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08B0E88323;
	Mon, 17 Jun 2024 17:33:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jv3maZF7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC91B882D6; Mon, 17 Jun 2024 17:33:31 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 536DD87CDA
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 17:33:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-421798185f0so35079085e9.1
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 08:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718638408; x=1719243208; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AZNiub6HjqIVk4HqcnuWBSu1BCu0GJHEca2tO5S3CPU=;
 b=jv3maZF7hd+rW4gahKN6WGn7WwKctslp9MApCoV4savtXLpUPwC+XBbDkrSGm8CabH
 UxlI24s1PazZVPw0+XpH5ntgXiJ5dGV9OzWSThFslSRmbo2l18FCFSuBmaCn7w3TxtAx
 RRHvldOs43oCWpbY9G6S4PHw2Y2TUdFtFVMpGizOPIaV5ooqSGcZzFvlxxjkqUZcCYOi
 B35XJpiUUy4317exrWMwm1WMI4y4oXAhGvWWNdtbQLGbFtPgwQ+K6UTLeCUxfsNWIkro
 8jHbuWpYQzU0z8tOjLD1aqnt5AYQM98IojLQ5B2txkoMkLQwUF4hZtU7+tZUjHFXn3wS
 qgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718638408; x=1719243208;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AZNiub6HjqIVk4HqcnuWBSu1BCu0GJHEca2tO5S3CPU=;
 b=urO5JfrGOlKQMZ4rCNVZSfSNU16dEqgL2sSXy3cm+N5nfztlqC/dYbwP4pOlfaW7Ud
 aVtrtOZcNE0SiY2+oitp6WYt+jPqdV8QgxQ88usKClwlmxUWjJLxJpXuYzP7g1LnB5SR
 WZT5/eIWAiaR6P9P1Wvz/wo1xlRTigxGfbtVEVMLWZzIUmZyzpRRm7umQiBFG0UXRd2J
 lGuy+3sO/GHtN/nck/HSD59EYdK26uvRlINwXEdbIDrkDyokOQB7FZY6Jb/v3eTZ4ljE
 Zk0TGA4psEIuxugbXC8VlAsGGbWoIVTGfGWiSiXT3CUrY52DEyKNyTbCliT/SzTERVTZ
 Z4QQ==
X-Gm-Message-State: AOJu0YzhmkO70YVNe/3KU6yUCnsxqZk6ja9/d2Ok8372aNibCBni0lEL
 EkIVEykydL1Yb88jpuELwGHSVZMcMdSsCdcXqYn5h/Cp/p/kNIxvtaOjV5MyEeAUrSoStNMDRw4
 a
X-Google-Smtp-Source: AGHT+IG608baM+JuJizC1My8KmMgIJ84Ngqlje2U8VaAaCmV/b5WRe1xvWOmP5UELVG7iVh5vzxWLA==
X-Received: by 2002:a05:600c:21cd:b0:418:c2af:ab83 with SMTP id
 5b1f17b1804b1-4230484c9bemr82961735e9.36.1718638408412; 
 Mon, 17 Jun 2024 08:33:28 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6e75:be8f:56ae:2b5e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f602f620sm161350895e9.19.2024.06.17.08.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 08:33:28 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH v4 00/14] Introduce the lwIP network stack
Date: Mon, 17 Jun 2024 17:32:52 +0200
Message-Id: <cover.1718638104.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
library for the network stack" [1]. The goal is to introduce the lwIP TCP/IP
stack [2] [3] as an alternative to the current implementation in net/,
selectable with Kconfig, and ultimately keep only lwIP if possible. Some
reasons for doing so are:
- Make the support of HTTPS in the wget command easier. Javier T. (CC'd)
has some additional lwIP and Mbed TLS patches to do so. With that it
becomes possible to fetch and launch a distro installer such as Debian
etc. using a secure, authenticated connection directly from the U-Boot
shell. Several use cases:
  * Authentication: prevent MITM attack (third party replacing the
binary with a different one)
  * Confidentiality: prevent third parties from grabbing a copy of the
image as it is being downloaded
  * Allow connection to servers that do not support plain HTTP anymore
(this is becoming more and more common on the Internet these days)
- Possibly benefit from additional features implemented in lwIP
- Less code to maintain in U-Boot

Prior to applying this series, the lwIP stack needs to be added as a
Git subtree with the following command:

 $  git subtree add --squash --prefix lib/lwip/lwip https://git.savannah.gnu.org/git/lwip.git STABLE-2_2_0_RELEASE

The first patch renames some enums in order to avoid a conflict when a
later patch enables the lwIP library.

The second patch introduces a new Kconfig symbol: NET_LWIP, which selects
the lwIP implementation instead of the current one (NET). Contrary to the
approach chosen by Maxim in [1], NET_LWIP and NET cannot be enabled
simultaneously. The rationale is we want to start from a clean state and
not pull potentially duplicated functionality from both stacks. Note
however that a few files are still built in net/, they are the ones
related to ethernet device management and the ethernet bootflow.

The third patch splits the net.h header into net-legacy.h, net-common.h,
net-lwip.h, leaving net.h as a simple wrapper.

The fourth patch introduces the Makefile to build lwIP when NET_LWIP is
enabled.

The subsequent patches implement various network-oriented commands and
features: dhcp, dns, ping, tftpboot, wget.

A number of features are currently incompatible with NET_LWIP: SANDBOX,
DFU_TFTP, FASTBOOT, SPL_NET. All make assumptions on how the network
stack is implemented and/or pull sybols that are not trivially exported
from lwIP. Some interface rework may be needed.

Due to the above and in order to provide some level of testing, a new QEMU
configuration is introduced (qemu_arm64_lwip_defconfig) which is the same
as qemu_arm64_defconfig but with NET_LWIP and CMD_*_LWIP enabled.
Tests are added to test/py/tests/test_net.py for that configuration.

Changes in v4:

- Fixed the DHCP algorithm which was missing a sys_timeout() call in
the "fine timer" callback. This should close the issue that Tom R.
reported with his Raspberry Pi 3 (it does fix it on mine).
- The DHCP exchange timeout is increased from 2 to 10 seconds
- The DHCP exchange can be interrupted with Ctrl-C.
- "net: introduce alternative implementation as net-lwip/": rework
dependencies. A few symbols have 'depends on !NET_LWIP' and in addition
'NET_LWIP depends on !SANDBOX'. Sandbox, DSA and fastboot are
unsupported, because they are deeply welded to the current stack.
- All network commands (dns, ping, tftp and wget):
  * Get rid of global variables (Ilias A.)
  * Use printf() rather than log_info()
- "net-lwip: add ping command": use packet count instead of
timeout, fix code style (Ilias A.)
- Add "net: split cmd/net.c into cmd/net.c and cmd/net-common.c"
extracted from the wget patch (Ilias A.).
- Add "net: split include/net.h into net{,-common,-legacy,-lwip}.h"
(Ilias A.)
- Add "flash: prefix error codes with FL_" which is required to
avoid name clashes when splitting net.h
- Reworked the initialization of the lwIP stack. One and only
one network interface (struct netif) is added for the duration
of the command that uses that interface. That's commit "net-lwip:
add DHCP support and dhcp commmand".
- Drop "test: dm: dsa, eth: disable tests when CONFIG_NET_LWIP=y",
not needed now that NET_LWIP depend on !SANDBOX.
- qemu_arm64_lwip_defconfig now enables CMD_DNS and CMD_WGET (so
that all the supported network commands are available).

Changes in v3:

- Make NET_LWIP a Kconfig choice in patch "net: introduce alternative
implementation as net-lwip/" (Tom R.)
- Drop the patch introducing lwIP as a Git subtree and document the git
command in the cover letter instead (Tom R.)
- "net-lwip: add TFTP support and tftpboot command": use the same
"Bytes transferred =" message as in the legacy implementation (Tom R.,
Maxim U.)
- Drop "test/py: net: add _lwip variants of dhcp, ping and tftpboot
tests" which is not needed anymore.
- Add missing kfree() calls in cmd/net-common.c and fix the parsing of
decimal address in net-lwip/wget.c (patch "net-lwip: add wget command")
(Maxim U.)
- "net-lwip: add ping command": drop the ICMP payload (Ilias A.). Set
the sequence number to zero when entering ping_loop().

Changes in v2:

** Address comments from Ilias A.

- "net-lwip: add wget command"
Implement the wget_with_dns() function to do most of the wget work and
call it from do_wget(). This allows to simplify patch "net-lwip: add
support for EFI_HTTP_BOOT".

- "net-lwip: import net command from cmd/net.c"
Move a few functions from cmd/net.c to a new file cmd/net-common.c
rather than duplicating then in cmd/net-lwip.c.

- "net-lwip: add support for EFI_HTTP_BOOT"
Since wget_with_dns() is now implemented in "net-lwip: add wget command",
just enable the wget command when the lwIP stack is enabled and
EFI_HTTP_BOOT is requested.

** Address comments from Tom R.

- "net-lwip: add DHCP support and dhcp commmand",
  "net-lwip: add TFTP support and tftpboot command",
  "net-lwip: add ping command",
  "net-lwip: add dns command",
  "net-lwip: add wget command"
Do not introduce new CMD_XXX_LWIP symbols and use existing CMD_XXX
instead.

- "configs: add qemu_arm64_lwip_defconfig"
Use #include <configs/qemu_arm64_defconfig>.

- "net-lwip: import lwIP library under lib/lwip"
Patch removed and replaced by the introduction of a Git subtree:
"Squashed 'lib/lwip/lwip/' content from commit 0a0452b2c3".

Note that I have not yet addressed your comments on "test: dm: dsa,
eth: disable tests when CONFIG_NET_LWIP=y"). I need some more time
for that and I think running CI on this v2 will help better understand
what is needed for v3.

** Miscellaneous improvements

- "net: introduce alternative implementation as net-lwip/":

* Make DFU_OVER_TFTP not DFU_TFTP incompatible with NET_LWIP. It seems
quite natural to supplement "depends on NET" with "&& !NET_LWIP".
* Make PROT_*_LWIP not visible by removing the Kconfig prompt.

[1] https://lore.kernel.org/all/20231127125726.3735-1-maxim.uvarov@linaro.org/
[2] https://www.nongnu.org/lwip/
[3] https://en.wikipedia.org/wiki/LwIP

CC: Javier Tia <javier.tia@linaro.org>

Jerome Forissier (14):
  flash: prefix error codes with FL_
  net: introduce alternative implementation as net-lwip/
  net: split include/net.h into net{,-common,-legacy,-lwip}.h
  net-lwip: build lwIP
  net-lwip: add DHCP support and dhcp commmand
  net-lwip: add TFTP support and tftpboot command
  net-lwip: add ping command
  net-lwip: add dns command
  net: split cmd/net.c into cmd/net.c and cmd/net-common.c
  net-lwip: add wget command
  cmd: bdinfo: enable -e when CONFIG_CMD_NET_LWIP=y
  configs: add qemu_arm64_lwip_defconfig
  MAINTAINERS: net-lwip: add myself as a maintainer
  CI: add qemu_arm64_lwip to the test matrix

 .azure-pipelines.yml              |   7 +
 Kconfig                           |  41 ++
 MAINTAINERS                       |  11 +
 Makefile                          |  12 +-
 board/cobra5272/flash.c           |  26 +-
 board/freescale/m5253demo/flash.c |   6 +-
 boot/Kconfig                      |   5 +-
 cmd/Kconfig                       |  44 ++
 cmd/Makefile                      |   7 +
 cmd/bdinfo.c                      |   5 +-
 cmd/net-common.c                  | 109 ++++
 cmd/net-lwip.c                    |  45 ++
 cmd/net.c                         | 115 ----
 common/Kconfig                    |   2 +-
 common/board_r.c                  |   4 +-
 common/flash.c                    |  44 +-
 common/spl/Kconfig                |   1 +
 configs/qemu_arm64_lwip_defconfig |   4 +
 drivers/dfu/Kconfig               |   1 +
 drivers/fastboot/Kconfig          |   1 +
 drivers/mtd/cfi_flash.c           |  36 +-
 drivers/net/Kconfig               |   3 +-
 drivers/net/phy/Kconfig           |   2 +-
 drivers/usb/gadget/Kconfig        |   2 +-
 include/flash.h                   |  20 +-
 include/net-common.h              | 408 +++++++++++++
 include/net-legacy.h              | 649 ++++++++++++++++++++
 include/net-lwip.h                |  36 ++
 include/net.h                     | 944 +-----------------------------
 lib/Makefile                      |   2 +
 lib/lwip/Makefile                 |  55 ++
 lib/lwip/u-boot/arch/cc.h         |  43 ++
 lib/lwip/u-boot/arch/sys_arch.h   |   0
 lib/lwip/u-boot/limits.h          |   0
 lib/lwip/u-boot/lwipopts.h        | 197 +++++++
 net-lwip/Kconfig                  |  37 ++
 net-lwip/Makefile                 |  18 +
 net-lwip/dhcp.c                   | 108 ++++
 net-lwip/dns.c                    | 117 ++++
 net-lwip/eth_internal.h           |  35 ++
 net-lwip/net-lwip.c               | 270 +++++++++
 net-lwip/ping.c                   | 174 ++++++
 net-lwip/tftp.c                   | 226 +++++++
 net-lwip/wget.c                   | 269 +++++++++
 net/Kconfig                       |  14 -
 45 files changed, 3008 insertions(+), 1147 deletions(-)
 create mode 100644 cmd/net-common.c
 create mode 100644 cmd/net-lwip.c
 create mode 100644 configs/qemu_arm64_lwip_defconfig
 create mode 100644 include/net-common.h
 create mode 100644 include/net-legacy.h
 create mode 100644 include/net-lwip.h
 create mode 100644 lib/lwip/Makefile
 create mode 100644 lib/lwip/u-boot/arch/cc.h
 create mode 100644 lib/lwip/u-boot/arch/sys_arch.h
 create mode 100644 lib/lwip/u-boot/limits.h
 create mode 100644 lib/lwip/u-boot/lwipopts.h
 create mode 100644 net-lwip/Kconfig
 create mode 100644 net-lwip/Makefile
 create mode 100644 net-lwip/dhcp.c
 create mode 100644 net-lwip/dns.c
 create mode 100644 net-lwip/eth_internal.h
 create mode 100644 net-lwip/net-lwip.c
 create mode 100644 net-lwip/ping.c
 create mode 100644 net-lwip/tftp.c
 create mode 100644 net-lwip/wget.c

-- 
2.40.1

