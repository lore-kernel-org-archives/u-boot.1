Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E33E0CD5BAF
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 06:49:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BBFA846CF;
	Fri, 22 May 2026 08:49:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pTqtQRVL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92F68846D0; Fri, 22 May 2026 08:49:20 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41F02841D7
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 08:49:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-7bdaa68cf81so64575637b3.3
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 23:49:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779432556; cv=none;
 d=google.com; s=arc-20240605;
 b=caYRt7/12o7IMPVyN7hNBV2DV4XxjVCDAEf4KHcdDy9GaBhtKbQXupLKy5NHugSPmd
 gENW2MaghZ0qKjRDAktAeqURZ1mOyzcaWpdrt2bsiRFPlggCf2RFCtu85oNuIr8tTAa+
 eXVzozV8Hhjswr3uzlOhc6vJGAlKFgwgl0bBfzdzJ5XrUPW3YC27ZGz8/5ARJChQYiwC
 3Vn4k6IsdRv4j99qONK80j98fD2Ujg0tzR0prKfwGsEVOQb/5sg+vqg+rt6Chwj30j5u
 DkOb+NQ0lO5DzWd0988TR0sp9BZxrIjgq5BBv/zxZCVbIdmY7P0A3j6c02h95R1jvG3L
 Pu0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GZtDM4icSRFzhluHloie4jxLLpwoPfbrxRvYEVgtiSE=;
 fh=07zUd/Is+PSwrEeSBoT+adnvQ2n/fGm+wxcGUqpW8ww=;
 b=azk3qKvERcUIbaJilSC7e4QV5EShiGPT2muG/eLA4+GPSBEd+lkQhDF1F2RdTzGqHQ
 iH0WJfEtbHHJh35WlYTF/QHvIiza+ys2RiMW3mprUDeincd1UziNzvDNQfwAr5le3zHi
 sjxsK6v2OQqdltlEW1E4zQmGCy0lDvKXXHbsa3ff3gSckNoXaSFk8fKVx9LoaCDIf0Fo
 fJh+hhSLLcfLWrllByhCV3x42HXfQ9iWjMsHScnrYHlMy+6UGxPxboNs9RQrdrRnGVxN
 5E0dle+0nQTXrKCuAv0UEm2n+ClTA8LRGhaqgmJt9flFW4PRa9AwcbUl7j338ONkQN6/
 2lsw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779432556; x=1780037356; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GZtDM4icSRFzhluHloie4jxLLpwoPfbrxRvYEVgtiSE=;
 b=pTqtQRVLxkaDeoKx2iiSb5xyRdfPZYM0EEHS0bbkebX3wuuOFVNT3nmCFDJGizQTXr
 AA7zbig2E6nESrzo2GgQliP69KH+Ty3ULszFW0sTzFRGI25Oq3e+QI8Q9rVw4a5E/394
 9DJVdtVBGfipnwXUXrPwEfUKTDvg5+tS9I2YUWjDLefX7aG7LvE1e9qyZ8twtC4FNT0B
 Ymr+lEsGxYyEC9jG5b8i2O8Jln7XryxPLccmAZvrhrQtkW4hrxfR6+90QF4f5c0+ri7D
 4jW1Y4VoB56qSlwRE8/AMXof+4110qZ9wTg+v/4EuimOaitoTE8uzixo6CbnRm1lG3Sb
 0b5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779432556; x=1780037356;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GZtDM4icSRFzhluHloie4jxLLpwoPfbrxRvYEVgtiSE=;
 b=db0Lf5xYXW9zfek0FEw3whBmg8+6+Fx2XrppU5e94B0W8t4UBasBi9R/CVuEqPomAr
 F+Aqbfl3qHfmF1l3SP2cMIcQUOs6UH1CR4xJSaJ6LO+Rkk9IriF5rZVQERBcaCIkyYf3
 LW+u5HlyitgaxU1r3RhXGrNIJ1Q2OqxlQ5jC+vX2RizVPU9s9VigHH23/pvbZqA587XB
 D66gAtxhjaPzu6JsBkxHI1Cc03XIQGK0VCPzkN6cgsS3pAc8uxvGfm5qqByxrXRRah2y
 mE8qXaMvcN7mO4TaaeOzJSX2nxrZHwozQUBASL24rM96FC4Zm3C/PSYm8Im2gTMp2bi1
 SOWg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ldOdxw+0LPNk1tdkPfy/xKFtPyZTJ30VMlWVZs7ypV4LjjNg7ObH07yE0ATDYMg0vKppj2Ks=@lists.denx.de
X-Gm-Message-State: AOJu0YwNgTZuc2dY4xKT5RedcIPPd1mFUGKNsg5KkxkkRn66xXkAJZdV
 53QumyegUZwcO6/+w8E/v1xB3qe5AvDNes92CgW0CBX+/Akg78oEgEwCTkD2cnohr6X3X/j3gaO
 1ElCg+if7Gb+mMOTkYmsmadYzSSaF7G6lAp2qkbWjqg==
X-Gm-Gg: Acq92OFHUp6Zgwtayxb0DUKHUjSO0+6AlrDouP5VomeqUD64l7AiBlysfyXXDUX8nc5
 lXDE1Q63rgy0e+uPTiZ33XHrYZJrVyAUVCMIn5AiCwxIsIdxNCv7K1qDPhEftq6pn04DKHx+SxP
 tSkFTKpodTNeLvFZLz7Zzhq0vn1V3TIcEwn+iaGof5KF0k9pVyxWYyw9LnnL0F+DmJsi+fwOJwb
 zCk4QfRulq54aI2cC0ioS7oDX73AsubocfTCS/OVMH4nsKmX6EnOiKPNkojQ7FEHdVH8NCmuzlp
 JIw5jGJx4dnMBw3B8r5MIogns2RY+C1D53nCkzj+iZ0DlPNUWKpUJHB68hcGdvyulotg8QaKRdE
 eSzSuZF0wJ5TjwLOoVO0HgzEiauZnLXsZuKjNtbEtLcRAM6cIU0ZAbdFXqtohi02Yd19m6im6wL
 fBLtIhw86ROktGG/DFm//0Uc41WGQTH3nxq7XIH4xs6LLRuq5cKpH5vjFdcAWvoyeJL5BYTQXhH
 chzjQwboFu1PZ7wvcpRhzM2wUrDau6DllGNvRyeEk1Y7J9kGgzLO4f2GHIgvf1sEYqPJLkw0fYp
 lhj788K/7HhPYpWBflYhSPLETA0i7x/R3XJDMC0lyvQWfTU2wwWDriyVdsIE4rwdgaFtLz7ffgF
 1RIo5pQ==
X-Received: by 2002:a05:690e:43c3:b0:651:92cb:7157 with SMTP id
 956f58d0204a3-65ec98ab616mr1832574d50.36.1779432555773; Thu, 21 May 2026
 23:49:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260522-capsule-v1-0-ff0ac9978d48@oss.qualcomm.com>
 <20260522-capsule-v1-1-ff0ac9978d48@oss.qualcomm.com>
In-Reply-To: <20260522-capsule-v1-1-ff0ac9978d48@oss.qualcomm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 22 May 2026 09:48:39 +0300
X-Gm-Features: AVHnY4KEtGLOsGsUUy6wdRznUKerOJpCkeA8ZYR-8FAvbWyu6G3gjXRjM_1Y038
Message-ID: <CAC_iWj+VQyO1Zy+mPqcQJY91aEFsrwXFT4dbObejar0fDpCaSg@mail.gmail.com>
Subject: Re: [PATCH 1/7] qcom: capsule: add FIT capsule support with
 multi-partition
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Minnekhanov <alexeymin@minlexx.ru>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
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

Hi Balaji,


On Fri, 22 May 2026 at 09:09, Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
>
> Add comprehensive FIT capsule update support for Qualcomm platforms
> alongside existing RAW capsule implementation. The new FIT support
> enables multi-partition firmware updates with automatic partition
> discovery.


I am not sure I am following this one? What are you trying to achieve
here? Have a single capsule for all hardware?

Thanks
/Ilias
>
> Refactor qcom_configure_capsule_updates() to use compile-time
> mutual exclusivity between CONFIG_EFI_CAPSULE_FIRMWARE_FIT and
> CONFIG_EFI_CAPSULE_FIRMWARE_RAW using #elif preprocessor directives.
>
> Add board-specific FIT capsule GUIDs for QCS615, QCS6490, and Lemans
> platforms with automatic board detection from device tree compatible
> strings. Each board uses a unique GUID to prevent cross-board
> flashing accidents.
>
> The FIT implementation discovers all SCSI/eMMC partitions across
> multiple devices, applies A/B selection logic based on GPT vendor
> attributes, and generates a comprehensive DFU string for
> multi-partition updates.
>
> A single ESRT entry represents all partitions for simplified firmware
> management.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  arch/arm/mach-snapdragon/capsule_update.c | 740 ++++++++++++++++++++++++++++--
>  arch/arm/mach-snapdragon/qcom-priv.h      |  23 +
>  2 files changed, 712 insertions(+), 51 deletions(-)
>
> diff --git a/arch/arm/mach-snapdragon/capsule_update.c b/arch/arm/mach-snapdragon/capsule_update.c
> index 586682434b7..d803c46f38d 100644
> --- a/arch/arm/mach-snapdragon/capsule_update.c
> +++ b/arch/arm/mach-snapdragon/capsule_update.c
> @@ -8,30 +8,55 @@
>
>  #define pr_fmt(fmt) "QCOM-FMP: " fmt
>
> -#include <dm/device.h>
> -#include <dm/uclass.h>
> +#include <command.h>
>  #include <efi.h>
>  #include <efi_loader.h>
>  #include <malloc.h>
>  #include <mmc.h>
> -#include <scsi.h>
>  #include <part.h>
> +#include <scsi.h>
> +#include <dm/device.h>
> +#include <dm/uclass.h>
>  #include <linux/err.h>
> -
>  #include "qcom-priv.h"
>
>  /*
> - * To handle different variants like chainloaded U-Boot here we need to
> - * build the fw_images array dynamically at runtime. These are the possible
> - * implementations:
> - *
> - * - Devices with U-Boot on the uefi_a/b partition
> - * - Devices with U-Boot on the boot (a/b) partition
> - * - Devices with U-Boot on the xbl (a/b) partition
> - *
> - * Which partition actually has U-Boot on it is determined based on the
> - * qcom_boot_source variable and additional logic in find_target_partition().
> + * Capsule update support with conditional FIT vs RAW implementation:
> + * - FIT capsules: Comprehensive partition discovery with dynamic fw_images
> + * - RAW capsules: Existing single-partition approach with static fw_images
>   */
> +
> +#ifdef CONFIG_EFI_CAPSULE_FIRMWARE_FIT
> +#define MAX_DFU_STRING_SIZE 2048
> +#define MAX_PARTITION_GROUPS 64
> +#define MAX_PARTITIONS_PER_LUN 64
> +#define MAX_PARTITIONS_TO_SCAN 128
> +#define MAX_LUN_GROUPS 16
> +
> +struct qcom_partition_info {
> +       char name[32];              /* "uefi_a", "boot_b", etc. */
> +       char base_name[32];         /* "uefi", "boot", etc. */
> +       char slot_suffix[4];        /* "_a", "_b", or "" */
> +       int lun;                    /* SCSI LUN number */
> +       int partition_num;          /* Partition number within LUN */
> +       bool is_active;             /* From GPT vendor attributes */
> +       bool is_bootable;           /* From GPT vendor attributes */
> +};
> +
> +struct partition_group {
> +       char base_name[32];
> +       struct qcom_partition_info *a_slot;
> +       struct qcom_partition_info *b_slot;
> +       struct qcom_partition_info *no_slot;
> +};
> +
> +struct lun_group {
> +       int lun_number;
> +       struct qcom_partition_info *partitions[MAX_PARTITIONS_PER_LUN];  /* Max partitions per LUN */
> +       int partition_count;
> +};
> +#endif /* CONFIG_EFI_CAPSULE_FIRMWARE_FIT */
> +
>  struct efi_fw_image fw_images[] = {
>         {
>                 .image_index = 1,
> @@ -39,18 +64,26 @@ struct efi_fw_image fw_images[] = {
>  };
>
>  struct efi_capsule_update_info update_info = {
> -       /* Filled in by configure_dfu_string() */
> +       /* Filled in by qcom_configure_capsule_updates() */
>         .dfu_string = NULL,
>         .num_images = ARRAY_SIZE(fw_images),
>         .images = fw_images,
>  };
>
> +#ifdef CONFIG_EFI_CAPSULE_FIRMWARE_RAW
>  enum target_part_type {
>         TARGET_PART_UEFI = 1,
>         TARGET_PART_XBL,
>         TARGET_PART_BOOT,
>  };
>
> +enum ab_slot {
> +       SLOT_NONE,
> +       SLOT_A,
> +       SLOT_B,
> +};
> +#endif /* CONFIG_EFI_CAPSULE_FIRMWARE_RAW */
> +
>  /* LSB first */
>  struct part_slot_status {
>         u16: 2;
> @@ -61,26 +94,6 @@ struct part_slot_status {
>         u16 tries_remaining : 4;
>  };
>
> -enum ab_slot {
> -       SLOT_NONE,
> -       SLOT_A,
> -       SLOT_B,
> -};
> -
> -static enum ab_slot get_part_slot(const char *partname)
> -{
> -       int len = strlen(partname);
> -
> -       if (partname[len - 2] != '_')
> -               return SLOT_NONE;
> -       if (partname[len - 1] == 'a')
> -               return SLOT_A;
> -       if (partname[len - 1] == 'b')
> -               return SLOT_B;
> -
> -       return SLOT_NONE;
> -}
> -
>  /* Shamelessly copied from lib/efi_loader/efi_device_path.c @ 33 */
>  /*
>   * Determine if an MMC device is an SD card.
> @@ -98,6 +111,25 @@ static bool is_sd(struct blk_desc *desc)
>         return IS_SD(mmc) != 0U;
>  }
>
> +#ifdef CONFIG_EFI_CAPSULE_FIRMWARE_RAW
> +/*
> + * RAW Capsule Support
> + */
> +
> +static enum ab_slot get_part_slot(const char *partname)
> +{
> +       int len = strlen(partname);
> +
> +       if (partname[len - 2] != '_')
> +               return SLOT_NONE;
> +       if (partname[len - 1] == 'a')
> +               return SLOT_A;
> +       if (partname[len - 1] == 'b')
> +               return SLOT_B;
> +
> +       return SLOT_NONE;
> +}
> +
>  /*
>   * Determine which partition U-Boot is flashed to based on the boot source (ABL/XBL),
>   * the slot status, and prioritizing the uefi partition over xbl if found.
> @@ -156,7 +188,7 @@ static int find_target_partition(int *devnum, enum uclass_id *uclass,
>                          * flags might not be set so we assume the A partition unless the B
>                          * partition is active.
>                          */
> -                       if (!strncmp(info.name, "uefi", strlen("uefi"))) {
> +                       if (!strncmp(info.name, "uefi_", strlen("uefi_"))) {
>                                 /*
>                                  * If U-Boot was chainloaded somehow we can't be flashed to
>                                  * the uefi partition
> @@ -263,7 +295,7 @@ static int find_target_partition(int *devnum, enum uclass_id *uclass,
>         }
>
>         /* Found no candidate partitions */
> -       return -1;
> +       return -ENOENT;
>
>  found:
>         if (desc) {
> @@ -278,18 +310,7 @@ found:
>         return partnum;
>  }
>
> -/**
> - * qcom_configure_capsule_updates() - Configure the DFU string for capsule updates
> - *
> - * U-Boot is flashed to the boot partition on Qualcomm boards. In most cases there
> - * are two boot partitions, boot_a and boot_b. As we don't currently support doing
> - * full A/B updates, we only support updating the currently active boot partition.
> - *
> - * So we need to find the current slot suffix and the associated boot partition.
> - * We do this by looking for the boot partition that has the 'active' flag set
> - * in the GPT partition vendor attribute bits.
> - */
> -void qcom_configure_capsule_updates(void)
> +static void configure_raw_capsule_updates(void)
>  {
>         int ret = 0, partnum = -1, devnum;
>         static char dfu_string[32] = { 0 };
> @@ -297,7 +318,6 @@ void qcom_configure_capsule_updates(void)
>         enum uclass_id dev_uclass;
>
>         if (IS_ENABLED(CONFIG_SCSI)) {
> -               /* Scan for SCSI devices */
>                 ret = scsi_scan(false);
>                 if (ret) {
>                         debug("Failed to scan SCSI devices: %d\n", ret);
> @@ -339,7 +359,625 @@ void qcom_configure_capsule_updates(void)
>                 debug("Unsupported storage uclass: %d\n", dev_uclass);
>                 return;
>         }
> -       log_debug("DFU string: '%s'\n", dfu_string);
>
> +       log_debug("RAW DFU string: '%s'\n", dfu_string);
> +
> +       /* Set RAW configuration state */
> +       update_info.dfu_string = dfu_string;
> +       update_info.images = fw_images;
> +       update_info.num_images = ARRAY_SIZE(fw_images);
> +
> +       log_info("RAW capsule update configured (single partition: %s)\n",
> +                target_part_type == TARGET_PART_UEFI ? "uefi" :
> +                target_part_type == TARGET_PART_XBL ? "xbl" : "boot");
> +}
> +#endif /* CONFIG_EFI_CAPSULE_FIRMWARE_RAW */
> +
> +#ifdef CONFIG_EFI_CAPSULE_FIRMWARE_FIT
> +/*
> + * FIT Capsule Support - Implementation
> + */
> +
> +static void parse_partition_name(const char *full_name, char *base_name, char *slot_suffix)
> +{
> +       char *underscore = strrchr(full_name, '_');
> +
> +       if (underscore && (strcmp(underscore, "_a") == 0 || strcmp(underscore, "_b") == 0)) {
> +               /* Has A/B suffix */
> +               size_t base_len = underscore - full_name;
> +
> +               strlcpy(base_name, full_name, base_len + 1);
> +               strcpy(slot_suffix, underscore);
> +       } else {
> +               /* No A/B suffix */
> +               strcpy(base_name, full_name);
> +               slot_suffix[0] = '\0';
> +       }
> +}
> +
> +static void parse_partition_info(struct qcom_partition_info *part,
> +                                struct disk_partition *info,
> +                                int lun, int partnum)
> +{
> +       struct part_slot_status *slot_status;
> +
> +       strlcpy(part->name, info->name, sizeof(part->name));
> +       part->lun = lun;
> +       part->partition_num = partnum;
> +
> +       /* Parse slot status from GPT vendor attributes */
> +       slot_status = (struct part_slot_status *)&info->type_flags;
> +       part->is_active = slot_status->active;
> +       part->is_bootable = !slot_status->unbootable;
> +
> +       /* Extract base name and slot suffix */
> +       parse_partition_name(part->name, part->base_name, part->slot_suffix);
> +}
> +
> +static struct partition_group *find_or_create_group(struct partition_group *groups,
> +                                                   int *group_count,
> +                                                   const char *base_name)
> +{
> +       /* Find existing group */
> +       for (int i = 0; i < *group_count; i++) {
> +               if (strcmp(groups[i].base_name, base_name) == 0)
> +                       return &groups[i];
> +       }
> +
> +       /* Create new group */
> +       if (*group_count >= MAX_PARTITION_GROUPS) {
> +               log_err("Too many partition groups\n");
> +               return NULL;
> +       }
> +
> +       struct partition_group *new_group = &groups[*group_count];
> +
> +       strcpy(new_group->base_name, base_name);
> +       new_group->a_slot = NULL;
> +       new_group->b_slot = NULL;
> +       new_group->no_slot = NULL;
> +
> +       (*group_count)++;
> +       return new_group;
> +}
> +
> +static struct qcom_partition_info *select_ab_target(struct qcom_partition_info *a_slot,
> +                                                   struct qcom_partition_info *b_slot)
> +{
> +       /* Priority: Active slot > A slot (fallback) */
> +
> +       if (a_slot && a_slot->is_active) {
> +               log_debug("Selected %s (active)\n", a_slot->name);
> +               return a_slot;
> +       }
> +       if (b_slot && b_slot->is_active) {
> +               log_debug("Selected %s (active)\n", b_slot->name);
> +               return b_slot;
> +       }
> +
> +       /* Both inactive - prefer A slot as fallback */
> +       struct qcom_partition_info *fallback = a_slot ? a_slot : b_slot;
> +
> +       if (fallback)
> +               log_debug("Selected %s (fallback - both inactive)\n", fallback->name);
> +       return fallback;
> +}
> +
> +static int discover_all_partitions(struct qcom_partition_info **all_parts, int *all_count)
> +{
> +       struct udevice *dev;
> +       struct blk_desc *desc;
> +       struct qcom_partition_info *partition_list;
> +       int partition_count = 0;
> +       int max_partitions = 256;
> +       bool have_ufs = false;
> +
> +       /* Allocate partition list */
> +       partition_list = calloc(max_partitions, sizeof(struct qcom_partition_info));
> +       if (!partition_list) {
> +               log_err("Failed to allocate partition list\n");
> +               return -ENOMEM;
> +       }
> +
> +       if (IS_ENABLED(CONFIG_SCSI)) {
> +               if (scsi_scan(false)) {
> +                       log_debug("Failed to scan SCSI devices\n");
> +                       free(partition_list);
> +                       return -EIO;
> +               }
> +       }
> +
> +       /*
> +        * Check to see if we have UFS storage, if so firmware MUST be on it and we can skip
> +        * all non-UFS block devices
> +        */
> +       uclass_foreach_dev_probe(UCLASS_UFS, dev) {
> +               have_ufs = true;
> +               break;
> +       }
> +
> +       /* Discover partitions with UFS-priority logic */
> +       uclass_foreach_dev_probe(UCLASS_BLK, dev) {
> +               if (device_get_uclass_id(dev) != UCLASS_BLK)
> +                       continue;
> +
> +               desc = dev_get_uclass_plat(dev);
> +               if (!desc)
> +                       continue;
> +
> +               if (have_ufs) {
> +                       if (device_get_uclass_id(dev->parent->parent) != UCLASS_UFS)
> +                               continue;
> +               } else {
> +                       /* If we don't have UFS, look at eMMC (but skip SD cards) */
> +                       if (desc->uclass_id == UCLASS_MMC) {
> +                               if (IS_ENABLED(CONFIG_MMC) && is_sd(desc)) {
> +                                       log_debug("Skipped SD-Card (devnum %d)\n", desc->devnum);
> +                                       continue;
> +                               }
> +                       } else if (desc->uclass_id != UCLASS_SCSI) {
> +                               /* Not MMC and not SCSI, skip it */
> +                               continue;
> +                       }
> +               }
> +
> +               int lun = desc->devnum;
> +
> +               /* Scan all partitions on this device */
> +               for (int partnum = 1; partnum <= MAX_PARTITIONS_TO_SCAN; partnum++) {
> +                       struct disk_partition info;
> +
> +                       if (part_get_info(desc, partnum, &info) != 0)
> +                               break;
> +
> +                       if (partition_count >= max_partitions) {
> +                               log_warning("Too many partitions discovered, truncating at %d\n",
> +                                           max_partitions);
> +                               break;
> +                       }
> +
> +                       /* Parse and store partition info */
> +                       parse_partition_info(&partition_list[partition_count], &info, lun, partnum);
> +                       partition_count++;
> +               }
> +       }
> +
> +       *all_parts = partition_list;
> +       *all_count = partition_count;
> +
> +       log_debug("Discovered %d partitions across all %s devices\n",
> +                 partition_count, have_ufs ? "UFS" : "eMMC");
> +       return 0;
> +}
> +
> +static int select_target_partitions(struct qcom_partition_info *all_parts, int all_count,
> +                                   struct qcom_partition_info **selected_parts,
> +                                   int *selected_count)
> +{
> +       struct partition_group groups[MAX_PARTITION_GROUPS];
> +       struct qcom_partition_info *target_list;
> +       int group_count = 0;
> +       int target_count = 0;
> +
> +       memset(groups, 0, sizeof(groups));
> +
> +       /* Allocate target list */
> +       target_list = calloc(all_count, sizeof(struct qcom_partition_info));
> +       if (!target_list) {
> +               log_err("Failed to allocate target partition list\n");
> +               return -ENOMEM;
> +       }
> +
> +       /* Group partitions by base name */
> +       for (int i = 0; i < all_count; i++) {
> +               struct qcom_partition_info *part = &all_parts[i];
> +               struct partition_group *group = find_or_create_group(groups, &group_count,
> +                                                                    part->base_name);
> +
> +               if (!group) {
> +                       log_err("Failed to create group for %s\n", part->base_name);
> +                       continue;
> +               }
> +
> +               if (strcmp(part->slot_suffix, "_a") == 0) {
> +                       if (!group->a_slot) {
> +                               group->a_slot = part;
> +                       } else {
> +                               log_info("Duplicate A-slot partition detected\n");
> +                               log_info("  Keeping: %s (LUN %d, partition %d) [first discovered]\n",
> +                                        group->a_slot->name, group->a_slot->lun,
> +                                        group->a_slot->partition_num);
> +                               log_info("  Ignoring: %s (LUN %d, partition %d) [duplicate]\n",
> +                                        part->name, part->lun, part->partition_num);
> +                       }
> +               } else if (strcmp(part->slot_suffix, "_b") == 0) {
> +                       if (!group->b_slot) {
> +                               group->b_slot = part;
> +                       } else {
> +                               log_info("Duplicate B-slot partition detected\n");
> +                               log_info("  Keeping: %s (LUN %d, partition %d) [first discovered]\n",
> +                                        group->b_slot->name, group->b_slot->lun,
> +                                        group->b_slot->partition_num);
> +                               log_info("  Ignoring: %s (LUN %d, partition %d) [duplicate]\n",
> +                                        part->name, part->lun, part->partition_num);
> +                       }
> +               } else {
> +                       if (!group->no_slot) {
> +                               group->no_slot = part;
> +                       } else {
> +                               log_info("Duplicate non-A/B partition detected\n");
> +                               log_info("  Keeping: %s (LUN %d, partition %d) [first discovered]\n",
> +                                        group->no_slot->name, group->no_slot->lun,
> +                                        group->no_slot->partition_num);
> +                               log_info("  Ignoring: %s (LUN %d, partition %d) [duplicate]\n",
> +                                        part->name, part->lun, part->partition_num);
> +                       }
> +               }
> +       }
> +
> +       log_debug("Created %d partition groups for selection\n", group_count);
> +
> +       /* Select target partition for each group */
> +       for (int i = 0; i < group_count; i++) {
> +               struct partition_group *group = &groups[i];
> +               struct qcom_partition_info *target = NULL;
> +
> +               if (group->no_slot) {
> +                       /* Non-A/B partition */
> +                       target = group->no_slot;
> +                       log_debug("Group %s: selected non-A/B partition %s\n",
> +                                 group->base_name, target->name);
> +               } else {
> +                       /* A/B partition - apply selection logic */
> +                       target = select_ab_target(group->a_slot, group->b_slot);
> +                       if (target) {
> +                               log_debug("Group %s: selected %s from A/B pair\n",
> +                                         group->base_name, target->name);
> +                       }
> +               }
> +
> +               if (target) {
> +                       /* Copy selected partition to target list */
> +                       memcpy(&target_list[target_count], target,
> +                              sizeof(struct qcom_partition_info));
> +                       target_count++;
> +               } else {
> +                       log_info("No target selected for group %s\n", group->base_name);
> +               }
> +       }
> +
> +       *selected_parts = target_list;
> +       *selected_count = target_count;
> +
> +       log_debug("Selected %d target partitions from %d discovered\n", target_count, all_count);
> +       return 0;
> +}
> +
> +static int group_partitions_by_lun(struct qcom_partition_info *selected_parts, int selected_count,
> +                                  struct lun_group **lun_groups, int *group_count)
> +{
> +       struct lun_group *groups;
> +       int max_groups = MAX_LUN_GROUPS;
> +       int current_groups = 0;
> +
> +       /* Allocate LUN groups array */
> +       groups = calloc(max_groups, sizeof(struct lun_group));
> +       if (!groups) {
> +               log_err("Failed to allocate LUN groups array\n");
> +               return -ENOMEM;
> +       }
> +
> +       /* Group partitions by LUN */
> +       for (int i = 0; i < selected_count; i++) {
> +               struct qcom_partition_info *part = &selected_parts[i];
> +               struct lun_group *target_group = NULL;
> +
> +               /* Find existing group for this LUN */
> +               for (int j = 0; j < current_groups; j++) {
> +                       if (groups[j].lun_number == part->lun) {
> +                               target_group = &groups[j];
> +                               break;
> +                       }
> +               }
> +
> +               /* Create new group if not found */
> +               if (!target_group) {
> +                       if (current_groups >= max_groups) {
> +                               log_err("Too many LUN groups (max %d)\n", max_groups);
> +                               free(groups);
> +                               return -ENOSPC;
> +                       }
> +
> +                       target_group = &groups[current_groups];
> +                       target_group->lun_number = part->lun;
> +                       target_group->partition_count = 0;
> +                       current_groups++;
> +               }
> +
> +               /* Add partition to group */
> +               if (target_group->partition_count >= 64) {
> +                       log_err("Too many partitions in LUN %d (max 64)\n", part->lun);
> +                       free(groups);
> +                       return -ENOSPC;
> +               }
> +
> +               target_group->partitions[target_group->partition_count] = part;
> +               target_group->partition_count++;
> +       }
> +
> +               /* Sort groups by LUN number for consistent output */
> +               for (int i = 0; i < current_groups - 1; i++) {
> +                       for (int j = i + 1; j < current_groups; j++) {
> +                               if (groups[i].lun_number > groups[j].lun_number) {
> +                                       struct lun_group temp = groups[i];
> +
> +                                       groups[i] = groups[j];
> +                                       groups[j] = temp;
> +                               }
> +                       }
> +               }
> +
> +       *lun_groups = groups;
> +       *group_count = current_groups;
> +
> +       log_debug("Grouped %d partitions into %d LUN groups\n", selected_count, current_groups);
> +       return 0;
> +}
> +
> +static int generate_dfu_string(struct qcom_partition_info *selected_parts, int selected_count,
> +                              char *dfu_string, size_t buffer_size)
> +{
> +       struct lun_group *lun_groups = NULL;
> +       struct udevice *dev;
> +       struct blk_desc *desc;
> +       int group_count = 0;
> +       char *dfu_ptr = dfu_string;
> +       int remaining = buffer_size;
> +       int ret;
> +       bool is_mmc = false;
> +
> +       /* Clear the buffer */
> +       memset(dfu_string, 0, buffer_size);
> +
> +       /* Determine storage type by checking the first partition's device */
> +       if (selected_count > 0) {
> +               uclass_foreach_dev_probe(UCLASS_BLK, dev) {
> +                       if (device_get_uclass_id(dev) != UCLASS_BLK)
> +                               continue;
> +
> +                       desc = dev_get_uclass_plat(dev);
> +                       if (!desc)
> +                               continue;
> +
> +                       if (desc->devnum == selected_parts[0].lun) {
> +                               if (desc->uclass_id == UCLASS_MMC) {
> +                                       is_mmc = true;
> +                                       log_debug("Detected MMC/eMMC storage for DFU string generation\n");
> +                               } else if (desc->uclass_id == UCLASS_SCSI) {
> +                                       is_mmc = false;
> +                                       log_debug("Detected SCSI/UFS storage for DFU string generation\n");
> +                               }
> +                               break;
> +                       }
> +               }
> +       }
> +
> +       /* Group partitions by LUN/device */
> +       ret = group_partitions_by_lun(selected_parts, selected_count, &lun_groups, &group_count);
> +       if (ret != 0) {
> +               log_err("Failed to group partitions by LUN: %d\n", ret);
> +               return ret;
> +       }
> +
> +       /* Generate DFU string with appropriate format for storage type */
> +       for (int i = 0; i < group_count; i++) {
> +               struct lun_group *group = &lun_groups[i];
> +               int written;
> +
> +               /* Add device group separator for non-first groups */
> +               if (i > 0) {
> +                       written = snprintf(dfu_ptr, remaining, "&");
> +                       dfu_ptr += written;
> +                       remaining -= written;
> +               }
> +
> +               if (is_mmc) {
> +                       /* MMC format: "mmc X=" */
> +                       written = snprintf(dfu_ptr, remaining, "mmc %d=", group->lun_number);
> +               } else {
> +                       /* SCSI format: "scsi X=" */
> +                       written = snprintf(dfu_ptr, remaining, "scsi %d=", group->lun_number);
> +               }
> +               dfu_ptr += written;
> +               remaining -= written;
> +
> +               /* Add partitions within this device group */
> +               for (int j = 0; j < group->partition_count; j++) {
> +                       struct qcom_partition_info *part = group->partitions[j];
> +
> +                       /* Add partition separator for non-first partitions in group */
> +                       if (j > 0) {
> +                               written = snprintf(dfu_ptr, remaining, ";");
> +                               dfu_ptr += written;
> +                               remaining -= written;
> +                       }
> +
> +                       if (is_mmc) {
> +                               /* MMC format: "partition_name part dev_num partition_num" */
> +                               written = snprintf(dfu_ptr, remaining, "%s part %d %d",
> +                                                  part->name, group->lun_number, part->partition_num);
> +                       } else {
> +                               /* SCSI format: "partition_name part partition_num" */
> +                               written = snprintf(dfu_ptr, remaining, "%s part %d",
> +                                                  part->name, part->partition_num);
> +                       }
> +                       dfu_ptr += written;
> +                       remaining -= written;
> +
> +                       if (remaining <= 10) {
> +                               log_err("DFU string buffer overflow at partition %s\n", part->name);
> +                               free(lun_groups);
> +                               return -ENOSPC;
> +                       }
> +               }
> +       }
> +
> +       /* Clean up */
> +       free(lun_groups);
> +
> +       log_debug("Generated %s DFU string (%zu chars): %s\n",
> +                 is_mmc ? "MMC" : "SCSI", strlen(dfu_string), dfu_string);
> +       return 0;
> +}
> +
> +/**
> + * get_board_fit_capsule_guid - Get board-specific FIT capsule GUID
> + *
> + * Detect the board type from device tree and return the appropriate GUID
> + * for FIT capsule updates.
> + *
> + * @guid: Pointer to store the GUID
> + * Return: 0 on success, negative error code on failure
> + */
> +static int get_board_fit_capsule_guid(efi_guid_t *guid)
> +{
> +       const char *compatible;
> +
> +       if (!guid)
> +               return -EINVAL;
> +
> +       compatible = ofnode_read_string(ofnode_root(), "compatible");
> +       if (!compatible) {
> +               log_err("Failed to read board compatible string\n");
> +               return -ENODEV;
> +       }
> +
> +       /* Check for QCS615 or Talos */
> +       if (strstr(compatible, "qcs615") || strstr(compatible, "talos")) {
> +               log_debug("Detected QCS615/Talos board\n");
> +               *guid = (efi_guid_t)QCOM_QCS615_FIT_CAPSULE_GUID;
> +               return 0;
> +       }
> +
> +       /* Check for QCS6490 */
> +       if (strstr(compatible, "qcs6490")) {
> +               log_debug("Detected QCS6490 board\n");
> +               *guid = (efi_guid_t)QCOM_QCS6490_FIT_CAPSULE_GUID;
> +               return 0;
> +       }
> +
> +       /* Check for Lemans */
> +       if (strstr(compatible, "lemans") || strstr(compatible, "qcs9100")) {
> +               log_debug("Detected Lemans board\n");
> +               *guid = (efi_guid_t)QCOM_LEMANS_FIT_CAPSULE_GUID;
> +               return 0;
> +       }
> +
> +       log_err("Unsupported board for capsule updates: %s\n", compatible);
> +       return -EINVAL;
> +}
> +
> +/*
> + * For creating FIT-based capsule images from FvUpdate.xml files, see:
> + *   - Tool: tools/fvupdate_to_fit.py
> + *   - Documentation: doc/develop/fvupdate_to_fit.rst
> + */
> +static void configure_fit_capsule_updates(void)
> +{
> +       struct qcom_partition_info *all_partitions = NULL;
> +       struct qcom_partition_info *selected_partitions = NULL;
> +       int all_count = 0, selected_count = 0;
> +       static char dfu_string[MAX_DFU_STRING_SIZE] = { 0 };
> +       static struct efi_fw_image single_fw_image;
> +       efi_guid_t board_guid;
> +       int ret;
> +
> +       /* Step 1: Discover all partitions across all SCSI LUNs */
> +       ret = discover_all_partitions(&all_partitions, &all_count);
> +       if (ret != 0) {
> +               log_err("Failed to discover SCSI partitions: %d\n", ret);
> +               return;
> +       }
> +
> +       if (all_count == 0) {
> +               log_warning("No SCSI partitions discovered\n");
> +               goto cleanup;
> +       }
> +
> +       /* Step 2: Apply A/B selection logic to choose target partitions */
> +       ret = select_target_partitions(all_partitions, all_count,
> +                                      &selected_partitions, &selected_count);
> +       if (ret != 0) {
> +               log_err("Failed to select target partitions: %d\n", ret);
> +               goto cleanup;
> +       }
> +
> +       if (selected_count == 0) {
> +               log_warning("No target partitions selected\n");
> +               goto cleanup;
> +       }
> +
> +       /* Step 3: Generate DFU string from selected partitions */
> +       ret = generate_dfu_string(selected_partitions, selected_count,
> +                                 dfu_string, sizeof(dfu_string));
> +       if (ret != 0) {
> +               log_err("Failed to generate DFU string: %d\n", ret);
> +               goto cleanup;
> +       }
> +
> +       /* Step 4: Get board-specific GUID */
> +       ret = get_board_fit_capsule_guid(&board_guid);
> +       if (ret != 0) {
> +               log_err("Failed to get board-specific GUID: %d\n", ret);
> +               goto cleanup;
> +       }
> +
> +       /* Step 5: Create SINGLE fw_image entry for ESRT */
> +       memset(&single_fw_image, 0, sizeof(single_fw_image));
> +       single_fw_image.fw_name = QCOM_FIT_CAPSULE_NAME;  /* Same name for all boards */
> +       single_fw_image.image_index = 1;
> +       single_fw_image.image_type_id = board_guid;
> +
> +       /* Step 6: Configure update_info */
>         update_info.dfu_string = dfu_string;
> +       update_info.images = &single_fw_image;
> +       update_info.num_images = 1;
> +
> +       log_info("FIT capsule configured successfully:\n");
> +       log_info("  Name: %ls\n", QCOM_FIT_CAPSULE_NAME);
> +       log_info("  GUID: %pUl\n", &board_guid);
> +       log_info("  Partitions in DFU string: %d\n", selected_count);
> +       log_info("  ESRT entries: 1 (single entry for all partitions)\n");
> +
> +cleanup:
> +       free(all_partitions);
> +       free(selected_partitions);
> +}
> +#endif /* CONFIG_EFI_CAPSULE_FIRMWARE_FIT */
> +
> +/**
> + * qcom_configure_capsule_updates() - Configure capsule updates
> + *
> + * Configures either FIT or RAW capsule updates based on compile-time configuration.
> + */
> +void qcom_configure_capsule_updates(void)
> +{
> +#if defined(CONFIG_EFI_CAPSULE_FIRMWARE_FIT)
> +       log_info("Configuring FIT capsule updates\n");
> +       configure_fit_capsule_updates();
> +#elif defined(CONFIG_EFI_CAPSULE_FIRMWARE_RAW)
> +       log_info("Configuring RAW capsule updates\n");
> +       configure_raw_capsule_updates();
> +#else
> +       log_warning("No capsule firmware configuration enabled\n");
> +#endif
> +
> +       /* Final state logging */
> +       if (update_info.dfu_string) {
> +               log_info("Capsule update configured successfully with %d image(s)\n",
> +                        update_info.num_images);
> +       } else {
> +               log_warning("Capsule update configuration failed\n");
> +       }
>  }
> +
> diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
> index b8bf574e8bb..d664c22ae96 100644
> --- a/arch/arm/mach-snapdragon/qcom-priv.h
> +++ b/arch/arm/mach-snapdragon/qcom-priv.h
> @@ -18,6 +18,29 @@ enum qcom_boot_source {
>  extern enum qcom_boot_source qcom_boot_source;
>
>  #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
> +/*
> + * Capsule Update GUIDs for FIT capsules
> + * Each board has a unique GUID to prevent cross-board flashing
> + */
> +
> +/* QCS615 FIT Capsule GUID: 9fd379d2-670e-4bb3-86a1-40497e6e17b0 */
> +#define QCOM_QCS615_FIT_CAPSULE_GUID \
> +       EFI_GUID(0x9fd379d2, 0x670e, 0x4bb3, 0x86, 0xa1, \
> +                0x40, 0x49, 0x7e, 0x6e, 0x17, 0xb0)
> +
> +/* QCS6490 FIT Capsule GUID: 6f25bfd2-a165-468b-980f-ac51a0a45c52 */
> +#define QCOM_QCS6490_FIT_CAPSULE_GUID \
> +       EFI_GUID(0x6f25bfd2, 0xa165, 0x468b, 0x98, 0x0f, \
> +                0xac, 0x51, 0xa0, 0xa4, 0x5c, 0x52)
> +
> +/* Lemans FIT Capsule GUID: 78462415-6133-431c-9fae-48f2bafd5c71 */
> +#define QCOM_LEMANS_FIT_CAPSULE_GUID \
> +       EFI_GUID(0x78462415, 0x6133, 0x431c, 0x9f, 0xae, \
> +                0x48, 0xf2, 0xba, 0xfd, 0x5c, 0x71)
> +
> +/* Common name for FIT capsule (same for all boards) */
> +#define QCOM_FIT_CAPSULE_NAME u"QCOM_FIT_CAPSULE"
> +
>  void qcom_configure_capsule_updates(void);
>  #else
>  void qcom_configure_capsule_updates(void) {}
>
> --
> 2.34.1
>
