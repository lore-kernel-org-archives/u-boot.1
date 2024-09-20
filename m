Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA89CF9C59
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 16:02:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED4D488CB8;
	Fri, 20 Sep 2024 18:01:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="flVRvNbT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D341A88C71; Fri, 20 Sep 2024 18:01:39 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DE6C88C4D
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 18:01:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7a99e8ad977so154696585a.3
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726848096; x=1727452896; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gWX9yPrGyZf0RRIg4K07zox9HUL8AV2YjeFBlk3KkM4=;
 b=flVRvNbTF7fgpkMikBt0ImLDPyFMXTSI4w9zUtxIwRLgymiRilYPy0BQi2Tp6GujAe
 yg0G7NReVNy1bHAYQg3ovIUvC98lgYzQkuj0lTApZdRjxWxPlGW8UIYBNq+KHnMOXl34
 JOkaIbTNyO1axPRVDUWDl0lFPtEADLYvWROi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726848096; x=1727452896;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gWX9yPrGyZf0RRIg4K07zox9HUL8AV2YjeFBlk3KkM4=;
 b=PGDfNrm8fY6gYmiOIUooE73mPaqWR26bJplhRxavByfuxImrfCpg2AT5+81FVKkefI
 H8CLc91+U0TjmiNyQNQzWgl9GXY/gqUcZw6Lj1i1X5AdOgoUefRKcWj27JsG36HkFDRb
 JfE/SLYjdX+APi25CCriaNoFT6lAqDjXHqdxaxfobjizIK1Z3Ci2HG0xaUQJAEHOtK9v
 4SVournyQRgmPsBVOuBiN1Fut9UU+Baq9kCnwYtOUU8x+tIXqhn2/abh9T0nwHgQ1Uus
 jECAmVNCEaWQ0dGdDcVJ5+mmANOi7WQJGvZxu9NgiLw61VraLdFLYBy4RCK931m+O/O4
 /DAQ==
X-Gm-Message-State: AOJu0YxKm3uytk4QQ3zpDMMhxj9is5HTkRn6HYbrYb5Dl3UwfTKnaEQK
 2dVBKBY93W8u7g8pliTIxicX7w5gAN6wKD98xgzvc+KfIn/th0AsC/Wk409zSR3/taThjc5Xm6L
 9O5JbgF4AoYifs+8CupTOKyOHoFezsVxyxzyJ
X-Google-Smtp-Source: AGHT+IEpqySevg/qFgxk/Sdifi07r4CyO+HO2InXGpt6guQ+U916LO+bZPbWUEFFvQEu9nTfYU8cv6o9GLQL7hgznfo=
X-Received: by 2002:a05:6214:4803:b0:6c5:5123:88a5 with SMTP id
 6a1803df08f44-6c7bc614a72mr45872306d6.3.1726848096146; Fri, 20 Sep 2024
 09:01:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240710071612.1717460-1-rasmus.villemoes@prevas.dk>
 <20240710071612.1717460-3-rasmus.villemoes@prevas.dk>
In-Reply-To: <20240710071612.1717460-3-rasmus.villemoes@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Sep 2024 18:01:25 +0200
Message-ID: <CAFLszTgLVi0+RR7QAprD+A4bSzjoywiSTRYKKF0meg05cqg8RA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] kbuild: Allow DTB overlays to built into .dtbo.S
 files
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>
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

On Wed, 10 Jul 2024 at 09:17, Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> [linux commit 941214a512d8, modified for U-Boot by removing the
> include of vmlinux.lds.h and replacing STRUCT_ALIGNMENT by 16.]
>
> DTB files can be built into the kernel by converting them to assembly
> files then assembling them into object files. We extend this here
> for DTB overlays with the .dtso extensions.
>
> We change the start and end delimiting tag prefix to make it clear that
> this data came from overlay files.
>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>  scripts/Makefile.lib | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 3e68d5aa803..549c3619472 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -305,7 +305,7 @@ endif
>  DTC_FLAGS += $(DTC_FLAGS_$(basetarget))
>
>  # Generate an assembly file to wrap the output of the device tree compiler
> -quiet_cmd_dt_S_dtb= DTB     $@
> +quiet_cmd_dt_S_dtb= DTBS    $@
>  # Modified for U-Boot
>  cmd_dt_S_dtb=                                          \
>  (                                                      \
> @@ -322,6 +322,24 @@ cmd_dt_S_dtb=                                              \
>  $(obj)/%.dtb.S: $(obj)/%.dtb
>         $(call cmd,dt_S_dtb)
>
> +# Generate an assembly file to wrap the output of the device tree compiler
> +quiet_cmd_dt_S_dtbo= DTBOS   $@
> +# Modified for U-Boot
> +cmd_dt_S_dtbo=                                         \
> +{                                                      \
> +       echo '.section .dtb.init.rodata,"a"';           \
> +       echo '.balign 16';                              \
> +       echo '.global __dtbo_$(subst -,_,$(*F))_begin'; \
> +       echo '__dtbo_$(subst -,_,$(*F))_begin:';        \
> +       echo '.incbin "$<" ';                           \
> +       echo '__dtbo_$(subst -,_,$(*F))_end:';          \
> +       echo '.global __dtbo_$(subst -,_,$(*F))_end';   \
> +       echo '.balign 16';                              \
> +} > $@
> +
> +$(obj)/%.dtbo.S: $(obj)/%.dtbo
> +       $(call cmd,dt_S_dtbo)
> +
>  ifeq ($(CONFIG_OF_LIBFDT_OVERLAY),y)
>  DTC_FLAGS += -@
>  endif
> --
> 2.45.2
>
