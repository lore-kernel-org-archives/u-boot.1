Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E77C2C02187
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 14:01:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 228528022B;
	Thu, 16 Jan 2025 15:01:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yLiMYfHA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67C018033D; Thu, 16 Jan 2025 15:01:18 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4A2E80214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 15:01:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e455bf1f4d3so1329899276.2
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 06:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737036075; x=1737640875; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=buYPNjZTusYOMMDINiTo75ckYJtMteVUGQPWyMw9pYc=;
 b=yLiMYfHAFuJaGTYSgxJmyUO2t0yHB2p5WoNSUjq7G5Ux4senqfRrHtirTTvAh2f/NY
 pEd2mm9JMvn3ouTP3Qwfqqms/EGTsgHBYz4MpZBBLlhTFL5qm8wiivbD5Nwp0L0OUMZx
 otFqlgsJX0XwHB3TTS4SpRGtx1V7wkWNiIaD8jVQw2g0bxnGi9N4u591WsXBa0OSbeG1
 p3WztRmXXjU5TSIymrq6uTwURo7oTPWcFoIeMmGWv6uYhQgW8wCimzFSneUi/tTTNBXN
 oJZeD0LslEq7bKDSgSQlpSTdcUp3zPWu6vJOl1QZ4JAZfCmzOaletj8N+T/hzqdr4hqj
 OY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737036075; x=1737640875;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=buYPNjZTusYOMMDINiTo75ckYJtMteVUGQPWyMw9pYc=;
 b=AxEEBM2dvYYaZUKXsKGAzY6Ua16kktLI+I0xkPPxtiw+Se3J7oXwAQ633T9T9OWCfQ
 HWzGm5uqM450GuU+crCfSXcJYpog1TwNvH2Adnj3iaQo/bEs65HvWwqYh15+jqVeDCX4
 3sbifTejqaM0sjnD8nYcu7CFwJcAuvlt0cQGhTYlxiL5gXf/SpeK9sWz9U4LMXpzR0on
 Muy3rb6t2XOeS/wthlNj5FUR/Dz9KanCj7cUiJJb1iU21t0YRh3GbkXj5YoFLRG3p80T
 LdYotqpk0R7eHo8YuFeHLFJSteIZbAwK6AGMbuovvGRjgkkLqzw6Frhno3YnrSkqChd4
 6sLQ==
X-Gm-Message-State: AOJu0YzvncQq3WkDtgLSpYi3V46LmaLawylZWYhIlX/tfFr5oM3aBomM
 MkFVPt0OG/mtSF8fxg1X8hH3GErvdQfV7BnaeMHJLK2YaKppKjgJ8QGOMv3VHiuRO/DGfBbkjX5
 sgkONdWilKIEgD7ERGTnVoWTKqW6C3I6WBIn4jg==
X-Gm-Gg: ASbGncstejSJxwTbbNzV+S2MAHIng7VqhRa1wIeUZbSS/HBqCUanrrYlLKpqdOVmu/s
 XAZ1k4m3sei1qyv1FDQ2O2z0N+XZ+zWHumhYcqA==
X-Google-Smtp-Source: AGHT+IGSIRZrb/dkXJVtbstRv4Zn+RV8V1vgOTLNkUrn7JxaBWNsJRXTqJZhy1nG3fJP5kTuInHsGRoMp2Nt4IHaf50=
X-Received: by 2002:a05:690c:b04:b0:6ef:59ef:f194 with SMTP id
 00721157ae682-6f531203885mr248990347b3.4.1737036074579; Thu, 16 Jan 2025
 06:01:14 -0800 (PST)
MIME-Version: 1.0
References: <20250114152022.933662-1-raymond.mao@linaro.org>
 <20250114152022.933662-2-raymond.mao@linaro.org>
In-Reply-To: <20250114152022.933662-2-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 16 Jan 2025 16:00:38 +0200
X-Gm-Features: AbW1kvZvnNhBhAkAo1oTCv_v8lKswXKxh8P0xbnYeZ_GsWWTHYKPrtfTfKg6fRM
Message-ID: <CAC_iWjLR0JgVLQ8YnFvDztfHNs3=0EXQf-8DCiO7-KesagrU1g@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] tcg2: decouple eventlog size from efi
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Levi Yun <yeoreum.yun@arm.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Michal Simek <michal.simek@amd.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Adriano Cordova <adrianox@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Tim Harvey <tharvey@gateworks.com>
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

On Tue, 14 Jan 2025 at 17:20, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Move default eventlog size from efi to tpm for using in both
> efi and measured boot.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v5
> - Move eventlog size kconfig from EFI to TPM2, so that it can be used by
>   both EFI and MEASURED_BOOT.
>
>  doc/usage/measured_boot.rst |  1 -
>  drivers/tpm/Kconfig         |  9 +++++++++
>  include/efi_tcg2.h          |  2 --
>  lib/efi_loader/Kconfig      |  9 ---------
>  lib/efi_loader/efi_tcg2.c   | 15 ++++++++-------
>  5 files changed, 17 insertions(+), 19 deletions(-)
>
> diff --git a/doc/usage/measured_boot.rst b/doc/usage/measured_boot.rst
> index 05c439e9ac..488dd546f1 100644
> --- a/doc/usage/measured_boot.rst
> +++ b/doc/usage/measured_boot.rst
> @@ -24,7 +24,6 @@ Requirements
>
>  * A hardware TPM 2.0 supported by an enabled U-Boot driver
>  * CONFIG_EFI_TCG2_PROTOCOL=y
> -* CONFIG_EFI_TCG2_PROTOCOL_EVENTLOG_SIZE=y
>  * optional CONFIG_EFI_TCG2_PROTOCOL_MEASURE_DTB=y will measure the loaded DTB
>    in PCR 1
>
> diff --git a/drivers/tpm/Kconfig b/drivers/tpm/Kconfig
> index d59102d9a6..01bc686d36 100644
> --- a/drivers/tpm/Kconfig
> +++ b/drivers/tpm/Kconfig
> @@ -209,6 +209,15 @@ config TPM2_MMIO
>           to the device using the standard TPM Interface Specification (TIS)
>           protocol.
>
> +config TPM2_EVENT_LOG_SIZE
> +       int "EventLog size"
> +       depends on TPM_V2
> +       default 65536
> +       help
> +         Define the size of the EventLog. Note that this is going to be
> +         allocated twice. One for the eventlog it self and one for the
> +         configuration table that is required from the TCG2 spec
> +
>  endif # TPM_V2
>
>  endmenu
> diff --git a/include/efi_tcg2.h b/include/efi_tcg2.h
> index 8dfb1bc952..7ed8880991 100644
> --- a/include/efi_tcg2.h
> +++ b/include/efi_tcg2.h
> @@ -28,8 +28,6 @@
>  #define EFI_TCG2_MAX_PCR_INDEX 23
>  #define EFI_TCG2_FINAL_EVENTS_TABLE_VERSION 1
>
> -#define TPM2_EVENT_LOG_SIZE CONFIG_EFI_TCG2_PROTOCOL_EVENTLOG_SIZE
> -
>  typedef u32 efi_tcg_event_log_bitmap;
>  typedef u32 efi_tcg_event_log_format;
>  typedef u32 efi_tcg_event_algorithm_bitmap;
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index c46ffe3a9d..d703e901ed 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -437,15 +437,6 @@ config EFI_TCG2_PROTOCOL
>           Provide a EFI_TCG2_PROTOCOL implementation using the TPM hardware
>           of the platform.
>
> -config EFI_TCG2_PROTOCOL_EVENTLOG_SIZE
> -       int "EFI_TCG2_PROTOCOL EventLog size"
> -       depends on EFI_TCG2_PROTOCOL
> -       default 65536
> -       help
> -               Define the size of the EventLog for EFI_TCG2_PROTOCOL. Note that
> -               this is going to be allocated twice. One for the eventlog it self
> -               and one for the configuration table that is required from the spec
> -
>  config EFI_TCG2_PROTOCOL_MEASURE_DTB
>         bool "Measure DTB with EFI_TCG2_PROTOCOL"
>         depends on EFI_TCG2_PROTOCOL
> diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
> index a15c73162e..6dba8b1406 100644
> --- a/lib/efi_loader/efi_tcg2.c
> +++ b/lib/efi_loader/efi_tcg2.c
> @@ -111,7 +111,7 @@ static efi_status_t tcg2_agile_log_append(u32 pcr_index, u32 event_type,
>         /* if ExitBootServices hasn't been called update the normal log */
>         if (!event_log.ebs_called) {
>                 if (event_log.truncated ||
> -                   event_log.pos + event_size > TPM2_EVENT_LOG_SIZE) {
> +                   event_log.pos + event_size > CONFIG_TPM2_EVENT_LOG_SIZE) {
>                         event_log.truncated = true;
>                         return EFI_VOLUME_FULL;
>                 }
> @@ -124,7 +124,7 @@ static efi_status_t tcg2_agile_log_append(u32 pcr_index, u32 event_type,
>                 return ret;
>
>         /* if GetEventLog has been called update FinalEventLog as well */
> -       if (event_log.final_pos + event_size > TPM2_EVENT_LOG_SIZE)
> +       if (event_log.final_pos + event_size > CONFIG_TPM2_EVENT_LOG_SIZE)
>                 return EFI_VOLUME_FULL;
>
>         log = (void *)((uintptr_t)event_log.final_buffer + event_log.final_pos);
> @@ -822,12 +822,12 @@ static efi_status_t create_final_event(void)
>          * EFI_TCG2_GET_EVENT_LOGS need to be stored in an instance of an
>          * EFI_CONFIGURATION_TABLE
>          */
> -       ret = efi_allocate_pool(EFI_ACPI_MEMORY_NVS, TPM2_EVENT_LOG_SIZE,
> +       ret = efi_allocate_pool(EFI_ACPI_MEMORY_NVS, CONFIG_TPM2_EVENT_LOG_SIZE,
>                                 &event_log.final_buffer);
>         if (ret != EFI_SUCCESS)
>                 goto out;
>
> -       memset(event_log.final_buffer, 0xff, TPM2_EVENT_LOG_SIZE);
> +       memset(event_log.final_buffer, 0xff, CONFIG_TPM2_EVENT_LOG_SIZE);
>         final_event = event_log.final_buffer;
>         final_event->number_of_events = 0;
>         final_event->version = EFI_TCG2_FINAL_EVENTS_TABLE_VERSION;
> @@ -913,7 +913,8 @@ static efi_status_t efi_init_event_log(void)
>         if (tcg2_platform_get_tpm2(&dev))
>                 return EFI_DEVICE_ERROR;
>
> -       ret = efi_allocate_pool(EFI_BOOT_SERVICES_DATA, TPM2_EVENT_LOG_SIZE,
> +       ret = efi_allocate_pool(EFI_BOOT_SERVICES_DATA,
> +                               CONFIG_TPM2_EVENT_LOG_SIZE,
>                                 (void **)&event_log.buffer);
>         if (ret != EFI_SUCCESS)
>                 return ret;
> @@ -922,7 +923,7 @@ static efi_status_t efi_init_event_log(void)
>          * initialize log area as 0xff so the OS can easily figure out the
>          * last log entry
>          */
> -       memset(event_log.buffer, 0xff, TPM2_EVENT_LOG_SIZE);
> +       memset(event_log.buffer, 0xff, CONFIG_TPM2_EVENT_LOG_SIZE);
>
>         /*
>          * The log header is defined to be in SHA1 event log entry format.
> @@ -939,7 +940,7 @@ static efi_status_t efi_init_event_log(void)
>          * platforms can use different ways to do so.
>          */
>         elog.log = event_log.buffer;
> -       elog.log_size = TPM2_EVENT_LOG_SIZE;
> +       elog.log_size = CONFIG_TPM2_EVENT_LOG_SIZE;
>         rc = tcg2_log_prepare_buffer(dev, &elog, false);
>         if (rc) {
>                 ret = (rc == -ENOBUFS) ? EFI_BUFFER_TOO_SMALL : EFI_DEVICE_ERROR;
> --
> 2.25.1
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
