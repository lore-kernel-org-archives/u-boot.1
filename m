Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9161BC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 01:36:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A79E98774E;
	Mon,  4 Dec 2023 02:36:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eRycRkaj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 955B98774E; Mon,  4 Dec 2023 02:36:11 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D69D876E0
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 02:36:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d03f90b0cbso7438395ad.1
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 17:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701653767; x=1702258567; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=opvjqL6YlYNbGPtNxP6+IPJKYjqBwzCl4dINfH70WmQ=;
 b=eRycRkajvDmx9Xm0OZUgkzfs000ogiUPTxrl1m/2+z7gBfhEbshPXm7DCsmi4GKSiV
 H4HogQ8Bc9APxaT6KJFeJSEixtitu8CW8NO4xXFs6bdDUnidN3wLo1aeWDxsk7NsXsQL
 Z6L9D0lLjfloh9RVBfMYJv79w7mIl1nuL5DsgKQW5UcWmEHldb52vUISCY9u7SitXaHH
 FNYhjPn6kXf68wbMlnEOakmIxopThFDMLHXQZPy8LOAT64tpuwPPDfE9Bfm3NYH73Ccp
 9W/8WXD7xBMDZg22HWzA2WKEpCgenFZCTN4geYW92GzFHsP3KorrheSJHuueZ1dc+waN
 /3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701653767; x=1702258567;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=opvjqL6YlYNbGPtNxP6+IPJKYjqBwzCl4dINfH70WmQ=;
 b=Lxfk2xgXULFztECa7cYCRuigZC6j00gNGMRNrqxWA1If/2bxIa4h6FEs0H5ubo7ZXM
 0KbqIwYhfN3P821V9I60wpKvV9pVjxHkeYgN3/5/34C3gLYcW576K7Y4t3iBtzj0xVeq
 TvKYwnHfO/bgSNwudgMQS9NZHADr1Oseyo+H6DLuBFsKRoE+zXjfG73DRq+sZ0/8WmVY
 b82rHuQZRvEQgMk3nyiH7yCa8pt2fXAB1iltzgM1yZ4KDQcUDiBmbljssoJalClt17mc
 lq5/2OgVPActmYBJRHA93WA9eSkgm+qmylXF4oWlbshGtk3/NgKD33Pstbn0Mz+x+Eon
 v7SQ==
X-Gm-Message-State: AOJu0YzSF8/UVeyKfHw8tPL4ozx1IeBVAUrSdSXGekgGIO7Pyvtp/GJV
 iIaher/QU6Al9rMKL2/q7y2ZcHf0XtKQ9XH/CK0=
X-Google-Smtp-Source: AGHT+IH4gFugTqFMsL/g+xUBfGKrfHzzF0a7nIUs3x+BjByBEMWYPeTwm5kUTESnmcdBPS0or2B7ty4OuOjFTIH+OiQ=
X-Received: by 2002:a17:90b:2d86:b0:286:abd5:e061 with SMTP id
 sj6-20020a17090b2d8600b00286abd5e061mr1609324pjb.4.1701653767470; Sun, 03 Dec
 2023 17:36:07 -0800 (PST)
MIME-Version: 1.0
References: <ZWy2Chxgz9mRxGQN@arcana.i.gnudd.com>
In-Reply-To: <ZWy2Chxgz9mRxGQN@arcana.i.gnudd.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 3 Dec 2023 22:35:56 -0300
Message-ID: <CAOMZO5Ajq2L9-pNLqq0JGUmWdn5Lw=SeQsoZZ1YNYJbC1gJZQQ@mail.gmail.com>
Subject: Re: [PATCH] tools: mxsboot: pre-fill buffer with 0xff, not 0
To: Alessandro Rubini <rubini@gnudd.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>,
 Rogan Dawes <rogan@dawes.za.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Alessandro,

[Adding Marek and Rogan]

On Sun, Dec 3, 2023 at 9:24=E2=80=AFPM Alessandro Rubini <rubini@gnudd.com>=
 wrote:
>
> The tool works for me, with imx28 and NAND memory, but the resulting
> blocks are reported as bad, both by u-boot and the kernel.
>
> This makes it impossible to erase from Linux (for an upgrade without
> console access, for example -- u-boot can "nand scrub" but linux can't).
>
> pre-filling with 0xff creates a proper boot loader image, but no
> bad-block marker is there when written to flash.
>
> Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
> ---
>  tools/mxsboot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/mxsboot.c b/tools/mxsboot.c
> index 04d86f87a8..8f4018aa56 100644
> --- a/tools/mxsboot.c
> +++ b/tools/mxsboot.c
> @@ -478,7 +478,7 @@ static int mx28_create_nand_image(int infd, int outfd=
)
>                 goto err0;
>         }
>
> -       memset(buf, 0, size);
> +       memset(buf, 0xff, size);

This makes sense:

Reviewed-by: Fabio Estevam <festevam@gmail.com>

Thanks
