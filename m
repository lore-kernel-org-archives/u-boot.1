Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534C9D39005
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 18:25:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B94EB803F5;
	Wed, 14 Jan 2026 19:25:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="OpZ8pFZu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E2218063E; Wed, 14 Jan 2026 19:25:07 +0100 (CET)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE14C80325
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 19:25:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1768415090;
 bh=Rs0m/+kj2zelkRIh2e+8eyoNs/zprNxge81Gs0LwPME=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=OpZ8pFZuHm4t91BdQlHPXiH9vv/AHU4mVtTCVk2qGvHArahzVovinD1iFI6GQ1t5U
 nGKiuxRckNrPO0gcW1f8bvfFd7qrbLuBRiV0Itko8OLFC42iB9WsqF9kECDqNFWBFK
 WWVr8s3cbJY1BNHjDO4Xnd8RimiBkb+j3z1he5vAGO9jJsugvTvNX4iIYhzupB1ojl
 rD5c2LTqB9aUc0OTw0avyGWOAzj48ccTXEMbGUSEm+UjZEqHwrRU5VZ5K1ZKAEE19z
 QRYAPEMVD7uPPw9EqwTFBbEdIwMu4iJIpqSsy2sFYZGD5xUlaU6q+QXBf2d0Adabu3
 GZPAUMpWs8lIA==
Received: from [IPV6:2605:59c0:2078:cf00:c0b6:e37b:5515:2b98] (unknown
 [IPv6:2605:59c0:2078:cf00:c0b6:e37b:5515:2b98])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 10CE4B2210A4;
 Wed, 14 Jan 2026 19:24:47 +0100 (CET)
Message-ID: <6e18320e-d481-4871-87d2-1debd8a104af@freeshell.de>
Date: Wed, 14 Jan 2026 10:24:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] efi_vars: Implement SPI Flash storage for EFI
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@amd.com
Cc: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, Raymond Mao
 <raymondmaoca@gmail.com>, Shantur Rathore <i@shantur.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
References: <cover.1768403729.git.michal.simek@amd.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <cover.1768403729.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Michal I have some user-facing questions about this concept.

On 1/14/26 07:15, Michal Simek wrote:
> 
> This is updated series based on v3 version sent here
> https://lore.kernel.org/all/20231126220836.374956-1-i@shantur.com/
> 
> that's why I am continuing on v4 instead of starting from scratch.
> 
> Tested on kv260 with saving variables to location where User MTD partition
> is.
> CONFIG_EFI_VARIABLE_SF_STORE=y
> CONFIG_EFI_RT_VOLATILE_STORE=y
> CONFIG_EFI_VARIABLE_SF_OFFSET=0x22a0000
> 
> Thanks,
> Michal
> 
> Changes in v4:
> - New patch based on review comments from v3
> - use unify methods for reading/writing variable
> 
> Changes in v3:
> - Fixed compiler warnings.
> 
> Changes in v2:
> - Refactored efi_var_file to move common parts out as requested
> - Changed ifdefs to use CONFIG_IS_DEFINED
> - Fixed typos
> 
> Michal Simek (1):
>   efi_var: Unify read/write access helper function
> 
> Shantur Rathore (2):
>   efi_var_file: refactor to move buffer functions
>   efi_vars: Implement SPI Flash store
> 
>  include/efi_variable.h          | 18 +++----
>  lib/efi_loader/Kconfig          | 26 +++++++++-
>  lib/efi_loader/Makefile         |  3 +-
>  lib/efi_loader/efi_var_common.c | 44 ++++++++++++++++
>  lib/efi_loader/efi_var_file.c   | 65 ++---------------------
>  lib/efi_loader/efi_var_sf.c     | 91 +++++++++++++++++++++++++++++++++
>  lib/efi_loader/efi_variable.c   | 16 ++++--
>  7 files changed, 187 insertions(+), 76 deletions(-)
>  create mode 100644 lib/efi_loader/efi_var_sf.c
> 

So far as I'm aware support for EFI variable storage is always integral
to a filesystem as the EFI System Partition, even in the case of the
specially-handled MMC boot partition facility. With presence of many
possible ESP is there then only one active ESP, or do all ESP become
part of a pool of available locations?  I'm not understanding this
clearly what is the purpose of selecting an ESP if the variable storage
is not integral to the ESP.

Does having EFI variable storage in SPI Flash always take priority over
other ESP presence that might have additional variable storage as a file?

Can (or should?) there be a runtime configurable setting to decide two
preferences; does one depend on the other or are these independent?:

1. Preferred ESP
2. Preferred EFI variable storage strategy

Consider not wanting to have a perceived ABI breakage as the SPI Flash
layout is previously codified by user expectations of what the vendor
initially shipped with the product and having been codified in upstream
Linux kernel devicetree definition. For the example where this would be
useful for boards where there is a well-known SPI Flash layout, I am
thinking of StarFive VisionFive 2 where there is {U-Boot SPL, U-Boot env
storage, U-Boot Main at 1MiB offset}; does your implementation of EFI
variable storage in SPI Flash have a suggested co-existence with the
"gap" in the area that is currently U-Boot env storage?

The use situations I am thinking of:

A. Installing a new OS or booting purpose-built image, where it is
intended that having (for example) a USB mass storage class or SD Card
of the all-in-one image depends on U-Boot in SPI Flash deciding both
that the EFI System Partition on the removable media is a priority over
other similar media (other different USB boot devices that may be
present, existing eMMC storage module possibly with ESP in addition to
the inserted removable SD Card).

B. Preventing the ambiguous selection of any additional removable
storage containing an EFI System Partition from breaking the desired
boot strategy. In many situations a user wants assurance that the board
will boot exactly the same every time regardless of what additional
removable media containing EFI System Partition might be connected.

C. Corrupt or unusable selected EFI System Partition prevents any
recovery and there is no runtime mechanism to attempt an alternative

Is there a possible mechanism for adding a runtime check (GPIO state,
key press, network event) to make the decision between some immutable
boot preference, or a user-configured boot preference?

Overall I want to get an understanding of how it might be recommended to
make use of this for StarFive VisionFive 2 board target(s). Many hours
of troubleshooting headache have been the result of EFI System Partition
confusion on board that have a wide variety of storage subsystems (MMC,
USB, NVMe, ...) which result in some really strange outcomes with
installers of GNU/Linux OS distros;  particularly as the devicetree dtb
search path currently points to storage subsystems that are typically
removable media, or the failure mode where an OS installer is using the
selected EFI System Partition that "leads on a path to nowhere" and is
not the intended installation target.

-E
