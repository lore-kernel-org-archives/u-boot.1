Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5166CCFA1A
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 08:55:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC5DA83C14;
	Wed, 12 Nov 2025 09:55:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gBVZVymJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5827183C40; Wed, 12 Nov 2025 09:55:30 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E828583C08
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 09:55:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-787da30c50fso5214787b3.3
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 00:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762937727; x=1763542527; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p/Q2KTzlplL10uQuMP3btr9ww8m6X830FDaSyfTwVxM=;
 b=gBVZVymJfxQA4Cj+H5hBpzOvaPrkYWnwpvVTg/bC1uU7i4QFuKeGAD5mpnH7Iquron
 ft5etC4k63rRj0ydcRnlkT2TQxQxRB8C8WVNoq3lfFwk2+UwXQupkBOk9sFBC5Vo6EiO
 cuF8AA7Qcoil+LL+/eGrhtJE2zQzYjoQ7GuyTqHGZO48JGVE6KroNZxR5yb29B2CqMOO
 vpP88XLRFFajkeUjO1so82kq7eQ6bvYjFFXybPw5eEvJ07JyXqmmwXIUEkd/oqsvnRzw
 6f3BW+4hKSI8pfEIQzzIaxZP+QemtSgPNHZXTDcJa9GQcH/c5Gud9XEP4YJrBwfvNG6N
 uxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762937727; x=1763542527;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p/Q2KTzlplL10uQuMP3btr9ww8m6X830FDaSyfTwVxM=;
 b=UGH7idABkk0+17gvxJwudJUolBaG74h28qb8vx/o7PLmNFDKYM3ry2zitulCadYDPY
 ZUYxXoZi+lZrOCHwzjpu+lzxgrLoDdd/kAJMB8qTr27k16uXOwb1VysmB/cMPz4HOCM4
 bJX/GZs7d4LgcHQ7u95MHZR17jJutoeI8H1GfJ+ooljngiMyAAwLphYyMl0bbUeo4lh/
 wzsucLZO7FeTTX55uVCHVYMGBRTw0rnM1EnMoPLFlUED8C+e85aENF180f6DyWgfuB6i
 ByxU81wnOJYxgI2Owv/fQknpYP1yhyfrxBb4K9LYKr8tRkn/kuLljah2fh7nHwPa3/ID
 /XzA==
X-Gm-Message-State: AOJu0YzQgem3R5JktBsBu/19J/A20m8ag1qzO+UpztGmCsy8AjpHau5s
 Xj7NFH4jhHdYjnKv7AP7h1MeBVWlxJQD/er31qhtpnAimFDOY+eHSWzintWnYYXy/vsL4NBUEyr
 PrvsQwQGWrGwYldVlCXSmmzghunhSRzHhDBuiQK526w==
X-Gm-Gg: ASbGncv0O2Q4trrufxoqXJwnEJ8063sJOXL9qyZ9CFFxudp3lgN9pYRnvbq/Hp/7qvT
 /eFjI7Od8XQUFpQrHZDV+kojk5juhdhiIPKC46tDGA5K8RdqfVzISr24kux0KOmxCrAr9GEj5yR
 4WUtKt0QQgpj7SDpnk4GorytYdBeywNKXtbeeRz6JBNGqbpElO8LyIB8zY4IXJ8g6tf98zR2O0b
 y8fdnuyKCSz9gMfH/laGYRtK4L6/h4+bhUzhiRg9GWAl86xvI26pH4BzpH1pSbCaI4VjhTlUli5
 BjgP+ksNunUZJ9ipTDo4ioYsDuQ7A6CltwvNvfSFWKMUudr/xBE=
X-Google-Smtp-Source: AGHT+IEJdGo87ScW5pjGEPk414EUQaNu2qZFpAz25f1ro5NMhavGYeXUUk0m5EITr/64KSdOQcgfG4PUnOx8PATFXhQ=
X-Received: by 2002:a05:690c:a7c8:b0:781:64f:2b18 with SMTP id
 00721157ae682-788136acb1amr24938607b3.58.1762937726758; Wed, 12 Nov 2025
 00:55:26 -0800 (PST)
MIME-Version: 1.0
References: <20251104-smbios-v1-1-99b79a8f59b3@arista.com>
In-Reply-To: <20251104-smbios-v1-1-99b79a8f59b3@arista.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 12 Nov 2025 10:54:51 +0200
X-Gm-Features: AWmQ_blK_6JPxNHfzkLZ372WErff5i5pjn5DnRSsYy2DwweR9QqANbebIYHRovc
Message-ID: <CAC_iWj+bCFQ8xyavApfzS4MTsyh4TKt1KP-fCO6GXw97+g0RJQ@mail.gmail.com>
Subject: Re: [PATCH] boot/bootfdt: Add smbios3-entrypoint to FDT for non-EFI
 boots
To: adriana <adriana@arista.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Dmitry Rokosov <ddrokosov@salutedevices.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Richard Weinberger <richard@nod.at>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>
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

Hi Adriana,

I agree with Tom that we should pull a version of this once the spec
changes are merged

>
> +/**
> + * board_fdt_chosen_smbios - boards may override this function to provide
> + *                           specific SMBIOS address
> + */
> +__weak phys_addr_t board_fdt_chosen_smbios(void)
> +{
> +       phys_addr_t ret = 0;
> +       const struct smbios3_entry *entry;
> +
> +       /* Only provide SMBIOS address if EFI is not enabled */
> +       if (IS_ENABLED(CONFIG_EFI_LOADER))
> +               return 0;
> +
> +       /* Only proceed if SMBIOS support is compiled in */
> +#if defined(CONFIG_SMBIOS) || defined(CONFIG_GENERATE_SMBIOS_TABLE)

IS_ENABLED() is the preferred macro instead of ifdefs. Also
CONFIG_GENERATE_SMBIOS_TABLE depends on CONFIG_SMBIOS.

> +       ret = gd->arch.smbios_start;
> +       if (!ret)
> +               return 0;
> +
> +       /* Verify this is SMBIOS 3 */
> +       entry = (struct smbios3_entry *)(uintptr_t)ret;
> +
> +       /* Check for "_SM3_" signature */
> +       if (memcmp(entry->anchor, "_SM3_", 5) != 0) {
> +               printf("SMBIOS: Not version 3, skipping DTB injection\n");
> +               return 0;
> +       }
> +
> +       /* Verify entry point length and version */
> +       if (entry->length < sizeof(struct smbios3_entry)) {
> +               printf("SMBIOS: Invalid entry length %d\n", entry->length);
> +               return 0;
> +       }
> +
> +       printf("SMBIOS: Found version %d.%d at 0x%llx\n",
> +              entry->major_ver, entry->minor_ver, (u64)ret);
> +#endif /* CONFIG_SMBIOS || CONFIG_GENERATE_SMBIOS_TABLE */
> +
> +       return ret;
> +}
> +
>  int fdt_chosen(void *fdt)
>  {
>         struct abuf buf = {};
>         int   nodeoffset;
>         int   err;
>         const char *str;                /* used to set string properties */
> +       phys_addr_t smbiosaddr; /* SMBIOS table address */
>
>         err = fdt_check_header(fdt);
>         if (err < 0) {
> @@ -387,6 +429,19 @@ int fdt_chosen(void *fdt)
>                 return err;
>         }
>
> +       /* Inject SMBIOS address when we have a valid address.
> +        * This is useful for systems using booti/bootm instead of bootefi.
> +        */
> +       smbiosaddr = board_fdt_chosen_smbios();
> +       if (smbiosaddr) {
> +               err = fdt_setprop_u64(fdt, nodeoffset, "linux,smbios3-entrypoint",
> +                                     smbiosaddr);
> +               if (err < 0) {
> +                       printf("WARNING: could not set linux,smbios3-entrypoint %s.\n",
> +                              fdt_strerror(err));

The errors are treated as fatal and return without running
fdt_fixup_stdout(). Arguably some of the errors should be fatal -- e.g
failing to set bootargs, while others shouldn't and only produce a
warning, like setting the rng-seed.
IMHO SMBIOS is fine and we should only print a warning, just making
sure that everyone is ok with that.

> +               }
> +       }
> +
>         return fdt_fixup_stdout(fdt, nodeoffset);
>  }
>
[...]

Thanks
/Ilias
