Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F22C3600C
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 06:13:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71E1A8303B;
	Tue,  8 Apr 2025 08:13:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tRkxwfde";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D5A383095; Tue,  8 Apr 2025 08:13:42 +0200 (CEST)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FFD882FBE
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 08:13:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e6405b5cd9bso4378403276.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 23:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744092818; x=1744697618; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ogB883ohPhuNWGfLFYV8uzoJPntjrI1mT7tdL8LJMFU=;
 b=tRkxwfdebCfgV+BkIO/b2ZOdDZI8yYOgDKgiwff3TkJACRSud+fKgK8lR16/EOgKBG
 QRARif2a2Z2enaBFHpa5UBzV4EnY86iD09OdbXcptdUrxUDtoqb38io3o9xqEqgY70ki
 zEKRZxxhrBenYr1tfzML8lJKhyjv8nJ447BkJvgqO59LK5au2VP0Ve4ou6JF1PTPXYBy
 FeDyW0KYooDigcq5nlAtik/I5eiFfkU/qI/ZbsZnc3ECSstAZoyEpvhGrBk49fDSA4sw
 UhRimdLGUMEAaFMJ2dQzvZ8+rd5gdsLFwxR93cGRyZfaJICN2rqS0UGws2BMJbcziHuO
 0Gkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744092818; x=1744697618;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ogB883ohPhuNWGfLFYV8uzoJPntjrI1mT7tdL8LJMFU=;
 b=af1V4d7R/ltvamsFcNV0WJgjUKG4+xfR8o1taQNRjzQJ9xZLiIGyg2P7zhhbjT16+c
 0XJECir9BNI6u+AOd1/BUXvGmzPGsdmquEH5BxhI5CGvbBtu3LiVwWyuqDK+bF0zoasQ
 FN7i4syfF0rTowDFnG2tAt/mN87po49ZUOZbZtMvzc7+95e71jhZdtComKxQc5uG3SYv
 II7kC4Znw8o1ZLRsdTyeEZJhf82vX66oCUF9ki5z1A55TxhXjBLy6SxIOXSICXR3zk7B
 RcndIZcEQsIHaX24CGGc46mBi4MgI7be3045wo0rFANyzX8BDeS6oUYImMeH5M7qRSxN
 Sg8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbMTABwxoocrWelint5Ru7t0DidAhlOUpCytX8NLozrS/ntQczNr8ShrGWJNFjviSv2Awh+IY=@lists.denx.de
X-Gm-Message-State: AOJu0YwFSZOHYvVnpjSIt2onmePcFOFvDPK55mc2l0YaIxZnnqw5LVXJ
 yIqpqhoL98vPv5vv7iiUn3vqk11KdfgXld8bu1pql2B/0HQoqhDPW58bm0m39miNPYK8EW3w06i
 BuV2oANH9f+B1pCRgcf26Sse0djo157PViaJGlg==
X-Gm-Gg: ASbGncsiovtrjfSDpXXaEo3sBgIaO3cMwU50n8x0AowpsbEqa6BCxNckXw8ev/9ykIe
 Rq764CDJoQRT8KvkLoe4WDau506nrkPYloslw5z+Vl2HqvP2n4iQE1feHrj8+GkAsyMj4M2BrIz
 PxCXK70oaXXwRk+6T4NhgjqmLB5/A=
X-Google-Smtp-Source: AGHT+IG0yFDoqTPOpH0SmpFAV2eO++wSOuUKcsORHAq6pmzqNKzPiDqCSGjSHlAdGcIG0d/2RSY02urFAur9+DmUpQc=
X-Received: by 2002:a05:6902:13c2:b0:e64:3f66:90b8 with SMTP id
 3f1490d57ef6-e6e5d8d2712mr4302415276.3.1744092818449; Mon, 07 Apr 2025
 23:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250407064424.71541-1-heinrich.schuchardt@canonical.com>
 <20250407064424.71541-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250407064424.71541-2-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 8 Apr 2025 09:13:02 +0300
X-Gm-Features: ATxdqUHHTcdQvWS56NIq8rbp-0G4goigDeGT9fqyM5VGRAaXwu-Mgi0wE2kN7b0
Message-ID: <CAC_iWjK2rjA4ewJJ++HDVBCSgiGX_8ySOcORSDmyAPFqd76whg@mail.gmail.com>
Subject: Re: [PATCH 1/2] acpi: select CONFIG_BLOBLIST
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, 
 Raymond Mao <raymond.mao@linaro.org>, Kever Yang <kever.yang@rock-chips.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
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

On Mon, 7 Apr 2025 at 09:44, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Since commit 53d5a221632e ("emulation: Use bloblist to hold tables")
> `make qemu-riscv64_smode_defconfig acpi.config && make` fails with
>
>     qfw_acpi.c:146:(.text.evt_write_acpi_tables+0xc):
>     undefined reference to `bloblist_add'
>
> Build with bloblist support.
>
> Fixes: 53d5a221632e ("emulation: Use bloblist to hold tables")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 1a683dea670..a348fccebdd 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -317,6 +317,7 @@ config SPL_ACPI
>  config GENERATE_ACPI_TABLE
>         bool "Generate an ACPI (Advanced Configuration and Power Interface) table"
>         depends on ACPI
> +       select BLOBLIST
>         select QFW if QEMU
>         help
>           The Advanced Configuration and Power Interface (ACPI) specification
> --
> 2.48.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
