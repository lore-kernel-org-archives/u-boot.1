Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8293DCD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 12:05:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF79787F2D;
	Thu,  4 Apr 2024 14:05:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1712232303;
	bh=qFjTB9M/VOugvFf/w1gMFpYnawLIA9iz+csXolHUJGU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FUz+cEybZrIQgk6XVN8HShCHODbY0Ht6GmxAAz7n/EL5ivauYZYnCTHg60empeEjX
	 SzVfIPfTQPYMhDhkpxAvPTlcAiSf3fO4I52mFc/laX7AFUVuCANzV2PzQB3FX3I8se
	 9VcatlvmmQQg660WWN9SKie3l2906gLo6IifpfhtyILn//ZwY6IYAUBHWbIF3qovIZ
	 CfKt7jX8ytaQw+tAbQ42Lfhd5muiYnecxw7AoghV4Wx6obKDLD4uv0XBQcmJaMnUGj
	 MDZFSrNbiGLpUUL+D8mc3tsr5ipyljMObotBqZTcxlC7OvDXCTd0hB1kydZTYUORLC
	 xnYrL1W85Jr2w==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 945E888120; Thu,  4 Apr 2024 14:05:02 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7468387842
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 14:05:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4V9L0B0qxRz9sSd;
 Thu,  4 Apr 2024 14:04:58 +0200 (CEST)
Message-ID: <90d15829-ef3f-423b-a17e-15b2a95b24a4@denx.de>
Date: Thu, 4 Apr 2024 14:04:57 +0200
MIME-Version: 1.0
Subject: Re: [PATCH u-boot-mvebu v4 00/18] Turris Omnia - New board revision
 support
Content-Language: en-US
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: u-boot@lists.denx.de
References: <20240404075107.19636-1-kabel@kernel.org>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240404075107.19636-1-kabel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 4/4/24 09:50, Marek Behún wrote:
> changes since v3:
> - added missing files turris_common.c and turris_common.h to patch 05/18
> - added comment to patch 11/18 before while (1); as discussed in v3
> 
> v1, v2 and v3 at:
>    https://patchwork.ozlabs.org/project/uboot/cover/20240304152148.3847-1-kabel@kernel.org/
>    https://patchwork.ozlabs.org/project/uboot/cover/20240323180711.5498-1-kabel@kernel.org/
>    https://patchwork.ozlabs.org/project/uboot/cover/20240327162355.24584-1-kabel@kernel.org/
> 
> Marek Behún (18):
>    arm: mvebu: turris_omnia: Enable LTO by default on Turris Omnia
>    arm: mvebu: turris_omnia: Add header containing MCU command interface
>      and use it
>    arm: mvebu: turris_{omnia, mox}: Don't print model two times
>    arm: mvebu: turris_omnia: Update MCU status and features reading
>    arm: mvebu: turris_omnia: Implement getting board information from MCU
>    arm: mvebu: turris_omnia: Print board ECDSA public key if available
>    arm: mvebu: turris_omnia: Disable Atmel SHA node if not present
>    arm: mvebu: spl: Do not build mvebu-reset in SPL
>    arm: mvebu: system-controller: Rework to use UCLASS_SYSCON
>    arm: mvebu: system-controller: Select mvebu-reset if DM_RESET &&
>      PCI_MVEBU
>    arm: mvebu: system-controller: Add support for SYSRESET
>    gpio: turris_omnia_mcu: Use byteorder conversion functions
>    gpio: turris_omnia_mcu: Update firmware features reading
>    gpio: turris_omnia_mcu: Add support for system power off via sysreset
>    arm: mvebu: turris_omnia: Enable poweroff command via sysreset in
>      defconfig
>    cmd: rng: Print "Abort" on -EINTR
>    misc: turris_omnia_mcu: Add support for rng provided by MCU
>    arm: mvebu: turris_omnia: Enable rng command in defconfig
> 
>   arch/arm/mach-mvebu/Kconfig              |  25 ++
>   arch/arm/mach-mvebu/Makefile             |   3 +-
>   arch/arm/mach-mvebu/cpu.c                |   2 +
>   arch/arm/mach-mvebu/system-controller.c  | 145 ++++++--
>   board/CZ.NIC/turris_atsha_otp.c          |  27 +-
>   board/CZ.NIC/turris_common.c             |  42 +++
>   board/CZ.NIC/turris_common.h             |  10 +
>   board/CZ.NIC/turris_mox/turris_mox.c     |   5 +-
>   board/CZ.NIC/turris_omnia/Makefile       |   2 +-
>   board/CZ.NIC/turris_omnia/turris_omnia.c | 310 ++++++++++++-----
>   cmd/rng.c                                |   7 +-
>   configs/turris_omnia_defconfig           |   6 +
>   drivers/gpio/Kconfig                     |   7 -
>   drivers/gpio/Makefile                    |   1 -
>   drivers/gpio/turris_omnia_mcu.c          | 316 -----------------
>   drivers/misc/Kconfig                     |  11 +
>   drivers/misc/Makefile                    |   1 +
>   drivers/misc/turris_omnia_mcu.c          | 411 +++++++++++++++++++++++
>   include/turris-omnia-mcu-interface.h     | 248 ++++++++++++++
>   19 files changed, 1097 insertions(+), 482 deletions(-)
>   create mode 100644 board/CZ.NIC/turris_common.c
>   create mode 100644 board/CZ.NIC/turris_common.h
>   delete mode 100644 drivers/gpio/turris_omnia_mcu.c
>   create mode 100644 drivers/misc/turris_omnia_mcu.c
>   create mode 100644 include/turris-omnia-mcu-interface.h

Applied to u-boot-marvell/master

Thanks,
Stefan
