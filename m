Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D07CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:50:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7A1586F0D;
	Thu, 12 Oct 2023 05:46:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H4CS3aQ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2296586EE6; Thu, 12 Oct 2023 05:45:19 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDD6586EAA
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:45:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5a7c08b7744so6699567b3.3
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697082308; x=1697687108; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OsuTO0+p2ksF/cl+0vfa6pax72B+0O0zbBzExw4IOL4=;
 b=H4CS3aQ+DJ9sDsx4QHRXZzmnGTAMKj40wXKKJNRbbC3GAAvWjjOiMzymB/yZX/h5Bs
 tKjwLSv92i7fCMe5Q+Jn/NtKktjh9FddjkiRKzor28+YXKDNoArJZ69Lcl1CoYe/k5tU
 m4Vmy/v7qfvyKaGkxDkyO2Q2MhPCzwZUKWUeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082308; x=1697687108;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OsuTO0+p2ksF/cl+0vfa6pax72B+0O0zbBzExw4IOL4=;
 b=p8oSqHF7HYyShKiSHGJhViQzoNUMkvyq1U7ufmZzof/iklOH9pLhB8XhWlgDmocyuB
 920mcHaP4lKkTGte0lM/WeYt29ATZnj6nhGaQ6ugzCW44I88vdidfuW21ld9fHfVBBzu
 fWZAGtm2LaF1rwXZM49+bCk0C6AwCvdUf08HAwnTrOsRpxp5ZUwEZQ81KErQP2mhKSlX
 dt57+iKq1ZnjwKZpevV5zWUJg0Cb9yzDbES6vE30lBwp2w6Wj9vsRFzoCl6akwy+hJ3I
 aq4vlAp0pL1PFNufxdwnzY6QhGZRK1HX9w8TA3px00+8c0eZNWhz3jf8vLYxon9Davjm
 CgtQ==
X-Gm-Message-State: AOJu0YwOzoxj5VP5p0oeWKqbl0HzlU5/p2D9vuRF5onvQMP/g/JQqQMs
 Pl8IH4sQOoSJhB+GRpUU4gozeDaPlzWZUT1cLPhLkA==
X-Google-Smtp-Source: AGHT+IHMh2qaPkBoaY8TXSk98KLi7rjyCWmYD8LegaoStgRd2I24LYlDW61aVH93eOnFeonj92FpA42JZ37GZnAIdYE=
X-Received: by 2002:a0d:d70d:0:b0:5a7:bbca:8c9e with SMTP id
 z13-20020a0dd70d000000b005a7bbca8c9emr7718379ywd.7.1697082307973; Wed, 11 Oct
 2023 20:45:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-17-seanga2@gmail.com>
In-Reply-To: <20231012015626.3487451-17-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Oct 2023 20:41:26 -0700
Message-ID: <CAPnjgZ1_cS9ABEr=2zgZVjhkdk=XWgdkWZiAMT__C_E2QozA7g@mail.gmail.com>
Subject: Re: [PATCH 16/26] spl: Don't cache devices when UNIT_TEST is enabled
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>
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

Hi Sean,

On Wed, 11 Oct 2023 at 18:56, Sean Anderson <seanga2@gmail.com> wrote:
>
> Several SPL functions try to avoid performing initialization twice by
> caching devices. This is fine for regular boot, but does not work with
> UNIT_TEST, since all devices are torn down after each test. Disable caching
> so we don't use stale devices.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>  common/spl/spl_fat.c | 2 +-
>  common/spl/spl_mmc.c | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/common/spl/spl_fat.c b/common/spl/spl_fat.c
> index c6e2526ade1..8bec9cce5ca 100644
> --- a/common/spl/spl_fat.c
> +++ b/common/spl/spl_fat.c
> @@ -24,7 +24,7 @@ static int spl_register_fat_device(struct blk_desc *block_dev, int partition)
>  {
>         int err = 0;
>
> -       if (fat_registered)
> +       if (!CONFIG_IS_ENABLED(UNIT_TEST) && fat_registered)

These sort of things worry me, since we are bringing test code /
conditions into the 'real' code. Is it possible to pass this as a
parameter, or adjust the value of fat_registered?

>                 return err;
>
>         err = fat_register_device(block_dev, partition);
> diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
> index 67c7ae34a58..a8579e29dee 100644
> --- a/common/spl/spl_mmc.c
> +++ b/common/spl/spl_mmc.c
> @@ -417,7 +417,8 @@ int spl_mmc_load(struct spl_image_info *spl_image,
>
>         /* Perform peripheral init only once for an mmc device */
>         mmc_dev = spl_mmc_get_device_index(bootdev->boot_device);
> -       if (!mmc || spl_mmc_get_mmc_devnum(mmc) != mmc_dev) {
> +       if (CONFIG_IS_ENABLED(UNIT_TEST) || !mmc ||
> +           spl_mmc_get_mmc_devnum(mmc) != mmc_dev) {
>                 err = spl_mmc_find_device(&mmc, bootdev->boot_device);
>                 if (err)
>                         return err;
> --
> 2.37.1
>

Regards,
Simon
