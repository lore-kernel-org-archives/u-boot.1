Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D559D5E373
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 15:06:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61BA088C0F;
	Sat,  9 Nov 2024 16:06:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uXuKQfVn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BDF888C0F; Sat,  9 Nov 2024 16:06:41 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B44688B9E
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 16:06:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2e34a089cd3so2554972a91.3
 for <u-boot@lists.denx.de>; Sat, 09 Nov 2024 07:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731164797; x=1731769597; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lozrEDMwb6Dwn4wMJU1UzTV2PaswtJpJwnO5+ylbDk4=;
 b=uXuKQfVnKLWIydbKtcNfVD9tZzHkWhCKAA1QrK/D3yTF8zk9ZfmBp4jlwfPuGlQD68
 bTwUwDb3HHR8Fzq8JDNDQwCP6k1vhDq+tSN6LWccJ2XTx78krvbTqpQsitskWT3eH0LM
 K3m6N9W3AOObDycxI5oDsYgfoxKDy7mMeaME5mTPBqISw9JRkVltSuRKSBYW+8u5FqEb
 7KViqlAe3OpXBIYbI5q3gMGHtyBSIWhUF7vHY0FPEsSxu8BIHqKxkHCCigOwJqnUOe00
 Y2/F7n4tm1ZbBApWcIU9ak6SHAig9bF2Ga2DyTI3ps0UJwMcpWNReeUHww9I3EAGkJMu
 Mb9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731164797; x=1731769597;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lozrEDMwb6Dwn4wMJU1UzTV2PaswtJpJwnO5+ylbDk4=;
 b=AkrzxwzgiMkzzM+ze6P/ITgFG6aRkjm9OStK9WSoyjH9+sIsQRvRkT/kTJ4SheCxnn
 ZtTCzxNdoHvoECLKrSXtc7NQ0UVJI48/FWHDpBORGsPa2wUq6QNP9v0d1y3oON2LDHR0
 p9ILxhugmm7Np8dPhfQ8i++T3LQoJglPjnAVL02zs5q91L+cOY2wGdtD9+WWoXQb7pQ2
 cDfJbvTXXxUt76/sIUCYFvcTETQgsmdQklX10PU5ysR11YGjYQSyZcDj4KL9f5oyTHcJ
 uzlb0Qhe+YBTnXf6yb73HxX6E2mB+n1IA1Vq9e2dw71RQ3xF2XCxgHr1h5Vsc6HIbaYe
 x49w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnLQ77uKAVD59RC1raC193V18WXh3RAGFXYf5A58/mM7K4eIYBDHFwMbHpWPHAAV3QQvduy5Q=@lists.denx.de
X-Gm-Message-State: AOJu0YwvVY4kf3gFNmCtvKrVw6CKD/qwiqm1DKaKQonbfNTcCCtiGKUf
 t5avLE+8ulU0TEBJqiwX7YAH1eEtctxhyESrCCKyk5H6s0s/se6HGx0hfnwwJZrozlcWCUngPkW
 X0rGfTES2ZfspM4PlQxLuP4sluupcpTEHjv1Sbg==
X-Google-Smtp-Source: AGHT+IEKhvh6GI3P4YVoFDSY6NNRvenc8uDddHB3FyDa2d40nibbtP4EaNUDU+qAdLSYheK+KAogGk4slYk81DTvOoU=
X-Received: by 2002:a17:90b:1c8a:b0:2e2:8995:dd10 with SMTP id
 98e67ed59e1d1-2e9b16ee961mr9263148a91.4.1731164797099; Sat, 09 Nov 2024
 07:06:37 -0800 (PST)
MIME-Version: 1.0
References: <20241109103141.33983-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241109103141.33983-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 9 Nov 2024 17:06:00 +0200
Message-ID: <CAC_iWjLKDZwQ_g3B4pt3j0Vy0KCq4CRKNvKsmhXFaT6tiJMFXw@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: provide valid PXE architecture on sandbox
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
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

On Sat, 9 Nov 2024 at 12:31, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Before this patch the sandbox uses 0xffffffea as PXE architecture.
>
>     => efidebug defaults
>     Default boot path: EFI\BOOT\BOOTSBOX.EFI
>     PXE arch: 0xffffffea
>
> With this patch it uses the PXE architecture that matches the host.
> This allows us to use bootmeth EFI on the sandbox to load an EFI binary.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/efi_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> index bf96f61d3d0..14049378930 100644
> --- a/lib/efi_loader/efi_helper.c
> +++ b/lib/efi_loader/efi_helper.c
> @@ -75,7 +75,7 @@ const char *efi_get_basename(void)
>
>  int efi_get_pxe_arch(void)
>  {
> -       if (efi_use_host_arch())
> +       if (IS_ENABLED(CONFIG_SANDBOX))
>                 return HOST_PXE_ARCH;
>
>         /* http://www.iana.org/assignments/dhcpv6-parameters/dhcpv6-parameters.xml */
> --
> 2.45.2
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
