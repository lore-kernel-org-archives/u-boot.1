Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED040D2ECF7
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 14:56:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 767BE83A8F;
	Tue, 20 Jan 2026 15:56:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="oodNZMC5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63EE683AB8; Tue, 20 Jan 2026 15:56:21 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E6CB83A2B
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 15:56:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1768920977; x=1769525777; i=xypron.glpk@gmx.de;
 bh=TuYXELB++iyN6G+/YJp4slNSURpFhr0pw8mBTrAnAFs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=oodNZMC5eaawo436Uw26DpR4gllts8cjPHbgk9BvN/tYhIju7ze7NVFzBKXn8E6L
 lTbtYDMy5LdtH3YX9wlUe4IofXWrndqrHY3aQPeVh5UvZ5x1pP6C4dYaJHcBvx2wV
 9SKbFvKqNPte8/oWocXRKxc50iUTreWGneyz8Tf56hP6MBzBJNgsiLrinjlR+Ik9g
 QjfMr+v8IVqXu1Pg7RpNPDBHAnq/8xy+RdiP/gLWsowlw8ju4HQgQYaTlHvo/0bxP
 FAqUPt5cp/u9+Ti8IpgycLzfM0kqi78MDYMEGxc+NycbLhU4WZhhfo9ApJqxwSko6
 7yG77qjwj+6KQLYP6Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.127] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiJZO-1wJzsM3aXW-00bR8r; Tue, 20
 Jan 2026 15:56:16 +0100
Message-ID: <b0c0049b-e15f-4730-955c-55429720adfc@gmx.de>
Date: Tue, 20 Jan 2026 15:56:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] efi_selftest: Enhance MBR test for
 PARTITION_INFO_PROTOCOL
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: eballetb@redhat.com, alexl@redhat.com,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260120133630.1695055-1-javierm@redhat.com>
 <20260120133630.1695055-6-javierm@redhat.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260120133630.1695055-6-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4MHP0gtA39vIpPvydGYVJxNwnBTiCCyIVrdEg2A7qvmU6xeUux3
 SRZHgt3c/E0UtgZivKD3kEouqAR/U5y2x0zWxJ6kCdrHaYj+rSwucB9e9pS1C1mce11NuC9
 WoAPj8x2221aYgx/c9Ev1clakIbC7/uwFrcrjeRWPzM2rBhRDvVIiWT+AMbDmo2W80fZF0z
 eZa0JVtB1fKIsEXCdI8Qg==
UI-OutboundReport: notjunk:1;M01:P0:4CxoKRX3MEA=;zsBytmf4jNCrIM/K9S/xLNIX1NZ
 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
 f54D/bisIbmxOG+Xr/Pb6HgPKrlx3
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

On 1/20/26 14:36, Javier Martinez Canillas wrote:
> The EFI_PARTITION_INFO_PROTOCOL test was added before the protocol fully
> supported MBR partitions. As a result, it lacked specific checks for the
> content of the raw MBR partition record.
>=20
> Now that MBR support has been implemented, enhance the selftest to provi=
de
> coverage for the MBR entries too.
>=20
> This verifies that the protocol correctly reads and exposes MBR partitio=
n
> records and prevents this functionality to regress due future changes.
>=20
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>=20
>   lib/efi_selftest/efi_selftest_block_device.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>=20
> diff --git a/lib/efi_selftest/efi_selftest_block_device.c b/lib/efi_self=
test/efi_selftest_block_device.c
> index f145e58a267a..50d1fb29e1ef 100644
> --- a/lib/efi_selftest/efi_selftest_block_device.c
> +++ b/lib/efi_selftest/efi_selftest_block_device.c
> @@ -404,6 +404,18 @@ static int execute(void)
>   			     part_info->system);
>   		return EFI_ST_FAILURE;
>   	}
> +	/* The first partition starts at LBA 1 on the test image */
> +	if (part_info->info.mbr.start_sect !=3D 1) {
> +		efi_st_error("MBR start sector %d, expected 1\n",
> +			     part_info->info.mbr.start_sect);
> +		return EFI_ST_FAILURE;
> +	}
> +	/* The partition type is FAT12 (0x01) in the test image */
> +	if (part_info->info.mbr.sys_ind !=3D 0x01) {
> +		efi_st_error("MBR system indicator %d, expected 1\n",
> +			     part_info->info.mbr.sys_ind);
> +		return EFI_ST_FAILURE;
> +	}

How about defining a static variable with all fields and using memcmp()=20
to check them all?

Best regards

Heinrich

>  =20
>   	/* Open the simple file system protocol */
>   	ret =3D boottime->open_protocol(handle_partition,

