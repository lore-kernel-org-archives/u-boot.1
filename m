Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6DEECD98DA
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 12:26:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 461D884119;
	Tue, 16 Jun 2026 14:26:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZGj9eupc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 468228484C; Tue, 16 Jun 2026 14:26:27 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D371E84105
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 14:26:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-45efa80e0afso3561676f8f.2
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 05:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781612784; x=1782217584; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KXOMFkJ+sp4DK5+fbtf2qNE5qbRlaY1mxzpg4uwsZ0Y=;
 b=ZGj9eupcXK/XRRSR193KfodA4qFC1LC7Hr3J+DqWo8Zb02gjzDuea6NprbXCqsy0NX
 6KxFoiA7R8I7TUMcpKp5Ay03N7+vjW7PpvQsbWZyHAhIQj3lvTYtUMKZHDpKsVeUEkOh
 1qDyfDYuCuLyhhQrvwjp5WK1LZqn0TYSJPbsZijZxgx9s9Ny0p9+MvbdtLRB06hR7O4Q
 9hpN9n0bVqQAC8AzhqW/WnE/51WEoqSShxwK5TDBgbOid5EZYDz/T7HPSXlaZTNCavav
 uGU57QTOToBm3/B3RXTX6KDX+UQe5Kww9056thI6xbqtXOQeQqpwuEDdBjaJLbhutBRU
 wdpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781612784; x=1782217584;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KXOMFkJ+sp4DK5+fbtf2qNE5qbRlaY1mxzpg4uwsZ0Y=;
 b=rwugikPKHJ0Wzf0To0w4vTsvvaKn7JLXYrcmy83Y1LvRkLxueGCvjVZdiRgrVWJJ/H
 5jaMOsiygx2Pdh6SkRbgdIxqiVLnPZfxIOxzP54xRuN4krv5/qmmwtyvjsuwDtqec6Db
 VBYKLpD2RlNW9v0R0mO9xeZ6cNEcZQIQzKW8Ub5L2e4WFElmqlw3YewHQb/yaQ8j3oQs
 SAqhmLrpBeA3J7KE5dFOrISyoqZLJx0nIgma3g0Yq6I59mMIymrZXTaq6GKkQntIvGd7
 vNDTZTOHFqML29iwR145fBIuab0piOKI9WY6AoVsmYOEwoTvYBmPJjuyRed5NVdwYLs0
 msjA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+4Eo9fgVyBItXTr3TEVQnu7jUfJVcHiWHPj60sJzNFGmRSsnMsWpkWEWG++bDdni//5o/gZ9I=@lists.denx.de
X-Gm-Message-State: AOJu0YwSszC5KYjeU99FyZ+VENLpcSM0v1d8BshKFrA3v+O7Qnd0DjtW
 jHICjMcEwwwhnZxQbvniQbE+WqkvXtftbG1tEwGY4xOrCQJL+A/nJKDavaRlJlH8vH0=
X-Gm-Gg: Acq92OGPne/P9BXzWg2SlhEjkxI1hOV/55EcCZ/NsD9kohbbG7lINUZHtbB+0UtLbC5
 Y1WhRlVcR816WoAreYjeZmSog5K7aqQ9UZCjkC4Ml7nfNuA8v5U9gr/zBIiEbIo+N9J8lEPTq/W
 dfLrJE0ncZ/LgQaVqpkUrSVZqNSuTDzWOrwJ32rMZtCXVMIBrkOXCXSP4NMcQuBngb3gYTW5Wix
 n8sLR7Qfl+kRZt8lYyr2NphmdoyTwgA/jayr3SpuFDRgwPOfyN5tKb177jgeSN9xX5x3KwALeBR
 9RrFQnAoKvbQaSDyo9KSSL/k2sLhJ1eEA3D6IdCsOkuOH6/3HjybqrngnFvn6Fk1l6gLz3rOlkO
 sAS1vHR/u5a2XxCobXjCoqTxQ/RVXTvFxGqTAvZAQyvRXS82UZ7CWRCfMpxGAhhQtfkm6kSx2hn
 dQ7/xVgrxR8pzeiGNv7Vyt4sb9G4WQ/46NSyYrXyq7FS6JhrhXJoJbuLVoS36bChg=
X-Received: by 2002:a05:6000:260f:b0:461:d2ee:2fcc with SMTP id
 ffacd0b85a97d-461d2ee3057mr1437288f8f.43.1781612784063; 
 Tue, 16 Jun 2026 05:26:24 -0700 (PDT)
Received: from [192.168.1.36] (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm42122513f8f.34.2026.06.16.05.26.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 05:26:23 -0700 (PDT)
Message-ID: <64718934-b054-4c47-9d01-dc6fac01dbd7@linaro.org>
Date: Tue, 16 Jun 2026 14:26:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] arm: snapdragon: Add snagboot support for
 Lemans-EVK
Content-Language: en-US
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 George Chan <gchan9527@gmail.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Michael Srba <Michael.Srba@seznam.cz>, Simon Glass <sjg@chromium.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
References: <20260616-sngboot-v3-0-6fb0dee8125c@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260616-sngboot-v3-0-6fb0dee8125c@oss.qualcomm.com>
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

Hi Balaji,

On 16/06/2026 11:22, Balaji Selvanathan wrote:
> This series adds support for running U-Boot in snagboot mode on
> Qualcomm Snapdragon platforms, targeting the Lemans-EVK board.

You didn't respond to my reply on v2 of this series.
> 
> Snagboot is an open-source, scriptable flashing framework that provides
> an alternative to the proprietary Firehose protocol for device
> provisioning. Like the traditional EDL+Firehose flow, Snagboot uses the
> Qualcomm boot ROM recovery mode (EDL) and Sahara protocol to download
> and execute bootloaders. However, instead of using the proprietary
> Firehose programmer, Snagboot loads U-Boot into DDR and uses the
> standard fastboot protocol for device flashing.

Glad to have some more info here. Please also add a doc page with this
information as well as a list of supported platforms.

I would hope that this support will be expanded to other platforms, and
I'll make that assumption with my feedback.

> 
> The framework consists of three modular components: snagrecover
> (downloads XBL/QCLib to initialize DDR and load U-Boot into RAM),
> snagflash (communicates with U-Boot over USB using fastboot to flash
> system images), and snagfactory (orchestrates parallel factory
> flashing tasks).
> 
> In the snagboot execution flow, ROM code in recovery mode loads

recovery mode?? Please be consistent and just say EDL or boot ROM.

> snagrecover, which downloads XBL to internal memory. XBL executes
> and initializes DDR, then snagrecover downloads U-Boot into DDR and
> transfers control to it. At this point, XBL has left the MMU enabled
> with its own page tables and has not initialized PSCI firmware or
> populated the Command DB. U-Boot must handle this non-standard boot
> environment to enter fastboot mode for device flashing.
> 
> This series addresses the specific requirements of the snagboot flow:
> 
> Patch 1 changes SYSRESET_PSCI from 'select' to 'imply' so it can
> be disabled on platforms where PSCI firmware is unavailable.
> 
> Patch 2 guards show_psci_version() and qcom_psci_fixup() with
> CONFIG_ARM_SMCCC to prevent build failures when SMCCC is disabled.
> 
> Patch 3 adds CONFIG_QCOM_SNAGBOOT_SUPPORT option to enable snagboot
> mode support on Qualcomm platforms.
> 
> Patch 4 disables the MMU and invalidates TLBs at the earliest entry
> point to clear stale page tables left by previous bootloader
> before U-Boot sets up its own MMU.
> 
> Patch 5 adds QCOM_COMMAND_DB_OPTIONAL to allow the CMD DB driver to
> bind successfully when CMD DB data is not populated by XBL, logging
> a warning instead of failing.
> 
> Patch 6 adds qcom_lemans_snagboot_defconfig for Lemans-EVK, based
> on qcom_defconfig with snagboot-specific settings.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v3:
> - Brought the MMU disable logic under CONFIG_QCOM_SNAGBOOT_SUPPORT
>   ifdef condition
> - Moved the MMU disable codes to a new seperate file
> - Used "if (IS_ENABLED(CONFIG_QCOM_COMMAND_DB_OPTIONAL))" instead
>   of #ifdef
> - Removed enabling QCOM_COMMAND_DB_OPTIONAL, ENABLE_ARM_SOC_BOOT0_HOOK
>   and SKIP_RELOCATE as they are now automatically enabled by
>   QCOM_SNAGBOOT_SUPPORT selection 
> - Removed updating MAINTAINERS as the defconfig file is picked up by
>   the "N: qcom" line
> - Link to v2: https://lore.kernel.org/u-boot/20260608-snagboot-v2-0-036bb0343bf7@oss.qualcomm.com/
> 
> Changes in v2:
> - Changed SYSRESET_PSCI from 'select' to 'imply'
> - Guard show_psci_version() and qcom_psci_fixup() with CONFIG_ARM_SMCCC
> - Disables the MMU and invalidates TLBs at the earliest entry point
> - Add qcom_lemans_snagboot_defconfig for Lemans-EVK
> - Link to v1: https://lore.kernel.org/u-boot/20260409-cmddb-v1-1-b10549b34133@oss.qualcomm.com/
> 
> ---
> Balaji Selvanathan (6):
>       arm: snapdragon: Make SYSRESET_PSCI optional
>       arm: snapdragon: Guard PSCI functions with CONFIG_ARM_SMCCC
>       arm: snapdragon: Add CONFIG_QCOM_SNAGBOOT_SUPPORT option
>       arm: snapdragon: Disable MMU early before U-Boot reset vector
>       soc: qcom: cmd-db: Allow boot without CMD DB data
>       configs: add qcom_lemans_snagboot_defconfig for Lemans-EVK
> 
>  arch/arm/Kconfig                                   |  2 +-
>  arch/arm/mach-snapdragon/Kconfig                   | 13 ++++++
>  arch/arm/mach-snapdragon/board.c                   |  6 +++
>  arch/arm/mach-snapdragon/include/mach/boot0.h      |  2 +
>  .../mach-snapdragon/include/mach/snagboot_boot0.h  | 53 ++++++++++++++++++++++
>  configs/qcom_lemans_snagboot_defconfig             | 45 ++++++++++++++++++
>  drivers/soc/qcom/Kconfig                           | 18 ++++++++
>  drivers/soc/qcom/cmd-db.c                          | 14 +++++-
>  8 files changed, 150 insertions(+), 3 deletions(-)
> ---
> base-commit: e1c3db1f788ed8106840e81b795e030cbe0020b7
> change-id: 20260616-sngboot-760714938d18
> 
> Best regards,

-- 
// Casey (she/her)

