Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF494F364A6
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 18:12:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2279383DC9;
	Thu,  9 Apr 2026 20:12:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nL6rBFzt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B11DF8412A; Thu,  9 Apr 2026 17:39:18 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3A728419E
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 17:39:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@gmail.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-8a23f802e0cso16153956d6.1
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 08:39:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775749153; cv=none;
 d=google.com; s=arc-20240605;
 b=GaL0Mw4N5xFs2+48t3uUQ0ZR36y/ksA34jzrnWFzJq+VIpSVQ2NdPd67kLuSt6SmRG
 MyXGAcLsc2epCUUn09+npDJcExgLDHRWQpntQU2wSEX20HiJnHs1KHhrLGAoq+XHKagW
 a8ZN+n8Qch9nODZvTBUinVlzY5uwR1bC962CaXvDwcdbIViGsagu1yWcCDyFsA3vGPLq
 KAmvdNT3oGSAwRKbvwbg7N4lGkMVNzS9j4RMNab+g7PSZyIlBAd0Dl2qY8aBmAA63oaS
 B310dzT0Vu4ZO6qAkH28bqBF8GabsVvNIpmXVxCtsu0SWzOXJE2dhTF3T527SDFAYGMQ
 V/6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4Ww8dkl4RVp/tg7Hf8/JC0HJ8TBmICYn8SJV5AwG/B0=;
 fh=uOhV1t+0iFcV5eYFRMCyQ4vbcPD89Ro005zURaNYH3A=;
 b=eUL7Iv+6wsOeAa/8QXkCpQkt4H4BfRjYLNphfZD/eN3FqxM4klfyQ173SXKFcZiBbo
 PnvlWXPhXleKDI3IDWDgFoVtwPKUMY1WVi3hwbhM7A3XWtTBpRsINtSk3Zw9ar4TPGyh
 mad/cGfHOo6CrABQqUwiiT5fFIvBCwZXsvtQC2ppf7UQtIeCFUuOaa2lmT8z2LXsQ/6X
 eQUd0uBLbx+4zEjunaNHE+011Lv0gxbefEEL3eOE1o37Rin7lu+H6hs3QaC7pAMPDfii
 chN4jE91tVNIU7ctD+My/724H5CbFOP/OXUUw+xTGKuW9sWL8sywpA+XLXOB3ohDPkOX
 ywZw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775749153; x=1776353953; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Ww8dkl4RVp/tg7Hf8/JC0HJ8TBmICYn8SJV5AwG/B0=;
 b=nL6rBFztF8YzGKdk34SFRuCcRTxIiQ4QDknzfiTezbCipmLVXDt5y/ztcya6nMCMUn
 EPXp8sCj2oVophzUZClCYxWQhZcHdpja/btYZtrVryhl9k+e+bdMtTyd3Jb1h1JQgjkN
 KC/kCbs0hL62LM6c1nRZttLajhxgoT5wPMvGwlcBSnXhLlYqgYQ4ocmm0wtmCGRCO+MC
 He6BRXC5bsof4nhPyCoSBPq6UJ4z1y4UKo1kC2aSHgM5cXQNePJOvzX/M4LzEt5NKjEG
 i4aR6rviOglb8np/1/s2X9cKQoMWZfnW1cHGTmY9inBw0pdn4FLyGq/v7Sy/2WjHSNdC
 WwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775749153; x=1776353953;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4Ww8dkl4RVp/tg7Hf8/JC0HJ8TBmICYn8SJV5AwG/B0=;
 b=E5mYYSeCy4QzNK7PdfurbvAEumWiqfRlUcxSrbBBaOTylwCtiHCWNuT7I8SvBAGrq9
 +5diWJ8F7XvbEvpsWxg+6IbSa4bP9h+nzKg29Ap9bxwhXXzPE5bKnOj1De+xP8w3+BHO
 tmZu0Ni/QftOZRaIjN23pgHLgc18XWmrdPMp6rzcJ+gVtaePIr5ugxE4RBTPj6VTECrP
 9VldW2Mpp0ldVBXrQUZx0DTSgI+oC1mg1wFX9PV9X3CG+ZZUnBv4gwMfB1XOfcW13OPR
 h5WZfZIv5qhRTAbbl61usthh+imOlhB36cKh8iW68C7RlJOptPnFheS1Pziq+mp053FB
 SRsQ==
X-Gm-Message-State: AOJu0Yw+89X76QDWW++Sb35Reba0y06ot9Q5NwuB9IbMOlq9Xo6SNfub
 nYXoUAGe5gcj8Tqa/RUvujVkT4c0qrCFsW+KN8Q+HQ9jf0fEaWt6c9Wc66KqiPIYsPlAp2y31fp
 Q6ihhSvWk6eSwoPGlld03RgG4VS9nTSqyPEqYiSdmxQ==
X-Gm-Gg: AeBDievKLpGHNtWgrfVyo5QVolNiD6KcskH4NHKWEGZE6ptdCFnObvhtIffB/pnTmfs
 RUSfD7aaVdsRl8JfIHh0Ascm2q47RVFjGEI12gEtfuJ3EvOMY1KSDUj30u+tQXsgIbtT9t7EHvx
 kdPYtGkZgKzYzqZUseqEw38PqmeMV8xthcfiebi8Q1WMqIynRmg6WqoOwOAqUbnSIpPGl5kmiJN
 KEgJ5IbK3QDFJ8qRdAW6pUgnrK8fL3zz1SWut7W2e6JXcNCr5xf8CoB6+1i6/eN2fAJdfJEBAY2
 vxl0J/I=
X-Received: by 2002:a05:6214:3114:b0:8a5:e0a7:d9ac with SMTP id
 6a1803df08f44-8ac7422bf46mr65143426d6.27.1775749152522; Thu, 09 Apr 2026
 08:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260409-spl_ufs_only-v1-0-f7e0e243d805@oss.qualcomm.com>
 <20260409-spl_ufs_only-v1-1-f7e0e243d805@oss.qualcomm.com>
In-Reply-To: <20260409-spl_ufs_only-v1-1-f7e0e243d805@oss.qualcomm.com>
From: Alexey Charkov <alchark@gmail.com>
Date: Thu, 9 Apr 2026 19:39:00 +0400
X-Gm-Features: AQROBzCVzRo2bW4hOcPGaxdHb7P7HQDkEofoZCOqd0f_GXZvTPsBeVTequItJaE
Message-ID: <CABjd4Yx3ckxysb20=vCL6xUADByOQA7bsRx1ZSCoRFp5MBE4FQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] spl: ufs: Add partition support and flexible loading
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, 
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Javier Martinez Canillas <javierm@redhat.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, 
 Javier Tia <javier.tia@linaro.org>, Rasmus Villemoes <ravi@prevas.dk>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Dhruva Gole <d-gole@ti.com>, Richard Genoud <richard.genoud@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Tuyen Dang <tuyen.dang.xa@renesas.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, 
 Yao Zi <me@ziyao.cc>, Peter Korsgaard <peter@korsgaard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 09 Apr 2026 20:12:16 +0200
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

On Thu, Apr 9, 2026 at 6:43=E2=80=AFPM Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
>
> Add partition-based loading support to SPL UFS, similar to the
> existing implementation in spl_mmc.c. This allows loading from
> named partitions or partition numbers instead of hardcoded sector
> offsets.
>
> The loading strategy tries methods in order: absolute sector if
> configured, partition by name, partition by number, then filesystem
> mode (placeholder for future implementation).
>
> This brings UFS boot flexibility on par with MMC/SD boot.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  common/spl/Kconfig   |  40 ++++++++++-
>  common/spl/spl_ufs.c | 188 +++++++++++++++++++++++++++++++++++++++++++++=
------
>  include/part.h       |   3 +-
>  include/spl.h        |   4 ++
>  4 files changed, 214 insertions(+), 21 deletions(-)
>
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index a21b71ad5d1..b3c7a1d8aa3 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -1637,9 +1637,47 @@ config SPL_UFS_RAW_U_BOOT_SECTOR
>         depends on SPL_UFS_SUPPORT
>         default 0x800 if ARCH_ROCKCHIP
>         help
> -         Address on the block device to load U-Boot from.
> +         Absolute sector offset on the UFS LUN to load U-Boot from.
> +         This is tried first before partition-based loading.
> +         Set to 0x0 to skip absolute sector loading and use partition mo=
de.
>           Units: UFS sectors (1 sector =3D 4096 bytes).

Hi Balaji,

What if I want to load the FIT image from the start of a dedicated LUN?

> +config SPL_UFS_RAW_U_BOOT_USE_PARTITION
> +       bool "Enable UFS partition support for raw mode"
> +       depends on SPL_UFS_SUPPORT
> +       select SPL_LIBDISK_SUPPORT
> +       help
> +         Enable support for loading from a specific partition on UFS
> +         in raw mode. When enabled, you can specify either a partition
> +         name or partition number to load from.
> +
> +config SPL_UFS_RAW_U_BOOT_PARTITION_NAME
> +       string "Partition name to load U-Boot from"
> +       depends on SPL_UFS_RAW_U_BOOT_USE_PARTITION
> +       help
> +         Name of the partition to load U-Boot from in UFS raw mode.
> +         This is tried before partition number lookup.
> +         Leave empty to skip name-based lookup.
> +         Example: "boot", "uefi", "dtb_a"
> +
> +config SPL_UFS_RAW_U_BOOT_PARTITION_NUM
> +       int "Partition number to load U-Boot from"
> +       depends on SPL_UFS_RAW_U_BOOT_USE_PARTITION
> +       help
> +         Partition number to load U-Boot from when using UFS raw mode
> +         with partition support. This is used if partition name is not
> +         specified or not found.
> +
> +config SPL_UFS_FS
> +       bool "Enable UFS filesystem boot mode"
> +       depends on SPL_UFS_SUPPORT
> +       help
> +         Enable filesystem-based boot from UFS. This allows loading
> +         U-Boot from FAT or EXT4 filesystems on UFS partitions.
> +         This is tried as a fallback if raw mode loading fails.
> +
> +         Note: Filesystem support is not yet fully implemented.

Maybe split those into separate commits for easier review?

>  config SPL_WATCHDOG
>         bool "Support watchdog drivers"
>         imply SPL_WDT if !HW_WATCHDOG
> diff --git a/common/spl/spl_ufs.c b/common/spl/spl_ufs.c
> index cef1843f40f..c4e793bf701 100644
> --- a/common/spl/spl_ufs.c
> +++ b/common/spl/spl_ufs.c
> @@ -3,15 +3,19 @@
>   * (C) Copyright 2025 Alexey Charkov <alchark@gmail.com>
>   */
>
> +#include <dm.h>
> +#include <log.h>
>  #include <spl.h>
>  #include <spl_load.h>
>  #include <scsi.h>
> -#include <errno.h>
> -#include <image.h>
> +#include <part.h>
> +#include <blk.h>
>  #include <linux/compiler.h>
> -#include <log.h>
> +#include <errno.h>
>
> -static ulong spl_ufs_load_read(struct spl_load_info *load, ulong off, ul=
ong size, void *buf)
> +/* Block read callback for spl_load framework */
> +static ulong h_spl_ufs_load_read(struct spl_load_info *load, ulong off,
> +                                ulong size, void *buf)
>  {
>         struct blk_desc *bd =3D load->priv;
>         lbaint_t sector =3D off >> bd->log2blksz;
> @@ -20,30 +24,176 @@ static ulong spl_ufs_load_read(struct spl_load_info =
*load, ulong off, ulong size
>         return blk_dread(bd, sector, count, buf) << bd->log2blksz;
>  }
>
> -static int spl_ufs_load_image(struct spl_image_info *spl_image,
> -                             struct spl_boot_device *bootdev)
> +/* Load image from raw sector */
> +static int ufs_load_image_raw_sector(struct spl_image_info *spl_image,
> +                                    struct spl_boot_device *bootdev,
> +                                    struct blk_desc *bd,
> +                                    unsigned long sector)
>  {
> -       unsigned long sector =3D CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR;
> -       int devnum =3D CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM;
>         struct spl_load_info load;
> +       int ret;
> +
> +       debug("spl: ufs loading from sector 0x%lx\n", sector);
> +
> +       spl_load_init(&load, h_spl_ufs_load_read, bd, bd->blksz);
> +       ret =3D spl_load(spl_image, bootdev, &load, 0, sector << bd->log2=
blksz);
> +
> +       if (ret) {
> +               debug("spl: ufs load failed: %d\n", ret);
> +               return ret;
> +       }
> +
> +       debug("spl: ufs load successful\n");
> +       return 0;
> +}
> +
> +u32 __weak spl_ufs_boot_mode(const u32 boot_device)
> +{
> +       return UFS_MODE_RAW;
> +}
> +
> +int spl_ufs_load(struct spl_image_info *spl_image,
> +                struct spl_boot_device *bootdev,
> +                const char *filename)
> +{
> +       u32 boot_mode;
> +       int ret =3D 0;
> +       int devnum =3D CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM;
>         struct blk_desc *bd;
> -       int err;
> +       unsigned long sector =3D 0;
> +
> +       log_debug("spl: ufs devnum=3D%d\n", devnum);
> +
> +       ret =3D scsi_scan(false);
> +       if (ret) {
> +               printf("spl: scsi scan failed: %d\n", ret);
> +               return ret;
> +       }
>
> -       /* try to recognize storage devices immediately */
> -       scsi_scan(false);
>         bd =3D blk_get_devnum_by_uclass_id(UCLASS_SCSI, devnum);
> -       if (!bd)
> +       if (!bd) {
> +               printf("spl: could not get UFS device %d\n", devnum);
>                 return -ENODEV;
> +       }
>
> -       spl_load_init(&load, spl_ufs_load_read, bd, bd->blksz);
> -       err =3D spl_load(spl_image, bootdev, &load, 0, sector << bd->log2=
blksz);
> -       if (err) {
> -               puts("spl_ufs_load_image: ufs block read error\n");
> -               log_debug("(error=3D%d)\n", err);
> -               return err;
> +       boot_mode =3D spl_ufs_boot_mode(bootdev->boot_device);
> +
> +       switch (boot_mode) {
> +       case UFS_MODE_RAW:
> +               debug("spl: ufs raw mode\n");
> +
> +               /* Step 1: Try absolute sector (if configured and non-zer=
o) */
> +#ifdef CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR

Perhaps if this and the below blocks are split out into helper
functions which compile to a no-op when the respective Kconfig option
is not set the code would be prettier :)

Preprocessor defines really break the flow visually by going across
the indentation of the surrounding code.

> +               if (CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR !=3D 0) {
> +                       debug("spl: trying absolute sector 0x%x\n",
> +                             CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR);
> +
> +                       ret =3D ufs_load_image_raw_sector(spl_image, boot=
dev, bd,
> +                                                       CONFIG_SPL_UFS_RA=
W_U_BOOT_SECTOR);
> +
> +                       if (!ret) {
> +                               debug("spl: loaded from absolute sector\n=
");
> +                               return 0;
> +                       }
> +                       debug("spl: absolute sector failed: %d\n", ret);
> +               }
> +#endif
> +
> +               /* Step 2-4: Try partition-based loading */
> +#ifdef CONFIG_SPL_UFS_RAW_U_BOOT_USE_PARTITION
> +               {
> +                       struct disk_partition part_info;
> +                       int part_found =3D 0;

... especially since you want to use scoped blocks with local
variables. These really ask to go into a helper function instead.

> +                       /* Step 2: Try partition name (if configured) */
> +#ifdef CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME
> +                       if (strlen(CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NA=
ME) > 0) {
> +                               debug("spl: trying partition name '%s'\n"=
,
> +                                     CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION=
_NAME);
> +
> +                               ret =3D part_get_info_by_name(bd,
> +                                                           CONFIG_SPL_UF=
S_RAW_U_BOOT_PARTITION_NAME,
> +                                       &part_info);
> +
> +                               if (ret >=3D 0) {
> +                                       debug("spl: found partition '%s' =
at 0x%lx\n",
> +                                             CONFIG_SPL_UFS_RAW_U_BOOT_P=
ARTITION_NAME,
> +                                             (ulong)part_info.start);
> +                                       sector =3D part_info.start;
> +                                       part_found =3D 1;
> +                               } else {
> +                                       debug("spl: partition name not fo=
und: %d\n", ret);
> +                               }
> +                       }
> +#endif
> +
> +                       /* Step 3: Try partition number (if name not foun=
d) */
> +#ifdef CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NUM
> +                       if (!part_found) {
> +                               debug("spl: trying partition number %d\n"=
,
> +                                     CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION=
_NUM);
> +
> +                               ret =3D part_get_info(bd,
> +                                                   CONFIG_SPL_UFS_RAW_U_=
BOOT_PARTITION_NUM,
> +                                                   &part_info);
> +
> +                               if (ret >=3D 0) {
> +                                       debug("spl: found partition %d at=
 0x%lx\n",
> +                                             CONFIG_SPL_UFS_RAW_U_BOOT_P=
ARTITION_NUM,
> +                                             (ulong)part_info.start);
> +                                       sector =3D part_info.start;
> +                                       part_found =3D 1;
> +                               } else {
> +                                       debug("spl: partition number not =
found: %d\n", ret);
> +                               }
> +                       }
> +#endif
> +
> +                       /* Load from partition if found */
> +                       if (part_found) {
> +                               ret =3D ufs_load_image_raw_sector(spl_ima=
ge, bootdev, bd, sector);
> +
> +                               if (!ret) {
> +                                       debug("spl: loaded from partition=
\n");
> +                                       return 0;
> +                               }
> +                               debug("spl: partition load failed: %d\n",=
 ret);
> +                       }
> +               }
> +#endif /* CONFIG_SPL_UFS_RAW_U_BOOT_USE_PARTITION */
> +
> +               /* Step 4: Fall through to FS mode if enabled */

Wouldn't a raw offset be a more natural fallback, given that it has
fewest dependencies out of all these options?

> +               debug("spl: raw mode failed, trying fs\n");
> +               fallthrough;
> +
> +#ifdef CONFIG_SPL_UFS_FS
> +       case UFS_MODE_FS:
> +               debug("spl: ufs fs mode\n");
> +
> +               /* TODO: Implement filesystem support */
> +               printf("spl: ufs filesystem boot not implemented\n");
> +               ret =3D -ENOSYS;
> +               break;
> +#endif
> +
> +       default:
> +               puts("spl: ufs: invalid boot mode\n");
> +               ret =3D -EINVAL;
>         }
>
> -       return 0;
> +       return ret;
> +}
> +
> +/* SPL load image entry point */
> +static int spl_ufs_load_image(struct spl_image_info *spl_image,
> +                             struct spl_boot_device *bootdev)
> +{
> +       return spl_ufs_load(spl_image, bootdev,
> +#ifdef CONFIG_SPL_FS_LOAD_PAYLOAD_NAME
> +                           CONFIG_SPL_FS_LOAD_PAYLOAD_NAME);
> +#else
> +                           NULL);
> +#endif

How about config_enabled(...) instead? Gives fewer repetitions of the
same symbol.

Best regards,
Alexey
