Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C31D13588
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 06:40:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92BD789038;
	Mon, 28 Oct 2024 07:40:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="devJQJM8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21F3689058; Mon, 28 Oct 2024 07:40:40 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F9E18887A
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 07:40:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730097628; x=1730702428; i=xypron.glpk@gmx.de;
 bh=RrOnndr5Ud1NL79NrvmeTwGrz6h6v3tmHniK1g9L43A=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=devJQJM8BsUAvvPpyu6sSDRh6nDkliigXwMv1ibg/hK5pZkliq/cwYb297awKkqg
 p52XvpJdDxHXEn+10lDdcLhAQmM2Uv13tEfday1LmhCLM5Z6wIL0OABTPty3C4lhm
 kkO0f+z4csJGqO/OyvUArtHwnFcDHt7dsT4zBCWNDwhvpwpV7O+iybou4QpYyD+/o
 83olx/GncdgvwZbdLKDpH14pmcpts49PUKrn0jfPu4Jm3DEspYlL9648d22EaTyhM
 jeft32daCBa0ERYJkr7EmKDo8lWoJnJHxhAlSeN2oazJHmG8IOCx372RApH+oNgWg
 8UmgpilqnVH+bhHGCw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.43.6.224] ([87.215.50.114]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKbkM-1tJh0i0Pj2-00MAkV; Mon, 28
 Oct 2024 07:40:28 +0100
Message-ID: <1334fa3c-95e1-41d7-b0e4-db1452de136d@gmx.de>
Date: Mon, 28 Oct 2024 07:40:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lmb: Correctly unmap and free memory on errors
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20241024104603.1340301-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241024104603.1340301-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HvD8XkMcjznqFas5KzR3SQFAM9DV9qqhaOePzsLfnp9Y45lqKeh
 fQQcT20iUaRH6yQy+7pv6KCdUQ8/pZgB0wk98PNN1mhHU4uli9qtEV1ZqEktLQ78MyYUAga
 b31iIFtH5MRlE2lMZP1IdcDSaq9iHSMYjcbsQeZYzNIY2Mmw8ySNXrTXJhvLJA8M9euGWSO
 TQ20QnS1CPikv0L4B3nMQ==
UI-OutboundReport: notjunk:1;M01:P0:w3YL8rxwWdo=;2/fDedTGtNjyEw4qM1jbJJ0YY9w
 VCLQQPlG4Mcp2OI4I5xtFnpAHuEYBYKsofGG3dofFU3qNTJbxGdEVXVqnO0Z4DwZeTemc7mXA
 5wlWm9dq7hB3ysLaj7WjJoiKe/dBHPqp4RNVlVh1a9DZYtlJx5g99f1RScv5UI7B+TJl4rgJf
 SV0/s5YFZngdWp1tsRxGqaATtWGTY/kZfgMen4BUbFZPiMMxzQm+WeHFxRtGn6PHXHWI7baWJ
 HKtG3gdXlrP0Dgpy1vGH5hznyVBqMW8fBW1T1KnhZqu6+EECNMFyWKcV8RknJddmzi1jnohl6
 9tWIiZYHLtNkTmSEMVOVZubsnHJG5UYKJc2DeE4pZ0bMc0L1M8toL8Hdpd/NvqogLTQnBye60
 eJhVCOGMz3exPM+5RNE0QPQDt4e4zkr7A2riskyQea6iQM/04T9FovEY6cO1tSg2/r5A3rjeV
 PgUD3D3EUcIPHfXN89D31NA0VYx2OzXZ1BZj9EZ+snw2vE9dSYigXVkx67ya2c1Fcyx8Kp+3S
 AqNupuSgRttbIR8p5SptEIV5Mb2iUirrwtlcb8dNgIQFW/1eDbjrHn5/+p6g9FIKgubr5/eVI
 e/+JL/nILUr+9qrqHU5KfgeKi3gGGauYq9YMSrjgUldpxOxjQ5yYuzwaRDtWbuO1AAt/efpcr
 AEjPTp5ndpPC89bmSX2maEoxDE5+W2llXIBotRmjf+FG+5/6GQjNU1hjNfFBe4uUB9t6z14qH
 344eBowoM/uQtQdVlVELJYlFhTlw2b7+Ze9FOfh2+VzAja8q9ZblyDYUl3rAbTDNCZMMIfwqe
 iPfbW1p5NJmrrFYZyZ1n7nIg==
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

On 10/24/24 12:46, Ilias Apalodimas wrote:
> We never free and unmap the memory on errors and we never unmap it when
> freeing it. This won't cause any problems on actual hardware but it will
> on sandbox
>
> Fixes: commit 22f2c9ed9f53 ("efi: memory: use the lmb API's for allocati=
ng and freeing memory")
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   lib/efi_loader/efi_memory.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 9f3f08769977..84be5532a655 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -451,7 +451,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_ty=
pe type,
>   				enum efi_memory_type memory_type,
>   				efi_uintn_t pages, uint64_t *memory)
>   {
> -	u64 len;
> +	u64 efi_addr, len;
>   	uint flags;
>   	efi_status_t ret;
>   	phys_addr_t addr;
> @@ -499,14 +499,17 @@ efi_status_t efi_allocate_pages(enum efi_allocate_=
type type,
>   		return EFI_INVALID_PARAMETER;
>   	}
>
> -	addr =3D (u64)(uintptr_t)map_sysmem(addr, 0);
> +	efi_addr =3D (u64)(uintptr_t)map_sysmem(addr, 0);
>   	/* Reserve that map in our memory maps */
> -	ret =3D efi_add_memory_map_pg(addr, pages, memory_type, true);
> -	if (ret !=3D EFI_SUCCESS)
> +	ret =3D efi_add_memory_map_pg(efi_addr, pages, memory_type, true);
> +	if (ret !=3D EFI_SUCCESS) {
>   		/* Map would overlap, bail out */
> +		lmb_free_flags(addr, (u64)pages << EFI_PAGE_SHIFT, flags);
> +		unmap_sysmem((void *)(uintptr_t)efi_addr);
>   		return  EFI_OUT_OF_RESOURCES;
> +	}
>
> -	*memory =3D addr;
> +	*memory =3D efi_addr;
>
>   	return EFI_SUCCESS;
>   }
> @@ -548,6 +551,8 @@ efi_status_t efi_free_pages(uint64_t memory, efi_uin=
tn_t pages)
>   	if (ret !=3D EFI_SUCCESS)
>   		return EFI_NOT_FOUND;
>
> +	unmap_sysmem((void *)(uintptr_t)memory);
> +
>   	return ret;
>   }
>
> --
> 2.45.2
>

AllocatePages() only provides access to EfiConventionalMemory.

We can safely call map_sysmem() with len =3D 0 and not use unmap_sysmem().

Best regards

Heinrich
