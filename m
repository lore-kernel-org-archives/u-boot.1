Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC16DC25B76
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 10:17:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DED5885C7;
	Tue, 11 Jun 2024 12:17:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Z3d5Rbs/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC888885F6; Tue, 11 Jun 2024 12:17:22 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BADD287B30
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 12:17:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718101037; x=1718705837; i=xypron.glpk@gmx.de;
 bh=DknLu4zo1UWZz+29VdgDHePOsXVl3eemQmjf4v7mPOM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Z3d5Rbs/FnIe0luwZ4WQFsmnXDpFQEkys1Qfh/SX1WOL4eQwqP4uNzju8FVX11zo
 SmmunyuzFaUJNNxmtuqZi3Ppwllggp8G6sH2IugJmPv1zZf7xkgR9NKwpZ5Cz+FC8
 gLbAp0tO91+HjiBcRUaUM5v8jBxwfeGwL8QhmLWRkNCQhwbwSlCDtgOIdqTJ0xyr5
 qwjqZa2eYoDEYTDQipgvcvo5DWZfwA9zadvTukSx7EHoRCY+wg31Nboy+Ur4ft42w
 94/kmVClWhcYSoJmdZjlLvhyte4onclnNJ6W9zqPPliGfZmpKin6BQ5ybnq08NUkq
 r328pj266++dRw7o1A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([109.42.176.212]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MowGa-1slLpT1pSo-00ohJA; Tue, 11
 Jun 2024 12:17:17 +0200
Message-ID: <50d0efab-0df6-47ef-a4e9-b0e3d6ec2556@gmx.de>
Date: Tue, 11 Jun 2024 12:17:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 15/31] efi_memory: add an event handler to update
 memory map
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
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
X-Provags-ID: V03:K1:8O/NVWWeZCWySzlY2WLSi5y8+3L/amc2NGKzXk3YCo4pC+0UJsQ
 DAn6JZwEPnCyD0eNPa6mfkUhrdeFxpzpF7B0uPWfLUwDNj6LI2SQWQsuD3ZriPV5off6607
 ZHU0IwY6iPQzqRnHxic/zYmIXr+NoWLAZueeGWs7sIX1xJOEuPgzyVdryX9z18aIUVs+9c6
 4ZkgoHFwiw6cGz1LtBmGg==
UI-OutboundReport: notjunk:1;M01:P0:Fhxw3YyxMkk=;gU4j5xF59l2eiLvFhUDLyNiiiKK
 vA3Cr9sjtsOZdKY0rXB8fotKnZBjeycJ6OiPCVeInWS1MKzDgcv1VnEnwYoUTZ4NRd+ew/Ybj
 YXQmK9ZibQ9FT9e/sVy9Y6pPcS2Wkpy0Xz8fdd0nk2nyHLdWk/VLk6qmdcaIXfwXb3mx8dQeU
 kMb7L94BrYOXC3r8CSoz38kNKbfLksVQZeFo171qwBbCujE9piMENhaKNX38kWsjlIforYMtM
 +lHlDTJ1ORr26hZazvdKgNJIH/cOY1cyAOEo7mBiQHdt223dTr4w8zB6092mo94hzKTh1CI+B
 iu5epf6A10hB93/xcVm+R1nQ57WJdEsIRJesPts8K0cDv/ARMKs0FipJWrp46l6BB//OCHQ2r
 kGFss+Rm++7nzLEMq43GwLj1FN371fpCjViSwVEv1zCz4SK7fx8oA4J48ZFzjAWeBnZRLfui7
 lVTp/SYh69mUW0SHueuvyZCUOvc5BFbCAd5uw8C1p2Y+U7AlC8PtWham1YyOSflkJ5miV4gnl
 X+tY8SMWYH22yQPxpsXb+TYruTUYbDXVKYg7PIZ6blRkBrtF5S2hDPrR844kueSOthYJ7T3Kz
 ddvF/wji8hGwKfdTlZJbnl5LMzWF4VHsd03LBoY+7oMsKHm5CPGqqPqF7SGG/sebfo6UFkyvc
 ijwmVXm77NDICKO4S5AUZtdSMI8245uhmF5wU5c6lR1AvW2qaiNB4raa62pu6HEm/Y6y8Ei5k
 vn72ySXrmqkh8XOpW7RQ8a1HvsKfUiddsLrKS2yF0VDMUYm4YnPjdnLLYl7fQkUZNGuCNHAQL
 07r5jOgfAIyeTlsPtj+m3Wq/Sy/y4U1alOOWnNYmx0eVg=
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

This is dangerous. LMB might turn memory that is marked as
EfiReservedMemory which the OS must respect into EfiBootServicesData
which the OS may discard.

E.g. initr_lmb() is being called after efi_memory_init().

Getting all cases of synchronization properly tested seems very hard to
me. Everything would be much easier if we had only a single memory
management system.

Best regards

Heinrich

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

