Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E76EE4993
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 15:45:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B4398645F;
	Wed, 23 Aug 2023 17:44:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Csb9kxUR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAED886467; Wed, 23 Aug 2023 17:44:56 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC2888631F
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 17:44:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692805490; x=1693410290; i=xypron.glpk@gmx.de;
 bh=s+4DUAfl4VaBDcz6f/1C6CcQfpbPjWjfPXeZpTWP4go=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Csb9kxURDnVCg0uy0cFqFcLjD2IODpsZ6OsknVFHKP6SCMvSW4SD70+h/c4JfRJPLkifX2T
 vyJkc/Q/TvMTSmBWFoCKtofzolx6v8LglSxIBzGGMhU6dSI7hZ9PjBpVZ77i9z3/2hO64Tj7k
 WO05jgcFUEfArZIMsi/Y+n5VxbiUljJB/2auqLjEp3Qer56lOJeexaQjeU7HPy/PvkE4PF/AL
 N6qVcd4Pgz8swc0BIzg+j63ICJJkVmUvxmjZzS0BO5F1ATZIx7Y8PsOgWx2+B3C7uJf7I6n5C
 r1MK5KDy9+uWsNrbRMMBy3ARc8K2acQds6avMwDIdIwoDg2os2WQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([62.143.244.162]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mq2jC-1puoVc1wWI-00nBtQ; Wed, 23
 Aug 2023 17:44:50 +0200
Message-ID: <f2cc3d2f-923d-6774-d411-25dace89b6a3@gmx.de>
Date: Wed, 23 Aug 2023 17:44:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/7] lmb: Tidy up structure access
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Sjoerd Simons <sjoerd@collabora.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20230823134209.1450567-1-sjg@chromium.org>
 <20230823134209.1450567-3-sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20230823134209.1450567-3-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ysgpnlcyH2aDeSeYXnNO2jxCN3Njc265/k4ThLK5QaOKeGqdLz4
 Dcn96BlrYvRGIYbN8/EPPmtWMQVkoMr64MBzuBz8dXytIhUU3CfmQJonFGTfK92hmLWRZOD
 3lN98L8d08KRfAQowrgsZAqvsC7Y9wt80uQnK7PPSjxR0jruwYCq0TAoTPKnGBhIFFFVmus
 VU8y5x3VRQFtUe+gJhLHg==
UI-OutboundReport: notjunk:1;M01:P0:EeQthQyNrUg=;oLP9F7eki8VBta1oI5wGkaHrZMF
 AcmnjKQC+OlGSQSeDhWn+vLLu6OJEbWUIECFJQMwFyQD+blX/xjEV7UprxJ/ZiamlNziYJsl5
 RA6tvt1g1aho8uV65aPMiu3VzKewESu5wVmYtRZRGuLv1xZKrUVyP/zaMJJSCtLq9uXp6R3Lk
 cqTEHrkW8/ToiL0XG5PQbQnOtjnXaQtGmTvYLbs1/rnoe43g6Vmv1uXvg32LWWGwDXque7LjI
 so1Z9tq44DQD8QhoNwmfdn46SZzrHtm6d67Re6psPr5vQj4w3m3Jkx2WpCORmMz4ARyfn6Gys
 zPOGps/Vr9YDbPm0t1tuH8QLGF0WPY47kmBZeoTEj41v5xpCEQrufXUAmndACCJyL+J+jwPTm
 K2T5W9rv5ckdix0IyRAcD7bzNyM0iyO/W/6NtyywIkXG9wCpJSd5vls5Sy4cmo1u3LQ3ewJkS
 oM31/38T4OIFt2eHSqnpw83fsPMedDWVa1jviCxUAnxNwFRCHQCf9o1C6bpk8DzA7s6ezS4bS
 vgBEJmm05iBl07iVe/EvPkJRvGFsdU1cs0IihHt7ZWo3Wdar3lQjm7LrQcJN6x87tu9lE9zZE
 fGuh7FZWjvUClidH+WuVNH5iLWewkz8w0G8TqNhfoMghlyUxHZArY6kFYqEGT0HIdl/1WlKzC
 tguS2GZnJ5TlVtEDg5Ty4geQK3seUyYDSsB/Q/bqK8yX5AlpOpp4yxXaXQPeLz0DMnI6KYYHg
 +9u/nG0BADz4kY2489khFJ0zOgS/TB5oG9CJJrp6ASU6Q/iAr4ZxINVBTtV1a6MD5wuZ2M1G2
 yziYfZsJsf7ehu8YcfSIwr5xds+1zlvZO0szIUuS9yX8aENku124HnmiwmX3ur8OMqaRHCfx1
 rDOdGjEYOFjIcIrIRTXB8cXAfRVk5pgSppYqUzoEbfRAI5HVs8yrTeqXNh8zD8WAxi1WWwddj
 Vmg6KXDkDNM7dTprm30k+iT34rn/71wnEBkZESzqNa/f6mgHi3H3Y0434mPCBeg/2vZnag==
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

On 23.08.23 15:41, Simon Glass wrote:
> In some cases it helps to define a local variable pointing to the
> structure being accessed. This avoids lots of repeated code.
>
> There is no need to individually assign each struct member, so use a
> structure assignment instead.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   lib/lmb.c | 54 +++++++++++++++++++++++++-----------------------------
>   1 file changed, 25 insertions(+), 29 deletions(-)
>
> diff --git a/lib/lmb.c b/lib/lmb.c
> index ae1969893f00..8b9a611c5216 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -23,20 +23,19 @@ DECLARE_GLOBAL_DATA_PTR;
>
>   static void lmb_dump_region(struct lmb_region *rgn, char *name)
>   {
> -	unsigned long long base, size, end;
> -	enum lmb_flags flags;
>   	int i;
>
>   	printf(" %s.cnt =3D 0x%lx / max =3D 0x%lx\n", name, rgn->cnt, rgn->ma=
x);
>
>   	for (i =3D 0; i < rgn->cnt; i++) {
> -		base =3D rgn->region[i].base;
> -		size =3D rgn->region[i].size;
> -		end =3D base + size - 1;
> -		flags =3D rgn->region[i].flags;
> +		struct lmb_property *prop =3D &rgn->region[i];
> +		unsigned long long end;
> +
> +		end =3D prop->base + prop->size - 1;
>
>   		printf(" %s[%d]\t[0x%llx-0x%llx], 0x%08llx bytes flags: %x\n",
> -		       name, i, base, end, size, flags);
> +		       name, i, (unsigned long long)prop->base, end,
> +		       (unsigned long long)prop->size, prop->flags);
>   	}
>   }
>
> @@ -89,11 +88,8 @@ static void lmb_remove_region(struct lmb_region *rgn,=
 unsigned long r)
>   {
>   	unsigned long i;
>
> -	for (i =3D r; i < rgn->cnt - 1; i++) {
> -		rgn->region[i].base =3D rgn->region[i + 1].base;
> -		rgn->region[i].size =3D rgn->region[i + 1].size;
> -		rgn->region[i].flags =3D rgn->region[i + 1].flags;
> -	}
> +	for (i =3D r; i < rgn->cnt - 1; i++)
> +		rgn->region[i] =3D rgn->region[i + 1];
>   	rgn->cnt--;
>   }
>
> @@ -122,6 +118,7 @@ void lmb_init(struct lmb *lmb)
>
>   void arch_lmb_reserve_generic(struct lmb *lmb, ulong sp, ulong end, ul=
ong align)
>   {
> +	struct bd_info *bd =3D gd->bd;
>   	ulong bank_end;
>   	int bank;
>
> @@ -135,12 +132,10 @@ void arch_lmb_reserve_generic(struct lmb *lmb, ulo=
ng sp, ulong end, ulong align)
>   	/* adjust sp by 4K to be safe */
>   	sp -=3D align;
>   	for (bank =3D 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
> -		if (!gd->bd->bi_dram[bank].size ||
> -		    sp < gd->bd->bi_dram[bank].start)
> +		if (!bd->bi_dram[bank].size || sp < bd->bi_dram[bank].start)
>   			continue;
>   		/* Watch out for RAM at end of address space! */
> -		bank_end =3D gd->bd->bi_dram[bank].start +
> -			gd->bd->bi_dram[bank].size - 1;
> +		bank_end =3D bd->bi_dram[bank].start + bd->bi_dram[bank].size - 1;
>   		if (sp > bank_end)
>   			continue;
>   		if (bank_end > end)
> @@ -244,9 +239,11 @@ static long lmb_add_region_flags(struct lmb_region =
*rgn, phys_addr_t base,
>
>   	/* First try and coalesce this LMB with another. */
>   	for (i =3D 0; i < rgn->cnt; i++) {
> -		phys_addr_t rgnbase =3D rgn->region[i].base;
> -		phys_size_t rgnsize =3D rgn->region[i].size;
> -		phys_size_t rgnflags =3D rgn->region[i].flags;
> +		struct lmb_property *prop =3D &rgn->region[i];

Why call a region prop? Can't we call it "region" or "rgn_ptr" or if you
want to allude to the position in the array "pos"? This would avoid
confusion.

Best regards

Heinrich

> +
> +		phys_addr_t rgnbase =3D prop->base;
> +		phys_size_t rgnsize =3D prop->size;
> +		phys_size_t rgnflags =3D prop->flags;
>   		phys_addr_t end =3D base + size - 1;
>   		phys_addr_t rgnend =3D rgnbase + rgnsize - 1;
>
> @@ -262,14 +259,14 @@ static long lmb_add_region_flags(struct lmb_region=
 *rgn, phys_addr_t base,
>   		if (adjacent > 0) {
>   			if (flags !=3D rgnflags)
>   				break;
> -			rgn->region[i].base -=3D size;
> -			rgn->region[i].size +=3D size;
> +			prop->base -=3D size;
> +			prop->size +=3D size;
>   			coalesced++;
>   			break;
>   		} else if (adjacent < 0) {
>   			if (flags !=3D rgnflags)
>   				break;
> -			rgn->region[i].size +=3D size;
> +			prop->size +=3D size;
>   			coalesced++;
>   			break;
>   		} else if (lmb_addrs_overlap(base, size, rgnbase, rgnsize)) {
> @@ -293,9 +290,7 @@ static long lmb_add_region_flags(struct lmb_region *=
rgn, phys_addr_t base,
>   	/* Couldn't coalesce the LMB, so add it to the sorted table. */
>   	for (i =3D rgn->cnt-1; i >=3D 0; i--) {
>   		if (base < rgn->region[i].base) {
> -			rgn->region[i + 1].base =3D rgn->region[i].base;
> -			rgn->region[i + 1].size =3D rgn->region[i].size;
> -			rgn->region[i + 1].flags =3D rgn->region[i].flags;
> +			rgn->region[i + 1] =3D rgn->region[i];
>   		} else {
>   			rgn->region[i + 1].base =3D base;
>   			rgn->region[i + 1].size =3D size;
> @@ -535,10 +530,11 @@ int lmb_is_reserved_flags(struct lmb *lmb, phys_ad=
dr_t addr, int flags)
>   	int i;
>
>   	for (i =3D 0; i < lmb->reserved.cnt; i++) {
> -		phys_addr_t upper =3D lmb->reserved.region[i].base +
> -			lmb->reserved.region[i].size - 1;
> -		if ((addr >=3D lmb->reserved.region[i].base) && (addr <=3D upper))
> -			return (lmb->reserved.region[i].flags & flags) =3D=3D flags;
> +		struct lmb_property *prop =3D &lmb->reserved.region[i];
> +		phys_addr_t upper =3D prop->base + prop->size - 1;
> +
> +		if (addr >=3D prop->base && addr <=3D upper)
> +			return (prop->flags & flags) =3D=3D flags;
>   	}
>
>   	return 0;

