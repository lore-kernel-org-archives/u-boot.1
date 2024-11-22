Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28112E65D3F
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 10:17:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44B37897E2;
	Fri, 22 Nov 2024 11:17:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3XYYE0oY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D78B2897E1; Fri, 22 Nov 2024 11:17:35 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 935A589117
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 11:17:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4315eac969aso10616545e9.1
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 02:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732270653; x=1732875453;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=qAtPqhxrD026mCcFjpbPDYbU3W/H+4QwBcMOuQxJCLU=;
 b=3XYYE0oYk1SL/hWBxtaqTscYhpn9NOl4/jl9VpTaqymSVlMH9yWEyXfNDQjnO+vFsq
 2C+dUQ4CrJ7iVCVdArqsiFqDAsMWueofAWQV9P/cHFMRsTjea22GVKPJRAUuNwOWfPq7
 tmWZ1UjTj9UKghXbPY++RP7MHSOVmz8pknmUmCYspoT89ReNtfCfI1RSDfv9m0QOutgl
 ZiY7wJQ7dpkLPmqsth3EShPNbxhvlfI6vOB0n+/CcrPSgubXoB5ACaLxK8cD4b6Agscg
 NVbVnDcqueFaGPWTZlggun/bwXiJWVcIlYOMQ9yj8IhBKjLKQE8Bar+5W6baC7GhOXQ1
 /hfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732270653; x=1732875453;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qAtPqhxrD026mCcFjpbPDYbU3W/H+4QwBcMOuQxJCLU=;
 b=NR1Hr1+/LnieRrQs/aDB1YGnovRQMMlO0iJhFiyD9Uo2UvxUXLWlZGM0fuwqzkvuJQ
 xD7F9Nh3UWAx/mjC1Gr43l30ptE2VNlX+1j/hifgY54DRIQ0Y6EdgrzSQ5lPEXKhf4m2
 Wdm13zt1uJQ+HjAsAezq61eO7Rnr867nE2LTOyDpohEQTLWllFeJK6NIQDUZIt3/i3fK
 J3cnwFGu7K80ge0mkz+FVur5yJnSOTZl/K/CE5eLacyxJKHOSwET799lEMOwLBqtgX6w
 2PfGG/acpg7/L16wPPMe5Dhq7+Od6piMsmn/8wndF1M/XMSFzhFQ4tNd13GCMdHPLzFX
 jvDg==
X-Gm-Message-State: AOJu0YxySnsexSd73UdmZxIlayMSnNGLZJ104yM70l5bl0LjvN9E0aUz
 fEhW5pbMiNSIOyYg3iwOlhmAE8o0FrO1lBVCTl0KdHsFlKhNoN/l2stsat9t/vA=
X-Gm-Gg: ASbGnct2cARnFX+yHyUynMRQL6xI5MRJHkm+XS3aLeZVDU51eN+i8abS5FkQa0wg4GM
 U+LiAOtQuvGW+zaL2p9vdM7uAoOuwDPnb5N3Y1BzRm2z6BYqw2GD9GHHHw9mE6+NPT8ex1sZ7KH
 d2AemXRgReivgDtazEBBgofmSY24GgS1LnMQJa5o/hXbAzWzpFiFIzpPp/ErNKdKUhuCE/cVfqS
 GeDqGBMA4ZQSw+/+O9+gQ3nUv9m0eBUmm26nZhj+51XdHfykeWkLFc28JE=
X-Google-Smtp-Source: AGHT+IHXyxoZuiGJNQECEK9qo6McaUCkeASvF/e4A0Pr4GVAxxQzj9W4omPtNACRV2Pg528aKDYaOw==
X-Received: by 2002:a05:600c:1e88:b0:431:5226:1633 with SMTP id
 5b1f17b1804b1-433cda11055mr20774105e9.6.1732270652813; 
 Fri, 22 Nov 2024 02:17:32 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b46430f1sm85716655e9.43.2024.11.22.02.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2024 02:17:32 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Julien Masson <jmasson@baylibre.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Julien Masson <jmasson@baylibre.com>
Subject: Re: [PATCH] bootstd: android: don't read whole partition sizes
In-Reply-To: <20241121-bootmeth-android-part-sizes-v1-1-25760bbd0f08@baylibre.com>
References: <20241121-bootmeth-android-part-sizes-v1-1-25760bbd0f08@baylibre.com>
Date: Fri, 22 Nov 2024 11:17:31 +0100
Message-ID: <875xofd138.fsf@baylibre.com>
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

Hi Julien,

Thank you for the patch.

On jeu., nov. 21, 2024 at 11:59, Julien Masson <jmasson@baylibre.com> wrote:

> The current implementation is reading the whole partition for boot and
> vendor_boot image which can be long following the size of the
> partition or the time to read blocks (driver/SoC specific).
>
> For example with mediatek mt8365 EVK board, we have a 64MiB boot
> partition and the boot image flashed in this partition is only 42MiB.
> It takes ~8-9 secs to read the boot partition.
>
> Instead we can retrieved the boot image and vendor boot image size
> with these new functions:
> - android_image_get_bootimg_size
> - android_image_get_vendor_bootimg_size
> Use these information and read only the necessary.
>
> By doing this with mt8365 EVK board, we read boot image in ~5 secs.
>
> Signed-off-by: Julien Masson <jmasson@baylibre.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> Changes have been tested with:
> $ ./test/py/test.py --bd sandbox --build -k ut_bootstd_bootflow_android_image_v4
> $ ./test/py/test.py --bd sandbox --build -k ut_bootstd_bootflow_android_image_v2
> ---
>  boot/bootmeth_android.c | 28 +++++++++++++++++++++++-----
>  boot/image-android.c    | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  include/image.h         | 24 ++++++++++++++++++++++++
>  3 files changed, 92 insertions(+), 5 deletions(-)
>
> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
> index 2aac32331d3c28853bc87d05a8c76ae868ea97c7..3a5144aaa3b0125cf13ff1805b05e87385263308 100644
> --- a/boot/bootmeth_android.c
> +++ b/boot/bootmeth_android.c
> @@ -45,6 +45,8 @@ struct android_priv {
>  	enum android_boot_mode boot_mode;
>  	char *slot;
>  	u32 header_version;
> +	u32 boot_img_size;
> +	u32 vendor_boot_img_size;
>  };
>  
>  static int android_check(struct udevice *dev, struct bootflow_iter *iter)
> @@ -98,7 +100,13 @@ static int scan_boot_part(struct udevice *blk, struct android_priv *priv)
>  		return log_msg_ret("header", -ENOENT);
>  	}
>  
> +	if (!android_image_get_bootimg_size(buf, &priv->boot_img_size)) {
> +		free(buf);
> +		return log_msg_ret("get bootimg size", -EINVAL);
> +	}
> +
>  	priv->header_version = ((struct andr_boot_img_hdr_v0 *)buf)->header_version;
> +
>  	free(buf);
>  
>  	return 0;
> @@ -138,6 +146,12 @@ static int scan_vendor_boot_part(struct udevice *blk, struct android_priv *priv)
>  		free(buf);
>  		return log_msg_ret("header", -ENOENT);
>  	}
> +
> +	if (!android_image_get_vendor_bootimg_size(buf, &priv->vendor_boot_img_size)) {
> +		free(buf);
> +		return log_msg_ret("get vendor bootimg size", -EINVAL);
> +	}
> +
>  	free(buf);
>  
>  	return 0;
> @@ -330,15 +344,17 @@ static int android_read_file(struct udevice *dev, struct bootflow *bflow,
>   * @blk: Block device to read
>   * @name: Partition name to read
>   * @slot: Nul-terminated slot suffixed to partition name ("a\0" or "b\0")
> + * @image_size: Image size in bytes used when reading the partition
>   * @addr: Address where the partition content is loaded into
>   * Return: 0 if OK, negative errno on failure.
>   */
>  static int read_slotted_partition(struct blk_desc *desc, const char *const name,
> -				  const char slot[2], ulong addr)
> +				  const char slot[2], ulong image_size, ulong addr)
>  {
>  	struct disk_partition partition;
>  	char partname[PART_NAME_LEN];
>  	size_t partname_len;
> +	ulong num_blks = DIV_ROUND_UP(image_size, desc->blksz);
>  	int ret;
>  	u32 n;
>  
> @@ -364,8 +380,8 @@ static int read_slotted_partition(struct blk_desc *desc, const char *const name,
>  	if (ret < 0)
>  		return log_msg_ret("part", ret);
>  
> -	n = blk_dread(desc, partition.start, partition.size, map_sysmem(addr, 0));
> -	if (n < partition.size)
> +	n = blk_dread(desc, partition.start, num_blks, map_sysmem(addr, 0));
> +	if (n < num_blks)
>  		return log_msg_ret("part read", -EIO);
>  
>  	return 0;
> @@ -498,12 +514,14 @@ static int boot_android_normal(struct bootflow *bflow)
>  	if (ret < 0)
>  		return log_msg_ret("read slot", ret);
>  
> -	ret = read_slotted_partition(desc, "boot", priv->slot, loadaddr);
> +	ret = read_slotted_partition(desc, "boot", priv->slot, priv->boot_img_size,
> +				     loadaddr);
>  	if (ret < 0)
>  		return log_msg_ret("read boot", ret);
>  
>  	if (priv->header_version >= 3) {
> -		ret = read_slotted_partition(desc, "vendor_boot", priv->slot, vloadaddr);
> +		ret = read_slotted_partition(desc, "vendor_boot", priv->slot,
> +					     priv->vendor_boot_img_size, vloadaddr);
>  		if (ret < 0)
>  			return log_msg_ret("read vendor_boot", ret);
>  		set_avendor_bootimg_addr(vloadaddr);
> diff --git a/boot/image-android.c b/boot/image-android.c
> index cd01278f211d63262f2bdad7aa1176e2c1bbfedd..93b54bf8d7936862693d56d5b75343575f3e6293 100644
> --- a/boot/image-android.c
> +++ b/boot/image-android.c
> @@ -178,6 +178,51 @@ static void android_boot_image_v0_v1_v2_parse_hdr(const struct andr_boot_img_hdr
>  	data->boot_img_total_size = end - (ulong)hdr;
>  }
>  
> +bool android_image_get_bootimg_size(const void *hdr, u32 *boot_img_size)
> +{
> +	struct andr_image_data data;
> +
> +	if (!hdr || !boot_img_size) {
> +		printf("hdr or boot_img_size can't be NULL\n");
> +		return false;
> +	}
> +
> +	if (!is_android_boot_image_header(hdr)) {
> +		printf("Incorrect boot image header\n");
> +		return false;
> +	}
> +
> +	if (((struct andr_boot_img_hdr_v0 *)hdr)->header_version <= 2)
> +		android_boot_image_v0_v1_v2_parse_hdr(hdr, &data);
> +	else
> +		android_boot_image_v3_v4_parse_hdr(hdr, &data);
> +
> +	*boot_img_size = data.boot_img_total_size;
> +
> +	return true;
> +}
> +
> +bool android_image_get_vendor_bootimg_size(const void *hdr, u32 *vendor_boot_img_size)
> +{
> +	struct andr_image_data data;
> +
> +	if (!hdr || !vendor_boot_img_size) {
> +		printf("hdr or vendor_boot_img_size can't be NULL\n");
> +		return false;
> +	}
> +
> +	if (!is_android_vendor_boot_image_header(hdr)) {
> +		printf("Incorrect vendor boot image header\n");
> +		return false;
> +	}
> +
> +	android_vendor_boot_image_v3_v4_parse_hdr(hdr, &data);
> +
> +	*vendor_boot_img_size = data.vendor_boot_img_total_size;
> +
> +	return true;
> +}
> +
>  bool android_image_get_data(const void *boot_hdr, const void *vendor_boot_hdr,
>  			    struct andr_image_data *data)
>  {
> diff --git a/include/image.h b/include/image.h
> index c52fced9b409b1f963daa4ab6c266909ca035aff..9be5acd8158f00930ab1f3988b8f577817acd1fe 100644
> --- a/include/image.h
> +++ b/include/image.h
> @@ -1801,6 +1801,30 @@ int fit_image_cipher_get_algo(const void *fit, int noffset, char **algo);
>  struct cipher_algo *image_get_cipher_algo(const char *full_name);
>  struct andr_image_data;
>  
> +/**
> + * android_image_get_bootimg_size() - Extract size of Android boot image
> + *
> + * This is used to extract the size of an Android boot image
> + * from boot image header.
> + *
> + * @hdr: Pointer to boot image header
> + * @boot_img_size: On exit returns the size in bytes of the boot image
> + * Return: true if succeeded, false otherwise
> + */
> +bool android_image_get_bootimg_size(const void *hdr, u32 *boot_img_size);
> +
> +/**
> + * android_image_get_vendor_bootimg_size() - Extract size of Android vendor-boot image
> + *
> + * This is used to extract the size of an Android vendor-boot image
> + * from vendor-boot image header.
> + *
> + * @hdr: Pointer to vendor-boot image header
> + * @vendor_boot_img_size: On exit returns the size in bytes of the vendor-boot image
> + * Return: true if succeeded, false otherwise
> + */
> +bool android_image_get_vendor_bootimg_size(const void *hdr, u32 *vendor_boot_img_size);
> +
>  /**
>   * android_image_get_data() - Parse Android boot images
>   *
>
> ---
> base-commit: acaa7f35a33146f887948d34130229388280844a
> change-id: 20241121-bootmeth-android-part-sizes-ff2866e0d079
>
> Best regards,
> -- 
> Julien Masson <jmasson@baylibre.com>
