Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B9D7EB64AC
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 13:23:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBDF8878AA;
	Thu, 11 Apr 2024 15:23:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QH6kQ+qM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACA50878AA; Thu, 11 Apr 2024 15:23:14 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6A5D8332E
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 15:23:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-516f2e0edb7so5726555e87.1
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 06:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712841792; x=1713446592; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s+XlmVfqeJnpWTFQJGMpCkh6cZi7bX6+mgimOy5LURA=;
 b=QH6kQ+qMTodMS9yyUxOTBmq7f9SafiSc0f8ckvJXX6ERBwiuKQCDdtvM2hz4i+Fxs2
 nPwUPo8pkxF5RawPJZv4bjTnUQ4i1KxYdBzpgu1LIVnjC1xISIHn2fnyPNSlm2PHLfBG
 LmVZjazZT+EnzHEZmuXZERFaCpHN8BpGiOuxHJTAoWOD6syFReUXKCJ/o52ljwA14x5f
 TkvwC/opkBgcRTr9pzIW1yLDrPAK5aLwISFYtz2m3kHRVPW1CeCrzhZ+mrIhx9s0BneE
 MDvN453bvEEcLHHM8HP3SWq476IPZs7qGSpxx3C1IbBsHnNcUoRKQYF9eGlvIF/FwZ/n
 18Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712841792; x=1713446592;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s+XlmVfqeJnpWTFQJGMpCkh6cZi7bX6+mgimOy5LURA=;
 b=qJVhs7zdRKDxXrJCCnC9Us8q8J6bX7nRD3oeWNaEPMXF4l08enocW6pvuRqcx0I8b2
 t+RED+jwzMbH+h72TT+k6tWpQM/iWxG/sFZNtfUf+KioR25C9ybbGlw8gs3QZYSFmZ7r
 HTsr/U7LnZWtOrZmmUUWtJRsBy9j9x6CWHDI/rSFQB4OH2u4azNK7+vfqUd10y8gqfZa
 uQDLQ7gRZPTYUm0lYyDEiZNNuahGIqqcPmZUhpODhblcr3t+eKcIWEct9Yc+scZHCoHd
 j9puchI7IM6/0q3wZtMU8V4pBzIbGz7U5HB7vmteesDq5zF1n9Xf9aRe2Q/aK1CM47qp
 ahug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCRiTT2X1lMhBnyD2fib7Qder6OLjvd4yd4gov/K8RbQJLyOtXPP3eP3PlmbxgMdjzgAEXpDnhCaAMk/lN5xQoBHi1nw==
X-Gm-Message-State: AOJu0YyP4EBIIe+q9mVMKjTFQuVEgJLpT/yyByWXvG6HDDqlgI8gjLlb
 Eg5wAqBeUJ1EM3AADCAxd/zuhpj9m/rY+1L4vecWCsSrGtaqhC766mn8ybwQwdQpFLF+FsF/9eK
 aXq1S+SRw9laYNeSGwuWLHSyCeHNTHVPQSe4wKw==
X-Google-Smtp-Source: AGHT+IEm9IwyeEQOiERvMdn5iakN203WdQhGnCbSIq8ksCQg/JfyE1FMis1E/IweRsMCPwac2zo01BbSNTW4F/VxfBU=
X-Received: by 2002:a19:f014:0:b0:517:8ad8:c64 with SMTP id
 p20-20020a19f014000000b005178ad80c64mr1477628lfc.21.1712841791871; Thu, 11
 Apr 2024 06:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240410121933.152265-1-o451686892@gmail.com>
 <400d93c5-d49e-48a3-b677-b61182ad6fcd@gmx.de>
In-Reply-To: <400d93c5-d49e-48a3-b677-b61182ad6fcd@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 11 Apr 2024 15:22:36 +0200
Message-ID: <CAC_iWj+hsbRg9XX3S6f23i00DiCFPAYu-ARz2ftDd=yzzV7gUg@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: using EFI_UNSUPPORTED for private
 authenticated variables
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Weizhao Ouyang <o451686892@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Masahisa Kojima <kojima.masahisa@socionext.com>,
 u-boot@lists.denx.de
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

On Wed, 10 Apr 2024 at 14:29, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 10.04.24 14:19, Weizhao Ouyang wrote:
> > Improve error message for UEFI SCT tests.
> >
> > Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> > ---
> >   lib/efi_loader/efi_variable.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
> > index 2951dc78c7..e6c1219a11 100644
> > --- a/lib/efi_loader/efi_variable.c
> > +++ b/lib/efi_loader/efi_variable.c
> > @@ -163,6 +163,7 @@ static efi_status_t efi_variable_authenticate(const u16 *variable,
> >               break;
> >       default:
> >               /* TODO: support private authenticated variables */
> > +             ret = EFI_UNSUPPORTED;
>
> This looks more adequate than EFI_SECURITY_VIOLATION. Thanks.
>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>
> >               goto err;
> >       }
> >
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
