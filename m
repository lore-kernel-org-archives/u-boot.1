Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE84C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 06:43:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9383E84979;
	Tue, 30 Jun 2026 08:43:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Pzkx2M72";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD666849BA; Tue, 30 Jun 2026 08:43:31 +0200 (CEST)
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com
 [IPv6:2607:f8b0:4864:20::b132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75C8884942
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 08:43:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-664ae993e4bso326603d50.0
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 23:43:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782801808; cv=none;
 d=google.com; s=arc-20260327;
 b=lIdWyX988GJmEyVyy8y8ZKcc+hFBR3DKLaeiDqWu04HpSVMdQMw4seqOUTQfHgyKNh
 xFn+r6D4yJmRPX2pePlN0lyL94eWg0favOc4c2w7nLXcO+KQNXKX0bOymJidUDRmzyGg
 MPz0CXZLTyD187HfrZT0elXKGf803tMr5Yj2YedGGpGJ7h9Gm5V5lmwoqu7GvYyHKFJB
 G1RijSjiY/cAdyez1Jn8QfShEHRpMc6Ljv0a4HhGhH1FNZ20kk4VBei1OGGzYW7agpbH
 CxC5J/g+ZrvzgGLuoqNV9rnQgzMWqI66UU5jdrFG4QAu8brrlD7yu9xzVVjVQDmpAO8Z
 eclA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VHhVxNAMxw7QFv9SYXS9bwlDFViR/zQJgRDrbTPaPCI=;
 fh=zTVi6mshrUeJ9QpeCSAV/3JF/7JHMQRxX3ysVuWRZi0=;
 b=G49xzaMqHgvtjxPx7I+LDE0EI4KCukGMC7CXpu8oVye4mTyFTgw3Mu4HyyMzdBJfL+
 qFeCVuUV5yOFE8ukGlmnpLFKz9ZdGQPdQYIaavQ+OZFmowqnCCtPS0CWqB+xqrqFuSqD
 XNJnoOTw5azNHTfgi28sR0cGfc4X2hBIMxSP7qx4RATqkpdlcCMfrC9fDKdCbKE7X6vD
 4mIE3VOhmRKyE6cOfvyKienRt4PE6JGWj9LNwc3ilY7pmNY2NgVZXdBH4PDMGqLnxiiG
 LMQegJxOBao0EcR8D2jLe9IKGcX2z6COK5y9cdK1rRmUOW8dvQXwkA9WFu/Xd5SxDZ3n
 NN2g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782801808; x=1783406608; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VHhVxNAMxw7QFv9SYXS9bwlDFViR/zQJgRDrbTPaPCI=;
 b=Pzkx2M724YynwM8i0t/Yla5KyqeGuGzTlfSlDaZox23ewtouhMQNiQHTNpHzksvmZD
 IKWuA1NLoKtGQoWBFVdV4PBFT+oGbYLkVdVNlprH3ci11aTrlMxKtM7xcohiUKmkFPrL
 uij36Yi8nwzjew9wsY/pFp9/e/992obCre1p2ZXPq+2msU7bZcNv4t/m41IpCzl82m2K
 x87zOrjL/f7YI4D0KLlBUWi3dg7UQP2yapvnZS4zxni0y6IcHQQ9mPlCkV28wMHrwC0Z
 3tR5HXpC/6POhKrLkowl/8i8YO7wOSOUOOVR08q93/jsZeaKFpJZd/paZDlvZJMFbjW0
 KSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782801808; x=1783406608;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VHhVxNAMxw7QFv9SYXS9bwlDFViR/zQJgRDrbTPaPCI=;
 b=QQjOx8Q4SwCQVc2V5IVYnckSyKkom2nYYZTmUBW1V545dajodmahraWX2Qi9UuKsji
 jBFxQ9C1hMnuOz/DQ/Nrilac+/6hPwO8OyjkEkwRWVZy+wfnZhPjemv7M8tDzPrY/GYK
 CV6DRJ7l6BiPQxCYfUh35FIgWErTYvoQ15QYnH83vMjjS6Qz874/cWQM4yYGAQcUpzBB
 caUbySBTWVUArLHskW09j6U78tmNSQIUWCiFqki8RsYr5VREjswEwpvINGeqR3x9b6LV
 vDX+Y9zPXte4Ne4FzZ+tCZyw3S+rrTSw565aN8gJKuPWAEVHefvRTJEvdef7yG6Lv/x0
 bJGg==
X-Gm-Message-State: AOJu0YydBEo94Do2x7ipTeupaxjq+ybAxTVbDsBQBKQ4TKgblVxzSJTO
 tQTxz25eoixPExJZ2Z8YLDU/TLoj//YSMMhrbKO39xh7FHfysG+iAWGp/tIfytHpI4ksK/KBhR5
 RiOarYIMZwwTuuTWz9/mdTheduPjoiZA9EpQGBtQXGypL8JLpMqgT+jgvcQ==
X-Gm-Gg: AfdE7cmZ9tcKsI3lCEE12104dW9wYSVgY6WlI52tkeccKjQ4ritmkNg+r8kB8l4wn+Z
 B7YUh8m8UmgZUHcx0O4Fx6umtnCuSEn6qPS7LA4FNkgkjBMIGefiVqdzsXukb5weFVJpfBXSy6C
 UsdOlSdBI6ZwDK0f5GtVcfvy3X8GzJc9GjC8xs9GnOVQwSM1g387VuIqF/m/Fc7ylgltkX6UVra
 4Sw+tViHRCQk2z8pQkGEkRChQEyPY1E4NGrOvVYYdH22XFa0YdXk6BjipVd2M4ILx8Sa2NPprLi
 wpo2fFxtTZub4PZWjn0t8N9Go0zMIsNHNlcVFG7Ac/X7T2YEJZyjBRpHA6ffk+tKJK4xCL7Y5Iz
 0BCYJMyy2poXjs4I/PlPdZ2HDQEj9J1G2m2EB/CqD0OTZAuQbIQuVvzGg5cPo9QaJHCkCeEa3LU
 Fvnj7MFDkeMwXoDBJx6SIMcZkIG2NRzJM72ZZL9r9UbVltMcvzn/HIuQqgA7NCJ/BIDZkbsDqEu
 P9aHyctBwBgfPnWTOWDydPMRZs3Is0G1jzEr/pKoKT2a2JdkOVG4w+sX/Ifn+Kgx+4M75cxOA2C
 DJ90rhPFTKF7wjfLz14rm9GICGH4nigbJX2fDJLpS9gQI27gF7b7n88Z5vjgrQSz0M1FFjo=
X-Received: by 2002:a05:690e:128e:b0:664:cd96:8577 with SMTP id
 956f58d0204a3-66507c00459mr455302d50.31.1782801808228; Mon, 29 Jun 2026
 23:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260629233514.211746-1-heinrich.schuchardt@canonical.com>
 <20260629233514.211746-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260629233514.211746-3-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 30 Jun 2026 09:42:51 +0300
X-Gm-Features: AVVi8Cc-tt4--_dz4V4XgokUxE70K4FKnQXSEuRey6CeLiLdJ8IBzVLmQc2aRPI
Message-ID: <CAC_iWj+y7uA+B_1bsJWk1pQ+H1_7Wd9n1uRrL82-gS+8WrgLDA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] efi_loader: fix memory leak in
 efi_sigstore_parse_siglist
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
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

Hi Heinrich,

On Tue, 30 Jun 2026 at 02:35, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> When malloc() fails for sig_data->data, sig_data is leaked.
>
> Free sig_data before jumping to the error path.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         fix typo in subject
> ---
>  lib/efi_loader/efi_signature.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/efi_loader/efi_signature.c b/lib/efi_loader/efi_signature.c
> index 6aff5c14a89..1da656161bb 100644
> --- a/lib/efi_loader/efi_signature.c
> +++ b/lib/efi_loader/efi_signature.c
> @@ -717,6 +717,7 @@ efi_sigstore_parse_siglist(struct efi_signature_list *esl)
>                 sig_data->data = malloc(sig_data->size);
>                 if (!sig_data->data) {
>                         EFI_PRINT("Out of memory\n");
> +                       free(sig_data);

I think the problem is bigger than just the last node here.
efi_sigstore_free() walks sigstore->sig_data_list to free the
allocated memory. However, that's only assigned after everything has
succeded.
I think we should move the siglist->sig_data_list = sig_data_next;
within the loop and let efi_sigstore_free() deal with freeing memory
on error.


Thanks
/Ilias
>                         goto err;
>                 }
>                 memcpy(sig_data->data, esd->signature_data, sig_data->size);
> --
> 2.53.0
>
