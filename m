Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7ABFC4167B
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 10:07:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 358B987B2B;
	Fri, 15 Dec 2023 11:07:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="e+HYZtTu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D5ED87B52; Fri, 15 Dec 2023 11:07:24 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F5C287A42
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 11:07:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50be10acaf9so411684e87.1
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 02:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702634840; x=1703239640; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BdbHSe9ibcm91cX2a3gyxsEmTSyKewJTW3q+Z6Izzfo=;
 b=e+HYZtTuAZCxCZNQSOu/WVXyYapr3sC66h2kPp6EZ4RBTDWWG6PMAH0Cuthn0RKBak
 v4XoliJO4Nod9YuUKUxoiMNG2ocBssT60v51TTx9DHDObpWHGGiq0/USi0J22mI/TUZt
 iwUMEnapNMlNTXC38lVymuzdJB+s4GDIuxFEjAiyCeZc+KN0HAvEbaFy68oqtryJ4awy
 Qj7KbloPwEIU9Qsb9JF7DfAJN4H/XtNrA/pQVuQwjuPWJjhZzXYZZhinkuKWsv3ptLl2
 io/pmtb01K43Le34fbxPD5uvpvpXRheldzxoJjZP3Hcz0qi6NeUYZLIifsSCDRztebr2
 CKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702634840; x=1703239640;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BdbHSe9ibcm91cX2a3gyxsEmTSyKewJTW3q+Z6Izzfo=;
 b=Ed+iU0v9QGCpreJJQpPxj3LxNMI8v4+W2BayRRYbbrhjaWFcIMPZNgJans9D0g0i3F
 qR93trq2AUsOjl+tJa1NCQduvKYp0rQhSmnWIh0l9piZ5iStD1O7b+4G774Ae4fXzRKe
 /k8Jmwji8YMjl8zwK93+EIp6wuAhJ1gQWMCYkza4a/XFbLq29l0BWVSSUssuQ55U2xLC
 a8HMxBjq1hzNeW0vOW/FE4lJ7bMD8cz0Os2bEUE00Eo6QMKgPVoitFnKihulYXby+g4H
 45J1o8yc1g0+N9RJDjs8iVXIIZqxcNwPTRyH3TsgJxdBZ6V30ZydJiGBK1EDPpAOgWxz
 D0Yw==
X-Gm-Message-State: AOJu0YyC1uQNdfsyWUtDOvnohntqiUSnA7dkiR5UFbNdmbaL6+CmW8aE
 IhA2iDAH6ruJ9mJGZuSQRODire1wcn57gWz6vve0Vg==
X-Google-Smtp-Source: AGHT+IHdqbDD3dhEL+YXCz17Yyju/kAgMZb5ACYT1aj/04CN+RmdDl08/D0bBnISFkrUNi+3CLpN6cOJifVqDBHSRnw=
X-Received: by 2002:a05:6512:2354:b0:50a:a872:3b1c with SMTP id
 p20-20020a056512235400b0050aa8723b1cmr8295147lfu.27.1702634839724; Fri, 15
 Dec 2023 02:07:19 -0800 (PST)
MIME-Version: 1.0
References: <20231208053914.216413-1-masahisa.kojima@linaro.org>
In-Reply-To: <20231208053914.216413-1-masahisa.kojima@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 15 Dec 2023 12:06:43 +0200
Message-ID: <CAC_iWj+RmYMBSd+xFm=dsBoC7zx49+WjAt6RQMnrZxovad=RAA@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: fix iteration of FMP protocols
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Kojima-san

On Fri, 8 Dec 2023 at 07:40, Masahisa Kojima <masahisa.kojima@linaro.org> wrote:
>
> If one of the FMP protocols fails when calling GetImageInfo(),
> populating the ESRT ends up with failure and other FMP protocols
> are not added to the ESRT. We should still add all other FMP
> protocols to the ESRT.
>
> With this commit, iteration of all FMP protocols continues
> even though one of the FMP protocols fails.
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
> Note that this patch addresses the following issue.
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/issues/3

[...]

>
> @@ -381,14 +381,14 @@ efi_status_t efi_esrt_populate(void)
>                          */
>                         EFI_PRINT("ESRT erroneous FMP implementation\n");
>                         ret = EFI_INVALID_PARAMETER;
> -                       goto out;
> +                       continue;

This doesn't look correct now.  We set ret but we never exit to do
something with it, instead the result is overwritten on the next
iteration. I think we should only get rid of the assignment, unless I
am missing something

>                 }
>
>                 ret = efi_allocate_pool(EFI_BOOT_SERVICES_DATA, info_size,

[...]

Thanks
/Ilias
