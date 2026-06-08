Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF161CD8C9D
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 16:46:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D4038466E;
	Mon,  8 Jun 2026 18:46:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qeXalmK1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EADFB846A7; Mon,  8 Jun 2026 18:46:53 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BB008407D
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 18:46:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-bf0170c80f7so750664166b.3
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 09:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780937209; x=1781542009; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7VHPxvY/sgzXZ66ABYl0rRTkjuE3ollcmsbeP/BXiEc=;
 b=qeXalmK11XaKoCA6LWEp/pYcbpg8LJGhQvfLzGBsuv4FM6S36A4Mlr3IsXmu+5vh4+
 rH4ox2Eg/Ck0E+ngQwNEjNuhXF3+r8mFixhj2XT+VLKXyDbIrFVPWElwjhteCcDTlUgn
 OenIJWerskHPQXDJNEcj1Z7tJOgkK5MT3PNmcXMMYAB/GgJlcXzeSKj2gYRuYenYmXJs
 LFf4kSrjkla0QIjcRBVH8U38kZxZZypSpAdmzsh0Ez05UywLiOpPCsQGfvVpuXK4rVzV
 33cqnkIz/GhoF1UoCyf9AOJoUVBVA/oShumqBGmrSkr+SpVjAn4HtQ9IRjrDvDBK8L8Z
 lJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780937209; x=1781542009;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7VHPxvY/sgzXZ66ABYl0rRTkjuE3ollcmsbeP/BXiEc=;
 b=qAeblOTqFwMYrJnaF7GPnC+ocm2yyzqIh1iJizWug4SYRXgpqImNHdKOigNv6tS87Z
 vneM1vhxVnYZNdPI+9NXC6f5BuT9Dv9OjQdeihmRTqrAKHi5q/lkB9WbmWAv6DgZsaa4
 8OdnhLWiTz06f4Gy2tVLgRkbMuQJVY5mK3C+1yZ9jCrrwgrB4TrWFKO/oB8rOfgKDkoX
 DNrnD4h1HpaHCcR+5Iy0c9poA9d79jo9l8MN5SihrfgVmNJEOxDQg4WVlFOgwrDrUl5Z
 LbM2waL6KdLrE8TK7kx7tWKtnDnw55zs4N0BXQjTYGDShqRUwR8/rCyY+cABVREEM7wx
 yq/g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+sK0XiTkTd70PdKSB73dJmjdtHo4FiK4944Q7nrJS8wwHQ16+OPNcFenDV24UIo0YirtfhwIQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxCtj9OPVX6X9Yigc5Q563XRmw5xWqLutKAhi4iFi68fSZBV3S3
 n2K6CsfZvDaU/fo3ryA7Qml3bLSZzsMlLSs08Iv7j2LXN1rf2Q+GpUgQkGzOc9XLfzw=
X-Gm-Gg: Acq92OEq4NFSyFMqtEwhA7AAXpM3ghdm/kTHaNXPSW9V64HX9s2OOuJP/eRJNX4EM5G
 PhlP3Kdy2o8xolITPLb5DBvWLA0ayqHuLnDegPjMJRgnxdWvzipuKIGu3vrcrDEgE3pWltivtDZ
 JGq7tVeQAyCxBMFKFeFWugTjU0PiuOs18pVDSa4g0rgbbwnoQr8Z/WzcVl8vforqPK5kglhTAfH
 jMRNq2amwwYYVrAha+CSJCwOsUipaSErgKzN2HijrWT4wSfyW0Ki40oR49EHIIq92/6GqKk/Gr8
 3LlLK6XK6ndp4bGrrLBWyJsrPNqmTJWEt+XYS63emRODvs2hTrsOcObL3NYi4Hxp39KNyS0wMUn
 6EX5kFFDoRyh/lkWMZqvUGyAu2ma8oDQJkjEENgCcBEeufWTTJZqRwkf4F5QcoTc7+Q5UUY3iAY
 7no79b1hUiWo9JFFoWA3saNokjy98oJQWVVyuO1SsLe8ails+RCSnc2QGGgldru3n0qBzFga92a
 A==
X-Received: by 2002:a17:907:75f7:b0:bed:f7d3:6211 with SMTP id
 a640c23a62f3a-bf373cf33dbmr587794366b.45.1780937209479; 
 Mon, 08 Jun 2026 09:46:49 -0700 (PDT)
Received: from [192.168.1.36] (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf0517712a7sm902946166b.4.2026.06.08.09.46.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 09:46:48 -0700 (PDT)
Message-ID: <6bb3db66-b04e-426e-8643-9a36436350aa@linaro.org>
Date: Mon, 8 Jun 2026 18:46:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] arm: snapdragon: Add snagboot support for
 Lemans-EVK
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Anshul Dalal <anshuld@ti.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Alice Guo
 <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 George Chan <gchan9527@gmail.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>, Kory Maincent <kory.maincent@bootlin.com>,
 Yao Zi <me@ziyao.cc>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>
References: <20260608-snagboot-v2-0-036bb0343bf7@oss.qualcomm.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260608-snagboot-v2-0-036bb0343bf7@oss.qualcomm.com>
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

On 08/06/2026 11:06, Balaji Selvanathan wrote:
> This series adds support for running U-Boot in snagboot mode on
> Qualcomm Snapdragon platforms, targeting the Lemans-EVK board.
> 
> In snagboot mode, XBL loads U-Boot directly without initializing
> PSCI firmware or populating the Command DB. U-Boot then enters
> fastboot immediately, enabling partition flashing for manufacturing
> and recovery use cases.

Is this for building a firehose binary with U-Boot? Some additional
explanation of what this is and why/how it should be used would be good.

Kind regards,

> 
> Patch 1 changes SYSRESET_PSCI from 'select' to 'imply' so it can
> be disabled on platforms where PSCI firmware is unavailable.
> 
> Patch 2 guards show_psci_version() and qcom_psci_fixup() with
> CONFIG_ARM_SMCCC to prevent build failures when SMCCC is disabled.
> 
> Patch 3 disables the MMU and invalidates TLBs at the earliest entry
> point to clear stale page tables left by previous bootloader
> before U-Boot sets up its own MMU.
> 
> Patch 4 adds QCOM_COMMAND_DB_OPTIONAL to allow the CMD DB driver to
> bind successfully when CMD DB data is not populated by XBL, logging
> a warning instead of failing.
> 
> Patch 5 adds qcom_lemans_snagboot_defconfig for Lemans-EVK, based
> on qcom_defconfig with snagboot-specific settings: SCSI-backed
> environment, optional CMD DB, PSCI reset disabled, and a bootcmd
> that auto-enters fastboot over USB with zero boot delay.
> 
> Patch 6 adds the new defconfig to the ARM SNAPDRAGON section in
> MAINTAINERS.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
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
>       arm: snapdragon: Disable MMU early before U-Boot reset vector
>       soc: qcom: cmd-db: Allow boot without CMD DB data
>       configs: add qcom_lemans_snagboot_defconfig for Lemans-EVK
>       MAINTAINERS: add qcom_lemans_snagboot_defconfig to ARM SNAPDRAGON
> 
>  MAINTAINERS                                   |  1 +
>  arch/arm/Kconfig                              |  2 +-
>  arch/arm/mach-snapdragon/board.c              | 14 ++++++++
>  arch/arm/mach-snapdragon/include/mach/boot0.h | 46 +++++++++++++++++++++++++
>  configs/qcom_lemans_snagboot_defconfig        | 49 +++++++++++++++++++++++++++
>  drivers/soc/qcom/Kconfig                      | 16 +++++++++
>  drivers/soc/qcom/cmd-db.c                     | 10 ++++++
>  7 files changed, 137 insertions(+), 1 deletion(-)
> ---
> base-commit: 26fe27b4eaddcf73e4472368a71703a68e2f67d9
> change-id: 20260608-snagboot-df4b6a79a086
> 
> Best regards,

-- 
// Casey (she/her)

