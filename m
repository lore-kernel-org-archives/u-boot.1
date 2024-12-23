Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C133E7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 19:34:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6908806D3;
	Mon, 23 Dec 2024 20:34:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XlnoRils";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87B298074B; Mon, 23 Dec 2024 20:34:23 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 325EE8069C
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 20:34:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5d122cf8e52so7391402a12.1
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 11:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734982460; x=1735587260; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AtCLGv1CHoFYS+he9RP+gw/T7M95OlzHD7k19c7IQWk=;
 b=XlnoRils3VO1cT2ZnYJPiaLeiwAMaSE0c0gzo2WNO/cstGowC7dheLLdlC6Zz+MhW9
 qlySQuhIUMEpxDkcQB4ilIbP8XeQSwHhTPxKz86qY/30tNZCltG5+jEHbMwP2A2nVkth
 CgdGWhnDELwLZdnA6Vj9pTIaXfn8JhT/qmIoEVpC+7l8Q0dNcgwL8pxZVkyzw3/ZM0M8
 98c9ifJhfpfhBrN2tRHmrXnTZ8gL1rNzIXNSXMzeCURiTsv+pG5lwJxmMYx4d1er4RDF
 t9B5y9qhVWwifMX6Mx9UBjc39zJdZMbs0XuCzjZwRLmo94lbTrzBtxAYomLL01xAIWKb
 8tuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734982460; x=1735587260;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AtCLGv1CHoFYS+he9RP+gw/T7M95OlzHD7k19c7IQWk=;
 b=XYyz6kCZg7FInRmBHlxEjGp1CjMVlIASrgvJVwiO2hOYVtbgacl5zsOMtCGy+bOZpr
 ZNpZKD1yXGZ5fOSaF7914wDgvtstDJIjQAf21SskL0mVNxvuuUHsfB1IqS9sOfZ4dJhV
 dr9fPSkVAE0bjmvCWvSu3q0fkYYtPMEcgQWUBXHw0miI47OK+t4mP9sJu9arV95GKRs2
 nR2l0J+bcH5axnks9c+9VQBHRtJIrvLF4x97JHLo5jATcrMiObv9gIz5Vv6IawSPtzxH
 KkDVMk7IlgZzX+TnUq9J7it4twMpFP3Zi8G0dUXBR9Qu0aisFgETpeswaOraLTV2EwEE
 jIjg==
X-Gm-Message-State: AOJu0YxziZ6R2Uk5lKlHFWUwMuBpkUAunIdF4w8tRj8cIXQd7gC6LQ1p
 +rj1AmKlKgY/4tUURBLKUPByLSly0icLRoTiJy3/5R61ZxNh9bV37Yi07LK8oWU4LYBc60Hi+SD
 By/J2c3wZcgzkrh37UcLJ8N6P7Uw=
X-Gm-Gg: ASbGncvnq3Z3TtjyjfDtJ+ZzHtDTKtKszob0egjwrhbZ95An8ltC8NTNK4PflbsKHq6
 IhjOhi0dHoNU3c+xc8KHofd2rhvD48tGdCkIkOrgR6WGlyA65/uY=
X-Google-Smtp-Source: AGHT+IEIso+JVSl1zmQhQQXSWGk0lrme+87AlaKxg8iO/NYMfGeZqprTD42er5c/EK5hFJFgIh4EI6UHs/fDEpEvyGU=
X-Received: by 2002:a05:6402:27d2:b0:5d2:723c:a577 with SMTP id
 4fb4d7f45d1cf-5d81ddc0843mr10928578a12.14.1734982460252; Mon, 23 Dec 2024
 11:34:20 -0800 (PST)
MIME-Version: 1.0
References: <20241214224344.303452-1-marek.vasut+renesas@mailbox.org>
 <20241214224344.303452-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241214224344.303452-2-marek.vasut+renesas@mailbox.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 23 Dec 2024 19:34:09 +0000
Message-ID: <CALeDE9NxUnfJMggy+SFRo+m1fY538iCBkhZ4REA+7xKx=Qa2oA@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: Add MIDR entries for Cortex-A57 and Cortex-A76
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

On Sat, 14 Dec 2024 at 23:01, Marek Vasut <marek.vasut+renesas@mailbox.org>
wrote:

> Add MIDR entries for Cortex-A57 and Cortex-A76 cores.
> Those are used on R-Car Gen3 and Gen4 SoCs respectively.
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
>  arch/arm/include/asm/armv8/cpu.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/include/asm/armv8/cpu.h
> b/arch/arm/include/asm/armv8/cpu.h
> index aa1470bb72d..4dbb589aab8 100644
> --- a/arch/arm/include/asm/armv8/cpu.h
> +++ b/arch/arm/include/asm/armv8/cpu.h
> @@ -5,7 +5,9 @@
>
>  #define MIDR_PARTNUM_CORTEX_A35                0xD04
>  #define MIDR_PARTNUM_CORTEX_A53                0xD03
> +#define MIDR_PARTNUM_CORTEX_A57                0xD07
>  #define MIDR_PARTNUM_CORTEX_A72                0xD08
> +#define MIDR_PARTNUM_CORTEX_A76                0xD0B
>  #define MIDR_PARTNUM_SHIFT             0x4
>  #define MIDR_PARTNUM_MASK              (0xFFF << MIDR_PARTNUM_SHIFT)
>
> @@ -29,4 +31,6 @@ static inline unsigned int read_midr(void)
>
>  is_cortex_a(35)
>  is_cortex_a(53)
> +is_cortex_a(57)
>  is_cortex_a(72)
> +is_cortex_a(76)
> --
> 2.45.2
>
>
