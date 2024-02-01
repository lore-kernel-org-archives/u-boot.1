Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FFBC4828F
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 14:50:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9DF087CE3;
	Thu,  1 Feb 2024 15:50:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xjZMTh3U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A1B487CD4; Thu,  1 Feb 2024 15:50:06 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE39C87D03
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 15:50:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40ef3f351d2so12692395e9.1
 for <u-boot@lists.denx.de>; Thu, 01 Feb 2024 06:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706799002; x=1707403802; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wi4zVG6DtsfblBgyh+JqN7nDrD7FmAqCB+mJlJB1JpM=;
 b=xjZMTh3UgZjuq9NZmu+a6aYPuv6JQ4zLIbf0vGwcH2PRwEPA5mtOZt4rbxlzwal51U
 zOJTjl82CEQKMdge8oH9b9X0brPKQ5CJfdE5+HVX7yRM5Q2LZRAkVjeumUReWwx5g0hR
 OXUaUmB3I86ufNHs2Uz1HzNB5KvEHyxAJgp+2Lti7Kqw/MMPeLlEkZVmISv9Lhfi364J
 fs4W2O0ODk7CZB7dOe5EWEfuvj2wPEZKFDrbLdhIRbVI58C1ohTwvVC55p5DTLg1kY2U
 1zGlP+JVvmNJ47B2UiYelMIFA++GIWCJvwVh3QAuPTl/a/1S27gQtpoNjiNfuhiP/7zK
 3Vog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706799002; x=1707403802;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wi4zVG6DtsfblBgyh+JqN7nDrD7FmAqCB+mJlJB1JpM=;
 b=SHBcPYpxbNi6mGX5zpvO4zrb9Jt3+SPVvY825VwAjafRleP4vmDmRtyIQZpV5u7xZy
 wDnzv7TP7zlpA+0FURkZkFXTGlRvYkd14m1buNZAHbjCrBm5q/SG6Kh5kop0BeVW56KZ
 dY8MehNnLpLyH8w2jwW/udwR/nLwaZLsK8hftkS1c/Na4yXExE8IXmlHApdb1IuNx5dy
 Q26AVDEbaBX6hwkBvtngHrkwDbALCClgS7fhdCi0P1bOq9rL02VK2RQ39qwd0fuo0FD6
 VcQI1hovgLnRUTQhu7Jd8DqzSsc6jmuz8wx/Av8+PJiBvLtrr5XU/Ppj2ZTy2CHMlqzJ
 dtFQ==
X-Gm-Message-State: AOJu0Yx/Kg7MedZhKoxZC5Bd/Macq1atSV9XfAWQQeVXyTecbUrhgG1M
 nXwoNDzDysVC2BicI+fkG9OMtcwXdobZsg5wZHET0llSkuR50aIQQX0bPLmK/1c=
X-Google-Smtp-Source: AGHT+IFTXAx5hNO6KYNPeF+vgkvN8ZE6rO6VnxGKsE2gKHUtS1nEK82qu5FF1y8claS8PWgbty3VJw==
X-Received: by 2002:a05:600c:3b8d:b0:40e:fb74:c514 with SMTP id
 n13-20020a05600c3b8d00b0040efb74c514mr4447657wms.7.1706799002295; 
 Thu, 01 Feb 2024 06:50:02 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXmtvxBs//YUM2B7z6Zlv/nSVZQ0sjOTuZgpR4XHKjkBxjhuCgxGJauOnCXqrhl/p7ZK45ofr3ysOkTKVKKtmIE1fH9U1g/OY5MAW5rxjKQYBHUL9SDSXMW+fct9yyCf0S4+HhJg41enGll3dltlGY8H0zJG7KL0N8RcOVJTnUxyQA6/qFirtMbHHPMufn3LFs2WBz/A4sWhFDbpNlctdWuqNAdfSoWQPy72iIn4KzE9c2oYEvvCVUeM8vlKIidOe63O06CxPAFtKfrDH/2rSMlQYFD6rWLnRLn/afCe/vI0I6q9WzKgUP8To53yu4JddBov/7y26BKhr8ueaUMoEtIcAR6hDEDaeutplJcmvMG31cxLNcBAS9pBO2RBXd4Joo0
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 t12-20020a05600c450c00b0040e9f7308f4sm4718387wmo.10.2024.02.01.06.50.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Feb 2024 06:50:01 -0800 (PST)
Message-ID: <9fa69f81-d703-49ff-a4b9-f32abfc45eaf@linaro.org>
Date: Thu, 1 Feb 2024 14:50:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/36] mach-snapdragon: carve out no-map regions
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, Dzmitry Sankouski
 <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
References: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
 <20240130-b4-qcom-common-target-v3-20-e523cbf9e556@linaro.org>
 <CAFA6WYPsHLST_=7tNmx=w_pggiH7vibJ1wh8-8CCs-8vw4R-mw@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFA6WYPsHLST_=7tNmx=w_pggiH7vibJ1wh8-8CCs-8vw4R-mw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 01/02/2024 12:07, Sumit Garg wrote:
> On Tue, 30 Jan 2024 at 19:35, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> On Qualcomm platforms, the TZ may already have certain memory regions
>> under protection by the time U-Boot starts. There is a rare case on some
>> platforms where the prefetcher might speculatively access one of these
>> regions resulting in a board crash (TZ traps and then resets the board).
>>
>> We shouldn't be accessing these regions from within U-Boot anyway, so
>> let's mark them all with PTE_TYPE_FAULT to prevent any speculative
>> access and correctly trap in EL1 rather than EL3.
>>
>> This is quite costly with caches off (takes ~2 seconds on SDM845 vs 35ms
>> with caches on). So to minimise the impact this is only enabled on
>> QCS404 for now (where the issue is known to occur).
> 
> It only took 65ms with caches off on QCS404 as per below print:
> 
> carveout time: 65ms
> 
> It's probably due to some missing bits as pointed below to get it
> working fast on SDM845 too..

Ah I didn't consider that the difference might really just be the 2M vs
4K alignment.

[snip]

>> +
>> +/* Mark all no-map regions as PTE_TYPE_FAULT to prevent speculative access.
>> + * On some platforms this is enough to trigger a security violation and trap
>> + * to EL3.
>> + */
>> +static void carve_out_reserved_memory(void)
>> +{
>> +       static struct fdt_resource res[N_RESERVED_REGIONS] = { 0 };
>> +       int parent, rmem, count, i = 0;
>> +       phys_addr_t start;
>> +       size_t size;
>> +
>> +       /* Some reserved nodes must be carved out, as the cache-prefetcher may otherwise
>> +        * attempt to access them, causing a security exception.
>> +        */
>> +       parent = fdt_path_offset(gd->fdt_blob, "/reserved-memory");
>> +       if (parent <= 0) {
>> +               log_err("No reserved memory regions found\n");
>> +               return;
>> +       }
>> +       count = fdtdec_get_child_count(gd->fdt_blob, parent);
>> +       if (count > N_RESERVED_REGIONS) {
>> +               log_err("Too many reserved memory regions!\n");
>> +               count = N_RESERVED_REGIONS;
>> +       }
>> +
>> +       /* Collect the reserved memory regions */
>> +       fdt_for_each_subnode(rmem, gd->fdt_blob, parent) {
>> +               if (!fdt_getprop(gd->fdt_blob, rmem, "no-map", NULL))
>> +                       continue;
>> +               if (fdt_getprop(gd->fdt_blob, rmem, "compatible", NULL))
>> +                       continue;
>> +               /* Skip regions that don't have a fixed address/size */
>> +               if (fdt_get_resource(gd->fdt_blob, rmem, "reg", 0, &res[i++]))
>> +                       i--;
>> +       }
>> +
>> +       /* Sort the reserved memory regions by address */
>> +       count = i;
>> +       qsort(res, count, sizeof(struct fdt_resource), fdt_cmp_res);
>> +
>> +       /* Now set the right attributes for them. Often a lot of the regions are tightly packed together
>> +        * so we can optimise the number of calls to mmu_change_region_attr() by combining adjacent
>> +        * regions.
>> +        */
>> +       start = ALIGN_DOWN(res[0].start, SZ_2M);
>> +       size = ALIGN(res[0].end, SZ_4K) - start;
>> +       for (i = 1; i < count; i++) {
> 
> I suppose this loop fails to configure attributes for the last no-map
> region like uefi_mem region on QCS404.

Right.
> 
>> +               /* We ideally want to 2M align everything for more efficient pagetables, but we must avoid
>> +                * overwriting reserved memory regions which shouldn't be mapped as FAULT (like those with
>> +                * compatible properties).
>> +                * If within 2M of the previous region, bump the size to include this region. Otherwise
>> +                * start a new region.
>> +                */
>> +               if (start + size < res[i].start - SZ_2M) {
>> +                       debug("  0x%016llx - 0x%016llx FAULT\n",
>> +                             start, start + size);
>> +                       mmu_change_region_attr(start, size, PTE_TYPE_FAULT);
> 
> Here the size won't always be 2M aligned which is the case for SDM845.
> I would suggest you do:
> 
>                             mmu_change_region_attr(start, ALIGN(size,
> SZ_2M), PTE_TYPE_FAULT);

This isn't an option as I want to avoid unmapping reserved memory
regions which have a compatible property; on SDM845 for example this
includes the cmd-db and rmtfs regions. These are not 2M aligned and
might be directly adjacent to other regions, so doing an align here
could result in unmapping part of these regions.

This will be especially relevant for SM8250 where I'll be enabling
cmd-db and RPMh drivers in order to turn on the USB VBUS regulator on RB5.
> 
> -Sumit
> 
>> +                       start = ALIGN_DOWN(res[i].start, SZ_2M);
>> +                       size = ALIGN(res[i].end, SZ_4K) - start;
>> +               } else {
>> +                       /* Bump size if this region is immediately after the previous one */
>> +                       size = ALIGN(res[i].end, SZ_4K) - start;
>> +               }
>> +       }
>> +}
>> +
>> +/* This function open-codes setup_all_pgtables() so that we can
>> + * insert additional mappings *before* turning on the MMU.
>> + */
>>  void enable_caches(void)
>>  {
>> +       u64 tlb_addr = gd->arch.tlb_addr;
>> +       u64 tlb_size = gd->arch.tlb_size;
>> +       ulong carveout_start;
>> +
>> +       gd->arch.tlb_fillptr = tlb_addr;
>> +
>>         build_mem_map();
>>
>>         icache_enable();
>> +
>> +       /* Create normal system page tables */
>> +       setup_pgtables();
>> +
>> +       /* Create emergency page tables */
>> +       gd->arch.tlb_size -= (uintptr_t)gd->arch.tlb_fillptr -
>> +                            (uintptr_t)gd->arch.tlb_addr;
>> +       gd->arch.tlb_addr = gd->arch.tlb_fillptr;
>> +       setup_pgtables();
>> +       gd->arch.tlb_emerg = gd->arch.tlb_addr;
>> +       gd->arch.tlb_addr = tlb_addr;
>> +       gd->arch.tlb_size = tlb_size;
>> +
>> +       /* Doing this has a noticeable impact on boot time, so until we can
>> +        * find a more efficient solution, just enable the workaround for
>> +        * the one board where it's necessary. Without this there seems to
>> +        * be a speculative access to a region which is protected by the TZ.
>> +        */
>> +       if (of_machine_is_compatible("qcom,qcs404")) {
>> +               carveout_start = get_timer(0);
>> +               carve_out_reserved_memory();
>> +               debug("carveout time: %lums\n", get_timer(carveout_start));
>> +       }
>> +
>>         dcache_enable();
>>  }
>>
>> --
>> 2.43.0
>>

-- 
// Caleb (they/them)
