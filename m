Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8738D339A1
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 17:05:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B090389156;
	Mon, 28 Oct 2024 18:05:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BtWVzojW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32CF0890D1; Mon, 28 Oct 2024 18:05:06 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7A818913A
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 18:04:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a9932aa108cso681160166b.2
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 10:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730135098; x=1730739898; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Qe5FyBm+9QyZerjZfNhf3JjfBFl5X9LjwVDIsH+9cuM=;
 b=BtWVzojWKary4zNFmmc8kjQETmG0w7t2xkCPFE6Ej4QfLQLycwfPcaxBOQP+5sl7ki
 GmjOYxWp8WIgyTnxothENj1yYpmPy8AnK2xd/S794p3LMq/zJU8Eg6KU6QcCO3pPzNwu
 BTq9VBr2XuMf7ofuRzoHq5nHCboN2TOgB0j2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730135098; x=1730739898;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qe5FyBm+9QyZerjZfNhf3JjfBFl5X9LjwVDIsH+9cuM=;
 b=AKS5nGIuafHQhOvrMeX7qMCOiXMmU2I1XA+XgsBFViQcNP4fWOyniF/4D9ztZmtyPm
 d59Y/s+3Y5ze+x5NiRDuRVTRr+VkiQ9FXmkiTFLVf0A/urJS7dTbh9h4kDIkAps1vIhT
 JkWz+5heH5qYfXRUWrBLNAvfPjfO5HmY/RzzAbsc4lBJ5XL66l/yO7lxdfueKyt/2c68
 JrRqw3j0edvgLr9/buUskPueSCojrm5JIfFq0Flt+urGfZX2f8T0LKSUhha+LwLRZTS9
 yO+MFgOGrWzmcDOqHsBziavrcEer4Y/IvwvIY1yjH+pppYEMwkXLARSPS3HEUqPO8WXz
 Zjkg==
X-Gm-Message-State: AOJu0YxqOzZqL7p+nzfM/L0KDQ3Lh5ihZWji75Sa5NbsrTE5Exiy9Py0
 qwfoeIPUe6imH6QZeSstwkQd2xamExLsJIX+a+rMlzDYDOjeIgxthcf1Cq8zuBJdl9p4uobzAUf
 EeRqGmgAGB/kJ0Z5onSsruudkDlFVlQ0DUGId
X-Google-Smtp-Source: AGHT+IHCGfpUYeFqfBbNx9EWZ0fVBPg9sTrOguZdikDv6GYT0vnrYriKh48ZZtJai1MOQnm0HfPvbSEx3ZAGRay65iI=
X-Received: by 2002:a17:907:2cc6:b0:a9a:423:3278 with SMTP id
 a640c23a62f3a-a9de619e3e9mr824845866b.49.1730135098034; Mon, 28 Oct 2024
 10:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <20241022200543.116343-1-raymond.mao@linaro.org>
 <20241022200543.116343-7-raymond.mao@linaro.org>
In-Reply-To: <20241022200543.116343-7-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Oct 2024 18:04:45 +0100
Message-ID: <CAFLszTjY=BwM8jUk_uRp-PnNu7=cXTdw0=znJwS4XDooWmNJjg@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] armv8: Add generic smbios information into the
 device tree
To: Raymond Mao <raymond.mao@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Stefan Roese <sr@denx.de>, Alexander Gendin <agendin@matrox.com>,
 Michal Simek <michal.simek@amd.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Wan Yee Lau <wan.yee.lau@intel.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Peter Robinson <pbrobinson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Raymond,

On Tue, 22 Oct 2024 at 22:07, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Add common smbios information that can be used by all armv8
> platforms and set it as default for qemu-arm64.
> From now smbios library can load values from here for those fields
> doesn't exist in the sysinfo driver.
>
> To run this with QEMU arm64, please dump the generated DTB
> from QEMU first, merge it with the one we build and then re-run
> QEMU with the merged DTB.
> ```
> qemu-system-arm -machine virt -machine dumpdtb=qemu.dtb
> cat  <(dtc -I dtb qemu.dtb) <(dtc -I dtb ./dts/dt.dtb | \
>   grep -v /dts-v1/) | dtc - -o merged.dtb
> qemu-system-arm -machine virt -nographic -bios u-boot.bin \
>   -dtb merged.dtb

and please talk to Peter about accepting my patch[1]


> ```
> For details please take reference on dt_qemu.rst
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Initial patch.
>
>  arch/arm/dts/qemu-arm64.dts      |  4 ++
>  arch/arm/dts/smbios_generic.dtsi | 82 ++++++++++++++++++++++++++++++++
>  2 files changed, 86 insertions(+)
>  create mode 100644 arch/arm/dts/smbios_generic.dtsi
>
> diff --git a/arch/arm/dts/qemu-arm64.dts b/arch/arm/dts/qemu-arm64.dts
> index 096b3910728..95fcf53ed74 100644
> --- a/arch/arm/dts/qemu-arm64.dts
> +++ b/arch/arm/dts/qemu-arm64.dts
> @@ -7,5 +7,9 @@
>
>  /dts-v1/;
>
> +#if defined(CONFIG_SYSINFO_SMBIOS) && !defined(QFW_SMBIOS)
> +#include "smbios_generic.dtsi"
> +#endif
> +
>  / {
>  };
> diff --git a/arch/arm/dts/smbios_generic.dtsi
b/arch/arm/dts/smbios_generic.dtsi
> new file mode 100644
> index 00000000000..c9f07283403
> --- /dev/null
> +++ b/arch/arm/dts/smbios_generic.dtsi
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Default SMBIOS information for Arm64 platforms
> + *
> + * Copyright (c) 2024 Linaro Limited
> + * Author: Raymond Mao <raymond.mao@linaro.org>
> + */
> +#include <config.h>
> +#include <smbios_def.h>
> +
> +/ {
> +       smbios {
> +               compatible = "u-boot,sysinfo-smbios";
> +
> +               smbios {
> +                       system {
> +                               manufacturer = CONFIG_SYS_VENDOR;
> +                               product = CONFIG_SYS_BOARD;
> +                               version = "Not Specified";
> +                               serial = "Not Specified";

Does it make sense to add these strings? Perhaps if the property is missing
in the DT, it should be missing in the SMBIOS table? Is 'Not Specified' a
special string in the SMBIO spec?

> +                               wakeup-type =
<SMBIOS_WAKEUP_TYPE_UNKNOWN>;
> +                               sku = "Not Specified";
> +                               family = "armv8";
> +                       };
> +
> +                       baseboard {
> +                               manufacturer = CONFIG_SYS_VENDOR;
> +                               product = CONFIG_SYS_BOARD;
> +                               version = "Not Specified";
> +                               serial = "Not Specified";
> +                               asset-tag = "Not Specified";
> +                               chassis-location = "Not Specified";
> +                               feature-flags =
<SMBIOS_BOARD_FEAT_HOST_BOARD>;
> +                               board-type =
<SMBIOS_BOARD_TYPE_MOTHERBOARD>;
> +                       };
> +
> +                       chassis {
> +                               manufacturer = CONFIG_SYS_VENDOR;
> +                               version = "Not Specified";
> +                               serial = "Not Specified";
> +                               asset-tag = "Not Specified";
> +                               chassis-type = <SMBIOS_ENCLOSURE_DESKTOP>;
> +                               bootup-state = <SMBIOS_STATE_SAFE>;
> +                               power-supply-state = <SMBIOS_STATE_SAFE>;
> +                               thermal-state = <SMBIOS_STATE_SAFE>;
> +                               security-status = <SMBIOS_SECURITY_NONE>;
> +                               oem-defined = <SMBIOS_ENCLOSURE_OEM_UND>;
> +                               height = <SMBIOS_ENCLOSURE_HEIGHT_UND>;
> +                               number-of-power-cords =
<SMBIOS_POWCORD_NUM_UND>;
> +                       };
> +
> +                       processor {
> +                               version = "Not Specified";
> +                               processor-type =
<SMBIOS_PROCESSOR_TYPE_CENTRAL>;
> +                               processor-status =
<SMBIOS_PROCESSOR_STATUS_ENABLED>;
> +                               upgrade = <SMBIOS_PROCESSOR_UPGRADE_NONE>;
> +                               family = <SMBIOS_PROCESSOR_FAMILY_EXT>;
> +                               family2 = <SMBIOS_PROCESSOR_FAMILY_ARMV8>;
> +                               socket-design = "Not Specified";
> +                               serial = "Not Specified";
> +                               asset-tag = "Not Specified";
> +                               part-number = "Not Specified";
> +                       };
> +
> +                       cache {
> +                               l1-cache {
> +                                       socket-design = "Not Specified";
> +                                       config = <(SMBIOS_CACHE_LEVEL_1 |
> +                                                  SMBIOS_CACHE_ENABLED |
> +                                                  SMBIOS_CACHE_OP_WB)>;
> +                               };
> +
> +                               l2-cache {
> +                                       socket-design = "Not Specified";
> +                                       config = <(SMBIOS_CACHE_LEVEL_2 |
> +                                                  SMBIOS_CACHE_ENABLED |
> +                                                  SMBIOS_CACHE_OP_WB)>;
> +                               };
> +                       };
> +               };
> +       };
> +};
> --
> 2.25.1
>

Regards,
Simon


[1]
https://patchwork.kernel.org/project/qemu-devel/patch/20210926183410.256484-1-sjg@chromium.org/#24481799
