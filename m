Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C444C2BB3F
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 00:46:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BB9687457;
	Sun, 19 Nov 2023 01:45:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BqcSn+pv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28CD086F64; Sun, 19 Nov 2023 01:44:02 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B633F86EB8
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 01:43:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5a7eef0b931so34749847b3.0
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 16:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700354622; x=1700959422; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JlJ+Ecoj7r3nm8ffMiWnQJCWQr0dZGdxzNU8ZArSo2o=;
 b=BqcSn+pv5j6kfBtQvT6amEaosxUDEoBwfs93x23bU91RoB22+hKLHqGB/8n3xxpW7O
 zgIVluq4TE25zMoyPcqylbxYI37ysnH1lSU6p1dvZYLdaV90tkL8oG8ngWyh7LAPQhKT
 8YlpAAbFN+hqiZA5zrmKO7HtJQQyS3016Tzj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700354622; x=1700959422;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JlJ+Ecoj7r3nm8ffMiWnQJCWQr0dZGdxzNU8ZArSo2o=;
 b=X6Wq6Ib2xPn0xaUqt5Cl8yN67zDSPexb6wjIs+oyTuT64M+irBP1qbXaaSFL4V+lCY
 b756dyB6mSlvH5sYGemudXhosURKZG4zBsbh5Fvv6xw465zn/JGOkxGgvVs1SojVAcAG
 pPY5AinIXAw7C+lxIZa6H1pSaVFqwGKNRGMuLXLuHNT8qdItK7SeBiqQJagE9RpLqjsv
 pZXHeEUurBTNrg+qxzTBdVAHdTCO9X+gTqr7gzTyivnHKlHbTku/udbySKWFibxbuT75
 GwfRuWMhCkEU7qwK6Sa/ZD2Ghx26iNc34Qb9A1SYGNWVjtjrUQ75VEc2jgrqpYBAmQpX
 JQRA==
X-Gm-Message-State: AOJu0YwFguCW5OBSZKoO4drDFL69PsfWM8phSL8JjzHqzSkeVX3CsWZH
 suZdH/L6s1P63bY1E5YuXefP1bulTZwQC71hBWrl4g==
X-Google-Smtp-Source: AGHT+IE55EmLp0HlXlBNasSjvdPiDE/Z9YNfnCVW0mgMkj7kVHW+yipuQDJ6xRX9Qymv7z9eQCikWWLgcd/mnhiqwKo=
X-Received: by 2002:a81:6c87:0:b0:5a8:3f0a:618e with SMTP id
 h129-20020a816c87000000b005a83f0a618emr3703760ywc.37.1700354622207; Sat, 18
 Nov 2023 16:43:42 -0800 (PST)
MIME-Version: 1.0
References: <20231118220313.1271556-1-i@shantur.com>
 <20231118220634.1271886-1-i@shantur.com>
 <20231118220634.1271886-3-i@shantur.com>
In-Reply-To: <20231118220634.1271886-3-i@shantur.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 18 Nov 2023 17:43:09 -0700
Message-ID: <CAPnjgZ1Wp9gU98vVx5j3ZvEv-ALVcvbjDgM8C35rwgOiDtOC4g@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] bootflow: bootmeth_efi: don't free buffer
To: Shantur Rathore <i@shantur.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, xypron.glpk@gmx.de
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

Hi Shantur,

On Sat, 18 Nov 2023 at 15:07, Shantur Rathore <i@shantur.com> wrote:
>
> bootmeth_efi doesn't allocate any buffer to load efi in any case.
> enable static buffer flag for all cases.
>
> Signed-off-by: Shantur Rathore <i@shantur.com>
> ---
>  boot/bootmeth_efi.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

>
> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> index 370d6fba9f..93f096896c 100644
> --- a/boot/bootmeth_efi.c
> +++ b/boot/bootmeth_efi.c
> @@ -160,7 +160,6 @@ static int efiload_read_file(struct bootflow *bflow, ulong addr)
>         if (ret)
>                 return log_msg_ret("read", ret);
>         bflow->buf = map_sysmem(addr, bflow->size);
> -       bflow->flags |= BOOTFLOWF_STATIC_BUF;
>
>         set_efi_bootdev(desc, bflow);
>
> @@ -404,6 +403,12 @@ static int distro_efi_read_bootflow(struct udevice *dev, struct bootflow *bflow)
>  {
>         int ret;
>
> +       /*
> +        * bootmeth_efi doesn't allocate any buffer neither for bulk nor net device

s/bulk/blk/ ?

> +        * set flag to avoid freeing static buffer.
> +        */
> +       bflow->flags |= BOOTFLOWF_STATIC_BUF;
> +
>         if (bootmeth_uses_network(bflow)) {
>                 /* we only support reading from one device, so ignore 'dev' */
>                 ret = distro_efi_read_bootflow_net(bflow);
> --
> 2.40.1
>

Regards,
Simon
