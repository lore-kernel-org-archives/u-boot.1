Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47ACFC5B552
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 09:15:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62C49830D9;
	Fri, 30 May 2025 11:15:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mJ3NCmX1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68E37830EA; Fri, 30 May 2025 11:15:23 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 385E1830AB
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 11:15:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 2C058A4BF68;
 Fri, 30 May 2025 09:15:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1ECC4CEE9;
 Fri, 30 May 2025 09:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1748596519;
 bh=utJiI4sJEhlpr5+RDpnj5AQemz4CSOvLTRR3sg3UKe0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=mJ3NCmX13eBxYud8vm84JwCWAwLBwR3WYVwk+8QSipT5lkdOZVoddq/FeWwJrQTu2
 op+He7WWF5HNIBPNR5obEU6FcN0TVtbcntlbI58nTM9CA/mb6gyS0Nrn8tOWvxIGyg
 1ToeDQ9tqdJ29vsnUaI+xVbIitrUsLhg2UzjnSWmqnDwHA8TsYQrV+/w/QDt7uSHHw
 aJdHQ6wy5QUZtQERV1s66onr1igRTudp7Uw+npkgG4GT8+b6Ap3d3GO53Y15EhgpZl
 yVPGLIwCriiqeiYeQ53RIafiHzPsmxIX7sQdItO+DwJXAIVN8hz2OIxAs1u68+sr3G
 Up5g1DwStppNA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Eddie Kovsky <ekovsky@redhat.com>, u-boot@lists.denx.de
Cc: Enric Balletbo i Serra <eballetbo@redhat.com>, Aaron Kling
 <webgeek1234@gmail.com>, Julien Masson <jmasson@baylibre.com>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nicolas Belin
 <nbelin@baylibre.com>, Roman Stratiienko <r.stratiienko@gmail.com>, Simon
 Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] image: android: fix ramdisk default address
In-Reply-To: <20250521212714.100357-1-ekovsky@redhat.com>
References: <20250521212714.100357-1-ekovsky@redhat.com>
Date: Fri, 30 May 2025 11:15:17 +0200
Message-ID: <87jz5ypihm.fsf@kernel.org>
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

Hi Eddie,

Thank you for the patch.

On mer., mai 21, 2025 at 15:26, Eddie Kovsky <ekovsky@redhat.com> wrote:

> Commit 21e7fa0e3ac5 ("image: android: handle ramdisk default address")
> changed the default behavior for header versions less than or equal to 2.
>
> The ramdisk address (img_data.ramdisk_ptr) is only assigned to *rd_data
> if the physical load address (img_data.ramdisk_addr) is equal to 0 or
> the Android default ramdisk address.
>
>     /* Ramdisk can be used in-place, use current ptr */
>     if (img_data.ramdisk_addr == 0 ||
>             img_data.ramdisk_addr == ANDROID_IMAGE_DEFAULT_RAMDISK_ADDR) {
>         *rd_data = img_data.ramdisk_ptr;
>     } else {
>         ramdisk_ptr = img_data.ramdisk_addr;
>         *rd_data = ramdisk_ptr;
>         memcpy((void *)(ramdisk_ptr), (void *)img_data.ramdisk_ptr,
>                 img_data.ramdisk_size);
>     }
>
> When the img_data.ramdisk_addr and the img_data.kernel_addr are the same
> *rd_data needs to be assigned to the ramdisk address (ramdisk_ptr), not
> the physical address (ramdisk_addr).
>
> As a result of the current behavior, we can no longer boot a kernel on
> the Renesas R-Car S4 board.
>
> Add an additional check to the if clause so that the ramdisk address is
> assigned when the kernel address and the ramdisk address are the same,
> restoring the previous default behavior.
>
> Fixes: 21e7fa0e3ac5 ("image: android: handle ramdisk default address")
> Signed-off-by: Eddie Kovsky <ekovsky@redhat.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

Boot tested on Khadas VIM3 using khadas-vim3_android_defconfig

Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org> # khadas vim3

> ---
>
>  boot/image-android.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/boot/image-android.c b/boot/image-android.c
> index 1746b0189008..459cdb8456c4 100644
> --- a/boot/image-android.c
> +++ b/boot/image-android.c
> @@ -488,7 +488,8 @@ int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
>  	} else {
>  		/* Ramdisk can be used in-place, use current ptr */
>  		if (img_data.ramdisk_addr == 0 ||
> -		    img_data.ramdisk_addr == ANDROID_IMAGE_DEFAULT_RAMDISK_ADDR) {
> +		    img_data.ramdisk_addr == ANDROID_IMAGE_DEFAULT_RAMDISK_ADDR ||
> +		    img_data.ramdisk_addr == img_data.kernel_addr) {
>  			*rd_data = img_data.ramdisk_ptr;
>  		} else {
>  			ramdisk_ptr = img_data.ramdisk_addr;
> -- 
> 2.49.0
