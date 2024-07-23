Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588DDC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 14:13:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D1B188805;
	Tue, 23 Jul 2024 16:13:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UhMNkObo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8121988826; Tue, 23 Jul 2024 16:13:26 +0200 (CEST)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8215C8811C
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 16:13:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-70d18112b60so1829412b3a.1
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 07:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721743995; x=1722348795; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jP9W9ZG1UKODG1VCCsiGOHiry2LnedEScgT00RU38Cc=;
 b=UhMNkObo/SXnFEYkNkGevIux53wjhzLG/D22+frF2l+u5PlYJ6Y0RarwtTIVaYN1+6
 MPjvDiKf7d2LPyPNQTy9/Tmor+0g7tRtF2+2MbWEwHStIaeU7g6yZcs5qsnZWVk48Lhs
 37D2ae3535ato0378aO7MWIBzbMmzYe/IGqfJQFMTDHe4798yxsBooVkXoLaa/yvgH7L
 2awDZ3MtZ4gHjBExRkBjYyHA8p8P5ZELPIr0F+xuJk5d1TywT0n+iY6tPsdZxR/PYEkt
 1Che8KsvzTL2UfHjwihzlz6ZrDPnPXJCHfkYiUmiuqjCRQrXp9p5lE+nzN6Ybvc0ajtu
 XBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721743995; x=1722348795;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jP9W9ZG1UKODG1VCCsiGOHiry2LnedEScgT00RU38Cc=;
 b=Cg3osXv95oaOO5amcpVPtIM2dc54tfVlF4x6hk5BFeC0d4DlSxWNSoC40uvvCqMtnT
 rRDXuJJq/zX3d/5G0FoNoWqaSvEdPSv24wPk6THjXLPssvDvry/FZfnWmrUhR6hDe+D9
 ZkRpCzvl9qx+e+WZYWwutzt83L8FbehBlS/r4jjUczCYaN5lbr50cyvwyL812WiqGEkK
 468XSXcjs1wCufrdD8CnjQP+YLPzmZ+xsqQTNNLadqUuZP0ghCy46DB6VZzRoJfNxgZn
 eN+B3zTzC828s20mRwza1qtE+YNWh8KdIlTavS0QylOB1Qa4cl5OvsPyngcrRGBRBIXQ
 HN8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtHJNiD+/iO23uqf+Vf2SNzoJDdJIukDHMpaQcvU2NMRYL4fYPli7hRSnA7CMEJD7GV8KxPYhcmVYkBMgoJMk4eW2W8Q==
X-Gm-Message-State: AOJu0Yz5PAol47YTyGqmwOGVUlYgQWEUrrwQbA0Rvnmq2y+swnGsz8GM
 SkmZlOGgxqCaEyR5YJjZnmQDSh5ZhDl4gOh3tjdSGLAUqgPWhtersmlPLS9ANlvn5VjOizz3Afn
 vzrPJxzEXgmbVyik0+D7nt78yjwvAMwWEiT/k8A==
X-Google-Smtp-Source: AGHT+IF9uf+T6K3+NHv1KQUyyxDO5usgj+mmcZsYggrg1nfJ/w0kGo8haUxL/LM9MAFYsr5ffokgMMQfvB5P9YbZBxM=
X-Received: by 2002:a05:6a00:814:b0:70d:2ab5:8677 with SMTP id
 d2e1a72fcca58-70e8089965bmr4053067b3a.10.1721743994808; Tue, 23 Jul 2024
 07:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240723104634.116082-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240723104634.116082-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 23 Jul 2024 17:12:37 +0300
Message-ID: <CAC_iWjKUpjQP_4kCPMAaotuQ4uRKb3bG=zVhdaU-Eb=85hbt2w@mail.gmail.com>
Subject: Re: [PATCH 1/1] smbios: add extended Extended BIOS ROM Size
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
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

Hi Heinrich,

On Tue, 23 Jul 2024 at 13:46, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> U-Boot claims to create SMBIOS 3.7 tables. The type 0 table has
> a field Extended BIOS ROM Size since version 3.1.
>
> BIOS ROM sizes of 16 MiB or above must be written to this field.
>
> Add and fill the missing field.
>
> This patch does not cover the case of a ROM >= 8 GiB which cannot
> be configured in U-Boot.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  include/smbios.h | 1 +
>  lib/smbios.c     | 9 ++++++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/include/smbios.h b/include/smbios.h
> index a4fda9df7bd..00119d7a60c 100644
> --- a/include/smbios.h
> +++ b/include/smbios.h
> @@ -105,6 +105,7 @@ struct __packed smbios_type0 {
>         u8 bios_minor_release;
>         u8 ec_major_release;
>         u8 ec_minor_release;
> +       u16 extended_bios_rom_size;
>         char eos[SMBIOS_STRUCT_EOS_BYTES];
>  };
>
> diff --git a/lib/smbios.c b/lib/smbios.c
> index 4126466e34a..e2a2f873a94 100644
> --- a/lib/smbios.c
> +++ b/lib/smbios.c
> @@ -348,7 +348,14 @@ static int smbios_write_type0(ulong *current, int handle,
>  #endif
>         t->bios_release_date = smbios_add_prop(ctx, NULL, U_BOOT_DMI_DATE);
>  #ifdef CONFIG_ROM_SIZE
> -       t->bios_rom_size = (CONFIG_ROM_SIZE / 65536) - 1;
> +       if (CONFIG_ROM_SIZE < 0x1000000) {

nit, but can we use SZ_16M instead? Then the comment below goes away

> +               /* CONFIG_ROM_SIZE < 16 MiB */
> +               t->bios_rom_size = (CONFIG_ROM_SIZE / 65536) - 1;
> +       } else {
> +               /* CONFIG_ROM_SIZE < 8 GiB */
> +               t->bios_rom_size = 0xff;

If the size is above 1gb we should also change bits 15:14. I guess
being above 1GB will never happen, but can we add a comment?

Thanks
/IIlias
> +               t->extended_bios_rom_size = CONFIG_ROM_SIZE >> 20;
> +       }
>  #endif
>         t->bios_characteristics = BIOS_CHARACTERISTICS_PCI_SUPPORTED |
>                                   BIOS_CHARACTERISTICS_SELECTABLE_BOOT |
> --
> 2.45.2
>
