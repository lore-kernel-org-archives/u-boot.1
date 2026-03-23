Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E79F4613D
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 15:08:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3220E84144;
	Mon, 23 Mar 2026 16:08:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FbWayW17";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7687A8412F; Mon, 23 Mar 2026 16:08:16 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43E0E8412F
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 16:08:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1D99360120;
 Mon, 23 Mar 2026 15:08:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA42C4CEF7;
 Mon, 23 Mar 2026 15:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774278487;
 bh=99pFc5lqEm3HxVz/exMZerXEHwyavsRZ+6NWbBoKUu8=;
 h=Date:From:To:Subject:Cc:References:In-Reply-To:From;
 b=FbWayW17Rsg9Ow1rNOXeKW98kSAo875Ay6O96tvV6rS4SF3yV7eartMVTzWidlasA
 l9S9Y1mLNegrsjlj0MkAZ0naozF3/j+ClXyxSu+4uCr/T+UnhmL3mDEqyX0kUXMvoh
 bTAoTRynTxHFHEG6kpMPmGV3EqEBzVqm765qSapIFh2wbVsECf68y49jUnkO9XONlI
 EVDTyTlpSW6marJbJtQElPtryGO86JLOJAuzi2eksKOvQ5krU53av9so1vB2bLeUlo
 xPofYJ1QVoGgHrJdPNUNzHTD/ktH9ftz59SpDZGR6evZ6HfsIYNVwfhbnIlDHUj6YR
 Ozr2rhHiXfJvA==
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=5e3ab7e9be9fb049f7a17dec87288033ce5a62afd946d4a9ae13b0b1b96f;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 23 Mar 2026 16:08:04 +0100
Message-Id: <DHA98B2R8313.2J0R49KQ2WE1X@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Gao Xiang" <hsiangkao@linux.alibaba.com>, "Huang Jianan"
 <jnhuang95@gmail.com>, "Tom Rini" <trini@konsulko.com>
Subject: Re: [PATCH 1/4] fs/erofs: align the malloc'ed data
Cc: <linux-erofs@lists.ozlabs.org>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.20.0
References: <20260323134305.2675822-1-mwalle@kernel.org>
 <20260323134305.2675822-2-mwalle@kernel.org>
 <b761dcf1-db25-47f3-8ef6-096c7a2f0493@linux.alibaba.com>
In-Reply-To: <b761dcf1-db25-47f3-8ef6-096c7a2f0493@linux.alibaba.com>
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

--5e3ab7e9be9fb049f7a17dec87288033ce5a62afd946d4a9ae13b0b1b96f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Gao,

On Mon Mar 23, 2026 at 3:41 PM CET, Gao Xiang wrote:
> Hi Michael,
>
> On 2026/3/23 21:42, Michael Walle wrote:
>> The data buffers are used to transfer from or to hardware peripherals.
>> Often, there are restrictions on addresses, i.e. they have to be aligned
>> at a certain size. Thus, allocate the data on the heap instead of the
>> stack (at a random address alignment). Use malloc_cache_aligned() to get
>> an aligned buffer.
>
> Many thanks for the patch, I wonder if it's possible to
> submit the patches to erofs-utils first (even make
> malloc_cache_aligned() as another malloc() for example)?
>
> Since I'd like to make u-boot codebase following
> erofs-utils, but I don't think Jianan have the
> bandwidth now, but if you have some use cases,
> you could help syncing up a bit.

Sorry, I don't have the bandwidth neither. But now I see where all
this is coming from. In userspace, you have much less (or none at
all) restrictions. So not sure, if that even makes sense to share. As
you've already pointed out the malloc_cache_aligned() would have to
be changed (back!) to malloc() again.

> Or at least, let's keep these four patches in sync
> between erofs-utils and u-boot.

Not sure what a DMA alignment has to do with userspace, or do you
mean moving all the block data from stack to heap?

This is more or less the result from an internal evaluation. You (or
anybody else) might take it - or leave it.

Do you share code between linux and erofs-utils, too? How does that
work?

Thanks,
-michael

>
> Many thanks!
> Gao Xiang
>
>>=20
>> Signed-off-by: Michael Walle <mwalle@kernel.org>
>> ---
>>   fs/erofs/data.c     | 11 ++++-------
>>   fs/erofs/internal.h |  1 +
>>   2 files changed, 5 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
>> index b58ec6fcc66..61dbae51a9a 100644
>> --- a/fs/erofs/data.c
>> +++ b/fs/erofs/data.c
>> @@ -319,15 +319,13 @@ static int z_erofs_read_data(struct erofs_inode *i=
node, char *buffer,
>>   		}
>>  =20
>>   		if (map.m_plen > bufsize) {
>> -			char *tmp;
>> -
>>   			bufsize =3D map.m_plen;
>> -			tmp =3D realloc(raw, bufsize);
>> -			if (!tmp) {
>> +			free(raw);
>> +			raw =3D malloc_cache_aligned(bufsize);
>> +			if (!raw) {
>>   				ret =3D -ENOMEM;
>>   				break;
>>   			}
>> -			raw =3D tmp;
>>   		}
>>  =20
>>   		ret =3D z_erofs_read_one_data(inode, &map, raw,
>> @@ -336,8 +334,7 @@ static int z_erofs_read_data(struct erofs_inode *ino=
de, char *buffer,
>>   		if (ret < 0)
>>   			break;
>>   	}
>> -	if (raw)
>> -		free(raw);
>> +	free(raw);
>>   	return ret < 0 ? ret : 0;
>>   }
>>  =20
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index 1875f37fcd2..13c862325a6 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -11,6 +11,7 @@
>>   #include <linux/printk.h>
>>   #include <linux/log2.h>
>>   #include <inttypes.h>
>> +#include <memalign.h>
>>   #include "erofs_fs.h"
>>  =20
>>   #define erofs_err(fmt, ...)	\


--5e3ab7e9be9fb049f7a17dec87288033ce5a62afd946d4a9ae13b0b1b96f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCacFXVBIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/hlzgF+MQNTBBoBCdia2AtL2tMg+YFjYbZnq3fX
nBm2QHe9f+fb5/8OkA6OQEBY66SKXGonAYCmynQh6BizftTuiKu+LZGK+0+xJj39
vwqvFOhadBjMmVq/P/J7nxpbBwtlCE/JnxM=
=xw/2
-----END PGP SIGNATURE-----

--5e3ab7e9be9fb049f7a17dec87288033ce5a62afd946d4a9ae13b0b1b96f--
