Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BFD4C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 14:00:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05672801CF;
	Mon, 20 Jan 2025 15:00:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kITsJYoT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AC7580711; Mon, 20 Jan 2025 15:00:19 +0100 (CET)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9435E80077
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 15:00:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e460717039fso5878325276.0
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 06:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737381615; x=1737986415; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oGD/XUS8FZ4PXOkfYACTreIj2I6wkqTrAUsywBCCqY0=;
 b=kITsJYoTf0kEN1vX5c5tvwZ4SclksVpqMJVTitmdseyeFaZnCVaUAvpiKl0+vO6QSD
 0UzxnQL/GzayU6KAHCRSXsD4LgP98TahLaNVNxLcQ8BE0b/cuBGX6CCbyDT5JxmR+5qO
 2xTeeZ91s7gZnq+r9G54wHT9FbLggzXKx4btVzefQ6nJAzXsub8Rhl2jRKtM6DWJlocr
 sEd5pKQX3KsYfgCpvYMfE9YBn/7urg6ug8jN+s2LwCwyg1vOvaddihd67zmBbGxeUvvH
 hPuJ8SYcNgytnYHIfQtUacxALgKr1l5VLMKuHc6W8ijm/Z5ivkxOsc6JJGV1wpkJnxae
 J5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737381615; x=1737986415;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oGD/XUS8FZ4PXOkfYACTreIj2I6wkqTrAUsywBCCqY0=;
 b=bVwstmuh2Ys4HHlkm03KXdFCGD/xJBp5QO2EjnRUfpvkmPlng6bLaSo4mIINXd8scA
 752VzesgyWe0VjeVacOtosAWZU/ZH7obA7eCBWlCscs/cApd5xMfUMEaG20P/HQU58RQ
 xkf/yOQMYaCoGjxv02MlyTULKHPvY1or6jQ9zcTgADTzKbB+XWqN29+fXWfH388SMeAW
 xKs5EqzDmgct4M4UOWOpNX4thtVjmWdQGzFuqyIQpw7yOCHC0vgwBGXpQhsHHP1wodBU
 i8PXUCy3EN5KI0FPYEJysJaELsOGSLzFLIsnorzNSVNXX8ei5ba3bcCYxQIpHr5hBfLh
 Ct2w==
X-Gm-Message-State: AOJu0Yy6vMcaGOzNYaIuWJy1V42NsGHUA7WOyzKrJ04IFw+wQmQRHOOv
 QEBaHGb2p2/fkCO35ULDJRS7s2KNFZJVgcoMDK+GT6uyk3CrJ8ypjj3WjPhClFO6AioiczguqcE
 Uj8aQnUU6X+/XJ9hpzhtHuqyt8VSM3LKtUdcK5uWM4Q16yAFGBMU=
X-Gm-Gg: ASbGncua+vvZeCySAYmdrY5RoUrDkM9S6oHlr/QH0HzGXI50bDwjK25JIbAmhOqH5GV
 QT54Th2W9PgpzrzjDBW7AnNDAkRhyNUZKBSJ8mYUya0uTagUiSqc=
X-Google-Smtp-Source: AGHT+IGcsunB4fLzEH74Bb0OqQ83g/sgd8FI8yzakHS+TO0cAVEjRLSKLDTgdOJQIu8umi+HNmuUiylFDGvkH6BpxrM=
X-Received: by 2002:a05:6902:1201:b0:e39:b357:cb15 with SMTP id
 3f1490d57ef6-e57b1051d31mr9227094276.16.1737381615043; Mon, 20 Jan 2025
 06:00:15 -0800 (PST)
MIME-Version: 1.0
References: <20250117203401.23380-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250117203401.23380-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 20 Jan 2025 15:59:39 +0200
X-Gm-Features: AbW1kvbsYgzvgW2U9F5TDuUKxrxRF7e4yGu2AkVr07y30I0mFGvZncVGJhi3WWw
Message-ID: <CAC_iWjJqKubQ=nJxwUyb2QxhhFCpAeOsiZXtxcCTu_m=yFdrpA@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: reduce UEFI size if HAS_BOARD_SIZE_LIMIT=y
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

On Fri, 17 Jan 2025 at 22:34, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> If a board has a strict size limit, disable
>
> * Unicode capitalization and
> * HII protocols
>
> by default to reduce the image size.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index c46ffe3a9d8..59df4e19cb6 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -386,7 +386,7 @@ config EFI_DT_FIXUP
>
>  config EFI_LOADER_HII
>         bool "HII protocols"
> -       default y
> +       default y if !HAS_BOARD_SIZE_LIMIT
>         help
>           The Human Interface Infrastructure is a complicated framework that
>           allows UEFI applications to draw fancy menus and hook strings using
> @@ -406,7 +406,7 @@ if EFI_UNICODE_COLLATION_PROTOCOL2
>
>  config EFI_UNICODE_CAPITALIZATION
>         bool "Support Unicode capitalization"
> -       default y
> +       default y if !HAS_BOARD_SIZE_LIMIT
>         help
>           Select this option to enable correct handling of the capitalization of
>           Unicode codepoints in the range 0x0000-0xffff. If this option is not
> --
> 2.47.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
