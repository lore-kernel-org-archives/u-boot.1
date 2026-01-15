Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B248D4114E
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 09:40:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2836836A3;
	Thu, 15 Jan 2026 10:40:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="imZHkx1b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34497836AC; Thu, 15 Jan 2026 10:40:29 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6019380077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 10:40:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id DC737601B4;
 Thu, 15 Jan 2026 09:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA6EC116D0;
 Thu, 15 Jan 2026 09:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768470024;
 bh=ZvzCfuzMopQJ16ZylmfkMm9/HmehfUGA+aZfXXeEJBc=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=imZHkx1b9vvMchboqwDjkZy1Yl1hscXwPY4KhOZp9s2HTCPC7HFJg0Vkybe1rYnVG
 GYSUA0tFw2WUIYAKdEFdbJ8TIOEWsOBG3A6jXYWesRL67KNGUOPF0XlYqWL3ybKyFb
 PEescGsDaZvr169hSbnAzcGVY66AG4dXQ9LfkcN7fWzwNgL/biS2yhfjUSEvwQb4bv
 lTVYqwNnxYqpAbomjZlo4uoMl4J49j4btfOMHpnDx0NFCv4Hj96wrqrJdkHAFUz21g
 +KkmnejX+5hcZSqqgz5t1ESrafS0uzHpE+8rGaJACmnnfFA517MiLlczBjLIHMI83T
 Lupe7ILFTf6Aw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>, Tom Rini
 <trini@konsulko.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Julien Masson <jmasson@baylibre.com>, Guillaume La Roque
 <glaroque@baylibre.com>, u-boot@lists.denx.de, Simon Glass
 <sjg@chromium.org>, Nicolas Belin <nbelin@baylibre.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Aaron Kling <webgeek1234@gmail.com>, George Chan <gchan9527@gmail.com>,
 Sam Day <me@samcday.com>, Maxime Fournier <mfournier@baylibre.com>, Eddie
 Kovsky <ekovsky@redhat.com>, Casey Connolly <casey.connolly@linaro.org>,
 Guillaume Ranquet <ranquet.guillaume@gmail.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Jerome Forissier <jerome@forissier.org>
Subject: Re: [PATCH v5 3/5] boot: android: Add bootconfig support
In-Reply-To: <20260112-bootconfig-v5-3-79b242159ac7@baylibre.com>
References: <20260112-bootconfig-v5-0-79b242159ac7@baylibre.com>
 <20260112-bootconfig-v5-3-79b242159ac7@baylibre.com>
Date: Thu, 15 Jan 2026 10:40:21 +0100
Message-ID: <87wm1jdxiy.fsf@kernel.org>
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

Hi Guillaume,

Thank you for the patch.

On Mon, Jan 12, 2026 at 11:55, "Guillaume La Roque (TI.com)" <glaroque@baylibre.com> wrote:

> For android vendor boot image version 4 bootconfig is mandatory.[1]
>
> In the android_image_get_ramdisk function, after copying both vendor and
> boot ramdisks, we extract all androidboot.* entries from the kernel
> command line. These entries are added to the bootconfig section.
> We then update the sizes of the ramdisk and bootconfig.
> Finally, all androidboot.* entries are removed from the kernel command
> line.
>
> [1] https://source.android.com/docs/core/architecture/partitions/vendor-boot-partitions#bootloader-support
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
> ---
>  boot/image-android.c | 174 +++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 163 insertions(+), 11 deletions(-)
>
> diff --git a/boot/image-android.c b/boot/image-android.c
> index b9e0b3f68b0..c4a0cb138eb 100644
> --- a/boot/image-android.c
> +++ b/boot/image-android.c
> @@ -505,6 +505,166 @@ ulong android_image_get_kcomp(const void *hdr,
>  		return image_decomp_type(p, sizeof(u32));
>  }
>  
> +/**
> + * android_boot_append_bootconfig() - Append bootconfig parameters to ramdisk
> + * @img_data: Pointer to Android image data
> + * @params: Pointer to boot config parameters to append
> + * @params_len: Length of boot config parameters
> + * @ramdisk_dest: Destination address for the merged ramdisk
> + *
> + * This function copies the vendor ramdisk, boot ramdisk, and bootconfig to
> + * the destination. It then appends the provided bootconfig parameters.
> + *
> + * Return: Bytes added to the bootconfig on success, negative on error.
> + */
> +static long android_boot_append_bootconfig(const struct andr_image_data *img_data,
> +					   char *params, long params_len,
> +					   void *ramdisk_dest)
> +{
> +	void *vendor_ramdisk_src;
> +	void *boot_ramdisk_src;
> +	void *bootconfig_src;
> +	long bytes_added = 0;
> +
> +	/* Map sources */
> +	vendor_ramdisk_src = map_sysmem(img_data->vendor_ramdisk_ptr,
> +					img_data->vendor_ramdisk_size);
> +	boot_ramdisk_src = map_sysmem(img_data->ramdisk_ptr,
> +				      img_data->boot_ramdisk_size);
> +
> +	/* Copy Vendor Ramdisk */
> +	memcpy(ramdisk_dest, vendor_ramdisk_src, img_data->vendor_ramdisk_size);
> +
> +	/* Copy Boot Ramdisk */
> +	memcpy((char *)ramdisk_dest + img_data->vendor_ramdisk_size,
> +	       boot_ramdisk_src, img_data->boot_ramdisk_size);
> +
> +	/* Copy Bootconfig and Append Params */
> +	if (img_data->bootconfig_size) {
> +		bootconfig_src = map_sysmem(img_data->bootconfig_addr,
> +					    img_data->bootconfig_size);
> +		memcpy((char *)ramdisk_dest + img_data->vendor_ramdisk_size +
> +		       img_data->boot_ramdisk_size,
> +		       bootconfig_src, img_data->bootconfig_size);
> +		unmap_sysmem(bootconfig_src);
> +
> +		if (params && params_len > 1) {
> +			void *bootconfig_ptr = (char *)ramdisk_dest +
> +					       img_data->vendor_ramdisk_size +
> +					       img_data->boot_ramdisk_size;
> +			bytes_added = add_bootconfig_parameters(params, params_len,
> +								(ulong)bootconfig_ptr,
> +								img_data->bootconfig_size);
> +		}
> +	}
> +
> +	unmap_sysmem(boot_ramdisk_src);
> +	unmap_sysmem(vendor_ramdisk_src);
> +
> +	if (bytes_added < 0)
> +		return bytes_added;
> +
> +	return bytes_added;
> +}
> +
> +/**
> + * android_image_set_bootconfig() - Extract androidboot.* args and append to bootconfig
> + * @hdr: Pointer to boot image header
> + * @vendor_boot_img: Pointer to vendor boot image header
> + * @ramdisk_addr: Destination address for the merged ramdisk
> + *
> + * Return: Size of the bootconfig section (including new params) on success, negative on error.
> + */
> +static long android_image_set_bootconfig(const void *hdr,
> +					 const void *vendor_boot_img,
> +					 ulong ramdisk_addr)
> +{
> +	const char *bootargs = env_get("bootargs");
> +	char *params = NULL;
> +	char *new_bootargs = NULL;
> +	long params_len = 0; /* Renamed from androidboot_params_len */

What is this comment for? Please drop it. It makes no sense to have a
comment about a variable name that was in a previous patch version.

> +	struct andr_image_data img_data;
> +	long ret;
> +	size_t len;
> +	const char *src;
> +	char *bc_dst;
> +	char *args_dst;
> +	ulong total_size;
> +	void *ramdisk_dest;
> +
> +	if (!android_image_get_data(hdr, vendor_boot_img, &img_data))
> +		return -EINVAL; /* Use errno */

same? Use errno? What does it mean?

If you agree that these comments are not useful, I can fix up while applying.

> +
> +	/* Extract androidboot.* parameters from bootargs */
