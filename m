Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A12C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 18:22:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0FE784A5D;
	Mon, 29 Jun 2026 20:22:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="fXHW9OCR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A20284A63; Mon, 29 Jun 2026 20:22:14 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A350884942
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 20:22:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 774FD355A;
 Mon, 29 Jun 2026 11:22:06 -0700 (PDT)
Received: from e130802.arm.com (unknown [10.57.80.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B5BD3F905;
 Mon, 29 Jun 2026 11:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1782757330; bh=VDHxY15vFnV/Q3/g5br8oJ3HrDb0yIkB64bLWV41sYc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fXHW9OCRLbuFOhZjU+dknNttfXR9ZxvVDcDYwaJEdb4Htq/5OHe/9aQH4/tfx7Y7+
 e9t4ROsxBYTvkB8/W+6KtTpfcdeYBjYpyVJ01qlS4ncgjKR143nffdRKTfhyKTER95
 BP2VZ6wRolvuXLlqcaY8+uuquZbs1wNQlcmxh52M=
Date: Mon, 29 Jun 2026 19:21:59 +0100
From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
To: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v3 01/10] efi_loader: add runtime memset helper
Message-ID: <akK3x3Ih9NH0Sjje@e130802.arm.com>
References: <20260627144421.2067410-1-harsimransingh.tungal@arm.com>
 <20260627144421.2067410-2-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260627144421.2067410-2-harsimransingh.tungal@arm.com>
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

On Sat, Jun 27, 2026 at 03:44:12PM +0100, Harsimran Singh Tungal wrote:
> Add efi_memset_runtime() for EFI runtime paths
> 
> This keeps buffer initialization in runtime-resident code after
> ExitBootServices() and avoids relying on non-runtime helpers.
> 
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
> ---
>  include/efi_loader.h         |  3 +++
>  lib/efi_loader/efi_runtime.c | 20 ++++++++++++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 3a4d502631c..9dfea1fd7de 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -1151,6 +1151,9 @@ void efi_memcpy_runtime(void *dest, const void *src, size_t n);
>  /* runtime implementation of memcmp() */
>  int efi_memcmp_runtime(const void *s1, const void *s2, size_t n);
>  
> +/* runtime implementation of memset() */
> +void *efi_memset_runtime(void *dest, int c, size_t n);
> +
>  /* commonly used helper functions */
>  u16 *efi_create_indexed_name(u16 *buffer, size_t buffer_size, const char *name,
>  			     unsigned int index);
> diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
> index 73d4097464c..c0182931c42 100644
> --- a/lib/efi_loader/efi_runtime.c
> +++ b/lib/efi_loader/efi_runtime.c
> @@ -233,6 +233,26 @@ int __efi_runtime efi_memcmp_runtime(const void *s1, const void *s2, size_t n)
>  	return 0;
>  }
>  
> +/**
> + * efi_memset_runtime() - fill memory area
> + *
> + * At runtime memset() is not available.
> + *
> + * @dest:	destination buffer
> + * @c:		byte value used to fill destination buffer
> + * @n:		number of bytes to set
> + * Return:	pointer to destination buffer
> + */
> +__efi_runtime void *efi_memset_runtime(void *dest, int c, size_t n)
> +{
> +	u8 *d = dest;
> +
> +	for (; n; --n)
> +		*d++ = (u8)c;
> +
> +	return dest;
> +}
> +
>  /**
>   * efi_update_table_header_crc32() - Update crc32 in table header
>   *
> -- 
> 2.34.1
> 

Reviewed-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
