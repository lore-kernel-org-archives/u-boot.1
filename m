Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524C5E95A77
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:19:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C38D286F24;
	Sun,  8 Oct 2023 01:13:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="WCbhlDwS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43171864F3; Sun,  8 Oct 2023 01:12:22 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F8E786EB8
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:12:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-59bf1dde73fso40651877b3.3
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696720299; x=1697325099; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n+wXd0nmwEiB3xEm53S6NoSUBpumV1P7Ir1e0wtrkLw=;
 b=WCbhlDwSb9Jjvp/EvwPQ8y7tFbJ2tkKIXZGsUyat1pEjbRf55Pl6JtA8p7iGQGhd84
 bzLFNmaIKna3y2QCZJB2wUCqBUiDHHqw04RBIB4xE/CltW0yE8B+ID2pH9ZZtpKFBxJf
 eDYJm2hbcFMwXtsHwStBBcMuk87V6hDWwIzw4fPUv5GEwXsbbXxcMXjlcxzodDybGAXi
 in0zXinezWK+jBK+vCrSo+2eJLnUNAaiEEFt0ekKJpRDyjdu4PRLvptnKAYlobjsNDf9
 BdtX2Q2zej3gIBXuTc+uUam6NvLNO5mXm0pdI/dssjVfMJ6pkL7HMJ39FT+71UJ70DaE
 SAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696720299; x=1697325099;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n+wXd0nmwEiB3xEm53S6NoSUBpumV1P7Ir1e0wtrkLw=;
 b=kwtcLV3dIBEDGVxa5BcClaXYLoy4fyPICkr2vumTJsf6pdTMoZMe4KXz5wXFmvylS5
 ufzjIOwi97oYiHMjipPAcUmTV2ouk6sTVZmUXXQbkWzIn7t8hYh6choMRF54QbCupYWw
 PWdOyMu1ApMv1FvMOkn+ywOM6XWLFXdEmHM9xI+sM6xg6K0EvRT9MS9/Lc+Mt14OLniw
 MEOGRxcRM5VCApUreN8F8TH0DiXKFIPVKhkvetlCMUDvzbsn+ZBd5TyNmELfVGKCWa+s
 n7mlwTCYFtDBlQ/oiMBmOlWeN9bAEo0U6tYjXeAwZaC3QTQBl3jdg2ykjLs7JHT+d6uS
 mwhg==
X-Gm-Message-State: AOJu0YyX1V/SuGOB5G9STY1R8D1pwX7kGTScLEolHH6Ima26MJP3GSvp
 McNBWHKGSlFn8aurW7p3o8QmCUb00hfWzqYqA69UPg==
X-Google-Smtp-Source: AGHT+IEJASSsuvmv3QSf3Egfr3msPh2qP5Scp3RbYNBZWxdn53oeJ7pTzbr39nvfIhVZXumWs/RHoYnS8prLiS/uW+o=
X-Received: by 2002:a81:9c14:0:b0:598:5bb5:1801 with SMTP id
 m20-20020a819c14000000b005985bb51801mr10687461ywa.50.1696720299242; Sat, 07
 Oct 2023 16:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231006112351.2275090-1-randolph@andestech.com>
 <20231006112351.2275090-3-randolph@andestech.com>
In-Reply-To: <20231006112351.2275090-3-randolph@andestech.com>
From: Simon Glass <sjg@google.com>
Date: Sat, 7 Oct 2023 17:09:53 -0600
Message-ID: <CAPnjgZ0i2aou95Fp9xPESL7R23AjU_HqTc7ug0Z9g416XgrfEQ@mail.gmail.com>
Subject: Re: [PATCH RESEND 2/7] riscv: dts: add binman_linux.dtsi for opensbi
 os boot mode
To: randolph@andestech.com
Cc: u-boot@lists.denx.de, randolph.sklin@gmail.com, dylan@andestech.com, 
 tim609@andestech.com, peterlin@andestech.com
Content-Type: text/plain; charset="UTF-8"
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

Hi Randoph,

On Fri, 6 Oct 2023 at 05:26, Randolph <randolph@andestech.com> wrote:
>
> The binman_linux.dtsi is a fork of binman.dtsi, just change the first
> section image from the "u-boot" to "linux". Note that the filename
> is also changed. In binman.dtsi, the filename of u-boot section filename
> is called "u-boot-nodtb.bin". In binman_linux.dtsi, the filename should
> be called "Image", which is located in linux/arch/riscv/boot.
>
> Signed-off-by: Randolph <randolph@andestech.com>
> ---
>  arch/riscv/dts/binman_linux.dtsi | 79 ++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 arch/riscv/dts/binman_linux.dtsi
>
> diff --git a/arch/riscv/dts/binman_linux.dtsi b/arch/riscv/dts/binman_linux.dtsi
> new file mode 100644
> index 0000000000..334d64bc40
> --- /dev/null
> +++ b/arch/riscv/dts/binman_linux.dtsi
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2021, Bin Meng <bmeng.cn@gmail.com>
> + */
> +
> +#include <config.h>
> +
> +/ {
> +       binman: binman {
> +               multiple-images;
> +       };
> +};
> +
> +&binman {
> +       itb {
> +               filename = "linux.itb";
> +
> +               fit {
> +                       description = "Configuration to load OpenSBI before Linux";
> +                       #address-cells = <1>;
> +                       fit,fdt-list = "of-list";
> +
> +                       images {
> +                               linux {
> +                                       description = "Linux";
> +                                       type = "standalone";
> +                                       os = "Linux";
> +                                       arch = "riscv";
> +                                       compression = "none";
> +                                       load = <CONFIG_TEXT_BASE>;
> +
> +                                       linux_blob: blob-ext {
> +                                               filename = "Image";
> +                                       };
> +                               };
> +
> +                               opensbi {
> +                                       description = "OpenSBI fw_dynamic Firmware";
> +                                       type = "firmware";
> +                                       os = "opensbi";
> +                                       arch = "riscv";
> +                                       compression = "none";
> +                                       load = <CONFIG_SPL_OPENSBI_LOAD_ADDR>;
> +                                       entry = <CONFIG_SPL_OPENSBI_LOAD_ADDR>;
> +
> +                                       opensbi_blob: opensbi {
> +                                               filename = "fw_dynamic.bin";
> +                                               missing-msg = "opensbi";
> +                                       };
> +                               };
> +
> +#ifndef CONFIG_OF_BOARD
> +                               @fdt-SEQ {
> +                                       description = "NAME";
> +                                       type = "flat_dt";
> +                                       compression = "none";
> +                               };
> +#endif
> +                       };
> +
> +                       configurations {
> +                               default = "conf-1";
> +
> +#ifndef CONFIG_OF_BOARD
> +                               @conf-SEQ {
> +#else
> +                               conf-1 {
> +#endif
> +                                       description = "NAME";
> +                                       firmware = "opensbi";
> +                                       loadables = "linux";
> +#ifndef CONFIG_OF_BOARD
> +                                       fdt = "fdt-SEQ";
> +#endif
> +                               };
> +                       };
> +               };
> +       };
> +};
> --
> 2.34.1
>

Could you instead put an #ifdef to include the right file (or nodes)
in a single file?

i.e. always include binman.dtsi but have it do different things in either case?

Regards,
Simon
