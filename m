Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14793C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 21:17:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B02387880;
	Sat,  2 Dec 2023 22:16:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PIv/Yfsq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 775C38787A; Sat,  2 Dec 2023 22:16:42 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 972B48641F
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 22:16:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40b4746ae51so32989115e9.2
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 13:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701551800; x=1702156600; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l85Ngjo1oFNNqlwS3rdSTmDXvQOWz9gRQko5hygQZck=;
 b=PIv/YfsqDQVx9gpABqe4wtaenKaBYQX10Lfwp663hp7/S/5vuIud6wukV5eW/uDQMN
 2juJkzdLmCVZJA2UmT87LogkvYlNQxMNhq07XjHSfzxVBatlHK+cV/2cLeDmlbqqoIIO
 gPg9oMSDQEcZhkFTt993qT5Vi3DINkTPyhEJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701551800; x=1702156600;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l85Ngjo1oFNNqlwS3rdSTmDXvQOWz9gRQko5hygQZck=;
 b=US+VqiKsRt1dgESSW5vlD65s4AXHvZMOxFsScCKHKeyiTHvXFTZIY3N3yqPyeWMCrN
 1VxVjMZ30BLD3EN27N4t2vZURzJGBM+4dg51jUnDzKsG78l+Nqntrcj1IeBltwh4gxqF
 Ge3RxT9koyMFGEqLAPGUNAS9WlVpKYe/3RJk666EQr4Q39xbeJ+JQ8JKKkZp7F0SAXXj
 CX4mJluIKnHhkHKy5qdoNhc9FV/8skbeTfn70hiCiFl72At5F4H77khsmxm774afuIoi
 DPRK7rU8ab6eDKGGKbKtxLLZbSpjVqoLeXSrcd+1m1wiBhxXOG3GAd5qtTb79CFcmSmW
 PqSQ==
X-Gm-Message-State: AOJu0YwtCNFjBwQbmqZu9WZ0x59/aoLEgYFa3CI1tfuENWmDS4iLVv9P
 QhAQ//lnh++LXRWk61yk0FRcqopxzO3bYHX/rpjgAg==
X-Google-Smtp-Source: AGHT+IHs2xRtshNTT48TXx1JAFQgdIKvcXVpB3g1y4YbYRURRwAysleHfp/DOdtv0GU17BJUVvNGsOh5BAaPbecTzp4=
X-Received: by 2002:a05:600c:b56:b0:40c:711:f492 with SMTP id
 k22-20020a05600c0b5600b0040c0711f492mr467872wmr.181.1701551799933; Sat, 02
 Dec 2023 13:16:39 -0800 (PST)
MIME-Version: 1.0
References: <20231127182609.4663-1-stefan_b@posteo.net>
 <20231127182609.4663-2-stefan_b@posteo.net>
In-Reply-To: <20231127182609.4663-2-stefan_b@posteo.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 14:16:27 -0700
Message-ID: <CAPnjgZ1=ZE+yKrBW24cCHKdsioa7y3DdR7Ud+G+dCcCcRsf1ew@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] common: board_f: change calculation of gd->mon_len
 to fix s5p4418 reloc
To: Stefan Bosch <stefan_b@posteo.net>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Mon, 27 Nov 2023 at 11:28, Stefan Bosch <stefan_b@posteo.net> wrote:
>
> ARM and MICROBLAZE: Change calculation of monitor length (gd->mon_len)
> to fix relocation at boards with s5p4418-SoC. At s5p4418, _start is
> after the header (NSIH) therefore the monitor length has to be
> calculated using __image_copy_start instead of _start in order the whole
> monitor code is relocated.
>
> Signed-off-by: Stefan Bosch <stefan_b@posteo.net>
> ---
>
> Changes in v2:
> - Cosmetic: Fix spelling mistake in commit message
>
>  common/board_f.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>





> diff --git a/common/board_f.c b/common/board_f.c
> index d4d7d01f8f..d2e4d9eae2 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -283,7 +283,7 @@ static int init_func_i2c(void)
>  static int setup_mon_len(void)
>  {
>  #if defined(__ARM__) || defined(__MICROBLAZE__)
> -       gd->mon_len = (ulong)__bss_end - (ulong)_start;
> +       gd->mon_len = (ulong)__bss_end - (ulong)__image_copy_start;
>  #elif defined(CONFIG_SANDBOX) && !defined(__riscv)
>         gd->mon_len = (ulong)_end - (ulong)_init;
>  #elif defined(CONFIG_SANDBOX)
> --
> 2.17.1
>
