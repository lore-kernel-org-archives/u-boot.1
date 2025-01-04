Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25086E77188
	for <u-boot@archiver.kernel.org>; Sat,  4 Jan 2025 11:49:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E2D88036D;
	Sat,  4 Jan 2025 12:49:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="zPC2Q72x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29D06803DC; Sat,  4 Jan 2025 12:49:52 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D16680107
 for <u-boot@lists.denx.de>; Sat,  4 Jan 2025 12:49:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4402=T4=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1735991388;
 bh=l9lZ1aoBPBHwuDuLSBfFArxTJORMM4v/GxcXskBFnZ8=;
 b=zPC2Q72xbtQ8+oSJ6mRWW+5JtWBdcuGq3zJ4eQy8OWnzcu3j1IYa3xvZVj/dk1TdCzBHomGP2
 L1KXupxvRpQDfdGWnqyfWLBqCrM82Vgk7zMI2IubtkP8xw015UgDl+EZPcgHnaO3MKCdVEpNCdN
 6sz5QBtdUnu5HY9LZsBdvfPCgmUDsjNsy73NJz316q8QP+OSH92ROu3enTBD682W1bvzzo6OG9W
 B7oA2MKlK0w2DXuA1Xlgk+RaMCyzvLxemct5SoO1leZ8JOGIHC8742P8t3g+5F5vPiJIhRazbNY
 QZEU2lOOYvTbjQISJJrriu2xZzc5CSfA1f5BRMu5d7DQ==
X-ForwardEmail-Version: 0.4.40
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Received: from [192.168.2.234] ([78.69.151.207]
 78-69-151-207-no600.tbcn.telia.com) by smtp.forwardemail.net (Forward
 Email) with ESMTPSA (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384); Sat,
 04 Jan 2025 11:49:38 +0000
Message-ID: <a84b7af4-0e78-4a07-ba5c-590891bc50ca@kwiboo.se>
Date: Sat, 4 Jan 2025 12:49:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Pull request efi-next-20250104
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lothar Rubusch <l.rubusch@gmail.com>,
 Olivier L'Heureux <olivier.lheureux@mind.be>,
 Yang Gang <yanggang@byosoft.com.cn>
References: <5222dd9e-83f6-40ad-adc1-dc3fe1651991@gmx.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <5222dd9e-83f6-40ad-adc1-dc3fe1651991@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 677920561e1e19a204b7dc06
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

Hi Heinrich,

On 2025-01-04 04:19, Heinrich Schuchardt wrote:
> Dear Tom,
> 
> The following changes since commit ec9263b4f15c4cf82eb6a211c67baa6385065b8e:
> 
>    Fix neighbor discovery ethernet address saving (2025-01-01 14:40:04
> -0600)
> 
> are available in the Git repository at:
> 
>    https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-next-20250104
> 
> for you to fetch changes up to ce190e1b33b8c0e1228f4123759dfa1981c202de:
> 
>    efi: Correct ECPT table GUID (2025-01-04 02:17:06 +0100)
> 
> Gitlab CI reported no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/24075
> 
> ----------------------------------------------------------------
> Pull request efi-next-20250104
> 
> Documentation:
> 
> * doc: develop: Fix typos and wording in binman/binman.rst
> * doc: develop: Fix typos and wording in gdb.rst
> * doc: sandbox: Fix the "sb" command name
> * doc/develop/distro.rst: Better document upstream definition of
> extlinux.conf
> 
> UEFI:
> 
> With this pull request the UEFI sub-system detects all boot devices even
> if they have not been probed before. If this adds to much boot delay
> individual bootmeths and bootdevs can be disabled via the customizing.
> 
> * efi_loader: avoid writing message in Exit() boot service
> * efi_loader: run bootdev_hunt() to find ESP

This patch still completely changes how standard boot operates, from
lazy probing boot devices from fastest to slowest (probe time) as
described in the standard boot documentation [1], to probing all boot
devices all at once before checking for a bootmeth/bootflow.

This slows down script and extlinux booing on my Rockchip board by
several seconds because now pcie and usb is probed before current fast
bootflow from mmc devices is tested.

Will you work on a fix for this or do you recommend disabling the
efi_mgr bootmeth or similar? E.g. something like the diff below.

Similarly if I understand correctly the priority of efi_mgr bootmeth,
first regardless of configured bootmeth order, is the main blocker for
sunxi to fully move to standard boot.

diff --git a/boot/Kconfig b/boot/Kconfig
index 20935a269c60..81e10be4eef8 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -617,7 +617,7 @@ config BOOTMETH_EFI_BOOTMGR
 	bool "Bootdev support for EFI boot manager"
 	depends on EFI_BOOTMGR
 	select BOOTMETH_GLOBAL
-	default y
+	default y if !ARCH_ROCKCHIP
 	help
 	  Enable booting via the UEFI boot manager. Based on the EFI variables
 	  the EFI binary to be launched is determined. To set the EFI variables

[1] https://docs.u-boot.org/en/latest/develop/bootstd/overview.html#boot-process

Regards,
Jonas

> * efi_loader: update EFI specification version
> * cmd: efidebug: update output of memory attributes
> * efi_loader: Don't warn if the TCG2 FinalEvents table is not installed
> * cmd: bootmenu: add parameter -e for UEFI boot options
> * efi_loader: Update startimage_exit self-test to check error
> * efi: Correct ECPT table GUID
> 
> Others:
> 
> Building the API demo application for riscv64 is supported.
> 
> * API: unify platform_sys_info() implementations
> * examples: implement _start and syscall for RISC-V
> * examples: use architecture specific memset() on RISC-V
> * examples: use QEMU compatible LOAD_ADDR on RISC-V
> * test: fix test_extension.py
> * configs: sandbox_deconfig: remove CONFIG_AMIGA_PARTITION
> * CI: xilinx_versal_virt: disable USB_DWC3
> * net: eth_bootdev_hunt() should not run DHCP
> 
> ----------------------------------------------------------------
> Adriano Cordova (1):
>        efi_loader: Expose efi_reinstall_protocol_interface in efi_loader.h
> 
> Aleksandar Gerasimovski (1):
>        efi_loader: fix pe reloc pointer overrun
> 
> Heinrich Schuchardt (13):
>        API: unify platform_sys_info() implementations
>        examples: implement _start and syscall for RISC-V
>        examples: use architecture specific memset() on RISC-V
>        examples: use QEMU compatible LOAD_ADDR on RISC-V
>        efi_loader: avoid writing message in Exit() boot service
>        test: fix test_extension.py
>        configs: sandbox_deconfig: remove CONFIG_AMIGA_PARTITION
>        CI: xilinx_versal_virt: disable USB_DWC3
>        net: eth_bootdev_hunt() should not run DHCP
>        cmd: bootmenu: add parameter -e for UEFI boot options
>        efi_loader: run bootdev_hunt() to find ESP
>        efi_loader: update EFI specification version
>        cmd: efidebug: update output of memory attributes
> 
> Ilias Apalodimas (1):
>        efi_loader: Don't warn if the TCG2 FinalEvents table is not installed
> 
> Lothar Rubusch (2):
>        doc: develop: Fix typos and wording in binman/binman.rst
>        doc: develop: Fix typos and wording in gdb.rst
> 
> Olivier L'Heureux (1):
>        doc: sandbox: Fix the "sb" command name
> 
> Simon Glass (1):
>        efi_loader: Update startimage_exit self-test to check error
> 
> Tom Rini (1):
>        doc/develop/distro.rst: Better document upstream definition of
> extlinux.conf
> 
> Yang Gang (1):
>        efi: Correct ECPT table GUID
> 
>   .azure-pipelines.yml                            |   1 +
>   .gitlab-ci.yml                                  |   1 +
>   api/Makefile                                    |   9 +-
>   api/api_platform-arm.c                          |  35 ----
>   api/api_platform-mips.c                         |  29 ---
>   api/api_platform.c                              |  25 +++
>   cmd/bootmenu.c                                  |  39 +++-
>   cmd/efidebug.c                                  |   5 +-
>   configs/sandbox_defconfig                       |   1 -
>   doc/develop/distro.rst                          |  15 +-
>   doc/develop/gdb.rst                             |  10 +-
>   doc/usage/cmd/bootmenu.rst                      |  13 +-
>   doc/usage/cmd/sb.rst                            |   6 +-
>   examples/api/Makefile                           |   7 +-
>   examples/api/crt0.S                             |  32 ++++
>   include/efi.h                                   |   2 +
>   include/efi_api.h                               |   8 +-
>   include/efi_loader.h                            |   5 +
>   lib/efi_loader/efi_boottime.c                   |   9 +-
>   lib/efi_loader/efi_image_loader.c               |   2 +-
>   lib/efi_loader/efi_setup.c                      |   8 +
>   lib/efi_loader/efi_tcg2.c                       |   2 +-
>   lib/efi_selftest/efi_selftest_startimage_exit.c |   6 +-
>   net/eth_bootdev.c                               |  30 +--
>   test/py/tests/test_extension.py                 |   4 +-
>   tools/binman/binman.rst                         | 234
> ++++++++++++------------
>   26 files changed, 300 insertions(+), 238 deletions(-)
>   delete mode 100644 api/api_platform-arm.c
>   delete mode 100644 api/api_platform-mips.c
>   create mode 100644 api/api_platform.c
> 

