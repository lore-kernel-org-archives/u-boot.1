Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C699E95A8E
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 01:47:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4257E86D78;
	Mon,  9 Oct 2023 03:47:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="TfRE8wuP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DDC686D1C; Mon,  9 Oct 2023 03:47:32 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0EE086C58
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 03:47:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1696816049; x=1697420849; i=xypron.glpk@gmx.de;
 bh=xHNNTHz+P/n4qzLVcGdri+o/QZ8/uxVaQJ5f7sUwLag=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=TfRE8wuP/OdtSnVZeadpFnVEW5itTYoz6Iqn7j7zbJCFSt9kzitk+PXcVVPrEURdwikrD9gusrL
 VjHfEiqjXTWtZ59IsWhhO+vQGEqkVjAhh+S0087kjavRFGE6ulzMO3mDb/ZsAIfgSL3gJzsFgJvhq
 fCcgba2l/4CjPhaNMLJvhGRp/tpo4pesBSQnACBN+Xzvt2XMfuj0Cm31OhpLNqVnEmZ/9IQUbLNa2
 UDKanMYkNCEnObR0xI5Xr+ODP7F2yCTbwi+fsxvvlBX3+ZUKstIsHGDNa+PaNxnKWAN9eNGtldAac
 LzEOgArgSR1k9Kcyu99LvXuIqIUmIQM2ieDw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQv8x-1rBr553Zep-00O2lN; Mon, 09
 Oct 2023 03:47:28 +0200
Message-ID: <45a89ca7-0e70-4fe5-b757-4f7b0dcbec08@gmx.de>
Date: Mon, 9 Oct 2023 03:47:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] efi: Use the correct GUID for the SMBIOS table
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20231008213646.622002-1-sjg@chromium.org>
 <20231008213646.622002-5-sjg@chromium.org>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231008213646.622002-5-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cJ6XSSX1I9A6oguZ+QB+X84Sn9ohv8+velUm57MbTi23aGYsCqr
 MT3U9T8tKDZNOYeikiJqLFR977a8T0SUl7Ps+XUoKNeysJEAZnJEKadTuuxgSwF86KNyu/o
 gF+ZEywaCqzLljm4vYVJ3P62steYPy1xhQ8jBraEcitaWnVN9GVupd+tTymkwX15nC127sY
 4jh/LiTveUhKGmXtns0tw==
UI-OutboundReport: notjunk:1;M01:P0:3O5+v/BmwsE=;13/K4WOm6pa/yxrCNuwdyX8l4am
 7UZTWaxq2B/QsN7dANhv12u5667jS7ei+s8L9SUJNeDWrWItidejMjTx4nAW7CFVtXSL3EYAM
 2JANV/mZDAKnrFF2AoKfqICHAS8oHNpLyUL1uxVhJfN54dSnAVqEkxcjoZMfyGFHYPb6JVhiz
 1qh7yJpiNUf6Sb5YsjDdFf5NBJ5gSagPz+8kROdYPs4i/xFVMA4xI2TfcHW8UhyH1/xL6XMQz
 M10FAuiB9SFUNt+Nspm+3o/ausLDhDHo5u/DYjhguYfP858nu4oBJrt0eeExYf8RTwlFQnzOC
 taqaxsLVfvzkHQsvUN6Vg39yF2r8mssGX8d3zzY/IkkEbt0/r5VA4/XvKZLy3eHywrOzoVTA6
 K7Agrm2VDnvgaBLQg4gvY1xCQhMmevuL5DxCdo2z+yAJN1khJ2tGPmes3DvTg1dvAwu8uE9By
 D2jxwbI5+OzV/rqBM+yTFgEwQBMdtllzWsPuGcC3Q1IVcbXZrMz3m0k60cYCDbK7wvXhjtqGl
 dYeYkzRYN7zFOx7kyHjTpIG0/CXZUNiivgeN+aE4L3xVXKCcmGD8e25A0d0jUvg8xwr6zv5Li
 64/hHVmCIG6x3Vd8pw8pFGH1S/XcMaBDTLURHH75UAbf54M0FHdNARtkdYP4iL6XfoCDuEWEf
 Z13wqnf0qj6cruwBQcyrqsWlgvgXOCU+oBNLx/3yjkQYzw/6ntQsCBeIyOS2rBlBmmM5uuJFZ
 UYXoElB8qkDZICH5JG3WpynuDKyKtMORzH3MVfKUzjhCCWOps7gHP7/z4chegW+mHzxwROlte
 qmjTl8c3Yv0tzRFDnPAp7yM+yegdzuoqcnxescMcfubnLg3uXV6FiFN5litkgjKkq5iOYYAMy
 ZR87+B90SN6McMBp23TjJcvKW1MN9HtYOSuCghY0SFfszgsBh2aLbd2Y7SCVSp5YC0Y43z9ia
 VymZsTH11Hq44u1YTD+bgDM3YbE=
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

On 10/8/23 23:36, Simon Glass wrote:
> EFI does not use the 'anchor string' to determine the SMBIOS table
> version, instead preferring to have two separate GUIDs. Use the correct
> one, depending on the table version.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   include/efi_api.h           |  4 ++++
>   lib/efi_loader/efi_smbios.c | 12 ++++++++++--
>   2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/include/efi_api.h b/include/efi_api.h
> index 8f5ef5f680f3..1abac2ed7563 100644
> --- a/include/efi_api.h
> +++ b/include/efi_api.h
> @@ -430,6 +430,10 @@ struct efi_runtime_services {
>   	EFI_GUID(0xeb9d2d31, 0x2d88, 0x11d3,  \
>   		 0x9a, 0x16, 0x00, 0x90, 0x27, 0x3f, 0xc1, 0x4d)
>
> +#define SMBIOS3_TABLE_GUID \
> +	EFI_GUID(0xf2fd1544, 0x9794, 0x4a2c, \
> +		 0x99, 0x2e, 0xe5, 0xbb, 0xcf, 0x20, 0xe3, 0x94)
> +
>   #define EFI_LOAD_FILE_PROTOCOL_GUID \
>   	EFI_GUID(0x56ec3091, 0x954c, 0x11d2, \
>   		 0x8e, 0x3f, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b)
> diff --git a/lib/efi_loader/efi_smbios.c b/lib/efi_loader/efi_smbios.c
> index 48446f654d9b..9ef736853d10 100644
> --- a/lib/efi_loader/efi_smbios.c
> +++ b/lib/efi_loader/efi_smbios.c
> @@ -15,6 +15,8 @@
>   #include <smbios.h>
>   #include <linux/sizes.h>
>
> +const efi_guid_t smbios3_guid =3D SMBIOS3_TABLE_GUID;
> +
>   enum {
>   	TABLE_SIZE	=3D SZ_4K,
>   };
> @@ -26,8 +28,10 @@ enum {
>    */
>   efi_status_t efi_smbios_register(void)
>   {
> +	const efi_guid_t *guid;
>   	ulong addr;
>   	efi_status_t ret;
> +	void *buf;
>
>   	addr =3D gd->arch.smbios_start;

Why did you define the macro gd_smbios_start() if it does not point to
the correct field and you don't use it? See
50834884a815 ("Record the position of the SMBIOS tables")

>   	if (!addr) {
> @@ -43,8 +47,12 @@ efi_status_t efi_smbios_register(void)
>   	log_debug("EFI using SMBIOS tables at %lx\n", addr);
>
>   	/* Install SMBIOS information as configuration table */
> -	return efi_install_configuration_table(&smbios_guid,
> -					       map_sysmem(addr, 0));
> +	buf =3D map_sysmem(addr, 10);

Where does this arbitrary value of 10 come from?

The second parameter can safely be set to 0 as the SMBIOS table is not
in PCIe mapped memory on the sandbox.

> +	guid =3D !memcmp(buf, "_SM_", 4) ? &smbios_guid : &smbios3_guid;
> +	ret =3D efi_install_configuration_table(guid, buf);
> +	unmap_sysmem(buf);

Even on the sandbox this is a NOP as this is not a PCIe address.

Best regards

Heinrich

> +
> +	return ret;
>   }
>
>   static int install_smbios_table(void)

