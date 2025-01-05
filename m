Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A1F9E77188
	for <u-boot@archiver.kernel.org>; Sun,  5 Jan 2025 02:57:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0E338036D;
	Sun,  5 Jan 2025 03:57:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Ce6V6cfP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 393D6803DC; Sun,  5 Jan 2025 03:57:54 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40D3A801DE
 for <u-boot@lists.denx.de>; Sun,  5 Jan 2025 03:57:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1736045848; x=1736650648; i=xypron.glpk@gmx.de;
 bh=rU2L3i5vCWXnB37tLVjvvcIg5o+dvfTnEk1tW6yvn4Q=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Ce6V6cfPxSa+EvZag1waKI4atOddSy+A23xbXsSa9XAK5RBvDKMzAYFKbw2DgZ+4
 2vbya+PaPfyU0rZvBZnRqRj5AXuTyhMa81UCTgZNfj1JzxnXSBCxEpQL4cHEKnirL
 1dyARO6q4LsdH7xgH1SwYFAv0FBmBQEIHtNgu9qPUNl6PQoJs3SGHA0fNZxUh2D3l
 VoaxP8x/EjFKxRxPe8FWljPvnW8Qc/lu9BONU+yIhDCwcRL/9Fho2YOwcQ5N9m5m0
 41jfa6dAA/thhiomwEGINw/nOoln0u7iY5fVziA5z7Ee4NUFpYBD5jZ43k9nceYZJ
 UDooBW4ozsXvwVaHSw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.106.210]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MS3il-1t1r1P0SKZ-00UL9y; Sun, 05
 Jan 2025 03:57:28 +0100
Message-ID: <6c11a4a5-8a38-4665-bd04-3e20a662d714@gmx.de>
Date: Sun, 5 Jan 2025 03:57:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aleksandar Gerasimovski <Aleksandar.Gerasimovski@belden.com>,
 Lothar Rubusch <l.rubusch@gmail.com>, Simon Glass <sjg@chromium.org>,
 Olivier L'Heureux <olivier.lheureux@mind.be>,
 Yang Gang <yanggang@byosoft.com.cn>, Jonas Karlman <jonas@kwiboo.se>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-next-20250105
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w1fZLq+1obW02ToMuiRzl+DM5+fZqYDfsOpk26BIqle25AFzMt0
 dEp1qbxvtJ88YcqRzAXt9sBZRE8qKaqqrcnymv+iWGNQnqP/GE5cqHil5l7XA9E425JISLB
 3H9XlneWTjLfWopiEsuDXCdMQJywykBx1B9K4Ts+05C0Q3kK7r6NfsFA8g1C4KqPHQtMVFM
 0slUvI0quNk4wHxkUxUXQ==
UI-OutboundReport: notjunk:1;M01:P0:yRb1GOGdbTk=;EKqjQQuOoYM+Su6VKXczat2HQB0
 2rG7dklnljnXNUMDt+5SwvzqFzRkLnB0EAR3RF0u9f8IfRu+yfI3x9VDS4VmEXSriUeHbll2H
 DvWg5/1S7r7CYZO+S7J2u4bdmpFYpCqPk8KqXONFd1M0fDJMdPMXeRq6FWGkaDxheTPeMwAi4
 Xr3lQACjLGrPWl4l5O1sNHAo+uGzVZcyQbPz1vPEkjdqt8xxu7mYRi80GJ7MRJ2//PD1w8Sk4
 M8zgw4Ittnryfv43XO5isXAURd7XrIKo70WfY5oHqjHrB9Qf+qfXsqNdt+iuTVYIVu2V8qzJn
 B87T7N6qB37tfoLEcYc+AlWFlWRq4LRtqFe1oFYhzKjYlJsrkgI+/EHfW6Pd55odddUfgqgPc
 oV2F25c7kcNRXFAHI6ZhQAE0y/P54ctQR/K/Fycb8rzWfEkYbt8BdXo3uYL1K/X0LAGRw5pA6
 rcXTbqb7LapUjGRY6SSB9CoQkoaF/T2eQ/31i36UKYVOQcdrcNzIuZD4wswli1D4N8pihwbD+
 u2QNSLnBWyfbCHSjwHzqenjPLu0WvAcY1PuvslrDjHtB0D43h88R6Dn0sifeH6VGdIEdHzkg9
 cPSusxoCeqTTAHsntO0GR7RLRb98cvrgOcz8+KzS/hnow2/mtmWoX3dbX4IOIBZvLWr6aDvRP
 IDmLfP64c27QalHjQ/32FvAl/z/ueoKWbLm6ZJTGAQNlxCfKHTjbG11+pJjAI8LgG/hPQvUmW
 d8OITQQT6Gqi81H1aQOCAzNBanZPmSuJ1OESPd/ncr8aDDnIBlpLuHsrvhxHduP9PBTWKyNoy
 MBSte6gCCU7pkisPZO5MewxcurmkfWuxBcfrJdZVwoLoKjqxBWq1OlfZ4BtmZMMoBtLzV9LQM
 2qVAJFnMLhR2AluxVbjpT6SwWGsNkCtbS4SLqIbsGXWGeYl+VwtVSBGbRcHCbgH4+d9gCeMcM
 1+QDQTJusZL11cYbbQN4CyyQI0sKKgvtRRFiUUTlQdm92s5824JhI9oLhztEnc8xS+o7cD/Qg
 6hczJaR8E29jqhiwB/0xjd3eYdiKj3JrzehzcY/4q9FhpMZ5F8GNJxk6o6JSmMykeQ2i3j4GZ
 SMQgU4UctrwP4DTe95xph8ALrax1lz
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

Dear Tom,

I have removed the objected patch
"efi_loader: run bootdev_hunt() to find ESP"

The following changes since commit ec9263b4f15c4cf82eb6a211c67baa6385065b8=
e:

   Fix neighbor discovery ethernet address saving (2025-01-01 14:40:04
-0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/efi-next-20250105

for you to fetch changes up to 9c6c7e30aa006a3eab52302e5399f5eb592184ed:

   efi: Correct ECPT table GUID (2025-01-05 02:30:49 +0100)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/24077

=2D---------------------------------------------------------------
Pull request efi-next-20250105

Documentation:

* doc: develop: Fix typos and wording in binman/binman.rst
* doc: develop: Fix typos and wording in gdb.rst
* doc: sandbox: Fix the "sb" command name
* doc/develop/distro.rst: Better document upstream definition of
extlinux.conf

UEFI:

* efi_loader: avoid writing message in Exit() boot service
* efi_loader: update EFI specification version
* cmd: efidebug: update output of memory attributes
* efi_loader: Don't warn if the TCG2 FinalEvents table is not installed
* cmd: bootmenu: add parameter -e for UEFI boot options
* efi_loader: Update startimage_exit self-test to check error
* efi: Correct ECPT table GUID

Others:

Building the API demo application for riscv64 is supported.

* API: unify platform_sys_info() implementations
* examples: implement _start and syscall for RISC-V
* examples: use architecture specific memset() on RISC-V
* examples: use QEMU compatible LOAD_ADDR on RISC-V
* test: fix test_extension.py
* configs: sandbox_deconfig: remove CONFIG_AMIGA_PARTITION
* CI: xilinx_versal_virt: disable USB_DWC3
* net: eth_bootdev_hunt() should not run DHCP

=2D---------------------------------------------------------------
Adriano Cordova (1):
       efi_loader: Expose efi_reinstall_protocol_interface in efi_loader.h

Aleksandar Gerasimovski (1):
       efi_loader: fix pe reloc pointer overrun

Heinrich Schuchardt (12):
       API: unify platform_sys_info() implementations
       examples: implement _start and syscall for RISC-V
       examples: use architecture specific memset() on RISC-V
       examples: use QEMU compatible LOAD_ADDR on RISC-V
       efi_loader: avoid writing message in Exit() boot service
       test: fix test_extension.py
       configs: sandbox_deconfig: remove CONFIG_AMIGA_PARTITION
       CI: xilinx_versal_virt: disable USB_DWC3
       net: eth_bootdev_hunt() should not run DHCP
       cmd: bootmenu: add parameter -e for UEFI boot options
       efi_loader: update EFI specification version
       cmd: efidebug: update output of memory attributes

Ilias Apalodimas (1):
       efi_loader: Don't warn if the TCG2 FinalEvents table is not install=
ed

Lothar Rubusch (2):
       doc: develop: Fix typos and wording in binman/binman.rst
       doc: develop: Fix typos and wording in gdb.rst

Olivier L'Heureux (1):
       doc: sandbox: Fix the "sb" command name

Simon Glass (1):
       efi_loader: Update startimage_exit self-test to check error

Tom Rini (1):
       doc/develop/distro.rst: Better document upstream definition of
extlinux.conf

Yang Gang (1):
       efi: Correct ECPT table GUID

  .azure-pipelines.yml                            |   1 +
  .gitlab-ci.yml                                  |   1 +
  api/Makefile                                    |   9 +-
  api/api_platform-arm.c                          |  35 ----
  api/api_platform-mips.c                         |  29 ---
  api/api_platform.c                              |  25 +++
  cmd/bootmenu.c                                  |  39 +++-
  cmd/efidebug.c                                  |   5 +-
  configs/sandbox_defconfig                       |   1 -
  doc/develop/distro.rst                          |  15 +-
  doc/develop/gdb.rst                             |  10 +-
  doc/usage/cmd/bootmenu.rst                      |  13 +-
  doc/usage/cmd/sb.rst                            |   6 +-
  examples/api/Makefile                           |   7 +-
  examples/api/crt0.S                             |  32 ++++
  include/efi.h                                   |   2 +
  include/efi_api.h                               |   8 +-
  include/efi_loader.h                            |   5 +
  lib/efi_loader/efi_boottime.c                   |   9 +-
  lib/efi_loader/efi_image_loader.c               |   2 +-
  lib/efi_loader/efi_tcg2.c                       |   2 +-
  lib/efi_selftest/efi_selftest_startimage_exit.c |   6 +-
  net/eth_bootdev.c                               |  30 +--
  test/py/tests/test_extension.py                 |   4 +-
  tools/binman/binman.rst                         | 234
++++++++++++------------
  25 files changed, 292 insertions(+), 238 deletions(-)
  delete mode 100644 api/api_platform-arm.c
  delete mode 100644 api/api_platform-mips.c
  create mode 100644 api/api_platform.c

