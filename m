Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA803E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 17:40:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3445789535;
	Fri,  6 Dec 2024 18:40:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WoEQe8Kz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C55D889622; Fri,  6 Dec 2024 18:40:07 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F31DA89471
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 18:40:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4B6He30t056403;
 Fri, 6 Dec 2024 11:40:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1733506803;
 bh=cGDaeymX2BDjdxlA8EflwIZxrl2q7lLn0lda+kkJs3w=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=WoEQe8Kz8m9b8peP3GKRk0PFqRgMoWCXVh+I2xKXraJ0TjGFZPepDNR0OWqYe1lBE
 RL7C8bkTccOM6RilV94rgtz/O96/fksiEF5MYNZL4HiSyRP492Nd0ZOrqhQdIt51kE
 oqWzHUwZ/wmwRZ58zzcp+HPzK+pKBdqpsSib54cg=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B6He2bX079570
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 6 Dec 2024 11:40:02 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 6
 Dec 2024 11:40:01 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 6 Dec 2024 11:40:01 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B6He13q088315;
 Fri, 6 Dec 2024 11:40:01 -0600
Date: Fri, 6 Dec 2024 11:40:01 -0600
From: Bryan Brattlof <bb@ti.com>
To: Wadim Egorov <w.egorov@phytec.de>
CC: Neha Malcom Francis <n-francis@ti.com>, Santhosh Kumar K <s-k6@ti.com>,
 <trini@konsulko.com>, <m-chawdhry@ti.com>, <nm@ti.com>,
 <u-kumar1@ti.com>, <vigneshr@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v4 2/8] ram: k3-ddrss: Add
 k3_ddrss_ddr_bank_base_size_calc() to solve 'calculations restricted to 32
 bits' issue
Message-ID: <20241206174001.3ekkbiicjojlqggz@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20241021044024.835846-1-s-k6@ti.com>
 <20241021044024.835846-3-s-k6@ti.com>
 <20241023143905.xbrqu6eabaer6wui@bryanbrattlof.com>
 <92a86113-f2b3-4b1a-942d-792aaf63a34d@ti.com>
 <20241024161958.hxbtvbeaf52zsblc@bryanbrattlof.com>
 <b7dc8b69-cb3d-433a-adef-56e54e8db275@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <b7dc8b69-cb3d-433a-adef-56e54e8db275@phytec.de>
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

On December  6, 2024 thus sayeth Wadim Egorov:
> Am 24.10.24 um 18:19 schrieb Bryan Brattlof:
> > On October 24, 2024 thus sayeth Neha Malcom Francis:
> > > Hi Bryan
> > > 
> > > On 23/10/24 20:09, Bryan Brattlof wrote:
> > > > On October 21, 2024 thus sayeth Santhosh Kumar K:
> > > > > As R5 is a 32 bit processor, the RAM banks' base and size calculation
> > > > > is restricted to 32 bits, which results in wrong values if bank's base
> > > > > is greater than 32 bits or bank's size is greater than or equal to 4GB.
> > > > > 
> > > > > So, add k3_ddrss_ddr_bank_base_size_calc() to get the base address and
> > > > > size of RAM's banks from the device tree memory node, and store in a
> > > > > 64 bit device private data which can be used for ECC reserved memory
> > > > > calculation, Setting ECC range and Fixing up bank size in device tree
> > > > > when ECC is enabled.
> > > > > 
> > > > > Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
> > > > > ---
> > > > >    drivers/ram/k3-ddrss/k3-ddrss.c | 72 ++++++++++++++++++++++++++-------
> > > > >    1 file changed, 57 insertions(+), 15 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
> > > > > index f2ab8cf2b49b..bd6783ebc2cd 100644
> > > > > --- a/drivers/ram/k3-ddrss/k3-ddrss.c
> > > > > +++ b/drivers/ram/k3-ddrss/k3-ddrss.c
> > > > > @@ -147,6 +147,9 @@ struct k3_ddrss_desc {
> > > > >    	struct k3_ddrss_ecc_region ecc_regions[K3_DDRSS_MAX_ECC_REGIONS];
> > > > >    	u64 ecc_reserved_space;
> > > > >    	bool ti_ecc_enabled;
> > > > > +	unsigned long long ddr_bank_base[CONFIG_NR_DRAM_BANKS];
> > > > > +	unsigned long long ddr_bank_size[CONFIG_NR_DRAM_BANKS];
> > > > > +	unsigned long long ddr_ram_size;
> > > > 
> > > > Should we use the u64 typedef here?
> > > > 
> > > > >    };
> > > > >    struct reginitdata {
> > > > > @@ -668,11 +671,54 @@ static void k3_ddrss_lpddr4_preload_full_mem(struct k3_ddrss_desc *ddrss,
> > > > >    	printf("ECC: priming DDR completed in %lu msec\n", get_timer(done));
> > > > >    }
> > > > > +static void k3_ddrss_ddr_bank_base_size_calc(struct k3_ddrss_desc *ddrss)
> > > > > +{
> > > > > +	int bank, na, ns, len, parent;
> > > > > +	const fdt32_t *ptr, *end;
> > > > > +
> > > > > +	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
> > > > > +		ddrss->ddr_bank_base[bank] = 0;
> > > > > +		ddrss->ddr_bank_size[bank] = 0;
> > > > > +	}
> > > > > +
> > > > > +	ofnode mem = ofnode_null();
> > > > > +
> > > > > +	do {
> > > > > +		mem = ofnode_by_prop_value(mem, "device_type", "memory", 7);
> > > > > +	} while (!ofnode_is_enabled(mem));
> > > > > +
> > > > > +	const void *fdt = ofnode_to_fdt(mem);
> > > > > +	int node = ofnode_to_offset(mem);
> > > > > +	const char *property = "reg";
> > > > > +
> > > > > +	parent = fdt_parent_offset(fdt, node);
> > > > > +	na = fdt_address_cells(fdt, parent);
> > > > > +	ns = fdt_size_cells(fdt, parent);
> > > > > +	ptr = fdt_getprop(fdt, node, property, &len);
> > > > > +	end = ptr + len / sizeof(*ptr);
> > > > > +
> > > > > +	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
> > > > > +		if (ptr + na + ns <= end) {
> > > > > +			if (CONFIG_IS_ENABLED(OF_TRANSLATE))
> > > > > +				ddrss->ddr_bank_base[bank] = fdt_translate_address(fdt, node, ptr);
> > > > > +			else
> > > > > +				ddrss->ddr_bank_base[bank] = fdtdec_get_number(ptr, na);
> > > > > +
> > > > > +			ddrss->ddr_bank_size[bank] = fdtdec_get_number(&ptr[na], ns);
> > > > > +		}
> > > > > +
> > > > > +		ptr += na + ns;
> > > > > +	}
> > > > > +
> > > > > +	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++)
> > > > > +		ddrss->ddr_ram_size += ddrss->ddr_bank_size[bank];
> > > > > +}
> > > > > +
> > > > >    static void k3_ddrss_lpddr4_ecc_calc_reserved_mem(struct k3_ddrss_desc *ddrss)
> > > > >    {
> > > > >    	fdtdec_setup_mem_size_base_lowest();
> > > > > -	ddrss->ecc_reserved_space = gd->ram_size;
> > > > > +	ddrss->ecc_reserved_space = ddrss->ddr_ram_size;
> > > > >    	do_div(ddrss->ecc_reserved_space, 9);
> > > > >    	/* Round to clean number */
> > > > > @@ -696,7 +742,7 @@ static void k3_ddrss_lpddr4_ecc_init(struct k3_ddrss_desc *ddrss)
> > > > >    	/* Preload the full memory with 0's using the BIST engine of
> > > > >    	 * the LPDDR4 controller.
> > > > >    	 */
> > > > > -	k3_ddrss_lpddr4_preload_full_mem(ddrss, gd->ram_size, 0);
> > > > > +	k3_ddrss_lpddr4_preload_full_mem(ddrss, ddrss->ddr_ram_size, 0);
> > > > >    	/* Clear Error Count Register */
> > > > >    	writel(0x1, base + DDRSS_ECC_1B_ERR_CNT_REG);
> > > > > @@ -741,6 +787,8 @@ static int k3_ddrss_probe(struct udevice *dev)
> > > > >    	k3_lpddr4_start(ddrss);
> > > > > +	k3_ddrss_ddr_bank_base_size_calc(ddrss);
> > > > > +
> > > > >    	if (ddrss->ti_ecc_enabled) {
> > > > >    		if (!ddrss->ddrss_ss_cfg) {
> > > > >    			printf("%s: ss_cfg is required if ecc is enabled but not provided.",
> > > > > @@ -761,30 +809,24 @@ static int k3_ddrss_probe(struct udevice *dev)
> > > > >    int k3_ddrss_ddr_fdt_fixup(struct udevice *dev, void *blob, struct bd_info *bd)
> > > > >    {
> > > > > -	struct k3_ddrss_desc *ddrss = dev_get_priv(dev);
> > > > > -	u64 start[CONFIG_NR_DRAM_BANKS];
> > > > > -	u64 size[CONFIG_NR_DRAM_BANKS];
> > > > >    	int bank;
> > > > > +	struct k3_ddrss_desc *ddrss = dev_get_priv(dev);
> > > > >    	if (ddrss->ecc_reserved_space == 0)
> > > > >    		return 0;
> > > > >    	for (bank = CONFIG_NR_DRAM_BANKS - 1; bank >= 0; bank--) {
> > > > > -		if (ddrss->ecc_reserved_space > bd->bi_dram[bank].size) {
> > > > > -			ddrss->ecc_reserved_space -= bd->bi_dram[bank].size;
> > > > > -			bd->bi_dram[bank].size = 0;
> > > > > +		if (ddrss->ecc_reserved_space > ddrss->ddr_bank_size[bank]) {
> > > > > +			ddrss->ecc_reserved_space -= ddrss->ddr_bank_size[bank];
> > > > > +			ddrss->ddr_bank_size[bank] = 0;
> > > > >    		} else {
> > > > > -			bd->bi_dram[bank].size -= ddrss->ecc_reserved_space;
> > > > > +			ddrss->ddr_bank_size[bank] -= ddrss->ecc_reserved_space;
> > > > >    			break;
> > > > >    		}
> > > > >    	}
> > > > > -	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
> > > > > -		start[bank] =  bd->bi_dram[bank].start;
> > > > > -		size[bank] = bd->bi_dram[bank].size;
> > > > > -	}
> > > > > -
> > > > > -	return fdt_fixup_memory_banks(blob, start, size, CONFIG_NR_DRAM_BANKS);
> > > > > +	return fdt_fixup_memory_banks(blob, ddrss->ddr_bank_base,
> > > > > +				      ddrss->ddr_bank_size, CONFIG_NR_DRAM_BANKS);
> > > > >    }
> > > > 
> > > > Have we looked into passing this information via the global data pointer
> > > > rather than fixing up the device tree on each boot phase?
> > > > 
> > > >       https://patchwork.ozlabs.org/project/uboot/patch/20180926215520.87168-23-sjg@chromium.org/
> > > > 
> > > > I don't see a clear path to pass GD from SPL to SPL but there is a TPL
> > > > to SPL which I think we should be able to copy.
> > > 
> > > But we also make use of this to fix up the device tree that passes onto
> > > kernel as well, I need to look into this patch though. But from a first
> > > glance looks like we will be able to pass on the information from SPL->SPL
> > > (with modification as you said) and SPL->U-Boot but U-Boot->Kernel would
> > > still require this function to be present.
> 
> Just came across this series again and noticed that this will be a bit
> tricky with boards detecting RAM at runtime.
> 
> Updating the memory node with detected RAM size prio to DDR driver probing
> should be no problem. But the next stages will need to update u-boot's and
> Linux memory nodes too. Unfortunately, we do not have the data at this stage
> which tells us how much space was reserved for ECC.
> 

I agree. We'll need to prototype this out real quick but my goal is to 
set the gd->ram_size in the R5 SPL that we can then pass GD to each boot 
phase. What I haven't looked into is what other drivers will break :)

> It would be best to do the memory setup for GD or memory node once and have
> other stages reuse it.
> 
> Right now I have no idea how my board should be aware of the reserved ecc
> memory in u-boot. Any suggestions?
> 

I don't have a solution to this either. My only thought would be to look 
at the controller to see if it has ECC enabled and take 8/9s of the 
total capacity.

I'm not a huge fan of that as well as it's kinda opaque. It's much more 
clean to let the R5 SPL do this and pass the info along all the way to 
the kernel.

~Bryan

