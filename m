Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B38C282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 16:58:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2054280F9C;
	Thu, 13 Mar 2025 17:58:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Tw8UnnnZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70AFC80FF7; Thu, 13 Mar 2025 16:58:21 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4D6280540
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 16:58:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1741881493; x=1742486293; i=xypron.glpk@gmx.de;
 bh=yvjPYiEfG+AQkxQb5fV9VvgLEJEkmtZVwUI42xiDbaE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Tw8UnnnZ8bek5moWH+UgUyiP4mYmoG0HeUiBUzoU+apCp1H1hRm9G8TByS8sspiD
 2M3hdRl6V1e4Hc+f70yknD+6sTyRDtTwnHxaULybpqWtanLuUzNQ8RUyq8UzFhVKt
 PYT1Qb0e4VApLP2Q+P552NSZf1j42t+0K/uLwBu5sniEAk5bsPIhDRZg3qv0U0lEX
 zOcMipWAzae/lHh7lNin3GRZuXZDKL97NK3cYY9zvesegt6Zy3sbX/5A3m3ETx1QW
 fgcwXks01e/w7zLcZlxBpBrvtbfa+tkRVK7/6r46Vs468631sgl0GyU1OyZiBCyPX
 HRly1PHknDpqWCXwtg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAwbz-1u3Way1lhB-00DpS0; Thu, 13
 Mar 2025 16:58:13 +0100
Message-ID: <73d0773a-2b6c-4ece-be75-4b3f0e65619d@gmx.de>
Date: Thu, 13 Mar 2025 16:58:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] fs: exfat: Import libexfat from fuse-exfat
To: Marek Vasut <marex@denx.de>
Cc: Baruch Siach <baruch@tkos.co.il>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
References: <20250308201533.1315951-1-marex@denx.de>
 <20250308201533.1315951-7-marex@denx.de>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250308201533.1315951-7-marex@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:e/jRwLrWgpIbRwRPU3kmv/YqgjuxAIMSlTZtIqmwGQCw7gxUw8e
 FQ+EZMFxCgy812TJoh75vbbs0r4jlSMfgtQlCCjLr6B7ogxmL9eV973udpSXSctL7/nLAN1
 sGcXdLeerks/5scZkWXFVIgFV9/nhaE4j5aTX9KhtlHDowECKzIXM2AYm83iSApDV/7FESe
 PQTYI1E30cR6tcGDMj9Tg==
UI-OutboundReport: notjunk:1;M01:P0:dKRytM87VuM=;aJsRKnLFwgTve551Yk0HAnQeNiz
 hje2XggFUWcGilGkpowEglOVvSj7+CiuDDBgfv2xWm9H6yaZpsoZH5ktktGQ7ztaYFHmFRWTm
 HeSXV+71Go8RweCamj0fKND5Jmrd6QDiQaszxtouNu5dQqxuqkMWjZJZ8WrsnjzTJiLAjowNY
 TkKsOIxD3vAN0c7b0fnCoxRNEbrakY5MTiulxaGy4EqI+XUBGECb3BaUvMAA37YTU61++kq0G
 ZioTzlGwwUWzsKdltD3E/rv7uJYJyhbx7ptiwRvKeA3xWr9SOtqdvqSjoznZXxsIGL+O0/a3D
 E3aZRB5BiRAuyWXbz7MYNRjrcQa72iu9IbWGuzHUCaxNL4LpKrYvqEsADip7xCk22fmKPtFH2
 i0J1I+5YFFllXTYHXVeunS7fLWV5ylScPbk8ZmXOVd95fxQek1GNCBIvpjOa0WJdMv1z6fXUZ
 Ppm41ovz0zyeUGp4lV2X5Qm9fFt9yeNLv9JMhT3ZCPIoIiNOMWJWlatTlPVZBTRUDJVYGJqbl
 j3RrtVi/RhmHcIlSaifIVXX9Xye2VQwq5x4NqLfWhtFHL/eTvpD1GDRg21ar85IsNGt66vssf
 qrQZ9DY14eKf3Iw1GDgVhazdA6kW1KXGizjB4OXJIvIqdjMLQbTm6pp1W5Ag9iYxhBJupE0Lu
 jrOye/xNtPBgC1LWUqwhrmhM6X3TMmadd16VM7BKm1Tt1/bWuyLfHH5WrATGKqnoT7NUVq/v4
 U+UwSZMVxCEtREbppG1GnwfTRsObyEirVguIp8FVbS4vNjzNxmKwmha+VlPZASdWE5HIjFoNX
 cnwf/VUyZGZ2PPAX7ce71cV8xLnVEYTAhQu9di66dOOp/gsbkWXip8CzR12bv4xgpacCg21g1
 m8OZ13B3pyUU3+K9hwOeohPEhZa6x+Bp/pV5UBweWRcGEDjUtJ1Yvyg8hsGh5FnU6n4Ghpiar
 ygXv2N1EmCSrp9bpIuJy4C8JwGp2rN2sfO9ueBcod3MzDkObu05sj0+WooWHpFeOBkaPWlxsE
 Gk7K9yv1Jg7/BtzRuByoRvB7YegYbcmt6tE3Y0HDAOiH3rJSM3gVJhBXSwPMuhraKIYxV4gEj
 C/LI9hTJyO2meMSQu8/WA/0RMU4/5cVdQAuDHJnJWPyLMKpsxmLyRPK1qGoBCscDwjYexjftc
 avY9PckE2cA+La/N/MQ+jsltEZL1ng6gQkRMt3sY0JDIaby6U00TUnA9tsRvxJTL1ZwKhdV5I
 76WAdtqZ7mFDUbvso2oVRZubDFxkG9VpADi3XENj1jkKsgDzWrxo8GcT6lHPuU7XyrV+gNJ49
 A2GApf960M0XsNcZEGi4JeP/9B28LtZCd6oOIfuvVA4A2HtsffQ1wtqeRO5iK2oPeM9ZQeuyN
 iohPkB5+mJsBwr8tsuf444+pBh9W+ckrBjhZRtQ++k38lPNvWpsWMCO5yaFZjqpCSnGK+L2Gw
 IedHxH4KI6oonz2O83BXpQrnAws27hBzYeGKo2sPSHuMT/UOdKzm1X0HWzMzy06EEfdQ8b20+
 Wimw4jjeaIjbwROpWXA=
X-Mailman-Approved-At: Thu, 13 Mar 2025 17:58:37 +0100
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

On 08.03.25 21:12, Marek Vasut wrote:
> Import most of libexfat from [1] except for log.c verbatim. The code
> does not even compile and further adjustments and integration into
> U-Boot filesystem code is in the next patch.
>
> [1] https://github.com/relan/exfat
>      0b41c6d3560d ("CI: bump FreeBSD to 13.1.")
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Baruch Siach <baruch@tkos.co.il>
> Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Hiago De Franco <hiago.franco@toradex.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Nam Cao <namcao@linutronix.de>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>   fs/exfat/byteorder.h |   68 +++
>   fs/exfat/cluster.c   |  496 +++++++++++++++++
>   fs/exfat/compiler.h  |   69 +++
>   fs/exfat/exfat.h     |  248 +++++++++
>   fs/exfat/exfatfs.h   |  181 ++++++
>   fs/exfat/io.c        |  514 +++++++++++++++++
>   fs/exfat/lookup.c    |  222 ++++++++
>   fs/exfat/mount.c     |  373 +++++++++++++
>   fs/exfat/node.c      | 1243 ++++++++++++++++++++++++++++++++++++++++++
>   fs/exfat/platform.h  |   73 +++
>   fs/exfat/repair.c    |  102 ++++
>   fs/exfat/time.c      |  173 ++++++
>   fs/exfat/utf.c       |  254 +++++++++

This file contains Unicode conversion routines and duplicates what we
already have in lib/charset.c.

Please, consider removing the code duplication. This will also solve
your issue with wchar_t.

exfat internally uses low-endian UTF16 like our EFI code. The functions
converting from and to 32bit wchar_t are not used at all.

Best regards

Heinrich

>   fs/exfat/utils.c     |  192 +++++++
>   14 files changed, 4208 insertions(+)
>   create mode 100644 fs/exfat/byteorder.h
>   create mode 100644 fs/exfat/cluster.c
>   create mode 100644 fs/exfat/compiler.h
>   create mode 100644 fs/exfat/exfat.h
>   create mode 100644 fs/exfat/exfatfs.h
>   create mode 100644 fs/exfat/io.c
>   create mode 100644 fs/exfat/lookup.c
>   create mode 100644 fs/exfat/mount.c
>   create mode 100644 fs/exfat/node.c
>   create mode 100644 fs/exfat/platform.h
>   create mode 100644 fs/exfat/repair.c
>   create mode 100644 fs/exfat/time.c
>   create mode 100644 fs/exfat/utf.c
>   create mode 100644 fs/exfat/utils.c
>
> diff --git a/fs/exfat/byteorder.h b/fs/exfat/byteorder.h
> new file mode 100644
> index 00000000000..98b93c700c3
> --- /dev/null
> +++ b/fs/exfat/byteorder.h
> @@ -0,0 +1,68 @@
> +/*
> +	byteorder.h (12.01.10)
> +	Endianness stuff. exFAT uses little-endian byte order.
> +
> +	Free exFAT implementation.
> +	Copyright (C) 2010-2023  Andrew Nayenko
> +
> +	This program is free software; you can redistribute it and/or modify
> +	it under the terms of the GNU General Public License as published by
> +	the Free Software Foundation, either version 2 of the License, or
> +	(at your option) any later version.
> +
> +	This program is distributed in the hope that it will be useful,
> +	but WITHOUT ANY WARRANTY; without even the implied warranty of
> +	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +	GNU General Public License for more details.
> +
> +	You should have received a copy of the GNU General Public License alon=
g
> +	with this program; if not, write to the Free Software Foundation, Inc.=
,
> +	51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +*/
> +
> +#ifndef BYTEORDER_H_INCLUDED
> +#define BYTEORDER_H_INCLUDED
> +
> +#include "platform.h"/
> +#include <stdint.h>
> +#include <stddef.h>
> +
> +typedef struct { uint16_t __u16; } le16_t;
> +typedef struct { uint32_t __u32; } le32_t;
> +typedef struct { uint64_t __u64; } le64_t;
> +
> +#if EXFAT_BYTE_ORDER =3D=3D EXFAT_LITTLE_ENDIAN
> +
> +static inline uint16_t le16_to_cpu(le16_t v) { return v.__u16; }
> +static inline uint32_t le32_to_cpu(le32_t v) { return v.__u32; }
> +static inline uint64_t le64_to_cpu(le64_t v) { return v.__u64; }
> +
> +static inline le16_t cpu_to_le16(uint16_t v) { le16_t t =3D {v}; return=
 t; }
> +static inline le32_t cpu_to_le32(uint32_t v) { le32_t t =3D {v}; return=
 t; }
> +static inline le64_t cpu_to_le64(uint64_t v) { le64_t t =3D {v}; return=
 t; }
> +
> +typedef size_t bitmap_t;
> +
> +#elif EXFAT_BYTE_ORDER =3D=3D EXFAT_BIG_ENDIAN
> +
> +static inline uint16_t le16_to_cpu(le16_t v)
> +	{ return exfat_bswap16(v.__u16); }
> +static inline uint32_t le32_to_cpu(le32_t v)
> +	{ return exfat_bswap32(v.__u32); }
> +static inline uint64_t le64_to_cpu(le64_t v)
> +	{ return exfat_bswap64(v.__u64); }
> +
> +static inline le16_t cpu_to_le16(uint16_t v)
> +	{ le16_t t =3D {exfat_bswap16(v)}; return t; }
> +static inline le32_t cpu_to_le32(uint32_t v)
> +	{ le32_t t =3D {exfat_bswap32(v)}; return t; }
> +static inline le64_t cpu_to_le64(uint64_t v)
> +	{ le64_t t =3D {exfat_bswap64(v)}; return t; }
> +
> +typedef unsigned char bitmap_t;
> +
> +#else
> +#error Wow! You have a PDP machine?!
> +#endif
> +
> +#endif /* ifndef BYTEORDER_H_INCLUDED */
> diff --git a/fs/exfat/cluster.c b/fs/exfat/cluster.c
> new file mode 100644
> index 00000000000..4ee6135fd84
> --- /dev/null
> +++ b/fs/exfat/cluster.c
> @@ -0,0 +1,496 @@
> +/*
> +	cluster.c (03.09.09)
> +	exFAT file system implementation library.
> +
> +	Free exFAT implementation.
> +	Copyright (C) 2010-2023  Andrew Nayenko
> +
> +	This program is free software; you can redistribute it and/or modify
> +	it under the terms of the GNU General Public License as published by
> +	the Free Software Foundation, either version 2 of the License, or
> +	(at your option) any later version.
> +
> +	This program is distributed in the hope that it will be useful,
> +	but WITHOUT ANY WARRANTY; without even the implied warranty of
> +	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +	GNU General Public License for more details.
> +
> +	You should have received a copy of the GNU General Public License alon=
g
> +	with this program; if not, write to the Free Software Foundation, Inc.=
,
> +	51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +*/
> +
> +#include "exfat.h"
> +#include <errno.h>
> +#include <string.h>
> +#include <inttypes.h>
> +
> +/*
> + * Sector to absolute offset.
> + */
> +static off_t s2o(const struct exfat* ef, off_t sector)
> +{
> +	return sector << ef->sb->sector_bits;
> +}
> +
> +/*
> + * Cluster to sector.
> + */
> +static off_t c2s(const struct exfat* ef, cluster_t cluster)
> +{
> +	if (cluster < EXFAT_FIRST_DATA_CLUSTER)
> +		exfat_bug("invalid cluster number %u", cluster);
> +	return le32_to_cpu(ef->sb->cluster_sector_start) +
> +		((off_t) (cluster - EXFAT_FIRST_DATA_CLUSTER) << ef->sb->spc_bits);
> +}
> +
> +/*
> + * Cluster to absolute offset.
> + */
> +off_t exfat_c2o(const struct exfat* ef, cluster_t cluster)
> +{
> +	return s2o(ef, c2s(ef, cluster));
> +}
> +
> +/*
> + * Sector to cluster.
> + */
> +static cluster_t s2c(const struct exfat* ef, off_t sector)
> +{
> +	return ((sector - le32_to_cpu(ef->sb->cluster_sector_start)) >>
> +			ef->sb->spc_bits) + EXFAT_FIRST_DATA_CLUSTER;
> +}
> +
> +/*
> + * Size in bytes to size in clusters (rounded upwards).
> + */
> +static uint32_t bytes2clusters(const struct exfat* ef, uint64_t bytes)
> +{
> +	uint64_t cluster_size =3D CLUSTER_SIZE(*ef->sb);
> +	return DIV_ROUND_UP(bytes, cluster_size);
> +}
> +
> +cluster_t exfat_next_cluster(const struct exfat* ef,
> +		const struct exfat_node* node, cluster_t cluster)
> +{
> +	le32_t next;
> +	off_t fat_offset;
> +
> +	if (cluster < EXFAT_FIRST_DATA_CLUSTER)
> +		exfat_bug("bad cluster 0x%x", cluster);
> +
> +	if (node->is_contiguous)
> +		return cluster + 1;
> +	fat_offset =3D s2o(ef, le32_to_cpu(ef->sb->fat_sector_start))
> +		+ cluster * sizeof(cluster_t);
> +	if (exfat_pread(ef->dev, &next, sizeof(next), fat_offset) < 0)
> +		return EXFAT_CLUSTER_BAD; /* the caller should handle this and print
> +		                             appropriate error message */
> +	return le32_to_cpu(next);
> +}
> +
> +cluster_t exfat_advance_cluster(const struct exfat* ef,
> +		struct exfat_node* node, uint32_t count)
> +{
> +	uint32_t i;
> +
> +	if (node->fptr_index > count)
> +	{
> +		node->fptr_index =3D 0;
> +		node->fptr_cluster =3D node->start_cluster;
> +	}
> +
> +	for (i =3D node->fptr_index; i < count; i++)
> +	{
> +		node->fptr_cluster =3D exfat_next_cluster(ef, node, node->fptr_cluste=
r);
> +		if (CLUSTER_INVALID(*ef->sb, node->fptr_cluster))
> +			break; /* the caller should handle this and print appropriate
> +			          error message */
> +	}
> +	node->fptr_index =3D count;
> +	return node->fptr_cluster;
> +}
> +
> +static cluster_t find_bit_and_set(bitmap_t* bitmap, size_t start, size_=
t end)
> +{
> +	const size_t start_index =3D start / sizeof(bitmap_t) / 8;
> +	const size_t end_index =3D DIV_ROUND_UP(end, sizeof(bitmap_t) * 8);
> +	size_t i;
> +	size_t start_bitindex;
> +	size_t end_bitindex;
> +	size_t c;
> +
> +	for (i =3D start_index; i < end_index; i++)
> +	{
> +		if (bitmap[i] =3D=3D (bitmap_t) ~((bitmap_t) 0))
> +			continue;
> +		start_bitindex =3D MAX(i * sizeof(bitmap_t) * 8, start);
> +		end_bitindex =3D MIN((i + 1) * sizeof(bitmap_t) * 8, end);
> +		for (c =3D start_bitindex; c < end_bitindex; c++)
> +			if (BMAP_GET(bitmap, c) =3D=3D 0)
> +			{
> +				BMAP_SET(bitmap, c);
> +				return c + EXFAT_FIRST_DATA_CLUSTER;
> +			}
> +	}
> +	return EXFAT_CLUSTER_END;
> +}
> +
> +static int flush_nodes(struct exfat* ef, struct exfat_node* node)
> +{
> +	struct exfat_node* p;
> +
> +	for (p =3D node->child; p !=3D NULL; p =3D p->next)
> +	{
> +		int rc =3D flush_nodes(ef, p);
> +		if (rc !=3D 0)
> +			return rc;
> +	}
> +	return exfat_flush_node(ef, node);
> +}
> +
> +int exfat_flush_nodes(struct exfat* ef)
> +{
> +	return flush_nodes(ef, ef->root);
> +}
> +
> +int exfat_flush(struct exfat* ef)
> +{
> +	if (ef->cmap.dirty)
> +	{
> +		if (exfat_pwrite(ef->dev, ef->cmap.chunk,
> +				BMAP_SIZE(ef->cmap.chunk_size),
> +				exfat_c2o(ef, ef->cmap.start_cluster)) < 0)
> +		{
> +			exfat_error("failed to write clusters bitmap");
> +			return -EIO;
> +		}
> +		ef->cmap.dirty =3D false;
> +	}
> +
> +	return 0;
> +}
> +
> +static bool set_next_cluster(const struct exfat* ef, bool contiguous,
> +		cluster_t current, cluster_t next)
> +{
> +	off_t fat_offset;
> +	le32_t next_le32;
> +
> +	if (contiguous)
> +		return true;
> +	fat_offset =3D s2o(ef, le32_to_cpu(ef->sb->fat_sector_start))
> +		+ current * sizeof(cluster_t);
> +	next_le32 =3D cpu_to_le32(next);
> +	if (exfat_pwrite(ef->dev, &next_le32, sizeof(next_le32), fat_offset) <=
 0)
> +	{
> +		exfat_error("failed to write the next cluster %#x after %#x", next,
> +				current);
> +		return false;
> +	}
> +	return true;
> +}
> +
> +static cluster_t allocate_cluster(struct exfat* ef, cluster_t hint)
> +{
> +	cluster_t cluster;
> +
> +	hint -=3D EXFAT_FIRST_DATA_CLUSTER;
> +	if (hint >=3D ef->cmap.chunk_size)
> +		hint =3D 0;
> +
> +	cluster =3D find_bit_and_set(ef->cmap.chunk, hint, ef->cmap.chunk_size=
);
> +	if (cluster =3D=3D EXFAT_CLUSTER_END)
> +		cluster =3D find_bit_and_set(ef->cmap.chunk, 0, hint);
> +	if (cluster =3D=3D EXFAT_CLUSTER_END)
> +	{
> +		exfat_error("no free space left");
> +		return EXFAT_CLUSTER_END;
> +	}
> +
> +	ef->cmap.dirty =3D true;
> +	return cluster;
> +}
> +
> +static void free_cluster(struct exfat* ef, cluster_t cluster)
> +{
> +	if (cluster - EXFAT_FIRST_DATA_CLUSTER >=3D ef->cmap.size)
> +		exfat_bug("caller must check cluster validity (%#x, %#x)", cluster,
> +				ef->cmap.size);
> +
> +	BMAP_CLR(ef->cmap.chunk, cluster - EXFAT_FIRST_DATA_CLUSTER);
> +	ef->cmap.dirty =3D true;
> +}
> +
> +static bool make_noncontiguous(const struct exfat* ef, cluster_t first,
> +		cluster_t last)
> +{
> +	cluster_t c;
> +
> +	for (c =3D first; c < last; c++)
> +		if (!set_next_cluster(ef, false, c, c + 1))
> +			return false;
> +	return true;
> +}
> +
> +static int shrink_file(struct exfat* ef, struct exfat_node* node,
> +		uint32_t current, uint32_t difference);
> +
> +static int grow_file(struct exfat* ef, struct exfat_node* node,
> +		uint32_t current, uint32_t difference)
> +{
> +	cluster_t previous;
> +	cluster_t next;
> +	uint32_t allocated =3D 0;
> +
> +	if (difference =3D=3D 0)
> +		exfat_bug("zero clusters count passed");
> +
> +	if (node->start_cluster !=3D EXFAT_CLUSTER_FREE)
> +	{
> +		/* get the last cluster of the file */
> +		previous =3D exfat_advance_cluster(ef, node, current - 1);
> +		if (CLUSTER_INVALID(*ef->sb, previous))
> +		{
> +			exfat_error("invalid cluster 0x%x while growing", previous);
> +			return -EIO;
> +		}
> +	}
> +	else
> +	{
> +		if (node->fptr_index !=3D 0)
> +			exfat_bug("non-zero pointer index (%u)", node->fptr_index);
> +		/* file does not have clusters (i.e. is empty), allocate
> +		   the first one for it */
> +		previous =3D allocate_cluster(ef, 0);
> +		if (CLUSTER_INVALID(*ef->sb, previous))
> +			return -ENOSPC;
> +		node->fptr_cluster =3D node->start_cluster =3D previous;
> +		allocated =3D 1;
> +		/* file consists of only one cluster, so it's contiguous */
> +		node->is_contiguous =3D true;
> +	}
> +
> +	while (allocated < difference)
> +	{
> +		next =3D allocate_cluster(ef, previous + 1);
> +		if (CLUSTER_INVALID(*ef->sb, next))
> +		{
> +			if (allocated !=3D 0)
> +				shrink_file(ef, node, current + allocated, allocated);
> +			return -ENOSPC;
> +		}
> +		if (next !=3D previous + 1 && node->is_contiguous)
> +		{
> +			/* it's a pity, but we are not able to keep the file contiguous
> +			   anymore */
> +			if (!make_noncontiguous(ef, node->start_cluster, previous))
> +				return -EIO;
> +			node->is_contiguous =3D false;
> +			node->is_dirty =3D true;
> +		}
> +		if (!set_next_cluster(ef, node->is_contiguous, previous, next))
> +			return -EIO;
> +		previous =3D next;
> +		allocated++;
> +	}
> +
> +	if (!set_next_cluster(ef, node->is_contiguous, previous,
> +			EXFAT_CLUSTER_END))
> +		return -EIO;
> +	return 0;
> +}
> +
> +static int shrink_file(struct exfat* ef, struct exfat_node* node,
> +		uint32_t current, uint32_t difference)
> +{
> +	cluster_t previous;
> +	cluster_t next;
> +
> +	if (difference =3D=3D 0)
> +		exfat_bug("zero difference passed");
> +	if (node->start_cluster =3D=3D EXFAT_CLUSTER_FREE)
> +		exfat_bug("unable to shrink empty file (%u clusters)", current);
> +	if (current < difference)
> +		exfat_bug("file underflow (%u < %u)", current, difference);
> +
> +	/* crop the file */
> +	if (current > difference)
> +	{
> +		cluster_t last =3D exfat_advance_cluster(ef, node,
> +				current - difference - 1);
> +		if (CLUSTER_INVALID(*ef->sb, last))
> +		{
> +			exfat_error("invalid cluster 0x%x while shrinking", last);
> +			return -EIO;
> +		}
> +		previous =3D exfat_next_cluster(ef, node, last);
> +		if (!set_next_cluster(ef, node->is_contiguous, last,
> +				EXFAT_CLUSTER_END))
> +			return -EIO;
> +	}
> +	else
> +	{
> +		previous =3D node->start_cluster;
> +		node->start_cluster =3D EXFAT_CLUSTER_FREE;
> +		node->is_dirty =3D true;
> +	}
> +	node->fptr_index =3D 0;
> +	node->fptr_cluster =3D node->start_cluster;
> +
> +	/* free remaining clusters */
> +	while (difference--)
> +	{
> +		if (CLUSTER_INVALID(*ef->sb, previous))
> +		{
> +			exfat_error("invalid cluster 0x%x while freeing after shrink",
> +					previous);
> +			return -EIO;
> +		}
> +
> +		next =3D exfat_next_cluster(ef, node, previous);
> +		if (!set_next_cluster(ef, node->is_contiguous, previous,
> +				EXFAT_CLUSTER_FREE))
> +			return -EIO;
> +		free_cluster(ef, previous);
> +		previous =3D next;
> +	}
> +	return 0;
> +}
> +
> +static bool erase_raw(struct exfat* ef, size_t size, off_t offset)
> +{
> +	if (exfat_pwrite(ef->dev, ef->zero_cluster, size, offset) < 0)
> +	{
> +		exfat_error("failed to erase %zu bytes at %"PRId64, size, offset);
> +		return false;
> +	}
> +	return true;
> +}
> +
> +static int erase_range(struct exfat* ef, struct exfat_node* node,
> +		uint64_t begin, uint64_t end)
> +{
> +	uint64_t cluster_boundary;
> +	cluster_t cluster;
> +
> +	if (begin >=3D end)
> +		return 0;
> +
> +	cluster_boundary =3D (begin | (CLUSTER_SIZE(*ef->sb) - 1)) + 1;
> +	cluster =3D exfat_advance_cluster(ef, node,
> +			begin / CLUSTER_SIZE(*ef->sb));
> +	if (CLUSTER_INVALID(*ef->sb, cluster))
> +	{
> +		exfat_error("invalid cluster 0x%x while erasing", cluster);
> +		return -EIO;
> +	}
> +	/* erase from the beginning to the closest cluster boundary */
> +	if (!erase_raw(ef, MIN(cluster_boundary, end) - begin,
> +			exfat_c2o(ef, cluster) + begin % CLUSTER_SIZE(*ef->sb)))
> +		return -EIO;
> +	/* erase whole clusters */
> +	while (cluster_boundary < end)
> +	{
> +		cluster =3D exfat_next_cluster(ef, node, cluster);
> +		/* the cluster cannot be invalid because we have just allocated it */
> +		if (CLUSTER_INVALID(*ef->sb, cluster))
> +			exfat_bug("invalid cluster 0x%x after allocation", cluster);
> +		if (!erase_raw(ef, CLUSTER_SIZE(*ef->sb), exfat_c2o(ef, cluster)))
> +			return -EIO;
> +		cluster_boundary +=3D CLUSTER_SIZE(*ef->sb);
> +	}
> +	return 0;
> +}
> +
> +int exfat_truncate(struct exfat* ef, struct exfat_node* node, uint64_t =
size,
> +		bool erase)
> +{
> +	uint32_t c1 =3D bytes2clusters(ef, node->size);
> +	uint32_t c2 =3D bytes2clusters(ef, size);
> +	int rc =3D 0;
> +
> +	if (node->references =3D=3D 0 && node->parent)
> +		exfat_bug("no references, node changes can be lost");
> +
> +	if (node->size =3D=3D size)
> +		return 0;
> +
> +	if (c1 < c2)
> +		rc =3D grow_file(ef, node, c1, c2 - c1);
> +	else if (c1 > c2)
> +		rc =3D shrink_file(ef, node, c1, c1 - c2);
> +
> +	if (rc !=3D 0)
> +		return rc;
> +
> +	if (erase)
> +	{
> +		rc =3D erase_range(ef, node, node->valid_size, size);
> +		if (rc !=3D 0)
> +			return rc;
> +		node->valid_size =3D size;
> +	}
> +	else
> +	{
> +		node->valid_size =3D MIN(node->valid_size, size);
> +	}
> +
> +	exfat_update_mtime(node);
> +	node->size =3D size;
> +	node->is_dirty =3D true;
> +	return 0;
> +}
> +
> +uint32_t exfat_count_free_clusters(const struct exfat* ef)
> +{
> +	uint32_t free_clusters =3D 0;
> +	uint32_t i;
> +
> +	for (i =3D 0; i < ef->cmap.size; i++)
> +		if (BMAP_GET(ef->cmap.chunk, i) =3D=3D 0)
> +			free_clusters++;
> +	return free_clusters;
> +}
> +
> +static int find_used_clusters(const struct exfat* ef,
> +		cluster_t* a, cluster_t* b)
> +{
> +	const cluster_t end =3D le32_to_cpu(ef->sb->cluster_count);
> +
> +	/* find first used cluster */
> +	for (*a =3D *b + 1; *a < end; (*a)++)
> +		if (BMAP_GET(ef->cmap.chunk, *a - EXFAT_FIRST_DATA_CLUSTER))
> +			break;
> +	if (*a >=3D end)
> +		return 1;
> +
> +	/* find last contiguous used cluster */
> +	for (*b =3D *a; *b < end; (*b)++)
> +		if (BMAP_GET(ef->cmap.chunk, *b - EXFAT_FIRST_DATA_CLUSTER) =3D=3D 0)
> +		{
> +			(*b)--;
> +			break;
> +		}
> +
> +	return 0;
> +}
> +
> +int exfat_find_used_sectors(const struct exfat* ef, off_t* a, off_t* b)
> +{
> +	cluster_t ca, cb;
> +
> +	if (*a =3D=3D 0 && *b =3D=3D 0)
> +		ca =3D cb =3D EXFAT_FIRST_DATA_CLUSTER - 1;
> +	else
> +	{
> +		ca =3D s2c(ef, *a);
> +		cb =3D s2c(ef, *b);
> +	}
> +	if (find_used_clusters(ef, &ca, &cb) !=3D 0)
> +		return 1;
> +	if (*a !=3D 0 || *b !=3D 0)
> +		*a =3D c2s(ef, ca);
> +	*b =3D c2s(ef, cb) + (CLUSTER_SIZE(*ef->sb) - 1) / SECTOR_SIZE(*ef->sb=
);
> +	return 0;
> +}
> diff --git a/fs/exfat/compiler.h b/fs/exfat/compiler.h
> new file mode 100644
> index 00000000000..48658280839
> --- /dev/null
> +++ b/fs/exfat/compiler.h
> @@ -0,0 +1,69 @@
> +/*
> +	compiler.h (09.06.13)
> +	Compiler-specific definitions. Note that unknown compiler is not a
> +	showstopper.
> +
> +	Free exFAT implementation.
> +	Copyright (C) 2010-2023  Andrew Nayenko
> +
> +	This program is free software; you can redistribute it and/or modify
> +	it under the terms of the GNU General Public License as published by
> +	the Free Software Foundation, either version 2 of the License, or
> +	(at your option) any later version.
> +
> +	This program is distributed in the hope that it will be useful,
> +	but WITHOUT ANY WARRANTY; without even the implied warranty of
> +	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +	GNU General Public License for more details.
> +
> +	You should have received a copy of the GNU General Public License alon=
g
> +	with this program; if not, write to the Free Software Foundation, Inc.=
,
> +	51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +*/
> +
> +#ifndef COMPILER_H_INCLUDED
> +#define COMPILER_H_INCLUDED
> +
> +#if __STDC_VERSION__ < 199901L
> +#error C99-compliant compiler is required
> +#endif
> +
> +#if defined(__clang__)
> +
> +#define PRINTF __attribute__((format(printf, 1, 2)))
> +#define NORETURN __attribute__((noreturn))
> +#define PACKED __attribute__((packed))
> +#define UNUSED __attribute__((unused))
> +#if __has_extension(c_static_assert)
> +#define USE_C11_STATIC_ASSERT
> +#endif
> +
> +#elif defined(__GNUC__)
> +
> +#define PRINTF __attribute__((format(printf, 1, 2)))
> +#define NORETURN __attribute__((noreturn))
> +#define PACKED __attribute__((packed))
> +#define UNUSED __attribute__((unused))
> +#if __GNUC__ > 4 || (__GNUC__ =3D=3D 4 && __GNUC_MINOR__ >=3D 6)
> +#define USE_C11_STATIC_ASSERT
> +#endif
> +
> +#else
> +
> +#define PRINTF
> +#define NORETURN
> +#define PACKED
> +#define UNUSED
> +
> +#endif
> +
> +#ifdef USE_C11_STATIC_ASSERT
> +#define STATIC_ASSERT(cond) _Static_assert(cond, #cond)
> +#else
> +#define CONCAT2(a, b) a ## b
> +#define CONCAT1(a, b) CONCAT2(a, b)
> +#define STATIC_ASSERT(cond) \
> +	extern void CONCAT1(static_assert, __LINE__)(int x[(cond) ? 1 : -1])
> +#endif
> +
> +#endif /* ifndef COMPILER_H_INCLUDED */
> diff --git a/fs/exfat/exfat.h b/fs/exfat/exfat.h
> new file mode 100644
> index 00000000000..0e146e8f4d9
> --- /dev/null
> +++ b/fs/exfat/exfat.h
> @@ -0,0 +1,248 @@
> +/*
> +	exfat.h (29.08.09)
> +	Definitions of structures and constants used in exFAT file system
> +	implementation.
> +
> +	Free exFAT implementation.
> +	Copyright (C) 2010-2023  Andrew Nayenko
> +
> +	This program is free software; you can redistribute it and/or modify
> +	it under the terms of the GNU General Public License as published by
> +	the Free Software Foundation, either version 2 of the License, or
> +	(at your option) any later version.
> +
> +	This program is distributed in the hope that it will be useful,
> +	but WITHOUT ANY WARRANTY; without even the implied warranty of
> +	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +	GNU General Public License for more details.
> +
> +	You should have received a copy of the GNU General Public License alon=
g
> +	with this program; if not, write to the Free Software Foundation, Inc.=
,
> +	51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +*/
> +
> +#ifndef EXFAT_H_INCLUDED
> +#define EXFAT_H_INCLUDED
> +
> +#ifndef ANDROID
> +/* Android.bp is used instead of autotools when targeting Android */
> +#include "config.h"
> +#endif
> +#include "compiler.h"
> +#include "exfatfs.h"
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <time.h>
> +#include <stdbool.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +
> +#define EXFAT_NAME_MAX 255
> +/* UTF-16 encodes code points up to U+FFFF as single 16-bit code units.
> +   UTF-8 uses up to 3 bytes (i.e. 8-bit code units) to encode code poin=
ts
> +   up to U+FFFF. One additional character is for null terminator. */
> +#define EXFAT_UTF8_NAME_BUFFER_MAX (EXFAT_NAME_MAX * 3 + 1)
> +#define EXFAT_UTF8_ENAME_BUFFER_MAX (EXFAT_ENAME_MAX * 3 + 1)
> +
> +#define SECTOR_SIZE(sb) (1 << (sb).sector_bits)
> +#define CLUSTER_SIZE(sb) (SECTOR_SIZE(sb) << (sb).spc_bits)
> +#define CLUSTER_INVALID(sb, c) ((c) < EXFAT_FIRST_DATA_CLUSTER || \
> +	(c) - EXFAT_FIRST_DATA_CLUSTER >=3D le32_to_cpu((sb).cluster_count))
> +
> +#define MIN(a, b) ((a) < (b) ? (a) : (b))
> +#define MAX(a, b) ((a) > (b) ? (a) : (b))
> +#define DIV_ROUND_UP(x, d) (((x) + (d) - 1) / (d))
> +#define ROUND_UP(x, d) (DIV_ROUND_UP(x, d) * (d))
> +
> +#define BMAP_SIZE(count) (ROUND_UP(count, sizeof(bitmap_t) * 8) / 8)
> +#define BMAP_BLOCK(index) ((index) / sizeof(bitmap_t) / 8)
> +#define BMAP_MASK(index) ((bitmap_t) 1 << ((index) % (sizeof(bitmap_t) =
* 8)))
> +#define BMAP_GET(bitmap, index) \
> +	((bitmap)[BMAP_BLOCK(index)] & BMAP_MASK(index))
> +#define BMAP_SET(bitmap, index) \
> +	((bitmap)[BMAP_BLOCK(index)] |=3D BMAP_MASK(index))
> +#define BMAP_CLR(bitmap, index) \
> +	((bitmap)[BMAP_BLOCK(index)] &=3D ~BMAP_MASK(index))
> +
> +#define EXFAT_REPAIR(hook, ef, ...) \
> +	(exfat_ask_to_fix(ef) && exfat_fix_ ## hook(ef, __VA_ARGS__))
> +
> +/* The size of off_t type must be 64 bits. File systems larger than 2 G=
B will
> +   be corrupted with 32-bit off_t. */
> +STATIC_ASSERT(sizeof(off_t) =3D=3D 8);
> +
> +struct exfat_node
> +{
> +	struct exfat_node* parent;
> +	struct exfat_node* child;
> +	struct exfat_node* next;
> +	struct exfat_node* prev;
> +
> +	int references;
> +	uint32_t fptr_index;
> +	cluster_t fptr_cluster;
> +	off_t entry_offset;
> +	cluster_t start_cluster;
> +	uint16_t attrib;
> +	uint8_t continuations;
> +	bool is_contiguous : 1;
> +	bool is_cached : 1;
> +	bool is_dirty : 1;
> +	bool is_unlinked : 1;
> +	uint64_t valid_size;
> +	uint64_t size;
> +	time_t mtime, atime;
> +	le16_t name[EXFAT_NAME_MAX + 1];
> +};
> +
> +enum exfat_mode
> +{
> +	EXFAT_MODE_RO,
> +	EXFAT_MODE_RW,
> +	EXFAT_MODE_ANY,
> +};
> +
> +struct exfat_dev;
> +
> +struct exfat
> +{
> +	struct exfat_dev* dev;
> +	struct exfat_super_block* sb;
> +	uint16_t* upcase;
> +	struct exfat_node* root;
> +	struct
> +	{
> +		cluster_t start_cluster;
> +		uint32_t size;				/* in bits */
> +		bitmap_t* chunk;
> +		uint32_t chunk_size;		/* in bits */
> +		bool dirty;
> +	}
> +	cmap;
> +	char label[EXFAT_UTF8_ENAME_BUFFER_MAX];
> +	void* zero_cluster;
> +	int dmask, fmask;
> +	uid_t uid;
> +	gid_t gid;
> +	int ro;
> +	bool noatime;
> +	enum { EXFAT_REPAIR_NO, EXFAT_REPAIR_ASK, EXFAT_REPAIR_YES } repair;
> +};
> +
> +/* in-core nodes iterator */
> +struct exfat_iterator
> +{
> +	struct exfat_node* parent;
> +	struct exfat_node* current;
> +};
> +
> +struct exfat_human_bytes
> +{
> +	uint64_t value;
> +	const char* unit;
> +};
> +
> +extern int exfat_errors;
> +extern int exfat_errors_fixed;
> +
> +void exfat_bug(const char* format, ...) PRINTF NORETURN;
> +void exfat_error(const char* format, ...) PRINTF;
> +void exfat_warn(const char* format, ...) PRINTF;
> +void exfat_debug(const char* format, ...) PRINTF;
> +
> +struct exfat_dev* exfat_open(const char* spec, enum exfat_mode mode);
> +int exfat_close(struct exfat_dev* dev);
> +int exfat_fsync(struct exfat_dev* dev);
> +enum exfat_mode exfat_get_mode(const struct exfat_dev* dev);
> +off_t exfat_get_size(const struct exfat_dev* dev);
> +off_t exfat_seek(struct exfat_dev* dev, off_t offset, int whence);
> +ssize_t exfat_read(struct exfat_dev* dev, void* buffer, size_t size);
> +ssize_t exfat_write(struct exfat_dev* dev, const void* buffer, size_t s=
ize);
> +ssize_t exfat_pread(struct exfat_dev* dev, void* buffer, size_t size,
> +		off_t offset);
> +ssize_t exfat_pwrite(struct exfat_dev* dev, const void* buffer, size_t =
size,
> +		off_t offset);
> +ssize_t exfat_generic_pread(const struct exfat* ef, struct exfat_node* =
node,
> +		void* buffer, size_t size, off_t offset);
> +ssize_t exfat_generic_pwrite(struct exfat* ef, struct exfat_node* node,
> +		const void* buffer, size_t size, off_t offset);
> +
> +int exfat_opendir(struct exfat* ef, struct exfat_node* dir,
> +		struct exfat_iterator* it);
> +void exfat_closedir(struct exfat* ef, struct exfat_iterator* it);
> +struct exfat_node* exfat_readdir(struct exfat_iterator* it);
> +int exfat_lookup(struct exfat* ef, struct exfat_node** node,
> +		const char* path);
> +int exfat_split(struct exfat* ef, struct exfat_node** parent,
> +		struct exfat_node** node, le16_t* name, const char* path);
> +
> +off_t exfat_c2o(const struct exfat* ef, cluster_t cluster);
> +cluster_t exfat_next_cluster(const struct exfat* ef,
> +		const struct exfat_node* node, cluster_t cluster);
> +cluster_t exfat_advance_cluster(const struct exfat* ef,
> +		struct exfat_node* node, uint32_t count);
> +int exfat_flush_nodes(struct exfat* ef);
> +int exfat_flush(struct exfat* ef);
> +int exfat_truncate(struct exfat* ef, struct exfat_node* node, uint64_t =
size,
> +		bool erase);
> +uint32_t exfat_count_free_clusters(const struct exfat* ef);
> +int exfat_find_used_sectors(const struct exfat* ef, off_t* a, off_t* b)=
;
> +
> +void exfat_stat(const struct exfat* ef, const struct exfat_node* node,
> +		struct stat* stbuf);
> +void exfat_get_name(const struct exfat_node* node,
> +		char buffer[EXFAT_UTF8_NAME_BUFFER_MAX]);
> +uint16_t exfat_start_checksum(const struct exfat_entry_meta1* entry);
> +uint16_t exfat_add_checksum(const void* entry, uint16_t sum);
> +le16_t exfat_calc_checksum(const struct exfat_entry* entries, int n);
> +uint32_t exfat_vbr_start_checksum(const void* sector, size_t size);
> +uint32_t exfat_vbr_add_checksum(const void* sector, size_t size, uint32=
_t sum);
> +le16_t exfat_calc_name_hash(const struct exfat* ef, const le16_t* name,
> +		size_t length);
> +void exfat_humanize_bytes(uint64_t value, struct exfat_human_bytes* hb)=
;
> +void exfat_print_info(const struct exfat_super_block* sb,
> +		uint32_t free_clusters);
> +bool exfat_match_option(const char* options, const char* option_name);
> +
> +int exfat_utf16_to_utf8(char* output, const le16_t* input, size_t outsi=
ze,
> +		size_t insize);
> +int exfat_utf8_to_utf16(le16_t* output, const char* input, size_t outsi=
ze,
> +		size_t insize);
> +size_t exfat_utf16_length(const le16_t* str);
> +
> +struct exfat_node* exfat_get_node(struct exfat_node* node);
> +void exfat_put_node(struct exfat* ef, struct exfat_node* node);
> +int exfat_cleanup_node(struct exfat* ef, struct exfat_node* node);
> +int exfat_cache_directory(struct exfat* ef, struct exfat_node* dir);
> +void exfat_reset_cache(struct exfat* ef);
> +int exfat_flush_node(struct exfat* ef, struct exfat_node* node);
> +int exfat_unlink(struct exfat* ef, struct exfat_node* node);
> +int exfat_rmdir(struct exfat* ef, struct exfat_node* node);
> +int exfat_mknod(struct exfat* ef, const char* path);
> +int exfat_mkdir(struct exfat* ef, const char* path);
> +int exfat_rename(struct exfat* ef, const char* old_path, const char* ne=
w_path);
> +void exfat_utimes(struct exfat_node* node, const struct timespec tv[2])=
;
> +void exfat_update_atime(struct exfat_node* node);
> +void exfat_update_mtime(struct exfat_node* node);
> +const char* exfat_get_label(struct exfat* ef);
> +int exfat_set_label(struct exfat* ef, const char* label);
> +
> +int exfat_soil_super_block(const struct exfat* ef);
> +int exfat_mount(struct exfat* ef, const char* spec, const char* options=
);
> +void exfat_unmount(struct exfat* ef);
> +
> +time_t exfat_exfat2unix(le16_t date, le16_t time, uint8_t centisec,
> +		uint8_t tzoffset);
> +void exfat_unix2exfat(time_t unix_time, le16_t* date, le16_t* time,
> +		uint8_t* centisec, uint8_t* tzoffset);
> +void exfat_tzset(void);
> +
> +bool exfat_ask_to_fix(const struct exfat* ef);
> +bool exfat_fix_invalid_vbr_checksum(const struct exfat* ef, void* secto=
r,
> +		uint32_t vbr_checksum);
> +bool exfat_fix_invalid_node_checksum(const struct exfat* ef,
> +		struct exfat_node* node);
> +bool exfat_fix_unknown_entry(struct exfat* ef, struct exfat_node* dir,
> +		const struct exfat_entry* entry, off_t offset);
> +
> +#endif /* ifndef EXFAT_H_INCLUDED */
> diff --git a/fs/exfat/exfatfs.h b/fs/exfat/exfatfs.h
> new file mode 100644
> index 00000000000..3618d4d3024
> --- /dev/null
> +++ b/fs/exfat/exfatfs.h
> @@ -0,0 +1,181 @@
> +/*
> +	exfatfs.h (29.08.09)
> +	Definitions of structures and constants used in exFAT file system.
> +
> +	Free exFAT implementation.
> +	Copyright (C) 2010-2023  Andrew Nayenko
> +
> +	This program is free software; you can redistribute it and/or modify
> +	it under the terms of the GNU General Public License as published by
> +	the Free Software Foundation, either version 2 of the License, or
> +	(at your option) any later version.
> +
> +	This program is distributed in the hope that it will be useful,
> +	but WITHOUT ANY WARRANTY; without even the implied warranty of
> +	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +	GNU General Public License for more details.
> +
> +	You should have received a copy of the GNU General Public License alon=
g
> +	with this program; if not, write to the Free Software Foundation, Inc.=
,
> +	51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +*/
> +
> +#ifndef EXFATFS_H_INCLUDED
> +#define EXFATFS_H_INCLUDED
> +
> +#include "byteorder.h"
> +#include "compiler.h"
> +
> +typedef uint32_t cluster_t;		/* cluster number */
> +
> +#define EXFAT_FIRST_DATA_CLUSTER 2
> +#define EXFAT_LAST_DATA_CLUSTER 0xfffffff6
> +
> +#define EXFAT_CLUSTER_FREE         0 /* free cluster */
> +#define EXFAT_CLUSTER_BAD 0xfffffff7 /* cluster contains bad sector */
> +#define EXFAT_CLUSTER_END 0xffffffff /* final cluster of file or direct=
ory */
> +
> +#define EXFAT_STATE_MOUNTED 2
> +
> +struct exfat_super_block
> +{
> +	uint8_t jump[3];				/* 0x00 jmp and nop instructions */
> +	uint8_t oem_name[8];			/* 0x03 "EXFAT   " */
> +	uint8_t	__unused1[53];			/* 0x0B always 0 */
> +	le64_t sector_start;			/* 0x40 partition first sector */
> +	le64_t sector_count;			/* 0x48 partition sectors count */
> +	le32_t fat_sector_start;		/* 0x50 FAT first sector */
> +	le32_t fat_sector_count;		/* 0x54 FAT sectors count */
> +	le32_t cluster_sector_start;	/* 0x58 first cluster sector */
> +	le32_t cluster_count;			/* 0x5C total clusters count */
> +	le32_t rootdir_cluster;			/* 0x60 first cluster of the root dir */
> +	le32_t volume_serial;			/* 0x64 volume serial number */
> +	struct							/* 0x68 FS version */
> +	{
> +		uint8_t minor;
> +		uint8_t major;
> +	}
> +	version;
> +	le16_t volume_state;			/* 0x6A volume state flags */
> +	uint8_t sector_bits;			/* 0x6C sector size as (1 << n) */
> +	uint8_t spc_bits;				/* 0x6D sectors per cluster as (1 << n) */
> +	uint8_t fat_count;				/* 0x6E always 1 */
> +	uint8_t drive_no;				/* 0x6F always 0x80 */
> +	uint8_t allocated_percent;		/* 0x70 percentage of allocated space */
> +	uint8_t __unused2[397];			/* 0x71 always 0 */
> +	le16_t boot_signature;			/* the value of 0xAA55 */
> +}
> +PACKED;
> +STATIC_ASSERT(sizeof(struct exfat_super_block) =3D=3D 512);
> +
> +#define EXFAT_ENTRY_VALID     0x80
> +#define EXFAT_ENTRY_CONTINUED 0x40
> +#define EXFAT_ENTRY_OPTIONAL  0x20
> +
> +#define EXFAT_ENTRY_BITMAP    (0x01 | EXFAT_ENTRY_VALID)
> +#define EXFAT_ENTRY_UPCASE    (0x02 | EXFAT_ENTRY_VALID)
> +#define EXFAT_ENTRY_LABEL     (0x03 | EXFAT_ENTRY_VALID)
> +#define EXFAT_ENTRY_FILE      (0x05 | EXFAT_ENTRY_VALID)
> +#define EXFAT_ENTRY_FILE_INFO (0x00 | EXFAT_ENTRY_VALID | EXFAT_ENTRY_C=
ONTINUED)
> +#define EXFAT_ENTRY_FILE_NAME (0x01 | EXFAT_ENTRY_VALID | EXFAT_ENTRY_C=
ONTINUED)
> +#define EXFAT_ENTRY_FILE_TAIL (0x00 | EXFAT_ENTRY_VALID \
> +                                    | EXFAT_ENTRY_CONTINUED \
> +                                    | EXFAT_ENTRY_OPTIONAL)
> +
> +struct exfat_entry					/* common container for all entries */
> +{
> +	uint8_t type;					/* any of EXFAT_ENTRY_xxx */
> +	uint8_t data[31];
> +}
> +PACKED;
> +STATIC_ASSERT(sizeof(struct exfat_entry) =3D=3D 32);
> +
> +#define EXFAT_ENAME_MAX 15
> +
> +struct exfat_entry_bitmap			/* allocated clusters bitmap */
> +{
> +	uint8_t type;					/* EXFAT_ENTRY_BITMAP */
> +	uint8_t __unknown1[19];
> +	le32_t start_cluster;
> +	le64_t size;					/* in bytes */
> +}
> +PACKED;
> +STATIC_ASSERT(sizeof(struct exfat_entry_bitmap) =3D=3D 32);
> +
> +#define EXFAT_UPCASE_CHARS 0x10000
> +
> +struct exfat_entry_upcase			/* upper case translation table */
> +{
> +	uint8_t type;					/* EXFAT_ENTRY_UPCASE */
> +	uint8_t __unknown1[3];
> +	le32_t checksum;
> +	uint8_t __unknown2[12];
> +	le32_t start_cluster;
> +	le64_t size;					/* in bytes */
> +}
> +PACKED;
> +STATIC_ASSERT(sizeof(struct exfat_entry_upcase) =3D=3D 32);
> +
> +struct exfat_entry_label			/* volume label */
> +{
> +	uint8_t type;					/* EXFAT_ENTRY_LABEL */
> +	uint8_t length;					/* number of characters */
> +	le16_t name[EXFAT_ENAME_MAX];	/* in UTF-16LE */
> +}
> +PACKED;
> +STATIC_ASSERT(sizeof(struct exfat_entry_label) =3D=3D 32);
> +
> +#define EXFAT_ATTRIB_RO     0x01
> +#define EXFAT_ATTRIB_HIDDEN 0x02
> +#define EXFAT_ATTRIB_SYSTEM 0x04
> +#define EXFAT_ATTRIB_VOLUME 0x08
> +#define EXFAT_ATTRIB_DIR    0x10
> +#define EXFAT_ATTRIB_ARCH   0x20
> +
> +struct exfat_entry_meta1			/* file or directory info (part 1) */
> +{
> +	uint8_t type;					/* EXFAT_ENTRY_FILE */
> +	uint8_t continuations;
> +	le16_t checksum;
> +	le16_t attrib;					/* combination of EXFAT_ATTRIB_xxx */
> +	le16_t __unknown1;
> +	le16_t crtime, crdate;			/* creation date and time */
> +	le16_t mtime, mdate;			/* latest modification date and time */
> +	le16_t atime, adate;			/* latest access date and time */
> +	uint8_t crtime_cs;				/* creation time in cs (centiseconds) */
> +	uint8_t mtime_cs;				/* latest modification time in cs */
> +	uint8_t crtime_tzo, mtime_tzo, atime_tzo;	/* timezone offset encoded *=
/
> +	uint8_t __unknown2[7];
> +}
> +PACKED;
> +STATIC_ASSERT(sizeof(struct exfat_entry_meta1) =3D=3D 32);
> +
> +#define EXFAT_FLAG_ALWAYS1		(1u << 0)
> +#define EXFAT_FLAG_CONTIGUOUS	(1u << 1)
> +
> +struct exfat_entry_meta2			/* file or directory info (part 2) */
> +{
> +	uint8_t type;					/* EXFAT_ENTRY_FILE_INFO */
> +	uint8_t flags;					/* combination of EXFAT_FLAG_xxx */
> +	uint8_t __unknown1;
> +	uint8_t name_length;
> +	le16_t name_hash;
> +	le16_t __unknown2;
> +	le64_t valid_size;				/* in bytes, less or equal to size */
> +	uint8_t __unknown3[4];
> +	le32_t start_cluster;
> +	le64_t size;					/* in bytes */
> +}
> +PACKED;
> +STATIC_ASSERT(sizeof(struct exfat_entry_meta2) =3D=3D 32);
> +
> +struct exfat_entry_name				/* file or directory name */
> +{
> +	uint8_t type;					/* EXFAT_ENTRY_FILE_NAME */
> +	uint8_t __unknown;
> +	le16_t name[EXFAT_ENAME_MAX];	/* in UTF-16LE */
> +}
> +PACKED;
> +STATIC_ASSERT(sizeof(struct exfat_entry_name) =3D=3D 32);
> +
> +#endif /* ifndef EXFATFS_H_INCLUDED */
> diff --git a/fs/exfat/io.c b/fs/exfat/io.c
> new file mode 100644
> index 00000000000..7af5316da70
> --- /dev/null
> +++ b/fs/exfat/io.c
> @@ -0,0 +1,514 @@
> +/*
> +	io.c (02.09.09)
> +	exFAT file system implementation library.
> +
> +	Free exFAT implementation.
> +	Copyright (C) 2010-2023  Andrew Nayenko
> +
> +	This program is free software; you can redistribute it and/or modify
> +	it under the terms of the GNU General Public License as published by
> +	the Free Software Foundation, either version 2 of the License, or
> +	(at your option) any later version.
> +
> +	This program is distributed in the hope that it will be useful,
> +	but WITHOUT ANY WARRANTY; without even the implied warranty of
> +	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +	GNU General Public License for more details.
> +
> +	You should have received a copy of the GNU General Public License alon=
g
> +	with this program; if not, write to the Free Software Foundation, Inc.=
,
> +	51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +*/
> +
> +#include "exfat.h"
> +#include <inttypes.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <errno.h>
> +#if defined(__APPLE__)
> +#include <sys/disk.h>
> +#elif defined(__OpenBSD__)
> +#include <sys/param.h>
> +#include <sys/disklabel.h>
> +#include <sys/dkio.h>
> +#include <sys/ioctl.h>
> +#elif defined(__NetBSD__)
> +#include <sys/ioctl.h>
> +#elif __linux__
> +#include <sys/mount.h>
> +#endif
> +#ifdef USE_UBLIO
> +#include <sys/uio.h>
> +#include <ublio.h>
> +#endif
> +
> +struct exfat_dev
> +{
> +	int fd;
> +	enum exfat_mode mode;
> +	off_t size; /* in bytes */
> +#ifdef USE_UBLIO
> +	off_t pos;
> +	ublio_filehandle_t ufh;
> +#endif
> +};
> +
> +static bool is_open(int fd)
> +{
> +	return fcntl(fd, F_GETFD) !=3D -1;
> +}
> +
> +static int open_ro(const char* spec)
> +{
> +	return open(spec, O_RDONLY);
> +}
> +
> +static int open_rw(const char* spec)
> +{
> +	int fd =3D open(spec, O_RDWR);
> +#ifdef __linux__
> +	int ro =3D 0;
> +
> +	/*
> +	   This ioctl is needed because after "blockdev --setro" kernel still
> +	   allows to open the device in read-write mode but fails writes.
> +	*/
> +	if (fd !=3D -1 && ioctl(fd, BLKROGET, &ro) =3D=3D 0 && ro)
> +	{
> +		close(fd);
> +		errno =3D EROFS;
> +		return -1;
> +	}
> +#endif
> +	return fd;
> +}
> +
> +struct exfat_dev* exfat_open(const char* spec, enum exfat_mode mode)
> +{
> +	struct exfat_dev* dev;
> +	struct stat stbuf;
> +#ifdef USE_UBLIO
> +	struct ublio_param up;
> +#endif
> +
> +	/* The system allocates file descriptors sequentially. If we have been
> +	   started with stdin (0), stdout (1) or stderr (2) closed, the system
> +	   will give us descriptor 0, 1 or 2 later when we open block device,
> +	   FUSE communication pipe, etc. As a result, functions using stdin,
> +	   stdout or stderr will actually work with a different thing and can
> +	   corrupt it. Protect descriptors 0, 1 and 2 from such misuse. */
> +	while (!is_open(STDIN_FILENO)
> +		|| !is_open(STDOUT_FILENO)
> +		|| !is_open(STDERR_FILENO))
> +	{
> +		/* we don't need those descriptors, let them leak */
> +		if (open("/dev/null", O_RDWR) =3D=3D -1)
> +		{
> +			exfat_error("failed to open /dev/null");
> +			return NULL;
> +		}
> +	}
> +
> +	dev =3D malloc(sizeof(struct exfat_dev));
> +	if (dev =3D=3D NULL)
> +	{
> +		exfat_error("failed to allocate memory for device structure");
> +		return NULL;
> +	}
> +
> +	switch (mode)
> +	{
> +	case EXFAT_MODE_RO:
> +		dev->fd =3D open_ro(spec);
> +		if (dev->fd =3D=3D -1)
> +		{
> +			free(dev);
> +			exfat_error("failed to open '%s' in read-only mode: %s", spec,
> +					strerror(errno));
> +			return NULL;
> +		}
> +		dev->mode =3D EXFAT_MODE_RO;
> +		break;
> +	case EXFAT_MODE_RW:
> +		dev->fd =3D open_rw(spec);
> +		if (dev->fd =3D=3D -1)
> +		{
> +			free(dev);
> +			exfat_error("failed to open '%s' in read-write mode: %s", spec,
> +					strerror(errno));
> +			return NULL;
> +		}
> +		dev->mode =3D EXFAT_MODE_RW;
> +		break;
> +	case EXFAT_MODE_ANY:
> +		dev->fd =3D open_rw(spec);
> +		if (dev->fd !=3D -1)
> +		{
> +			dev->mode =3D EXFAT_MODE_RW;
> +			break;
> +		}
> +		dev->fd =3D open_ro(spec);
> +		if (dev->fd !=3D -1)
> +		{
> +			dev->mode =3D EXFAT_MODE_RO;
> +			exfat_warn("'%s' is write-protected, mounting read-only", spec);
> +			break;
> +		}
> +		free(dev);
> +		exfat_error("failed to open '%s': %s", spec, strerror(errno));
> +		return NULL;
> +	}
> +
> +	if (fstat(dev->fd, &stbuf) !=3D 0)
> +	{
> +		close(dev->fd);
> +		free(dev);
> +		exfat_error("failed to fstat '%s'", spec);
> +		return NULL;
> +	}
> +	if (!S_ISBLK(stbuf.st_mode) &&
> +		!S_ISCHR(stbuf.st_mode) &&
> +		!S_ISREG(stbuf.st_mode))
> +	{
> +		close(dev->fd);
> +		free(dev);
> +		exfat_error("'%s' is neither a device, nor a regular file", spec);
> +		return NULL;
> +	}
> +
> +#if defined(__APPLE__)
> +	if (!S_ISREG(stbuf.st_mode))
> +	{
> +		uint32_t block_size =3D 0;
> +		uint64_t blocks =3D 0;
> +
> +		if (ioctl(dev->fd, DKIOCGETBLOCKSIZE, &block_size) !=3D 0)
> +		{
> +			close(dev->fd);
> +			free(dev);
> +			exfat_error("failed to get block size");
> +			return NULL;
> +		}
> +		if (ioctl(dev->fd, DKIOCGETBLOCKCOUNT, &blocks) !=3D 0)
> +		{
> +			close(dev->fd);
> +			free(dev);
> +			exfat_error("failed to get blocks count");
> +			return NULL;
> +		}
> +		dev->size =3D blocks * block_size;
> +	}
> +	else
> +#elif defined(__OpenBSD__)
> +	if (!S_ISREG(stbuf.st_mode))
> +	{
> +		struct disklabel lab;
> +		struct partition* pp;
> +		char* partition;
> +
> +		if (ioctl(dev->fd, DIOCGDINFO, &lab) =3D=3D -1)
> +		{
> +			close(dev->fd);
> +			free(dev);
> +			exfat_error("failed to get disklabel");
> +			return NULL;
> +		}
> +
> +		/* Don't need to check that partition letter is valid as we won't get
> +		   this far otherwise. */
> +		partition =3D strchr(spec, '\0') - 1;
> +		pp =3D &(lab.d_partitions[*partition - 'a']);
> +		dev->size =3D DL_GETPSIZE(pp) * lab.d_secsize;
> +
> +		if (pp->p_fstype !=3D FS_NTFS)
> +			exfat_warn("partition type is not 0x07 (NTFS/exFAT); "
> +					"you can fix this with fdisk(8)");
> +	}
> +	else
> +#elif defined(__NetBSD__)
> +	if (!S_ISREG(stbuf.st_mode))
> +	{
> +		off_t size;
> +
> +		if (ioctl(dev->fd, DIOCGMEDIASIZE, &size) =3D=3D -1)
> +		{
> +			close(dev->fd);
> +			free(dev);
> +			exfat_error("failed to get media size");
> +			return NULL;
> +		}
> +		dev->size =3D size;
> +	}
> +	else
> +#endif
> +	{
> +		/* works for Linux, FreeBSD, Solaris */
> +		dev->size =3D exfat_seek(dev, 0, SEEK_END);
> +		if (dev->size <=3D 0)
> +		{
> +			close(dev->fd);
> +			free(dev);
> +			exfat_error("failed to get size of '%s'", spec);
> +			return NULL;
> +		}
> +		if (exfat_seek(dev, 0, SEEK_SET) =3D=3D -1)
> +		{
> +			close(dev->fd);
> +			free(dev);
> +			exfat_error("failed to seek to the beginning of '%s'", spec);
> +			return NULL;
> +		}
> +	}
> +
> +#ifdef USE_UBLIO
> +	memset(&up, 0, sizeof(struct ublio_param));
> +	up.up_blocksize =3D 256 * 1024;
> +	up.up_items =3D 64;
> +	up.up_grace =3D 32;
> +	up.up_priv =3D &dev->fd;
> +
> +	dev->pos =3D 0;
> +	dev->ufh =3D ublio_open(&up);
> +	if (dev->ufh =3D=3D NULL)
> +	{
> +		close(dev->fd);
> +		free(dev);
> +		exfat_error("failed to initialize ublio");
> +		return NULL;
> +	}
> +#endif
> +
> +	return dev;
> +}
> +
> +int exfat_close(struct exfat_dev* dev)
> +{
> +	int rc =3D 0;
> +
> +#ifdef USE_UBLIO
> +	if (ublio_close(dev->ufh) !=3D 0)
> +	{
> +		exfat_error("failed to close ublio");
> +		rc =3D -EIO;
> +	}
> +#endif
> +	if (close(dev->fd) !=3D 0)
> +	{
> +		exfat_error("failed to close device: %s", strerror(errno));
> +		rc =3D -EIO;
> +	}
> +	free(dev);
> +	return rc;
> +}
> +
> +int exfat_fsync(struct exfat_dev* dev)
> +{
> +	int rc =3D 0;
> +
> +#ifdef USE_UBLIO
> +	if (ublio_fsync(dev->ufh) !=3D 0)
> +	{
> +		exfat_error("ublio fsync failed");
> +		rc =3D -EIO;
> +	}
> +#endif
> +	if (fsync(dev->fd) !=3D 0)
> +	{
> +		exfat_error("fsync failed: %s", strerror(errno));
> +		rc =3D -EIO;
> +	}
> +	return rc;
> +}
> +
> +enum exfat_mode exfat_get_mode(const struct exfat_dev* dev)
> +{
> +	return dev->mode;
> +}
> +
> +off_t exfat_get_size(const struct exfat_dev* dev)
> +{
> +	return dev->size;
> +}
> +
> +off_t exfat_seek(struct exfat_dev* dev, off_t offset, int whence)
> +{
> +#ifdef USE_UBLIO
> +	/* XXX SEEK_CUR will be handled incorrectly */
> +	return dev->pos =3D lseek(dev->fd, offset, whence);
> +#else
> +	return lseek(dev->fd, offset, whence);
> +#endif
> +}
> +
> +ssize_t exfat_read(struct exfat_dev* dev, void* buffer, size_t size)
> +{
> +#ifdef USE_UBLIO
> +	ssize_t result =3D ublio_pread(dev->ufh, buffer, size, dev->pos);
> +	if (result >=3D 0)
> +		dev->pos +=3D size;
> +	return result;
> +#else
> +	return read(dev->fd, buffer, size);
> +#endif
> +}
> +
> +ssize_t exfat_write(struct exfat_dev* dev, const void* buffer, size_t s=
ize)
> +{
> +#ifdef USE_UBLIO
> +	ssize_t result =3D ublio_pwrite(dev->ufh, (void*) buffer, size, dev->p=
os);
> +	if (result >=3D 0)
> +		dev->pos +=3D size;
> +	return result;
> +#else
> +	return write(dev->fd, buffer, size);
> +#endif
> +}
> +
> +ssize_t exfat_pread(struct exfat_dev* dev, void* buffer, size_t size,
> +		off_t offset)
> +{
> +#ifdef USE_UBLIO
> +	return ublio_pread(dev->ufh, buffer, size, offset);
> +#else
> +	return pread(dev->fd, buffer, size, offset);
> +#endif
> +}
> +
> +ssize_t exfat_pwrite(struct exfat_dev* dev, const void* buffer, size_t =
size,
> +		off_t offset)
> +{
> +#ifdef USE_UBLIO
> +	return ublio_pwrite(dev->ufh, (void*) buffer, size, offset);
> +#else
> +	return pwrite(dev->fd, buffer, size, offset);
> +#endif
> +}
> +
> +ssize_t exfat_generic_pread(const struct exfat* ef, struct exfat_node* =
node,
> +		void* buffer, size_t size, off_t offset)
> +{
> +	uint64_t uoffset =3D offset;
> +	cluster_t cluster;
> +	char* bufp =3D buffer;
> +	off_t lsize, loffset, remainder;
> +
> +	if (offset < 0)
> +		return -EINVAL;
> +	if (uoffset >=3D node->size)
> +		return 0;
> +	if (size =3D=3D 0)
> +		return 0;
> +
> +	if (uoffset + size > node->valid_size)
> +	{
> +		ssize_t bytes =3D 0;
> +
> +		if (uoffset < node->valid_size)
> +		{
> +			bytes =3D exfat_generic_pread(ef, node, buffer,
> +					node->valid_size - uoffset, offset);
> +			if (bytes < 0 || (size_t) bytes < node->valid_size - uoffset)
> +				return bytes;
> +		}
> +		memset(buffer + bytes, 0,
> +				MIN(size - bytes, node->size - node->valid_size));
> +		return MIN(size, node->size - uoffset);
> +	}
> +
> +	cluster =3D exfat_advance_cluster(ef, node, uoffset / CLUSTER_SIZE(*ef=
->sb));
> +	if (CLUSTER_INVALID(*ef->sb, cluster))
> +	{
> +		exfat_error("invalid cluster 0x%x while reading", cluster);
> +		return -EIO;
> +	}
> +
> +	loffset =3D uoffset % CLUSTER_SIZE(*ef->sb);
> +	remainder =3D MIN(size, node->size - uoffset);
> +	while (remainder > 0)
> +	{
> +		if (CLUSTER_INVALID(*ef->sb, cluster))
> +		{
> +			exfat_error("invalid cluster 0x%x while reading", cluster);
> +			return -EIO;
> +		}
> +		lsize =3D MIN(CLUSTER_SIZE(*ef->sb) - loffset, remainder);
> +		if (exfat_pread(ef->dev, bufp, lsize,
> +					exfat_c2o(ef, cluster) + loffset) < 0)
> +		{
> +			exfat_error("failed to read cluster %#x", cluster);
> +			return -EIO;
> +		}
> +		bufp +=3D lsize;
> +		loffset =3D 0;
> +		remainder -=3D lsize;
> +		cluster =3D exfat_next_cluster(ef, node, cluster);
> +	}
> +	if (!(node->attrib & EXFAT_ATTRIB_DIR) && !ef->ro && !ef->noatime)
> +		exfat_update_atime(node);
> +	return MIN(size, node->size - uoffset) - remainder;
> +}
> +
> +ssize_t exfat_generic_pwrite(struct exfat* ef, struct exfat_node* node,
> +		const void* buffer, size_t size, off_t offset)
> +{
> +	uint64_t uoffset =3D offset;
> +	int rc;
> +	cluster_t cluster;
> +	const char* bufp =3D buffer;
> +	off_t lsize, loffset, remainder;
> +
> +	if (offset < 0)
> +		return -EINVAL;
> +	if (uoffset > node->size)
> +	{
> +		rc =3D exfat_truncate(ef, node, uoffset, true);
> +		if (rc !=3D 0)
> +			return rc;
> +	}
> +	if (uoffset + size > node->size)
> +	{
> +		rc =3D exfat_truncate(ef, node, uoffset + size, false);
> +		if (rc !=3D 0)
> +			return rc;
> +	}
> +	if (size =3D=3D 0)
> +		return 0;
> +
> +	cluster =3D exfat_advance_cluster(ef, node, uoffset / CLUSTER_SIZE(*ef=
->sb));
> +	if (CLUSTER_INVALID(*ef->sb, cluster))
> +	{
> +		exfat_error("invalid cluster 0x%x while writing", cluster);
> +		return -EIO;
> +	}
> +
> +	loffset =3D uoffset % CLUSTER_SIZE(*ef->sb);
> +	remainder =3D size;
> +	while (remainder > 0)
> +	{
> +		if (CLUSTER_INVALID(*ef->sb, cluster))
> +		{
> +			exfat_error("invalid cluster 0x%x while writing", cluster);
> +			return -EIO;
> +		}
> +		lsize =3D MIN(CLUSTER_SIZE(*ef->sb) - loffset, remainder);
> +		if (exfat_pwrite(ef->dev, bufp, lsize,
> +				exfat_c2o(ef, cluster) + loffset) < 0)
> +		{
> +			exfat_error("failed to write cluster %#x", cluster);
> +			return -EIO;
> +		}
> +		bufp +=3D lsize;
> +		loffset =3D 0;
> +		remainder -=3D lsize;
> +		node->valid_size =3D MAX(node->valid_size, uoffset + size - remainder=
);
> +		cluster =3D exfat_next_cluster(ef, node, cluster);
> +	}
> +	if (!(node->attrib & EXFAT_ATTRIB_DIR))
> +		/* directory's mtime should be updated by the caller only when it
> +		   creates or removes something in this directory */
> +		exfat_update_mtime(node);
> +	return size - remainder;
> +}
> diff --git a/fs/exfat/lookup.c b/fs/exfat/lookup.c
> new file mode 100644
> index 00000000000..bb7b1243632
> --- /dev/null
> +++ b/fs/exfat/lookup.c
> @@ -0,0 +1,222 @@
> +/*
> +	lookup.c (02.09.09)
> +	exFAT file system implementation library.
> +
> +	Free exFAT implementation.
> +	Copyright (C) 2010-2023  Andrew Nayenko
> +
> +	This program is free software; you can redistribute it and/or modify
> +	it under the terms of the GNU General Public License as published by
> +	the Free Software Foundation, either version 2 of the License, or
> +	(at your option) any later version.
> +
> +	This program is distributed in the hope that it will be useful,
> +	but WITHOUT ANY WARRANTY; without even the implied warranty of
> +	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +	GNU General Public License for more details.
> +
> +	You should have received a copy of the GNU General Public License alon=
g
> +	with this program; if not, write to the Free Software Foundation, Inc.=
,
> +	51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +*/
> +
> +#include "exfat.h"
> +#include <string.h>
> +#include <errno.h>
> +#include <inttypes.h>
> +
> +int exfat_opendir(struct exfat* ef, struct exfat_node* dir,
> +		struct exfat_iterator* it)
> +{
> +	int rc;
> +
> +	exfat_get_node(dir);
> +	it->parent =3D dir;
> +	it->current =3D NULL;
> +	rc =3D exfat_cache_directory(ef, dir);
> +	if (rc !=3D 0)
> +		exfat_put_node(ef, dir);
> +	return rc;
> +}
> +
> +void exfat_closedir(struct exfat* ef, struct exfat_iterator* it)
> +{
> +	exfat_put_node(ef, it->parent);
> +	it->parent =3D NULL;
> +	it->current =3D NULL;
> +}
> +
> +struct exfat_node* exfat_readdir(struct exfat_iterator* it)
> +{
> +	if (it->current =3D=3D NULL)
> +		it->current =3D it->parent->child;
> +	else
> +		it->current =3D it->current->next;
> +
> +	if (it->current !=3D NULL)
> +		return exfat_get_node(it->current);
> +	else
> +		return NULL;
> +}
> +
> +static int compare_char(struct exfat* ef, uint16_t a, uint16_t b)
> +{
> +	return (int) ef->upcase[a] - (int) ef->upcase[b];
> +}
> +
> +static int compare_name(struct exfat* ef, const le16_t* a, const le16_t=
* b)
> +{
> +	while (le16_to_cpu(*a) && le16_to_cpu(*b))
> +	{
> +		int rc =3D compare_char(ef, le16_to_cpu(*a), le16_to_cpu(*b));
> +		if (rc !=3D 0)
> +			return rc;
> +		a++;
> +		b++;
> +	}
> +	return compare_char(ef, le16_to_cpu(*a), le16_to_cpu(*b));
> +}
> +
> +static int lookup_name(struct exfat* ef, struct exfat_node* parent,
> +		struct exfat_node** node, const char* name, size_t n)
> +{
> +	struct exfat_iterator it;
> +	le16_t buffer[EXFAT_NAME_MAX + 1];
> +	int rc;
> +
> +	*node =3D NULL;
> +
> +	rc =3D exfat_utf8_to_utf16(buffer, name, EXFAT_NAME_MAX + 1, n);
> +	if (rc !=3D 0)
> +		return rc;
> +
> +	rc =3D exfat_opendir(ef, parent, &it);
> +	if (rc !=3D 0)
> +		return rc;
> +	while ((*node =3D exfat_readdir(&it)))
> +	{
> +		if (compare_name(ef, buffer, (*node)->name) =3D=3D 0)
> +		{
> +			exfat_closedir(ef, &it);
> +			return 0;
> +		}
> +		exfat_put_node(ef, *node);
> +	}
> +	exfat_closedir(ef, &it);
> +	return -ENOENT;
> +}
> +
> +static size_t get_comp(const char* path, const char** comp)
> +{
> +	const char* end;
> +
> +	*comp =3D path + strspn(path, "/");				/* skip leading slashes */
> +	end =3D strchr(*comp, '/');
> +	if (end =3D=3D NULL)
> +		return strlen(*comp);
> +	else
> +		return end - *comp;
> +}
> +
> +int exfat_lookup(struct exfat* ef, struct exfat_node** node,
> +		const char* path)
> +{
> +	struct exfat_node* parent;
> +	const char* p;
> +	size_t n;
> +	int rc;
> +
> +	/* start from the root directory */
> +	parent =3D *node =3D exfat_get_node(ef->root);
> +	for (p =3D path; (n =3D get_comp(p, &p)); p +=3D n)
> +	{
> +		if (n =3D=3D 1 && *p =3D=3D '.')				/* skip "." component */
> +			continue;
> +		rc =3D lookup_name(ef, parent, node, p, n);
> +		if (rc !=3D 0)
> +		{
> +			exfat_put_node(ef, parent);
> +			return rc;
> +		}
> +		exfat_put_node(ef, parent);
> +		parent =3D *node;
> +	}
> +	return 0;
> +}
> +
> +static bool is_last_comp(const char* comp, size_t length)
> +{
> +	const char* p =3D comp + length;
> +
> +	return get_comp(p, &p) =3D=3D 0;
> +}
> +
> +static bool is_allowed(const char* comp, size_t length)
> +{
> +	size_t i;
> +
> +	for (i =3D 0; i < length; i++)
> +		switch (comp[i])
> +		{
> +		case 0x01 ... 0x1f:
> +		case '/':
> +		case '\\':
> +		case ':':
> +		case '*':
> +		case '?':
> +		case '"':
> +		case '<':
> +		case '>':
> +		case '|':
> +			return false;
> +		}
> +	return true;
> +}
> +
> +int exfat_split(struct exfat* ef, struct exfat_node** parent,
> +		struct exfat_node** node, le16_t* name, const char* path)
> +{
> +	const char* p;
> +	size_t n;
> +	int rc;
> +
> +	memset(name, 0, (EXFAT_NAME_MAX + 1) * sizeof(le16_t));
> +	*parent =3D *node =3D exfat_get_node(ef->root);
> +	for (p =3D path; (n =3D get_comp(p, &p)); p +=3D n)
> +	{
> +		if (n =3D=3D 1 && *p =3D=3D '.')
> +			continue;
> +		if (is_last_comp(p, n))
> +		{
> +			if (!is_allowed(p, n))
> +			{
> +				/* contains characters that are not allowed */
> +				exfat_put_node(ef, *parent);
> +				return -ENOENT;
> +			}
> +			rc =3D exfat_utf8_to_utf16(name, p, EXFAT_NAME_MAX + 1, n);
> +			if (rc !=3D 0)
> +			{
> +				exfat_put_node(ef, *parent);
> +				return rc;
> +			}
> +
> +			rc =3D lookup_name(ef, *parent, node, p, n);
> +			if (rc !=3D 0 && rc !=3D -ENOENT)
> +			{
> +				exfat_put_node(ef, *parent);
> +				return rc;
> +			}
> +			return 0;
> +		}
> +		rc =3D lookup_name(ef, *parent, node, p, n);
> +		if (rc !=3D 0)
> +		{
> +			exfat_put_node(ef, *parent);
> +			return rc;
> +		}
> +		exfat_put_node(ef, *parent);
> +		*parent =3D *node;
> +	}
> +	exfat_bug("impossible");
> +}
> diff --git a/fs/exfat/mount.c b/fs/exfat/mount.c
> new file mode 100644
> index 00000000000..86fb84db244
> --- /dev/null
> +++ b/fs/exfat/mount.c
> @@ -0,0 +1,373 @@
> +/*
> +	mount.c (22.10.09)
> +	exFAT file system implementation library.
> +
> +	Free exFAT implementation.
> +	Copyright (C) 2010-2023  Andrew Nayenko
> +
> +	This program is free software; you can redistribute it and/or modify
> +	it under the terms of the GNU General Public License as published by
> +	the Free Software Foundation, either version 2 of the License, or
> +	(at your option) any later version.
> +
> +	This program is distributed in the hope that it will be useful,
> +	but WITHOUT ANY WARRANTY; without even the implied warranty of
> +	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +	GNU General Public License for more details.
> +
> +	You should have received a copy of the GNU General Public License alon=
g
> +	with this program; if not, write to the Free Software Foundation, Inc.=
,
> +	51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +*/
> +
> +#include "exfat.h"
> +#include <string.h>
> +#include <stdlib.h>
> +#include <errno.h>
> +#include <inttypes.h>
> +#include <unistd.h>
> +#include <sys/types.h>
> +
> +static uint64_t rootdir_size(const struct exfat* ef)
> +{
> +	uint32_t clusters =3D 0;
> +	uint32_t clusters_max =3D le32_to_cpu(ef->sb->cluster_count);
> +	cluster_t rootdir_cluster =3D le32_to_cpu(ef->sb->rootdir_cluster);
> +
> +	/* Iterate all clusters of the root directory to calculate its size.
> +	   It can't be contiguous because there is no flag to indicate this. *=
/
> +	do
> +	{
> +		if (clusters =3D=3D clusters_max) /* infinite loop detected */
> +		{
> +			exfat_error("root directory cannot occupy all %d clusters",
> +					clusters);
> +			return 0;
> +		}
> +		if (CLUSTER_INVALID(*ef->sb, rootdir_cluster))
> +		{
> +			exfat_error("bad cluster %#x while reading root directory",
> +					rootdir_cluster);
> +			return 0;
> +		}
> +		rootdir_cluster =3D exfat_next_cluster(ef, ef->root, rootdir_cluster)=
;
> +		clusters++;
> +	}
> +	while (rootdir_cluster !=3D EXFAT_CLUSTER_END);
> +
> +	return (uint64_t) clusters * CLUSTER_SIZE(*ef->sb);
> +}
> +
> +static const char* get_option(const char* options, const char* option_n=
ame)
> +{
> +	const char* p;
> +	size_t length =3D strlen(option_name);
> +
> +	for (p =3D strstr(options, option_name); p; p =3D strstr(p + 1, option=
_name))
> +		if ((p =3D=3D options || p[-1] =3D=3D ',') && p[length] =3D=3D '=3D')
> +			return p + length + 1;
> +	return NULL;
> +}
> +
> +static int get_int_option(const char* options, const char* option_name,
> +		int base, int default_value)
> +{
> +	const char* p =3D get_option(options, option_name);
> +
> +	if (p =3D=3D NULL)
> +		return default_value;
> +	return strtol(p, NULL, base);
> +}
> +
> +static void parse_options(struct exfat* ef, const char* options)
> +{
> +	int opt_umask;
> +
> +	opt_umask =3D get_int_option(options, "umask", 8, 0);
> +	ef->dmask =3D get_int_option(options, "dmask", 8, opt_umask);
> +	ef->fmask =3D get_int_option(options, "fmask", 8, opt_umask);
> +
> +	ef->uid =3D get_int_option(options, "uid", 10, geteuid());
> +	ef->gid =3D get_int_option(options, "gid", 10, getegid());
> +
> +	ef->noatime =3D exfat_match_option(options, "noatime");
> +
> +	switch (get_int_option(options, "repair", 10, 0))
> +	{
> +	case 1:
> +		ef->repair =3D EXFAT_REPAIR_ASK;
> +		break;
> +	case 2:
> +		ef->repair =3D EXFAT_REPAIR_YES;
> +		break;
> +	default:
> +		ef->repair =3D EXFAT_REPAIR_NO;
> +		break;
> +	}
> +}
> +
> +static bool verify_vbr_checksum(const struct exfat* ef, void* sector)
> +{
> +	off_t sector_size =3D SECTOR_SIZE(*ef->sb);
> +	uint32_t vbr_checksum;
> +	size_t i;
> +
> +	if (exfat_pread(ef->dev, sector, sector_size, 0) < 0)
> +	{
> +		exfat_error("failed to read boot sector");
> +		return false;
> +	}
> +	vbr_checksum =3D exfat_vbr_start_checksum(sector, sector_size);
> +	for (i =3D 1; i < 11; i++)
> +	{
> +		if (exfat_pread(ef->dev, sector, sector_size, i * sector_size) < 0)
> +		{
> +			exfat_error("failed to read VBR sector");
> +			return false;
> +		}
> +		vbr_checksum =3D exfat_vbr_add_checksum(sector, sector_size,
> +				vbr_checksum);
> +	}
> +	if (exfat_pread(ef->dev, sector, sector_size, i * sector_size) < 0)
> +	{
> +		exfat_error("failed to read VBR checksum sector");
> +		return false;
> +	}
> +	for (i =3D 0; i < sector_size / sizeof(vbr_checksum); i++)
> +		if (le32_to_cpu(((const le32_t*) sector)[i]) !=3D vbr_checksum)
> +		{
> +			exfat_error("invalid VBR checksum 0x%x (expected 0x%x)",
> +					le32_to_cpu(((const le32_t*) sector)[i]), vbr_checksum);
> +			if (!EXFAT_REPAIR(invalid_vbr_checksum, ef, sector, vbr_checksum))
> +				return false;
> +		}
> +	return true;
> +}
> +
> +static int commit_super_block(const struct exfat* ef)
> +{
> +	if (exfat_pwrite(ef->dev, ef->sb, sizeof(struct exfat_super_block), 0)=
 < 0)
> +	{
> +		exfat_error("failed to write super block");
> +		return 1;
> +	}
> +	return exfat_fsync(ef->dev);
> +}
> +
> +int exfat_soil_super_block(const struct exfat* ef)
> +{
> +	if (ef->ro)
> +		return 0;
> +
> +	ef->sb->volume_state =3D cpu_to_le16(
> +			le16_to_cpu(ef->sb->volume_state) | EXFAT_STATE_MOUNTED);
> +	return commit_super_block(ef);
> +}
> +
> +static void exfat_free(struct exfat* ef)
> +{
> +	exfat_close(ef->dev);	/* first of all, close the descriptor */
> +	ef->dev =3D NULL;			/* struct exfat_dev is freed by exfat_close() */
> +	free(ef->root);
> +	ef->root =3D NULL;
> +	free(ef->zero_cluster);
> +	ef->zero_cluster =3D NULL;
> +	free(ef->cmap.chunk);
> +	ef->cmap.chunk =3D NULL;
> +	free(ef->upcase);
> +	ef->upcase =3D NULL;
> +	free(ef->sb);
> +	ef->sb =3D NULL;
> +}
> +
> +int exfat_mount(struct exfat* ef, const char* spec, const char* options=
)
> +{
> +	int rc;
> +	enum exfat_mode mode;
> +
> +	exfat_tzset();
> +	memset(ef, 0, sizeof(struct exfat));
> +
> +	parse_options(ef, options);
> +
> +	if (exfat_match_option(options, "ro"))
> +		mode =3D EXFAT_MODE_RO;
> +	else if (exfat_match_option(options, "ro_fallback"))
> +		mode =3D EXFAT_MODE_ANY;
> +	else
> +		mode =3D EXFAT_MODE_RW;
> +	ef->dev =3D exfat_open(spec, mode);
> +	if (ef->dev =3D=3D NULL)
> +		return -ENODEV;
> +	if (exfat_get_mode(ef->dev) =3D=3D EXFAT_MODE_RO)
> +	{
> +		if (mode =3D=3D EXFAT_MODE_ANY)
> +			ef->ro =3D -1;
> +		else
> +			ef->ro =3D 1;
> +	}
> +
> +	ef->sb =3D malloc(sizeof(struct exfat_super_block));
> +	if (ef->sb =3D=3D NULL)
> +	{
> +		exfat_error("failed to allocate memory for the super block");
> +		exfat_free(ef);
> +		return -ENOMEM;
> +	}
> +	memset(ef->sb, 0, sizeof(struct exfat_super_block));
> +
> +	if (exfat_pread(ef->dev, ef->sb, sizeof(struct exfat_super_block), 0) =
< 0)
> +	{
> +		exfat_error("failed to read boot sector");
> +		exfat_free(ef);
> +		return -EIO;
> +	}
> +	if (memcmp(ef->sb->oem_name, "EXFAT   ", 8) !=3D 0)
> +	{
> +		exfat_error("exFAT file system is not found");
> +		exfat_free(ef);
> +		return -EIO;
> +	}
> +	/* sector cannot be smaller than 512 bytes */
> +	if (ef->sb->sector_bits < 9)
> +	{
> +		exfat_error("too small sector size: 2^%hhd", ef->sb->sector_bits);
> +		exfat_free(ef);
> +		return -EIO;
> +	}
> +	/* officially exFAT supports cluster size up to 32 MB */
> +	if ((int) ef->sb->sector_bits + (int) ef->sb->spc_bits > 25)
> +	{
> +		exfat_error("too big cluster size: 2^(%hhd+%hhd)",
> +				ef->sb->sector_bits, ef->sb->spc_bits);
> +		exfat_free(ef);
> +		return -EIO;
> +	}
> +	ef->zero_cluster =3D malloc(CLUSTER_SIZE(*ef->sb));
> +	if (ef->zero_cluster =3D=3D NULL)
> +	{
> +		exfat_error("failed to allocate zero sector");
> +		exfat_free(ef);
> +		return -ENOMEM;
> +	}
> +	/* use zero_cluster as a temporary buffer for VBR checksum verificatio=
n */
> +	if (!verify_vbr_checksum(ef, ef->zero_cluster))
> +	{
> +		exfat_free(ef);
> +		return -EIO;
> +	}
> +	memset(ef->zero_cluster, 0, CLUSTER_SIZE(*ef->sb));
> +	if (ef->sb->version.major !=3D 1 || ef->sb->version.minor !=3D 0)
> +	{
> +		exfat_error("unsupported exFAT version: %hhu.%hhu",
> +				ef->sb->version.major, ef->sb->version.minor);
> +		exfat_free(ef);
> +		return -EIO;
> +	}
> +	if (ef->sb->fat_count !=3D 1)
> +	{
> +		exfat_error("unsupported FAT count: %hhu", ef->sb->fat_count);
> +		exfat_free(ef);
> +		return -EIO;
> +	}
> +	if (le64_to_cpu(ef->sb->sector_count) * SECTOR_SIZE(*ef->sb) >
> +			(uint64_t) exfat_get_size(ef->dev))
> +	{
> +		/* this can cause I/O errors later but we don't fail mounting to let
> +		   user rescue data */
> +		exfat_warn("file system in sectors is larger than device: "
> +				"%"PRIu64" * %d > %"PRIu64,
> +				le64_to_cpu(ef->sb->sector_count), SECTOR_SIZE(*ef->sb),
> +				exfat_get_size(ef->dev));
> +	}
> +	if ((off_t) le32_to_cpu(ef->sb->cluster_count) * CLUSTER_SIZE(*ef->sb)=
 >
> +			exfat_get_size(ef->dev))
> +	{
> +		exfat_error("file system in clusters is larger than device: "
> +				"%u * %d > %"PRIu64,
> +				le32_to_cpu(ef->sb->cluster_count), CLUSTER_SIZE(*ef->sb),
> +				exfat_get_size(ef->dev));
> +		exfat_free(ef);
> +		return -EIO;
> +	}
> +	if (le16_to_cpu(ef->sb->volume_state) & EXFAT_STATE_MOUNTED)
> +		exfat_warn("volume was not unmounted cleanly");
> +
> +	ef->root =3D malloc(sizeof(struct exfat_node));
> +	if (ef->root =3D=3D NULL)
> +	{
> +		exfat_error("failed to allocate root node");
> +		exfat_free(ef);
> +		return -ENOMEM;
> +	}
> +	memset(ef->root, 0, sizeof(struct exfat_node));
> +	ef->root->attrib =3D EXFAT_ATTRIB_DIR;
> +	ef->root->start_cluster =3D le32_to_cpu(ef->sb->rootdir_cluster);
> +	ef->root->fptr_cluster =3D ef->root->start_cluster;
> +	ef->root->name[0] =3D cpu_to_le16('\0');
> +	ef->root->valid_size =3D ef->root->size =3D rootdir_size(ef);
> +	if (ef->root->size =3D=3D 0)
> +	{
> +		exfat_free(ef);
> +		return -EIO;
> +	}
> +	/* exFAT does not have time attributes for the root directory */
> +	ef->root->mtime =3D 0;
> +	ef->root->atime =3D 0;
> +	/* always keep at least 1 reference to the root node */
> +	exfat_get_node(ef->root);
> +
> +	rc =3D exfat_cache_directory(ef, ef->root);
> +	if (rc !=3D 0)
> +		goto error;
> +	if (ef->upcase =3D=3D NULL)
> +	{
> +		exfat_error("upcase table is not found");
> +		goto error;
> +	}
> +	if (ef->cmap.chunk =3D=3D NULL)
> +	{
> +		exfat_error("clusters bitmap is not found");
> +		goto error;
> +	}
> +
> +	return 0;
> +
> +error:
> +	exfat_put_node(ef, ef->root);
> +	exfat_reset_cache(ef);
> +	exfat_free(ef);
> +	return -EIO;
> +}
> +
> +static void finalize_super_block(struct exfat* ef)
> +{
> +	if (ef->ro)
> +		return;
> +
> +	ef->sb->volume_state =3D cpu_to_le16(
> +			le16_to_cpu(ef->sb->volume_state) & ~EXFAT_STATE_MOUNTED);
> +
> +	/* Some implementations set the percentage of allocated space to 0xff
> +	   on FS creation and never update it. In this case leave it as is. */
> +	if (ef->sb->allocated_percent !=3D 0xff)
> +	{
> +		uint32_t free, total;
> +
> +		free =3D exfat_count_free_clusters(ef);
> +		total =3D le32_to_cpu(ef->sb->cluster_count);
> +		ef->sb->allocated_percent =3D ((total - free) * 100 + total / 2) / to=
tal;
> +	}
> +
> +	commit_super_block(ef);	/* ignore return code */
> +}
> +
> +void exfat_unmount(struct exfat* ef)
> +{
> +	exfat_flush_nodes(ef);	/* ignore return code */
> +	exfat_flush(ef);		/* ignore return code */
> +	exfat_put_node(ef, ef->root);
> +	exfat_reset_cache(ef);
> +	finalize_super_block(ef);
> +	exfat_free(ef);			/* will close the descriptor */
> +}
> diff --git a/fs/exfat/node.c b/fs/exfat/node.c
> new file mode 100644
> index 00000000000..88b1357189c
> --- /dev/null
> +++ b/fs/exfat/node.c
> @@ -0,0 +1,1243 @@
> +/*
> +	node.c (09.10.09)
> +	exFAT file system implementation library.
> +
> +	Free exFAT implementation.
> +	Copyright (C) 2010-2023  Andrew Nayenko
> +
> +	This program is free software; you can redistribute it and/or modify
> +	it under the terms of the GNU General Public License as published by
> +	the Free Software Foundation, either version 2 of the License, or
> +	(at your option) any later version.
> +
> +	This program is distributed in the hope that it will be useful,
> +	but WITHOUT ANY WARRANTY; without even the implied warranty of
> +	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +	GNU General Public License for more details.
> +
> +	You should have received a copy of the GNU General Public License alon=
g
> +	with this program; if not, write to the Free Software Foundation, Inc.=
,
> +	51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +*/
> +
> +#include "exfat.h"
> +#include <errno.h>
> +#include <string.h>
> +#include <inttypes.h>
> +
> +#define EXFAT_ENTRY_NONE (-1)
> +
> +struct exfat_node* exfat_get_node(struct exfat_node* node)
> +{
> +	/* if we switch to multi-threaded mode we will need atomic
> +	   increment here and atomic decrement in exfat_put_node() */
> +	node->references++;
> +	return node;
> +}
> +
> +void exfat_put_node(struct exfat* ef, struct exfat_node* node)
> +{
> +	char buffer[EXFAT_UTF8_NAME_BUFFER_MAX];
> +
> +	--node->references;
> +	if (node->references < 0)
> +	{
> +		exfat_get_name(node, buffer);
> +		exfat_bug("reference counter of '%s' is below zero", buffer);
> +	}
> +	else if (node->references =3D=3D 0 && node !=3D ef->root)
> +	{
> +		if (node->is_dirty)
> +		{
> +			exfat_get_name(node, buffer);
> +			exfat_warn("dirty node '%s' with zero references", buffer);
> +		}
> +	}
> +}
> +
> +/**
> + * This function must be called on rmdir and unlink (after the last
> + * exfat_put_node()) to free clusters.
> + */
> +int exfat_cleanup_node(struct exfat* ef, struct exfat_node* node)
> +{
> +	int rc =3D 0;
> +
> +	if (node->references !=3D 0)
> +		exfat_bug("unable to cleanup a node with %d references",
> +				node->references);
> +
> +	if (node->is_unlinked)
> +	{
> +		/* free all clusters and node structure itself */
> +		rc =3D exfat_truncate(ef, node, 0, true);
> +		/* free the node even in case of error or its memory will be lost */
> +		free(node);
> +	}
> +	return rc;
> +}
> +
> +static int read_entries(struct exfat* ef, struct exfat_node* dir,
> +		struct exfat_entry* entries, int n, off_t offset)
> +{
> +	ssize_t size;
> +
> +	if (!(dir->attrib & EXFAT_ATTRIB_DIR))
> +		exfat_bug("attempted to read entries from a file");
> +
> +	size =3D exfat_generic_pread(ef, dir, entries,
> +			sizeof(struct exfat_entry[n]), offset);
> +	if (size =3D=3D (ssize_t) sizeof(struct exfat_entry) * n)
> +		return 0; /* success */
> +	if (size =3D=3D 0)
> +		return -ENOENT;
> +	if (size < 0)
> +		return -EIO;
> +	exfat_error("read %zd bytes instead of %zu bytes", size,
> +			sizeof(struct exfat_entry[n]));
> +	return -EIO;
> +}
> +
> +static int write_entries(struct exfat* ef, struct exfat_node* dir,
> +		const struct exfat_entry* entries, int n, off_t offset)
> +{
> +	ssize_t size;
> +
> +	if (!(dir->attrib & EXFAT_ATTRIB_DIR))
> +		exfat_bug("attempted to write entries into a file");
> +
> +	size =3D exfat_generic_pwrite(ef, dir, entries,
> +			sizeof(struct exfat_entry[n]), offset);
> +	if (size =3D=3D (ssize_t) sizeof(struct exfat_entry) * n)
> +		return 0; /* success */
> +	if (size < 0)
> +		return -EIO;
> +	exfat_error("wrote %zd bytes instead of %zu bytes", size,
> +			sizeof(struct exfat_entry[n]));
> +	return -EIO;
> +}
> +
> +static struct exfat_node* allocate_node(void)
> +{
> +	struct exfat_node* node =3D malloc(sizeof(struct exfat_node));
> +	if (node =3D=3D NULL)
> +	{
> +		exfat_error("failed to allocate node");
> +		return NULL;
> +	}
> +	memset(node, 0, sizeof(struct exfat_node));
> +	return node;
> +}
> +
> +static void init_node_meta1(struct exfat_node* node,
> +		const struct exfat_entry_meta1* meta1)
> +{
> +	node->attrib =3D le16_to_cpu(meta1->attrib);
> +	node->continuations =3D meta1->continuations;
> +	node->mtime =3D exfat_exfat2unix(meta1->mdate, meta1->mtime,
> +			meta1->mtime_cs, meta1->mtime_tzo);
> +	/* there is no centiseconds field for atime */
> +	node->atime =3D exfat_exfat2unix(meta1->adate, meta1->atime,
> +			0, meta1->atime_tzo);
> +}
> +
> +static void init_node_meta2(struct exfat_node* node,
> +		const struct exfat_entry_meta2* meta2)
> +{
> +	node->valid_size =3D le64_to_cpu(meta2->valid_size);
> +	node->size =3D le64_to_cpu(meta2->size);
> +	node->start_cluster =3D le32_to_cpu(meta2->start_cluster);
> +	node->fptr_cluster =3D node->start_cluster;
> +	node->is_contiguous =3D ((meta2->flags & EXFAT_FLAG_CONTIGUOUS) !=3D 0=
);
> +}
> +
> +static void init_node_name(struct exfat_node* node,
> +		const struct exfat_entry* entries, int n)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < n; i++)
> +		memcpy(node->name + i * EXFAT_ENAME_MAX,
> +				((const struct exfat_entry_name*) &entries[i])->name,
> +				EXFAT_ENAME_MAX * sizeof(le16_t));
> +}
> +
> +static bool check_entries(const struct exfat_entry* entry, int n)
> +{
> +	int previous =3D EXFAT_ENTRY_NONE;
> +	int current;
> +	int i;
> +
> +	/* check transitions between entries types */
> +	for (i =3D 0; i < n + 1; previous =3D current, i++)
> +	{
> +		bool valid =3D false;
> +
> +		current =3D (i < n) ? entry[i].type : EXFAT_ENTRY_NONE;
> +		switch (previous)
> +		{
> +		case EXFAT_ENTRY_NONE:
> +			valid =3D (current =3D=3D EXFAT_ENTRY_FILE);
> +			break;
> +		case EXFAT_ENTRY_FILE:
> +			valid =3D (current =3D=3D EXFAT_ENTRY_FILE_INFO);
> +			break;
> +		case EXFAT_ENTRY_FILE_INFO:
> +			valid =3D (current =3D=3D EXFAT_ENTRY_FILE_NAME);
> +			break;
> +		case EXFAT_ENTRY_FILE_NAME:
> +			valid =3D (current =3D=3D EXFAT_ENTRY_FILE_NAME ||
> +			         current =3D=3D EXFAT_ENTRY_NONE ||
> +			         current >=3D EXFAT_ENTRY_FILE_TAIL);
> +			break;
> +		case EXFAT_ENTRY_FILE_TAIL ... 0xff:
> +			valid =3D (current >=3D EXFAT_ENTRY_FILE_TAIL ||
> +			         current =3D=3D EXFAT_ENTRY_NONE);
> +			break;
> +		}
> +
> +		if (!valid)
> +		{
> +			exfat_error("unexpected entry type %#x after %#x at %d/%d",
> +					current, previous, i, n);
> +			return false;
> +		}
> +	}
> +	return true;
> +}
> +
> +static bool check_node(const struct exfat* ef, struct exfat_node* node,
> +		le16_t actual_checksum, const struct exfat_entry_meta1* meta1)
> +{
> +	int cluster_size =3D CLUSTER_SIZE(*ef->sb);
> +	uint64_t clusters_heap_size =3D
> +			(uint64_t) le32_to_cpu(ef->sb->cluster_count) * cluster_size;
> +	char buffer[EXFAT_UTF8_NAME_BUFFER_MAX];
> +	bool ret =3D true;
> +
> +	/*
> +	   Validate checksum first. If it's invalid all other fields probably
> +	   contain just garbage.
> +	*/
> +	if (le16_to_cpu(actual_checksum) !=3D le16_to_cpu(meta1->checksum))
> +	{
> +		exfat_get_name(node, buffer);
> +		exfat_error("'%s' has invalid checksum (%#hx !=3D %#hx)", buffer,
> +				le16_to_cpu(actual_checksum), le16_to_cpu(meta1->checksum));
> +		if (!EXFAT_REPAIR(invalid_node_checksum, ef, node))
> +			ret =3D false;
> +	}
> +
> +	/*
> +	   exFAT does not support sparse files but allows files with uninitial=
ized
> +	   clusters. For such files valid_size means initialized data size and
> +	   cannot be greater than file size. See SetFileValidData() function
> +	   description in MSDN.
> +	*/
> +	if (node->valid_size > node->size)
> +	{
> +		exfat_get_name(node, buffer);
> +		exfat_error("'%s' has valid size (%"PRIu64") greater than size "
> +				"(%"PRIu64")", buffer, node->valid_size, node->size);
> +		ret =3D false;
> +	}
> +
> +	/*
> +	   Empty file must have zero start cluster. Non-empty file must start
> +	   with a valid cluster. Directories cannot be empty (i.e. must always
> +	   have a valid start cluster), but we will check this later while
> +	   reading that directory to give user a chance to read this directory=
.
> +	*/
> +	if (node->size =3D=3D 0 && node->start_cluster !=3D EXFAT_CLUSTER_FREE=
)
> +	{
> +		exfat_get_name(node, buffer);
> +		exfat_error("'%s' is empty but start cluster is %#x", buffer,
> +				node->start_cluster);
> +		ret =3D false;
> +	}
> +	if (node->size > 0 && CLUSTER_INVALID(*ef->sb, node->start_cluster))
> +	{
> +		exfat_get_name(node, buffer);
> +		exfat_error("'%s' points to invalid cluster %#x", buffer,
> +				node->start_cluster);
> +		ret =3D false;
> +	}
> +
> +	/* File or directory cannot be larger than clusters heap. */
> +	if (node->size > clusters_heap_size)
> +	{
> +		exfat_get_name(node, buffer);
> +		exfat_error("'%s' is larger than clusters heap: %"PRIu64" > %"PRIu64,
> +				buffer, node->size, clusters_heap_size);
> +		ret =3D false;
> +	}
> +
> +	/* Empty file or directory must be marked as non-contiguous. */
> +	if (node->size =3D=3D 0 && node->is_contiguous)
> +	{
> +		exfat_get_name(node, buffer);
> +		exfat_error("'%s' is empty but marked as contiguous (%#hx)", buffer,
> +				node->attrib);
> +		ret =3D false;
> +	}
> +
> +	/* Directory size must be aligned on at cluster boundary. */
> +	if ((node->attrib & EXFAT_ATTRIB_DIR) && node->size % cluster_size !=
=3D 0)
> +	{
> +		exfat_get_name(node, buffer);
> +		exfat_error("'%s' directory size %"PRIu64" is not divisible by %d", b=
uffer,
> +				node->size, cluster_size);
> +		ret =3D false;
> +	}
> +
> +	return ret;
> +}
> +
> +static int parse_file_entries(struct exfat* ef, struct exfat_node* node=
,
> +		const struct exfat_entry* entries, int n)
> +{
> +	const struct exfat_entry_meta1* meta1;
> +	const struct exfat_entry_meta2* meta2;
> +	int mandatory_entries;
> +
> +	if (!check_entries(entries, n))
> +		return -EIO;
> +
> +	meta1 =3D (const struct exfat_entry_meta1*) &entries[0];
> +	if (meta1->continuations < 2)
> +	{
> +		exfat_error("too few continuations (%hhu)", meta1->continuations);
> +		return -EIO;
> +	}
> +	meta2 =3D (const struct exfat_entry_meta2*) &entries[1];
> +	if (meta2->flags & ~(EXFAT_FLAG_ALWAYS1 | EXFAT_FLAG_CONTIGUOUS))
> +	{
> +		exfat_error("unknown flags in meta2 (%#hhx)", meta2->flags);
> +		return -EIO;
> +	}
> +	mandatory_entries =3D 2 + DIV_ROUND_UP(meta2->name_length, EXFAT_ENAME=
_MAX);
> +	if (meta1->continuations < mandatory_entries - 1)
> +	{
> +		exfat_error("too few continuations (%hhu < %d)",
> +				meta1->continuations, mandatory_entries - 1);
> +		return -EIO;
> +	}
> +
> +	init_node_meta1(node, meta1);
> +	init_node_meta2(node, meta2);
> +	init_node_name(node, entries + 2, mandatory_entries - 2);
> +
> +	if (!check_node(ef, node, exfat_calc_checksum(entries, n), meta1))
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static int parse_file_entry(struct exfat* ef, struct exfat_node* parent=
,
> +		struct exfat_node** node, off_t* offset, int n)
> +{
> +	struct exfat_entry entries[n];
> +	int rc;
> +
> +	rc =3D read_entries(ef, parent, entries, n, *offset);
> +	if (rc !=3D 0)
> +		return rc;
> +
> +	/* a new node has zero references */
> +	*node =3D allocate_node();
> +	if (*node =3D=3D NULL)
> +		return -ENOMEM;
> +	(*node)->entry_offset =3D *offset;
> +
> +	rc =3D parse_file_entries(ef, *node, entries, n);
> +	if (rc !=3D 0)
> +	{
> +		free(*node);
> +		return rc;
> +	}
> +
> +	*offset +=3D sizeof(struct exfat_entry[n]);
> +	return 0;
> +}
> +
> +static void decompress_upcase(uint16_t* output, const le16_t* source,
> +		size_t size)
> +{
> +	size_t si;
> +	size_t oi;
> +
> +	for (oi =3D 0; oi < EXFAT_UPCASE_CHARS; oi++)
> +		output[oi] =3D oi;
> +
> +	for (si =3D 0, oi =3D 0; si < size && oi < EXFAT_UPCASE_CHARS; si++)
> +	{
> +		uint16_t ch =3D le16_to_cpu(source[si]);
> +
> +		if (ch =3D=3D 0xffff && si + 1 < size)	/* indicates a run */
> +			oi +=3D le16_to_cpu(source[++si]);
> +		else
> +			output[oi++] =3D ch;
> +	}
> +}
> +
> +/*
> + * Read one entry in a directory at offset position and build a new nod=
e
> + * structure.
> + */
> +static int readdir(struct exfat* ef, struct exfat_node* parent,
> +		struct exfat_node** node, off_t* offset)
> +{
> +	int rc;
> +	struct exfat_entry entry;
> +	const struct exfat_entry_meta1* meta1;
> +	const struct exfat_entry_upcase* upcase;
> +	const struct exfat_entry_bitmap* bitmap;
> +	const struct exfat_entry_label* label;
> +	uint64_t upcase_size =3D 0;
> +	le16_t* upcase_comp =3D NULL;
> +	le16_t label_name[EXFAT_ENAME_MAX];
> +
> +	for (;;)
> +	{
> +		rc =3D read_entries(ef, parent, &entry, 1, *offset);
> +		if (rc !=3D 0)
> +			return rc;
> +
> +		switch (entry.type)
> +		{
> +		case EXFAT_ENTRY_FILE:
> +			meta1 =3D (const struct exfat_entry_meta1*) &entry;
> +			return parse_file_entry(ef, parent, node, offset,
> +					1 + meta1->continuations);
> +
> +		case EXFAT_ENTRY_UPCASE:
> +			if (ef->upcase !=3D NULL)
> +				break;
> +			upcase =3D (const struct exfat_entry_upcase*) &entry;
> +			if (CLUSTER_INVALID(*ef->sb, le32_to_cpu(upcase->start_cluster)))
> +			{
> +				exfat_error("invalid cluster 0x%x in upcase table",
> +						le32_to_cpu(upcase->start_cluster));
> +				return -EIO;
> +			}
> +			upcase_size =3D le64_to_cpu(upcase->size);
> +			if (upcase_size =3D=3D 0 ||
> +				upcase_size > EXFAT_UPCASE_CHARS * sizeof(uint16_t) ||
> +				upcase_size % sizeof(uint16_t) !=3D 0)
> +			{
> +				exfat_error("bad upcase table size (%"PRIu64" bytes)",
> +						upcase_size);
> +				return -EIO;
> +			}
> +			upcase_comp =3D malloc(upcase_size);
> +			if (upcase_comp =3D=3D NULL)
> +			{
> +				exfat_error("failed to allocate upcase table (%"PRIu64" bytes)",
> +						upcase_size);
> +				return -ENOMEM;
> +			}
> +
> +			/* read compressed upcase table */
> +			if (exfat_pread(ef->dev, upcase_comp, upcase_size,
> +					exfat_c2o(ef, le32_to_cpu(upcase->start_cluster))) < 0)
> +			{
> +				free(upcase_comp);
> +				exfat_error("failed to read upper case table "
> +						"(%"PRIu64" bytes starting at cluster %#x)",
> +						upcase_size,
> +						le32_to_cpu(upcase->start_cluster));
> +				return -EIO;
> +			}
> +
> +			/* decompress upcase table */
> +			ef->upcase =3D calloc(EXFAT_UPCASE_CHARS, sizeof(uint16_t));
> +			if (ef->upcase =3D=3D NULL)
> +			{
> +				free(upcase_comp);
> +				exfat_error("failed to allocate decompressed upcase table");
> +				return -ENOMEM;
> +			}
> +			decompress_upcase(ef->upcase, upcase_comp,
> +					upcase_size / sizeof(uint16_t));
> +			free(upcase_comp);
> +			break;
> +
> +		case EXFAT_ENTRY_BITMAP:
> +			bitmap =3D (const struct exfat_entry_bitmap*) &entry;
> +			ef->cmap.start_cluster =3D le32_to_cpu(bitmap->start_cluster);
> +			if (CLUSTER_INVALID(*ef->sb, ef->cmap.start_cluster))
> +			{
> +				exfat_error("invalid cluster 0x%x in clusters bitmap",
> +						ef->cmap.start_cluster);
> +				return -EIO;
> +			}
> +			ef->cmap.size =3D le32_to_cpu(ef->sb->cluster_count);
> +			if (le64_to_cpu(bitmap->size) < DIV_ROUND_UP(ef->cmap.size, 8))
> +			{
> +				exfat_error("invalid clusters bitmap size: %"PRIu64
> +						" (expected at least %u)",
> +						le64_to_cpu(bitmap->size),
> +						DIV_ROUND_UP(ef->cmap.size, 8));
> +				return -EIO;
> +			}
> +			/* FIXME bitmap can be rather big, up to 512 MB */
> +			ef->cmap.chunk_size =3D ef->cmap.size;
> +			ef->cmap.chunk =3D malloc(BMAP_SIZE(ef->cmap.chunk_size));
> +			if (ef->cmap.chunk =3D=3D NULL)
> +			{
> +				exfat_error("failed to allocate clusters bitmap chunk "
> +						"(%"PRIu64" bytes)", le64_to_cpu(bitmap->size));
> +				return -ENOMEM;
> +			}
> +
> +			if (exfat_pread(ef->dev, ef->cmap.chunk,
> +					BMAP_SIZE(ef->cmap.chunk_size),
> +					exfat_c2o(ef, ef->cmap.start_cluster)) < 0)
> +			{
> +				exfat_error("failed to read clusters bitmap "
> +						"(%"PRIu64" bytes starting at cluster %#x)",
> +						le64_to_cpu(bitmap->size), ef->cmap.start_cluster);
> +				return -EIO;
> +			}
> +			break;
> +
> +		case EXFAT_ENTRY_LABEL:
> +			label =3D (const struct exfat_entry_label*) &entry;
> +			if (label->length > EXFAT_ENAME_MAX)
> +			{
> +				exfat_error("too long label (%hhu chars)", label->length);
> +				return -EIO;
> +			}
> +			/* copy to a temporary buffer to avoid unaligned access to a
> +			   packed member */
> +			memcpy(label_name, label->name, sizeof(label_name));
> +			if (exfat_utf16_to_utf8(ef->label, label_name,
> +						sizeof(ef->label), EXFAT_ENAME_MAX) !=3D 0)
> +				return -EIO;
> +			break;
> +
> +		default:
> +			if (!(entry.type & EXFAT_ENTRY_VALID))
> +				break; /* deleted entry, ignore it */
> +
> +			exfat_error("unknown entry type %#hhx", entry.type);
> +			if (!EXFAT_REPAIR(unknown_entry, ef, parent, &entry, *offset))
> +				return -EIO;
> +		}
> +		*offset +=3D sizeof(entry);
> +	}
> +	/* we never reach here */
> +}
> +
> +int exfat_cache_directory(struct exfat* ef, struct exfat_node* dir)
> +{
> +	off_t offset =3D 0;
> +	int rc;
> +	struct exfat_node* node;
> +	struct exfat_node* current =3D NULL;
> +
> +	if (dir->is_cached)
> +		return 0; /* already cached */
> +
> +	while ((rc =3D readdir(ef, dir, &node, &offset)) =3D=3D 0)
> +	{
> +		node->parent =3D dir;
> +		if (current !=3D NULL)
> +		{
> +			current->next =3D node;
> +			node->prev =3D current;
> +		}
> +		else
> +			dir->child =3D node;
> +
> +		current =3D node;
> +	}
> +
> +	if (rc !=3D -ENOENT)
> +	{
> +		/* rollback */
> +		for (current =3D dir->child; current; current =3D node)
> +		{
> +			node =3D current->next;
> +			free(current);
> +		}
> +		dir->child =3D NULL;
> +		return rc;
> +	}
> +
> +	dir->is_cached =3D true;
> +	return 0;
> +}
> +
> +static void tree_attach(struct exfat_node* dir, struct exfat_node* node=
)
> +{
> +	node->parent =3D dir;
> +	if (dir->child)
> +	{
> +		dir->child->prev =3D node;
> +		node->next =3D dir->child;
> +	}
> +	dir->child =3D node;
> +}
> +
> +static void tree_detach(struct exfat_node* node)
> +{
> +	if (node->prev)
> +		node->prev->next =3D node->next;
> +	else /* this is the first node in the list */
> +		node->parent->child =3D node->next;
> +	if (node->next)
> +		node->next->prev =3D node->prev;
> +	node->parent =3D NULL;
> +	node->prev =3D NULL;
> +	node->next =3D NULL;
> +}
> +
> +static void reset_cache(struct exfat* ef, struct exfat_node* node)
> +{
> +	char buffer[EXFAT_UTF8_NAME_BUFFER_MAX];
> +
> +	while (node->child)
> +	{
> +		struct exfat_node* p =3D node->child;
> +		reset_cache(ef, p);
> +		tree_detach(p);
> +		free(p);
> +	}
> +	node->is_cached =3D false;
> +	if (node->references !=3D 0)
> +	{
> +		exfat_get_name(node, buffer);
> +		exfat_warn("non-zero reference counter (%d) for '%s'",
> +				node->references, buffer);
> +	}
> +	if (node !=3D ef->root && node->is_dirty)
> +	{
> +		exfat_get_name(node, buffer);
> +		exfat_bug("node '%s' is dirty", buffer);
> +	}
> +	while (node->references)
> +		exfat_put_node(ef, node);
> +}
> +
> +void exfat_reset_cache(struct exfat* ef)
> +{
> +	reset_cache(ef, ef->root);
> +}
> +
> +int exfat_flush_node(struct exfat* ef, struct exfat_node* node)
> +{
> +	struct exfat_entry entries[1 + node->continuations];
> +	struct exfat_entry_meta1* meta1 =3D (struct exfat_entry_meta1*) &entri=
es[0];
> +	struct exfat_entry_meta2* meta2 =3D (struct exfat_entry_meta2*) &entri=
es[1];
> +	int rc;
> +	le16_t edate, etime;
> +
> +	if (!node->is_dirty)
> +		return 0; /* no need to flush */
> +
> +	if (ef->ro)
> +		exfat_bug("unable to flush node to read-only FS");
> +
> +	if (node->parent =3D=3D NULL)
> +		return 0; /* do not flush unlinked node */
> +
> +	rc =3D read_entries(ef, node->parent, entries, 1 + node->continuations=
,
> +			node->entry_offset);
> +	if (rc !=3D 0)
> +		return rc;
> +	if (!check_entries(entries, 1 + node->continuations))
> +		return -EIO;
> +
> +	meta1->attrib =3D cpu_to_le16(node->attrib);
> +	exfat_unix2exfat(node->mtime, &edate, &etime,
> +			&meta1->mtime_cs, &meta1->mtime_tzo);
> +	meta1->mdate =3D edate;
> +	meta1->mtime =3D etime;
> +	exfat_unix2exfat(node->atime, &edate, &etime,
> +			NULL, &meta1->atime_tzo);
> +	meta1->adate =3D edate;
> +	meta1->atime =3D etime;
> +	meta2->valid_size =3D cpu_to_le64(node->valid_size);
> +	meta2->size =3D cpu_to_le64(node->size);
> +	meta2->start_cluster =3D cpu_to_le32(node->start_cluster);
> +	meta2->flags =3D EXFAT_FLAG_ALWAYS1;
> +	/* empty files must not be marked as contiguous */
> +	if (node->size !=3D 0 && node->is_contiguous)
> +		meta2->flags |=3D EXFAT_FLAG_CONTIGUOUS;
> +	/* name hash remains unchanged, no need to recalculate it */
> +
> +	meta1->checksum =3D exfat_calc_checksum(entries, 1 + node->continuatio=
ns);
> +	rc =3D write_entries(ef, node->parent, entries, 1 + node->continuation=
s,
> +			node->entry_offset);
> +	if (rc !=3D 0)
> +		return rc;
> +
> +	node->is_dirty =3D false;
> +	return exfat_flush(ef);
> +}
> +
> +static int erase_entries(struct exfat* ef, struct exfat_node* dir, int =
n,
> +		off_t offset)
> +{
> +	struct exfat_entry entries[n];
> +	int rc;
> +	int i;
> +
> +	rc =3D read_entries(ef, dir, entries, n, offset);
> +	if (rc !=3D 0)
> +		return rc;
> +	for (i =3D 0; i < n; i++)
> +		entries[i].type &=3D ~EXFAT_ENTRY_VALID;
> +	return write_entries(ef, dir, entries, n, offset);
> +}
> +
> +static int erase_node(struct exfat* ef, struct exfat_node* node)
> +{
> +	int rc;
> +
> +	exfat_get_node(node->parent);
> +	rc =3D erase_entries(ef, node->parent, 1 + node->continuations,
> +			node->entry_offset);
> +	if (rc !=3D 0)
> +	{
> +		exfat_put_node(ef, node->parent);
> +		return rc;
> +	}
> +	rc =3D exfat_flush_node(ef, node->parent);
> +	exfat_put_node(ef, node->parent);
> +	return rc;
> +}
> +
> +static int shrink_directory(struct exfat* ef, struct exfat_node* dir,
> +		off_t deleted_offset)
> +{
> +	const struct exfat_node* node;
> +	const struct exfat_node* last_node;
> +	uint64_t entries =3D 0;
> +	uint64_t new_size;
> +
> +	if (!(dir->attrib & EXFAT_ATTRIB_DIR))
> +		exfat_bug("attempted to shrink a file");
> +	if (!dir->is_cached)
> +		exfat_bug("attempted to shrink uncached directory");
> +
> +	for (last_node =3D node =3D dir->child; node; node =3D node->next)
> +	{
> +		if (deleted_offset < node->entry_offset)
> +		{
> +			/* there are other entries after the removed one, no way to shrink
> +			   this directory */
> +			return 0;
> +		}
> +		if (last_node->entry_offset < node->entry_offset)
> +			last_node =3D node;
> +	}
> +
> +	if (last_node)
> +	{
> +		/* offset of the last entry */
> +		entries +=3D last_node->entry_offset / sizeof(struct exfat_entry);
> +		/* two subentries with meta info */
> +		entries +=3D 2;
> +		/* subentries with file name */
> +		entries +=3D DIV_ROUND_UP(exfat_utf16_length(last_node->name),
> +				EXFAT_ENAME_MAX);
> +	}
> +
> +	new_size =3D DIV_ROUND_UP(entries * sizeof(struct exfat_entry),
> +				 CLUSTER_SIZE(*ef->sb)) * CLUSTER_SIZE(*ef->sb);
> +	if (new_size =3D=3D 0) /* directory always has at least 1 cluster */
> +		new_size =3D CLUSTER_SIZE(*ef->sb);
> +	if (new_size =3D=3D dir->size)
> +		return 0;
> +	return exfat_truncate(ef, dir, new_size, true);
> +}
> +
> +static int delete(struct exfat* ef, struct exfat_node* node)
> +{
> +	struct exfat_node* parent =3D node->parent;
> +	off_t deleted_offset =3D node->entry_offset;
> +	int rc;
> +
> +	exfat_get_node(parent);
> +	rc =3D erase_node(ef, node);
> +	if (rc !=3D 0)
> +	{
> +		exfat_put_node(ef, parent);
> +		return rc;
> +	}
> +	tree_detach(node);
> +	rc =3D shrink_directory(ef, parent, deleted_offset);
> +	node->is_unlinked =3D true;
> +	if (rc !=3D 0)
> +	{
> +		exfat_flush_node(ef, parent);
> +		exfat_put_node(ef, parent);
> +		return rc;
> +	}
> +	exfat_update_mtime(parent);
> +	rc =3D exfat_flush_node(ef, parent);
> +	exfat_put_node(ef, parent);
> +	return rc;
> +}
> +
> +int exfat_unlink(struct exfat* ef, struct exfat_node* node)
> +{
> +	if (node->attrib & EXFAT_ATTRIB_DIR)
> +		return -EISDIR;
> +	return delete(ef, node);
> +}
> +
> +int exfat_rmdir(struct exfat* ef, struct exfat_node* node)
> +{
> +	int rc;
> +
> +	if (!(node->attrib & EXFAT_ATTRIB_DIR))
> +		return -ENOTDIR;
> +	/* check that directory is empty */
> +	rc =3D exfat_cache_directory(ef, node);
> +	if (rc !=3D 0)
> +		return rc;
> +	if (node->child)
> +		return -ENOTEMPTY;
> +	return delete(ef, node);
> +}
> +
> +static int check_slot(struct exfat* ef, struct exfat_node* dir, off_t o=
ffset,
> +		int n)
> +{
> +	struct exfat_entry entries[n];
> +	int rc;
> +	int i;
> +
> +	/* Root directory contains entries, that don't have any nodes associat=
ed
> +	   with them (clusters bitmap, upper case table, label). We need to be
> +	   careful not to overwrite them. */
> +	if (dir !=3D ef->root)
> +		return 0;
> +
> +	rc =3D read_entries(ef, dir, entries, n, offset);
> +	if (rc !=3D 0)
> +		return rc;
> +	for (i =3D 0; i < n; i++)
> +		if (entries[i].type & EXFAT_ENTRY_VALID)
> +			return -EINVAL;
> +	return 0;
> +}
> +
> +static int find_slot(struct exfat* ef, struct exfat_node* dir,
> +		off_t* offset, int n)
> +{
> +	bitmap_t* dmap;
> +	struct exfat_node* p;
> +	size_t i;
> +	int contiguous =3D 0;
> +
> +	if (!dir->is_cached)
> +		exfat_bug("directory is not cached");
> +
> +	/* build a bitmap of valid entries in the directory */
> +	dmap =3D calloc(BMAP_SIZE(dir->size / sizeof(struct exfat_entry)),
> +			sizeof(bitmap_t));
> +	if (dmap =3D=3D NULL)
> +	{
> +		exfat_error("failed to allocate directory bitmap (%"PRIu64")",
> +				dir->size / sizeof(struct exfat_entry));
> +		return -ENOMEM;
> +	}
> +	for (p =3D dir->child; p !=3D NULL; p =3D p->next)
> +		for (i =3D 0; i < 1u + p->continuations; i++)
> +			BMAP_SET(dmap, p->entry_offset / sizeof(struct exfat_entry) + i);
> +
> +	/* find a slot in the directory entries bitmap */
> +	for (i =3D 0; i < dir->size / sizeof(struct exfat_entry); i++)
> +	{
> +		if (BMAP_GET(dmap, i) =3D=3D 0)
> +		{
> +			if (contiguous++ =3D=3D 0)
> +				*offset =3D (off_t) i * sizeof(struct exfat_entry);
> +			if (contiguous =3D=3D n)
> +			{
> +				int rc;
> +
> +				/* suitable slot is found, check that it's not occupied */
> +				rc =3D check_slot(ef, dir, *offset, n);
> +				if (rc =3D=3D -EINVAL)
> +				{
> +					/* slot at (i-n) is occupied, go back and check (i-n+1) */
> +					i -=3D contiguous - 1;
> +					contiguous =3D 0;
> +				}
> +				else
> +				{
> +					/* slot is free or an error occurred */
> +					free(dmap);
> +					return rc;
> +				}
> +			}
> +		}
> +		else
> +			contiguous =3D 0;
> +	}
> +	free(dmap);
> +
> +	/* no suitable slots found, extend the directory */
> +	if (contiguous =3D=3D 0)
> +		*offset =3D dir->size;
> +	return exfat_truncate(ef, dir,
> +			ROUND_UP(dir->size + sizeof(struct exfat_entry[n - contiguous]),
> +					CLUSTER_SIZE(*ef->sb)),
> +			true);
> +}
> +
> +static int commit_entry(struct exfat* ef, struct exfat_node* dir,
> +		const le16_t* name, off_t offset, uint16_t attrib)
> +{
> +	struct exfat_node* node;
> +	const size_t name_length =3D exfat_utf16_length(name);
> +	const int name_entries =3D DIV_ROUND_UP(name_length, EXFAT_ENAME_MAX);
> +	struct exfat_entry entries[2 + name_entries];
> +	struct exfat_entry_meta1* meta1 =3D (struct exfat_entry_meta1*) &entri=
es[0];
> +	struct exfat_entry_meta2* meta2 =3D (struct exfat_entry_meta2*) &entri=
es[1];
> +	int i;
> +	int rc;
> +	le16_t edate, etime;
> +
> +	memset(entries, 0, sizeof(struct exfat_entry[2]));
> +
> +	meta1->type =3D EXFAT_ENTRY_FILE;
> +	meta1->continuations =3D 1 + name_entries;
> +	meta1->attrib =3D cpu_to_le16(attrib);
> +	exfat_unix2exfat(time(NULL), &edate, &etime,
> +			&meta1->crtime_cs, &meta1->crtime_tzo);
> +	meta1->adate =3D meta1->mdate =3D meta1->crdate =3D edate;
> +	meta1->atime =3D meta1->mtime =3D meta1->crtime =3D etime;
> +	meta1->mtime_cs =3D meta1->crtime_cs; /* there is no atime_cs */
> +	meta1->atime_tzo =3D meta1->mtime_tzo =3D meta1->crtime_tzo;
> +
> +	meta2->type =3D EXFAT_ENTRY_FILE_INFO;
> +	meta2->flags =3D EXFAT_FLAG_ALWAYS1;
> +	meta2->name_length =3D name_length;
> +	meta2->name_hash =3D exfat_calc_name_hash(ef, name, name_length);
> +	meta2->start_cluster =3D cpu_to_le32(EXFAT_CLUSTER_FREE);
> +
> +	for (i =3D 0; i < name_entries; i++)
> +	{
> +		struct exfat_entry_name* name_entry;
> +
> +		name_entry =3D (struct exfat_entry_name*) &entries[2 + i];
> +		name_entry->type =3D EXFAT_ENTRY_FILE_NAME;
> +		name_entry->__unknown =3D 0;
> +		memcpy(name_entry->name, name + i * EXFAT_ENAME_MAX,
> +				EXFAT_ENAME_MAX * sizeof(le16_t));
> +	}
> +
> +	meta1->checksum =3D exfat_calc_checksum(entries, 2 + name_entries);
> +	rc =3D write_entries(ef, dir, entries, 2 + name_entries, offset);
> +	if (rc !=3D 0)
> +		return rc;
> +
> +	node =3D allocate_node();
> +	if (node =3D=3D NULL)
> +		return -ENOMEM;
> +	node->entry_offset =3D offset;
> +	memcpy(node->name, name, name_length * sizeof(le16_t));
> +	init_node_meta1(node, meta1);
> +	init_node_meta2(node, meta2);
> +
> +	tree_attach(dir, node);
> +	return 0;
> +}
> +
> +static int create(struct exfat* ef, const char* path, uint16_t attrib)
> +{
> +	struct exfat_node* dir;
> +	struct exfat_node* existing;
> +	off_t offset =3D -1;
> +	le16_t name[EXFAT_NAME_MAX + 1];
> +	int rc;
> +
> +	rc =3D exfat_split(ef, &dir, &existing, name, path);
> +	if (rc !=3D 0)
> +		return rc;
> +	if (existing !=3D NULL)
> +	{
> +		exfat_put_node(ef, existing);
> +		exfat_put_node(ef, dir);
> +		return -EEXIST;
> +	}
> +
> +	rc =3D find_slot(ef, dir, &offset,
> +			2 + DIV_ROUND_UP(exfat_utf16_length(name), EXFAT_ENAME_MAX));
> +	if (rc !=3D 0)
> +	{
> +		exfat_put_node(ef, dir);
> +		return rc;
> +	}
> +	rc =3D commit_entry(ef, dir, name, offset, attrib);
> +	if (rc !=3D 0)
> +	{
> +		exfat_put_node(ef, dir);
> +		return rc;
> +	}
> +	exfat_update_mtime(dir);
> +	rc =3D exfat_flush_node(ef, dir);
> +	exfat_put_node(ef, dir);
> +	return rc;
> +}
> +
> +int exfat_mknod(struct exfat* ef, const char* path)
> +{
> +	return create(ef, path, EXFAT_ATTRIB_ARCH);
> +}
> +
> +int exfat_mkdir(struct exfat* ef, const char* path)
> +{
> +	int rc;
> +	struct exfat_node* node;
> +
> +	rc =3D create(ef, path, EXFAT_ATTRIB_DIR);
> +	if (rc !=3D 0)
> +		return rc;
> +	rc =3D exfat_lookup(ef, &node, path);
> +	if (rc !=3D 0)
> +		return 0;
> +	/* directories always have at least one cluster */
> +	rc =3D exfat_truncate(ef, node, CLUSTER_SIZE(*ef->sb), true);
> +	if (rc !=3D 0)
> +	{
> +		delete(ef, node);
> +		exfat_put_node(ef, node);
> +		return rc;
> +	}
> +	rc =3D exfat_flush_node(ef, node);
> +	if (rc !=3D 0)
> +	{
> +		delete(ef, node);
> +		exfat_put_node(ef, node);
> +		return rc;
> +	}
> +	exfat_put_node(ef, node);
> +	return 0;
> +}
> +
> +static int rename_entry(struct exfat* ef, struct exfat_node* dir,
> +		struct exfat_node* node, const le16_t* name, off_t new_offset)
> +{
> +	const size_t name_length =3D exfat_utf16_length(name);
> +	const int name_entries =3D DIV_ROUND_UP(name_length, EXFAT_ENAME_MAX);
> +	struct exfat_entry entries[2 + name_entries];
> +	struct exfat_entry_meta1* meta1 =3D (struct exfat_entry_meta1*) &entri=
es[0];
> +	struct exfat_entry_meta2* meta2 =3D (struct exfat_entry_meta2*) &entri=
es[1];
> +	int rc;
> +	int i;
> +
> +	rc =3D read_entries(ef, node->parent, entries, 2, node->entry_offset);
> +	if (rc !=3D 0)
> +		return rc;
> +
> +	meta1->continuations =3D 1 + name_entries;
> +	meta2->name_length =3D name_length;
> +	meta2->name_hash =3D exfat_calc_name_hash(ef, name, name_length);
> +
> +	rc =3D erase_node(ef, node);
> +	if (rc !=3D 0)
> +		return rc;
> +
> +	node->entry_offset =3D new_offset;
> +	node->continuations =3D 1 + name_entries;
> +
> +	for (i =3D 0; i < name_entries; i++)
> +	{
> +		struct exfat_entry_name* name_entry;
> +
> +		name_entry =3D (struct exfat_entry_name*) &entries[2 + i];
> +		name_entry->type =3D EXFAT_ENTRY_FILE_NAME;
> +		name_entry->__unknown =3D 0;
> +		memcpy(name_entry->name, name + i * EXFAT_ENAME_MAX,
> +				EXFAT_ENAME_MAX * sizeof(le16_t));
> +	}
> +
> +	meta1->checksum =3D exfat_calc_checksum(entries, 2 + name_entries);
> +	rc =3D write_entries(ef, dir, entries, 2 + name_entries, new_offset);
> +	if (rc !=3D 0)
> +		return rc;
> +
> +	memcpy(node->name, name, (EXFAT_NAME_MAX + 1) * sizeof(le16_t));
> +	tree_detach(node);
> +	tree_attach(dir, node);
> +	return 0;
> +}
> +
> +int exfat_rename(struct exfat* ef, const char* old_path, const char* ne=
w_path)
> +{
> +	struct exfat_node* node;
> +	struct exfat_node* existing;
> +	struct exfat_node* dir;
> +	off_t offset =3D -1;
> +	le16_t name[EXFAT_NAME_MAX + 1];
> +	int rc;
> +
> +	rc =3D exfat_lookup(ef, &node, old_path);
> +	if (rc !=3D 0)
> +		return rc;
> +
> +	rc =3D exfat_split(ef, &dir, &existing, name, new_path);
> +	if (rc !=3D 0)
> +	{
> +		exfat_put_node(ef, node);
> +		return rc;
> +	}
> +
> +	/* check that target is not a subdirectory of the source */
> +	if (node->attrib & EXFAT_ATTRIB_DIR)
> +	{
> +		struct exfat_node* p;
> +
> +		for (p =3D dir; p; p =3D p->parent)
> +			if (node =3D=3D p)
> +			{
> +				if (existing !=3D NULL)
> +					exfat_put_node(ef, existing);
> +				exfat_put_node(ef, dir);
> +				exfat_put_node(ef, node);
> +				return -EINVAL;
> +			}
> +	}
> +
> +	if (existing !=3D NULL)
> +	{
> +		/* remove target if it's not the same node as source */
> +		if (existing !=3D node)
> +		{
> +			if (existing->attrib & EXFAT_ATTRIB_DIR)
> +			{
> +				if (node->attrib & EXFAT_ATTRIB_DIR)
> +					rc =3D exfat_rmdir(ef, existing);
> +				else
> +					rc =3D -ENOTDIR;
> +			}
> +			else
> +			{
> +				if (!(node->attrib & EXFAT_ATTRIB_DIR))
> +					rc =3D exfat_unlink(ef, existing);
> +				else
> +					rc =3D -EISDIR;
> +			}
> +			exfat_put_node(ef, existing);
> +			if (rc !=3D 0)
> +			{
> +				/* free clusters even if something went wrong; otherwise they
> +				   will be just lost */
> +				exfat_cleanup_node(ef, existing);
> +				exfat_put_node(ef, dir);
> +				exfat_put_node(ef, node);
> +				return rc;
> +			}
> +			rc =3D exfat_cleanup_node(ef, existing);
> +			if (rc !=3D 0)
> +			{
> +				exfat_put_node(ef, dir);
> +				exfat_put_node(ef, node);
> +				return rc;
> +			}
> +		}
> +		else
> +			exfat_put_node(ef, existing);
> +	}
> +
> +	rc =3D find_slot(ef, dir, &offset,
> +			2 + DIV_ROUND_UP(exfat_utf16_length(name), EXFAT_ENAME_MAX));
> +	if (rc !=3D 0)
> +	{
> +		exfat_put_node(ef, dir);
> +		exfat_put_node(ef, node);
> +		return rc;
> +	}
> +	rc =3D rename_entry(ef, dir, node, name, offset);
> +	if (rc !=3D 0)
> +	{
> +		exfat_put_node(ef, dir);
> +		exfat_put_node(ef, node);
> +		return rc;
> +	}
> +	rc =3D exfat_flush_node(ef, dir);
> +	exfat_put_node(ef, dir);
> +	exfat_put_node(ef, node);
> +	/* node itself is not marked as dirty, no need to flush it */
> +	return rc;
> +}
> +
> +void exfat_utimes(struct exfat_node* node, const struct timespec tv[2])
> +{
> +	node->atime =3D tv[0].tv_sec;
> +	node->mtime =3D tv[1].tv_sec;
> +	node->is_dirty =3D true;
> +}
> +
> +void exfat_update_atime(struct exfat_node* node)
> +{
> +	node->atime =3D time(NULL);
> +	node->is_dirty =3D true;
> +}
> +
> +void exfat_update_mtime(struct exfat_node* node)
> +{
> +	node->mtime =3D time(NULL);
> +	node->is_dirty =3D true;
> +}
> +
> +const char* exfat_get_label(struct exfat* ef)
> +{
> +	return ef->label;
> +}
> +
> +static int find_label(struct exfat* ef, off_t* offset)
> +{
> +	struct exfat_entry entry;
> +	int rc;
> +
> +	for (*offset =3D 0; ; *offset +=3D sizeof(entry))
> +	{
> +		rc =3D read_entries(ef, ef->root, &entry, 1, *offset);
> +		if (rc !=3D 0)
> +			return rc;
> +
> +		if (entry.type =3D=3D EXFAT_ENTRY_LABEL)
> +			return 0;
> +	}
> +}
> +
> +int exfat_set_label(struct exfat* ef, const char* label)
> +{
> +	le16_t label_utf16[EXFAT_ENAME_MAX + 1];
> +	int rc;
> +	off_t offset;
> +	struct exfat_entry_label entry;
> +
> +	memset(label_utf16, 0, sizeof(label_utf16));
> +	rc =3D exfat_utf8_to_utf16(label_utf16, label, EXFAT_ENAME_MAX + 1,
> +			strlen(label));
> +	if (rc !=3D 0)
> +		return rc;
> +
> +	rc =3D find_label(ef, &offset);
> +	if (rc =3D=3D -ENOENT)
> +		rc =3D find_slot(ef, ef->root, &offset, 1);
> +	if (rc !=3D 0)
> +		return rc;
> +
> +	entry.type =3D EXFAT_ENTRY_LABEL;
> +	entry.length =3D exfat_utf16_length(label_utf16);
> +	memcpy(entry.name, label_utf16, sizeof(entry.name));
> +	if (entry.length =3D=3D 0)
> +		entry.type ^=3D EXFAT_ENTRY_VALID;
> +
> +	rc =3D write_entries(ef, ef->root, (struct exfat_entry*) &entry, 1, of=
fset);
> +	if (rc !=3D 0)
> +		return rc;
> +
> +	strcpy(ef->label, label);
> +	return 0;
> +}
> diff --git a/fs/exfat/platform.h b/fs/exfat/platform.h
> new file mode 100644
> index 00000000000..9bd125a100a
> --- /dev/null
> +++ b/fs/exfat/platform.h
> @@ -0,0 +1,73 @@
> +/*
> +	platform.h (14.05.13)
> +	OS-specific code (libc-specific in fact). Note that systems with the
> +	same kernel can use different libc implementations.
> +
> +	Free exFAT implementation.
> +	Copyright (C) 2010-2023  Andrew Nayenko
> +
> +	This program is free software; you can redistribute it and/or modify
> +	it under the terms of the GNU General Public License as published by
> +	the Free Software Foundation, either version 2 of the License, or
> +	(at your option) any later version.
> +
> +	This program is distributed in the hope that it will be useful,
> +	but WITHOUT ANY WARRANTY; without even the implied warranty of
> +	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +	GNU General Public License for more details.
> +
> +	You should have received a copy of the GNU General Public License alon=
g
> +	with this program; if not, write to the Free Software Foundation, Inc.=
,
> +	51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +*/
> +
> +#ifndef PLATFORM_H_INCLUDED
> +#define PLATFORM_H_INCLUDED
> +
> +#if defined(__linux__) || defined(__GLIBC__) || defined(__GNU__)
> +
> +#include <endian.h>
> +#include <byteswap.h>
> +#define exfat_bswap16(x) bswap_16(x)
> +#define exfat_bswap32(x) bswap_32(x)
> +#define exfat_bswap64(x) bswap_64(x)
> +#define EXFAT_BYTE_ORDER __BYTE_ORDER
> +#define EXFAT_LITTLE_ENDIAN __LITTLE_ENDIAN
> +#define EXFAT_BIG_ENDIAN __BIG_ENDIAN
> +
> +#elif defined(__APPLE__)
> +
> +#include <machine/endian.h>
> +#include <libkern/OSByteOrder.h>
> +#define exfat_bswap16(x) OSSwapInt16(x)
> +#define exfat_bswap32(x) OSSwapInt32(x)
> +#define exfat_bswap64(x) OSSwapInt64(x)
> +#define EXFAT_BYTE_ORDER BYTE_ORDER
> +#define EXFAT_LITTLE_ENDIAN LITTLE_ENDIAN
> +#define EXFAT_BIG_ENDIAN BIG_ENDIAN
> +
> +#elif defined(__FreeBSD__) || defined(__DragonFly__) || defined(__NetBS=
D__) || defined(__OpenBSD__)
> +
> +#include <sys/endian.h>
> +#define exfat_bswap16(x) bswap16(x)
> +#define exfat_bswap32(x) bswap32(x)
> +#define exfat_bswap64(x) bswap64(x)
> +#define EXFAT_BYTE_ORDER _BYTE_ORDER
> +#define EXFAT_LITTLE_ENDIAN _LITTLE_ENDIAN
> +#define EXFAT_BIG_ENDIAN _BIG_ENDIAN
> +
> +#elif defined(__sun)
> +
> +#include <endian.h>
> +#define exfat_bswap16(x) bswap_16(x)
> +#define exfat_bswap32(x) bswap_32(x)
> +#define exfat_bswap64(x) bswap_64(x)
> +#define EXFAT_BYTE_ORDER __BYTE_ORDER
> +#define EXFAT_LITTLE_ENDIAN __LITTLE_ENDIAN
> +#define EXFAT_BIG_ENDIAN __BIG_ENDIAN
> +
> +#else
> +#error Unknown platform
> +#endif
> +
> +#endif /* ifndef PLATFORM_H_INCLUDED */
> diff --git a/fs/exfat/repair.c b/fs/exfat/repair.c
> new file mode 100644
> index 00000000000..615b8d11f3c
> --- /dev/null
> +++ b/fs/exfat/repair.c
> @@ -0,0 +1,102 @@
> +/*
> +	repair.c (09.03.17)
> +	exFAT file system implementation library.
> +
> +	Free exFAT implementation.
> +	Copyright (C) 2010-2023  Andrew Nayenko
> +
> +	This program is free software; you can redistribute it and/or modify
> +	it under the terms of the GNU General Public License as published by
> +	the Free Software Foundation, either version 2 of the License, or
> +	(at your option) any later version.
> +
> +	This program is distributed in the hope that it will be useful,
> +	but WITHOUT ANY WARRANTY; without even the implied warranty of
> +	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +	GNU General Public License for more details.
> +
> +	You should have received a copy of the GNU General Public License alon=
g
> +	with this program; if not, write to the Free Software Foundation, Inc.=
,
> +	51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +*/
> +
> +#include "exfat.h"
> +#include <strings.h>
> +
> +int exfat_errors_fixed;
> +
> +bool exfat_ask_to_fix(const struct exfat* ef)
> +{
> +	const char* question =3D "Fix (Y/N)?";
> +	char answer[8];
> +	bool yeah, nope;
> +
> +	switch (ef->repair)
> +	{
> +	case EXFAT_REPAIR_NO:
> +		return false;
> +	case EXFAT_REPAIR_YES:
> +		printf("%s %s", question, "Y\n");
> +		return true;
> +	case EXFAT_REPAIR_ASK:
> +		do
> +		{
> +			printf("%s ", question);
> +			fflush(stdout);
> +			if (fgets(answer, sizeof(answer), stdin))
> +			{
> +				yeah =3D strcasecmp(answer, "Y\n") =3D=3D 0;
> +				nope =3D strcasecmp(answer, "N\n") =3D=3D 0;
> +			}
> +			else
> +			{
> +				yeah =3D false;
> +				nope =3D true;
> +			}
> +		}
> +		while (!yeah && !nope);
> +		return yeah;
> +	}
> +	exfat_bug("invalid repair option value: %d", ef->repair);
> +}
> +
> +bool exfat_fix_invalid_vbr_checksum(const struct exfat* ef, void* secto=
r,
> +		uint32_t vbr_checksum)
> +{
> +	size_t i;
> +	off_t sector_size =3D SECTOR_SIZE(*ef->sb);
> +
> +	for (i =3D 0; i < sector_size / sizeof(vbr_checksum); i++)
> +		((le32_t*) sector)[i] =3D cpu_to_le32(vbr_checksum);
> +	if (exfat_pwrite(ef->dev, sector, sector_size, 11 * sector_size) < 0)
> +	{
> +		exfat_error("failed to write correct VBR checksum");
> +		return false;
> +	}
> +	exfat_errors_fixed++;
> +	return true;
> +}
> +
> +bool exfat_fix_invalid_node_checksum(UNUSED const struct exfat* ef,
> +		struct exfat_node* node)
> +{
> +	/* checksum will be rewritten by exfat_flush_node() */
> +	node->is_dirty =3D true;
> +
> +	exfat_errors_fixed++;
> +	return true;
> +}
> +
> +bool exfat_fix_unknown_entry(struct exfat* ef, struct exfat_node* dir,
> +		const struct exfat_entry* entry, off_t offset)
> +{
> +	struct exfat_entry deleted =3D *entry;
> +
> +	deleted.type &=3D ~EXFAT_ENTRY_VALID;
> +	if (exfat_generic_pwrite(ef, dir, &deleted, sizeof(struct exfat_entry)=
,
> +			offset) !=3D sizeof(struct exfat_entry))
> +		return false;
> +
> +	exfat_errors_fixed++;
> +	return true;
> +}
> diff --git a/fs/exfat/time.c b/fs/exfat/time.c
> new file mode 100644
> index 00000000000..3ab2a1561b8
> --- /dev/null
> +++ b/fs/exfat/time.c
> @@ -0,0 +1,173 @@
> +/*
> +	time.c (03.02.12)
> +	exFAT file system implementation library.
> +
> +	Free exFAT implementation.
> +	Copyright (C) 2010-2023  Andrew Nayenko
> +
> +	This program is free software; you can redistribute it and/or modify
> +	it under the terms of the GNU General Public License as published by
> +	the Free Software Foundation, either version 2 of the License, or
> +	(at your option) any later version.
> +
> +	This program is distributed in the hope that it will be useful,
> +	but WITHOUT ANY WARRANTY; without even the implied warranty of
> +	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +	GNU General Public License for more details.
> +
> +	You should have received a copy of the GNU General Public License alon=
g
> +	with this program; if not, write to the Free Software Foundation, Inc.=
,
> +	51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +*/
> +
> +#include "exfat.h"
> +
> +/* timezone offset from UTC in seconds; positive for western timezones,
> +   negative for eastern ones */
> +static long exfat_timezone;
> +
> +#define SEC_IN_MIN 60ll
> +#define SEC_IN_HOUR (60 * SEC_IN_MIN)
> +#define SEC_IN_DAY (24 * SEC_IN_HOUR)
> +#define SEC_IN_YEAR (365 * SEC_IN_DAY) /* not leap year */
> +/* Unix epoch started at 0:00:00 UTC 1 January 1970 */
> +#define UNIX_EPOCH_YEAR 1970
> +/* exFAT epoch started at 0:00:00 UTC 1 January 1980 */
> +#define EXFAT_EPOCH_YEAR 1980
> +/* number of years from Unix epoch to exFAT epoch */
> +#define EPOCH_DIFF_YEAR (EXFAT_EPOCH_YEAR - UNIX_EPOCH_YEAR)
> +/* number of days from Unix epoch to exFAT epoch (considering leap days=
) */
> +#define EPOCH_DIFF_DAYS (EPOCH_DIFF_YEAR * 365 + EPOCH_DIFF_YEAR / 4)
> +/* number of seconds from Unix epoch to exFAT epoch (considering leap d=
ays) */
> +#define EPOCH_DIFF_SEC (EPOCH_DIFF_DAYS * SEC_IN_DAY)
> +/* number of leap years passed from exFAT epoch to the specified year
> +   (excluding the specified year itself) */
> +#define LEAP_YEARS(year) ((EXFAT_EPOCH_YEAR + (year) - 1) / 4 \
> +		- (EXFAT_EPOCH_YEAR - 1) / 4)
> +/* checks whether the specified year is leap */
> +#define IS_LEAP_YEAR(year) ((EXFAT_EPOCH_YEAR + (year)) % 4 =3D=3D 0)
> +
> +static const time_t days_in_year[] =3D
> +{
> +	/* Jan  Feb  Mar  Apr  May  Jun  Jul  Aug  Sep  Oct  Nov  Dec */
> +	0,   0,  31,  59,  90, 120, 151, 181, 212, 243, 273, 304, 334
> +};
> +
> +time_t exfat_exfat2unix(le16_t date, le16_t time, uint8_t centisec,
> +		uint8_t tzoffset)
> +{
> +	time_t unix_time =3D EPOCH_DIFF_SEC;
> +	uint16_t ndate =3D le16_to_cpu(date);
> +	uint16_t ntime =3D le16_to_cpu(time);
> +
> +	uint16_t day    =3D ndate & 0x1f;      /* 5 bits, 1-31 */
> +	uint16_t month  =3D ndate >> 5 & 0xf;  /* 4 bits, 1-12 */
> +	uint16_t year   =3D ndate >> 9;        /* 7 bits, 1-127 (+1980) */
> +
> +	uint16_t twosec =3D ntime & 0x1f;      /* 5 bits, 0-29 (2 sec granular=
ity) */
> +	uint16_t min    =3D ntime >> 5 & 0x3f; /* 6 bits, 0-59 */
> +	uint16_t hour   =3D ntime >> 11;       /* 5 bits, 0-23 */
> +
> +	if (day =3D=3D 0 || month =3D=3D 0 || month > 12)
> +	{
> +		exfat_error("bad date %u-%02hu-%02hu",
> +				year + EXFAT_EPOCH_YEAR, month, day);
> +		return 0;
> +	}
> +	if (hour > 23 || min > 59 || twosec > 29)
> +	{
> +		exfat_error("bad time %hu:%02hu:%02u",
> +				hour, min, twosec * 2);
> +		return 0;
> +	}
> +	if (centisec > 199)
> +	{
> +		exfat_error("bad centiseconds count %hhu", centisec);
> +		return 0;
> +	}
> +
> +	/* every 4th year between 1904 and 2096 is leap */
> +	unix_time +=3D year * SEC_IN_YEAR + LEAP_YEARS(year) * SEC_IN_DAY;
> +	unix_time +=3D days_in_year[month] * SEC_IN_DAY;
> +	/* if it's leap year and February has passed we should add 1 day */
> +	if ((EXFAT_EPOCH_YEAR + year) % 4 =3D=3D 0 && month > 2)
> +		unix_time +=3D SEC_IN_DAY;
> +	unix_time +=3D (day - 1) * SEC_IN_DAY;
> +
> +	unix_time +=3D hour * SEC_IN_HOUR;
> +	unix_time +=3D min * SEC_IN_MIN;
> +	/* exFAT represents time with 2 sec granularity */
> +	unix_time +=3D twosec * 2;
> +	unix_time +=3D centisec / 100;
> +
> +	/* exFAT stores timestamps in local time, so we correct it to UTC */
> +	if (tzoffset & 0x80)
> +		/* lower 7 bits are signed timezone offset in 15 minute increments */
> +		unix_time -=3D (int8_t)(tzoffset << 1) * 15 * 60 / 2;
> +	else
> +		/* timezone offset not present, assume our local timezone */
> +		unix_time +=3D exfat_timezone;
> +
> +	return unix_time;
> +}
> +
> +void exfat_unix2exfat(time_t unix_time, le16_t* date, le16_t* time,
> +		uint8_t* centisec, uint8_t* tzoffset)
> +{
> +	time_t shift =3D EPOCH_DIFF_SEC + exfat_timezone;
> +	uint16_t day, month, year;
> +	uint16_t twosec, min, hour;
> +	int days;
> +	int i;
> +
> +	/* time before exFAT epoch cannot be represented */
> +	if (unix_time < shift)
> +		unix_time =3D shift;
> +
> +	unix_time -=3D shift;
> +
> +	days =3D unix_time / SEC_IN_DAY;
> +	year =3D (4 * days) / (4 * 365 + 1);
> +	days -=3D year * 365 + LEAP_YEARS(year);
> +	month =3D 0;
> +	for (i =3D 1; i <=3D 12; i++)
> +	{
> +		int leap_day =3D (IS_LEAP_YEAR(year) && i =3D=3D 2);
> +		int leap_sub =3D (IS_LEAP_YEAR(year) && i >=3D 3);
> +
> +		if (i =3D=3D 12 || days - leap_sub < days_in_year[i + 1] + leap_day)
> +		{
> +			month =3D i;
> +			days -=3D days_in_year[i] + leap_sub;
> +			break;
> +		}
> +	}
> +	day =3D days + 1;
> +
> +	hour =3D (unix_time % SEC_IN_DAY) / SEC_IN_HOUR;
> +	min =3D (unix_time % SEC_IN_HOUR) / SEC_IN_MIN;
> +	twosec =3D (unix_time % SEC_IN_MIN) / 2;
> +
> +	*date =3D cpu_to_le16(day | (month << 5) | (year << 9));
> +	*time =3D cpu_to_le16(twosec | (min << 5) | (hour << 11));
> +	if (centisec)
> +		*centisec =3D (unix_time % 2) * 100;
> +
> +	/* record our local timezone offset in exFAT (15 minute increment) for=
mat */
> +	*tzoffset =3D (uint8_t)(-exfat_timezone / 60 / 15) | 0x80;
> +}
> +
> +void exfat_tzset(void)
> +{
> +	time_t now;
> +	struct tm* utc;
> +
> +	tzset();
> +	now =3D time(NULL);
> +	utc =3D gmtime(&now);
> +	/* gmtime() always sets tm_isdst to 0 because daylight savings never
> +	   affect UTC. Setting tm_isdst to -1 makes mktime() to determine whet=
her
> +	   summer time is in effect. */
> +	utc->tm_isdst =3D -1;
> +	exfat_timezone =3D mktime(utc) - now;
> +}
> diff --git a/fs/exfat/utf.c b/fs/exfat/utf.c
> new file mode 100644
> index 00000000000..b1d09e76478
> --- /dev/null
> +++ b/fs/exfat/utf.c
> @@ -0,0 +1,254 @@
> +/*
> +	utf.c (13.09.09)
> +	exFAT file system implementation library.
> +
> +	Free exFAT implementation.
> +	Copyright (C) 2010-2023  Andrew Nayenko
> +
> +	This program is free software; you can redistribute it and/or modify
> +	it under the terms of the GNU General Public License as published by
> +	the Free Software Foundation, either version 2 of the License, or
> +	(at your option) any later version.
> +
> +	This program is distributed in the hope that it will be useful,
> +	but WITHOUT ANY WARRANTY; without even the implied warranty of
> +	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +	GNU General Public License for more details.
> +
> +	You should have received a copy of the GNU General Public License alon=
g
> +	with this program; if not, write to the Free Software Foundation, Inc.=
,
> +	51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +*/
> +
> +#include "exfat.h"
> +#include <errno.h>
> +
> +static char* wchar_to_utf8(char* output, wchar_t wc, size_t outsize)
> +{
> +	if (wc <=3D 0x7f)
> +	{
> +		if (outsize < 1)
> +			return NULL;
> +		*output++ =3D (char) wc;
> +	}
> +	else if (wc <=3D 0x7ff)
> +	{
> +		if (outsize < 2)
> +			return NULL;
> +		*output++ =3D 0xc0 | (wc >> 6);
> +		*output++ =3D 0x80 | (wc & 0x3f);
> +	}
> +	else if (wc <=3D 0xffff)
> +	{
> +		if (outsize < 3)
> +			return NULL;
> +		*output++ =3D 0xe0 | (wc >> 12);
> +		*output++ =3D 0x80 | ((wc >> 6) & 0x3f);
> +		*output++ =3D 0x80 | (wc & 0x3f);
> +	}
> +	else if (wc <=3D 0x1fffff)
> +	{
> +		if (outsize < 4)
> +			return NULL;
> +		*output++ =3D 0xf0 | (wc >> 18);
> +		*output++ =3D 0x80 | ((wc >> 12) & 0x3f);
> +		*output++ =3D 0x80 | ((wc >> 6) & 0x3f);
> +		*output++ =3D 0x80 | (wc & 0x3f);
> +	}
> +	else if (wc <=3D 0x3ffffff)
> +	{
> +		if (outsize < 5)
> +			return NULL;
> +		*output++ =3D 0xf8 | (wc >> 24);
> +		*output++ =3D 0x80 | ((wc >> 18) & 0x3f);
> +		*output++ =3D 0x80 | ((wc >> 12) & 0x3f);
> +		*output++ =3D 0x80 | ((wc >> 6) & 0x3f);
> +		*output++ =3D 0x80 | (wc & 0x3f);
> +	}
> +	else if (wc <=3D 0x7fffffff)
> +	{
> +		if (outsize < 6)
> +			return NULL;
> +		*output++ =3D 0xfc | (wc >> 30);
> +		*output++ =3D 0x80 | ((wc >> 24) & 0x3f);
> +		*output++ =3D 0x80 | ((wc >> 18) & 0x3f);
> +		*output++ =3D 0x80 | ((wc >> 12) & 0x3f);
> +		*output++ =3D 0x80 | ((wc >> 6) & 0x3f);
> +		*output++ =3D 0x80 | (wc & 0x3f);
> +	}
> +	else
> +		return NULL;
> +
> +	return output;
> +}
> +
> +static const le16_t* utf16_to_wchar(const le16_t* input, wchar_t* wc,
> +		size_t insize)
> +{
> +	if ((le16_to_cpu(input[0]) & 0xfc00) =3D=3D 0xd800)
> +	{
> +		if (insize < 2 || (le16_to_cpu(input[1]) & 0xfc00) !=3D 0xdc00)
> +			return NULL;
> +		*wc =3D ((wchar_t) (le16_to_cpu(input[0]) & 0x3ff) << 10);
> +		*wc |=3D (le16_to_cpu(input[1]) & 0x3ff);
> +		*wc +=3D 0x10000;
> +		return input + 2;
> +	}
> +	else
> +	{
> +		*wc =3D le16_to_cpu(*input);
> +		return input + 1;
> +	}
> +}
> +
> +int exfat_utf16_to_utf8(char* output, const le16_t* input, size_t outsi=
ze,
> +		size_t insize)
> +{
> +	const le16_t* iptr =3D input;
> +	const le16_t* iend =3D input + insize;
> +	char* optr =3D output;
> +	const char* oend =3D output + outsize;
> +	wchar_t wc;
> +
> +	while (iptr < iend)
> +	{
> +		iptr =3D utf16_to_wchar(iptr, &wc, iend - iptr);
> +		if (iptr =3D=3D NULL)
> +		{
> +			exfat_error("illegal UTF-16 sequence");
> +			return -EILSEQ;
> +		}
> +		optr =3D wchar_to_utf8(optr, wc, oend - optr);
> +		if (optr =3D=3D NULL)
> +		{
> +			exfat_error("name is too long");
> +			return -ENAMETOOLONG;
> +		}
> +		if (wc =3D=3D 0)
> +			return 0;
> +	}
> +	if (optr >=3D oend)
> +	{
> +		exfat_error("name is too long");
> +		return -ENAMETOOLONG;
> +	}
> +	*optr =3D '\0';
> +	return 0;
> +}
> +
> +static const char* utf8_to_wchar(const char* input, wchar_t* wc,
> +		size_t insize)
> +{
> +	size_t size;
> +	size_t i;
> +
> +	if (insize =3D=3D 0)
> +		exfat_bug("no input for utf8_to_wchar");
> +
> +	if ((input[0] & 0x80) =3D=3D 0)
> +	{
> +		*wc =3D (wchar_t) input[0];
> +		return input + 1;
> +	}
> +	else if ((input[0] & 0xe0) =3D=3D 0xc0)
> +	{
> +		*wc =3D ((wchar_t) input[0] & 0x1f) << 6;
> +		size =3D 2;
> +	}
> +	else if ((input[0] & 0xf0) =3D=3D 0xe0)
> +	{
> +		*wc =3D ((wchar_t) input[0] & 0x0f) << 12;
> +		size =3D 3;
> +	}
> +	else if ((input[0] & 0xf8) =3D=3D 0xf0)
> +	{
> +		*wc =3D ((wchar_t) input[0] & 0x07) << 18;
> +		size =3D 4;
> +	}
> +	else if ((input[0] & 0xfc) =3D=3D 0xf8)
> +	{
> +		*wc =3D ((wchar_t) input[0] & 0x03) << 24;
> +		size =3D 5;
> +	}
> +	else if ((input[0] & 0xfe) =3D=3D 0xfc)
> +	{
> +		*wc =3D ((wchar_t) input[0] & 0x01) << 30;
> +		size =3D 6;
> +	}
> +	else
> +		return NULL;
> +
> +	if (insize < size)
> +		return NULL;
> +
> +	/* the first byte is handled above */
> +	for (i =3D 1; i < size; i++)
> +	{
> +		if ((input[i] & 0xc0) !=3D 0x80)
> +			return NULL;
> +		*wc |=3D (input[i] & 0x3f) << ((size - i - 1) * 6);
> +	}
> +
> +	return input + size;
> +}
> +
> +static le16_t* wchar_to_utf16(le16_t* output, wchar_t wc, size_t outsiz=
e)
> +{
> +	if (wc <=3D 0xffff) /* if character is from BMP */
> +	{
> +		if (outsize =3D=3D 0)
> +			return NULL;
> +		output[0] =3D cpu_to_le16(wc);
> +		return output + 1;
> +	}
> +	if (outsize < 2)
> +		return NULL;
> +	wc -=3D 0x10000;
> +	output[0] =3D cpu_to_le16(0xd800 | ((wc >> 10) & 0x3ff));
> +	output[1] =3D cpu_to_le16(0xdc00 | (wc & 0x3ff));
> +	return output + 2;
> +}
> +
> +int exfat_utf8_to_utf16(le16_t* output, const char* input, size_t outsi=
ze,
> +		size_t insize)
> +{
> +	const char* iptr =3D input;
> +	const char* iend =3D input + insize;
> +	le16_t* optr =3D output;
> +	const le16_t* oend =3D output + outsize;
> +	wchar_t wc;
> +
> +	while (iptr < iend)
> +	{
> +		iptr =3D utf8_to_wchar(iptr, &wc, iend - iptr);
> +		if (iptr =3D=3D NULL)
> +		{
> +			exfat_error("illegal UTF-8 sequence");
> +			return -EILSEQ;
> +		}
> +		optr =3D wchar_to_utf16(optr, wc, oend - optr);
> +		if (optr =3D=3D NULL)
> +		{
> +			exfat_error("name is too long");
> +			return -ENAMETOOLONG;
> +		}
> +		if (wc =3D=3D 0)
> +			break;
> +	}
> +	if (optr >=3D oend)
> +	{
> +		exfat_error("name is too long");
> +		return -ENAMETOOLONG;
> +	}
> +	*optr =3D cpu_to_le16(0);
> +	return 0;
> +}
> +
> +size_t exfat_utf16_length(const le16_t* str)
> +{
> +	size_t i =3D 0;
> +
> +	while (le16_to_cpu(str[i]))
> +		i++;
> +	return i;
> +}
> diff --git a/fs/exfat/utils.c b/fs/exfat/utils.c
> new file mode 100644
> index 00000000000..0d97b65dcab
> --- /dev/null
> +++ b/fs/exfat/utils.c
> @@ -0,0 +1,192 @@
> +/*
> +	utils.c (04.09.09)
> +	exFAT file system implementation library.
> +
> +	Free exFAT implementation.
> +	Copyright (C) 2010-2023  Andrew Nayenko
> +
> +	This program is free software; you can redistribute it and/or modify
> +	it under the terms of the GNU General Public License as published by
> +	the Free Software Foundation, either version 2 of the License, or
> +	(at your option) any later version.
> +
> +	This program is distributed in the hope that it will be useful,
> +	but WITHOUT ANY WARRANTY; without even the implied warranty of
> +	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +	GNU General Public License for more details.
> +
> +	You should have received a copy of the GNU General Public License alon=
g
> +	with this program; if not, write to the Free Software Foundation, Inc.=
,
> +	51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +*/
> +
> +#include "exfat.h"
> +#include <string.h>
> +#include <stdio.h>
> +#include <inttypes.h>
> +
> +void exfat_stat(const struct exfat* ef, const struct exfat_node* node,
> +		struct stat* stbuf)
> +{
> +	memset(stbuf, 0, sizeof(struct stat));
> +	if (node->attrib & EXFAT_ATTRIB_DIR)
> +		stbuf->st_mode =3D S_IFDIR | (0777 & ~ef->dmask);
> +	else
> +		stbuf->st_mode =3D S_IFREG | (0777 & ~ef->fmask);
> +	stbuf->st_nlink =3D 1;
> +	stbuf->st_uid =3D ef->uid;
> +	stbuf->st_gid =3D ef->gid;
> +	stbuf->st_size =3D node->size;
> +	stbuf->st_blocks =3D ROUND_UP(node->size, CLUSTER_SIZE(*ef->sb)) / 512=
;
> +	stbuf->st_mtime =3D node->mtime;
> +	stbuf->st_atime =3D node->atime;
> +	/* set ctime to mtime to ensure we don't break programs that rely on c=
time
> +	   (e.g. rsync) */
> +	stbuf->st_ctime =3D node->mtime;
> +}
> +
> +void exfat_get_name(const struct exfat_node* node,
> +		char buffer[EXFAT_UTF8_NAME_BUFFER_MAX])
> +{
> +	if (exfat_utf16_to_utf8(buffer, node->name, EXFAT_UTF8_NAME_BUFFER_MAX=
,
> +				EXFAT_NAME_MAX) !=3D 0)
> +		exfat_bug("failed to convert name to UTF-8");
> +}
> +
> +static uint16_t add_checksum_byte(uint16_t sum, uint8_t byte)
> +{
> +	return ((sum << 15) | (sum >> 1)) + byte;
> +}
> +
> +static uint16_t add_checksum_bytes(uint16_t sum, const void* buffer, si=
ze_t n)
> +{
> +	size_t i;
> +
> +	for (i =3D 0; i < n; i++)
> +		sum =3D add_checksum_byte(sum, ((const uint8_t*) buffer)[i]);
> +	return sum;
> +}
> +
> +uint16_t exfat_start_checksum(const struct exfat_entry_meta1* entry)
> +{
> +	uint16_t sum =3D 0;
> +	size_t i;
> +
> +	for (i =3D 0; i < sizeof(struct exfat_entry); i++)
> +		if (i !=3D 2 && i !=3D 3) /* skip checksum field itself */
> +			sum =3D add_checksum_byte(sum, ((const uint8_t*) entry)[i]);
> +	return sum;
> +}
> +
> +uint16_t exfat_add_checksum(const void* entry, uint16_t sum)
> +{
> +	return add_checksum_bytes(sum, entry, sizeof(struct exfat_entry));
> +}
> +
> +le16_t exfat_calc_checksum(const struct exfat_entry* entries, int n)
> +{
> +	uint16_t checksum;
> +	int i;
> +
> +	checksum =3D exfat_start_checksum((const struct exfat_entry_meta1*) en=
tries);
> +	for (i =3D 1; i < n; i++)
> +		checksum =3D exfat_add_checksum(entries + i, checksum);
> +	return cpu_to_le16(checksum);
> +}
> +
> +uint32_t exfat_vbr_start_checksum(const void* sector, size_t size)
> +{
> +	size_t i;
> +	uint32_t sum =3D 0;
> +
> +	for (i =3D 0; i < size; i++)
> +		/* skip volume_state and allocated_percent fields */
> +		if (i !=3D 0x6a && i !=3D 0x6b && i !=3D 0x70)
> +			sum =3D ((sum << 31) | (sum >> 1)) + ((const uint8_t*) sector)[i];
> +	return sum;
> +}
> +
> +uint32_t exfat_vbr_add_checksum(const void* sector, size_t size, uint32=
_t sum)
> +{
> +	size_t i;
> +
> +	for (i =3D 0; i < size; i++)
> +		sum =3D ((sum << 31) | (sum >> 1)) + ((const uint8_t*) sector)[i];
> +	return sum;
> +}
> +
> +le16_t exfat_calc_name_hash(const struct exfat* ef, const le16_t* name,
> +		size_t length)
> +{
> +	size_t i;
> +	uint16_t hash =3D 0;
> +
> +	for (i =3D 0; i < length; i++)
> +	{
> +		uint16_t c =3D le16_to_cpu(name[i]);
> +
> +		/* convert to upper case */
> +		c =3D ef->upcase[c];
> +
> +		hash =3D ((hash << 15) | (hash >> 1)) + (c & 0xff);
> +		hash =3D ((hash << 15) | (hash >> 1)) + (c >> 8);
> +	}
> +	return cpu_to_le16(hash);
> +}
> +
> +void exfat_humanize_bytes(uint64_t value, struct exfat_human_bytes* hb)
> +{
> +	size_t i;
> +	/* 16 EB (minus 1 byte) is the largest size that can be represented by
> +	   uint64_t */
> +	const char* units[] =3D {"bytes", "KB", "MB", "GB", "TB", "PB", "EB"};
> +	uint64_t divisor =3D 1;
> +	uint64_t temp =3D 0;
> +
> +	for (i =3D 0; ; i++, divisor *=3D 1024)
> +	{
> +		temp =3D (value + divisor / 2) / divisor;
> +
> +		if (temp =3D=3D 0)
> +			break;
> +		if (temp / 1024 * 1024 =3D=3D temp)
> +			continue;
> +		if (temp < 10240)
> +			break;
> +	}
> +	hb->value =3D temp;
> +	hb->unit =3D units[i];
> +}
> +
> +void exfat_print_info(const struct exfat_super_block* sb,
> +		uint32_t free_clusters)
> +{
> +	struct exfat_human_bytes hb;
> +	off_t total_space =3D le64_to_cpu(sb->sector_count) * SECTOR_SIZE(*sb)=
;
> +	off_t avail_space =3D (off_t) free_clusters * CLUSTER_SIZE(*sb);
> +
> +	printf("File system version           %hhu.%hhu\n",
> +			sb->version.major, sb->version.minor);
> +	exfat_humanize_bytes(SECTOR_SIZE(*sb), &hb);
> +	printf("Sector size          %10"PRIu64" %s\n", hb.value, hb.unit);
> +	exfat_humanize_bytes(CLUSTER_SIZE(*sb), &hb);
> +	printf("Cluster size         %10"PRIu64" %s\n", hb.value, hb.unit);
> +	exfat_humanize_bytes(total_space, &hb);
> +	printf("Volume size          %10"PRIu64" %s\n", hb.value, hb.unit);
> +	exfat_humanize_bytes(total_space - avail_space, &hb);
> +	printf("Used space           %10"PRIu64" %s\n", hb.value, hb.unit);
> +	exfat_humanize_bytes(avail_space, &hb);
> +	printf("Available space      %10"PRIu64" %s\n", hb.value, hb.unit);
> +}
> +
> +bool exfat_match_option(const char* options, const char* option_name)
> +{
> +	const char* p;
> +	size_t length =3D strlen(option_name);
> +
> +	for (p =3D strstr(options, option_name); p; p =3D strstr(p + 1, option=
_name))
> +		if ((p =3D=3D options || p[-1] =3D=3D ',') &&
> +				(p[length] =3D=3D ',' || p[length] =3D=3D '\0'))
> +			return true;
> +	return false;
> +}

