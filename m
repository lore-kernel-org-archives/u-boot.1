Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4357C48260
	for <u-boot@archiver.kernel.org>; Fri, 16 Feb 2024 10:35:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A4718780A;
	Fri, 16 Feb 2024 11:35:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bz5qhZ5Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F189D87BA8; Fri, 16 Feb 2024 11:35:47 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E249586564
 for <u-boot@lists.denx.de>; Fri, 16 Feb 2024 11:35:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-51187830d6dso591362e87.3
 for <u-boot@lists.denx.de>; Fri, 16 Feb 2024 02:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708079739; x=1708684539; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DOFdDHKODy+IBKkRskBbEFcSDGGO4es9EZIYOeyvGz4=;
 b=bz5qhZ5Qn7+qCzIK2YVtNSlIZ15PBWz048I7k0hBS2qRgAhHQof9mXzeadP+5KOwma
 BqXNPSqW8v0fB3qppPS4TM+42dJytDs9xw7YCn2sSubGSRhYTmkfjlbr+DMKjDhxGoDO
 gsRkjNd5UkbHrR61qT033ChRvkQNkRJfGjbF2rIEreKoRqad1TwYp1lZeXraaP6RfWHq
 boGiUicam1K/8LGW3GqQZQgnE1csV22O8lfMqU7vU/l91lzmmeR5zSu+qfKrkDMKW3KJ
 1dTyXsn81k1CNJ/SMwCfJZK9JnpffI2ZL4K5yAEPfIHaQT2TN9znq+aJoNqAyPZ55bLK
 klIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708079739; x=1708684539;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DOFdDHKODy+IBKkRskBbEFcSDGGO4es9EZIYOeyvGz4=;
 b=qXv4rH7Y7CyVJBxIcmxAuH6mmHM2xjc43jEvIcpTIzxtz3lcZXOBJI6fmqa6Hxhlj8
 oY35ZtzNMc3CFJD0UDjAR9+Q0NmTMLzlBUNlY+9AYVKYPX57FgkORETUVufl/v53ZJRZ
 Gygfctwx1VRXXfmbTwgZtcUH4zSKIOdAjHgu1Q4933Oooq8DGyWbA6hpfPaYSAOyUE3b
 Nr2ctqizKCesj5ngINdBcN70ftTpITFEb9asspeNlUrZWH9tOLn7u0Ds8SP5r2qB7b7/
 GwkWtySuM298bhPFdYtns7PW0wdHDn+F3txktCdYI/wo6lxHFqzMpTzsz+XvY5Di7KDo
 7eYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc99TGIB08vjb/+mBMpN7l4fmEp1hjmS1oqLNTagS49Ulgcf2rN6dKSiVmukmp3QVyUtIlnwOYBuQ/XDXVxuSRGj9DqA==
X-Gm-Message-State: AOJu0YzxxVVs6BDXdoSM2hkYjG+S4M0UHoTxlATdnWX4wu0/u+G7zCsE
 pxdjAwZZBM54chhR1gIpjpVanp5XHHrXasjnhPGtSQdf5pSnBFPshAFiqwHCo2oFvW5Bi4W3V92
 YYVYF6YW6AhDBMfv/dlzVghKZAm/XPIqeuUQASg==
X-Google-Smtp-Source: AGHT+IEaelKInM64PA8/GtVMiTOl9ZuI6TAZjRMY4bjvTc7tDAXXs+0JjnN75hwVjmk2t4RrugFdvksHyPn99pQrbi4=
X-Received: by 2002:ac2:53b5:0:b0:511:a02b:8223 with SMTP id
 j21-20020ac253b5000000b00511a02b8223mr3006243lfh.58.1708079739628; Fri, 16
 Feb 2024 02:35:39 -0800 (PST)
MIME-Version: 1.0
References: <20240214190625.13764-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240214190625.13764-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 16 Feb 2024 12:35:03 +0200
Message-ID: <CAC_iWj+SVZw14QeNLFp8KC8=cP8fYaZUnThQG_cEivxN56BwAw@mail.gmail.com>
Subject: Re: [PATCH 1/1] arm: separate .data and .text sections of EFI binaries
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

Hi Heinrich,

[...]

>         }
> +       .rela.dyn : { *(.rela.dyn) }
> +       .rela.plt : { *(.rela.plt) }
> +       .rela.got : { *(.rela.got) }
> +       .rela.data : { *(.rela.data) *(.rela.data*) }

Why are we switching from Rel to Rela?

>         _etext = .;
>         _text_size = . - _text;
> -       .dynamic  : { *(.dynamic) }
> +       . = ALIGN(4096);
>         .data : {
>                 _data = .;
>                 *(.sdata)
> @@ -47,20 +59,19 @@ SECTIONS
>                 . = ALIGN(512);
>                 _bss_end = .;
>                 _edata = .;
> -       }
> -       .rel.dyn : { *(.rel.dyn) }
> -       .rel.plt : { *(.rel.plt) }
> -       .rel.got : { *(.rel.got) }
> -       .rel.data : { *(.rel.data) *(.rel.data*) }
> -       _data_size = . - _etext;
> +       } :data
> +       _data_size = _edata - _data;
>
> +       . = ALIGN(4096);
> +       .dynsym   : { *(.dynsym) }
> +       . = ALIGN(4096);
> +       .dynstr   : { *(.dynstr) }
> +       . = ALIGN(4096);
> +       .note.gnu.build-id : { *(.note.gnu.build-id) }
>         /DISCARD/ : {
>                 *(.rel.reloc)
>                 *(.eh_frame)
>                 *(.note.GNU-stack)
> -               *(.dynsym)
> -               *(.dynstr)
> -               *(.note.gnu.build-id)
> -               *(.comment)
>         }
> +       .comment 0 : { *(.comment) }
>  }
> --
> 2.43.0
>

Cheers
/Ilias
