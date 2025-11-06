Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1950FCCFA05
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 11:37:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F36B83B72;
	Thu,  6 Nov 2025 12:37:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rFZ20dnF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4191D83B80; Thu,  6 Nov 2025 12:36:59 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3FEA83957
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 12:36:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-7864cef1976so28684887b3.0
 for <u-boot@lists.denx.de>; Thu, 06 Nov 2025 03:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762429015; x=1763033815; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RPDw+FfU1vy05Sj3CLuiWou5rxal+LZylGqZTEirjmU=;
 b=rFZ20dnFvy+UnxFhUou/b5cdsKryrqnieGo6WUei0uVJDl6gJOuQAzPuxG+kR75+ZO
 YE0x1S4+GzPdaY9Z5Z8E3PviB9iCiwArWjtnlQVCcaEz1gLNa4UuNHg77+zQ2ROEsw2q
 rNeZXRprfrTgCpfopy2WHqDxVGwTGC0DM20Nn0fIcY0IxrMHMh5v2Zxx72JR5A2if2vX
 NOok0FhabqbDciuAIbCs1FmWRrYEBYfPuxE0YxqKf45wUMWg52saU6JY45nGb0IfkCE4
 6Wg+errdDINYY4aAmb+XTkg+2J32a0Mx5Vhrl+MPIYkg4qUvsM+FjaD3DXwGQVbu1ApC
 7KPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762429015; x=1763033815;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RPDw+FfU1vy05Sj3CLuiWou5rxal+LZylGqZTEirjmU=;
 b=gJd0Xp8xtM89q0teldqfF3VVPZ1ba/cAW459zKjZlKvqPWucPWDkAve3xtpCUa6SgS
 lbSEe3J6CcqUYQyLjZjIOLX0zR575kL80Npr1PzLhSPRLB+4KesEfu9J1g5RE4IljGjV
 3ey5jWP0M8o0Cd699ry3UvJZIZaIuJSHVRpXjXfAwCE9uxL9AVNsAj6SGDDCLTQtUNrw
 sUEKCf2FzRbUJEWL5MQqQitivBl3jhIq88ZEoXFnYsLS8iEQlpOF1FGsd1qzEP73+XTF
 Zl183Yksz5wofEnCictuVNHa7fsqMWAEcBvdIOj7enLhX2JrNZXaEbHMYG1oFwa9vC/s
 gUUA==
X-Gm-Message-State: AOJu0YxaVgJNwGE3Lvwt39NIXNTO+TYdGX9Lu+PANmE+/061jeEyDWqw
 oz3QhIqXADeZoLl8otdPQQQcekKga/6lwLegqIB/rR7XZRHax1OPFpocha5ZY6nQGmTCREIiAGE
 a+xGBnllqRDWthdi4ga1bll3MkYDV38EGt4bofVEuSw==
X-Gm-Gg: ASbGncsDB+UCio+eEkDVdWttZtr8nRuRYQjbBdlq2PPZ321njl/Tfu7KzVebRPZOcTT
 fbAfq+jKJN/lsDmRF9ehKjFp5Gd05Gt/OYUljg6trRg9+4nOviQhobLG1ux/1ye2rjMUJ2jPHiy
 n2Ga1Vk43RMV4iQ9Ot7VxVnD13fXpsG/zCs+Ni+roqHG+C4RNY8iYfVjazmKsVhWgl9dc+YQpSg
 q454N+Tk4CAPGbYeZ6HX75mflK/FBfC3T9gwHSNcgp0rEbaP1tNzCRjLCmJuxo4jbMlkUWL7BWC
 soNGFcXm29uNTxFjgWvQE1PBBXPjioIiW97hTt81Uw==
X-Google-Smtp-Source: AGHT+IFiefKnlUT2xQ1t1IsR3tGDLCOjlCeR1QZvN89I+/wh0Arfvfk+WJtpRA+AFQ8rgIEx06OAFIUaEn2kQ0i0Xok=
X-Received: by 2002:a05:690e:1402:b0:63f:ae5f:d7cb with SMTP id
 956f58d0204a3-640b52ae4e7mr2172911d50.0.1762429015493; Thu, 06 Nov 2025
 03:36:55 -0800 (PST)
MIME-Version: 1.0
References: <20251106-topic-snapdragron-en-pgprot-v1-1-d2b9e802230b@linaro.org>
In-Reply-To: <20251106-topic-snapdragron-en-pgprot-v1-1-d2b9e802230b@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 6 Nov 2025 13:36:17 +0200
X-Gm-Features: AWmQ_bnEe9C9llu6Vv7aFYnWlJygYQpwRdkSDBzKv1UcvYJe0V6lqW7FINzQH_c
Message-ID: <CAC_iWjKeKbNVH31OwfdTXb9NDf=XLEsgruJeMpK9k6CJbX1aXg@mail.gmail.com>
Subject: Re: [PATCH] mach-snapdragon: enable MMU_PGPROT by default
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, u-boot-qcom@groups.io
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

On Thu, 6 Nov 2025 at 13:01, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Let's enable proper MMU page table protection to properly
> protect write-protected and non-executable sections.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index ef834542bd4..b200e9c730a 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1142,6 +1142,7 @@ config ARCH_SNAPDRAGON
>         select SYSRESET
>         select SYSRESET_PSCI
>         select ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
> +       select MMU_PGPROT
>         imply OF_UPSTREAM
>         imply CMD_DM
>         imply DM_USB_GADGET
>
> ---
> base-commit: 23987e10905146def3ab61e55ec912c6e742efdc
> change-id: 20251106-topic-snapdragron-en-pgprot-ce10531d6e91
>
> Best regards,
> --
> Neil Armstrong <neil.armstrong@linaro.org>
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
