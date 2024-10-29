Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5909ED2AB11
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 10:02:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C83CB890D1;
	Tue, 29 Oct 2024 11:02:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BjH7nqPY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A69EE87BF4; Tue, 29 Oct 2024 11:02:33 +0100 (CET)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CF4D89070
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 11:02:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-72097a5ca74so311802b3a.3
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 03:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730196150; x=1730800950; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kof21xtc0Dx0H3EztM/ZUHzjpH7Sc058mN11rB1ZXNk=;
 b=BjH7nqPYdKt1ldU83U/92tHsTswGVMEkNn0ITskY20eDnuk8hXNKb8hdeBVkTdxOSJ
 poK7d88T7tdwfvvNUm2g8jS+6w3AayaRtmY4jXWzMbzdQc+KCb5tRYZwEIdq4mXOJ74T
 5DIscxZdF/pay/AQl7H6poaZEaYheI5tktv10CApptHLnRcQIT99TcfaoOM40vbs+N6o
 ZsOG7bNRsC006iWOspTmBRfTBKUDVBICwtQ79WULlY1mTCUDh8mRhq9fsdlMPASqRCah
 n/rBP8xNUypdT9uN76T9KUl0l4LNct7JZoGx2Exd0jfJGqZnb/UZexYOiJzSnH1NNXk5
 YU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730196150; x=1730800950;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kof21xtc0Dx0H3EztM/ZUHzjpH7Sc058mN11rB1ZXNk=;
 b=IlSruW5fZ/r84omKhvooD2agNuzaVzs2KBrZgbLmTvNh0TjvMdCuUCWGUt+eZCZVbu
 wlN0sLUOZRI45rFzpX3e7Ym7mG26QsjOgVPKxSDLc1pLLe4BBzdALiX8qfol9Q6y6PLz
 bvkYGOhDzf5zSHFN8PWr1vOT8l2pcII3urKiMWo5WM9SwIkWPzbRRyd+m4aiRjXdodRd
 c+D9sG4FiEZfN8WRvJhd4YoCYF474+gBYgjyMRANB/0h7YCBKqXQKmSW+uIk+f2hDQ2Z
 97MdR3Y++cKxt29BXdARRYJiaYhJWj4yg83cAx9EmpWzYGP7o8g5hyXHn0KjvRAxKjDC
 xg/g==
X-Gm-Message-State: AOJu0Yx3Wz4au33XkkXn5oLE0CmEwDt7ZnlxE2KPdiSK+UxATNgcImkb
 1sB1eAezCVh5oUfyZONO2RQ4WcR0an75NzMqh1xWlhhhN8FcLJeinPSib7DKa7TthKawCVt4TVH
 L8xuzZoxgMLlrBa8lB7pZ/TxPYMYsToby0gs2AQ==
X-Google-Smtp-Source: AGHT+IH8p6ojuDvYxw4eGWQr/1Pu0ndptFbzXSabj8Z4ff/4m74kXv7/T5/hcgtkxRPJ3wf6qjae3iHVq7MoblJyOw4=
X-Received: by 2002:a05:6a00:124d:b0:71d:f012:6de7 with SMTP id
 d2e1a72fcca58-720630a82b9mr17091790b3a.27.1730196149887; Tue, 29 Oct 2024
 03:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <20241028124815.47262-1-sjg@chromium.org>
 <20241028124815.47262-10-sjg@chromium.org>
In-Reply-To: <20241028124815.47262-10-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 29 Oct 2024 12:01:53 +0200
Message-ID: <CAC_iWj+H_m3jiQ-Q-BK=9vtdMEnw0GHyQT2_LFHUYyEnnZh3EQ@mail.gmail.com>
Subject: Re: [PATCH 09/15] efi_loader: Fix free in
 ..._media_device_boot_option()
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>
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

Hi Simon,

On Mon, 28 Oct 2024 at 14:48, Simon Glass <sjg@chromium.org> wrote:
>
> Freeing a NULL pointer is an error in EFI, so check the pointer first,
> before freeing it.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  lib/efi_loader/efi_bootmgr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index a3aa2b8d1b9..431a38704e9 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -1180,7 +1180,8 @@ out:
>                         free(opt[i].lo);
>         }
>         free(opt);
> -       efi_free_pool(handles);
> +       if (handles)
> +               efi_free_pool(handles);

We don't need this, efi_free_pool() checks the pointer already.

Thanks
/Ilias
>
>         if (ret == EFI_NOT_FOUND)
>                 return EFI_SUCCESS;
> --
> 2.43.0
>
