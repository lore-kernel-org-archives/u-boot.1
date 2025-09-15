Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E30C7CA101F
	for <u-boot@archiver.kernel.org>; Mon, 15 Sep 2025 05:06:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DABA83106;
	Mon, 15 Sep 2025 07:06:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aU2+xU3L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B6808317B; Mon, 15 Sep 2025 07:06:12 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3361F8309E
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 07:06:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58F5619S1417876;
 Mon, 15 Sep 2025 00:06:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757912761;
 bh=iVpNIRi51/SRGVCrDczRpAbLED+aeANIigJkNqG//hc=;
 h=Date:Subject:From:To:CC:References:In-Reply-To;
 b=aU2+xU3L8R1U/JyvKfBcQcsz4uN6ii5hnY/0sZsJONs4/w7zOExDPN84GgxJBl7sB
 SD52sWPcJFaECi4zJ/rRRInK0nRem+fhLc86iBgA4/pkAqiguJLdYpf/Iqc396GLW7
 DVqyCi+L4HgUYhBk8oYV9rWcQ60yVnv7L9v1xEJM=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58F561PC3703238
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 15 Sep 2025 00:06:01 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 15
 Sep 2025 00:05:59 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 15 Sep 2025 00:06:00 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58F55wOq3167046;
 Mon, 15 Sep 2025 00:05:59 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 15 Sep 2025 10:35:58 +0530
Message-ID: <DCT42CFXRKPZ.28R4SNL5IVDR3@ti.com>
Subject: Re: [PATCH -next v7 04/10] arm: armv8: invalidate dcache entries on
 dcache_enable
From: Anshul Dalal <anshuld@ti.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
CC: <d-gole@ti.com>, <b-padhi@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <nm@ti.com>, <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <afd@ti.com>, <bb@ti.com>, <u-kumar1@ti.com>,
 <devarsht@ti.com>, <ilias.apalodimas@linaro.org>,
 <u-boot@lists.denx.de>, <patrice.chotard@foss.st.com>,
 <patrick.delaunay@foss.st.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250912121618.1074054-1-anshuld@ti.com>
 <20250912121618.1074054-5-anshuld@ti.com>
 <f7cf5404-610b-420a-ae5a-a1d4cdb7ed4b@gmx.de>
In-Reply-To: <f7cf5404-610b-420a-ae5a-a1d4cdb7ed4b@gmx.de>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi Heinrich,

On Fri Sep 12, 2025 at 5:58 PM IST, Heinrich Schuchardt wrote:
> On 9/12/25 14:16, Anshul Dalal wrote:
>> In dcache_enable, currently the dcache entries are only invalidated when
>> the MMU is not enabled. This causes issues when dcache_enable is called
>> with the MMU already configured, in such cases the existing dcache
>> entries are not flushed which might result in un-expected behavior.
>>=20
>> This patch invalidates the cache entries on every call of dcache_enable
>> before enabling dcache (by setting CR_C). This makes dcache_enable
>> behave similar to icache_enable as well.
>>=20
>> Reviewed-by: Dhruva Gole <d-gole@ti.com>
>> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>> Tested-by: Wadim Egorov <w.egorov@phytec.de>
>> ---
>>   arch/arm/cpu/armv8/cache_v8.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8=
.c
>> index 1c1e33bec24..6e662395a83 100644
>> --- a/arch/arm/cpu/armv8/cache_v8.c
>> +++ b/arch/arm/cpu/armv8/cache_v8.c
>> @@ -830,16 +830,15 @@ void flush_dcache_range(unsigned long start, unsig=
ned long stop)
>>   void dcache_enable(void)
>>   {
>>   	/* The data cache is not active unless the mmu is enabled */
>> -	if (!(get_sctlr() & CR_M)) {
>> -		invalidate_dcache_all();
>> -		__asm_invalidate_tlb_all();
>> +	if (!mmu_status())
>
> You are changing the logic here without describing why in the commit=20
> message:
>
> mmu_status() returns zero if CONFIG_SYS_ICACHE_OFF=3Dy.
> Only for CONFIG_SYS_ICACHE_OFF=3Dn it calls get_sctlr().
>
> Please, check if the logic change is intended.
> Please, update the commit message.
>

The bheaviour should be the same for all combinations of ICACHE_OFF and
DCACHE_OFF except for when ICACHE_OFF=3Dy and DCACHE_OFF=3Dn, in such cases
there is the concern that mmu_setup will be called everytime on
dcache_enable after my patch.

This was not an intended change, thanks for bringing it to my attention.

I think we should drop the ICACHE_OFF=3Dy definition of mmu_setup which
was added in the commit 268f6ac1f95c ("arm64: Update memcpy_{from,
to}io() helpers"). And only keep the one that calls get_sctlr. If that's
off the table, I can respin the series without the call to mmu_status as
well.

CC+: Patrice Chotard, Patrick Delaunay (the authors of above commit)

Regards,
Anshul

>
>>   		mmu_setup();
>> -	}
>>  =20
>>   	/* Set up page tables only once (it is done also by mmu_setup()) */
>>   	if (!gd->arch.tlb_fillptr)
>>   		setup_all_pgtables();
>>  =20
>> +	invalidate_dcache_all();
>> +	__asm_invalidate_tlb_all();
>>   	set_sctlr(get_sctlr() | CR_C);
>>   }
>>  =20

