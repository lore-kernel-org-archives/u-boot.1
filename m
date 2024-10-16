Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEE3D1AD39
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 09:57:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 400D288EDD;
	Wed, 16 Oct 2024 11:57:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="P0e6uNeI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46CB788F3C; Wed, 16 Oct 2024 11:57:13 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49D5C88D1B
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 11:57:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-430576ff251so55314255e9.0
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 02:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729072629; x=1729677429; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hL3UOh2d3jC7uJc1bDbsVIbbRm31lgjNVslE0iFy8BE=;
 b=P0e6uNeIihSMl8sRYNZkGb2Q/l62TnzL2292kRs5AEgI+hqhZiagEuYHOXj0oqr/u8
 MFHygPKEMG7TOJVSfK4Vj2HM2IYoXqRmWlZ+QOCG6RFEhILbXQZrmNjkwhecETtTQ1tt
 dOc1rrpW2tL8cw3hK1cR3jZH4TTE2zWyJBsfbVH/05Hldba6au9QJmgMZjaD3WPsMs61
 CTNVWHo0ydohAQ8EQ13PkTKah+3F1CmEpXDH2H8oalZrBkRzSAr9QCGkjeT2nrTETE5v
 V84ybbwSJhbbsYRO2ddCvjQHYYY8h3OitESurUj1VT1s5u/05LE3cvmvEIKRbR9w328R
 PtlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729072629; x=1729677429;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hL3UOh2d3jC7uJc1bDbsVIbbRm31lgjNVslE0iFy8BE=;
 b=ItsDoBkEka9jceuA3hlTI8HAuICOX+C7vK6aMOIbMi40ORejrEdCO6glajtSf0B8Ix
 fOq5TXJJ843X/F+vZGnIN1PHBjI7i4XsnNJTDTkz3MSBUhPc958ustF3F6aLE4O1xLeW
 rVysrGjQ3vqIxEcmiTzzp/o9/8I/cPYcM+JG3s7HEP90JnExB+HxVu86rc3dWfHHKuJc
 frNSOUsyV8+LvgpBJeQzzgDQzVTasYwws4wbXwoXgzneLzkOh8MlQyhpK1U6v0Q24Auq
 Xkv4P76mznElI8eYAniKVe/ruwR7sd1uBVrh61/acQOuDE6bzBSzkW/+KmuwRG9/1rlY
 cM7A==
X-Gm-Message-State: AOJu0YxaRfrLqCjtekTPxOlMixZAAOEegZcRMIPLrvQzoLnzV8n/+Bmi
 RAvVkHDw8EXDcY4QQI79W7hMd8iZ9plhdJl1zsjHA9hMPUhtiRi/gAmnLcZezSYIEPvCydUm8F2
 i4NVxWA==
X-Google-Smtp-Source: AGHT+IGQnFjGKHhY7EPCAC4Lgt5K7JKhu9cKq56sskk9RRbIQMQLqSBGoEx3GKBIwqmCKxZErmXqiA==
X-Received: by 2002:a05:600c:1d26:b0:42c:a905:9384 with SMTP id
 5b1f17b1804b1-4311deec45cmr141162775e9.20.1729072629093; 
 Wed, 16 Oct 2024 02:57:09 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f6b1ebfsm45236335e9.34.2024.10.16.02.57.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 02:57:08 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH v13 00/21] Introduce the lwIP network stack
Date: Wed, 16 Oct 2024 11:56:22 +0200
Message-Id: <cover.1729070678.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

 $ git subtree add --squash --prefix lib/lwip/lwip \
   https://github.com/lwip-tcpip/lwip.git  STABLE-2_2_0_RELEASE 

Notes

1. A number of features are currently incompatible with NET_LWIP:
DFU_TFTP, FASTBOOT, SPL_NET, ETH_SANDBOX, ETH_SANDBOX_RAW, DM_ETH. They
all make assumptions on how the network stack is implemented and/or
pull sybols that are not trivially exported from lwIP. Some interface
rework may be needed.

2. Due to the above, and in order to provide some level of testing of the
lwIP code in CI even when the legacy NET is the default, a new QEMU
configuration is introduced (qemu_arm64_lwip_defconfig) which is
based on qemu_arm64_defconfig with NET_LWIP and CMD_*_LWIP enabled.
In addition to that, this series has some [TESTING] patches
which make NET_LWIP the default.

[1] https://lore.kernel.org/all/20231127125726.3735-1-maxim.uvarov@linaro.org/
[2] https://www.nongnu.org/lwip/
[3] https://en.wikipedia.org/wiki/LwIP

Changes in v13:

- Rebased onto master
- "net: lwip: tftp: add support of blksize option to client":
update computation of blksize_length (Ilias A.)

Changes in v12:

- Rebase onto master
- Combine "net: split include/net.h into net{, -common, -legacy, -lwip}.h"
and "net: move copy_filename() to new file net/net-common.c" (Ilias A.)
- Fold "net-lwip: lwIP wget supports user defined port in the uri, so
allow it." into parent patch "net-lwip: add wget command"
- CI: update .gitlab-ci.yml too (Tom R.)
- Fold "configs: replace '# CONFIG_NET is not set' with CONFIG_NO_NET=y"
into "net: introduce alternative implementation as net-lwip/"
- bootflow_cmd_label test: use 'if CONFIG_IS_ENABLED(DSA_SANDBOX)'
- Drop the "[TESTING]" patches:
  * "[TESTING] Kconfig: enable NET_LWIP by default"
  * "[TESTING] configs: set CONFIG_NET=y for FTGMAC100"
- Drop the patches sent separately:
  * "net: recv(): return -EAGAIN instead of 0 when no cleanup is expected"
  * "Make AVB_VERIFY depend on FASTBOOT"
  * "linker_lists: set LINKER_LIST_ALIGN to 8 if 64BIT"
- Fix "configs: use syntax CONFIG_FOO=n in tools-only_defconfig":
'CONFIG_NET=n' was inadvertently forgotten.
- Fix "net: introduce alternative implementation as net-lwip/": set
CONFIG_NO_NET=y in tools-only_defconfig.
- Add the "git subtree add" command to the patch description in
"net-lwip: build lwIP".
- All patches: use "net: lwip:" as a subsystem prefix rather than
"net-lwip:".
- Apply review tags

Changes in v11:

- Rebased onto next
- "Miscellaneous fixes" removed (patches were merged in next). The
series still begins with small fixes posted separately [1] [2] [3].
- Add (some) support for CMD_PXE and therefore drop patch "[TESTING]
configs: set CONFIG_NET=y when PXE is enabled". This is build-tested
only and it is very likely that some work is needed to make it useful.
For example, adding the code for DHCP option 209 to lwIP so that
BOOTP_PXE_DHCP_OPTION can be supported.
- SANDBOX is now supported, but with the dm eth and wget tests
disabled.
- Move eth_set_enable_bootdevs() declaration to net-common.h
Fixes warning with snow_defconfig:
test/test-main.c:310:17: warning: implicit declaration of function ‘eth_set_enable_bootdevs’ [....]
- Do eth_init() and eth_init_rings() only once, and do not forget
lwip_init()! Fixes TFTP stalls on TI K3 (reported by Tom R. and
tested by Ilias A.)
- Set MEM_ALIGNMENT to 8 in lib/lwip/u-boot/lwipopts.h. Fixes TFTP
random crashes on TI K3 (Ilias A.)
- net_lwip_rx(): call free_pkt() even when recv() has returned 0,
as required by the driver model documentation (and imx8mp_evk). Fixes
a regression introduced in v9. Goes together with patch [2].
- Add "lwip: tftp: bind to TFTP port only when in server mode" to
fix an issue with interrupted tftp commands (the tftp command hangs
if it is interrupted with Ctrl-C and started again).
- TFTP: fix uninitialized "ret" variable in do_tftpb(); print "Abort"
on Ctrl-C.
- MAINTAINERS: remove README and add sandbox ethernet driver to the
list of maintained files.
- AFAICT, CI should be all good except qemu_xtensa_dc233c which is
broken when NET_LWIP=y (QEMU just hangs with no output). I could
not find or build a suitable GDB binary to debug that.

[1] https://patchwork.ozlabs.org/project/uboot/patch/20241002144845.1439316-1-jerome.forissier@linaro.org/
[2] https://patchwork.ozlabs.org/project/uboot/patch/20240927142038.879037-1-jerome.forissier@linaro.org/ 
[3] https://patchwork.ozlabs.org/project/uboot/patch/20241003142030.1610222-1-jerome.forissier@linaro.org/

Changes in v10:

- Rebase onto next
- URL for lwIP changed in cover letter: using GitHub now since all
tags have suddenly disappeared from the repository on gnu.org.
- Post fixes as a separate series [1] or individual patches [2] [3]
- Add "if NET_LWIP" to net/lwip/Kconfig to fix a kconfig warning
  when doing the full branch build with buildman ("[NEW]")
- net/ is added to libs-y only when NET or NET_LWIP, not NO_NET
- Apply review tags

[1] http://patchwork.ozlabs.org/project/uboot/list/?series=422079
https://lists.denx.de/pipermail/u-boot/2024-September/563904.html
[2] http://patchwork.ozlabs.org/project/uboot/list/?series=421962
[3] http://patchwork.ozlabs.org/project/uboot/list/?series=421959
 
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

Jerome Forissier (21):
  configs: use syntax CONFIG_FOO=n in tools-only_defconfig
  sandbox: add dummy driver ETH_SANDBOX_LWIP
  test: boot: fix bootdev_test_any for when DSA_SANDBOX is disabled
  test: boot: fix bootflow_cmd_label for when DSA_SANDBOX is disabled
  net: introduce alternative implementation as net/lwip/
  net: split net into net{,-common,-legacy,-lwip}
  net: eth-uclass: add function eth_start_udev()
  net: lwip: build lwIP
  net: lwip: add DHCP support and dhcp commmand
  net: lwip: tftp: bind to TFTP port only when in server mode
  net: lwip: add TFTP support and tftpboot command
  net: lwip: add ping command
  net: lwip: add dns command
  net: split cmd/net.c into cmd/net.c and cmd/net-common.c
  net: lwip: add wget command
  cmd: bdinfo: enable -e when CONFIG_CMD_NET_LWIP=y
  configs: add qemu_arm64_lwip_defconfig
  net: lwip: tftp: add support of blksize option to client
  net: lwip: add TFTP_BLOCKSIZE
  CI: add qemu_arm64_lwip to the test matrix
  MAINTAINERS: net: lwip: add myself as a maintainer

 .azure-pipelines.yml                          |   7 +
 .gitlab-ci.yml                                |   9 +
 Kconfig                                       |  29 +
 MAINTAINERS                                   |  11 +
 Makefile                                      |   6 +-
 board/engicam/imx8mp/icore_mx8mp.c            |   2 +-
 .../imx8mp_debix_model_a.c                    |   2 +-
 board/ti/am335x/board.c                       |   3 +-
 board/xilinx/common/board.c                   |   3 +-
 boot/Kconfig                                  |   4 +-
 cmd/Kconfig                                   | 140 +--
 cmd/Makefile                                  |   9 +-
 cmd/bdinfo.c                                  |   5 +-
 cmd/elf.c                                     |   2 +-
 cmd/net-common.c                              | 109 ++
 cmd/net-lwip.c                                |  45 +
 cmd/net.c                                     | 115 ---
 common/Kconfig                                |   2 +-
 common/board_r.c                              |   4 +-
 common/spl/Kconfig                            |   1 +
 common/usb_kbd.c                              |   2 +-
 configs/LicheePi_Zero_defconfig               |   2 +-
 configs/M5249EVB_defconfig                    |   2 +-
 configs/am335x_pdu001_defconfig               |   2 +-
 configs/am62ax_evm_r5_defconfig               |   2 +-
 configs/am62px_evm_r5_defconfig               |   2 +-
 configs/am62x_beagleplay_r5_defconfig         |   2 +-
 configs/amcore_defconfig                      |   2 +-
 configs/amd_versal2_mini_defconfig            |   2 +-
 configs/amd_versal2_mini_emmc_defconfig       |   2 +-
 configs/amd_versal2_mini_ospi_defconfig       |   2 +-
 configs/amd_versal2_mini_qspi_defconfig       |   2 +-
 configs/anbernic-rgxx3-rk3566_defconfig       |   2 +-
 configs/ap143_defconfig                       |   2 +-
 configs/ap152_defconfig                       |   2 +-
 configs/apple_m1_defconfig                    |   2 +-
 configs/astro_mcf5373l_defconfig              |   2 +-
 configs/at91sam9rlek_dataflash_defconfig      |   2 +-
 configs/at91sam9rlek_mmc_defconfig            |   2 +-
 configs/at91sam9rlek_nandflash_defconfig      |   2 +-
 configs/bcm7260_defconfig                     |   2 +-
 configs/bcm7445_defconfig                     |   2 +-
 configs/bcm968380gerg_ram_defconfig           |   2 +-
 configs/bcmns_defconfig                       |   2 +-
 configs/chromebook_samus_tpl_defconfig        |   2 +-
 configs/cortina_presidio-asic-base_defconfig  |   2 +-
 configs/cortina_presidio-asic-pnand_defconfig |   2 +-
 configs/durian_defconfig                      |   2 +-
 configs/e850-96_defconfig                     |   2 +-
 configs/ea-lpc3250devkitv2_defconfig          |   2 +-
 configs/efi-x86_app32_defconfig               |   2 +-
 configs/efi-x86_app64_defconfig               |   2 +-
 configs/emsdp_defconfig                       |   2 +-
 configs/evb-px5_defconfig                     |   2 +-
 configs/generic-rk3568_defconfig              |   2 +-
 configs/generic-rk3588_defconfig              |   2 +-
 configs/hc2910_2aghd05_defconfig              |   2 +-
 configs/igep00x0_defconfig                    |   2 +-
 configs/imx6q_bosch_acc_defconfig             |   2 +-
 configs/imx6ulz_smm_m2_defconfig              |   2 +-
 configs/iot_devkit_defconfig                  |   2 +-
 configs/j722s_evm_r5_defconfig                |   2 +-
 configs/legoev3_defconfig                     |   2 +-
 configs/mk808_defconfig                       |   2 +-
 configs/mx23evk_defconfig                     |   2 +-
 configs/mx28evk_defconfig                     |   2 +-
 configs/mx6memcal_defconfig                   |   2 +-
 configs/mx6ulz_14x14_evk_defconfig            |   2 +-
 configs/mx7ulp_com_defconfig                  |   2 +-
 configs/mx7ulp_evk_defconfig                  |   2 +-
 configs/mx7ulp_evk_plugin_defconfig           |   2 +-
 configs/netgear_cg3100d_ram_defconfig         |   2 +-
 configs/nsim_700_defconfig                    |   2 +-
 configs/nsim_700be_defconfig                  |   2 +-
 configs/nsim_hs38be_defconfig                 |   2 +-
 configs/openpiton_riscv64_defconfig           |   2 +-
 configs/openpiton_riscv64_spl_defconfig       |   2 +-
 configs/origen_defconfig                      |   2 +-
 configs/pe2201_defconfig                      |   2 +-
 configs/pinecube_defconfig                    |   2 +-
 configs/pm9261_defconfig                      |   2 +-
 configs/qemu_arm64_lwip_defconfig             |   9 +
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
 configs/sipeed_maix_bitm_defconfig            |   2 +-
 configs/sipeed_maix_smode_defconfig           |   2 +-
 configs/stemmy_defconfig                      |   2 +-
 configs/stm32f429-discovery_defconfig         |   2 +-
 configs/stm32f429-evaluation_defconfig        |   2 +-
 configs/stm32f469-discovery_defconfig         |   2 +-
 configs/stm32h743-disco_defconfig             |   2 +-
 configs/stm32h743-eval_defconfig              |   2 +-
 configs/stm32h750-art-pi_defconfig            |   2 +-
 configs/stm32mp25_defconfig                   |   2 +-
 configs/stmark2_defconfig                     |   2 +-
 configs/th1520_lpi4a_defconfig                |   2 +-
 configs/thunderx_88xx_defconfig               |   2 +-
 configs/tools-only_defconfig                  |  40 +-
 configs/topic_miami_defconfig                 |   2 +-
 configs/topic_miamilite_defconfig             |   2 +-
 configs/topic_miamiplus_defconfig             |   2 +-
 configs/total_compute_defconfig               |   2 +-
 configs/trats2_defconfig                      |   2 +-
 configs/trats_defconfig                       |   2 +-
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
 drivers/dfu/Kconfig                           |   1 +
 drivers/fastboot/Kconfig                      |   1 +
 drivers/net/Kconfig                           |  16 +-
 drivers/net/Makefile                          |   1 +
 drivers/net/phy/Kconfig                       |   2 +-
 drivers/net/sandbox-lwip.c                    |  85 ++
 drivers/usb/gadget/Kconfig                    |   2 +-
 include/net-common.h                          | 509 ++++++++++
 include/net-legacy.h                          | 541 ++++++++++
 include/net-lwip.h                            |  41 +
 include/net.h                                 | 943 +-----------------
 lib/Makefile                                  |   2 +
 lib/binman.c                                  |   1 +
 lib/lwip/Makefile                             |  55 +
 lib/lwip/lwip/src/apps/tftp/tftp.c            | 102 +-
 .../lwip/src/include/lwip/apps/tftp_client.h  |   1 +
 lib/lwip/u-boot/arch/cc.h                     |  45 +
 lib/lwip/u-boot/arch/sys_arch.h               |   0
 lib/lwip/u-boot/limits.h                      |   0
 lib/lwip/u-boot/lwipopts.h                    | 157 +++
 lib/tiny-printf.c                             |   3 +-
 net/Kconfig                                   |  81 +-
 net/Makefile                                  |  20 +-
 net/eth-uclass.c                              |  38 +-
 net/lwip/Kconfig                              |  49 +
 net/lwip/Makefile                             |   8 +
 net/lwip/dhcp.c                               | 139 +++
 net/lwip/dns.c                                | 127 +++
 net/lwip/eth_internal.h                       |  35 +
 net/lwip/net-lwip.c                           | 305 ++++++
 net/lwip/ping.c                               | 177 ++++
 net/lwip/tftp.c                               | 290 ++++++
 net/lwip/wget.c                               | 357 +++++++
 net/net-common.c                              |  13 +
 net/net.c                                     |  12 -
 test/boot/bootdev.c                           |  11 +-
 test/boot/bootflow.c                          |  12 +-
 test/cmd/Makefile                             |   2 +
 test/dm/Makefile                              |   2 +
 171 files changed, 3624 insertions(+), 1339 deletions(-)
 create mode 100644 cmd/net-common.c
 create mode 100644 cmd/net-lwip.c
 create mode 100644 configs/qemu_arm64_lwip_defconfig
 create mode 100644 drivers/net/sandbox-lwip.c
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

