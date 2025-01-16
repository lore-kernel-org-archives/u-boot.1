Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54DFDC02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 13:04:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AC528022B;
	Thu, 16 Jan 2025 14:04:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WkBIw8/j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DECF780283; Thu, 16 Jan 2025 14:04:27 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CAAF801B0
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 14:04:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e545c1e8a15so1430729276.1
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 05:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737032664; x=1737637464; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d2tze4s4oF5PGhT0wHmFotVpDqCz6QxWaKQ0EX4gbMg=;
 b=WkBIw8/jbe3Ef3jddOIrIR1E5EQIvIpF9V6sjOBj0SPrxiRrZHmQLoTEoyzbGvRMqp
 l9wwykfU0swJd+vuUId9XQ6cikSs1Q1xe7ndBh+RG+tAWztU4OY3VoKweIOPEIaWd2U1
 uTZkxtlhla/6H/+kvXAmSqtESK8x/J6eMcDbZ9fbFfGkISbjrsI/PdFWe+cBgYGJ3MCX
 CRw/F/IXDcjOiW1jnNNdFysSh+mkbpNXrtrhtq+6n2pPtayhGoXdnJ0AUhmfcV+MYyzJ
 scUwk4AetxnJ47ny54JRU80GtYanTTpnabddzR/ENaSBnb8l6iA8TRk1XX+s4GMcbyox
 DRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737032664; x=1737637464;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d2tze4s4oF5PGhT0wHmFotVpDqCz6QxWaKQ0EX4gbMg=;
 b=ahAFmjHPDQyjMNMKjnpRVlFWNLdXk/RX+I3cyHMrCpYdbRTcV+4gdb8eVAyYxXeU/W
 RYW0BmJBAZXNUaNiPB88my7K2mCPLS6GG1ELD6gdrswiBfFct/VmCs4GPZa87fVn8obb
 kJ3sPYF5V7UhISYaxH25fQT0Eg/WsxC7ypu9w55MvII70XpqYSB9J5U6HxAk4sFagRrm
 rJRfR1TK0rpE0BFo+gfQ3DsP3xVFQ3l1Eib/Niqsn4bLsggD6PS4aPq59GQWKFAQ401W
 0opZmpsH5dusJXEn1rSsXKE/0/3rk43MHdpFdEy343ll0FhS0hh7WmXo6m5jXBBMWQ7T
 kvow==
X-Gm-Message-State: AOJu0YywE95YJGFZd6Gr24TEshyp/f8qsRuoKRiNjHm5u9TYQNv7v9Hf
 DAIqIXIWBXCWy2etFahVqXdYkZcgyp5tL3rDs8FU60fRIcnp+gi+2DK9r6vl0gtVvw+GLx5SWqy
 R4HSCXC5JmGz68ojYwKo/hJAPxED/up+d4efoZg==
X-Gm-Gg: ASbGnctcmfKbiRnZ2tgULO7nZeu5GoekW40ByBQlgTjC7gdaBJWQO4d9tqWJhKK80ZD
 ez68FF9kyzDwrCtm73dk2Q0JwbtR0onVzZ8x9Tg==
X-Google-Smtp-Source: AGHT+IF0YbTSxsaYKgT7IVoWQm+d6DGZMVIR8SB0nGysFMsqvK/R1cSXGrM+Qkp68nVZAzAEHSEYPDr68mGOEJtn0ZY=
X-Received: by 2002:a05:690c:45c8:b0:6f6:c9b8:a026 with SMTP id
 00721157ae682-6f6c9b8a0c3mr56379707b3.5.1737032664282; Thu, 16 Jan 2025
 05:04:24 -0800 (PST)
MIME-Version: 1.0
References: <20250115200144.951530-1-raymond.mao@linaro.org>
 <20250115200144.951530-5-raymond.mao@linaro.org>
In-Reply-To: <20250115200144.951530-5-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 16 Jan 2025 15:03:48 +0200
X-Gm-Features: AbW1kvZpg2A_RLQgyk2y-smj0S9Dg8lOBI0rSef4KhbE1biBOnot2s-6WE80m-c
Message-ID: <CAC_iWj+3O+0dLRi9k+vB56-GOgro4zvuaunNKJgQ3Rj3CrCt2w@mail.gmail.com>
Subject: Re: [PATCH 4/6] tpm: add PCR allocate into the eventlog handling
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Tim Harvey <tharvey@gateworks.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
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

On Wed, 15 Jan 2025 at 22:02, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Get eventlog bank mask when parsing the eventlog from previous
> boot stage and invoke PCR allocate function based on it.
> PCR allocate will be proceeded if any dismatches observed among
> the active, supportted and eventlog bank masks to re-configurate
> the TPM with the proper algorithms and reboot the system.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  lib/tpm_tcg2.c | 52 +++++++++++++++++---------------------------------
>  1 file changed, 17 insertions(+), 35 deletions(-)
>
> diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
> index 2d9076f091..fd84045d8b 100644
> --- a/lib/tpm_tcg2.c
> +++ b/lib/tpm_tcg2.c
> @@ -360,12 +360,12 @@ static int tcg2_replay_eventlog(struct tcg2_event_log *elog,
>         return 0;
>  }
>
> -static int tcg2_log_parse(struct udevice *dev, struct tcg2_event_log *elog)
> +static int tcg2_log_parse(struct udevice *dev, struct tcg2_event_log *elog,
> +                         u32 *log_active)
>  {
>         struct tpml_digest_values digest_list;
>         struct tcg_efi_spec_id_event *event;
>         struct tcg_pcr_event *log;
> -       u32 log_active;
>         u32 calc_size;
>         u32 active;
>         u32 count;
> @@ -376,6 +376,8 @@ static int tcg2_log_parse(struct udevice *dev, struct tcg2_event_log *elog)
>         int rc;
>         u32 i;
>
> +       *log_active = 0;
> +
>         if (elog->log_size <= offsetof(struct tcg_pcr_event, event))
>                 return 0;
>
> @@ -421,7 +423,6 @@ static int tcg2_log_parse(struct udevice *dev, struct tcg2_event_log *elog)
>          * algorithms, so just check the EvenLog against the TPM active ones.
>          */
>         digest_list.count = 0;
> -       log_active = 0;
>         for (i = 0; i < count; ++i) {
>                 algo = get_unaligned_le16(&event->digest_sizes[i].algorithm_id);
>                 mask = tcg2_algorithm_to_mask(algo);
> @@ -447,17 +448,15 @@ static int tcg2_log_parse(struct udevice *dev, struct tcg2_event_log *elog)
>                                 algo);
>                         return -1;
>                 }
> -               log_active |= mask;
> +               *log_active |= mask;
>         }
>
>         rc = tcg2_get_active_pcr_banks(dev, &active);
>         if (rc)
>                 return rc;
>         /* If the EventLog and active algorithms don't match exit */
> -       if (log_active != active) {
> -               log_err("EventLog doesn't contain all active PCR banks\n");
> -               return -1;
> -       }
> +       if (*log_active != active)
> +               return -ERESTARTSYS;
>
>         /* Read PCR0 to check if previous firmware extended the PCRs or not. */
>         rc = tcg2_pcr_read(dev, 0, &digest_list);
> @@ -554,43 +553,21 @@ int tcg2_log_prepare_buffer(struct udevice *dev, struct tcg2_event_log *elog,
>                             bool ignore_existing_log)
>  {
>         struct tcg2_event_log log;
> -       int rc, i;
> +       int rc;
> +       u32 log_active = 0;
>
>         elog->log_position = 0;
>         elog->found = false;
>
> -       /*
> -        * Make sure U-Boot is compiled with all the active PCRs
> -        * since we are about to create an EventLog and we won't
> -        * measure anything if the PCR banks don't match
> -        */
> -       if (!tpm2_check_active_banks(dev)) {
> -               log_err("Cannot create EventLog\n");
> -               log_err("Mismatch between U-Boot and TPM hash algos\n");
> -               log_info("TPM:\n");
> -               tpm2_print_active_banks(dev);
> -               log_info("U-Boot:\n");
> -               for (i = 0; i < ARRAY_SIZE(hash_algo_list); i++) {
> -                       const struct digest_info *algo = &hash_algo_list[i];
> -                       const char *str;
> -
> -                       if (!algo->supported)
> -                               continue;
> -
> -                       str = tpm2_algorithm_name(algo->hash_alg);
> -                       if (str)
> -                               log_info("%s\n", str);
> -               }
> -               return -EINVAL;
> -       }
> -
>         rc = tcg2_platform_get_log(dev, (void **)&log.log, &log.log_size);
>         if (!rc) {
>                 log.log_position = 0;
>                 log.found = false;
>
>                 if (!ignore_existing_log) {
> -                       rc = tcg2_log_parse(dev, &log);
> +                       rc = tcg2_log_parse(dev, &log, &log_active);
> +                       if (rc == -ERESTARTSYS && log_active)
> +                               goto pcr_allocate;
>                         if (rc)
>                                 return rc;
>                 }
> @@ -617,6 +594,11 @@ int tcg2_log_prepare_buffer(struct udevice *dev, struct tcg2_event_log *elog,
>                 elog->found = log.found;
>         }
>
> +pcr_allocate:
> +       rc = tpm2_pcr_allocate(dev, log_active);
> +       if (rc)
> +               return rc;
> +
>         if (elog->found)
>                 return 0;
>
> --
> 2.25.1
>

With the naming changes on patch #3

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
