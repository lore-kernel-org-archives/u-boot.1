Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D56E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 15:55:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4705E8022B;
	Thu, 19 Dec 2024 16:55:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Un7uM8Jn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16442802B4; Thu, 19 Dec 2024 16:55:14 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDC938021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 16:55:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1734623697; x=1735228497; i=xypron.glpk@gmx.de;
 bh=/tAOiXJlRT/SyuKpI886dAyqmz65tuzSlGFbfcHKh9E=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Un7uM8JnaZOhcDmiDBTcFRPXTprVsHBvPK8V+wkAJH245AQKWZd0ZciQrRuvR8Xv
 TNTJSGcH8KjOIJ+FS8qw3SzEJ2zsi/2eJNaVVMiziCL65MS3Vm4/LB+uCbHf+hI0x
 hwJcg71rP2ykoM9xSdzqOAXV8dUKGvnCYSYKV8xQcyyQZze2lwHmCwb3nwP8Sr3PJ
 AJjonDVRWprQyUHgBwRSsLauOlxtGj4p8duRVFSTpjqFKo6lbuHpsxNe7JtTc171u
 W21q32F5HNhJDynNfrqNwi0NMa+wKWHv+BXHozWqeldq9dIruwIJ3rQUWudOwxmpC
 Ozz5Dk8ElZ18tX6HRA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.104] ([46.114.111.103]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPXhA-1tBbWs3nyU-00QdEb; Thu, 19
 Dec 2024 16:54:57 +0100
Message-ID: <468bd401-f85d-4b76-b513-f775a51ee5ab@gmx.de>
Date: Thu, 19 Dec 2024 16:54:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/10] configs: Enable sysinfo for QEMU Arm64
To: Raymond Mao <raymond.mao@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, Stefan Roese <sr@denx.de>,
 Alexander Gendin <agendin@matrox.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Wan Yee Lau <wan.yee.lau@intel.com>, Jonas Karlman <jonas@kwiboo.se>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Michal Simek <michal.simek@amd.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Peter Robinson
 <pbrobinson@gmail.com>, u-boot@lists.denx.de
References: <20241206225438.13866-1-raymond.mao@linaro.org>
 <20241206225438.13866-11-raymond.mao@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241206225438.13866-11-raymond.mao@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Vp/TsKbFdOnnmnHH4YYzZbHSiwBGa2mVxTyHNe1I74OBoQNzzIM
 ApTLy7Prs7GVOI0+6hvC8tNRuSe/fDjD9NOgy0uj4Gmr4qiJVr5J3xEol3T5dirpE4cSo/L
 xTeOVO0lqsJuilenlmMFvU2Ihi/6RyvZMe8bnYlZI+/Q0p2Td0ZXxfShQCMybS5fVZ2ZtM5
 75WtE/5evnS7sXmYvPI/Q==
UI-OutboundReport: notjunk:1;M01:P0:7MfkrXUhj1Y=;2g/aJGquGuK7AT0Bp3TRGWZQ9YC
 a3RG28eyeM9Df5rFdGJBevSF9XDlTtF3e+2hfIxnWk0PxBQBKLibt+L5EPHACxM6DVu1qyP4u
 /UToQ10BpwqcjYcr6dFR7LsaNO8a/h4wfZ5g2Q5Z3XCW83/UarEZqj/vV9rg/MBLaaCQiSQ10
 dwNfQL4xq4hIrSG4bBvliUyQSn57J6cv9kKweOZvzggqmdC8I5/Z3egii0rr7LWW06MczjimX
 IWErCwUdwLXQWgGoEvxPThPMtXxFiZomZH5PPCBoMJ8mD7lz7ZTABR7Dw9LsADhrNz+9ANYlQ
 t9VROmAglzbKh+Mz8+JsXcs/f9itv5ZUEFLW7KRsH7vfMU3I3i6wJrZHh9HLuvnsdCDyNNpsu
 JhAC5Fm7PPSi8WWgaDKnZvJFlGozsiP+saNyAi40VAno6CWxoe/GiLLaNqEZZmNm4HG/E8v3s
 Vakpr1MLTJ0HXqpQTaYjJwovYN+ErWudkJk9dVG+TS886CBWBcVutfkwt2ZQdkl807+WZmye6
 UD71jlnA4EkRxr4NmPGD/8RLIkUN68zxBCFOHX4/u2/A+A2DGSjE+kJhPqczD6NGrVlrmgt4k
 GZTNwXqWvofDR1CeBxh7KSJPbjibu4MdRYDQQMDrZ/IhLiTw2gWK9QVJjr/ow8PdaaP3hJMDg
 GJOqw1AY1nUtb/Gx79xto6UYUkjq54XmH7MITCSDd2qYejbPkXVApKUijzKthyvvKb27PhgJH
 8egAf4AvKhGLVXUrC18Tbq82QCNevPPZOA8Sg7PxCZIz5dmyN2m4HpLWu1V9rHzFKy8dIKm3L
 H9Aw9WjNk33HxBkgkEOV0vGM7xm3de/N9conDCZV69nT78CDvyN8l9knmohdUFR3WsXtQORMB
 SPuIRmbgBMaGGORVwRfKiq2WfLFWcMTUL8LkAm2UYiziLW/op5zELqIGk1mbvbil0wzukNBZV
 ei+ZlT3oC4kRzOo/rpjGOAPGk34piBd5nsHjcIHM64sYzRrKQsbJUtRSHC/Yzo+1NX81Cg3cb
 YQ1Eml44Lku5msrcY7HE6BA5zxerWwxblrGWe80Awdj4eo+4E3IKL0TB7iYEmV/scO7zHGXFj
 /5aCBuEoiEAE5wkjZcRkOKChnWiZC6
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

On 06.12.24 23:54, Raymond Mao wrote:
> Enable sysinfo smbios by default for arm64.
> When SYSINFO_SMBIOS is enabled, disable QFW_SMBIOS.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> Changes in v2
> - None.
> Changes in v3
> - add CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE
>
>   configs/qemu_arm64_defconfig | 3 +++
>   drivers/misc/Kconfig         | 2 +-
>   2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
> index 8dffb91e93b..31656699d82 100644
> --- a/configs/qemu_arm64_defconfig
> +++ b/configs/qemu_arm64_defconfig

Doesn't this work on qemu_arm_defconfig?
We should test on 32bit too.

Best regards

Heinrich

> @@ -62,6 +62,8 @@ CONFIG_PCIE_ECAM_GENERIC=3Dy
>   CONFIG_SCSI=3Dy
>   CONFIG_DEBUG_UART_PL011=3Dy
>   CONFIG_DEBUG_UART_SHIFT=3D2
> +CONFIG_SYSINFO=3Dy
> +CONFIG_SYSINFO_SMBIOS=3Dy
>   CONFIG_SYSRESET=3Dy
>   CONFIG_SYSRESET_CMD_POWEROFF=3Dy
>   CONFIG_SYSRESET_PSCI=3Dy
> @@ -71,3 +73,4 @@ CONFIG_USB_EHCI_PCI=3Dy
>   CONFIG_SEMIHOSTING=3Dy
>   CONFIG_MBEDTLS_LIB=3Dy
>   CONFIG_TPM=3Dy
> +CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE=3Dy
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 6009d55f400..da84b35e804 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -568,7 +568,7 @@ config QFW_MMIO
>   config QFW_SMBIOS
>   	bool
>   	default y
> -	depends on QFW && SMBIOS && !SANDBOX
> +	depends on QFW && SMBIOS && !SANDBOX && !SYSINFO_SMBIOS
>   	help
>   	  Hidden option to read SMBIOS tables from QEMU.
>

