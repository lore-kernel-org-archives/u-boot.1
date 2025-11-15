Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D81CEB2CC
	for <u-boot@archiver.kernel.org>; Sat, 15 Nov 2025 12:10:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11DAC83A7A;
	Sat, 15 Nov 2025 13:09:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OXyc11aD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6A31839C6; Sat, 15 Nov 2025 13:09:58 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A099F839C6
 for <u-boot@lists.denx.de>; Sat, 15 Nov 2025 13:09:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-640aa1445c3so4470692a12.1
 for <u-boot@lists.denx.de>; Sat, 15 Nov 2025 04:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763208596; x=1763813396; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hhE0wrZ/MO1mNy0gFYNSBaOA1A9h5vOoigkp6Wmc4U4=;
 b=OXyc11aD3LQ24dqjI7S7RQxGU4rJbPckbz1RF9hSKJ2xEzO8JXKk7IqS0QYjFzyqBB
 il42lajCkvnppypi5hG9/csc5y0hTSRVIyQnrlHGS2kYwZ1xFKcJ5lOeNUjmk/gNGE4n
 imtw6zHhgouehgMOt0xiNIvpjpoi0db2ReWtYce+vuWvPejTr6eU3SOfHpJeFCmBtx8Z
 wrkvNe7vea1hYi7eBr6sRXsCOv90QF5J2WQIkyd3ItxOiIJsjOGxz52ipZCTNismYlHx
 vgPCcex0a3oSU2DwfPxo89is1/75rRbNMM0GqJjUj2a9soq0lh9fJtAL174J537Ln+vk
 kgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763208596; x=1763813396;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hhE0wrZ/MO1mNy0gFYNSBaOA1A9h5vOoigkp6Wmc4U4=;
 b=k2QYpqCxOlrqgArSMIxcMPKQgkPo3V9OLwAoNazxBsK1VTIfprlrRaWTo3e4tKe752
 Wv5zd+vim+z2tBLR+e0FOi0plrVMFb8CSkecSbvKctZVHxJTbylkNrZBch1vPO03Nazf
 GlNhqSh3W6ZDRdDCXQUdBE7kwOK5/xiptcAK2aOegID/DxZGjekT99kqf+4izN+CQtPk
 xL+iRNAsBNxw7KAQ/qW5MqZ6CBOs4xiC95n0f6cCw7VTrMY4yd7SVA+/7OGTv3sC6bCY
 BD31sXLoNVrNKJ3h48ZElwjrCPa7fYEJoGvF8KNwxS29ovUORexuPO6P+bYTDbaXY8Qf
 ziBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMkocRtvWPP7dT/xdd+8Jn57ZvJfHPLGZzP93rRACt6LOs226tbr7g5kkhl4URvo57+Xh06fQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyhhOtV+DSeJK42UOelCzqPzE1/IA7B2HS6Wvip5wmqJhiymnc9
 1eolu2NYzpuMJRM5GjPj1mzCjUe4pmRYIt44Y1RchC0ydu9CfeTsuvhrh2o39FFvoZa+L3sQl0C
 3UzL1bfyCmDGQUqfTEOAeM6DVs2tRis0=
X-Gm-Gg: ASbGnctaxSXVn+Av4BOUKtt+7w5BiYw9HruTegiczd2NpD+e6St73AUEisWdczXi+6A
 2cSIVX4EMbxT443y6bKOr0GdO7A/VlLNYWsPH755+IolGJVbai9W/hi3jMV+UnphEtM1ByUvYxS
 n0DY8Y4bQfhz17FFy/8QGNox6Bg+NQRD4MIQqymfIetPec73IvFXyQV/OTLbC0V8i/3vgIUJZTS
 sQDayUY+HPiqX2oRC5VrBdEytowupjz1CMz38l0kfTXHfhZ36AVeqQA1fU9lwTkq9q79M8ZEOyM
 QoFn0HzGHiarfxNEEXRySeTTpYLVxSbf78XkAHi1NrfjcL8VvnjfZjGz84MceqC97YMDdUdArE+
 7iaB0KqgMQBp22cjlwyeg1pumjJh+NX8HxNWaaFq77H/ZI0KzgOpE3w==
X-Google-Smtp-Source: AGHT+IG9qDKFTGA/xaUL5yLEiILDO+3DowEC8WIgHuFbEYC88ii9I01g2aaZEvlletkQD1PcYOayvj/Q2gJsS+fxZrk=
X-Received: by 2002:a05:6402:278f:b0:640:f481:984 with SMTP id
 4fb4d7f45d1cf-64350e11448mr5279657a12.2.1763208595743; Sat, 15 Nov 2025
 04:09:55 -0800 (PST)
MIME-Version: 1.0
References: <20251115073329.35720-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20251115073329.35720-1-ilias.apalodimas@linaro.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sat, 15 Nov 2025 12:09:44 +0000
X-Gm-Features: AWmQ_bkVEQoYfNjeP17ZmTieiXzgN0gBQxsnFoNBjrDjClcKhR6dKhWpARFUSPs
Message-ID: <CALeDE9PxD1ax2rnXbViD=LjmMnzE=O7sHTzNQYYdq6MfCJQm5g@mail.gmail.com>
Subject: Re: [PATCH] rpi4: Fix compilation with larger configs
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: trini@konsulko.com, Matthias Brugger <mbrugger@suse.com>,
 u-boot@lists.denx.de
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

On Sat, 15 Nov 2025 at 07:33, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Tom reports that adding more Kconfig options fails with
> board/raspberrypi/rpi/lowlevel_init.o: in function `save_boot_params':
> board/raspberrypi/rpi/lowlevel_init.S:20:(.text+0x0):
> relocation truncated to fit: R_AARCH64_ADR_PREL_LO21
> against symbol `fw_dtb_pointer' defined in .data section
> in board/raspberrypi/rpi/rpi.o
> make: *** [Makefile:2029: u-boot] Error 1
>
> Since fw_dtb_pointer lives in .data it might end up above the
> +-1MB that adr can reach.
> So switch over to adrp+add which has a +-4gb reach.
>
> Reported-by: Tom Rini <trini@konsulko.com>
> Closes: https://source.denx.de/u-boot/custodians/u-boot-raspberrypi/-/issues/2
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Minor nit, it's not rpi4 specific, I'll update on commit.

Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  board/raspberrypi/rpi/lowlevel_init.S | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/board/raspberrypi/rpi/lowlevel_init.S b/board/raspberrypi/rpi/lowlevel_init.S
> index 8c39b3e12e80..30c0b0c27a81 100644
> --- a/board/raspberrypi/rpi/lowlevel_init.S
> +++ b/board/raspberrypi/rpi/lowlevel_init.S
> @@ -16,7 +16,8 @@ save_boot_params:
>
>         /* The firmware provided ATAG/FDT address can be found in r2/x0 */
>  #ifdef CONFIG_ARM64
> -       adr     x8, fw_dtb_pointer
> +       adrp    x8, fw_dtb_pointer
> +       add     x8, x8, #:lo12:fw_dtb_pointer
>         str     x0, [x8]
>  #else
>         ldr     r8, =fw_dtb_pointer
> --
> 2.51.0
>
