Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB406C87FCB
	for <u-boot@archiver.kernel.org>; Sun,  3 Aug 2025 13:23:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 873E483D8B;
	Sun,  3 Aug 2025 15:22:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="C0IqEqXE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 759AE83D28; Sun,  3 Aug 2025 10:33:31 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4394683CEE
 for <u-boot@lists.denx.de>; Sun,  3 Aug 2025 10:33:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-24031a3e05cso24723085ad.1
 for <u-boot@lists.denx.de>; Sun, 03 Aug 2025 01:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1754210003; x=1754814803;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aaOy3QF3q8DSKI9dtRfHTBdy2ry5Y8NqZBmbzk5axEs=;
 b=C0IqEqXENhTmlrWem33doOoIwJTvH7gSqKsRQZBxqK8YNMquw6U07LvblcE9SMug38
 JnjrlOzddzf0plRQhwrsSQPeZNwxxHTDRYLOgC945TTZdNIsttHuHbS7iQi6i3gaGLAR
 iCNo2MFyFiYSR8H9ZkhUZmvxZS2JD8lc5bHyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754210003; x=1754814803;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aaOy3QF3q8DSKI9dtRfHTBdy2ry5Y8NqZBmbzk5axEs=;
 b=OyPEjNZLesvC/pwBYnmgATPNZfRlWcgFBnOl35tZkq8TX+/N7VIQaI6IBg1STDsOf2
 bYOcxxPlYT8eUshhudkVMhpIrIWLtnGPiSJ4bBueISlJMZjn+qWu/JbcSlrf9XakUeNL
 NFqXH8YSEz9Hg9ypaUV0PTFj49n9L9H/eIYu95XFUU0AQlpVWkIij4SwZ2TCEmm2t6Ec
 iox+mCF9DI+gCm6OtzsnJg+KjU8vM9zQbOZJEItfBHn6Jt92b8w6PIg44TGP2ZAXO5DC
 ZITVm3fGm97HyA4OwJvjj+huPTmwtRE6CmgSwgujIOc+yeP+zJly2MZMn/XSxV2TOWJQ
 Sh9Q==
X-Gm-Message-State: AOJu0YxG3Sd6GgyH8rpgDoOjH6NdsE27JiGfLv5gu1lVe2UYVAvHBwZ0
 O3Yfk6pIT2QlORam0GZNSngXJJBrbL57nuLqswh+OM/ncZ409Jni0WrCnLJX1ytLkDX7mdlLSqn
 pMB1TslwP3lMKCwjOHR5klQUJf/C7JUZUfFJkTmvDkJI9R6G8wEnunaEhFH/E
X-Gm-Gg: ASbGncttl08XtZy1XXcwqHOtipN5cOmQcLC5Q78SwmW13zrdGYlCkUTSVdGEvzqPlEI
 c5GURg3FGrFBxEHafOQbvvkDz5nWIUsq++dVEKYAXr+20K8VjeaLOW0iXZYOjA5OX/SQxh5T5wU
 dcZvVCIPue95dyfiTM50NzynAhQjEteLVQ4XD29RGmEvzTN1Qq/1pm30JgjTeCxWt8e6z3nTnJx
 DxNaQ==
X-Google-Smtp-Source: AGHT+IHxX5mVJ1q3bevg+VWVxhSJxFB3MplNrOdEXISWcqfHviubPppxcV/Vyb1gVYael0V64zbeYHa2TpeqTC9/t8M=
X-Received: by 2002:a17:903:244a:b0:240:4683:90a0 with SMTP id
 d9443c01a7336-24200a4c9aemr167447765ad.6.1754210001942; Sun, 03 Aug 2025
 01:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250711151946.2225317-1-trini@konsulko.com>
In-Reply-To: <20250711151946.2225317-1-trini@konsulko.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sun, 3 Aug 2025 10:33:04 +0200
X-Gm-Features: Ac12FXyFuykhNx-M6oG3S7S905kLcKYe_j6OY8lnlGheTLECLFPBHmGbDAe7rV0
Message-ID: <CAOf5uw=AGFgtM1jD2iFhbmLFHKatUnE-ve2hVgh=bdnVAHM4UQ@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: nand: raw: Remove unused octeontx_nand driver
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
X-Mailman-Approved-At: Sun, 03 Aug 2025 15:22:51 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Jul 11, 2025 at 5:19=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:

> As no platforms use this driver anymore let's go ahead and remove it.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  drivers/mtd/nand/raw/Kconfig             |   16 -
>  drivers/mtd/nand/raw/Makefile            |    2 -
>  drivers/mtd/nand/raw/octeontx_bch.c      |  422 ----
>  drivers/mtd/nand/raw/octeontx_bch.h      |  131 --
>  drivers/mtd/nand/raw/octeontx_bch_regs.h |  167 --
>  drivers/mtd/nand/raw/octeontx_nand.c     | 2254 ----------------------
>  6 files changed, 2992 deletions(-)
>  delete mode 100644 drivers/mtd/nand/raw/octeontx_bch.c
>  delete mode 100644 drivers/mtd/nand/raw/octeontx_bch.h
>  delete mode 100644 drivers/mtd/nand/raw/octeontx_bch_regs.h
>  delete mode 100644 drivers/mtd/nand/raw/octeontx_nand.c
>
>
Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index 4b4330302bed..492b577709d0 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -567,22 +567,6 @@ config NAND_ZYNQ_USE_BOOTLOADER1_TIMINGS
>           This flag prevent U-Boot reconfigure NAND flash controller and
> reuse
>           the NAND timing from 1st stage bootloader.
>
> -config NAND_OCTEONTX
> -       bool "Support for OcteonTX NAND controller"
> -       select SYS_NAND_SELF_INIT
> -       imply CMD_NAND
> -       help
> -         This enables Nand flash controller hardware found on the Octeon=
TX
> -         processors.
> -
> -config NAND_OCTEONTX_HW_ECC
> -       bool "Support Hardware ECC for OcteonTX NAND controller"
> -       depends on NAND_OCTEONTX
> -       default y
> -       help
> -         This enables Hardware BCH engine found on the OcteonTX
> processors to
> -         support ECC for NAND flash controller.
> -
>  config NAND_STM32_FMC2
>         bool "Support for NAND controller on STM32MP SoCs"
>         depends on ARCH_STM32MP
> diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefil=
e
> index 5ffd450e8fe7..76546a6287b7 100644
> --- a/drivers/mtd/nand/raw/Makefile
> +++ b/drivers/mtd/nand/raw/Makefile
> @@ -66,8 +66,6 @@ obj-$(CONFIG_NAND_MESON) +=3D meson_nand.o
>  obj-$(CONFIG_NAND_MXC) +=3D mxc_nand.o
>  obj-$(CONFIG_NAND_MXS) +=3D mxs_nand.o
>  obj-$(CONFIG_NAND_MXS_DT) +=3D mxs_nand_dt.o
> -obj-$(CONFIG_NAND_OCTEONTX) +=3D octeontx_nand.o
> -obj-$(CONFIG_NAND_OCTEONTX_HW_ECC) +=3D octeontx_bch.o
>  obj-$(CONFIG_NAND_PXA3XX) +=3D pxa3xx_nand.o
>  obj-$(CONFIG_TEGRA_NAND) +=3D tegra_nand.o
>  obj-$(CONFIG_NAND_OMAP_GPMC) +=3D omap_gpmc.o
> diff --git a/drivers/mtd/nand/raw/octeontx_bch.c
> b/drivers/mtd/nand/raw/octeontx_bch.c
> deleted file mode 100644
> index 056a6857822f..000000000000
> --- a/drivers/mtd/nand/raw/octeontx_bch.c
> +++ /dev/null
> @@ -1,422 +0,0 @@
> -// SPDX-License-Identifier:    GPL-2.0
> -/*
> - * Copyright (C) 2018 Marvell International Ltd.
> - */
> -
> -#include <dm.h>
> -#include <dm/of_access.h>
> -#include <malloc.h>
> -#include <memalign.h>
> -#include <nand.h>
> -#include <pci.h>
> -#include <pci_ids.h>
> -#include <time.h>
> -#include <linux/bitfield.h>
> -#include <linux/ctype.h>
> -#include <linux/delay.h>
> -#include <linux/errno.h>
> -#include <linux/err.h>
> -#include <linux/ioport.h>
> -#include <linux/libfdt.h>
> -#include <linux/mtd/mtd.h>
> -#include <linux/mtd/nand_bch.h>
> -#include <linux/mtd/nand_ecc.h>
> -#include <asm/io.h>
> -#include <asm/types.h>
> -#include <asm/dma-mapping.h>
> -#include <asm/arch/clock.h>
> -#include "octeontx_bch.h"
> -
> -static LIST_HEAD(octeontx_bch_devices);
> -static unsigned int num_vfs =3D BCH_NR_VF;
> -static void *bch_pf;
> -static void *bch_vf;
> -static void *token;
> -static bool bch_pf_initialized;
> -static bool bch_vf_initialized;
> -
> -static int pci_enable_sriov(struct udevice *dev, int nr_virtfn)
> -{
> -       int ret;
> -
> -       ret =3D pci_sriov_init(dev, nr_virtfn);
> -       if (ret)
> -               printf("%s(%s): pci_sriov_init returned %d\n", __func__,
> -                      dev->name, ret);
> -       return ret;
> -}
> -
> -void *octeontx_bch_getv(void)
> -{
> -       if (!bch_vf)
> -               return NULL;
> -       if (bch_vf_initialized && bch_pf_initialized)
> -               return bch_vf;
> -       else
> -               return NULL;
> -}
> -
> -void octeontx_bch_putv(void *token)
> -{
> -       bch_vf_initialized =3D !!token;
> -       bch_vf =3D token;
> -}
> -
> -void *octeontx_bch_getp(void)
> -{
> -       return token;
> -}
> -
> -void octeontx_bch_putp(void *token)
> -{
> -       bch_pf =3D token;
> -       bch_pf_initialized =3D !!token;
> -}
> -
> -static int do_bch_init(struct bch_device *bch)
> -{
> -       return 0;
> -}
> -
> -static void bch_reset(struct bch_device *bch)
> -{
> -       writeq(1, bch->reg_base + BCH_CTL);
> -       mdelay(2);
> -}
> -
> -static void bch_disable(struct bch_device *bch)
> -{
> -       writeq(~0ull, bch->reg_base + BCH_ERR_INT_ENA_W1C);
> -       writeq(~0ull, bch->reg_base + BCH_ERR_INT);
> -       bch_reset(bch);
> -}
> -
> -static u32 bch_check_bist_status(struct bch_device *bch)
> -{
> -       return readq(bch->reg_base + BCH_BIST_RESULT);
> -}
> -
> -static int bch_device_init(struct bch_device *bch)
> -{
> -       u64 bist;
> -       int rc;
> -
> -       debug("%s: Resetting...\n", __func__);
> -       /* Reset the PF when probed first */
> -       bch_reset(bch);
> -
> -       debug("%s: Checking BIST...\n", __func__);
> -       /* Check BIST status */
> -       bist =3D (u64)bch_check_bist_status(bch);
> -       if (bist) {
> -               dev_err(dev, "BCH BIST failed with code 0x%llx\n", bist);
> -               return -ENODEV;
> -       }
> -
> -       /* Get max VQs/VFs supported by the device */
> -
> -       bch->max_vfs =3D pci_sriov_get_totalvfs(bch->dev);
> -       debug("%s: %d vfs\n", __func__, bch->max_vfs);
> -       if (num_vfs > bch->max_vfs) {
> -               dev_warn(dev, "Num of VFs to enable %d is greater than ma=
x
> available.  Enabling %d VFs.\n",
> -                        num_vfs, bch->max_vfs);
> -               num_vfs =3D bch->max_vfs;
> -       }
> -       bch->vfs_enabled =3D bch->max_vfs;
> -       /* Get number of VQs/VFs to be enabled */
> -       /* TODO: Get CLK frequency */
> -       /* Reset device parameters */
> -
> -       debug("%s: Doing initialization\n", __func__);
> -       rc =3D do_bch_init(bch);
> -
> -       return rc;
> -}
> -
> -static int bch_sriov_configure(struct udevice *dev, int numvfs)
> -{
> -       struct bch_device *bch =3D dev_get_priv(dev);
> -       int ret =3D -EBUSY;
> -
> -       debug("%s(%s, %d), bch: %p, vfs_in_use: %d, enabled: %d\n",
> __func__,
> -             dev->name, numvfs, bch, bch->vfs_in_use, bch->vfs_enabled);
> -       if (bch->vfs_in_use)
> -               goto exit;
> -
> -       ret =3D 0;
> -
> -       if (numvfs > 0) {
> -               debug("%s: Enabling sriov\n", __func__);
> -               ret =3D pci_enable_sriov(dev, numvfs);
> -               if (ret =3D=3D 0) {
> -                       bch->flags |=3D BCH_FLAG_SRIOV_ENABLED;
> -                       ret =3D numvfs;
> -                       bch->vfs_enabled =3D numvfs;
> -               }
> -       }
> -
> -       debug("VFs enabled: %d\n", ret);
> -exit:
> -       debug("%s: Returning %d\n", __func__, ret);
> -       return ret;
> -}
> -
> -static int octeontx_pci_bchpf_probe(struct udevice *dev)
> -{
> -       struct bch_device *bch;
> -       int ret;
> -
> -       debug("%s(%s)\n", __func__, dev->name);
> -       bch =3D dev_get_priv(dev);
> -       if (!bch)
> -               return -ENOMEM;
> -
> -       bch->reg_base =3D dm_pci_map_bar(dev, PCI_BASE_ADDRESS_0, 0, 0,
> -                                      PCI_REGION_TYPE, PCI_REGION_MEM);
> -       bch->dev =3D dev;
> -
> -       debug("%s: base address: %p\n", __func__, bch->reg_base);
> -       ret =3D bch_device_init(bch);
> -       if (ret) {
> -               printf("%s(%s): init returned %d\n", __func__, dev->name,
> ret);
> -               return ret;
> -       }
> -       INIT_LIST_HEAD(&bch->list);
> -       list_add(&bch->list, &octeontx_bch_devices);
> -       token =3D (void *)dev;
> -
> -       debug("%s: Configuring SRIOV\n", __func__);
> -       bch_sriov_configure(dev, num_vfs);
> -       debug("%s: Done.\n", __func__);
> -       octeontx_bch_putp(bch);
> -
> -       return 0;
> -}
> -
> -static const struct pci_device_id octeontx_bchpf_pci_id_table[] =3D {
> -       { PCI_VDEVICE(CAVIUM, PCI_DEVICE_ID_CAVIUM_BCH) },
> -       {},
> -};
> -
> -static const struct pci_device_id octeontx_bchvf_pci_id_table[] =3D {
> -       { PCI_VDEVICE(CAVIUM, PCI_DEVICE_ID_CAVIUM_BCHVF)},
> -       {},
> -};
> -
> -/**
> - * Given a data block calculate the ecc data and fill in the response
> - *
> - * @param[in] block    8-byte aligned pointer to data block to calculate
> ECC
> - * @param block_size   Size of block in bytes, must be a multiple of two=
.
> - * @param bch_level    Number of errors that must be corrected.  The
> number of
> - *                     parity bytes is equal to ((15 * bch_level) + 7) /
> 8.
> - *                     Must be 4, 8, 16, 24, 32, 40, 48, 56, 60 or 64.
> - * @param[out] ecc     8-byte aligned pointer to where ecc data should g=
o
> - * @param[in] resp     pointer to where responses will be written.
> - *
> - * Return: Zero on success, negative on failure.
> - */
> -int octeontx_bch_encode(struct bch_vf *vf, dma_addr_t block, u16
> block_size,
> -                       u8 bch_level, dma_addr_t ecc, dma_addr_t resp)
> -{
> -       union bch_cmd cmd;
> -       int rc;
> -
> -       memset(&cmd, 0, sizeof(cmd));
> -       cmd.s.cword.ecc_gen =3D eg_gen;
> -       cmd.s.cword.ecc_level =3D bch_level;
> -       cmd.s.cword.size =3D block_size;
> -
> -       cmd.s.oword.ptr =3D ecc;
> -       cmd.s.iword.ptr =3D block;
> -       cmd.s.rword.ptr =3D resp;
> -       rc =3D octeontx_cmd_queue_write(QID_BCH, 1,
> -                                     sizeof(cmd) / sizeof(uint64_t),
> cmd.u);
> -       if (rc)
> -               return -1;
> -
> -       octeontx_bch_write_doorbell(1, vf);
> -
> -       return 0;
> -}
> -
> -/**
> - * Given a data block and ecc data correct the data block
> - *
> - * @param[in] block_ecc_in     8-byte aligned pointer to data block with
> ECC
> - *                             data concatenated to the end to correct
> - * @param block_size           Size of block in bytes, must be a multipl=
e
> of
> - *                             two.
> - * @param bch_level            Number of errors that must be corrected.
> The
> - *                             number of parity bytes is equal to
> - *                             ((15 * bch_level) + 7) / 8.
> - *                             Must be 4, 8, 16, 24, 32, 40, 48, 56, 60
> or 64.
> - * @param[out] block_out       8-byte aligned pointer to corrected data
> buffer.
> - *                             This should not be the same as
> block_ecc_in.
> - * @param[in] resp             pointer to where responses will be writte=
n.
> - *
> - * Return: Zero on success, negative on failure.
> - */
> -
> -int octeontx_bch_decode(struct bch_vf *vf, dma_addr_t block_ecc_in,
> -                       u16 block_size, u8 bch_level,
> -                       dma_addr_t block_out, dma_addr_t resp)
> -{
> -       union bch_cmd cmd;
> -       int rc;
> -
> -       memset(&cmd, 0, sizeof(cmd));
> -       cmd.s.cword.ecc_gen =3D eg_correct;
> -       cmd.s.cword.ecc_level =3D bch_level;
> -       cmd.s.cword.size =3D block_size;
> -
> -       cmd.s.oword.ptr =3D block_out;
> -       cmd.s.iword.ptr =3D block_ecc_in;
> -       cmd.s.rword.ptr =3D resp;
> -       rc =3D octeontx_cmd_queue_write(QID_BCH, 1,
> -                                     sizeof(cmd) / sizeof(uint64_t),
> cmd.u);
> -       if (rc)
> -               return -1;
> -
> -       octeontx_bch_write_doorbell(1, vf);
> -       return 0;
> -}
> -EXPORT_SYMBOL(octeontx_bch_decode);
> -
> -int octeontx_bch_wait(struct bch_vf *vf, union bch_resp *resp,
> -                     dma_addr_t handle)
> -{
> -       ulong start =3D get_timer(0);
> -
> -       __iormb(); /* HW is updating *resp */
> -       while (!resp->s.done && get_timer(start) < 10)
> -               __iormb(); /* HW is updating *resp */
> -
> -       if (resp->s.done)
> -               return 0;
> -
> -       return -ETIMEDOUT;
> -}
> -
> -struct bch_q octeontx_bch_q[QID_MAX];
> -
> -static int octeontx_cmd_queue_initialize(struct udevice *dev, int
> queue_id,
> -                                        int max_depth, int fpa_pool,
> -                                        int pool_size)
> -{
> -       /* some params are for later merge with CPT or cn83xx */
> -       struct bch_q *q =3D &octeontx_bch_q[queue_id];
> -       unsigned long paddr;
> -       u64 *chunk_buffer;
> -       int chunk =3D max_depth + 1;
> -       int i, size;
> -
> -       if ((unsigned int)queue_id >=3D QID_MAX)
> -               return -EINVAL;
> -       if (max_depth & chunk) /* must be 2^N - 1 */
> -               return -EINVAL;
> -
> -       size =3D NQS * chunk * sizeof(u64);
> -       chunk_buffer =3D dma_alloc_coherent(size, &paddr);
> -       if (!chunk_buffer)
> -               return -ENOMEM;
> -
> -       q->base_paddr =3D paddr;
> -       q->dev =3D dev;
> -       q->index =3D 0;
> -       q->max_depth =3D max_depth;
> -       q->pool_size_m1 =3D pool_size;
> -       q->base_vaddr =3D chunk_buffer;
> -
> -       for (i =3D 0; i < NQS; i++) {
> -               u64 *ixp;
> -               int inext =3D (i + 1) * chunk - 1;
> -               int j =3D (i + 1) % NQS;
> -               int jnext =3D j * chunk;
> -               dma_addr_t jbase =3D q->base_paddr + jnext * sizeof(u64);
> -
> -               ixp =3D &chunk_buffer[inext];
> -               *ixp =3D jbase;
> -       }
> -
> -       return 0;
> -}
> -
> -static int octeontx_pci_bchvf_probe(struct udevice *dev)
> -{
> -       struct bch_vf *vf;
> -       union bch_vqx_ctl ctl;
> -       union bch_vqx_cmd_buf cbuf;
> -       int err;
> -
> -       debug("%s(%s)\n", __func__, dev->name);
> -       vf =3D dev_get_priv(dev);
> -       if (!vf)
> -               return -ENOMEM;
> -
> -       vf->dev =3D dev;
> -
> -       /* Map PF's configuration registers */
> -       vf->reg_base =3D dm_pci_map_bar(dev, PCI_BASE_ADDRESS_0, 0, 0,
> -                                     PCI_REGION_TYPE, PCI_REGION_MEM);
> -       debug("%s: reg base: %p\n", __func__, vf->reg_base);
> -
> -       err =3D octeontx_cmd_queue_initialize(dev, QID_BCH, QDEPTH - 1, 0=
,
> -                                           sizeof(union bch_cmd) *
> QDEPTH);
> -       if (err) {
> -               dev_err(dev, "octeontx_cmd_queue_initialize() failed\n");
> -               goto release;
> -       }
> -
> -       ctl.u =3D readq(vf->reg_base + BCH_VQX_CTL(0));
> -
> -       cbuf.u =3D 0;
> -       cbuf.s.ldwb =3D 1;
> -       cbuf.s.dfb =3D 1;
> -       cbuf.s.size =3D QDEPTH;
> -       writeq(cbuf.u, vf->reg_base + BCH_VQX_CMD_BUF(0));
> -
> -       writeq(ctl.u, vf->reg_base + BCH_VQX_CTL(0));
> -
> -       writeq(octeontx_bch_q[QID_BCH].base_paddr,
> -              vf->reg_base + BCH_VQX_CMD_PTR(0));
> -
> -       octeontx_bch_putv(vf);
> -
> -       debug("%s: bch vf initialization complete\n", __func__);
> -
> -       if (octeontx_bch_getv())
> -               return octeontx_pci_nand_deferred_probe();
> -
> -       return -1;
> -
> -release:
> -       return err;
> -}
> -
> -static int octeontx_pci_bchpf_remove(struct udevice *dev)
> -{
> -       struct bch_device *bch =3D dev_get_priv(dev);
> -
> -       bch_disable(bch);
> -       return 0;
> -}
> -
> -U_BOOT_DRIVER(octeontx_pci_bchpf) =3D {
> -       .name   =3D BCHPF_DRIVER_NAME,
> -       .id     =3D UCLASS_MISC,
> -       .probe  =3D octeontx_pci_bchpf_probe,
> -       .remove =3D octeontx_pci_bchpf_remove,
> -       .priv_auto      =3D sizeof(struct bch_device),
> -       .flags =3D DM_FLAG_OS_PREPARE,
> -};
> -
> -U_BOOT_DRIVER(octeontx_pci_bchvf) =3D {
> -       .name   =3D BCHVF_DRIVER_NAME,
> -       .id     =3D UCLASS_MISC,
> -       .probe =3D octeontx_pci_bchvf_probe,
> -       .priv_auto      =3D sizeof(struct bch_vf),
> -};
> -
> -U_BOOT_PCI_DEVICE(octeontx_pci_bchpf, octeontx_bchpf_pci_id_table);
> -U_BOOT_PCI_DEVICE(octeontx_pci_bchvf, octeontx_bchvf_pci_id_table);
> diff --git a/drivers/mtd/nand/raw/octeontx_bch.h
> b/drivers/mtd/nand/raw/octeontx_bch.h
> deleted file mode 100644
> index 95a9b7126fbf..000000000000
> --- a/drivers/mtd/nand/raw/octeontx_bch.h
> +++ /dev/null
> @@ -1,131 +0,0 @@
> -/* SPDX-License-Identifier:    GPL-2.0
> - *
> - * Copyright (C) 2018 Marvell International Ltd.
> - */
> -
> -#ifndef __OCTEONTX_BCH_H__
> -#define __OCTEONTX_BCH_H__
> -
> -#include "octeontx_bch_regs.h"
> -
> -/* flags to indicate the features supported */
> -#define BCH_FLAG_SRIOV_ENABLED         BIT(1)
> -
> -/*
> - * BCH Registers map for 81xx
> - */
> -
> -/* PF registers */
> -#define BCH_CTL                                0x0ull
> -#define BCH_ERR_CFG                    0x10ull
> -#define BCH_BIST_RESULT                        0x80ull
> -#define BCH_ERR_INT                    0x88ull
> -#define BCH_ERR_INT_W1S                        0x90ull
> -#define BCH_ERR_INT_ENA_W1C            0xA0ull
> -#define BCH_ERR_INT_ENA_W1S            0xA8ull
> -
> -/* VF registers */
> -#define BCH_VQX_CTL(z)                 0x0ull
> -#define BCH_VQX_CMD_BUF(z)             0x8ull
> -#define BCH_VQX_CMD_PTR(z)             0x20ull
> -#define BCH_VQX_DOORBELL(z)            0x800ull
> -
> -#define BCHPF_DRIVER_NAME      "octeontx-bchpf"
> -#define BCHVF_DRIVER_NAME      "octeontx-bchvf"
> -
> -struct bch_device {
> -       struct list_head list;
> -       u8 max_vfs;
> -       u8 vfs_enabled;
> -       u8 vfs_in_use;
> -       u32 flags;
> -       void __iomem *reg_base;
> -       struct udevice *dev;
> -};
> -
> -struct bch_vf {
> -       u16 flags;
> -       u8 vfid;
> -       u8 node;
> -       u8 priority;
> -       struct udevice *dev;
> -       void __iomem *reg_base;
> -};
> -
> -struct buf_ptr {
> -       u8 *vptr;
> -       dma_addr_t dma_addr;
> -       u16 size;
> -};
> -
> -void *octeontx_bch_getv(void);
> -void octeontx_bch_putv(void *token);
> -void *octeontx_bch_getp(void);
> -void octeontx_bch_putp(void *token);
> -int octeontx_bch_wait(struct bch_vf *vf, union bch_resp *resp,
> -                     dma_addr_t handle);
> -/**
> - * Given a data block calculate the ecc data and fill in the response
> - *
> - * @param[in] block    8-byte aligned pointer to data block to calculate
> ECC
> - * @param block_size   Size of block in bytes, must be a multiple of two=
.
> - * @param bch_level    Number of errors that must be corrected.  The
> number of
> - *                     parity bytes is equal to ((15 * bch_level) + 7) /
> 8.
> - *                     Must be 4, 8, 16, 24, 32, 40, 48, 56, 60 or 64.
> - * @param[out] ecc     8-byte aligned pointer to where ecc data should g=
o
> - * @param[in] resp     pointer to where responses will be written.
> - *
> - * Return: Zero on success, negative on failure.
> - */
> -int octeontx_bch_encode(struct bch_vf *vf, dma_addr_t block, u16
> block_size,
> -                       u8 bch_level, dma_addr_t ecc, dma_addr_t resp);
> -
> -/**
> - * Given a data block and ecc data correct the data block
> - *
> - * @param[in] block_ecc_in     8-byte aligned pointer to data block with
> ECC
> - *                             data concatenated to the end to correct
> - * @param block_size           Size of block in bytes, must be a multipl=
e
> of
> - *                             two.
> - * @param bch_level            Number of errors that must be corrected.
> The
> - *                             number of parity bytes is equal to
> - *                             ((15 * bch_level) + 7) / 8.
> - *                             Must be 4, 8, 16, 24, 32, 40, 48, 56, 60
> or 64.
> - * @param[out] block_out       8-byte aligned pointer to corrected data
> buffer.
> - *                             This should not be the same as
> block_ecc_in.
> - * @param[in] resp             pointer to where responses will be writte=
n.
> - *
> - * Return: Zero on success, negative on failure.
> - */
> -
> -int octeontx_bch_decode(struct bch_vf *vf, dma_addr_t block_ecc_in,
> -                       u16 block_size, u8 bch_level,
> -                       dma_addr_t block_out, dma_addr_t resp);
> -
> -/**
> - * Ring the BCH doorbell telling it that new commands are
> - * available.
> - *
> - * @param num_commands Number of new commands
> - * @param vf           virtual function handle
> - */
> -static inline void octeontx_bch_write_doorbell(u64 num_commands,
> -                                              struct bch_vf *vf)
> -{
> -       u64 num_words =3D num_commands * sizeof(union bch_cmd) /
> sizeof(uint64_t);
> -
> -       writeq(num_words, vf->reg_base + BCH_VQX_DOORBELL(0));
> -}
> -
> -/**
> - * Since it's possible (and even likely) that the NAND device will be
> probed
> - * before the BCH device has been probed, we may need to defer the
> probing.
> - *
> - * In this case, the initial probe returns success but the actual probin=
g
> - * is deferred until the BCH VF has been probed.
> - *
> - * Return:     0 for success, otherwise error
> - */
> -int octeontx_pci_nand_deferred_probe(void);
> -
> -#endif /* __OCTEONTX_BCH_H__ */
> diff --git a/drivers/mtd/nand/raw/octeontx_bch_regs.h
> b/drivers/mtd/nand/raw/octeontx_bch_regs.h
> deleted file mode 100644
> index 7d34438fec02..000000000000
> --- a/drivers/mtd/nand/raw/octeontx_bch_regs.h
> +++ /dev/null
> @@ -1,167 +0,0 @@
> -/* SPDX-License-Identifier:    GPL-2.0
> - *
> - * Copyright (C) 2018 Marvell International Ltd.
> - */
> -
> -#ifndef __OCTEONTX_BCH_REGS_H__
> -#define __OCTEONTX_BCH_REGS_H__
> -
> -#define BCH_NR_VF      1
> -
> -union bch_cmd {
> -       u64 u[4];
> -       struct fields {
> -           struct {
> -               u64 size:12;
> -               u64 reserved_12_31:20;
> -               u64 ecc_level:4;
> -               u64 reserved_36_61:26;
> -               u64 ecc_gen:2;
> -           } cword;
> -           struct {
> -               u64 ptr:49;
> -               u64 reserved_49_55:7;
> -               u64 nc:1;
> -               u64 fw:1;
> -               u64 reserved_58_63:6;
> -           } oword;
> -           struct {
> -               u64 ptr:49;
> -               u64 reserved_49_55:7;
> -               u64 nc:1;
> -               u64 reserved_57_63:7;
> -           } iword;
> -           struct {
> -               u64 ptr:49;
> -               u64 reserved_49_63:15;
> -           } rword;
> -       } s;
> -};
> -
> -enum ecc_gen {
> -       eg_correct,
> -       eg_copy,
> -       eg_gen,
> -       eg_copy3,
> -};
> -
> -/** Response from BCH instruction */
> -union bch_resp {
> -       u16  u16;
> -       struct {
> -               u16     num_errors:7;   /** Number of errors in block */
> -               u16     zero:6;         /** Always zero, ignore */
> -               u16     erased:1;       /** Block is erased */
> -               u16     uncorrectable:1;/** too many bits flipped */
> -               u16     done:1;         /** Block is done */
> -       } s;
> -};
> -
> -union bch_vqx_ctl {
> -       u64 u;
> -       struct {
> -               u64 reserved_0:1;
> -               u64 cmd_be:1;
> -               u64 max_read:4;
> -               u64 reserved_6_15:10;
> -               u64 erase_disable:1;
> -               u64 one_cmd:1;
> -               u64 early_term:4;
> -               u64 reserved_22_63:42;
> -       } s;
> -};
> -
> -union bch_vqx_cmd_buf {
> -       u64 u;
> -       struct {
> -               u64 reserved_0_32:33;
> -               u64 size:13;
> -               u64 dfb:1;
> -               u64 ldwb:1;
> -               u64 reserved_48_63:16;
> -       } s;
> -};
> -
> -/* keep queue state indexed, even though just one supported here,
> - * for later generalization to similarly-shaped queues on other Cavium
> devices
> - */
> -enum {
> -       QID_BCH,
> -       QID_MAX
> -};
> -
> -struct bch_q {
> -       struct udevice *dev;
> -       int index;
> -       u16 max_depth;
> -       u16 pool_size_m1;
> -       u64 *base_vaddr;
> -       dma_addr_t base_paddr;
> -};
> -
> -extern struct bch_q octeontx_bch_q[QID_MAX];
> -
> -/* with one dma-mapped area, virt<->phys conversions by +/- (vaddr-paddr=
)
> */
> -static inline dma_addr_t qphys(int qid, void *v)
> -{
> -       struct bch_q *q =3D &octeontx_bch_q[qid];
> -       int off =3D (u8 *)v - (u8 *)q->base_vaddr;
> -
> -       return q->base_paddr + off;
> -}
> -
> -#define octeontx_ptr_to_phys(v) qphys(QID_BCH, (v))
> -
> -static inline void *qvirt(int qid, dma_addr_t p)
> -{
> -       struct bch_q *q =3D &octeontx_bch_q[qid];
> -       int off =3D p - q->base_paddr;
> -
> -       return q->base_vaddr + off;
> -}
> -
> -#define octeontx_phys_to_ptr(p) qvirt(QID_BCH, (p))
> -
> -/* plenty for interleaved r/w on two planes with 16k page, ecc_size 1k *=
/
> -/* QDEPTH >=3D 16, as successive chunks must align on 128-byte boundarie=
s */
> -#define QDEPTH 256     /* u64s in a command queue chunk, incl
> next-pointer */
> -#define NQS    1       /* linked chunks in the chain */
> -
> -/**
> - * Write an arbitrary number of command words to a command queue.
> - * This is a generic function; the fixed number of command word
> - * functions yield higher performance.
> - *
> - * Could merge with crypto version for FPA use on cn83xx
> - */
> -static inline int octeontx_cmd_queue_write(int queue_id, bool use_lockin=
g,
> -                                          int cmd_count, const u64 *cmds=
)
> -{
> -       int ret =3D 0;
> -       u64 *cmd_ptr;
> -       struct bch_q *qptr =3D &octeontx_bch_q[queue_id];
> -
> -       if (unlikely(cmd_count < 1 || cmd_count > 32))
> -               return -EINVAL;
> -       if (unlikely(!cmds))
> -               return -EINVAL;
> -
> -       cmd_ptr =3D qptr->base_vaddr;
> -
> -       while (cmd_count > 0) {
> -               int slot =3D qptr->index % (QDEPTH * NQS);
> -
> -               if (slot % QDEPTH !=3D QDEPTH - 1) {
> -                       cmd_ptr[slot] =3D *cmds++;
> -                       cmd_count--;
> -               }
> -
> -               qptr->index++;
> -       }
> -
> -       __iowmb();      /* flush commands before ringing bell */
> -
> -       return ret;
> -}
> -
> -#endif /* __OCTEONTX_BCH_REGS_H__ */
> diff --git a/drivers/mtd/nand/raw/octeontx_nand.c
> b/drivers/mtd/nand/raw/octeontx_nand.c
> deleted file mode 100644
> index 3b20685fac03..000000000000
> --- a/drivers/mtd/nand/raw/octeontx_nand.c
> +++ /dev/null
> @@ -1,2254 +0,0 @@
> -// SPDX-License-Identifier:    GPL-2.0
> -/*
> - * Copyright (C) 2018 Marvell International Ltd.
> - */
> -
> -#include <dm.h>
> -#include <dm/device-internal.h>
> -#include <dm/devres.h>
> -#include <dm/of_access.h>
> -#include <malloc.h>
> -#include <memalign.h>
> -#include <nand.h>
> -#include <pci.h>
> -#include <time.h>
> -#include <linux/bitfield.h>
> -#include <linux/ctype.h>
> -#include <linux/dma-mapping.h>
> -#include <linux/delay.h>
> -#include <linux/errno.h>
> -#include <linux/err.h>
> -#include <linux/ioport.h>
> -#include <linux/libfdt.h>
> -#include <linux/mtd/mtd.h>
> -#include <linux/mtd/nand_bch.h>
> -#include <linux/mtd/nand_ecc.h>
> -#include <linux/mtd/rawnand.h>
> -#include <linux/time.h>
> -#include <asm/global_data.h>
> -#include <asm/io.h>
> -#include <asm/types.h>
> -#include <asm/dma-mapping.h>
> -#include <asm/arch/clock.h>
> -#include "octeontx_bch.h"
> -
> -/*
> - * The NDF_CMD queue takes commands between 16 - 128 bit.
> - * All commands must be 16 bit aligned and are little endian.
> - * WAIT_STATUS commands must be 64 bit aligned.
> - * Commands are selected by the 4 bit opcode.
> - *
> - * Available Commands:
> - *
> - * 16 Bit:
> - *   NOP
> - *   WAIT
> - *   BUS_ACQ, BUS_REL
> - *   CHIP_EN, CHIP_DIS
> - *
> - * 32 Bit:
> - *   CLE_CMD
> - *   RD_CMD, RD_EDO_CMD
> - *   WR_CMD
> - *
> - * 64 Bit:
> - *   SET_TM_PAR
> - *
> - * 96 Bit:
> - *   ALE_CMD
> - *
> - * 128 Bit:
> - *   WAIT_STATUS, WAIT_STATUS_ALE
> - */
> -
> -/* NDF Register offsets */
> -#define NDF_CMD                        0x0
> -#define NDF_MISC               0x8
> -#define NDF_ECC_CNT            0x10
> -#define NDF_DRBELL             0x30
> -#define NDF_ST_REG             0x38    /* status */
> -#define NDF_INT                        0x40
> -#define NDF_INT_W1S            0x48
> -#define NDF_DMA_CFG            0x50
> -#define NDF_DMA_ADR            0x58
> -#define NDF_INT_ENA_W1C                0x60
> -#define NDF_INT_ENA_W1S                0x68
> -
> -/* NDF command opcodes */
> -#define NDF_OP_NOP             0x0
> -#define NDF_OP_SET_TM_PAR      0x1
> -#define NDF_OP_WAIT            0x2
> -#define NDF_OP_CHIP_EN_DIS     0x3
> -#define NDF_OP_CLE_CMD         0x4
> -#define NDF_OP_ALE_CMD         0x5
> -#define NDF_OP_WR_CMD          0x8
> -#define NDF_OP_RD_CMD          0x9
> -#define NDF_OP_RD_EDO_CMD      0xa
> -#define NDF_OP_WAIT_STATUS     0xb     /* same opcode for WAIT_STATUS_AL=
E
> */
> -#define NDF_OP_BUS_ACQ_REL     0xf
> -
> -#define NDF_BUS_ACQUIRE                1
> -#define NDF_BUS_RELEASE                0
> -
> -#define DBGX_EDSCR(X)          (0x87A008000088 + (X) * 0x80000)
> -
> -struct ndf_nop_cmd {
> -       u16 opcode:     4;
> -       u16 nop:        12;
> -};
> -
> -struct ndf_wait_cmd {
> -       u16 opcode:4;
> -       u16 r_b:1;              /* wait for one cycle or PBUS_WAIT
> deassert */
> -       u16:3;
> -       u16 wlen:3;             /* timing parameter select */
> -       u16:5;
> -};
> -
> -struct ndf_bus_cmd {
> -       u16 opcode:4;
> -       u16 direction:4;        /* 1 =3D acquire, 0 =3D release */
> -       u16:8;
> -};
> -
> -struct ndf_chip_cmd {
> -       u16 opcode:4;
> -       u16 chip:3;             /* select chip, 0 =3D disable */
> -       u16 enable:1;           /* 1 =3D enable, 0 =3D disable */
> -       u16 bus_width:2;        /* 10 =3D 16 bit, 01 =3D 8 bit */
> -       u16:6;
> -};
> -
> -struct ndf_cle_cmd {
> -       u32 opcode:4;
> -       u32:4;
> -       u32 cmd_data:8;         /* command sent to the PBUS AD pins */
> -       u32 clen1:3;            /* time between PBUS CLE and WE asserts *=
/
> -       u32 clen2:3;            /* time WE remains asserted */
> -       u32 clen3:3;            /* time between WE deassert and CLE */
> -       u32:7;
> -};
> -
> -/* RD_EDO_CMD uses the same layout as RD_CMD */
> -struct ndf_rd_cmd {
> -       u32 opcode:4;
> -       u32 data:16;            /* data bytes */
> -       u32 rlen1:3;
> -       u32 rlen2:3;
> -       u32 rlen3:3;
> -       u32 rlen4:3;
> -};
> -
> -struct ndf_wr_cmd {
> -       u32 opcode:4;
> -       u32 data:16;            /* data bytes */
> -       u32:4;
> -       u32 wlen1:3;
> -       u32 wlen2:3;
> -       u32:3;
> -};
> -
> -struct ndf_set_tm_par_cmd {
> -       u64 opcode:4;
> -       u64 tim_mult:4; /* multiplier for the seven parameters */
> -       u64 tm_par1:8;  /* --> Following are the 7 timing parameters that
> */
> -       u64 tm_par2:8;  /*     specify the number of coprocessor cycles.
> */
> -       u64 tm_par3:8;  /*     A value of zero means one cycle.
>  */
> -       u64 tm_par4:8;  /*     All values are scaled by tim_mult
> */
> -       u64 tm_par5:8;  /*     using tim_par * (2 ^ tim_mult).
> */
> -       u64 tm_par6:8;
> -       u64 tm_par7:8;
> -};
> -
> -struct ndf_ale_cmd {
> -       u32 opcode:4;
> -       u32:4;
> -       u32 adr_byte_num:4;     /* number of address bytes to be sent */
> -       u32:4;
> -       u32 alen1:3;
> -       u32 alen2:3;
> -       u32 alen3:3;
> -       u32 alen4:3;
> -       u32:4;
> -       u8 adr_byt1;
> -       u8 adr_byt2;
> -       u8 adr_byt3;
> -       u8 adr_byt4;
> -       u8 adr_byt5;
> -       u8 adr_byt6;
> -       u8 adr_byt7;
> -       u8 adr_byt8;
> -};
> -
> -struct ndf_wait_status_cmd {
> -       u32 opcode:4;
> -       u32:4;
> -       u32 data:8;             /** data */
> -       u32 clen1:3;
> -       u32 clen2:3;
> -       u32 clen3:3;
> -       u32:8;
> -       /** set to 5 to select WAIT_STATUS_ALE command */
> -       u32 ale_ind:8;
> -       /** ALE only: number of address bytes to be sent */
> -       u32 adr_byte_num:4;
> -       u32:4;
> -       u32 alen1:3;    /* ALE only */
> -       u32 alen2:3;    /* ALE only */
> -       u32 alen3:3;    /* ALE only */
> -       u32 alen4:3;    /* ALE only */
> -       u32:4;
> -       u8 adr_byt[4];          /* ALE only */
> -       u32 nine:4;     /* set to 9 */
> -       u32 and_mask:8;
> -       u32 comp_byte:8;
> -       u32 rlen1:3;
> -       u32 rlen2:3;
> -       u32 rlen3:3;
> -       u32 rlen4:3;
> -};
> -
> -union ndf_cmd {
> -       u64 val[2];
> -       union {
> -               struct ndf_nop_cmd              nop;
> -               struct ndf_wait_cmd             wait;
> -               struct ndf_bus_cmd              bus_acq_rel;
> -               struct ndf_chip_cmd             chip_en_dis;
> -               struct ndf_cle_cmd              cle_cmd;
> -               struct ndf_rd_cmd               rd_cmd;
> -               struct ndf_wr_cmd               wr_cmd;
> -               struct ndf_set_tm_par_cmd       set_tm_par;
> -               struct ndf_ale_cmd              ale_cmd;
> -               struct ndf_wait_status_cmd      wait_status;
> -       } u;
> -};
> -
> -/** Disable multi-bit error hangs */
> -#define NDF_MISC_MB_DIS                BIT_ULL(27)
> -/** High watermark for NBR FIFO or load/store operations */
> -#define NDF_MISC_NBR_HWM       GENMASK_ULL(26, 24)
> -/** Wait input filter count */
> -#define NDF_MISC_WAIT_CNT      GENMASK_ULL(23, 18)
> -/** Unfilled NFD_CMD queue bytes */
> -#define NDF_MISC_FR_BYTE       GENMASK_ULL(17, 7)
> -/** Set by HW when it reads the last 8 bytes of NDF_CMD */
> -#define NDF_MISC_RD_DONE       BIT_ULL(6)
> -/** Set by HW when it reads. SW read of NDF_CMD clears it */
> -#define NDF_MISC_RD_VAL                BIT_ULL(5)
> -/** Let HW read NDF_CMD queue. Cleared on SW NDF_CMD write */
> -#define NDF_MISC_RD_CMD                BIT_ULL(4)
> -/** Boot disable */
> -#define NDF_MISC_BT_DIS                BIT_ULL(2)
> -/** Stop command execution after completing command queue */
> -#define NDF_MISC_EX_DIS                BIT_ULL(1)
> -/** Reset fifo */
> -#define NDF_MISC_RST_FF                BIT_ULL(0)
> -
> -/** DMA engine enable */
> -#define NDF_DMA_CFG_EN         BIT_ULL(63)
> -/** Read or write */
> -#define NDF_DMA_CFG_RW         BIT_ULL(62)
> -/** Terminates DMA and clears enable bit */
> -#define NDF_DMA_CFG_CLR                BIT_ULL(61)
> -/** 32-bit swap enable */
> -#define NDF_DMA_CFG_SWAP32     BIT_ULL(59)
> -/** 16-bit swap enable */
> -#define NDF_DMA_CFG_SWAP16     BIT_ULL(58)
> -/** 8-bit swap enable */
> -#define NDF_DMA_CFG_SWAP8      BIT_ULL(57)
> -/** Endian mode */
> -#define NDF_DMA_CFG_CMD_BE     BIT_ULL(56)
> -/** Number of 64 bit transfers */
> -#define NDF_DMA_CFG_SIZE       GENMASK_ULL(55, 36)
> -
> -/** Command execution status idle */
> -#define NDF_ST_REG_EXE_IDLE    BIT_ULL(15)
> -/** Command execution SM states */
> -#define NDF_ST_REG_EXE_SM      GENMASK_ULL(14, 11)
> -/** DMA and load SM states */
> -#define NDF_ST_REG_BT_SM       GENMASK_ULL(10, 7)
> -/** Queue read-back SM bad state */
> -#define NDF_ST_REG_RD_FF_BAD   BIT_ULL(6)
> -/** Queue read-back SM states */
> -#define NDF_ST_REG_RD_FF       GENMASK_ULL(5, 4)
> -/** Main SM is in a bad state */
> -#define NDF_ST_REG_MAIN_BAD    BIT_ULL(3)
> -/** Main SM states */
> -#define NDF_ST_REG_MAIN_SM     GENMASK_ULL(2, 0)
> -
> -#define MAX_NAND_NAME_LEN      64
> -#if (defined(NAND_MAX_PAGESIZE) && (NAND_MAX_PAGESIZE > 4096)) ||      \
> -       !defined(NAND_MAX_PAGESIZE)
> -# undef NAND_MAX_PAGESIZE
> -# define NAND_MAX_PAGESIZE     4096
> -#endif
> -#if (defined(NAND_MAX_OOBSIZE) && (NAND_MAX_OOBSIZE > 256)) ||         \
> -       !defined(NAND_MAX_OOBSIZE)
> -# undef NAND_MAX_OOBSIZE
> -# define NAND_MAX_OOBSIZE      256
> -#endif
> -
> -#define OCTEONTX_NAND_DRIVER_NAME      "octeontx_nand"
> -
> -#define NDF_TIMEOUT            1000    /** Timeout in ms */
> -#ifndef NAND_MAX_CHIPS
> -# define NAND_MAX_CHIPS                8       /** Linux compatibility *=
/
> -#endif
> -
> -struct octeontx_nand_chip {
> -       struct list_head node;
> -       struct nand_chip nand;
> -       struct ndf_set_tm_par_cmd timings;
> -       int cs;
> -       int selected_page;
> -       int iface_mode;
> -       int row_bytes;
> -       int col_bytes;
> -       bool oob_only;
> -       bool iface_set;
> -};
> -
> -struct octeontx_nand_buf {
> -       u8 *dmabuf;
> -       dma_addr_t dmaaddr;
> -       int dmabuflen;
> -       int data_len;
> -       int data_index;
> -};
> -
> -/** NAND flash controller (NDF) related information */
> -struct octeontx_nfc {
> -       struct nand_hw_control controller;
> -       struct udevice *dev;
> -       void __iomem *base;
> -       struct list_head chips;
> -       int selected_chip;      /* Currently selected NAND chip number */
> -
> -       /*
> -        * Status is separate from octeontx_nand_buf because
> -        * it can be used in parallel and during init.
> -        */
> -       u8 *stat;
> -       dma_addr_t stat_addr;
> -       bool use_status;
> -
> -       struct octeontx_nand_buf buf;
> -       union bch_resp *bch_resp;
> -       dma_addr_t bch_rhandle;
> -
> -       /* BCH of all-0xff, so erased pages read as error-free */
> -       unsigned char *eccmask;
> -};
> -
> -/* settable timings - 0..7 select timing of alen1..4/clen1..3/etc */
> -enum tm_idx {
> -       t0, /* fixed at 4<<mult cycles */
> -       t1, t2, t3, t4, t5, t6, t7, /* settable per ONFI-timing mode */
> -};
> -
> -struct octeontx_probe_device {
> -       struct list_head list;
> -       struct udevice *dev;
> -};
> -
> -static struct bch_vf *bch_vf;
> -/** Deferred devices due to BCH not being ready */
> -static LIST_HEAD(octeontx_pci_nand_deferred_devices);
> -
> -/** default parameters used for probing chips */
> -#define MAX_ONFI_MODE  5
> -
> -static int default_onfi_timing;
> -static int slew_ns =3D 2; /* default timing padding */
> -static int def_ecc_size =3D 512; /* 1024 best for sw_bch, <=3D 4095 for
> hw_bch */
> -static int default_width =3D 1; /* 8 bit */
> -static int default_page_size =3D 2048;
> -static struct ndf_set_tm_par_cmd default_timing_parms;
> -
> -/** Port from Linux */
> -#define readq_poll_timeout(addr, val, cond, delay_us, timeout_us)      \
> -({                                                                     \
> -       ulong __start =3D get_timer(0);                                  =
 \
> -       void *__addr =3D (addr);                                         =
 \
> -       const ulong __timeout_ms =3D timeout_us / 1000;                  =
 \
> -       do {                                                            \
> -               (val) =3D readq(__addr);                                 =
 \
> -               if (cond)                                               \
> -                       break;                                          \
> -               if (timeout_us && get_timer(__start) > __timeout_ms) {  \
> -                       (val) =3D readq(__addr);                         =
 \
> -                       break;                                          \
> -               }                                                       \
> -               if (delay_us)                                           \
> -                       udelay(delay_us);                               \
> -       } while (1);                                                    \
> -       (cond) ? 0 : -ETIMEDOUT;                                        \
> -})
> -
> -/** Ported from Linux 4.9.0 include/linux/of.h for compatibility */
> -static inline int of_get_child_count(const ofnode node)
> -{
> -       return fdtdec_get_child_count(gd->fdt_blob,
> ofnode_to_offset(node));
> -}
> -
> -/**
> - * Linux compatibility from Linux 4.9.0 drivers/mtd/nand/nand_base.c
> - */
> -static int nand_ooblayout_ecc_lp(struct mtd_info *mtd, int section,
> -                                struct mtd_oob_region *oobregion)
> -{
> -       struct nand_chip *chip =3D mtd_to_nand(mtd);
> -       struct nand_ecc_ctrl *ecc =3D &chip->ecc;
> -
> -       if (section || !ecc->total)
> -               return -ERANGE;
> -
> -       oobregion->length =3D ecc->total;
> -       oobregion->offset =3D mtd->oobsize - oobregion->length;
> -
> -       return 0;
> -}
> -
> -/**
> - * Linux compatibility from Linux 4.9.0 drivers/mtd/nand/nand_base.c
> - */
> -static int nand_ooblayout_free_lp(struct mtd_info *mtd, int section,
> -                                 struct mtd_oob_region *oobregion)
> -{
> -       struct nand_chip *chip =3D mtd_to_nand(mtd);
> -       struct nand_ecc_ctrl *ecc =3D &chip->ecc;
> -
> -       if (section)
> -               return -ERANGE;
> -
> -       oobregion->length =3D mtd->oobsize - ecc->total - 2;
> -       oobregion->offset =3D 2;
> -
> -       return 0;
> -}
> -
> -static const struct mtd_ooblayout_ops nand_ooblayout_lp_ops =3D {
> -       .ecc =3D nand_ooblayout_ecc_lp,
> -       .rfree =3D nand_ooblayout_free_lp,
> -};
> -
> -static inline struct octeontx_nand_chip *to_otx_nand(struct nand_chip
> *nand)
> -{
> -       return container_of(nand, struct octeontx_nand_chip, nand);
> -}
> -
> -static inline struct octeontx_nfc *to_otx_nfc(struct nand_hw_control
> *ctrl)
> -{
> -       return container_of(ctrl, struct octeontx_nfc, controller);
> -}
> -
> -static int octeontx_nand_calc_ecc_layout(struct nand_chip *nand)
> -{
> -       struct nand_ecclayout *layout =3D nand->ecc.layout;
> -       struct octeontx_nfc *tn =3D to_otx_nfc(nand->controller);
> -       struct mtd_info *mtd =3D &nand->mtd;
> -       int oobsize =3D mtd->oobsize;
> -       int i;
> -       bool layout_alloc =3D false;
> -
> -       if (!layout) {
> -               layout =3D devm_kzalloc(tn->dev, sizeof(*layout),
> GFP_KERNEL);
> -               if (!layout)
> -                       return -ENOMEM;
> -               nand->ecc.layout =3D layout;
> -               layout_alloc =3D true;
> -       }
> -       layout->eccbytes =3D nand->ecc.steps * nand->ecc.bytes;
> -       /* Reserve 2 bytes for bad block marker */
> -       if (layout->eccbytes + 2 > oobsize) {
> -               pr_err("No suitable oob scheme available for oobsize %d
> eccbytes %u\n",
> -                      oobsize, layout->eccbytes);
> -               goto fail;
> -       }
> -       /* put ecc bytes at oob tail */
> -       for (i =3D 0; i < layout->eccbytes; i++)
> -               layout->eccpos[i] =3D oobsize - layout->eccbytes + i;
> -       layout->oobfree[0].offset =3D 2;
> -       layout->oobfree[0].length =3D oobsize - 2 - layout->eccbytes;
> -       nand->ecc.layout =3D layout;
> -       return 0;
> -
> -fail:
> -       if (layout_alloc)
> -               kfree(layout);
> -       return -1;
> -}
> -
> -/*
> - * Read a single byte from the temporary buffer. Used after READID
> - * to get the NAND information and for STATUS.
> - */
> -static u8 octeontx_nand_read_byte(struct mtd_info *mtd)
> -{
> -       struct nand_chip *nand =3D mtd_to_nand(mtd);
> -       struct octeontx_nfc *tn =3D to_otx_nfc(nand->controller);
> -
> -       if (tn->use_status) {
> -               tn->use_status =3D false;
> -               return *tn->stat;
> -       }
> -
> -       if (tn->buf.data_index < tn->buf.data_len)
> -               return tn->buf.dmabuf[tn->buf.data_index++];
> -
> -       dev_err(tn->dev, "No data to read, idx: 0x%x, len: 0x%x\n",
> -               tn->buf.data_index, tn->buf.data_len);
> -
> -       return 0xff;
> -}
> -
> -/*
> - * Read a number of pending bytes from the temporary buffer. Used
> - * to get page and OOB data.
> - */
> -static void octeontx_nand_read_buf(struct mtd_info *mtd, u8 *buf, int le=
n)
> -{
> -       struct nand_chip *nand =3D mtd_to_nand(mtd);
> -       struct octeontx_nfc *tn =3D to_otx_nfc(nand->controller);
> -
> -       if (len > tn->buf.data_len - tn->buf.data_index) {
> -               dev_err(tn->dev, "Not enough data for read of %d bytes\n"=
,
> len);
> -               return;
> -       }
> -
> -       memcpy(buf, tn->buf.dmabuf + tn->buf.data_index, len);
> -       tn->buf.data_index +=3D len;
> -}
> -
> -static void octeontx_nand_write_buf(struct mtd_info *mtd,
> -                                   const u8 *buf, int len)
> -{
> -       struct nand_chip *nand =3D mtd_to_nand(mtd);
> -       struct octeontx_nfc *tn =3D to_otx_nfc(nand->controller);
> -
> -       memcpy(tn->buf.dmabuf + tn->buf.data_len, buf, len);
> -       tn->buf.data_len +=3D len;
> -}
> -
> -/* Overwrite default function to avoid sync abort on chip =3D -1. */
> -static void octeontx_nand_select_chip(struct mtd_info *mtd, int chip)
> -{
> -}
> -
> -static inline int timing_to_cycle(u32 psec, unsigned long clock)
> -{
> -       unsigned int ns;
> -       int ticks;
> -
> -       ns =3D DIV_ROUND_UP(psec, 1000);
> -       ns +=3D slew_ns;
> -
> -       /* no rounding needed since clock is multiple of 1MHz */
> -       clock /=3D 1000000;
> -       ns *=3D clock;
> -
> -       ticks =3D DIV_ROUND_UP(ns, 1000);
> -
> -       /* actual delay is (tm_parX+1)<<tim_mult */
> -       if (ticks)
> -               ticks--;
> -
> -       return ticks;
> -}
> -
> -static void set_timings(struct octeontx_nand_chip *chip,
> -                       struct ndf_set_tm_par_cmd *tp,
> -                       const struct nand_sdr_timings *timings,
> -                       unsigned long sclk)
> -{
> -       /* scaled coprocessor-cycle values */
> -       u32 s_wh, s_cls, s_clh, s_rp, s_wb, s_wc;
> -
> -       tp->tim_mult =3D 0;
> -       s_wh =3D timing_to_cycle(timings->tWH_min, sclk);
> -       s_cls =3D timing_to_cycle(timings->tCLS_min, sclk);
> -       s_clh =3D timing_to_cycle(timings->tCLH_min, sclk);
> -       s_rp =3D timing_to_cycle(timings->tRP_min, sclk);
> -       s_wb =3D timing_to_cycle(timings->tWB_max, sclk);
> -       s_wc =3D timing_to_cycle(timings->tWC_min, sclk);
> -
> -       tp->tm_par1 =3D s_wh;
> -       tp->tm_par2 =3D s_clh;
> -       tp->tm_par3 =3D s_rp + 1;
> -       tp->tm_par4 =3D s_cls - s_wh;
> -       tp->tm_par5 =3D s_wc - s_wh + 1;
> -       tp->tm_par6 =3D s_wb;
> -       tp->tm_par7 =3D 0;
> -       tp->tim_mult++; /* overcompensate for bad math */
> -
> -       /* TODO: comment parameter re-use */
> -
> -       pr_debug("%s: tim_par: mult: %d  p1: %d  p2: %d  p3: %d\n",
> -                __func__, tp->tim_mult, tp->tm_par1, tp->tm_par2,
> tp->tm_par3);
> -       pr_debug("                 p4: %d  p5: %d  p6: %d  p7: %d\n",
> -                tp->tm_par4, tp->tm_par5, tp->tm_par6, tp->tm_par7);
> -}
> -
> -static int set_default_timings(struct octeontx_nfc *tn,
> -                              const struct nand_sdr_timings *timings)
> -{
> -       unsigned long sclk =3D octeontx_get_io_clock();
> -
> -       set_timings(NULL, &default_timing_parms, timings, sclk);
> -       return 0;
> -}
> -
> -static int octeontx_nfc_chip_set_timings(struct octeontx_nand_chip *chip=
,
> -                                        const struct nand_sdr_timings
> *timings)
> -{
> -       /*struct octeontx_nfc *tn =3D to_otx_nfc(chip->nand.controller);*=
/
> -       unsigned long sclk =3D octeontx_get_io_clock();
> -
> -       set_timings(chip, &chip->timings, timings, sclk);
> -       return 0;
> -}
> -
> -/* How many bytes are free in the NFD_CMD queue? */
> -static int ndf_cmd_queue_free(struct octeontx_nfc *tn)
> -{
> -       u64 ndf_misc;
> -
> -       ndf_misc =3D readq(tn->base + NDF_MISC);
> -       return FIELD_GET(NDF_MISC_FR_BYTE, ndf_misc);
> -}
> -
> -/* Submit a command to the NAND command queue. */
> -static int ndf_submit(struct octeontx_nfc *tn, union ndf_cmd *cmd)
> -{
> -       int opcode =3D cmd->val[0] & 0xf;
> -
> -       switch (opcode) {
> -       /* All these commands fit in one 64bit word */
> -       case NDF_OP_NOP:
> -       case NDF_OP_SET_TM_PAR:
> -       case NDF_OP_WAIT:
> -       case NDF_OP_CHIP_EN_DIS:
> -       case NDF_OP_CLE_CMD:
> -       case NDF_OP_WR_CMD:
> -       case NDF_OP_RD_CMD:
> -       case NDF_OP_RD_EDO_CMD:
> -       case NDF_OP_BUS_ACQ_REL:
> -               if (ndf_cmd_queue_free(tn) < 8)
> -                       goto full;
> -               writeq(cmd->val[0], tn->base + NDF_CMD);
> -               break;
> -       case NDF_OP_ALE_CMD:
> -               /* ALE commands take either one or two 64bit words */
> -               if (cmd->u.ale_cmd.adr_byte_num < 5) {
> -                       if (ndf_cmd_queue_free(tn) < 8)
> -                               goto full;
> -                       writeq(cmd->val[0], tn->base + NDF_CMD);
> -               } else {
> -                       if (ndf_cmd_queue_free(tn) < 16)
> -                               goto full;
> -                       writeq(cmd->val[0], tn->base + NDF_CMD);
> -                       writeq(cmd->val[1], tn->base + NDF_CMD);
> -               }
> -               break;
> -       case NDF_OP_WAIT_STATUS: /* Wait status commands take two 64bit
> words */
> -               if (ndf_cmd_queue_free(tn) < 16)
> -                       goto full;
> -               writeq(cmd->val[0], tn->base + NDF_CMD);
> -               writeq(cmd->val[1], tn->base + NDF_CMD);
> -               break;
> -       default:
> -               dev_err(tn->dev, "%s: unknown command: %u\n", __func__,
> opcode);
> -               return -EINVAL;
> -       }
> -       return 0;
> -
> -full:
> -       dev_err(tn->dev, "%s: no space left in command queue\n", __func__=
);
> -       return -ENOMEM;
> -}
> -
> -/**
> - * Wait for the ready/busy signal. First wait for busy to be valid,
> - * then wait for busy to de-assert.
> - */
> -static int ndf_build_wait_busy(struct octeontx_nfc *tn)
> -{
> -       union ndf_cmd cmd;
> -
> -       memset(&cmd, 0, sizeof(cmd));
> -       cmd.u.wait.opcode =3D NDF_OP_WAIT;
> -       cmd.u.wait.r_b =3D 1;
> -       cmd.u.wait.wlen =3D t6;
> -
> -       if (ndf_submit(tn, &cmd))
> -               return -ENOMEM;
> -       return 0;
> -}
> -
> -static bool ndf_dma_done(struct octeontx_nfc *tn)
> -{
> -       u64 dma_cfg;
> -
> -       /* Enable bit should be clear after a transfer */
> -       dma_cfg =3D readq(tn->base + NDF_DMA_CFG);
> -       if (!(dma_cfg & NDF_DMA_CFG_EN))
> -               return true;
> -
> -       return false;
> -}
> -
> -static int ndf_wait(struct octeontx_nfc *tn)
> -{
> -       ulong start =3D get_timer(0);
> -       bool done;
> -
> -       while (!(done =3D ndf_dma_done(tn)) && get_timer(start) <
> NDF_TIMEOUT)
> -               ;
> -
> -       if (!done) {
> -               dev_err(tn->dev, "%s: timeout error\n", __func__);
> -               return -ETIMEDOUT;
> -       }
> -       return 0;
> -}
> -
> -static int ndf_wait_idle(struct octeontx_nfc *tn)
> -{
> -       u64 val;
> -       u64 dval =3D 0;
> -       int rc;
> -       int pause =3D 100;
> -       u64 tot_us =3D USEC_PER_SEC / 10;
> -
> -       rc =3D readq_poll_timeout(tn->base + NDF_ST_REG,
> -                               val, val & NDF_ST_REG_EXE_IDLE, pause,
> tot_us);
> -       if (!rc)
> -               rc =3D readq_poll_timeout(tn->base + NDF_DMA_CFG,
> -                                       dval, !(dval & NDF_DMA_CFG_EN),
> -                                       pause, tot_us);
> -
> -       return rc;
> -}
> -
> -/** Issue set timing parameters */
> -static int ndf_queue_cmd_timing(struct octeontx_nfc *tn,
> -                               struct ndf_set_tm_par_cmd *timings)
> -{
> -       union ndf_cmd cmd;
> -
> -       memset(&cmd, 0, sizeof(cmd));
> -       cmd.u.set_tm_par.opcode =3D NDF_OP_SET_TM_PAR;
> -       cmd.u.set_tm_par.tim_mult =3D timings->tim_mult;
> -       cmd.u.set_tm_par.tm_par1 =3D timings->tm_par1;
> -       cmd.u.set_tm_par.tm_par2 =3D timings->tm_par2;
> -       cmd.u.set_tm_par.tm_par3 =3D timings->tm_par3;
> -       cmd.u.set_tm_par.tm_par4 =3D timings->tm_par4;
> -       cmd.u.set_tm_par.tm_par5 =3D timings->tm_par5;
> -       cmd.u.set_tm_par.tm_par6 =3D timings->tm_par6;
> -       cmd.u.set_tm_par.tm_par7 =3D timings->tm_par7;
> -       return ndf_submit(tn, &cmd);
> -}
> -
> -/** Issue bus acquire or release */
> -static int ndf_queue_cmd_bus(struct octeontx_nfc *tn, int direction)
> -{
> -       union ndf_cmd cmd;
> -
> -       memset(&cmd, 0, sizeof(cmd));
> -       cmd.u.bus_acq_rel.opcode =3D NDF_OP_BUS_ACQ_REL;
> -       cmd.u.bus_acq_rel.direction =3D direction;
> -       return ndf_submit(tn, &cmd);
> -}
> -
> -/* Issue chip select or deselect */
> -static int ndf_queue_cmd_chip(struct octeontx_nfc *tn, int enable, int
> chip,
> -                             int width)
> -{
> -       union ndf_cmd cmd;
> -
> -       memset(&cmd, 0, sizeof(cmd));
> -       cmd.u.chip_en_dis.opcode =3D NDF_OP_CHIP_EN_DIS;
> -       cmd.u.chip_en_dis.chip =3D chip;
> -       cmd.u.chip_en_dis.enable =3D enable;
> -       cmd.u.chip_en_dis.bus_width =3D width;
> -       return ndf_submit(tn, &cmd);
> -}
> -
> -static int ndf_queue_cmd_wait(struct octeontx_nfc *tn, int t_delay)
> -{
> -       union ndf_cmd cmd;
> -
> -       memset(&cmd, 0, sizeof(cmd));
> -       cmd.u.wait.opcode =3D NDF_OP_WAIT;
> -       cmd.u.wait.wlen =3D t_delay;
> -       return ndf_submit(tn, &cmd);
> -}
> -
> -static int ndf_queue_cmd_cle(struct octeontx_nfc *tn, int command)
> -{
> -       union ndf_cmd cmd;
> -
> -       memset(&cmd, 0, sizeof(cmd));
> -       cmd.u.cle_cmd.opcode =3D NDF_OP_CLE_CMD;
> -       cmd.u.cle_cmd.cmd_data =3D command;
> -       cmd.u.cle_cmd.clen1 =3D t4;
> -       cmd.u.cle_cmd.clen2 =3D t1;
> -       cmd.u.cle_cmd.clen3 =3D t2;
> -       return ndf_submit(tn, &cmd);
> -}
> -
> -static int ndf_queue_cmd_ale(struct octeontx_nfc *tn, int addr_bytes,
> -                            struct nand_chip *nand, u64 page,
> -                            u32 col, int page_size)
> -{
> -       struct octeontx_nand_chip *octeontx_nand =3D (nand) ?
> -                                               to_otx_nand(nand) : NULL;
> -       union ndf_cmd cmd;
> -
> -       memset(&cmd, 0, sizeof(cmd));
> -       cmd.u.ale_cmd.opcode =3D NDF_OP_ALE_CMD;
> -       cmd.u.ale_cmd.adr_byte_num =3D addr_bytes;
> -
> -       /* set column bit for OOB area, assume OOB follows page */
> -       if (octeontx_nand && octeontx_nand->oob_only)
> -               col +=3D page_size;
> -
> -       /* page is u64 for this generality, even if cmdfunc() passes int =
*/
> -       switch (addr_bytes) {
> -       /* 4-8 bytes: page, then 2-byte col */
> -       case 8:
> -               cmd.u.ale_cmd.adr_byt8 =3D (page >> 40) & 0xff;
> -               fallthrough;
> -       case 7:
> -               cmd.u.ale_cmd.adr_byt7 =3D (page >> 32) & 0xff;
> -               fallthrough;
> -       case 6:
> -               cmd.u.ale_cmd.adr_byt6 =3D (page >> 24) & 0xff;
> -               fallthrough;
> -       case 5:
> -               cmd.u.ale_cmd.adr_byt5 =3D (page >> 16) & 0xff;
> -               fallthrough;
> -       case 4:
> -               cmd.u.ale_cmd.adr_byt4 =3D (page >> 8) & 0xff;
> -               cmd.u.ale_cmd.adr_byt3 =3D page & 0xff;
> -               cmd.u.ale_cmd.adr_byt2 =3D (col >> 8) & 0xff;
> -               cmd.u.ale_cmd.adr_byt1 =3D  col & 0xff;
> -               break;
> -       /* 1-3 bytes: just the page address */
> -       case 3:
> -               cmd.u.ale_cmd.adr_byt3 =3D (page >> 16) & 0xff;
> -               fallthrough;
> -       case 2:
> -               cmd.u.ale_cmd.adr_byt2 =3D (page >> 8) & 0xff;
> -               fallthrough;
> -       case 1:
> -               cmd.u.ale_cmd.adr_byt1 =3D page & 0xff;
> -               break;
> -       default:
> -               break;
> -       }
> -
> -       cmd.u.ale_cmd.alen1 =3D t3;
> -       cmd.u.ale_cmd.alen2 =3D t1;
> -       cmd.u.ale_cmd.alen3 =3D t5;
> -       cmd.u.ale_cmd.alen4 =3D t2;
> -       return ndf_submit(tn, &cmd);
> -}
> -
> -static int ndf_queue_cmd_write(struct octeontx_nfc *tn, int len)
> -{
> -       union ndf_cmd cmd;
> -
> -       memset(&cmd, 0, sizeof(cmd));
> -       cmd.u.wr_cmd.opcode =3D NDF_OP_WR_CMD;
> -       cmd.u.wr_cmd.data =3D len;
> -       cmd.u.wr_cmd.wlen1 =3D t3;
> -       cmd.u.wr_cmd.wlen2 =3D t1;
> -       return ndf_submit(tn, &cmd);
> -}
> -
> -static int ndf_build_pre_cmd(struct octeontx_nfc *tn, int cmd1,
> -                            int addr_bytes, u64 page, u32 col, int cmd2)
> -{
> -       struct nand_chip *nand =3D tn->controller.active;
> -       struct octeontx_nand_chip *octeontx_nand;
> -       struct ndf_set_tm_par_cmd *timings;
> -       int width, page_size, rc;
> -
> -       /* Also called before chip probing is finished */
> -       if (!nand) {
> -               timings =3D &default_timing_parms;
> -               page_size =3D default_page_size;
> -               width =3D default_width;
> -       } else {
> -               octeontx_nand =3D to_otx_nand(nand);
> -               timings =3D &octeontx_nand->timings;
> -               page_size =3D nand->mtd.writesize;
> -               if (nand->options & NAND_BUSWIDTH_16)
> -                       width =3D 2;
> -               else
> -                       width =3D 1;
> -       }
> -       rc =3D ndf_queue_cmd_timing(tn, timings);
> -       if (rc)
> -               return rc;
> -
> -       rc =3D ndf_queue_cmd_bus(tn, NDF_BUS_ACQUIRE);
> -       if (rc)
> -               return rc;
> -
> -       rc =3D ndf_queue_cmd_chip(tn, 1, tn->selected_chip, width);
> -       if (rc)
> -               return rc;
> -
> -       rc =3D ndf_queue_cmd_wait(tn, t1);
> -       if (rc)
> -               return rc;
> -
> -       rc =3D ndf_queue_cmd_cle(tn, cmd1);
> -       if (rc)
> -               return rc;
> -
> -       if (addr_bytes) {
> -               rc =3D ndf_build_wait_busy(tn);
> -               if (rc)
> -                       return rc;
> -
> -               rc =3D ndf_queue_cmd_ale(tn, addr_bytes, nand,
> -                                      page, col, page_size);
> -               if (rc)
> -                       return rc;
> -       }
> -
> -       /* CLE 2 */
> -       if (cmd2) {
> -               rc =3D ndf_build_wait_busy(tn);
> -               if (rc)
> -                       return rc;
> -
> -               rc =3D ndf_queue_cmd_cle(tn, cmd2);
> -               if (rc)
> -                       return rc;
> -       }
> -       return 0;
> -}
> -
> -static int ndf_build_post_cmd(struct octeontx_nfc *tn, int hold_time)
> -{
> -       int rc;
> -
> -       /* Deselect chip */
> -       rc =3D ndf_queue_cmd_chip(tn, 0, 0, 0);
> -       if (rc)
> -               return rc;
> -
> -       rc =3D ndf_queue_cmd_wait(tn, t2);
> -       if (rc)
> -               return rc;
> -
> -       /* Release bus */
> -       rc =3D ndf_queue_cmd_bus(tn, 0);
> -       if (rc)
> -               return rc;
> -
> -       rc =3D ndf_queue_cmd_wait(tn, hold_time);
> -       if (rc)
> -               return rc;
> -
> -       /*
> -        * Last action is ringing the doorbell with number of bus
> -        * acquire-releases cycles (currently 1).
> -        */
> -       writeq(1, tn->base + NDF_DRBELL);
> -       return 0;
> -}
> -
> -/* Setup the NAND DMA engine for a transfer. */
> -static void ndf_setup_dma(struct octeontx_nfc *tn, int is_write,
> -                         dma_addr_t bus_addr, int len)
> -{
> -       u64 dma_cfg;
> -
> -       dma_cfg =3D FIELD_PREP(NDF_DMA_CFG_RW, is_write) |
> -                 FIELD_PREP(NDF_DMA_CFG_SIZE, (len >> 3) - 1);
> -       dma_cfg |=3D NDF_DMA_CFG_EN;
> -       writeq(bus_addr, tn->base + NDF_DMA_ADR);
> -       writeq(dma_cfg, tn->base + NDF_DMA_CFG);
> -}
> -
> -static int octeontx_nand_reset(struct octeontx_nfc *tn)
> -{
> -       int rc;
> -
> -       rc =3D ndf_build_pre_cmd(tn, NAND_CMD_RESET, 0, 0, 0, 0);
> -       if (rc)
> -               return rc;
> -
> -       rc =3D ndf_build_wait_busy(tn);
> -       if (rc)
> -               return rc;
> -
> -       rc =3D ndf_build_post_cmd(tn, t2);
> -       if (rc)
> -               return rc;
> -
> -       return 0;
> -}
> -
> -static int ndf_read(struct octeontx_nfc *tn, int cmd1, int addr_bytes,
> -                   u64 page, u32 col, int cmd2, int len)
> -{
> -       dma_addr_t bus_addr =3D tn->use_status ? tn->stat_addr :
> tn->buf.dmaaddr;
> -       struct nand_chip *nand =3D tn->controller.active;
> -       int timing_mode, bytes, rc;
> -       union ndf_cmd cmd;
> -       u64 start, end;
> -
> -       pr_debug("%s(%p, 0x%x, 0x%x, 0x%llx, 0x%x, 0x%x, 0x%x)\n",
> __func__,
> -                tn, cmd1, addr_bytes, page, col, cmd2, len);
> -       if (!nand)
> -               timing_mode =3D default_onfi_timing;
> -       else
> -               timing_mode =3D nand->onfi_timing_mode_default;
> -
> -       /* Build the command and address cycles */
> -       rc =3D ndf_build_pre_cmd(tn, cmd1, addr_bytes, page, col, cmd2);
> -       if (rc) {
> -               dev_err(tn->dev, "Build pre command failed\n");
> -               return rc;
> -       }
> -
> -       /* This waits for some time, then waits for busy to be
> de-asserted. */
> -       rc =3D ndf_build_wait_busy(tn);
> -       if (rc) {
> -               dev_err(tn->dev, "Wait timeout\n");
> -               return rc;
> -       }
> -
> -       memset(&cmd, 0, sizeof(cmd));
> -
> -       if (timing_mode < 4)
> -               cmd.u.rd_cmd.opcode =3D NDF_OP_RD_CMD;
> -       else
> -               cmd.u.rd_cmd.opcode =3D NDF_OP_RD_EDO_CMD;
> -
> -       cmd.u.rd_cmd.data =3D len;
> -       cmd.u.rd_cmd.rlen1 =3D t7;
> -       cmd.u.rd_cmd.rlen2 =3D t3;
> -       cmd.u.rd_cmd.rlen3 =3D t1;
> -       cmd.u.rd_cmd.rlen4 =3D t7;
> -       rc =3D ndf_submit(tn, &cmd);
> -       if (rc) {
> -               dev_err(tn->dev, "Error submitting command\n");
> -               return rc;
> -       }
> -
> -       start =3D (u64)bus_addr;
> -       ndf_setup_dma(tn, 0, bus_addr, len);
> -
> -       rc =3D ndf_build_post_cmd(tn, t2);
> -       if (rc) {
> -               dev_err(tn->dev, "Build post command failed\n");
> -               return rc;
> -       }
> -
> -       /* Wait for the DMA to complete */
> -       rc =3D ndf_wait(tn);
> -       if (rc) {
> -               dev_err(tn->dev, "DMA timed out\n");
> -               return rc;
> -       }
> -
> -       end =3D readq(tn->base + NDF_DMA_ADR);
> -       bytes =3D end - start;
> -
> -       /* Make sure NDF is really done */
> -       rc =3D ndf_wait_idle(tn);
> -       if (rc) {
> -               dev_err(tn->dev, "poll idle failed\n");
> -               return rc;
> -       }
> -
> -       pr_debug("%s: Read %d bytes\n", __func__, bytes);
> -       return bytes;
> -}
> -
> -static int octeontx_nand_get_features(struct mtd_info *mtd,
> -                                     struct nand_chip *chip, int
> feature_addr,
> -                                     u8 *subfeature_para)
> -{
> -       struct nand_chip *nand =3D chip;
> -       struct octeontx_nfc *tn =3D to_otx_nfc(nand->controller);
> -       int len =3D 8;
> -       int rc;
> -
> -       pr_debug("%s: feature addr: 0x%x\n", __func__, feature_addr);
> -       memset(tn->buf.dmabuf, 0xff, len);
> -       tn->buf.data_index =3D 0;
> -       tn->buf.data_len =3D 0;
> -       rc =3D ndf_read(tn, NAND_CMD_GET_FEATURES, 1, feature_addr, 0, 0,
> len);
> -       if (rc)
> -               return rc;
> -
> -       memcpy(subfeature_para, tn->buf.dmabuf, ONFI_SUBFEATURE_PARAM_LEN=
);
> -
> -       return 0;
> -}
> -
> -static int octeontx_nand_set_features(struct mtd_info *mtd,
> -                                     struct nand_chip *chip, int
> feature_addr,
> -                                     u8 *subfeature_para)
> -{
> -       struct nand_chip *nand =3D chip;
> -       struct octeontx_nfc *tn =3D to_otx_nfc(nand->controller);
> -       const int len =3D ONFI_SUBFEATURE_PARAM_LEN;
> -       int rc;
> -
> -       rc =3D ndf_build_pre_cmd(tn, NAND_CMD_SET_FEATURES,
> -                              1, feature_addr, 0, 0);
> -       if (rc)
> -               return rc;
> -
> -       memcpy(tn->buf.dmabuf, subfeature_para, len);
> -       memset(tn->buf.dmabuf + len, 0, 8 - len);
> -
> -       ndf_setup_dma(tn, 1, tn->buf.dmaaddr, 8);
> -
> -       rc =3D ndf_queue_cmd_write(tn, 8);
> -       if (rc)
> -               return rc;
> -
> -       rc =3D ndf_build_wait_busy(tn);
> -       if (rc)
> -               return rc;
> -
> -       rc =3D ndf_build_post_cmd(tn, t2);
> -       if (rc)
> -               return rc;
> -
> -       return 0;
> -}
> -
> -/*
> - * Read a page from NAND. If the buffer has room, the out of band
> - * data will be included.
> - */
> -static int ndf_page_read(struct octeontx_nfc *tn, u64 page, int col, int
> len)
> -{
> -       debug("%s(%p, 0x%llx, 0x%x, 0x%x) active: %p\n", __func__,
> -             tn, page, col, len, tn->controller.active);
> -       struct nand_chip *nand =3D tn->controller.active;
> -       struct octeontx_nand_chip *chip =3D to_otx_nand(nand);
> -       int addr_bytes =3D chip->row_bytes + chip->col_bytes;
> -
> -       memset(tn->buf.dmabuf, 0xff, len);
> -       return ndf_read(tn, NAND_CMD_READ0, addr_bytes,
> -                   page, col, NAND_CMD_READSTART, len);
> -}
> -
> -/* Erase a NAND block */
> -static int ndf_block_erase(struct octeontx_nfc *tn, u64 page_addr)
> -{
> -       struct nand_chip *nand =3D tn->controller.active;
> -       struct octeontx_nand_chip *chip =3D to_otx_nand(nand);
> -       int addr_bytes =3D chip->row_bytes;
> -       int rc;
> -
> -       rc =3D ndf_build_pre_cmd(tn, NAND_CMD_ERASE1, addr_bytes,
> -                              page_addr, 0, NAND_CMD_ERASE2);
> -       if (rc)
> -               return rc;
> -
> -       /* Wait for R_B to signal erase is complete  */
> -       rc =3D ndf_build_wait_busy(tn);
> -       if (rc)
> -               return rc;
> -
> -       rc =3D ndf_build_post_cmd(tn, t2);
> -       if (rc)
> -               return rc;
> -
> -       /* Wait until the command queue is idle */
> -       return ndf_wait_idle(tn);
> -}
> -
> -/*
> - * Write a page (or less) to NAND.
> - */
> -static int ndf_page_write(struct octeontx_nfc *tn, int page)
> -{
> -       int len, rc;
> -       struct nand_chip *nand =3D tn->controller.active;
> -       struct octeontx_nand_chip *chip =3D to_otx_nand(nand);
> -       int addr_bytes =3D chip->row_bytes + chip->col_bytes;
> -
> -       len =3D tn->buf.data_len - tn->buf.data_index;
> -       chip->oob_only =3D (tn->buf.data_index >=3D nand->mtd.writesize);
> -       WARN_ON_ONCE(len & 0x7);
> -
> -       ndf_setup_dma(tn, 1, tn->buf.dmaaddr + tn->buf.data_index, len);
> -       rc =3D ndf_build_pre_cmd(tn, NAND_CMD_SEQIN, addr_bytes, page, 0,=
 0);
> -       if (rc)
> -               return rc;
> -
> -       rc =3D ndf_queue_cmd_write(tn, len);
> -       if (rc)
> -               return rc;
> -
> -       rc =3D ndf_queue_cmd_cle(tn, NAND_CMD_PAGEPROG);
> -       if (rc)
> -               return rc;
> -
> -       /* Wait for R_B to signal program is complete  */
> -       rc =3D ndf_build_wait_busy(tn);
> -       if (rc)
> -               return rc;
> -
> -       rc =3D ndf_build_post_cmd(tn, t2);
> -       if (rc)
> -               return rc;
> -
> -       /* Wait for the DMA to complete */
> -       rc =3D ndf_wait(tn);
> -       if (rc)
> -               return rc;
> -
> -       /* Data transfer is done but NDF is not, it is waiting for R/B# *=
/
> -       return ndf_wait_idle(tn);
> -}
> -
> -static void octeontx_nand_cmdfunc(struct mtd_info *mtd, unsigned int
> command,
> -                                 int column, int page_addr)
> -{
> -       struct nand_chip *nand =3D mtd_to_nand(mtd);
> -       struct octeontx_nand_chip *octeontx_nand =3D to_otx_nand(nand);
> -       struct octeontx_nfc *tn =3D to_otx_nfc(nand->controller);
> -       int rc;
> -
> -       tn->selected_chip =3D octeontx_nand->cs;
> -       if (tn->selected_chip < 0 || tn->selected_chip >=3D NAND_MAX_CHIP=
S) {
> -               dev_err(tn->dev, "invalid chip select\n");
> -               return;
> -       }
> -
> -       tn->use_status =3D false;
> -
> -       pr_debug("%s(%p, 0x%x, 0x%x, 0x%x) cs: %d\n", __func__, mtd,
> command,
> -                column, page_addr, tn->selected_chip);
> -       switch (command) {
> -       case NAND_CMD_READID:
> -               tn->buf.data_index =3D 0;
> -               octeontx_nand->oob_only =3D false;
> -               rc =3D ndf_read(tn, command, 1, column, 0, 0, 8);
> -               if (rc < 0)
> -                       dev_err(tn->dev, "READID failed with %d\n", rc);
> -               else
> -                       tn->buf.data_len =3D rc;
> -               break;
> -
> -       case NAND_CMD_READOOB:
> -               octeontx_nand->oob_only =3D true;
> -               tn->buf.data_index =3D 0;
> -               tn->buf.data_len =3D 0;
> -               rc =3D ndf_page_read(tn, page_addr, column, mtd->oobsize)=
;
> -               if (rc < mtd->oobsize)
> -                       dev_err(tn->dev, "READOOB failed with %d\n",
> -                               tn->buf.data_len);
> -               else
> -                       tn->buf.data_len =3D rc;
> -               break;
> -
> -       case NAND_CMD_READ0:
> -               octeontx_nand->oob_only =3D false;
> -               tn->buf.data_index =3D 0;
> -               tn->buf.data_len =3D 0;
> -               rc =3D ndf_page_read(tn, page_addr, column,
> -                                  mtd->writesize + mtd->oobsize);
> -
> -               if (rc < mtd->writesize + mtd->oobsize)
> -                       dev_err(tn->dev, "READ0 failed with %d\n", rc);
> -               else
> -                       tn->buf.data_len =3D rc;
> -               break;
> -
> -       case NAND_CMD_STATUS:
> -               /* used in oob/not states */
> -               tn->use_status =3D true;
> -               rc =3D ndf_read(tn, command, 0, 0, 0, 0, 8);
> -               if (rc < 0)
> -                       dev_err(tn->dev, "STATUS failed with %d\n", rc);
> -               break;
> -
> -       case NAND_CMD_RESET:
> -               /* used in oob/not states */
> -               rc =3D octeontx_nand_reset(tn);
> -               if (rc < 0)
> -                       dev_err(tn->dev, "RESET failed with %d\n", rc);
> -               break;
> -
> -       case NAND_CMD_PARAM:
> -               octeontx_nand->oob_only =3D false;
> -               tn->buf.data_index =3D 0;
> -               rc =3D ndf_read(tn, command, 1, 0, 0, 0,
> -                             min(tn->buf.dmabuflen, 3 * 512));
> -               if (rc < 0)
> -                       dev_err(tn->dev, "PARAM failed with %d\n", rc);
> -               else
> -                       tn->buf.data_len =3D rc;
> -               break;
> -
> -       case NAND_CMD_RNDOUT:
> -               tn->buf.data_index =3D column;
> -               break;
> -
> -       case NAND_CMD_ERASE1:
> -               if (ndf_block_erase(tn, page_addr))
> -                       dev_err(tn->dev, "ERASE1 failed\n");
> -               break;
> -
> -       case NAND_CMD_ERASE2:
> -               /* We do all erase processing in the first command, so
> ignore
> -                * this one.
> -                */
> -               break;
> -
> -       case NAND_CMD_SEQIN:
> -               octeontx_nand->oob_only =3D (column >=3D mtd->writesize);
> -               tn->buf.data_index =3D column;
> -               tn->buf.data_len =3D column;
> -
> -               octeontx_nand->selected_page =3D page_addr;
> -               break;
> -
> -       case NAND_CMD_PAGEPROG:
> -               rc =3D ndf_page_write(tn, octeontx_nand->selected_page);
> -               if (rc)
> -                       dev_err(tn->dev, "PAGEPROG failed with %d\n", rc)=
;
> -               break;
> -
> -       case NAND_CMD_SET_FEATURES:
> -               octeontx_nand->oob_only =3D false;
> -               /* assume tn->buf.data_len =3D=3D 4 of data has been set =
there
> */
> -               rc =3D octeontx_nand_set_features(mtd, nand,
> -                                               page_addr, tn->buf.dmabuf=
);
> -               if (rc)
> -                       dev_err(tn->dev, "SET_FEATURES failed with %d\n",
> rc);
> -               break;
> -
> -       case NAND_CMD_GET_FEATURES:
> -               octeontx_nand->oob_only =3D false;
> -               rc =3D octeontx_nand_get_features(mtd, nand,
> -                                               page_addr, tn->buf.dmabuf=
);
> -               if (!rc) {
> -                       tn->buf.data_index =3D 0;
> -                       tn->buf.data_len =3D 4;
> -               } else {
> -                       dev_err(tn->dev, "GET_FEATURES failed with %d\n",
> rc);
> -               }
> -               break;
> -
> -       default:
> -               WARN_ON_ONCE(1);
> -               dev_err(tn->dev, "unhandled nand cmd: %x\n", command);
> -       }
> -}
> -
> -static int octeontx_nand_waitfunc(struct mtd_info *mtd, struct nand_chip
> *chip)
> -{
> -       struct octeontx_nfc *tn =3D to_otx_nfc(chip->controller);
> -       int ret;
> -
> -       ret =3D ndf_wait_idle(tn);
> -       return (ret < 0) ? -EIO : 0;
> -}
> -
> -/* check compatibility with ONFI timing mode#N, and optionally apply */
> -/* TODO: Implement chipnr support? */
> -static int octeontx_nand_setup_dat_intf(struct mtd_info *mtd, int chipnr=
,
> -                                       const struct nand_data_interface
> *conf)
> -{
> -       static const bool check_only;
> -       struct nand_chip *nand =3D mtd_to_nand(mtd);
> -       struct octeontx_nand_chip *chip =3D to_otx_nand(nand);
> -       static u64 t_wc_n[MAX_ONFI_MODE + 2]; /* cache a mode signature *=
/
> -       int mode; /* deduced mode number, for reporting and restricting *=
/
> -       int rc;
> -
> -       /*
> -        * Cache timing modes for reporting, and reducing needless change=
.
> -        *
> -        * Challenge: caller does not pass ONFI mode#, but reporting the
> mode
> -        * and restricting to a maximum, or a list, are useful for
> diagnosing
> -        * new hardware.  So use tWC_min, distinct and monotonic across
> modes,
> -        * to discover the requested/accepted mode number
> -        */
> -       for (mode =3D MAX_ONFI_MODE; mode >=3D 0 && !t_wc_n[0]; mode--) {
> -               const struct nand_sdr_timings *t;
> -
> -               t =3D onfi_async_timing_mode_to_sdr_timings(mode);
> -               if (!t)
> -                       continue;
> -               t_wc_n[mode] =3D t->tWC_min;
> -       }
> -
> -       if (!conf) {
> -               rc =3D -EINVAL;
> -       } else if (check_only) {
> -               rc =3D 0;
> -       } else if (nand->data_interface &&
> -                       chip->iface_set && chip->iface_mode =3D=3D mode) =
{
> -               /*
> -                * Cases:
> -                * - called from nand_reset, which clears DDR timing
> -                *   mode back to SDR.  BUT if we're already in SDR,
> -                *   timing mode persists over resets.
> -                *   While mtd/nand layer only supports SDR,
> -                *   this is always safe. And this driver only supports
> SDR.
> -                *
> -                * - called from post-power-event nand_reset (maybe
> -                *   NFC+flash power down, or system hibernate.
> -                *   Address this when CONFIG_PM support added
> -                */
> -               rc =3D 0;
> -       } else {
> -               rc =3D octeontx_nfc_chip_set_timings(chip,
> &conf->timings.sdr);
> -               if (!rc) {
> -                       chip->iface_mode =3D mode;
> -                       chip->iface_set =3D true;
> -               }
> -       }
> -       return rc;
> -}
> -
> -static void octeontx_bch_reset(void)
> -{
> -}
> -
> -/*
> - * Given a page, calculate the ECC code
> - *
> - * chip:       Pointer to NAND chip data structure
> - * buf:                Buffer to calculate ECC on
> - * code:       Buffer to hold ECC data
> - *
> - * Return 0 on success or -1 on failure
> - */
> -static int octeontx_nand_bch_calculate_ecc_internal(struct mtd_info *mtd=
,
> -                                                   dma_addr_t ihandle,
> -                                                   u8 *code)
> -{
> -       struct nand_chip *nand =3D mtd_to_nand(mtd);
> -       struct octeontx_nfc *tn =3D to_otx_nfc(nand->controller);
> -       int rc;
> -       int i;
> -       static u8 *ecc_buffer;
> -       static int ecc_size;
> -       static unsigned long ecc_handle;
> -       union bch_resp *r =3D tn->bch_resp;
> -
> -       if (!ecc_buffer || ecc_size < nand->ecc.size) {
> -               ecc_size =3D nand->ecc.size;
> -               ecc_buffer =3D dma_alloc_coherent(ecc_size,
> -                                               (unsigned long
> *)&ecc_handle);
> -       }
> -
> -       memset(ecc_buffer, 0, nand->ecc.bytes);
> -
> -       r->u16 =3D 0;
> -       __iowmb(); /* flush done=3D0 before making request */
> -
> -       rc =3D octeontx_bch_encode(bch_vf, ihandle, nand->ecc.size,
> -                                nand->ecc.strength,
> -                                (dma_addr_t)ecc_handle, tn->bch_rhandle)=
;
> -
> -       if (!rc) {
> -               octeontx_bch_wait(bch_vf, r, tn->bch_rhandle);
> -       } else {
> -               dev_err(tn->dev, "octeontx_bch_encode failed\n");
> -               return -1;
> -       }
> -
> -       if (!r->s.done || r->s.uncorrectable) {
> -               dev_err(tn->dev,
> -                       "%s timeout, done:%d uncorr:%d corr:%d
> erased:%d\n",
> -                       __func__, r->s.done, r->s.uncorrectable,
> -                       r->s.num_errors, r->s.erased);
> -               octeontx_bch_reset();
> -               return -1;
> -       }
> -
> -       memcpy(code, ecc_buffer, nand->ecc.bytes);
> -
> -       for (i =3D 0; i < nand->ecc.bytes; i++)
> -               code[i] ^=3D tn->eccmask[i];
> -
> -       return tn->bch_resp->s.num_errors;
> -}
> -
> -/*
> - * Given a page, calculate the ECC code
> - *
> - * mtd:        MTD block structure
> - * dat:        raw data (unused)
> - * ecc_code:   buffer for ECC
> - */
> -static int octeontx_nand_bch_calculate(struct mtd_info *mtd,
> -                                      const u8 *dat, u8 *ecc_code)
> -{
> -       struct nand_chip *nand =3D mtd_to_nand(mtd);
> -       dma_addr_t handle =3D dma_map_single((u8 *)dat,
> -                                          nand->ecc.size, DMA_TO_DEVICE)=
;
> -       int ret;
> -
> -       ret =3D octeontx_nand_bch_calculate_ecc_internal(mtd, handle,
> -                                                      (void *)ecc_code);
> -
> -       return ret;
> -}
> -
> -/*
> - * Detect and correct multi-bit ECC for a page
> - *
> - * mtd:        MTD block structure
> - * dat:        raw data read from the chip
> - * read_ecc:   ECC from the chip (unused)
> - * isnull:     unused
> - *
> - * Returns number of bits corrected or -1 if unrecoverable
> - */
> -static int octeontx_nand_bch_correct(struct mtd_info *mtd, u_char *dat,
> -                                    u_char *read_ecc, u_char *isnull)
> -{
> -       struct nand_chip *nand =3D mtd_to_nand(mtd);
> -       struct octeontx_nfc *tn =3D to_otx_nfc(nand->controller);
> -       int i =3D nand->ecc.size + nand->ecc.bytes;
> -       static u8 *data_buffer;
> -       static dma_addr_t ihandle;
> -       static int buffer_size;
> -       dma_addr_t ohandle;
> -       union bch_resp *r =3D tn->bch_resp;
> -       int rc;
> -
> -       if (i > buffer_size) {
> -               if (buffer_size)
> -                       free(data_buffer);
> -               data_buffer =3D dma_alloc_coherent(i,
> -                                                (unsigned long
> *)&ihandle);
> -               if (!data_buffer) {
> -                       dev_err(tn->dev,
> -                               "%s: Could not allocate %d bytes for
> buffer\n",
> -                               __func__, i);
> -                       goto error;
> -               }
> -               buffer_size =3D i;
> -       }
> -
> -       memcpy(data_buffer, dat, nand->ecc.size);
> -       memcpy(data_buffer + nand->ecc.size, read_ecc, nand->ecc.bytes);
> -
> -       for (i =3D 0; i < nand->ecc.bytes; i++)
> -               data_buffer[nand->ecc.size + i] ^=3D tn->eccmask[i];
> -
> -       r->u16 =3D 0;
> -       __iowmb(); /* flush done=3D0 before making request */
> -
> -       ohandle =3D dma_map_single(dat, nand->ecc.size, DMA_FROM_DEVICE);
> -       rc =3D octeontx_bch_decode(bch_vf, ihandle, nand->ecc.size,
> -                                nand->ecc.strength, ohandle,
> tn->bch_rhandle);
> -
> -       if (!rc)
> -               octeontx_bch_wait(bch_vf, r, tn->bch_rhandle);
> -
> -       if (rc) {
> -               dev_err(tn->dev, "octeontx_bch_decode failed\n");
> -               goto error;
> -       }
> -
> -       if (!r->s.done) {
> -               dev_err(tn->dev, "Error: BCH engine timeout\n");
> -               octeontx_bch_reset();
> -               goto error;
> -       }
> -
> -       if (r->s.erased) {
> -               debug("Info: BCH block is erased\n");
> -               return 0;
> -       }
> -
> -       if (r->s.uncorrectable) {
> -               debug("Cannot correct NAND block, response: 0x%x\n",
> -                     r->u16);
> -               goto error;
> -       }
> -
> -       return r->s.num_errors;
> -
> -error:
> -       debug("Error performing bch correction\n");
> -       return -1;
> -}
> -
> -void octeontx_nand_bch_hwctl(struct mtd_info *mtd, int mode)
> -{
> -       /* Do nothing. */
> -}
> -
> -static int octeontx_nand_hw_bch_read_page(struct mtd_info *mtd,
> -                                         struct nand_chip *chip, u8 *buf=
,
> -                                         int oob_required, int page)
> -{
> -       struct nand_chip *nand =3D mtd_to_nand(mtd);
> -       struct octeontx_nfc *tn =3D to_otx_nfc(nand->controller);
> -       int i, eccsize =3D chip->ecc.size, ret;
> -       int eccbytes =3D chip->ecc.bytes;
> -       int eccsteps =3D chip->ecc.steps;
> -       u8 *p;
> -       u8 *ecc_code =3D chip->buffers->ecccode;
> -       unsigned int max_bitflips =3D 0;
> -
> -       /* chip->read_buf() insists on sequential order, we do OOB first =
*/
> -       memcpy(chip->oob_poi, tn->buf.dmabuf + mtd->writesize,
> mtd->oobsize);
> -
> -       /* Use private buffer as input for ECC correction */
> -       p =3D tn->buf.dmabuf;
> -
> -       ret =3D mtd_ooblayout_get_eccbytes(mtd, ecc_code, chip->oob_poi, =
0,
> -                                        chip->ecc.total);
> -       if (ret)
> -               return ret;
> -
> -       for (i =3D 0; eccsteps; eccsteps--, i +=3D eccbytes, p +=3D eccsi=
ze) {
> -               int stat;
> -
> -               debug("Correcting block offset %lx, ecc offset %x\n",
> -                     p - buf, i);
> -               stat =3D chip->ecc.correct(mtd, p, &ecc_code[i], NULL);
> -
> -               if (stat < 0) {
> -                       mtd->ecc_stats.failed++;
> -                       debug("Cannot correct NAND page %d\n", page);
> -               } else {
> -                       mtd->ecc_stats.corrected +=3D stat;
> -                       max_bitflips =3D max_t(unsigned int, max_bitflips=
,
> stat);
> -               }
> -       }
> -
> -       /* Copy corrected data to caller's buffer now */
> -       memcpy(buf, tn->buf.dmabuf, mtd->writesize);
> -
> -       return max_bitflips;
> -}
> -
> -static int octeontx_nand_hw_bch_write_page(struct mtd_info *mtd,
> -                                          struct nand_chip *chip,
> -                                          const u8 *buf, int oob_require=
d,
> -                                          int page)
> -{
> -       struct octeontx_nfc *tn =3D to_otx_nfc(chip->controller);
> -       int i, eccsize =3D chip->ecc.size, ret;
> -       int eccbytes =3D chip->ecc.bytes;
> -       int eccsteps =3D chip->ecc.steps;
> -       const u8 *p;
> -       u8 *ecc_calc =3D chip->buffers->ecccalc;
> -
> -       debug("%s(buf?%p, oob%d p%x)\n",
> -             __func__, buf, oob_required, page);
> -       for (i =3D 0; i < chip->ecc.total; i++)
> -               ecc_calc[i] =3D 0xFF;
> -
> -       /* Copy the page data from caller's buffers to private buffer */
> -       chip->write_buf(mtd, buf, mtd->writesize);
> -       /* Use private date as source for ECC calculation */
> -       p =3D tn->buf.dmabuf;
> -
> -       /* Hardware ECC calculation */
> -       for (i =3D 0; eccsteps; eccsteps--, i +=3D eccbytes, p +=3D eccsi=
ze) {
> -               int ret;
> -
> -               ret =3D chip->ecc.calculate(mtd, p, &ecc_calc[i]);
> -
> -               if (ret < 0)
> -                       debug("calculate(mtd, p?%p, &ecc_calc[%d]?%p)
> returned %d\n",
> -                             p, i, &ecc_calc[i], ret);
> -
> -               debug("block offset %lx, ecc offset %x\n", p - buf, i);
> -       }
> -
> -       ret =3D mtd_ooblayout_set_eccbytes(mtd, ecc_calc, chip->oob_poi, =
0,
> -                                        chip->ecc.total);
> -       if (ret)
> -               return ret;
> -
> -       /* Store resulting OOB into private buffer, will be sent to HW */
> -       chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
> -
> -       return 0;
> -}
> -
> -/**
> - * nand_write_page_raw - [INTERN] raw page write function
> - * @mtd: mtd info structure
> - * @chip: nand chip info structure
> - * @buf: data buffer
> - * @oob_required: must write chip->oob_poi to OOB
> - * @page: page number to write
> - *
> - * Not for syndrome calculating ECC controllers, which use a special oob
> layout.
> - */
> -static int octeontx_nand_write_page_raw(struct mtd_info *mtd,
> -                                       struct nand_chip *chip,
> -                                       const u8 *buf, int oob_required,
> -                                       int page)
> -{
> -       chip->write_buf(mtd, buf, mtd->writesize);
> -       if (oob_required)
> -               chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
> -
> -       return 0;
> -}
> -
> -/**
> - * octeontx_nand_write_oob_std - [REPLACEABLE] the most common OOB data
> write
> - *                             function
> - * @mtd: mtd info structure
> - * @chip: nand chip info structure
> - * @page: page number to write
> - */
> -static int octeontx_nand_write_oob_std(struct mtd_info *mtd,
> -                                      struct nand_chip *chip,
> -                                      int page)
> -{
> -       int status =3D 0;
> -       const u8 *buf =3D chip->oob_poi;
> -       int length =3D mtd->oobsize;
> -
> -       chip->cmdfunc(mtd, NAND_CMD_SEQIN, mtd->writesize, page);
> -       chip->write_buf(mtd, buf, length);
> -       /* Send command to program the OOB data */
> -       chip->cmdfunc(mtd, NAND_CMD_PAGEPROG, -1, -1);
> -
> -       status =3D chip->waitfunc(mtd, chip);
> -
> -       return status & NAND_STATUS_FAIL ? -EIO : 0;
> -}
> -
> -/**
> - * octeontx_nand_read_page_raw - [INTERN] read raw page data without ecc
> - * @mtd: mtd info structure
> - * @chip: nand chip info structure
> - * @buf: buffer to store read data
> - * @oob_required: caller requires OOB data read to chip->oob_poi
> - * @page: page number to read
> - *
> - * Not for syndrome calculating ECC controllers, which use a special oob
> layout.
> - */
> -static int octeontx_nand_read_page_raw(struct mtd_info *mtd,
> -                                      struct nand_chip *chip,
> -                                      u8 *buf, int oob_required, int pag=
e)
> -{
> -       chip->read_buf(mtd, buf, mtd->writesize);
> -       if (oob_required)
> -               chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
> -       return 0;
> -}
> -
> -static int octeontx_nand_read_oob_std(struct mtd_info *mtd,
> -                                     struct nand_chip *chip,
> -                                     int page)
> -
> -{
> -       chip->cmdfunc(mtd, NAND_CMD_READOOB, 0, page);
> -       chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
> -       return 0;
> -}
> -
> -static int octeontx_nand_calc_bch_ecc_strength(struct nand_chip *nand)
> -{
> -       struct mtd_info *mtd =3D nand_to_mtd(nand);
> -       struct nand_ecc_ctrl *ecc =3D &nand->ecc;
> -       struct octeontx_nfc *tn =3D to_otx_nfc(nand->controller);
> -       int nsteps =3D mtd->writesize / ecc->size;
> -       int oobchunk =3D mtd->oobsize / nsteps;
> -
> -       /* ecc->strength determines ecc_level and OOB's ecc_bytes. */
> -       const u8 strengths[]  =3D {4, 8, 16, 24, 32, 40, 48, 56, 60, 64};
> -       /* first set the desired ecc_level to match strengths[] */
> -       int index =3D ARRAY_SIZE(strengths) - 1;
> -       int need;
> -
> -       while (index > 0 && !(ecc->options & NAND_ECC_MAXIMIZE) &&
> -              strengths[index - 1] >=3D ecc->strength)
> -               index--;
> -
> -       do {
> -               need =3D DIV_ROUND_UP(15 * strengths[index], 8);
> -               if (need <=3D oobchunk - 2)
> -                       break;
> -       } while (index > 0);
> -
> -       debug("%s: steps ds: %d, strength ds: %d\n", __func__,
> -             nand->ecc_step_ds, nand->ecc_strength_ds);
> -       ecc->strength =3D strengths[index];
> -       ecc->bytes =3D need;
> -       debug("%s: strength: %d, bytes: %d\n", __func__, ecc->strength,
> -             ecc->bytes);
> -
> -       if (!tn->eccmask)
> -               tn->eccmask =3D devm_kzalloc(tn->dev, ecc->bytes,
> GFP_KERNEL);
> -       if (!tn->eccmask)
> -               return -ENOMEM;
> -
> -       return 0;
> -}
> -
> -/* sample the BCH signature of an erased (all 0xff) page,
> - * to XOR into all page traffic, so erased pages have no ECC errors
> - */
> -static int octeontx_bch_save_empty_eccmask(struct nand_chip *nand)
> -{
> -       struct mtd_info *mtd =3D nand_to_mtd(nand);
> -       struct octeontx_nfc *tn =3D to_otx_nfc(nand->controller);
> -       unsigned int eccsize =3D nand->ecc.size;
> -       unsigned int eccbytes =3D nand->ecc.bytes;
> -       u8 erased_ecc[eccbytes];
> -       unsigned long erased_handle;
> -       unsigned char *erased_page =3D dma_alloc_coherent(eccsize,
> -                                                       &erased_handle);
> -       int i;
> -       int rc =3D 0;
> -
> -       if (!erased_page)
> -               return -ENOMEM;
> -
> -       memset(erased_page, 0xff, eccsize);
> -       memset(erased_ecc, 0, eccbytes);
> -
> -       rc =3D octeontx_nand_bch_calculate_ecc_internal(mtd,
> -
>  (dma_addr_t)erased_handle,
> -                                                     erased_ecc);
> -
> -       free(erased_page);
> -
> -       for (i =3D 0; i < eccbytes; i++)
> -               tn->eccmask[i] =3D erased_ecc[i] ^ 0xff;
> -
> -       return rc;
> -}
> -
> -static void octeontx_nfc_chip_sizing(struct nand_chip *nand)
> -{
> -       struct octeontx_nand_chip *chip =3D to_otx_nand(nand);
> -       struct mtd_info *mtd =3D nand_to_mtd(nand);
> -       struct nand_ecc_ctrl *ecc =3D &nand->ecc;
> -
> -       chip->row_bytes =3D nand->onfi_params.addr_cycles & 0xf;
> -       chip->col_bytes =3D nand->onfi_params.addr_cycles >> 4;
> -       debug("%s(%p) row bytes: %d, col bytes: %d, ecc mode: %d\n",
> -             __func__, nand, chip->row_bytes, chip->col_bytes, ecc->mode=
);
> -
> -       /*
> -        * HW_BCH using OcteonTX BCH engine, or SOFT_BCH laid out in
> -        * HW_BCH-compatible fashion, depending on devtree advice
> -        * and kernel config.
> -        * BCH/NFC hardware capable of subpage ops, not implemented.
> -        */
> -       mtd_set_ooblayout(mtd, &nand_ooblayout_lp_ops);
> -       nand->options |=3D NAND_NO_SUBPAGE_WRITE;
> -       debug("%s: start steps: %d, size: %d, bytes: %d\n",
> -             __func__, ecc->steps, ecc->size, ecc->bytes);
> -       debug("%s: step ds: %d, strength ds: %d\n", __func__,
> -             nand->ecc_step_ds, nand->ecc_strength_ds);
> -
> -       if (ecc->mode !=3D NAND_ECC_NONE) {
> -               int nsteps =3D ecc->steps ? ecc->steps : 1;
> -
> -               if (ecc->size && ecc->size !=3D mtd->writesize)
> -                       nsteps =3D mtd->writesize / ecc->size;
> -               else if (mtd->writesize > def_ecc_size &&
> -                        !(mtd->writesize & (def_ecc_size - 1)))
> -                       nsteps =3D mtd->writesize / def_ecc_size;
> -               ecc->steps =3D nsteps;
> -               ecc->size =3D mtd->writesize / nsteps;
> -               ecc->bytes =3D mtd->oobsize / nsteps;
> -
> -               if (nand->ecc_strength_ds)
> -                       ecc->strength =3D nand->ecc_strength_ds;
> -               if (nand->ecc_step_ds)
> -                       ecc->size =3D nand->ecc_step_ds;
> -               /*
> -                * no subpage ops, but set subpage-shift to match
> ecc->steps
> -                * so mtd_nandbiterrs tests appropriate boundaries
> -                */
> -               if (!mtd->subpage_sft && !(ecc->steps & (ecc->steps - 1))=
)
> -                       mtd->subpage_sft =3D fls(ecc->steps) - 1;
> -
> -               if (IS_ENABLED(CONFIG_NAND_OCTEONTX_HW_ECC)) {
> -                       debug("%s: ecc mode: %d\n", __func__, ecc->mode);
> -                       if (ecc->mode !=3D NAND_ECC_SOFT &&
> -                           !octeontx_nand_calc_bch_ecc_strength(nand)) {
> -                               struct octeontx_nfc *tn =3D
> -                                       to_otx_nfc(nand->controller);
> -
> -                               debug("Using hardware BCH engine
> support\n");
> -                               ecc->mode =3D NAND_ECC_HW_SYNDROME;
> -                               ecc->read_page =3D
> octeontx_nand_hw_bch_read_page;
> -                               ecc->write_page =3D
> -                                       octeontx_nand_hw_bch_write_page;
> -                               ecc->read_page_raw =3D
> -                                       octeontx_nand_read_page_raw;
> -                               ecc->write_page_raw =3D
> -                                       octeontx_nand_write_page_raw;
> -                               ecc->read_oob =3D octeontx_nand_read_oob_=
std;
> -                               ecc->write_oob =3D
> octeontx_nand_write_oob_std;
> -
> -                               ecc->calculate =3D
> octeontx_nand_bch_calculate;
> -                               ecc->correct =3D octeontx_nand_bch_correc=
t;
> -                               ecc->hwctl =3D octeontx_nand_bch_hwctl;
> -
> -                               debug("NAND chip %d using hw_bch\n",
> -                                     tn->selected_chip);
> -                               debug(" %d bytes ECC per %d byte block\n"=
,
> -                                     ecc->bytes, ecc->size);
> -                               debug(" for %d bits of correction per
> block.",
> -                                     ecc->strength);
> -                               octeontx_nand_calc_ecc_layout(nand);
> -                               octeontx_bch_save_empty_eccmask(nand);
> -                       }
> -               }
> -       }
> -}
> -
> -static int octeontx_nfc_chip_init(struct octeontx_nfc *tn, struct udevic=
e
> *dev,
> -                                 ofnode node)
> -{
> -       struct octeontx_nand_chip *chip;
> -       struct nand_chip *nand;
> -       struct mtd_info *mtd;
> -       int ret;
> -
> -       chip =3D devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
> -       if (!chip)
> -               return -ENOMEM;
> -
> -       debug("%s: Getting chip select\n", __func__);
> -       ret =3D ofnode_read_s32(node, "reg", &chip->cs);
> -       if (ret) {
> -               dev_err(dev, "could not retrieve reg property: %d\n", ret=
);
> -               return ret;
> -       }
> -
> -       if (chip->cs >=3D NAND_MAX_CHIPS) {
> -               dev_err(dev, "invalid reg value: %u (max CS =3D 7)\n",
> chip->cs);
> -               return -EINVAL;
> -       }
> -       debug("%s: chip select: %d\n", __func__, chip->cs);
> -       nand =3D &chip->nand;
> -       nand->controller =3D &tn->controller;
> -       if (!tn->controller.active)
> -               tn->controller.active =3D nand;
> -
> -       debug("%s: Setting flash node\n", __func__);
> -       nand_set_flash_node(nand, node);
> -
> -       nand->options =3D 0;
> -       nand->select_chip =3D octeontx_nand_select_chip;
> -       nand->cmdfunc =3D octeontx_nand_cmdfunc;
> -       nand->waitfunc =3D octeontx_nand_waitfunc;
> -       nand->read_byte =3D octeontx_nand_read_byte;
> -       nand->read_buf =3D octeontx_nand_read_buf;
> -       nand->write_buf =3D octeontx_nand_write_buf;
> -       nand->onfi_set_features =3D octeontx_nand_set_features;
> -       nand->onfi_get_features =3D octeontx_nand_get_features;
> -       nand->setup_data_interface =3D octeontx_nand_setup_dat_intf;
> -
> -       mtd =3D nand_to_mtd(nand);
> -       debug("%s: mtd: %p\n", __func__, mtd);
> -       mtd->dev->parent =3D dev;
> -
> -       debug("%s: NDF_MISC: 0x%llx\n", __func__,
> -             readq(tn->base + NDF_MISC));
> -
> -       /* TODO: support more then 1 chip */
> -       debug("%s: Scanning identification\n", __func__);
> -       ret =3D nand_scan_ident(mtd, 1, NULL);
> -       if (ret)
> -               return ret;
> -
> -       debug("%s: Sizing chip\n", __func__);
> -       octeontx_nfc_chip_sizing(nand);
> -
> -       debug("%s: Scanning tail\n", __func__);
> -       ret =3D nand_scan_tail(mtd);
> -       if (ret) {
> -               dev_err(dev, "nand_scan_tail failed: %d\n", ret);
> -               return ret;
> -       }
> -
> -       debug("%s: Registering mtd\n", __func__);
> -       ret =3D nand_register(0, mtd);
> -
> -       debug("%s: Adding tail\n", __func__);
> -       list_add_tail(&chip->node, &tn->chips);
> -       return 0;
> -}
> -
> -static int octeontx_nfc_chips_init(struct octeontx_nfc *tn)
> -{
> -       struct udevice *dev =3D tn->dev;
> -       ofnode node =3D dev_ofnode(dev);
> -       ofnode nand_node;
> -       int nr_chips =3D of_get_child_count(node);
> -       int ret;
> -
> -       debug("%s: node: %s\n", __func__, ofnode_get_name(node));
> -       debug("%s: %d chips\n", __func__, nr_chips);
> -       if (nr_chips > NAND_MAX_CHIPS) {
> -               dev_err(dev, "too many NAND chips: %d\n", nr_chips);
> -               return -EINVAL;
> -       }
> -
> -       if (!nr_chips) {
> -               debug("no DT NAND chips found\n");
> -               return -ENODEV;
> -       }
> -
> -       pr_info("%s: scanning %d chips DTs\n", __func__, nr_chips);
> -
> -       ofnode_for_each_subnode(nand_node, node) {
> -               debug("%s: Calling octeontx_nfc_chip_init(%p, %s, %ld)\n"=
,
> -                     __func__, tn, dev->name, nand_node.of_offset);
> -               ret =3D octeontx_nfc_chip_init(tn, dev, nand_node);
> -               if (ret)
> -                       return ret;
> -       }
> -       return 0;
> -}
> -
> -/* Reset NFC and initialize registers. */
> -static int octeontx_nfc_init(struct octeontx_nfc *tn)
> -{
> -       const struct nand_sdr_timings *timings;
> -       u64 ndf_misc;
> -       int rc;
> -
> -       /* Initialize values and reset the fifo */
> -       ndf_misc =3D readq(tn->base + NDF_MISC);
> -
> -       ndf_misc &=3D ~NDF_MISC_EX_DIS;
> -       ndf_misc |=3D (NDF_MISC_BT_DIS | NDF_MISC_RST_FF);
> -       writeq(ndf_misc, tn->base + NDF_MISC);
> -       debug("%s: NDF_MISC: 0x%llx\n", __func__, readq(tn->base +
> NDF_MISC));
> -
> -       /* Bring the fifo out of reset */
> -       ndf_misc &=3D ~(NDF_MISC_RST_FF);
> -
> -       /* Maximum of co-processor cycles for glitch filtering */
> -       ndf_misc |=3D FIELD_PREP(NDF_MISC_WAIT_CNT, 0x3f);
> -
> -       writeq(ndf_misc, tn->base + NDF_MISC);
> -
> -       /* Set timing parameters to onfi mode 0 for probing */
> -       timings =3D onfi_async_timing_mode_to_sdr_timings(0);
> -       if (IS_ERR(timings))
> -               return PTR_ERR(timings);
> -       rc =3D set_default_timings(tn, timings);
> -       if (rc)
> -               return rc;
> -
> -       return 0;
> -}
> -
> -static int octeontx_pci_nand_probe(struct udevice *dev)
> -{
> -       struct octeontx_nfc *tn =3D dev_get_priv(dev);
> -       int ret;
> -       static bool probe_done;
> -
> -       debug("%s(%s) tn: %p\n", __func__, dev->name, tn);
> -       if (probe_done)
> -               return 0;
> -
> -       if (IS_ENABLED(CONFIG_NAND_OCTEONTX_HW_ECC)) {
> -               bch_vf =3D octeontx_bch_getv();
> -               if (!bch_vf) {
> -                       struct octeontx_probe_device *probe_dev;
> -
> -                       debug("%s: bch not yet initialized\n", __func__);
> -                       probe_dev =3D calloc(sizeof(*probe_dev), 1);
> -                       if (!probe_dev) {
> -                               printf("%s: Out of memory\n", __func__);
> -                               return -ENOMEM;
> -                       }
> -                       probe_dev->dev =3D dev;
> -                       INIT_LIST_HEAD(&probe_dev->list);
> -                       list_add_tail(&probe_dev->list,
> -                                     &octeontx_pci_nand_deferred_devices=
);
> -                       debug("%s: Defering probe until after BCH
> initialization\n",
> -                             __func__);
> -                       return 0;
> -               }
> -       }
> -
> -       tn->dev =3D dev;
> -       INIT_LIST_HEAD(&tn->chips);
> -
> -       tn->base =3D dm_pci_map_bar(dev, PCI_BASE_ADDRESS_0, 0, 0,
> PCI_REGION_TYPE, PCI_REGION_MEM);
> -       if (!tn->base) {
> -               ret =3D -EINVAL;
> -               goto release;
> -       }
> -       debug("%s: bar at %p\n", __func__, tn->base);
> -       tn->buf.dmabuflen =3D NAND_MAX_PAGESIZE + NAND_MAX_OOBSIZE;
> -       tn->buf.dmabuf =3D dma_alloc_coherent(tn->buf.dmabuflen,
> -                                           (unsigned long
> *)&tn->buf.dmaaddr);
> -       if (!tn->buf.dmabuf) {
> -               ret =3D -ENOMEM;
> -               debug("%s: Could not allocate DMA buffer\n", __func__);
> -               goto unclk;
> -       }
> -
> -       /* one hw-bch response, for one outstanding transaction */
> -       tn->bch_resp =3D dma_alloc_coherent(sizeof(*tn->bch_resp),
> -                                         (unsigned long
> *)&tn->bch_rhandle);
> -
> -       tn->stat =3D dma_alloc_coherent(8, (unsigned long *)&tn->stat_add=
r);
> -       if (!tn->stat || !tn->bch_resp) {
> -               debug("%s: Could not allocate bch status or response\n",
> -                     __func__);
> -               ret =3D -ENOMEM;
> -               goto unclk;
> -       }
> -
> -       debug("%s: Calling octeontx_nfc_init()\n", __func__);
> -       octeontx_nfc_init(tn);
> -       debug("%s: Initializing chips\n", __func__);
> -       ret =3D octeontx_nfc_chips_init(tn);
> -       debug("%s: init chips ret: %d\n", __func__, ret);
> -       if (ret) {
> -               if (ret !=3D -ENODEV)
> -                       dev_err(dev, "failed to init nand chips\n");
> -               goto unclk;
> -       }
> -       dev_info(dev, "probed\n");
> -       return 0;
> -
> -unclk:
> -release:
> -       return ret;
> -}
> -
> -int octeontx_pci_nand_disable(struct udevice *dev)
> -{
> -       struct octeontx_nfc *tn =3D dev_get_priv(dev);
> -       u64 dma_cfg;
> -       u64 ndf_misc;
> -
> -       debug("%s: Disabling NAND device %s\n", __func__, dev->name);
> -       dma_cfg =3D readq(tn->base + NDF_DMA_CFG);
> -       dma_cfg &=3D ~NDF_DMA_CFG_EN;
> -       dma_cfg |=3D NDF_DMA_CFG_CLR;
> -       writeq(dma_cfg, tn->base + NDF_DMA_CFG);
> -
> -       /* Disable execution and put FIFO in reset mode */
> -       ndf_misc =3D readq(tn->base + NDF_MISC);
> -       ndf_misc |=3D NDF_MISC_EX_DIS | NDF_MISC_RST_FF;
> -       writeq(ndf_misc, tn->base + NDF_MISC);
> -       ndf_misc &=3D ~NDF_MISC_RST_FF;
> -       writeq(ndf_misc, tn->base + NDF_MISC);
> -#ifdef DEBUG
> -       printf("%s: NDF_MISC: 0x%llx\n", __func__, readq(tn->base +
> NDF_MISC));
> -#endif
> -       /* Clear any interrupts and enable bits */
> -       writeq(~0ull, tn->base + NDF_INT_ENA_W1C);
> -       writeq(~0ull, tn->base + NDF_INT);
> -       debug("%s: NDF_ST_REG: 0x%llx\n", __func__,
> -             readq(tn->base + NDF_ST_REG));
> -       return 0;
> -}
> -
> -/**
> - * Since it's possible (and even likely) that the NAND device will be
> probed
> - * before the BCH device has been probed, we may need to defer the
> probing.
> - *
> - * In this case, the initial probe returns success but the actual probin=
g
> - * is deferred until the BCH VF has been probed.
> - *
> - * Return:     0 for success, otherwise error
> - */
> -int octeontx_pci_nand_deferred_probe(void)
> -{
> -       int rc =3D 0;
> -       struct octeontx_probe_device *pdev;
> -
> -       debug("%s: Performing deferred probing\n", __func__);
> -       list_for_each_entry(pdev, &octeontx_pci_nand_deferred_devices,
> list) {
> -               debug("%s: Probing %s\n", __func__, pdev->dev->name);
> -               dev_get_flags(pdev->dev) &=3D ~DM_FLAG_ACTIVATED;
> -               rc =3D device_probe(pdev->dev);
> -               if (rc && rc !=3D -ENODEV) {
> -                       printf("%s: Error %d with deferred probe of %s\n"=
,
> -                              __func__, rc, pdev->dev->name);
> -                       break;
> -               }
> -       }
> -       return rc;
> -}
> -
> -static const struct pci_device_id octeontx_nfc_pci_id_table[] =3D {
> -       { PCI_VDEVICE(CAVIUM, 0xA04F) },
> -       {}
> -};
> -
> -static int octeontx_nand_of_to_plat(struct udevice *dev)
> -{
> -       return 0;
> -}
> -
> -static const struct udevice_id octeontx_nand_ids[] =3D {
> -       { .compatible =3D "cavium,cn8130-nand" },
> -       { },
> -};
> -
> -U_BOOT_DRIVER(octeontx_pci_nand) =3D {
> -       .name   =3D OCTEONTX_NAND_DRIVER_NAME,
> -       .id     =3D UCLASS_MTD,
> -       .of_match =3D of_match_ptr(octeontx_nand_ids),
> -       .of_to_plat =3D octeontx_nand_of_to_plat,
> -       .probe =3D octeontx_pci_nand_probe,
> -       .priv_auto      =3D sizeof(struct octeontx_nfc),
> -       .remove =3D octeontx_pci_nand_disable,
> -       .flags =3D DM_FLAG_OS_PREPARE,
> -};
> -
> -U_BOOT_PCI_DEVICE(octeontx_pci_nand, octeontx_nfc_pci_id_table);
> -
> -void board_nand_init(void)
> -{
> -       struct udevice *dev;
> -       int ret;
> -
> -       if (IS_ENABLED(CONFIG_NAND_OCTEONTX_HW_ECC)) {
> -               ret =3D uclass_get_device_by_driver(UCLASS_MISC,
> -
>  DM_DRIVER_GET(octeontx_pci_bchpf),
> -                                                 &dev);
> -               if (ret && ret !=3D -ENODEV) {
> -                       pr_err("Failed to initialize OcteonTX BCH PF
> controller. (error %d)\n",
> -                              ret);
> -               }
> -               ret =3D uclass_get_device_by_driver(UCLASS_MISC,
> -
>  DM_DRIVER_GET(octeontx_pci_bchvf),
> -                                                 &dev);
> -               if (ret && ret !=3D -ENODEV) {
> -                       pr_err("Failed to initialize OcteonTX BCH VF
> controller. (error %d)\n",
> -                              ret);
> -               }
> -       }
> -
> -       ret =3D uclass_get_device_by_driver(UCLASS_MTD,
> -                                         DM_DRIVER_GET(octeontx_pci_nand=
),
> -                                         &dev);
> -       if (ret && ret !=3D -ENODEV)
> -               pr_err("Failed to initialize OcteonTX NAND controller.
> (error %d)\n",
> -                      ret);
> -}
> --
> 2.43.0
>
>

--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
