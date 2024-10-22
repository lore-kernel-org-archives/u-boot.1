Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D816ED2C555
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 13:51:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28E7088EFB;
	Tue, 22 Oct 2024 15:51:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QaI4JtO6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F0B888F31; Tue, 22 Oct 2024 15:51:48 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E4D688D97
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 15:51:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43152b79d25so55005825e9.1
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 06:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729605105; x=1730209905;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=VWQoCY5PEs0wWlKNHHKovn17yhaLOWXeStDVvSkGDHA=;
 b=QaI4JtO6bbI3ciEn2SZ+hBxyyRj3UkNCWWNpIBcd0mnzdn7P0Sb0nQv9yYjh2edBeF
 F/4Lbektoj9OL1jfghK5Bgb/udek2FNHyBXSoTChqof5MjCH95gup5SZNrsE6QpQhb1O
 3FDbw7Sg6Vb5HGdKFT/zQJyK+xkUYJq7KUCdTfS5eddWd7oOfQC9th1/Vw/P3RWfZQZy
 5Z7NoIsKQMqfpPDn3Pyu1ygHPovQx+/3nS31hnTeJdOMlWYNqJpWjauKWhDdbHAXu+ed
 +Q5Jpb0fCtHoJnG6ZL0r7iVSbpw38HWsqX3W+bFQG45xqeXS97GNUnAuA+t2jK1N1uBC
 zhPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729605105; x=1730209905;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VWQoCY5PEs0wWlKNHHKovn17yhaLOWXeStDVvSkGDHA=;
 b=p78uGPo/lOlkNReGtt/O/BXPFgvzUHTh4YGfrf4MJTkSgv42XL/QgZYsin+iklKEfr
 9xd4o5JQ9n/b0c2x2PNL6JkmalzTFLK6OmA63EAo2So16DUBbca2MvI2SAN7DYxpNQ2H
 O9k80kgy1hvmaqr3NAMFlbsA7GxVPLDvP7M5Ph+YizkPxtdx0H4jACfxWewo9LvwQ+bM
 vBe7weACOQuC/Bj0Dm8m/bjHauZR05knL6gyakWjp7qZLAav8+I5NEZ5oDlHjrs2Rp2u
 7GCmSVU5WcDaasCsAydiJZ70Szgy9EDz5tNyeQdD7f6+R1xtaG1SWKbKsOei8Jf7vHy5
 RevA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCV2UEIl+ZQVOEtM7vknGMAkE7WDWc+nDHDsdyPy7xJpmmSS4MgTyIUEXJrr/y/SzUV/OLO/0=@lists.denx.de
X-Gm-Message-State: AOJu0YxLvEybYDZ3pnFYJNr+gcstAq64WoYJrXrEc/CnycrkySyQlJOE
 DGwRTvEF+OQeeboevz4rH8KIYzjzZMBzOlEWqiLXN1M50JYbExQVohUq7MksOKE=
X-Google-Smtp-Source: AGHT+IE2/rsh8c35A35/6Yn0ohQJtzPqc1Kpij7C8rwNHaqmmMG0tG5GwzGYCJwbdyxn5S9IgoEwtw==
X-Received: by 2002:a05:600c:4ed4:b0:430:52ec:1e41 with SMTP id
 5b1f17b1804b1-4317cab54cemr25163345e9.17.1729605105387; 
 Tue, 22 Oct 2024 06:51:45 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f570f89sm88341555e9.7.2024.10.22.06.51.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 06:51:44 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, AKASHI
 Takahiro <akashi.tkhro@gmail.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 10/31] test: boot: Use a consistent name for the
 script bootmeth
In-Reply-To: <20241019152211.1014896-11-sjg@chromium.org>
References: <20241019152211.1014896-1-sjg@chromium.org>
 <20241019152211.1014896-11-sjg@chromium.org>
Date: Tue, 22 Oct 2024 15:51:41 +0200
Message-ID: <87ldygutxu.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Simon,

Thank you for the patch.

On sam., oct. 19, 2024 at 09:21, Simon Glass <sjg@chromium.org> wrote:

> In the bootflow tests the script bootmeth is bound with the name
> bootmeth_script whereas the others have a name without the bootmeth_
> prefix. Adjust it to be the same.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
> (no changes since v1)
>
>  test/boot/bootflow.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> index 154dea70a59..8ea284098e7 100644
> --- a/test/boot/bootflow.c
> +++ b/test/boot/bootflow.c
> @@ -542,7 +542,7 @@ static int prep_mmc_bootdev(struct unit_test_state *uts, const char *mmc_dev,
>  	/* Enable the script bootmeth too */
>  	ut_assertok(uclass_first_device_err(UCLASS_BOOTSTD, &bootstd));
>  	ut_assertok(device_bind(bootstd, DM_DRIVER_REF(bootmeth_2script),
> -				"bootmeth_script", 0, ofnode_null(), &dev));
> +				"script", 0, ofnode_null(), &dev));
>  
>  	/* Enable the cros bootmeth if needed */
>  	if (IS_ENABLED(CONFIG_BOOTMETH_CROS) && bind_cros_android) {
> -- 
> 2.34.1
