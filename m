Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B547ACE7B1D
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 15:02:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2B2788CF2;
	Fri,  6 Sep 2024 17:02:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lKcjKExV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AA8888CE8; Fri,  6 Sep 2024 17:02:37 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E62FA88915
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 17:02:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6bf6606363fso11935706d6.3
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 08:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725634954; x=1726239754; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SmL94QRFnmD+nqInk2nzdq8++hJsjZFS06sON8OoYkQ=;
 b=lKcjKExVAvRw3aUvzx5OW12UFEFeAW8Q+xNfBiv3L4ZFvBh8UmJWt408QfxxUG2+wb
 /7vanPGMTr6BkJryGk7uVwSG4rmyGjkgh2B8icmn2o1rEOVGhIeeaB0ynpe1hebCKrJh
 y3IyOS3M/WjL7yPU+nrtofNJXvhLIu9g0tBYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725634954; x=1726239754;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SmL94QRFnmD+nqInk2nzdq8++hJsjZFS06sON8OoYkQ=;
 b=rUm1texKdmaqy8Q/lkNJ8Kqj1UrTLxMWqHKXruqxq77GYkcIdWszakwtKKqOZFrpv1
 gBS7SJgq2oZquIHr5YTpBxWLiao70b2FB66uBHECy+1SStWRRRRSrqctZjxK12mL7SIW
 G8EvdlOZ7EJma/tdP/IItkzKErSVGeBCpkeEpazItch4cJh/93pdm9f2jK0pKEF54bAb
 xyOFQtClUxf0/r3FtU/Oi/7KBWMvefYwS3J28PP5Agx2hk+ZYK5zLPhpmRoqyNZH0oDw
 E8z5WW2dFM6veYcpp0Hm7AYjGJGCNifRBkMavk1VQq1LRc/k/+NCBtwFAPMofJ0DU94q
 9vkQ==
X-Gm-Message-State: AOJu0YzBX0iRzb3Y0URjFzp3AqkP8byFLnege1hE7YaAQkER6Yvde5vF
 DjPursZIueK/VwaGwgyCJeoSj4qzeLrLIjy4PNVH1p5tcRt2QSEQriVRlp+jFCK4cS91kLeO6vq
 xY/uWKYgGUf7O8uy0YAI1PwdhfiEXJu9eokWP
X-Google-Smtp-Source: AGHT+IHlYYD5lvRVzgTGTwCtjpVFGcI2G7Q8/NDpJ9tjrFGFfr/8+3HvimpTpJTpqF+7tueb42X9eDbyYxj5r4lnJ8c=
X-Received: by 2002:a05:6214:5707:b0:6c3:63f7:639e with SMTP id
 6a1803df08f44-6c5284f43c2mr35559226d6.18.1725634953679; Fri, 06 Sep 2024
 08:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1725351676.git.jerome.forissier@linaro.org>
 <a5617c0cb57624d004c4b4f42861822016edb2e9.1725351676.git.jerome.forissier@linaro.org>
In-Reply-To: <a5617c0cb57624d004c4b4f42861822016edb2e9.1725351676.git.jerome.forissier@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Sep 2024 09:02:22 -0600
Message-ID: <CAFLszTgr9fEmdx9No2yh-1tiVW4P1qb+mWFJ=Zk6Om_d_CFuXQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/16] Makefile: detect HOST_ARCH properly when
 CROSS_COMPILE is multi-word
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sumit Garg <sumit.garg@linaro.org>,
 Andrew Davis <afd@ti.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Bryan Brattlof <bb@ti.com>, 
 Jesse Taube <mr.bossman075@gmail.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>
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

Hi Jerome,

On Tue, 3 Sept 2024 at 02:38, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> When CROSS_COMPILE contains multiple words, HOST_ARCH is not properly
> detected and the sandbox build fail. It typically happens when using
> ccache. For example:
>
>  $ make sandbox_defconfig
>  $ make CROSS_COMPILE="ccache x86_64-linux-gnu-" \
>         CC="ccache x86_64-linux-gnu-gcc"
>  [...]
>  In file included from boot/bootmeth_efi.c:16:
>  include/efi_default_filename.h:33:2: error: #error Unsupported UEFI architecture
>     33 | #error Unsupported UEFI architecture
>        |  ^~~~~
>
> A similar error occurs when the build is done via buildman and
> ~/.buildman contains:
>
>   [toolchain-wrapper]
>   wrapper = ccache
>
> Fix the issue by considering only the last word in $(CROSS_COMPILE).
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index f90e48f58a5..dc7bdd79420 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -21,7 +21,7 @@ include include/host_arch.h
>  ifeq ("", "$(CROSS_COMPILE)")
>    MK_ARCH="${shell uname -m}"
>  else
> -  MK_ARCH="${shell echo $(CROSS_COMPILE) | sed -n 's/^[[:space:]]*\([^\/]*\/\)*\([^-]*\)-[^[:space:]]*/\2/p'}"
> +  MK_ARCH="${shell echo ${lastword $(CROSS_COMPILE)} | sed -n 's/^[[:space:]]*\([^\/]*\/\)*\([^-]*\)-[^[:space:]]*/\2/p'}"
>  endif
>  unexport HOST_ARCH
>  ifeq ("x86_64", $(MK_ARCH))
> --
> 2.40.1
>

I've lost track of this, but did you pull in [1] first?

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20240815195746.749042-2-sjg@chromium.org/
