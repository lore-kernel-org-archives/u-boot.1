Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E71AC27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 15:12:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD96B885AD;
	Mon, 10 Jun 2024 17:12:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="gJ2lJBPs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EAE4885C9; Mon, 10 Jun 2024 17:12:26 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 355BF885A5
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 17:12:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718032341; x=1718637141; i=xypron.glpk@gmx.de;
 bh=+U1jJ5WPqWB0u3FP6pATUmwfykb2IP8kQmACEZElVE4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=gJ2lJBPsnk7i5DgXMpJXzNU+7X2OgsbsBK3Bwq0yKkXE/O08zaN+u++mx/pnIpe3
 WoOEqpzgkGZVL+mUiMmFZMfpht3Hq9cK+3ReTOJ9ga5LHQG8jBLOorD5JGrX8jxB1
 5+D3oZXS162EHCj7qXTMwPcB6f7y9D1SHEB4Mp9CJkqgG4FDaB5UhJiYLxA6CeuCz
 dnjD/lp1nhneTiRphnV6OYY2wZH8TpqzwGehrJxpF17/2Da/S3qrYlYP9bAzcCXiI
 7+LEwKt9OBLIILXmeFwE3TQ7OQbtlBBw3aZeBcL9Q1K7nMYnYFhyD+raOPvGfpLy6
 Ykeg14X4foPbtAs7WQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([109.42.176.212]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mi2O1-1su82e1tiL-00gRLu; Mon, 10
 Jun 2024 17:12:21 +0200
Message-ID: <40cf9c99-d3f5-4851-81e0-9fc7218434e8@gmx.de>
Date: Mon, 10 Jun 2024 17:12:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 15/31] efi_memory: add an event handler to update
 memory map
To: Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>,
 u-boot@lists.denx.de
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-16-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240607185240.1892031-16-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yDtUiYRdQtkV2CD0HmLDKVAHYNrTSl+edgBHJJxbloMxJace2P0
 LXCci7z7JBEgq0UvyRcLkpfTJceosVBfBrTYrRSQh9iyogvu2QH5OFGN8QVJJL29xxK7E0b
 /hD7ltLdAS55qcSG+LkVFhNKNDk4UtswRHQ6Y4+5IZI1lFegs5zHM9aWGppsOWVkjgV1FjO
 U2vzBgvRVi2EZKxTUzEYQ==
UI-OutboundReport: notjunk:1;M01:P0:Qzd0ExkcZPo=;L6ONLRBVcJboVImbnDQiyDFLXjY
 s8wPHFPMM3/5/s+ECIMydwDNHeNN+JSpX9GdeJ+fEHQR9u0Mm8LGf1NNCZDQuGiELnxkqkZcm
 ZmL4rhK+TSu0TkixJ/eIUl4unQOvKER7dE7aoSysth5sQtWhN0jY1J6xhCacbZNXFDhphvwCx
 LtX7/9qHN2C/FsASFXt4Dst4d3ZDJMEA8DyFxLXTFnjH8myxc/EIGPT2VzoN1rI5ShFEcy3gm
 RWf5jwRKLct82PcKj+Ulrk5HuqCwl0XqZFZ6xYpfgbJ9lbDXOb7xBINDKrukcVsLyc1KRf+LM
 UjMRk8agGupabYcUiQNRbGC9qP8hhoakJr21Fa5yDjnNN0vzmqHIcF5eNkQrgmFJQNOxSPt4N
 MtIgCFPlQ2EsXb2h5VaR0N1dii0rgXmCZ0P+lXoHMINEm7LDYJsvG0BKOLwN6ubefOsqFZHwG
 pDtDgzkmeBOd7Jd1scxHPX/Z9prqG7efTWWJizf+EnKl4xvOsuxIKeDzGUwtKAoKQHGPrBmmU
 UaxA72pl0ZC48jnC6bb0PloV7Pv0IsWDpwKmouzAXQ6qkgW9HhI76NTnU7UkDZ17R+Hxvd6oV
 wbrkGeHCjTqnReaMVsBG83PfNTJmyPGu8R6KfcnCugNItnnZsqfRCaxsIzDVMcJaNnHbOdXhc
 GDKiZLKl+qJkJhUEsGO554a0hzGfzNNzYYJXhSkgEv7/quzcaOXGvvWY1uQgD7hTiplH5QEni
 /is+1FvBENMcRxFdIEMkJhukp96SdXljeSVPOA277Chc49u1lyrgqfIw2n9Toihr3RZBspxH5
 JVlvVSd43kQWFIpclVrIHOmJIyYV5lhNwWdVXCw41LvzY=
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

On 07.06.24 20:52, Sughosh Ganu wrote:
> There are events that would be used to notify other interested modules
> of any changes in available and occupied memory. This would happen
> when a module allocates or reserves memory, or frees up memory. These

I am worried about the "frees up memory" case.

When LMB frees memory we cannot add it back to EFI conventional memory
as there might still be a file image lingering around that EFI should
not overwrite. It has to stay marked as EfiLoaderCode or EfiLoaderData.

How do you ensure that if a region reserved by LMB notification as
EfiLoaderData is coalesced with some other allocation LMB is not
requested to mark the coalesced region as reserved?

@Tom

Clinging to the existing logic that you can do anything when loading
files is obviously leading us into coding hell.

If somebody wants to load two images into the same location, he should
be forced to unload the first image. This will allow us to have a single
memory management system.

Best regards

Heinrich

> changes in memory map should be notified to other interested modules
> so that the allocated memory does not get overwritten. Add an event
> handler in the EFI memory module to update the EFI memory map
> accordingly when such changes happen. As a consequence, any subsequent
> memory request would honour the updated memory map and only available
> memory would be allocated from.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>   lib/efi_loader/efi_memory.c | 70 ++++++++++++++++++++++++++++++-------
>   1 file changed, 58 insertions(+), 12 deletions(-)
>
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 435e580fb3..93244161b0 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -73,6 +73,10 @@ struct efi_pool_allocation {
>   #if CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY)
>   extern bool is_addr_in_ram(uintptr_t addr);
>
> +static efi_status_t __efi_add_memory_map_pg(u64 start, u64 pages,
> +					    int memory_type,
> +					    bool overlap_only_ram);
> +
>   static void efi_map_update_notify(u64 addr, u64 size, u8 op)
>   {
>   	struct event_efi_mem_map_update efi_map =3D {0};
> @@ -84,6 +88,34 @@ static void efi_map_update_notify(u64 addr, u64 size,=
 u8 op)
>   	if (is_addr_in_ram((uintptr_t)addr))
>   		event_notify(EVT_EFI_MEM_MAP_UPDATE, &efi_map, sizeof(efi_map));
>   }
> +
> +static int lmb_mem_map_update_sync(void *ctx, struct event *event)
> +{
> +	u8 op;
> +	u64 addr;
> +	u64 pages;
> +	efi_status_t status;
> +	struct event_lmb_map_update *lmb_map =3D &event->data.lmb_map;
> +
> +	addr =3D (uintptr_t)map_sysmem(lmb_map->base, 0);
> +	pages =3D efi_size_in_pages(lmb_map->size + (addr & EFI_PAGE_MASK));
> +	op =3D lmb_map->op;
> +	addr &=3D ~EFI_PAGE_MASK;
> +
> +	if (op !=3D MAP_OP_RESERVE && op !=3D MAP_OP_FREE) {
> +		log_debug("Invalid map update op received (%d)\n", op);
> +		return -1;
> +	}
> +
> +	status =3D __efi_add_memory_map_pg(addr, pages,
> +					 op =3D=3D MAP_OP_FREE ?
> +					 EFI_CONVENTIONAL_MEMORY :
> +					 EFI_BOOT_SERVICES_DATA,
> +					 true);
> +
> +	return status =3D=3D EFI_SUCCESS ? 0 : -1;
> +}
> +EVENT_SPY_FULL(EVT_LMB_MAP_UPDATE, lmb_mem_map_update_sync);
>   #endif /* MEM_MAP_UPDATE_NOTIFY */
>
>   /**
> @@ -275,18 +307,9 @@ static s64 efi_mem_carve_out(struct efi_mem_list *m=
ap,
>   	return EFI_CARVE_LOOP_AGAIN;
>   }
>
> -/**
> - * efi_add_memory_map_pg() - add pages to the memory map
> - *
> - * @start:		start address, must be a multiple of EFI_PAGE_SIZE
> - * @pages:		number of pages to add
> - * @memory_type:	type of memory added
> - * @overlap_only_ram:	region may only overlap RAM
> - * Return:		status code
> - */
> -static efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> -					  int memory_type,
> -					  bool overlap_only_ram)
> +static efi_status_t __efi_add_memory_map_pg(u64 start, u64 pages,
> +					    int memory_type,
> +					    bool overlap_only_ram)
>   {
>   	struct list_head *lhandle;
>   	struct efi_mem_list *newlist;
> @@ -395,6 +418,29 @@ static efi_status_t efi_add_memory_map_pg(u64 start=
, u64 pages,
>   		}
>   	}
>
> +	return EFI_SUCCESS;
> +}
> +
> +/**
> + * efi_add_memory_map_pg() - add pages to the memory map
> + *
> + * @start:		start address, must be a multiple of EFI_PAGE_SIZE
> + * @pages:		number of pages to add
> + * @memory_type:	type of memory added
> + * @overlap_only_ram:	region may only overlap RAM
> + * Return:		status code
> + */
> +static efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> +					  int memory_type,
> +					  bool overlap_only_ram)
> +{
> +	efi_status_t status;
> +
> +	status =3D __efi_add_memory_map_pg(start, pages, memory_type,
> +					 overlap_only_ram);
> +	if (status !=3D EFI_SUCCESS)
> +		return status;
> +
>   	if (CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY))
>   		efi_map_update_notify(start, pages << EFI_PAGE_SHIFT,
>   				      memory_type =3D=3D EFI_CONVENTIONAL_MEMORY ?

