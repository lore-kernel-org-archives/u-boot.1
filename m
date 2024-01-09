Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EFD7C47073
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 08:57:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0133B8789A;
	Tue,  9 Jan 2024 09:57:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PmNUVyDh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 032D987874; Tue,  9 Jan 2024 09:57:35 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F5FE8789B
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 09:57:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-50e67e37661so3253565e87.0
 for <u-boot@lists.denx.de>; Tue, 09 Jan 2024 00:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704790652; x=1705395452; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2h8BeNyAj5hhCamdrIJePWwZtMeW1E4Xdfp4Fxhio48=;
 b=PmNUVyDhEWoZEu7TTb9xBg1deKgab8Ofr8QmbL6FVkK4l5ArOI5Ns3x/Sh9j3d112/
 dP4nATQZ3yWiMJgbwE3UWdgvZvc2V3bQMKm/VhGYxMSGAarFZbnuvifjXe5WoGLeuMUl
 nO7VpcPfFvTtmWWs4GsV+g15qM8rH9KyPpTnFONIFsHnHfu0s3N9+tgyBrtzg3rsqeT8
 V3oFtoS9G2SFK37kKmFW3aExBvoEOM6FZ6/M8jmcKZ75qMB+vCKAuL6RXkJseVjFcZxA
 yR2LvXtshpu6LSe2xbHG1yyYwabMDiDdtVSu9eOaWKTL9EGSqZFlpOkox22CD1zPtPm+
 QOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704790652; x=1705395452;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2h8BeNyAj5hhCamdrIJePWwZtMeW1E4Xdfp4Fxhio48=;
 b=TBlh7gz1rmR+JUtlHxFsl8LRzYDxHYvCr42Or1s2CmAKmLZUF4c6h2pUJbgERHqsGp
 lUXMycTfpp3u0ya6gdXeCOOPuebiOqpN3Gj3ODIOG5tEKWLTLZvlhxY+bc3yIEYcvoNW
 VJOVRYZg/9VDmXvPd0ZqxgzxRESGGtlJj3Dul1b0wiHmNHrakSVoXx3Cd58PbGIRoy0C
 sxpBXLnx3lmVjgEbx+BbXKqpo20iLmSeHQgVBgIQnNCHiR3CFAobBAax7ggBxeL8iuMX
 gOf+sSX8QZQp/xbBqV5Y5WJDDpF2Ts6iwRW8DNVmPvwN5KpWEYbb77XaPV6OTg43VfUS
 Dx4Q==
X-Gm-Message-State: AOJu0YzNQ9ChgCBP5PVDb1znO79FEtMA/lA5TiasEbP6eTCzC5eVCgrp
 mUW5U5MgTH/5XRY849r42T+6TNlJBReig6AtVpLJ091cKkaDWw==
X-Google-Smtp-Source: AGHT+IHmM66KXy6dM0ieNjzC9uMx1V4vgpcuj6M1X1cu7f0Dp4VVGCbtFo/rN0HiJ53/2Rt0dLXWF/HMckrYdJaK0CY=
X-Received: by 2002:a05:6512:78c:b0:50e:7bd0:1c3d with SMTP id
 x12-20020a056512078c00b0050e7bd01c3dmr2026187lfr.97.1704790652407; Tue, 09
 Jan 2024 00:57:32 -0800 (PST)
MIME-Version: 1.0
References: <20240109085334.41481-1-heinrich.schuchardt@canonical.com>
 <20240109085334.41481-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240109085334.41481-2-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 9 Jan 2024 10:56:56 +0200
Message-ID: <CAC_iWjJX5fG3i_edtnNtGcZQPecD6Mn7_RgBKPCwqOgCKxrJig@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] lib: make table_compute_checksum() arguments const
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, u-boot@lists.denx.de
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

On Tue, 9 Jan 2024 at 10:53, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> table_compute_checksum() does neither changes the content of the
> checksummed buffer nor the buffer length. Adding const to the
> definition makes the function wider usable.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         new patch
> ---
>  include/tables_csum.h | 2 +-
>  lib/tables_csum.c     | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/tables_csum.h b/include/tables_csum.h
> index 4812333093..9207e85f91 100644
> --- a/include/tables_csum.h
> +++ b/include/tables_csum.h
> @@ -17,6 +17,6 @@
>   * @len:       configuration table size
>   * @return:    the 8-bit checksum
>   */
> -u8 table_compute_checksum(void *v, int len);
> +u8 table_compute_checksum(const void *v, const int len);
>
>  #endif
> diff --git a/lib/tables_csum.c b/lib/tables_csum.c
> index 636aa59676..305b1ec31c 100644
> --- a/lib/tables_csum.c
> +++ b/lib/tables_csum.c
> @@ -5,9 +5,9 @@
>
>  #include <linux/types.h>
>
> -u8 table_compute_checksum(void *v, int len)
> +u8 table_compute_checksum(const void *v, const int len)
>  {
> -       u8 *bytes = v;
> +       const u8 *bytes = v;
>         u8 checksum = 0;
>         int i;
>
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
