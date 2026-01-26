Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3984DC88E49
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 05:15:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A2BD83E70;
	Mon, 26 Jan 2026 06:15:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f986hunw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B31483E76; Mon, 26 Jan 2026 06:15:43 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E998C83DDD
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 06:15:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b883c8dfb00so876552166b.1
 for <u-boot@lists.denx.de>; Sun, 25 Jan 2026 21:15:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769404540; cv=none;
 d=google.com; s=arc-20240605;
 b=LsmS8g/lIw+mArQi+CzGlEUEs57fqRvJzonVzeT7AS0TfN6uONhgfdLkCYizbolx8a
 qPKHfr++FxOKGQGOOh1zO5BpUbxhsYvY5UwctbRnzukghedG7DOisDCEYLkVMQYFycNx
 sIVpbXcK2CyGZKJkLuNmxq5PQVucPUA2V8U2NNjJMX9vZaUVdrcEEAfBqQh5JBYChCj4
 9RXH8JpGNnCAZVOLZNINCZ40Wf+cbAivnHBIGiA2zdsMVuftRT9yvU8u6ePasbMkaaQH
 sDGYxjeTkQ20u/K/BlnsaTKM8oA1++9V1L7MDzBzXA9j6x/i6C97emjaBcAk8B0vkRex
 3Qzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pS7hCuc93ierMToitj4BbfI7Lufh6i8Xhu6imFwuCQc=;
 fh=8yBEU56r5NKo9EN8x6ltPeR/oM/L5gjHYW/GwqzAZkQ=;
 b=buZADhVRhJPjlhVlhmspja+B9vfWGs8ywx4VlMcYw9N6Ao32MXY9Y1z0waB+TnfrYt
 VD8YhWSNVMEUTPsIIOLk178UD0jhQ/K11NDShsRosu+xio6NJDUE1QymR55hSFfYXuHm
 CSwBZSihNC2zuYiBSonpIK+ZaGC+VYNIIwsZ59Ykzc2px+Y9cmOilfAMxNYe9IZhyho4
 f95ucpSKnS/VE7D0F0J4p1ZJnaU42yFltmkHi/lPhQNzn6ilWtjH38JF4horwvN1j+ng
 rFWiCog8MdZzZjeV92Nq0Rqbsr4sMBEzVW8jAp3rJ4+0zhM9xyj0gY9YP9tqh6zNx5CQ
 pfiQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1769404540; x=1770009340; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pS7hCuc93ierMToitj4BbfI7Lufh6i8Xhu6imFwuCQc=;
 b=f986hunwBLb8eoZCiCPR6kjBMoqMHMeyjlJfLOLF4tlzg3yuduD0huZhFZnjJ3eFud
 QUCdPlieL6lu6FmBgzo/qR2emaoRgMGtkWlLELQjLuR2C3Mz+iZP4AbFrBYEOfrvkFrd
 E7NgY6QF9x86qwBgjXGrrRLJJ97fN4+u+TfQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769404540; x=1770009340;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pS7hCuc93ierMToitj4BbfI7Lufh6i8Xhu6imFwuCQc=;
 b=oJAc0HJFDQAbP7yv/uawuEkxvQMjSWD16Ea/mT3I/3SL1sAme1VQZkye0q7UKwUyfu
 QzlfM6uRcYOUuCbTD43m5+8x9StQ9s4GPY5Q0IWhk0U78lc7is0rg+iWLMrbkd6pmAuN
 VIFlt0k6T/RehY8oERBTjXzyzGVos66+6PyfdYfsHd63d+NwnfDn/9+WILxwCD6Wbriy
 BKeZQoTZMM7CRhPBnsEhyGv7dWDZc1RnSbo9P/UE1cTt9cHtHxNZNakSiM7jvY9ZAmWe
 LEVmHXWAHYCxY69efB/x15UrnYcZBOoubQaNBkTn4mkz+OfsLcIoVgKfIsXKgjWa7oGe
 ONOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaoc6zmWO4pKtLeRqemLlZo2AXj8ihmFhHLXktuIlvwWAhvT7A08CcHV8rR7dXBOlKvli6PdI=@lists.denx.de
X-Gm-Message-State: AOJu0Yw5TRqKuHVav+Dk/68FIFWLCgac8pc8Vj7UmRq2AQxt2Sla8Ys0
 OInnX/IIugcSn+S3HQRZ91cnu34IkcPkwWGSQr/hmQLkqqR3J8sFmLptBeK0mWBpiJM58bqtGLC
 fBTfj2pHfgO6ZrazHE9hlc/ehYdqQq3Qz5oetBESonGYCPn2kcuct2A==
X-Gm-Gg: AZuq6aLz54k0dSNz9diOLhWHO418+T+sKQk+oIVvse3SrccT1mNchOrnQR3R/am6wGP
 6UeLfgGbOOkVKsuP/S4bUCNzdteT1LnnDM1AMlHvKt4gIxoOyQrwZRXzY7IXBQJ9XxaL7PyF/tq
 fqf6/kiEhBlVX1hAsC3UcxC30DJTG2D9ece0MZE2FebouKgzciQ2tMoD5qPDDDrzPWwIZ6+fUwp
 GJmk2mZYDpomVJisYtwtVH21WYym+ncFHt+HWhDID8y+SF2Tc7hVWIAtmbko3ddNcIC0Bs1Yg==
X-Received: by 2002:a17:907:9804:b0:b88:6dd4:9ca0 with SMTP id
 a640c23a62f3a-b8d2e88cbbemr230871166b.64.1769404540301; Sun, 25 Jan 2026
 21:15:40 -0800 (PST)
MIME-Version: 1.0
References: <20260122172057.3212673-1-jonas@kwiboo.se>
In-Reply-To: <20260122172057.3212673-1-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Jan 2026 18:15:27 +1300
X-Gm-Features: AZwV_QgFJGd97MfrEGqea1QWaOUtbh9619LgwQL-xEfxAgNvqkyNL7CJeydRIvY
Message-ID: <CAFLszTiZ_gaRnYmmDFgUNVRRaSCRe+-FUDvtit4aeq2v_QOHpw@mail.gmail.com>
Subject: Re: [PATCH v2] armv8: u-boot-spl.lds: Place binman symbols at end of
 binary
To: Jonas Karlman <jonas@kwiboo.se>
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

On Fri, 23 Jan 2026 at 06:21, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> It can be useful in xPL to access symbols from binman, such as the
> offset/position and size of a binman entry.
>
> Place these binman symbols together at the end of the xPL binary for
> ARMv8, similar to ARM and RISC-V.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v2: Rebase on master after "arm: Update linker scripts to ensure
>     appended device tree is aligned".
> ---
>  arch/arm/cpu/armv8/u-boot-spl.lds | 8 ++++++++
>  1 file changed, 8 insertions(+)
>

Reviewed-by: Simon Glass <simon.glass@canonical.com>



> diff --git a/arch/arm/cpu/armv8/u-boot-spl.lds b/arch/arm/cpu/armv8/u-boot-spl.lds
> index d9963846c4f4..b732133ce76d 100644
> --- a/arch/arm/cpu/armv8/u-boot-spl.lds
> +++ b/arch/arm/cpu/armv8/u-boot-spl.lds
> @@ -55,6 +55,14 @@ SECTIONS
>                 . = ALIGN(8);
>         } >.sram
>
> +       .binman_sym_table : {
> +               . = ALIGN(8);
> +               __binman_sym_start = .;
> +               KEEP(*(SORT(.binman_sym*)));
> +               __binman_sym_end = .;
> +               . = ALIGN(8);
> +       } > .sram
> +
>         __image_copy_end = .;
>         _end = .;
>         _image_binary_end = .;
> --
> 2.52.0
>
