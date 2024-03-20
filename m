Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC4DC54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 21:19:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 322CC880AC;
	Wed, 20 Mar 2024 22:19:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZW3DIXyO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0E69880AE; Wed, 20 Mar 2024 22:19:02 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8018788076
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 22:19:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d48f03a8bbso13068321fa.0
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 14:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710969540; x=1711574340; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=09y7SbDjRuERh5zC9zDDHpoqhkmibAnfTZp7vSPypoc=;
 b=ZW3DIXyOYVuPW0opuEICZmVY8rNDq0J1ZBGW5Lm+tk96gl+54rVYZx5H7oG3KW+2WM
 EGiY5OqJflBt1p1BYHiAHeImBXzwy9sz8gqRa4aCpeBtMkMwbge94fz1QxK/OT+z9jaC
 UUSOJni9OvRGltdpFxDXe7LWqWE0GhTtaj8x1DGdA2asW1i+iJWXkRIE7Jc0jUSFxJg5
 LUys3B9GzfZ0J53V/rCUWfDphMjBXI4tqbd24XapFRF7Vd1blqw4Bb8uxscONa15QdK0
 yWpEUwK/X0Ugdhhdr1v2l56oIkM34Yn+jPM2ablLWn64scnMGvRhsz6u7V3TskEXiQM+
 VQrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710969540; x=1711574340;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=09y7SbDjRuERh5zC9zDDHpoqhkmibAnfTZp7vSPypoc=;
 b=O/0ZHcr4NUyrasLFATWb1O4HKQ5Ow/Pi6fv1sucLqh9VhU2klLkEWp2/Z8fInD3A+H
 UHjzsHTnTpUa0ChGDwSVbJefXczN0L3dQFFi+m08f5l+jOGR44qQHYv8jiYZ/4Q8w3bP
 w6Gbhf42oYcNg2BoQHviWNPXzP7SlVHRoE7tMae/ZFMirOrjwSIUih6QCbc2eEN7SxMY
 aslXY9kIcTPLA6UqnS67NcLbJbGeDEOxVgG866RuecI1i7FoDlz4U4oUfmFivQnkwjY/
 aAUZydbuxoqCURcgbbuGf3ZMdnzDGtvVbtNswH+y5yAdfXJDkCsDtqeT8tvBgoyuhQcj
 vn9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLXrHsFxb43yaA657FA2uTllhfoGQw6FJlrTPl5nt9xT0kp173szfQjbFpvNrYm+tufXkmS2JA5yu60aZtbRqtGM1hmQ==
X-Gm-Message-State: AOJu0YyAI/UJx0mRm9hVsOn8TGFTBaD5kH76p63DicAAN2SQsa+uW8eR
 XpkVsUCHhkkLvnltxUfLFBozIQhPsGMbe7LSlKflviYCQrSovGtOkxQ0caxkKBovjfIDFV+V6Ma
 OEqAZxwY0e64wJUZ25xy/wF+4vV5NCjTKKQTMEGpYIY5Aw47AG3A=
X-Google-Smtp-Source: AGHT+IGxya+FV1ImUsm+IMAQPYk406VXFPaL5NkX4XS3FOgJwHMN5l2zrxEUQ3nTwDqOih7p8wXgYYNQ4iQLOQYd9Zw=
X-Received: by 2002:a2e:9ec5:0:b0:2d4:86a7:19be with SMTP id
 h5-20020a2e9ec5000000b002d486a719bemr249856ljk.24.1710969539761; Wed, 20 Mar
 2024 14:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240316093644.54869-1-heinrich.schuchardt@canonical.com>
 <20240316093644.54869-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240316093644.54869-2-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 20 Mar 2024 23:18:22 +0200
Message-ID: <CAC_iWjLGBTovX0etafrD-TxDbXB-HfiibH2AE-WcYLSeRU_kTw@mail.gmail.com>
Subject: Re: [PATCH 1/3] efi_loader: correct handling of EFI binary return code
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, u-boot@lists.denx.de
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

Hi Heinrich

On Sat, 16 Mar 2024 at 11:37, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Running an EFI binary loaded via tftp using the bootefi command results in
> showing the usage help.

The commit message sounds a bit off. The real problem is removing
protocols from a non existent handle right?
The help message was fixed in a subsequent patch

With that fixed
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> We should not try to remove protocol interfaces from a NULL handle.
>
> Fixes: 6422820ac3e5 ("efi_loader: split unrelated code from efi_bootmgr.c")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/efi_bootbin.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> index 733cc1a61b5..b7910f78fb6 100644
> --- a/lib/efi_loader/efi_bootbin.c
> +++ b/lib/efi_loader/efi_bootbin.c
> @@ -125,7 +125,7 @@ efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
>         efi_handle_t mem_handle = NULL, handle;
>         struct efi_device_path *file_path = NULL;
>         struct efi_device_path *msg_path;
> -       efi_status_t ret, ret2;
> +       efi_status_t ret;
>         u16 *load_options;
>
>         if (!bootefi_device_path || !bootefi_image_path) {
> @@ -172,11 +172,17 @@ efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
>         ret = do_bootefi_exec(handle, load_options);
>
>  out:
> -       ret2 = efi_uninstall_multiple_protocol_interfaces(mem_handle,
> -                                                         &efi_guid_device_path,
> -                                                         file_path, NULL);
> +       if (mem_handle) {
> +               efi_status_t r;
> +
> +               r = efi_uninstall_multiple_protocol_interfaces(
> +                       mem_handle, &efi_guid_device_path, file_path, NULL);
> +               if (r != EFI_SUCCESS)
> +                       log_err("Uninstalling protocol interfaces failed\n");
> +       }
>         efi_free_pool(file_path);
> -       return (ret != EFI_SUCCESS) ? ret : ret2;
> +
> +       return ret;
>  }
>
>  /**
> --
> 2.43.0
>
