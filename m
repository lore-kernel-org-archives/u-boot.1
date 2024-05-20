Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3ADC04FFE
	for <u-boot@archiver.kernel.org>; Mon, 20 May 2024 09:55:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ED1F88124;
	Mon, 20 May 2024 11:55:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dkB+OE/x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E89CC88140; Mon, 20 May 2024 11:55:20 +0200 (CEST)
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com
 [IPv6:2607:f8b0:4864:20::e2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBB818806A
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 11:55:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-47efcb120feso714041137.2
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 02:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716198917; x=1716803717; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6AqOGodQwysyblT03Uwd6h/QOSKAZxqbo8ojrQ8D3tE=;
 b=dkB+OE/xXJfmffgvyOthpeS3o34UD7tDXqeLZG6qbikAxpLh37x9jBBZJGqHB9iABh
 /SyPRjQVm19l89EntWgvbyNHYRyQPZpouk5r96Zm4I859L/DZhMRCsMjz7bAY2AGOzA8
 IJuVkbK9sXNRmPMNrNQBx82zYC/wqUxikVruX9ofEq1Ad+ZuB/lvV85xO6ws67iv1QjF
 To4TzpQrqTVehdHR6uA2Eo35fApm4CNJceTWknfvK0zD0rkK1JluU5MxcgLAPo9N+Aid
 mPWuTYxQtB/9QK8Fmpa3FhvSGfl5VkyV1tm+AtlEYqEUN6q3YEsd6TF05N55+XlthWl2
 sXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716198917; x=1716803717;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6AqOGodQwysyblT03Uwd6h/QOSKAZxqbo8ojrQ8D3tE=;
 b=Vr3lQ4Quox4EDvlkBa9M95vsSGKfdL3NmZfjjmRGYe/vAcmpUiIlHjNsRQRsq8CczB
 PfEw58hKPLh8zklv8L3Sf4En3pSKktGumEJ9XJOki+9vAcD7THlbEPPrbTBmLNUhRXCc
 3vaFEMKWekvnI8A8pde+H+WZaCXnz5AhtPI7/gxmeQbllLwbDA2HmufbeBfM/GR/sj+q
 I+INWJifpSXY8aJFsr32yi9/vUOVtP3OrG2i9yvLgiSxBKkrRyvD/uobts9AnlGHMA+8
 iJQ9O0oIvqo/NHwZMIrKKdtG0QABoXwimo7RDZ3HW8cCBxso1jrO1yKEaHzp91r8/LCv
 cp/A==
X-Gm-Message-State: AOJu0YzoPZ8ip2UMEMqL4lx4sVhuumvBop2xG4sQqKkkCd24pbAiUmuJ
 NLNqebhLoL5Ci4Bzt8QZ+1h/GfmbNctnxCKqeYDPgyKsUWE5fY+bzxK3oKUUJ2+TY89E7CWviHc
 H3WWsAiiyCQfAUUL/oA6MzOHVCUOQW8yArj/Dpw==
X-Google-Smtp-Source: AGHT+IGtRNdl0VrV8WpzIrdttfrK95LE4nKrmRNo7W1AJrafHkaUp+TAx1lZTf63Q5QS5tTA6zqb29U4zsq0P3gBQrw=
X-Received: by 2002:a05:6102:dc8:b0:47c:11ba:fea9 with SMTP id
 ada2fe7eead31-48077e71431mr30445518137.23.1716198917548; Mon, 20 May 2024
 02:55:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240519204044.187165-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240519204044.187165-1-marek.vasut+renesas@mailbox.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 20 May 2024 15:25:06 +0530
Message-ID: <CAFA6WYNVvhZDj5DocnpqJK7QM0dFPru-xfWnBE6UmgxdqWWLTw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: renesas: Reserve space in 64bit R-Car DTs
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On Mon, 20 May 2024 at 02:11, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Reserve 4 kiB of space in 64bit R-Car DTs when those DTs are compiled
> to permit patching in OpTee-OS /firmware node, /reserved-memory node,
> possibly also additional /memory@ nodes and RPC node by TFA.
>
> This duplicates behavior in arch/arm/dts/Makefile with OF_UPSTREAM.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>  dts/upstream/src/arm64/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/dts/upstream/src/arm64/Makefile b/dts/upstream/src/arm64/Makefile
> index 9a8f6aa3584..26a83d3d29d 100644
> --- a/dts/upstream/src/arm64/Makefile
> +++ b/dts/upstream/src/arm64/Makefile
> @@ -7,6 +7,10 @@ targets += $(dtb-y)
>  # Add any required device tree compiler flags here
>  DTC_FLAGS += -a 0x8
>
> +ifdef CONFIG_RCAR_64
> +DTC_FLAGS += -R 4 -p 0x1000
> +endif
> +
>  PHONY += dtbs
>  dtbs: $(addprefix $(obj)/, $(dtb-y))
>         @:
> --
> 2.43.0
>
