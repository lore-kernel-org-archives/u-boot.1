Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53DD9C02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 13:01:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 904E88022B;
	Thu, 16 Jan 2025 14:01:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gLaih0am";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C29380283; Thu, 16 Jan 2025 14:01:37 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A19FC801B0
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 14:01:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e4930eca0d4so1361801276.3
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 05:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737032493; x=1737637293; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5tNfREidDWMhMHxrhZkb+bO2+eQyAk+xR0gXVQt9ksk=;
 b=gLaih0am1RifdkXO1LKFWriOlNmLseLPDJrZv/pY+vqyVA3YEVCr89u0UFYTJ7fLOJ
 TR7Wtu5/U99A+QKItUw9KlQPi2LH98tbhhnPpHXX8E96xj48I1M5ph1VhupTT01weNTi
 7gBXbCq8Nt48UzOP9M/ZIPmha1duTip58zOH16dmkmJqhv+wRivlAZswy/RytNKyIVaw
 YlD6vJFPYDdCv2jKwhKwhg8876X3G+Cvi4ircHaTnYSBF7acfl7Bwpj4pagN+e4zypsa
 H+BmFPdQZUj/IbjlMQouEkljgUtQo/VEYN5hCicPfeaiegzswicdoODHU2uEyq0pBF+C
 +ZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737032493; x=1737637293;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5tNfREidDWMhMHxrhZkb+bO2+eQyAk+xR0gXVQt9ksk=;
 b=HV1TWCbO5OYKg2DCPLd3wh0PZQAWyDhlRcArpOBPiMUzVjF0nGs3UHtAVc36Wwo61c
 iUdKuRL4q1yiwwa4t0Z5zyA9IWKq5doihawrP+4hhShQYyP/xhRDHGzCIqJA3lv1og1o
 O9lKfwZ6gN4ML0NwZYR6Fum3r5XdRuSja1OpAHsjBT6H8+72E8xuRYwHdySU2iLB+nU2
 EEdXcsroW2nWjBF0wnSf1d6XQkupFR64EDvJ4YKBdgDFZ0WWTAH/kJMRmXN9OYH5IAvq
 V8yQx83StNYzgkoT22ibMMDJB6FQubloCbEQLFtKPEcgFWRSXBp/y2mbFjY5LI/37hEj
 Og3A==
X-Gm-Message-State: AOJu0YzRIfsv8sXzMWS0KwvfTMLM+WTPsy88kOHiE7Rw6LXkH3cf1zz1
 YgrJho3ilXnUWbxjqmeudsS/Vt1e6Qy2uksqicibobhOLaAMiqSL1cbvZfw3S5aqRcBJDexig8d
 3KzaJHx/bhnxgzYmmtb5ZFjsBouARLj42Hrg1lw==
X-Gm-Gg: ASbGnctlNA26toWOGBvuqlOSyv5vbgr5r/wpsbuEOfDhZbaJ+YamRIKTO70DSMAzeND
 gHw4YiaK3Ml/EFBAbcVn0qYBcufQYxkWZIdBGLA==
X-Google-Smtp-Source: AGHT+IEKNFIngW4Lwcl8X7U3YZIw+Hk0OPYr8KoMmhm6GEtA1FUSYYSDmlQ5aLGIrY0XKb3GnA4qM/fPkitl+27+oC8=
X-Received: by 2002:a05:690c:6185:b0:6dc:7877:1ea3 with SMTP id
 00721157ae682-6f53124c672mr251242887b3.17.1737032493272; Thu, 16 Jan 2025
 05:01:33 -0800 (PST)
MIME-Version: 1.0
References: <20250115200144.951530-1-raymond.mao@linaro.org>
 <20250115200144.951530-4-raymond.mao@linaro.org>
In-Reply-To: <20250115200144.951530-4-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 16 Jan 2025 15:00:57 +0200
X-Gm-Features: AbW1kvZ0b581ASpuRsSf0cAEAUaEHPPoyRLRIgP0M3Fu8hlmupZCbrDn_Vma7eI
Message-ID: <CAC_iWjLFUPCCopHrgrRLq7Z6oT=rV+PWjaVurzRWkuoRCR6Okw@mail.gmail.com>
Subject: Re: [PATCH 3/6] tpm: add wrapper and helper APIs for PCR allocate
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Tim Harvey <tharvey@gateworks.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Michal Simek <michal.simek@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
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

On Wed, 15 Jan 2025 at 22:02, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Add PCR allocate wrapper APIs for using in tcg2 protocol.
> The wrapper proceeds a PCR allocate command, followed by a
> shutdown command.

We have lib/tpm_tcg2.c does any of the functions belong to that file?
Unless we expect the non-TCG version to do something similar....

> A system boot is required after two commands since TPM device needs
> a HW reset to activate the new algorithms config.
> Also, a helper function is included to determine the new bank mask
> for PCR allocation by combining the status of current active,
> supported and eventlog bank masks.
> A new kconfig is created. PCR allocate and system reboot only
> happens when the kconfig is selected, otherwise just exit with
> errors.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  include/tpm-v2.h |  20 ++++++++
>  lib/Kconfig      |  12 +++++
>  lib/tpm-v2.c     | 121 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 153 insertions(+)
>
> diff --git a/include/tpm-v2.h b/include/tpm-v2.h
> index af3158f6e4..79dc4a34e2 100644
> --- a/include/tpm-v2.h
> +++ b/include/tpm-v2.h
> @@ -703,6 +703,17 @@ u32 tpm2_report_state(struct udevice *dev, uint vendor_cmd, uint vendor_subcmd,
>  u32 tpm2_enable_nvcommits(struct udevice *dev, uint vendor_cmd,
>                           uint vendor_subcmd);
>
> +/**
> + * tpm2_pcr_allocate_get_mask - Get algorithm bitmask for PCR allocate

Naming nit. This is comparing the EventLog, U-Boot supported, and
active algorithms. Can we rename it to tpm2_scan_masks() or something
similar and update the description with that?

> + *
> + * @dev                TPM device
> + * @log_active Active algorithm bitmask
> + * @mask       Bitmask for PCR allocate
> + *
> + * Return: zero on success, negative errno otherwise
> + */
> +int tpm2_pcr_allocate_get_mask(struct udevice *dev, u32 log_active, u32 *mask);
> +
>  /**
>   * tpm2_pcr_config_algo() - Allocate the active PCRs. Requires reboot
>   *
> @@ -730,6 +741,15 @@ u32 tpm2_pcr_config_algo(struct udevice *dev, u32 algo_mask,
>  u32 tpm2_send_pcr_allocate(struct udevice *dev, const char *pw,
>                            const ssize_t pw_sz, struct tpml_pcr_selection *pcr,
>                            u32 pcr_len);
> +/**
> + * tpm2_pcr_allocate() - Allocate the PCRs
> + *
> + * @param dev   TPM device
> + * @log_active Bitmask of eventlog algorithms
> + *
> + * Return: code of the operation
> + */
> +int tpm2_pcr_allocate(struct udevice *dev, u32 log_active);
>
>  /**
>   * tpm2_auto_start() - start up the TPM and perform selftests.
> diff --git a/lib/Kconfig b/lib/Kconfig
> index baeb615626..0732333849 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -514,6 +514,18 @@ config VPL_TPM
>           for the low-level TPM interface, but only one TPM is supported at
>           a time by the TPM library.
>
> +config TPM_PCR_ALLOCATE
> +       bool "Re-configurate TPM algorithms in run-time (PCR allocate)"
> +       depends on TPM_V2 && (MEASURED_BOOT || EFI_TCG2_PROTOCOL)
> +       help
> +         This enables a detection for the dismatches of algorithms among TPM
> +         device, eventlog from previous boot stage and U-Boot support.
> +         A PCR allocate command will be sent to reconfigurate the TPM device
> +         in run-time to make sure algorithms in TPM device, eventlog and
> +         U-Boot are aligned with each other.
> +         A system reboot will be proceeded after then to activate the new
> +         algorithms.
> +
>  endmenu
>
>  menu "Android Verified Boot"
> diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> index 045b5dd9eb..71abf070de 100644
> --- a/lib/tpm-v2.c
> +++ b/lib/tpm-v2.c
> @@ -44,6 +44,127 @@ static int tpm2_update_active_banks(struct udevice *dev)
>         return 0;
>  }
>
> +static void tpm2_print_selected_algorithm_name(u32 selected)
> +{
> +       size_t i;
> +       const char *str;
> +
> +       for (i = 0; i < ARRAY_SIZE(hash_algo_list); i++) {
> +               const struct digest_info *algo = &hash_algo_list[i];
> +
> +               if (!(selected & algo->hash_mask))
> +                       continue;
> +
> +               str = tpm2_algorithm_name(algo->hash_alg);
> +               if (str)
> +                       log_info("%s\n", str);
> +       }
> +}
> +
> +int tpm2_pcr_allocate_get_mask(struct udevice *dev, u32 log_active, u32 *mask)
> +{
> +       struct tpml_pcr_selection pcrs;
> +       u32 active = 0;
> +       u32 supported = 0;
> +       int rc, i;
> +
> +       *mask = 0;
> +
> +       rc = tpm2_get_pcr_info(dev, &pcrs);
> +       if (rc)
> +               return rc;
> +
> +       for (i = 0; i < pcrs.count; i++) {
> +               struct tpms_pcr_selection *sel = &pcrs.selection[i];
> +               size_t j;
> +               u32 hash_mask = 0;
> +
> +               for (j = 0; j < ARRAY_SIZE(hash_algo_list); j++) {
> +                       if (hash_algo_list[j].hash_alg == sel->hash)
> +                               hash_mask = hash_algo_list[j].hash_mask;
> +               }
> +
> +               if (tpm2_algorithm_supported(sel->hash))
> +                       supported |= hash_mask;
> +
> +               if (tpm2_is_active_bank(sel))
> +                       active |= hash_mask;

We duplicate this in the tcg functions for getting active pcr banks,
but I can live with it now and refactor it later.

> +       }
> +
> +       /* All eventlog algorithm(s) must be supported */
> +       if (log_active & ~supported) {
> +               log_err("EventLog contains U-Boot unsupported algorithm(s)\n");
> +               tpm2_print_selected_algorithm_name(log_active & ~supported);
> +               rc = -1;
> +       }
> +       if (log_active && active & ~log_active) {
> +               log_warning("TPM active algorithm(s) not exist in eventlog\n");
> +               tpm2_print_selected_algorithm_name(active & ~log_active);
> +               *mask = log_active;
> +       }
> +
> +       /* Any active algorithm(s) which are not supported must be removed */
> +       if (active & ~supported) {
> +               log_warning("TPM active algorithm(s) unsupported by u-boot\n");
> +               tpm2_print_selected_algorithm_name(active & ~supported);
> +               if (*mask)

if (rc) is clearer here I think

> +                       *mask = active & supported & *mask;
> +               else
> +                       *mask = active & supported;
> +       }
> +
> +       return rc;
> +}
> +
> +static int tpm2_proceed_pcr_allocate(struct udevice *dev, u32 algo_mask)

Naming this tpm2_pcr_allocate() is better

> +{
> +       struct tpml_pcr_selection pcr = { 0 };
> +       u32 pcr_len = 0;
> +       int rc;
> +
> +       rc = tpm2_get_pcr_info(dev, &pcr);
> +       if (rc)
> +               return rc;
> +
> +       rc = tpm2_pcr_config_algo(dev, algo_mask, &pcr, &pcr_len);
> +       if (rc)
> +               return rc;
> +
> +       /* Assume no password */
> +       rc = tpm2_send_pcr_allocate(dev, NULL, 0, &pcr, pcr_len);
> +       if (rc)
> +               return rc;
> +
> +       /* Send TPM2_Shutdown, assume mode = TPM2_SU_CLEAR */
> +       return tpm2_startup(dev, false, TPM2_SU_CLEAR);
> +}
> +
> +int tpm2_pcr_allocate(struct udevice *dev, u32 log_active)

This assumes there's a log involved. So let's find a better name and
keep the current one for the function above.

> +{
> +       u32 algo_mask = 0;
> +       int rc;
> +
> +       rc = tpm2_pcr_allocate_get_mask(dev, log_active, &algo_mask);
> +       if (rc)
> +               return rc;
> +
> +       if (algo_mask) {
> +               if (!IS_ENABLED(CONFIG_TPM_PCR_ALLOCATE))
> +                       return -1;
> +
> +               rc = tpm2_proceed_pcr_allocate(dev, algo_mask);
> +               if (rc)
> +                       return rc;
> +
> +               log_info("PCR allocate done, shutdown TPM and reboot\n");
> +               do_reset(NULL, 0, 0, NULL);
> +               log_err("reset does not work!\n");
> +               return -1;
> +       }
> +
> +       return 0;
> +}
> +
>  u32 tpm2_startup(struct udevice *dev, bool bon, enum tpm2_startup_types mode)
>  {
>         int op = bon ? TPM2_CC_STARTUP : TPM2_CC_SHUTDOWN;
> --
> 2.25.1
>

Thanks
/Ilias
