Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29B3C9EC8B
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 13:29:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17CE283935;
	Mon, 12 Jan 2026 14:29:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Nj2++du1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50F188393F; Mon, 12 Jan 2026 14:29:29 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C58A8388D
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 14:29:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-64fabaf9133so11581466a12.3
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 05:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768224567; x=1768829367; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r+Pl8SFjWaAP+6Xrddghl4NPvXPauJ8BYmWEVjzIVB8=;
 b=Nj2++du1P/Jtfh3h50rWTMO52GAX15tleV0KOipwh+4lq1jt3wUJl0s+VGkEimlMYa
 8jc8cIzqI34sNC/dGOKs9DFAEwI90e6WQmq+83oUT4MOxzBvwKG7HBu5Bccj45CXDKCc
 8Py9eEozWneTFWp0259xtqj54y1UldOZQwl5gWxvKti+1eN4DJ84hQGhLhUbyzPoMTPL
 VLRY0/g5zAwDce/F88PkWv9KDTta1UKG9JquRg/7mnfaTPuGFUnfUCU6jtb3TIau3gHI
 wHR/Blkv18YuJknF7DMcPFdzo3V2Q8suk+0nH4BbOnOtO2gAz806slG8/GALfoBe0tfZ
 W4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768224567; x=1768829367;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r+Pl8SFjWaAP+6Xrddghl4NPvXPauJ8BYmWEVjzIVB8=;
 b=UmulHFs0I5QH2N74EPVmY/UPeY7jTF/qm8wD2K/LG1ckNRo6ymWrTy6kojnWUGyxw+
 2/+kkdJ7kxGnS2W3YjeKHFM9zqUCRxJmTza2ozQLOKxOWhCiWDWPu5KFps0ht5uFFdCy
 aPLopDx/Qd9lnyGgwYeQgXfJg6x5lMTt614hU4405GvzCBz5KVXGgb7WzR/vsiPOxid/
 VinfLDeSAUhi2VxL8RCNlFBNPXnCQ3ShxXIU2t3ItNqhYwZMQgKSJ2XTj/3nFhqS0Rh+
 Q720sRKqcJ9BBnbUAoKg3Pf3DGA6jDaqrTz3tBnw7OfFPFA/eY0/jLs9UvT/I5Fspe9n
 C65g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbz0v8kxV/lRPvn/w8BxU9W9FER9A+YQqUXzklX9KfkmRV7kX633r49hP6sPg+d1wy8LwB5ag=@lists.denx.de
X-Gm-Message-State: AOJu0YwofK12Ze1IiWcTnRrEH6BHCmcQkLs/cDgY6DNp+hg6ASLG3h9z
 mg1tuJ+nL38VfYeOuswFQnkHHozduAO7SQ21KPWEiyiX9HyzUjQ3iycYNDSA6wNwVfI=
X-Gm-Gg: AY/fxX5Z9iFmYMNx4/b3BPnkBHl3OxHxIcvUPC1ffxjB/NEHLbfZsNc6vpPKFe6dqsV
 QNWYoFAuOAMb1/haUrz5a791EUU3exh1WoBFFXNy9pLPDhNyX7GYcqUgumW5UEGvPtPCvKbLUTt
 nnE6Xjp5QGV7uGwFHODpc6ZpyfWU78g0O4YPIF7ILYNz82mzMJoNfSMIXA0qLbB0PMMMnvB6z3C
 HnFBiTeBoxP/BvJZ74nwTbNuULCNvY4CeXJGiY44IKHoKJLwgKmen4TBgFiHi+YmtfrD+gHfHcu
 neQAx3g2dhpKDZZr9N1plEPTJDQIjgcKpMz5iN+BNJp1qksh5zzjuNrNmrNNQtooD/CsqN8dcGw
 wEy8yxk4r9TErIRgdFoybCpza5iJKBtFm4mmyr9lWzNqbZfJ84uwka6a8dmhktx8SsvBZwmQXSP
 k8uWU9p6/DFHlVREiSdmQvADNn3C2/QXZmw4ymVmApMCBHruS6oWc=
X-Google-Smtp-Source: AGHT+IHsySNCVmaI/tdgPc5Eu3EJ7/LdFQ6BLXMcqqBntcOxUV09y982pFR+cat9sBhA5X8/pA0buA==
X-Received: by 2002:a17:907:7742:b0:b87:1eaf:377c with SMTP id
 a640c23a62f3a-b871eaf3facmr188914866b.38.1768224566696; 
 Mon, 12 Jan 2026 05:29:26 -0800 (PST)
Received: from [192.168.1.36] (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a27c0casm1930270366b.19.2026.01.12.05.29.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 05:29:26 -0800 (PST)
Message-ID: <d3cfe794-9d0e-4a0a-bd17-d48b6220e6b3@linaro.org>
Date: Mon, 12 Jan 2026 14:29:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] sysreset: Implement PSCI based reset to EDL mode
 for QCOM SoCs
Content-Language: en-US
To: Varadarajan Narayanan <quic_varada@quicinc.com>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 ilias.apalodimas@linaro.org, marek.vasut+renesas@mailbox.org,
 jerome.forissier@linaro.org, sjg@chromium.org,
 patrick.rudolph@9elements.com, clamor95@gmail.com, me@samcday.com,
 robert.marko@sartura.hr, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250613051957.3159564-1-quic_varada@quicinc.com>
 <20250613051957.3159564-4-quic_varada@quicinc.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250613051957.3159564-4-quic_varada@quicinc.com>
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



On 13/06/2025 07:19, Varadarajan Narayanan wrote:
> Implement request_arg() sysreset_op for QCOM SoCs that use
> PSCI to reset to EDL (Emergency Download) mode.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
> v4: * Check if ARM_PSCI_1_1_FN64_SYSTEM_RESET2 is supported before
>       issuing it
> 
> v3: * Move argument handling to a separate function and pass the
>       arguments to the actual handler to process
>     * Drop Qcom specific SYSRESET_EDL from the common enum
> 
> v2: * Update commit message
>     * Elaborate Kconfig help text
>     * Use '-edl' instead of 'edl' for consistency with other arguments of reset
>       command
>     * Remove 'weak' for qcom_psci_sysreset_get_status() and make it static
>     * Mention 'SYSRESET_EDL' is Qcom specific in the enum's comments
> ---
>  drivers/firmware/psci.c               |  4 +++
>  drivers/sysreset/Kconfig              |  6 ++++
>  drivers/sysreset/Makefile             |  1 +
>  drivers/sysreset/sysreset_qcom-psci.c | 45 +++++++++++++++++++++++++++
>  4 files changed, 56 insertions(+)
>  create mode 100644 drivers/sysreset/sysreset_qcom-psci.c
> 
> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> index 2e3223e1c32..b6838a244d2 100644
> --- a/drivers/firmware/psci.c
> +++ b/drivers/firmware/psci.c
> @@ -186,6 +186,10 @@ static int psci_bind(struct udevice *dev)
>  					 NULL);
>  		if (ret)
>  			pr_debug("PSCI System Reset was not bound.\n");
> +		if (IS_ENABLED(CONFIG_SYSRESET_QCOM_PSCI) &&
> +		    device_bind_driver(dev, "qcom_psci-sysreset",
> +				       "qcom_psci-sysreset", NULL))
> +			pr_debug("QCOM PSCI System Reset was not bound.\n");
>  	}
>  
>  	/* From PSCI v1.0 onward we can discover services through ARM_SMCCC_FEATURE */
> diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
> index aa83073c96a..894c3d38b26 100644
> --- a/drivers/sysreset/Kconfig
> +++ b/drivers/sysreset/Kconfig
> @@ -292,6 +292,12 @@ config SYSRESET_RAA215300
>  	help
>  	  Add support for the system reboot via the Renesas RAA215300 PMIC.
>  
> +config SYSRESET_QCOM_PSCI
> +	bool "Support reset to EDL for Qualcomm SoCs via PSCI"
> +	help
> +	  Add support for the reset to EDL (Emergency Download) on Qualcomm
> +	  SoCs via PSCI.
> +
>  config SYSRESET_QCOM_PSHOLD
>  	bool "Support sysreset for Qualcomm SoCs via PSHOLD"
>  	help
> diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
> index f5c78b25896..8bb1eabd48e 100644
> --- a/drivers/sysreset/Makefile
> +++ b/drivers/sysreset/Makefile
> @@ -30,5 +30,6 @@ obj-$(CONFIG_SYSRESET_RESETCTL) += sysreset_resetctl.o
>  obj-$(CONFIG_$(PHASE_)SYSRESET_AT91) += sysreset_at91.o
>  obj-$(CONFIG_$(PHASE_)SYSRESET_X86) += sysreset_x86.o
>  obj-$(CONFIG_SYSRESET_RAA215300) += sysreset_raa215300.o
> +obj-$(CONFIG_SYSRESET_QCOM_PSCI) += sysreset_qcom-psci.o
>  obj-$(CONFIG_SYSRESET_QCOM_PSHOLD) += sysreset_qcom-pshold.o
>  obj-$(CONFIG_TARGET_XTFPGA) += sysreset_xtfpga.o
> diff --git a/drivers/sysreset/sysreset_qcom-psci.c b/drivers/sysreset/sysreset_qcom-psci.c
> new file mode 100644
> index 00000000000..3627bbf5c82
> --- /dev/null
> +++ b/drivers/sysreset/sysreset_qcom-psci.c
> @@ -0,0 +1,45 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2017 Masahiro Yamada <yamada.masahiro@socionext.com>
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <dm.h>
> +#include <sysreset.h>
> +#include <asm/system.h>
> +#include <linux/errno.h>
> +#include <linux/psci.h>
> +#include <asm/psci.h>
> +
> +static int qcom_psci_sysreset_get_status(struct udevice *dev, char *buf, int size)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static int qcom_psci_sysreset_request_arg(struct udevice *dev, int argc,
> +					  char * const argv[])
> +{
> +	if (!strncasecmp(argv[1], "-edl", 4)) {
> +		/* Supported in qcs9100, qcs8300, sc7280, qcs615 */
> +		if (psci_features(ARM_PSCI_1_1_FN64_SYSTEM_RESET2) ==
> +							ARM_PSCI_RET_SUCCESS) {
> +			psci_system_reset2(0, 1);
> +			return -EINPROGRESS;
> +		}
> +		printf("PSCI SYSTEM_RESET2 not supported\n");
> +	}
> +
> +	return -EPROTONOSUPPORT;
> +}
> +
> +static struct sysreset_ops qcom_psci_sysreset_ops = {
> +	.request_arg = qcom_psci_sysreset_request_arg,
> +	.get_status = qcom_psci_sysreset_get_status,
> +};
> +
> +U_BOOT_DRIVER(qcom_psci_sysreset) = {
> +	.name = "qcom_psci-sysreset",
> +	.id = UCLASS_SYSRESET,
> +	.ops = &qcom_psci_sysreset_ops,
> +	.flags = DM_FLAG_PRE_RELOC,
> +};

-- 
// Casey (she/her)

