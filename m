Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB65D1D484
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 17:42:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6801484285;
	Thu,  8 Jan 2026 18:42:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aheyWV9L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 170B484285; Thu,  8 Jan 2026 18:42:53 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C614184198
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 18:42:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2a0f3f74587so29583375ad.2
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 09:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767894169; x=1768498969; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O0zt5qZOssXZ25MrTw186w968CpmoZDMZXhCYBzm99A=;
 b=aheyWV9LFZRGLbqOSxBs/Q+j2nADCCu81/1MMXCG1VwPcKIjbcHAfDw6CS359Eztxi
 +bd+r8muhM5sJ2lKrpl4YIRmFDD5nsFk2B9vHOp7lvF9DgHBNqEHYRKylEC1D5j8I7mR
 xpHTVJeEoxLO/EJfeTQ29OQ1yKyozHrQo5+Dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767894169; x=1768498969;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O0zt5qZOssXZ25MrTw186w968CpmoZDMZXhCYBzm99A=;
 b=pxgGZnMQuxG1rCJR99+9D8lr/g+RKoHJiOIhqZkuibbSy6UfM23/RemrRMVlsLouxZ
 yogyCDYheSN3xyuqmQvL4zLMoP3qkFIS1YP+lgpn3YBd++2OlJUALtKckd1nb+RoWU4O
 K2f99L6IHGkiFUZdhfK2HbDEMzr9veOu+A4JhUqH+Tk25UDpBbOhRrC87kXax0tHfpq0
 Apx/QK7OczzHZd7f8kmJ/p2U7ez4ZEctfzbfAKanZ42Z8pCaG3A+rMN0nF+E0DHGKnAR
 zlEI8HTiDz1+hNwZeZQBGXB6gCXSMOIMPYi+Caed81rm2LVWyWAuWim/XqgBqP0uOQio
 y88Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWE9Oc57qjNiXTx4ph7okS+vVKFa7YdmVGbHUg2TlRFBz9ShM1Rmy+tMq011PSk81bDZbol39Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yz17Gh8THtZp4A7mOVL2uZje4x7d9OleulzcalD57/jo45h3W32
 23KRM2ufPnofnRx+Ng4oP5r2W6MGL6Z7vWnd+iRzQPR6C7kLsXhGTL3lo/KHb3/FCQcIa3SZx98
 OWSHWssHDLLvoQkqxVcsw8KER4oNorcm2rJQm4WCX
X-Gm-Gg: AY/fxX4MWuWupMv+tOnOGaObtcHCCrkvIfNEzW/C/Lg6eycmd27OVbhn24QzgHspgv3
 4Zb0XAcaRxTNqLPj2yqCETuGoobP61hzhkZ2yoLNCAT48EMKWXWDtbBioYKVjBIOePfz8R9Iop3
 6bkNnUxEbk1FpgMFU/rgNHtGLgoE7c9u178QI2jzy4Wy7s2txh/8GIgNjrue0ZSr4EiFTW2TwKt
 ue7clvOkA0P5foJGeEIH5An0DVXDVVNPcE+Our3ccDuYdQiQCjIlAL2mb+m48l9jqTTmA==
X-Google-Smtp-Source: AGHT+IGaYCVH/h+OPwQbDauZ2OmonTAAmFS9rEvPN4uKOyGY3lzYE/6Lo5Xl44WQT9EpZyyUf56ZVVt4w8wtuRRw5Pg=
X-Received: by 2002:a17:903:3c2d:b0:29d:73cc:c9e8 with SMTP id
 d9443c01a7336-2a3ee43896bmr66528645ad.2.1767894169282; Thu, 08 Jan 2026
 09:42:49 -0800 (PST)
MIME-Version: 1.0
References: <20260108064947.3237361-1-balaji.selvanathan@oss.qualcomm.com>
 <20260108064947.3237361-4-balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20260108064947.3237361-4-balaji.selvanathan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 8 Jan 2026 10:42:06 -0700
X-Gm-Features: AQt7F2pW3xue4jLLIhbwNHedwiCixKD-U0dM3jOdt77spXaZ3d3lo-fg11RHVIo
Message-ID: <CAFLszTg6X8PeD4ZyY08WsTSs+qnRb_-jJjyupzSmi-jDzEhWUQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] env: scsi: Add support for partition type GUID
 based environment
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, trini@konsulko.com, aswin.murugan@oss.qualcomm.com, 
 joe.hershberger@ni.com, ilias.apalodimas@linaro.org, quentin.schulz@cherry.de, 
 ravi@prevas.dk, javier.tia@linaro.org, quic_varada@quicinc.com, 
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com, ansuelsmth@gmail.com, 
 mwalle@kernel.org, anshuld@ti.com, jan.kiszka@siemens.com, javierm@redhat.com, 
 u-boot-qcom@groups.io, u-boot@lists.denx.de
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

On Wed, 7 Jan 2026 at 23:50, Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
>
> Add support for locating SCSI environment partition using GPT type
> GUID instead of unique UUID. This enables the saveenv command to
> work with partitions identified by their type rather than unique
> identifiers, providing flexibility for systems where partition
> UUIDs may vary across devices but types remain constant.
>
> Introduce CONFIG_SCSI_ENV_PART_TYPE_GUID configuration option that
> allows specifying a partition type GUID for environment storage.
> When enabled, the environment subsystem uses the new type GUID
> based lookup method via scsi_get_blk_by_type_guid() to find the
> first matching partition.
>
> This change maintains backward compatibility with the existing
> UUID-based approach.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  env/Kconfig |  7 +++++++
>  env/scsi.c  | 13 +++++++++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/env/Kconfig b/env/Kconfig
> index b312f9b5324..97cb3d05daf 100644
> --- a/env/Kconfig
> +++ b/env/Kconfig
> @@ -768,6 +768,13 @@ config SCSI_ENV_PART_UUID
>         help
>           UUID of the SCSI partition that you want to store the environment in.
>
> +config SCSI_ENV_PART_TYPE_GUID
> +       string "SCSI partition type GUID for saving environment"
> +       depends on ENV_IS_IN_SCSI
> +       help
> +         Type GUID of the SCSI partition to store the environment in.
> +         Uses the first partition matching this type GUID.
> +
>  config ENV_USE_DEFAULT_ENV_TEXT_FILE
>         bool "Create default environment from file"
>         depends on !COMPILE_TEST
> diff --git a/env/scsi.c b/env/scsi.c
> index 207717e17b1..6182ae26679 100644
> --- a/env/scsi.c
> +++ b/env/scsi.c
> @@ -35,8 +35,13 @@ static inline struct env_scsi_info *env_scsi_get_part(void)
>  {
>         struct env_scsi_info *ep = &env_part;
>
> +#ifdef CONFIG_SCSI_ENV_PART_TYPE_GUID
> +       if (scsi_get_blk_by_type_guid(CONFIG_SCSI_ENV_PART_TYPE_GUID, &ep->blk, &ep->part))

Can you use if IS_ENABLED(CONFIG_SCSI_ENV_PART_TYPE_GUID)

(we try to avoid #ifdef)

> +               return NULL;
> +#else
>         if (scsi_get_blk_by_uuid(CONFIG_SCSI_ENV_PART_UUID, &ep->blk, &ep->part))
>                 return NULL;
> +#endif
>
>         ep->count = CONFIG_ENV_SIZE / ep->part.blksz;
>
> @@ -83,12 +88,20 @@ static int env_scsi_load(void)
>         int ret;
>
>         if (!ep) {
> +#ifdef CONFIG_SCSI_ENV_PART_TYPE_GUID
> +               env_set_default(CONFIG_SCSI_ENV_PART_TYPE_GUID " partition not found", 0);
> +#else
>                 env_set_default(CONFIG_SCSI_ENV_PART_UUID " partition not found", 0);
> +#endif
>                 return -ENOENT;
>         }
>
>         if (blk_dread(ep->blk, ep->part.start, ep->count, &envbuf) != ep->count) {
> +#ifdef CONFIG_SCSI_ENV_PART_TYPE_GUID
> +               env_set_default(CONFIG_SCSI_ENV_PART_TYPE_GUID " partition read failed", 0);
> +#else
>                 env_set_default(CONFIG_SCSI_ENV_PART_UUID " partition read failed", 0);
> +#endif
>                 return -EIO;
>         }
>
> --
> 2.34.1
>

Regards,
Simon
