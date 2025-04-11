Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736F2C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 06:20:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93FA183EAB;
	Fri, 11 Apr 2025 08:20:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="hKf6VSkj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6F5A83EAC; Fri, 11 Apr 2025 08:20:11 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76FC683E92
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 08:20:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1744352408; x=1744957208; i=xypron.glpk@gmx.de;
 bh=/3S70V9nxAyE7Uliv1678c3UtYfmThkLOmdQ4IXHsic=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=hKf6VSkjcvVNvf+KL4Ze/VFCrwFgJiAkxYXKmCvYM+EFbf3jrOJ2LabPZ+D5HoxK
 gsUVKldfwK9pLEVLbB57S3/f3PPbWABsh5AhMPbhC0HnG/4o0OHHEd3iz+Zgv1jXf
 sDvRI0dWhrISul1JgL1WFVMuYkvnc9OG6EiW5V3DRUR7jOlT1vEmAck+e8CAAEtGS
 9B4hckKMZQHJRAK0jJPSJjzd7GGaD2cGOoc01rcUXW2NrSLcZ55Tp2TmCDtNwxdsC
 YrzhBwlyeXKxoDSkaoXQWqiFzsZW405bQoezQckJKbg8rxZ/hS8+yX2nVIfmNc9Zc
 SxzzoPOz2c/2R+rFmw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.109.163]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MzhnN-1t87L713aL-00vUU3; Fri, 11
 Apr 2025 08:20:08 +0200
Message-ID: <16f41a27-4b98-4c2c-81c0-6dc5d64b19f2@gmx.de>
Date: Fri, 11 Apr 2025 08:20:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] efi: Make FDT extra space configurable
To: Pawel Kochanowski <pkochanowski@sii.pl>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Gabriel Nesteruk <gnesteruk@sii.pl>,
 u-boot@lists.denx.de
References: <20250318092327.55203-1-pkochanowski@sii.pl>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250318092327.55203-1-pkochanowski@sii.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bAlvbDA+XUCSlWndEvf9bT7ZsYgy4qtwAlnbWg00G0ahtCg3GL1
 50QN99dFY+Csyeb9jsI2LKuLWt4tLNUsIohUg9sHx4cka5dwCjBFB9+7gyL5oO6wg+LeB6Y
 MNt6NRwppWHBfSqTO9+y2FRLQBeBQ4PenbkqutwHnFhAVvzTzRRQyXeiSpkdWWeziDaas1M
 SEOyASfEOlSHeVjKkY6bQ==
UI-OutboundReport: notjunk:1;M01:P0:hXc/dJ9AH3U=;XiE4+Mf66bqDjx1ZJBkWydd9B3V
 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
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

On 3/18/25 10:22, Pawel Kochanowski wrote:
> U-Boot currently reserves only 0x3000 bytes when copying the FDT
> in copy_fdt(), which may not be sufficient if additional nodes
> (such as FMAN firmware) are added later.
>
> This patch uses the exisitng SYS_FDT_PAD to reserve space for FDT fixup
> instead of hardcoded value.
>
> This change prevents potential corruption when resizing FDT after
> EFI boot, especially when firmware like FMAN requires additional
> space.
>
> Signed-off-by: Gabriel Nesteruk <gnesteruk@sii.pl>
> Signed-off-by: Pawel Kochanowski <pkochanowski@sii.pl>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
> Changes since version 1:
> - Removed custom CONFIG_FDT_EXTRA_SPACE in favor of already present SYS_=
FDT_PAD
> - Use the define also in efi_dt_fixup.c
>
>   lib/efi_loader/efi_dt_fixup.c | 2 +-
>   lib/efi_loader/efi_helper.c   | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/efi_loader/efi_dt_fixup.c b/lib/efi_loader/efi_dt_fixup=
.c
> index 26928cfc454..544e1aa9808 100644
> --- a/lib/efi_loader/efi_dt_fixup.c
> +++ b/lib/efi_loader/efi_dt_fixup.c
> @@ -168,7 +168,7 @@ efi_dt_fixup(struct efi_dt_fixup_protocol *this, voi=
d *dtb,
>   		/* Check size */
>   		required_size =3D fdt_off_dt_strings(dtb) +
>   				fdt_size_dt_strings(dtb) +
> -				0x3000;
> +				CONFIG_SYS_FDT_PAD;
>   		total_size =3D fdt_totalsize(dtb);
>   		if (required_size < total_size)
>   			required_size =3D total_size;
> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> index 04b2efc4a3b..40e5d31575a 100644
> --- a/lib/efi_loader/efi_helper.c
> +++ b/lib/efi_loader/efi_helper.c
> @@ -477,7 +477,7 @@ static efi_status_t copy_fdt(void **fdtp)
>   	 * needs to be expanded later.
>   	 */
>   	fdt =3D *fdtp;
> -	fdt_pages =3D efi_size_in_pages(fdt_totalsize(fdt) + 0x3000);
> +	fdt_pages =3D efi_size_in_pages(fdt_totalsize(fdt) + CONFIG_SYS_FDT_PA=
D);
>   	fdt_size =3D fdt_pages << EFI_PAGE_SHIFT;
>
>   	ret =3D efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,

