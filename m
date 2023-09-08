Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EECFEE57E7
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 09:36:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AC11869B1;
	Fri,  8 Sep 2023 11:36:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cLkyX4Wv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 035DE80275; Fri,  8 Sep 2023 11:36:35 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DB5E86580
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 11:36:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2bcfd3220d3so30871771fa.2
 for <u-boot@lists.denx.de>; Fri, 08 Sep 2023 02:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694165791; x=1694770591; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8WfNGGaZbm+JuECthQ7r6XPKeGogFjHXxjxhC8hBZ6E=;
 b=cLkyX4WvDrnUbbiVEYxPD4Gq+KVtMM9ta7fPhDc7WDAvPT2rLH4jZ5f9EDY14Y3L/j
 6fPSZiDcnJTAsP2yxBmV3Dx94RrVuEM296QJhmI2OAdJZ/IDMjtGfyvCiAhy0Qty5q+g
 IrImrpc1nZ1zZHBlyeBXrsygE9NykH2yIt33wPKLZHbds0aoYGgRCHQ2iQMblqrhprmt
 OOljiqHJCvZdLhC8tXaHopbslUSCoMKPmMSJO8//JVOjsLuLh8vXAFnkHSMgd9BFsSsj
 vN69xaGqT40CzP6C5lxfuyvBHNA6nR1FqiMabX0TShC+VCSpYOZz6bQgMxCrYC9rU5W8
 +80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694165791; x=1694770591;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8WfNGGaZbm+JuECthQ7r6XPKeGogFjHXxjxhC8hBZ6E=;
 b=ulvoqftOBZ7tsIyONqh92UmiTG4nJVtNdxI5dKQECX26N+FqpMS35cPrp1YXh+5znB
 Qz3Pb8A79jFv6Vrp2Bn554Iv0ZTLrep77Ojr89XsoRf2YLe+8Cd4YbAOnEJOtUWqqp7b
 5X+dRDtJuiwvc/acjePgxgUwVNfiuaBGM4fn95aaYjubSg+ChPffXWU8J38cNKPzDzAA
 RrFXTeq2TzbZVElcsYLPspwyOWRfACGzE1j/42NRqdxkd3SF4IXMmSff6+ciADkEfMT+
 UBpxYKsntSkerFUt6Po8Tgp8ty3WTiNtvn+ayGaVQxTLaAFt8cqpxQ/X5+SEPMUd8K+G
 cshg==
X-Gm-Message-State: AOJu0YxmtsQm86Au2rhF2TjXhmYY2aa2N7UCEgVp2er2L9O0P7S00eBr
 p4m3PRZluv/8LC6ZNI/+0wwGbaI2PULD/kZ1/ps=
X-Google-Smtp-Source: AGHT+IG4ckpAQl9q8MMXUgbqCFuW0h6bOaD1+FpJxTU1aaBhnuFBuIbVt/5dwOQj+cxvEW0uAmw1wmck6QpcDeVrer4=
X-Received: by 2002:a2e:9dc6:0:b0:2bd:1614:d47 with SMTP id
 x6-20020a2e9dc6000000b002bd16140d47mr1483674ljj.42.1694165791361; Fri, 08 Sep
 2023 02:36:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230907155933.48511-1-sjg@chromium.org>
 <20230907155933.48511-10-sjg@chromium.org>
In-Reply-To: <20230907155933.48511-10-sjg@chromium.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 8 Sep 2023 10:36:20 +0100
Message-ID: <CALeDE9PS3J-wGzMNbAJuHtqUkVCnraCAAdJXoEnX_eyoFq2xLw@mail.gmail.com>
Subject: Re: [PATCH v4 09/22] Move fdt_simplefb to boot/
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, Mark Kettenis <mark.kettenis@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Sep 7, 2023 at 5:02=E2=80=AFPM Simon Glass <sjg@chromium.org> wrote=
:
>
> This relates to booting, so move it there. Create a new Kconfig menu for
> things related to devicetree fixup.

Is simplefb booting or video?

> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  boot/Kconfig                    | 16 ++++++++++++++++
>  boot/Makefile                   |  1 +
>  {common =3D> boot}/fdt_simplefb.c |  0
>  common/Kconfig                  |  9 ---------
>  common/Makefile                 |  1 -
>  5 files changed, 17 insertions(+), 10 deletions(-)
>  rename {common =3D> boot}/fdt_simplefb.c (100%)
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 0a98f1e22207..39c51e9e2fe8 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -1538,6 +1538,22 @@ config SPL_IMAGE_PRE_LOAD_SIG
>
>  endmenu
>
> +if OF_LIBFDT
> +
> +menu "Devicetree fixup"
> +
> +config FDT_SIMPLEFB
> +       bool "FDT tools for simplefb support"
> +       help
> +         Enable the fdt tools to manage the simple fb nodes in device tr=
ee.
> +         These functions can be used by board to indicate to the OS
> +         the presence of the simple frame buffer with associated reserve=
d
> +         memory
> +
> +endmenu
> +
> +endif # OF_LIBFDT
> +
>  config USE_BOOTARGS
>         bool "Enable boot arguments"
>         help
> diff --git a/boot/Makefile b/boot/Makefile
> index f15a161614ff..6ce983b83fa4 100644
> --- a/boot/Makefile
> +++ b/boot/Makefile
> @@ -39,6 +39,7 @@ obj-$(CONFIG_$(SPL_TPL_)CEDIT) +=3D cedit.o
>  endif
>
>  obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) +=3D fdt_support.o
> +obj-$(CONFIG_$(SPL_TPL_)FDT_SIMPLEFB) +=3D fdt_simplefb.o
>
>  obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) +=3D image-fdt.o
>  obj-$(CONFIG_$(SPL_TPL_)FIT_SIGNATURE) +=3D fdt_region.o
> diff --git a/common/fdt_simplefb.c b/boot/fdt_simplefb.c
> similarity index 100%
> rename from common/fdt_simplefb.c
> rename to boot/fdt_simplefb.c
> diff --git a/common/Kconfig b/common/Kconfig
> index d11292f52c2b..21eaa5e815f9 100644
> --- a/common/Kconfig
> +++ b/common/Kconfig
> @@ -1157,14 +1157,5 @@ config VPL_IMAGE_SIGN_INFO
>
>  endif
>
> -config FDT_SIMPLEFB
> -       bool "FDT tools for simplefb support"
> -       depends on OF_LIBFDT
> -       help
> -         Enable the fdt tools to manage the simple fb nodes in device tr=
ee.
> -         These functions can be used by board to indicate to the OS
> -         the presence of the simple frame buffer with associated reserve=
d
> -         memory
> -
>  config IO_TRACE
>         bool
> diff --git a/common/Makefile b/common/Makefile
> index 0948721d0b47..5c1617206f07 100644
> --- a/common/Makefile
> +++ b/common/Makefile
> @@ -17,7 +17,6 @@ obj-y +=3D board_r.o
>  obj-$(CONFIG_DISPLAY_BOARDINFO) +=3D board_info.o
>  obj-$(CONFIG_DISPLAY_BOARDINFO_LATE) +=3D board_info.o
>
> -obj-$(CONFIG_FDT_SIMPLEFB) +=3D fdt_simplefb.o
>  obj-$(CONFIG_MII) +=3D miiphyutil.o
>  obj-$(CONFIG_CMD_MII) +=3D miiphyutil.o
>  obj-$(CONFIG_PHYLIB) +=3D miiphyutil.o
> --
> 2.42.0.283.g2d96d420d3-goog
>
