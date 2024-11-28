Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78ABBD70DE6
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 16:34:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD273894F2;
	Thu, 28 Nov 2024 17:34:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="N4chutrj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 390D0897F3; Thu, 28 Nov 2024 17:34:10 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1525989430
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 17:34:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1732811642; x=1733416442; i=xypron.glpk@gmx.de;
 bh=GvxmozrGp/VSEsbqXKk8kF8vRulUO434q7wv5YLe3aA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=N4chutrjCWZAl73cFbI32PA+wuXEvl/whU8LWlWR1BEl0blp3Ubs5DMuqF0r/egQ
 Q3Ibu7j7AfgVhWt5OUzsGpybPMl9HiznD3YR6icLr2VLpW7in1K7DJcCdCn5Qsuo7
 Ka6ndRoaSUsMOCQQ9eSUoDUqcXiUmNWBfU9so/ntMVvhmkAOB7bS3rnrznsAg19Wc
 HZwouWaePXGWVf2RByY4/D+AD920ENOx6QtPj6ndRbpHjH/Dl4QktDBCAd7MAQoOq
 kDoCzTjs52uyQTorrZmMYzGvmuSGuSKBNjAciZVEpTJ7pA4aCQXlW/YkI8DOaYvVP
 5j+BiJXXOHu+HDNtyg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOiDX-1t3GmD08cB-00Or2p; Thu, 28
 Nov 2024 17:34:02 +0100
Message-ID: <60b25206-8f4d-4955-991e-47e851c1aed2@gmx.de>
Date: Thu, 28 Nov 2024 17:34:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/28] efi_loader: Add comments where incorrect
 addresses are used
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241128154727.771871-1-sjg@chromium.org>
 <20241128154727.771871-5-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241128154727.771871-5-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kZIcv7gI0WWnOi8M5IOEtD+VN9sr5vujGj2Ml/cbyIpucLJUyiz
 YxPDL4Ol5779aKYvyq/8TAxWObEllM3S3Dxvc0/4gzDXTyLeP04mG5XhvAMDGCY1Zfg8qox
 uajlqmZQQ9oEzGXttKOc8FeJP6qcRRBTRkimhvDeGqY0Ah+BfgxL7Bl3iDXisE23F7DsLQ7
 UDQfUek0d1Pmwika8CDGw==
UI-OutboundReport: notjunk:1;M01:P0:we/q218RGBQ=;/iCVcQpNYD0rPXM89QphdRgg0fg
 9DNs2BLGtLAlivOCjD1cuVpjutAAPILsYq+Ptt7+7aEFQzowNT7/COu1Alw6kDhR294wP8Cgd
 aGoKHjWPBlkOH8Dgv4CllxkHYvPaIdz8Sq9PpEIOz3keDdb2Z5eKnAuxdftuC7eNx1OoBsuoi
 CvzTmpUN2ipnR1kplP4FWMiR4/i1vx5J1dL0rjpGFsAUBuyKPt5HRlR+NdW4DfR2t+/jOHekx
 gWV40yv8GZmDKkcnwjonBe5V9oadXO3iC7sNwJTwUHbZkG2PHY5oKkTOiHF/JC6M4IEo0yGFY
 k721pOeM2hEf2diXvlOebkjf85+6MqvrdnMSFcPK7gGnRKtjCe2wxsP49RuN2bpRjz+yoru5q
 G7xA671DsfsM1CeAwLoLdKXTSemAQZivepJks52shqgcOcrVzIVA113j9Gg911Csj2hKE8DzD
 5ZyemXbG3/mM8mdCddqbIvTrX3kPzHJDjqmC1qG35oNs/7wEJf/Uv620xASK1mTNUs9ZKmMpR
 b2kGFgigk3WxJuVujH+EpViBGfpXKOmLMC9uCiBJyFe0bq7BnVI2bUq45CDzFjx8YcCOhsTWD
 dSFih1eWWpCf37yBCV0uZI7QR83/GeNdwKZG2arRTNHG+6JXnOAw4l1YQYhZWZGOW+L/8BLNA
 BODGb2iakxXJ2rz/DiSf2aQfU/dYogsI/Ya2bB17haQYJGkRUbcDoj1RipP1jsCP0RqrN/aHm
 gAL0n7g+DBrltfaGVEoIW3afR5R8H1Jx8V7GqHVzCiNB8YPLKfaHf8Agnj1+tR5Qm3N41FcOh
 WHbH/641v8YSuRwmYP86zpxelVJ4+cQA09ASALEvyFUT9X9dTF37y0makQnxBLCyybt0nqxP6
 5dS0kDObmB9vD9nXtlI7rf5yEshQZyPqen/xWg7MHJbybmE75xIvA2RHYYxOMqr2yHOx3vaG8
 JIcsxWKdtCagrhG5zgFdXiaHJYQ7hQNwnH66bQ5cxzOzxPjFjdrQZIp2YVycvZ5VoUH0le2e8
 T6uPQYGo1YVLfKGnWsoob55r1sG1lLqVul4zSJcRkRhBqLcQYSEFojJHeaXDN5GmjvIwytor8
 y4NDp7F4ZPQU27gn+/3cw1hFeJvGBZ
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

On 28.11.24 16:47, Simon Glass wrote:
> Some functions are passing addresses instead of pointers to the
> efi_add_memory_map() function. This confusion is understandable since
> the function arguments indicate an address.
>
> Make a note of the 8 places where there are problems, which would break
> usage in sandbox tests.
>
> Future work will resolve these problems.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v2:
> - Add a new patch with comments where incorrect addresses are used
>
>   lib/efi_loader/efi_acpi.c    | 2 ++
>   lib/efi_loader/efi_bootmgr.c | 5 +++++
>   lib/efi_loader/efi_helper.c  | 1 +
>   lib/efi_loader/efi_smbios.c  | 6 +++++-
>   lib/efi_loader/efi_var_mem.c | 2 ++
>   5 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
> index 67bd7f8ca24..ffb360d461b 100644
> --- a/lib/efi_loader/efi_acpi.c
> +++ b/lib/efi_loader/efi_acpi.c
> @@ -28,12 +28,14 @@ efi_status_t efi_acpi_register(void)
>   	/* Mark space used for tables */
>   	start =3D ALIGN_DOWN(gd->arch.table_start, EFI_PAGE_MASK);
>   	end =3D ALIGN(gd->arch.table_end, EFI_PAGE_MASK);
> +	/* TODO(sjg): This should use (ulong)map_sysmem(start, ...) */
>   	ret =3D efi_add_memory_map(start, end - start, EFI_ACPI_RECLAIM_MEMOR=
Y);
>   	if (ret !=3D EFI_SUCCESS)
>   		return ret;
>   	if (gd->arch.table_start_high) {
>   		start =3D ALIGN_DOWN(gd->arch.table_start_high, EFI_PAGE_MASK);
>   		end =3D ALIGN(gd->arch.table_end_high, EFI_PAGE_MASK);
> +		/* TODO(sjg): This should use (ulong)map_sysmem(start, ...) */
>   		ret =3D efi_add_memory_map(start, end - start,
>   					 EFI_ACPI_RECLAIM_MEMORY);
>   		if (ret !=3D EFI_SUCCESS)
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index 8c51a6ef2ed..bb635d77b53 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -365,6 +365,8 @@ static efi_status_t prepare_loaded_image(u16 *label,=
 ulong addr, ulong size,
>   	 * TODO: expose the ramdisk to OS.
>   	 * Need to pass the ramdisk information by the architecture-specific
>   	 * methods such as 'pmem' device-tree node.
> +	 *
> +	 * TODO(sjg): This should use (ulong)map_sysmem(addr)
>   	 */

This cannot work. The EFI memory according to the EFI specification
uses  EFI_PHYSICAL_ADDRESS defined as UINT64.

>   	ret =3D efi_add_memory_map(addr, size, EFI_RESERVED_MEMORY_TYPE);
>   	if (ret !=3D EFI_SUCCESS) {
> @@ -399,6 +401,7 @@ static efi_status_t efi_bootmgr_release_uridp(struct=
 uridp_context *ctx)
>
>   	/* cleanup for iso or img image */
>   	if (ctx->ramdisk_blk_dev) {
> +		/* TODO(sjg): This should use (ulong)map_sysmem(...) */
>   		ret =3D efi_add_memory_map(ctx->image_addr, ctx->image_size,
>   					 EFI_CONVENTIONAL_MEMORY);
>   		if (ret !=3D EFI_SUCCESS)
> @@ -506,6 +509,8 @@ static efi_status_t try_load_from_uri_path(struct ef=
i_device_path_uri *uridp,
>
>   		source_buffer =3D NULL;
>   		source_size =3D 0;
> +
> +	/* TODO(sjg): This does not work on sandbox */
>   	} else if (efi_check_pe((void *)image_addr, image_size, NULL) =3D=3D =
EFI_SUCCESS) {
>   		/*
>   		 * loaded_dp must exist until efi application returns,
> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> index bf96f61d3d0..fd89ef6036f 100644
> --- a/lib/efi_loader/efi_helper.c
> +++ b/lib/efi_loader/efi_helper.c
> @@ -486,6 +486,7 @@ static efi_status_t copy_fdt(void **fdtp)
>   		log_err("Failed to reserve space for FDT\n");
>   		goto done;
>   	}
> +	/* TODO(sjg): This does not work on sandbox */
>   	new_fdt =3D (void *)(uintptr_t)new_fdt_addr;

What is not working?

AllocatePages() MUST provide an EFI_PHYSICAL_ADDRESS according to the
UEFI specification.

The UEFI specification further requires an identity mapping. So
EFI_PHYSICAL_ADDRESS variables MUST take a value that can be used as
pointer.


>   	memcpy(new_fdt, fdt, fdt_totalsize(fdt));
>   	fdt_set_totalsize(new_fdt, fdt_size);
> diff --git a/lib/efi_loader/efi_smbios.c b/lib/efi_loader/efi_smbios.c
> index 8d2ef6deb51..02d4a5dd045 100644
> --- a/lib/efi_loader/efi_smbios.c
> +++ b/lib/efi_loader/efi_smbios.c
> @@ -40,7 +40,11 @@ efi_status_t efi_smbios_register(void)
>   		return EFI_NOT_FOUND;
>   	}
>
> -	/* Mark space used for tables */
> +	/*
> +	 * Mark space used for tables/
> +	 *
> +	 * TODO(sjg): This should use (ulong)map_sysmem(addr, ...)

No. See above.

> +	 */
>   	ret =3D efi_add_memory_map(addr, TABLE_SIZE, EFI_RUNTIME_SERVICES_DAT=
A);
>   	if (ret)
>   		return ret;
> diff --git a/lib/efi_loader/efi_var_mem.c b/lib/efi_loader/efi_var_mem.c
> index 139e16aad7c..5c69a1e0f3e 100644
> --- a/lib/efi_loader/efi_var_mem.c
> +++ b/lib/efi_loader/efi_var_mem.c
> @@ -226,6 +226,8 @@ efi_status_t efi_var_mem_init(void)
>   				 &memory);
>   	if (ret !=3D EFI_SUCCESS)
>   		return ret;
> +
> +	/* TODO(sjg): This does not work on sandbox */

It has been working fine up to now.

Best regards

Heinrich

>   	efi_var_buf =3D (struct efi_var_file *)(uintptr_t)memory;
>   	memset(efi_var_buf, 0, EFI_VAR_BUF_SIZE);
>   	efi_var_buf->magic =3D EFI_VAR_FILE_MAGIC;

