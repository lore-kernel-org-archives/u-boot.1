Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F9CDC02180
	for <u-boot@archiver.kernel.org>; Sat, 14 Sep 2024 07:35:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A97B388D74;
	Sat, 14 Sep 2024 09:35:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="JXFV6E6b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C68A288D78; Sat, 14 Sep 2024 09:35:10 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94A4B88C71
 for <u-boot@lists.denx.de>; Sat, 14 Sep 2024 09:35:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1726299298; x=1726904098; i=xypron.glpk@gmx.de;
 bh=jUJamyFb6a1AgJgu4xwS//axZQhLApdbe1MeDLVD+Pg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=JXFV6E6bupG8yeJwjM4CLKcBZ4GG+ynjDjic1CviZ/IF8Rni0+NtVgV74TPSGeao
 zD96aFojPvCctMZVdQSPSuaPgKx+mYw52HHnDe+mYBky2j7YBjXLkwh3IHw8xzcF+
 wZLSxvd4HESN9koFyB4kGZ8RhJ8ZaFoi7hS8Kfxk2sU2ApYagUZgF65kbCsckgVq3
 X9K+jLyURjk6bkadk57T/5ckoXK4VOkx2CiXAjcBGXWc/q8JrYA93ImMJOGOc53/A
 w638Zx06RGCm3YZ6RA17+NtRtQfhNeGBjIrMwwGs8KZRW0QULWw+5wz7IXEmkaGTI
 nG0DiABj1SAmTgnwHg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIdeR-1sjXsd2X7F-007pWC; Sat, 14
 Sep 2024 09:34:58 +0200
Message-ID: <52f2da9e-924c-44b4-8390-7d604d07ab33@gmx.de>
Date: Sat, 14 Sep 2024 09:34:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] efi: Drop the memset() from efi_alloc()
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240901222259.456932-1-sjg@chromium.org>
 <20240901222259.456932-2-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240901222259.456932-2-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u4VCQ28hKN8waAUhgAg3m0oN9Xb5SGB5TSsoI5L5a2Jo26WAUKD
 yey3wlGSk0MlRyKXRxRBt+06vS6i1lzD79pZ+g72p5HZthstfLMInpC9blLa6BCplxJ3MpE
 nufuuHU4ixBkF9JphC4f1EcHE+PYGUMq9p9aG0ixLE1gbXlNBEa4a3sbMbhAR6/+cwq+g3t
 DBoqw/gz/XED8GSrxl7Nw==
UI-OutboundReport: notjunk:1;M01:P0:mFuhDTnKqf4=;/TnBTZTEpDg7wx0jVlb8rvQJA9Y
 ewd0BLUEGcPNscKc8bE9hEJVh9ORwwW36Plv7DZxZdbKK65gnvTJslR62bSNRKGcRjeHIohTM
 wl1u+O4r2Vt7V+q1CjYXyHJsql0LDPhcC/so1c1V4fOBm2vD2OwCCDDP/n5bWofZ78AwcVxKj
 x8LHszvGweJDag9eJvSMRPro6xVm+sQrv5+Mdlsjg77TpfvupK6ld5lvhoYFdSoaD51goUCAN
 OYBBHuqPmWFEjAe5rwe11Dtyty/o2YNattzGGbfOl++txZ7U8/7wwWre3qYMvxxdcjXO6SJjN
 +51+4lWfWityTu1jxawA1vo4K7AklD892UwjEnQJiW5I3VQyb7iacXTABTuJS5sJemRD62ZXN
 L4FZ8v7CMlTJ/xuYSCtRFyPw/I6uGouv/66WVls4MrTpkjSKluG2bcurIvTamnDlfkxFRx0Sa
 wsMyaCbxFkznXR4ndeQmCOOLuHM2ej+GU/3ssnN2XEfY6pxhhF9HtN7vxz9Fcouqo+Rpcfplg
 EUfwXN2uDghK26pdDpStMR59qUGGUWtRoN09NY5wQmfqG31hjyUmrrfaumcNwA5lCY6tv4E7/
 beVtG5s+DhrUD2G2r0SvGdOGW93qNdTwiIlL9KfIViQ+2r1PS0BFh8fiJY3f7wkapgHEFP7Mj
 i1CiUXyEAIiZiHje+r1XHgcRi4WCNlFtprAM9yuU5SHcKklJf0KqUtKVIrpmw1uWEAkE1r6fH
 KmDGCd07Ki91beAs9ji5ul0Vw7PUhSy8Y65vq3VJl0VJIR4tgqMSYQLYRrp8vw3ZqCWszqOHn
 uGr+i5YKm0RvnU/y30bpaivQ==
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

On 02.09.24 00:22, Simon Glass wrote:
>  From my inspection none of the users need the memory to be zeroed. It
> is somewhat unexpected that it does so, since the name gives no clue to
> this.

Though the UEFI specification does not require it, EDK II uses
AllocateZeroPool() to implement
EFI_DEVICE_PATH_UTILITIES_PROTOCOL.CreateDeviceNode(). We should not
deviate from it.

>
> Drop the memset() so that it effectively becomes a wrapper around the
> normal EFI-pool allocator.
>
> Another option would be to drop this function and call
> efi_allocate_pool() directly, but that increase code size a little.
>
> Move the function comment to the header file like most other exported
> functions in U-Boot.

Yes, we should move all non-static EFI function descriptions to headers.
But it makes no sense to move the comments of a single function and
leave the other functions unchanged. Have a look at doc/api/efi.rst.

Best regards

Heinrich

>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v3:
> - Add new patch to drop the memset() from efi_alloc()
> - Drop patch to convert device_path allocation to use malloc()
>
>   include/efi_loader.h        | 11 ++++++++++-
>   lib/efi_loader/efi_memory.c |  9 ---------
>   2 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index f84852e384f..38971d01442 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -758,8 +758,17 @@ efi_status_t efi_next_variable_name(efi_uintn_t *si=
ze, u16 **buf,
>    * Return:	size in pages
>    */
>   #define efi_size_in_pages(size) (((size) + EFI_PAGE_MASK) >> EFI_PAGE_=
SHIFT)
> -/* Allocate boot service data pool memory */
> +
> +/**
> + * efi_alloc() - allocate boot services data pool memory
> + *
> + * Allocate memory from pool with type EFI_BOOT_SERVICES_DATA
> + *
> + * @size:	number of bytes to allocate
> + * Return:	pointer to allocated memory, or NULL if out of memory
> + */
>   void *efi_alloc(size_t len);
> +
>   /* Allocate pages on the specified alignment */
>   void *efi_alloc_aligned_pages(u64 len, int memory_type, size_t align);
>   /* More specific EFI memory allocator, called by EFI payloads */
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index c6f1dd09456..50cb2f3898b 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -664,14 +664,6 @@ efi_status_t efi_allocate_pool(enum efi_memory_type=
 pool_type, efi_uintn_t size,
>   	return r;
>   }
>
> -/**
> - * efi_alloc() - allocate boot services data pool memory
> - *
> - * Allocate memory from pool and zero it out.
> - *
> - * @size:	number of bytes to allocate
> - * Return:	pointer to allocated memory or NULL
> - */
>   void *efi_alloc(size_t size)
>   {
>   	void *buf;
> @@ -681,7 +673,6 @@ void *efi_alloc(size_t size)
>   		log_err("out of memory");
>   		return NULL;
>   	}
> -	memset(buf, 0, size);
>
>   	return buf;
>   }

