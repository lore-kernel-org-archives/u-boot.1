Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD1DCCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 12:50:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CFF583710;
	Fri, 17 Oct 2025 14:50:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bxeFLkZU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB71783829; Fri, 17 Oct 2025 14:50:30 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 843A483655
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 14:50:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59HCoN1o2364454;
 Fri, 17 Oct 2025 07:50:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1760705423;
 bh=GmCHFUXVwtJtP2fvN51fH+JhMvGRpVZRFL3tGSK9jB8=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=bxeFLkZU7/6ommwQsaPUWVpgnXW9xldtIxW72meuAydiHMU0BZHWbdT60kxne2UmZ
 IecrqfM9vSb++5gObdycCF9OfQkci/HjzjOJ8cTIWSnyxLUnXaCYrSk1kaSbRaLngS
 XYt7kaBAkYIUiMMOnPQjoED3ROop1wVj0LNHj8YM=
Received: from DFLE202.ent.ti.com (dfle202.ent.ti.com [10.64.6.60])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59HCoNTf2414343
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 17 Oct 2025 07:50:23 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 17 Oct
 2025 07:50:22 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 17 Oct 2025 07:50:22 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59HCoLBw1312303;
 Fri, 17 Oct 2025 07:50:22 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 17 Oct 2025 18:20:21 +0530
Message-ID: <DDKLZC5V72FZ.2GAUEUKTYIS8N@ti.com>
From: Anshul Dalal <anshuld@ti.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Anshul Dalal
 <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, <d-gole@ti.com>, <b-padhi@ti.com>,
 <vigneshr@ti.com>, <trini@konsulko.com>, <nm@ti.com>,
 <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <afd@ti.com>, <bb@ti.com>, <u-kumar1@ti.com>,
 <devarsht@ti.com>, <xypron.glpk@gmx.de>
Subject: Re: [PATCH v10 07/11] arm: armv8: mmu: add mmu_unmap_reserved_mem
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251010134424.3835757-1-anshuld@ti.com>
 <20251010134424.3835757-8-anshuld@ti.com>
 <CAC_iWjJSdG6Z-6HtKt3VaJPT8A4HZO3UxbfmuFJ4RCY7jvJPvg@mail.gmail.com>
In-Reply-To: <CAC_iWjJSdG6Z-6HtKt3VaJPT8A4HZO3UxbfmuFJ4RCY7jvJPvg@mail.gmail.com>
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

On Fri Oct 17, 2025 at 6:04 PM IST, Ilias Apalodimas wrote:
> Hi Anshul,
>
> On Fri, 10 Oct 2025 at 16:44, Anshul Dalal <anshuld@ti.com> wrote:
>>
>> For armv8, U-Boot uses a static map defined as 'mem_map' for configuring
>> the MMU's page tables, done by mmu_setup.
>>
>> Though this works well for simpler platforms, it makes creating runtime
>> carveouts by modifying the static array at runtime exceedingly complex
>> like in mach-snapdragon/board.c.
>>
>> Creation of such carveouts are much better handled by APIs such as
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
>>  arch/arm/cpu/armv8/cache_v8.c    | 26 ++++++++++++++++++++++++++
>>  arch/arm/include/asm/armv8/mmu.h |  8 ++++++++
>>  2 files changed, 34 insertions(+)
>>
>> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8=
.c
>> index 9b3c37dae82..f2e006a98ab 100644
>> --- a/arch/arm/cpu/armv8/cache_v8.c
>> +++ b/arch/arm/cpu/armv8/cache_v8.c
>> @@ -86,6 +86,32 @@ int mem_map_from_dram_banks(unsigned int index, unsig=
ned int len, u64 attrs)
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
>> +
>> +       if (!fdtdec_get_bool(fdt, ret, "no-map"))
>> +               return -EINVAL;
>> +
>
> Apologies I wasn't clear on my last mail. Can we do this check
> conditional please? IOW add a "check_nomap" in the function args

Will add that in the next revision, thanks for the review!

Anshul

>
>> +       addr =3D fdtdec_get_addr_size(fdt, ret, "reg", &size);
>> +       if (addr =3D=3D FDT_ADDR_T_NONE)
>> +               return -1;
>> +
>> +       mmu_change_region_attr_nobreak(addr, size, PTE_TYPE_FAULT);
>> +
>> +       return 0;
>> +}
>> +
>>  u64 get_tcr(u64 *pips, u64 *pva_bits)
>>  {
>>         int el =3D get_effective_el();
>> diff --git a/arch/arm/include/asm/armv8/mmu.h b/arch/arm/include/asm/arm=
v8/mmu.h
>> index 6e7a3366844..ca402c7d74c 100644
>> --- a/arch/arm/include/asm/armv8/mmu.h
>> +++ b/arch/arm/include/asm/armv8/mmu.h
>> @@ -207,6 +207,14 @@ void setup_pgtables(void);
>>   */
>>  int mem_map_from_dram_banks(unsigned int index, unsigned int len, u64 a=
ttrs);
>>
>> +/**
>> + * mmu_unmap_reserved_mem() - Unmaps a reserved-memory node as PTE_TYPE=
_FAULT
>> + * once MMU is configured by mmu_setup.
>> + *
>> + * @name: The name of the node under "/reserved-memory/" path
>> + */
>> +int mmu_unmap_reserved_mem(const char *name);
>> +
>>  u64 get_tcr(u64 *pips, u64 *pva_bits);
>>
>>  /**
>> --
>> 2.51.0
>>
>
> Other than that
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

