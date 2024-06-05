Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 479B6C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 05:33:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C787F88297;
	Wed,  5 Jun 2024 07:33:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="giNkp+qp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6413882E0; Wed,  5 Jun 2024 07:33:34 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0CE5879F3
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 07:33:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1717565609; x=1718170409; i=xypron.glpk@gmx.de;
 bh=VZbjW2SeXqzM1TqAZs1IBaCiu84r1rNSWFpZh39+cn0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=giNkp+qp2om9hW8KRX8NO6T/NPzyzskIyb3I/c/FFC9EPbaCthBRvVtax5sZP3iu
 c7DWWXbDYGEZgP1MT0nBLl3hyCqwHUlO7bqmh86R21NiKyaCYqWb4MNdou3ujWfbQ
 lpQxMxpKcn4NdBn6Qre5L3SDeFErEgKNEA4NRJ1YCNBX2Nk4YB2EDPOxIqIz93tAV
 Hdy1pqoEuIOtMIPIOQ68YLZZm17vKWFOPr53BWpnK7bOxXWOV2LJJ2PgA/c2Hb/HT
 AbpmnK1TP6HwwUw3/BFEAk6ecUoONLv4YsrjOTgv0DEpDsTKXZXBFnX+dYIM1M/hD
 uLL2Nz62a0uVwKRMDQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.107] ([109.42.178.114]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5wLZ-1s7HYg2vPv-007U63; Wed, 05
 Jun 2024 07:33:29 +0200
Message-ID: <928c870f-2749-46d7-8a02-a5605557bce2@gmx.de>
Date: Wed, 5 Jun 2024 07:33:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] lib: uuid: add UUID v5 support
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Mario Six <mario.six@gdsys.cc>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
References: <20240531-b4-dynamic-uuid-v3-0-ca4a4865db00@linaro.org>
 <20240531-b4-dynamic-uuid-v3-1-ca4a4865db00@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240531-b4-dynamic-uuid-v3-1-ca4a4865db00@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lHjTRLhO/ug/EEAD/ekSjBrCWNd3s2y1ijQ8E0QSETEN/q4QBzz
 9ZV9C1ZZrNEqS1w/nLwWSDhCDw3RZOUUQy1EkapOR/OVgowy3nXrkaDdUeFRKiDX5WwIe1W
 Q9eZbsgOy7HEvFaljlSnL8zfhp2r0niu1BB6bQM/tdw9jXhzm1TnygAVguAVfn+Rwiov8o4
 Hj77eZB9kD/S9WYvSfPKg==
UI-OutboundReport: notjunk:1;M01:P0:8L8tTXn+Eog=;uXKrCQcU/uOE2yDWSLXJd1Rbcu5
 anrqBS0lYiyrMSLsMjl6a4k+zZvHJh9Q+CifJN2RvYQadu1BLdTsq/SkPR1p6ofh6ijBaddFk
 uMRCAehh+CkFjq/OLXgWuAKzleznAxHptzj3Hgz9lGZe/mtfSjtzXpI+EDiAw1GKNS/v2OLTO
 ezD/PrjJDNxytW0dc1VuJxZwFMlvKfSORHr4RaEmECreFySwmNFZkLWuk534VZ6Umbb2w3xB/
 ezD8/+BwE6dsm7qa16ifoPwKsWxmwXONjLx5DsRnXnoCcp+oh1I0r39YJk6B8oryO1XxO5Rpz
 pRx7QCZGQPHGXXJuXqm7xGYHylb9SmPb4WfMs6QOHAdS0AGc1m6qYRuf3YgcjZrLTo38I7k5M
 LpQWzk8ZA13xQh6LzYXuEBuyYq5fHC6nfzpHRlGHhVSeeRbxhKp4z1Mt/s2Qa23QsjGVp34W9
 E+6P4yQiTUz+Zzn74XVLHJgHNeWekHJMOHW/ounTFcVjmbD/r2t7uOOOoSIaJ1Yv9cKyKbmfR
 gQ3d8npPhAzowgKYAdg+y3pvKCyxRj4pocMwwIRSdYuy+iknM+I1FchXBiPF7VdCAuFy+pyye
 v2bbLqz82xeQvgaYCkXAE8Lsy2/5nvdSi35ObH6XIzmS8tF+5EZ+ltop3TYNDZZH24VrdufA/
 9Vz3EGJk2lM0wAVlxha8C+moVUPDYumiI53KRxef0ZFy1ZbU6j96OEBKvrgS8mABNZk+GjKfi
 yT1q3meCphmRXZ7i51eqOUtVQhjQEjr7XEviypuzobkJo6OVtT5sudKli+p1HMb3RqDYRLuoK
 WQIfB6V5bd5hR4y78NG7LD5M/1xJc9b1IaVFQ318/G/+A=
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

On 5/31/24 15:50, Caleb Connolly wrote:
> Add support for generating version 5 UUIDs, these are determistic and wo=
rk
> by hashing a "namespace" UUID together with some unique data. One intend=
ed
> usecase is to allow for dynamically generate payload UUIDs for UEFI
> capsule updates, so that supported boards can have their own UUIDs
> without needing to hardcode them.
>
> Tests for this are added in an upcoming patch.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   include/uuid.h | 17 +++++++++++++++++
>   lib/Kconfig    |  8 ++++++++
>   lib/uuid.c     | 37 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 62 insertions(+)
>
> diff --git a/include/uuid.h b/include/uuid.h
> index f5a941250f48..539affaa47b9 100644
> --- a/include/uuid.h
> +++ b/include/uuid.h
> @@ -10,8 +10,9 @@
>   #ifndef __UUID_H__
>   #define __UUID_H__
>
>   #include <linux/bitops.h>
> +#include <linux/kconfig.h>
>
>   /*
>    * UUID - Universally Unique IDentifier - 128 bits unique number.
>    *        There are 5 versions and one variant of UUID defined by RFC4=
122
> @@ -142,8 +143,24 @@ void gen_rand_uuid(unsigned char *uuid_bin);
>    * @param          - uuid output type: UUID - 0, GUID - 1
>    */
>   void gen_rand_uuid_str(char *uuid_str, int str_format);
>
> +#if IS_ENABLED(CONFIG_UUID_GEN_V5)
> +/**
> + * gen_uuid_v5() - generate UUID v5 from namespace and other seed data.
> + *
> + * @namespace:   pointer to UUID namespace salt
> + * @uuid:        pointer to allocated UUID output
> + * @...:         NULL terminated list of seed data as pairs of pointers
> + *               to data and their lengths

It is unclear what this might mean.

According to your description ... could be

struct {
	void *data;
	u32 *length;
} ...[] =3D {
	{ &data_1, &length_1 },
	{ &data_2, &length_2 },
	{ NULL, NULL }
}

Do we have pointer to lengths?
Which data type do lengths have?

Please, provide an unambiguous description.

An example would help.

> + */
> +void gen_uuid_v5(const struct uuid *namespace, struct uuid *uuid, ...);
> +#else
> +static inline void gen_uuid_v5(const struct uuid *namespace, struct uui=
d *uuid, ...)
> +{
> +}
> +#endif
> +
>   /**
>    * uuid_str_to_le_bin() - Convert string UUID to little endian binary =
data.
>    * @uuid_str:	pointer to UUID string
>    * @uuid_bin:	pointer to allocated array for little endian output [16B=
]
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 189e6eb31aa1..2941532f25cf 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -80,8 +80,16 @@ config RANDOM_UUID
>   	help
>   	  Enable the generation of partitions with random UUIDs if none
>   	  are provided.
>
> +config UUID_GEN_V5
> +	bool "Enable UUID version 5 generation"
> +	select LIB_UUID
> +	depends on SHA1

'select SHA1' might make things easier.

> +	help
> +	  Enable the generation of version 5 UUIDs, these are determistic and

%s/determistic/deterministic/

> +	  generated from a namespace UUID, and a string (such as a board name)=
.
> +
>   config SPL_LIB_UUID
>   	depends on SPL
>   	bool
>
> diff --git a/lib/uuid.c b/lib/uuid.c
> index dfa2320ba267..2df0523e717f 100644
> --- a/lib/uuid.c
> +++ b/lib/uuid.c
> @@ -21,8 +21,9 @@
>   #include <part_efi.h>
>   #include <malloc.h>
>   #include <dm/uclass.h>
>   #include <rng.h>
> +#include <u-boot/sha1.h>
>
>   int uuid_str_valid(const char *uuid)
>   {
>   	int i, valid;
> @@ -368,8 +369,44 @@ void uuid_bin_to_str(const unsigned char *uuid_bin,=
 char *uuid_str,
>   		}
>   	}
>   }
>
> +#if IS_ENABLED(CONFIG_UUID_GEN_V5)
> +void gen_uuid_v5(const struct uuid *namespace, struct uuid *uuid, ...)
> +{
> +	sha1_context ctx;
> +	va_list args;
> +	const uint8_t *data;
> +	uint8_t hash[SHA1_SUM_LEN];
> +	uint32_t tmp;
> +
> +	sha1_starts(&ctx);
> +	/* Hash the namespace UUID as salt */
> +	sha1_update(&ctx, (unsigned char *)namespace, UUID_BIN_LEN);
> +	va_start(args, uuid);
> +
> +	while ((data =3D va_arg(args, const uint8_t *))) {
> +		unsigned int len =3D va_arg(args, size_t);
> +
> +		sha1_update(&ctx, data, len);
> +	}
> +
> +	va_end(args);
> +	sha1_finish(&ctx, hash);
> +
> +	/* Truncate the hash into output UUID, it is already big endian */
> +	memcpy(uuid, hash, sizeof(*uuid));
> +
> +	/* Configure variant/version bits */
> +	tmp =3D be32_to_cpu(uuid->time_hi_and_version);
> +	tmp =3D (tmp & ~UUID_VERSION_MASK) | (5 << UUID_VERSION_SHIFT);

Currently we have

#define UUID_VERSION            0x4

Shouldn't we create

#define UUID_VARIANT_4 0x4 - to be used in gen_rand_uuid()
#define UUID_VARIANT_5 0x5 - to be used in gen_uuid_v5()

instead?

Please, provide a unit test for gen_uuid_v5() that passes multiple
strings to gen_uuid_v5() and checks the hash.

Best regards

Heinrich

> +	uuid->time_hi_and_version =3D cpu_to_be32(tmp);
> +
> +	uuid->clock_seq_hi_and_reserved &=3D UUID_VARIANT_MASK;
> +	uuid->clock_seq_hi_and_reserved |=3D UUID_VARIANT << UUID_VARIANT_SHIF=
T;
> +}
> +#endif
> +
>   #if defined(CONFIG_RANDOM_UUID) || defined(CONFIG_CMD_UUID)
>   void gen_rand_uuid(unsigned char *uuid_bin)
>   {
>   	u32 ptr[4];
>

