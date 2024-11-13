Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C81E5D41C12
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 08:10:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D77F88E2B;
	Wed, 13 Nov 2024 09:10:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wi+G3KVN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DF638953C; Wed, 13 Nov 2024 09:10:22 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E12F588581
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 09:10:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2e3010478e6so5282225a91.1
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 00:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731485418; x=1732090218; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iz5r1rfiX+FblBSzK9npm1h8DgXatQERme9/w5xuits=;
 b=wi+G3KVN5qoZrb+ZeHcrVcghmlfdST4Jw50eab6wIlADIkiAqlo/Wk7Zs1XtXqHF9E
 lsNu/bdub37bNdFCdzurBwyLz2ViQ5ACrMsRlH8BiWdW+CKx03HlnJgnSu8TATHikbgK
 Qm72RJBsRkV0yzH7b3LbPrb/nMczbmxPUScI+O5G5BF7us9665iDn5tGE/j7dxj2YpKx
 fLhv+blW4CDgIKTQE7B3EvX/5sgszXWaCAzE/vyaVVGVgIsOHic0GEbzJzNhPGmZJyGW
 2TCB7gcekN4lPn/WbNHpUtAfIwx+pPrSAFh3rpQ8rdqQ6QC2ImTtAkpJ30IrU95AaVc3
 i71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731485418; x=1732090218;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iz5r1rfiX+FblBSzK9npm1h8DgXatQERme9/w5xuits=;
 b=pnVCdzcaw1g4aJREyI+zJrVHtJCJUsRSgVPQqvAhkOZkVg/CH8X92egS/MItA2FoPj
 scavJgfwHeoMWembl9ZNagKRya6l4XlGF8dceN0zqhtL+yLOJBAnTs3mNS1THmmQsQ26
 bQWbZKujksihU0aPvFJzHm5DGagIl2NCrjjm5Jdg97MPD/s9d8M9h3+/OVu2rQlJ/gkW
 +11JHs+k+T+3plxhNwkyyvwZ8SX4PicEcKsuVAMyze5S9TxFxrczuA4wK8PyAQWmCHwP
 bLmV3tx4AubIiyBNfyUCg1/waGATJJ+GzXgsI6+KQsgvdRGO8CQYMqz7i0MbFxLNaW1Y
 7DoA==
X-Gm-Message-State: AOJu0YxMdc05nuRW1dZxJVy7+PM2EUwZ9/R8TcxQDHHlNWP9y+j3TWuS
 KyDZpuqJjiSlW0VqcsKMr2jnaOEES1I2DqvPm+kM9GtBrGPv1FKXrdykqoR1MFdUkTiYPNK66Al
 nKvA3BT1ii6oYrgyDXwbWips+qGpktDEO/mdEMoq7aUN5ox/Q
X-Google-Smtp-Source: AGHT+IHNl2IhddGBz5TK7DvDkR4oYL5OTUkMPlQpitPuUtxxbDtiEqoG0mulCH14HY0gLJ3rA22aHgFE0T6GDU2K+vU=
X-Received: by 2002:a17:90b:510c:b0:2e2:d5fc:2848 with SMTP id
 98e67ed59e1d1-2e9b16e63e5mr24706092a91.4.1731485418426; Wed, 13 Nov 2024
 00:10:18 -0800 (PST)
MIME-Version: 1.0
References: <20241111210959.560738-1-adrianox@gmail.com>
 <20241111210959.560738-14-adrianox@gmail.com>
In-Reply-To: <20241111210959.560738-14-adrianox@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 13 Nov 2024 10:09:42 +0200
Message-ID: <CAC_iWj+JnVRATiaZ2LGvKwLz4vd3qRuEJu96oZZBM_VHZd8zeA@mail.gmail.com>
Subject: Re: [PATCH v3 13/15] lib: uuid: display HTTP and IPV4 Config II
 protocols
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 jerome.forissier@linaro.org, xypron.glpk@gmx.de, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

Hi Adriano,

You forgot to add reviewed tags on this one.
I am reviewing the rest of the patches, so please go through the tags
and add them when you send a v4.

Thanks
/Ilias
On Mon, 11 Nov 2024 at 23:10, Adriano Cordova <adrianox@gmail.com> wrote:
>
> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> Add long texts for
>
> * EFI HTTP Protocol
> * EFI HTTP Service Binding Protocol
> * EFI IPv4 Configuration II Protocol
>
> to the uuid library.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
>
> (no changes since v2)
>
>  lib/uuid.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/lib/uuid.c b/lib/uuid.c
> index c6a27b7d04..3b2cf60fe1 100644
> --- a/lib/uuid.c
> +++ b/lib/uuid.c
> @@ -174,6 +174,20 @@ static const struct {
>                 "Firmware Management",
>                 EFI_FIRMWARE_MANAGEMENT_PROTOCOL_GUID
>         },
> +#if IS_ENABLED(CONFIG_EFI_HTTP_PROTOCOL)
> +       {
> +               "HTTP",
> +               EFI_HTTP_PROTOCOL_GUID,
> +       },
> +       {
> +               "HTTP Service Binding",
> +               EFI_HTTP_SERVICE_BINDING_PROTOCOL_GUID,
> +       },
> +       {
> +               "IPv4 Config2",
> +               EFI_IP4_CONFIG2_PROTOCOL_GUID,
> +       },
> +#endif
>         /* Configuration table GUIDs */
>         {
>                 "ACPI table",
> --
> 2.43.0
>
