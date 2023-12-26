Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDCD1C46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:50:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6865087910;
	Tue, 26 Dec 2023 10:48:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YeUB78Rc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3FA08790F; Tue, 26 Dec 2023 10:48:13 +0100 (CET)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66A048788F
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:48:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-204520717b3so2118270fac.0
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584090; x=1704188890; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J5rczW5kJyVcZVcA9+UoWJEpbmkEg4nbM7ruZCRD7gg=;
 b=YeUB78RcQN00KTUDGiIYwEIWFvGC2yZ0EiN3dAhhWU//YyLQvFnWuxGZC8297GD64H
 UieWdxNGuU/ZOVUcbEKTPQVrWiaSNopgW1qRcxOOnNbG7VHCB9g24eVL0/sy2MBMTHTg
 TRGVCnSz+arHYuhFKSM0N+FE3Gr+/Hg+03RwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584090; x=1704188890;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J5rczW5kJyVcZVcA9+UoWJEpbmkEg4nbM7ruZCRD7gg=;
 b=C7wX10KMmFtLnT6PEMYRfB8ba+bMjtRL53s8QLXcBDNLwGeFnYszoqIP4+KVaNZeBX
 oQHbypLm+bV4xdR2iV9GJTyDUW4vTyQ+vqRIbkCwucjWyFmU11TopJYGQR0w8dWyA/U8
 knExci+I24JmOwI+Is8Rxoakh6WLBVSrP6b8qW3S/fH26DJp89D5A5DOkS+c4AdAxMra
 ZMOZjOAaSUWxxvtnF0dOdfff/w+2lTQHNhl30L9hNdAYtO/d810KuVx1gEvbrqZeU59a
 avIb6CVyaFn+kdzbCXa5fkyWoIAoMRnyadN+fzCYmBbIvyT+drf6dOqI0EwmCOhCfqk9
 xRIw==
X-Gm-Message-State: AOJu0Yyel1jQJGg1bOZOEgnvXtvcnPC3FzuIoWdt8QrLFlDrijramjbL
 evHeqR6GIWJrzpo9uPqeX3pB00gQq66QGwE3trDYoz8QjqKV
X-Google-Smtp-Source: AGHT+IHm6m1IM6qHMs/3wmjeTpDHJlU2t06bPskoTqQ1B6fx4u6JdspjsyipPQWW3Ei7Dl+YUy4OLS2aX6hDAPq3F00=
X-Received: by 2002:a05:6358:70c1:b0:174:e6ff:276c with SMTP id
 h1-20020a05635870c100b00174e6ff276cmr2813544rwh.1.1703584089952; Tue, 26 Dec
 2023 01:48:09 -0800 (PST)
MIME-Version: 1.0
References: <20231222213110.660402-1-raymond.mao@linaro.org>
 <20231222213110.660402-7-raymond.mao@linaro.org>
In-Reply-To: <20231222213110.660402-7-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:47:45 +0000
Message-ID: <CAFLszTjoViZAxZy26k4aXuoBhvzt_P8zBwqx8Kr8wPHFns1RRQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] qemu-arm: Get bloblist from boot arguments
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, jwerner@chromium.org, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>, 
 Shiji Yang <yangshiji66@outlook.com>, Devarsh Thakkar <devarsht@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Baruch Siach <baruch@tkos.co.il>, 
 Michal Simek <michal.simek@amd.com>, Qu Wenruo <wqu@suse.com>, 
 Sean Anderson <sean.anderson@seco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Dec 22, 2023 at 9:32=E2=80=AFPM Raymond Mao <raymond.mao@linaro.org=
> wrote:
>
> Add platform custom function to get bloblist from boot arguments.
> Check whether boot arguments aligns with the register conventions
> defined in FW Handoff spec v0.9.
> Add bloblist related options into qemu default config.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Remove low level code for copying boot arguments.
> - Refactor board_fdt_blob_setup() and remove direct access of gd->bloblis=
t.
> Changes in v3
> - Optimize board_bloblist_from_boot_arg().
>
>  board/emulation/qemu-arm/qemu-arm.c | 30 +++++++++++++++++++++++++++++
>  configs/qemu_arm64_defconfig        |  3 +++
>  2 files changed, 33 insertions(+)
>
> diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-a=
rm/qemu-arm.c
> index 942f1fff57..e225011bf0 100644
> --- a/board/emulation/qemu-arm/qemu-arm.c
> +++ b/board/emulation/qemu-arm/qemu-arm.c
> @@ -4,6 +4,7 @@
>   */
>
>  #include <common.h>
> +#include <bloblist.h>
>  #include <cpu_func.h>
>  #include <dm.h>
>  #include <efi.h>
> @@ -102,6 +103,15 @@ static struct mm_region qemu_arm64_mem_map[] =3D {
>  struct mm_region *mem_map =3D qemu_arm64_mem_map;
>  #endif
>
> +/*
> + * Boot parameters saved from start.S
> + * saved_args[0]: FDT base address
> + * saved_args[1]: Bloblist signature
> + * saved_args[2]: must be 0
> + * saved_args[3]: Bloblist base address
> + */
> +extern unsigned long saved_args[];
> +
>  int board_init(void)
>  {
>         return 0;
> @@ -144,6 +154,26 @@ void *board_fdt_blob_setup(int *err)
>         return (void *)CFG_SYS_SDRAM_BASE;
>  }
>
> +int board_bloblist_from_boot_arg(unsigned long addr, unsigned long size)
> +{
> +       int ret =3D -ENOENT;
> +
> +       if (!IS_ENABLED(CONFIG_OF_BOARD) || !IS_ENABLED(CONFIG_BLOBLIST))
> +               return -ENOENT;
> +
> +       ret =3D bloblist_check(saved_args[3], size);
> +       if (ret)
> +               return ret;

What about saved_args[1] ?

> +
> +       /* Check the register conventions */
> +       ret =3D bloblist_check_reg_conv(saved_args[0], saved_args[2]);
> +       if (!ret)
> +               /* Relocate the bloblist to the fixed address */
> +               ret =3D bloblist_reloc((void *)addr, CONFIG_BLOBLIST_SIZE=
);
> +
> +       return ret;
> +}
> +

This should be a generic function, e.g. in arch/arm

>  void enable_caches(void)
>  {
>          icache_enable();
> diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
> index c010c25a92..418f48001c 100644
> --- a/configs/qemu_arm64_defconfig
> +++ b/configs/qemu_arm64_defconfig
> @@ -69,3 +69,6 @@ CONFIG_USB_EHCI_HCD=3Dy
>  CONFIG_USB_EHCI_PCI=3Dy
>  CONFIG_SEMIHOSTING=3Dy
>  CONFIG_TPM=3Dy
> +CONFIG_BLOBLIST=3Dy
> +CONFIG_BLOBLIST_ADDR=3D0x40004000
> +CONFIG_BLOBLIST_SIZE=3D0x4000
> --
> 2.25.1
>

Regards,
Simon
