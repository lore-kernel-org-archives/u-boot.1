Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0670DD2A53A
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 11:58:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6491088C60;
	Thu, 17 Oct 2024 13:58:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YswZroC2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F22D088F57; Thu, 17 Oct 2024 13:58:16 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D6EF88B8F
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 13:58:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43152b79d25so8715155e9.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 04:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729166292; x=1729771092;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=5kPxk/rf9H4EyCzYqtz4ZVvdvCvvaH8nghW+vxc2oUc=;
 b=YswZroC2x5l0m5qvv16niYd3ra3RAM8MMtp9c6Wt2FGztYF0aPeMya7DGDaTQlmJ+1
 GqKeigWWVJeuWbQKEqvi2GnYscnScRYFbKmeX4tpUCLTK+MRmqzaAr5hlpZTwHtI18Z3
 h4gKINiPzVN35at3ZYudTh32hLsekkJvpKLqA8K7JfYhOa4sss/g44CovJd+KVUvTrzQ
 YyySDxYoCkcc9yVHndlPpFJv2jbRMqIjI4DqOQhVmMREyvH1mHhZx2yJ8irjagAz0XWM
 5fzX9NYEZSlxr8yybvmDZMU6eh/4qi9prMalc9pqP4UAsIfhOgWgFPClZJiyaV60o2gv
 sYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729166292; x=1729771092;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5kPxk/rf9H4EyCzYqtz4ZVvdvCvvaH8nghW+vxc2oUc=;
 b=OAiTUOKYb+rw5sCbh5lKs7ePiN6jX5FhmDj/8zfmbw7CNWiWNFbcnOaSlymeDCrMfD
 HKidswkVUhHzlyIXXZeeLyBSb4GCADBJqAv2c+XIxrtbSUhmy4ibUa7ogXR15B7kWgzT
 pp47n0PtuGt6PFLVCg1qlVeVRthEjQssHftlYFcEMLqC1o+SwNAiuTKsXCsCSBrBy7l+
 il0TliHDj/EgBQsOrHKaTRRLYHd4IJuDsLgfOS2TNX7cw+8+0U2C6NOwq7J1CIQ13D7l
 WZhCR6ekqqCoesjqXRa5v4Y7VbYY3TW7ClVKmY37SbdSd85mHEE649TdgsG9Dgnt98tw
 2QNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWkUN6vH9o9MWZQuM9UiRxvgZGi9sBQv+NYKvcFKZM7keWKDEgN+bqG2lzMvbpgFWc1cG+CN0=@lists.denx.de
X-Gm-Message-State: AOJu0YxId/dhV8llsV+/ReUNKGmPIKltcHBrf/OvH10Ws7kssVFrooii
 TDTvbxxWGGFWqv2GiwkjsOC5ABQ2iwhAGz85U5lP4COQR1omHlmXO4K4HXfFQzM=
X-Google-Smtp-Source: AGHT+IF7hqVQU8f7zq5bMtEiAYwghm/QLqz124Dq3sndfazpQ8sEYgMz2fPBWj0+1MbR30ZgQNjx5Q==
X-Received: by 2002:a05:600c:34d3:b0:431:58b3:affa with SMTP id
 5b1f17b1804b1-43158b3b0a0mr20123965e9.9.1729166291986; 
 Thu, 17 Oct 2024 04:58:11 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43158c40228sm24001205e9.21.2024.10.17.04.58.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 04:58:11 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/3] image: android: misc fixes when using on Qualcomm
 platforms
In-Reply-To: <87ed4f2ccc.fsf@baylibre.com>
References: <20241016-topic-fastboot-fixes-mkbootimg-v1-0-94fd9340722b@linaro.org>
 <87ed4f2ccc.fsf@baylibre.com>
Date: Thu, 17 Oct 2024 13:58:09 +0200
Message-ID: <871q0f2b72.fsf@baylibre.com>
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

On jeu., oct. 17, 2024 at 13:33, Mattijs Korpershoek <mkorpershoek@baylibre.com> wrote:

> Hi Neil,
>
> Thank you for the series.
>
> On mer., oct. 16, 2024 at 17:46, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
>> When trying to use the Android boot image with header version 2
>> on recent Qualcomm platforms, we get into some troubles.
>>
>> First the kernel in-place address can be > 32bit, then since
>> we use the Android mkbootimg, it uses the default load address
>> which isn't big enough to uncompress the kernel.
>>
>> Finally, the ramdisk also uses a default load address, and
>> it should be taken in account like for the kernel address.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>> Neil Armstrong (3):
>>       image: android: use ulong for kernel address
>>       boot: image-android: do not boot XIP when kernel is compressed
>>       image: android: handle ramdisk default address
>
> I have boot tested aosp/main on Khadas VIM3 using
> khadas_vim3_android_defconfig
>
> This ensures that boot image v2 still works.
>
> I also tried to boot test the Beagle Play board (which runs Android 14
> with boot image v4).
>
> Unfortunetly, that does not boot. The kernel starts but then I see:
>
> [    0.434360][    T1] /dev/root: Can't open blockdev
> [    0.439587][    T1] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
>
> Full boot logs:
> https://paste.debian.net/1332547/
>
> Full boot logs on master:
> https://paste.debian.net/1332548/
>
> It seems that somehow, the bootconfig section is no longer present.
>
> I'll try to identify the offending patch and help debug this.

Offending patch is
  [PATCH 3/3] image: android: handle ramdisk default address

The following (invalid) diff "fixes it"

modified   boot/image-android.c
@@ -448,9 +448,9 @@ int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
 	}
 
 	printf("RAM disk load addr 0x%08lx size %u KiB\n",
-	       ramdisk_ptr, DIV_ROUND_UP(img_data.ramdisk_size, 1024));
+	       img_data.ramdisk_addr, DIV_ROUND_UP(img_data.ramdisk_size, 1024));
 
-	*rd_data = ramdisk_ptr;
+	*rd_data = img_data.ramdisk_addr;
 
 	*rd_len = img_data.ramdisk_size;
 	return 0;

I'll debug a bit more.

>
>>
>>  boot/image-android.c    | 60 +++++++++++++++++++++++++++++++++++++------------
>>  include/android_image.h |  2 +-
>>  2 files changed, 47 insertions(+), 15 deletions(-)
>> ---
>> base-commit: d5cab0d6adc26ec1bbd45c2fed101184d04454ae
>> change-id: 20241016-topic-fastboot-fixes-mkbootimg-8d73ab93db3d
>>
>> Best regards,
>> -- 
>> Neil Armstrong <neil.armstrong@linaro.org>
