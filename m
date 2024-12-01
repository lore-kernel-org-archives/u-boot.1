Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2469D49779
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 16:15:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B0B18966C;
	Sun,  1 Dec 2024 17:14:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FSH8EtRv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFAED896A7; Sun,  1 Dec 2024 17:14:36 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3380489491
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 17:14:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ee67e9287fso1593361a91.0
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 08:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733069670; x=1733674470; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mFUXs7pszGtTXU0pa8Nm8I/WIHYagthRj4cQy8yok8I=;
 b=FSH8EtRvnP/VmvSkfiB8ufXoXIQYxjTppAj5GqddIs/a0Ac+16JxSa/KNul6m6FA+/
 KwyqtUStalsxUR9edvmDUthw7V6smlDtelWpzKEt9WGRi0KghIBQtefUovsyjxvqXOV6
 JKoddsVzEEcfP1uUr7BzEPd3FG9CmnkVI9oN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733069670; x=1733674470;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mFUXs7pszGtTXU0pa8Nm8I/WIHYagthRj4cQy8yok8I=;
 b=tqqtkSjHfAnc8uwJR8t2YozOZnfS8xB3voMYMihLi3NXZJsZkX+dhMMp4GMphphT4e
 HYoddwOk1zQ0ZeRJK4nGKauafGhPQbR6pufG826yQrsEz8tJhYHp3fQKUYKDMhtE1zF0
 zCVLT7mEXWBTm7dA8/s4qUJjgQw4HdqG6McM8WRR683GaZxayBGD1YKBwiklSR2d/VVn
 gU0Zt+eTEaqYJAaE9pS2d2rP1+59yhjhQr6I9VkkPUfnWF+Wir1TbPVqy9gqgn0wz117
 5ey8v3c8IjLpBTbXNnBNvxk2aJX5e2vbbNQDSyO5ZtfFmahdZyou8SHPktbeFPDKtCcD
 yB9g==
X-Gm-Message-State: AOJu0YxbsMI5AEXCvHMNUg8Oo4PTHZPtxyQSu8vMlBDpUk5bryg+d3j+
 XG/7myEvo06KSxackVQ0a4/3BNuTWa1CTLsIAq96Qt6TjCfLC3NGaQ+VnB8wnP1/rINQlX7zsxP
 u6EY5LVTSoVphlLuyj78nQRb49cJWuoBeHx9oabI1np0fExk=
X-Gm-Gg: ASbGncuVXo90LOFAI0HfvVoOl/SER3j0J0gI7bP5ITOuiw7x0jYv1fiBbeeYYAhjjKt
 PhPr53XBtubZ6WPA2n4ziTz5sP8kcRw==
X-Google-Smtp-Source: AGHT+IH43cfEsaxPrkhOgyjlcvhfIIuvfwuq+b4krgau2owtkwm474SIqUW7iFduR1jHTT+fZCMofHR9785IzKOCFn8=
X-Received: by 2002:a17:90b:1b42:b0:2ee:d193:f3d5 with SMTP id
 98e67ed59e1d1-2eed193f4abmr28608a91.7.1733069669822; Sun, 01 Dec 2024
 08:14:29 -0800 (PST)
MIME-Version: 1.0
References: <20241123195616.305687-1-mjg59@srcf.ucam.org>
 <20241123195616.305687-8-mjg59@srcf.ucam.org>
In-Reply-To: <20241123195616.305687-8-mjg59@srcf.ucam.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Dec 2024 09:14:14 -0700
Message-ID: <CAFLszTjYd-8LueZSaivTeZH0H2==LJLD_DbRuqzNwqR_MphSCA@mail.gmail.com>
Subject: Re: [PATCH 07/10] Support separate DTB files with the UEFI app
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: u-boot@lists.denx.de, Matthew Garrett <mgarrett@aurora.tech>, 
 Bin Meng <bmeng.cn@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>, Marek Vasut <marex@denx.de>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
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

On Sat, 23 Nov 2024 at 12:57, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> From: Matthew Garrett <mgarrett@aurora.tech>
>
> The UEFI app is an actual executable with things like section headers,
> so just gluing the DTB onto the end of it won't work. Add an additional
> section to contain this and allocate some space, and then during build
> copy the DTB into that section.
>
> Signed-off-by: Matthew Garrett <mgarrett@aurora.tech>
> ---
>
>  Makefile                        | 7 ++++++-
>  arch/x86/config.mk              | 2 +-
>  arch/x86/lib/elf_x86_64_efi.lds | 4 ++++
>  include/asm-generic/sections.h  | 1 +
>  lib/efi/Makefile                | 2 +-
>  lib/efi/efi_dtb.S               | 6 ++++++
>  lib/fdtdec.c                    | 3 +++
>  7 files changed, 22 insertions(+), 3 deletions(-)
>  create mode 100644 lib/efi/efi_dtb.S

Reviewed-by: Simon Glass <sjg@chromium.org>
