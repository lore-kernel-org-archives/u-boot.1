Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D55CCD185
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 13:41:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC13A83D9C;
	Thu,  9 Oct 2025 15:41:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xim6JwTg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F0AF83E2B; Thu,  9 Oct 2025 15:41:28 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEC0D83D8B
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 15:41:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 599DfISw470307;
 Thu, 9 Oct 2025 08:41:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1760017278;
 bh=5qteyt4CHk+iBKD+M206Si4+rL+revcQLSnAjtRRlSM=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=xim6JwTgArK3YZSjSw1NX9C9pmC5oQDMT4scpmtUhlt0AvQOF96H+FsNl1e4kxI76
 cID67hG1qTrqOOqOWVn+UTAQ+d2ra9kJryTigSAy2KOe8Ky0t3IscM2qGncT/+n+rk
 llNsOOwlLcXCk53Xo7lU+CXJOd6Qbcs1vZiHIuBU=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 599DfIlJ1467374
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 9 Oct 2025 08:41:18 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 9
 Oct 2025 08:41:17 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Oct 2025 08:41:17 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 599DfGs4095886;
 Thu, 9 Oct 2025 08:41:17 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 9 Oct 2025 19:11:15 +0530
Message-ID: <DDDU1YJHMWCT.2WOBI5DIYDCG1@ti.com>
From: Anshul Dalal <anshuld@ti.com>
To: Bryan Brattlof <bb@ti.com>, Anshul Dalal <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, <d-gole@ti.com>, <b-padhi@ti.com>,
 <vigneshr@ti.com>, <trini@konsulko.com>, <nm@ti.com>,
 <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <afd@ti.com>, <u-kumar1@ti.com>,
 <devarsht@ti.com>, <ilias.apalodimas@linaro.org>, <xypron.glpk@gmx.de>
Subject: Re: [PATCH -next v8 11/11] arm: mach-k3: reserve space for page
 table entries
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251006082852.4008937-1-anshuld@ti.com>
 <20251006082852.4008937-12-anshuld@ti.com>
 <20251008150303.zzf4vxshdap3pdpb@bryanbrattlof.com>
In-Reply-To: <20251008150303.zzf4vxshdap3pdpb@bryanbrattlof.com>
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

On Wed Oct 8, 2025 at 8:33 PM IST, Bryan Brattlof wrote:
> On October  6, 2025 thus sayeth Anshul Dalal:
>> With the memory map configuration being done dynamically, reserve extra
>> space during U-Boot relocation to ensure we have enough for the fixups.
>>=20
>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>> ---
>>  arch/arm/mach-k3/arm64/arm64-mmu.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>=20
>> diff --git a/arch/arm/mach-k3/arm64/arm64-mmu.c b/arch/arm/mach-k3/arm64=
/arm64-mmu.c
>> index 479451452a2..f999af143fb 100644
>> --- a/arch/arm/mach-k3/arm64/arm64-mmu.c
>> +++ b/arch/arm/mach-k3/arm64/arm64-mmu.c
>> @@ -41,3 +41,8 @@ struct mm_region k3_mem_map[K3_MEM_MAP_LEN] =3D {
>>  };
>> =20
>>  struct mm_region *mem_map =3D k3_mem_map;
>> +
>> +u64 get_page_table_size(void)
>> +{
>> +	return SZ_128K;
>> +}
>
> How are we calculating this size? With 2^39 addresses this should bring=
=20
> us into the MBs of TLB data.=20
>
> I see we limit U-Boot to 512 entries, but that doesn't match this either
>

Of the current K3 devices, the largest reported size for the fixed up
memory maps was ~32KiB with AM62 SiP (TFA@80000000 and TEE@80080000).

With the carveouts not aligned to 2MiB, maximum size I saw was ~64KiB.
So with an added 2x margin of safety, I arrived at 128KiB ;)

This is enough for all current K3 devices and we can always increase it
later if need be. As the panic we would get is pretty self explanatory:

  Insufficient RAM for page table: 0x3000 > 0x2000. Please increase the siz=
e in get_page_table_size()

Regards,
Anshul
