Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E79C54753
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 08:55:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A40EC88A3E;
	Wed, 28 Aug 2024 10:55:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="t2q4y9V+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21E9088A76; Wed, 28 Aug 2024 10:55:12 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF1C28870B
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 10:55:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2d427fb7c92so4745877a91.1
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 01:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724835308; x=1725440108; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AZ1Uscc/5GQHDppijd+k8POdTAs0VPVzOwxqtM+v5VA=;
 b=t2q4y9V+Cy+7GqPgI8pNy6XMKYDoRA1AelKjgFjvElrvkbAW8qpOBs/rR+1x9y1MnQ
 Kg64M5n0OmtD67Doc6srzajKKGXO0vBHGleroxljqb+fObQ2iok6hV/+FNefDHsbvhDS
 9+3IAwumsdnAkkD5PcwQ0seTDCalWKHVzh+PGkIeBAG6lCYBJhPpYK8PASnFE3c+hdU6
 G4FCXO5ihA+T6ciQReRA7TjbBtm4F8wfC1z6YtocIDrXhNIG+OXDoxeYujcQeMtS0Eie
 axTqO4T0yUTwFF+7aTLS6xb5IWItQaPZZCzc8EKGg6PUTevTEhaAjHGxHpYvHwjAmCQC
 +FOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724835308; x=1725440108;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AZ1Uscc/5GQHDppijd+k8POdTAs0VPVzOwxqtM+v5VA=;
 b=vfHKcOeanQnXiAzxpeANhMhw17srQEQU3E03Vi7SOp5Y1llND0coAzLqZGf2acnihk
 lDGtlx1gCTdtk3CK9bt5KbLSO+LcXCtYxD4kCvC2RyGTdAGe6mnPGt5HS0gDIU4y/Mkt
 zN5gSjVNu3GMFHGkZHCDwWWPI0zkjoIJsIdwoYBhh77qENsxXxHV/RKgDOlOSkXcFO7b
 snmUv8ZySuTfCtOlTyFfxptLEGEHiHY/jKcz+4gFJ3URIHeUXHqjAfVqRmxiQmvvrN+p
 804y49wYY7cyPlmSPJ/qfchLojFOlynUGXVkynmat/uWCs47aMvO2LX7yzPq/cRh+b/f
 6psg==
X-Gm-Message-State: AOJu0Yx5T3fcXJEzsXTph7zSazXBmmDOW+xrAWWWYfmibOkvhzptOL5i
 hOVtjhv+OOsSuJL+b97ho9vYeiZJeD6A7OBILTqlwJZ+L/eKbJWLz06/SQKalwJwq9Xt0Q5SW8Q
 dcyWfBo/Pmad9J+0NEHSk2RxDC+80tKCVC3l/gw==
X-Google-Smtp-Source: AGHT+IHkza1eq0mmA8Ac8SQW/1WAP9qNdlASMHHokOStYpCihif8e1H8+uMHoCHRTP9gWYAHbH3RCn2xEBkdfqlmqvM=
X-Received: by 2002:a17:90a:c48:b0:2d3:d68e:e8d8 with SMTP id
 98e67ed59e1d1-2d646d600b3mr13604302a91.40.1724835308111; Wed, 28 Aug 2024
 01:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
 <20240816214436.1877263-29-raymond.mao@linaro.org>
In-Reply-To: <20240816214436.1877263-29-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 28 Aug 2024 11:54:32 +0300
Message-ID: <CAC_iWjJXJzsnHC4ad7bmSux3khYs8TRSQnLYW+FiPi_XQfMnXw@mail.gmail.com>
Subject: Re: [PATCH v6 28/28] configs: enable MbedTLS as default setting
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com, 
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Alexander Gendin <agendin@matrox.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Eddie James <eajames@linux.ibm.com>, Anand Moon <linux.amoon@gmail.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
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

On Sat, 17 Aug 2024 at 00:55, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Enable MbedTLS as default setting for qemu arm64 and sandbox.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - None.
> Changes in v3
> - None.
> Changes in v4
> - None.
> Changes in v5
> - Remove unused config MBEDTLS_LIB_TLS.
> - Remove EFI_SECURE_BOOT from the default config.
> Changes in v6
> - Remove MBEDTLS_LIB_CRYPTO and MBEDTLS_LIB_X509.
>
>  configs/qemu_arm64_defconfig | 1 +
>  configs/sandbox_defconfig    | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
> index 7e166f43908..2a7885d2a68 100644
> --- a/configs/qemu_arm64_defconfig
> +++ b/configs/qemu_arm64_defconfig
> @@ -67,4 +67,5 @@ CONFIG_TPM2_MMIO=y
>  CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_EHCI_PCI=y
>  CONFIG_SEMIHOSTING=y
> +CONFIG_MBEDTLS_LIB=y
>  CONFIG_TPM=y
> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index 484f9e1bf8d..2ca2e66d1de 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -344,6 +344,7 @@ CONFIG_FS_CBFS=y
>  CONFIG_FS_CRAMFS=y
>  CONFIG_ADDR_MAP=y
>  CONFIG_CMD_DHRYSTONE=y
> +CONFIG_MBEDTLS_LIB=y
>  CONFIG_ECDSA=y
>  CONFIG_ECDSA_VERIFY=y
>  CONFIG_TPM=y
> --
> 2.25.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
