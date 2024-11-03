Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E60E67806
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 08:49:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10B3B8908D;
	Sun,  3 Nov 2024 09:49:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="XL2W4N/P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0C43890B9; Sun,  3 Nov 2024 09:49:31 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A8028899C
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 09:49:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730623760; x=1731228560; i=xypron.glpk@gmx.de;
 bh=5hYGBFLyAsGqmGOkV1yq9059XRtjXtqBsyjiyi8i3sM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=XL2W4N/PIedk7eqOw41ZuVcomLj41fwDacyaTteQCwt6N0G0d5006rdQ2qLzixj5
 0ZvHB9CJH+X2VkJm1tupB1jRsnpel5/RLRr87pCI3ViK8jcwDXoXtgXCKv6s7GI39
 n9GmuVNvFS70BnwB/P0yAowKQU9hd1US6hTViNWSHF6N1d8RN7y+z/D91eOotys2Q
 43L2GrcjYKDVetTh6cEsYMFQpnSTRVYt1H2c/O/7tvLIWBGyv2ukHk6KUpHp/1oV2
 674WgsCy8A43N9QkIFOpZoxElQiHkQwqwbOEcmEXqL28GWxaVMzb/EGDezDWmQvrH
 huR2lIRU6xGcEsqeMw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5fIQ-1tDXuE0aIk-00Fips; Sun, 03
 Nov 2024 09:49:20 +0100
Message-ID: <bf24a9c2-31fc-4768-80d5-b2a4dea5cc35@gmx.de>
Date: Sun, 3 Nov 2024 09:49:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/9] efi: Drop the memset() from efi_alloc()
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241103002828.624931-1-sjg@chromium.org>
 <20241103002828.624931-5-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241103002828.624931-5-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sRV9VIxxoh6GxAfIG6y6e24K0Hlzr6p1K0oZvEY412wLbo1EhMX
 GfbCii+m4WcW/c7lS2GLSBigiR/HjjH8aBGc7JybY0pCbR2HLjr+pGU051oWCIfakSE1ZXm
 4sFEZBHFludevNmh8BLur1VOK9CFmZUA1QknMOpjmQuHeqvoG/Z49Rbyz8M2JzhKYBzcWEb
 eXQTSYcteQ9WZleuTSfeA==
UI-OutboundReport: notjunk:1;M01:P0:Uo565MRQ0ZU=;RnHrdrfarFxV2ijM3AGk6lI3pey
 P3V2kDMQaCv+CjfdZVQiWJVNh6iJYKdqtLas/1Ix+0xLkLRNVvLoRuvNr//pgXYfdwShezYRR
 JoHvLaoBgK94a18UCzd1tSXXP9vQe9hdqqE/8dC9sTdndfYs+SBaErVnElf+NokmWBbTkOzQh
 KZFZ/V9iOoQBGORtXOaSTZBTQu5pgu8627f2THjE8XkUUuwpWs22SpI7tVqOlHeEEpn9jWxSa
 Xy98MRaeM+zPr/NQHtmGrkwzQDVgxrZrfI2rcbqNrQNfFmjBLSZ9GRRstTcNgxjkFuNOfYtDx
 0dBquu9ElEgLzDStRMt2uaW50ipSJtThNdfl2VDFL0vihvzIEg5xwDkmaspZOlO41qwEmbUxn
 yxUWNqFCx3t28mCfXvwSsROgAmFGlTAwd5a/REnZJ7+ucXXA95Pa5Vf6RyTHJmit8xIMoyy2v
 HtdiGEGDME4QvmAIIZK34sjxytnRejkPLtW3/IPAceSQgZSqPxSkQrmB1+gtUwFB0zizjCPcM
 seQQBwG1Bk8zS76kdf22wOyviSbBKBcqqtjZ+lAVjCgUEu09/+P4YC5O7rIgUpakU78h1iqFE
 WW5Slm41nt/LjDPohCqZ2I3YWi+l0LYFn772Er8cjqcYGnNZy2RPAITtU0Woo/9JCab+tznCG
 iHwcERw0Cq/u74GMCHh5USjDaXIAWS3NXZ2a8kFUhpxoqHaWWo7GnzHEzgfD7khneppQEIfUK
 mX88fMSwSpkQXehxbGaG3GUaK0ilFbMw1YkCE5kgK5wVwxMHpDyjfXUwikY1dGbpn/5enStuE
 DEohLKqirtAjUesF/GwqeiXQ==
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

On 11/3/24 01:28, Simon Glass wrote:
>  From my inspection none of the users need the memory to be zeroed. It
> is somewhat unexpected that it does so, since the name gives no clue to
> this.
>
> Drop the memset() so that it effectively becomes a wrapper around the
> normal EFI-pool allocator.
>
> Another option would be to drop this function and call
> efi_allocate_pool() directly, but that increase code size a little.
>
> Move the function comment to the header file like most other exported
> functions in U-Boot.
>
> Comments were made in v3 that another project uses memset() when
> allocating memory, but that is not required by the spec. In any case, as
> above, from inspection, none of the users need the memory to be zeroed,
> as they fill the entire region with their own data.

As already written in response to v3 of the series I want to be sure
that code that runs on EDK II does not fail on U-Boot.

EFI_DEVICE_PATH_UTILITIES_PROTOCOL.CreateDeviceNode() in EDK II zeros
out the returned buffer. We implement this function via efi_alloc().

Here is a code example relying on a zeroed out node:

https://github.com/acidanthera/gfxutil/blob/5284a662181ff4b81dd19d1279aedb=
68725b827f/edk2misc.c#L215

Please, drop the patch.

I have created issue USWG 0002487
https://mantis.uefi.org/mantis/view.php?id=3D2487) asking to indicate in
the specification if the returned device path node should be zeroed out
by the firmware.

Best regards

Heinrich

>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v4)
>
> Changes in v4:
> - Expand the commit message
>
> Changes in v3:
> - Add new patch to drop the memset() from efi_alloc()
> - Drop patch to convert device_path allocation to use malloc()
>
>   include/efi_loader.h        | 11 ++++++++++-
>   lib/efi_loader/efi_memory.c |  1 -
>   2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 291eca5c077..f940dc81345 100644
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
> index 2982c45dc38..8b086b165a7 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -696,7 +696,6 @@ void *efi_alloc(size_t size)
>   		log_err("out of memory\n");
>   		return NULL;
>   	}
> -	memset(buf, 0, size);
>
>   	return buf;
>   }

