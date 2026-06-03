Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE88CD6E55
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 14:12:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 883E48467E;
	Wed,  3 Jun 2026 16:12:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rjwW0vFi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 778C58469D; Wed,  3 Jun 2026 16:12:54 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C343F83EF9
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 16:12:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-45eea68dd6fso3614785f8f.2
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 07:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780495971; x=1781100771; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HwcfjYtg2Rs4VY5DrItbosRAMhNJO49xCDVEjfVYPzA=;
 b=rjwW0vFiijErMuQ9C5QQftM3Z96kgS8C9IT6P9SsmlslV9LW3kPU9WH2XYei0HMMLI
 pIQIVpsTW8AXCtgGK8b5M2SZcNR7Yxi7YZNa8dA/cYKBq0owJq1Trb7Ju8/cnwnXbt6s
 Gzw8e9oSBwrnyK9P+ZA3mJauifmwfFbrwvA0X+0XsRN0+l2H6Y8wC5G19HrWqNaYH5WB
 r25yH/S1wAZv9rgSiXuUIzcnH2oQJFU2NzexC7pN26xZVQbfhKfRvW9xwCv4Gml/rnmJ
 SmSezo05cgqWQceeMzueUELrpsEHtWvok7ruIrbLTtDYSnlH7edU6C2clUoEu7+g07Pd
 2ZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780495971; x=1781100771;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HwcfjYtg2Rs4VY5DrItbosRAMhNJO49xCDVEjfVYPzA=;
 b=HwiJ8pn7UzekoqKHan2x8daON1P3jUSpF4yNBtX0rzw07JJizagtrryMiEWBDLafU7
 Xo1IOvbAOSqjY1n3DuvxfhWOVC9VQLt3t7V5mBa1PxQqMkU9ONIwUc2C9icjp6gAoPfR
 3bW07UbI15qCCsx+mZeI9nrU8JeHMY2VHRpCZAmFoHf/5C8Cb25vZkMjktiPxHtXJazs
 mtfoqpGQJ7d/yS07pIcqtsTuszZu6vQYUAT9o4XhuU84g2aR3LE94kZDHFMjC387buyJ
 xA2cjnQkGS+il9JpDzA3coH5wLGVhyAb37XGzszI22MUj1GjjunbdDf1Cvp4duE0YuE7
 ArJQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8mBZ9S9V7MuOtGaEzkGDz2SgqIFqtaffPXhkvlMwtjvq16y8Uj9CoFpyJ8Ur8dWhGkJDJyYgM=@lists.denx.de
X-Gm-Message-State: AOJu0YwFP5Wj72JhW87/1+46WeOoh5xpB8UYJBDB1wslMWNQB5khXqI7
 Nn3kNm2SoSPzaNzczEOKUH3In/njImH51/F8ehb4HpRlp2Ffw2sYjH0FDg//r0LRYtU=
X-Gm-Gg: Acq92OGrIatQTC+zW3vKuXIngvIueUrZrrprKXKIK33EPfDoNhWWpzc8+X2dM/YXfO4
 MjJYVu+qlIcBeyG1qBRjYEZmojau9Eg0R1IiVU0e1VNahaSx4U6qcS5vcxiyz7kJBMX8Ax4yWYd
 ExB1vTOxWB6cc5J0ILtB9e66XvqcMbtoDFV75Z1S5lEimR8EnYMP2knVAe9En+EkTf+HkyA/iz0
 bzggfjmX91+5TUFdf64iyNCPVs4p3gCeAaY9ppjqaCeuj5Q1q5MJ1Uyfi2GfZlFqXbAFwbBHW2S
 6DCp2dreL6RBFAU7EtUS8EBk7Ol79+U8jqHnKTtNNY0g2HlRJVMRD0wRGFMM2BJK0tENBdNOzHz
 F7wT/HbP6i+Hl8wn6p1/0R+UcaiiGYYBXrvXYzwCAFO8nKdr+VPes4qbiLOqTKsw/SOOhcCvpMU
 oeJS+h1aFnFs4bwsXoR8ap4fnmKptIByk1LymfuTW6WvhHt7/fzcODqPN6
X-Received: by 2002:a05:6000:4692:b0:460:2477:2277 with SMTP id
 ffacd0b85a97d-4602477246dmr1624058f8f.31.1780495971007; 
 Wed, 03 Jun 2026 07:12:51 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff23:4410:d5ad:2604:b045:5b80])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f344762sm8669886f8f.23.2026.06.03.07.12.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 07:12:50 -0700 (PDT)
Date: Wed, 3 Jun 2026 16:12:48 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: me@samcday.com
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Sumit Garg <sumit.garg@kernel.org>,
 Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Simon Glass <sjg@chromium.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>,
 Peng Fan <peng.fan@nxp.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 5/6] mach-snapdragon: MSM8916 spin-table CPU boot
 support
Message-ID: <aiA2YFnFBLJKahGU@linaro.org>
References: <20260602-msm8916-smp-support-v2-0-792e53dac374@samcday.com>
 <20260602-msm8916-smp-support-v2-5-792e53dac374@samcday.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-msm8916-smp-support-v2-5-792e53dac374@samcday.com>
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

On Tue, Jun 02, 2026 at 05:19:01PM +1000, Sam Day via B4 Relay wrote:
> From: Sam Day <me@samcday.com>
> 
> Most MSM8916 devices lack PSCI support, instead they're brought online
> with a qcom SCM call to set the boot address, and some register poking
> of the APCS register block.
> 
> Signed-off-by: Sam Day <me@samcday.com>
> ---
>  arch/arm/mach-snapdragon/Makefile      |   1 +
>  arch/arm/mach-snapdragon/msm8916-smp.c | 138 +++++++++++++++++++++++++++++++++
>  2 files changed, 139 insertions(+)
> 
> diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
> index 343e825c6fd..584b8af055a 100644
> --- a/arch/arm/mach-snapdragon/Makefile
> +++ b/arch/arm/mach-snapdragon/Makefile
> @@ -5,3 +5,4 @@
>  obj-y += board.o
>  obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += capsule_update.o
>  obj-$(CONFIG_OF_LIVE) += of_fixup.o
> +obj-$(CONFIG_ARMV8_SPIN_TABLE) += msm8916-smp.o
> diff --git a/arch/arm/mach-snapdragon/msm8916-smp.c b/arch/arm/mach-snapdragon/msm8916-smp.c
> new file mode 100644
> index 00000000000..24f5590ccc3
> --- /dev/null
> +++ b/arch/arm/mach-snapdragon/msm8916-smp.c
> @@ -0,0 +1,138 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * On MSM8916 devices that lack a PSCI implementation, firing up the secondary
> + * cores requires a call to TZ to set the boot address, and some poking of ACPS
> + * register block.
> + *
> + * Copyright (c) 2025 Linaro Ltd.
> + */

Was Linaro involved in this in 2025? Did you write the code yourself
(the init sequence, especially) or take it over from somewhere else?
Would be good to be precise here.

> +
> +#include <asm/io.h>
> +#include <asm/spin_table.h>
> +#include <asm/system.h>
> +#include <cpu_func.h>
> +#include <dm/ofnode.h>
> +#include <firmware/qcom/scm.h>
> +#include <linux/arm-smccc.h>
> +#include <linux/delay.h>
> +
> +#define APCS_CPU_PWR_CTL	0x04
> +#define CORE_PWRD_UP		BIT(7)
> +#define COREPOR_RST		BIT(5)
> +#define CORE_RST		BIT(4)
> +#define CORE_MEM_HS		BIT(3)
> +#define CORE_MEM_CLAMP		BIT(1)
> +#define CLAMP			BIT(0)
> +
> +#define APC_PWR_GATE_CTL	0x14
> +#define GDHS_CNT_SHIFT		24
> +#define GDHS_EN			BIT(0)
> +
> +static void qcom_boot_cortex_a53(phys_addr_t acc_base)
> +{
> +	u32 reg_val;
> +
> +	/* Put the CPU into reset. */
> +	reg_val = CORE_RST | COREPOR_RST | CLAMP | CORE_MEM_CLAMP;
> +	writel(reg_val, acc_base + APCS_CPU_PWR_CTL);
> +
> +	/* Turn on the GDHS and set the GDHS_CNT to 16 XO clock cycles */
> +	writel(GDHS_EN | (0x10 << GDHS_CNT_SHIFT), acc_base + APC_PWR_GATE_CTL);
> +	/* Wait for the GDHS to settle */
> +	udelay(2);
> +
> +	reg_val &= ~CORE_MEM_CLAMP;
> +	writel(reg_val, acc_base + APCS_CPU_PWR_CTL);
> +	reg_val |= CORE_MEM_HS;
> +	writel(reg_val, acc_base + APCS_CPU_PWR_CTL);
> +	udelay(2);
> +
> +	reg_val &= ~CLAMP;
> +	writel(reg_val, acc_base + APCS_CPU_PWR_CTL);
> +	udelay(2);
> +
> +	/* Release CPU out of reset and bring it to life. */
> +	reg_val &= ~(CORE_RST | COREPOR_RST);
> +	writel(reg_val, acc_base + APCS_CPU_PWR_CTL);
> +	reg_val |= CORE_PWRD_UP;
> +	writel(reg_val, acc_base + APCS_CPU_PWR_CTL);

Nitpick (might be fine as-is, since Linux seems to have the same):
Strictly speaking, I think we need some memory barriers / DSBs in here
to make sure the write is complete before the udelay() starts (although
this is notoriously hard. If you're interested in this, take a look at
https://youtu.be/i6DayghhA8Q?t=1677, although I think it doesn't
translate exactly to U-Boot).

> +}
> +
> +static int qcom_scm_set_boot_addr_mc(void *entry, unsigned int flags)
> +{
> +	struct qcom_scm_desc desc = {
> +		.svc = QCOM_SCM_SVC_BOOT,
> +		.cmd = QCOM_SCM_BOOT_SET_ADDR_MC,
> +		.owner = ARM_SMCCC_OWNER_SIP,
> +		.arginfo = QCOM_SCM_ARGS(6),
> +		.args = {
> +			(u64)entry,
> +			/* Apply to all CPUs in all affinity levels */
> +			~0ULL, ~0ULL, ~0ULL, ~0ULL,
> +			flags,
> +		},
> +	};
> +
> +	if (!qcom_scm_is_call_available(desc.svc, desc.cmd))
> +		return -EOPNOTSUPP;
> +
> +	return qcom_scm_call(&desc, NULL);
> +}
> +
> +static bool boot_addr_set;
> +
> +int spin_table_boot_cpu(void *fdt, int cpu_offset)
> +{
> +	struct fdtdec_phandle_args acc;
> +	u32 mpidr_aff, acc_base, reg;
> +	int ret;
> +
> +	if (fdt_node_check_compatible(fdt, 0, "qcom,msm8916"))
> +		return 0;

What if we have a qcom,apq8016? :)

> +
> +	reg = fdtdec_get_uint(fdt, cpu_offset, "reg", 0);
> +
> +	if (fdt_node_check_compatible(fdt, cpu_offset, "arm,cortex-a53")) {
> +		log_warning("CPU%d is not arm,cortex-a53 compatible\n", reg);
> +		return -EINVAL;
> +	}
> +
> +	if (!boot_addr_set) {
> +		debug("Setting CPU boot address to 0x%llx\n",
> +		      (phys_addr_t)&spin_table_reserve_begin);
> +		ret = qcom_scm_set_boot_addr_mc(&spin_table_reserve_begin,
> +						QCOM_SCM_BOOT_MC_FLAG_AARCH64 |
> +						QCOM_SCM_BOOT_MC_FLAG_COLDBOOT);
> +		if (ret) {
> +			log_err("Failed to set CPU boot addr: %d\n", ret);
> +			return ret;
> +		}
> +
> +		boot_addr_set = true;
> +	}

I would move this below log_info("Booting CPU"), so you don't waste
doing this for nothing if one of the other check fails.

> +
> +	mpidr_aff = read_mpidr() & 0xffffff;
> +
> +	if (reg == mpidr_aff) {
> +		debug("Skipping boot of current CPU%d\n", reg);
> +		return 0;
> +	}
> +
> +	ret = fdtdec_parse_phandle_with_args(fdt, cpu_offset, "qcom,acc",
> +					     NULL, 0, 0, &acc);
> +	if (ret) {
> +		log_err("Failed to parse qcom,acc phandle: %d\n", reg);
> +		return ret;
> +	}
> +
> +	acc_base = fdtdec_get_addr_size_auto_noparent(fdt, acc.node, "reg", 0,
> +						      NULL, true);
> +	if (!acc_base) {
> +		log_err("Failed to parse qcom,acc regbase\n");
> +		return -EINVAL;
> +	}
> +
> +	log_info("Booting CPU%d @ 0x%x\n", reg, acc_base);
> +	qcom_boot_cortex_a53(acc_base);
> +	return 0;
> +}

Thanks,
Stephan
