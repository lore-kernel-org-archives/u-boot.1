Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ACDEFF885A
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 05:45:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3616846D5;
	Tue,  5 May 2026 07:45:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dtIIfaUz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1086846DB; Tue,  5 May 2026 07:45:47 +0200 (CEST)
Received: from mail-yx1-xb12a.google.com (mail-yx1-xb12a.google.com
 [IPv6:2607:f8b0:4864:20::b12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C555284683
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 07:45:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-64937edbc9eso3868044d50.2
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 22:45:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777959944; cv=none;
 d=google.com; s=arc-20240605;
 b=PAa5pW8+kNtyLhRqLHm1/esz5zBKBSp+QjNhQWy+kqA7wuY0xr+Dg53xrDcyvOALaj
 7cVroCczWuD+Q9R/sYd3goIvB93lAT24ufGPbJapBWrgdXu1JafdQE1GJCDO7BTiyE83
 lMGO6xjhVzoXLORzBsKSrxrz3BW1hPqeVt4SEyaxp6n3d0Gmqd6yG54LMX+OREVLf4lD
 EZIzz0d6A+Yxmts2bPa7v3rVT1WiYKebB2LTJtRDvcM1GzQTKA+lEeROAK5lwtBRLg2i
 shVre1+li0CbkfQaHEbhSWlpdmWCCrKpRZ7VB5hbIAs23Ffmbpd9mX2oNHa/qjKTxBUI
 0Ucw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=y+yKGfB+3MNP5utHdVEUq0WWqcI/YVvNodFAKrWunA8=;
 fh=Jg1GwjOEZ1S4lNqzrPlyRpppkKciiPaSkBs16SCT10U=;
 b=YUvjRU57uVJYzGJ0WhdNIVobGffvmcDeuLcxngF5+oiysAELoqN4ds4mH0WFZH8kNc
 V5VUaGpwIEO94Qs+kvZYDhts0Q1jMgpm5SxPUWynXtnlMdK4FO7FYDT+KRBarfdRyULZ
 h/2vc2fhBTBaB2jp4yn1uyX85bW1I82bJNfTVXVSitFR+TvK77TKFjZEx0s/KhD+3Joz
 wGNJRK8XoODlIxC5LZENrZglT+o/ZR/V6Pc530f7toqBvLXmvIwKTonubEqHeXthJkPz
 MPKSSkNoKRtZTQXGjnL8a8l+dFF5ue5v3/Kkfpfk6B+wuB6A3sD/QI8TGI62GTZfE4XD
 UIRQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777959944; x=1778564744; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y+yKGfB+3MNP5utHdVEUq0WWqcI/YVvNodFAKrWunA8=;
 b=dtIIfaUz54GoeVWIS0n9ofxdpcs0fBrEPTQ/Y5DQ4FzT15z4FJLbRlo6pXufh2xcuH
 /VWmYzUBFQ2nKyFGx5HX101GjubZNYYUCUMvcuI6wWsHd3Y7P03MHAYJqQAPbjfikPsl
 6eemCC6aNgds6f77ElnojHKI9pb7qBAjKHxmjZQe/yO3QgfrX2EA/YcmHo8GenO3iMW/
 MwhCzNKtS7okHhK+G+k49aIZQQrOrTpETKXtB1bcqJULXZ2ctbR9m0aFVWNNPao2obnc
 HXbh0oolAv7HXcsUlxZGLB1+PYaK9FHZhIQgXTp+OZyMjzUtdYiSbuwSLO6Yqu2UM2YQ
 xT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777959944; x=1778564744;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y+yKGfB+3MNP5utHdVEUq0WWqcI/YVvNodFAKrWunA8=;
 b=HgatJGW3HeF02ORIzD9vAWIadd+PxGxXbasR+DlpyGYwLJOQbNbQJQA54PPkCIIQEC
 5n9mPnx4LEpqD20OhlrrpbhRoCsJXq3fUl61Cwh46Iy66igans8g2fYt1FqvkjTxADDR
 fjl2RfEhvKjnfOync3h6l23d+yTbhGdg7mE8NPUYXLdHCRf7GVYXpALqreTAUPh2sLgS
 JqRrlvBI2wJYr8H6P+SCdZijFBFPEJTXPOCxbKlNlfGmJw13m3IkjJE/cud50ekFBnLf
 IHgZ9y3R/LatggG/e9Rvpbl94UQBoZHNKdM17PpE9fSS+p2pOak1AaTgWr3nDrnTkkJj
 uTfA==
X-Gm-Message-State: AOJu0Yxo4GdfPyLFh8/RLRq/h3T+PV342AlhA87v0S3cZm0G23iDw57e
 bTccJ9BxCw+8p8K5k78OKjEg/nIuIoxlSnuCD5RF/TkFzn6I2mjZZzLS4CsWuzDjDB2UppmxFtF
 b8BhGKBQo1EjJZWozdFpoYoA9eNy/G9fVBunMqPmvPA==
X-Gm-Gg: AeBDiesUuepfwP6MxEoaOISIpd5Tp6iV6i1/6SP5qg1LeOLuDbvK9PeEuZp8u1UC6QM
 RjHhkwrut2NJUzy8ZEEuVnXUZ3d+Zh8UBxPlH3KjA3O3X2Ur4rnNO8/V6Tw2nhXFikBOEuF9myf
 I2wMG02uKMDWLx2VHpBJRCOopOPI9fVJp7oE3b/lesNcKMFfa2UQuVT6X/f9RVmXmkXqWTimkBU
 MvUIYK+qCKLYmyz08ZRXfmF/TUYmQb91pOhRNfCgjqng6j7HyJIRF6v7r3aQJdEFqbrscvKDBhf
 98ZLU6ojjXMAM4bhN9Kx4jHVVX3L+h0icWZNY/YnhyP1RykmXruOoGgvsLpRnxQ92VwPuR4v1Xr
 6ujaFKVrQsqB/ND9BotflSrI+m90VlsftrZfdfb+1jfsP/GjRioqhShZx6gvcTgflgjgiwO4fbB
 4sh0PblYdVwVT5WxFT53SdYReF5GRzbru9A/UOjxZiDsECfdVyagvyi6ewaC+nlna8OcUNtnWTk
 GBf1UbuV7QFu3BxdIhf+zuqkgXv53nVJsVGzpTtA4iSBOqa4eluRiqy5fHPXGhrjUd7+VmuAYkq
 kd636cCfBZC500eXXxqBOkUJKPeuxvjFAxos9rFAdQKyKMr452nlvff69RmQDZsZ/7xPgCLoGBK
 KESACde8qF911pnGtqygYie5GOeU=
X-Received: by 2002:a05:690e:1c1b:b0:650:3bbc:5375 with SMTP id
 956f58d0204a3-65c69cab325mr1540261d50.17.1777959944498; Mon, 04 May 2026
 22:45:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504-extrawarn-sync-v1-12-b19301d1948a@cherry.de>
In-Reply-To: <20260504-extrawarn-sync-v1-12-b19301d1948a@cherry.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 5 May 2026 08:45:07 +0300
X-Gm-Features: AVHnY4LIGW1CzrmG9rFNmPA3SJTRQrbc8e5gYY7eckSU2W7JwUVDfZnGZxuBXvs
Message-ID: <CAC_iWjLqdXsAhAjWKYJS_wWuBfp4qu_Zm03fC_04mkWaCLSEFg@mail.gmail.com>
Subject: Re: [PATCH RFC next 12/18] scripts/Makefile.extrawarn.u-boot: remove
 redundant Werror handling
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <simon.glass@canonical.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Yao Zi <me@ziyao.cc>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Mon, 4 May 2026 at 16:20, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> In the previous commit, scripts/Makefile.extrawarn from the Linux kernel
> gained support for adding -Werror to KBUILD_CPPFLAGS when CONFIG_WERROR
> is enabled, therefore this is now redundant and can be removed.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  scripts/Makefile.extrawarn.u-boot | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/scripts/Makefile.extrawarn.u-boot b/scripts/Makefile.extrawarn.u-boot
> index 86f6fbc2301..0a9b49a30f0 100644
> --- a/scripts/Makefile.extrawarn.u-boot
> +++ b/scripts/Makefile.extrawarn.u-boot
> @@ -25,6 +25,3 @@ ifdef CONFIG_CC_IS_CLANG
>  # there are other places as well. For now, we will silence this warning.
>  KBUILD_CFLAGS += $(call cc-disable-warning, deprecated-non-prototype)
>  endif
> -
> -KBUILD_CPPFLAGS-$(CONFIG_WERROR) += -Werror
> -KBUILD_CPPFLAGS += $(KBUILD_CPPFLAGS-y)
>
> --
> 2.54.0
>
