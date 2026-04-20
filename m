Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D45FEA71B3
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 02:12:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB30C8429E;
	Mon, 20 Apr 2026 04:12:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="amL+iZJj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14708842C7; Mon, 20 Apr 2026 04:12:36 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BE9E842A4
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 04:12:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b9c3a9fe80fso312018766b.3
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 19:12:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776651154; cv=none;
 d=google.com; s=arc-20240605;
 b=Wm71SRz956fIrA4j5M27kzfF10FfLEVsZF9aTq/mEWxQp/oc9S//ZAT0aIXcw/L5vb
 9tLz8lNgeyDtjQSWYavaVUAE6LI+aPe5JUVj4EHd4sR6rEsg5hN6MbM+zaXUcjkiMjaZ
 /Pn82s7qG4G2A/1yNU3p+quByhDGW46BvygDohhNzsexqmsIciXETVEWP9Y6JyPOOi4G
 LtvPxJ4lEz7LE+1zgr0213Ag7yAfK9d4zA+XqEcw6Ishx2NSc13DHzav6hRYzelHFHhI
 p1ZMnyA1IQdVylD1jZ6N3iCan5fj1pJkiEUVUPsejUlAR1I7d83KzaUXkWI2Mnic3/+H
 zMmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=P7j+41nACDJbYHW7DcJYsdikCwjI8i03mUClhpDUJwU=;
 fh=MARMZ3uT2jMt3s6dMYOO4Y5Qg4zEZXBBhj48MXTVEAU=;
 b=O8pnWS4aqdt/rUqkTExxI3rSI6immtwJCD3BMVGwUFYO8+wG51WUbgSO/7WDcUU5iG
 C3dL7LxDGABxEl13w2eknRDv4qHq8RW88ROlepNckEjARqQc8IPMXJbKvXp9fmxMKxfB
 Qd79razylFXvhJkiArlW7B+WPGL0MaV+NwQ9IcZXVokBVXddDpyOREJE3+sXu0a7rnAf
 fP8hjOhdPpo8v2Wbni1r+vjr6fEj2/J4t/+6/z2iVi7n2RoKiinZIXKtoJHyOmNGuciF
 09SSYWwRxFaDvoxt33Ah/iyhur7ZhN7JJe0JaL4NnOGtGkd8BNLgLvyvMiW9JPaKcqDl
 1KOg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776651154; x=1777255954; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P7j+41nACDJbYHW7DcJYsdikCwjI8i03mUClhpDUJwU=;
 b=amL+iZJju1zvv15O4448UvU/+0SrhR/ZhvK/sf1SYhnLDHFSXhboxrCj7iGuPMvSmh
 jk2msevNHbADuFU5MpAuZzH0OPN4RsxjsQ+1rG/+IaVV2zLGrB/p7vOiQ8c3mctnYlAM
 ElTW9rwcpYvC/Pxh9V+q+xEtet+oHomAmlGGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776651154; x=1777255954;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P7j+41nACDJbYHW7DcJYsdikCwjI8i03mUClhpDUJwU=;
 b=MvodrdyvokBjoEaqynJw8YshZOEEW16Vr+8AacoVWdcSfU2dnvTPHf6yPA5l+yMPZH
 vp/5gFFHHcjuhte2UhDb5oR7olM1inbYIKDOeJSP5Wg8BdLNSow518ItkRehKMiYme4h
 jC6YztSmto3+yF8QOqXXr82gV16a0uhyOzO9l9k40Cbl8vO1QXOY0zLNFMgVEEZUsxAO
 sYLOxEZ75o7XdKNM3tlkREVGnBjFxGZRetnbaIHYADec8ggAZF2J//auuBkxmK10nQh9
 0VeINRZbv+fkyqV5q/SAsjQGp/at7inZUWVEzQvt+MOisRDTPQwwvAYlpvdhP7ghRpQW
 3Lbg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/GHqQkcxqSIy4SILsqcAAeCg6Kw5UFoCv0x8Hzyo8CgvBlDamJ/aQ9slrrnBELxtiCrTngE3Q=@lists.denx.de
X-Gm-Message-State: AOJu0YwRtIJAxe4KafRjkwCQasRPIB1hgNjU5XRaGh53AbKfgY+WblX+
 t+2F6sniO9VDY+TAnMMqX1gFfFW4Rtitvkq0FJFZRtAY3bo5qdtZSBlyTJpBPHMawSoQMb7RJ8f
 PAyaQeHKjw6s1dvQqtvDl4I+LjVApyUR+YJx1DhT/
X-Gm-Gg: AeBDietwKywE9uViCqIr9cemu+qRvIHAu0ReL2HD25h4G31a3jhneNlnt5wWhqNybRV
 MmbHs4hnMBNz7lU2D8Q/UupJPLnAan/4Z1v4xS9KfGn/G+xg26AvcuHhsEMfD9rqXixjOTUOzBS
 Joa9uZOERebQKrcJJGG4uAE5ETpw8coFRj3NLHgNBc5XZuiYhVum8sSsxXaHGH0m32CopaBWrkS
 cTlvDK72/LBkrLj1Y4eKx+e1sSC6fdGpxlQ5Si6pFQgW9s59MpfSX7EVKtVCyvzxs/rNh6PCcMA
 INKJzT+XoEcYWR3G6m3m
X-Received: by 2002:a17:906:9fcb:b0:ba6:42ee:75f1 with SMTP id
 a640c23a62f3a-ba642ee77b3mr225339566b.2.1776651153554; Sun, 19 Apr 2026
 19:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260417130204.49896-1-philippe.reynes@softathome.com>
 <20260417130204.49896-7-philippe.reynes@softathome.com>
In-Reply-To: <20260417130204.49896-7-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 14:11:58 +1200
X-Gm-Features: AQROBzC2vS-a0qWqUu-O39Pm-4b5BJv55DaS36MbPhr6eafjb9XdLNZ0f1dFJfE
Message-ID: <CAFLszTh_zZT1P3nxH_4NbGhkYA8ws0tc_nVbU-1OcNjGJV8fKQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/14] test: dm: ecdsa.c: clean this test as software
 ecdsa is now implemented
To: philippe.reynes@softathome.com
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com, 
 trini@konsulko.com, simon.glass@canonical.com, u-boot@lists.denx.de
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

Hi Philippe,

On 2026-04-17T13:02:04, Philippe Reynes <philippe.reynes@softathome.com> wrote:
> test: dm: ecdsa.c: clean this test as software ecdsa is now implemented
>
> The test ecdsa was done when ecdsa was only supported by hardware.
> So it wasn't possible to test ecdsa on sandbox, and there is a test
> to check that ecdsa is not supported on sandbox.
> Now, there is a software implementation of ecdsa. So we remove
> this outdated test.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>
> test/dm/ecdsa.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 94 insertions(+), 10 deletions(-)

> diff --git a/test/dm/ecdsa.c b/test/dm/ecdsa.c
> @@ -3,36 +3,120 @@
> +     struct image_sign_info info = {
> +             .checksum = image_get_checksum_algo(full_name),
> +             .crypto = image_get_crypto_algo(full_name),
> +             .fdt_blob = fdt,
> +     };

If the crypto algo name is invalid, info.crypto will be NULL - please
can you add ut_assertnonnull() checks for both checksum and crypto to
catch this earlier?

Regards,
Simon
