Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33516C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 06:58:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E85788B44;
	Wed,  7 Aug 2024 08:58:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZDWNvv1E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9FD488B54; Wed,  7 Aug 2024 08:58:35 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72ACE889BE
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 08:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-81fd925287eso54665139f.3
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 23:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723013912; x=1723618712; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OoA6WLjyaa+paubDI4moHs4jrevk6a1GkhhO5W6Smpg=;
 b=ZDWNvv1EmOsE2iv6L9vEdAdxJg8i6EQuHUkXxo1TmP8mLQmBIVC+PQTYaDoG6opfi5
 bnu+aOzFJzMILXlD5BUUdGjPttrQFp4eHj10vx1RWbxjdFV01ADs8PduqWrxnXIkBiU2
 upX0TOAlbKj0iawM3e0u3GXTY4dFBntxlf2cJQJVJMDKD3by43PpQJdJu4Ti+9DzKATc
 JlnXiDppv1mgcWRe3GVB/2LzTemC0/Sf4upZskK+Oyb1cZPdnsxMcl16f4ltxPZZ8xid
 AucwkNpCRNm2KtmPOJ7wHpkoHAgDz9tv9NyIo1dUZPXGTTYw60QYjbFUlcCQiAEYB1mk
 u5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723013912; x=1723618712;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OoA6WLjyaa+paubDI4moHs4jrevk6a1GkhhO5W6Smpg=;
 b=MW2gHrYAowkHFS7DUDwQSHqJ+OuzJzpSPEnXzcs6TeM7xHlia/IWlwi7TzYPI7whR9
 G9nf7h6YSjNRP4m5R3uWKBO1cqYZP2VEg9QYZIP6slpPdLB750k1Vb4eB5w198obhhRB
 w0RLD9iKorFZStadEV2vp+vgiOXA2zP/Nd6oUkYe90i8uaXT+VZs/OHEE7QVkm+btC0M
 evN2Q7zZkRk4Hs5g24rFEuoPya0dPO6LRvHS6QwUhWb3szrtlfqPFLlfDYXB/Z5gD2NM
 fUy3QC1iNziCxWCEBM4+oX4TO1NhZ7JobZnCtpvahJg/EoZ+KFrpolCD4PytZjGd5rMj
 rxEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUP/tf0w94lEvaHXTB8c4ewJToGGMMaAtpnyltgNXR8qKsSkRY7gl2vhhMfdy4IdrWJ/THz0mMyK6OD+GiACIbkx34xnA==
X-Gm-Message-State: AOJu0YzEq+G5aMEm08NYvrvQALXOX9K/I3P1Rp/tsmoicVQahkiZX2Kq
 jbuQvYshk7e2NXneHw1yFGqIcoBbjXOShBS9KjLN/dVVAoVua5T6RE0CnjzzXi9smTHX9lVGrPe
 uYxhlCzPJH1NGT2VUI7xz4hruC62rxQtJRIXsNK7rc4WBL5cqTTQ=
X-Google-Smtp-Source: AGHT+IHZcn1xuLZgRfv622AhfNIzO+Dw7xuEwJ13Nhg5GOvCFNlziJKnj3ek+faujpdj9w3ipAbFChwodKs20aQMyu4=
X-Received: by 2002:a92:1e05:0:b0:398:623a:2f49 with SMTP id
 e9e14a558f8ab-39b1fc350famr169058255ab.27.1723013911852; Tue, 06 Aug 2024
 23:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240807001345.296937-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240807001345.296937-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 7 Aug 2024 09:57:54 +0300
Message-ID: <CAC_iWjKZ1oJCOMRWBCzuL6w1ry3Q+dQEgo+Togym3sE5D4_FZg@mail.gmail.com>
Subject: Re: [PATCH 1/1] boot: set correct block device name in
 set_efi_bootdev()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Shantur Rathore <i@shantur.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
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

On Wed, 7 Aug 2024 at 03:13, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> For SATA devices the class name is 'ahci' but the block device name is
> 'sata'.
>
> Use function blk_get_uclass_name() to retrieve the correct string.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  boot/bootmeth_efi.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> index 39232eb2e25..6b41c0999f1 100644
> --- a/boot/bootmeth_efi.c
> +++ b/boot/bootmeth_efi.c
> @@ -100,11 +100,10 @@ static void set_efi_bootdev(struct blk_desc *desc, struct bootflow *bflow)
>         if (last_slash)
>                 *last_slash = '\0';
>
> -       log_debug("setting bootdev %s, %s, %s, %p, %x\n",
> -                 dev_get_uclass_name(media_dev), devnum_str, bflow->fname,
> -                 bflow->buf, size);
>         dev_name = device_get_uclass_id(media_dev) == UCLASS_MASS_STORAGE ?
> -                "usb" : dev_get_uclass_name(media_dev);
> +                "usb" : blk_get_uclass_name(device_get_uclass_id(media_dev));
> +       log_debug("setting bootdev %s, %s, %s, %p, %x\n",
> +                 dev_name, devnum_str, bflow->fname, bflow->buf, size);
>         efi_set_bootdev(dev_name, devnum_str, bflow->fname, bflow->buf, size);
>  }
>
> --
> 2.45.2
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
