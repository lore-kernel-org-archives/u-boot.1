Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11987C27C55
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 13:36:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 388AC88414;
	Thu,  6 Jun 2024 15:36:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MpIlD4SB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2A3D883CE; Thu,  6 Jun 2024 15:36:56 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39BBB878E2
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 15:36:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42136faf3aeso6331465e9.2
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 06:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717681013; x=1718285813; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AHE/C5ynmqIm2V1kHQaVhNVTBeVr7o5cQodyqdDe4Sc=;
 b=MpIlD4SBV819/AboWyusZVGO+UvM/asyh1buoitZuVsK83HDt/7xHvf39O6uQoCusC
 bEGczD/MB/w9mbQf/FUmyvwu5GiPFQA4CyOuzJbwxKVS+81ZvUBjam3GBTh7LORn2FyR
 XUJ1NpzMhq2bux03hrLRK/sR43+gojRNeo1yiKvfVnOxUxzFGNVgD8QFOGSGnDQBuevB
 M061wRcoNxo7uQ4UfYPhC2KmEUVv8r9NrstGxaxgy3B8oWfIrBCe9Ro3I3KM8/pxD9m1
 bMDcwARjFKJKDQCRZ/6xfjPIIUup3bWwqDYEndiHbLpYihs1mao73SJrTuBwWVbUgJ3H
 b0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717681013; x=1718285813;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AHE/C5ynmqIm2V1kHQaVhNVTBeVr7o5cQodyqdDe4Sc=;
 b=KK3LDOK1Ul1Fsj31wwUxUAMVSy9tWp5myZZEzxtY4s64euVUUgiMPIrV1H6psEQ1K5
 LmeFXfvjJlC78puHN8QJUA7rH9BKimxl1vAPe1Ay4YF6hYsPOweXyEfeWSKu+vdfPovu
 dvRDXX3VRg5AMWHFWuYN4dFzDFoATo8xaYdvpXlZqJfhdWhCnMTI8wiPcsF+sKPq7hGr
 3xi2oAzqNtcDjkFRTlcSZ1hTKePwtqPsiUHj0hH7UuJfsdsxgZHpMdts2qUh9XyBj5B6
 n0u8+HxiqiTmnCrUUGVdnwhHxY7Y2OXl42S9x30U5aZubtDJnPqRvSR73R5hdRTzJikj
 TaNA==
X-Gm-Message-State: AOJu0YyqsXXwWeHuO9HXTGqFME0tvCdRVNT9jCPevn+OPEsjAUdGJSst
 wI7zXc4s81ABie1sYfSh/2XeiQyIVd4bPxbgehAN6C63+IWqodmvz0dX9LSG08KqJs3+J8uG2Pz
 FXPHUJ3cK
X-Google-Smtp-Source: AGHT+IH1chTq/XmFEL5gqtJEX11REQc/EUzmW2ROUgGyF5HHsCj7SgebYeI7Tqvdf0CI89OLE7SrDA==
X-Received: by 2002:a05:600c:4e0b:b0:421:5f00:90b9 with SMTP id
 5b1f17b1804b1-4215f009442mr12373935e9.38.1717681012692; 
 Thu, 06 Jun 2024 06:36:52 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215c19d52dsm23111955e9.8.2024.06.06.06.36.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 06:36:52 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH v3 00/12] Introduce the lwIP network stack
Date: Thu,  6 Jun 2024 15:35:55 +0200
Message-Id: <cover.1717680809.git.jerome.forissier@linaro.org>
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

The first patch introduces a new Kconfig symbol: NET_LWIP, which selects
the lwIP implementation instead of the current one (NET). Contrary to the
approach chosen by Maxim in [1], NET_LWIP and NET cannot be enabled
simultaneously. The rationale is we want to start from a clean state and
not pull potentially duplicated functionality from both stacks. Note
however that a few files are still built in net/, they are the ones
related to ethernet device management and the ethernet bootflow.

The second patch introduces the Makefile to build lwIP when NET_LWIP is
enabled.

The subsequent patches implement various network-oriented commands and
features: dhcp, dns, ping, tftpboot, wget.

NET_LWIP is not enabled by default because it lacks functionality compared
to NET and many CI tests would fail to run or even build.

Some tests (dm dsa/eth) are disabled when NET_LWIP is selected because
they make strong assumptions on how the network stack is implemented and
how the packet flow occurs. For example, an ARP exchange is expected
when an ICMP packet goes out, but with lwIP no exchange will occur if the
host IP is already in the the ARP cache.

Due to the above and in order to provide some level of testing, a new QEMU
configuration is introduced (qemu_arm64_lwip_defconfig) which is the same
as qemu_arm64_lwip_defconfig but with NET_LWIP and CMD_*_LWIP enabled.
Tests are added to test/py/tests/test_net.py for that configuration.

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

Jerome Forissier (12):
  net: introduce alternative implementation as net-lwip/
  net-lwip: build lwIP
  net-lwip: add DHCP support and dhcp commmand
  net-lwip: add TFTP support and tftpboot command
  net-lwip: add ping command
  net-lwip: add dns command
  net-lwip: add wget command
  test: dm: dsa, eth: disable tests when CONFIG_NET_LWIP=y
  cmd: bdinfo: enable -e when CONFIG_CMD_NET_LWIP=y
  configs: add qemu_arm64_lwip_defconfig
  MAINTAINERS: net-lwip: add myself as a maintainer
  CI: add qemu_arm64_lwip to the test matrix

 .azure-pipelines.yml              |   7 +
 Kconfig                           |  40 ++++++
 MAINTAINERS                       |  11 ++
 Makefile                          |   3 +-
 boot/Kconfig                      |   5 +-
 cmd/Kconfig                       |  44 ++++++
 cmd/Makefile                      |   7 +
 cmd/bdinfo.c                      |   5 +-
 cmd/efidebug.c                    |   8 +-
 cmd/net-common.c                  | 115 +++++++++++++++
 cmd/net-lwip.c                    |  49 +++++++
 cmd/net.c                         | 115 ---------------
 common/Kconfig                    |   2 +-
 common/board_r.c                  |   4 +-
 common/spl/Kconfig                |   1 +
 configs/qemu_arm64_lwip_defconfig |   3 +
 drivers/dfu/Kconfig               |   2 +-
 drivers/fastboot/Kconfig          |   4 +-
 drivers/net/Kconfig               |   2 +-
 drivers/net/phy/Kconfig           |   2 +-
 drivers/usb/gadget/Kconfig        |   2 +-
 include/net-lwip.h                | 140 +++++++++++++++++++
 include/net.h                     |   2 +-
 lib/Makefile                      |   2 +
 lib/lwip/Makefile                 |  57 ++++++++
 lib/lwip/u-boot/arch/cc.h         |  43 ++++++
 lib/lwip/u-boot/arch/sys_arch.h   |   0
 lib/lwip/u-boot/limits.h          |   0
 lib/lwip/u-boot/lwipopts.h        | 197 ++++++++++++++++++++++++++
 net-lwip/Kconfig                  |  37 +++++
 net-lwip/Makefile                 |  18 +++
 net-lwip/dhcp.c                   | 114 +++++++++++++++
 net-lwip/dns.c                    | 107 ++++++++++++++
 net-lwip/eth_internal.h           |  35 +++++
 net-lwip/net-lwip.c               | 224 ++++++++++++++++++++++++++++++
 net-lwip/ping.c                   | 163 ++++++++++++++++++++++
 net-lwip/tftp.c                   | 209 ++++++++++++++++++++++++++++
 net-lwip/wget.c                   | 180 ++++++++++++++++++++++++
 net/Kconfig                       |  14 --
 test/dm/dsa.c                     |   2 +
 test/dm/eth.c                     |   4 +
 41 files changed, 1832 insertions(+), 147 deletions(-)
 create mode 100644 cmd/net-common.c
 create mode 100644 cmd/net-lwip.c
 create mode 100644 configs/qemu_arm64_lwip_defconfig
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

