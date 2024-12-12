Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C4AE77180
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 12:33:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CB56801BE;
	Thu, 12 Dec 2024 13:33:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="CsGr5/2W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 437DF801B6; Thu, 12 Dec 2024 13:33:14 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07403801BD
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 13:33:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 3ff30d5c-b885-11ef-8d54-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 3ff30d5c-b885-11ef-8d54-005056999439;
 Thu, 12 Dec 2024 13:33:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=qSiDMltgRPENwedpuvKNJpTyLuLiDZ3TAKyXwItORyA=;
 b=CsGr5/2WD9QeQ1agNyu7mGTvFBYQBbaapcNVBiCqXqIszS9JqrLlNDo1zBf31ixXTU2fn5gIDhla/
 Qpz+MRR6r4mqLCEv8vou/y9NuszhwckPKRr6rKTMssVICs7shi7Azm5+JdbDGwemshEclrtDRkiymP
 PaUO01xTiTiAvxJ3wID1ll2KlRo7P+9eLq2Q9kToSkzUj2Yuj5EHzSDkmeI0cp7mW44nlfcx1HOrTA
 E49IBSDy3brLUdeXvBfHWaC4kHqKFj3yLB9UzOXju7yDVwqrrXeqO0W5CsE+iAtv/ecAxirmX1wk2j
 jcRUeThLUjrrmMp9daE5r9NLi4vFREg==
X-KPN-MID: 33|3i5CdhyrgPP96wm7VJyDhLxYZbkq7SEcimWg+v3p6XEgFV467cYI8WmXX5iuMgo
 BQph3/402wC9Y73AqiTtHsZrrPuQss4WQo0hxLAvzewg=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|HYtnqnDV9Iaoe39FJN7P/EYcGZzXyK3RnthPs/EaEjAqmscYDy6fkq9gABM23iu
 CMNuums+wTCUNCQ7MJkPwSg==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 3f7926aa-b885-11ef-88b2-00505699772e;
 Thu, 12 Dec 2024 13:33:11 +0100 (CET)
Date: Thu, 12 Dec 2024 13:33:10 +0100
Message-Id: <8734itxerd.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: sughosh.ganu@linaro.org, trini@konsulko.com, u-boot@lists.denx.de,
 patrick.delaunay@foss.st.com, xypron.glpk@gmx.de, lucent@gmail.com
In-Reply-To: <a1b49293-7ebd-4590-8311-f3bc2943a6dd@foss.st.com> (message from
 Patrice CHOTARD on Thu, 12 Dec 2024 09:23:52 +0100)
Subject: Re: [PATCH] lmb: prohibit allocations above ram_top even from same
 bank
References: <20241202070624.1295497-1-sughosh.ganu@linaro.org>
 <173358702572.3722028.2684286775587826268.b4-ty@konsulko.com>
 <092f9d73-c0c5-419e-b6e5-e671f8227753@foss.st.com>
 <CADg8p96XXRVn6r-9tSu-h1CANgnayQuEVs8XVUb8eAd8d5kz9A@mail.gmail.com>
 <7642b0fc-8383-4877-bbc6-22bcd22536fc@foss.st.com>
 <CADg8p951Y10c_ffDCKZaCS6kG+c8mR2aDrTtDgD3rZsWoBM3Cw@mail.gmail.com>
 <a1b49293-7ebd-4590-8311-f3bc2943a6dd@foss.st.com>
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

> Date: Thu, 12 Dec 2024 09:23:52 +0100
> From: Patrice CHOTARD <patrice.chotard@foss.st.com>
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
> see include/asm-generic/global_data.h :
> 
> 	/**
> 	 * @ram_top: top address of RAM used by U-Boot
> 	 */
> 	phys_addr_t ram_top;
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
> 	reserved-memory {
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 		ranges;
> 
> 		optee@dd000000 {
> 			reg = <0xdd000000 0x3000000>;
> 			no-map;
> 		};
> 	};
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

And that's what needs to be fixed I think.  It should be allowed to
add this flag to an already existing region regardless of whether the
LMB_NOOVERWRITE flag is set (and split the region if necessary).

I wonder if it is enough to adjust the

                        if (flags == LMB_NONE) {

in lib/lmb.c:lmb_add_region_flags() into

                        if (flags == LMB_NONE || (flags & LMB_NOOVERWRITE)) {

to fix your issue.

Currently the code in boot/image-fdt.c:boot_fdt_add_mem_rsv_regions()
always adds LMB_NOOVERWRITE, which supports the view that LMB_NOMAP
adds restrictions on top of that.

> For information, it has impact on all STM32MP platforms (at least 6 boards).
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
> 
