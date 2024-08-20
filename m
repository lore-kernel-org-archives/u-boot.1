Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DA8C3DA4A
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 07:08:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FA49889FC;
	Tue, 20 Aug 2024 09:08:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yTPc69bg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7E5A88CD7; Tue, 20 Aug 2024 09:08:13 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7C8588717
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 09:08:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-37182eee02dso2696627f8f.1
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 00:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724137691; x=1724742491;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x0MkjZm2Wb2Z+BfLMP7VFSR8CdBMCz5EYmdFAOpG1/A=;
 b=yTPc69bg72VqVGcB4v4i5OlIGtGfAufWVESM1O/Wp3FusVd29ImQo4ca9vlNbO1c/l
 LN6xbh456wfSifjjL4YdxlYdXXrP7bcp8iI5XX80ZryVvbkjyqKTLml/LTeLJv1DzJuo
 d3U/4qaE4ee6lvGic7QPc8SdQa9dfqFZ4/zZ7dMhLNLgV9X1FQnTBl+jHI3QRud1c7Hb
 j7SRoBi02EgPS4kao7CM2etc/agcXxRaR35KZahSLcNy1Y5M0GbPwnjhEiIwK4EuPjIL
 aivZY37/vlHMbqZ1HiY/mgu79rspYDOrb3PYNoVrVH3YuQnL5pEgnyyU4quzZu9pifCh
 x4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724137691; x=1724742491;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x0MkjZm2Wb2Z+BfLMP7VFSR8CdBMCz5EYmdFAOpG1/A=;
 b=IQqypDNwsaAim6OtABczjQnLt5jKLBLqBhuFS1sdOfNIjOUQauCJILhdUTNbYupDJx
 XeJMNOuKpOkjdhi7COE49rUqx5Npdi+RJiqAHil1kO5HxdrtN+7PS2I3qWAg3jtmvutw
 ELAlan98f7w0AJXdkFkgpD5s/gGU/6eyOJW8Osl/F7gkduybtOiuzvP1WZT/LNI7GYeh
 Li0ffCPVv3ElP08G+n7Knx+S+6kVAF1/sXhyjAyZSz9PONcC807ywT5kHLBGpyHxTSzv
 Ez+R64QdFj2qkw4EGS7mMkpLZt2lkdIVSVwyJd8RGnhP1R3r0rsxvya4NOjrvCBWPxAd
 ZhuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8Y5iN3vI17iwcbVSNxU0gk0S1Oy604r2qVD5ZYqC0sw6/AjvtSDCyTuq7NDBI22AupfiFp0msgaZ1zFV68cp/sdmfLw==
X-Gm-Message-State: AOJu0YwdaB9dyvozeyHlMxp7d5L0GYkZ2z/vhJBZvrlJRMS67qJf5YEv
 SUes16DHYkEx1r+j6j9qK6t8PR81uUBIwWK8bFJfnoTG8JU5/Sl9MCZ/MRpQuIY=
X-Google-Smtp-Source: AGHT+IFB35F6NYRatrXHgOF5XxhF0Nc00TGAVuxIr9eUzC7qF9XoZkgFQI2nKyGP41K2NGMqaMeY6A==
X-Received: by 2002:adf:ebd1:0:b0:368:377a:e8bb with SMTP id
 ffacd0b85a97d-371c4bab756mr885011f8f.28.1724137690556; 
 Tue, 20 Aug 2024 00:08:10 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37189897419sm12312578f8f.82.2024.08.20.00.08.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 00:08:10 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Francis
 Laniel <francis.laniel@amarulasolutions.com>, Ion Agorria
 <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH 17/21] test: hush: Use UTF_CONSOLE in tests
In-Reply-To: <20240810205205.3403177-18-sjg@chromium.org>
References: <20240810205205.3403177-1-sjg@chromium.org>
 <20240810205205.3403177-18-sjg@chromium.org>
Date: Tue, 20 Aug 2024 09:08:09 +0200
Message-ID: <8734mzwu1y.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Simon,

Thank you for the patch.

On sam., ao=C3=BBt 10, 2024 at 14:52, Simon Glass <sjg@chromium.org> wrote:

> Set this flag rather than doing things manually in the test.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
>  test/hush/dollar.c | 10 +++-------
>  test/hush/loop.c   | 11 +++--------
>  2 files changed, 6 insertions(+), 15 deletions(-)
>
> diff --git a/test/hush/dollar.c b/test/hush/dollar.c
> index 4caa07c192a..91b097017c2 100644
> --- a/test/hush/dollar.c
> +++ b/test/hush/dollar.c
> @@ -14,7 +14,6 @@ DECLARE_GLOBAL_DATA_PTR;
>=20=20
>  static int hush_test_simple_dollar(struct unit_test_state *uts)
>  {
> -	console_record_reset_enable();
>  	ut_assertok(run_command("echo $dollar_foo", 0));
>  	ut_assert_nextline_empty();
>  	ut_assert_console_end();
> @@ -121,12 +120,11 @@ static int hush_test_simple_dollar(struct unit_test=
_state *uts)
>=20=20
>  	return 0;
>  }
> -HUSH_TEST(hush_test_simple_dollar, 0);
> +HUSH_TEST(hush_test_simple_dollar, UTF_CONSOLE);
>=20=20
>  static int hush_test_env_dollar(struct unit_test_state *uts)
>  {
>  	env_set("env_foo", "bar");
> -	console_record_reset_enable();
>=20=20
>  	ut_assertok(run_command("echo $env_foo", 0));
>  	ut_assert_nextline("bar");
> @@ -154,12 +152,10 @@ static int hush_test_env_dollar(struct unit_test_st=
ate *uts)
>=20=20
>  	return 0;
>  }
> -HUSH_TEST(hush_test_env_dollar, 0);
> +HUSH_TEST(hush_test_env_dollar, UTF_CONSOLE);
>=20=20
>  static int hush_test_command_dollar(struct unit_test_state *uts)
>  {
> -	console_record_reset_enable();
> -
>  	ut_assertok(run_command("dollar_bar=3D\"echo bar\"", 0));
>=20=20
>  	ut_assertok(run_command("$dollar_bar", 0));
> @@ -222,4 +218,4 @@ static int hush_test_command_dollar(struct unit_test_=
state *uts)
>=20=20
>  	return 0;
>  }
> -HUSH_TEST(hush_test_command_dollar, 0);
> +HUSH_TEST(hush_test_command_dollar, UTF_CONSOLE);
> diff --git a/test/hush/loop.c b/test/hush/loop.c
> index d734abf136d..a9b6a8edf24 100644
> --- a/test/hush/loop.c
> +++ b/test/hush/loop.c
> @@ -14,8 +14,6 @@ DECLARE_GLOBAL_DATA_PTR;
>=20=20
>  static int hush_test_for(struct unit_test_state *uts)
>  {
> -	console_record_reset_enable();
> -
>  	ut_assertok(run_command("for loop_i in foo bar quux quux; do echo $loop=
_i; done", 0));
>  	ut_assert_nextline("foo");
>  	ut_assert_nextline("bar");
> @@ -32,12 +30,10 @@ static int hush_test_for(struct unit_test_state *uts)
>=20=20
>  	return 0;
>  }
> -HUSH_TEST(hush_test_for, 0);
> +HUSH_TEST(hush_test_for, UTF_CONSOLE);
>=20=20
>  static int hush_test_while(struct unit_test_state *uts)
>  {
> -	console_record_reset_enable();
> -
>  	if (gd->flags & GD_FLG_HUSH_MODERN_PARSER) {
>  		/*
>  		 * Hush 2021 always returns 0 from while loop...
> @@ -65,11 +61,10 @@ static int hush_test_while(struct unit_test_state *ut=
s)
>=20=20
>  	return 0;
>  }
> -HUSH_TEST(hush_test_while, 0);
> +HUSH_TEST(hush_test_while, UTF_CONSOLE);
>=20=20
>  static int hush_test_until(struct unit_test_state *uts)
>  {
> -	console_record_reset_enable();
>  	env_set("loop_bar", "bar");
>=20=20
>  	/*
> @@ -87,4 +82,4 @@ static int hush_test_until(struct unit_test_state *uts)
>  	env_set("loop_bar", NULL);
>  	return 0;
>  }
> -HUSH_TEST(hush_test_until, 0);
> +HUSH_TEST(hush_test_until, UTF_CONSOLE);
> --=20
> 2.34.1
