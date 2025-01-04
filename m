Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B0FE77188
	for <u-boot@archiver.kernel.org>; Sat,  4 Jan 2025 12:08:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA39A8036D;
	Sat,  4 Jan 2025 13:08:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="oR20kjda";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDDB3803DC; Sat,  4 Jan 2025 13:08:13 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52A3980107
 for <u-boot@lists.denx.de>; Sat,  4 Jan 2025 13:08:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1735992490; x=1736597290; i=xypron.glpk@gmx.de;
 bh=e2yeKOT1PfaPUrDx5aO7oXjqrbw1EsgA8JJ+kpV6zFU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=oR20kjdaGY9rX9zuU2jBwE+JB+xutzcqEAY6lqc4Mpi1yf7ydYduJbNDVepPJOTe
 4BybvqXGQmULxRTTMBQXwVXwEsikl01tasPJvhwZxpMWXChF/2p8JrMpW/3iCyw1w
 hFPK2DXP9L38AUP2msugtXoMm81bwQKtt1V1lkxvkbGD1fPKaB1MkXrQPZTuhdkWk
 qHZ8/wYI6g/z8Xmst/gTgxxbEnj3ole2WK9+Hpc0ARzVkEDmx2vay9TNk2OpahOdC
 GfjFzJX4/7kckZYJXtrvoAWCusUIIR97HX8ZLuJhCJJa/XI5H3bWXxYnemPrCJFzF
 GBQGXJcb5tgO4diYyg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.106.210]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MryTF-1tqzEN2knl-00mXno; Sat, 04
 Jan 2025 13:08:10 +0100
Message-ID: <947b4423-b1fb-4a65-ae5e-f71fb8a50255@gmx.de>
Date: Sat, 4 Jan 2025 13:08:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Pull request efi-next-20250104
To: Jonas Karlman <jonas@kwiboo.se>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lothar Rubusch <l.rubusch@gmail.com>,
 Olivier L'Heureux <olivier.lheureux@mind.be>,
 Yang Gang <yanggang@byosoft.com.cn>, Tom Rini <trini@konsulko.com>
References: <5222dd9e-83f6-40ad-adc1-dc3fe1651991@gmx.de>
 <a84b7af4-0e78-4a07-ba5c-590891bc50ca@kwiboo.se>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <a84b7af4-0e78-4a07-ba5c-590891bc50ca@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A3dlJDe9quzvXYSTdkT23Mc389KX+j7QoALDZVKoAsK+p+sL8aT
 6dnkU8tuYaLARuvYGrUcIG4kyijRqnFbiVCrk07t7XR5dog0nyXBcMSE5k0uIbd6NEVXyeJ
 IfohOpy54Jvxeszz7R4BIW71MCcY+Mfx2gSNrspj+UKU//Dmwbdsiqar8EoLF6PElX5wEeU
 snSCaBf+hgoIZ6zOx/hFg==
UI-OutboundReport: notjunk:1;M01:P0:FvU6Fbw0SxY=;4BnMTX5OdEgHKymg6q39GdkX7O0
 1vuL/X9dcm4eKGelzTWKYM0WPuseNZYswZrvYTTlTVESMclAYCxw+ptkzp4o6OHNKbKMQSJBh
 GFhq9Qjl7HkLW7HAkidJXH0sG/rMfQAfEbOuLm+Y7ZmB5w/qbLz4qrGDMVqhGtTeDfgOQaYBz
 spjSlnb6SlNXY9woilyg+dBKy/F5T7D7K8+yLWn8ebTaFgLtlq1BF62dqhhUrA89wRYtBPZLs
 n2X15kx8WVhkbrEkW7c1mdvRBX//Y/snX5wvwaPoK5plZBD+T6m+gE5zBWlmqqtXYrPhU2Qga
 aDZS2xI+NWbQUm+LZNzVppWJF2S4RFf9XlSq/xFx+vx1xr22LrUsVCip+ZlwsqjwB2kiNsCDc
 kMu4rQ89eGO5tsvrHo9sTvWgIV7Da39dKLzeNCS1Bay4XnERnOfG/1u0qtp6schlGZXPCQtmu
 s2iqvinYpGH7xEiIEXW/2vFGvySnCCSwZ2482P/eak0whxBBisMqHAbDDSMST4Zt0IH3JWzFL
 jT20k4Gq/KqT72eR+bBNnNO1DsddP3k74A7YPDy7SAF4G1jlH97PKh3qrFqUt9UhMcVgMMXAC
 zhtE6dp36WEFdLO+POvt68ujiyHFFsxTjaPmtMDn4X/yNgilA6/quv/CzrBNSlDyk2JrVGL+e
 rOEFNUz3mMxUzW/jf3AGDuFnEjbNd+1opGuP56/3LYMdCA4WgxkNaVYqeXtJYk2jN3Hwoi93O
 XKb3HDmYwgGkRxsndfYU6QxgdAoXAVFo9QIyV0MQA3TDnts7lLB6SJHh/9F34iMojpYtIv+wc
 SeXCMnlYndUe53abheg6iDgeIgVAE+E3hZ4EFCFkJ0hWj6x575A+xamPzAaVAfcw/FHZbmdxC
 a4LiiAz2UhJNJZVdofhetT5I+Am1kTucUtJhPuN3cqmB16dlMOzk2HiLC8G623V5krmIxNu2D
 uYv7CjyhflRkFVxT68W6m7ZBR9z6IPOiwR5HcxnGcD8uxtWixwkVbYe1ocK78+lAcLCKjQurT
 7VsJfoGy5oZ6L7Q1NgeE68Ah3pKsffH6VZF4A9jH1xkEfqST3K/QBLRJnPs40eT/Glf8nTGf5
 D3kOxKk65NK4O1mMCW4QuOo/AIJbM5
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

On 1/4/25 12:49, Jonas Karlman wrote:
> Hi Heinrich,
>
> On 2025-01-04 04:19, Heinrich Schuchardt wrote:
>> Dear Tom,
>>
>> The following changes since commit ec9263b4f15c4cf82eb6a211c67baa638506=
5b8e:
>>
>>     Fix neighbor discovery ethernet address saving (2025-01-01 14:40:04
>> -0600)
>>
>> are available in the Git repository at:
>>
>>     https://source.denx.de/u-boot/custodians/u-boot-efi.git
>> tags/efi-next-20250104
>>
>> for you to fetch changes up to ce190e1b33b8c0e1228f4123759dfa1981c202de=
:
>>
>>     efi: Correct ECPT table GUID (2025-01-04 02:17:06 +0100)
>>
>> Gitlab CI reported no issues:
>> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/24075
>>
>> ----------------------------------------------------------------
>> Pull request efi-next-20250104
>>
>> Documentation:
>>
>> * doc: develop: Fix typos and wording in binman/binman.rst
>> * doc: develop: Fix typos and wording in gdb.rst
>> * doc: sandbox: Fix the "sb" command name
>> * doc/develop/distro.rst: Better document upstream definition of
>> extlinux.conf
>>
>> UEFI:
>>
>> With this pull request the UEFI sub-system detects all boot devices eve=
n
>> if they have not been probed before. If this adds to much boot delay
>> individual bootmeths and bootdevs can be disabled via the customizing.
>>
>> * efi_loader: avoid writing message in Exit() boot service
>> * efi_loader: run bootdev_hunt() to find ESP
>
> This patch still completely changes how standard boot operates, from
> lazy probing boot devices from fastest to slowest (probe time) as
> described in the standard boot documentation [1], to probing all boot
> devices all at once before checking for a bootmeth/bootflow.
>
> This slows down script and extlinux booing on my Rockchip board by
> several seconds because now pcie and usb is probed before current fast
> bootflow from mmc devices is tested.

We need to scan all block devices to be EFI compliant.

As described in the pull request message, if you don't want to boot from
PCIe or USB, you can disable these bootdevs.

If you don't want to boot via EFI set CONFIG_EFI_LOADER=3Dn.

>
> Will you work on a fix for this or do you recommend disabling the
> efi_mgr bootmeth or similar? E.g. something like the diff below.
>
> Similarly if I understand correctly the priority of efi_mgr bootmeth,
> first regardless of configured bootmeth order, is the main blocker for
> sunxi to fully move to standard boot.

Allowing to run global boot methods after non-global ones still has to
be worked on.

Please, elaborate why Sunxi cannot be migrated like other boards. If
some embedded board needs to be trimmed to maximize boot speed you will
anyway adjust the configuration to eliminate all unnecessary scanning of
devices.

Best regards

Heinrich

>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 20935a269c60..81e10be4eef8 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -617,7 +617,7 @@ config BOOTMETH_EFI_BOOTMGR
>   	bool "Bootdev support for EFI boot manager"
>   	depends on EFI_BOOTMGR
>   	select BOOTMETH_GLOBAL
> -	default y
> +	default y if !ARCH_ROCKCHIP
>   	help
>   	  Enable booting via the UEFI boot manager. Based on the EFI variable=
s
>   	  the EFI binary to be launched is determined. To set the EFI variabl=
es
>
> [1] https://docs.u-boot.org/en/latest/develop/bootstd/overview.html#boot=
-process
>
> Regards,
> Jonas
>
>> * efi_loader: update EFI specification version
>> * cmd: efidebug: update output of memory attributes
>> * efi_loader: Don't warn if the TCG2 FinalEvents table is not installed
>> * cmd: bootmenu: add parameter -e for UEFI boot options
>> * efi_loader: Update startimage_exit self-test to check error
>> * efi: Correct ECPT table GUID
>>
>> Others:
>>
>> Building the API demo application for riscv64 is supported.
>>
>> * API: unify platform_sys_info() implementations
>> * examples: implement _start and syscall for RISC-V
>> * examples: use architecture specific memset() on RISC-V
>> * examples: use QEMU compatible LOAD_ADDR on RISC-V
>> * test: fix test_extension.py
>> * configs: sandbox_deconfig: remove CONFIG_AMIGA_PARTITION
>> * CI: xilinx_versal_virt: disable USB_DWC3
>> * net: eth_bootdev_hunt() should not run DHCP
>>
>> ----------------------------------------------------------------
>> Adriano Cordova (1):
>>         efi_loader: Expose efi_reinstall_protocol_interface in efi_load=
er.h
>>
>> Aleksandar Gerasimovski (1):
>>         efi_loader: fix pe reloc pointer overrun
>>
>> Heinrich Schuchardt (13):
>>         API: unify platform_sys_info() implementations
>>         examples: implement _start and syscall for RISC-V
>>         examples: use architecture specific memset() on RISC-V
>>         examples: use QEMU compatible LOAD_ADDR on RISC-V
>>         efi_loader: avoid writing message in Exit() boot service
>>         test: fix test_extension.py
>>         configs: sandbox_deconfig: remove CONFIG_AMIGA_PARTITION
>>         CI: xilinx_versal_virt: disable USB_DWC3
>>         net: eth_bootdev_hunt() should not run DHCP
>>         cmd: bootmenu: add parameter -e for UEFI boot options
>>         efi_loader: run bootdev_hunt() to find ESP
>>         efi_loader: update EFI specification version
>>         cmd: efidebug: update output of memory attributes
>>
>> Ilias Apalodimas (1):
>>         efi_loader: Don't warn if the TCG2 FinalEvents table is not ins=
talled
>>
>> Lothar Rubusch (2):
>>         doc: develop: Fix typos and wording in binman/binman.rst
>>         doc: develop: Fix typos and wording in gdb.rst
>>
>> Olivier L'Heureux (1):
>>         doc: sandbox: Fix the "sb" command name
>>
>> Simon Glass (1):
>>         efi_loader: Update startimage_exit self-test to check error
>>
>> Tom Rini (1):
>>         doc/develop/distro.rst: Better document upstream definition of
>> extlinux.conf
>>
>> Yang Gang (1):
>>         efi: Correct ECPT table GUID
>>
>>    .azure-pipelines.yml                            |   1 +
>>    .gitlab-ci.yml                                  |   1 +
>>    api/Makefile                                    |   9 +-
>>    api/api_platform-arm.c                          |  35 ----
>>    api/api_platform-mips.c                         |  29 ---
>>    api/api_platform.c                              |  25 +++
>>    cmd/bootmenu.c                                  |  39 +++-
>>    cmd/efidebug.c                                  |   5 +-
>>    configs/sandbox_defconfig                       |   1 -
>>    doc/develop/distro.rst                          |  15 +-
>>    doc/develop/gdb.rst                             |  10 +-
>>    doc/usage/cmd/bootmenu.rst                      |  13 +-
>>    doc/usage/cmd/sb.rst                            |   6 +-
>>    examples/api/Makefile                           |   7 +-
>>    examples/api/crt0.S                             |  32 ++++
>>    include/efi.h                                   |   2 +
>>    include/efi_api.h                               |   8 +-
>>    include/efi_loader.h                            |   5 +
>>    lib/efi_loader/efi_boottime.c                   |   9 +-
>>    lib/efi_loader/efi_image_loader.c               |   2 +-
>>    lib/efi_loader/efi_setup.c                      |   8 +
>>    lib/efi_loader/efi_tcg2.c                       |   2 +-
>>    lib/efi_selftest/efi_selftest_startimage_exit.c |   6 +-
>>    net/eth_bootdev.c                               |  30 +--
>>    test/py/tests/test_extension.py                 |   4 +-
>>    tools/binman/binman.rst                         | 234
>> ++++++++++++------------
>>    26 files changed, 300 insertions(+), 238 deletions(-)
>>    delete mode 100644 api/api_platform-arm.c
>>    delete mode 100644 api/api_platform-mips.c
>>    create mode 100644 api/api_platform.c
>>
>

