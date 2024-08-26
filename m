Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C1C6C5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 10:17:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2A1482BA7;
	Mon, 26 Aug 2024 12:17:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ohEuipBL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4E128641A; Mon, 26 Aug 2024 12:17:29 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7895080805
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 12:17:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-202089e57d8so25880255ad.0
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 03:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724667446; x=1725272246; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Tb8l/MojCu4humhQqFw4iRcoVr2GSfX6Sv4HeENmMIY=;
 b=ohEuipBLzDvJ8WybO2SEBJ2DlD3syv4I8w/YkdLIRHtO/PVBYhlmoJtHmsztwiLrkr
 7RSeSZFJV7THo9fHNIKvpMOJrg9eUZK22+XFA5wmufgnEAWZPCdSV5neRA0omw8AWbyI
 7x8qALXTJi8Jt/4/n9GggbOhdoWYIZrqfXGQ0CXPBcRJanNDAT/LV2j+dhbmUAzsZejB
 kdtJZOEIyxjgj1cBw3OErvudNdX7PWnPO+wB2BXhYyLmWopjLYQccLXsL1JarlsIjPyr
 t9S8/GVFGAwed5jTi422YxjOKT54tNPKY0sgcjcgzcF7A3fG+U46QSE9SMXFERa9EXC6
 YcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724667446; x=1725272246;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tb8l/MojCu4humhQqFw4iRcoVr2GSfX6Sv4HeENmMIY=;
 b=RG1FdoEl951UhUJolPAsS3Z7oZTASbWgO4EnJBIk17uZpjIHLpnaTgOnxDtgeYt/D1
 abSn4P9NkDMg36Fkb0TsBKG2uMGsSBLoYM+HFHLMynnBaEt/t5uJK9mQn5kpjQi6EYoG
 S6ij4NkYBmv5wjw0I9Df5LYu+O8QQGYw9wpAsuH27mr2S8840xy4UnZpfkBhNAynnX94
 NHE/itkOPLBD5lD+JYMFOAnfblmTOhi//MYAqQAnwKTV7BqZcNtOlgxDXDNit0Jdgdl4
 s+UmhueMzvsMiIsU+SyxtZKnPTEmC6YQczLFof9Y+moa8E2puFT+f+8xYcY2NWv/u3SE
 q6uw==
X-Gm-Message-State: AOJu0Ywhh5U6DA4dM3OkwOb2Ywe9fqJlG9O4Inz6BVeiU+ZrxzDIVhZi
 386EYP2jsBlYIeuRZTfZ+8nVfyPMPDbIbIkY2qW/mxht1uy1eYfF4kQAnVzVohuD0grxqQPGBMy
 +5KPoR83hmbR6HxrNk0PLUF/hsOp0OCWBtxxS1ZFZFqEvRhCDs+Y=
X-Google-Smtp-Source: AGHT+IGCpNOUxCXFuQiO68Hhxg+moDwD90StQfhxJ4yl6bxMgQEAHjuZa884oAXHI2wObjdf5JJJi8tuyJaZxtk/vtg=
X-Received: by 2002:a17:902:d512:b0:1fb:5d71:20dd with SMTP id
 d9443c01a7336-2037ed33422mr237583595ad.0.1724667445444; Mon, 26 Aug 2024
 03:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240821213349.256463-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240821213349.256463-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 26 Aug 2024 13:16:49 +0300
Message-ID: <CAC_iWjK+XJ2AjpSV7JjNOuf_Mag43q4T4Wh3z88+Rw94dFWXLA@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: allow EFI_LOADER_BOUNCE_BUFFER on all
 architectures
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

On Thu, 22 Aug 2024 at 00:34, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> There not only ARM64 boards but also RISC-V boards that require a bounce
> buffer to read block devices.
>
> Drop the architecture restriction.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 1179c31bb13..6ffefa9103f 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -364,7 +364,6 @@ endif
>
>  config EFI_LOADER_BOUNCE_BUFFER
>         bool "EFI Applications use bounce buffers for DMA operations"
> -       depends on ARM64
>         help
>           Some hardware does not support DMA to full 64bit addresses. For this
>           hardware we can create a bounce buffer so that payloads don't have to
> --
> 2.45.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
