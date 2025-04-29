Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B982DC369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 06:30:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F05980BAD;
	Tue, 29 Apr 2025 08:30:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MfK7mwmA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52BD580FDA; Tue, 29 Apr 2025 08:29:58 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 199F98091A
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 08:29:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-6febbd3b75cso53492397b3.0
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 23:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745908195; x=1746512995; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6qZk9nBrDX1wDz4c/UICbdfNR3rEb0aC4H5e5ravO7A=;
 b=MfK7mwmAPfYD8hBY7qH9N04kCjl9LtsZUw3uvHUnUY13ppqQ+LQ6HTopI9Thouar3J
 jn9dir5Pz0RwKCu2eu3EP1khTF0T2EFsFtWvyleYBNLe2Lbum7B7pNuf6vmGj78wBqSP
 8gxOzuoaHEz8SV/5Hr8jvCvx6Mu+go7izB8qj867h4fPfFKZEL+t6t++kEX6srRJgQXF
 SUC82/FCK6FCqzdO4qYMHhBIfzfBnaaYSOrfC6ItkSBVtXuhNLT6M443JN5+h46ic1Ws
 2j9zUwPz8jxP05wgay+CDQ/ZT2tq7PjKJ2bUMvPznFE+m7pwKj4xOUanlOEwQCki3bCi
 LOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745908195; x=1746512995;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6qZk9nBrDX1wDz4c/UICbdfNR3rEb0aC4H5e5ravO7A=;
 b=UapWhUjiDd5HAN2/HfdkeOY9S9R0x3h/pvDgUYV3L4IX4wUqm1B3iM+P7WeExHopxW
 Z20drFW8BPISteQhbrzSc9cANs4G9BQNNMkZglB/Jd/JE+lamTs0taBVI+fg8Si7hIcZ
 9TQsb39dTDucKUxNno5QIKZBmHIe8J0BBDkj5rWd/W9ydS2LMIABMtt/4MWhHgcftIK8
 ByhG0lpWbaqBxW1NzgrJU14xZjob6y/bp4Y6SR+M2C+N5VWjLbSRBTnLxGD99ZV00vW4
 Ad0Yjte7ieZ8ZIlsLXTkQ/qEXmIlFWiHZVHqZeXyX4tkYlPPc1ZTYK+TpWPyncAZJ5VC
 3N8A==
X-Gm-Message-State: AOJu0YzQ8gYH9R/YT3///Nrrl30c3lEDYfLuwlizJI4OXFciji72Ue16
 KZeNy48OpcZ4HtWZq3VMHuerbJu1E44iqw5PCBR26youoAXXJQtTYt2WXzPPL+SyhyMA3eUqFmJ
 H509Fnq/owx9fMcdB0O0eyzfLenVpYG4b9xPFK4YBuiKy6NnGJng=
X-Gm-Gg: ASbGnctWxufIbr+aviIKSpWENY7QQmW4MsCLAD/mMW2KsXbMksi9nh8wsk+JUl7DqJV
 J5QKSyjLJMsIcDzWKbuTQQE++o5m29V6jb1ABG4He6YGDojQEqN6wR4i/A1ahmANF5ZVyXbDJD/
 DBgbe65F4biyYKNSh+B4WTyHE=
X-Google-Smtp-Source: AGHT+IHw4yhHHBVQnPfa2kB+RR9TV0q0VhUou0vGpCeEpoZF6Ur2HNW73zNNQv+kdAI/j3RvAaMw9sBuWj+lF+KC/rk=
X-Received: by 2002:a05:690c:b85:b0:708:2c19:bb4f with SMTP id
 00721157ae682-7085f18d719mr158190167b3.17.1745908194969; Mon, 28 Apr 2025
 23:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250426120913.23314-1-andre.przywara@arm.com>
In-Reply-To: <20250426120913.23314-1-andre.przywara@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 29 Apr 2025 09:29:18 +0300
X-Gm-Features: ATxdqUH00DMRx6GEQ0klCxfbsIF2Km50YjsrbFGq0gS3ql0M_2ElnW-nf0xgTjI
Message-ID: <CAC_iWjJSHaypyJXo2TuUy2mnC=mx+Xg2Te2Orff_JzJ-xZ6oOw@mail.gmail.com>
Subject: Re: [PATCH] sunxi: enable MMU_PGPROT proper page table protection
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>, 
 Tom Rini <trini@konsulko.com>, linux-sunxi@lists.linux.dev, 
 Jernej Skrabec <jernej.skrabec@gmail.com>
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

Thanks Andre

On Sat, 26 Apr 2025 at 15:10, Andre Przywara <andre.przywara@arm.com> wrote:
>
> Select the new MMU_PGPROT Kconfig symbol for all Allwinner board builds,
> to use a write-protected .rodata, non-executable .data and .rodata
> sections, and non-writable .text sections.
>
> This might trigger runtime exceptions in misbehaving drivers, which
> should then be fixed.
> Please report on the list or on IRC if bisecting ends at this patch.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
> Hi,
>
> I am planning on merging this ASAP, to get some exposure and use the time
> until the release for wider testing. If worst comes to the worst, we can
> revert it still before July.
>
> Cheers,
> Andre
>
>  arch/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 99750072e55..f22d347d5ad 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1192,6 +1192,7 @@ config ARCH_SUNXI
>         select DM_KEYBOARD
>         select DM_SERIAL
>         select DM_PMIC
> +       select MMU_PGPROT if ARM64
>         select OF_BOARD_SETUP
>         select OF_CONTROL
>         select PINCTRL
> --
> 2.46.3
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
