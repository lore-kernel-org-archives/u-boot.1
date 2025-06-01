Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1DEC54FB3
	for <u-boot@archiver.kernel.org>; Sun,  1 Jun 2025 22:14:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1351C82045;
	Mon,  2 Jun 2025 00:14:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="pzCw2uHV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8528C8296B; Mon,  2 Jun 2025 00:14:54 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3366382012
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 00:14:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1748816061; x=1749420861; i=xypron.glpk@gmx.de;
 bh=vNXTqGbF8TfYyRwKLltXVGBlFgF7UqZ7FLa3POIntdk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=pzCw2uHV60WSYwwJd7/S8F7eLlW2K9WRUv7m+CRPwhNUJFEei/a2PpuEtruynM+5
 E63t8BgO1IgPWGXSqHvoDLlqD0L/iX4Ek3rPO+h7NzBjAHhSjyg1JnfzB0b8k8EjM
 wRP9044y6MFZn2IU8nY2Ehe3mZYVS0sphF3yOv+uuOvYkXUGmeGJO5T1sSsyGheUy
 qlPWAOZ1sJ+93mILdqpSCg+zGs2yp/vQbwN6lUnQExXGDHxO2kqye/29LZq2TLo3G
 kghDP+MBjZ8/G3I9SzAUGKoFGHAeAbxbH7fvjCQd6+QMDUax5/X/FDg7Bq4xQhYeJ
 Mh0alC0POzZt8bdjxA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4QwW-1v38OJ0g58-013H6V; Mon, 02
 Jun 2025 00:14:21 +0200
Message-ID: <22d48966-26d0-4a2e-9e13-3d28215cc234@gmx.de>
Date: Mon, 2 Jun 2025 00:14:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] disk: part: implement generic function
 part_get_info_by_uuid()
To: Varadarajan Narayanan <quic_varada@quicinc.com>
References: <20250513091710.3719292-1-quic_varada@quicinc.com>
 <20250513091710.3719292-2-quic_varada@quicinc.com>
Content-Language: en-US
Cc: u-boot-qcom@groups.io, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 joe.hershberger@ni.com, avromanov@salutedevices.com,
 michael@amarulasolutions.com, sjg@chromium.org, hs@denx.de,
 michal.simek@amd.com, marek.vasut+renesas@mailbox.org,
 venkatesh.abbarapu@amd.com, ansuelsmth@gmail.com,
 cniedermaier@dh-electronics.com, ilias.apalodimas@linaro.org,
 u-boot@lists.denx.de
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250513091710.3719292-2-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iBB08YBoA8cyLHshrgL9GTYdr6jRod1U/5Sxllm+Bi13Ug9J8ix
 /OYh1SY57rgDW11ILgGx8bUeWMEQuhJDHhVLEkPdAVvXOdTmSstx8a1mi6zl4rfLnbmUfGy
 vyCSQkAYIBUBJUD+bieKZSH7urfhEZZdEcWlSO8yoN0IozFE1cpwtwx8zPujYdGtvi976ic
 96bLlrq43MMVoe2mEUCdA==
UI-OutboundReport: notjunk:1;M01:P0:QTk0wWN1XGI=;75ggilvp5kGENTJ8HlQ3vv0I0gx
 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
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

On 5/13/25 11:17, Varadarajan Narayanan wrote:
> Add function to search for a partition by UUID as partition
> names may not be unique.
>=20
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v4: Use if (!CONFIG_IS_ENABLED(PARTITION_UUIDS)) instead of '#if'
>=20
>      Not breaking from the for loop if '->get_info()' returns non-zero
>      to have similar behaviour as in part_get_info_by_name().
> ---
>   disk/part.c    | 39 +++++++++++++++++++++++++++++++++++++++
>   include/part.h | 20 ++++++++++++++++++++
>   2 files changed, 59 insertions(+)
>=20
> diff --git a/disk/part.c b/disk/part.c
> index 303178161c0..8eefda39d7b 100644
> --- a/disk/part.c
> +++ b/disk/part.c
> @@ -698,6 +698,45 @@ int part_get_info_by_name(struct blk_desc *desc, co=
nst char *name,
>   	return -ENOENT;
>   }
>  =20
> +int part_get_info_by_uuid(struct blk_desc *desc, const char *uuid,
> +			  struct disk_partition *info)
> +{
> +	struct part_driver *part_drv;
> +	int ret;
> +	int i;
> +
> +	if (!CONFIG_IS_ENABLED(PARTITION_UUIDS))
> +		return -ENOENT;
> +
> +	part_drv =3D part_driver_lookup_type(desc);
> +	if (!part_drv)
> +		return -1;
> +
> +	if (!part_drv->get_info) {
> +		log_debug("## Driver %s does not have the get_info() method\n",
> +			  part_drv->name);
> +		return -ENOSYS;
> +	}
> +
> +	for (i =3D 1; i < part_drv->max_entries; i++) {
> +		ret =3D part_drv->get_info(desc, i, info);
> +		if (ret !=3D 0) {
> +			/*
> +			 * Partition with this index can't be obtained, but
> +			 * further partitions might be, so keep checking.
> +			 */
> +			continue;
> +		}
> +
> +		if (!strncasecmp(uuid, disk_partition_uuid(info), UUID_STR_LEN)) {
> +			/* matched */
> +			return i;
> +		}
> +	}
> +
> +	return -ENOENT;
> +}
> +
>   /**
>    * Get partition info from device number and partition name.
>    *
> diff --git a/include/part.h b/include/part.h
> index fcb3c13dea4..3e6eb0ec33f 100644
> --- a/include/part.h
> +++ b/include/part.h
> @@ -315,6 +315,20 @@ int blk_get_device_part_str(const char *ifname, con=
st char *dev_part_str,
>   int part_get_info_by_name(struct blk_desc *desc, const char *name,
>   			  struct disk_partition *info);
>  =20
> +/**
> + * part_get_info_by_uuid() - Search for a partition by uuid
> + *                           among all available registered partitions

When I read this I don't know if you mean:

* "partition type GUID" or
* "unique partition GUID".

The terms "partition type GUID" and "partition unique GUID" are defined=20
in the UEFI specification.

https://uefi.org/specs/UEFI/2.11/05_GUID_Partition_Table_Format.html#gpt-p=
artition-entry-array

Please, provide a concise description.

> + *
> + * @desc:	block device descriptor
> + * @uuid:	the specified table entry uuid

Every parameter is "specified". "Table entry uuid" isn't getting to the=20
point, either. Please, use one of the established terms.

Calling a parameter "uuid" when the specification calls it "GUID" looks=20
inconsistent.

Best regards

Heinrich

> + * @info:	the disk partition info
> + *
> + * Return: the partition number on match (starting on 1), -ENOENT on no=
 match,
> + * otherwise error
> + */
> +int part_get_info_by_uuid(struct blk_desc *desc, const char *uuid,
> +			  struct disk_partition *info);
> +
>   /**
>    * part_get_info_by_dev_and_name_or_num() - Get partition info from de=
v number
>    *					    and part name, or dev number and
> @@ -386,6 +400,12 @@ static inline int part_get_info_by_name(struct blk_=
desc *desc, const char *name,
>   	return -ENOENT;
>   }
>  =20
> +static inline int part_get_info_by_uuid(struct blk_desc *desc, const ch=
ar *uuid,
> +					struct disk_partition *info)
> +{
> +	return -ENOENT;
> +}
> +
>   static inline int
>   part_get_info_by_dev_and_name_or_num(const char *dev_iface,
>   				     const char *dev_part_str,

