Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05CE1C52D7C
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 15:58:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC2DA88C18;
	Fri,  9 Aug 2024 17:58:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XUh8iOn2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CC2C88C12; Fri,  9 Aug 2024 17:58:26 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AA5888C04
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 17:58:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6b79b93a4c9so18539886d6.1
 for <u-boot@lists.denx.de>; Fri, 09 Aug 2024 08:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723219103; x=1723823903; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kDPoYXYOYfe5V5A03IqW+DAbiXR5/PikjVwVLCzVYGQ=;
 b=XUh8iOn212PFe7P8NN9EHAL+5yk0NPcpOHh01xCzHZ7vkwWpFM9k1Q6vk2VYBRQ7Rt
 uaAqpWpZKZ+YpMC/+yLKX5eiKouTEu0NNrjnD9b/1A0cUMV/5S0TIYgqbiLv34o3XOYS
 1LrtF3gBD+vQOqDC6Ohl1e+31y/p31/P+VOWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723219103; x=1723823903;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kDPoYXYOYfe5V5A03IqW+DAbiXR5/PikjVwVLCzVYGQ=;
 b=ojsBeEy+RARHYCeM8a2gfgZ78YDb0s8KBygDx3+Re8KpNv9/5l6f6lBscZVnHjZU1H
 yqVwO0wYjbXzfzAclQ/ZwvCdj3FCWgC9olAWldfNL07Rqja9ZZimJQYfuJ71+xfDfu7x
 UDnLZLcZ5bS86Alo+avCTRN/tJ5jB/pOxqNZ641YqtBF+WB01M2DtY9l8Wpjz20SNp12
 GjpnTnk/pkCJz3+y6vaZqMbCR4W54ysNy/eIr8AHlsWbgDKv28rJfwN1NW8csASsPbUI
 VVS+9M8eiAwFZVv8nzgpnFrAIL4Ahttp27QdMZxU7oPYqTmDgv2ErCSIBQOSQJSD8vGI
 6gZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVz03dgEn3Io+Ny+3nNjQozEoYMTxumGypLkOv1o5e59Et54IA6kVJ8NAhGEoL7KHCAf9GvwD/s2cUxBMRNKjDBBKP8cA==
X-Gm-Message-State: AOJu0YyvHBBaPywI/AmqhU/hM3g/L6tefnPPrcWsxpngwV+Fk3058pod
 6cIJpasIk3bwNrpYCp4EFsz3Dv6m8NGclsnR8WpQFIhtL4p/VuhWH9BAmgmK01Y2jqHfLUMFJMf
 8DZMo1YaGNV6Ui4AqnyrEvfgNldhD000otgP/
X-Google-Smtp-Source: AGHT+IFR8aSthdzfkI8yiYcaFGl0a900MhJ+8Ryj+JaHwiu1xHlbsvF+btY/wL09CFXaLApZWe2puFm3TmRZwt6NaA0=
X-Received: by 2002:a0c:f413:0:b0:6b4:e21c:d46f with SMTP id
 6a1803df08f44-6bd79c3d61cmr27748016d6.27.1723219103421; Fri, 09 Aug 2024
 08:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <03cdd29b-331c-76b0-f6d7-a064552ffd67@marvell.com>
In-Reply-To: <03cdd29b-331c-76b0-f6d7-a064552ffd67@marvell.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 9 Aug 2024 09:58:12 -0600
Message-ID: <CAFLszTiCS-jRfL__PJ=uEQf0rUKcw4J8czp-=khzkHB=q9ySOg@mail.gmail.com>
Subject: Re: [PATCH] env: remove vars that are not in default env
To: Ravi Minnikanti <rminnikanti@marvell.com>
Cc: Tom Rini <trini@konsulko.com>, quentin.schulz@bootlin.com, 
 U-Boot-Denx <u-boot@lists.denx.de>
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

Hi Ravi,

On Fri, 9 Aug 2024 at 09:38, Ravi Minnikanti <rminnikanti@marvell.com> wrote:
>
>
> current env_set_default_vars() doesn't delete
> var that are not in the imported env. hashtable
> removes vars that are not in the imported
> env but present in the current env only if H_NOCLEAR
> flag is not set.
>
> This change is to avoid passing H_NOCLEAR flag if
> specific vars are passed to env_set_default_vars()
>
> Test:
>
> Without this change:
> Marvell>> env default boot_mode
> Marvell>>
>
> With the change:
> Marvell>> env default boot_mode
> WARNING: 'boot_mode' not in imported env, deleting it!
>
> Signed-off-by: rminnikanti <rminnikanti@marvell.com>
> ---
>  env/common.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Could you add to usage/environment.rst and also update the tests for
this - test/env/ - I suppose your patch fixes a bug, but it is hard to
figure out what it is supposed to do from the docs.

See for example dm_test_acpi_cmd_set() for how to check output from a command.

>
> diff --git a/env/common.c b/env/common.c
> index 8d47d72605..2f783e3a69 100644
> --- a/env/common.c
> +++ b/env/common.c
> @@ -401,7 +401,15 @@ int env_set_default_vars(int nvars, char * const vars[], int flags)
>          * Special use-case: import from default environment
>          * (and use \0 as a separator)
>          */
> -       flags |= H_NOCLEAR | H_DEFAULT;
> +
> +       /*
> +        * When vars are passed remove variables that are not in
> +        * the default environment.
> +        */
> +       if (!nvars)
> +               flags |= H_NOCLEAR;
> +
> +       flags |= H_DEFAULT;
>         return himport_r(&env_htab, default_environment,
>                                 sizeof(default_environment), '\0',
>                                 flags, 0, nvars, vars);
> --
> 2.25.1
Regards,
Simon
