Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873BACCF9E3
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 11:57:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12274839A5;
	Mon, 10 Nov 2025 12:57:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="C1e9rPDN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AC1283980; Mon, 10 Nov 2025 12:57:54 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A652B83A84
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 12:57:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-787d5555274so17283207b3.1
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 03:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762775870; x=1763380670; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yst4qoJUUPMScq9jrDvT7/JeAZmJihfMIeomcQK4lN8=;
 b=C1e9rPDN2VjTveZOL5jwFbOySUNJaC8vQxYlSv6bQXd7WQoxtj04e8Q2RREctuzhih
 sCgPSQX6dPU2hM2bUxdJeL9XSkE+NrRApy36bTLhZ6oVmtdHAHg0J7sP3VL784sKarll
 k/Pvm2CQGCreNtMiGseRcB7slCuSVlnxGMR+w43PF18LC1inDepF/d/y0wN4CcW2mCV8
 q9cA0RV1q6HF7wj5qeRl2QH4UZ4ZVHFUOinKtZJmULvlt8pE5SE1ku3JBs0QwZWc7gcG
 cu4SYEzPHRGdgxa35msGnOOLcE3cFj973JUY9kiHElWOH+VfmAwfw9DYOo1DhbTPU4XP
 a0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762775870; x=1763380670;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yst4qoJUUPMScq9jrDvT7/JeAZmJihfMIeomcQK4lN8=;
 b=ZXxOPFGJx/ZtPU2YMXGYe9DtQ1fzgJMB6cBPOFreYnFlBhUwnzsADUFd245M2OT5rV
 Q6pK3EiMuNgRd2mUZ1jm+pU8gP5wBT586W/Q46+/MMAGuX78KqnM74LhQMbuT55pReeW
 P4WDFtgU4ZIpZ3eC729mh6HbcW14oD89apfYDNAhJdsCA34hcMjeDsm/J/xJoOsWw3xP
 E2VOZnNUlXHZZlXkvv4D17ejfkyJ6KgnDu37dzEPs1H/8AcRSvHho2v+2+5I0eGt30y7
 uZLKa98fK3y0CKNw7sqXJjVSdoNho2/+EsuqCs3Eib3rDw7hRJprqKDBK3EnDWP4mIDi
 VExg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTaVA29dl4Ww+cOJII8ICRh84mqWL+mdGLaUOSCcnQYc3FEGguA17htKs2nsNKdj7XMJt1z0c=@lists.denx.de
X-Gm-Message-State: AOJu0YyftUp/t2HavqrayB638rDZ5C0YOmr15dDDlZaQ6P1FU4iJt6k9
 Tk4B6vZTsP3CuHn2RiGFpiLGbcNLYwlmXWmtc9BJjAyZjTaZ+D0yUrVBTdHKGIIecmxkLoA6Tqi
 0dbpdmttewrFybP4NpEpQImPOJZU2v5oZV1L6Cv4yfQ==
X-Gm-Gg: ASbGnct6MvlCMBqQ0WyJH0ndxvYnJRRI4bkPHZtrOYbrffmNKH6fAS4a2Ja080rXlf/
 GWip3yvBNeKrYos+sNDDpSoLAOvEMwwLJdx4KpVUOqjgHlckq9cxeGXYd9j7B/jyTVhR/bFCCUO
 W+GmTVA5Yh/tmtJ78xNE35HHmTGWMCIbaX0cO8cJb3gvZ7VXWALFNZZ7fyT6tDqPvjcxYVlmOW+
 9m76vkSq8cAG9OMJMawH24Tqd5jBRT+OmcOCKWQk1xXeo17GXIChTpOt7GaqPSaQkZqWMkZEenA
 pUB5sv31THfdtTMpl+EiAT1tU9Y8i5lNz6nu6LYdAwUSEm6BOAA=
X-Google-Smtp-Source: AGHT+IEGK4iQcXDZYr4nZLGmdyCHRbvyK9tdiFZxeKzzm5ciOhXR8yeRjDw46KxjtxPpT9KA+qTHQn2jjBu7ZHpjZbA=
X-Received: by 2002:a05:690e:244c:b0:63f:b3aa:d9e with SMTP id
 956f58d0204a3-640d4540be7mr5640770d50.23.1762775870435; Mon, 10 Nov 2025
 03:57:50 -0800 (PST)
MIME-Version: 1.0
References: <20251104232933.88528-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251104232933.88528-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 10 Nov 2025 13:57:14 +0200
X-Gm-Features: AWmQ_blcRhpYb89OEUGd4w93lealjtdjtgRGs1ga2OK1wdtrqhJRMEVY_n8vOiI
Message-ID: <CAC_iWjKX4nuQcLbRkbQGTb0v_D6jJH=gO0uHvQiva1n_DUuT5g@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_driver: correct formatting in efi_uc_stop()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

On Wed, 5 Nov 2025 at 01:29, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Correct indentation.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  lib/efi_driver/efi_uclass.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_driver/efi_uclass.c b/lib/efi_driver/efi_uclass.c
> index 7392c60f0f9..bd46c9f5539 100644
> --- a/lib/efi_driver/efi_uclass.c
> +++ b/lib/efi_driver/efi_uclass.c
> @@ -227,7 +227,7 @@ static efi_status_t EFIAPI efi_uc_stop(
>                                 goto out;
>                 }
>                 ret = EFI_SUCCESS;
> -                       goto out;
> +               goto out;
>         }
>
>         /* Destroy all children */
> --
> 2.51.0
>
