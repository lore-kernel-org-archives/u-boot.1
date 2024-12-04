Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5723BE7716B
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 15:01:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD9D4896BF;
	Wed,  4 Dec 2024 16:01:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="MFLkgnNS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07D9B896DF; Wed,  4 Dec 2024 16:01:54 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15DF288E50
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 16:01:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=234f=S6=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1733324504;
 bh=T2D+GvR0Xs1Uf4tkg0KIwASXrWEheyZNl1veOo/5m3o=;
 b=MFLkgnNSAva5CMBW9xs4PQHmUSvdBE7nq1Ejg79oK454++shF60rTOXz5wxk6kOGUZbquoNq5
 TZVND3iMhplAcdePhTqXbA+rWbuKutlpPAkBiP5bA7LVqpVyooe7I46ZFWBG7je5aIS1sjlo5IX
 hVlalhof35eBy+Xkz6eW0Tg4arKdRI2ukf394TlCKRYUk4COlRancVt/nN584f6t3MakoekcxZi
 HLcR5kHm/csTB6gAo6oJg+lZkAEUO/B4iNIp+m7bidPEZHVjtLceEix02+4y8/mZhbt35RdHdBJ
 TRD3FHEHpr89lvCCV06b7+2SFHZYomdCFlo0CxYUJxFA==
Message-ID: <2cca538b-c568-464e-b4f0-4c0bba553d58@kwiboo.se>
Date: Wed, 4 Dec 2024 16:01:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [MASTER] Pull-request efi-2025-01-rc4
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andy Yan <andyshrk@163.com>,
 =?UTF-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>
References: <8910d434-2d77-425f-aa81-8eb803078aef@gmx.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <8910d434-2d77-425f-aa81-8eb803078aef@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 67506ed629932d4adc2ad572
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

On 2024-12-04 13:10, Heinrich Schuchardt wrote:
> Dear Tom,
> 
> The following changes since commit f96e5133184aac377b54bd61f8abf78710f2ee56:
> 
>    Merge branch 'master' of
> https://gitlab.denx.de/u-boot/custodians/u-boot-samsung (2024-12-03
> 12:37:20 -0600)
> 
> are available in the Git repository at:
> 
>    https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2025-01-rc4
> 
> for you to fetch changes up to 657310322e5893d0b1bbba002fbe59b318062192:
> 
>    doc: environment: NET_LWIP dhcp sets ipaddrN, netmaskN and gatewayipN
> (2024-12-04 11:26:34 +0100)
> 
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/23706
> 
> ----------------------------------------------------------------
> Pull-request efi-2025-01-rc4
> 
> With the move to bootstd booting via the EFI boot manager stopped to
> consider all block devices due to missing probing.
> 
> With this pull request probing of all bootdevs before running the boot
> manager is achieved. Prerequisite changes are needed to pass the CI.
> 
>        efi_loader: simplify efi_disk_rw_blocks()
>        test: fix test_extension.py
>        configs: sandbox_deconfig: remove CONFIG_AMIGA_PARTITION
>        CI: xilinx_versal_virt: disable USB_DWC3
>        net: eth_bootdev_hunt() should not run DHCP
>        cmd: bootmenu: add parameter -e for UEFI boot options
>        efi_loader: run bootdev_hunt() to find ESP

As pointed out in v1 of this patch, this cause a serious slowed down
boot for bootstd boards using scripts and extlinux boot due to usb and
pci being initialized before boot_targets order is considered.

With this merged we probably need to disable BOOTMETH_EFI_BOOTMGR for
bootstd/Rockchip. Seem very late in release to merge this big change!

Regards,
Jonas

> 
> Further UEFI changes:
> 
>        Avoid writing message in Exit() boot service
>        Update startimage_exit self-test to check error
>        Don't warn if the TCG2 FinalEvents table is not installed
> 
> Documentation changes:
> 
>        cmd: bootmenu typo 'read'
>        clk: mpc83xx: Fix typo in "Coherent System Bus"
>        efi_loader: Fix typos in enum efi_allocate_type
>        doc: sending_patches: Fix spelling of "its"
>        doc: environment: NET_LWIP dhcp sets ipaddrN, netmaskN and gatewayipN
>        doc: board: theobroma-systems: fix feature list in introductions
> 
> ----------------------------------------------------------------
> Andy Yan (1):
>        doc: coolpi: Fix document style
> 
> Heinrich Schuchardt (9):
>        efi_loader: simplify efi_disk_rw_blocks()
>        test: fix test_extension.py
>        configs: sandbox_deconfig: remove CONFIG_AMIGA_PARTITION
>        CI: xilinx_versal_virt: disable USB_DWC3
>        net: eth_bootdev_hunt() should not run DHCP
>        cmd: bootmenu: add parameter -e for UEFI boot options
>        efi_loader: run bootdev_hunt() to find ESP
>        cmd: bootmenu typo 'read'
>        efi_loader: avoid writing message in Exit() boot service
> 
> Ilias Apalodimas (1):
>        efi_loader: Don't warn if the TCG2 FinalEvents table is not installed
> 
> J. Neuschäfer (2):
>        clk: mpc83xx: Fix typo in "Coherent System Bus"
>        doc: sending_patches: Fix spelling of "its"
> 
> Jerome Forissier (1):
>        doc: environment: NET_LWIP dhcp sets ipaddrN, netmaskN and gatewayipN
> 
> Quentin Schulz (1):
>        doc: board: theobroma-systems: fix feature list in introductions
> 
> Simon Glass (2):
>        efi_loader: Fix typos in enum efi_allocate_type
>        efi_loader: Update startimage_exit self-test to check error
> 
>   .azure-pipelines.yml                            |  1 +
>   .gitlab-ci.yml                                  |  1 +
>   cmd/bootmenu.c                                  | 41
> +++++++++++++++++++------
>   configs/sandbox_defconfig                       |  1 -
>   doc/board/coolpi/genbook_cm5_rk3588.rst         | 11 ++++---
>   doc/board/theobroma-systems/puma_rk3399.rst     |  1 +
>   doc/board/theobroma-systems/tiger_rk3588.rst    |  7 +++++
>   doc/develop/sending_patches.rst                 |  2 +-
>   doc/usage/cmd/bootmenu.rst                      | 13 ++++++--
>   doc/usage/environment.rst                       | 31 ++++++++++---------
>   drivers/clk/mpc83xx_clk.h                       |  2 +-
>   include/efi.h                                   |  2 +-
>   lib/efi_loader/efi_boottime.c                   |  7 ++---
>   lib/efi_loader/efi_disk.c                       |  8 ++---
>   lib/efi_loader/efi_setup.c                      |  8 +++++
>   lib/efi_loader/efi_tcg2.c                       |  2 +-
>   lib/efi_selftest/efi_selftest_startimage_exit.c |  6 ++--
>   net/eth_bootdev.c                               | 30 ++++++++++--------
>   test/py/tests/test_extension.py                 |  4 ++-
>   19 files changed, 116 insertions(+), 62 deletions(-)
> 

