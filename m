Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF92C7115B
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 20:02:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4175381FEE;
	Mon, 23 Jun 2025 22:02:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E5k5+MGz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E4D28210D; Mon, 23 Jun 2025 22:02:13 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7470D81E13
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 22:02:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-60179d8e65fso8191720a12.0
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 13:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750708931; x=1751313731; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N6kdkr0iS9mCwUxFUBb7+srrhUlpMCEWuzoVgWmMm+0=;
 b=E5k5+MGzJ8ZFnYXVrwhmEQyxFF6y1M0P8FVuMv3M7TKJ6Z4Phj5c6aB8yfzzshrL0l
 0bdBNJmbQmVL2+D/IauV5xnxTiVbAQt15N27noUqC4luYxR6EYAYbLC7RsOrndyA4eaI
 VEUTwi/pjxVwdNCqtgcHwDofyYofWzEE9BvEHq1BBQRo9UGBgxnYvSK1VKIHwoTpwL/z
 0IOk1n1jUdFsd53fwBcjFkfBJ7/omw2d86BLu/jjeUL1eSgMsf7ZuEricdsFMMwKPJtC
 SbN+VgH1/j55JArmjHdSvAy40ZxTouk+5N6krhrbiRS6Icv69cCN32BhchGIweTU0cQL
 EJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750708931; x=1751313731;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N6kdkr0iS9mCwUxFUBb7+srrhUlpMCEWuzoVgWmMm+0=;
 b=nbRlZ5PYcXMp0LD0H4qqGwJQFlW7yl7o16A11KGCn7DvbAxeRiL0x8dgWPLWp9L66E
 XSSH9vCGysZR4hUlDtCIsYtu020CP3LK7uM1FlWYIgFG4eTiPWD96LqivAZJ9YwGhx+Y
 Qvx1tJnOYRY7IJ8wJE+HnOxYDeoKYWQAwOgdUC/GRPbiKudTZnEB40c4dFGJmIlzmnwS
 sE0PbXgvVPS7JfNBi2aaBa0JxqNFNOKL95J32FeMDwcX/RmHutXrMVJNtB6P3Pt7JTzh
 uGA1r3jT1O7XkMWr8BBqwlBr7aSh1UwE2/5Pn0251L/D6w2P4xWt0wn3gXnH7uKyJ05V
 jlUA==
X-Gm-Message-State: AOJu0YywSGzxj8ENO4sn+8uCXfqW0wAOXgMGNVJnwbpyfJQc1BTHVoAc
 RbzzMhgvAqriI5LtXMpQM8wreza/Y/seCykNpfTAmcau5+YauNGkomO5aWjtJgJtAxafiLSgVxX
 fyWP3GAqoYs3zfO8l8qIADPLM2uSgFyOzgMcP
X-Gm-Gg: ASbGncvZk8qhdFyguiWmDH65c5q/PxZ/PhgIeD+XqK2spfASCk7z3evVAcrUSos9zVo
 ixH+1MQ0jTAubWHDomjfAVqf/ZqgihwHbji34s/RAZTRwTOmLPtagcPDaEQ0A5Cquxekjp86cJC
 NAK03BtLbTPlnnzJaFwrHSvSaKNO/4aH7Le/03Rw90uuHX
X-Google-Smtp-Source: AGHT+IE/TLIFM7y2BJi/7V5+uDKdfScj+ALkdr9/ktGsx91zsgYI838HLhnmPtm70DxVl0qro6PbddMjKM7+hY/Rzr0=
X-Received: by 2002:a05:6402:34d2:b0:607:f42f:d5eb with SMTP id
 4fb4d7f45d1cf-60a1cd1af9amr13186079a12.7.1750708930609; Mon, 23 Jun 2025
 13:02:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250623191011.4036434-1-trini@konsulko.com>
In-Reply-To: <20250623191011.4036434-1-trini@konsulko.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Mon, 23 Jun 2025 13:01:58 -0700
X-Gm-Features: AX0GCFvBhQuaSRZ55MpuGkAK0jMGhG0tm_wn3rbHInS2yznZvup-RWx1IXQDwrw
Message-ID: <CAJaLiFxWkJm45cE=NXDodZUKQTML+2h0-jSemzoFCe5JfRg9AQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm: kirkwood: fix freeze on boot
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@linaro.org>
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

On Mon, Jun 23, 2025 at 12:10=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>
> From: Jerome Forissier <jerome.forissier@linaro.org>
>
> Commit 6fe50e395080 ("arm: asm/system.h: mrc and mcr need .arm if
> __thumb2__ is not set") is not a proper fix for the LTO link error
> mentioned in its description. It causes 32-bit arm instructions to be
> mixed with thumb instructions, which the Kirkwood SoCs do not support.
> For example, board_init_r() is mostly generated in Thumb-1 mode as
> expected since the build flags contain -mthumb -mthumb-interwork. The
> MCR instruction corresponding to writefr_extra_feature_reg() is also
> correcly emitted as a 32-bit ARM instruction (it cannot be encoded in
> Thumb-1 anyways). The problem is, the compiler inlines the MCR without
> generating the BX or BLX instruction which are needed to transition
> between the ARM and the Thumb-1 states. From the objdump output:
>
> 006186a0 <board_init_r>:
> board_init_r():
> /home/jerome/work/u-boot/common/board_r.c:799
>   6186a0:       b5f0            push    {r4, r5, r6, r7, lr}
>   6186a2:       b0ab            sub     sp, #172        @ 0xac
> get_gd():
> /home/jerome/work/u-boot/./arch/arm/include/asm/global_data.h:127
>   6186a4:       464a            mov     r2, r9
> ...
> /home/jerome/work/u-boot/arch/arm/mach-kirkwood/cpu.c:242
>   619aae:       9b15            ldr     r3, [sp, #84]   @ 0x54
> writefr_extra_feature_reg():
> /home/jerome/work/u-boot/./arch/arm/include/asm/arch/cpu.h:100
>   619ab0:       ee2f3f11        mcr     15, 1, r3, cr15, cr1, {0}
>                 ^^^^^^^^
>                 32-bit ARM instruction
>
> Further investigation is needed to understand how to fix the issue so
> that the code size is minimal for all boards. In the mean time, this
> fix disables LTO for the two problematic files (common/board_f.c and
> common/board_r.c). This makes the Kirkwood-based boards bootable again.
> The binary size is increased by 1048 bytes which is perfectly
> acceptable.
>
> Fixes: 6fe50e395080 ("arm: asm/system.h: mrc and mcr need .arm if __thumb=
2__ is not set")
> Reported-by: Tony Dinh <mibodhi@gmail.com>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Changes in v2:
> - Guard the change with 'ifdef CONFIG_$(PHASE_)SYS_THUMB_BUILD'
> ---
>  common/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/common/Makefile b/common/Makefile
> index 35991562a12b..e589f3072621 100644
> --- a/common/Makefile
> +++ b/common/Makefile
> @@ -19,6 +19,10 @@ obj-y +=3D version.o
>  # # boards
>  obj-y +=3D board_f.o
>  obj-y +=3D board_r.o
> +ifdef CONFIG_$(PHASE_)SYS_THUMB_BUILD
> +CFLAGS_REMOVE_board_f.o :=3D $(LTO_CFLAGS)
> +CFLAGS_REMOVE_board_r.o :=3D $(LTO_CFLAGS)
> +endif
>  obj-$(CONFIG_DISPLAY_BOARDINFO) +=3D board_info.o
>  obj-$(CONFIG_DISPLAY_BOARDINFO_LATE) +=3D board_info.o
>
> --
> 2.43.0
>
Tested-by: Tony Dinh <mibodhi@gmail.com>
