Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9118AD3C90B
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 11:50:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB44689251;
	Sat, 19 Oct 2024 13:50:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hbAIRQ6Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B440A891E6; Sat, 19 Oct 2024 13:50:03 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D652688F0A
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 13:49:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6cb82317809so19838326d6.0
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 04:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729338597; x=1729943397; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wgnb39yR7zFvDjkrbygFjtdutlRW/Uc93vD/O2mFHV8=;
 b=hbAIRQ6ZEkkROQvGmnuOtsT1Uuab3CteGJaJUg9fQpi/l53rf8SKUggPcW/mwUjOae
 aiAbq//s1M5z5lHi8iuoKp2Qxu2y0wzQ0xOBj9nAF2RsLek31gjIUMqGA6P7zyRNgxNm
 iSK2QKvzya5Eq8FH/m5MPiLm5mK7NilA8SoAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729338597; x=1729943397;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wgnb39yR7zFvDjkrbygFjtdutlRW/Uc93vD/O2mFHV8=;
 b=dMhz8QYjyNXIJpp9Cu7uedr2PFrBZ/k9kWHRu1epgmod9uPnngIuYJkq6PdqbWq1Wf
 x3XHC0+FzqGp/QZlDhGlr2US7e5G0ulZoi85ikryAUXk3OinPVZ8Ctp7qT0f1qYm9n+a
 m7emqlGZr2ZcrWaKDTPqrbzilWoXYHMTIrbw3pZ/UjhltDZZCRBSUXuUWOAR+lptW+DN
 NLRasSJ7txIg+mGmxO45y6sAPP7InNl0oTzt8O19KysVqI+yc3iIMi9QosOhK92yCviv
 JnfBbrQ2TiMvRHR1WnTa+aMqxX0ZRq/rFs+qoADSOmbY7I3G+G2uXu50/zKUgBdlBcGd
 fZfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTQfzoHgHS6npyuJNB3gASUa3ClXK7kT7mY4jalDtxfVIEET0ntAq6oiCvyVywyY+RNdVg2gU=@lists.denx.de
X-Gm-Message-State: AOJu0Yz2Fr3VpHU1YbAX7n9qpvEZZXx+NnMsbN5x1ghoHrjjZHMB3zL0
 XOcH23D7bp5BUl6pWyG8A973sJWl6HaoNU3sToD+fx+qXHOvFm4aIc1C2lxSzebhEJt3jVC7NEF
 h7JEKrYAIIisTBQ0sBLI/qZpxAmbc8W1oraGo
X-Google-Smtp-Source: AGHT+IGSD6g9lo8jkzRmHrTQDeAbKbaEknUk7LFq4eDlXXqBKcl4nsrcwHW6kzt8wuxtKvGZ9g+9I4KnJa3qwQEduQ0=
X-Received: by 2002:a05:6214:31a1:b0:6cc:375:73e4 with SMTP id
 6a1803df08f44-6cde162039fmr73332046d6.35.1729338596798; Sat, 19 Oct 2024
 04:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <20241019085029.22151-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241019085029.22151-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 19 Oct 2024 05:49:45 -0600
Message-ID: <CAFLszTipE5u-zHJXjqGvVoyfEQUQTE1Vi4F-PBTCsMuSvvEf4Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_selftest: fix typo 'got languages' in HII test
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

On Sat, 19 Oct 2024 at 02:50, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> %s/got languages are/Available languages:/
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_selftest/efi_selftest_hii.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/lib/efi_selftest/efi_selftest_hii.c b/lib/efi_selftest/efi_selftest_hii.c
> index f219c0120a3..c363df466dc 100644
> --- a/lib/efi_selftest/efi_selftest_hii.c
> +++ b/lib/efi_selftest/efi_selftest_hii.c
> @@ -913,7 +913,7 @@ static int test_hii_string_get_languages(void)
>                 goto out;
>         }
>
> -       efi_st_printf("got languages are %s\n", languages);
> +       efi_st_printf("Available languages: %s\n", languages);
>
>         result = EFI_ST_SUCCESS;
>
> --
> 2.45.2
>
