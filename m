Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 879E2CCF9F8
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 09:04:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9834F839D5;
	Sat,  1 Nov 2025 10:04:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HSfszq3V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 557EA839DF; Sat,  1 Nov 2025 10:04:06 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF576839B9
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 10:04:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b3e9d633b78so747844266b.1
 for <u-boot@lists.denx.de>; Sat, 01 Nov 2025 02:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1761987843; x=1762592643; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hCyPh9kZ4kfZm0ZB6XV3NuyTSnnLQcYFxW4YUMPJb1g=;
 b=HSfszq3VOBcWxURxUCpUQe8qcbtYVMaUS9PIZHi10TDsrzgAUkyBmg+GAe2czshxg9
 X0z2muUnXSHh4oHKp1yC1cSXfckTusLl/RC5VMYCFA2cb+SRHJcLILSpnH4fX3npv0SN
 vwTm821XvictGfu/v1p8SOm8xMFQVO/lip13s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761987843; x=1762592643;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hCyPh9kZ4kfZm0ZB6XV3NuyTSnnLQcYFxW4YUMPJb1g=;
 b=Ht+Fn2bNrX8ZFjGsijrFKD766dUFCwla42Gvovh+7UHzIyYvHICqRQXteg9pc4J1JB
 A1xohI41fGXNJN4TDB+PsH6hCk2JxQcDm7tqOYIrTjVSYohvuwzprs3+miHJmXb9tY+F
 V3xSAKQVU/Vy+GIYAZwbGcZUpZn9wKLrTqHz5ILpdsy6A9yKKocIOu4vUUA5i1tm6I2d
 v+EXPFyGNGgt5f5ZihSJSPOnJ8cKfvVd6gvfzAkv8tKIaEZMZmq9HelVVmTv0tu8NJzg
 EMZgewK5zpYmHkJk+ix4b/xEadiM86R1jHtLtVDp/Fv/MAW9qzb7U/3smyUCs4UaEnvM
 YvHQ==
X-Gm-Message-State: AOJu0YziTuNEsR2MAVJCR4rBlf7DIdpK0fQTNsxM0NEy3C2j3dpKbc+t
 wkDtYYlnyFOc0VVtT9JBaWZScOkZ6m43VfnBzMlDB6I9zletPiZg9mjqtz/wicShB2718fiPlmi
 EhPYCQG8KPHEL72GTO0T0e+g4yJSBHJFUQl9SuJiq
X-Gm-Gg: ASbGnct+b+13KSkaeHEDi6zXwgz5RHX3ATIcT3KaKNFV8ejhyIP7Z08L+g6frq69zhr
 mfPxD6RFOh/hgdeMLK4r9ULOdHT1bHTmhvpVgPfJjJejUnz6LOBO/orRThNgk6Reil2u/jjEzvO
 YAKhX9AhgPEO0WbSSS+nTuDYP951TOzZMPgUXRfnDkZfiUxWKHOVV1ZcldONaqlD8G7phv1Q0T8
 SujTwGjDm/Zvu49H3VJRllzNoOCRlIZ/E6o1M8WlbAk051lNc2ZV2ZghL4FKVYtMVafm58=
X-Google-Smtp-Source: AGHT+IHDTARzgLEri5rAXsHBma7lWlvt3modrRtoWGVaxvmkv8GPkXOJ996XhCovNUnshVuHlij56sq84rSEZ/WyL3Q=
X-Received: by 2002:a17:906:7947:b0:b6d:545e:44f6 with SMTP id
 a640c23a62f3a-b7051f630abmr1203563866b.12.1761987843469; Sat, 01 Nov 2025
 02:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <20251029-arch-rockchip-imply-v1-1-899e1592a736@cherry.de>
In-Reply-To: <20251029-arch-rockchip-imply-v1-1-899e1592a736@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 1 Nov 2025 10:03:50 +0100
X-Gm-Features: AWmQ_bkGUYF_qLvPgJB6-8LlRvwiklyTExZqCEUT9gEHU1btz28LSN2g3S5qgOs
Message-ID: <CAFLszTgDgDat6KK_J9uFvbWybJ9ivC4ffk1twT=RmZqofv1WHw@mail.gmail.com>
Subject: Re: [PATCH] rockchip: imply most symbols for ARCH_ROCKCHIP
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Liya Huang <1425075683@qq.com>, Quentin Schulz <quentin.schulz@cherry.de>
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

On Wed, 29 Oct 2025 at 12:34, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> Forcing all those symbols on means we cannot make the binary smaller or
> with unnecessary features or drivers disabled. This is especially useful
> for security, auditing and certification where less code built means
> less to look at (and less surface attack) and less to patch, but also
> for making binary images smaller which typically means faster boot.
>
> It is possible to have boards without MMC, NAND or SPI flashes, without
> anything on SPI or I2C buses, nothing to control over PWM or GPIO or for
> which we have no interest in regulator control or serial output so make
> it possible to remove all that if desired.
>
> No intended change in default selected symbols.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  arch/arm/Kconfig | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

I'm a fan of 'imply'
