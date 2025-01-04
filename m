Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D686AE77198
	for <u-boot@archiver.kernel.org>; Sat,  4 Jan 2025 03:21:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8636980584;
	Sat,  4 Jan 2025 04:20:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="mREDL7Pe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E4668034E; Sat,  4 Jan 2025 04:19:59 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 137928035E
 for <u-boot@lists.denx.de>; Sat,  4 Jan 2025 04:19:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1735960782; x=1736565582; i=xypron.glpk@gmx.de;
 bh=yQeT9vx1CjN5tmm0z6vvcgpWNwdVqyNNsMQWScna1a8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=mREDL7PeJ79Xjhc+Uat1B8oue7ls28q7UM7V2WVVrmElaeLwY1kQf2Ud7HUN1/bP
 k0sx7mr2jQjT+A8hP9RCrDWQ0nh/WSK++j0TCLlP4wC9RVa0jVi+92PJ/Gm59TZwv
 R5LH3a2nnN16kUy3aqT1CyLi5Cem4xkemHihG9Kp3y3pxPqiDhmWBBYluIscPj4Qz
 /IAxjpC3SFWLIqsdKMoC8aIJx9xWRTx6P/LU55KNSemMF7VQTGTZe7tJ1iOU63Kn9
 a2Jthv8YfduWZOYi29q0e/TUjahfqZCSXejkWSnkfLnis7fZyHOwyS1wavcRQL8BZ
 9d1Kc+p8Axf/oDp+ng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.109.94]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mqs0X-1tq27L2WTx-00neDE; Sat, 04
 Jan 2025 04:19:42 +0100
Message-ID: <5222dd9e-83f6-40ad-adc1-dc3fe1651991@gmx.de>
Date: Sat, 4 Jan 2025 04:19:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lothar Rubusch <l.rubusch@gmail.com>,
 Olivier L'Heureux <olivier.lheureux@mind.be>,
 Yang Gang <yanggang@byosoft.com.cn>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-next-20250104
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2ChUIEFOxEEutDd6rX5vvazI/qsQ0PCpF5+kgiSSXKdLbTDLCLk
 tEEBSJOoMmrcjgMWgUGGe3+ngIeNt8EFSVexOPbQ4sKa1BqYetZFAwiCg8kQmF+1z7xj7Me
 CfLLI62LdMIXNFO1S01QnlyTMTLEdu9kuroPX+84eVQ36ARuof4wuQ/MzsEoRH31L1g1u4f
 onmvNEfXe/b0ZkP09BtRw==
UI-OutboundReport: notjunk:1;M01:P0:+mdcpWAfNHQ=;ysrkG7iHv499L81frCJAV+iZrw1
 9PlcnznQ2Kl45rrkfEiiB8oo6Xkf1w2GgCWCLMWlpwVKNG/7OnQip0fv6gULlNf2YUdTy6nAD
 sdEJJ7LGqW5O/Li8dRpihs1DcF8Mek77iqUjrHVfaJ/mcnEEEsFd437JRx3DdozT9UfNDZASZ
 97MS23D398QYo423wlv22keGrQb8bwjPOoFdc9x0uX39/lMIlDt9zcsrnXORj1uKwZ4acK3LR
 rUDcFfn2TJR/hGfIRvkmotoTqU8CAOjQpQysC9WdYYIzlQW500bRwV/YBxGVbGOu1P2YzKpu7
 LFuMGPeEuOZ+jHH22lJ5M6fYx2DjiRUn2n9wWFoLwwLjQlYsTRMwjbUROmq+KFGQfzPs0HVWG
 +crjYP4q9O1fc3m6hHY5YNF50Z7C3U++soCRwMh3yL4MVTXTXwn6qnHxXyPTR5Sp8Nr3SZVny
 7KqDXTzLCZsmcy51qw+pMB9yV5gST+1G+/4515LUtoAC/vLuEHdiKc8pzEHSRp/BJ29Xj0adE
 AnV6cdCYF0/5B4eO6Li1TIofmvDoA6HY2uW9J4IYJ9eXLdIVchMzIpj+v7eJ/XDw5mE7ItVWI
 8s6LTd2I3e9bOBRzlrrbFvXUgsL+QNmNNJsGWZaPM5MxF7u7V2v4GX2rd1OQBxOmcTL9V4hII
 bFVl0KwFXazmtBFkfSm0WpoF1tnM02PuS8eBrQK8Gm+P+r25QYOmNhkEgCdBnP4qWajnKmv4D
 9qtvXzuye+lKt1kY/mADfRUlSeQCfZXMUQS4Tze1DZ2aSxYFZKu25IscHoqUhGBOlUmLpzGCt
 TxtFt/RqUhiqcJDbb1nuFB5UNwCRAqCvaOFmxml4DeD7+Cth4jpkucwb8pDFK+1majFUNf8e+
 TPgJZT3bmYPxUmB64MlRi+2jiL2MX6AWMXjZdypbfssHfPcsJVd6vswsUexajS120xLaOMj4B
 8daI8Ha9jkF4LAr2ml6KiSY5PTZvGaj4APllE6YSpjSYJISFiGlrmrYtEKDUgJBsUw3AVop5s
 3YJEH9cX3FDESM6kU0BDu/QOhBju8e8dMN2YybM6bHEV63lvoT3AAb/N1PjK65oJWusavauYc
 V+8eycxeL6EfCFW2qhn7urwtdz/VAg
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

The following changes since commit ec9263b4f15c4cf82eb6a211c67baa6385065b8=
e:

   Fix neighbor discovery ethernet address saving (2025-01-01 14:40:04
-0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/efi-next-20250104

for you to fetch changes up to ce190e1b33b8c0e1228f4123759dfa1981c202de:

   efi: Correct ECPT table GUID (2025-01-04 02:17:06 +0100)

Gitlab CI reported no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/24075

=2D---------------------------------------------------------------
Pull request efi-next-20250104

Documentation:

* doc: develop: Fix typos and wording in binman/binman.rst
* doc: develop: Fix typos and wording in gdb.rst
* doc: sandbox: Fix the "sb" command name
* doc/develop/distro.rst: Better document upstream definition of
extlinux.conf

UEFI:

With this pull request the UEFI sub-system detects all boot devices even
if they have not been probed before. If this adds to much boot delay
individual bootmeths and bootdevs can be disabled via the customizing.

* efi_loader: avoid writing message in Exit() boot service
* efi_loader: run bootdev_hunt() to find ESP
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

Heinrich Schuchardt (13):
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
       efi_loader: run bootdev_hunt() to find ESP
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
  lib/efi_loader/efi_setup.c                      |   8 +
  lib/efi_loader/efi_tcg2.c                       |   2 +-
  lib/efi_selftest/efi_selftest_startimage_exit.c |   6 +-
  net/eth_bootdev.c                               |  30 +--
  test/py/tests/test_extension.py                 |   4 +-
  tools/binman/binman.rst                         | 234
++++++++++++------------
  26 files changed, 300 insertions(+), 238 deletions(-)
  delete mode 100644 api/api_platform-arm.c
  delete mode 100644 api/api_platform-mips.c
  create mode 100644 api/api_platform.c

