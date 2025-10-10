Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B0ACCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 12:42:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DA1283EAC;
	Fri, 10 Oct 2025 14:42:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jSQkcgWY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2FB383F6A; Fri, 10 Oct 2025 14:42:42 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF8DE83B8B
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 14:42:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59ACgX4F246868;
 Fri, 10 Oct 2025 07:42:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1760100153;
 bh=wuAm/P9REIOqbDw8phQ7AakGUUBaPCU87Kgp5D3SNqA=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=jSQkcgWYaqFF0DyLFr8HbbJg2LpDBJd5bbF2F6txwoa0d9hKG5H9arMOTA5wXeHdw
 rDDKtK+oOpCYZiTVLhsRpZ0XNX3wGBuBvk16mNjiSM8kpQe729bC1TN7DuUvcK7y63
 j3SdX0UsX/sf+CTrG+UnYJ1pSOCGQFoTocfEofbg=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59ACgXHL1677392
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 10 Oct 2025 07:42:33 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 10
 Oct 2025 07:42:33 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 10 Oct 2025 07:42:33 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59ACgVVB1651415;
 Fri, 10 Oct 2025 07:42:32 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 10 Oct 2025 18:12:31 +0530
Message-ID: <DDENFJ22P0WN.25YBPRDCJ5C89@ti.com>
CC: <u-boot@lists.denx.de>, <d-gole@ti.com>, <b-padhi@ti.com>,
 <vigneshr@ti.com>, <trini@konsulko.com>, <nm@ti.com>,
 <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <afd@ti.com>, <bb@ti.com>, <u-kumar1@ti.com>,
 <devarsht@ti.com>, <xypron.glpk@gmx.de>
Subject: Re: [PATCH v9 07/11] arm: armv8: mmu: add mmu_unmap_reserved_mem
From: Anshul Dalal <anshuld@ti.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Anshul Dalal
 <anshuld@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251010055340.2574743-1-anshuld@ti.com>
 <20251010055340.2574743-8-anshuld@ti.com>
 <CAC_iWjJhBWRirbMjwAvdih2tmFH_PxikzFJfAK-txYQuGmKDnA@mail.gmail.com>
In-Reply-To: <CAC_iWjJhBWRirbMjwAvdih2tmFH_PxikzFJfAK-txYQuGmKDnA@mail.gmail.com>
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

On Fri Oct 10, 2025 at 5:38 PM IST, Ilias Apalodimas wrote:
> Hi Anshul,
>
> On Fri, 10 Oct 2025 at 08:54, Anshul Dalal <anshuld@ti.com> wrote:
>>
>> For armv8, U-Boot uses a static map defined as 'mem_map' for configuring
>> the MMU's page tables, done by mmu_setup.
>>
>> Though this works well for simpler platforms, it makes creating runtime
>> carveouts by modifying the static array at runtime exceedingly complex
>> like in mach-snapdragon/board.c.
>>
>> Creation of such carveouts is much better handled by APIs such as
>> mmu_change_region_attr once the page tables are configured. Usually such
>> carveouts are configured via the device-tree's reserved-memory node
>> which provides the address and size for the carveout.
>>
>> Therefore this patch adds mmu_unmap_reserved_mem which acts as a wrapper
>> over mmu_change_region_attr, helping unmap a reserved-memory region.
>>
>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>> Tested-by: Wadim Egorov <w.egorov@phytec.de>
>> ---
>>  arch/arm/cpu/armv8/cache_v8.c    | 23 +++++++++++++++++++++++
>>  arch/arm/include/asm/armv8/mmu.h |  9 +++++++++
>>  2 files changed, 32 insertions(+)
>>
>> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8=
.c
>> index cdf17d5f396..74814601483 100644
>> --- a/arch/arm/cpu/armv8/cache_v8.c
>> +++ b/arch/arm/cpu/armv8/cache_v8.c
>> @@ -86,6 +86,29 @@ int mem_map_fix_dram_banks(unsigned int index, unsign=
ed int len, u64 attrs)
>>
>>         return 0;
>>  }
>> +
>> +int mmu_unmap_reserved_mem(const char *name)
>> +{
>> +       void *fdt =3D (void *)gd->fdt_blob;
>> +       char node_path[128];
>> +       fdt_addr_t addr;
>> +       fdt_size_t size;
>> +       int ret;
>> +
>> +       snprintf(node_path, sizeof(node_path), "/reserved-memory/%s", na=
me);
>> +       ret =3D fdt_path_offset(fdt, node_path);
>> +       if (ret < 0)
>> +               return ret;
>
> The DT spec defines a /reserved/ no-map; option for reserved memory
> that should not participate in the memory map.
> Is there any reason why we unconditionally unmap reserved memory and
> not the no-map one only?
>

I was expecting the caller to only try to unmap regions that already had
no-map but we can add a check here too.

Regards,
Anshul
