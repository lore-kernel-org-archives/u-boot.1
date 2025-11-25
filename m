Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACEFFD0E6CE
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 12:20:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E4DA83FFE;
	Tue, 25 Nov 2025 13:20:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fIgzHJKL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05BBC84015; Tue, 25 Nov 2025 13:20:37 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB5E183FF4
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 13:20:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6418b55f86dso9131536a12.1
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 04:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764073234; x=1764678034; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mMeHEX5ZNuVWe8L4jTleMnyU9926cwKVSJfadEnPXb0=;
 b=fIgzHJKL+ggo5xO87/TYH4Y/r7G31/+yrD17pmdCu9at3F0hWAcjQSaRUK31y/k0Js
 saknvrGrbtwNZXbr3OwLS+LwCe6fnmu9oCfBHsqA+Rt29I6JlBJaB0S9sxYttGxkYpyM
 G63YamX0yKwVu23kOwHhrJOmiGWKo3se1sGv2cq1Nw3GQVXNIMb0BJjjf5siLtqv5v17
 ZIjc6hClD8sCraEbyfS5dmerE3VJs/kdhOBDIFA9ezrGcxr5SS031ZRmS7X5cLdkm+OB
 dx+igp6s76JPOSLfLZyK3yKCGDSQAmSBkFKZkMEblzNDfJyqeqDgb10JQlhnffoJEB1h
 zYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764073234; x=1764678034;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mMeHEX5ZNuVWe8L4jTleMnyU9926cwKVSJfadEnPXb0=;
 b=NsrQua73uHv+LgQLJSUor7RPHah9hFzoZ2HYwJuSo9oGpm3qq3fAJBDNsXuF2ALVKJ
 oNOQlD0YnkBKTd7/XnAfB260o8MryViiG7QV4TOgGe7cPLvRiTqE7Kl3SipqIQMtr6TA
 80E5t1j6mDv/pDVt2LbVsTQ3NWc2KJqrSObf8KzXUrVj2bBaKT7IDgBN0thrdUPlXtcA
 5aec51CPXozGY9AqnKxusfI+2XwER2mX8vssLz42hsXklnhDD1rih1uhFPUvZFl3sZIN
 9kw69iRdlV7vZDdtNKpyGuA+jEXzKu6ZJFuP01QOkYiur1p5LNJFnOuNb89zrffc8Ak0
 AX4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoZYLT5f+7ovw3hUC3bx+ByULBNJcLA5IWWBFy+zChhT2jvaSKhyPYUUDQuuLOFvTVi2YX8Bc=@lists.denx.de
X-Gm-Message-State: AOJu0YzguYe8wetPKzax+ABxzyxFB0JV9OBSX5MIMoWdNixTMSQDSYkf
 eWh8acsXssznyJkS1GiR4MA/6vowTu9SDqgwMfrAyQ6C/IDYj0fKT/yXvNKwSTZIQCusdNHw+aq
 9m2ZBI0/+nKmQvDaffXUGrBz/inFyiDHgSA==
X-Gm-Gg: ASbGncslaGEAd4p1ZvlI3cXHG9J6Vt2mRtsSmZ0XblRF6aJbX0Xk/ZY2SvPQbh8mJkI
 QlOOH45YjB7lu6ALZm0Y69ZVs5ycmiXKgqgjdrsMNnXD7fPYfIuAMUIazfDqFnOwRhiGot1R+uv
 tpLRideEKmQZIUfIYwcHBhu31SIVXaGlagM7eWx8u2CFl4tafNFvNvqq22SdHeqJKIXKmBVrZzl
 TAAhHTY/ddZkpEpduGcGRZLKwLo/lIOhOkWwSi/vEMneYjDY40DXsSv7yXGSHD+z5My8SCvqpQR
 7qy2uwOLlo9P5K3cpzbwlxM3KgOzpVXzogYYPRh3crzUwIk5wpGUAHiIMhuo84BJqm0K/lxdkKD
 s5zRpwX8ygbSZ+JwwJBM+Elhcmv4ATl32DzzdCYVI5tdKTtZADYhLZ35uY59EoWHU
X-Google-Smtp-Source: AGHT+IF4D5DnFdjsx5QjAnSw55D3RYgH5Sp2IakBVsvdNTk4Z8Q1/Q0wqQMnD61eeX5y5F7AaOrqEgiTsA8CjubtFYM=
X-Received: by 2002:a05:6402:3054:20b0:645:c6b1:5f9d with SMTP id
 4fb4d7f45d1cf-645c6b15fd9mr5518915a12.5.1764073233913; Tue, 25 Nov 2025
 04:20:33 -0800 (PST)
MIME-Version: 1.0
References: <20251125102358.1850991-1-anders.roxell@linaro.org>
In-Reply-To: <20251125102358.1850991-1-anders.roxell@linaro.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 25 Nov 2025 12:20:22 +0000
X-Gm-Features: AWmQ_bnH2sdrs9922ALJYmn9DNZIRf9Vp7zBkPMV4YdMGcvFNNyuq9uiKdASm4E
Message-ID: <CALeDE9O4KOsRFsxZcnJxOVTzzJkn62k+bT=vgHa-k__qkjO0Yg@mail.gmail.com>
Subject: Re: [RFC][PATCH] rpi: Fix DRAM size reporting to show total RAM
To: Anders Roxell <anders.roxell@linaro.org>
Cc: mbrugger@suse.com, trini@konsulko.com, ilias.apalodimas@linaro.org, 
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

On Tue, 25 Nov 2025 at 10:25, Anders Roxell <anders.roxell@linaro.org> wrote:
>
> The VideoCore mailbox GET_ARM_MEMORY only reports the size of the
> first accessible memory region (~947 MiB on RPi4 with 8GB), not the
> total RAM. This causes U-Boot to display "DRAM: 947 MiB (total 7.9 GiB)"
> instead of "DRAM: 7.9 GiB".
>
> On Raspberry Pi 4 with 8GB RAM, the memory is split across multiple
> non-contiguous banks. The dram_init() function only sets gd->ram_size
> to the first bank size reported by the VideoCore firmware, while
> fdtdec_setup_memory_banksize() correctly populates all memory banks
> from the device tree.
>
> Fix this by updating gd->ram_size after dram_init_banksize() has
> populated all memory banks, so it reflects the actual total RAM
> across all banks.
>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Please add details as to why this is RFC? What comments are you actually after?

> ---
>  board/raspberrypi/rpi/rpi.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> index 1b0b664fa2b7..0cd45104b3bc 100644
> --- a/board/raspberrypi/rpi/rpi.c
> +++ b/board/raspberrypi/rpi/rpi.c
> @@ -332,13 +332,27 @@ int dram_init(void)
>  #ifdef CONFIG_OF_BOARD
>  int dram_init_banksize(void)
>  {
> +       phys_addr_t total_size = 0;
> +       int i;
>         int ret;
>
>         ret = fdtdec_setup_memory_banksize();
>         if (ret)
>                 return ret;
>
> -       return fdtdec_setup_mem_size_base();
> +       ret = fdtdec_setup_mem_size_base();
> +       if (ret)
> +               return ret;
> +
> +       /* Update gd->ram_size to reflect total RAM across all banks */
> +       for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
> +               if (gd->bd->bi_dram[i].size == 0)
> +                       break;
> +               total_size += gd->bd->bi_dram[i].size;
> +       }
> +       gd->ram_size = total_size;
> +
> +       return 0;
>  }
>  #endif
>
> --
> 2.51.0
>
