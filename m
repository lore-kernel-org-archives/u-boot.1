Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4FB4F5A8A0
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 17:07:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 368658422D;
	Mon, 20 Apr 2026 19:07:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YktBxC2p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36F4684310; Mon, 20 Apr 2026 19:07:28 +0200 (CEST)
Received: from mail-yx1-xb135.google.com (mail-yx1-xb135.google.com
 [IPv6:2607:f8b0:4864:20::b135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52BC883BC8
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 19:07:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-65006c99d38so3108418d50.3
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 10:07:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776704844; cv=none;
 d=google.com; s=arc-20240605;
 b=NQiTy2ThrPi/x2InHjixbC9Syiby6yV/ycRFEuAFcdQsb6N8+KyJnfZSbx4mO1gz8+
 hpOa+tKjROQLSpXWbLCZnPup1rIkruvk+yee7J7VKeQ3/dAKLLvxLreK0wta4PDTtxc0
 p+1nqP6iGsH4nZ0pPPhVEjP46+su2EOwUWIyM2FACCyneC/tHERzo8FnkJp192goW1nU
 FQqwHiN57uCp0OyvKW+TUUp974t+cM2veeK4lFbFkKjmj6681P5NTqUtPhOuzoxHB6Gh
 fgDZtN+vj/mq86+kOZfIky6JizFKlnpFtelKQGrJgfdCuvEj69+LvwOOxYasydkeLybb
 IxCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nNM7H+cG2OqR7Ra2ixOopvTyh7cVlKh4JToZfip+bUU=;
 fh=D3Aim0wMiGNrDhS92A2EMFYMPNqHC1fXFwF4sdP0BWc=;
 b=B97j54mxLXYF2GC4q6l6GI4JbMZdUeVsh5DLK6Y/on4A8mvAIme/Nd4r+w3uBpIMjV
 Eze9EbM9qbmB6ps+PxCuCjkeRslqJwZr4oh7fMvc+nRz6BMBo0r07+QfqOJ+/w1F8EYX
 D/37NQwWwsBZs+Z5CxwyRsdsmlFJyGCEHwIjhUwrh+h8UJLEaIB4lA6RR15RiD3w9nYn
 k/smCafTrmNxlwLDUNi5d5IJRRpkIkrorRFhBrE1iQMli+Xr7aIcsksXLgICXmX1jxlG
 L6CTdzozkpOTPkZM6GL1eGf/e6Odv9BHMctZ92wsYd47hL3iIdvLvHDRd9N1+Nsl9tvh
 LOww==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776704844; x=1777309644; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nNM7H+cG2OqR7Ra2ixOopvTyh7cVlKh4JToZfip+bUU=;
 b=YktBxC2pu1WE2IzZzn7w8ahDmlEX+kdvCy6o2mm/BRW0Ht/yikeFZxiHf1GGcRMFvI
 PDv2Loag7r6RxrY8auwf+tPZI1x4weNlmhrNYqyKtR5wensvdLr8lOfKzqm6YlsvA5dS
 SrMWjHQYim64Ei3220f0OganQBE5OP9ZIqexBJyFvxScv7vjuTcyRMDF3os2MocTl4/7
 j00KC3v1DgAvD78/w+yfZBQIzEMh3JBMAlg15K2dMvFnqvV0IYpjmeqGQcztVH5jk+mK
 dIcXDeRvvAqGbIbQdutTR+W+13R6DBu96tFSxZnIdqXTflr4BRa5IEnPm2tq3zlVr1UD
 d1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776704844; x=1777309644;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nNM7H+cG2OqR7Ra2ixOopvTyh7cVlKh4JToZfip+bUU=;
 b=ZHLuWsJH0Va16wHY7wJLrwVUAUxCh3PlfCZ7paWptfSnpq5pXklmAUWmj6EmrrkptD
 Owyl8bfn05CAqYv91M5WEqa67JxNZKnaHhpxtHL8MxUMiwNFJYEBsuIzH7gekHPd0koQ
 I0UeXOdUY29Xa8R24VKcgvjvjPmdxUrY7ud1Ni11Ex4N2gwTH2pXGgmjzQueg8Kp+OHJ
 NgEnp7PWwN62KGFoYr1JFfaCLzHwJzc+rCbXNzp9BEOrA6+3dQZrU+bCVdK8wbhMISDF
 +43RRIHvaWSpOsdshe1zyBtnMI7tRUWZJR26XjMFxsaxdr9+jHUdgBgRk7eb/tKrdpZZ
 ++fQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+BCREsPQbDGQv1KZe8mt3njZY+FHQ9GdnekmwWeylO1Ud4oFP8xAC2AYljqr2EO5i8253SCIM=@lists.denx.de
X-Gm-Message-State: AOJu0YzkTWhQ655pklb0LAvj7s8h2MIYZh+R3GZI/jCE1C/pus9lfBg4
 EEZzJjwfNruj2B799/TtTty7aPcSIDtrneJMoV0gNKgzcfArEcwoYWqQimfx1Kq4kxvmGnP4sQh
 MK4zywQWzdBeqwuy6SPruq9dv3LyBZNrxezK9bLZz/w==
X-Gm-Gg: AeBDiethLFVzYnoMfW+eD03Y8r41uMrs/NQ927Qn/IrJUEGkwI3J3JzuxDhMPRSjs6g
 mS4QhqRHInObEwt9fkHxDa/UTimr74UdVjzJuuDWpPVabSxkVQ3jf9BAK73XKxQgqzONgUicQ4M
 ZspfTKO0BF7zpjN9LInthTqbSQOPlG1yVP9TVPAnfPZRepojIBVLEK333HsF6kfkJjpaar13NB9
 HadiwZRInOIJz9Njg0TQMCGVMi022Mp3BNtkP36gTHYqGtDasb3FKQgNn/1xw1YBPNBDW5NFXlF
 2GOkAztaMaOP8QQbo9sC8J4TKn8nnix/TINiulLlDWNgjDe5xyZavpq2FCU36AUPHoJcwU5jFIy
 yefudQgROEu66QqrsAP22Bmy/i+s4CkG7DFOrH/MSZQR/RTE5jqyv/Nl9q+a5W4NiYrSHt1+2nF
 Q4cZiik0JxT5FYOIO/VKKHSN6HwJ0vOsuMfFbQxUSleBsRYTLeLavXfYhqXl67rWts8/WYBMdlV
 3s6ybOmAQKPz+2QLhZP3Ng+W82D1hhz2yvS/zKN0w5e9N7Iwl2caw9PMISmkj1jtxc/VnC+Yu7S
 dVLvNrFQ44YiG3iHouB/04ExV8gvMJ1QbukQ0wTk2oaNubUsMIrEng==
X-Received: by 2002:a53:acc2:0:20b0:651:a928:4c73 with SMTP id
 956f58d0204a3-65310a68f49mr10780676d50.44.1776704843865; Mon, 20 Apr 2026
 10:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260413203555.1990337-1-rs@ti.com>
 <20260413203555.1990337-3-rs@ti.com>
 <CAC_iWj+=ukmK+vXA=T8g7xnJpCb14=DHm7GF_su+ohYTpMCoGg@mail.gmail.com>
 <DHUTP14B0Z8Q.64QEUIVV4YNB@ti.com>
 <CAC_iWjJRoKuRiLNLYeNSo6P6Mszcn=vY11-U71_N=mS0A8P+-w@mail.gmail.com>
 <DHUV5T2RE2EW.2QKJXXKF2Z3N@ti.com>
 <CAC_iWj+irf7MajW9OELsx0t1SJ_4jxebbRF0D5Oe=OjMkD+4UQ@mail.gmail.com>
 <DHVL4XXFM4DP.2NI6DUA729U5O@ti.com>
 <CAC_iWj+BGMYWvLCtfFzN+ngkW6UjSoJJMkGz0FHhyW6KmB=G7A@mail.gmail.com>
 <DHY4W2KEPMLJ.GAWHD1NKHEA2@ti.com> <DHY57GQVGF31.2FBBF7HFSZ5ET@ti.com>
In-Reply-To: <DHY57GQVGF31.2FBBF7HFSZ5ET@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 20 Apr 2026 20:06:46 +0300
X-Gm-Features: AQROBzARaSGCVDbmKbJLoD5g3w_bWAmCJqhO9hDzD_x3S40-zXv_iRMoVj7RQn4
Message-ID: <CAC_iWjJNnJRYx0+Xb9QkSaXO2d1zoeF6JkXr+ggLXxkCeJ7+zA@mail.gmail.com>
Subject: Re: [PATCHv3 2/6] lmb: add LMB_FDT for fdt reserved regions
To: Randolph Sapp <rs@ti.com>
Cc: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, xypron.glpk@gmx.de, u-boot@lists.denx.de
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

On Mon, 20 Apr 2026 at 20:03, Randolph Sapp <rs@ti.com> wrote:
>
> On Mon Apr 20, 2026 at 11:47 AM CDT, Randolph Sapp wrote:
> > On Mon Apr 20, 2026 at 9:30 AM CDT, Ilias Apalodimas wrote:
> >> On Fri, 17 Apr 2026 at 19:53, Randolph Sapp <rs@ti.com> wrote:
> >>>
> >>> On Fri Apr 17, 2026 at 3:12 AM CDT, Ilias Apalodimas wrote:
> >>> > On Thu, 16 Apr 2026 at 23:32, Randolph Sapp <rs@ti.com> wrote:
> >>> >>
> >>> >> On Thu Apr 16, 2026 at 2:54 PM CDT, Ilias Apalodimas wrote:
> >>> >> > On Thu, 16 Apr 2026 at 22:23, Randolph Sapp <rs@ti.com> wrote:
> >>> >> >>
> >>> >> >> On Thu Apr 16, 2026 at 3:39 AM CDT, Ilias Apalodimas wrote:
> >>> >> >> > Hi Randolph.
> >>> >> >> >
> >>> >> >> > On Mon, 13 Apr 2026 at 23:36, <rs@ti.com> wrote:
> >>> >> >> >>
> >>> >> >> >> From: Randolph Sapp <rs@ti.com>
> >>> >> >> >>
> >>> >> >> >> Add an LMB_FDT bit for fdt reserved regions, so we can reclaim them when
> >>> >> >> >> parsing a new device tree and properly warn people when a reservation
> >>> >> >> >> overlaps with an existing allocation.
> >>> >> >> >
> >>> >> >> > The LMB has a set of regions that clearly describe memory in an
> >>> >> >> > abstact way, e.g reserved, no overwrite etc.
> >>> >> >> > I don't think adding we should open the door for treating reserved
> >>> >> >> > memory as special. Can't we apply the same fix without adding a new
> >>> >> >> > description?
> >>> >> >> >
> >>> >> >> > Thanks
> >>> >> >> > /Ilias
> >>> >> >>
> >>> >> >> I did have an initial implementation using a separate allocation list for fdt
> >>> >> >> regions in LMB. It works, but boy it's much more messy. All allocations and
> >>> >> >> frees had to check both the regular allocation list and the fdt allocation list.
> >>> >> >>
> >>> >> >> I thought about having the fdt helpers build their own local list separate from
> >>> >> >> LMB, but that's also a little messy in that it means we're either double
> >>> >> >> tracking regions or tying to reach into the guts of LMB to extract information
> >>> >> >> about that existing allocation region.
> >>> >> >>
> >>> >> >> Maybe that's fine considering LMB already reaches out to kick
> >>> >> >> boot_fdt_add_mem_rsv_regions. Just trying to keep things compartmentalized at
> >>> >> >> the moment.
> >>> >> >>
> >>> >> >> I'll revisit the localized reservation list for image-fdt. I'll just setup some
> >>> >> >> goofy linked list to track allocation start and size for the later free. I
> >>> >> >> assume we prefer a separate set of lmb_region structs for that list as it's a
> >>> >> >> little concerning to pass references to an active LMB region outside of the LMB
> >>> >> >> core.
> >>> >> >
> >>> >> > Can you explain a bit more when the problem happens? Is it because
> >>> >> > boot_fdt_add_mem_rsv_regions() get called twice in some boot flows? Or
> >>> >> > is there another reason?
> >>> >> >
> >>> >> > Thanks
> >>> >> > /Ilias
> >>> >>
> >>> >> The initial comment explicitly calls out that as the reason they disabled the
> >>> >> warning, but it should occur any time a device tree is loaded. Internal or
> >>> >> external.
> >>> >>
> >>> >
> >>> > Yes, but that's requesting to reserve specific address(es) which is
> >>> > always the same address ranges unless the DTB changes.  In which case
> >>> > you just have to find and free the reserved-ranges. Keeping in mind
> >>> > that's rare, you can re-parse the DT with minimal overhead and you
> >>> > dont have to keep any metadat stored in LMB or anywhere else. and the
> >>> > LMB subsystem is not the place to do that. The EEXIST basically means
> >>> > "I've already done that" here so I am trying to understand what can
> >>> > trigger this problem.
> >>> >
> >>> >> That also lead me to believe if one were to load multiple external device trees
> >>> >> that you could theoretically trip an OOM with a bunch of non-overlapping
> >>> >> reserved regions. I have yet to test that, but culling old allocations seemed
> >>> >> practical enough without that PoC.
> >>> >
> >>> > Yea but that's a user error. You can also load a bigger binary that
> >>> > your entire DRAM and trigger an OOM
> >>> >
> >>> > Thanks
> >>> > /Ilias
> >>>
> >>> The explicit case were I really wish we had this warning was when the u-boot
> >>> stack was creeping into a FDT reserved region. The FDT reservation naturally
> >>> failed with EEXIST. That error is overloaded as is. We have to track the
> >>> reservations we successfully create in order to clean them up properly.
> >>
> >> Ok, I think we might have a similar issue to the EFI subsystem then,
> >> were we can unload and replace the DT based on various config options.
> >> Why don't we just add a function that read the (existing loaded) DT
> >> and free the LMB regions based on the DT info?
> >>
> >> Cheers
> >> /Ilias
> >
> > I did think about that for a bit. Issue is, we need to make sure that function
> > gets called in all of the paths this function is expected to be called prior to
> > the device tree being switched out. It's doable, but it's a little less
> > foolproof.
>
> It would also have to blindly assume the reservation worked the first time. No
> way to know if something else just so happened to reserve that region before the
> device tree. Fingers crossed freeing it won't be a problem.

Yea I think that's fine. Because if it didn't work we should report
that way earlier (and perhaps stop loading because that's a critical
error) before we reach the point of freeing it.

Cheers
/Ilias
>
> > I'll play around with that idea a little more, as it's certainly better for
> > low-mem applications. My localized tracking patch is here if anyone's curious
> > about that implementation:
> >
> > https://github.com/StaticRocket/u-boot/commit/d0d86e065c9a3588977f4bebf6fd783936de0c82
> >
> >>>
> >>> >>
> >>> >> >>
> >>> >> >> >>
> >>> >> >> >> If we don't at least warn the user of these reservation failures,
> >>> >> >> >> there's a chance that this region could be freed and reallocated for
> >>> >> >> >> something important later.
> >>> >> >> >>
> >>> >> >> >> This useful warning mechanism was broken in:
> >>> >> >> >> 5a6aa7d5913 ("boot: fdt: Handle already reserved memory in boot_fdt_reserve_region()")
> >>> >> >> >>
> >>> >> >> >> Signed-off-by: Randolph Sapp <rs@ti.com>
> >>> >> >> >> ---
> >>> >> >> >>  boot/image-fdt.c |  5 ++++-
> >>> >> >> >>  include/lmb.h    | 14 ++++++++++++++
> >>> >> >> >>  lib/lmb.c        | 33 +++++++++++++++++++++++++++++----
> >>> >> >> >>  3 files changed, 47 insertions(+), 5 deletions(-)
> >>> >> >> >>
> >>> >> >> >> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> >>> >> >> >> index a3a4fb8b558..0f5857f24d2 100644
> >>> >> >> >> --- a/boot/image-fdt.c
> >>> >> >> >> +++ b/boot/image-fdt.c
> >>> >> >> >> @@ -73,6 +73,7 @@ static void boot_fdt_reserve_region(u64 addr, u64 size, u32 flags)
> >>> >> >> >>  {
> >>> >> >> >>         long ret;
> >>> >> >> >>         phys_addr_t rsv_addr;
> >>> >> >> >> +       flags |= LMB_FDT;
> >>> >> >> >>
> >>> >> >> >>         rsv_addr = (phys_addr_t)addr;
> >>> >> >> >>         ret = lmb_alloc_mem(LMB_MEM_ALLOC_ADDR, 0, &rsv_addr, size, flags);
> >>> >> >> >> @@ -80,7 +81,7 @@ static void boot_fdt_reserve_region(u64 addr, u64 size, u32 flags)
> >>> >> >> >>                 debug("   reserving fdt memory region: addr=%llx size=%llx flags=%x\n",
> >>> >> >> >>                       (unsigned long long)addr,
> >>> >> >> >>                       (unsigned long long)size, flags);
> >>> >> >> >> -       } else if (ret != -EEXIST && ret != -EINVAL) {
> >>> >> >> >> +       } else if (ret != -EINVAL) {
> >>> >> >> >>                 puts("ERROR: reserving fdt memory region failed ");
> >>> >> >> >>                 printf("(addr=%llx size=%llx flags=%x)\n",
> >>> >> >> >>                        (unsigned long long)addr,
> >>> >> >> >> @@ -108,6 +109,8 @@ void boot_fdt_add_mem_rsv_regions(void *fdt_blob)
> >>> >> >> >>         if (fdt_check_header(fdt_blob) != 0)
> >>> >> >> >>                 return;
> >>> >> >> >>
> >>> >> >> >> +       lmb_free_fdt_regions();
> >>> >> >> >> +
> >>> >> >> >>         /* process memreserve sections */
> >>> >> >> >>         total = fdt_num_mem_rsv(fdt_blob);
> >>> >> >> >>         for (i = 0; i < total; i++) {
> >>> >> >> >> diff --git a/include/lmb.h b/include/lmb.h
> >>> >> >> >> index 427d701bc30..c6a1fc1ca47 100644
> >>> >> >> >> --- a/include/lmb.h
> >>> >> >> >> +++ b/include/lmb.h
> >>> >> >> >> @@ -51,6 +51,15 @@
> >>> >> >> >>   */
> >>> >> >> >>  #define LMB_NONOTIFY BIT(3)
> >>> >> >> >>
> >>> >> >> >> +/**
> >>> >> >> >> + * define LMB_FDT - reclaim this region with lmb_free_fdt_regions()
> >>> >> >> >> + *
> >>> >> >> >> + * LMB Memory region attribute flag to indicate that the region will be
> >>> >> >> >> + * reclaimed with lmb_free_fdt_regions(). This allows device tree reservations
> >>> >> >> >> + * to be cleaned up and tracked more granularly.
> >>> >> >> >> + */
> >>> >> >> >> +#define LMB_FDT BIT(4)
> >>> >> >> >> +
> >>> >> >> >>  /**
> >>> >> >> >>   * enum lmb_mem_type - type of memory allocation request
> >>> >> >> >>   * @LMB_MEM_ALLOC_ADDR:        request for a particular region of memory
> >>> >> >> >> @@ -235,6 +244,11 @@ phys_addr_t io_lmb_alloc(struct lmb *io_lmb, phys_size_t size, ulong align);
> >>> >> >> >>   */
> >>> >> >> >>  long io_lmb_free(struct lmb *io_lmb, phys_addr_t base, phys_size_t size);
> >>> >> >> >>
> >>> >> >> >> +/**
> >>> >> >> >> + * lmb_free_fdt_regions() - Reclaim all %LMB_FDT tagged reserved regions
> >>> >> >> >> + */
> >>> >> >> >> +void lmb_free_fdt_regions(void);
> >>> >> >> >> +
> >>> >> >> >>  #endif /* __KERNEL__ */
> >>> >> >> >>
> >>> >> >> >>  #endif /* _LINUX_LMB_H */
> >>> >> >> >> diff --git a/lib/lmb.c b/lib/lmb.c
> >>> >> >> >> index 8f12c6ad8e5..7ecc548d831 100644
> >>> >> >> >> --- a/lib/lmb.c
> >>> >> >> >> +++ b/lib/lmb.c
> >>> >> >> >> @@ -463,10 +463,10 @@ static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size,
> >>> >> >> >>
> >>> >> >> >>  static void lmb_print_region_flags(u32 flags)
> >>> >> >> >>  {
> >>> >> >> >> -       const char * const flag_str[] = { "none", "no-map", "no-overwrite",
> >>> >> >> >> -                                         "no-notify" };
> >>> >> >> >> -       unsigned int pflags = flags &
> >>> >> >> >> -                             (LMB_NOMAP | LMB_NOOVERWRITE | LMB_NONOTIFY);
> >>> >> >> >> +       const char *const flag_str[] = { "none", "no-map", "no-overwrite",
> >>> >> >> >> +                                        "no-notify", "fdt" };
> >>> >> >> >> +       unsigned int pflags =
> >>> >> >> >> +               flags & (LMB_NOMAP | LMB_NOOVERWRITE | LMB_NONOTIFY | LMB_FDT);
> >>> >> >> >>
> >>> >> >> >>         if (flags != pflags) {
> >>> >> >> >>                 printf("invalid %#x\n", flags);
> >>> >> >> >> @@ -654,6 +654,31 @@ long lmb_free(phys_addr_t base, phys_size_t size, u32 flags)
> >>> >> >> >>         return lmb_map_update_notify(base, size, LMB_MAP_OP_FREE, flags);
> >>> >> >> >>  }
> >>> >> >> >>
> >>> >> >> >> +void lmb_free_fdt_regions(void)
> >>> >> >> >> +{
> >>> >> >> >> +       struct alist *lmb_rgn_lst = &lmb.used_mem;
> >>> >> >> >> +       struct lmb_region *rgn = lmb_rgn_lst->data;
> >>> >> >> >> +       long ret;
> >>> >> >> >> +       int i = 0;
> >>> >> >> >> +
> >>> >> >> >> +       while (i < lmb_rgn_lst->count) {
> >>> >> >> >> +               phys_addr_t base = rgn[i].base;
> >>> >> >> >> +               phys_size_t size = rgn[i].size;
> >>> >> >> >> +               u32 flags = rgn[i].flags;
> >>> >> >> >> +
> >>> >> >> >> +               if (flags & LMB_FDT) {
> >>> >> >> >> +                       ret = lmb_free(base, size, flags);
> >>> >> >> >> +                       if (ret < 0) {
> >>> >> >> >> +                               printf("Unable to free FDT memory at 0x%08lx\n",
> >>> >> >> >> +                                      (ulong)base);
> >>> >> >> >> +                               i++;
> >>> >> >> >> +                       }
> >>> >> >> >> +               } else {
> >>> >> >> >> +                       i++;
> >>> >> >> >> +               }
> >>> >> >> >> +       }
> >>> >> >> >> +}
> >>> >> >> >> +
> >>> >> >> >>  static int _lmb_alloc_base(phys_size_t size, ulong align,
> >>> >> >> >>                            phys_addr_t *addr, u32 flags)
> >>> >> >> >>  {
> >>> >> >> >> --
> >>> >> >> >> 2.53.0
> >>> >> >> >>
> >>> >> >>
> >>> >>
> >>>
>
