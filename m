Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB554D15DA5
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 14:41:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B546788365;
	Mon, 21 Oct 2024 16:41:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="v3gfaQrr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDD9B885F4; Mon, 21 Oct 2024 16:41:29 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A989E8806A
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 16:41:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-71e5130832aso3150639b3a.0
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 07:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729521686; x=1730126486; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C5Um+Yq4RT11FNo8xfFim0FUi6z17JWHUW1+ACZhzlw=;
 b=v3gfaQrrGIt5FwYYlY/KBNom86ccjCWLo+l1QKoVzdRWotq+oYYPQD5qpKJiyHI3KV
 gFocIZlQh0ctbndSZo0yF8udFudgRODbgL67Y0Qx+0MoI1T6WwpQvTdw00D5FxArxsPx
 TpGgkMTBxhlLG9FKrmF1C2CIRvKzbk4hoH1Pf9L+V/x8xKfjEl3M1AlSrz/A8aGGIKj5
 H8Pji0SnHTlv2V8zJcIxBh7J+kAuA3UvXg5c8NJVz+jgfgCUnT1P//OdcHbrK1acsSAl
 REVWa8aFz3qvxUf6aBkNnRn8vjqPibkVOzeICpigBMMrBJoYnx1DF3DCvaHIGvf74bUm
 jjrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729521686; x=1730126486;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C5Um+Yq4RT11FNo8xfFim0FUi6z17JWHUW1+ACZhzlw=;
 b=ue3fnDuL+7bqBR4Io+/4PftYWqA2YzKhRWF+iWkuP0k2j7/jI7sp1Rj0LViJ0v64w6
 9/ZjeEP16HvngcAK7pulgyBLTqipZATMW6ETPkg0JY7VLRaRRxQfOf7xTO2LXfiY6T2N
 Y0AGLOQX/2BJ/hTrGV38TF3FLPXhqn5cBFoadsPaH/jljFZ+Y3NPaXpC1PnFgizIQBtK
 15l0poJ0owgARh+xUgglQYCsjqy899k6b/hfSQHIMT89FaK6gnrGHVX9//oj3vKELrVZ
 DzSEznpQTVYQdg+sAx3Nyi1aA5RME4rvAHGTMyQRL5tPHwv61ux8H4zhCJ88JmwcNzyY
 XMnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWr4925nW4CSTmrN68XfY1vm/d3Vgi6Lan+icpQCkVutCvTLJJZAE4pP+mqg2e6zieqMEJjBKQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxOrD7zIaGAUgkZh+r90vFqiC9XhwoEy3hWJtGou9eaCeVEXRV0
 4XrfRBKUn6uA+r/lGKeJ6xlqCoNH62sd7UWvN3LE6ZqgNUtrtZdQI3GG8d76hRzyk9W3dLB4yKp
 oTloAvz1WzshacZoeQKApnjtp2huHkEbyoycVRA==
X-Google-Smtp-Source: AGHT+IFFANPKmmHvPVO7QdmvoXMe1kFShgpuARbMkgW5tdrrjPM9oGfB/BAL0PP6+SgqoOJ6ZWIKBb4WkxN0PK2H+P0=
X-Received: by 2002:aa7:88d1:0:b0:71e:410:4764 with SMTP id
 d2e1a72fcca58-71ea314edf9mr17188212b3a.8.1729521686148; Mon, 21 Oct 2024
 07:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20241021140546.2969356-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20241021140546.2969356-1-andriy.shevchenko@linux.intel.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 21 Oct 2024 17:40:49 +0300
Message-ID: <CAC_iWjL1nUaKGb2kDK=7BKn1xgS3CitQ3FHP94VcwObjcMuuAQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] efi_loader: Mark a function static
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
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

Thanks Andy

On Mon, 21 Oct 2024 at 17:06, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> efi_bootmgr_release_uridp_resource() is not used anywhere except
> the same file where it is defined. Mark it static.
> This helps avoiding the compiler warning:
>
>   lib/efi_loader/efi_bootmgr.c:388:14: warning: no previous prototype for=
 =E2=80=98efi_bootmgr_release_uridp_resource=E2=80=99 [-Wmissing-prototypes=
]
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  lib/efi_loader/efi_bootmgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index 589d3996b680..79144962cd73 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -385,7 +385,7 @@ err:
>   * @ctx:       event context
>   * Return:     status code
>   */
> -efi_status_t efi_bootmgr_release_uridp_resource(struct uridp_context *ct=
x)
> +static efi_status_t efi_bootmgr_release_uridp_resource(struct uridp_cont=
ext *ctx)
>  {
>         efi_status_t ret =3D EFI_SUCCESS;
>
> --
> 2.43.0.rc1.1336.g36b5255a03ac
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
