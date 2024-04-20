Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23B8C4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 14:58:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE16C880D8;
	Sat, 20 Apr 2024 16:58:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iDzsG+Fg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4E7188113; Sat, 20 Apr 2024 16:57:59 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DD7B880D5
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 16:57:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a44ad785a44so288859866b.3
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 07:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713625077; x=1714229877; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nmifAR8yd5ygH5ZnUtYAQqguZt0Ir3weHHAxfhYUGvI=;
 b=iDzsG+FgA+eNDdFTUIsg9I15xQmma1mD7my3JVc03Nk64AHCZEUuSa300jRtpHF96f
 fh/XeCNHqWD8dOgsDYsb3DmcIAu0eK9LBM2fdat477X+KemfTipkVD76o3Vrfo5jdo9s
 etps9925sgygxVaA5l68QDTeTvKJNPEDgz62yOL3h+dJ8YRkLV99pPXWG6lIgp03a5+z
 UBRD4v6kI9gWZUoNLPzaisL5w6InSASJnZTTa1ZxuweuwvT8koe5u2s22Wjk0mir1Rf1
 0+lX75W390bu4XLvBsKww9O1wj8ZWMQVQyUIyDkrkCaP9X9Dtwu1XJvhMQLYhoRA7J8J
 MMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713625077; x=1714229877;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nmifAR8yd5ygH5ZnUtYAQqguZt0Ir3weHHAxfhYUGvI=;
 b=cwWEdhFHEHzFBjK5rQtzt3/YOoOiF99hKJiGLvV5LSjefq2LShoQYR9kPc3xHH057E
 NA8UJ1VstRa6u9v/ELzZoETbgnvYp1isbgquWHEU8LpFHHk2YmsyZOuqtPJCOt/RFSwW
 qlfxSReBZWlfv/934iJsG189eiLXCUcHrw317i/gxPRIitT2XQzX9mQjY78mWZ1Exrt5
 ZEzA7Mkq5R8mDw+AtrLT/G1RXxiyYmEDDVrHMPQ9oKWFEWN7Z669rbWrHC6fgnkO5hsK
 cVfRu3odNRO60s3luolnvXKkMZUvKB0Vnf8VPfMJk12CQyFvLSzs/EZGy8zMiJYOUDR0
 kEcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0CoKy5QeTKhdBgLqhSksf28vhCrKQ+M69nJFinBiiqEVpZAPcPm9GQvOhkDp6m/7df1+LmqnLCpyDwCR+0yufAgoVzg==
X-Gm-Message-State: AOJu0YxuNqXwNiG85VjLp6qXPjm8BI61y32j+YmnuHhC63TZvcCDaiOj
 DXdhFajQw6JsW+ynyzRBbJo8QKbkuoncbCYGQa59rE4xMI3OjUilfQasQmGOqzoM/cGWZZbZo1O
 KFOimsGKL9dr4owySBwfuljFOFZ7QnLpYP7glPA==
X-Google-Smtp-Source: AGHT+IG6QM4fxDQ0NVf09SG4+POb/hKodzjl5QWqK+K6Ye5MvUTpbdJMj9OeOcT9O3rQ2sNIqjrX7hNMxmYay9UsyGY=
X-Received: by 2002:a17:906:a92:b0:a46:d041:28e0 with SMTP id
 y18-20020a1709060a9200b00a46d04128e0mr3246403ejf.59.1713625076870; Sat, 20
 Apr 2024 07:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240420140616.121072-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240420140616.121072-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 20 Apr 2024 17:57:20 +0300
Message-ID: <CAC_iWjKSfEZxDHM18F4NdvH9hjpPOhmg_3hMpwxL1E8QNBZY2Q@mail.gmail.com>
Subject: Re: [PATCH] cmd: terminate efidebug test bootmgr early on error
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>,
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

On Sat, 20 Apr 2024 at 17:06, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> If efi_bootmgr_load() fails, there is no point in trying to start an image
> that has not been loaded.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/efidebug.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/cmd/efidebug.c b/cmd/efidebug.c
> index a587860e2a5..5103ada29a5 100644
> --- a/cmd/efidebug.c
> +++ b/cmd/efidebug.c
> @@ -1397,6 +1397,8 @@ static __maybe_unused int do_efi_test_bootmgr(struct cmd_tbl *cmdtp, int flag,
>
>         ret = efi_bootmgr_load(&image, &load_options);
>         printf("efi_bootmgr_load() returned: %ld\n", ret & ~EFI_ERROR_MASK);
> +       if (ret != EFI_SUCCESS)
> +               return CMD_RET_SUCCESS;
>
>         /* We call efi_start_image() even if error for test purpose. */
>         ret = EFI_CALL(efi_start_image(image, &exit_data_size, &exit_data));
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
