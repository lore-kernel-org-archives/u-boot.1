Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5461C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 13:39:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DEDD8037B;
	Thu, 23 Jan 2025 14:39:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ecKDB8q/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76A1880214; Thu, 23 Jan 2025 14:39:14 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66FB780137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 14:39:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmasson@baylibre.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3862b40a6e0so651243f8f.0
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 05:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737639552; x=1738244352;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Fwq8ZtfIVSfnAk4EBYRA7O3op3Lw8/xISDwieo971rY=;
 b=ecKDB8q/sFDfAZLvQnCr9dS+pNeSrjsdQgRsrpEZjY2NJ2ZNt9z9z4Za3qZsstw/6O
 YyNhqJuRqjL3pq5ynT+r0VQYS7xk0UBRp2KSf2i9wP1LP7g223Rer6xr52sdLBYZFBHp
 h6Uzs3UMakt78f7CN1EWJ3lW3JdCBQ6Y2et20nIuSsQ5KMNOaVSqlOPiVULwsgr6vm2s
 BcBud7qO9S6wXc30g3GgZkSKRGquRd7rEOhytMH6PhkaksxXmtibxK4UMqN536xI3EZ7
 80cqorqZrlgk4TuK/CbhFrPN25HEx+2bzvngFOD2My3xs0HimMh8GAsf4XhVU5lJfLiI
 qJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737639552; x=1738244352;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fwq8ZtfIVSfnAk4EBYRA7O3op3Lw8/xISDwieo971rY=;
 b=RSOngXYL8NiP+MHPA/H5yEH5f8p4t0QQ6JRqysfPiPowtfHsmrUYR6WnovAZElMV4s
 wrdChI5JU2m5ddShGWY0O3SkZ8M/Xf6T+/4nmg1XhzmwZWxsTnnGICVh7YnQrURtJhkj
 JjbQ/+ztapoLtHqboOEV49KxDuiHvhEHmFPWSJHRRe0/h7NygqU5717Aj1XBPiCbT3Yu
 ZGDhbabSSBX2BIrENX3twZvArr9ECpYe6+8XFcaps8DnE6/oIlJXdHU6QCpCpbx4ZJEZ
 ye3whGrFJejyYeMvFpctYypbnO9wDGgq9GMiyGxEAh1Aqu8+FLEYFWQqJx1JB2EipqWx
 lpIQ==
X-Gm-Message-State: AOJu0YxasHWKtlu3j0vl1lfCuWPb8CDwT719e0DWNoBbhtCLZtn0RVnL
 rKCFKU1BpI9qvVdcuiXGrV/rFZeNnKzAzJpEEMd0gcOVv+CmdMhWrg2jjSWog28=
X-Gm-Gg: ASbGncvjj/1EtUo0xG3Vx3idHiclrWU8HPsT5JacBKl6aZle7T6geBrlu2y28UyzzVo
 v2JbM2a7Q1wVKhb1a6znU+1Ud8mAKRWJXbXCxyoydzU+Y/W2LQu3D6mDx0ywDTl1jzPJiUM7eG/
 mF0CovvFTpllg0AL+ALdiN4DVzf9ycI9AyTykAbxTU874hH2phL4Zz8CSnHXOJHGOEEjEWHesph
 qmSspYb79oaIOEADYKVnNrhkCQimBckhWGCt5WL4L8Zcm71SoNR5ghkDduMZx9W0pRKy5GCkU8g
 qMdjIagVUu98L7+SncydzkZGza5tAEFeh2O3eJvApmve
X-Google-Smtp-Source: AGHT+IGoKc1rP1L1MW9Z/ur2rkCgCGsC4Cg3z8BvGei4Kd+Qzy5jSjI0BYP/e0JXs4eEXxi5PWNJuw==
X-Received: by 2002:a5d:6481:0:b0:38c:246f:b0b3 with SMTP id
 ffacd0b85a97d-38c246fb2bcmr2987597f8f.51.1737639551684; 
 Thu, 23 Jan 2025 05:39:11 -0800 (PST)
Received: from localhost ([2a04:cec0:1900:d4b5:e910:e51a:5b57:1fb4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf3275755sm18948240f8f.80.2025.01.23.05.39.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 05:39:11 -0800 (PST)
From: Julien Masson <jmasson@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Guillaume La Roque
 <glaroque@baylibre.com>
Cc: <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: Re: [PATCH v2 1/2] bootstd: android: Add missing NULL in the avb
 partition list
In-Reply-To: <20250108-avb-disable-verif-v2-1-ba7d3b0d5b6a@baylibre.com>
References: <20250108-avb-disable-verif-v2-0-ba7d3b0d5b6a@baylibre.com>
Date: Thu, 23 Jan 2025 14:39:10 +0100
Message-ID: <874j1pd4zl.fsf@baylibre.com>
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


On Thu 23 Jan 2025 at 14:38, Mattijs Korpershoek <mkorpershoek@baylibre.com> wrote:

> When booting an Android build with AVB enabled, it's still possible to
> deactivate the check for development purposes if the bootloader state is
> UNLOCKED.
> 
> This is very useful for development and can be done at flashing time via:
> $ fastboot flash --disable-verity --disable-verification vbmeta vbmeta.img
> 
> However, with bootmeth_android, we cannot boot this way:
> 
>     Scanning bootdev 'mmc@fa10000.bootdev':
>       0  android      ready   mmc          0  mmc@fa10000.bootdev.whole
>     ** Booting bootflow 'mmc@fa10000.bootdev.whole' with android
>     avb_vbmeta_image.c:188: ERROR: Hash does not match!
>     avb_slot_verify.c:732: ERROR: vbmeta_a: Error verifying vbmeta image: HASH_MISMATCH
>     get_partition: can't find partition '_a'
>     avb_slot_verify.c:496: ERROR: _a: Error determining partition size.
>     Verification failed, reason: I/O error occurred while trying to load data
>     Boot failed (err=-5)
>     No more bootdevs
> 
> From the logs we can see that avb tries to read a partition named '_a'.
> It's doing so because the last element of requested_partitions implicitly is
> '\0', but the doc explicitly request it to be NULL instead.
> 
> Add NULL as last element to requested_partitions to avoid this problem.
> 
> Fixes: 125d9f3306ea ("bootstd: Add a bootmeth for Android")
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  boot/bootmeth_android.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
> index 19b1f2c377b9a51ff1683259085e1d636c939413..2cd167f80280801618a317a65e93a10e70a0d9ee 100644
> --- a/boot/bootmeth_android.c
> +++ b/boot/bootmeth_android.c
> @@ -380,7 +380,7 @@ static int run_avb_verification(struct bootflow *bflow)
>  {
>  	struct blk_desc *desc = dev_get_uclass_plat(bflow->blk);
>  	struct android_priv *priv = bflow->bootmeth_priv;
> -	const char * const requested_partitions[] = {"boot", "vendor_boot"};
> +	const char * const requested_partitions[] = {"boot", "vendor_boot", NULL};
>  	struct AvbOps *avb_ops;
>  	AvbSlotVerifyResult result;
>  	AvbSlotVerifyData *out_data;
> 
> -- 
> 2.47.1
> 

Reviewed-by: Julien Masson <jmasson@baylibre.com>
