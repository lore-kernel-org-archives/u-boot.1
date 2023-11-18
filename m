Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0B0C54E76
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 07:52:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AE3387087;
	Sat, 18 Nov 2023 08:52:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w65qjf4a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32D3487087; Sat, 18 Nov 2023 08:52:23 +0100 (CET)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1267D870D5
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 08:52:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2c871d566cfso9693601fa.3
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 23:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700293935; x=1700898735; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6sXXX2XDs8FRJb/9A7RUb3GOPeculnUbHhOp6W06ZSE=;
 b=w65qjf4aAr13HzIvhSJ32Y62SrJ+VhG3XZSw0h6Lmfo9sfDOTPrMJr9AF+1+QXFl0s
 w664fnosj9KgsAkbFbQvYjmvAhIpXWZaQH18CWWBqvkm0hIZ1UQwa2qWghC37fCX2VAT
 OuqVkGDer/5EAjzPlviRhIDK1tncY0A6ScI62KpbXlNC6xkBmK7CWuVscj9Nr9Rd9JX8
 nfX6GbehEdENX77yvf7N/dUsyCkj3pYdO6LV7rWv/u/5LimBnrRWeBonPPxnc7A1UgrX
 HkVEhbcVE1ULvp4bq8zpCyKI8/4YdJ+OltDYD8LoMSap8sGLkLn0YZiKBKAgpsFCVlGI
 va+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700293935; x=1700898735;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6sXXX2XDs8FRJb/9A7RUb3GOPeculnUbHhOp6W06ZSE=;
 b=IZn9Pj9RQqh6y73jAbdquP9Sld7VxUC3McwYeWuusnaKzrjuzfcqSeb2P6+75yULKK
 3x9I0xtW16RgaHL0sanLK7hcdkkGBX9wma+zQ6y1B9UiBb6W6pr8Y8juCXQ01JHaZyR6
 LuwXT/EfcyHueBBlufsDHELwbp4j1elm57a78Wd5kG00f5odeVs1um0S5PBVnpYOu7NX
 H6wXxAa4LW5n6kptzZW595xNH+KzgAmfRbABlzdB123C6i+3/CNaM4yz9R0zI1E9ozCV
 wCMmHma59hxlt1G3TLOIBwqWJtFT3+z8HMRjQ9COLQZIg26saWZzZ/xRNCCv+zBd+ri+
 1Dsw==
X-Gm-Message-State: AOJu0YwE33v+UMV8/WB/PBhA5pRyspSEYGtsb7FUmVa7QKk6+BGxYlEE
 ezhYya6/iKPqiP6I1ZESNdEXxPw/VpB+DokMMAONKA==
X-Google-Smtp-Source: AGHT+IHGmFB/cE6iYCiPCDOGQT0eELDJSD0ZRSqT9KVYfjZyWH32RsWfiRNW73xU0TG/y6bdIEV2IWK2Yqql9En3a3E=
X-Received: by 2002:a2e:8716:0:b0:2c5:18ed:1809 with SMTP id
 m22-20020a2e8716000000b002c518ed1809mr1346693lji.34.1700293935358; Fri, 17
 Nov 2023 23:52:15 -0800 (PST)
MIME-Version: 1.0
References: <20231116041043.362055-1-sjg@chromium.org>
 <20231116041043.362055-8-sjg@chromium.org>
In-Reply-To: <20231116041043.362055-8-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 18 Nov 2023 09:51:39 +0200
Message-ID: <CAC_iWjLtV4V+kumuXzWQ_2v=G4d37XZ-eTPL9kyHrefwdb1LuA@mail.gmail.com>
Subject: Re: [PATCH v2 07/32] bootm: Drop arguments from bootm_start()
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, Eddie James <eajames@linux.ibm.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
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

On Thu, 16 Nov 2023 at 06:11, Simon Glass <sjg@chromium.org> wrote:
>
> This function does not use its arguments. Drop them.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> (no changes since v1)
>
>  boot/bootm.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/boot/bootm.c b/boot/bootm.c
> index cb61485c226c..fda97706fc26 100644
> --- a/boot/bootm.c
> +++ b/boot/bootm.c
> @@ -69,8 +69,7 @@ static void boot_start_lmb(struct bootm_headers *images)
>  static inline void boot_start_lmb(struct bootm_headers *images) { }
>  #endif
>
> -static int bootm_start(struct cmd_tbl *cmdtp, int flag, int argc,
> -                      char *const argv[])
> +static int bootm_start(void)
>  {
>         memset((void *)&images, 0, sizeof(images));
>         images.verify = env_get_yesno("verify");
> @@ -783,7 +782,7 @@ int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
>          * any error.
>          */
>         if (states & BOOTM_STATE_START)
> -               ret = bootm_start(cmdtp, flag, argc, argv);
> +               ret = bootm_start();
>
>         if (!ret && (states & BOOTM_STATE_PRE_LOAD))
>                 ret = bootm_pre_load(cmdtp, flag, argc, argv);
> --
> 2.43.0.rc0.421.g78406f8d94-goog
>
