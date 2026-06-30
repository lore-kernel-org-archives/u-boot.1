Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC86C43327
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 06:24:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEE25849BA;
	Tue, 30 Jun 2026 08:24:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vMFVIgf0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C7B3849F3; Tue, 30 Jun 2026 08:24:28 +0200 (CEST)
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com
 [IPv6:2607:f8b0:4864:20::b134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA1AF84979
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 08:24:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-664cb440f9eso1788071d50.1
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 23:24:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782800664; cv=none;
 d=google.com; s=arc-20260327;
 b=GwQrQXViFN8wTtGhgtc8fb38q+//kDbgF7ECOwKKLwIm88Orbs+MoGkvQEOML6d4oL
 o0SqjiUjutWGQQq+0y1rdbvs0Q1ePnfSM6gaWRtav8w0olGyTIwVbl0yfw8pivtGDGLg
 amw6CMS0qBvYBWl27aY3xQDZI0CLdl6bao553C4bsuYuZ4C5v/cZyyCI3Ts8g4W8NUqi
 +RRqmqrePlp8fD5myeaTpe5fCriKHBcmvmqx4WHHxdPpD739dLlB5frjunn9L+S9jkI6
 wnJ378ev+1pklO+u8QolFCtPLcRvmgTUJNXjV90pK7vsuxW/ueOMAOZYFmVDji9HOvD+
 Ts7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cxWJU6JH6KDDKSk0nvE7ztLcdbT/Q/bZongvJKLTNPM=;
 fh=zTVi6mshrUeJ9QpeCSAV/3JF/7JHMQRxX3ysVuWRZi0=;
 b=NGtFOd4zM9z/aprXbWdceyIpvx1sxdm9pAoTLcT2qCPbeGMgQqsPt95K/8/PFsdWFF
 iYxVoTI5ZJREy2nUfi/1cvstFOgi42poxkzU9WMaFK/v70yWlXWDWUnkN9odtZ0cMvaW
 KJ+tO4N7YH3GJYStgJBA0tyZ4QaUr0XER+asVGmpKeARkzcaJKm1l+sZSLzNcYUzjh9M
 wSkjWyeru0B1Mi32fJFG0CqPlDiwbHnuqd0FFsItpDykLTE7ZsANNwdSuy9GIizAHSf0
 GDZbA3Em+osiGm0CkbX0s9xL444neo1N5QTwdttxWh70pIPVS4oLwyOsiDSIv+rKEjTh
 MWlA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782800663; x=1783405463; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cxWJU6JH6KDDKSk0nvE7ztLcdbT/Q/bZongvJKLTNPM=;
 b=vMFVIgf0itqq907I2TXc8b+jIjOccO7Zo4BjEbb9rMdMWWtgoDEH7UwzxM/GlTIA0H
 t19ZrQeo1cPz/owL77Ton2OgCtEpaxCU5vw7VTfXc1RYBmgRtsPxW2OY2Bx995rwIbfi
 Xi+jMjqpX+ORTFX7jmTCRHyfkNXrnVjhCPRxEY4l1iYow24V4s8XXOojjDiZrrtFBWe2
 8/qSu9dTPFAtzV1AzttJedogPsDlHGThM+yIBUoWpxzSQzMe8xnl0IiWidisdGC7Ylsg
 Swguo5G/jvVqBA5SL3BSyu5g2Kvqf9KqptDNGysvRy8toO/DNUJPymoHyF3DHSoVlGpu
 Vesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782800663; x=1783405463;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cxWJU6JH6KDDKSk0nvE7ztLcdbT/Q/bZongvJKLTNPM=;
 b=G3UI2nLAugktLNxeEEhRwYvozCgcJxkLlxrpHnQz9di8bM7436RMbWmcJkCGX+esvR
 Cc3kWi0kFo6QYtcPGFTXCV+0bl67vbNQRJVW7LCJ9+GuUoDT1LGWmijjPIZAWIjmLqem
 ekFBH3L2baqAqy4ikju1UQu5wxerMIn4t+dJnMjUUjREloi8wEHdrDlp/zmInX8q7h/K
 EY2KOHV/mXm2Y8d9W44JjkQ7LqTanURzv/YhW09P3TYIgnFySSQt2l3aJI9SoSeMb6zp
 p7hxZo4GeWSPQYiCxa5IKweunt63bVoVBpgmW4liFfC2qp7xIjKYYoKDB4Oz68+8IwMz
 /S6w==
X-Gm-Message-State: AOJu0YzQSRKIuuBGeD/+sJT2tSsvnbfb+/n+wQ0syquQg+r0n1SJMenQ
 kjrgzbPIoQ7L+wZL5uUuLu+76WlDUyTsR48Gh4jw+7ZgQXsTdkKWgaEeSfkqJl8tWWU7rUT9T+o
 8Tau0NxG+jGGPaM0tW3cuHFBMoPoV5LJE7jMvyTNMUP+dJug0QPHf8vJQdw==
X-Gm-Gg: AfdE7cm1SKPOpOBmmEn6Y9WdYgC6s5LiAhgQ5Ywj0G+kLX4mwASgO3TN+VR6dC99WWV
 kPMF3a1FKsqlhdvU2wzjBwlu8OuKonlXfJL7hzVUE4lIH3NKqK/TPF/jG/0iyxiwjjlwH/lJ6Jf
 mKPODUsCBVDWef4gEDNQwI8WzKXcTgk9IBX83jben46or384dLWUon9lfTSEGxUhL3HjCLBXHwe
 FEdGKvh3C685tH0ECrdjbUahOE+BjlxQhhJgnm/Cy8rL7aQ//7sv6BUkfCV0TMxqBu4IGChiv7b
 s5XnXXuOAgKVYkUXvHf9xjA4ijy1yftLYE8pZXK9QnTlgaTXGdiH3Myr9KorJAC/2k9LAHmnSW8
 ps0SQ4LRO5B2K9G2VGh+56wBOs708e27+YHaF/6LAouXtPLLBaz5rk+NtTUhfQvEbvNAFK0PsvN
 LsvQbZtWMka/iwnVKG/nS+P6iA73+aLOFPjnI4x4/P38NWS4mTt+vCq/QpsZjO3WsITxiiiIaSv
 NOiZTYJh8mMUNr3TMVg0gexyapS/MfCFTwbrqoRIpzt1OpfFP5nVDvbLa0MbgUeRBElcYmYJUbD
 QpsfbxGOrr1YHnEPCwLIhL3A1hDjYLfOfMPBjpzpCkP46mj0ZAD4h6f5+VCwuvPRT0Hp2Cw=
X-Received: by 2002:a05:690e:158b:10b0:664:ae68:ca03 with SMTP id
 956f58d0204a3-664f9a64d6amr1930091d50.73.1782800663570; Mon, 29 Jun 2026
 23:24:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260629233514.211746-1-heinrich.schuchardt@canonical.com>
 <20260629233514.211746-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260629233514.211746-2-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 30 Jun 2026 09:23:47 +0300
X-Gm-Features: AVVi8CdkCvyWfDH0kzkV3FWDY5Yjlyd23PHUH9qICHwBg1MQ4_aFa9sGEVcTKhA
Message-ID: <CAC_iWj+4jPsbgEJ=eAabzMO=xZSyNM0nQxb=UbXa=HykaKJASA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] efi_loader: fix buffer overrun in
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

Hi Heinirch,


On Tue, 30 Jun 2026 at 02:35, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> In efi_sigstore_parse_siglist() sigdata is allocated. But instead of an
> allocation matching the size of sigdata, tainted external data was used
> to calculate the allocation size. This may lead to buffer overflows.
>
> * Correct the allocation size.
> * Follow the man-page. Use the structure size as second argument for
>   calloc.

I think the fix is correct, but the commit message might be misleading.
Looking at the values sizeof(*sig_data) is 40b, but the
esl->signature_size - sizeof(esd->signature_owner)) is way bigger and
depends on the actual signature size. So I dont think something bad
really happens apart from wasting a few bytes of memory.
The actual point of the signature size is correctly allocated a few lines below.

>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

With the commit message updated
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
> v2:
>         no change
> ---
>  lib/efi_loader/efi_signature.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/lib/efi_loader/efi_signature.c b/lib/efi_loader/efi_signature.c
> index 93a4f257016..6aff5c14a89 100644
> --- a/lib/efi_loader/efi_signature.c
> +++ b/lib/efi_loader/efi_signature.c
> @@ -703,8 +703,7 @@ efi_sigstore_parse_siglist(struct efi_signature_list *esl)
>                         goto err;
>                 }
>
> -               sig_data = calloc(esl->signature_size
> -                                       - sizeof(esd->signature_owner), 1);
> +               sig_data = calloc(1, sizeof(*sig_data));
>                 if (!sig_data) {
>                         EFI_PRINT("Out of memory\n");
>                         goto err;
> --
> 2.53.0
>
