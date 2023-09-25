Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48753CE7A81
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 04:10:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2846186B36;
	Mon, 25 Sep 2023 06:10:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oX+mjSam";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69B1086B3F; Mon, 25 Sep 2023 06:10:16 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14D0D86A88
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 06:10:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38P4A05K105076;
 Sun, 24 Sep 2023 23:10:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695615000;
 bh=QaJteAyQ/8Yb8khRCZ1sZZd8TfuS7bQTk7+oyMVbbsQ=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=oX+mjSamQ5Bb9GN5OD7U+bJwsOATkOpEloh2qs1L2C+/os4fFK/IJ7me6fENQlzSl
 2bbviDoIHBGCex4JwUihCjS2vN+sMftyWhbAKpHbRCpv1UafnLuVNFzme2yYqTCfbd
 fXi/vZyXwK9POTrlS7DKesSfETSBd74cVd98oRz8=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38P4A0MG011392
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 24 Sep 2023 23:10:00 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 24
 Sep 2023 23:09:59 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 24 Sep 2023 23:09:59 -0500
Received: from [172.24.20.156] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38P49uRE047936;
 Sun, 24 Sep 2023 23:09:57 -0500
Message-ID: <7edb7998-66a4-293e-9cfb-ebc142387684@ti.com>
Date: Mon, 25 Sep 2023 09:39:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] lmb: remove overlapping region with next range
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, <nm@ti.com>, <vigneshr@ti.com>, 
 <patrick.delaunay@foss.st.com>, <sjoerd@collabora.com>
CC: <u-boot@lists.denx.de>, <michal.simek@amd.com>, Suman Anna <s-anna@ti.com>
References: <20230924111832.3741245-1-u-kumar1@ti.com>
 <57F0DE54-C8BF-4B48-9075-2D267DBA4924@gmx.de>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <57F0DE54-C8BF-4B48-9075-2D267DBA4924@gmx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 9/24/2023 7:21 PM, Heinrich Schuchardt wrote:
>
> Am 24. September 2023 13:18:32 MESZ schrieb Udit Kumar <u-kumar1@ti.com>:
>> In case of new memory range to be added is coalesced
>> with any already added non last lmb region.
>>
>> And there is possibility that, then region in which new memory
>> range added is not adjacent to next region. But have some
>> sections are overlapping.
>>
>> So along with adjacency check with next lmb region,
>> check for overlap should be done.
>>
>> In case overlap  is found, adjust and merge these two lmb
>> region into one.
>>
>> Reported-by: Suman Anna <s-anna@ti.com>
>> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
>> ---
>> logs
>> https://gist.github.com/uditkumarti/5d08c34442235ad270cfa863792ebcdc
>> seqeunce : line 1 to 13
>> without fix : line 96-100
>> with fix : line 199-202
>>
>> lib/lmb.c | 37 +++++++++++++++++++++++++++++++++----
>> 1 file changed, 33 insertions(+), 4 deletions(-)
>>
>> diff --git a/lib/lmb.c b/lib/lmb.c
>> index b2c233edb6..2580d01d90 100644
>> --- a/lib/lmb.c
>> +++ b/lib/lmb.c
>> @@ -74,6 +74,16 @@ static long lmb_addrs_adjacent(phys_addr_t base1, phys_size_t size1,
>> 	return 0;
>> }
>>
>> +static long lmb_regions_overlap(struct lmb_region *rgn, unsigned long r1,
>> +				unsigned long r2)
>> +{
>> +	phys_addr_t base1 = rgn->region[r1].base;
>> +	phys_size_t size1 = rgn->region[r1].size;
>> +	phys_addr_t base2 = rgn->region[r2].base;
>> +	phys_size_t size2 = rgn->region[r2].size;
>> +
>> +	return lmb_addrs_overlap(base1, size1, base2, size2);
>> +}
>> static long lmb_regions_adjacent(struct lmb_region *rgn, unsigned long r1,
>> 				 unsigned long r2)
>> {
>> @@ -81,7 +91,6 @@ static long lmb_regions_adjacent(struct lmb_region *rgn, unsigned long r1,
>> 	phys_size_t size1 = rgn->region[r1].size;
>> 	phys_addr_t base2 = rgn->region[r2].base;
>> 	phys_size_t size2 = rgn->region[r2].size;
>> -
>> 	return lmb_addrs_adjacent(base1, size1, base2, size2);
>> }
>>
>> @@ -105,6 +114,23 @@ static void lmb_coalesce_regions(struct lmb_region *rgn, unsigned long r1,
>> 	lmb_remove_region(rgn, r2);
>> }
>>
>> +/*Assmptuon : base addr of region 1 < base addr of region 2*/
> Assumption


Thanks Heinrich  will fix this typo in v2.

Let me wait for other review feedback as well before proceeding for v2.


> Regards Heinrich
>
>> +static void lmb_fix_over_lap_regions(struct lmb_region *rgn, unsigned long r1,
>> +				     unsigned long r2)
>> +{
>> +	phys_addr_t base1 = rgn->region[r1].base;
>> +	phys_size_t size1 = rgn->region[r1].size;
>> +	phys_addr_t base2 = rgn->region[r2].base;
>> +	phys_size_t size2 = rgn->region[r2].size;
>> +
>> +	if (base1 + size1 > base2 + size2) {
>> +		printf("This will not be a case any time\n");
>> +		return;
>> +	}
>> +	rgn->region[r1].size = base2 + size2 - base1;
>> +	lmb_remove_region(rgn, r2);
>> +}
>> +
>> void lmb_init(struct lmb *lmb)
>> {
>> #if IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
>> @@ -249,7 +275,6 @@ static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
>> 		phys_size_t rgnflags = rgn->region[i].flags;
>> 		phys_addr_t end = base + size - 1;
>> 		phys_addr_t rgnend = rgnbase + rgnsize - 1;
>> -
>> 		if (rgnbase <= base && end <= rgnend) {
>> 			if (flags == rgnflags)
>> 				/* Already have this region, so we're done */
>> @@ -278,10 +303,14 @@ static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
>> 		}
>> 	}
>>
>> -	if ((i < rgn->cnt - 1) && lmb_regions_adjacent(rgn, i, i + 1)) {
>> -		if (rgn->region[i].flags == rgn->region[i + 1].flags) {
>> +	if (i < rgn->cnt - 1 && rgn->region[i].flags == rgn->region[i + 1].flags)  {
>> +		if (lmb_regions_adjacent(rgn, i, i + 1)) {
>> 			lmb_coalesce_regions(rgn, i, i + 1);
>> 			coalesced++;
>> +		} else if (lmb_regions_overlap(rgn, i, i + 1)) {
>> +			/* fix overlapping area */
>> +			lmb_fix_over_lap_regions(rgn, i, i + 1);
>> +			coalesced++;
>> 		}
>> 	}
>>
