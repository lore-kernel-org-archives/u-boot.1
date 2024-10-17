Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8064AD2127F
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 11:33:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1380688FA4;
	Thu, 17 Oct 2024 13:33:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0TonqJTL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87C4488E5C; Thu, 17 Oct 2024 13:33:31 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B9B688FA4
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 13:33:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-37d70df0b1aso602982f8f.3
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 04:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729164807; x=1729769607;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=6OEyupfarSrxo8Lq88Qf8u5ahPuN91TyQ1cZGek1oOI=;
 b=0TonqJTLvfjIAgWHj5IUfVTy9H4CuAiFxTngK0bcng5UAFVdja52KL+tOOmSodAykV
 469yZEcopZzyvCW/cLOyz82F9YOmjOSybZY+q+LafjOU1tHlyXhfqIcNHhDTn2t6taNi
 4M8zfGC0M0LIwaIQ1LmZvxM6WpdA5KRc44e2iM6bgBpgr3QcDnuNlcTzFw8NFvLyaKtY
 rpGY4ZlCVyZGVvy/fAN5P6kneOaaVhsXCLTNGO9533qNLBx2w7NHh5fxXSJvAWJWOkif
 SXqTyND62nT4h2HsyXfRRZbArbcfPkGqQ6+35GX0gaEJqqjfOTLFlZWTpmrTwH5uhM9+
 uTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729164807; x=1729769607;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6OEyupfarSrxo8Lq88Qf8u5ahPuN91TyQ1cZGek1oOI=;
 b=NzuiBryzqMiXuS067XxUNuhhALb+sWMP4cJ/BuccoiHa8YRP8SwEfBW533zThZ/klP
 BzSfhnTVlt1Vf4iCqlZhxJo3OADFSryzJiE4oNISZNqJV+syov/WZbYNhx1Y1umvGreK
 +v5YO7QTs7/4y/zpt05Ce8nlxvlsKFj+Zfkcmnn9o6ET74pHTtb+oO+15uPxIE+z0LiY
 2EovWXGERd2fnR/O1kKzmQ2sKd0Dhi5kFRtoel8FlFBF4k6ifZYxP32klEMCxWyT71tJ
 Qw5UP9RLP1PKh3j37izrDpM1W4jc0R0A92DH4b/LwSDJ1g40cN0Bj6JZp9mVcVmbHsaj
 NWtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSPVYKN6jNchLtDcbhNTSH12NHNwO1/JMMt0DmvIn/mppHF1xNZ/VsrsMn0kMtWHwibiUfUxA=@lists.denx.de
X-Gm-Message-State: AOJu0YyGpFUAs0SIoHrJ9vnixbAXMw1PnGsEdZ4gXekk0hDLOch7SlCs
 LUxanFMsFVVUEggrMGD2NXxGC5hRC/8xT8c0t/U7oiO24Dl5VJZpWX00blfq504=
X-Google-Smtp-Source: AGHT+IHKSM1ZxUGsXxph1aoSiTe2Cg7qtmKTJvzSqQJXCT0O7CbgXwqHoUpLFizfkCblwkdDdkoa5A==
X-Received: by 2002:adf:f38b:0:b0:37d:45f0:dd08 with SMTP id
 ffacd0b85a97d-37d86bb78e9mr4549545f8f.11.1729164806798; 
 Thu, 17 Oct 2024 04:33:26 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa87c70sm7033765f8f.30.2024.10.17.04.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 04:33:26 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/3] image: android: misc fixes when using on Qualcomm
 platforms
In-Reply-To: <20241016-topic-fastboot-fixes-mkbootimg-v1-0-94fd9340722b@linaro.org>
References: <20241016-topic-fastboot-fixes-mkbootimg-v1-0-94fd9340722b@linaro.org>
Date: Thu, 17 Oct 2024 13:33:23 +0200
Message-ID: <87ed4f2ccc.fsf@baylibre.com>
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

Hi Neil,

Thank you for the series.

On mer., oct. 16, 2024 at 17:46, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> When trying to use the Android boot image with header version 2
> on recent Qualcomm platforms, we get into some troubles.
>
> First the kernel in-place address can be > 32bit, then since
> we use the Android mkbootimg, it uses the default load address
> which isn't big enough to uncompress the kernel.
>
> Finally, the ramdisk also uses a default load address, and
> it should be taken in account like for the kernel address.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Neil Armstrong (3):
>       image: android: use ulong for kernel address
>       boot: image-android: do not boot XIP when kernel is compressed
>       image: android: handle ramdisk default address

I have boot tested aosp/main on Khadas VIM3 using
khadas_vim3_android_defconfig

This ensures that boot image v2 still works.

I also tried to boot test the Beagle Play board (which runs Android 14
with boot image v4).

Unfortunetly, that does not boot. The kernel starts but then I see:

[    0.434360][    T1] /dev/root: Can't open blockdev
[    0.439587][    T1] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)

Full boot logs:
https://paste.debian.net/1332547/

Full boot logs on master:
https://paste.debian.net/1332548/

It seems that somehow, the bootconfig section is no longer present.

I'll try to identify the offending patch and help debug this.

>
>  boot/image-android.c    | 60 +++++++++++++++++++++++++++++++++++++------------
>  include/android_image.h |  2 +-
>  2 files changed, 47 insertions(+), 15 deletions(-)
> ---
> base-commit: d5cab0d6adc26ec1bbd45c2fed101184d04454ae
> change-id: 20241016-topic-fastboot-fixes-mkbootimg-8d73ab93db3d
>
> Best regards,
> -- 
> Neil Armstrong <neil.armstrong@linaro.org>
