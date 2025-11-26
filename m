Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2571D10384
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 07:31:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBACD840C1;
	Wed, 26 Nov 2025 08:31:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Medleuo3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 065AD840C3; Wed, 26 Nov 2025 08:31:51 +0100 (CET)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2627840BE
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 08:31:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7bb710d1d1dso9709400b3a.1
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 23:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764142307; x=1764747107; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ftp7Lr5YPM8uFqxqmDY+/TegjheUkxqcQoiTQKetPmg=;
 b=Medleuo3QI3lSyyvsDnKjh2pV96VlRuWN7Q4C3wN+AqcwXXzwZPZoH1R2H9ED0IoPc
 umra1voHlOsTBtTb19Dii2EsyzgimxbqubR5p3faT9s/k/2mDJiFXsv4z+rZyTH/Agx/
 cAj+iSebPCsgEXIGRGMXAPo8UfZ2kXAHGokMY1fXgrdzU9mEheJAacbPk9qNO3CoaOBS
 SA3K1LlrzHW9UVat0934YtLhG7wGp7y6xRYJdPab/yGSqN9DBVminkGDIqyIYR7Aqiiu
 3iITRouJwvnxzLB1LVy9Eij0KhehtNIGc9+z9SNRRIbGh7JO2J+f5cfc3ghtaYiRP85Y
 c4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764142307; x=1764747107;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ftp7Lr5YPM8uFqxqmDY+/TegjheUkxqcQoiTQKetPmg=;
 b=ciCW5hztct329W6FJ36JkcvyMoglNKCeSZKWHh/pZ2vFj0xVdkLxsyvZ6J8O81MSvA
 iTbtGnowdJ/6WAg4qPayi2+4X9SX3nKZ3p1EXX7JOCksdqjuPe4IbByVkkZEXAJ3fyKW
 lBxTBSOH9f+jauyQLVct0aUPxHzo7hNOlfZsyVllqi5IYK2b8iYkSpKeFgyM9QXeJmtO
 z19vryortjun0RXkCUZmxDncGu+xHsTKhjrGjJOkvRh6M+mM0rb54/3osF2cuSLfSrRo
 NdgNq9wsHBAedo50P/SeB/N+VazB3GdgjnESOedEkfBL3tGYhZQ6AGxnzEsBGeseMDB/
 YKHw==
X-Gm-Message-State: AOJu0YyFfEdYFam6y1cS9VCT+nsKfYeUx3pDsC0M3Z9fmTK7uAGGSV+R
 tjC5E4SQPhqrDC/hshdmwBWhsz7EHz5MpcgjWaDVASB4yZ2JXnt3FDU6bN/3guJsCGI6uYE2sfo
 mRwoK+nDDtwlcKffyB3JlECud7R7KFg==
X-Gm-Gg: ASbGncvDXE9Pr1XhnY7iMczF7ecTdl+45u9fQdf7+ItvgMbOji/VtO7UYwH4JGnaw9y
 5f0/SNa/sqrHPV1uxEUl9TOTAX1bfkWkO+ZH2eSn945yYMjqIZwzlkL5sR6yu3coLZQAiaYyyax
 TSJqRlBg1VgC8/EOs77fgFPA+QNGu6VSKfu2KuGucA3GdvFCtOSf+lM6wawsUnUhAYfw38luR/u
 hyz9llu9RLODPzRVEEJ86TT9JcsH/3p4tWfJ1v/YUoHqrzEL09jqnuSZVoMzm+hd6c5mjtnJ2iI
 vulr2AA1kbJuZUkvBQ8i3a3h8mRbpdjoFDQbxQ==
X-Google-Smtp-Source: AGHT+IGPU9U0E3nGErrvF4/NJ0YRwTOa+7CnX9gC+aMTqQswjh7Q9fRfnk2qPYjiPtExYAYfBTT5DAZOOL0N6vPNqEY=
X-Received: by 2002:a05:7022:1e0b:b0:119:e56b:c73d with SMTP id
 a92af1059eb24-11cb3ec2526mr3158862c88.2.1764142307162; Tue, 25 Nov 2025
 23:31:47 -0800 (PST)
MIME-Version: 1.0
References: <20251118142641.526356-1-trini@konsulko.com>
In-Reply-To: <20251118142641.526356-1-trini@konsulko.com>
From: Greg Malysa <malysagreg@gmail.com>
Date: Wed, 26 Nov 2025 02:31:00 -0500
X-Gm-Features: AWmQ_bn409_Rv_i3FM0s5vxQjNhE4PPmFskrqFfc9UgIbf_VEN98Mu9GoXNKWRQ
Message-ID: <CABdDSeVNwOVk-9hUoP2xFPte4c9YKtno-Qy7cspoeOUhoEJ2tA@mail.gmail.com>
Subject: Re: [PATCH] adi: Stop disabling device tree relocation
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, adsp-linux@analog.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Nov 18, 2025 at 9:26=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> Remove setting of fdt_high to ~0, which disables device tree relocation,
> from the default environment. Doing so prevents U-Boot from correcting
> problems such as having an unaligned device tree and leads to various
> failure modes in the OS.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> If there is some window of memory that must be used for where the device
> tree is relocated to, bootm_low + bootm_size (or often just bootm_size)
> or bootm_mapsize are the correct way do this. Please see
> doc/usage/environment.rst for more details.
>
> Cc: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> Cc: Greg Malysa <malysagreg@gmail.com>
> Cc: Ian Roberts <ian.roberts@timesys.com>
> Cc: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
> Cc: Utsav Agarwal <utsav.agarwal@analog.com>
> Cc: Arturs Artamonovs <arturs.artamonovs@analog.com>
> Cc: adsp-linux@analog.com
> ---
>  include/env/adi/adi_boot.env | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/include/env/adi/adi_boot.env b/include/env/adi/adi_boot.env
> index d56b14f51726..e266c89b110f 100644
> --- a/include/env/adi/adi_boot.env
> +++ b/include/env/adi/adi_boot.env
> @@ -20,10 +20,8 @@ ethaddr=3D02:80:ad:20:31:e8
>  eth1addr=3D02:80:ad:20:31:e9
>  uart_console=3DCONFIG_UART_CONSOLE
>  #ifdef CONFIG_SC59X_64
> -fdt_high=3D0xffffffffffffffff
>  initrd_high=3D0xffffffffffffffff
>  #else
> -fdt_high=3D0xffffffff
>  initrd_high=3D0xffffffff
>  #endif
>
> --
> 2.43.0
>

Hi Tom,

Thanks for this fix. Works for me on the sc573 and sc598 boards, and
there's no reason it should not work on any other boards. We primarily
boot FIT images which include an explicit fdt load address anyway.

Tested-by: Greg Malysa <malysagreg@gmail.com>
