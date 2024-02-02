Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B32DC47258
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 06:03:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5544C87CEA;
	Fri,  2 Feb 2024 07:03:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NkSKBu6E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CDC387BDB; Fri,  2 Feb 2024 07:03:21 +0100 (CET)
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com
 [IPv6:2607:f8b0:4864:20::e2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE40A87D2E
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 07:03:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-467e4a04086so672196137.3
 for <u-boot@lists.denx.de>; Thu, 01 Feb 2024 22:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853795; x=1707458595; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hvaMXTSyZ/VuAmsBdHkTAUB6yrQvS7nss9R+Bs0cVAQ=;
 b=NkSKBu6EOCtcEYmpRNXeitd+E+EbfTSF7vaLKwbeQ2fTULkXfuj/9NYekVoVIIS57Q
 kbtlTdWul5mgblSb/vd2q/YyA18IlaZtBFXOwRMgKYPhlHoeV+nz1a6CeBfUyVlPZnG5
 ckDqRbxW/NphuEaDaZ1q7bqoL6/g3XpzvkYjA59MVl5yBP4+bYExB4Qofw8Auqv59fpt
 vGjPQMTx/sFTai36DIwAAVuH+jBQ29H6UVXCVnF8K6MtxuhdrIf4eKbJUaCwix3Ph5uB
 wGdxh9+T0FbZKhgsQWFwyVds5QZQtodld1Lvr99FtOOdl2QfDMRF/G0KMp8WD+CVZSgR
 6K0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853795; x=1707458595;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hvaMXTSyZ/VuAmsBdHkTAUB6yrQvS7nss9R+Bs0cVAQ=;
 b=gHCnEquP+e1PHqI/bQd4cpjmyTFZJMeicmgrYOtslKrGMm1ArF1OeFeszmRbnFwrsv
 wuC0f8Dvn0RkvCNNdQr2+JSezdhxZ6c6m+pN0WtgJwe//rjlh/YoPtwFnmnoKujprFe6
 mTPKBOMUTDWKKIPeBAxJLU87T77m1VRwZsBGYB1jHdOiZYlcA61CGPhNmbaWvw6oYv/7
 JrnOQQZ1TQwkCy5VvMRIKLvYAA3Gcd9yZzkR4QWgAa1SoHjm/G8uTpPz9KEZgqzbsf/1
 O4xaSIJmAWTdIPlLpaWe81kyy1keVNWs0KawsuN6BN8lST0CxxQwmK34tBPD/bG6mXpZ
 YyuQ==
X-Gm-Message-State: AOJu0YyzSapuj9axkyoBD/mOeqzhzsG0Z/u9NZp7hI153lJYuKBnnVsl
 KntttuUzHuS2rpTBlYcjvKhf9pm0KD9MsBxn8EbR/2K0x55DsZt+IhTJaLkQsI9ijvwDD9OzzHl
 KIhelYufyr+qIgiVQ2CT2UWGa7itYZvcI21ZV3w==
X-Google-Smtp-Source: AGHT+IEr0MCdUlho2DWoxmKG6V9qEA/zZwOMcMprA/GOiY+pRlHeg1k080xLhJvEt4yJhHbgsD6Qz/pN0CtsJ7schXk=
X-Received: by 2002:a05:6102:21d2:b0:46b:5862:9b5d with SMTP id
 r18-20020a05610221d200b0046b58629b5dmr3330021vsg.28.1706853795149; Thu, 01
 Feb 2024 22:03:15 -0800 (PST)
MIME-Version: 1.0
References: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
 <20240130-b4-qcom-common-target-v3-20-e523cbf9e556@linaro.org>
 <CAFA6WYPsHLST_=7tNmx=w_pggiH7vibJ1wh8-8CCs-8vw4R-mw@mail.gmail.com>
 <9fa69f81-d703-49ff-a4b9-f32abfc45eaf@linaro.org>
In-Reply-To: <9fa69f81-d703-49ff-a4b9-f32abfc45eaf@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 2 Feb 2024 11:33:03 +0530
Message-ID: <CAFA6WYPbv-+BtoUufORXLF1O+xF5m=OBcfw1DwoiDvhFZGw5jA@mail.gmail.com>
Subject: Re: [PATCH v3 20/36] mach-snapdragon: carve out no-map regions
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 1 Feb 2024 at 20:20, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 01/02/2024 12:07, Sumit Garg wrote:
> > On Tue, 30 Jan 2024 at 19:35, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>
> >> On Qualcomm platforms, the TZ may already have certain memory regions
> >> under protection by the time U-Boot starts. There is a rare case on some
> >> platforms where the prefetcher might speculatively access one of these
> >> regions resulting in a board crash (TZ traps and then resets the board).
> >>
> >> We shouldn't be accessing these regions from within U-Boot anyway, so
> >> let's mark them all with PTE_TYPE_FAULT to prevent any speculative
> >> access and correctly trap in EL1 rather than EL3.
> >>
> >> This is quite costly with caches off (takes ~2 seconds on SDM845 vs 35ms
> >> with caches on). So to minimise the impact this is only enabled on
> >> QCS404 for now (where the issue is known to occur).
> >
> > It only took 65ms with caches off on QCS404 as per below print:
> >
> > carveout time: 65ms
> >
> > It's probably due to some missing bits as pointed below to get it
> > working fast on SDM845 too..
>
> Ah I didn't consider that the difference might really just be the 2M vs
> 4K alignment.
>
> [snip]
>
> >> +
> >> +/* Mark all no-map regions as PTE_TYPE_FAULT to prevent speculative access.
> >> + * On some platforms this is enough to trigger a security violation and trap
> >> + * to EL3.
> >> + */
> >> +static void carve_out_reserved_memory(void)
> >> +{
> >> +       static struct fdt_resource res[N_RESERVED_REGIONS] = { 0 };
> >> +       int parent, rmem, count, i = 0;
> >> +       phys_addr_t start;
> >> +       size_t size;
> >> +
> >> +       /* Some reserved nodes must be carved out, as the cache-prefetcher may otherwise
> >> +        * attempt to access them, causing a security exception.
> >> +        */
> >> +       parent = fdt_path_offset(gd->fdt_blob, "/reserved-memory");
> >> +       if (parent <= 0) {
> >> +               log_err("No reserved memory regions found\n");
> >> +               return;
> >> +       }
> >> +       count = fdtdec_get_child_count(gd->fdt_blob, parent);
> >> +       if (count > N_RESERVED_REGIONS) {
> >> +               log_err("Too many reserved memory regions!\n");
> >> +               count = N_RESERVED_REGIONS;
> >> +       }
> >> +
> >> +       /* Collect the reserved memory regions */
> >> +       fdt_for_each_subnode(rmem, gd->fdt_blob, parent) {
> >> +               if (!fdt_getprop(gd->fdt_blob, rmem, "no-map", NULL))
> >> +                       continue;
> >> +               if (fdt_getprop(gd->fdt_blob, rmem, "compatible", NULL))
> >> +                       continue;
> >> +               /* Skip regions that don't have a fixed address/size */
> >> +               if (fdt_get_resource(gd->fdt_blob, rmem, "reg", 0, &res[i++]))
> >> +                       i--;
> >> +       }
> >> +
> >> +       /* Sort the reserved memory regions by address */
> >> +       count = i;
> >> +       qsort(res, count, sizeof(struct fdt_resource), fdt_cmp_res);
> >> +
> >> +       /* Now set the right attributes for them. Often a lot of the regions are tightly packed together
> >> +        * so we can optimise the number of calls to mmu_change_region_attr() by combining adjacent
> >> +        * regions.
> >> +        */
> >> +       start = ALIGN_DOWN(res[0].start, SZ_2M);
> >> +       size = ALIGN(res[0].end, SZ_4K) - start;
> >> +       for (i = 1; i < count; i++) {
> >
> > I suppose this loop fails to configure attributes for the last no-map
> > region like uefi_mem region on QCS404.
>
> Right.
> >
> >> +               /* We ideally want to 2M align everything for more efficient pagetables, but we must avoid
> >> +                * overwriting reserved memory regions which shouldn't be mapped as FAULT (like those with
> >> +                * compatible properties).
> >> +                * If within 2M of the previous region, bump the size to include this region. Otherwise
> >> +                * start a new region.
> >> +                */
> >> +               if (start + size < res[i].start - SZ_2M) {
> >> +                       debug("  0x%016llx - 0x%016llx FAULT\n",
> >> +                             start, start + size);
> >> +                       mmu_change_region_attr(start, size, PTE_TYPE_FAULT);
> >
> > Here the size won't always be 2M aligned which is the case for SDM845.
> > I would suggest you do:
> >
> >                             mmu_change_region_attr(start, ALIGN(size,
> > SZ_2M), PTE_TYPE_FAULT);
>
> This isn't an option as I want to avoid unmapping reserved memory
> regions which have a compatible property; on SDM845 for example this
> includes the cmd-db and rmtfs regions. These are not 2M aligned and
> might be directly adjacent to other regions, so doing an align here
> could result in unmapping part of these regions.

The regions with a compatible property and "no-map" should be mapped
by corresponding drivers later on when caches are enabled. The default
memory attributes or cache policy may not make sense for them for eg.
a shared memory region with coprocessors which has to be marked
un-cached etc.

>
> This will be especially relevant for SM8250 where I'll be enabling
> cmd-db and RPMh drivers in order to turn on the USB VBUS regulator on RB5.

So the cmd-db and RPMh drivers should map corresponding reserved
memory appropriately as per their requirements via
mmu_change_region_attr(). Since we have the caches enabled at that
point it won't be an expensive operation.

-Sumit

> >
> >> +                       start = ALIGN_DOWN(res[i].start, SZ_2M);
> >> +                       size = ALIGN(res[i].end, SZ_4K) - start;
> >> +               } else {
> >> +                       /* Bump size if this region is immediately after the previous one */
> >> +                       size = ALIGN(res[i].end, SZ_4K) - start;
> >> +               }
> >> +       }
> >> +}
> >> +
> >> +/* This function open-codes setup_all_pgtables() so that we can
> >> + * insert additional mappings *before* turning on the MMU.
> >> + */
> >>  void enable_caches(void)
> >>  {
> >> +       u64 tlb_addr = gd->arch.tlb_addr;
> >> +       u64 tlb_size = gd->arch.tlb_size;
> >> +       ulong carveout_start;
> >> +
> >> +       gd->arch.tlb_fillptr = tlb_addr;
> >> +
> >>         build_mem_map();
> >>
> >>         icache_enable();
> >> +
> >> +       /* Create normal system page tables */
> >> +       setup_pgtables();
> >> +
> >> +       /* Create emergency page tables */
> >> +       gd->arch.tlb_size -= (uintptr_t)gd->arch.tlb_fillptr -
> >> +                            (uintptr_t)gd->arch.tlb_addr;
> >> +       gd->arch.tlb_addr = gd->arch.tlb_fillptr;
> >> +       setup_pgtables();
> >> +       gd->arch.tlb_emerg = gd->arch.tlb_addr;
> >> +       gd->arch.tlb_addr = tlb_addr;
> >> +       gd->arch.tlb_size = tlb_size;
> >> +
> >> +       /* Doing this has a noticeable impact on boot time, so until we can
> >> +        * find a more efficient solution, just enable the workaround for
> >> +        * the one board where it's necessary. Without this there seems to
> >> +        * be a speculative access to a region which is protected by the TZ.
> >> +        */
> >> +       if (of_machine_is_compatible("qcom,qcs404")) {
> >> +               carveout_start = get_timer(0);
> >> +               carve_out_reserved_memory();
> >> +               debug("carveout time: %lums\n", get_timer(carveout_start));
> >> +       }
> >> +
> >>         dcache_enable();
> >>  }
> >>
> >> --
> >> 2.43.0
> >>
>
> --
> // Caleb (they/them)
