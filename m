Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F20DCCEACEF
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 14:53:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 810AC83A64;
	Mon, 17 Nov 2025 15:53:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="L1MzEUAa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1505883A64; Mon, 17 Nov 2025 15:53:48 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC3588393F
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 15:53:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-787c9f90eccso45883117b3.3
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 06:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763391225; x=1763996025; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Jovutb/tD2ouLcHalgXMT4Sj6SPPUHLBzsHJcbs3dzE=;
 b=L1MzEUAafD6uCIIhe0XhM6ojvZm74a8hGL2sBmt/4cp9fvqL/3X81stmFN6xE4UYIX
 Q1jhzp9nFyQNyB1Xa/NeRbnClE2Z2wVppIfTFqn9bt9GzAVrrAO2SwBD8NZl+Lj/f737
 F2JUJ3sbhdub0U9ZyM4uSgb6PNXzYuoSv8qpYrzldpf68vWmiTFSDZKvNGHZoZbGqkNS
 j2syKAgP54z0ZKaXEnIXlDV+NDeLe0pExkD608Wakf+PlnQoFxPvZ0PnVGbHwMe+d7JV
 sNpVzX04OpXubeNbJbH2wNnEVh+EU/8OqV/wnyN+MlleDtyL6mS2R2q2OY2vPU+RrI7h
 uBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763391225; x=1763996025;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jovutb/tD2ouLcHalgXMT4Sj6SPPUHLBzsHJcbs3dzE=;
 b=kxyTBh96p9f57RCfkqh7cRrpViPl4/x72wb6/8JlakmfSwnWuPDZGjh0E3PZe7ZnMm
 NM2cPnt196aXHz0Rau8JfmYaIKMm0i29L7I9ddE7Uf7wVAwAIeCmVyWAJDE/6buzwBWf
 YEkSlo4RL++KEnDNEkNk2NvmQEOW6gAjjwKwACrYgKAO4E0wCNOCMu3cNl2XG0BsaSWk
 QVQWZQZyhUgbtxSf5Sqxsj/hCzpS+UeCJTeZXiGnAX8Z08yD4D2+iUZBCOCx7PZS8p6S
 8mltOZc8CwoM2j/QnVPnTElwPeZQc2UKR9dCo9028aWyPl8GZ9DcYxrp6fzGZEPzI5r2
 bDmA==
X-Gm-Message-State: AOJu0YyCD5bMvI0vANVpDLMS6oBfkux6eB8SsH6uhIHR9PQnd9B6hsqA
 2vGmgtYp6LQ/d5x26/xka5+9UMVb9mwonlMImsHaR+h5d4pZ6JssBg+7syyJ3HrcATqM27Ntx+3
 8cyh7UemjftRFjUIWZPC0CWJTHSOnb5DwyGJEve/crQ==
X-Gm-Gg: ASbGncummjwGOPhjYF2FBjHetWScoSKCXKT0lYvm6btpFo5bNiHdklzxsPuBvxERK0m
 m9LEFm+KvFVNr/4I9yP8B77ilW8foUnVrNujMveylywOLTGtnWSUfhzFIFXU2wNdqXQfxwJOnn7
 BomlTC4byvdJUSJnkLwzOyDbCcXpgPWb9lCQ6uBk+I59VsI5fAlm60qVxI54TyfH0YkSthsnNsL
 BwnF4oQVL1c2mkcooxc1Er+iJRKM6Ipwbgzp9mLnxHJOfEW+epTQmVwUFB7fBSTOUTAnQPwmlJP
 RuM1IDz3YaxQuUAoUnuZQsaJQaK3t8GouH0kPqY3
X-Google-Smtp-Source: AGHT+IEZZRpoH6JhmqV/htXiph2EucuIjV/BTpKqetEaFgUqo6JV2ab0DV9zmk7e7/peOwjmrNEf9gAkj2iEo72wlVk=
X-Received: by 2002:a05:690e:1550:10b0:63f:af64:ae5b with SMTP id
 956f58d0204a3-641e763fda5mr8291003d50.41.1763391224676; Mon, 17 Nov 2025
 06:53:44 -0800 (PST)
MIME-Version: 1.0
References: <20251114093246.56422-1-heinrich.schuchardt@canonical.com>
 <20251114093246.56422-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251114093246.56422-3-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 17 Nov 2025 16:53:08 +0200
X-Gm-Features: AWmQ_bnxcRNyE5bxNXWUq_lr3Z23XGBYLRTfojLJYAD60hVLZ_K6fWGMKzL0ewg
Message-ID: <CAC_iWjLdf90EMGZQjPNcL6Ah1MW2hTWaVZUpFw6W2Jfqeq10xg@mail.gmail.com>
Subject: Re: [PATCH 2/7] efi_selftest: simplify efi_selftest_reset
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
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

On Fri, 14 Nov 2025 at 11:33, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Use global st_runtime.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  lib/efi_selftest/efi_selftest_reset.c | 20 +-------------------
>  1 file changed, 1 insertion(+), 19 deletions(-)
>
> diff --git a/lib/efi_selftest/efi_selftest_reset.c b/lib/efi_selftest/efi_selftest_reset.c
> index 5dfe517de4f..8125f51815e 100644
> --- a/lib/efi_selftest/efi_selftest_reset.c
> +++ b/lib/efi_selftest/efi_selftest_reset.c
> @@ -10,22 +10,6 @@
>
>  #include <efi_selftest.h>
>
> -static struct efi_runtime_services *runtime;
> -
> -/*
> - * Setup unit test.
> - *
> - * @handle:    handle of the loaded image
> - * @systable:  system table
> - * Return:     EFI_ST_SUCCESS for success
> - */
> -static int setup(const efi_handle_t handle,
> -                const struct efi_system_table *systable)
> -{
> -       runtime = systable->runtime;
> -       return EFI_ST_SUCCESS;
> -}
> -
>  /*
>   * Execute unit test.
>   *
> @@ -35,7 +19,7 @@ static int execute(void)
>  {
>         u16 reset_data[] = u"Reset by selftest";
>
> -       runtime->reset_system(EFI_RESET_COLD, EFI_SUCCESS,
> +       st_runtime->reset_system(EFI_RESET_COLD, EFI_SUCCESS,
>                               sizeof(reset_data), reset_data);
>         efi_st_error("Reset failed.\n");
>         return EFI_ST_FAILURE;
> @@ -44,7 +28,6 @@ static int execute(void)
>  EFI_UNIT_TEST(reset) = {
>         .name = "reset system",
>         .phase = EFI_EXECUTE_BEFORE_BOOTTIME_EXIT,
> -       .setup = setup,
>         .execute = execute,
>         .on_request = true,
>  };
> @@ -52,7 +35,6 @@ EFI_UNIT_TEST(reset) = {
>  EFI_UNIT_TEST(resetrt) = {
>         .name = "reset system runtime",
>         .phase = EFI_SETUP_BEFORE_BOOTTIME_EXIT,
> -       .setup = setup,
>         .execute = execute,
>         .on_request = true,
>  };
> --
> 2.51.0
>
