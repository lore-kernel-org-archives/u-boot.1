Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F43BC3ABB6
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 07:47:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D03B820EB;
	Wed,  7 May 2025 09:47:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cGCd6wip";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47B7182102; Wed,  7 May 2025 09:47:32 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DD6E8007D
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 09:47:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8FA6045205;
 Wed,  7 May 2025 07:47:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2389AC4CEE7;
 Wed,  7 May 2025 07:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746604047;
 bh=dN8roacBS+A/y/a70JW+9pYa7e3BlDDLBAFleeYBS/c=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=cGCd6wipGUnrSRmSwXEE0fdYnTUVnbIknGG9j1LBDieFEtfQ8o4sViT4X2srR5e4U
 A75l0V/k8v40+bwMH4pttfK92k5nOVBA6wP2WHI/DQUD82dVJV+4cmZRMkHxt+BhXp
 8D3gcVdCQm7ZCNc1oVtn4uwiNXGl7mrn6O40uMB2lMJ20K4R4AsboIXJ03hUzhl8g9
 R86c3MrDGrCdG4oQW2r5bIsn01RAKDwf2kUkF8weCNfBaesjrePwPA8Ng19MHe2FO8
 gFrfvIO3gO8nTvaWIJQEE33kXKk/F+UFHyTaKsZql7ZD14WfwIcSjYyXUblgRdwmYe
 qwyfT08tDAdkQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>, Tom
 Rini <trini@konsulko.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Simon Glass <sjg@chromium.org>, Casey Connolly
 <casey.connolly@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Rayagonda Kokatanur
 <rayagonda.kokatanur@broadcom.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, George Chan
 <gchan9527@gmail.com>
Subject: Re: [PATCH v2 1/5] boot/image-android: Workaround kernel/ramdisk
 invalid addr
In-Reply-To: <20250505-android-boot-v2-1-92dcb5bf59c8@gmail.com>
References: <20250505-android-boot-v2-0-92dcb5bf59c8@gmail.com>
 <20250505-android-boot-v2-1-92dcb5bf59c8@gmail.com>
Date: Wed, 07 May 2025 09:47:24 +0200
Message-ID: <87zffoamlv.fsf@kernel.org>
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
I really prefer this solution to the one proposed in v1.

I have tested this on Khadas VIM3 board (using khadas-vim3_android_defconfig)

I have a couple of small remarks below.

On lun., mai 05, 2025 at 17:17, George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org> wrote:

> From: George Chan <gchan9527@gmail.com>
>
> Some androidboot image have invalid kernel/ramdisk load addr,
> force to ignore those value and use loadaddr instead.

Can we please elaborate a bit more in the commit message?
We have not explained/justified why repacking a boot image with proper
kernel ramdisk/load addr is not possible.

Is the following an acceptable justification for you?
"""
Since it's not always possible to change the load addr by repacking
the boot.img (due to AVB signature mismatch/<or_another_justification>),
we need a way to use kernel_addr_r and ramdisk_addr_r.
"""

Feel free to reformulate the above.

>
> Suggested-by: Casey Connolly <casey.connolly@linaro.org>
> Signed-off-by: George Chan <gchan9527@gmail.com>
> ---
>  boot/Kconfig         | 6 ++++++
>  boot/image-android.c | 9 ++++++---
>  2 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index fb37d912bc9..4bdac384181 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -11,6 +11,12 @@ config ANDROID_BOOT_IMAGE
>  	  This enables support for booting images which use the Android
>  	  image format header.
>  
> +config ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
> +	bool "Android Boot Image ignore addr"
> +	default n
> +	help
> +	  This ignore kernel/ramdisk load addr specified in androidboot header.

Please add a bit more context here, checkpatch.pl reports issues:
$ ./scripts/checkpatch.pl --u-boot --git master..HEAD

WARNING: please write a paragraph that describes the config symbol fully
#27: FILE: boot/Kconfig:14:
+config ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR

> +
>  config TIMESTAMP
>  	bool "Show image date and time when displaying image information"
>  	default y if CMD_DATE
> diff --git a/boot/image-android.c b/boot/image-android.c
> index 1746b018900..7b8eb6a4f64 100644
> --- a/boot/image-android.c
> +++ b/boot/image-android.c
> @@ -268,7 +268,8 @@ static ulong android_image_get_kernel_addr(struct andr_image_data *img_data,
>  	 *
>  	 * Otherwise, we will return the actual value set by the user.
>  	 */
> -	if (img_data->kernel_addr  == ANDROID_IMAGE_DEFAULT_KERNEL_ADDR) {
> +	if (img_data->kernel_addr  == ANDROID_IMAGE_DEFAULT_KERNEL_ADDR ||
> +		IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR)) {

Please fix indentation, should be:

+	if (img_data->kernel_addr  == ANDROID_IMAGE_DEFAULT_KERNEL_ADDR ||
+	    IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR)) {

(checkpatch.pl reports this)

>  		if (comp == IH_COMP_NONE)
>  			return img_data->kernel_ptr;
>  		return env_get_ulong("kernel_addr_r", 16, 0);
> @@ -464,7 +465,8 @@ int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
>  	 */
>  	if (img_data.header_version > 2) {
>  		/* Ramdisk can't be used in-place, copy it to ramdisk_addr_r */
> -		if (img_data.ramdisk_addr == ANDROID_IMAGE_DEFAULT_RAMDISK_ADDR) {
> +		if (img_data.ramdisk_addr == ANDROID_IMAGE_DEFAULT_RAMDISK_ADDR ||
> +			(IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR))) {

Same here. Also, can we please drop the leading parenthesis (IS_ENABLED(
-> IS_ENABLED( to be consistent with the previous code change?

>  			ramdisk_ptr = env_get_ulong("ramdisk_addr_r", 16, 0);
>  			if (!ramdisk_ptr) {
>  				printf("Invalid ramdisk_addr_r to copy ramdisk into\n");
> @@ -488,7 +490,8 @@ int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
>  	} else {
>  		/* Ramdisk can be used in-place, use current ptr */
>  		if (img_data.ramdisk_addr == 0 ||
> -		    img_data.ramdisk_addr == ANDROID_IMAGE_DEFAULT_RAMDISK_ADDR) {
> +		    img_data.ramdisk_addr == ANDROID_IMAGE_DEFAULT_RAMDISK_ADDR ||
> +			(IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR))) {

Same here. Also, can we please drop the leading parenthesis (IS_ENABLED(
-> IS_ENABLED( to be consistent with the previous code change?

>  			*rd_data = img_data.ramdisk_ptr;
>  		} else {
>  			ramdisk_ptr = img_data.ramdisk_addr;
>
> -- 
> 2.43.0
