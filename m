Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C488D1CDC5
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 09:16:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9168488F8A;
	Tue, 22 Oct 2024 11:15:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FIOjI/8c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14A7488D9C; Tue, 22 Oct 2024 11:15:58 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A7BB88EC9
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 11:15:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4315baec69eso49615335e9.2
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 02:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729588555; x=1730193355;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=vR/KF4f9v7tWnAiR/TTaw4iPQMvXjU/o8IHtrULEqfE=;
 b=FIOjI/8c9Z544ZXQ+IlqVMFgB3mGn786wtlQEY6jbE4EToA74QYMkEVQVvLYV7fLZo
 E+o957O5zT1swU5695NIG0ySkBVon/7mDpDIk3j3uPPCOKFFqmKpOx9+1K2c+lHkD/oI
 xY/sCmvRLzyGtybKTJj9KC2c1UgN1av42bPc4MgWY5FO3JgHZ2DRGg7+4myTQYpDYUdz
 yqhukQE8QPwlRCc6HfwDde5U2omyTU2gcuf1o7n3xu9zGxDd4sMblOKxUafR7EjcvXaF
 WjdR/UL6TYxGn/Fkfwdu7kbfUOohIEq3JGB8Ao/AC+edl3HCI+6NTq33cnXBHV4P17jB
 GVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729588555; x=1730193355;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vR/KF4f9v7tWnAiR/TTaw4iPQMvXjU/o8IHtrULEqfE=;
 b=JtfUzW7Ydq5T2oppfTMuVdODAHZca2epKYbOQ8SYt+xJRMDr6Y/i9L7Uqs7+V696D8
 JUcayQTAmKHMYnuxeEq6fnapGVIgw+U+sAzGTkOHPFdRBoy5okSaHNgMiHawd+g8JwKe
 UTo867a7+D8mOSkmaz48OCc1q9gZ1+qJXLoZL/55h+7Odqh84moGaRMv9/7oUXyA63gU
 keJnBMF8IHH2EtPBb0tqJa2jWLIT0gZqwcl/wBYSwznv0IIfMzsHSq49uIHwoMKZE8OB
 JFJyrg5Os/L6vFjbqnmryIQ8U55yHxhaMawig9bS9zUprmpikfNiWvmI5yqpAjisv5FU
 SftQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjGnlQaZrdnG1Uv3EuWU3zKXVX+a3XbiyGWGgTxIWE1H1jMBTtTNyeE8sWAKPlhC8vlyVpfNM=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7reGHbBZV/7A2upyTjYzziqDcos1M/56pkYHeUv0ccWAXZbjf
 Pe3IAU1nxMMHpyi4Qb/bDElSmisap5Ftv0v04XBbNaBOeqs1fyPILPv29KspsSE=
X-Google-Smtp-Source: AGHT+IHeWZ3WheA8KcAaKRWOwUDXDtGN6R3KXBhaJjF+s/k0rFI0XazI5sdGr56hfWGqTmG+1YqPlQ==
X-Received: by 2002:a05:600c:3b9b:b0:431:47d4:19c7 with SMTP id
 5b1f17b1804b1-43161634d95mr112273925e9.3.1729588555506; 
 Tue, 22 Oct 2024 02:15:55 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f57ba16sm83158495e9.11.2024.10.22.02.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 02:15:55 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 1/3] image: android: use ulong for kernel address
In-Reply-To: <20241017-topic-fastboot-fixes-mkbootimg-v2-1-c3927102d931@linaro.org>
References: <20241017-topic-fastboot-fixes-mkbootimg-v2-0-c3927102d931@linaro.org>
 <20241017-topic-fastboot-fixes-mkbootimg-v2-1-c3927102d931@linaro.org>
Date: Tue, 22 Oct 2024 11:15:52 +0200
Message-ID: <87ed48wl9z.fsf@baylibre.com>
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

Thank you for the patch.

On jeu., oct. 17, 2024 at 16:44, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> When booting with platforms having > 4GiB of memory,
> the kernel physical address can be more than 32bits.
>
> Use ulong like all the other addresses, and fix the
> print to show the > 32bits address numbers.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  boot/image-android.c    | 4 ++--
>  include/android_image.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/boot/image-android.c b/boot/image-android.c
> index e74dd498a305566e42aa235b45c22995e21ca64b..bb5f4f84487d40e0cf24dc3b57042993967e66d5 100644
> --- a/boot/image-android.c
> +++ b/boot/image-android.c
> @@ -256,7 +256,7 @@ int android_image_get_kernel(const void *hdr,
>  			     ulong *os_data, ulong *os_len)
>  {
>  	struct andr_image_data img_data = {0};
> -	u32 kernel_addr;
> +	ulong kernel_addr;
>  	const struct legacy_img_hdr *ihdr;
>  
>  	if (!android_image_get_data(hdr, vendor_boot_img, &img_data))
> @@ -275,7 +275,7 @@ int android_image_get_kernel(const void *hdr,
>  	if (strlen(andr_tmp_str))
>  		printf("Android's image name: %s\n", andr_tmp_str);
>  
> -	printf("Kernel load addr 0x%08x size %u KiB\n",
> +	printf("Kernel load addr 0x%08lx size %u KiB\n",
>  	       kernel_addr, DIV_ROUND_UP(img_data.kernel_size, 1024));
>  
>  	int len = 0;
> diff --git a/include/android_image.h b/include/android_image.h
> index d503c980b233bf31cd12a246ff1570544597a1c7..96820709b42830c7ce4cb753687da373936253a7 100644
> --- a/include/android_image.h
> +++ b/include/android_image.h
> @@ -348,7 +348,7 @@ struct andr_image_data {
>  	ulong bootconfig_addr;  /* bootconfig image address */
>  	ulong bootconfig_size;  /* bootconfig image size */
>  
> -	u32 kernel_addr;  /* physical load addr */
> +	ulong kernel_addr;  /* physical load addr */
>  	ulong ramdisk_addr;  /* physical load addr */
>  	ulong ramdisk_ptr;  /* ramdisk address */
>  	ulong dtb_load_addr;  /* physical load address for DTB image */
>
> -- 
> 2.34.1
