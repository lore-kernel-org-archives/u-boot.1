Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46509D5AE7C
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 09:57:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE70289242;
	Thu,  7 Nov 2024 10:57:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="f8tw1Tmg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D4D889247; Thu,  7 Nov 2024 10:57:09 +0100 (CET)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCE9689032
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 10:57:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7f3f1849849so597149a12.1
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 01:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730973425; x=1731578225; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4FPnBrZ40E1EvCsLcW8drn17RCqUp3WRlqDlYrCHaQY=;
 b=f8tw1TmgnXJpFG/01aL5qqxY+qihXO7H34Ppy0hHopew5xiGzd9RAQJhyQbgBzvnCo
 DE32T8xDnTL9D8TU7x83tkVJayDAVYHge4cWSkVswjWhF0vfU/t2rLgF6U1ZuaiE44e8
 00L/anMY9X1523Xi6b5cAK/cDLg16mJN4tiAB0S7mNmj+Uee2uWfM7MlOe5idQAP53ON
 +ByVzDYbOZvghyYYwEvqRivA4MZaQ6hn1ChacGSjQ72uJxNk0FXkuz2/OlqncvdXylIP
 yZmiWjRzVRAs4/IiCjqvUfbyV1qXmhc6K5ZPPijQhjPdviOz5zzpESI1TnDIrTXlXbND
 WXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730973425; x=1731578225;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4FPnBrZ40E1EvCsLcW8drn17RCqUp3WRlqDlYrCHaQY=;
 b=R+kD45zCQtY2focyyVQMds9MQRW41C+jx3Sn0uryjxQu0FxYJ4qdKDWFGUJdv7K9ex
 2wCUpa8iNFdB2NIN2hVWs/vVjokP/jytd1BT+TrcWfEJ4p+o4jRdcpH1IPEa8R8fcxUh
 dm9/0G3GMVbmMzgMQSpuM/1/NDS922Rs/tPlNoLXgfwqLQt9N8Bvb3sMWsOwYwbOY9Gk
 i6V2UW0G4I1mxXwG4RZ72e/qsbrWNxSlVAzWxeffBJc7IuCUgs3CLJtl4dOca0dgF9t7
 uC1X17O6+c3GFgcMNCT8tVhdY47xrHQmDRbudFb79AVZ7hvM97sFbbkrb3bz+uK1+VbH
 kViA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0mRmMoRitLpB3V8RzIG8K2i0/PLXqz7VUtxoFPwDFhs4V3pEEFGwLodeunfIoMwwIWBF65Gk=@lists.denx.de
X-Gm-Message-State: AOJu0Yyb+KL2YzO4v/UcQC9B2AfObOnQx2NLSE1lKni0bNTg/jAjfqBs
 xk1jDeFOfBMtjqMPDh4wa7mLvsCxpPngCD2ECE3RvbjYOiuNTyRMVeYqf2cklo4iU4DNtMGqONx
 /KBrGRDz2JW0qf8830vAAndZy/iOMBGCS7cpFbA==
X-Google-Smtp-Source: AGHT+IFofQNGpjOGLExUjKHel76+w3m/HSXIsqcvmgfeYv2avQEv3W/O1o7i7kSx188anqjkoIOOYNNMyNC5TZcPfvk=
X-Received: by 2002:a05:6a21:3384:b0:1db:dcc6:dd39 with SMTP id
 adf61e73a8af0-1dc17a82fb1mr689837637.26.1730973425403; Thu, 07 Nov 2024
 01:57:05 -0800 (PST)
MIME-Version: 1.0
References: <20241102064127.41571-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241102064127.41571-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 7 Nov 2024 09:56:28 +0000
Message-ID: <CAC_iWj+RvycgEoFZXbs8G4YCY+k6jwLzzWj5WAp5xpu6D17xww@mail.gmail.com>
Subject: Re: [PATCH 1/1] lmb.c: add missing comma in lmb_dump_region()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 u-boot@lists.denx.de
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

On Sat, 2 Nov 2024 at 06:41, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> In the message string " %s[%d]\t[0x%llx-0x%llx], 0x%08llx bytes flags: "
> a comma is missing before flags.
>
> To avoid increasing the code size replace '0x%' by '%#'.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/lmb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 00c8888936a..95adf2e93a4 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -97,7 +97,7 @@ static void lmb_dump_region(struct alist *lmb_rgn_lst, char *name)
>         enum lmb_flags flags;
>         int i;
>
> -       printf(" %s.count = 0x%x\n", name, lmb_rgn_lst->count);
> +       printf(" %s.count = %#x\n", name, lmb_rgn_lst->count);
>
>         for (i = 0; i < lmb_rgn_lst->count; i++) {
>                 base = rgn[i].base;
> @@ -105,7 +105,7 @@ static void lmb_dump_region(struct alist *lmb_rgn_lst, char *name)
>                 end = base + size - 1;
>                 flags = rgn[i].flags;
>
> -               printf(" %s[%d]\t[0x%llx-0x%llx], 0x%08llx bytes flags: ",
> +               printf(" %s[%d]\t[%#llx-%#llx], %#08llx bytes, flags: ",
>                        name, i, base, end, size);
>                 lmb_print_region_flags(flags);
>         }
> --
> 2.45.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
