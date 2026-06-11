Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8148CD98CC
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 09:57:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE111839A8;
	Thu, 11 Jun 2026 11:57:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q/AEyNe5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BC5283FEC; Thu, 11 Jun 2026 11:57:50 +0200 (CEST)
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com
 [IPv6:2607:f8b0:4864:20::b132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB5FC838D7
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 11:57:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-66043ecf6b3so7713002d50.0
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 02:57:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781171866; cv=none;
 d=google.com; s=arc-20240605;
 b=OSyAS+ynUHEHc9YLLHay9k0QxpZvurjOM3/kPP34upliVnwIET5a5LC+31bRilzCwm
 Fzs2+3ETVlcXne5C5PiQAkPMnzW78otBKG7p/irdG0oL3wFZjbRiTCK/3EmYSAOr0RnI
 5LKGOCIDNPJ6siJ6u678GWsX+89jkscLRniz9aSdzxapBOdpIn+kBNKSUAdf4LuOOLk8
 8agdiDqfK58ccWW+JrNap/xuZlW7Y5UXbxaKp4YqpqxOckwgzI1Vt3RVlXqqkCnojs93
 8Llmn7VrbOI+QO0obdCVl8OfaRH7NyJfeO6KZTMjizblbxt+kryvrtKc/fUJndB5Ipuv
 +t0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ui8KPzdbZd2xaouz4sTWrDMTY9v9Pfv7nmfLbClq3wg=;
 fh=F1g9JCAMPZIsmmAfp/vapo88p6hpnQuU8mOv+m+nz5E=;
 b=kaivgJV2X6BohZ8z1iKe+MIpIG6/QYnw9gvrAPJIqp/Lavt58N6TCzjf1G8C+kFoXX
 FsY5HGjzTKGZEPrzmslczVrjiMRHJ2TM3MuooUiV3pk67iGsK6ULMAtmf3FOJaeEOIMc
 Sz+5svqDRf5jMVoaUxr2QzAext5Lbo8RtOQu5WF+XwWYqUW7Jw0eeHLh92KEDw5u+WoG
 yIeXT6KJcxSq5m7/rKo5k0nryWBFM3U1r4B4tK03+iCIs1rNtJnEPfI9uSQukAqlyMrx
 VW+EWgxaRsseST0iz4BmJayOEZOtpFRC/eAiobyqzPyU1d9LYuejyNxcYqbqz78tLKbm
 lH7g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781171866; x=1781776666; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ui8KPzdbZd2xaouz4sTWrDMTY9v9Pfv7nmfLbClq3wg=;
 b=Q/AEyNe50lx4LJ7ANj8/4H1SSwi5E41Rteed6EL/KQYmK1mK8DYtD9SGhQhAB/WADV
 nrowibzAmDQMjgerwWW/csvwZQmxitcJ920TpR2gxBsN4asIXTBhxJY1xq9st8S4PC9O
 GkVVj7+YrTsILybWM4RdvqtxUzOt3GVsC7pdSLJEftyFugHyEsUoxrEfTrgUkhU7BGeZ
 fwmp5ZHW3WjkF8bILbAn5tMPHfhRVaS+vU3n0Yu3gKy8VJSBbkkv6XpqupWe8MLMw7aU
 kqqJir8JycSnWiw1raqCxG+/n/++Ib7FZJ+ZulcpYu8q6mhitIDVPeL7PTpJVXpQ8gLk
 UOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781171866; x=1781776666;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ui8KPzdbZd2xaouz4sTWrDMTY9v9Pfv7nmfLbClq3wg=;
 b=FWNNJGYQB60jTSdYxtMIRfiHLT3XZxrIsJoOEmucTf3sC3jw6FYJFqQrY5O/C3QuO5
 /s+u/6s21d+1SvZ/jsN4Bl+IbioZqMqrIvJkUJ9jWnGHH72WSxWW9QN22i8owcm0YaTl
 OrMP205i69v++TuA3NAFDArwTfWBLDYAHsA7WGQtWoFgJAT9V+G35z0a+0dvC/LNJXuN
 pvGifFBwpVRXlXfgL4L+s0DjohjZl5UzBD21pSUqcHju+b3BJ3FShy4KS7Ko+OwNgNmq
 FTUgy57uhrtQ5XdYUhhm4wTg0j7rcqdTpsywWYJrahfgvCv6355OXhEGssE/4nF621OG
 VIuQ==
X-Gm-Message-State: AOJu0YwPPk56TDxnn0147ULAve5pVQyp0wOokncVGIPhQicRQpKxScFt
 MzWVS8T648Fba3A//MwYqvHcH0mCF9vnYK/SIlAz1kSAbvMi7y8y2a5KaQeU/lOTdKbS/ZEMaDZ
 0Nxez+WwQvZ/QGPrj7bYCRFJEsXXnVneys7niM1nTWQ==
X-Gm-Gg: Acq92OEs7itjN/D1guI1QzrrkaEZ9P5rCNIyiZe8pRJY2vppPIuKfL4cQNrLo2330fV
 NiX6OXd7GBuBdPaDrwDaVLNGYobfCiU8yCwBeW5A1ZeQWcFy2DiLPD6cmUevNdGtBIaM8dg1ZuN
 l/NTuTuB1jsLaTvjjWmi9Edj4jib2cSnjqEwJKcHo7qhgMgrnc1I8yK8Yo0uLJqdEq21t0+wSka
 TKhBdz1ZcW18VV954+ct3VdCsB6ng+kCiltGhea+0IAdrLqI/MFG773QIQoN1GbH9U74w032f10
 ppdnrFUz7bWo9Bof38dBO3Dhp1kCQJ66u/7U324os/ZWhrW4iONkspjsTtm7DsDBttmpW1HvUlG
 Qgl9NG7KzxtpsZhteaGZEbs0CNHD2IQiLxB3KWjkBJbcZF+iUNJ1EqMsx5R2geIpZAGw2rCJCa5
 2ObJBbFw5XejmZJP+nCd87p++N4wAQytTAaSJLL+wJOiLKCgpTTPjfabmG4fU6FjCUlpu0nJPWf
 lzcD2wXhOcei0BbBWZMpjeYlqAU/1JuxLlg+UtnSHS/0imzzRlDPxBKdZ3R9X2/WJUAiY19POJE
 Dz2KOIEfZo1V8NMAPABopQ3B6ILFKITW1Cz4U5qnpkzlNicSF0hbLH6eekTu9XySn+CWdlU9Fbk
 tr02miLZ6wvohkGY8
X-Received: by 2002:a05:690e:4383:b0:65c:3597:5fd9 with SMTP id
 956f58d0204a3-6626965176amr1132287d50.17.1781171866399; Thu, 11 Jun 2026
 02:57:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260610105243.193355-1-ludwig.nussel@siemens.com>
 <20260610125204.v2.3.db7fbeb8b6e8499f4d031c04cb5cd8175873b643@changeid>
In-Reply-To: <20260610125204.v2.3.db7fbeb8b6e8499f4d031c04cb5cd8175873b643@changeid>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 11 Jun 2026 12:57:09 +0300
X-Gm-Features: AVVi8CcUVZu4QxZO5-3wReLsJdhcJQ54LqLTvPtRMGuRlXbXs0c5TquaJQyqxs4
Message-ID: <CAC_iWjKN4URBGikcEeTHp7dQPf7QasESmPOmys9piEnsVt-fWw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] tpm: allocate tpm event log if missing
To: Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>, 
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
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

The CI [0] fails with this attached. You can run it in github by
opening a PR before v3. Also can you update the description and add
the use case you mention in the cover letter?


On Wed, 10 Jun 2026 at 13:52, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
>
> Allocate and attach the TPM event log to the TPM device if not
> initialized yet. The address is copied into the device tree for the
> kernel so the event log is accessible from Linux userspace too.
>
> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
>
> ---
>
> Changes in v2:
> - imply DEVRES in config TPM
> - use fdt_getprop for reading property
> - don't wrap #include in #if
> - fix memory leak in error case of tcg2_log_prepare_buffer
> - handle NULL elog parameter in tcg2_measurement_term
> - use CONFIG_TPM2_EVENT_LOG_SIZE
> - pass log_size instead of position in dt
>
>  boot/bootm.c         |  18 +++---
>  boot/image-fdt.c     |  69 +++++++++++++++++++++++
>  include/tpm-common.h |   2 +
>  include/tpm_tcg2.h   |   9 +--
>  lib/Kconfig          |   1 +
>  lib/tpm_tcg2.c       | 130 ++++++++++++++++++++++++++++++++++---------
>  6 files changed, 188 insertions(+), 41 deletions(-)
>

[...]

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

I'd like the eventlog to be initialized before calling this (look below).

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

[...]

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

I think it makes more sense to define an eventlog state with a u32 and
replace the found boolean with it. e.g

#define ELOG_FOUND BIT(0)
#define ELOG_ALLOCATED BIT(1) etc

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

Initializing this here feels wrong. This is a function that just
measures and logs data. Why can't we fill in the eventlog address
early before calling this? If we do so some of the checks above are
also not needed


>         return tcg2_log_append_check(elog, pcr_index, event_type, &digest_list,
>                                      event_size, event);
>  }
> @@ -560,15 +567,32 @@ int tcg2_measure_data(struct udevice *dev, struct tcg2_event_log *elog,
>  int tcg2_log_prepare_buffer(struct udevice *dev, struct tcg2_event_log *elog,

[...]


[0] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/30423

Thanks
/Ilias
