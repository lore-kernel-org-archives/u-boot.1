Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68DA5CF3943
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:09:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1DAD89189;
	Thu, 19 Sep 2024 16:09:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kRmmv7oD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA1C4891A7; Thu, 19 Sep 2024 16:09:54 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77BF989178
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:09:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5dfaccba946so477153eaf.1
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726754991; x=1727359791; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wHj5yhT3f9W9+j34S9/HM3JFNOpuxnPkujJ1gqGkXVs=;
 b=kRmmv7oDA2uFqibkUBYGe9rpi1YhjDziVhBCJ2aDSXyyJpeidAPPFRqjmFqlWWNhQB
 CKQRLB9ex9oBRWOldtCb3Xj2IlrIlX2/h5y4/PmgNUV7qVVBbBAlvxsnbcXkLF305Ngb
 u8UZFXvTuC8xUYtiLZgrhqq3BLKmVRSBiZAOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726754991; x=1727359791;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wHj5yhT3f9W9+j34S9/HM3JFNOpuxnPkujJ1gqGkXVs=;
 b=YBLij/CO1AeRJlnT/RU2HoLjJHrgOMnPxq0bFGKWZBkcKeGwCkfYn3YV52rV3W+aL/
 hF1nHz2kQbhSliEzV4JaWCjpb/CEu9HW7Grl+CghXI4iGMt2AOI18OMUzGE/qxzz/nD4
 eYbguu+pgs6LavHrz/lw1oGdJIoaTn2RLkQx1HYH3tMYNEbts6Ji2+ac20jaz+rz5mk/
 +/nGYMSd2QLypQC2Rei1o5y0fA6V4COU5wO+s3gAobVdysAc2RScXDDQoUYGOKyl80rT
 vqXkHsY2qu/SRazndNTDlJ8IN4nkYB9/U/h8iP7SdnyJC9oS1iUN/rhEV2xeEELepC+4
 1xFg==
X-Gm-Message-State: AOJu0YyYIK0IwHL2h+glLjN3QFey5Qi7+wHr4nb+0pZfdbcJfU5dVN6u
 s0Qjhy99UdR+8OZO505kZ91AoPBEe8X6TBC3MBefpHz+533RDIjOWtTwkkZWYMeZzNsMmuZ9pj7
 VaDl16yEfgxHzFbTyQ4U8oF+5CTsz+4HZCfpO
X-Google-Smtp-Source: AGHT+IHw7ytM33H0zCxGaVjE23CzZLT71DyjAEijZDU6JIfyaeHs8yvlCsZTVmpcc1B4CqFQV0z+tmkxPRqmSnKg1W4=
X-Received: by 2002:a05:6358:9147:b0:1a5:6b71:dde6 with SMTP id
 e5c5f4694b2df-1bb14de9155mr755565855d.3.1726754991210; Thu, 19 Sep 2024
 07:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240918090359.743-1-al.kochet@gmail.com>
In-Reply-To: <20240918090359.743-1-al.kochet@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:09:40 +0200
Message-ID: <CAFLszTiq+eFoK_FTMHXXQ040nsJ1Gbw75oN6i4zcVK4aMRsrRQ@mail.gmail.com>
Subject: Re: [PATCH] Makefile: pass external DTB provided by make variable
 EXT_DTB to binman
To: al.kochet@gmail.com
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

Hi,

On Wed, 18 Sept 2024 at 11:04, <al.kochet@gmail.com> wrote:
>
> From: Alexander Kochetkov <al.kochet@gmail.com>
>
> Yocto build is using EXT_DTB to repack U-boot during signed
> FIT kernel creation. First, it takes the DTB from U-boot, than

U-Boot (please fix both)

s/than/then/

> it creates signed FIT kernel image and places kernel key into
> the DTB. After that it executes:
>     make EXT_DTB=/path/to/dtb/with/kernel/key
>
> Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
> ---
>  Makefile | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

How do you handle a FIT with multiple configurations?

>
> diff --git a/Makefile b/Makefile
> index 1c754ceb595..21b47cb2b59 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1367,7 +1367,16 @@ u-boot.ldr:      u-boot
>  # ---------------------------------------------------------------------------
>  # Use 'make BINMAN_DEBUG=1' to enable debugging
>  # Use 'make BINMAN_VERBOSE=3' to set vebosity level
> +
> +ifneq ($(EXT_DTB),)
> +of_list := $(basename $(notdir $(EXT_DTB)))
> +of_list_dir := $(dir $(EXT_DTB))
> +default_dt := $(of_list)
> +else
> +of_list := $(CONFIG_OF_LIST)
> +of_list_dir := $(dt_dir)
>  default_dt := $(if $(DEVICE_TREE),$(DEVICE_TREE),$(CONFIG_DEFAULT_DEVICE_TREE))
> +endif
>
>  quiet_cmd_binman = BINMAN  $@
>  cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
> @@ -1377,7 +1386,7 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
>                 build -u -d u-boot.dtb -O . -m \
>                 --allow-missing $(if $(BINMAN_ALLOW_MISSING),--ignore-missing) \
>                 -I . -I $(srctree) -I $(srctree)/board/$(BOARDDIR) \
> -               -I $(dt_dir) -a of-list=$(CONFIG_OF_LIST) \
> +               -I $(of_list_dir) -a of-list=$(of_list) \
>                 $(foreach f,$(BINMAN_INDIRS),-I $(f)) \
>                 -a atf-bl31-path=${BL31} \
>                 -a tee-os-path=${TEE} \
> --
> 2.17.1
>

Regards,
Simon
