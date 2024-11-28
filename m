Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FFED70DE3
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 16:59:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15E1B89D16;
	Thu, 28 Nov 2024 17:59:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="XKMFix5s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FD9F89D18; Thu, 28 Nov 2024 17:59:44 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D2F889C67
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 17:59:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1732813178; x=1733417978; i=xypron.glpk@gmx.de;
 bh=+8bOl1HSMgg6NRzfUF8XqbymrOHw1XU0G9BDzHeOqZM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=XKMFix5s/XMKDnwR3vFXqDQZQ8WKB9M9asIBnVvq1u5pntLpaoE5Zc8zgZGZTcFv
 wXCuyaPKLf1C782oXg3cnu7CPc2/neZbDuUYOhvCTo49ZYH8d7cKiJSexF20DytlZ
 ZMG6DMAIVi4PdhL+1RGf+KGLPWbN0imlvAixQQ+ZoXb4oLGsMJaWouRTPpOn/iLBU
 tkcNL2JVHop/gaSaEZFLtGATe9rM87KPaG0ASIkcirCWpy4Gb3e+a2Mn3WUXFEJwB
 mm6g1mZCApU7dTBKc/QUUFpusAM81oqVM2TP4+7/Yj69EiJq1OppBqKgRUrDkt4jv
 2xb7LfGFgWM+EJMjCA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0oG5-1te22O3IJB-016mNm; Thu, 28
 Nov 2024 17:59:37 +0100
Message-ID: <e1dfadd0-8c26-4daa-b775-4e176ee1a2b6@gmx.de>
Date: Thu, 28 Nov 2024 17:59:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/28] efi: Define fields in struct efi_mem_desc
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241128154727.771871-1-sjg@chromium.org>
 <20241128154727.771871-2-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241128154727.771871-2-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xjL5xqTOmIiEaJD2e63tEXO15/+5iyYwbGA8wqEK15OwyVi+dTp
 xdlemgiR9g6WyRJmp0vSdgfpaKD9Z/kCq0JG33zcyNqwcm849SgrUoPmWc8evJJW+tWWY34
 hASCCTbPv0NJAbDM8Yepfrdoj+CD9vPXahapoNu+v4FKIRzcsSzj++Sbt5JqV01/BAB/zRY
 zDgYb/wQLS+OjD1CmfQYA==
UI-OutboundReport: notjunk:1;M01:P0:q9ltUui1fBY=;a54C6wZSScoN+WI0SYResWZOa0g
 cJo1Dzc39gP+nf5NQhX5EvV55Ko2Ldw8Be3KP+bSzVy7Dpd84IUU6IJ04jGRO0R/z8P+Pg6JC
 IMwtnGIGjnT7VRp5jL4QAHA1TeSoNPjTB0G7s1G/yCiPPbLwZzVyd8F0+175BZ/WGRSXOkVco
 eR6O+7W1p4hyuuMWiQK/AoaCvpXdMD2YoN6Fs7sdmd5zPwXJ7OHd+nNj5lCl/5yCzKs8587AC
 +ifJNn3NtTm+B0zfbafbqkTM3yrRZgI8jB232+4nPNFCvhhZE2GBoF+JhMt2bbnOFTituRtw5
 HErWn688tQLCV2SNMdMVsC8BBMZAGKI1HCV+8IEINFHwD1TOXmK6KWH22XIcQjWzSHxQ6efCt
 6TFN4A5ai8c4vT9vycTw88tB/2dXIyJVpF2rMjQuZer1LfViRt1zSOMZp5f5PG6dV8vHdA+A5
 09GxQfs37u8yT/mWjMN4jEOTA6rU44BvpD9hVsR2BxUMdlJwys2AIBDX2bQ560SH2HCSgxuYl
 Yu2uHQiVprDRY2hvHi/m0yi8zyNDPTWitz81APqGIVzOdeANtjyTr35yiKE7gv5fijEqYA4LQ
 ETMW3evdaoy+UfIHt0EknPwvyJUJSpRKYk8UDcqYhzGBJqW3tWNiO0BJTGS3eTY4fvYA6iICO
 8Esl83Y6fSbxUrbHIfUYMWJmae7s9k/LzSmmf5gIM8gVu6gKXGn2taxxlny+6DJL8xL9lPWMg
 vUBjngbq3Zkx1Fu9PoK8nIHxFxkm0d2Fk1dXZoRcf8SSSnbYqyKnO5jpiOYKWPxFKutKrk4pb
 +t/z57q+kzblqCV4A1Od/JRnxhFlkXpwm62gshWnGqo+RTYYf0zzZw+rRe557kJNi8DzAKcgi
 id8OMRjyqFh+SDsi6JeSj8yaxRvgyMrPKHWSpTmNKSlqk7njnpNadbWfUwHrb7xry7fEEYZjT
 nM8ItyOfplczkDRfHDufXg2QpkYV4lCUAK6Cyly/iyDXaqCYEtWN4ZSueYiL3pUN9lW5H8K+0
 FXac9YTp+LHjXH2xQIJa7HYw6m4vFlpI3vcvNmuKpeFSbrn4PeFW011/p5KCu353VWjbAw2bz
 TIN/SAM8yUxHw3aLGlNVrZbbiKdr5K
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
> There is quite a bit of confusion in the EFI code as to whether a field
> contains an address or a pointer. As a first step towards resolving
> this, document the memory-descriptor struct, indicating that it holds
> pointers, not addresses.
>
> Dro the same for efi_add_memory_map() as it is widely used, as well as
> efi_add_memory_map_pg() which is only used by lmb
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v2:
> - Fix missing @
> - Note that this holds pointers, not addresses
>
>   include/efi.h               | 15 +++++++++++++++
>   include/efi_loader.h        |  6 ++++--
>   lib/efi_loader/efi_memory.c |  4 +++-
>   3 files changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/include/efi.h b/include/efi.h
> index c559fda3004..3fce281233c 100644
> --- a/include/efi.h
> +++ b/include/efi.h
> @@ -273,6 +273,21 @@ enum efi_memory_type {
>   #define EFI_PAGE_SIZE		(1ULL << EFI_PAGE_SHIFT)
>   #define EFI_PAGE_MASK		(EFI_PAGE_SIZE - 1)
>
> +/**
> + * struct efi_mem_desc - defines an EFI memory record

Please, add here that this structure implements the
EFI_MEMORY_DESCRIPTOR type of the UEFI specification.

> + *
> + * Note that this struct is for use outside U-Boot, so the two 'start' =
fields
> + * are pointers, not addresses. Use map_to_sysmem() to convert to an ad=
dress, so
> + * that sandbox operates correctly.
> + *
> + * @type (enum efi_memory_type): EFI memory-type
> + * @reserved: unused
> + * @physical_start: Start address of region in physical memory
> + * @virtual_start: Start address of region in physical memory

%s/virtual memory/

where both addresses will always be the same before
SetVirtualMemoryMap() as the UEFI specification requires identity mapping.

> + * @num_pages: Number of EFI pages this record covers (each is EFI_PAGE=
_SIZE
> + *	bytes)
> + * @attribute: Memory attributes (see EFI_MEMORY_...)
> + */
>   struct efi_mem_desc {
>   	u32 type;
>   	u32 reserved;
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 39809eac1bc..ee0cdd36500 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -788,8 +788,10 @@ efi_status_t efi_add_memory_map(u64 start, u64 size=
, int memory_type);
>   /**
>    * efi_add_memory_map_pg() - add pages to the memory map
>    *
> - * @start:			start address, must be a multiple of
> - *				EFI_PAGE_SIZE
> + * @start: start address, must be a multiple of EFI_PAGE_SIZE. Note tha=
t this
> + * is actually a pointer provided as an integer. To pass in an address,=
 pass

%s/an address/a sandbox virtual address/

> + * in (ulong)map_to_sysmem(addr)
> + *
>    * @pages:			number of pages to add
>    * @memory_type:		type of memory added
>    * @overlap_conventional:	region may only overlap free(conventional)
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index e493934c713..f1154f73e05 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -384,7 +384,9 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pa=
ges,
>   /**
>    * efi_add_memory_map() - add memory area to the memory map
>    *
> - * @start:		start address of the memory area
> + * @start:		start address of the memory area. Note that this is
> + *			actually a pointer provided as an integer. To pass in
> + *			an address, pass in (ulong)map_to_sysmem(addr)

%s/an address/a sandbox virtual address/

Best regards

Heinrich

>    * @size:		length in bytes of the memory area
>    * @memory_type:	type of memory added
>    *

