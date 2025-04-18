Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB62C369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 11:39:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F20482CFD;
	Fri, 18 Apr 2025 13:39:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V0OVCMtS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFECB82E38; Fri, 18 Apr 2025 13:39:47 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC94682C15
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 13:39:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ac73723b2d5so337532366b.3
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 04:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744976385; x=1745581185; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ouX7nNkxQGKnB5Glv2CPA20OplPnlVKtgNvT4fovev0=;
 b=V0OVCMtSpKRTotPLXuMkMAWxCaJUxqr8LquLfTQ2kkIMAGUEbfNEdByFgUNQ0wZQXf
 4uqWaL7cI7AtH9PZVDWCLaPLjeW7ixPh25F95xGEZx3jFN1PYjcuVqfBTlwzhpwUbNcJ
 Kc5Oqq+8ZZFlQsedbMiCJTBX+GTHll4BKHx00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744976385; x=1745581185;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ouX7nNkxQGKnB5Glv2CPA20OplPnlVKtgNvT4fovev0=;
 b=F5hmNBvp5dZsyYZDkrpouhJx3i5RgpMSnOc1LW6qyWJ3mq8O+S0jaqxhmOYZJoDZxy
 FzAZ52pV4qnO0hqh2sOVhu1WIeUTPvIrdN64tzgdMVKg7K8zBOh+pyKO1iOWsYBqdg8l
 8dwMi9nJ9LeOVYyfK5tJctF/LA3uo9DXoSZA0wL9BD3yVG5iFG/VvaKoQQrf1qwCmT5l
 rF0Q+ZjDI8wt+WYRbamFGb3knQh1QM3z8X5pw8WCaZgB9tP4WyeZr89ndxyYdR27zI6i
 SvxeUHuCCpEn4nG40n+6sx2iP7OYv4gq6SqZnUEu5iLdy3eYtFpRuaZvgQbmyxu6xM35
 8Dmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFKb8XjcOS0rA/e5h3dHQGle+vDKv19LfcCxH2vRt5dJlljErPRgiSC5PXrnoHSh+OckDqeTc=@lists.denx.de
X-Gm-Message-State: AOJu0YzSGLJ2x19XZh51arm+ef1kUD8jVQCqBbRLV+JjrtK/1KyvwZC1
 ovJ2e5jiAp/rIS6Tebbrs76PEo92ororEpUub/MDH+0y0bjvk4T7/d3HvoUYgc7/vGqqWer9xSD
 BRSAeJj7MpSgk8j2sr0gON+pXwyM39lzelIS2
X-Gm-Gg: ASbGncvrDM3fA1u5oYoU5Q8cCn5Gvgpefn42p9+ptIl/q2DbySyVJXwzdR01/AKWh4z
 ctXo9bGyj6WbsrRe1ilij4IgpKK+GbTN/pJYdLLyt6+pC9F7KpMDNU4XXU0BkHSsoeHUgvrpVfZ
 0m6Q70L5Y2ou7z4uz6vjEYCHk=
X-Google-Smtp-Source: AGHT+IFhOYAwkop0JbhtQVgg3QGP7eeYL8iTpMCYMMHP7OuRxspfv058est4blzSLye9rEobfBAbFRgETo1tS9hMLJY=
X-Received: by 2002:a17:907:d2a:b0:ac3:991:a631 with SMTP id
 a640c23a62f3a-acb74ba560fmr172397266b.34.1744976385015; Fri, 18 Apr 2025
 04:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250418043137.537340-1-heinrich.schuchardt@canonical.com>
 <20250418043137.537340-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250418043137.537340-4-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Apr 2025 05:39:32 -0600
X-Gm-Features: ATxdqUF2QQhTXpSAZ266zl6li17z2MJcIJ5IH6pCZaYhgYbsXLOh4KH24lrOuf0
Message-ID: <CAFLszTg5Gfj_u=CJfGzzJ2N-gfsR0Wvy7rxht7eTDj8x6hj=3w@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] doc/buildman: describe using fragments
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Brandon Maier <brandon.maier@collins.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
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

On Thu, 17 Apr 2025 at 22:31, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Describe the new --fragments parameter
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v4:
>         Describe the invocation of merge_config.sh
> v3:
>         no change
> v2:
>         new patch
> ---
>  tools/buildman/buildman.rst | 28 ++++++++++++----------------
>  1 file changed, 12 insertions(+), 16 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
> index 07ecc5c110c..0729f15f2b5 100644
> --- a/tools/buildman/buildman.rst
> +++ b/tools/buildman/buildman.rst
> @@ -1126,27 +1126,23 @@ later comparison.
>  defconfig fragments
>  -------------------
>
> -Buildman provides some initial support for configuration fragments. It can scan
> -these when present in defconfig files and handle the resuiting Kconfig
> -correctly. Thus it is possible to build a board which has a ``#include`` in the
> -defconfig file.
> +A comma separated list of configuration fragments can be added via the

comma-separated


> +--fragments parameter to all processed defconfig files, e.g.
>
> -For now, Buildman simply includes the files to produce a single output file,
> -using the C preprocessor. It does not call the ``merge_config.sh`` script. The
> -redefined/redundant logic in that script could fairly easily be repeated in
> -Buildman, to detect potential problems. For now it is not clear that this is
> -useful.
> +.. code-block:: bash
>
> -To specify the C preprocessor to use, set the ``CPP`` environment variable. The
> -default is ``cpp``.
> +    buildman -k qemu-riscv64_smode --fragments acpi.config
>
> -Note that Buildman does not support adding fragments to existing boards, e.g.
> -like::
> +Buildman invokes ``make`` passing the defconfig file and the fragment files as
> +target arguments. In ``scripts/kconfig/Makefile`` the script ``merge_config.sh``
> +is called for each fragment file to add it to the configuration.
>
> -    make qemu_riscv64_defconfig acpi.config
> +Buildman also supports configuration fragments that are included in defconfig
> +files via an ``#include`` statement. It can scan these and handle the resulting
> +Kconfig correctly.
>
> -This is partly because there is no way for Buildman to know which fragments are
> -valid on which boards.
> +To specify the C preprocessor to use, set the ``CPP`` environment variable. The
> +default is ``cpp``.
>
>  Building with clang
>  -------------------
> --
> 2.48.1
>
