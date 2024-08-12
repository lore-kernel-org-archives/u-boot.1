Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19676C52D7C
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 07:59:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A3C2886B1;
	Mon, 12 Aug 2024 09:59:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OO+5aZRL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74DD7886BB; Mon, 12 Aug 2024 09:59:08 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A58387CF8
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 09:59:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70d399da0b5so3293489b3a.3
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 00:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723449544; x=1724054344; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hcYbuGo7mthziyxlqZeRY2L10Syotv8DKZCYUzUyghM=;
 b=OO+5aZRLy2fpcRtDOSKKad3U9Qt3POD8axbUOAiaT/g23dFk8qhvfvChnbOpUGk4yj
 qHNEED1IksSKr9BHTGuna+8jZ7qgBCag5apoi1MTZalEkg40HGrSLnplxRVYnor5TiLD
 l+BcMaQGsgxXQK7PWYv849bvNA9SX/DJweTaOlAyJo46qmMdOC5PyfUS/dPLUmUUFjfy
 GNTaxEmxQJDuJtN65HPwjE0dPZadTg0CbRb4xN3P0RoMwt8BRbDNnY1FToCmpbhkkbPv
 zg2nVYv/xMdKxBe77CYXveEfcVfAf+2vvVJiesntoqycpz1JO38L+GTGZA4BG+PMq5t8
 BFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723449544; x=1724054344;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hcYbuGo7mthziyxlqZeRY2L10Syotv8DKZCYUzUyghM=;
 b=wLCBUleBg//NIiWXqtQdCvwtoJU95Ubq1NkdLMsfbVcrCo+sY7ffCJT6YjhhImKyXl
 omGb6+MvZmiy6QOSDT0rqaD5MRdVmZRFztr4gt1fAAbletRHrQR/M1oZh0SzISmplPK8
 k34n4Rluh/Im20OOCpsRrSvjs+aoBuzubbzdr7S1NAlUBYkJBIb9GC5QnLYz+IfoquKa
 sg/iK49qM/1BDxxysznZ46nI29bpMxgAib0rj3yIjCDhr68Aynpn4fDxilaM74F13xJS
 U7ngh6H4IreDHThMv1OADiKQ9+MRyAwhnhlj9X1+iXCAxNWyMQyt8B0dCMK3FowGqTgO
 l9ug==
X-Gm-Message-State: AOJu0Yz99rAK2ZBu+Ui/N0ZkZF6QB9zkzZKP1e6RuhEcFqU/2FS05ONa
 LyZIQPPi6f1CGnO7bvo5o1AC/FAmKBF4H9pcobAm9iQaDR4MQ3nhJlE46CgITFvf1Kf5jLxlYBX
 +EFurMh0lTujcLzgNiZnoeGLvyFvuIYgKorjSFEE1ir1OaP50GIw=
X-Google-Smtp-Source: AGHT+IHIcV92PtSymus8i7LWG+lxsI0Z7z22Tv13+il7IuFFhMdHD2dXQIQ+HkC0yixyT54ZaEinXLlIYDzZvMHAcQY=
X-Received: by 2002:a05:6a20:6f87:b0:1b6:d9fa:8be with SMTP id
 adf61e73a8af0-1c89fec32aamr10969345637.40.1723449544442; Mon, 12 Aug 2024
 00:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240811145209.4191404-1-sjg@chromium.org>
 <20240811145209.4191404-32-sjg@chromium.org>
In-Reply-To: <20240811145209.4191404-32-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 12 Aug 2024 10:58:28 +0300
Message-ID: <CAC_iWj+DtHbghAqJWiwm8ZVCXf3mCOOm13YpLSQGGBPcpgnWiQ@mail.gmail.com>
Subject: Re: [PATCH v3 31/40] efi: Show the vendor in helloworld
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Sun, 11 Aug 2024 at 17:52, Simon Glass <sjg@chromium.org> wrote:
>
> Show the vendor name so it is clear which firmware is being used, e.g.
> whether U-Boot is providing the boot services.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Reword commit message
> - Use 'Firmware vendor' instead of just 'Vendor'
>
>  lib/efi_loader/helloworld.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/lib/efi_loader/helloworld.c b/lib/efi_loader/helloworld.c
> index 586177de0c8..c4d2afcb40a 100644
> --- a/lib/efi_loader/helloworld.c
> +++ b/lib/efi_loader/helloworld.c
> @@ -237,6 +237,9 @@ efi_status_t EFIAPI efi_main(efi_handle_t handle,
>                         (con_out, u"Missing device path for device handle\r\n");
>                 goto out;
>         }
> +       con_out->output_string(con_out, u"Firmware vendor: ");
> +       con_out->output_string(con_out, systab->fw_vendor);
> +       con_out->output_string(con_out, u"\n");
>         con_out->output_string(con_out, u"Boot device: ");
>         ret = print_device_path(device_path, device_path_to_text);
>         if (ret != EFI_SUCCESS)
> --
> 2.34.1
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
