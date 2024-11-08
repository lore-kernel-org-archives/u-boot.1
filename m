Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6717ED5E15A
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 11:41:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB6828903B;
	Fri,  8 Nov 2024 12:41:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IfTyp81M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54E95890E4; Fri,  8 Nov 2024 12:41:55 +0100 (CET)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28B3D88FD0
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 12:41:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7f4325168c8so327556a12.1
 for <u-boot@lists.denx.de>; Fri, 08 Nov 2024 03:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731066112; x=1731670912; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+JMAF8RRKXA1uy25PVYT4S/d6YvavfUFnziLKr/sf2Y=;
 b=IfTyp81MwmkJv75ar0cqLWInv4FXVsZP//TvJFBuBl6CKX8ExIGbm+Kr4DGmP3QRVN
 hVdmUUoXdSqYDqNy6EqUP18Ysfa5+6i44fbgd8zKBFwHFNHnFkwuyKtFLPdJdAJH4xlw
 q35ZVXT1TxYzQ0yzXslXEnRL4tnzsiyME01Vx4FAYzz+7Rms9rTjyHRukYG0XLe8Evdj
 hmCvMgNGRJ1zNSWf9cDj4cyJ5PiIIe90P1eVW9jtTXkQBJ6mYOUbmEp+wlrJd060ZaJT
 NRUJT9DgEwybul4dTGu63ryWZfHh3IdVWzMzqdJvakGeI8rTGPss9zbeF4SqL0qon/26
 UJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731066112; x=1731670912;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+JMAF8RRKXA1uy25PVYT4S/d6YvavfUFnziLKr/sf2Y=;
 b=TgmOp+JXsSfyMJOBTBX93FFh1Uq2oqRJ/d4J0ZxyIzFD7aJXtkQBJBnZtNeeFf0UXU
 xH7OQ3bBKVygBMU6QYIM2c6gnTsIt1jK2ecDiOvqtTdFwhnSh37ukcBMW6oj52HXvaaD
 LS/wryNUhtgECAhtBw2PHJ6F0Imkz23BVLdfGNFgF0KbdUzIk0EpOQAzmjcp6QcL2Bem
 fpGrszOYQmYBwAVeIOGyaLczZuCVKVRl7EqmCU7lwm67jQ/NwRr6BkyFnjQaXYZBnN9N
 qKKUvQQKYjL0J23KF2nIgkx9FLUEqCiKVf7gXNXjlC636t/H2+qpBTnXWinuMEDgWOqB
 VO+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfbjZP0AvxZJdyLoYWix7KPRUyVneDlEGs1zZFh1acmZt6wiXXv+NrCvexXgA1UOs9x/IBvis=@lists.denx.de
X-Gm-Message-State: AOJu0Ywhf3cxkZcV9OUlfiwWlNeNBR4RhcyuTR8wXOTrUH2mepkx8r86
 VTaDmdLM7d9/lpnn20TZw0RX9gaynCLiaZzDQkTWWvT7wQxJ0rhRfxQ1PWb7aI34LFB4BADOtky
 16zCdbzFrImh1NB/uU1/BTnfu5WfrZcFZG8HN4A==
X-Google-Smtp-Source: AGHT+IGPmW3Tf3whM8lOartVRwWR02k4m/5cenmZhKdcjBgCPKIvFdZ2yhjyewQyT6lUYJqLVwTBQzeVbM4Nz2yAqQ8=
X-Received: by 2002:a17:90b:4c48:b0:2e1:a81f:5520 with SMTP id
 98e67ed59e1d1-2e9b166bbaamr3832566a91.1.1731066111687; Fri, 08 Nov 2024
 03:41:51 -0800 (PST)
MIME-Version: 1.0
References: <20241107093854.42184-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241107093854.42184-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 8 Nov 2024 11:41:15 +0000
Message-ID: <CAC_iWj+eA6q+O70xzqv=MbY_wPQmNAHogrcoHkTJPtM3rMMdVQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] fs: ext4: correct error handling
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de
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

On Thu, 7 Nov 2024 at 09:39, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> After calling strdup() check the returned pointer.
>
> Avoid a memory leak if the directory is not found.
>
> Reported-by: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
> Fixes: 22fdac381f98 ("fs: ext4: implement opendir, readdir, closedir")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  fs/ext4/ext4fs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ext4/ext4fs.c b/fs/ext4/ext4fs.c
> index dfecfa0b4e8..1727da2dc6d 100644
> --- a/fs/ext4/ext4fs.c
> +++ b/fs/ext4/ext4fs.c
> @@ -213,7 +213,7 @@ int ext4fs_opendir(const char *dirname, struct fs_dir_stream **dirsp)
>         if (!dirs)
>                 return -ENOMEM;
>         dirs->dirname = strdup(dirname);
> -       if (!dirs) {
> +       if (!dirs->dirname) {
>                 free(dirs);
>                 return -ENOMEM;
>         }
> @@ -224,6 +224,8 @@ int ext4fs_opendir(const char *dirname, struct fs_dir_stream **dirsp)
>                 ret = 0;
>                 *dirsp = (struct fs_dir_stream *)dirs;
>         } else {
> +               free(dirs->dirname);
> +               free(dirs);
>                 ret = -ENOENT;
>         }
>
> --
> 2.45.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
