Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD931C4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 08:42:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 064D787652;
	Thu,  2 Nov 2023 09:42:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vjkrdkez";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78AC586996; Thu,  2 Nov 2023 09:42:32 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58F9C86AFA
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 09:42:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-507a55302e0so809671e87.0
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 01:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698914547; x=1699519347; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SCf7BpLkdBv9eYXTsEaKgmGGaQzyakTrR5KNPso/j34=;
 b=vjkrdkezOu5wEWOp8OozDnh97lB2yDv4cyjf/6bKeUtopwcVkSKx1uEJwF/NRuNJzh
 mnwN9jX6vFMVQXkIFGQEj8zmbGN/jipxLS4RA2VOJbnGNd0zsMSbGIE7eWMj1uDKDdCl
 HxXUzYedjf3QYqEenHp6OL6zHUUnLKc/jt3MYiGHaEOd87eBmL2306WHdzcCPZhFEV8i
 DA3yPo+DTTh5lb1B3dobAYlPqQ3EIuNtMFtnymgIxWLIN7vIU9/8FjIc2cpk0G5hFMkL
 +65LcAzR66QuOGaFq+WIphLsJdJSmFD8eaWVbNZZM0o5jRi315BJW9MWOxAWKzNZsCcH
 oqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698914547; x=1699519347;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SCf7BpLkdBv9eYXTsEaKgmGGaQzyakTrR5KNPso/j34=;
 b=Zo5D7OZyvNQlBYUmv+C7yN/kmjvan00lHHPgbC/RtfEyHlghnqFV1g+296Nho/IQLd
 ixt81io9ccssuZuVIgnvB0vXXsbJk1R2Q6OuQrh1lRZd4lKNq8+bpue5F4QHnZlW94Bb
 RJcC3kXupgNp9ytnqYeO1Vv7+5F0tdYPaXirpnNwNsE1cPcDaerckfEepAKiXm45zmx1
 5dzWtvYVbkY9tG6oWg2S+clue0s9W+MsN4IXAoNUX/m1sk8SHxzSzDuE7ATd0M8932E4
 Zun7PxIoQlCd6/v8yhrLYSnPFPPwFjZUHeXrHIXNyQyT8n7iquDzS4qLrPRplLxFZIKQ
 Gszw==
X-Gm-Message-State: AOJu0Yz5nH5wxg8gCgSw1y1A9bnvZJbNb/9RaoyHqDlXUvGFKYCzrKQH
 nPAg3bGxrPv311x5u2tq4R4vvc0wWeSS6ftd+ifEtQ==
X-Google-Smtp-Source: AGHT+IEpyJfL+JE10m3a79fenoJRX2Zlyh6Ke+7M2aAbiMA6bYxi42qCoHPa/OD/Ad6axfv+BJdk6e0fRZzNvEVb7O8=
X-Received: by 2002:a05:6512:40a:b0:500:ac71:8464 with SMTP id
 u10-20020a056512040a00b00500ac718464mr12469831lfk.66.1698914547607; Thu, 02
 Nov 2023 01:42:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231102064459.3466953-1-masahisa.kojima@linaro.org>
 <20231102064459.3466953-6-masahisa.kojima@linaro.org>
In-Reply-To: <20231102064459.3466953-6-masahisa.kojima@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 2 Nov 2023 10:41:51 +0200
Message-ID: <CAC_iWjKDtM9uCv2C_mcA833xGgsN-Ugkp_BtUumw2qRTHxMS9g@mail.gmail.com>
Subject: Re: [PATCH v9 5/9] efi_loader: add missing const classifier for event
 service
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Takahiro Akashi <takahiro.akashi@linaro.org>, 
 Michal Simek <michal.simek@amd.com>
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

On Thu, 2 Nov 2023 at 08:46, Masahisa Kojima <masahisa.kojima@linaro.org> wrote:
>
> const classifier is missing in EventGroup parameter of
> CreateEventEx(). Fix it to remove the compiler warning.
>
> NotifyContext parameter of CreateEventEx() is also defined
> with const in UEFI specification, but NotifyContext parameter
> of CreateEvent() is defined without const.
> Since current implementation calls the common efi_create_event()
> function from both CreateEventEx() and CreateEvent() services,
> NotifyContext parameter leaves as is.
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
>  include/efi_api.h             | 2 +-
>  include/efi_loader.h          | 2 +-
>  lib/efi_loader/efi_boottime.c | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/efi_api.h b/include/efi_api.h
> index 8f5ef5f680..c2d6964467 100644
> --- a/include/efi_api.h
> +++ b/include/efi_api.h
> @@ -192,7 +192,7 @@ struct efi_boot_services {
>                                         struct efi_event *event,
>                                         void *context),
>                                 void *notify_context,
> -                               efi_guid_t *event_group,
> +                               const efi_guid_t *event_group,
>                                 struct efi_event **event);
>  };
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index e24410505f..e164e6067d 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -685,7 +685,7 @@ efi_status_t efi_create_event(uint32_t type, efi_uintn_t notify_tpl,
>                               void (EFIAPI *notify_function) (
>                                         struct efi_event *event,
>                                         void *context),
> -                             void *notify_context, efi_guid_t *group,
> +                             void *notify_context, const efi_guid_t *group,
>                               struct efi_event **event);
>  /* Call this to set a timer */
>  efi_status_t efi_set_timer(struct efi_event *event, enum efi_timer_delay type,
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> index 0b7579cb5a..f9b10a9763 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -712,7 +712,7 @@ efi_status_t efi_create_event(uint32_t type, efi_uintn_t notify_tpl,
>                               void (EFIAPI *notify_function) (
>                                         struct efi_event *event,
>                                         void *context),
> -                             void *notify_context, efi_guid_t *group,
> +                             void *notify_context, const efi_guid_t *group,
>                               struct efi_event **event)
>  {
>         struct efi_event *evt;
> @@ -790,7 +790,7 @@ efi_status_t EFIAPI efi_create_event_ex(uint32_t type, efi_uintn_t notify_tpl,
>                                                         struct efi_event *event,
>                                                         void *context),
>                                         void *notify_context,
> -                                       efi_guid_t *event_group,
> +                                       const efi_guid_t *event_group,
>                                         struct efi_event **event)
>  {
>         efi_status_t ret;
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
