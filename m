Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A266FC71155
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 15:00:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AC4386EA8;
	Fri, 18 Aug 2023 17:00:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RvXxdTOM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20D7A86EA4; Fri, 18 Aug 2023 17:00:14 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 781B386E97
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 17:00:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4ff91f2d7e2so1371188e87.0
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 08:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692370811; x=1692975611;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=970M0x5kanbKN0q6KOW47SSfLjOG0/UFE3z8cNj39L8=;
 b=RvXxdTOM/V2FSTIb8lN1Bnhy01fTzNGN1QLGEPy/QskgY5G8y5b38imfk/s8gZdfSs
 3KTA+VjbtF1X/Z/PA04gBO8hXiHX6Ki0+ahr4CgFc0LagcLvZ8ReoJENueCvbuj8HPh9
 wRAigxkQ4tE2TJofHFOvE+WJmV34FRWfjItCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692370811; x=1692975611;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=970M0x5kanbKN0q6KOW47SSfLjOG0/UFE3z8cNj39L8=;
 b=lDI/79+VcqCP6lFmgdQr+ujJhEHohJOYrF9nVIBQz3qTf0Zx8xLkEdiOercIcln1fo
 2ovWETtVnEgkofEoSCWYvs53cD96hMXJjPPOeiLIF/x6MJVMvro0BDD02ArzgUPXOimF
 lOltJPtsO6zS3zi9fbe5tS6A+xhXFLwjy5g8iQH7feVBy3rhDXrtZCxfbnEqtAc35ROW
 5PcilyEw9bAVOg8yU8qcOnlwFRkXEO0wMrq337gDxx4LGpt2c97fxmGVDYozC3Ly8iXL
 iJkxDq6UbHDjaU/jc9EvCFLgcXnE6LUkkK0qhygTR+1G2QrWNaJGxv9o83YY+NxQkg9D
 fcOA==
X-Gm-Message-State: AOJu0YyG3iG6R/2j1dmv3p8dAyFnFhXdl/2wKBo7vND1bEvgQP4OLkDC
 BRdiw9DmqmTSjFWrr8bU6fDhnGuvtDHrXnJZLboHVBF3fvwl+XMboxA=
X-Google-Smtp-Source: AGHT+IGvNyFgyFdAyNmjWU1R/H/Qj6O8j3IW4peF4TF4xQ1GKx+ch7G1JZaDwdN2RA05q3onXJ+HnfABRwnrylb1xc8=
X-Received: by 2002:a19:520b:0:b0:4f8:766f:8dc3 with SMTP id
 m11-20020a19520b000000b004f8766f8dc3mr1848825lfb.32.1692370807746; Fri, 18
 Aug 2023 08:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230818145413.280037-1-pbrobinson@gmail.com>
In-Reply-To: <20230818145413.280037-1-pbrobinson@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Aug 2023 08:59:56 -0600
Message-ID: <CAPnjgZ3BmHmvwG47zrnZ3yYWyTPz688RF_BxCifvHksSExmf2Q@mail.gmail.com>
Subject: Re: [PATCH] boot: Fix reference to bootmenu doc
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Fri, 18 Aug 2023 at 08:54, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> The Kconfig references a readme file that's moved and
> converted to rst so update the reference.
>
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  boot/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index e8fb03b8016..86c2787dc53 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -1439,7 +1439,7 @@ config AUTOBOOT_MENU_SHOW
>           This enables the boot menu, controlled by environment variables
>           defined by the board. The menu starts after running the 'preboot'
>           environmnent variable (if enabled) and before handling the boot delay.
> -         See README.bootmenu for more details.
> +         See doc/usage/cmd/bootmenu.rst for more details.
>
>  config BOOTMENU_DISABLE_UBOOT_CONSOLE
>         bool "Disallow bootmenu to enter the U-Boot console"
> --
> 2.41.0
>
