Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0520FC369DC
	for <u-boot@archiver.kernel.org>; Sun,  4 May 2025 07:23:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 360248211F;
	Sun,  4 May 2025 09:23:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="plue7XrA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 539BD82163; Sun,  4 May 2025 09:23:07 +0200 (CEST)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8538D8210D
 for <u-boot@lists.denx.de>; Sun,  4 May 2025 09:23:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e75668006b9so1884349276.3
 for <u-boot@lists.denx.de>; Sun, 04 May 2025 00:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746343383; x=1746948183; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wmmZvkqLDvtboIzQSULxqOsxbnXdzIH1DNrkIV1w7Ag=;
 b=plue7XrARevKgHcTsiBDHpvMP0pVwHkN0Y6GoO53cXb2gCl4xNL8upO4q2xaZupFqa
 bRWrtIxTB5gC3w5kjuAWJjpHuWz3nXBp3y/AfO+4zBiej/v6516c75vg50YvdJj6ZFy2
 cNe4M80fQR0OzTw/1GpzPumMVep3upcAe4YTlrbkQiZ3qTYrsfPKgmY/mCYZHeftkL5e
 J9ZCfmkfkf/lGkrytQLu7371WJsztMfVEuvkQo/OFFBCmkWMXiBKnFpT7xPT/DxgOILC
 dXTNr7xc/U8z6Uqgx9RUn7USQdt7cwfyVuCS6LUEOuAJsgndS/NIU52ZvP1DOMYVFtH+
 Ofuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746343383; x=1746948183;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wmmZvkqLDvtboIzQSULxqOsxbnXdzIH1DNrkIV1w7Ag=;
 b=s/wqSrybp1QIrEJd2PL0Y/RJAiJHFjQ38APzH85oJXdnLicuFkBMKiiU+Z7Y8yxzul
 ln8/wMq1P0DeLjcgtSXiN/ojYBtNIUv/Y7tLjXErnOa5DwUuXk7e2mCsXfNtsew8lCQ4
 OO0mcAqkrLAmFtAuiMk3lgfnuUkuaLEWWEs7h7VwvEXUoE8/cCqi6365IAQav2v9urPc
 61JLE3/uT/CHrW4dL/S+MiFxaEDPXgxgT6PPDpSJXN6Uvsl6XdoVenHdyLMF9EjyPgbO
 4Aw3vkv9fVEWnCXpJZchUm8TMn/CFxhIMaqAevzuNBZt0w6OQlXWNFWDaszhdGu4siom
 aIjw==
X-Gm-Message-State: AOJu0YzJHls51wi8TkS2anz6Wndakx8KSgMRM4U8QGEDHo3Dvf8HGWQd
 lQxFoNAlUfGjlkwChA8fVNjNtsbxDNSsGnzWXup4ZO1REFdNiUqEpDtrsLwd2QaafY0BeBFWMcB
 kCx+aV8jVdyl15Vo/57VxvEcupJxgQNk55UoJDQ==
X-Gm-Gg: ASbGncs/Fa/y7xRJiOv2ECixOKgB26YU51RE8I6wQTKLLCVo8xjSyDaQiMk2Y74O37W
 89ujpGzL0Ikre6BUt7JMmISEDM+IVEyFFVKNkRVlErU+4ps1Bdjf8+IJyAM/26tKNimt74WnxTj
 j2aTSdn4jRrviUsJuT2x6s+Q==
X-Google-Smtp-Source: AGHT+IE9nV1WrUa8eAaj09fXKbIvhUWL9Tc4AyVakRmp1zLK2wvQfNiitmkzouWBIPoKqrPYyeI0+WgVC/yOWSIWijg=
X-Received: by 2002:a05:6902:120d:b0:e72:8aca:d06b with SMTP id
 3f1490d57ef6-e757d2fe802mr3643496276.25.1746343383151; Sun, 04 May 2025
 00:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250417181613.1355024-1-sjg@chromium.org>
 <20250417121601.v3.10.I56d9d06e5d74724c963eaffbbe1c2aa400b60bb8@changeid>
In-Reply-To: <20250417121601.v3.10.I56d9d06e5d74724c963eaffbbe1c2aa400b60bb8@changeid>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 4 May 2025 10:22:27 +0300
X-Gm-Features: ATxdqUF50llOwCr3RiDbvoRaSMfnz_TPqcUE0UVKXMXJYr--a7QmVNPlLsNIOag
Message-ID: <CAC_iWj+EJ1p1JcfC2NFWg097Uyk_tv0h2PsZj1Y1nsETrSU3ww@mail.gmail.com>
Subject: Re: [PATCH v3 10/22] passage: arm: Accept a passage from the previous
 phase
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>, 
 =?UTF-8?Q?Fran=C3=A7ois_Ozog?= <francois.ozog@linaro.org>, 
 Bill Mills <bill.mills@linaro.org>, Albert Aribaud <albert.u.boot@aribaud.net>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Xu Zhang <423756212@qq.com>
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

Hi Simon,

On Thu, 17 Apr 2025 at 21:16, Simon Glass <sjg@chromium.org> wrote:
>
> Accept a bloblist and control devicetree from a previous phase in
> registers 0 to 3, as documented in the Firmware Handoff
> specification[1].
>
> [1] https://firmwarehandoff.github.io/firmware_handoff/main/index.html
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v3:
> - Add support for aarch64 also
> - Update registers to match the Firmware Handoff protocol
>
> Changes in v2:
> - Use three registers instead of two for the entry

[...]

> --- a/arch/arm/cpu/armv8/start.S
> +++ b/arch/arm/cpu/armv8/start.S
> @@ -57,6 +57,18 @@ reset:
>         b       save_boot_params
>  .globl save_boot_params_ret
>  save_boot_params_ret:
> +#if CONFIG_IS_ENABLED(PASSAGE_IN)
> +       # Keep passage information in case it is provided
> +       cmp     x2, #0
> +       bne     no_passage
> +       mov     x19, x1         /* mach */
> +       mov     x20, x0         /* dtb */
> +       mov     x21, x3         /* bloblist */

Those are already stored in saved_args. Can you explain on the commit
message why you need to preserve them in x19-x21 as well?

[...]

/Ilias
