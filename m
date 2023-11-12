Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C76C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 16:22:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D8F686F8E;
	Sun, 12 Nov 2023 17:22:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="eobLAQtM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E37C870A2; Sun, 12 Nov 2023 17:22:36 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5030686F8E
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 17:22:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1699806153; x=1700410953; i=xypron.glpk@gmx.de;
 bh=DRkg+GXzxoOZJL0Tjm8gDNWfEprkFTyu/MYkt3uXosw=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=eobLAQtMdYtqNTDWtDQYPxGOkOAP4i20v2M2tZKu1lx5R0sAO0+wumeaGx8uVhLE
 MXXBOLLXaLYIwvi93HVNh6zL/6RWtZ3YDhlAmGRtGaRjdT61cvYSWiIE12NVez+fj
 8D4X2xR7fgzSaoVfBSxojUEbSM4SEudl4FdReQI/97y+4FMsoP/3vuDAKfEli6DhI
 Sf9WtK3W9I8dgNa1KIlvZBsf1m31JuGDT/SkSmEYOp4X+Xl53e5TaRNIwTe4y+7dI
 tIBADHI1fwvqCWr1XUW8p6JIsmOVR3aSUg1dV9l2lAIzt26HqqQHfDVX5GoMlO7G9
 4szHU4mxvqMQtCuvgg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwQXH-1rKyy53Mxx-00sNwk; Sun, 12
 Nov 2023 17:22:32 +0100
Message-ID: <141b3e06-2383-4fd4-929b-520a6c7c4af9@gmx.de>
Date: Sun, 12 Nov 2023 17:22:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] efi: Collect the ACPI tables in the app
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20231112155808.135585-1-sjg@chromium.org>
 <20231112155808.135585-3-sjg@chromium.org>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231112155808.135585-3-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bvyc66zmo6eHrECDZ+WQbfYH1qDAfDwW537LyxcOvhZfJ2BQJDQ
 o1EACgODAR/gFw21/ra4YkR0j+qrb1rbP+RkoCT+6k8gTFz8jnO+gqe7/3MzEIzh/nc6JmX
 sO4pundthNSdJCzcwwrz7LsQMpMYCpyr+GJf51ouGZ8Cn0G25jmrrl2Vp29/WSgEjTdP7fq
 XPdbI4zasj5ljj0yHyAug==
UI-OutboundReport: notjunk:1;M01:P0:TjPiG/zQ0MM=;b3CIQLKwazwWXkGLX0XjR3jARtK
 fSdR4DZNtTSSEb7RfFlygPCp25qkktybEJlRBUWRBhSrxj/Q06kHcsYqkERplV2E4oPZzUYfl
 o+QhdXrkfmTyZv3fPjimmaSrCuUx7QOVBCdg+bwMhNdmEcv9qv3hgP8IbXraeDuT8cVFstX79
 wjHWgW0NbtNQYhtCwKfUDFCgWJ5bN2pD9ABSthiJxPZyHWDZnGgzlqf0HOtQ/ceDI/faevGpW
 i1sAm90pymdBxB4tZrw/rq/WxrKphUTJS5n4cagCyaHwjeSpDbB1tZU71X3tMg10HwCWEcfee
 pUWICQmC0dmm5HsWlUbb4VmmYhRruPoY/6/zNa3PRINqrAGMrKVwN0UC8sD0pyS/KdxWfnUpy
 XDDG+ik/rqx/XMZUwZYMKeLzfUtNJoTuHj+r/l58HNcEwvkx+l+5B//0gbod5TW8xSDh/nl2w
 1k02v7EcFeu9FPRz683ocLg5Pjrit856ncn8368VG6Ajx6njK1jmZ+7r9mHQNrBnZl+RTsQ2W
 NSAZTk3Ps3Lmv2CKikZEqlUgjsi/Zz+7IOpe9k4s/kmmU6Gt968N7qBdz/+LVadMheqtJVkSq
 LkkQofb2CVM5VXWq0QxvHcD97aeI78ACepzZVHr6VnP8KrYEann1TvHJZ2PP0ywSau0tImMeU
 vF1gHRwyxcK32oLRRp/VZMsEfRpkZ8rK21g5dekOoxwjVw8OB7sgeNxOcCPWKOgkITJcKM2zS
 En7vo4ZGKhA8t7Le9zvCPRrZ6OJdffc7lHlqINM6BoklxVl3ZJuTLrz2bmqM+J9J9gqKAhlD4
 bHfayqUR7NsDH5MQK1VKDJG4DzldMQ31R399vRZikUEvZsxOvIjkqlus43aKCh8BEhHaZ9/u8
 NRC/TpX/AooU+Eqh51fk/zMv5Az0xpqPatLzU1+n2HSCk0Nh5OMhhxFD0Mrx4Rp6DvXkzqUYm
 7979/BcSldvOWVw9aIRpa8Mloc8=
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

On 11/12/23 16:58, Simon Glass wrote:
> Locate these so that they can be displayed using the 'acpi' command.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   lib/efi/efi_app.c | 24 +++++++++++++++++++++---
>   1 file changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/lib/efi/efi_app.c b/lib/efi/efi_app.c
> index 2209410f35b5..c5eb816655ea 100644
> --- a/lib/efi/efi_app.c
> +++ b/lib/efi/efi_app.c
> @@ -12,18 +12,21 @@
>   #include <cpu_func.h>
>   #include <debug_uart.h>
>   #include <dm.h>
> +#include <efi.h>
> +#include <efi_api.h>
>   #include <errno.h>
>   #include <init.h>
>   #include <malloc.h>
> +#include <sysreset.h>
> +#include <uuid.h>
>   #include <asm/global_data.h>
>   #include <linux/err.h>
>   #include <linux/types.h>
> -#include <efi.h>
> -#include <efi_api.h>
> -#include <sysreset.h>
> +#include <asm/global_data.h>
>   #include <dm/device-internal.h>
>   #include <dm/lists.h>
>   #include <dm/root.h>
> +#include <mapmem.h>
>
>   DECLARE_GLOBAL_DATA_PTR;
>
> @@ -320,6 +323,19 @@ int dm_scan_other(bool pre_reloc_only)
>   	return 0;
>   }
>
> +static void scan_tables(struct efi_system_table *sys_table)
> +{
> +	efi_guid_t acpi =3D EFI_ACPI_TABLE_GUID;
> +	uint i;
> +
> +	for (i =3D 0; i < sys_table->nr_tables; i++) {
> +		struct efi_configuration_table *tab =3D &sys_table->tables[i];
> +
> +		if (!memcmp(&tab->guid, &acpi, sizeof(efi_guid_t)))
> +			gd_set_acpi_start(map_to_sysmem(tab->table));
> +	}

Should we have a function efi_get_configuration_table(efi_guid_t *guid)
that we can use to retrieve different configuration tables?

This would allow us to read the device-tree on non-x86 tables.

We may at some point also be interested in reading the
EFI_RT_PROPERTIES_TABLE to find out which runtime services we are
allowed to call.

Or would you prefer to all of this into scan_tables()?

Best regards

Heinrich

> +}
> +
>   /**
>    * efi_main() - Start an EFI image
>    *
> @@ -354,6 +370,8 @@ efi_status_t EFIAPI efi_main(efi_handle_t image,
>   		return ret;
>   	}
>
> +	scan_tables(priv->sys_table);
> +
>   	/*
>   	 * We could store the EFI memory map here, but it changes all the tim=
e,
>   	 * so this is only useful for debugging.

