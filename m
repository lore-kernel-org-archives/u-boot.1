Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 057B4C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 11:49:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25EA680F4C;
	Tue, 18 Mar 2025 12:49:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fwkPbyVK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 348A2811BB; Tue, 18 Mar 2025 12:49:18 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50DDC800B3
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 12:49:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-391342fc1f6so4559380f8f.1
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 04:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742298555; x=1742903355; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g62PMbm0mu44KpGO9CyNA0NRphug1fvNr49b8ljyVqA=;
 b=fwkPbyVKqWklK9B8O975GWbLhgLzThYeUVLYVyXWuhwIH06foWeUzp17hBX9fVdHb9
 hMBvjuZbqSkamt5vdRvm9P0XX6Z5vo89/3lGeZv4rWsk1JahRv344OFFef6R82I+NGGV
 /QzRfu8aUJHTaIAkSJySCeeUVnS2A1ZabapjwfgDuKaxVxubcwfjUbwpmgCMTA4x2yCr
 /y/gMjmWmV1Ek/kYKIl7pTVriVArukYdbS2iBEXxh4vcDCEt4N0TgYuvKFSz0us9as0o
 Hl5OEgps3gr9ML6VLcmnzz825rWsUNPy3BhEJAHHr6GeY8bKyhRMfN7UpK8uBqiCgf2e
 1dWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742298555; x=1742903355;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g62PMbm0mu44KpGO9CyNA0NRphug1fvNr49b8ljyVqA=;
 b=ZkC0ZEfYe4Z7HVbvm+QNTKd2pakKZiP/BLeqygPIKYhMI43G2e7NenXrDNRpfx+5Ii
 ZC8FAWsha18Q/b+mw3AM/kg6ukD/ruQvrkIRjlSdhI7l4ak3hN998BAynw05nxlBTVbT
 M8sjcgYN8NAgEZFQZ0JsRBnNWL7OB1k+X6iIBHl/3JaVHhEHPQC7v/4TH6mcxh0qy/9D
 akKSuYTZ+zH9mKjtI7M5OBSn6yuQD6DU/qzX1OMAFeggj8FHUNMmh0pJ/Cb/8hJCvswr
 /m/4ONRNmFHrsbam7sk9tbLFH3UPLLXoU7yU7znkJ2v51c0Luf37DCugadDBZYSoqoPn
 7B7w==
X-Gm-Message-State: AOJu0Yw7/7xtlwznzpdPBhLXy7bFT+ODGqltrGaA9Ygiq3eThE9eLrfU
 GiO2NXvL5pqrQTu6IUe2/3eKspOpNHKR2HUHSg3LCg0M5tzm1K8ojUMtsp8AbU0=
X-Gm-Gg: ASbGncv3Tbl9FTgGEQMMAaul0ixja5D8Bbg1Y6OmPJp38GLrv92PYbDUPZuRH1M1cXv
 z2wtfyEn0aavTp5mI9f8+haMSAYEmgpbdqmiy5VoGt21RL7ODynrjfQ7LtvuD2xHuKsGsak6FEk
 2uX67yFozd7ux8Ak320jVA90SN+Pz/wL1TExtHUy9G/HkhD2hHshQj07qCKk8csIdc1dCuevdTU
 dDe3VyqhGQSEH8hiP8chkTi5jc7yF0r21XktZog41S9s49yxEljep9m7/m0Pn+eDEddD/xh5JLH
 +6vY98PCWXVD94VkwcKLyeuu6hpLAxUOqKhzRA0Z0UJxy4H97dqBFo+AmrVFolnRm0BLLxoYlGp
 1XUaFZqtjakcazWIhptftV+ykrA==
X-Google-Smtp-Source: AGHT+IFCqYntxi4OyGpmUc5vCKMm/nRAMzHd5wIvytcUe1te6CB0piXyNMJELYhlwvE49RxcZbUbqw==
X-Received: by 2002:adf:a35e:0:b0:38d:d0ea:b04c with SMTP id
 ffacd0b85a97d-3971ee43fa0mr16838195f8f.38.1742298554595; 
 Tue, 18 Mar 2025 04:49:14 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1d11:ab01:2c08:4dd1:926c:85e7?
 ([2a0a:ef40:1d11:ab01:2c08:4dd1:926c:85e7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c83b6a27sm18123787f8f.31.2025.03.18.04.49.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 04:49:13 -0700 (PDT)
Message-ID: <83e763c9-ab18-4f6f-a247-ddcb9f2739bc@linaro.org>
Date: Tue, 18 Mar 2025 11:49:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] mach-snapdragon: qcom SCM call support
To: Sam Day <me@samcday.com>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250128-msm8916-smp-support-v1-0-39587f18cf0c@samcday.com>
 <20250128-msm8916-smp-support-v1-3-39587f18cf0c@samcday.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250128-msm8916-smp-support-v1-3-39587f18cf0c@samcday.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 1/27/25 23:03, Sam Day wrote:
> These calls are a little more complex than a standard SMCCC instruction.
> There's 32bit/64bit calling conventions, support for passing more
> arguments than can fit in the usual registers (by placing a pointer to
> the additional args in x7), and the use of a qcom-specific smccc quirk.

Hi Sam,

This patch kinda slipped me by heh

I actually have a port of this locally that I just haven't gotten around 
to cleaning up and sending...

I think it's probably the right move to simplify it as you're doing 
here, so I'd be happy to go with this approach, just a few additional 
comments inline.
> 
> Signed-off-by: Sam Day <me@samcday.com>
> ---
>   arch/arm/mach-snapdragon/Makefile   |   1 +
>   arch/arm/mach-snapdragon/qcom-scm.c | 145 +++++++++++++++++++++++++++++++
>   arch/arm/mach-snapdragon/qcom-scm.h | 165 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 311 insertions(+)
> 
> diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
> index 343e825c6fdd05f36e210b138e741b7b7dd606ac..e3b9510d25da040e72aa61668014f4863add6b5a 100644
> --- a/arch/arm/mach-snapdragon/Makefile
> +++ b/arch/arm/mach-snapdragon/Makefile
> @@ -3,5 +3,6 @@
>   # (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
>   
>   obj-y += board.o
> +obj-y += qcom-scm.o
>   obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += capsule_update.o
>   obj-$(CONFIG_OF_LIVE) += of_fixup.o
> diff --git a/arch/arm/mach-snapdragon/qcom-scm.c b/arch/arm/mach-snapdragon/qcom-scm.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..b9ccd1bbb7c1a43d864f2d5f3804836a06607b11
> --- /dev/null
> +++ b/arch/arm/mach-snapdragon/qcom-scm.c

This should go in drivers/firmware/qcom. It doesn't need to be a 
full-fat driver like the Linux one is (binding to the DT node, etc) but 
I think it should be made optional (with stub functions in the header).
> @@ -0,0 +1,145 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2025 Linaro Ltd. */
> +
> +/* Much of this code was adapted from Linux kernel */
> +/* Copyright (c) 2010-2015,2019 The Linux Foundation.	 All rights reserved.
> + */
> +
> +#include "qcom-scm.h"
> +
> +#define QCOM_SCM_EBUSY_WAIT_MS 30
> +#define QCOM_SCM_EBUSY_MAX_RETRY 20
> +
> +#define SCM_SMC_N_REG_ARGS	4
> +#define SCM_SMC_FIRST_EXT_IDX	(SCM_SMC_N_REG_ARGS - 1)
> +#define SCM_SMC_N_EXT_ARGS	(MAX_QCOM_SCM_ARGS - SCM_SMC_N_REG_ARGS + 1)
> +#define SCM_SMC_FIRST_REG_IDX	2
> +#define SCM_SMC_LAST_REG_IDX	(SCM_SMC_FIRST_REG_IDX + SCM_SMC_N_REG_ARGS - 1)
> +
> +/**
> + * struct arm_smccc_args
> + * @args:	The array of values used in registers in smc instruction
> + */
> +struct arm_smccc_args {
> +	unsigned long args[8];
> +};
> +
> +static void __scm_smc_do_quirk(const struct arm_smccc_args *smc,
> +			       struct arm_smccc_res *res)
> +{
> +	unsigned long a0 = smc->args[0];
> +	struct arm_smccc_quirk quirk = { .id = ARM_SMCCC_QUIRK_QCOM_A6 };
> +
> +	quirk.state.a6 = 0;
> +
> +	do {
> +		arm_smccc_smc_quirk(a0, smc->args[1], smc->args[2],
> +				    smc->args[3], smc->args[4], smc->args[5],
> +				    quirk.state.a6, smc->args[7], res, &quirk);
> +
> +		if (res->a0 == QCOM_SCM_INTERRUPTED)
> +			a0 = res->a0;
> +
> +	} while (res->a0 == QCOM_SCM_INTERRUPTED);
> +}
> +
> +static int __scm_smc_do(struct arm_smccc_args *smc, struct arm_smccc_res *res,
> +			bool atomic)
> +{
> +	int retry_count = 0;
> +
> +	do {
> +		__scm_smc_do_quirk(smc, res);
> +
> +		if (atomic)
> +			return 0;
> +
> +		if (res->a0 == QCOM_SCM_V2_EBUSY) {
> +			if (retry_count++ > QCOM_SCM_EBUSY_MAX_RETRY)
> +				break;
> +			mdelay(QCOM_SCM_EBUSY_WAIT_MS);
> +		}
> +	}  while (res->a0 == QCOM_SCM_V2_EBUSY);
> +
> +	return 0;
> +}
> +
> +int qcom_scm_call(const struct qcom_scm_desc *desc,
> +		  enum qcom_scm_convention qcom_convention,

I don't think it's desirable to require the caller to know the calling 
convention. We should use the same detection method Linux does.
> +		  struct qcom_scm_res *res, bool atomic)

For atomic, I think we can just remove this and assume it's always 
false. I haven't seen any calls that are relevant to us that need this, 
I'd rather add it back in the future if necessary.
> +{
> +	int arglen = desc->arginfo & 0xf;
> +	void *args = NULL;
> +	int i, ret;
> +	struct arm_smccc_args smc = {0};
> +	struct arm_smccc_res smc_res;
> +	u32 smccc_call_type = atomic ? ARM_SMCCC_FAST_CALL : ARM_SMCCC_STD_CALL;
> +	u32 qcom_smccc_convention = (qcom_convention == SMC_CONVENTION_ARM_32) ?
> +				    ARM_SMCCC_SMC_32 : ARM_SMCCC_SMC_64;
> +	u32 fnid = SCM_SMC_FNID(desc->svc, desc->cmd);
> +
> +	smc.args[0] = ARM_SMCCC_CALL_VAL(smccc_call_type, qcom_smccc_convention,
> +					 desc->owner, fnid);
> +	smc.args[1] = desc->arginfo;
> +	for (i = 0; i < SCM_SMC_N_REG_ARGS; i++)
> +		smc.args[i + SCM_SMC_FIRST_REG_IDX] = desc->args[i];
> +
> +	if (unlikely(arglen > SCM_SMC_N_REG_ARGS)) {
> +		args = malloc_cache_aligned(SCM_SMC_N_EXT_ARGS * sizeof(u64));
> +		if (!args)
> +			return -ENOMEM;
> +
> +		if (qcom_smccc_convention == ARM_SMCCC_SMC_32) {
> +			__le32 *args32 = args;
> +
> +			for (i = 0; i < SCM_SMC_N_EXT_ARGS; i++)
> +				args32[i] = cpu_to_le32(desc->args[i +
> +							SCM_SMC_FIRST_EXT_IDX]);
> +		} else {
> +			__le64 *args64 = args;
> +
> +			for (i = 0; i < SCM_SMC_N_EXT_ARGS; i++)
> +				args64[i] = cpu_to_le64(desc->args[i +
> +							SCM_SMC_FIRST_EXT_IDX]);
> +		}
> +
> +		smc.args[SCM_SMC_LAST_REG_IDX] = (phys_addr_t)args;
> +		flush_cache((unsigned long)args, SCM_SMC_N_EXT_ARGS * sizeof(u64));
> +	}
> +
> +	ret = __scm_smc_do(&smc, &smc_res, atomic);
> +
> +	if (args)
> +		free(args);
> +
> +	if (ret)
> +		return ret;
> +
> +	if (res) {
> +		res->result[0] = smc_res.a1;
> +		res->result[1] = smc_res.a2;
> +		res->result[2] = smc_res.a3;
> +	}
> +
> +	return (long)smc_res.a0 ? qcom_scm_remap_error(smc_res.a0) : 0;
> +}
> +
> +bool qcom_scm_is_call_available(u32 svc_id, u32 cmd_id,
> +				enum qcom_scm_convention convention)
> +{
> +	u32 fnid = SCM_SMC_FNID(svc_id, cmd_id);
> +	struct qcom_scm_res scm_ret = {0};
> +	struct qcom_scm_desc desc = {
> +		.svc = QCOM_SCM_SVC_INFO,
> +		.cmd = QCOM_SCM_INFO_IS_CALL_AVAIL,
> +		.owner = ARM_SMCCC_OWNER_SIP,
> +		.arginfo = QCOM_SCM_ARGS(1),
> +		.args = {
> +			ARM_SMCCC_CALL_VAL(ARM_SMCCC_STD_CALL, convention,
> +					   ARM_SMCCC_OWNER_SIP, fnid)
> +		},
> +	};
> +	if (qcom_scm_call(&desc, convention, &scm_ret, false))
> +		return false;
> +	return scm_ret.result[0];
> +}
> diff --git a/arch/arm/mach-snapdragon/qcom-scm.h b/arch/arm/mach-snapdragon/qcom-scm.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..053d8b3c8cd44566f62b129e228963a50c678e19
> --- /dev/null
> +++ b/arch/arm/mach-snapdragon/qcom-scm.h

This should be split into the private header (in drivers/firmware/qcom/) 
and a public header in include/firmware/ which contains the API.
> @@ -0,0 +1,165 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* This header was adapted from linux/drivers/firmware/qcom/qcom_scm.h */
> +/* Copyright (c) 2010-2015,2019 The Linux Foundation. All rights reserved.
> + */
> +#ifndef __QCOM_SCM_INT_H
> +#define __QCOM_SCM_INT_H
> +
> +#include <asm/io.h>
> +#include <errno.h>
> +#include <linux/arm-smccc.h>
> +#include <linux/delay.h>
> +#include <linux/types.h>
> +#include <memalign.h>
> +
> +enum qcom_scm_convention {
> +	SMC_CONVENTION_UNKNOWN,
> +	SMC_CONVENTION_LEGACY,
> +	SMC_CONVENTION_ARM_32,
> +	SMC_CONVENTION_ARM_64,
> +};
> +
> +extern enum qcom_scm_convention qcom_scm_convention;
> +
> +#define MAX_QCOM_SCM_ARGS 10
> +#define MAX_QCOM_SCM_RETS 3
> +
> +#define QCOM_SCM_ARGS_IMPL(num, a, b, c, d, e, f, g, h, i, j, ...) (\
> +			   (((a) & 0x3) << 4) | \
> +			   (((b) & 0x3) << 6) | \
> +			   (((c) & 0x3) << 8) | \
> +			   (((d) & 0x3) << 10) | \
> +			   (((e) & 0x3) << 12) | \
> +			   (((f) & 0x3) << 14) | \
> +			   (((g) & 0x3) << 16) | \
> +			   (((h) & 0x3) << 18) | \
> +			   (((i) & 0x3) << 20) | \
> +			   (((j) & 0x3) << 22) | \
> +			   ((num) & 0xf))
> +
> +#define QCOM_SCM_ARGS(...) QCOM_SCM_ARGS_IMPL(__VA_ARGS__, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
> +
> +/**
> + * struct qcom_scm_desc
> + * @arginfo:	Metadata describing the arguments in args[]
> + * @args:	The array of arguments for the secure syscall
> + */
> +struct qcom_scm_desc {
> +	u32 svc;
> +	u32 cmd;
> +	u32 arginfo;
> +	u64 args[MAX_QCOM_SCM_ARGS];
> +	u32 owner;
> +};
> +
> +/**
> + * struct qcom_scm_res
> + * @result:	The values returned by the secure syscall
> + */
> +struct qcom_scm_res {
> +	u64 result[MAX_QCOM_SCM_RETS];
> +};
> +
> +#define SCM_SMC_FNID(s, c)	((((s) & 0xFF) << 8) | ((c) & 0xFF))
> +
> +#define QCOM_SCM_SVC_BOOT		0x01
> +#define QCOM_SCM_BOOT_SET_ADDR		0x01
> +#define QCOM_SCM_BOOT_TERMINATE_PC	0x02
> +#define QCOM_SCM_BOOT_SDI_CONFIG	0x09
> +#define QCOM_SCM_BOOT_SET_DLOAD_MODE	0x10
> +#define QCOM_SCM_BOOT_SET_ADDR_MC	0x11
> +#define QCOM_SCM_BOOT_SET_REMOTE_STATE	0x0a
> +#define QCOM_SCM_FLUSH_FLAG_MASK	0x3
> +#define QCOM_SCM_BOOT_MAX_CPUS		4
> +#define QCOM_SCM_BOOT_MC_FLAG_AARCH64	BIT(0)
> +#define QCOM_SCM_BOOT_MC_FLAG_COLDBOOT	BIT(1)
> +#define QCOM_SCM_BOOT_MC_FLAG_WARMBOOT	BIT(2)
> +
> +#define QCOM_SCM_SVC_PIL		0x02
> +#define QCOM_SCM_PIL_PAS_INIT_IMAGE	0x01
> +#define QCOM_SCM_PIL_PAS_MEM_SETUP	0x02
> +#define QCOM_SCM_PIL_PAS_AUTH_AND_RESET	0x05
> +#define QCOM_SCM_PIL_PAS_SHUTDOWN	0x06
> +#define QCOM_SCM_PIL_PAS_IS_SUPPORTED	0x07
> +#define QCOM_SCM_PIL_PAS_MSS_RESET	0x0a
> +
> +#define QCOM_SCM_SVC_IO			0x05
> +#define QCOM_SCM_IO_READ		0x01
> +#define QCOM_SCM_IO_WRITE		0x02
> +
> +#define QCOM_SCM_SVC_INFO		0x06
> +#define QCOM_SCM_INFO_IS_CALL_AVAIL	0x01
> +
> +#define QCOM_SCM_SVC_MP				0x0c
> +#define QCOM_SCM_MP_RESTORE_SEC_CFG		0x02
> +#define QCOM_SCM_MP_IOMMU_SECURE_PTBL_SIZE	0x03
> +#define QCOM_SCM_MP_IOMMU_SECURE_PTBL_INIT	0x04
> +#define QCOM_SCM_MP_IOMMU_SET_CP_POOL_SIZE	0x05
> +#define QCOM_SCM_MP_VIDEO_VAR			0x08
> +#define QCOM_SCM_MP_ASSIGN			0x16
> +#define QCOM_SCM_MP_SHM_BRIDGE_ENABLE		0x1c
> +#define QCOM_SCM_MP_SHM_BRIDGE_DELETE		0x1d
> +#define QCOM_SCM_MP_SHM_BRIDGE_CREATE		0x1e
> +
> +#define QCOM_SCM_SVC_OCMEM		0x0f
> +#define QCOM_SCM_OCMEM_LOCK_CMD		0x01
> +#define QCOM_SCM_OCMEM_UNLOCK_CMD	0x02
> +
> +#define QCOM_SCM_SVC_ES			0x10	/* Enterprise Security */
> +#define QCOM_SCM_ES_INVALIDATE_ICE_KEY	0x03
> +#define QCOM_SCM_ES_CONFIG_SET_ICE_KEY	0x04
> +
> +#define QCOM_SCM_SVC_HDCP		0x11
> +#define QCOM_SCM_HDCP_INVOKE		0x01
> +
> +#define QCOM_SCM_SVC_LMH			0x13
> +#define QCOM_SCM_LMH_LIMIT_PROFILE_CHANGE	0x01
> +#define QCOM_SCM_LMH_LIMIT_DCVSH		0x10
> +
> +#define QCOM_SCM_SVC_SMMU_PROGRAM		0x15
> +#define QCOM_SCM_SMMU_PT_FORMAT			0x01
> +#define QCOM_SCM_SMMU_CONFIG_ERRATA1		0x03
> +#define QCOM_SCM_SMMU_CONFIG_ERRATA1_CLIENT_ALL	0x02
> +
> +#define QCOM_SCM_SVC_WAITQ			0x24
> +#define QCOM_SCM_WAITQ_RESUME			0x02
> +#define QCOM_SCM_WAITQ_GET_WQ_CTX		0x03
> +
> +#define QCOM_SCM_SVC_GPU			0x28
> +#define QCOM_SCM_SVC_GPU_INIT_REGS		0x01
> +
> +/* common error codes */
> +#define QCOM_SCM_V2_EBUSY	-12
> +#define QCOM_SCM_ENOMEM		-5
> +#define QCOM_SCM_EOPNOTSUPP	-4
> +#define QCOM_SCM_EINVAL_ADDR	-3
> +#define QCOM_SCM_EINVAL_ARG	-2
> +#define QCOM_SCM_ERROR		-1
> +#define QCOM_SCM_INTERRUPTED	1
> +
> +static inline int qcom_scm_remap_error(int err)
> +{
> +	switch (err) {
> +	case QCOM_SCM_ERROR:
> +		return -EIO;
> +	case QCOM_SCM_EINVAL_ADDR:
> +	case QCOM_SCM_EINVAL_ARG:
> +		return -EINVAL;
> +	case QCOM_SCM_EOPNOTSUPP:
> +		return -EOPNOTSUPP;
> +	case QCOM_SCM_ENOMEM:
> +		return -ENOMEM;
> +	case QCOM_SCM_V2_EBUSY:
> +		return -EBUSY;
> +	}
> +	return -EINVAL;
> +}
> +
> +bool qcom_scm_is_call_available(u32 svc_id, u32 cmd_id,
> +				enum qcom_scm_convention convention);
> +
> +int qcom_scm_call(const struct qcom_scm_desc *desc,
> +		  enum qcom_scm_convention qcom_convention,
> +		  struct qcom_scm_res *res, bool atomic);
> +
> +#endif
> 

Kind regards,

-- 
Caleb (they/them)

