Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F76C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 13:07:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A92E384B39;
	Mon, 13 Jul 2026 15:07:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m2cSWtdr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC79F84B3A; Mon, 13 Jul 2026 15:07:01 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2B5C84B27
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 15:06:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c15e0c3f395so369354766b.3
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 06:06:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783948019; cv=none;
 d=google.com; s=arc-20260327;
 b=Y4sisOESFF5qhGbg49aiWDH9723IkoewRpAlk+D3hlB6HRAAEmf47r47YEh2WCwMNM
 Hhrlni9wjw/7sbSrO39Wtc+nqpu7wRtF8mz2Shu7RVs3zNEIrTfuFUgmLOFY34vYA7rg
 3Xp9TP1VkhgMpFelyly6FHuxY4YRF7w9klQHoHBbtZWwKWKu47EcdPtzzt+agAswK3tK
 g2zNrX7vdPeL5UQyLinWtouyqJzS89lwQHcFVmyJ1563H1e3yV+kbBu5hIi0CqUfu8fu
 +hdJci3D8RaQFFnzLrxd7cM43FjNeUUR4V2TV7UOBiBfyZ5UvuWMlYDUqt/yHM6TkHKv
 Llqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vT2Bo5HiF4S9K8aIjBs7Cid5QBmjlH0DLF59wfNC/Io=;
 fh=mkEYNmuFNxJfhqS3FPHZk+x7OcStFw/zDeQdbqQeFVU=;
 b=WzphwKsV+qZM2/WlMCae7Hn4sZpUt4Om+ke7KoUqEiMJn2sEHxG48+/4gIFFw0qvn9
 gN0xC+Udy700U5Qr2dUq+CA/y/eIgsdUW/RXJ/T+tWEj6jF5CIb9eF3O5kUzts7lWlMK
 69+SySAy4D7e6Xi2dxyeVDW6w8U9OUTX/kz29P6UqSjrhz4MOTXG6dIAcCFqEtL6uoAj
 qIS2VINuo/UsHKNDJQG2y/Ss+87gX/CRhrssGBc+XSN3O2yaXO4JiI9+Qk2lbLSY3V9w
 FOArqhsUy/3Q8lsZv1B/gkug72M0nVPTZp1ZCohfqPBZXn95v6N4ei7EvyvHPp4IBXYM
 Ko3w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783948019; x=1784552819; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vT2Bo5HiF4S9K8aIjBs7Cid5QBmjlH0DLF59wfNC/Io=;
 b=m2cSWtdrE/LV4mvkXq8nB3ezLo+Y4rcKftBK47sY5cOhdtX+M9iAfM6PUpNWWTBVCe
 cvioZiePvd/52ffSt/joFAO56mV7mYyPzD5vCKewuStbfOZMCGQhC2J+hgzI8zBv6I/N
 OZLpjfQd8Nd0YEACZSpuETRrJvBHMJ4peE1vU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783948019; x=1784552819;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vT2Bo5HiF4S9K8aIjBs7Cid5QBmjlH0DLF59wfNC/Io=;
 b=PrhoYl+DEu1M49Rai2RUQgCqigF57MseSrnNoIUs1i2rGCmkjsIVIspS4gor+ru6Zb
 Dbuqs2ADGSkXc/4jrfbcOmZY5/ivxUE+kJugFLJ/SIFGqmIF1P0Q4KT9tBZgCPuYC0mB
 Q8cYSSxjtqp+b5g7pMAllq838FyOkZYGT79yFsKkp3h4IxG35MvnH92O7oSncGGxCHap
 6mqTy7HWYHQt+vMDhkXqoBJsQR+8RxaCch0FXUnufWSpedLydqEqgOXvL5MynWSPrtS0
 s3L3u57qyruA2/6tPWlixOpD6LP345qj4+ocrVk9mKJOI3UEv1NZvusZUbbxIUJgMZgJ
 J2Yg==
X-Gm-Message-State: AOJu0Yxrlh1v8+a81P3SesCEOPBsaLegL2gRz6eqkfHXrO0xFpS+uoNG
 wAhsmb/hfk6d+ufM6oMBfX1WjcSxWnTcKDrY+DKY29odFpF6VSufpp5VjtOsQIdTSiIssvMEIj5
 fZuQi0dceHUu1cJFdRAVcegDumIIXKAmk4B8nEInPJgQwggGxfL0B/g==
X-Gm-Gg: AfdE7cl8eavbvR3s+09lY8wB/IQQURsq2nekdiqjkKAzZgYmVKF7PRlzPho5LZpLcPh
 XdSHv4yEnRtLWzBZbOaX/QJft2LAdFM6TyjqdOuhlUNPhez1CIMs4iNvXmwUw8alf/eVa1oaRe2
 L8lzdYtuPqLSwJuO0UJ4chd4RePMJE4ueEkkqD2+t/eMD01tjfvFupR0iS7zlk4C5WHhtmRz3cx
 xu19VybkbJqe0q3PWzBcffYpj1VEk0kAPYx1QiPIDRMjC4AfGp4rXZd4HcVsswznLYcV+c=
X-Received: by 2002:a17:906:af7c:b0:c12:8c41:3bf5 with SMTP id
 a640c23a62f3a-c161f3e0f1bmr266142766b.59.1783948019428; Mon, 13 Jul 2026
 06:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260629080241.36311-1-ludwig.nussel@siemens.com>
 <20260629080241.36311-2-ludwig.nussel@siemens.com>
In-Reply-To: <20260629080241.36311-2-ludwig.nussel@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jul 2026 07:06:46 -0600
X-Gm-Features: AUfX_mz6w26Yz6q29VqWqWgMNXbAoouVOS69xCoeM3bGbl9NXJ1zFk6rvuLPdhE
Message-ID: <CAFLszTgw=nk9fJnkt+4JiMRky5nBZ=MqmqZjWMP4_JhnMWTCGg@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] tpm: unify the tcg2 eventlog structures
To: ludwig.nussel@siemens.com
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

Hi Ilias,

On 2026-06-29T08:00:59, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
> tpm: unify the tcg2 eventlog structures
>
> We currently have two structures describing the internal TCG EventLog
> buffers we keep in memory.
> The first one is 'struct event_log_buffer' and it carries all the
> necessary members to keep track of the information needed to implement
> the EFI TCG protocol.
>
> The second one is 'struct tcg2_event_log' which was introduced later,
> when some functions from the TCG protocol moved to U-Boots core, and is
> is used to measure binaries when booting with bootm, booti etc.
>
> The split led to some duplication -- e.g tcg2_measure_data() and
> measure_event() functions are very similar with the exception of
> extending the EventLog.
>
> Since the latter is a subset of the former, let's move all the members
> to a single struct and use that instead.
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> [...]
>
> include/tpm_tcg2.h        | 15 ++++++++++++
>  lib/efi_loader/efi_tcg2.c | 60 +++++++++++++++--------------------------------
>  2 files changed, 34 insertions(+), 41 deletions(-)

> diff --git a/include/tpm_tcg2.h b/include/tpm_tcg2.h
> @@ -163,6 +163,15 @@ struct tcg_efi_spec_id_event {
>   * @log_size:                Log space available
>   * @found:           Boolean indicating if an existing log was discovered
>   * @allocated:               Boolean indicating that the log was allocated by u-boot
> + * @final_buffer:    finalevent config table buffer. Only used for EFI
> + * @final_position:  current position of 'final_buffer'. Only used for EFI
> + * @last_event_size:         Size of the last event. Only used for EFI
> + * @get_event_called:        true if GetEventLog has been invoked at least once.
> + *                   Only used for EFI
> + * @ebs_called:              true if ExitBootServices has been invoked.
> + *                   Only used for EFI
> + * @truncated:               true if the 'buffer' is truncated.
> + *                   Only used for EFI

A few small doc nits:

- finalevent should be final event
- @truncated refers to buffer but the renamed field is log
- @last_event_size: has a stray space before the tab (checkpatch will flag it)

> diff --git a/include/tpm_tcg2.h b/include/tpm_tcg2.h
> @@ -170,6 +179,12 @@ struct tcg_efi_spec_id_event {
>       u32 log_size;
>       bool found;
>       bool allocated;
> +     void *final_buffer;
> +     u32 final_position;
> +     u32 last_event_size;

Just to check: the previous EFI struct used size_t for
pos/final_pos/last_event_size, and these become u32 here. Fine for the
current CONFIG_TPM2_EVENT_LOG_SIZE range, but worth calling out in the
commit message since it is a silent narrowing on 64-bit builds.

Regards,
Simon
