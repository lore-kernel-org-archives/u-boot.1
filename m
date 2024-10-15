Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 338C9CFC280
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 10:02:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F69C8907E;
	Tue, 15 Oct 2024 12:02:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LrDZGSm6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66C3F88E36; Tue, 15 Oct 2024 12:02:25 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BA4488D54
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 12:02:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4311d972e3eso30096705e9.3
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 03:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728986543; x=1729591343;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=QAGDzmbJsme3obHDeDPZfS4Zs/uLjzb8ndw4eKtjWp0=;
 b=LrDZGSm6j48+DvIi7F3ZUiMtkqwd/Yqkb6K2peFAz9vzcZv+xFwquqsNs02pseHmOj
 XPc8i2B9EVHBFeG3PhQ3HDoPD+mJ03XP783AcFtDNK1PtjbMe/AGSDjA9pyr9fmsWJOQ
 PsA6DXNv09JLwR0aommnsyEnkRgKLN9MMVFsojVvI1t9MRVMpryricFlDn3E97Go7tWQ
 TWPjKpL8u91ah7zK/LNj8mZIYbRclaxkHNoJJGOoqm8tPY7W2NdZQk7BdQv0cZPjYmdR
 UUj3+6kB0m0hnhMA4cyoZLza3BsDxXx4tggR7PEf38lSrW1FfUItRX0hs2u7wLciCGD6
 +zmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728986543; x=1729591343;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QAGDzmbJsme3obHDeDPZfS4Zs/uLjzb8ndw4eKtjWp0=;
 b=wZ0ES7g7KSrLHpCMZBE7UDf62efoSBM9qZ3ERDHZDZfmEnM6D/qiyGEWGjierKqnHX
 nl9fDcYM1ZzJI6In+EoPA4M9dnedQ6irrmyhddUDOuVs0vo2A5l7zMIZKQMhIFT7XOa5
 NO+2bqcEYgMco4TVe0AlbZn3KcFBJgXCJDD8RjNd2CCOp4C1gc3eCkGCIUO5dIn7ETbQ
 37YWiDrPo90M6pJIgb9g2Y8KAfLX/DVdM5xyqCYdHfU7GQoMfTIBP79anwokstK+xrM3
 p6WvYbK9ojiBMwdmLjgfTEIn+7A5IZbdZX2zLzs3X41WNg1neCICEpWcpTc7LwJTxHnX
 72JQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOikZpyF8bqNxpAyVh5Je2fCd08JmSRCkA7K+r/99oYJQaT6/Nd2qYpgTzwEotwmiUxTbaHCA=@lists.denx.de
X-Gm-Message-State: AOJu0Yz3rWMhM4p1ITNM3nybPMW0SOWRYiuLt+dmEm12RlNjE5SVLdWK
 yB8fMC74u1dy2eRYGByS2QI1jOd1CjvnZunPQa6//00/008r3/n5fWKNoRx+FhU=
X-Google-Smtp-Source: AGHT+IHe7fZYJfDX9Su5piJRRhsktJdbTTT151JVWJuDfZVst32EJFdb10KQBvRnbdZiTiQtGkAlxA==
X-Received: by 2002:a05:600c:8714:b0:426:6326:4cec with SMTP id
 5b1f17b1804b1-431256199cdmr93068025e9.29.1728986542658; 
 Tue, 15 Oct 2024 03:02:22 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f6c4a0dsm12802425e9.40.2024.10.15.03.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 03:02:22 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Sean
 Anderson <seanga2@gmail.com>
Subject: Re: [PATCH] test: Drop mention of old flags in a comment
In-Reply-To: <20241014201753.1902999-1-sjg@chromium.org>
References: <20241014201753.1902999-1-sjg@chromium.org>
Date: Tue, 15 Oct 2024 12:02:19 +0200
Message-ID: <87plo1zntg.fsf@baylibre.com>
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

On lun., oct. 14, 2024 at 14:17, Simon Glass <sjg@chromium.org> wrote:

> A comment in test-main.c was not updated with the recent rename. Fix it.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
>  test/test-main.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/test/test-main.c b/test/test-main.c
> index 479dbb33b72..ed100eda847 100644
> --- a/test/test-main.c
> +++ b/test/test-main.c
> @@ -294,27 +294,27 @@ static int test_pre_run(struct unit_test_state *uts, struct unit_test *test)
>  	 * Remove any USB keyboard, so that we can add and remove USB devices
>  	 * in tests.
>  	 *
> -	 * For UT_TESTF_DM tests, the old driver model state is saved and
> +	 * For UTF_DM tests, the old driver model state is saved and
>  	 * restored across each test. Within in each test there is therefore a
>  	 * new driver model state, which means that any USB keyboard device in
>  	 * stdio points to the old state.
>  	 *
> -	 * This is fine in most cases. But if a non-UT_TESTF_DM test starts up
> +	 * This is fine in most cases. But if a non-UTF_DM test starts up
>  	 * USB (thus creating a stdio record pointing to the USB keyboard
>  	 * device) then when the test finishes, the new driver model state is
>  	 * freed, meaning that there is now a stale pointer in stdio.
>  	 *
> -	 * This means that any future UT_TESTF_DM test which uses stdin will
> +	 * This means that any future UTF_DM test which uses stdin will
>  	 * cause the console system to call tstc() on the stale device pointer,
>  	 * causing a crash.
>  	 *
> -	 * We don't want to fix this by enabling UT_TESTF_DM for all tests as
> +	 * We don't want to fix this by enabling UTF_DM for all tests as
>  	 * this causes other problems. For example, bootflow_efi relies on
>  	 * U-Boot going through a proper init - without that we don't have the
>  	 * TCG measurement working and get an error
>  	 * 'tcg2 measurement fails(0x8000000000000007)'. Once we tidy up how EFI
>  	 * runs tests (e.g. get rid of all the restarting of U-Boot) we could
> -	 * potentially make the bootstd tests set UT_TESTF_DM, but other tests
> +	 * potentially make the bootstd tests set UTF_DM, but other tests
>  	 * might do the same thing.
>  	 *
>  	 * We could add a test flag to declare that USB is being used, but that
> @@ -323,7 +323,7 @@ static int test_pre_run(struct unit_test_state *uts, struct unit_test *test)
>  	 * pointers always.
>  	 *
>  	 * So just remove any USB keyboards from the console tables. This allows
> -	 * UT_TESTF_DM and non-UT_TESTF_DM tests to coexist happily.
> +	 * UTF_DM and non-UTF_DM tests to coexist happily.
>  	 */
>  	usb_kbd_remove_for_test();
>  
> -- 
> 2.34.1
