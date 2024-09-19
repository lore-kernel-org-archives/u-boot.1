Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 322C2CE8D52
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 07:04:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6AE7890CA;
	Thu, 19 Sep 2024 09:04:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OgkUjNZ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48645890D1; Thu, 19 Sep 2024 09:04:41 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07142890C9
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 09:04:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7cf5e179b68so460488a12.1
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 00:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726729477; x=1727334277; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JQdmFsDAwiaPzx1H13ChteC1sYraLY1TFWS1G6YXyVY=;
 b=OgkUjNZ3Byrnl2pdhcTHtmkVgFKbQeIFTObYbkBJYxbK7wSOD75dkQrYqCWHLk521i
 SyisSZPK55hODlaHiMycSlGvCwj0Rfwj/bSVaYUeT1gBi6IxT46jTnnD/4NASiUEMLMG
 PvnjHYTdyrddeThDPvIbetjStPsr6lm3PYfglwdElAOqpwN/0h/EpXlFjY4Jl8VimUbs
 KTfAzSLWKhEcKXwomGgDbWwmqAuA2NYRc1SAt10ydsX4gy2pXXqnpjIZLOscPDLhm6hn
 dT7Gs18KLRzVaGXZquQ9dbb1ZloNbmRKr/r/AOjf9s3viYEcSMoaS8YrN2GZRLAzzGSD
 uFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726729477; x=1727334277;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JQdmFsDAwiaPzx1H13ChteC1sYraLY1TFWS1G6YXyVY=;
 b=POMN22LUSZtLeMH8si1pCeRxY3ppzo5eDvUdUIMUiI4WDGFtFVQfsK0ND6CBJqTU2M
 tq7j/prOCmG75AEkzsAzmBgEN0c3GYaQYXMB0gB0qxf3B/MNYQfZoLwqtp7iTeF4rWUJ
 c43y+yk8+g42bPUlxyFn+FQruJls0MTA7h5ojWfJPY7gz+lNfZuRewMRcCJ3IgHj4Hjl
 GwZ7focJoKiJPPNsWc6s+ypiCwVlrzOr4QftF0YG9nOMfzeqDF8I986WpnMGVtENRKOq
 CAhf6gloqgDqMJVjuMbQviKYuJc3Hyru14GFvtIlTYJ5fQeJGhdsjqvIhcVimbUCVeww
 dKQw==
X-Gm-Message-State: AOJu0Ywxm9Pr4Rijmv93UXbsoCIVW2KCurRkmlfJbdGQ94NfKAigXohn
 s3ymh1eu2bHqoQkDRnMyoQilKi2NmdCPdEcIjd/06MeyFOtWkIKRRbgPvLv7TVQBlQfI7BDcO0X
 4+iXRssCN00s2KMhMToufC4O9IZ+Z50XhteDa+Q==
X-Google-Smtp-Source: AGHT+IEoQPE5OiDG8X5RSPc++Eq4T97IdYabP04sOUhRDDILzhL+B6ddngIt3lEFFMU+Zeddjejgo7FYVn5tLh1FWII=
X-Received: by 2002:a05:6a21:6801:b0:1cf:1218:fa8 with SMTP id
 adf61e73a8af0-1d2fcad52a6mr3387438637.22.1726729477346; Thu, 19 Sep 2024
 00:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240918213728.19657-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240918213728.19657-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 19 Sep 2024 10:04:01 +0300
Message-ID: <CAC_iWj+FC708qmb461EGc0G+34hDYRfGmqR0qu8SAnOwwvxXcw@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: fix some function descriptions
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On Thu, 19 Sept 2024 at 00:37, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> * The function name must be provided in the description.
> * The function name must match the name used in the description.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> @Tom
> This is one of the fixes needed before we can update scripts/kernel-doc.
> ---
>  lib/efi_loader/efi_console.c           | 2 +-
>  lib/efi_loader/efi_file.c              | 2 +-
>  lib/efi_loader/efi_rng.c               | 2 +-
>  lib/efi_loader/efi_unicode_collation.c | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.c
> index cea50c748aa..9d9f786a6db 100644
> --- a/lib/efi_loader/efi_console.c
> +++ b/lib/efi_loader/efi_console.c
> @@ -100,7 +100,7 @@ static int term_get_char(s32 *c)
>  }
>
>  /**
> - * Receive and parse a reply from the terminal.
> + * term_read_reply() - receive and parse a reply from the terminal
>   *
>   * @n:         array of return values
>   * @num:       number of return values expected
> diff --git a/lib/efi_loader/efi_file.c b/lib/efi_loader/efi_file.c
> index 222001d6a3b..c92d8ccf004 100644
> --- a/lib/efi_loader/efi_file.c
> +++ b/lib/efi_loader/efi_file.c
> @@ -295,7 +295,7 @@ out:
>  }
>
>  /**
> - * efi_file_open_()
> + * efi_file_open() - open file synchronously
>   *
>   * This function implements the Open service of the File Protocol.
>   * See the UEFI spec for details.
> diff --git a/lib/efi_loader/efi_rng.c b/lib/efi_loader/efi_rng.c
> index 9bad7ed6931..4734f95eee1 100644
> --- a/lib/efi_loader/efi_rng.c
> +++ b/lib/efi_loader/efi_rng.c
> @@ -91,7 +91,7 @@ back:
>  }
>
>  /**
> - * rng_getrng() - get random value
> + * getrng() - get random value
>   *
>   * This function implement the GetRng() service of the EFI random number
>   * generator protocol. See the UEFI spec for details.
> diff --git a/lib/efi_loader/efi_unicode_collation.c b/lib/efi_loader/efi_unicode_collation.c
> index 627bb9123cf..d48700a352b 100644
> --- a/lib/efi_loader/efi_unicode_collation.c
> +++ b/lib/efi_loader/efi_unicode_collation.c
> @@ -266,7 +266,7 @@ static void EFIAPI efi_fat_to_str(struct efi_unicode_collation_protocol *this,
>  }
>
>  /**
> - * efi_fat_to_str() - convert a utf-16 string to legal characters for a FAT
> + * efi_str_to_fat() - convert a utf-16 string to legal characters for a FAT
>   *                    file name in an OEM code page
>   *
>   * @this:      unicode collation protocol instance
> --
> 2.45.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
