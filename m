Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8224BCD98DA
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 12:37:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE04E8484C;
	Tue, 16 Jun 2026 14:37:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JCKv6YQA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6E6484869; Tue, 16 Jun 2026 14:37:08 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A2E8846A4
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 14:37:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-45eeba68948so3327446f8f.1
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 05:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781613425; x=1782218225; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=etCp7cb3SPQetGrBCYap0n0o5mEQOMyagRJrKwkSU20=;
 b=JCKv6YQA13TEhp8KoC9sgcUMpxUGY/e9FD7JQvnraZUKHQBnG5iFR8xHRh73pfL8il
 AG+ZaJj3+Mo03c65fTOpuzn+C348CVYkyMvSTTpiqsgdzvzZYGltHEIy7ixdV7+rMz/x
 Y2b+5y12bozH0s/KEzadVIJQYS4SCGkY2GfHc/vhEQ4FYQM/pe6P8trtl2p/91QLciwl
 E/5JDMXu62TkqBkp/xJYtqC4h+HEjmw/FxjkTohawZKkny6EdKRHafmtIJ9HH4M231n4
 TekkDjpc2w2YpKgbboBQPcufscs0eFpo51V+U0S07uZRuMa/JYwXZNA837qwRFEgq613
 cuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781613425; x=1782218225;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=etCp7cb3SPQetGrBCYap0n0o5mEQOMyagRJrKwkSU20=;
 b=DZSw0UXJXDDfEvu47FLaSCSJ+DET34REHOZzQ6q03bgUM1jCGfl4mtf2w0ugl6VyP4
 QcQbpkfE5VmQZur4QhnAf5WLEizwWEJd1/mQkrLAEcVaGQV7yUlOOXITuOaYX3a8LXoo
 D0eEpkcPV2Mka8FEJPUwRPtJIXWCNI5siPooiTwg2bp8XRnsgGPwLgGrTWOguardlw8i
 9LWvpBQry1rwB6hQZGGg4lNSZsLKOA8lg9nTvbS60OpuTkCJBbiz1s70utue1vP630lu
 XhEmRDmSgjkDwUxNDLVCZrnVenZUzC0ySNnInxL4y8yLSmyFVWCHlfcxLmTX3yEIC1Im
 Ji6w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+tULF2fjm4wwKA1eGNa0sE7x5tzD+aIRlSM0XKCfP2gGfolYYR0/jXAWVGY5PNFl8ffxbCYaU=@lists.denx.de
X-Gm-Message-State: AOJu0YwCmobrob/J0TSNjVsqHTToyvLzEVpKaZCtb/hyYuHzMAq2+E4y
 ejZIOZIHc8zf9LEIZ5qLCfvIyhf7Yg7eqoPpDYWPFUQatDqPlDkhtO3E7ZUpohnhFxY=
X-Gm-Gg: Acq92OFA2HWzAX9Y/uBzUaHdywMsRGQTsq/zMaw7uaJCMWylCni/TKh6V42ACq+Mj5r
 YHPx/Bb/7U83WmRIt6vAM5RzFNQc5xy9HJ7jUQ+w+r1zfBCbU/M4mJyAXy14J6flBWmr5fK8XVV
 X3BVgwtvRGWRa7uL+toXQaOnx8ZqiQ17bwmQl5L1u3M1S02iwsJDdn6Raqat8NrU7C0oByB37Rb
 KR9j6wc3/x5mycK1gybdKoJooyh+VaeOCaBHcvmeVw0yyHHh7RKkgIIPKqU55kdfbXzmY8Cdwhc
 qPjJ7B2mSJKpOlfUjLvTkRg0TamCip1zT1n8md0hg3BzfeiS3BsPumni/K2E4OZ0vNB3RYG234v
 IxevwspcRCyaWI7YhChUYZ+7yBlxt7TB10XuRKEyg8Yykrj0zeWRZDeBI8hYnhfILcqQ2DZaZyR
 S4OPTW4ax2nnMw+Dte+T37y++oeKt2okfQKE/1cNdu0I+/jKWwTxUxvJ44fykGE+I=
X-Received: by 2002:a5d:628d:0:b0:460:6b0e:a75e with SMTP id
 ffacd0b85a97d-4619f38d01cmr4738292f8f.16.1781613424694; 
 Tue, 16 Jun 2026 05:37:04 -0700 (PDT)
Received: from [192.168.1.36] (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f309sm41489557f8f.14.2026.06.16.05.37.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 05:37:04 -0700 (PDT)
Message-ID: <92d1a9f5-9bd7-42d6-8097-c1b6b96e6892@linaro.org>
Date: Tue, 16 Jun 2026 14:37:02 +0200
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

It's clear from the patches that this series will not apply, and you
haven't indicated any dependencies.

Please list them in the cover letter in the next revision, for now
having that list in a reply here would be helpful.

> 
> Snagboot is an open-source, scriptable flashing framework that provides
> an alternative to the proprietary Firehose protocol for device
> provisioning. Like the traditional EDL+Firehose flow, Snagboot uses the
> Qualcomm boot ROM recovery mode (EDL) and Sahara protocol to download
> and execute bootloaders. However, instead of using the proprietary
> Firehose programmer, Snagboot loads U-Boot into DDR and uses the
> standard fastboot protocol for device flashing.
> 
> The framework consists of three modular components: snagrecover
> (downloads XBL/QCLib to initialize DDR and load U-Boot into RAM),
> snagflash (communicates with U-Boot over USB using fastboot to flash
> system images), and snagfactory (orchestrates parallel factory
> flashing tasks).
> 
> In the snagboot execution flow, ROM code in recovery mode loads
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

