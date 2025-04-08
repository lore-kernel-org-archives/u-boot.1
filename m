Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38AACC3600C
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 09:55:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71491833C8;
	Tue,  8 Apr 2025 11:55:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="dlVEupsM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 869B2833D1; Tue,  8 Apr 2025 11:55:21 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A0858312E
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 11:55:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1744106118; x=1744710918; i=xypron.glpk@gmx.de;
 bh=vTGZ63jReh0U9JlMWlh/gHIaY1iYJqP/ouVV0bo3FFY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=dlVEupsMEsaRg2DR4u3R0isQSoS7Gjdnw5ytNu7LLSuyuCWrMSV+S8L9f1IdVcC8
 lGHKNw7AJhdr+qM0M4ielAGsbYVwSC7c3KOAeg1Y3B7g/7NNWB/zKBiJ7436IcRiE
 I9ag/FuLTmB385rOkMoiOSnKQk34W9OCTfvXnsfYlHffcqu3/FvW3DtTTYTZrsDvb
 EdACliWaw6DaBKfFEg3S20PojCLxzxrrroIyQ8iia12gfzZxUHIr9fnfvAIU0JLA8
 I1mpNQGrXoZ3NgOYS9zMK9Dp/DdSWF2Ya5EK52eL6dkj+WTtZz4mTvS9bdxGyhYuZ
 z35/C+fsFMqwVg4GcQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEV3C-1trb273aRu-00DlMa; Tue, 08
 Apr 2025 11:55:17 +0200
Message-ID: <613a0f69-0fc6-4861-90a8-760f4c516a1a@gmx.de>
Date: Tue, 8 Apr 2025 11:55:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] part: add part_get_info_cached() API
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, Tom Rini
 <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20250408-topic-gpt-cache-v2-0-de76e47debb7@linaro.org>
 <20250408-topic-gpt-cache-v2-1-de76e47debb7@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250408-topic-gpt-cache-v2-1-de76e47debb7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aSeUzBMxWSmIZl6W9aXVe8k0HjKHn/tn8XPyRLLQY7nTMu5B+F5
 Sx9r3e8hbUp0V0bDeEgE2qahZjUqbrlbAwqulsnLd+qXD+IQbD6k7RZj7TThU9AtdntXbb/
 7fMDz/B8PiMNVRiJ9Sz79XtbGSMxiBjmuErFlsNT5MDCIZmHaNzEF1kRgFVOpTNhreJjEVm
 2rjqaC1n/WRmLw9YHQU/A==
UI-OutboundReport: notjunk:1;M01:P0:yv0ld1xeAD0=;NZfUZ08JT9RTckVmtkwqKrM9MIN
 m+TkAGv9truYgeKhuKaLsW9xig4HBHxyvzx+U0XkSNHRUOXYjLLznn0nnGQFYPnOXwXKqrgRM
 mgaE0Z3QJNGkDWtyanaOqxLYa99FcgzJ0aTpGmt3dWOTWp/66S0lbz07D7HiqTol/c1CeLhz5
 AiCpa8HKwxBiuuA1x7xIz4MgynyzoYjQrbqiCUxToM2JAskGgxsUnXfaSD6Z0KzmBC/i4zo1l
 yaG9878KP2LvAkZznKoRjghQUwi2iydIMSVjzO0hccwtu92ETewfHShawnaSTa9A1rW7y8/eV
 B6IYJke697ZX8yvEH0KMkWF/Nuebw0nDrVqUrNYbNH0mDwRGF62xpJO7CK6y7Xyjb1l2odwZh
 GIizc1NFrQX5mL8iI0sA2p39/BpD0YFrCKC/ybZZyWxctHvHiUtqCJsncm8fV3IAxK8EjEd/0
 DfA+BZF30xmUcjdFpzNcJOwAogCh5zJSNdflA/v6cU7DtjGXjAnYLA01WorkP1grYverf3AsN
 fzi0iLZnkhvMnEZTI+Qx2fIIanPYRmQ0rW+hLI0FSjDZuh9u6barMtSRvJ7zZgGz80UBmCgu9
 kOfYrRkahSfNJJjP7Pc8YB0epRLugJkXeFkd5+qLhTuTzFPP9W9mdHTgb20nte6fWJmsZc0lb
 MiP09omJLYR+08/FnaKCjETfeyZDOwbn0Mlo/Acw9akYtTXRA0wlaaGHq36FSrf9n0FTHd9cK
 myBosJmX8FNJ0wnNjOBzOR64T5OlGvQAvvC+ZvRUcWoNzKoMxpu+ahJBjxi3ABRtIc389dpBr
 sIe3IzFRicAqTp27YTv9hk2FV4OHrm4z0oIlCj5vjASpCVqbgiQfhYnCzL2cx01/HziXkMVnt
 UZ3C0BSGgjTZPmHsndOo5KGC18iQeRrXUpVHCrCjR9sQgLtJ8GzrlxxCMzHdWz0TqvabB8FnM
 GLUmKNNo8BwHIx9l8I9d4T/iW+E++uteO5eyn8j9qRnUcOjVEWyqLpJAOOQBz7l0/lGmzGwXY
 XaJ8nRqEr5QBGhSNMIL80NoQmZO1/6wvZGHIdzcD5PYYaSvo0VNmlElBcoIWxZ56JQ7oiYIcX
 NKByQfb+wme2f3y6DSz6wyPtow8PmM+DWbXdzpKk44pkle9IRtI7mgIdZKsiSExTvNkmVRMCx
 EdN/ZRjnwdFg3tV9UUVN1cF59q/FPUwaK+kAQx08obHAK+CB4ViiLzr6uSFJOP41uByXTpDNT
 EKVtp8VEBjShx8at8S82Amc/sVp1LcFBTkrCHpBFjC/tGhiBwIEniibmp+a/M4VuTQxf5btxB
 af6OFgMpA/sBg8fvZMCidFwnjiwJDinSlzyf/6hN1WZ5cG0pd3q2RESURS6bDR9l2gZw17caG
 c9NYfpztUVPxCzYPvVZj5YNn07pDWUOs5qj5rRG5CcS5fO3uPeDJAxQedIEm6glvrIYwOVwbV
 EQjZW8jf156Bqgor7GEAZDUrLKY8=
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

On 08.04.25 11:13, Neil Armstrong wrote:
> Introduce a new part_get_info_cached() API that's used to
> get the part_info of a blk_desc allowing to use an eventual
> partition scanning cache to avoid rescanning the entire disk
> partition scheme for each partition number.
>
> The part_get_info_cached_free() is also added to hint the
> partition code to flush any cached data from this disk.
>
> The equivalent ops are added that directly maps to those
> added functions.
>
> This API is designed to be used as a direct replacement of
> part_get_info() in codes scanning all partitions for a same
> disk, like in blk-uclass. With this, a lot of unnecessary
> computation is saved, leading to a faster boot time when
> partitions are scanned, especially with storage medias
> with potentially multiple large hardware partitions like
> UFS, NVMe or eMMC.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   disk/part.c    | 55 ++++++++++++++++++++++++++++++++++++++++++++------=
-----
>   include/part.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 88 insertions(+), 11 deletions(-)
>
> diff --git a/disk/part.c b/disk/part.c
> index 303178161c083ec6e1b767b4f06ac5773576ca60..1d09c0511c75d457c81cab04=
0c3f5caa924ee945 100644
> --- a/disk/part.c
> +++ b/disk/part.c
> @@ -335,8 +335,8 @@ void part_print(struct blk_desc *desc)
>   		drv->print(desc);
>   }
>
> -int part_get_info_by_type(struct blk_desc *desc, int part, int part_typ=
e,
> -			  struct disk_partition *info)

Thank you, Neil, for pushing this forward.

All functions deserve a description.

> +static int _part_get_info_by_type(struct blk_desc *desc, int part, int =
part_type,
> +				  struct disk_partition *info, bool cached)
>   {
>   	struct part_driver *drv;
>
> @@ -356,24 +356,57 @@ int part_get_info_by_type(struct blk_desc *desc, i=
nt part, int part_type,
>   			      desc->part_type);
>   			return -EPROTONOSUPPORT;
>   		}
> -		if (!drv->get_info) {
> -			PRINTF("## Driver %s does not have the get_info() method\n",

Writing to the console creates screen havoc in EFI applications. Please,
use log_debug() instead of PRINTF().

And, please, remove that noisy '## '. It carries no information.

Best regards

Heinrich

> -			       drv->name);
> -			return -ENOSYS;
> -		}
> -		if (drv->get_info(desc, part, info) =3D=3D 0) {
> -			PRINTF("## Valid %s partition found ##\n", drv->name);
> -			return 0;
> +		if (cached && drv->get_info_cached) {
> +			if (drv->get_info_cached(desc, part, info) =3D=3D 0) {
> +				PRINTF("## Valid %s partition found ##\n", drv->name);
> +				return 0;
> +			}
> +		} else {
> +			if (!drv->get_info) {
> +				PRINTF("## Driver %s does not have the get_info() method\n",
> +				       drv->name);
> +				return -ENOSYS;
> +			}
> +			if (drv->get_info(desc, part, info) =3D=3D 0) {
> +				PRINTF("## Valid %s partition found ##\n", drv->name);
> +				return 0;
> +			}
>   		}
>   	}
>
>   	return -ENOENT;
>   }
>
> +int part_get_info_by_type(struct blk_desc *desc, int part, int part_typ=
e,
> +			  struct disk_partition *info)
> +{
> +	return _part_get_info_by_type(desc, part, part_type, info, false);
> +}
> +
> +int part_get_info_cached(struct blk_desc *desc, int part,
> +			 struct disk_partition *info)
> +{
> +	return _part_get_info_by_type(desc, part, PART_TYPE_UNKNOWN, info, tru=
e);
> +}
> +
>   int part_get_info(struct blk_desc *desc, int part,
>   		  struct disk_partition *info)
>   {
> -	return part_get_info_by_type(desc, part, PART_TYPE_UNKNOWN, info);
> +	return _part_get_info_by_type(desc, part, PART_TYPE_UNKNOWN, info, fal=
se);
> +}
> +
> +void part_get_info_cached_free(struct blk_desc *desc)
> +{
> +	struct part_driver *drv;
> +
> +	if (blk_enabled()) {
> +		drv =3D part_driver_lookup_type(desc);
> +		if (!drv)
> +			return;
> +		if (!drv->get_info_cache_free)
> +			return;
> +		drv->get_info_cache_free(desc);
> +	}
>   }
>
>   int part_get_info_whole_disk(struct blk_desc *desc,
> diff --git a/include/part.h b/include/part.h
> index fcb3c13dea4de6346ad98d6ce320ef36747dda85..8c98865146306fb665095760=
68c45de01b9cedb6 100644
> --- a/include/part.h
> +++ b/include/part.h
> @@ -216,6 +216,34 @@ struct blk_desc *mg_disk_get_dev(int dev);
>    */
>   int part_get_info_by_type(struct blk_desc *desc, int part, int part_ty=
pe,
>   			  struct disk_partition *info);
> +
> +/**
> + * part_get_info_cached() - Get partitions from a block device but save=
 the
> + * disk partition map between different partitions.
> + *
> + * Call to part_get_info_cached_free() is required when scanning of the
> + * block device is finished.
> + *
> + * If the partition driver doesn't support cached part_info, the
> + * normal part_info will be called instead.
> + *
> + * @desc:	Block device descriptor
> + * @part:	Partition number to read
> + * @info:	Returned partition information
> + *
> + * Return: 0 on success, negative errno on failure
> + */
> +int part_get_info_cached(struct blk_desc *desc, int part,
> +			 struct disk_partition *info);
> +
> +/**
> + * part_get_info_cached_free() - Free the saved disk partition map
> + * from a previous call of part_get_info_cached().
> + *
> + * @desc:	Block device descriptor
> + */
> +void part_get_info_cached_free(struct blk_desc *desc);
> +
>   int part_get_info(struct blk_desc *desc, int part,
>   		  struct disk_partition *info);
>   /**
> @@ -463,6 +491,22 @@ struct part_driver {
>   	int part_type;
>   	/** @max_entries:	maximum number of partition table entries */
>   	const int max_entries;
> +	/**
> +	 * @cache_free_cache_free:	Free any parsing data stored from get_info_=
cached()
> +	 *
> +	 * @get_info_cache_free.desc:	Block device descriptor
> +	 */
> +	void (*get_info_cache_free)(struct blk_desc *desc);
> +	/**
> +	 * @get_inf_cachedo:		Get information about a partition, and save
> +	 *				the resulting parsing data for the next partition.
> +	 *
> +	 * @get_info_cached.desc:	Block device descriptor
> +	 * @get_info_cached.part:	Partition number (1 =3D first)
> +	 * @get_info_cached.info:	Returns partition information
> +	 */
> +	int (*get_info_cached)(struct blk_desc *desc, int part,
> +			       struct disk_partition *info);
>   	/**
>   	 * @get_info:		Get information about a partition
>   	 *
>

