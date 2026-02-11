Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71104E9E31E
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 15:17:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97AE28388D;
	Wed, 11 Feb 2026 16:17:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qq3eVQE0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA33083966; Wed, 11 Feb 2026 16:17:15 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8DE983015
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 16:17:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-79495b1aaa7so68968627b3.1
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 07:17:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770823032; cv=none;
 d=google.com; s=arc-20240605;
 b=h86CJY47O+qQfK3gf1slXXvdu9jcbVk/7NmyS+A+Sy95bJ/HGKce4Nhmjv77wIPpcZ
 LrTNCqV7nMoepOU3aCSIeo2+B4rk93ePsZwT+jfC1UHbperZf7ya1wAKyUnW0qfbqvQ3
 0s6pziY+j6d+wMswdGnyHUz+4dKzcGg9nThgLNP46vrcFTHtdPMZ6s0I6m/DwmfbaI63
 yBYvrlbIAZvNL0XLdRZY36yqkTN1VLmvueQhkeuFo522hjzzgGll3VU+YZfsKKcYZRbE
 hHhP0shY5aF99eS+Tpc0wiOqUL4W/YT+Bq0oS2GwDZZeqSFkelpPeRIBEd9gHPKFqODd
 4wgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3j8Xg3RQ2a2ljqB8H43xljHk7shluYK5IG4E0FyU3kE=;
 fh=qDxef2lzHjzlNn+eQVRosSEfgvSRXYPWkbnxd3nNkXk=;
 b=WyBYH6Mrypx+ck3yrWOHNKcTKhqlyCpww/ZgnCrDcVFGCjYAoM1z6z3DlrvlBMrL48
 Q1KhqDv4cKjQODWXJ/kNnxYd0O9Eg+HazMDOhuz9/dEuDHfXpTfvnMGVDYrtni8lGGXp
 OPmoo/WIOHRsSjdMqscVptYRE1Wel+QGHczN13lOohvTvtzsCbOjPdWQDvRh3vLUU+Lw
 4tUBV3N8ieRlV4XBn0wV5fym6gM5aDgWQB4ysoJMfZutwsPvppiPYVpqWr3laDF/silX
 qBPfdG6cgmu6gdhGpi4vit2wwDffUl/QB+0chEP1SAMU1GZr10jtgEf6vOBIXHMxwc0G
 Ik/g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770823032; x=1771427832; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3j8Xg3RQ2a2ljqB8H43xljHk7shluYK5IG4E0FyU3kE=;
 b=qq3eVQE0RnjsD4oONkp5mPgVgkGEKCVB9WsTdKjYCKCO246SIroT3QNtw53hkXQ7CA
 4tAwRMR1kzhQNLgJ+aRDN+i5HnbCmi6W6xZXZtmyV01OBJUcF3MMjBgh5q4SZSH08hKR
 JP6AicJ0Cm98SkREkv6c/QX82asggBYV9RA0E06+DZPLKxBarkA6g8EcMn5SFuUzbLQn
 XcSW/VHQJEwV7NGXfTlLX7l5cZ5ouZ2CTzEngx1RH2dBfY1rmZZC0QLNq5X5RKuwHXis
 kVYhVk4BfsdW7es+9JjjI8zNgLYEJQSmqQfe64AYqcXxkx9L3esFyNFvDaSzzlw3aysn
 PJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770823032; x=1771427832;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3j8Xg3RQ2a2ljqB8H43xljHk7shluYK5IG4E0FyU3kE=;
 b=nF6IF8HkozI1JTmIUKkU15wIWh/XsetKjcB0qMJm7iP17ZknTNUtBkoPNfSoaPLkOB
 6lultcxeT/zuBGLj26ZANesvktHszUqrn4DI29cWYkxM7kRnWEswp43Gmd+gr4a3od1+
 XEbdXN1LvP3Ca3hCE1hySQ7a8A9krM+cideAj9vcAeOo4O181rUtp0vey+h8pehTmEJu
 L2w4cDNdR9/qwQes6er7Z5asvCIUnlGH8Xuo5xi1gET8te532RyxGaq3e6YORup0RPwy
 TapCH7WCalDCl1P5y4BtZEtbWI4rxc8Z+s+PUYx8Wr/TzS1mRsKVJSuj3eFe5OT+YP5w
 2ZWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcWnPEGCdmp6NoTSC9iX0HlR87kCqYq1HXIlOBhaSdCn1sQkyHX1PTxt2cy/YAHgGEEx1Cs40=@lists.denx.de
X-Gm-Message-State: AOJu0YzQcCdWafK8/Zpu3URYcndDWpo/R/9qMt+LRDJKA0ScF2pBS7Ka
 LmcH0SyESU1Db0flAjpnp8sbIChAsKVQLEo4uODmuwF11E+hf9M5yjpsoMdGHOp6u1Hx2kYFbVU
 v0BGkgFDbav5dIJgX/syi6XeNdXrGLKuX7dUOrppGgQ==
X-Gm-Gg: AZuq6aI1mLV7ete0zYVcneQ69iy9vpY1wNd57cUiWfncQ4WLG6Oc2h9NAnDuOt6XVG8
 JeOA8QPd9kZ+B5t+50l+MN0yf/A2odn5mo5hlxQ5+A+UNWc+vzABKSuOB3YP0Xk5zBr1286u9QF
 1mvWMbcB8lx+Y111ISHFXzFYqzJ7ehyhWrpxMxLuWNvVxSHRX+9C2PcAYNwWYQ7IED77e+DXBM5
 88z32Tj8+LC3+VVXhGlD+3QrtEU1Vv2Th6G1/eBM1OHid+lK0Ubln+s9Ib4l0dtUE4AympOHo4G
 U+hMCz4djuzZ1Lk9pcUOAqQbvKdcEoopFyMMK7RCtUbCX86A48z1yYrV2EO5rAn9aLuD4kZTGZv
 5/4A6jKZ+SYMWUMTk23gHGLx7ylEi6MOePgOE+4AoDJ6BxrUNrPA/GQqluKZgVwYGZ2bYIUDnSr
 qKP6axws7bt8MBWzS71ojuS2Wr45zNYZa1NwWErmb2blZjhUiamlrOA7ow14d3kAgMhZJuA84NR
 mI3PFpQ/0uH6EwxIPQjUkSKYBBXnc9kfQ1zIQDFdvePJ73T1gD2isgyCPDwADSZfrvnq1a9lfd4
 +ACyhl2fdVF+xUtZc6Wf2r7bjSQSXoovPoJOtXNuk/se
X-Received: by 2002:a05:690c:4b85:b0:796:5a14:87c3 with SMTP id
 00721157ae682-7966c097022mr20003517b3.40.1770823032169; Wed, 11 Feb 2026
 07:17:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1770119483.git.michal.simek@amd.com>
 <1f50d76c2370b9b032e73c35c05246cc70255b28.1770119483.git.michal.simek@amd.com>
 <CAC_iWjKxshi4fEtUvvrwGrd8quSUNeeuqjTV=gFrW4x6uXi55A@mail.gmail.com>
 <CAC_iWjKyuoFAVVTv=+tajWJoYtEv4bxebWMAxqUehSEk2YMQaQ@mail.gmail.com>
 <20260211151257.GB2747538@bill-the-cat>
In-Reply-To: <20260211151257.GB2747538@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 11 Feb 2026 17:16:34 +0200
X-Gm-Features: AZwV_QhK8FPRmjArw-cXFCaFAsUfaQM_ADn4SgJUVJyy5qw92t_5tbGjoXAjEu4
Message-ID: <CAC_iWjL3J1iF9W1GsgXeE-3-=PHkEGHsRjR_7c5w1izQVewL1A@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] efi_var_file: refactor to move buffer functions
To: Tom Rini <trini@konsulko.com>
Cc: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@amd.com, 
 Shantur Rathore <i@shantur.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
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

On Wed, 11 Feb 2026 at 17:13, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Feb 11, 2026 at 05:04:00PM +0200, Ilias Apalodimas wrote:
> > So this fails for a weird reason
> >
> > Some boards don't have FAT_WRTE. It seems that the Kconfig order
> > matters and those boards pick the new option if SPI is enabled.
> >
> > This fixes it
> >
> > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > index c13cb8952caa..0f6f927ddaf1 100644
> > --- a/lib/efi_loader/Kconfig
> > +++ b/lib/efi_loader/Kconfig
> > @@ -112,7 +112,8 @@ menu "UEFI Variables"
> >
> >  choice
> >         prompt "Store for non-volatile UEFI variables"
> > -       default EFI_VARIABLE_FILE_STORE
> > +       default EFI_VARIABLE_FILE_STORE if FAT_WRITE
> > +       default EFI_VARIABLE_NO_STORE
> >         help
> >           Select where non-volatile UEFI variables shall be stored.
>
> The behavior of a choice statement is such that if there's no default
> (and in this case, platforms don't set FAT_WRITE, so there's effectively
> no default) they select the first presented valid option. Before this
> patch, that ends up being EFI_VARIABLE_NO_STORE but after this patch it
> ends up being the SPI option. So making it clear that the fallback is
> NO_STORE is a correct general clarification / bugfix. It can be its own
> patch even :)\

Yep, we already discussed this with Michal over IRC. He'll send it as
a separate patch with your Suggested-by etc

Thanks
/Ilias
>
> --
> Tom
