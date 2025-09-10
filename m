Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F0A1CA0FED
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 12:05:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B6858318E;
	Wed, 10 Sep 2025 14:05:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Oz1gKjt5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F16AA831D5; Wed, 10 Sep 2025 14:05:17 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5470C830B4
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 14:05:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58AC59mN053927;
 Wed, 10 Sep 2025 07:05:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757505909;
 bh=o0M0/LHmVyQzRnm/x8MGwtPWzALqrOQRlb2/FiArUEk=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=Oz1gKjt5kTbGSKrdy4XEzW+69COgi4QD8+16oz7KVa4UWxEe0v8m53kHpiK5MSskn
 7mZ+iRLK9VBK0nQXu9NfSjF4j4CxLX+vd33PRwlPNEhY4XLVZJvgORtOqPlWKVbyA2
 9vpRodOUpAELbDsLUxN3Mna85Da4fuprHJokoShU=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58AC59B21131362
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 10 Sep 2025 07:05:09 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 10
 Sep 2025 07:05:09 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 10 Sep 2025 07:05:09 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58AC57Gm145600;
 Wed, 10 Sep 2025 07:05:08 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 10 Sep 2025 17:35:07 +0530
Message-ID: <DCP3UJR6WC44.CKQ79WHIG19X@ti.com>
CC: <u-boot@lists.denx.de>, <d-gole@ti.com>, <b-padhi@ti.com>,
 <vigneshr@ti.com>, <trini@konsulko.com>, <nm@ti.com>,
 <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <a-nandan@ti.com>, <afd@ti.com>,
 <u-kumar1@ti.com>, <devarsht@ti.com>, <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH -next v6 10/10] mach-k3: add carveouts for TFA and optee
From: Anshul Dalal <anshuld@ti.com>
To: Bryan Brattlof <bb@ti.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250905081902.489345-1-anshuld@ti.com>
 <20250905081902.489345-11-anshuld@ti.com>
 <20250910111434.xz57ywvmx6kc7ku5@bryanbrattlof.com>
In-Reply-To: <20250910111434.xz57ywvmx6kc7ku5@bryanbrattlof.com>
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

On Wed Sep 10, 2025 at 4:44 PM IST, Bryan Brattlof wrote:
> On September  5, 2025 thus sayeth Anshul Dalal:
>> K3 platforms have reserved memory regions for TFA and OPTEE which should
>> be unmapped for U-Boot.
>>=20
>> Therefore this patch adds the necessary fdt fixups to properly set the
>> load address for TFA/OPTEE and unmaps both by mmu_unmap_reserved_mem.
>>=20
>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>> ---
>>  arch/arm/mach-k3/common.c | 26 ++++++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>=20
>> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
>> index 9c2fe92cf25..71fc7d31abe 100644
>> --- a/arch/arm/mach-k3/common.c
>> +++ b/arch/arm/mach-k3/common.c
>> @@ -31,6 +31,7 @@
>>  #include <dm/uclass-internal.h>
>>  #include <dm/device-internal.h>
>>  #include <asm/armv8/mmu.h>
>> +#include <mach/k3-common-fdt.h>
>>  #include <mach/k3-ddr.h>
>> =20
>>  #define PROC_BOOT_CTRL_FLAG_R5_CORE_HALT	0x00000001
>> @@ -263,6 +264,7 @@ void board_prep_linux(struct bootm_headers *images)
>> =20
>>  void enable_caches(void)
>>  {
>> +	void *fdt =3D (void *)gd->fdt_blob;
>>  	int ret;
>> =20
>>  	ret =3D mem_map_fix_dram_banks(K3_MEM_MAP_FIRST_BANK_IDX, K3_MEM_MAP_L=
EN,
>> @@ -273,6 +275,30 @@ void enable_caches(void)
>> =20
>>  	mmu_setup();
>> =20
>> +	if (CONFIG_K3_ATF_LOAD_ADDR >=3D CFG_SYS_SDRAM_BASE) {
>> +		ret =3D fdt_fixup_reserved(fdt, "tfa", CONFIG_K3_ATF_LOAD_ADDR,
>> +					 0x80000);
>> +		if (ret)
>> +			debug("%s: Failed to perform tfa fixups (%s)\n",
>> +			      __func__, fdt_strerror(ret));
>> +		ret =3D mmu_unmap_reserved_mem("tfa");
>> +		if (ret)
>> +			debug("%s: Failed to unmap tfa rsvd mem (%s)\n",
>> +			      __func__, fdt_strerror(ret));
>> +	}
>> +
>> +	if (CONFIG_K3_OPTEE_LOAD_ADDR >=3D CFG_SYS_SDRAM_BASE) {
>> +		ret =3D fdt_fixup_reserved(fdt, "optee",
>> +					 CONFIG_K3_OPTEE_LOAD_ADDR, 0x1800000);
>
> We will most likely need to move these sizes into Kconfig. The fact they=
=20
> have remained the same is purely an artifact from us not changing
> anything nor developing much on OP-TEE for most of K3's lifetime.
>
> For future chips BL1 and OP-TEE will likely need to grow.

Yeah, we would probably need to update the fdt_fixup_reserved API as
well which currently just ignores the size we provide if one already
exists in the reserved-memory node.

Regards,
Anshul
