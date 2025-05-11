Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20FA9C3ABC3
	for <u-boot@archiver.kernel.org>; Sun, 11 May 2025 14:18:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9516480C83;
	Sun, 11 May 2025 16:18:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nv11CN4c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DFFC8091A; Sun, 11 May 2025 16:18:17 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC5A3828BC
 for <u-boot@lists.denx.de>; Sun, 11 May 2025 16:18:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5fd1f7f8b25so1165579a12.0
 for <u-boot@lists.denx.de>; Sun, 11 May 2025 07:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746973095; x=1747577895; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JE+exIMcCmjeHoR1M9+HfTAlvvja1ny1/TW2Mrm9uK4=;
 b=nv11CN4cvSGeEg09xmKNiWYcF4I4/GIc6ha2d3ozse05yf58cDuSgR/zwLQhv0hzUK
 xpADMrCLgeZTXAMAxRKEDA6szfrrYjkEzV3h9ryVWdrESYDbb+TJmfLeO3YcSocgi4Q5
 ucCgKjdr60tWSBwDJsiF09rn/L7iWRrWzsmeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746973095; x=1747577895;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JE+exIMcCmjeHoR1M9+HfTAlvvja1ny1/TW2Mrm9uK4=;
 b=hRlEbl5FLblE6Tbz8/cAgFku0Ccr46tDPv6ccIPxzXs/H4uv3KsYCet2ZmXG0K6+nD
 w0pe6sLB1+hokHI1heMEFWVUy2k+FF6JzqgEgmzyAlM18+4piHnBVj1zF5YrYZIp8GKB
 mtRnTfB0VfBO9/Lx1bg7E/DcQygFva8NMGlaoUoik4rnEJfzxpWLJcESXkFpbxuzp612
 zK+4TGV5MDh64bf75bP8Og/cfRdAgSUlWgYiedIQj6ZW+nyDWLX6JUCQPJ2+sfYvoQU5
 yklrhyjIyC/BKl87kqMW5RStz3YSm8/xcpTmWMIkkZPv5q0E9TlaCmX9bBpj3bZ4tWGZ
 wlFQ==
X-Gm-Message-State: AOJu0Yw0SruV1Dsg4lokITg2h/ftB4A2hv5+2LCAtfxfQfQRIL0RppBi
 XI/YWxdMx01rU/5jgncuDWhUPnHPGJT3R2h1gV04pv13iPRzGOxxK6gUWPpS0Sd448fBbI54N3T
 npHB/1sWvGlaVBPiwTYjHGx8Oqj7HNwhzjtqo8QSGNaK65XolezkbbyK6/g==
X-Gm-Gg: ASbGncsZpYtHa+Plgus8qi9fSkjC8JaWEt2Uupkh4TYsDEcsPFYW8EIkgTzAhItyab4
 7XhRLd+q08zfnQjTkZyiiwv/6iHHKM/pCnnw+Hpf2K3OzSL5pFnYuuY70z7Qff+0S5XKeLnhfbK
 CLSP3kbuCF0exy3tIlQEtbqrQlBAkEeaEdTg==
X-Google-Smtp-Source: AGHT+IHNiZCxpIpnlPfpw2YNL2Uve+eU6V18YSFDz7dIE7YgxPq/lRgDhYsWFCsGnJ2NZdKyGcmwoQ0FpJ17zO5VBOg=
X-Received: by 2002:a17:907:9484:b0:ad2:5657:3161 with SMTP id
 a640c23a62f3a-ad256573523mr33887166b.59.1746973095074; Sun, 11 May 2025
 07:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250508183034.3439777-1-adriano.cordova@canonical.com>
 <20250508183034.3439777-3-adriano.cordova@canonical.com>
In-Reply-To: <20250508183034.3439777-3-adriano.cordova@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 11 May 2025 16:18:03 +0200
X-Gm-Features: AX0GCFvSk_luM3kV5FIopI7DjQtA3tTZRivRIVdNJA2JHDlkd_ICrd7Z9fERd5g
Message-ID: <CAFLszTgGRAbVq13TtAHHJ4U-E1QZLZmLkGbEpyuRCS-TEFrNPQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] efi_loader: fix dtbdump output color and format
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, 
 trini@konsulko.com, o451686892@gmail.com, 
 Adriano Cordova <adriano.cordova@canonical.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

Hi Adriano,

On Thu, 8 May 2025 at 20:29, Adriano Cordova <adrianox@gmail.com> wrote:
>
> Imitate in dtbdump what initrddump does for color,
> newlines and input handling. The output parsing in
> the CI is strict and with the current output the CI
> is not recongnizing the prompt '=>'.

It would be useful to mention 'ANSI' in the subject, since I'm
assuming it is ANSI colour codes which are being written to the output
here?

>
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>
> (no changes since v1)
>
>  lib/efi_loader/dtbdump.c | 86 ++++++++++++++++++++++++++++++++++------
>  1 file changed, 74 insertions(+), 12 deletions(-)
>
> diff --git a/lib/efi_loader/dtbdump.c b/lib/efi_loader/dtbdump.c
> index a3d59a2fd3b..1e72404ecc1 100644
> --- a/lib/efi_loader/dtbdump.c
> +++ b/lib/efi_loader/dtbdump.c
> @@ -29,6 +29,18 @@ static struct efi_system_table *systable;
>  static const efi_guid_t efi_dt_fixup_protocol_guid = EFI_DT_FIXUP_PROTOCOL_GUID;
>  static const efi_guid_t efi_file_info_guid = EFI_FILE_INFO_GUID;
>  static const efi_guid_t efi_system_partition_guid = PARTITION_SYSTEM_GUID;
> +static bool nocolor;
> +
> +/**
> + * color() - set foreground color
> + *
> + * @color:     foreground color
> + */
> +static void color(u8 color)
> +{
> +       if (!nocolor)
> +               cout->set_attribute(cout, color | EFI_BACKGROUND_BLACK);
> +}

Rather than duplicating this code, could it go in a shared file? Could
be a follow-up patch.

>
>  /**
>   * print() - print string
> @@ -87,6 +99,17 @@ static void printx(unsigned char val)
>         print_hex_digit(val & 0xf);
>  }
>
> +/**
> + * cls() - clear screen
> + */
> +static void cls(void)
> +{
> +       if (nocolor)
> +               print(u"\r\n");
> +       else
> +               cout->clear_screen(cout);
> +}
> +
>  /**
>   * error() - print error string
>   *
> @@ -94,9 +117,17 @@ static void printx(unsigned char val)
>   */
>  static void error(u16 *string)
>  {
> -       cout->set_attribute(cout, EFI_LIGHTRED | EFI_BACKGROUND_BLACK);
> +       color(EFI_LIGHTRED);
>         print(string);
> -       cout->set_attribute(cout, EFI_LIGHTBLUE | EFI_BACKGROUND_BLACK);
> +       color(EFI_LIGHTBLUE);
> +}
> +
> +/**
> + * efi_drain_input() - drain console input
> + */
> +static void efi_drain_input(void)
> +{
> +       cin->reset(cin, true);
>  }
>
>  /**
> @@ -116,8 +147,6 @@ static efi_status_t efi_input_yn(void)
>         efi_uintn_t index;
>         efi_status_t ret;
>
> -       /* Drain the console input */
> -       ret = cin->reset(cin, true);
>         for (;;) {
>                 ret = bs->wait_for_event(1, &cin->wait_for_key, &index);
>                 if (ret != EFI_SUCCESS)
> @@ -158,8 +187,6 @@ static efi_status_t efi_input(u16 *buffer, efi_uintn_t buffer_size)
>         u16 outbuf[2] = u" ";
>         efi_status_t ret;
>
> -       /* Drain the console input */
> -       ret = cin->reset(cin, true);
>         *buffer = 0;
>         for (;;) {
>                 ret = bs->wait_for_event(1, &cin->wait_for_key, &index);
> @@ -262,6 +289,9 @@ static u16 *skip_whitespace(u16 *pos)
>   */

Please update the function comment to indicate its behaviour when NULL is passed

>  static bool starts_with(u16 *string, u16 *keyword)
>  {
> +       if (!string || !keyword)
> +               return false;
> +

[..]

Regards,
Simon
