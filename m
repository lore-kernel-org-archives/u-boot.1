Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06150C28B2E
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 13:43:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7677D801BE;
	Tue, 11 Mar 2025 14:43:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="efniB2cI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 484D6807D9; Tue, 11 Mar 2025 14:43:55 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA39A8003E
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 14:43:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-6feb0742878so51120127b3.2
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 06:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741700632; x=1742305432; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ynNLNQP7Pow07zpnsv+shYD82cAZBWlUlKUy5JodHEM=;
 b=efniB2cI8Fp42YGmrqlXzaYIaJFQ0rGxujrFZv5SdIEUcqGjHNLNrlGyO4XY86u8FL
 IkULWvy8x1THKxfHLrsuPhlugF7V0KbKCJj7WQUa7LeXP5fIVF/e7x2WuNzrwYGzGFSI
 GCW2anM7CBNLUEv9ch0CYMl/TEZRj3W0BO2GWWOtnZcZ4MUB2lTboBfD1JL6K1rlR9uz
 2NXmxpgW3FwpdtRxJGeW5TUvBCOQp78KoFWtJjJ0Q/sQyK+d3wxQluw6hWkyMyX5TcF6
 Cj+Ol3WLQCnXD2dFSgJln/fDhkmU/Oyf2xihgFiy4dkk4cB0yJ8gm1eify3Unlv2VTAQ
 YojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741700632; x=1742305432;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ynNLNQP7Pow07zpnsv+shYD82cAZBWlUlKUy5JodHEM=;
 b=vkiAZbF2ZcW7Yx9g4Mp6NfrDBxzFcRgjc50jZK8PSBnXnad/qIdP1/b789YXz8srkF
 qhPN1fdlYbR2NGy3tpjcLZyg+74jY5n+RLIxiYKNeO9FRpw3BGL02/fyh2K/XBmjvaMy
 wf5faDVoieVJ1QupgC3FurPKh2LXAVhh9qxjWwQBfz9tRBAH7q+jdWPYASjmkQm5diwM
 jUc8Zx9HYrww5BA4RwhHRN0DN10pNDKXPefBvA1l9os+sQeqnMGyzn18FJqZFvPPX5we
 usxqgWBAnKWx+AKgKwcAcKY5ZRyhf84NytCbCEqyV93XkIPg/tIKg5rGFwYVF9v/W72B
 O5sg==
X-Gm-Message-State: AOJu0YxppoqPhs+fp+yK/J8VuqujlHBY7wLk9v3A46IciDfmUzmyg2LS
 EkwJo22+odWg7VlI107VJGE8oqt+v1IUNVrQ62Q5dVugmotqsihM3RGVvTawLWNaLmdbNv8PUS/
 P+ulED+qD8jqQnOPjALZdQwsKYY4bKfg+yiyNKw==
X-Gm-Gg: ASbGncu1NQ9XIEtArCV3rCfReG8sPvjBSbZ3CVWFDoVEtfER1isHsGC2PJ+uZlPAua9
 mSZvi8BWNXBAzas/gqOOseClBbiwwZNx2yGoX7dALfhaHVOcEs8nOfWpDd0diPuf2D6uN0dYA6E
 yHw6ad8bbGjTs43njbhvSkNDPzvOE=
X-Google-Smtp-Source: AGHT+IFzoJvpZxE9zfvrch5RJYZstKBNGOR9dbNadl8F86NAcwf85eYM9CYxYXg1D1oKvhGa+RTh4+luMzkxju3+go0=
X-Received: by 2002:a05:690c:4807:b0:6fd:2762:9d11 with SMTP id
 00721157ae682-6febf2a0c0fmr234669317b3.8.1741700631815; Tue, 11 Mar 2025
 06:43:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250310115750.1019051-1-sughosh.ganu@linaro.org>
 <20250310115750.1019051-3-sughosh.ganu@linaro.org>
In-Reply-To: <20250310115750.1019051-3-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 11 Mar 2025 15:43:14 +0200
X-Gm-Features: AQ5f1Jpzswhjvs-OFn_QkkERSZwv9ZYlv2lydoJ8fSdvuli5F6f-sJqV-Ro7q7E
Message-ID: <CAC_iWjKesPeOfH=Nt6kQZS2nKa+jgt8vtVazNJhc1wm-VzJutQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/8] efi_loader: install device-tree on configuration
 table on every invocation
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Anton Antonov <Anton.Antonov@arm.com>, 
 Tobias Waldekranz <tobias@waldekranz.com>, Bin Meng <bmeng@tinylab.org>
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

Hi Sughosh,

[...]

>  {
> -       unsigned long fdt_pages;
>         efi_status_t ret = 0;
>         void *fdt, *new_fdt;
> -       u64 new_fdt_addr;
> -       uint fdt_size;
> +       static u64 new_fdt_addr;
> +       static ulong fdt_pages;

efi_uintn_t fdt_pages

> +       ulong fdt_size;
> +
> +       if ((new_fdt_addr && !fdt_pages) || (fdt_pages && !new_fdt_addr)) {

Is there a case when this can happen? I think we can just get rid of it entirely

> +               log_err("%s: Fdt address/size not in the right state\n",
> +                       __func__);
> +               return EFI_INVALID_PARAMETER;
> +       }
> +
> +       if (new_fdt_addr) {
> +               log_debug("%s: Found allocated memory at %#llx, with %#lx pages\n",
> +                       __func__, new_fdt_addr, fdt_pages);
> +               ret = efi_free_pages(new_fdt_addr, fdt_pages);
> +               if (ret != EFI_SUCCESS) {
> +                       log_err("Unable to free up existing FDT memory region\n");
> +                       return ret;
> +               }
> +       }
>
>         /*
[...]

Chers
/Ilias
