Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D243EB2705
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 20:04:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B95FA83DEC;
	Tue, 10 Feb 2026 21:04:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="WBNHcIh7";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vlpAXYxc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB66E83E0E; Tue, 10 Feb 2026 21:04:40 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0C3F8388D
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 21:04:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4f9Xb93vm4z9ttV;
 Tue, 10 Feb 2026 21:04:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770753877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IVYlwCxxy+nAatELaemLcK5XmLeolj1pdfqDsCttmGw=;
 b=WBNHcIh7VWd82BT4xyAUMBPVbGfq+kaDibx7w81iD9zFDK0VmEwuP9ElhFWRlj2CzUAK7r
 hRcBy0bC3PJppUfdYJMdsYAo/dWITT1QHztDiZv3xaTU5FBFb5E6aWvwh1xCG5qcr5w9j+
 3YWSPJ6x9LEiak8hJyC5I9aYr7CpuxHElL2gVlg7upFew+abCazO4lMmoEqJkRmAdCgAJ4
 g6eBxtig2qjFfPdn33yzHkZlp7irVVYdnTlv/+ESdrwQtNbD0TfmoHzfUEK3Zyoh7aIEiM
 DBAw5x/LOp6sYs3e8tvdmmMyot/EPlkzfesMd/Dd+aF5Xc/C48iCsIdwd/sSXw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=vlpAXYxc;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <0ed5f17d-14f3-432b-9f6d-e686ca1ae29e@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770753875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IVYlwCxxy+nAatELaemLcK5XmLeolj1pdfqDsCttmGw=;
 b=vlpAXYxcnv0yBaHC8HW46DQ3Ir3D4Jv4Vi/D/0oGy7pBzRO/cfbzFbjUoFLd2kJqbCod6+
 MEaiQRwIstEvWV+9yfn0JncIC/3P2ZdrwhUYFKUdwZ+KNxGXuYkM6pAXAIlI4A2+zMbtp4
 IeynYRbxrigZ6RpzZyoKThc17HN0gaJVGwMtbW7QnInpFnqFdGa9qfhfQDLv3e36V0L+j4
 3VdBwzB2SurHeO3iEWxpXZPACrWaW2I2kO53kKd2FvEhaIhCSb9Jia2XLcJjJ0n0MUf49W
 3eOVLZg5v8Ta99qFdei09zwgYPk/irMzXJ0viP84WPkpHMuUxWSvTa/0CvnFPw==
Date: Tue, 10 Feb 2026 21:04:33 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/1] image: fit: Apply overlays using aligned writable
 FDT copies
To: James Hilliard <james.hilliard1@gmail.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Jamie Gibbons <Jamie.Gibbons@microchip.com>
References: <20260210185455.2409242-1-james.hilliard1@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260210185455.2409242-1-james.hilliard1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 0ab41918a20dec159ae
X-MBO-RS-META: 8qghwkohm4orneoqjhrg3r9ws56ccxf4
X-Rspamd-Queue-Id: 4f9Xb93vm4z9ttV
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

On 2/10/26 7:54 PM, James Hilliard wrote:
> libfdt expects FDT/DTO blobs to be 8-byte aligned. When loading the
> base FDT or overlays from a FIT, the mapped buffer may be unaligned,
> which can break fdt_open_into() on strict-alignment architectures.
> 
> boot_get_fdt_fit() relocates the base FDT with boot_relocate_fdt()
> before applying overlays. That uses the bootm memory map and can
> overlap with the FIT buffer when the FIT is loaded into RAM,
> corrupting data needed to load the kernel and ramdisk.
> 
> Allocate writable, 8-byte aligned copies of the base FDT and overlays
> with memalign() and fdt_open_into(). Grow the base buffer as needed,
> apply overlays to it and pack the final tree. Free each temporary
> overlay copy after application and check fdt_pack() errors.
> 
> Fixes: 8fbcc0e0e839 ("boot: Assure FDT is always 8-byte aligned")
> Fixes: 881f0b77dc8c ("image: apply FDTOs on FDT image node")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v1 -> v2:
>    - also fix alignment issues

Please keep the Jamie on CC

> ---
>   boot/image-fit.c | 158 +++++++++++++++++++++++++++++++++++------------
>   1 file changed, 118 insertions(+), 40 deletions(-)
> 
> diff --git a/boot/image-fit.c b/boot/image-fit.c
> index 41ab1f552b0..68fb75c8389 100644
> --- a/boot/image-fit.c
> +++ b/boot/image-fit.c
> @@ -2344,6 +2344,52 @@ int boot_get_setup_fit(struct bootm_headers *images, uint8_t arch,
>   }
>   
>   #ifndef USE_HOSTCC
> +#ifdef CONFIG_OF_LIBFDT_OVERLAY
> +static int boot_get_fdt_fit_into_buffer(const void *src, ulong srclen,
> +					ulong extra, ulong min_dstlen,
> +					void **fdtdstbuf, ulong *fdtdstlenp)
> +{
> +	const void *fdtsrcbuf;
> +	void *tmp = NULL;
> +	ulong fdtdstlen;
> +	int err;
> +
> +	/* Make sure the source FDT/DTO is 8-byte aligned for libfdt. */
> +	fdtsrcbuf = src;
> +	if (!IS_ALIGNED((uintptr_t)src, 8)) {
> +		tmp = memalign(8, srclen);
> +		if (!tmp)
> +			return -ENOMEM;
> +
> +		memcpy(tmp, src, srclen);
> +		fdtsrcbuf = tmp;
> +	}
> +
> +	fdtdstlen = ALIGN(fdt_totalsize(fdtsrcbuf) + extra, SZ_4K);
> +	min_dstlen = ALIGN(min_dstlen, SZ_4K);
> +	if (fdtdstlen < min_dstlen)
> +		fdtdstlen = min_dstlen;
> +
> +	*fdtdstbuf = memalign(8, fdtdstlen);
> +	if (!*fdtdstbuf) {
> +		free(tmp);
> +		return -ENOMEM;
> +	}
> +
> +	err = fdt_open_into(fdtsrcbuf, *fdtdstbuf, fdtdstlen);
> +	free(tmp);
> +	if (err < 0) {
> +		free(*fdtdstbuf);
> +		*fdtdstbuf = NULL;
> +		return err;
> +	}
> +
> +	*fdtdstlenp = fdtdstlen;
> +
> +	return 0;
> +}
> +#endif
> +
>   int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
>   		     const char **fit_unamep, const char **fit_uname_configp,
>   		     int arch, ulong *datap, ulong *lenp)
> @@ -2356,18 +2402,12 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
>   	char *next_config = NULL;
>   	ulong load, len;
>   #ifdef CONFIG_OF_LIBFDT_OVERLAY
> -	ulong ovload, ovlen, ovcopylen;
> +	ulong ovload, ovlen, ovcopylen, need;
>   	const char *uconfig;
>   	const char *uname;
> -	/*
> -	 * of_flat_tree is storing the void * returned by map_sysmem, then its
> -	 * address is passed to boot_relocate_fdt which expects a char ** and it
> -	 * is then cast into a ulong. Setting its type to void * would require
> -	 * to cast its address to char ** when passing it to boot_relocate_fdt.
> -	 * Instead, let's be lazy and use void *.
> -	 */
> -	char *of_flat_tree;
> -	void *base, *ov, *ovcopy = NULL;
> +	void *ovcopy = NULL;
> +	void *base_buf = NULL;
> +	ulong base_buf_size = 0;
>   	int i, err, noffset, ov_noffset;
>   #endif
>   
> @@ -2410,18 +2450,27 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
>   	/* we need to apply overlays */
>   
>   #ifdef CONFIG_OF_LIBFDT_OVERLAY
> -	/* Relocate FDT so resizing does not overwrite other data in FIT. */
> -	of_flat_tree = map_sysmem(load, len);
> -	len = ALIGN(fdt_totalsize(load), SZ_4K);
> -	err = boot_relocate_fdt(&of_flat_tree, &len);
> -	if (err) {
> -		printf("Required FDT relocation for applying DTOs failed: %d\n",
> -		       err);
> -		fdt_noffset = -EBADF;
> +	/*
> +	 * Make a writable copy of the base FDT for applying overlays.
> +	 *
> +	 * Do not use boot_relocate_fdt() here: it allocates from the bootm map and
> +	 * may overlap with the FIT buffer (still needed to load the kernel /
> +	 * ramdisk) when the FIT is loaded into RAM.
> +	 */
> +	err = boot_get_fdt_fit_into_buffer(map_sysmem(load, len), len,
> +					   CONFIG_SYS_FDT_PAD, 0, &base_buf,
> +					   &base_buf_size);
> +	if (err < 0) {
> +		if (err == -ENOMEM)
> +			printf("Required FDT copy for applying DTOs failed: out of memory\n");

If this returns ENOMEM, you will likely not be able to print anything, 
so don't bother. Bail with a return value and be done with it, i.e. drop 
the error prints here.

> +		else
> +			printf("Required FDT copy for applying DTOs failed: %s\n",
> +			       fdt_strerror(err));
> +		fdt_noffset = err;
>   		goto out;
>   	}
>   
> -	load = (ulong)of_flat_tree;
> +	len = fdt_off_dt_strings(base_buf) + fdt_size_dt_strings(base_buf);
>   
>   	/* apply extra configs in FIT first, followed by args */
>   	for (i = 1; ; i++) {
> @@ -2465,46 +2514,73 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
>   		}
>   		debug("%s loaded at 0x%08lx len=0x%08lx\n",
>   				uname, ovload, ovlen);
> -		ov = map_sysmem(ovload, ovlen);
> -
> -		ovcopylen = ALIGN(fdt_totalsize(ov), SZ_4K);
> -		ovcopy = malloc(ovcopylen);
> -		if (!ovcopy) {
> -			printf("failed to duplicate DTO before application\n");
> -			fdt_noffset = -ENOMEM;
> -			goto out;
> -		}
> -
> -		err = fdt_open_into(ov, ovcopy, ovcopylen);
> +		err = boot_get_fdt_fit_into_buffer(map_sysmem(ovload, ovlen),
> +						   ovlen, 0, 0, &ovcopy,
> +						   &ovcopylen);
>   		if (err < 0) {
> -			printf("failed on fdt_open_into for DTO\n");
> +			if (err == -ENOMEM)
> +				printf("failed to duplicate DTO before application\n");
> +			else
> +				printf("failed on fdt_open_into for DTO: %s\n",

DTTO

> +				       fdt_strerror(err));
>   			fdt_noffset = err;
>   			goto out;
>   		}
>   
> -		base = map_sysmem(load, len + ovlen);
> -		err = fdt_open_into(base, base, len + ovlen);
> -		if (err < 0) {
> -			printf("failed on fdt_open_into\n");
> -			fdt_noffset = err;
> -			goto out;
> +		/*
> +		 * Ensure the base FDT buffer is open and has enough room for
> +		 * the overlay. Grow it on demand.
> +		 */
> +		need = ALIGN(len + ovcopylen + CONFIG_SYS_FDT_PAD, SZ_4K);
> +		if (need > base_buf_size) {

Doesn't boot_get_fdt_fit_into_buffer() do the necessary 
rounding/alignment/... already , so shouldn't it be enough to simply 
call it here, without this conditional ?

> +			void *new_base;
> +			ulong new_size;
> +
> +			err = boot_get_fdt_fit_into_buffer(base_buf, base_buf_size,
> +							   0, need, &new_base,
> +							   &new_size);
> +			if (err < 0) {
> +				if (err == -ENOMEM)
> +					printf("failed to expand FDT for DTO application\n");
> +				else
> +					printf("failed on fdt_open_into while expanding FDT\n");
> +				fdt_noffset = err;
> +				goto out;
> +			}
> +
> +			free(base_buf);
> +			base_buf = new_base;
> +			base_buf_size = new_size;
>   		}
The rest looks good, thanks !
