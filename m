Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53891E7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 20:50:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CE03806D4;
	Mon, 23 Dec 2024 21:50:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RTSSncqm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 020CA80741; Mon, 23 Dec 2024 21:50:37 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CD04806D3
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 21:50:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5d3d0205bd5so6199729a12.3
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 12:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734987034; x=1735591834; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zadrwyRlOElnqYsJvM5v5kRYbFesJNmAXI3E8gK6Pj4=;
 b=RTSSncqm0jy+vAaZbP1gzPDhiNF8dk9EAqkYyfabM60LUcX4ZmmyOUotfEqWb44XrF
 u28HljxN8oo3hnDFUi/9XxMMj2o9nojG07/cR7hNfrpINmPtwDRAdFMSLUYudIBLmatH
 U1nPNwC+1dA725OKaEW8+4dKrQKmMqFviUr11HPhRt4q3+8ngdbmkvM3+bkYcT7ipBZA
 u00PEJL8rmfmF/51GPXouR4D9ufs+KjkvGGE98zvBt9y8MW+S0WY4azEfDM02d6Xk2Ki
 vWXV32NhQiMM39VZRwZDl2iGZqUpxcr1zTP1QAIRky23mVvzrumBJncqXjFYYN8+TG1e
 Yoag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734987034; x=1735591834;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zadrwyRlOElnqYsJvM5v5kRYbFesJNmAXI3E8gK6Pj4=;
 b=Eihxs4mh2pdoHjVIOm+u2tpG0XMgPIRsNGDy9NlI4BzTXttGD3brzPuYiainFApPZk
 tzoFjZk5qAO6Z+Y908Nb1Vyo9NUIYFYWPQrktCifuH15F0/Urxvw1XAKKrV3urpdLa9m
 cWLTiU/TZRq0BdOqF4+dXQ/VXYCZicf4Loskzk52/kV73kHdOK5Kd5hc3aoMTc4OupEi
 gaQceb1iXl8m2rFzb4omb6lT4zrqV3n0x4wbQqTKUVp/bdVJ4oOf60UhsQc8SQnHbnoM
 C+ej3YlRcN6CF4f5qkXNm5Kha1uRP1ZnV+2jGeJogSGsm6wO/5T5KaNK6M0nnb9jPziV
 8ZGw==
X-Gm-Message-State: AOJu0Ywob73Qqi2GocDsmTItoy+X0AjjPdGcDwwtY5zDGa8Mz6CQmSPL
 Unbugxf2D6WVd3D1otwcJobdTDb45y1kw1ts3Juw262lFAIKN6RpM8sFlMlHmExqJ9JE5ZtdnlH
 zuhvim/S9Vxjd29vPYveDphBzacLUjTR/
X-Gm-Gg: ASbGnctDo0thZ1DhNJTXFTfRCvbUxDjLveCvEdKSOOYWuGX/GH7KsXEI0lfZRtSAC8t
 XURLltl4HQJzoyNZamYtVMljhCARsubqXe/8i+Zorseggb6+PGto=
X-Google-Smtp-Source: AGHT+IFwu9ss40dplzRhi1OYvFb1RFgMqO7g7jWCxZqvqCD1C/jB0WIdInSVpvsEaRQwG2S8Y1uAQIggEsBPX1gLTkI=
X-Received: by 2002:a05:6402:401b:b0:5d2:7456:9812 with SMTP id
 4fb4d7f45d1cf-5d81ddfbe2fmr15984967a12.22.1734987033660; Mon, 23 Dec 2024
 12:50:33 -0800 (PST)
MIME-Version: 1.0
References: <20241214224344.303452-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241214224344.303452-1-marek.vasut+renesas@mailbox.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 23 Dec 2024 20:50:22 +0000
Message-ID: <CALeDE9O0CLc-vGG1xB8+GSPKb0SuAiUYuwd1m2avKPeOPtDBsA@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: Convert core type check macros into inline
 functions
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Biju Das <biju.das.jz@bp.renesas.com>, 
 Chris Paterson <chris.paterson2@renesas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Sat, 14 Dec 2024 at 22:44, Marek Vasut <marek.vasut+renesas@mailbox.org>
wrote:

> Turn the core type check macros into inline functions to perform
> better type checking on them. The inline functions get optimized
> out in case they are not used. Indent the MIDR_PARTNUM_CORTEX_An
> macros in preparation for addition of future three-digit cores
> and use MIDR_PARTNUM_SHIFT in MIDR_PARTNUM_MASK to be consistent.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>


> ---
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Chris Paterson <chris.paterson2@renesas.com>
> Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  arch/arm/include/asm/armv8/cpu.h | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/include/asm/armv8/cpu.h
> b/arch/arm/include/asm/armv8/cpu.h
> index 40d54dc85ab..aa1470bb72d 100644
> --- a/arch/arm/include/asm/armv8/cpu.h
> +++ b/arch/arm/include/asm/armv8/cpu.h
> @@ -3,11 +3,11 @@
>   * Copyright 2018 NXP
>   */
>
> -#define MIDR_PARTNUM_CORTEX_A35        0xD04
> -#define MIDR_PARTNUM_CORTEX_A53        0xD03
> -#define MIDR_PARTNUM_CORTEX_A72        0xD08
> -#define MIDR_PARTNUM_SHIFT     0x4
> -#define MIDR_PARTNUM_MASK      (0xFFF << 0x4)
> +#define MIDR_PARTNUM_CORTEX_A35                0xD04
> +#define MIDR_PARTNUM_CORTEX_A53                0xD03
> +#define MIDR_PARTNUM_CORTEX_A72                0xD08
> +#define MIDR_PARTNUM_SHIFT             0x4
> +#define MIDR_PARTNUM_MASK              (0xFFF << MIDR_PARTNUM_SHIFT)
>
>  static inline unsigned int read_midr(void)
>  {
> @@ -18,9 +18,15 @@ static inline unsigned int read_midr(void)
>         return val;
>  }
>
> -#define is_cortex_a35() (((read_midr() & MIDR_PARTNUM_MASK) >> \
> -                        MIDR_PARTNUM_SHIFT) == MIDR_PARTNUM_CORTEX_A35)
> -#define is_cortex_a53() (((read_midr() & MIDR_PARTNUM_MASK) >> \
> -                        MIDR_PARTNUM_SHIFT) == MIDR_PARTNUM_CORTEX_A53)
> -#define is_cortex_a72() (((read_midr() & MIDR_PARTNUM_MASK) >>\
> -                        MIDR_PARTNUM_SHIFT) == MIDR_PARTNUM_CORTEX_A72)
> +#define is_cortex_a(__n)                                       \
> +       static inline int is_cortex_a##__n(void)                \
> +       {                                                       \
> +               unsigned int midr = read_midr();                \
> +               midr &= MIDR_PARTNUM_MASK;                      \
> +               midr >>= MIDR_PARTNUM_SHIFT;                    \
> +               return midr == MIDR_PARTNUM_CORTEX_A##__n;      \
> +       }
> +
> +is_cortex_a(35)
> +is_cortex_a(53)
> +is_cortex_a(72)
> --
> 2.45.2
>
>
