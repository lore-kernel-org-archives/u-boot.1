Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54FFDC19F4F
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 14:43:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C70FF8874C;
	Wed,  8 May 2024 16:43:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cbRbo2Pg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D592088760; Wed,  8 May 2024 16:43:12 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA99888723
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 16:43:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a59a0e4b773so1077485866b.2
 for <u-boot@lists.denx.de>; Wed, 08 May 2024 07:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715179390; x=1715784190; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZWk3S3LEnAAy84oh5xF3FflQ7HUgggRuzBUXlydelAk=;
 b=cbRbo2Pgrmfa6A0s0vQn++aXFnOz8cjjqJfwZiMhtjz+onKXfeE02jrJoWjHlornZ8
 kfj2jKTOfD2OyO16JsFTZnV9q2/JFV42USQF6rCIA15m0UqKEzt7DQJLwB72lxddMcws
 zXZ5VGx7TjieVH+b/LWCYyRzpoUPJ4xWLVhTCcPvvuSTBKHvm+Ob26PSOV8qcCHg8H8q
 ITbVP53wjJru98SzbmCPCSGIbyXUJOt9++p1NjSFq6ve0gAOaEyUeQy/eU5BJqXwbvAw
 vFKXkprI6k1AU6pueaQwV65URF1VrmwskymkNI7Y4HhHKVhyYH55UQGAOyiFHVIyGm2h
 Y5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715179390; x=1715784190;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZWk3S3LEnAAy84oh5xF3FflQ7HUgggRuzBUXlydelAk=;
 b=Sc+e/y5IC/HEA/JsZV8koAgGHVUIS4aOY+eKsRmsCvYx2zZhX/7fneswiiN6O+Gqz0
 XtkwWbV+WRSLKFbFkiitL8WrNB8LROwllsFWP0VaUfSKBcSqpAG946CF8SYKNB7LRULO
 6B+tiHTDQCW9oec3TbC4tjAy5XcQxLCPcsxCSzIzrLdU1S0pbrce9UvsQzbH+cbP3y8n
 zjKrqS/6FeqMpFjNT9c+BgCCmeUCrD7dynJbTE5EvKNSEOP/5D6h5PGqHeVOg2UjIBrT
 MDJUraxiY7LXX+4LgWOkl4FlmDm0ohtLWh3tx+BjTPHhuaG9Jo+SMu9uPid02sbn0y4C
 fOcw==
X-Gm-Message-State: AOJu0YyzNwIfwXhN7bu8xp+NS6fUrrNcUbF/T+LRe8zmf89MXblifPZX
 7BqVNCZLyT/fM1P0MhYlnrga67uR2XCh8mdg6BRI6cz/kXDqIlUfCJJG1bxheAk/nKdLrUogpPd
 m7hWzdbYGJGC8ITrCgnzqmaYxyDYOD0qZp2u3fg==
X-Google-Smtp-Source: AGHT+IEok15Vs8OQvAmmSFDAk6y+krcgyTl88kkvj3rdFbLK8jC0pFcOPGS8nh24UorR9EF79AsXFcUc+Fljb59QLgw=
X-Received: by 2002:a17:906:7188:b0:a59:b4e8:d928 with SMTP id
 a640c23a62f3a-a59fb955954mr173822766b.19.1715179390357; Wed, 08 May 2024
 07:43:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
 <20240507175132.1456512-5-raymond.mao@linaro.org>
In-Reply-To: <20240507175132.1456512-5-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 8 May 2024 17:42:18 +0300
Message-ID: <CAC_iWjK+14L6mEi8GQN-McF-SChvhnjJ79nE1tWLV+kgWZKVew@mail.gmail.com>
Subject: Re: [PATCH v2 04/28] arm: EFI linker script text section alignment
To: Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Andrew Davis <afd@ti.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Sumit Garg <sumit.garg@linaro.org>, Jesse Taube <mr.bossman075@gmail.com>, 
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, Sergei Antonov <saproj@gmail.com>, 
 Ilya Lukin <4.shket@gmail.com>, Bin Meng <bmeng@tinylab.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 Alexander Gendin <agendin@matrox.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>
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

Hi Raymond,

On Tue, 7 May 2024 at 20:53, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Add text section alignment to fix sbsign signing warning
> 'gaps in the section table may result in different checksums'
> which causes a failure of efi_image_verify_diges()
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - None.
>
>  arch/arm/lib/elf_aarch64_efi.lds | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/lib/elf_aarch64_efi.lds b/arch/arm/lib/elf_aarch64_efi.lds
> index 5dd98091698..bffd9a0447a 100644
> --- a/arch/arm/lib/elf_aarch64_efi.lds
> +++ b/arch/arm/lib/elf_aarch64_efi.lds
> @@ -28,6 +28,7 @@ SECTIONS
>                 *(.dynamic);
>                 . = ALIGN(512);
>         }
> +       . = ALIGN(4096);

There are linker symbols a few lines below marking _etext and _text_size.
Those should be moved within the section alignment. On top of that,
more architectures will need a similar fix.

Heinrich don't you need similar changes on risc-v?

Thanks
/Ilias

>         .rela.dyn : { *(.rela.dyn) }
>         .rela.plt : { *(.rela.plt) }
>         .rela.got : { *(.rela.got) }
> --
> 2.25.1
>

Split this off to a preparation series. This seems like a generic fix.
