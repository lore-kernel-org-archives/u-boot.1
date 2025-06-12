Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE6AC71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 07:19:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BB7182A4B;
	Thu, 12 Jun 2025 09:19:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AYvOh77L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0670D82B70; Thu, 12 Jun 2025 09:19:17 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD7C1828A2
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 09:19:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 699A4629EA;
 Thu, 12 Jun 2025 07:19:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A510FC4CEEA;
 Thu, 12 Jun 2025 07:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1749712752;
 bh=mbw1m30Q3aclBrIkVz4nrgWk/6tQPFTen6pceXF4fL8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=AYvOh77LUVaxJa7XrlFfb575hTqxiXN1fxR79e5YTUKh/QyWBWywv3hOTlZFXzSyF
 XkPspniya6JjUWMkcnvb52KK2n4ngOD/HkT4wmOZwEslmBxKLC61E6SMezSPPV4+ZY
 bg2gqsuckKT1Bdf3YMhuJCQ9GWf+3yJrk59SnwhHVmmQWbmah8JG2cXkLQVp9pKoye
 pDOIkmSVM3AlSv2kmJ65+v986Xs7Tk0TMIPkX8PDu7uJtAtFAZOg2nbLuEnQwQaF6V
 0epk2HW368b2lofJ3A1K4As+i1eVX9DKpbFXuI9UtYUtje5DQ/bmiZflf+iXF2wzLJ
 6ajU4ikWZR1ZQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>, Tom
 Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg
 <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, gchan9527@gmail.com
Subject: Re: [PATCH v2 1/5] image-android: Prepend/postpend default bootargs
 value with given bootcmd
In-Reply-To: <20250607-sc7180-android-boot-v2-1-2df5d7f61124@gmail.com>
References: <20250607-sc7180-android-boot-v2-0-2df5d7f61124@gmail.com>
 <20250607-sc7180-android-boot-v2-1-2df5d7f61124@gmail.com>
Date: Thu, 12 Jun 2025 09:19:09 +0200
Message-ID: <87wm9ha0lu.fsf@kernel.org>
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

Hi George,

Thank you for the patch.

I have a couple of small remarks on wording/spelling but the code
change looks good already.

On Sat, Jun 07, 2025 at 13:24, George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org> wrote:

> From: George Chan <gchan9527@gmail.com>
>
> Control how default bootargs is prepended or postpended to boot param found
> from androidboot img.

Let's rephrase to be slightly more accurate, and add a problem statement
first:

By default, the boot.img's cmdline are appended to the bootargs
environment.
If we take a cmdline example of:
* androidboot.hardware=warm (in U-Boot environment)
* androidboot.hardware=chilly (in boot.img's cmdline)

The resulting commandline will be:
androidboot.hardware=warm [...] androidboot.hardware=chilly.

Because of this, the U-Boot environment always take priority on the
boot.img.

If we want to have a single U-Boot binary that support multiple
board variants, we can't override androidboot.hardware via the boot.img.

Add a new Kconfig option, ANDROID_BOOT_IMAGE_PREPEND_ENV_BOOTARGS that
reverse the logic.

with ANDROID_BOOT_IMAGE_PREPEND_ENV_BOOTARGS=y, the resulting
commandline would be:
androidboot.hardware=chilly [...] androidboot.hardware=warm.

(feel free to rephrase some parts to your liking)

>
> Signed-off-by: George Chan <gchan9527@gmail.com>
> ---
>  boot/Kconfig         |  7 +++++++
>  boot/image-android.c | 10 ++++++++--
>  2 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 30eb5b328d7..7b71a340620 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -11,6 +11,13 @@ config ANDROID_BOOT_IMAGE
>  	  This enables support for booting images which use the Android
>  	  image format header.
>  
> +config ANDROID_BOOT_IMAGE_PREPEND_ENV_BOOTARGS
> +	bool "Android Boot Image boot cmd param will prepend to env bootargs"
> +	help
> +	  This control how androidboot img with bootcmd param integrate with u-boot

Please, no abbreviations and some minor spelling tweaks:

This controls how Android boot image embedded cmdline integrates
with U-Boot bootargs environment.

By enabling this, the boot.img's cmdline is prepended to the bootargs
environment. By default, when disabled, the cmdline is appended.

(Note: We use cmdline here since that's the terminology used by
Android's mkbootimg tool [1])

[1] https://android.googlesource.com/platform/system/tools/mkbootimg/+/refs/heads/main/mkbootimg.py#511

With the wording fixed, please add

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

Also, Casey, feel free to pick of the reworded version through your tree !

> +	  env bootargs. By enable this, androidboot boot param will prepend to
> +	  head of bootargs env.
> +
>  config TIMESTAMP
>  	bool "Show image date and time when displaying image information"
>  	default y if CMD_DATE
> diff --git a/boot/image-android.c b/boot/image-android.c
> index 1746b018900..fbcd2682a5e 100644
> --- a/boot/image-android.c
> +++ b/boot/image-android.c
> @@ -347,14 +347,14 @@ int android_image_get_kernel(const void *hdr,
>  		len += strlen(img_data.kcmdline_extra) + (len ? 1 : 0); /* +1 for extra space */
>  	}
>  
> -	char *newbootargs = malloc(len + 1); /* +1 for the '\0' */
> +	char *newbootargs = malloc(len + 2); /* +2 for 2x '\0' */
>  	if (!newbootargs) {
>  		puts("Error: malloc in android_image_get_kernel failed!\n");
>  		return -ENOMEM;
>  	}
>  	*newbootargs = '\0'; /* set to Null in case no components below are present */
>  
> -	if (bootargs)
> +	if (bootargs && !IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE_PREPEND_ENV_BOOTARGS))
>  		strcpy(newbootargs, bootargs);
>  
>  	if (img_data.kcmdline && *img_data.kcmdline) {
> @@ -369,6 +369,12 @@ int android_image_get_kernel(const void *hdr,
>  		strcat(newbootargs, img_data.kcmdline_extra);
>  	}
>  
> +	if (bootargs && IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE_PREPEND_ENV_BOOTARGS)) {
> +		if (*newbootargs) /* If there is something in newbootargs, a space is needed */
> +			strcat(newbootargs, " ");
> +		strcat(newbootargs, bootargs);
> +	}
> +
>  	env_set("bootargs", newbootargs);
>  	free(newbootargs);
>  
>
> -- 
> 2.43.0
