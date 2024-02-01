Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D655C47DDF
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 08:38:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1A4487BE5;
	Thu,  1 Feb 2024 09:38:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eLr9IwI5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D20C87776; Thu,  1 Feb 2024 09:38:49 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6494287BE5
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 09:38:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-510218c4a0eso1643643e87.1
 for <u-boot@lists.denx.de>; Thu, 01 Feb 2024 00:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706776726; x=1707381526; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kMfYAwDOBoXwWRKoBH9DyKjXlyWhS0fIm2mLQSS0MZk=;
 b=eLr9IwI5HW/+KUdr4pSgUZbic1IZbNrxRbyGVtj6sNNLk2x30XlfBLiosRrp5p4NKx
 7tKZPpcl7FTaQvPRznKzGDKxRzJDTg1wK3dCaDV81Kev6OJKGW5UUw1cngztDuu6rThM
 Q/GkRBFQBHqhzgYAr9Fab7kP+fx2wKF7zLaiPsG759JhTgjVFRrkngVSRfh7UNV/+xxO
 XL5CKe4Oy7Fid/aTpm2w3VRN/JTwCnNUWSl824w8oi5Lqse/JXCWlt94l7dqbbRmKSza
 sJrtJISo2fZ5hYwqn1i0GUYfLky1f6JWw1KA8c0pkTAebcVtnI4S73d94C0Nz3ks38Cp
 WoSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706776726; x=1707381526;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kMfYAwDOBoXwWRKoBH9DyKjXlyWhS0fIm2mLQSS0MZk=;
 b=LA4a4Ca3+ivH7o7HfAP+sRpLUDB0t61W0Xmybx6oLtwVI9HNi733z+Rla7ztXdGExu
 u95Z4nkcy83Cjsb1H6xV2F1WXWw2ejbgTdUQqkyEuf04pcuiRqL0qeGQ+3lkEH9uoRa6
 uRe4UPIiHMH5itHMdHEbsSKIjs+VGeFKHnvafw5+UeITAZyAuXc3Rkej4QQ+bjf80Lxf
 vQRaKMdCGHfGesap2B9RIzzvknN0eQ93vXX/YRCEYR9ECBEQk3jpKgRRfAQWxxp4DYkL
 JecS7cghbvUSmf3ylIVJFzPxHwiaKWOxl1kygV6dy816cKrS6s0etJ9UupYX2Seg/8ic
 AalQ==
X-Gm-Message-State: AOJu0Yyde4daqgLN58TvDds2g3SlEBskSOtyVwhDgpaMwQmYZUFf2+WI
 dOx4Px5Zn0Y8ikhYBSqJj8oh30vwTZ3JqaiEAipqPNGPDdsIXVl6tC+B9HNo2PYPvDNSX+zs3wW
 2seC1H3nBQOz/2wU6YU7j4AKaRG3Xp125tu6AyQ==
X-Google-Smtp-Source: AGHT+IEiCZ3MjZxcbovHMf60hwh1bT/18/TpMABmgn18rcUcCvpvwkSqbNnbnEx1fJqtAlVt8JPK2KfyqxXxgE48zDg=
X-Received: by 2002:a05:6512:55b:b0:50e:797c:249a with SMTP id
 h27-20020a056512055b00b0050e797c249amr616733lfl.12.1706776726620; Thu, 01 Feb
 2024 00:38:46 -0800 (PST)
MIME-Version: 1.0
References: <20240129210453.31070-1-heinrich.schuchardt@canonical.com>
 <20240129210453.31070-5-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240129210453.31070-5-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 1 Feb 2024 10:38:10 +0200
Message-ID: <CAC_iWjKrkF6rE3poDrN69BML3dpST5g5BJr+wNFOY8hikbXJJg@mail.gmail.com>
Subject: Re: [PATCH 4/7] smbios: string table always needs two terminating NUL
 bytes
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
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

On Mon, 29 Jan 2024 at 23:05, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The string section of the different SMBIOS structures is always terminated
> by two NUL bytes even if there is no string at all. This is described in
> section 6.1.3 "Text string" of the SMBIOS 3.7.0 specification.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/smbios.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/lib/smbios.c b/lib/smbios.c
> index 7bd9805fec0..81908e89610 100644
> --- a/lib/smbios.c
> +++ b/lib/smbios.c
> @@ -311,6 +311,9 @@ int smbios_update_version(const char *version)
>   */
>  static int smbios_string_table_len(const struct smbios_ctx *ctx)
>  {
> +       /* If the structure contains no string it is followed by to NUL bytes */
> +       if (ctx->next_ptr == ctx->eos)
> +               return 2;
>         /* Allow for the final \0 after all strings */
>         return (ctx->next_ptr + 1) - ctx->eos;
>  }
> --
> 2.43.0
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
