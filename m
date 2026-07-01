Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5AF8C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 11:52:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 263FB84B0E;
	Wed,  1 Jul 2026 13:52:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XFi/M8/1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F027C84BC6; Wed,  1 Jul 2026 13:52:38 +0200 (CEST)
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com
 [IPv6:2607:f8b0:4864:20::b131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2B7284A26
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 13:52:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-664d35b4777so697741d50.3
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 04:52:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782906754; cv=none;
 d=google.com; s=arc-20260327;
 b=nxfsXwrGPUH89TRDgVmgyDgrntwwRDDxos+o+uwm+oI0M4rWIqbS2byB8MlXR/1cTJ
 jEjhW79YxVtEH5zRMbru+XEIMIbbJG9IQYxYIOyaU8ogmtxeVPECidyI1XILwN6y7Ty6
 mItSrAp+ONOJGEfPYN61NM7CMBVf/nlinz0CSx6pdYYYPZ7WWY826yjFJ1NJsf6S0nnp
 kw0iT4T8PB2I7q2t5v3M0hB70wUxRzWgyPHBeHPXVy56cjEvR3QTVI8JULmM1qzjAD1X
 7YUqfSA7scKWP0VdIT/25qD7Y+vWdxrlQ/58XCsbBIKdTHYwtucHhtDXlSDGP73UDN3j
 Iskw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/dHk9b762H50XyPBups+I6qu8IKwpAzKgE2iDj9Q41w=;
 fh=G77DOrEBa9vYP3Ysb62K+3tuBUBfRrZUys70ZS9WjEI=;
 b=EOL6uz+g2UEr6FdoPlPnJxWaHHJ5adIpL5TRbLSbwLFRXJ/CR7dZzTCT3UQKR0lLaG
 8I+KFyO0k5bamDgrnRKxn42GwQQVzlCpeFHmnZpw1BBFDNUgLTY5QLweki/18UhuJftw
 AdgKcKOUgFicXasVwS033e4tD36r6V8dnfYkDxO7/RVzvEH72jX3IA2pepEAm6krkTMl
 W4NOUiD0pLWIQMstSNPqvAKRQ5kTUo4PsrVZqY0fQZsMybgFguQiK1uV2MTFvvlSzDXM
 2kmpCN4K8odbUW3m8HpI+uMJT03z/tfk+NybIpSOhusRoc1v+PD3HYdN57v+l3v7lULv
 lV5w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782906754; x=1783511554; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/dHk9b762H50XyPBups+I6qu8IKwpAzKgE2iDj9Q41w=;
 b=XFi/M8/1qjxrabHPZl6/j6hfIEy3a7jQgYVhOkKHM3Pe3eggfzn2OwGTBSej5nPJIP
 8rnM4HLPqbckkbk9GHAKg4Zapm8uAAdOOU9S7Oh4laVAEu/NjyocQVZdSffewQoTxwyV
 V12YwWSBFNYrhpW6CCRmWnyKVBQCpJK2oeJ4rf9o2zUyuRX+wAsTxHVNGOetR2gewVRD
 ueH7aj1igFF3b9Wc0dRdq7ljuDhZbkm0Wh/rc0reI6/bqijMDPH3K1Xq8Q59venZkGPM
 fkGwrzIYXhmoVuvPk06tH8Nn3LWFwzCIfrZKWZMe0YwQp0ntI2f7vTmeJ7rzX1eeZH+2
 1wQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782906754; x=1783511554;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/dHk9b762H50XyPBups+I6qu8IKwpAzKgE2iDj9Q41w=;
 b=lk/yyjr1cTCBGlx+XkL4IVLG9SodYKp2ofoFfGAw/MCL+5pehNqCIgbzySzkkH67qe
 a7ZccnIsQ4pUfVuoCTAmD5Q0Dm0CS3MerD7DP8E721e6Co7Fus0/Xb9NywkY6E9OIl1N
 7cxUhMUBw3tAGtTlkbwvZmMv6oz3xaT5/KwBF0HaA1Cj6aG3kEaPh0HxxZC5hHNNQGi6
 K+Pe6uUk0ncDyK+f2Zzdu7ys0dPyN7bYky+BQGzfp2fYP9bgAvT9zeCl6fZco4Y80SIE
 ISksCCFyNkYGR1uU6VDhTpw8E78xleBVOZ/chFI0NAiT+HTPa0QbtlVew4gsAN83XGUZ
 VIeA==
X-Gm-Message-State: AOJu0Yy/XZfskb9HnIPMmD6DyOsikT4APlV1DV7rBCbg86Msstg5XZ4x
 GyQvK+z0ahSgSmr/pTfBxwYRJUpN6n6fZzFSdzNRUeYfEt1Dtex4ysif6adPag/4UwgsEw786yR
 YyBWiHXeea0paTRakMozP5NDn3Debp+17FX7dOj6w1g==
X-Gm-Gg: AfdE7cnEMaDpuSNG427OO12x6usRXUqeN/1cAoCSZzF6fI3RvJ15Ww6WhgUSjb4kVmB
 mSJxnDLqLhfHnCjf8Z3Ij/ue/AlhJ53NMK8ZMqZH2Zt81xROTpZXc2pDP6qQKNrHuL+ykZTDd14
 PnVF0MyUip9/AGQIlz22O0NntNbz4bbfpF5i4atPFUfiGKPt9hC2t6USQKP5uKrDB68rt5qSMal
 wRXIls6Q0nY+5RtF3/KXa0v60tyTTaeilscqne+kd3jWCytqLtH+2WRFTDVomlWZKOMulByKZws
 HFB47XQ0vZYIX+EFP5B62NIs8esfEdO0bMyzSs9oBsuLRyfhOaZWefhrkYn8SbVGQ4+CsJJ2FjH
 MfETZ3NFm7Ds28Mc+yVqsgf8AdOYwBOm0BCZcaJRmdDMv3ffDTrpXdVWUG+yl4qFGCseZls3Bvs
 SqX9SdObgO6ukN6e8Lgke/yjuYS2vmcs+jq1pM/kGnqx0NZYXA7RuEDAw5osoz2OIrcKEkrctJP
 SFltnwUjoO3mlf9wk2WQpCqMmOUEIEn08HFyG2xq7TXeVuOuaV9aaMnLW1O/dS9VUeIqmjaJ9Ub
 6i+khmyKSmffBiCVCF+WHko6VydhIv+sKNf8cydaRRr8JoAXf5EA2EDwrz3T46057vxaPV0=
X-Received: by 2002:a05:690e:13c6:b0:664:f570:84f5 with SMTP id
 956f58d0204a3-66521a5068dmr1460416d50.37.1782906754174; Wed, 01 Jul 2026
 04:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260629080241.36311-1-ludwig.nussel@siemens.com>
 <20260629100104.v4.3.db7fbeb8b6e8499f4d031c04cb5cd8175873b643@changeid>
In-Reply-To: <20260629100104.v4.3.db7fbeb8b6e8499f4d031c04cb5cd8175873b643@changeid>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 1 Jul 2026 14:51:57 +0300
X-Gm-Features: AVVi8CePoWdzGfWInhhawo_of6FOFNmyxBjaWhKOvOaYmN0hYkgcsDtDnCcktW0
Message-ID: <CAC_iWjL-uC0C9xFyGdJnYY5WcNuD56uNufwHdi5Tbe8WmvHHiQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] tpm: allocate tpm event log if missing
To: Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>, 
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
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

Hi Ludwig,

On Mon, 29 Jun 2026 at 11:02, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
>
> With EFI U-Boot always allocates a buffer for the TPM event log. If
> a previous bootloader stage started an event log, U-Boot would copy
> the entries to that allocated buffer.
>
> Without EFI U-Boot wants to reuse the event log memory from a
> previous bootloader stage instead. If U-Boot is first component to
> start the event log, e.g. when used in qemu there would be no memory
> allocated for the event log.
>
> So allocate memory in tcg2_log_prepare_buffer() if no event log was
> found and no buffer was allocated already.
> Also copy the address of the event log into the device tree for the
> kernel so the event log is accessible from Linux userspace too.
>
> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
>

[...]

>
>  boot/bootm.c         |  18 +++---
>  boot/image-fdt.c     |  69 +++++++++++++++++++++++
>  include/tpm-common.h |   2 +
>  include/tpm_tcg2.h   |   9 +--
>  lib/Kconfig          |   1 +
>  lib/tpm_tcg2.c       | 130 ++++++++++++++++++++++++++++++++++---------
>  6 files changed, 188 insertions(+), 41 deletions(-)
>
> diff --git a/boot/bootm.c b/boot/bootm.c
> index 4836d6b2d41..701ec010e01 100644
> --- a/boot/bootm.c
> +++ b/boot/bootm.c
> @@ -921,23 +921,19 @@ int bootm_measure(struct bootm_headers *images)
>                 return ret;
>
>         if (IS_ENABLED(CONFIG_MEASURED_BOOT)) {
> -               struct tcg2_event_log elog;
>                 struct udevice *dev;
>                 void *initrd_buf;
>                 void *image_buf;
>                 const char *s;
>                 u32 rd_len;
> -               bool ign;
>
> -               elog.log_size = 0;
> -               ign = IS_ENABLED(CONFIG_MEASURE_IGNORE_LOG);
> -               ret = tcg2_measurement_init(&dev, &elog, ign);
> -               if (ret)
> +               ret = tcg2_measurement_init(&dev, NULL);
> +               if (ret && ret != -EEXIST)
>                         return ret;
>
>                 image_buf = map_sysmem(images->os.image_start,
>                                        images->os.image_len);
> -               ret = tcg2_measure_data(dev, &elog, 8, images->os.image_len,
> +               ret = tcg2_measure_data(dev, NULL, 8, images->os.image_len,
>                                         image_buf, EV_COMPACT_HASH,
>                                         strlen("linux") + 1, (u8 *)"linux");
>                 if (ret)
> @@ -945,14 +941,14 @@ int bootm_measure(struct bootm_headers *images)
>
>                 rd_len = images->rd_end - images->rd_start;
>                 initrd_buf = map_sysmem(images->rd_start, rd_len);
> -               ret = tcg2_measure_data(dev, &elog, 9, rd_len, initrd_buf,
> +               ret = tcg2_measure_data(dev, NULL, 9, rd_len, initrd_buf,
>                                         EV_COMPACT_HASH, strlen("initrd") + 1,
>                                         (u8 *)"initrd");
>                 if (ret)
>                         goto unmap_initrd;
>
>                 if (IS_ENABLED(CONFIG_MEASURE_DEVICETREE)) {
> -                       ret = tcg2_measure_data(dev, &elog, 1, images->ft_len,
> +                       ret = tcg2_measure_data(dev, NULL, 1, images->ft_len,
>                                                 (u8 *)images->ft_addr,
>                                                 EV_TABLE_OF_DEVICES,
>                                                 strlen("dts") + 1,
> @@ -964,7 +960,7 @@ int bootm_measure(struct bootm_headers *images)
>                 s = env_get("bootargs");
>                 if (!s)
>                         s = "";
> -               ret = tcg2_measure_data(dev, &elog, 1, strlen(s) + 1, (u8 *)s,
> +               ret = tcg2_measure_data(dev, NULL, 1, strlen(s) + 1, (u8 *)s,
>                                         EV_PLATFORM_CONFIG_FLAGS,
>                                         strlen(s) + 1, (u8 *)s);
>
> @@ -973,7 +969,7 @@ unmap_initrd:
>
>  unmap_image:
>                 unmap_sysmem(image_buf);
> -               tcg2_measurement_term(dev, &elog, ret != 0);
> +               tcg2_measurement_term(dev, NULL, ret != 0);
>         }
>
>         return ret;
> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> index a3a4fb8b558..478158294ed 100644
> --- a/boot/image-fdt.c
> +++ b/boot/image-fdt.c
> @@ -24,6 +24,8 @@
>  #include <asm/io.h>
>  #include <dm/ofnode.h>
>  #include <tee/optee.h>
> +#include <tpm_tcg2.h>
> +#include <dm/device.h>
>
>  DECLARE_GLOBAL_DATA_PTR;
>
> @@ -589,6 +591,68 @@ __weak int arch_fixup_fdt(void *blob)
>         return 0;
>  }
>
> +static int copy_tpm_event_log(void *blob)
> +{
> +       int rc;
> +       struct udevice *dev;
> +       ofnode node;
> +       char path[256];
> +       int off;
> +       struct tcg2_event_log *log;
> +
> +       if (!IS_ENABLED(CONFIG_MEASURED_BOOT))
> +               return 0;
> +
> +       rc = tcg2_platform_get_tpm2(&dev);
> +       if (rc)
> +               return rc;
> +
> +       log = tcg2_platform_get_dev_log(dev);
> +
> +       if (!log || !log->allocated) {
> +               log_debug("tpm event log not allocated\n");
> +               return -ENOENT;
> +       }
> +
> +       node = dev_ofnode(dev);
> +       if (!ofnode_valid(node)) {
> +               log_err("tpm %p has no device tree representation\n", dev);
> +               return -ENOENT;
> +       }
> +
> +       rc = ofnode_get_path(node, path, sizeof(path));
> +       if (rc)
> +               return rc;
> +
> +       off = fdt_path_offset(blob, path);
> +       if (off < 0) {
> +               log_warning("kernel device tree lacks %s\n", path);
> +               return 0;
> +       }
> +
> +       if (fdt_getprop(blob, off, "linux,sml-base", NULL)) {
> +               log_warning("kernel dt already defines an event log address at %s\n", path);
> +               return 0;
> +       }
> +
> +       fdt64_t base = cpu_to_fdt64((u64)virt_to_phys(log->log));
> +
> +       rc = fdt_find_and_setprop(blob, path, "linux,sml-base", &base, sizeof(base), 1);
> +       if (rc) {
> +               log_err("failed to set sml-base: %d\n", rc);
> +               return rc;
> +       }
> +
> +       fdt32_t size = cpu_to_fdt32((u32)log->log_size);
> +
> +       rc = fdt_find_and_setprop(blob, path, "linux,sml-size", &size, sizeof(size), 1);
> +       if (rc) {
> +               log_err("failed to set sml-size: %d\n", rc);
> +               return rc;
> +       }
> +       return 0;
> +}
> +
>  int image_setup_libfdt(struct bootm_headers *images, void *blob, bool lmb)
>  {
>         ulong *initrd_start = &images->initrd_start;
> @@ -631,6 +695,11 @@ int image_setup_libfdt(struct bootm_headers *images, void *blob, bool lmb)
>                 goto err;
>         }
>
> +       fdt_ret = copy_tpm_event_log(blob);
> +       if (fdt_ret && fdt_ret != -ENOENT && fdt_ret != -ENODEV) {
> +               log_warning("Failed to copy TPM event log: %d\n", fdt_ret);
> +       }
> +
>         /* Store name of configuration node as u-boot,bootconf in /chosen node */
>         if (images->fit_uname_cfg)
>                 fdt_find_and_setprop(blob, "/chosen", "u-boot,bootconf",
> diff --git a/include/tpm-common.h b/include/tpm-common.h
> index bfb84a931d1..3be69e7f392 100644
> --- a/include/tpm-common.h
> +++ b/include/tpm-common.h
> @@ -10,6 +10,7 @@
>  #include <command.h>
>
>  struct udevice;
> +struct tcg2_event_log;
>
>  enum tpm_duration {
>         TPM_SHORT = 0,
> @@ -83,6 +84,7 @@ struct tpm_chip_priv {
>         u32 active_banks[TPM2_NUM_PCR_BANKS];
>  #endif
>         bool plat_hier_disabled;
> +       struct tcg2_event_log *log;
>  };
>
>  /**
> diff --git a/include/tpm_tcg2.h b/include/tpm_tcg2.h
> index eb6afe49e77..db3f6f486e9 100644
> --- a/include/tpm_tcg2.h
> +++ b/include/tpm_tcg2.h
> @@ -162,12 +162,14 @@ struct tcg_efi_spec_id_event {
>   * @log_position:      Current entry position
>   * @log_size:          Log space available
>   * @found:             Boolean indicating if an existing log was discovered
> + * @allocated:         Boolean indicating that the log was allocated by u-boot
>   */
>  struct tcg2_event_log {
>         u8 *log;
>         u32 log_position;
>         u32 log_size;
>         bool found;
> +       bool allocated;
>  };
>
>  /**
> @@ -291,13 +293,10 @@ int tcg2_log_prepare_buffer(struct udevice *dev, struct tcg2_event_log *elog,
>   *                     memory region, in which case any existing log
>   *                     discovered will be copied to the specified memory
>   *                     region.
> - * @ignore_existing_log Boolean to indicate whether or not to ignore an
> - *                     existing platform log in memory
>   *
>   * Return: zero on success, negative errno otherwise
>   */
> -int tcg2_measurement_init(struct udevice **dev, struct tcg2_event_log *elog,
> -                         bool ignore_existing_log);
> +int tcg2_measurement_init(struct udevice **dev, struct tcg2_event_log *elog);
>
>  /**
>   * Stop measurements and record separator events.
> @@ -345,4 +344,6 @@ void tcg2_platform_startup_error(struct udevice *dev, int rc);
>   */
>  u32 tcg2_algorithm_to_mask(enum tpm2_algorithms);
>
> +struct tcg2_event_log *tcg2_platform_get_dev_log(struct udevice *dev);
> +
>  #endif /* __TPM_TCG_V2_H */
> diff --git a/lib/Kconfig b/lib/Kconfig
> index cf13ac1bdad..170621ae266 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -493,6 +493,7 @@ config TPM
>         bool "Trusted Platform Module (TPM) Support"
>         depends on DM
>         imply DM_RNG
> +       imply DEVRES
>         select SHA1
>         help
>           This enables support for TPMs which can be used to provide security
> diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
> index d41228f75a9..2270b038cf5 100644
> --- a/lib/tpm_tcg2.c
> +++ b/lib/tpm_tcg2.c
> @@ -21,6 +21,7 @@
>  #include <linux/unaligned/le_byteshift.h>
>  #include "tpm-utils.h"
>  #include <bloblist.h>
> +#include <dm/devres.h>
>
>  int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_bank, u32 *active_bank,
>                       u32 *bank_num)
> @@ -212,6 +213,9 @@ static int tcg2_log_append_check(struct tcg2_event_log *elog, u32 pcr_index,
>         u32 event_size;
>         u8 *log;
>
> +       if (!elog || !elog->log_size)
> +               return 0;
> +

This is not needed, you always call it after setting up the eventlog.

>         event_size = size + tcg2_event_get_size(digest_list);
>         if (elog->log_position + event_size > elog->log_size) {
>                 printf("%s: log too large: %u + %u > %u\n", __func__,
> @@ -553,6 +557,9 @@ int tcg2_measure_data(struct udevice *dev, struct tcg2_event_log *elog,
>         if (rc)
>                 return rc;
>
> +       if (!elog)
> +               elog = tcg2_platform_get_dev_log(dev);
> +

I still don't like this. However, I think I can live with it, because
we can just change the EFI code in the future do fill in the priv->log
and get rid of the argument overall. We can then just look at
priv->log and allocate one if it's NULL.

>         return tcg2_log_append_check(elog, pcr_index, event_type, &digest_list,
>                                      event_size, event);
>  }
> @@ -560,15 +567,32 @@ int tcg2_measure_data(struct udevice *dev, struct tcg2_event_log *elog,
>  int tcg2_log_prepare_buffer(struct udevice *dev, struct tcg2_event_log *elog,
>                             bool ignore_existing_log)
>  {
> -       struct tcg2_event_log log;
> +       struct tcg2_event_log log = {};
>         int rc;
>         u32 log_active = 0;
>
> -       elog->log_position = 0;
> -       elog->found = false;
> +       if (elog) {
> +               elog->log_position = 0;
> +               elog->found = false;
> +               elog->allocated = false;
> +       } else if (tcg2_platform_get_dev_log(dev)) {
> +               return -EEXIST;
> +       }
>
>         rc = tcg2_platform_get_log(dev, (void **)&log.log, &log.log_size);

We now have tcg2_platform_get_log(), tcg2_platform_get_dev_log() and
it's getting a bit confusing.
tcg2_platform_get_log() is already looking at the handover protocol,
the DT and reserved memory nodes to figure out if it needs to use one
of these or  bail out.

I think it would make sense to rename tcg2_platform_get_log() to
tcg2_upsert_eventlog of tcg2_find_create_eventlog() and fold in the
memory allocation in there. Since the memory location won't change
across various bootm commands either, we won't be calling
copy_tpm_event_log() each time. And on top of that we can probably get
rid of the -EEXIST checks, since we will know that the first booted
image has also created the eventlog for us. While at it we can also
remove the __weak argument from that function. That was added back
when reading the eventlog from previous loaders wasn't well
standardized. It now is so we don't need platforms overriding that
part

[...]

Thanks
/Ilias
