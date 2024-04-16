Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1373FC4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 07:48:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58763881DA;
	Tue, 16 Apr 2024 09:48:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="m75G8v05";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A34BB881CE; Tue, 16 Apr 2024 09:48:56 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95717881DC
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 09:48:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-516d0162fa1so5171320e87.3
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 00:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713253734; x=1713858534; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hT6U7LjtBHNnzPXPlqgae8KX2u/xRorQl9uBQnQuujo=;
 b=m75G8v05ucqovY+hdhR9eiXnrlkRu6txs/Q4Ow/t9/TBXGdBrmknj1hW6P4XqjOLYm
 LCwehxKLrtN8na0btEwYKwch0t8ESHsXrW4vgAj4HYDh46d3OBuqXko1UrhCf/aQTfI8
 LTIDwRJrNDRa+TQp7uU1sVLLrGYU+kwVP5bMeaEhBaZxYhpZowgFqnDKMPvcYUb1valm
 HScXTWVGYHWzwzfxsFHFNFBZE5lzb9PErooOm6eq6jUXEU0UYnILffK9BKHDlGE1MBkY
 QiJOkfXojhab8NZ7CbGjcGrfyiAFpa4JWTkYPXXJODAPH7jIIQJIHi0VcBiD8uONQGtC
 3h3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713253734; x=1713858534;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hT6U7LjtBHNnzPXPlqgae8KX2u/xRorQl9uBQnQuujo=;
 b=e+2XhMUuI06WUJV9++SyMEbY7TGQGW2c54eQhZOcXC47Ydsf4dWmX7MIE9Mw1NBq3U
 y9V0GhxSCb0wmfwp+lS+GBDi+GdzavBGef5u82R5pTG2ZOVqnp7h04k+JwPbzMmgFapY
 hOu0eBZ6vkAom+9IsU2mg+1i27+sJSCEh7ZUPN/YEOv1+VWlRZYGZpzmexm/frjnNYX7
 LzQgr0Z9mqXrCWnvf1SzlEpKr0z4hRT8yJGfrfKj+YiUTy4kpkObRcuA3oyscudEAMGr
 DnGS7WZ0F30YAXAILSHK2HLXIEaA4wJSgeOHDcVR0huuV95OM++c1ggmI3xRL1nAzsmf
 WK3Q==
X-Gm-Message-State: AOJu0YzjqXsPKmX2oyR7Fp5ZDpN2SnPTBqcM+nz1JsCI8r1ZVFCNcdfM
 L3JU0P7+cc/v/POwM0p94/HX96vm92WiIdPKx6Op1KF3C/WCaEkDK6cgZ9gJNGRIgWdhnIvPkEV
 mnnXupDwLNAP8fSy+nnTMi6zvXWWoFKXuB5a5dQ==
X-Google-Smtp-Source: AGHT+IGFCdG5lEtTR4+XKEyJVYfHSU4/XljW6vpVjgfpFC500DMpdiasqUPENeDBj8FoD6K3vlIwT1BPGHQqGWSGocM=
X-Received: by 2002:a19:3806:0:b0:518:69c5:c02f with SMTP id
 f6-20020a193806000000b0051869c5c02fmr9283989lfa.52.1713253733894; Tue, 16 Apr
 2024 00:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1713250508.git.michal.simek@amd.com>
 <e7206c2695459ad0c1a1f0040d9bd286c2fa109a.1713250508.git.michal.simek@amd.com>
In-Reply-To: <e7206c2695459ad0c1a1f0040d9bd286c2fa109a.1713250508.git.michal.simek@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 16 Apr 2024 10:48:17 +0300
Message-ID: <CAC_iWjLCiAZtatsd2ck5UqqSGBTFJf39s-0n2T0bEh3qY47W_g@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] Kconfig: Add missing quotes around default string
 value
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Eddie James <eajames@linux.ibm.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
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

On Tue, 16 Apr 2024 at 09:55, Michal Simek <michal.simek@amd.com> wrote:
>
> All errors are generated by ./tools/qconfig.py -b -j8 -i whatever.
> Error look like this:
> warning: style: quotes recommended around default value for string symbol
> EFI_VAR_SEED_FILE (defined at lib/efi_loader/Kconfig:130)
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>
> (no changes since v1)
>
>  lib/efi_loader/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index e13a6f9f4c3a..a5ab7d1b262f 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -129,7 +129,7 @@ if EFI_VARIABLES_PRESEED
>
>  config EFI_VAR_SEED_FILE
>         string "File with initial values of non-volatile UEFI variables"
> -       default ubootefi.var
> +       default "ubootefi.var"
>         help
>           File with initial values of non-volatile UEFI variables. The file must
>           be in the same format as the storage in the EFI system partition. The
> --
> 2.44.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
