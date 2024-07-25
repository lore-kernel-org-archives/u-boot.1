Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F42C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 16:21:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E316587C7E;
	Thu, 25 Jul 2024 18:21:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="IsOmMNYH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B65D8800C; Thu, 25 Jul 2024 18:21:06 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2E378811C
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 18:21:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1721924455; x=1722529255; i=xypron.glpk@gmx.de;
 bh=N4Aq1vgCtDQGWJMvDRFYIlcPrwDCGBfvMdu4f/SeId0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=IsOmMNYHxC2BwMh9ULzxhhgM4AMkReoYHGBCkLeAKXGj3j82ib73Sk1e5th2PzAi
 jrVKdCRhP4PtPJgQ9tSGM3ac0xeG9mJQEktNb8Umqi2/qV9TUBLE0/ApoGZLLn8ce
 +m+lm3vgHT/ZEjEO4usiYEwcVx7CgU0JU2aZcYa2yFdqLhvCvpaTWvV1at9dfCH0Q
 L0fo2ep7Y5IEr8S8gqYnhlF9zqwoZrUkuC7aoLDJzlMfQZqgbxN99TRxikkf+Vipg
 p09QpAVMJoQpYHQtEGfl+JzDoQSLO7oj35sKGURYAdnynmhjfVe5IcsFQTrDR6r/+
 Doa3eG6gmElR/7JeFg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([62.143.93.80]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOzT4-1swE6U3OP6-00IQKw; Thu, 25
 Jul 2024 18:20:54 +0200
Message-ID: <f499b8da-61dd-488d-ab86-bd71c0eb94dc@gmx.de>
Date: Thu, 25 Jul 2024 18:20:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] efi: Allow monitoring of page allocations
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Joao Marcos Costa <jmcosta944@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, =?UTF-8?Q?Vincent_Stehl=C3=A9?=
 <vincent.stehle@arm.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240725135629.3505072-1-sjg@chromium.org>
 <20240725135629.3505072-4-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240725135629.3505072-4-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jV2CXMp/hthzCNiLGkSDCYmJXSURShs1bZ07wx7NTm3EEkKbQOL
 Iu0WnbRX6kbffmPHw1UQrW9ndRtY6sv6azhIX/uYzXqCx1Uz/T+2sayMyE5TEoMOKzcDGva
 9OiwrdR4hJ93S//uv2cDZNSRqGlwK8alDF3Tev2K8q4evuNqia779SYJtnSi2NOgXoocnaC
 XGzJgv5hG1GhBEv3hV+OQ==
UI-OutboundReport: notjunk:1;M01:P0:gwnivsfLef4=;knpN2Sa/pli4Ap/+QPfO9fqYapl
 nwkHVnHd7OqiuGtGxQbT6xxFmCyqDwcPgW9wCMrllq4JwvLIP8nY2ta263G3cA72csZmc0Lye
 l3var30nJKlD7QUl6jwOXg9awP0QeoZ1Bi9XFM6TCFP/IJVnJDkQQjXfxh4fjVW0EMD+BT9C8
 rz9cMzORE9bZe4suj1zZk/AOVOgth/i71xVKRCUNzD4jg5y2/JVn8JzAE97UtG8Pr4RBmjCnx
 i3oD9Mein/OCUCPiJYi/rQCz7DiwkUn7mHmhGOizBQ0igwYRwsu82ej691M/KKiGJtIp3oFYg
 NUQKrHF7Je2EMN/1gizFJ6DFKzFOlgJPaTx7VRJ6nG2RDbwbLZuqTAxtC1kr3Rt7iZH8/dfdF
 jZRSK5rBRurp59t0sEq0yatnAM4HK8Gsi9LxipSrYJzFWPVmVIyxKMWxTW2rMs4InhtlYyZkp
 RWaO3es9vtRRKOcWYFjn19kLUD+BehQ6GZDB3+zfaJ4E9+gfG+ZDBQ+XPYcENRnOEukcV8n9V
 kmz6obRaKmHYTzYwPGGQtZFzPh4PB5xrfwenAeWzzFJLcQV9a1ajlyCdJChwFZxDvcUlUPF/d
 5UBkitmw3Q1ql2N6zXeEOcdqiUyqlmhnFiADfQODL07Bo5r1mpGujCy1MRGzrn2kG9AdAzwQA
 WYUTh2eYAcvNpBcC7/RdD51Q8v8B9VwPUhihoSUGvpaHa82jF2jh9r7gvfBEwVSD/jSW9u50Y
 VlS89wjz8GRH3oyn5vN1ja5J7Jei0wcYOi5rAk/58qrX9mz9RZ/KooqZjl7Vh8C0lQ0739q+X
 pDqNt3dRgQHlUUZNxjp2rPWQ==
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

On 25.07.24 15:56, Simon Glass wrote:
> Some confusion has set in over which memory-allocation method to use in
> EFI-related code, particularly for the pool allocator. Most of the time,
> malloc() is used, which is correct.
>
> However in some cases the page allocator is used. This means that some
> EFI information is sitting 'in space', outside of the malloc() and not
> allocated by lmb. This can cause problems if an image happens to be
> loaded at the same address.

We already agreed to resolve this problem by integrating LMB and UEFI
memory allocation.

Please, contribute to reviewing
[RFC PATCH v2 00/48] Make U-Boot memory reservations coherent
https://lists.denx.de/pipermail/u-boot/2024-July/557962.html

>
>  From what I can tell, there is currently no checking of this, but it
> seems to be a real bug.
>
> Add a way to control whether allocations are permitted, to help debug
> these sorts of issues.

Calling AllocatePages() and AllocatedPool() cannot be forbidden as we
want to comply to the UEFI specification.

Best regards

Heinrich

>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   include/efi_loader.h         | 24 +++++++++++++++++++
>   lib/efi_loader/efi_bootbin.c |  2 ++
>   lib/efi_loader/efi_memory.c  | 46 ++++++++++++++++++++++++++++++++++++
>   lib/efi_loader/efi_setup.c   |  7 ++++++
>   4 files changed, 79 insertions(+)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index f2e5063a970..187078adf55 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -797,6 +797,30 @@ int efi_disk_probe(void *ctx, struct event *event);
>   int efi_disk_remove(void *ctx, struct event *event);
>   /* Called by board init to initialize the EFI memory map */
>   int efi_memory_init(void);
> +
> +/**
> + * enum efi_alloc_action - action to take when EFI does a page allocati=
on
> + *
> + * @EFIAA_FAIL: Fail the allocation and print an error
> + * @EFIAA_WARN: Allow the allocation but print a warning
> + * @EFIAA_ALLOW: Allow the allocation with no message
> + */
> +enum efi_alloc_action {
> +	EFIAA_FAIL,
> +	EFIAA_WARN,
> +	EFIAA_ALLOW,
> +};
> +
> +/**
> + * efi_set_alloc() - Set behaviour on page allocation
> + *
> + * This is useful for debugging use of the page allocator when malloc()=
 should
> + * be used instead
> + *
> + * @allow: true to allow EFI to allocate pages, false to fail the alloc=
ation
> + */
> +void efi_set_alloc(enum efi_alloc_action action);
> +
>   /* Adds new or overrides configuration table entry to the system table=
 */
>   efi_status_t efi_install_configuration_table(const efi_guid_t *guid, v=
oid *table);
>   /* Sets up a loaded image */
> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> index a87006b3c0e..07c8fca68cc 100644
> --- a/lib/efi_loader/efi_bootbin.c
> +++ b/lib/efi_loader/efi_bootbin.c
> @@ -201,6 +201,8 @@ efi_status_t efi_binary_run(void *image, size_t size=
, void *fdt)
>   {
>   	efi_status_t ret;
>
> +	efi_set_alloc(EFIAA_ALLOW);
> +
>   	/* Initialize EFI drivers */
>   	ret =3D efi_init_obj_list();
>   	if (ret !=3D EFI_SUCCESS) {
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 12cf23fa3fa..087f4c88cdf 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -24,6 +24,43 @@ DECLARE_GLOBAL_DATA_PTR;
>   /* Magic number identifying memory allocated from pool */
>   #define EFI_ALLOC_POOL_MAGIC 0x1fe67ddf6491caa2
>
> +/*
> + * This is true if EFI is permitted to allocate pages in memory. When f=
alse,
> + * such allocations will fail. This is useful for debugging page alloca=
tions
> + * which should in fact use malloc().
> + *
> + * This defaults to EFIAA_FAIL until set.
> + */
> +static enum efi_alloc_action alloc_action;
> +
> +void efi_set_alloc(enum efi_alloc_action action)
> +{
> +	alloc_action =3D action;
> +}
> +
> +/**
> + * efi_bad_alloc() - Indicate that an allocation is not allowed
> + *
> + * Set a breakpoint on this function to locate the bad allocation in th=
e call
> + * stack
> + */
> +static void efi_bad_alloc(void)
> +{
> +	log_err("EFI: alloc not allowed\n");
> +}
> +
> +static bool check_allowed(void)
> +{
> +	if (alloc_action =3D=3D EFIAA_FAIL) {
> +		efi_bad_alloc();
> +		return false;
> +	} else if (alloc_action =3D=3D EFIAA_WARN) {
> +		log_warning("EFI: suspicious alloc detected\n");
> +	}
> +
> +	return true;
> +}
> +
>   efi_uintn_t efi_memory_map_key;
>
>   struct efi_mem_list {
> @@ -501,6 +538,9 @@ efi_status_t efi_allocate_pages(enum efi_allocate_ty=
pe type,
>   	efi_status_t ret;
>   	uint64_t addr;
>
> +	if (!check_allowed())
> +		return EFI_UNSUPPORTED;
> +
>   	/* Check import parameters */
>   	if (memory_type >=3D EFI_PERSISTENT_MEMORY_TYPE &&
>   	    memory_type <=3D 0x6FFFFFFF)
> @@ -649,6 +689,9 @@ efi_status_t efi_allocate_pool(enum efi_memory_type =
pool_type, efi_uintn_t size,
>   	u64 num_pages =3D efi_size_in_pages(size +
>   					  sizeof(struct efi_pool_allocation));
>
> +	if (!check_allowed())
> +		return EFI_UNSUPPORTED;
> +
>   	if (!buffer)
>   		return EFI_INVALID_PARAMETER;
>
> @@ -952,6 +995,9 @@ int efi_memory_init(void)
>   	/* Request a 32bit 64MB bounce buffer region */
>   	uint64_t efi_bounce_buffer_addr =3D 0xffffffff;
>
> +	/* this is the earliest page allocation, so allow it */
> +	efi_set_alloc(EFIAA_ALLOW);
> +
>   	if (efi_allocate_pages(EFI_ALLOCATE_MAX_ADDRESS, EFI_BOOT_SERVICES_DA=
TA,
>   			       (64 * 1024 * 1024) >> EFI_PAGE_SHIFT,
>   			       &efi_bounce_buffer_addr) !=3D EFI_SUCCESS)
> diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> index a610e032d2f..27e24c2f223 100644
> --- a/lib/efi_loader/efi_setup.c
> +++ b/lib/efi_loader/efi_setup.c
> @@ -193,6 +193,13 @@ int efi_init_early(void)
>   	/* Allow unaligned memory access */
>   	allow_unaligned();
>
> +	/*
> +	 * For now, allow EFI to allocate memory outside the malloc() region.
> +	 * Once these bugs are fixed, this can be changed to EFIAA_FAIL, with
> +	 * the allocations being allowed only when the EFI system is booting.
> +	 */
> +	efi_set_alloc(EFIAA_ALLOW);
> +
>   	/* Initialize root node */
>   	ret =3D efi_root_node_register();
>   	if (ret !=3D EFI_SUCCESS)

