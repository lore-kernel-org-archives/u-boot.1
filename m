Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A11BE7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 13:24:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81F2D801CF;
	Thu, 12 Dec 2024 14:24:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qOjKhSfp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C29F1801D7; Thu, 12 Dec 2024 14:24:06 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E7D5801CE
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 14:24:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d3d479b1e6so747292a12.2
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 05:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734009843; x=1734614643; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TRPCZxEQ4k5AEDPNM/Lea9dgurbIgpXqdtnduHKwhT4=;
 b=qOjKhSfp0FBLFQty+merE3MD7yQPNYAwFMHfFMmn7tK4tKbvA9Mh3RMviIJ4LvKNQH
 Lc29ZDrCXZ21QqbuLhkJEniws2sGsEXQ50fYufu3FE5p8A9xFGFc/WFA4U4YQgjO9kfw
 UISBR687sEPrFT9QwYxxo2sU1E9J03rqo9KVLEwzCVZGjwSUwAZtMrGM25FxYKakgwF+
 VhjDcQr6I/+DRs4evk6PFYioEEHAmyEHRTnqas2rsd0++YIbyhsbQ/2Y1L73nIlC/7gJ
 wQe/yuBDlEzmCReHRJSUnhPXlxnnEQF5fUcHW2vCMwtNygO0pwwXRKxskhpGTJrTgCa/
 Rqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734009843; x=1734614643;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TRPCZxEQ4k5AEDPNM/Lea9dgurbIgpXqdtnduHKwhT4=;
 b=gJHDHVFwPu45lajARgkpgLJ7P4dm3tHnj8Qjsy98BGMErHqr8NXTDCGtiwWn8UtBGS
 gM1fHlzF4E2GjbXGvd95Sd77ccHixHzQzNI6++IHfcX4oZOdviC8CgPUuiJsjG4vkCJW
 rXCM4plIXmtF6rjCd7ofvY85F3OOvmC6hf/+OWmrGc1VmvZlDpfWYhuMMzhnGENzjc1x
 hicRr6QnXHgwKwSlkyNQffrzGyOFqtzPzF2l7xP1or0u2SmmjfXUNIsIPd0c3+ngHN1q
 JIqbWpH4p6OxZLiZ53MrEXJ27AEu3sAhH32neK+nR7h++6xkAe6Txryvrs6sj3MA1Jam
 IWDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1WZzFuryHFqKsAdlGtZc5i+O8kaq9ubMExFMC1x5TTeIG+178AvjZ4g3+FTKuol1hI6oVeNo=@lists.denx.de
X-Gm-Message-State: AOJu0YxTFm8cDNtr6zi8hHEqhMweWCDop1wibVF7iT0nIioq9i3jsI59
 Gipcg0EqQs6SKelt0ugDDABNxdE1cZSAXKcpq/EnhwTLBmPD7dxlcOrOCexIIYVDjpN6pFZmwx/
 RhLNzgvCgzQhfME7bzmDBqBAMFZGYEUeY7w4e8Q==
X-Gm-Gg: ASbGncsiV4kye78mgpHJjF90Qi/YJpzFZHZo/wOViveaCgsEDC8SU1/cfQhxpGpK8QU
 SFKWABPHMHRIboRL74usUlSgcosEfdyOxPN60gnk=
X-Google-Smtp-Source: AGHT+IHMhvHuO3iNX+PUztTWeustZ2dQ7tTC8uBlza5PB1Qws2hAvQlwdGX/LHdgMeMy+n1yljvCnsDmn4rUiMTSqow=
X-Received: by 2002:a05:6402:4583:b0:5d3:cf89:bd3e with SMTP id
 4fb4d7f45d1cf-5d633eb0b2cmr494384a12.30.1734009843428; Thu, 12 Dec 2024
 05:24:03 -0800 (PST)
MIME-Version: 1.0
References: <20241202070624.1295497-1-sughosh.ganu@linaro.org>
 <173358702572.3722028.2684286775587826268.b4-ty@konsulko.com>
 <092f9d73-c0c5-419e-b6e5-e671f8227753@foss.st.com>
 <CADg8p96XXRVn6r-9tSu-h1CANgnayQuEVs8XVUb8eAd8d5kz9A@mail.gmail.com>
 <7642b0fc-8383-4877-bbc6-22bcd22536fc@foss.st.com>
 <CADg8p951Y10c_ffDCKZaCS6kG+c8mR2aDrTtDgD3rZsWoBM3Cw@mail.gmail.com>
 <a1b49293-7ebd-4590-8311-f3bc2943a6dd@foss.st.com>
In-Reply-To: <a1b49293-7ebd-4590-8311-f3bc2943a6dd@foss.st.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 12 Dec 2024 18:53:51 +0530
Message-ID: <CADg8p96=GdW-ZADTfXSJ76Zm9=1fn7R1PM=LkkUvk+Ayv2NiZQ@mail.gmail.com>
Subject: Re: [PATCH] lmb: prohibit allocations above ram_top even from same
 bank
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, E Shattow <lucent@gmail.com>
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

On Thu, 12 Dec 2024 at 13:58, Patrice CHOTARD
<patrice.chotard@foss.st.com> wrote:
>
>
>
> On 12/11/24 19:16, Sughosh Ganu wrote:
> > On Wed, 11 Dec 2024 at 22:20, Patrice CHOTARD
> > <patrice.chotard@foss.st.com> wrote:
> >>
> >>
> >>
> >> On 12/11/24 17:27, Sughosh Ganu wrote:
> >>> On Wed, 11 Dec 2024 at 21:50, Patrice CHOTARD
> >>> <patrice.chotard@foss.st.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 12/7/24 16:57, Tom Rini wrote:
> >>>>> On Mon, 02 Dec 2024 12:36:24 +0530, Sughosh Ganu wrote:
> >>>>>
> >>>>>> There are platforms which set the value of ram_top based on certain
> >>>>>> restrictions that the platform might have in accessing memory above
> >>>>>> ram_top, even when the memory region is in the same DRAM bank. So,
> >>>>>> even though the LMB allocator works as expected, when trying to
> >>>>>> allocate memory above ram_top, prohibit this by marking all memory
> >>>>>> above ram_top as reserved, even if the said memory region is from the
> >>>>>> same bank.
> >>>>>>
> >>>>>> [...]
> >>>>>
> >>>>> Applied to u-boot/master, thanks!
> >>>>>
> >>>> Hello
> >>>>
> >>>> This patch is breaking the boot on STM32MP135F-DK.
> >>>>
> >>>> On this platform, we got an area above gd->ram_top,
> >>>> this area, reserved for OPTEE, is tagged with LMB_NOMAP in boot_fdt_add_mem_rsv_regions().
> >>>>
> >>>> Since this commit 1a48b0be93d4 ("lmb: prohibit allocations above ram_top even from same bank"),
> >>>> this area is no more tagged as LMB_NOMAP, because it's previously been
> >>>> tagged with LMB_NOOVERWRITE in lmb_add_memory().
> >>>>
> >>>> By not being tagged LMB_NOMAP, the MMU configuration is impacted and leads to a panic.
> >>>>
> >>>> I suggest to revert this patch.
> >>>
> >>> I don't think that this patch should be reverted. If the said platform
> >>> has a reserved memory region above ram_top, I would suggest to either
> >>> a) move the ram_top on this platform so that the op-tee region gets
> >>> marked as no-map in the lmb memory map, or b) do not use the lmb
> >>
> >> In my explanation above, i indicated that before this commit,
> >> this area was marked as LMB_NOMAP in the lmb memory map by boot_fdt_add_mem_rsv_regions().
> >> this is exactly what you described in the possible solution "a)".
> >>
> >> But now with this commit, as lmb_add_memory() is called in lmb_init() the area above ram_top is marked LMB_NOOVERWRITE.
> >> Then later, boot_fdt_add_mem_rsv_regions() is executed, but the area above ram_top can't be marked as
> >> LMB_NOMAP as previously because it's already marked LMB_NOOVERWRITE.
> >
> > This has been done to ensure that memory above ram_top is not taken
> > into consideration when it comes to U-Boot. The reason why memory
>
> It was already the case before this commit, ram_top was designed to
> indicate to U-Boot the top address of available RAM,

With earlier lmb code, it was a function of how the API's were being
used. Specifically the amount of RAM memory that would get added. It
was very much possible to allocate memory above ram_top [1], something
which is not so now.

> see include/asm-generic/global_data.h :
>
>         /**
>          * @ram_top: top address of RAM used by U-Boot
>          */
>         phys_addr_t ram_top;
>
> > above ram_top also needs to be added is to ensure that this memory
> > also gets passed on to the OS when booting with EFI. If it has to be
> > considered by U-Boot, the value of ram_top needs to be adjusted
> > accordingly. Is that not possible on the platform? If not, the only
> > other solution is to obtain this memory region from the DT, and then
> > configure the MMU.
>
> Currently, ram_top is adjusted on STM32MP platforms,
> for example in stm32mp135f-dk.dts :
>
>         reserved-memory {
>                 #address-cells = <1>;
>                 #size-cells = <1>;
>                 ranges;
>
>                 optee@dd000000 {
>                         reg = <0xdd000000 0x3000000>;
>                         no-map;
>                 };
>         };
>
>           0xE000 0000  ********************
>                        *                  *
>                        *       OPTEE      *
>                        *    (LMB_NOMAP)   *
>                        *                  *
> ram_top = 0xDD00 0000  ********************
>                        *                  *
>                        *                  *
>                        *                  *
>                        *                  *
>                        *                  *
>                        *                  *
>                        *                  *
>                        *                  *
>                        *                  *
>                        *                  *
>           0xC000 0000  ********************
>
> On STM32MP platforms, we already obtain all memory regions from DT with
> property "no-map" and we marked them LMB_NOMAP.
>
> Later we parse the LMB regions, all of these region marked LMB_NOMAP are
> used to configure our MMU accordingly.
> So, again, we are doing things as you suggested.
>
> This commit now forbids to mark OPTEE memory region with LMB_NOMAP as
> indicated in DT.
>
> For information, it has impact on all STM32MP platforms (at least 6 boards).

So this is indeed the case of all of the memory region above ram_top
being marked as no-map in the DT. I do have a ST DK2 board with me,
but I do not see a hang on that board. Not sure why. Can we not put a
check in the mmu configuration function to cover the case of memory
above ram_top. Something like this.

diff --git a/arch/arm/mach-stm32mp/stm32mp1/cpu.c
b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
index 62cc98910a7..55ac62679ff 100644
--- a/arch/arm/mach-stm32mp/stm32mp1/cpu.c
+++ b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
@@ -77,8 +77,13 @@ void dram_bank_mmu_setup(int bank)
        for (i = start >> MMU_SECTION_SHIFT;
             i < (start >> MMU_SECTION_SHIFT) + (size >> MMU_SECTION_SHIFT);
             i++) {
+               phys_addr_t addr;
+
+               addr = i << MMU_SECTION_SHIFT;
                option = DCACHE_DEFAULT_OPTION;
-               if (use_lmb && lmb_is_reserved_flags(i <<
MMU_SECTION_SHIFT, LMB_NOMAP))
+               if (use_lmb && (lmb_is_reserved_flags(i << MMU_SECTION_SHIFT,
+                                                     LMB_NOMAP) ||
+                               addr >= gd->ram_top))
                        option = 0; /* INVALID ENTRY in TLB */
                set_section_dcache(i, option);
        }

-sughosh

[1] - https://gist.github.com/sughoshg/1a03f1af93bb75db10a4a1df3265ebf0

>
> Patrice
>
>
>
> >
> >>
> >>
> >>> memory map to configure the MMU -- can the MMU configuration logic not
> >>> read the DT to get which regions are to be marked as no-map?
> >>>
> >>> As far as the lmb module is concerned, it is being told through this
> >>> commit to not consider memory above ram_top for allocations, which is
> >>> not an incorrect thing imo.
> >>
> >> That's the case, we don't consider memory above ram_top for allocations,
> >> we only marked it with LMB_NOMAP.
> >
> > That was because the lmb scope was local. That meant a platform could
> > add any size that it wanted, and then use that map for whatever it
> > fancied. The use of lmb for "allocating" addresses for io-va addresses
> > by the apple iommu is another such case.
> >
> > -sughosh
> >
> >>
> >> Thanks
> >> Patrice
> >>
> >>>
> >>> -sughosh
> >>>
> >>>>
> >>>> Patrice
