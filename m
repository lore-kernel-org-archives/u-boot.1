Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D8F3CAC5B0
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 10:14:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A0748206E;
	Mon, 29 Sep 2025 12:14:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E7IELH2+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CFDC82A9E; Mon, 29 Sep 2025 12:14:16 +0200 (CEST)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77FAB809A5
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 12:14:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-4ddf60466d4so34180361cf.2
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 03:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759140853; x=1759745653; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=XA1p9dDlihZlrribTMgAPwzhnEdM9mfqkQuuN4Yi9zQ=;
 b=E7IELH2+65H2d1/AyRgmUbz7p4hVEzmST1Jp2EI+UxVlyvnae8ZWGo5V8f7M5emGhn
 o1WX6UPtpgSOAy/YmN/gFa3wAdEOfGinluYCXmk6hO3cYV/akwvtRp4Y6c8I/SjD7i/q
 guevIGHT2wZ6U1jkwGEHIm2SwWdxTAVPk2AaCESRqj9u8EbHsFrgPsw5e8qaNDYHVqwb
 tPRK+NSJZa/LVi8oa1luA87bTOhxmRyc31EFXb+KXIvFggWmvtA9FlEswzBl0uGtAr8J
 Xfshxm+MSuP2jJVlLLSc/oMP7TqCckUDhWdPtEZpT7aN413xMTdiRQD0Ds7pFCxEIuh+
 NofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759140853; x=1759745653;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XA1p9dDlihZlrribTMgAPwzhnEdM9mfqkQuuN4Yi9zQ=;
 b=KaJ2f6fizgK0S4KbFgkUAEMdFTcxS2UZOXZR2gn50CwH0mq1FSfW3BG2KMdtpcucRy
 +PkSDyaC6yr4jrNSK2wbFR3RvGuLH/I4wFF3dMQOUtBBf7u7RwHoa/LHYAX5Yyy4POf/
 R8nqBcYq4u2DieSEUrYQZrBayKuVUdwdXmgdLEWjGcv0E316BrOQoeVkDzuSJNPywVBv
 TDSFkadXpkOUWmb4Ay0xX56Qdc3nQi2jLPjspirBq88G0GenSkB0kKVDqAHUuq5omQGf
 FNDY1xDZLPn0w7837rErDTM/zN0tUxYN7OVxv8e54fOOApUwFfu/ZArDanNePdDFobhx
 767g==
X-Gm-Message-State: AOJu0Yz1wI+QjAxLmliNlrSwC42FQFlOVqocc95sm/03eNkETBYgP76Q
 2unz+QQ6sS5dn7L3v3YQht1Q+RpnP1wJPbUIKQvGWu5h5PyLeXLMdurcMwSDhQ==
X-Gm-Gg: ASbGncsKUvfAHtAmHZfa5JyJUIFLtmALq38Ao8GQ3CwjASt7r2qtqsZvVJaCtFgufFH
 VxI1P2gyLYXac2hjvfehv++UXbGbLwWiCcu4U4T5fMOxPF59rYf5Tj6fGonLgecf9xa3FOTC9Uv
 /71nlCVJ7SsIIfP6PQ22b/KbjQdkvfWq5LoAYvD27oFv6qEKlAW/n7eLmQnOnMIndZuJXXW9ee3
 8VhOcHpF58AROU/dkHb/UwG0dSi0dt3OlNJL/NBd0fvOsEqmzKophBPURWzc1oothtrXVETZCSi
 TcIu2pI5J6DoJLFww4jPX4MoGRuSYDWkVm2w+YCNTwkjAQ/yLH/gZ2ZvuuKtGC31+8cH8WKsnL6
 4NFwhO/UdcuTWnP/eAGs7Z5LpRUUPaQY7C4iKaLonLAKc8z5PzH4PpLW7Sc3F/vEZSdZWlg==
X-Google-Smtp-Source: AGHT+IFt1SUqxHvuxiiX7Hssd66zH9IEjm0kORy1FeEdEnzY181G1U40mBlZ70XMykdRjIkiPRN+gg==
X-Received: by 2002:ac8:5fd3:0:b0:4d8:372b:e16a with SMTP id
 d75a77b69052e-4da481d96bcmr195826801cf.4.1759140853270; 
 Mon, 29 Sep 2025 03:14:13 -0700 (PDT)
Received: from Ansuel-XPS. (host-95-249-236-54.retail.telecomitalia.it.
 [95.249.236.54]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4db09f19db1sm73108481cf.2.2025.09.29.03.14.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 03:14:12 -0700 (PDT)
Message-ID: <68da5bf4.c80a0220.2f77f4.4c19@mx.google.com>
X-Google-Original-Message-ID: <aNpb8ecIaLPzq8ir@Ansuel-XPS.>
Date: Mon, 29 Sep 2025 12:14:09 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] test: led: Add missing ';'
References: <20250925205026.3561694-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925205026.3561694-1-trini@konsulko.com>
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

On Thu, Sep 25, 2025 at 02:50:25PM -0600, Tom Rini wrote:
> Some tests here had not been compile tested before submission and were
> missing a ';' on the end of declaring struct udevice *dev. Add it.
> 
> Fixes: 9046279d92bb ("test: dm: Add tests for LED boot and activity")
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Christian Marangi <ansuelsmth@gmail.com>
> ---

Sorry Tom for not catching this, I hoped the CI enabled these config.

Does the CI for these test use the SANDBOX defconfig?

Just to prevent similar error in the future.

>  test/dm/led.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/test/dm/led.c b/test/dm/led.c
> index 36652c2833a9..f41a2fb73fc0 100644
> --- a/test/dm/led.c
> +++ b/test/dm/led.c
> @@ -162,7 +162,7 @@ DM_TEST(dm_test_led_blink, UTF_SCAN_PDATA | UTF_SCAN_FDT);
>  #ifdef CONFIG_LED_BOOT
>  static int dm_test_led_boot(struct unit_test_state *uts)
>  {
> -	struct udevice *dev
> +	struct udevice *dev;
>  
>  	/* options/u-boot/boot-led is set to phandle to "sandbox:green" */
>  	ut_assertok(led_get_by_label("sandbox:green", &dev));
> @@ -180,7 +180,7 @@ DM_TEST(dm_test_led_boot, UTF_SCAN_PDATA | UTF_SCAN_FDT);
>  #ifndef CONFIG_LED_BLINK
>  static int dm_test_led_boot_blink(struct unit_test_state *uts)
>  {
> -	struct udevice *dev
> +	struct udevice *dev;
>  
>  	/* options/u-boot/boot-led is set to phandle to "sandbox:green" */
>  	ut_assertok(led_get_by_label("sandbox:green", &dev));
> @@ -200,7 +200,7 @@ DM_TEST(dm_test_led_boot_blink, UTF_SCAN_PDATA | UTF_SCAN_FDT);
>  #ifdef CONFIG_LED_ACTIVITY
>  static int dm_test_led_activity(struct unit_test_state *uts)
>  {
> -	struct udevice *dev
> +	struct udevice *dev;
>  
>  	/* options/u-boot/activity-led is set to phandle to "sandbox:red" */
>  	ut_assertok(led_get_by_label("sandbox:red", &dev));
> @@ -218,7 +218,7 @@ DM_TEST(dm_test_led_activity, UTF_SCAN_PDATA | UTF_SCAN_FDT);
>  #ifndef CONFIG_LED_BLINK
>  static int dm_test_led_activityt_blink(struct unit_test_state *uts)
>  {
> -	struct udevice *dev
> +	struct udevice *dev;
>  
>  	/* options/u-boot/activity-led is set to phandle to "sandbox:red" */
>  	ut_assertok(led_get_by_label("sandbox:red", &dev));
> -- 
> 2.43.0
> 

-- 
	Ansuel
