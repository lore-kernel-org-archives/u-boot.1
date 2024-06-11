Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C73B6C25B76
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 09:17:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17D1F885EC;
	Tue, 11 Jun 2024 11:17:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Rx8uWsBk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A89C488619; Tue, 11 Jun 2024 11:17:13 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CE5388300
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 11:17:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718097429; x=1718702229; i=xypron.glpk@gmx.de;
 bh=wXV/kaW7luOEty6I/EoauAYulKmagMVs8uoiPMxywEk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Rx8uWsBkJCTwxGREAdt0bIutpORr1TqjFB2qJ7OCRc6PGz+gc+pAGb/aqi6O6XC4
 x4xBBltVtGTgWzS2jNC85WMYOi7Dxtynh1l5HFf7nc2P2KaA+6i3d8/HYqYt4LHqy
 Z10VmFJr10zB7KR2xp9TL6kyF+UF2sBfMD8y42+KviRAolrT909305wDi6Fj05Lti
 19m84gS7cH6ziHWX2Dz9dnw06baGYoYgp4AfH2/WtnILxfxZzwDtFuwTJAjp9Jt6B
 oM54lwIjLmq24iuP5HdN6v499xX69dLfw78mArcFOczV16Ric+an91H5QtxFU5Jte
 JYiHQaGuxMgc74/pZw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([109.42.176.212]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MlNpH-1sgiCm1M1V-00ffPD; Tue, 11
 Jun 2024 11:17:09 +0200
Message-ID: <5d133571-ba43-40c7-bd19-0c0a4e857034@gmx.de>
Date: Tue, 11 Jun 2024 11:17:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 09/31] lmb: allow for resizing lmb regions
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>,
 u-boot@lists.denx.de
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-10-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240607185240.1892031-10-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IzIwEIARnEt30bpr5WiIkqHuvWlG04+CFNQNOek7gyogdJ/jubZ
 7EPPLe8ors9o+FnZ7zgh89Xa7+r9eYxId8lm2CcxS/pyLk6JAkJChkhlSM4xG44ox+IzQvs
 MVcX0lnM8L6ggzioDJvobQBgaDk5jx6clcs4OmQ8s68SxZDDWmUBFfsxVqvS0CApwfd6Utv
 q9gAS44eGOzQdmuEQrtrg==
UI-OutboundReport: notjunk:1;M01:P0:OnxB+QiSlRY=;3Bms1InFEDQwqlnMKohfCQs3Dm5
 F4Zndc4h2wQxZNYrGJHoa7X27f0PPD05DP5vj/4OBS5GsKnSNTDhhjYxaugdhNctyBKkSEVj7
 ysqS0HnxjIqeoJkG7zfERLDiIdxCY5C72y8k15TI8T63pXd/Juqo3YZM2dnFlPhRoK1284r2k
 xJbyzRkTajqfEQ2fnIF2UuNq+2+RiXiDHUXkF3VoRxqw0lr4KlSzsG3jkXbM9E9GHTC+qlETg
 6K0AQlyfiKghqsxZaRT6vhc8gl4LbdV2fkJu2HAjm42OOYNmjql5cWIzV9wj761P+lIl2m+Tk
 ayX+PwEEfnsIxrfnbDVf2DPyADdg5QFMJiLCIK10pe13MK6sXUseb+mvsiZ0rTzxYQW0zN36r
 2OJj/GwNzpdUcdTNo2VTeJMrqdZzSSPEXPtxUgHGdO60qdZbLJXFH/2GqpZ/mnTxkKwIeuIIW
 lNVHMwKOlVIQ0tGsrXzGnH30gcw9AdJBAWbWySCXnPs7IiVIEoe6YN6JKW8Ve2r9GEheUbWfS
 Qy/OteNs04wMOq5PnTcyRX6c7FIXgTUCXTuyXOvrx3JLbO8PQSSfTbA1C9Ie7CaLkQGaTHkpY
 e3285m0gCBdIwCuAcUlsnrK4k2GM8Mp/fRaL6crEYwsrmGluIUrhFrwAwH55lqaDC7GB+9b7r
 uD3jzV0fUD7qlYNIhVRkqhT027qwIPjGLu0/YnkK7Y2M9bFnUTaVWIfqufjJCjSJ6YhLi6fjT
 GFLf2F0NPJfctK2iEs303bUVr50EYl05hzyRau/gabNNC6aMO3rVPRWsEfUEaYEe5PCMwRI0a
 b192RQ7fnItm3wPICjZpzRyE5CNty9181WkLeKRqiN5C4=
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
> Allow for resizing of LMB regions if the region attributes match. The
> current code returns a failure status on detecting an overlapping
> address. This worked up until now since the LMB calls were not
> persistent and global -- the LMB memory map was specific and private
> to a given caller of the LMB API's.
>
> With the change in the LMB code to make the LMB reservations
> persistent, there needs to be a check on whether the memory region can
> be resized, and then do it if so. To distinguish between memory that
> cannot be resized, add a new flag, LMB_NOOVERWRITE. Reserving a region
> of memory with this attribute would indicate that the region cannot be
> resized.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>   include/lmb.h |   1 +
>   lib/lmb.c     | 120 ++++++++++++++++++++++++++++++++++++++++++++------
>   2 files changed, 107 insertions(+), 14 deletions(-)
>
> diff --git a/include/lmb.h b/include/lmb.h
> index 03bce2a50c..1d4cd255d2 100644
> --- a/include/lmb.h
> +++ b/include/lmb.h
> @@ -20,6 +20,7 @@
>   enum lmb_flags {
>   	LMB_NONE		=3D 0x0,
>   	LMB_NOMAP		=3D 0x4,
> +	LMB_NOOVERWRITE		=3D 0x8,

Please, add the missing description for the new value. Using the first
available bit (0x01) would be expected.

Using the BIT macro would make it clearer that these are bits of a bitmap:

enum lmb_flags {
	LMB_NONE		=3D BIT(0),
	LMB_NOOVERWRITE		=3D BIT(1),
};

Best regards

Heinrich


>   };
>
>   /**
> diff --git a/lib/lmb.c b/lib/lmb.c
> index de5a2cf23b..0a4f3d5bcd 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -260,12 +260,88 @@ void lmb_add_memory(struct bd_info *bd)
>   	}
>   }
>
> +static bool lmb_region_flags_match(struct lmb_region *rgn, unsigned lon=
g r1,
> +				   enum lmb_flags flags)
> +{
> +	return rgn->region[r1].flags =3D=3D flags;
> +}
> +
> +static long lmb_merge_overlap_regions(struct lmb_region *rgn, unsigned =
long i,
> +				      phys_addr_t base, phys_size_t size,
> +				      enum lmb_flags flags)
> +{
> +	phys_size_t rgnsize;
> +	unsigned long rgn_cnt, idx;
> +	phys_addr_t rgnbase, rgnend;
> +	phys_addr_t mergebase, mergeend;
> +
> +	rgn_cnt =3D 0;
> +	idx =3D i;
> +	/*
> +	 * First thing to do is to identify how many regions does
> +	 * the requested region overlap.
> +	 * If the flags match, combine all these overlapping
> +	 * regions into a single region, and remove the merged
> +	 * regions.
> +	 */
> +	while (idx < rgn->cnt - 1) {
> +		rgnbase =3D rgn->region[idx].base;
> +		rgnsize =3D rgn->region[idx].size;
> +
> +		if (lmb_addrs_overlap(base, size, rgnbase,
> +				      rgnsize)) {
> +			if (!lmb_region_flags_match(rgn, idx, flags))
> +				return -1;
> +			rgn_cnt++;
> +			idx++;
> +		}
> +	}
> +
> +	/* The merged region's base and size */
> +	rgnbase =3D rgn->region[i].base;
> +	mergebase =3D min(base, rgnbase);
> +	rgnend =3D rgn->region[idx].base + rgn->region[idx].size;
> +	mergeend =3D max(rgnend, (base + size));
> +
> +	rgn->region[i].base =3D mergebase;
> +	rgn->region[i].size =3D mergeend - mergebase;
> +
> +	/* Now remove the merged regions */
> +	while (--rgn_cnt)
> +		lmb_remove_region(rgn, i + 1);
> +
> +	return 0;
> +}
> +
> +static long lmb_resize_regions(struct lmb_region *rgn, unsigned long i,
> +			       phys_addr_t base, phys_size_t size,
> +			       enum lmb_flags flags)
> +{
> +	long ret =3D 0;
> +	phys_addr_t rgnend;
> +
> +	if (i =3D=3D rgn->cnt - 1 ||
> +		base + size < rgn->region[i + 1].base) {
> +		if (!lmb_region_flags_match(rgn, i, flags))
> +			return -1;
> +
> +		rgnend =3D rgn->region[i].base + rgn->region[i].size;
> +		rgn->region[i].base =3D min(base, rgn->region[i].base);
> +		rgnend =3D max(base + size, rgnend);
> +		rgn->region[i].size =3D rgnend - rgn->region[i].base;
> +	} else {
> +		ret =3D lmb_merge_overlap_regions(rgn, i, base, size, flags);
> +	}
> +
> +	return ret;
> +}
> +
>   /* This routine called with relocation disabled. */
>   static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t b=
ase,
>   				 phys_size_t size, enum lmb_flags flags)
>   {
>   	unsigned long coalesced =3D 0;
> -	long adjacent, i;
> +	long ret, i;
>
>   	if (rgn->cnt =3D=3D 0) {
>   		rgn->region[0].base =3D base;
> @@ -290,23 +366,32 @@ static long lmb_add_region_flags(struct lmb_region=
 *rgn, phys_addr_t base,
>   				return -1; /* regions with new flags */
>   		}
>
> -		adjacent =3D lmb_addrs_adjacent(base, size, rgnbase, rgnsize);
> -		if (adjacent > 0) {
> +		ret =3D lmb_addrs_adjacent(base, size, rgnbase, rgnsize);
> +		if (ret > 0) {
>   			if (flags !=3D rgnflags)
>   				break;
>   			rgn->region[i].base -=3D size;
>   			rgn->region[i].size +=3D size;
>   			coalesced++;
>   			break;
> -		} else if (adjacent < 0) {
> +		} else if (ret < 0) {
>   			if (flags !=3D rgnflags)
>   				break;
>   			rgn->region[i].size +=3D size;
>   			coalesced++;
>   			break;
>   		} else if (lmb_addrs_overlap(base, size, rgnbase, rgnsize)) {
> -			/* regions overlap */
> -			return -1;
> +			if (flags =3D=3D LMB_NONE) {
> +				ret =3D lmb_resize_regions(rgn, i, base, size,
> +							 flags);
> +				if (ret < 0)
> +					return -1;
> +
> +				coalesced++;
> +				break;
> +			} else {
> +				return -1;
> +			}
>   		}
>   	}
>
> @@ -448,7 +533,7 @@ static phys_addr_t lmb_align_down(phys_addr_t addr, =
phys_size_t size)
>   }
>
>   static phys_addr_t __lmb_alloc_base(phys_size_t size, ulong align,
> -				    phys_addr_t max_addr)
> +				    phys_addr_t max_addr, enum lmb_flags flags)
>   {
>   	long i, rgn;
>   	phys_addr_t base =3D 0;
> @@ -498,7 +583,7 @@ phys_addr_t lmb_alloc_base(phys_size_t size, ulong a=
lign, phys_addr_t max_addr)
>   {
>   	phys_addr_t alloc;
>
> -	alloc =3D __lmb_alloc_base(size, align, max_addr);
> +	alloc =3D __lmb_alloc_base(size, align, max_addr, LMB_NONE);
>
>   	if (alloc =3D=3D 0)
>   		printf("ERROR: Failed to allocate 0x%lx bytes below 0x%lx.\n",
> @@ -507,11 +592,8 @@ phys_addr_t lmb_alloc_base(phys_size_t size, ulong =
align, phys_addr_t max_addr)
>   	return alloc;
>   }
>
> -/*
> - * Try to allocate a specific address range: must be in defined memory =
but not
> - * reserved
> - */
> -phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size)
> +static phys_addr_t __lmb_alloc_addr(phys_addr_t base, phys_size_t size,
> +				    enum lmb_flags flags)
>   {
>   	long rgn;
>
> @@ -526,13 +608,23 @@ phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_=
size_t size)
>   				      lmb.memory.region[rgn].size,
>   				      base + size - 1, 1)) {
>   			/* ok, reserve the memory */
> -			if (lmb_reserve(base, size) >=3D 0)
> +			if (lmb_reserve_flags(base, size, flags) >=3D 0)
>   				return base;
>   		}
>   	}
> +
>   	return 0;
>   }
>
> +/*
> + * Try to allocate a specific address range: must be in defined memory =
but not
> + * reserved
> + */
> +phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size)
> +{
> +	return __lmb_alloc_addr(base, size, LMB_NONE);
> +}
> +
>   /* Return number of bytes from a given address that are free */
>   phys_size_t lmb_get_free_size(phys_addr_t addr)
>   {

