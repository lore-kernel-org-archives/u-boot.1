Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E70BC2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 14:05:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0377260A44;
	Fri,  7 Aug 2026 14:05:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m9u8ukONAvDo; Fri,  7 Aug 2026 14:05:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D0E4860A47
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786111503;
	bh=jZH+xuchfqNnwopxQCvWNFpczv1aDYdfxO3KPMRcx94=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yA7TB0GDe+zvzVjP4eJsnALh3ggRQ+YDRslWhhWxYuCT4cTwlnqbLljM6GzJ5Q+yt
	 bf8UILSJXV3TFEvoernKKyTmMfCvnIGeUY+NrOGZdjU6AHYB+tajUc/n/SSVl4m2cC
	 fENkOnVSzdoq1AJX/QXatEaLVNTeG1N2L4UMx1Q8IA4SysOlIozPCnNKfNcdXqszB5
	 8lTbypx9S4OY2Yq82XXRAVZZJJnO2mESueszJMTJaSPtPtv8B9BKePFI3znUYjP6fF
	 0fmkhkLuc2O9dGh2LokmK9sLY2l2n5GlIR7eKfdHN+5w3S0+WP0jNdtduLf4JqNEfx
	 xx6COwUHamrGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D0E4860A47;
	Fri,  7 Aug 2026 14:05:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EC5CB2F5
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 14:05:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CCF3D60A6D
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 14:05:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FUlLcv1iExti for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 14:05:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org BC1AE60A44
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BC1AE60A44
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BC1AE60A44
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 14:04:58 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-69c5fda04a8so5455818a12.1
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 07:04:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786111496; cv=none;
 d=google.com; s=arc-20260327;
 b=OTMgz3goLpg4RLTOQwGg5vLQTBIJsFAWhCgIY5FL5VYJomdkhOk6v0/zxj0CDn6mV1
 b+wCZExgFfoUk+wP/jCFcItlxGTG+lKs5tMdqc2Jzsb2Lf5bBDFuQFIQLJyV1OQC7VBQ
 Dyx4pQnOPc3Kb6mT4xSENF5sEUViYT5hfoUINZ5bnJ54bOgD6ptyHjonkDaHGhFstbZ9
 eMuGq78TTWmv1u89oyh2qUaxwwPVBdYsRyOJD0ECkjVDG9JLuks9LunrEqO/HFEr1eY+
 2X9vo4QbR+ppA343pK6kytwd9bJnWsbyJeP/4lbVubQhajfdddITRng6I/PHwhGFn+p6
 e4yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jZH+xuchfqNnwopxQCvWNFpczv1aDYdfxO3KPMRcx94=;
 fh=zq0xwFSW4TOBo+VRunfqpnjDrw5t9D1HU9uzIQOEeWk=;
 b=cfbrtJrgGcYoIwhPNQ7wuhUIP3/hsXGUsbz8tLng9kIz1tWf6ordW5xj49ejRrseoa
 6K2pBVysqvQeRsFsibJH62kRt9Soyzv0OssCeKbERbFPVv+ifBuutDwZRwyW6eqn1FUl
 BdynHxbfH0stvTFj4bJq+yIe5fxo+wM/v61C/bV+dNkv/6DwelHhRpsT4m9Y7ynTuiSh
 2nxFRICSHblqM7eoHRCD+OkqGI0gIe8j9pTBqK5yA2lDFoGnguCAsz8wlJjaQ8wV9EJw
 hpqRGoAuaFCLwnT+LBj3TXDlKq8MvLiL6c20m3aWpWyDclr3wfuXN4dZizjae100FgrH
 CnrQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786111496; x=1786716296;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jZH+xuchfqNnwopxQCvWNFpczv1aDYdfxO3KPMRcx94=;
 b=avNPrsFRqcYPRR6jyaTcDLRGqRSnYFg057o1xHbHLpEThpvecgfGmtJ9U+eqKHC5YJ
 6nSX8ImiHTJTPgqfakP8drCNajx8F9BmPrR8Hkqr0HIChJWQZHfPbAj2WC0EFGtqDbY1
 fIElWPhqzHA/2TA2MD69qyvkDCmjXOhSdIxqDF2BN27vZvtaONw9VQsdmqWlzyniZRcm
 u7sAVhdkoFaC4dzNVLCIhSCjsHZqwvbrJ9Ms+T7v6kVbS3kY8WzSqtH8ZbF/agWSb8hR
 1RxrtIBFegLNFIzmRaysl3u/r9So/ZQWxzNouSNiXKHjrrzDejYUigJzR14QUEmeFxsE
 nlsw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoE8uEsn19uWFitNX4/G+URqKnxHlVEAwiwm+VKzrZusn0HTKv7M/AXBqBwHBauAWlAmhf3av4=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyxSuBigG+bDn/Mdgg0V4Cldm6O+scFvP++7yfurPseuw06oqUz
 fIuDHx8YVmWeRiF8eIwVowiE6uWE/fC/+5hAjl+c9JmsJmqr/SUeQrbFfkIGBqVYSU5XJN/jt85
 xNthHupo2W0esBfpMuRX0XGF9PRUC83CDwXSDLM8Wj0DfO6s8M3hkBU1+cw==
X-Gm-Gg: AR+sD10mm8WXhBU+sWcf+U4glf/HfgNE6/bEjG7yPheQDubmfMM1rPDMJTPCpG9n9+z
 bv+961k1Ov4ohSyDkJkk6NyVE5K7ib6CsFff0UVdXgZ4Jq8PlDHxKf2q7APxaYAdMTMKvaQsvVN
 /p3DO0RrraXlHQUwZJMlOlE5CbGa2rYXG9RZnLiVPPe/xP+2Xhkkqm78vkV6M+IxsrlDwJCGpRB
 jti4+sNkW5Sk+C5pa6FoRmw5fFqNTaanzwjF67pmx3ug+b7r2LQAojWRDb+uKHz6QGaDc5t1ZUf
 Xn/pf/Bf53CH7J79W5w0L7qygt6QTkSu/JhP9WCuSvTuPFPE/cMzPwi9vJi6rYO55d1/ULkZnGn
 6VIOgZGa7qX9NV4vQl4DbiDUWF8/4hklPV2TBGHx88L4lkLTHdB0R093qOsjIjNo=
X-Received: by 2002:a17:907:97c2:b0:c15:fc5b:6884 with SMTP id
 a640c23a62f3a-c2039cb18f2mr1101454066b.13.1786111496368; Fri, 07 Aug 2026
 07:04:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260803-mtk-genio-360-bringup-v1-0-606ee60755b5@baylibre.com>
 <20260803-mtk-genio-360-bringup-v1-4-606ee60755b5@baylibre.com>
In-Reply-To: <20260803-mtk-genio-360-bringup-v1-4-606ee60755b5@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 7 Aug 2026 16:04:45 +0200
X-Gm-Features: AUfX_mxODsQN6N3Po3RsFjulwkFbjLfV0b5KpxE1dfpKf8I588h1-SbgUWorUJk
Message-ID: <CAEHHSvaeNGwbV0nGiS9kUtv1O5HH6tRaAfLbhW9PDWDwKadHMQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] arm: mediatek: add MT8366 application processor
To: David Lechner <dlechner@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org, Chris Chen <chris-qj.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786111496; x=1786716296;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jZH+xuchfqNnwopxQCvWNFpczv1aDYdfxO3KPMRcx94=;
 b=AeLRve2WOAOpRMrvpY2hjQbzKxURIvThgQ5ELYUGMBb+v/k6+R2wCFEsP86ugqVs2s
 O3MINnq2mUP75iV3Ja9WiVobuTZ6H4Nmx18+8ss9rRCB0SuxslDACJHmPsmKGqNxl3xY
 AVSQPRYPw4X9FGYJCT1AdaqEDjUZ/gNYygN37FXR/HTFuevgzopiGeIcF5EbYmC2iwh9
 b7SHAcOKm/qxEYEkaLStf/LD8isoKIqo2PWzrvCtP2vJzwFjrm3ZnIqCWwc4Ewk/Krls
 F38ipI76/pUd/vU17AKXRVVCUSHKbc+TYH1hwKKnOamHuk21wWOwLO/ScyRkua8PYfjq
 Igyg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=AeLRve2W
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Le mar. 4 ao=C3=BBt 2026 =C3=A0 01:21, David Lechner <dlechner@baylibre.com=
> a =C3=A9crit :
>
> From: Chris Chen <chris-qj.chen@mediatek.com>
>
> Add basic support for the MT8366 application processor including init
> Kconfig target.
>
> Signed-off-by: Chris Chen <chris-qj.chen@mediatek.com>
> Co-developed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  arch/arm/mach-mediatek/Kconfig         | 12 ++++++-
>  arch/arm/mach-mediatek/Makefile        |  1 +
>  arch/arm/mach-mediatek/cpu.c           |  3 +-
>  arch/arm/mach-mediatek/mt8366/Makefile |  3 ++
>  arch/arm/mach-mediatek/mt8366/init.c   | 58 ++++++++++++++++++++++++++++=
++++++
>  5 files changed, 75 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kcon=
fig
> index 9ff7e7a7f5e..a9ef1f1e314 100644
> --- a/arch/arm/mach-mediatek/Kconfig
> +++ b/arch/arm/mach-mediatek/Kconfig
> @@ -120,6 +120,15 @@ config TARGET_MT8365
>           It is including UART, SPI, USB2.0 dual role, SD and MMC cards, =
NAND, PWM,
>           I2C, I2S, S/PDIF, and several LPDDR3 and LPDDR4 options.
>
> +config TARGET_MT8366
> +       bool "MediaTek MT8366 SoC"
> +       select ARM64
> +       help
> +         The MediaTek MT8366 is a ARM64-based SoC with a single-core Cor=
tex-A76 and
> +         a six-core Cortex-A55. It is including UART, SPI, USB3.0 dual r=
ole,

According to https://genio.mediatek.com/doc/android/hw/mt8366-soc.html
it's 5 Cortex-A55

> +         SD and MMC cards, UFS, PWM, I2C, I2S, S/PDIF, and several LPDDR=
4x
> +         options.
> +
>  config TARGET_MT8512
>         bool "MediaTek MT8512 SoC"
>         select ARM64
> @@ -160,6 +169,7 @@ config MTK_MEM_MAP_DDR_BASE_PHY
>  config MTK_MEM_MAP_DDR_SIZE
>         hex "DDR .size in mem_map"
>         default 0x200000000 if TARGET_MT7987 || TARGET_MT7988 || TARGET_M=
T8188 || TARGET_MT8195
> +       default 0x100000000 if TARGET_MT8366
>         default 0xc0000000 if TARGET_MT8365
>         default 0x80000000 if TARGET_MT7981 || TARGET_MT7986 || TARGET_MT=
8183
>         default 0x40000000 if TARGET_MT7622 || TARGET_MT8512
> @@ -208,7 +218,7 @@ config SYS_CONFIG_NAME
>  config MTK_BROM_HEADER_INFO
>         string
>         default "media=3Dnor" if TARGET_MT8518 || TARGET_MT8512 || TARGET=
_MT7629
> -       default "media=3Demmc" if TARGET_MT8516 || TARGET_MT8365 || TARGE=
T_MT8183 || TARGET_MT8188 || TARGET_MT8189 || TARGET_MT8195
> +       default "media=3Demmc" if TARGET_MT8516 || TARGET_MT8365 || TARGE=
T_MT8366 || TARGET_MT8183 || TARGET_MT8188 || TARGET_MT8189 || TARGET_MT819=
5
>         default "lk=3D1" if TARGET_MT7623
>
>  config MTK_TZ_MOVABLE
> diff --git a/arch/arm/mach-mediatek/Makefile b/arch/arm/mach-mediatek/Mak=
efile
> index 35f748a70d6..51bf5789bb5 100644
> --- a/arch/arm/mach-mediatek/Makefile
> +++ b/arch/arm/mach-mediatek/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_TARGET_MT8188) +=3D mt8188/
>  obj-$(CONFIG_TARGET_MT8189) +=3D mt8189/
>  obj-$(CONFIG_TARGET_MT8195) +=3D mt8195/
>  obj-$(CONFIG_TARGET_MT8365) +=3D mt8365/
> +obj-$(CONFIG_TARGET_MT8366) +=3D mt8366/
>  obj-$(CONFIG_TARGET_MT8512) +=3D mt8512/
>  obj-$(CONFIG_TARGET_MT8516) +=3D mt8516/
>  obj-$(CONFIG_TARGET_MT8518) +=3D mt8518/
> diff --git a/arch/arm/mach-mediatek/cpu.c b/arch/arm/mach-mediatek/cpu.c
> index 56a41e42df6..04ede8823b0 100644
> --- a/arch/arm/mach-mediatek/cpu.c
> +++ b/arch/arm/mach-mediatek/cpu.c
> @@ -39,7 +39,8 @@ void enable_caches(void)
>  u32 mediatek_sip_part_name(void)
>  {
>         if (CONFIG_IS_ENABLED(TARGET_MT8188) || CONFIG_IS_ENABLED(TARGET_=
MT8189) ||
> -           CONFIG_IS_ENABLED(TARGET_MT8195) || CONFIG_IS_ENABLED(TARGET_=
MT8365)) {
> +           CONFIG_IS_ENABLED(TARGET_MT8195) || CONFIG_IS_ENABLED(TARGET_=
MT8365) ||
> +           CONFIG_IS_ENABLED(TARGET_MT8366)) {
>                 struct arm_smccc_res res __maybe_unused;
>
>                 arm_smccc_smc(MTK_SIP_PLAT_BINFO, 0, 0, 0, 0, 0, 0, 0, &r=
es);
> diff --git a/arch/arm/mach-mediatek/mt8366/Makefile b/arch/arm/mach-media=
tek/mt8366/Makefile
> new file mode 100644
> index 00000000000..661744a4398
> --- /dev/null
> +++ b/arch/arm/mach-mediatek/mt8366/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +obj-y +=3D init.o
> diff --git a/arch/arm/mach-mediatek/mt8366/init.c b/arch/arm/mach-mediate=
k/mt8366/init.c
> new file mode 100644
> index 00000000000..13123be068e
> --- /dev/null
> +++ b/arch/arm/mach-mediatek/mt8366/init.c
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2026 Baylibre, SAS
> + * Copyright (C) 2026 MediaTek Inc.
> + * Author: Chris Chen <chris-qj.chen@mediatek.com>
> + */
> +
> +#include <fdtdec.h>
> +#include <stdio.h>
> +#include <asm/global_data.h>
> +#include <asm/system.h>
> +#include <dm/uclass.h>
> +#include <linux/kernel.h>
> +#include <linux/sizes.h>
> +#include <wdt.h>
> +
> +#include "../cpu.h"
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +int dram_init(void)
> +{
> +       return fdtdec_setup_mem_size_base();
> +}
> +
> +phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
> +{
> +       /*
> +        * Limit gd->ram_top not exceeding SZ_4G. Because some peripheral=
s like
> +        * MMC requires DMA buffer allocated below SZ_4G.
> +        */
> +       return min(gd->ram_top, SZ_4G);
> +}
> +
> +void reset_cpu(void)
> +{
> +       if (CONFIG_IS_ENABLED(PSCI_RESET)) {
> +               psci_system_reset();
> +       } else {
> +               struct udevice *wdt;
> +
> +               uclass_first_device(UCLASS_WDT, &wdt);
> +               if (wdt)
> +                       wdt_expire_now(wdt, 0);
> +       }
> +}
> +
> +int print_cpuinfo(void)
> +{
> +       u32 part =3D mediatek_sip_part_name();
> +
> +       if (part)
> +               printf("CPU:   MediaTek MT%.4x\n", part);
> +       else
> +               printf("CPU:   MediaTek MT8366 series\n");
> +
> +       return 0;
> +}
>
> --
> 2.43.0
>
