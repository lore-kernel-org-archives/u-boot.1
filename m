Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46CE2C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 06:31:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B53EF80243;
	Thu, 23 Jan 2025 07:31:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yyhwqp0m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF46680275; Thu, 23 Jan 2025 07:31:52 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55AB480214
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 07:31:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e39779a268bso940880276.1
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 22:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737613909; x=1738218709; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QZU+ynMaE0Xe8D1GUqX+dHhvOwOdIR84EGAMYXLcQ+E=;
 b=yyhwqp0mbIE/S0HtZS//I53j18qVZwRv85D4JzFxtoeHwhqQHoOCGJ3TPNqda2uwcv
 i1sE0QkaCbLdyGkkGo48NAXcdVq+z1ocpHZ3WMGB+Tui5qAM8yr895SIIHIhROY8eMpf
 I+oViZWzWXMdyuv5QkcM4UvJohPvHcQ/PYfcpBlytW0UCNdyw1ISumGmLr+BUWFtCxl7
 v38v7+BZVgPcDJ7E4TdMNPrSxdSYgjAM5gzbFL7ulXTMWbYr2yFg8xhN7X0l6/Tqs9iW
 Gt/CSLLZ4qv69+zl0PQdOgeMohHHaEo+SATeorqOFfufdcDTTpNd2gkuQl8OIx5t3zFD
 q1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737613909; x=1738218709;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QZU+ynMaE0Xe8D1GUqX+dHhvOwOdIR84EGAMYXLcQ+E=;
 b=A4sY28muqC6lad1HM+BWpolQ3p6xOq2QuaHPx5Zwq4M2vlwU4rns/r7kkLZ/QtOqtn
 eyUJK3SoWL0AaVn/OWxI4cD8a2TvevAZhYBdtFHQzrrX0/V6qdKMrVXDRtYTktOiB0hg
 +hBozRW4LKDTRIydlC5grf+pjq09J7/ywsud/4rUaCU+gRXOUKT4MqAl1jycy3awWA5J
 UK0Ji3Zqoa7NNLUcBim8sK3+8iNh+gjxJO+ERFpar99/CXHYpGZDBErb/TN6/aR+WtDA
 pRdJjSprVUK7EQCCPdCzIYF59UfZY/cU7sY+k3oUv4c3Gi5iMKDh1gX4YVR65X+o3Qs1
 AJjQ==
X-Gm-Message-State: AOJu0Yw3wVB+a1CHs2aidPkrFJ73Ffhl8fi9O5fdXJNvUpEDkLqQPLtW
 GSrX+xCSQmS4A+YJl3EcvvVCsngZt9avBeqJH9dY9z0BsxPdP7dtqvVyV7cyhA6+MKy4YM+i3jA
 dXSmZTzw7IAJRzXp7c/ngmQBR55W+kFoh52cO9Q==
X-Gm-Gg: ASbGnctsVS6Lyjmdcarx0GiqMa3Wb/c2wpWPGinzgzNHTlLsuL/+AzOy343BzfHdkDk
 UdYGkrT6dvp/19auKu1MOsfmMOg4CwOfd9v1vkQ5gC0i3hLA8ArVThevcIyD1Vw==
X-Google-Smtp-Source: AGHT+IHg4ge3QWfRg8p/1VFD75rCiaSjeX65puy0xfV7/Iy/lsfBzgbPzU90BrM2vOBxrm5GCaBwLUFOQ5DHXIvanac=
X-Received: by 2002:a05:6902:2ec7:b0:e57:37f8:d554 with SMTP id
 3f1490d57ef6-e58257ce0eamr2009870276.8.1737613897066; Wed, 22 Jan 2025
 22:31:37 -0800 (PST)
MIME-Version: 1.0
References: <20250117164032.88942-1-raymond.mao@linaro.org>
 <20250117164032.88942-4-raymond.mao@linaro.org>
In-Reply-To: <20250117164032.88942-4-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 23 Jan 2025 08:31:01 +0200
X-Gm-Features: AbW1kvbY675FdENQpgu9yvD0JT_dMNUR9BXeiwYhzLgFnh5Khxt3JlWrVWuO_jM
Message-ID: <CAC_iWjL4xtW55Js1=QnwbQxmTeKZwePHcy7ZL-4rYA_CcVJpDw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] tpm: add wrapper and helper APIs for PCR allocate
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Tim Harvey <tharvey@gateworks.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Michal Simek <michal.simek@amd.com>, 
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

Hi Raymond,


On Fri, 17 Jan 2025 at 18:40, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Add PCR allocate wrapper APIs for using in tcg2 protocol.
> The wrapper proceeds a PCR allocate command, followed by a
> shutdown command.
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
> changes in v2
> - Rename the newly added APIs.
>
>  include/tpm-v2.h |  22 +++++++++
>  lib/Kconfig      |  12 +++++
>  lib/tpm-v2.c     | 121 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 155 insertions(+)
>
> diff --git a/include/tpm-v2.h b/include/tpm-v2.h
> index af3158f6e4..58085c9c59 100644
> --- a/include/tpm-v2.h
> +++ b/include/tpm-v2.h
> @@ -703,6 +703,19 @@ u32 tpm2_report_state(struct udevice *dev, uint vendor_cmd, uint vendor_subcmd,
>  u32 tpm2_enable_nvcommits(struct udevice *dev, uint vendor_cmd,
>                           uint vendor_subcmd);
>
> +/**
> + * tpm2_set_algorithm_mask - Set the bitmask of algorithms based on the
> + *                          active/supported banks and the one from
> + *                          eventlog.
> + *
> + * @dev                TPM device
> + * @log_active Active algorithm bitmask
> + * @mask       Bitmask to set
> + *
> + * Return: zero on success, negative errno otherwise
> + */
> +int tpm2_set_algorithm_mask(struct udevice *dev, u32 log_active, u32 *mask);

This isn't a set right? This is getting the pcr banks we need to
configure later on.
The previous version had this as 'tpm2_pcr_allocate_get_mask' which
was a bit less confusing. But on that version, I asked to rename it to
tpm2_scan_masks(). Since the function is trying to cross-check the
available banks and the ones sent in the EventLog.
Can you rename it to that? Or perhaps tpm2_is_mask_allowed()?

Thanks
/Ilias

> +
>  /**
>   * tpm2_pcr_config_algo() - Allocate the active PCRs. Requires reboot
>   *
> @@ -730,6 +743,15 @@ u32 tpm2_pcr_config_algo(struct udevice *dev, u32 algo_mask,
>  u32 tpm2_send_pcr_allocate(struct udevice *dev, const char *pw,
>                            const ssize_t pw_sz, struct tpml_pcr_selection *pcr,
>                            u32 pcr_len);
> +/**
> + * tpm2_activate_banks() - Activate PCR banks
> + *
> + * @param dev   TPM device
> + * @log_active Bitmask of eventlog algorithms
> + *
> + * Return: code of the operation
> + */
> +int tpm2_activate_banks(struct udevice *dev, u32 log_active);
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
> index 045b5dd9eb..0e497b2c2a 100644
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
> +int tpm2_set_algorithm_mask(struct udevice *dev, u32 log_active, u32 *mask)
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
> +                       *mask = active & supported & *mask;
> +               else
> +                       *mask = active & supported;
> +       }
> +
> +       return rc;
> +}
> +
> +static int tpm2_pcr_allocate(struct udevice *dev, u32 algo_mask)
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
> +int tpm2_activate_banks(struct udevice *dev, u32 log_active)
> +{
> +       u32 algo_mask = 0;
> +       int rc;
> +
> +       rc = tpm2_set_algorithm_mask(dev, log_active, &algo_mask);
> +       if (rc)
> +               return rc;
> +
> +       if (algo_mask) {
> +               if (!IS_ENABLED(CONFIG_TPM_PCR_ALLOCATE))
> +                       return -1;
> +
> +               rc = tpm2_pcr_allocate(dev, algo_mask);
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
