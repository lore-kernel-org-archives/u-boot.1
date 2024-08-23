Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26532C531DC
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 13:49:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81D7D889DA;
	Fri, 23 Aug 2024 15:49:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w8YIBJBS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4224A88722; Fri, 23 Aug 2024 15:49:14 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E32CF88641
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 15:49:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3730749ee7aso1111000f8f.2
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 06:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724420950; x=1725025750; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Up2hxOvqkAi7gCFLG7BiuXroOGierzmYCY1vg84tBcg=;
 b=w8YIBJBS/L3keL3+PBd9IR6Kkui3v8wHSpqrW12Z1jughzcGmJo7rUvldpf6skQOkc
 tTtd7kTPWhda90JDJL8RD0dQkfGAdVbxkX1X20eFBxDbKhnnNkvI8LCltmZi9CvLz2Gx
 4uhSMrmRR+LEj2lmJvKhLE6l6bkiuNWj3FixUgpGwycT8GPR5Foqu4Z/LIfqnyH80f04
 gMtOCn8nBfTmAnv34KS331rsO8q4jfDKT5EOFJ9jYPxZrUYOS+3xFuMeKu52kL9NIixt
 hIC+R8rkNWbJLylpTVaB+81w+BwahsfrjoAYjirvODPfRwMW397b3kCk4ZPl65rXgf7a
 rb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724420950; x=1725025750;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Up2hxOvqkAi7gCFLG7BiuXroOGierzmYCY1vg84tBcg=;
 b=kT/VNovWTIZOaUJ5aAPM5+GNA1oUou+SAAPN4bOmmi0sqQzJKhUSCAfLSwlo6P4CET
 yw/qIy+XXZKGRNb49yc7DRheNOfehpoUj1XckYKwbytVIaMiUOFeH4Ot6whphGSI9dFk
 Eq5ndLiWozoeewmY/s9jyRaibm9rn/lVqaIbtprnSGlqZiR+XBTstidvm6ceK0yQzEIg
 WmedokCzuC0QovJ5iRgoCOSQ+fEu77S7Q+GddEanML0JPI/+1251/ZoaFR+ny+FqOzGg
 DRjIStmPIfNeS3kcQ4+gBTBUHHFEWRw/rYUdBFlhW+0HJ/OW3rlX46gSiLQ3Oo0BnKC8
 8GPQ==
X-Gm-Message-State: AOJu0Ywo5wsUfoR8/71xbARHIfgKtvmmfnSDWM+eFr6SwJNM66bYM4Mq
 Y2dU+SHb2VSZn7UxzbdEgWWicSbRzL9xVYyWKqcPV/4MO0vJWFCXY6+TFOitTQD5ch5xpUnF5eM
 1/MW/Rw==
X-Google-Smtp-Source: AGHT+IFooevgrP1aSc8PG6q+98MsXk5Je7/4tm+gCLeyrCCueTPFj7C64GvgHk7glEaY2DrHu1JD2w==
X-Received: by 2002:a05:6000:54a:b0:368:420e:b790 with SMTP id
 ffacd0b85a97d-37311855d66mr1506541f8f.14.1724420949716; 
 Fri, 23 Aug 2024 06:49:09 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:e668:dc94:35c7:8064])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-373081ffb40sm4201665f8f.76.2024.08.23.06.49.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 06:49:09 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH v9 00/23] Introduce the lwIP network stack
Date: Fri, 23 Aug 2024 15:48:04 +0200
Message-Id: <cover.1724419624.git.jerome.forissier@linaro.org>
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
- Make the support of HTTPS in the wget command easier. Javier T. and
Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to do
so. With that it becomes possible to fetch and launch a distro installer
such as Debian etc. using a secure, authenticated connection directly
from the U-Boot shell. Several use cases:
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

Notes

1. A number of features are currently incompatible with NET_LWIP: SANDBOX,
DFU_TFTP, FASTBOOT, SPL_NET, CMD_PXE. All make assumptions on how the network
stack is implemented and/or pull sybols that are not trivially exported
from lwIP. Some interface rework may be needed.

2. Due to the above and in order to provide some level of testing, a new QEMU
configuration is introduced (qemu_arm64_lwip_defconfig) which is the same
as qemu_arm64_defconfig but with NET_LWIP and CMD_*_LWIP enabled.
Tests are added to test/py/tests/test_net.py for that configuration.
In addition to that, this series has some [TESTING] patches which make
NET_LWIP the default and opt-out the platforms that fail CI (~130 of
them, among which ~100 is because of PXE).

[1] https://lore.kernel.org/all/20231127125726.3735-1-maxim.uvarov@linaro.org/
[2] https://www.nongnu.org/lwip/
[3] https://en.wikipedia.org/wiki/LwIP

Changes in v9:

- Rebased onto master, reordered commits to put some fixes that are not
strictly related to lwIP first.
- New commit "test/py: test_efi_loader: add missing dependency on
cmd_tftpboot" (Tom R.)
- test_efi_loader.py: add missing dependency on cmd_wget (Tom R.)
- wget: fix divide by zero when transfer takes less than 1ms (Tom R.)
- New commit "configs: use syntax CONFIG_FOO=n in tools-only_defconfig"
(Tom R.)
- Make TCP_WND configurable (via CONFIG_LWIP_TCP_WND) because a large
value is needed for good performance especially with latency but 
transfers stall in QEMU (-net user) when the value is larger than a few
KB (Anton A., offlist)
- Added [TESTING] commits to run CI with NET_LWIP enabled by default
except for SANDBOX and platforms that enable PXE, and fixed a number of
issues:
  * coreboot_defconfig: 'implicit declaration' warnings on
    ip_checksum_ok() and compute_ip_checksum()
  * Fix EFI net tests (bootefi selftest) by adding missing
    push_packed() call to net_process_received_packet()
  * qemu_arm64: fix test_efi_loader.py failures (skip HTTP test
    by default since it needs a HTTP server; fix a bug in the dhcp
    command which would not set the "serverip" variable)
  * QEMU CI tests for r2dplus_i82557c, r2dplus_rtl8139:
    Fixed receive errors due to calling free_pkt() with a
    length of zero. r2dplus_tulip: fixed "dm_pci_phys_to_bus:
    invalid physical address" caused by too late eth_init_rings().
With that the CI status is all GREEN:
https://dev.azure.com/u-boot/u-boot/_build/results?buildId=9225&view=results

Changes in v8:

- Fix bootefi with tftp and wget. It would previously fail with an
error message: "No UEFI binary known at 200000". Tested on Raspberry
3B+. Also fix the legacy wget. (Tom R.)
- wget: add "Bytes transferred =" message and accept legacy syntax
for better compatibility which also makes it easier to add a test to
the test suite
- wget: When no server name or address is supplied, use
${httpserverip} then ${serverip}.
- wget: start the timer used for measuring throughput when the first
data block is received. In other words: do not include DNS resolution
and TCP connection time in measurement. It gives better numbers ;)
but more importantly is how the legacy code works.
- wget: handle non-200 result codes from the server as errors.
- tftp: when no server name or ip is supplied, use ${tftpserverip}
then fall back to ${serverip}.
- New commit: "test/py: add HTTP (wget) test"
- New commit: "net: wget: removed unused function wget_success()"
- Change back all !CONFIG_IS_ENABLED(NO_NET) tests to
(CONFIG_IS_ENABLED(NET) || CONFIG_IS_ENABLED(NET_LWIP)) since the
NO_NET case is wrong when CONFIG_SPL_BUILD or CONFIG_TPL_BUILD is
defined (Tom R.)

Changes in v7:

- Rebased onto master
- Updated binary size comparisons in this cover letter. Note that
the increase for imx8mp_evk_defconfig  was wrong due to a configuration
error.

Changes in v6:

- Rebased on next
- "flash: prefix error codes with FL_"
Update drivers/mtd/altera_qspi.c too (Tom R.)
- "net: introduce alternative implementation as net-lwip/"
Introduce a "Networking" top-level menu in the main Kconfig. Avoids
having a lot of network-related symbols on the first screen of
menuconfig. The "Networking stack" choice as well as the applicable
symbols (depending on the selected choice) are now all inside this
"Networking" menu. (Michal S.)
For PROT_DHCP_LWIP and PROT_DNS_LWIP, use "select" PROT_UDP_LWIP
rather than "depends on".
Move NET_RANDOM_ETHADDR to the common ('if NET || NET_LWIP') block.
Move SYS_RX_ETH_BUFFER out of 'if NET || NET_LWIP' since it is used
unguarded in some code (e.g., am62x_beagleplay_r5) (Tom R.).
- "net: split include/net.h into net{,-common,-legacy,-lwip}.h"
Move net_random_ethaddr() to net-common.h.
- "net: eth-uclass: add function eth_start_udev()"
Fix typo and apply Tom R.'s R-b.
- "net-lwip: add DHCP support and dhcp commmand"
Convert !CONFIG_IS_ENABLED(NET) to
CONFIG_IS_ENABLED(NO_NET) in board/xilinx/common/board.c
to fix an issue with device having no MAC address (thanks Michal S.).
Do the same at other places (icore_mx8mp.c, imx8mp_debix_model_a.c,
board/ti/am335x/board.c, tiny-printf.c).
Move CMD_MII and CMD_MDIO into 'if NET || NET_LWIP'.
- "net-lwip: add TFTP support and tftpboot command":
Fix help string.
- "net: split cmd/net.c into cmd/net.c and cmd/net-common.c":
Apply Ilias' R-b.
- "net-lwip: add TFTP_BLOCKSIZE"
Apply Ilias' R-b. I moved the TFTP_BLOCKSIZE Kconfig into this commit
where it belongs (it was previously in "net" split ... net.h").

Changes in v5:

- Rebased on next
- Refactor Kconfig options to avoid duplicates
- Library functions use a more consistent naming (dhcp_loop(),
ping_loop() etc.) and take a struct udevice * parameter (Heinrich S.)
- Do not use net_process_receive_packet() for input anymore. Instead of
calling eth_rx() which would invoke net_process_receive_packet(), we
call a new net_lwip_rx(udev) function which invokes the device recv()
and pushes the packets up the lwIP stack. Thus everything is tied to
a udevice now. (Heinrich S.)
- Add "configs: replace '# CONFIG_NET is not set' with CONFIG_NO_NET=y"
(Tom R.)
- tftp: unify display with legacy command: add throughput, 65 hashes per
line, one every 10 blocks received (Tom R.)
- Moved net-lwip/* to net/lwip/* (Simon G.)
- Rename static function low_level_output() to linkoutput() since it is
the name used in the lwIP netif struct.
- Fixed off-by-one in parse_url() which could cause wget to fail when
passed a URL with a host name (as opposed to a URL with an IP address).
- Improved TFTP performance by adding support for the blksize option
(patches "lwip: tftp: add support of blksize option to client" and
"net-lwip: add TFTP_BLOCKSIZE) (Tom R.)
- Add an optional port number to the tftp command for easier testing
(syntax: tftp [[ip:[port:]]filename])
- wget: display an "unsupported URI" error if uri is not http://
(Jon H.)
- Adjusted the lwIP TCP options in lib/lwip/u-boot/lwipopts.h for
better performance, in particular TCP_WND.
- Add "net: fec_mxc_init(): do not ignore return status of fec_open()"
- Set the proper environment variables when DHCP succeeds (ipaddr%d
etc.) and read the proper ones for the given device in new_netif(),
allowing correct behavior when several adapters are available (tested
on i.MX8M Plus).
- Fix an alignment issue with outgoing packets (see the linkoutput()
function). With that the i.MX8M Plus ENET1 interface works properly.
(reported by Tim H.).
- Add review tags

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

Jerome Forissier (36):
  Makefile: detect HOST_ARCH properly when CROSS_COMPILE is multi-word
  flash: prefix error codes with FL_
  at91: rename mem_init() to at91_mem_init()
  arm: omap2: add missing #include <netdev.h>
  net: fm: call dtsec_init_phy() only when it is defined
  net: wget: removed unused function wget_success()
  net: phy: ncsi: depend on NET
  net: ftgmac100: depend on NET
  net: wget: allow EFI boot
  net: fec_mxc_init(): do not ignore return status of fec_open()
  test/py: net_boot: fix comment
  test/py: test_efi_loader: add missing dependency on cmd_tftpboot
  test/py: test_efi_loader: add HTTP (wget) test for the EFI loader
  net: introduce alternative implementation as net-lwip/
  configs: replace '# CONFIG_NET is not set' with CONFIG_NO_NET=y
  net: split include/net.h into net{,-common,-legacy,-lwip}.h
  net: move copy_filename() to new file net/net-common.c
  net: eth-uclass: add function eth_start_udev()
  net-lwip: build lwIP
  net-lwip: add DHCP support and dhcp commmand
  net-lwip: add TFTP support and tftpboot command
  net-lwip: add ping command
  net-lwip: add dns command
  net: split cmd/net.c into cmd/net.c and cmd/net-common.c
  net-lwip: add wget command
  cmd: bdinfo: enable -e when CONFIG_CMD_NET_LWIP=y
  configs: add qemu_arm64_lwip_defconfig
  lwip: tftp: add support of blksize option to client
  net-lwip: add TFTP_BLOCKSIZE
  CI: add qemu_arm64_lwip to the test matrix
  MAINTAINERS: net-lwip: add myself as a maintainer
  Kconfig: fix undefined symbols (g_dnl*) when NET_LWIP is default
    enabled
  configs: use syntax CONFIG_FOO=n in tools-only_defconfig
  [TESTING] Kconfig: enable NET_LWIP by default except for SANDBOX
  [TESTING] configs: set CONFIG_NET=y for FTGMAC100
  [TESTING] configs: set CONFIG_NET=y when PXE is enabled

Jonathan Humphreys (1):
  net-lwip: lwIP wget supports user defined port in the uri, so allow
    it.

 .azure-pipelines.yml                          |   7 +
 Kconfig                                       |  31 +
 MAINTAINERS                                   |  11 +
 Makefile                                      |   6 +-
 arch/arm/mach-at91/include/mach/at91_common.h |   2 +-
 arch/arm/mach-at91/spl_at91.c                 |   2 +-
 arch/arm/mach-at91/spl_atmel.c                |   2 +-
 arch/arm/mach-omap2/omap3/emac.c              |   1 +
 .../atmel/at91sam9m10g45ek/at91sam9m10g45ek.c |   2 +-
 board/atmel/at91sam9n12ek/at91sam9n12ek.c     |   2 +-
 board/atmel/at91sam9x5ek/at91sam9x5ek.c       |   2 +-
 .../atmel/sama5d27_som1_ek/sama5d27_som1_ek.c |   2 +-
 .../sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c   |   2 +-
 board/atmel/sama5d2_icp/sama5d2_icp.c         |   2 +-
 .../atmel/sama5d2_xplained/sama5d2_xplained.c |   2 +-
 .../atmel/sama5d3_xplained/sama5d3_xplained.c |   2 +-
 board/atmel/sama5d3xek/sama5d3xek.c           |   2 +-
 .../atmel/sama5d4_xplained/sama5d4_xplained.c |   2 +-
 board/atmel/sama5d4ek/sama5d4ek.c             |   2 +-
 board/cobra5272/flash.c                       |  26 +-
 .../conclusive/kstr-sama5d27/kstr-sama5d27.c  |   2 +-
 board/engicam/imx8mp/icore_mx8mp.c            |   2 +-
 board/freescale/m5253demo/flash.c             |   6 +-
 board/gardena/smart-gateway-at91sam/spl.c     |   2 +-
 .../imx8mp_debix_model_a.c                    |   2 +-
 board/siemens/corvus/board.c                  |   2 +-
 board/siemens/smartweb/smartweb.c             |   2 +-
 board/siemens/taurus/taurus.c                 |   2 +-
 board/ti/am335x/board.c                       |   3 +-
 board/xilinx/common/board.c                   |   3 +-
 boot/Kconfig                                  |   4 +-
 cmd/Kconfig                                   | 129 ++-
 cmd/Makefile                                  |   9 +-
 cmd/bdinfo.c                                  |   5 +-
 cmd/elf.c                                     |   2 +-
 cmd/net-common.c                              | 109 ++
 cmd/net-lwip.c                                |  45 +
 cmd/net.c                                     | 115 ---
 common/Kconfig                                |   2 +-
 common/board_r.c                              |   4 +-
 common/flash.c                                |  44 +-
 common/spl/Kconfig                            |   1 +
 common/usb_kbd.c                              |   2 +-
 configs/LicheePi_Zero_defconfig               |   2 +-
 configs/M5249EVB_defconfig                    |   2 +-
 configs/ad401_defconfig                       |   1 +
 configs/am335x_pdu001_defconfig               |   2 +-
 configs/am43xx_evm_defconfig                  |   1 +
 configs/am43xx_evm_qspiboot_defconfig         |   1 +
 configs/am43xx_evm_rtconly_defconfig          |   1 +
 configs/am43xx_evm_usbhost_boot_defconfig     |   1 +
 configs/am43xx_hs_evm_defconfig               |   1 +
 configs/am43xx_hs_evm_qspi_defconfig          |   1 +
 configs/am57xx_evm_defconfig                  |   1 +
 configs/am57xx_hs_evm_defconfig               |   1 +
 configs/am57xx_hs_evm_usb_defconfig           |   1 +
 configs/am62ax_evm_r5_defconfig               |   2 +-
 configs/am62px_evm_r5_defconfig               |   2 +-
 configs/am62x_beagleplay_r5_defconfig         |   2 +-
 configs/amcore_defconfig                      |   2 +-
 configs/anbernic-rgxx3-rk3566_defconfig       |   2 +-
 configs/ap143_defconfig                       |   2 +-
 configs/ap152_defconfig                       |   2 +-
 configs/apple_m1_defconfig                    |   2 +-
 configs/arndale_defconfig                     |   1 +
 configs/astro_mcf5373l_defconfig              |   2 +-
 configs/at91sam9rlek_dataflash_defconfig      |   2 +-
 configs/at91sam9rlek_mmc_defconfig            |   2 +-
 configs/at91sam9rlek_nandflash_defconfig      |   2 +-
 configs/bananapi-cm4-cm4io_defconfig          |   1 +
 configs/bananapi-m2-pro_defconfig             |   1 +
 configs/bananapi-m2s_defconfig                |   1 +
 configs/bananapi-m5_defconfig                 |   1 +
 configs/bcm7260_defconfig                     |   2 +-
 configs/bcm7445_defconfig                     |   2 +-
 configs/bcm968380gerg_ram_defconfig           |   2 +-
 configs/bcmns_defconfig                       |   2 +-
 configs/beelink-gsking-x_defconfig            |   1 +
 configs/beelink-gt1-ultimate_defconfig        |   1 +
 configs/beelink-gtking_defconfig              |   1 +
 configs/beelink-gtkingpro_defconfig           |   1 +
 configs/chromebook_samus_tpl_defconfig        |   2 +-
 configs/clearfog_defconfig                    |   1 +
 configs/clearfog_gt_8k_defconfig              |   1 +
 configs/clearfog_sata_defconfig               |   1 +
 configs/clearfog_spi_defconfig                |   1 +
 configs/cortina_presidio-asic-base_defconfig  |   2 +-
 configs/cortina_presidio-asic-pnand_defconfig |   2 +-
 configs/dra7xx_evm_defconfig                  |   1 +
 configs/dra7xx_hs_evm_defconfig               |   1 +
 configs/dra7xx_hs_evm_usb_defconfig           |   1 +
 configs/durian_defconfig                      |   2 +-
 configs/e850-96_defconfig                     |   2 +-
 configs/ea-lpc3250devkitv2_defconfig          |   2 +-
 configs/efi-x86_app32_defconfig               |   2 +-
 configs/efi-x86_app64_defconfig               |   2 +-
 configs/emsdp_defconfig                       |   2 +-
 configs/evb-ast2500_defconfig                 |   1 +
 configs/evb-ast2600_defconfig                 |   1 +
 configs/evb-px5_defconfig                     |   2 +-
 configs/generic-rk3568_defconfig              |   2 +-
 configs/generic-rk3588_defconfig              |   2 +-
 configs/hc2910_2aghd05_defconfig              |   2 +-
 configs/helios4_defconfig                     |   1 +
 configs/igep00x0_defconfig                    |   2 +-
 configs/imx6q_bosch_acc_defconfig             |   2 +-
 configs/imx6ulz_smm_m2_defconfig              |   2 +-
 configs/imx8mn_var_som_defconfig              |   1 +
 configs/iot_devkit_defconfig                  |   2 +-
 configs/jethub_j100_defconfig                 |   1 +
 configs/jethub_j80_defconfig                  |   1 +
 configs/khadas-vim2_defconfig                 |   1 +
 configs/khadas-vim3_defconfig                 |   1 +
 configs/khadas-vim3l_defconfig                |   1 +
 configs/khadas-vim_defconfig                  |   1 +
 configs/kontron-sl-mx6ul_defconfig            |   1 +
 configs/kontron-sl-mx8mm_defconfig            |   1 +
 configs/kontron_pitx_imx8m_defconfig          |   1 +
 configs/kontron_sl28_defconfig                |   1 +
 configs/legoev3_defconfig                     |   2 +-
 configs/libretech-ac_defconfig                |   1 +
 configs/libretech-cc_defconfig                |   1 +
 configs/libretech-cc_v2_defconfig             |   1 +
 configs/libretech-s905d-pc_defconfig          |   1 +
 configs/libretech-s912-pc_defconfig           |   1 +
 configs/marsboard_defconfig                   |   1 +
 configs/mk808_defconfig                       |   2 +-
 configs/mvebu_crb_cn9130_defconfig            |   1 +
 configs/mvebu_db_armada8k_defconfig           |   1 +
 configs/mvebu_db_cn9130_defconfig             |   1 +
 configs/mvebu_mcbin-88f8040_defconfig         |   1 +
 configs/mvebu_puzzle-m801-88f8040_defconfig   |   1 +
 configs/mx23evk_defconfig                     |   2 +-
 configs/mx28evk_defconfig                     |   2 +-
 configs/mx53cx9020_defconfig                  |   1 +
 configs/mx6cuboxi_defconfig                   |   1 +
 configs/mx6memcal_defconfig                   |   2 +-
 configs/mx6ulz_14x14_evk_defconfig            |   2 +-
 configs/mx7dsabresd_defconfig                 |   1 +
 configs/mx7dsabresd_qspi_defconfig            |   1 +
 configs/mx7ulp_com_defconfig                  |   2 +-
 configs/mx7ulp_evk_defconfig                  |   2 +-
 configs/mx7ulp_evk_plugin_defconfig           |   2 +-
 configs/myir_mys_6ulx_defconfig               |   1 +
 configs/nanopi-k2_defconfig                   |   1 +
 configs/netgear_cg3100d_ram_defconfig         |   2 +-
 configs/novena_defconfig                      |   1 +
 configs/nsim_700_defconfig                    |   2 +-
 configs/nsim_700be_defconfig                  |   2 +-
 configs/nsim_hs38be_defconfig                 |   2 +-
 configs/odroid-c2_defconfig                   |   1 +
 configs/odroid-c4_defconfig                   |   1 +
 configs/odroid-go-ultra_defconfig             |   1 +
 configs/odroid-hc4_defconfig                  |   1 +
 configs/odroid-n2_defconfig                   |   1 +
 configs/odroid-n2l_defconfig                  |   1 +
 configs/odroid-xu3_defconfig                  |   1 +
 configs/openpiton_riscv64_defconfig           |   2 +-
 configs/openpiton_riscv64_spl_defconfig       |   2 +-
 configs/origen_defconfig                      |   2 +-
 configs/p200_defconfig                        |   1 +
 configs/p201_defconfig                        |   1 +
 configs/p212_defconfig                        |   1 +
 configs/pe2201_defconfig                      |   2 +-
 configs/peach-pi_defconfig                    |   1 +
 configs/peach-pit_defconfig                   |   1 +
 configs/phycore_pcl063_defconfig              |   1 +
 configs/pico-dwarf-imx6ul_defconfig           |   1 +
 configs/pico-dwarf-imx7d_defconfig            |   1 +
 configs/pico-hobbit-imx6ul_defconfig          |   1 +
 configs/pico-hobbit-imx7d_defconfig           |   1 +
 configs/pico-imx6ul_defconfig                 |   1 +
 configs/pico-imx7d_bl33_defconfig             |   1 +
 configs/pico-imx7d_defconfig                  |   1 +
 configs/pico-nymph-imx7d_defconfig            |   1 +
 configs/pico-pi-imx6ul_defconfig              |   1 +
 configs/pico-pi-imx7d_defconfig               |   1 +
 configs/pinecube_defconfig                    |   2 +-
 configs/pm9261_defconfig                      |   2 +-
 configs/qemu_arm64_lwip_defconfig             |  10 +
 configs/radxa-zero2_defconfig                 |   1 +
 configs/radxa-zero_defconfig                  |   1 +
 configs/riotboard_defconfig                   |   1 +
 configs/s400_defconfig                        |   1 +
 configs/s5p4418_nanopi2_defconfig             |   2 +-
 configs/s5p_goni_defconfig                    |   2 +-
 configs/s5pc210_universal_defconfig           |   2 +-
 configs/sama5d27_giantboard_defconfig         |   2 +-
 configs/sama5d29_curiosity_mmc1_defconfig     |   2 +-
 configs/sama5d29_curiosity_mmc_defconfig      |   2 +-
 .../sama5d29_curiosity_qspiflash_defconfig    |   2 +-
 configs/sama7g54_curiosity_mmc_defconfig      |   2 +-
 .../sama7g54_curiosity_nandflash_defconfig    |   2 +-
 .../sama7g54_curiosity_qspiflash_defconfig    |   2 +-
 configs/seeed_npi_imx6ull_defconfig           |   1 +
 configs/sipeed_maix_bitm_defconfig            |   2 +-
 configs/sipeed_maix_smode_defconfig           |   2 +-
 configs/smdk5250_defconfig                    |   1 +
 configs/smdk5420_defconfig                    |   1 +
 configs/snow_defconfig                        |   1 +
 configs/spring_defconfig                      |   1 +
 configs/stemmy_defconfig                      |   2 +-
 configs/stm32f429-discovery_defconfig         |   2 +-
 configs/stm32f429-evaluation_defconfig        |   2 +-
 configs/stm32f469-discovery_defconfig         |   2 +-
 configs/stm32h743-disco_defconfig             |   2 +-
 configs/stm32h743-eval_defconfig              |   2 +-
 configs/stm32h750-art-pi_defconfig            |   2 +-
 configs/stm32mp25_defconfig                   |   2 +-
 configs/stmark2_defconfig                     |   2 +-
 configs/ten64_tfa_defconfig                   |   1 +
 configs/th1520_lpi4a_defconfig                |   2 +-
 configs/thunderx_88xx_defconfig               |   2 +-
 configs/tools-only_defconfig                  |  34 +-
 configs/topic_miami_defconfig                 |   2 +-
 configs/topic_miamilite_defconfig             |   2 +-
 configs/topic_miamiplus_defconfig             |   2 +-
 configs/total_compute_defconfig               |   2 +-
 configs/trats2_defconfig                      |   2 +-
 configs/trats_defconfig                       |   2 +-
 configs/turris_mox_defconfig                  |   1 +
 configs/turris_omnia_defconfig                |   1 +
 configs/u200_defconfig                        |   1 +
 configs/vexpress_aemv8a_juno_defconfig        |   1 +
 configs/vexpress_aemv8a_semi_defconfig        |   1 +
 configs/vexpress_aemv8r_defconfig             |   1 +
 configs/vexpress_ca9x4_defconfig              |   1 +
 configs/vexpress_fvp_defconfig                |   1 +
 configs/videostrong-kii-pro_defconfig         |   1 +
 configs/wandboard_defconfig                   |   1 +
 configs/wetek-core2_defconfig                 |   1 +
 configs/wetek-hub_defconfig                   |   1 +
 configs/wetek-play2_defconfig                 |   1 +
 configs/xenguest_arm64_defconfig              |   2 +-
 configs/xenguest_arm64_virtio_defconfig       |   2 +-
 configs/xilinx_versal_mini_defconfig          |   2 +-
 configs/xilinx_versal_mini_emmc0_defconfig    |   2 +-
 configs/xilinx_versal_mini_emmc1_defconfig    |   2 +-
 configs/xilinx_versal_mini_ospi_defconfig     |   2 +-
 configs/xilinx_versal_mini_qspi_defconfig     |   2 +-
 configs/xilinx_versal_net_mini_defconfig      |   2 +-
 configs/xilinx_versal_net_mini_emmc_defconfig |   2 +-
 configs/xilinx_versal_net_mini_ospi_defconfig |   2 +-
 configs/xilinx_versal_net_mini_qspi_defconfig |   2 +-
 configs/xilinx_zynqmp_mini_defconfig          |   2 +-
 configs/xilinx_zynqmp_mini_emmc0_defconfig    |   2 +-
 configs/xilinx_zynqmp_mini_emmc1_defconfig    |   2 +-
 configs/xilinx_zynqmp_mini_nand_defconfig     |   2 +-
 .../xilinx_zynqmp_mini_nand_single_defconfig  |   2 +-
 configs/xilinx_zynqmp_mini_qspi_defconfig     |   2 +-
 configs/zynq_cse_nand_defconfig               |   2 +-
 configs/zynq_cse_nor_defconfig                |   2 +-
 configs/zynq_cse_qspi_defconfig               |   2 +-
 drivers/dfu/Kconfig                           |   2 +
 drivers/fastboot/Kconfig                      |   1 +
 drivers/mtd/altera_qspi.c                     |   4 +-
 drivers/mtd/cfi_flash.c                       |  36 +-
 drivers/net/Kconfig                           |   4 +-
 drivers/net/fec_mxc.c                         |   3 +-
 drivers/net/fm/eth.c                          |   2 +
 drivers/net/phy/Kconfig                       |   3 +-
 drivers/usb/gadget/Kconfig                    |   3 +-
 include/flash.h                               |  20 +-
 include/net-common.h                          | 490 +++++++++
 include/net-legacy.h                          | 560 +++++++++++
 include/net-lwip.h                            |  41 +
 include/net.h                                 | 943 +-----------------
 lib/Makefile                                  |   2 +
 lib/lwip/Makefile                             |  55 +
 lib/lwip/lwip/src/apps/tftp/tftp.c            |  94 +-
 .../lwip/src/include/lwip/apps/tftp_client.h  |   1 +
 lib/lwip/u-boot/arch/cc.h                     |  45 +
 lib/lwip/u-boot/arch/sys_arch.h               |   0
 lib/lwip/u-boot/limits.h                      |   0
 lib/lwip/u-boot/lwipopts.h                    | 157 +++
 lib/tiny-printf.c                             |   3 +-
 net/Kconfig                                   |  81 +-
 net/Makefile                                  |  20 +-
 net/eth-uclass.c                              |  38 +-
 net/lwip/Kconfig                              |  44 +
 net/lwip/Makefile                             |   8 +
 net/lwip/dhcp.c                               | 134 +++
 net/lwip/dns.c                                | 127 +++
 net/lwip/eth_internal.h                       |  35 +
 net/lwip/net-lwip.c                           | 302 ++++++
 net/lwip/ping.c                               | 177 ++++
 net/lwip/tftp.c                               | 286 ++++++
 net/lwip/wget.c                               | 357 +++++++
 net/net-common.c                              |  13 +
 net/net.c                                     |  12 -
 net/wget.c                                    |  11 +-
 test/py/tests/test_efi_loader.py              |  62 +-
 test/py/tests/test_net_boot.py                |   2 +-
 293 files changed, 3704 insertions(+), 1437 deletions(-)
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
 create mode 100644 net/lwip/Kconfig
 create mode 100644 net/lwip/Makefile
 create mode 100644 net/lwip/dhcp.c
 create mode 100644 net/lwip/dns.c
 create mode 100644 net/lwip/eth_internal.h
 create mode 100644 net/lwip/net-lwip.c
 create mode 100644 net/lwip/ping.c
 create mode 100644 net/lwip/tftp.c
 create mode 100644 net/lwip/wget.c
 create mode 100644 net/net-common.c

-- 
2.40.1

