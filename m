Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF01CD1297
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 06:38:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E910882A2;
	Thu,  4 Apr 2024 08:38:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1712212688;
	bh=+v5c99J0Fu3ZYYHifA6S0ssZ+yk60Sk2m7TppIx1DRc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iUa1BRzYAsv9tBJUf8rE28QeTTC3j/1sjGj9qgoFrgiOHOyRMQ8EZmotTt9Jm5Q6/
	 VUE5grGGi5ExmRMotxMYHDhRg+GJwPl0bqplAxHPMi1qiSLr9FuWV8hCKa1PoXOYPn
	 KNUFi90SduQP+eYfZN9Ie2qaplZYBXFiPAhlpnkLdzUakPMqWsTJ7LDzt7IH9X3Ou4
	 Sxis+2yEnV6K6P4GZRgrdJ0Olx4N+EoOHuCZiYBzSeNQHTv/ek3vyL+6Wc4AL7MBo6
	 EERp4c4dxHgHsErJwzANQjTDaFkxh+wnuFdMkkhh5iRNcbpafcQz4CQtzL9QGhk8qe
	 WGN8+DjkVGQBg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9FC9882B5; Thu,  4 Apr 2024 08:38:07 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4E1387C2D
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 08:38:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4V9Bkz2tFPz9sQm;
 Thu,  4 Apr 2024 08:38:03 +0200 (CEST)
Message-ID: <b37ad950-46e4-443d-98b9-9d34bb47bde0@denx.de>
Date: Thu, 4 Apr 2024 08:38:02 +0200
MIME-Version: 1.0
Subject: Re: [PATCH u-boot-mvebu v3 00/18] Turris Omnia - New board revision
 support
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: u-boot@lists.denx.de, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20240327162355.24584-1-kabel@kernel.org>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240327162355.24584-1-kabel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4V9Bkz2tFPz9sQm
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

Hi Marek,

On 3/27/24 17:23, Marek Behún wrote:
> Hi Stefan,
> 
> this is v3 of series adding support for new board revision of Turris
> Omnia.
> 
> Changes since v2:
> - patch 2: updated MCU command interface header
> - patch 6: fixed bug setting \0 as end of string in src array instead
>             of dst array after bin2hex() call
> - patch 16: updated commit message (added the bit about ctrl+c)
> 
> v1 and v2 at:
>    https://patchwork.ozlabs.org/project/uboot/cover/20240304152148.3847-1-kabel@kernel.org/
>    https://patchwork.ozlabs.org/project/uboot/cover/20240323180711.5498-1-kabel@kernel.org/

After pushing there changes in my current master I get these build
errors for "turris_omnia_defconfig":

make[1]: *** No rule to make target 
'board/CZ.NIC/turris_omnia/../turris_common.o', needed by 
'board/CZ.NIC/turris_omnia/built-in.o'.  Stop.
make[1]: *** Waiting for unfinished jobs....
board/CZ.NIC/turris_omnia/../turris_atsha_otp.c:14:10: fatal error: 
turris_common.h: No such file or directory
    14 | #include "turris_common.h"
       |          ^~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.build:257: 
board/CZ.NIC/turris_omnia/../turris_atsha_otp.o] Error 1
board/CZ.NIC/turris_omnia/turris_omnia.c:36:10: fatal error: 
../turris_common.h: No such file or directory
    36 | #include "../turris_common.h"
       |          ^~~~~~~~~~~~~~~~~~~~
compilation terminated.

Available here:

https://source.denx.de/u-boot/custodians/u-boot-marvell/-/commits/master?ref_type=heads

Could you please have a look?

Thanks,
Stefan

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
>   arch/arm/mach-mvebu/system-controller.c  | 144 ++++++--
>   board/CZ.NIC/turris_atsha_otp.c          |  27 +-
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
>   17 files changed, 1044 insertions(+), 482 deletions(-)
>   delete mode 100644 drivers/gpio/turris_omnia_mcu.c
>   create mode 100644 drivers/misc/turris_omnia_mcu.c
>   create mode 100644 include/turris-omnia-mcu-interface.h
> 

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
