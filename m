Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E1DC41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 19:10:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C220886813;
	Fri, 22 Dec 2023 20:10:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lmzzEgWk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 101DA86D4C; Fri, 22 Dec 2023 20:10:04 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF39586784
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 20:10:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-50e49a0b5caso2630273e87.0
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 11:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703272201; x=1703877001; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FDJ111tknS1VjCdvi/Nku63RRAbCcCIZ/W121BKHKfs=;
 b=lmzzEgWkdzTuN+6MuATDtaTSWWbXdB7ePJeIu4GibDSNkBRo0mnMc8knsqKOF27iSM
 QUEovXr0+l0ip1UhO+YfHIGl1WShGXF5AOdKKjLC78DBPiSpYjumBtc7afIVXYMTUSQY
 MdYqCh7O8tVBgfIXsaHKTW6dDLaQYSlOkz1EnoF0ZmuJnoLyGbTSvmy4+ZELlf3fV0hU
 SkB/F2UU4CYHtU+IT0lFhCtuhFOnvFSsckcnqXaPPdVp5SRu2Y5OPPFdWkTWa4nE5TTt
 woQBj6IQuZVxx/v65EJeO9Iw07YBIGLPQM3qOb/fuAgy29wXuSwxKSZlnkm6yhC08IvK
 A/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703272201; x=1703877001;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FDJ111tknS1VjCdvi/Nku63RRAbCcCIZ/W121BKHKfs=;
 b=GsSfnrVyqU74GY3CMoqAcG1hlHkKCshhz860wfBghOMiycLdYypgoNEF/3IgpfaXpi
 8LJQQKtpZhBB1pac19N+fF+ro79SXR8d8f8IOc3v5XIwpXHghAmByIZ5+xz88ghdzMVM
 LWWLRgc7OhNSX0j7vzJBYMGN0ls4f5KlvfdMhSh7Xme28pszcECZpUzTdvfIsDhvTTC3
 CME7v4SK4cSz0IfOxIUDjVGgu/WMW/WyupaJlUkCcDHJaMf6hnzSf6xFwey0dZGjRFTp
 7GsHi7qbwlRSMpNFI9QUO6cxpmBmFCGbhTQKWZ63jJ6HZV9fdj1nDWs6OXgd49wdYSJh
 eQ6w==
X-Gm-Message-State: AOJu0YwpNi8HoUt+ophlrV1LB6JDje0NRzBN9L5aZXbpu0VCauCzPJfs
 gsDSfuOPjys5pS55vnNVePB/vfQnvXPVbR4BPBq0lpdxYHykOQ==
X-Google-Smtp-Source: AGHT+IFVSF+UC6xvHHXydY7MIw9Q6gSMaVAXrq0dM9SC9bg+zVNxxzIy3uyWkDI0R634oopf7CFCxeu+BCt3QGs+Ibw=
X-Received: by 2002:a05:6512:558:b0:50e:6482:be34 with SMTP id
 h24-20020a056512055800b0050e6482be34mr863716lfl.124.1703272201087; Fri, 22
 Dec 2023 11:10:01 -0800 (PST)
MIME-Version: 1.0
References: <20231222175403.46629-1-xypron.glpk@gmx.de>
In-Reply-To: <20231222175403.46629-1-xypron.glpk@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 22 Dec 2023 21:09:25 +0200
Message-ID: <CAC_iWjK14ZoGbLZD2LmZMsZrKBuowUbGXDd22gYyguOoO5cXtA@mail.gmail.com>
Subject: Re: [PATCH 1/1] lib: smbios: remove redundant next_header()
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>, u-boot@lists.denx.de
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

On Fri, 22 Dec 2023 at 19:54, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> next_header() and get_next_header() only differ in how the const attribute
> is used. One function taking a const parameter and returning a non-const is
> good enough.
>
> Fixes: 3d49ee8510d3 ("efi_loader: add SMBIOS table measurement")\

This doesn't fix a bug. It correctly cleans up code, so I think the
Fixes tag must be omitted.

> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  lib/smbios-parser.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/lib/smbios-parser.c b/lib/smbios-parser.c
> index b578c30840..f4de350e6e 100644
> --- a/lib/smbios-parser.c
> +++ b/lib/smbios-parser.c
> @@ -50,14 +50,7 @@ static u8 *find_next_header(u8 *pos)
>         return pos;
>  }
>
> -static struct smbios_header *get_next_header(struct smbios_header *curr)
> -{
> -       u8 *pos = ((u8 *)curr) + curr->length;
> -
> -       return (struct smbios_header *)find_next_header(pos);
> -}
> -
> -static const struct smbios_header *next_header(const struct smbios_header *curr)
> +static struct smbios_header *get_next_header(const struct smbios_header *curr)
>  {
>         u8 *pos = ((u8 *)curr) + curr->length;
>
> @@ -73,7 +66,7 @@ const struct smbios_header *smbios_header(const struct smbios_entry *entry, int
>                 if (header->type == type)
>                         return header;
>
> -               header = next_header(header);
> +               header = get_next_header(header);
>         }
>
>         return NULL;
> --
> 2.43.0
>

Other than that
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
