Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD696CA0EDC
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 14:12:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26C4B8393F;
	Thu, 14 Aug 2025 16:12:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WaqEirgZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECB6683979; Thu, 14 Aug 2025 16:12:17 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A708983939
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 16:12:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57EEC8fA1895039;
 Thu, 14 Aug 2025 09:12:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1755180728;
 bh=JxMaVN2a3EiafSVp3GReoZaVwwBjwlByAR0IH3U6AHU=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=WaqEirgZb2dvoRh7HN8e6ZRgFsQkqlYXNUQzAm8ecJdCI3F6yd2wAAIkOVfeFLLce
 F451r+6LPQ5acnk2peBUNjFiaaZuqeS72ofR692wo29GGYdIO66zwZBuW2lp1TkLF+
 WOFROAkQdXsKoV6XMxDucsX1whCoAUaDErRB6JZ8=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57EEC8XH1200637
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 14 Aug 2025 09:12:08 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 14
 Aug 2025 09:12:07 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 14 Aug 2025 09:12:07 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57EEC58s3719930;
 Thu, 14 Aug 2025 09:12:06 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 14 Aug 2025 19:41:03 +0530
Message-ID: <DC27M9DO6JP0.2ZG4RG8ZUIRMP@ti.com>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <nm@ti.com>,
 <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <a-nandan@ti.com>, <afd@ti.com>, <bb@ti.com>,
 <u-kumar1@ti.com>, <devarsht@ti.com>
Subject: Re: [PATCH v5 2/4] mach-k3: add runtime configuration of MMU table
From: Anshul Dalal <anshuld@ti.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250703133533.104758-1-anshuld@ti.com>
 <20250703133533.104758-3-anshuld@ti.com>
 <DB63KZ89ZWMY.3KGIHVA42RGM4@linaro.org>
In-Reply-To: <DB63KZ89ZWMY.3KGIHVA42RGM4@linaro.org>
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

On Tue Jul 8, 2025 at 1:45 AM IST, Ilias Apalodimas wrote:
> Hi Anshul,
>
> On Thu Jul 3, 2025 at 4:35 PM EEST, Anshul Dalal wrote:
>> k3_mem_map is used by u-boot to configure the MMU on k3 devices but
>> currently it's a static array which does not scale for platforms with
>> non-standard load addresses for ATF and OP-TEE. Additionally on systems
>> with limited DRAM, more space is mapped than is available on the device.
>>
>> Therefore this patch adds a new k3_mem_map_init function which can
>> be called from dram_init to configure the table at runtime where we
>> can query the required DDR information and reserved regions from the
>> device-tree.
>
> Is this a problem for k3 only? This kind of code should be aimed at the m=
mu
> support and improving armv8 overall, not specific platforms
>

In K3 we try to support a wide array of SoCs with a single memory map.
Since the requirements are similar across all K3 devices i.e:

1. Map all DDR banks
2. Create carveouts for ATF and OPTEE
3. At SPL stage, map framebuffer region for VIDEO enabled devices

Of the 3 here, #1 and #3 could be useful for ARMv8 overall but #2 is
quite specific to the platform's boot flow.

As I see it, since most of the existing platforms are using a static map
and thus won't benefit from a generic way to handle #1 and #3. The few
that do have runtime fixups for the memory map, only seem to have #1 in
common (imx and renesas).

>>
>> A dummy implementation is also added in r5/common.c to allow the build
>> to pass without masking each call to k3_mem_map_init behind an ifdef
>> CONFIG_ARM64.
>>
>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>
> [...]
>
>> +
>> +static void k3_mmu_add_cachable_entry(u64 start, u64 end, unsigned int =
*map_idx)
>> +{
>> +	if (start >=3D end)
>> +		return;
>> +
>> +	k3_mem_map[*map_idx].virt =3D start,
>> +	k3_mem_map[*map_idx].phys =3D start,
>> +	k3_mem_map[*map_idx].size =3D end - start,
>> +	k3_mem_map[*map_idx].attrs =3D PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>> +				     PTE_BLOCK_INNER_SHARE;
>> +	(*map_idx)++;
>> +}
>
> Doesn't this need a break-before-make?
> Also why does it have to be a board specific function? Is there something=
 mmu_change_region_attr()
> doesn't do ?
>

Oh, I wasn't aware of that API, I'll update in my next revision.

Thanks for the review,
Anshul
