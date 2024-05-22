Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6278DC25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 06:16:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDEAD88412;
	Wed, 22 May 2024 08:16:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="euvkfe4j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4AA988488; Wed, 22 May 2024 08:16:51 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD34A87F4B
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 08:16:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2e73359b979so23646071fa.1
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 23:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716358609; x=1716963409; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7LqKqpGkqSdQQtySlS5FqA0Y4A8r3CJ2osDMOrFydnE=;
 b=euvkfe4jiHKVj4JOW3M2BlGkrqtd82hideu0oN/7t0kdeUzRylIHjmcZi6UDHmNd8s
 6scniEb9sxCDdCYeXp2Aa1o3tl00kcCEZa2MFC0+kVqzURaGbpRtgQU2CG8BOEdZ8PiH
 XgIQstyVrFc3c0hBisE9vDZZ26/mCeA8z/3FdVes+RgrMv91ezAiRaNLKyH4lG4xO0pc
 K5JlJv8Iy/IigXbXPS/M8DvsQc9gQafurxpXJZizEBo4+CazH+2x3zJHVjs3dfBEeUXl
 jNiw2kORGnZrRIakCg9eGJ6hvdv/qLEppfaQOYrUHj9wVbbWw2w25KQHZZdk2plXh1pR
 haag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716358609; x=1716963409;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7LqKqpGkqSdQQtySlS5FqA0Y4A8r3CJ2osDMOrFydnE=;
 b=DKE4OkpW/8xH4xNnxUvCkewzDnvPJ6M+UmGSQwytHtjHsS8LkSwqjcUnM99it/+R0I
 WKdoyI7pkkgEvpTB327JA0cGZVbK4OenRM3yem+EKrcI2luTXul6t+Iyhtl6BCSEIZCj
 6ct3wRq4nTEZMssoalPi8YMCVrEIz9UNlU8537hvzFtEuElO9SHtFRJhBj/fxkleHPJz
 JPbRepS+52kNRivmdE3/jYMm4986UaNpDeYExeGvChC+usI9WZFJRLXU/Otp4tzbIx85
 u9+Da0uIkmmGXiO/NSGiVET7VXazs1CKx5aYabq7nnV7NK8Ptqn7V6jnR3ExZBLWfRn8
 Bgiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnmHVzAE0WiVWwzgDOcyb0uhXmgSHWtG22gkAW9C9IV06Rcr605FIlIwxyxD9OyzH1u+qicaJYAAb4fLU51WkiyYszeQ==
X-Gm-Message-State: AOJu0YzSj5N5OrxKLO0qpuYBbhqOd2HwQ7buSq6L/NlM5KQ8s+2exy9n
 aP0QdX3xyA8tDdhrkQqpD6fuG0AfdABdCWbOTglxCCbXdfbFyJgJOFllSpsy48w=
X-Google-Smtp-Source: AGHT+IF1e3jtn/wj2D9A7yl8z6KZB95OECqWoXT7V9eCLjWTJR1ZcQ13FL7cbyiqeTmf1vwrOd0E/g==
X-Received: by 2002:a2e:8807:0:b0:2e7:14a4:1f64 with SMTP id
 38308e7fff4ca-2e949490127mr4604781fa.7.1716358609020; 
 Tue, 21 May 2024 23:16:49 -0700 (PDT)
Received: from hera (ppp089210091242.access.hol.gr. [89.210.91.242])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41f88110f3esm523519955e9.29.2024.05.21.23.16.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 23:16:48 -0700 (PDT)
Date: Wed, 22 May 2024 09:16:46 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, Bin Meng <bmeng@tinylab.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Joao Marcos Costa <jmcosta944@gmail.com>, u-boot@lists.denx.de
Subject: Re: [RFC 05/14] cmd: efidebug: add support for setting fdt
Message-ID: <Zk2NzrpdiOL6IhMr@hera>
References: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
 <20240426141321.232236-6-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426141321.232236-6-heinrich.schuchardt@canonical.com>
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

Hi Heinrich

On Fri, Apr 26, 2024 at 04:13:12PM +0200, Heinrich Schuchardt wrote:
> We already support creating a load option where the device-path
> field contains the concatenation of the binary device-path and
> optionally the device path of the initrd which we expose via the
> EFI_LOAD_FILE2_PROTOCOL.
>
> Allow to append another device-path pointing to the device-tree
> identified by the device-tree GUID.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/efidebug.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 63 insertions(+), 5 deletions(-)
>
> diff --git a/cmd/efidebug.c b/cmd/efidebug.c
> index 93ba16efc7d..32c64711b6c 100644
> --- a/cmd/efidebug.c
> +++ b/cmd/efidebug.c
> @@ -660,16 +660,33 @@ static int do_efi_show_tables(struct cmd_tbl *cmdtp, int flag,
>   * @part:	disk partition
>   * @file:	filename
>   * @shortform:	create short form device path
> + * @fdt:	create path for device-tree
>   * Return:	pointer to the device path or ERR_PTR
>   */
>  static
>  struct efi_device_path *create_initrd_dp(const char *dev, const char *part,
> -					 const char *file, int shortform)
> +					 const char *file, bool shortform,
> +					 bool fdt)

Overall the patch looks correct. Can we pick a better name instead of
create_initrd_dp() & efi_initrd_dp? Do you have in mind any extra uses
cases apart from the initrd and dtb? If yes, then we could convert the i
'bool fdt' to an enum.

Since all these are encoded in the load option perhaps we can rename it to
create_lo_dp and efi_lo_dp?

>
>  {
>  	struct efi_device_path *tmp_dp = NULL, *tmp_fp = NULL, *short_fp = NULL;
>  	struct efi_device_path *initrd_dp = NULL;
>  	efi_status_t ret;
> +	const struct efi_initrd_dp fdt_dp = {
> +		.vendor = {
> +			{
> +			DEVICE_PATH_TYPE_MEDIA_DEVICE,
> +			DEVICE_PATH_SUB_TYPE_VENDOR_PATH,
> +			sizeof(fdt_dp.vendor),
> +			},
> +			EFI_FDT_GUID,
> +		},
> +		.end = {
> +			DEVICE_PATH_TYPE_END,
> +			DEVICE_PATH_SUB_TYPE_END,
> +			sizeof(fdt_dp.end),
> +		}
> +	};
>  	const struct efi_initrd_dp id_dp = {
>  		.vendor = {
>  			{
> @@ -696,7 +713,8 @@ struct efi_device_path *create_initrd_dp(const char *dev, const char *part,
>  	if (!short_fp)
>  		short_fp = tmp_fp;
>
> -	initrd_dp = efi_dp_concat((const struct efi_device_path *)&id_dp,
> +	initrd_dp = efi_dp_concat((const struct efi_device_path *)
> +				  (fdt ? &fdt_dp : &id_dp),
>  				  short_fp);
>
>  out:
> @@ -796,6 +814,7 @@ static int do_efi_boot_add(struct cmd_tbl *cmdtp, int flag,
>  	struct efi_device_path *fp_free = NULL;
>  	struct efi_device_path *final_fp = NULL;
>  	struct efi_device_path *initrd_dp = NULL;
> +	struct efi_device_path *fdt_dp = NULL;
>  	struct efi_load_option lo;
>  	void *data = NULL;
>  	efi_uintn_t size;
> @@ -860,6 +879,27 @@ static int do_efi_boot_add(struct cmd_tbl *cmdtp, int flag,
>  			argc -= 5;
>  			argv += 5;
>  			break;
> +		case 'd':
> +			shortform = 1;
> +			fallthrough;
> +		case 'D':
> +			if (argc < 3 || fdt_dp) {
> +				r = CMD_RET_USAGE;
> +				goto out;
> +			}
> +
> +			fdt_dp = create_initrd_dp(argv[1], argv[2], argv[3],
> +						  shortform, true);
> +			if (!fdt_dp) {
> +				printf("Cannot add a device-tree\n");
> +				r = CMD_RET_FAILURE;
> +				goto out;
> +			}
> +			argc -= 3;
> +			argv += 3;
> +			fp_size += efi_dp_size(fdt_dp) +
> +				sizeof(struct efi_device_path);
> +			break;
>  		case 'i':
>  			shortform = 1;
>  			/* fallthrough */
> @@ -870,7 +910,7 @@ static int do_efi_boot_add(struct cmd_tbl *cmdtp, int flag,
>  			}
>
>  			initrd_dp = create_initrd_dp(argv[1], argv[2], argv[3],
> -						     shortform);
> +						     shortform, false);
>  			if (!initrd_dp) {
>  				printf("Cannot add an initrd\n");
>  				r = CMD_RET_FAILURE;
> @@ -929,6 +969,15 @@ static int do_efi_boot_add(struct cmd_tbl *cmdtp, int flag,
>  		}
>  	}
>
> +	if (fdt_dp) {
> +		final_fp = efi_dp_merge(final_fp, &fp_size, fdt_dp);
> +		if (!final_fp) {
> +			printf("Cannot create final device path\n");
> +			r = CMD_RET_FAILURE;
> +			goto out;
> +		}
> +	}
> +
>  	lo.file_path = final_fp;
>  	lo.file_path_length = fp_size;
>
> @@ -952,6 +1001,7 @@ out:
>  	free(data);
>  	efi_free_pool(final_fp);
>  	efi_free_pool(initrd_dp);
> +	efi_free_pool(fdt_dp);
>  	efi_free_pool(fp_free);
>  	free(lo.label);
>
> @@ -1014,7 +1064,8 @@ static int do_efi_boot_rm(struct cmd_tbl *cmdtp, int flag,
>   */
>  static void show_efi_boot_opt_data(u16 *varname16, void *data, size_t *size)
>  {
> -	struct efi_device_path *initrd_path = NULL;
> +	struct efi_device_path *fdt_path;
> +	struct efi_device_path *initrd_path;
>  	struct efi_load_option lo;
>  	efi_status_t ret;
>
> @@ -1043,6 +1094,12 @@ static void show_efi_boot_opt_data(u16 *varname16, void *data, size_t *size)
>  		efi_free_pool(initrd_path);
>  	}
>
> +	fdt_path = efi_dp_from_lo(&lo, &efi_guid_fdt);
> +	if (fdt_path) {
> +		printf("  device-tree path: %pD\n", fdt_path);
> +		efi_free_pool(fdt_path);
> +	}
> +
>  	printf("  data:\n");
>  	print_hex_dump("    ", DUMP_PREFIX_OFFSET, 16, 1,
>  		       lo.optional_data, *size, true);
> @@ -1570,8 +1627,9 @@ U_BOOT_LONGHELP(efidebug,
>  	"\n"
>  	"efidebug boot add - set UEFI BootXXXX variable\n"
>  	"  -b|-B <bootid> <label> <interface> <devnum>[:<part>] <file path>\n"
> +	"  -d|-D <interface> <devnum>[:<part>] <device-tree file path>\n"
>  	"  -i|-I <interface> <devnum>[:<part>] <initrd file path>\n"
> -	"  (-b, -i for short form device path)\n"
> +	"  (-b, -d, -i for short form device path)\n"
>  #if (IS_ENABLED(CONFIG_EFI_HTTP_BOOT))
>  	"  -u <bootid> <label> <uri>\n"
>  #endif
> --
> 2.43.0
>

Regards
/Ilias
