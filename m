Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B83BC3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 17:32:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2392829A1;
	Thu, 10 Apr 2025 19:32:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="2RjI+VQF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3353E83B9D; Thu, 10 Apr 2025 18:43:01 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F3A883B4F
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 18:42:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-30db1bd3bebso9438061fa.2
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 09:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1744303378; x=1744908178;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9jucHuLZeJpPV6tRQwlYjarm+xAFNS/q3HG6xPcKyWE=;
 b=2RjI+VQFKp3xK7n1E3UI6/MVajV7jgLf0HbBFV2+9BHJFevgX/inRhWqLzX1g3Wlxn
 LdHNCSRwOPOEflZkTwvvnszLqyrloJ6IyHxP85+/XxL+hgohzfrLUUxDR5iAtdapMYEr
 46VmCx3Vqj7PSo9pKNVg7utogRVdw/HEi7pQguFZguea79qjQhkz4fedMP+b8IqbMPZb
 FWCWAuVZNgB155dnWt9uVMDVtWXMRrGcX5k1dIJnOQuBw6wMM1ox/OtZipdpu24rL1Nk
 xW1L41C+geBTPtW2nlpsvk47KfqI0AXw7AV3z7Vh6kaGcRB/q6fm7oVuEwjs0LlwIe3s
 ZU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744303378; x=1744908178;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9jucHuLZeJpPV6tRQwlYjarm+xAFNS/q3HG6xPcKyWE=;
 b=pCSTMSl0OKvP2DzCbemwBXpSVJ7LdbBVsoLJCp4fCeOqb2Wr3yMSpqMCo5pJwHWXpd
 OzZDnoyYorpLPFrJukm2G6777AoN3KQoiGJz9y6d4FcK9VN3uTEuj0KY50u59IbZRuke
 8ScqxMNTQFsB2CxUfTHFWWligOkE2bvO+2LvO+pbf2RbvaGdiO+S4L9L1GIm6buqtFgg
 7w805f+Swv4iv4t+4clN8Xu8nv98anxYQAzOfWcd3ML4UpS/DwvaaBTnQ97c/SVpdq4z
 ZCVCA8LiP57i7uGOGhdrY/zz+hTAn/vYAhkOIscfIT7nIpvUmcE9B6Ir2kag2ds4B1Wr
 jlZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUOVJ/2T/X4vIfO1L/9DaWgP8C07UCTTaMSYg9TOstj4poNSR9rIvuu7ToxoH96MG/CCE/ryI=@lists.denx.de
X-Gm-Message-State: AOJu0YxTh+3IQhzi3XzrE3bAHLs9j8xaZb2J+Aloai13U79GUKCtWZOH
 iUf37905weLTfBD8anyB7DZJt2JYpxAeFwBHXfQKOz3Rb8Y7BsBzh3X3xizDVfDyVJtiUkWSYZH
 tl3ypFoy93O6oJuEWC2q94407+ycAOJaELpLAmArEMW2xSqP4scQ=
X-Gm-Gg: ASbGncucYTiAtCOjJ+RpzockDLxSXUmyCbkiRpkySABpc59x8xFZkdFc5m0oxaM9frN
 syP/V+BQJ5E2ox5bMaPS9CQyabrtkEN+pqBacJJ4XMgQLujPfQCPWmEFCSaIxG3qbaO0L7Za/Hx
 BTgB+Be2Oeu0umOXSmqvWb1pQ=
X-Google-Smtp-Source: AGHT+IElmPW+2icLMkNd11wwmq8X2ixL7wTcTdwDyTbtiTYYZEeR6FB6bwbIMqxbKXX/LQkmN5GKjcXDbe5rnWPr0ho=
X-Received: by 2002:a05:651c:1594:b0:308:e54d:61b1 with SMTP id
 38308e7fff4ca-30faccc520emr14068491fa.34.1744303378143; Thu, 10 Apr 2025
 09:42:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250331191520.1805001-1-admin@hifiphile.com>
 <20250331191520.1805001-2-admin@hifiphile.com>
 <d7fc480b-a5cf-4fec-b9be-84c29e4d83ef@linaro.org>
In-Reply-To: <d7fc480b-a5cf-4fec-b9be-84c29e4d83ef@linaro.org>
From: Zixun LI <admin@hifiphile.com>
Date: Thu, 10 Apr 2025 18:42:47 +0200
X-Gm-Features: ATxdqUG3a8q1FEO4q3L-TUfhOypl0BWflx29rSk23n4atkibs1o6-pV-qJ4a1DM
Message-ID: <CA+GyqeZNaf194nXhCxvV6LPfB5jei5rvTNuwSg+Gg6pw50T3jA@mail.gmail.com>
Subject: Re: [PATCH 1/7] arm: at91: wdt: Remove unused at91_wdt struct
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 10 Apr 2025 19:32:45 +0200
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

On Thu, Apr 10, 2025 at 12:28=E2=80=AFPM Eugen Hristev <eugen.hristev@linar=
o.org> wrote:
>
> This breaks sama5d2_xplained_mmc_defconfig for example.
>
> In file included from arch/arm/mach-at91/spl.c:8:
> arch/arm/mach-at91/spl.c: In function =E2=80=98at91_disable_wdt=E2=80=99:
> arch/arm/mach-at91/spl.c:19:39: error: invalid use of undefined type
> =E2=80=98struct at91_wdt=E2=80=99
>    19 |         writel(AT91_WDT_MR_WDDIS, &wdt->mr);
>       |                                       ^~
> ./arch/arm/include/asm/io.h:31:69: note: in definition of macro
> =E2=80=98__arch_putl=E2=80=99
>    31 | #define __arch_putl(v,a)                (*(volatile unsigned int
> *)(a) =3D (v))
>       |
>    ^
> arch/arm/mach-at91/spl.c:19:9: note: in expansion of macro =E2=80=98write=
l=E2=80=99
>    19 |         writel(AT91_WDT_MR_WDDIS, &wdt->mr);
>       |         ^~~~~~
>

Thank you for the spot. I can add a patch like this:

 #if !defined(CONFIG_WDT_AT91)
 void at91_disable_wdt(void)
 {
-    struct at91_wdt *wdt =3D (struct at91_wdt *)ATMEL_BASE_WDT;
-
-    writel(AT91_WDT_MR_WDDIS, &wdt->mr);
+#if defined(CONFIG_SAM9X60)
+    writel(AT91_SAM9X60_MR_WDDIS, ATMEL_BASE_WDT + AT91_WDT_MR);
+#else
+    writel(AT91_WDT_MR_WDDIS, ATMEL_BASE_WDT + AT91_WDT_MR);
+#endif
 }
 #endif

Zixun
