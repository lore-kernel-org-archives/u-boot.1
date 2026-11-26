Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C44C606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 12:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pWi5bbxz;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ALYZbEjj
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E8560409BC;
	Thu, 26 Nov 2026 12:56:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OllHrVn3nedF; Thu, 26 Nov 2026 12:56:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BD41F40935
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795697795;
	b=Rw9g+PKrL+aW7z2DAVJaW4fc70OQwl9sJLVmlIkf3/11L19av6EDa7KK+1IfrQdNa+IE
	 +W4B5dAd+IzvBoK+gKzwAxBkrrGbmAOIYMsVfSOo89IYWpaiMBNUsB8iqK4KSjfZq5G1h
	 EHENlB+/BWg+9rQpZBCSNPU8b/nA0AcT18sZe7zOHDct36weavqRrQdjrrqDmZaRp3GF8
	 2qnPWiR7kzLNGLFj7fekiuJYezmdOj8IeUlVJS++yuoEQoEtEaNUwkqBWYeyTIm/Nl099
	 tDkN1jyToTWtNkbma4aMWNufB7zYaLBXin+ElfNaiT6kx+N0zBRo7fC9Bv5Thxl343w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795697795;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1Bg1X06oVehofDxiMkJHDJo7+RJ1qxksFwKuPk8z02A=;
	b=ADhukVf6T9M1x/1JutfZ3EeIv38fp8NtbhXGL/w0cOuVM/aMSPIUJTrRVbFjKYUVHrmg
	 oVNSeS2WtsgbW2Y9HSRueCml2vZ3S5jmq32/b+gwRGMniRlIDSouUuDWKnE8nGXi5u8gq
	 W7uz+8bI72tcMfh9NX4G9Eoo28jznQ5JkSwblQp3xV0xlQdOaT8t/630WChgBIB1AIXWT
	 0ABetw4H+Vgl5h3mi7mTn2TT9Vz0K6BPGziSFTlTIE4y7dObjPDbo31Z5QH11KcyOUjDb
	 rsotDjClhYjJmX+T+YLflibz5QW8Yu5TDPri4WBaEPEKL4AxvOBHdU55JEHC3GPWxTw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ALYZbEjj;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795697795;
	bh=1Bg1X06oVehofDxiMkJHDJo7+RJ1qxksFwKuPk8z02A=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pWi5bbxzlSwGq3UfnNno7I30SjtkALCToguKgP8iCtwHBL6eLS93VN7m+drdBS2RK
	 aBQna8+MFtY0jQNWyW5c6KCf7PpemD9ghZUG1y3NSUtl55unhlNAbSQ64Ir5IMYn86
	 PugiMc3EWiocRFRakiagV8dI3+Epbfx9FGID4QfGhiZdxs22R2nz4Tvm9OOjDf3Jwa
	 Ga+YNotcoWHPYOK06xNU7N0KwA6ZxQuZhUMbIO4LdascdYspylJ/wnEp9Sl63g8Vz5
	 F2oaSrbKutoAXuCNsIxGJT9F3ZP2ulRYAYaynugfKkpGWWpDFFlls6pgVBOblKvqId
	 K34Q8xXeBMy/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD41F40935;
	Thu, 26 Nov 2026 12:56:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 57CC832D
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:56:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3E46440935
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:56:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3rXWwCVnyMby for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 12:56:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 34D8240854
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sumit.garg@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=ALYZbEjj
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 34D8240854
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:56:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8BBF040C3B;
 Thu, 26 Nov 2026 12:56:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7333A1F000CF;
 Thu, 26 Nov 2026 12:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795697792;
 bh=1Bg1X06oVehofDxiMkJHDJo7+RJ1qxksFwKuPk8z02A=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=ALYZbEjj/+7op+dy7SGCZiWDLdGhRJzX3vF9JNuS2DIAqQ0TzrLrMiueuZ8sOGv7N
 qonmUAwY4dE8sYcH8ZMtmDmOtlUmYX29FcsvgGOli+6IktflWrh0+PIzs5+YaFrHbj
 KJN6Ss/osqAZrQSzXWJbrhIHjZKFv/nA08jGOEAmkYNYlhHi0FwxRlTz5jCK9PNrbe
 7sCNJUGI0TG4M6AdLsfg7V5f0NFj1Shcj4lbvMn/fwz9cs6kTEvQxnnClLNem1z91C
 bGDNP+uVcpwW6b84V5AGRRKl4agMUGYHDqr5xwtTSo7hXSkPoLuyCWdc/sn8n70CtY
 Xp3PBMkfwjMDA==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] armv8: mmu: sync emergency page table attribute updates
From: Sumit Garg <sumit.garg@kernel.org>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, trini@konsulko.com, 
 casey.connolly@linaro.org, u-boot@lists.u-boot-project.org
In-Reply-To: <CAC_iWjJO7Xi3RrSnQw4sALirSfjS85PV6wyfyrupN5npC9YY4g@mail.gmail.com>
References: <20261024174056.3529978-1-aswin.murugan@oss.qualcomm.com>
 <CAC_iWjJO7Xi3RrSnQw4sALirSfjS85PV6wyfyrupN5npC9YY4g@mail.gmail.com>
Date: Thu, 26 Nov 2026 18:26:26 +0530
Message-Id: <179569778695.130558.12289369126356468678.b4-reply@b4>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-01 11:31 +0200, Ilias Apalodimas wrote:
> On Sat, 24 Oct 2026 at 20:41, Aswin Murugan
> <aswin.murugan@oss.qualcomm.com> wrote:
> >
> > mmu_change_region_attr_nobreak() updates only the primary page
> > table, leaving the emergency page table with stale attributes.
> > The emergency table is used temporarily while the primary page
> > table is being updated.
> >
> > As a result, speculative accesses can reach regions that were
> > intended to be blocked in the primary table, leading to XPU
> > violations.
> >
> > Update both primary and emergency page tables when modifying
> > region attributes to keep mappings consistent regardless of the
> > active translation table.
> >
> > Since splits can now happen in both the primary and emergency
> > tables, double the number of page tables get_page_table_size()
> > reserves for runtime splits.
> >
> > Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> > ---
> 
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> 

Tom,

Will you be able to pick this fix?

-Sumit

> 
> > Changes in v2:
> > - Added a `root` parameter directly to `find_pte()`, `set_one_region()`,
> >   `set_regions()` instead of renaming them and adding wrapper functions.
> >
> > - Doubled the page table reserve in `get_page_table_size()` to account
> >   for splits now happening in both primary and emergency tables.
> >
> > Link to v1: https://lore.kernel.org/u-boot/20260926092635.2712021-1-aswin.murugan@oss.qualcomm.com/#t
> > ---
> >  arch/arm/cpu/armv8/cache_v8.c | 28 +++++++++++++++++-----------
> >  1 file changed, 17 insertions(+), 11 deletions(-)
> >
> > diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> > index 135bb62ea72..f22cf3f67f2 100644
> > --- a/arch/arm/cpu/armv8/cache_v8.c
> > +++ b/arch/arm/cpu/armv8/cache_v8.c
> > @@ -173,7 +173,7 @@ static int level2shift(int level)
> >         return (12 + 9 * (3 - level));
> >  }
> >
> > -static u64 *find_pte(u64 addr, int level)
> > +static u64 *find_pte(u64 *root, u64 addr, int level)
> >  {
> >         int start_level = 0;
> >         u64 *pte;
> > @@ -191,7 +191,7 @@ static u64 *find_pte(u64 addr, int level)
> >                 return NULL;
> >
> >         /* Walk through all page table levels to find our PTE */
> > -       pte = (u64*)gd->arch.tlb_addr;
> > +       pte = root;
> >         for (i = start_level; i < 4; i++) {
> >                 idx = (addr >> level2shift(i)) & 0x1FF;
> >                 pte += idx;
> > @@ -816,9 +816,10 @@ __weak u64 get_page_table_size(void)
> >
> >         /*
> >          * We may need to split page tables later on if dcache settings change,
> > -        * so reserve up to 4 (random pick) page tables for that.
> > +        * so reserve up to 4 (random pick) page tables for that. Splits can
> > +        * now happen in both the primary and emergency tables, so double it.
> >          */
> > -       size += one_pt * 4;
> > +       size += one_pt * 4 * 2;
> >
> >         return size;
> >  }
> > @@ -1003,11 +1004,11 @@ static bool is_aligned(u64 addr, u64 size, u64 align)
> >  }
> >
> >  /* Use flag to indicate if attrs has more than d-cache attributes */
> > -static u64 set_one_region(u64 start, u64 size, u64 attrs, bool flag, int level)
> > +static u64 set_one_region(u64 *root, u64 start, u64 size, u64 attrs, bool flag, int level)
> >  {
> >         int levelshift = level2shift(level);
> >         u64 levelsize = 1ULL << levelshift;
> > -       u64 *pte = find_pte(start, level);
> > +       u64 *pte = find_pte(root, start, level);
> >
> >         /* Can we can just modify the current level block/page? */
> >         if (is_aligned(start, size, levelsize)) {
> > @@ -1044,7 +1045,7 @@ static u64 set_one_region(u64 start, u64 size, u64 attrs, bool flag, int level)
> >         return 0;
> >  }
> >
> > -static void set_regions(u64 start, u64 size, u64 attrs, bool flag)
> > +static void set_regions(u64 *root, u64 start, u64 size, u64 attrs, bool flag)
> >  {
> >         int level;
> >         u64 r;
> > @@ -1055,7 +1056,7 @@ static void set_regions(u64 start, u64 size, u64 attrs, bool flag)
> >          */
> >         while (size > 0) {
> >                 for (level = 1; level < 4; level++) {
> > -                       r = set_one_region(start, size, attrs, flag, level);
> > +                       r = set_one_region(root, start, size, attrs, flag, level);
> >                         if (r) {
> >                                 /* PTE successfully replaced */
> >                                 size -= r;
> > @@ -1085,7 +1086,7 @@ void mmu_set_region_dcache_behaviour(phys_addr_t start, size_t size,
> >          */
> >         __asm_switch_ttbr(gd->arch.tlb_emerg);
> >
> > -       set_regions(start, size, attrs, false);
> > +       set_regions((u64 *)gd->arch.tlb_addr, start, size, attrs, false);
> >
> >         /* We're done modifying page tables, switch back to our primary ones */
> >         __asm_switch_ttbr(gd->arch.tlb_addr);
> > @@ -1099,7 +1100,12 @@ void mmu_set_region_dcache_behaviour(phys_addr_t start, size_t size,
> >
> >  void mmu_change_region_attr_nobreak(phys_addr_t addr, size_t size, u64 attrs)
> >  {
> > -       set_regions(addr, size, attrs, true);
> > +       set_regions((u64 *)gd->arch.tlb_addr, addr, size, attrs, true);
> > +
> > +       /* Keep the emergency table in sync with the primary one */
> > +       if (gd->arch.tlb_emerg)
> > +               set_regions((u64 *)gd->arch.tlb_emerg, addr, size, attrs, true);
> > +
> >         flush_dcache_range(gd->arch.tlb_addr,
> >                            gd->arch.tlb_addr + gd->arch.tlb_size);
> >         __asm_invalidate_tlb_all();
> > @@ -1112,7 +1118,7 @@ void mmu_change_region_attr_nobreak(phys_addr_t addr, size_t size, u64 attrs)
> >   */
> >  void mmu_change_region_attr(phys_addr_t addr, size_t size, u64 attrs)
> >  {
> > -       set_regions(addr, size, PTE_TYPE_FAULT, true);
> > +       set_regions((u64 *)gd->arch.tlb_addr, addr, size, PTE_TYPE_FAULT, true);
> >
> >         flush_dcache_range(gd->arch.tlb_addr,
> >                            gd->arch.tlb_addr + gd->arch.tlb_size);
> > --
> > 2.34.1
> >
> 
> 


