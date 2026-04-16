Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F7A0F8D775
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 19:54:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 068AC841F2;
	Thu, 16 Apr 2026 21:54:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WNgNsSsh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA31883EEF; Thu, 16 Apr 2026 21:54:52 +0200 (CEST)
Received: from mail-yx1-xb133.google.com (mail-yx1-xb133.google.com
 [IPv6:2607:f8b0:4864:20::b133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E0AE83EEF
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 21:54:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-650789b22e3so9855012d50.1
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 12:54:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776369289; cv=none;
 d=google.com; s=arc-20240605;
 b=T4QGuwqeCIB7/dlcwZSFWvH40MIb0aYx3WkcUgrR4gkfqlO/K1/LL4cA7sT8pw1U+m
 Wobx704h1GIMw9w9hzDIo2dHJ/o0XT9YdGAAH/RhcZkC3J12lnGPWkCWfluW6/hwDVr/
 lmm0HXfq3XPxqgN9vLPNrnI4L2OgQh8u1dPckUlcvJog0zmEeT8mY9CPQaWdQwOGXDgw
 m6uEnDFsfTEBiSHk67gRbX3x9JEn4N6tdq0ikIvxCxA7185qKyyLm8ltXCdL0Cv1Y6q3
 Bgh+XfpNb3SrM9UsTfgzHjFMXrBoUekHWKAWYmJWQuVzxrrd8afXAcZIgVIgV/Ft1/v1
 oezg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=y/Ms3YXFFWdC8HunHda/2F2fpkQ5yIYjb7gIFRLGR50=;
 fh=aNZCeVXI75hsTZEZgHzjEkpPw9QzDCuy/OQeWOk5+u4=;
 b=BvJXuH9reS31u6vjei0Vm7qGzmR2RbU8E/or+HmlNDX/NRz+LGwgm4S8vl2MQUF80s
 N5weJXk06C0a7ttesiibIgxQpochcV5JcaupZyYKQOSz6fyC7y2CEEihohUCNZ2hMBgq
 HdK+PtYiP0QdV+gasNk838QgZgShD5bFueo8AnzqPDG/4ItUotTqMqL7kBXMigjSvr0Y
 AwcS8XXwsujiKejcOivqhf+n/CMLjok6QFMJCAthQfz74QBg5bYMGuvp2kS5gr5ugB2G
 cyGEe6W0JjXhmnTccreNB9ATKc1rAFfyAx2jrhzIRICNh1rp6YKHE3jgwS0xCfPYGfxv
 PUWQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776369289; x=1776974089; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y/Ms3YXFFWdC8HunHda/2F2fpkQ5yIYjb7gIFRLGR50=;
 b=WNgNsSshVxL52Ewqob0vTbcsGk4JuyTz0y25rUYRWGs/bgfStlop8kSbuF7j5DARIw
 wHYvn8RhXmCE2JEjiLJ40yODjE7NYWjrVab1344YgYCp+jgN+o7s3UtB5hFNTEIKmRhe
 BXWZLrOAjUb9Ve+UFO/K+oWWEukq1luj4pBBef0s8ESPdJjo+8CC8T7977cN0udebxB+
 wLX6s9nTLClPNPilQRXFHuukN9QSmsKJ7D3VQ036UwwZcBvXrRiQRO+RFUuJJhNWYhsX
 5VG2m3164gD69PxqZnj7n3tNxgSCY9vsHz1i1+S3SBAV4OlRmSqTFHdiq8/yDjABB9UM
 EmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776369289; x=1776974089;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y/Ms3YXFFWdC8HunHda/2F2fpkQ5yIYjb7gIFRLGR50=;
 b=H6bkX4Ts+LyGv4eLcLDib5DEe4B8qDTge1K8ZjywBkMLMWHjEmBlcRnM+bNlJS2dqh
 0AXfYHy1DzilCY8xByoFlnakeSQSWXQHD6ZIHZUXwIusetx3OoRLRywf9TioV0k/Ne8e
 0dzZxM0FUdHV9VeMhxtpQLsjj1y0mntSgmReAWM9eMY+pcIEKXNiX8sc1VKXJgm966PM
 h96rIkXZ8n/2yIYnSEp1DjF4uWmB9n+djyxXhNzLDY1Evf9YH9wr9DKJgKKAPSklAXTU
 lucBppS7p0WMFBhzeDHyeKwGnHX9HBIYaED+t4T10TWovP8wdd7G3HtFLBA6ZorZxj7c
 WfJA==
X-Forwarded-Encrypted: i=1;
 AFNElJ99T/IUo/iewoOYFb8rBSl43YgFcN33ty/yBt/Q2CqQc5jfQsQfvqI6DvVXgryDKLVnQ80jB+w=@lists.denx.de
X-Gm-Message-State: AOJu0YyDtMRD8kgvhzEdHe7IqCNZscbStdLjLLFWoE3qKAtVMiV9Sf3U
 JIrFDuH2g31RqfAvvL4KT6S1PU7ejVWwY5QNrxfR7Cmy7n+r0npEhpVJQ/XuxU08jHACmMgaK8z
 fC84W3c9d1R2/DJ/QITIWmMLdk7BATukERUAq/RBqkg==
X-Gm-Gg: AeBDievqvRV52d8gsi1ozXQPqVzyaurXTN6zXjCE2q4G3NmVnDhglf7x9O0YAmpB8hu
 VjYuH5campKVSdPEXz4y3RLaaAt6nFWtxtPWbUKIo+FlWxFDQB09mQKER71kXx3rbvxaVAMwZo2
 qxr1gccghpcDUExnL5kXic7kxJ48pY0Oew0K7F64DReJcJ/cQj5OP8go/mdYg56NV6RVABAmDVu
 n5/qB/hhQVnafsBg+gxe9iJtH9Pdd1WGI1dq4mVHgpBWKANIrAydF/ClINlJCmrBMVWCWNkZ6B9
 5axl0F+RWwbIbri7RKfpLSUf1KwJ3205XOxMuqiqs9wjDDTrnL2qexxoTod4yL6dbL3GoVj0rZE
 7dfdOoq6Z3/UsNuY79lCVdMyT1YdTidZYiFFQJoZ/yc6jc6LF/cquSpl/L1BQcb+l9gczULr9BX
 wt4rgZofkejEIxNPBnknDLjcL1jNmiPLZErAoanGHtaPPLkRAC6dyj1PMFddAeBYc1EFT9h6JqU
 XpCZDU6NFgrLXxOlrOnVnOjKAvMucNBqq/3gEnVunmYaeUffoPV9BoGSbl0p7siUWBS2rkaKJlL
 0dxPSVZqBl2XmKgYIuoGJkxafty0tV/uLwudu6sDn8yvlsYQ3o/Pyg==
X-Received: by 2002:a53:accb:0:10b0:64d:6a5a:ac29 with SMTP id
 956f58d0204a3-65310b456cbmr5030d50.55.1776369288898; Thu, 16 Apr 2026
 12:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260413203555.1990337-1-rs@ti.com>
 <20260413203555.1990337-3-rs@ti.com>
 <CAC_iWj+=ukmK+vXA=T8g7xnJpCb14=DHm7GF_su+ohYTpMCoGg@mail.gmail.com>
 <DHUTP14B0Z8Q.64QEUIVV4YNB@ti.com>
In-Reply-To: <DHUTP14B0Z8Q.64QEUIVV4YNB@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 16 Apr 2026 22:54:13 +0300
X-Gm-Features: AQROBzDvS8NkvlUhB6oTLVR4NcXZE1mO6s49ubbYbLXNRmbp5NfwUYRlcv86KLw
Message-ID: <CAC_iWjJRoKuRiLNLYeNSo6P6Mszcn=vY11-U71_N=mS0A8P+-w@mail.gmail.com>
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

On Thu, 16 Apr 2026 at 22:23, Randolph Sapp <rs@ti.com> wrote:
>
> On Thu Apr 16, 2026 at 3:39 AM CDT, Ilias Apalodimas wrote:
> > Hi Randolph.
> >
> > On Mon, 13 Apr 2026 at 23:36, <rs@ti.com> wrote:
> >>
> >> From: Randolph Sapp <rs@ti.com>
> >>
> >> Add an LMB_FDT bit for fdt reserved regions, so we can reclaim them when
> >> parsing a new device tree and properly warn people when a reservation
> >> overlaps with an existing allocation.
> >
> > The LMB has a set of regions that clearly describe memory in an
> > abstact way, e.g reserved, no overwrite etc.
> > I don't think adding we should open the door for treating reserved
> > memory as special. Can't we apply the same fix without adding a new
> > description?
> >
> > Thanks
> > /Ilias
>
> I did have an initial implementation using a separate allocation list for fdt
> regions in LMB. It works, but boy it's much more messy. All allocations and
> frees had to check both the regular allocation list and the fdt allocation list.
>
> I thought about having the fdt helpers build their own local list separate from
> LMB, but that's also a little messy in that it means we're either double
> tracking regions or tying to reach into the guts of LMB to extract information
> about that existing allocation region.
>
> Maybe that's fine considering LMB already reaches out to kick
> boot_fdt_add_mem_rsv_regions. Just trying to keep things compartmentalized at
> the moment.
>
> I'll revisit the localized reservation list for image-fdt. I'll just setup some
> goofy linked list to track allocation start and size for the later free. I
> assume we prefer a separate set of lmb_region structs for that list as it's a
> little concerning to pass references to an active LMB region outside of the LMB
> core.

Can you explain a bit more when the problem happens? Is it because
boot_fdt_add_mem_rsv_regions() get called twice in some boot flows? Or
is there another reason?

Thanks
/Ilias
>
> >>
> >> If we don't at least warn the user of these reservation failures,
> >> there's a chance that this region could be freed and reallocated for
> >> something important later.
> >>
> >> This useful warning mechanism was broken in:
> >> 5a6aa7d5913 ("boot: fdt: Handle already reserved memory in boot_fdt_reserve_region()")
> >>
> >> Signed-off-by: Randolph Sapp <rs@ti.com>
> >> ---
> >>  boot/image-fdt.c |  5 ++++-
> >>  include/lmb.h    | 14 ++++++++++++++
> >>  lib/lmb.c        | 33 +++++++++++++++++++++++++++++----
> >>  3 files changed, 47 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> >> index a3a4fb8b558..0f5857f24d2 100644
> >> --- a/boot/image-fdt.c
> >> +++ b/boot/image-fdt.c
> >> @@ -73,6 +73,7 @@ static void boot_fdt_reserve_region(u64 addr, u64 size, u32 flags)
> >>  {
> >>         long ret;
> >>         phys_addr_t rsv_addr;
> >> +       flags |= LMB_FDT;
> >>
> >>         rsv_addr = (phys_addr_t)addr;
> >>         ret = lmb_alloc_mem(LMB_MEM_ALLOC_ADDR, 0, &rsv_addr, size, flags);
> >> @@ -80,7 +81,7 @@ static void boot_fdt_reserve_region(u64 addr, u64 size, u32 flags)
> >>                 debug("   reserving fdt memory region: addr=%llx size=%llx flags=%x\n",
> >>                       (unsigned long long)addr,
> >>                       (unsigned long long)size, flags);
> >> -       } else if (ret != -EEXIST && ret != -EINVAL) {
> >> +       } else if (ret != -EINVAL) {
> >>                 puts("ERROR: reserving fdt memory region failed ");
> >>                 printf("(addr=%llx size=%llx flags=%x)\n",
> >>                        (unsigned long long)addr,
> >> @@ -108,6 +109,8 @@ void boot_fdt_add_mem_rsv_regions(void *fdt_blob)
> >>         if (fdt_check_header(fdt_blob) != 0)
> >>                 return;
> >>
> >> +       lmb_free_fdt_regions();
> >> +
> >>         /* process memreserve sections */
> >>         total = fdt_num_mem_rsv(fdt_blob);
> >>         for (i = 0; i < total; i++) {
> >> diff --git a/include/lmb.h b/include/lmb.h
> >> index 427d701bc30..c6a1fc1ca47 100644
> >> --- a/include/lmb.h
> >> +++ b/include/lmb.h
> >> @@ -51,6 +51,15 @@
> >>   */
> >>  #define LMB_NONOTIFY BIT(3)
> >>
> >> +/**
> >> + * define LMB_FDT - reclaim this region with lmb_free_fdt_regions()
> >> + *
> >> + * LMB Memory region attribute flag to indicate that the region will be
> >> + * reclaimed with lmb_free_fdt_regions(). This allows device tree reservations
> >> + * to be cleaned up and tracked more granularly.
> >> + */
> >> +#define LMB_FDT BIT(4)
> >> +
> >>  /**
> >>   * enum lmb_mem_type - type of memory allocation request
> >>   * @LMB_MEM_ALLOC_ADDR:        request for a particular region of memory
> >> @@ -235,6 +244,11 @@ phys_addr_t io_lmb_alloc(struct lmb *io_lmb, phys_size_t size, ulong align);
> >>   */
> >>  long io_lmb_free(struct lmb *io_lmb, phys_addr_t base, phys_size_t size);
> >>
> >> +/**
> >> + * lmb_free_fdt_regions() - Reclaim all %LMB_FDT tagged reserved regions
> >> + */
> >> +void lmb_free_fdt_regions(void);
> >> +
> >>  #endif /* __KERNEL__ */
> >>
> >>  #endif /* _LINUX_LMB_H */
> >> diff --git a/lib/lmb.c b/lib/lmb.c
> >> index 8f12c6ad8e5..7ecc548d831 100644
> >> --- a/lib/lmb.c
> >> +++ b/lib/lmb.c
> >> @@ -463,10 +463,10 @@ static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size,
> >>
> >>  static void lmb_print_region_flags(u32 flags)
> >>  {
> >> -       const char * const flag_str[] = { "none", "no-map", "no-overwrite",
> >> -                                         "no-notify" };
> >> -       unsigned int pflags = flags &
> >> -                             (LMB_NOMAP | LMB_NOOVERWRITE | LMB_NONOTIFY);
> >> +       const char *const flag_str[] = { "none", "no-map", "no-overwrite",
> >> +                                        "no-notify", "fdt" };
> >> +       unsigned int pflags =
> >> +               flags & (LMB_NOMAP | LMB_NOOVERWRITE | LMB_NONOTIFY | LMB_FDT);
> >>
> >>         if (flags != pflags) {
> >>                 printf("invalid %#x\n", flags);
> >> @@ -654,6 +654,31 @@ long lmb_free(phys_addr_t base, phys_size_t size, u32 flags)
> >>         return lmb_map_update_notify(base, size, LMB_MAP_OP_FREE, flags);
> >>  }
> >>
> >> +void lmb_free_fdt_regions(void)
> >> +{
> >> +       struct alist *lmb_rgn_lst = &lmb.used_mem;
> >> +       struct lmb_region *rgn = lmb_rgn_lst->data;
> >> +       long ret;
> >> +       int i = 0;
> >> +
> >> +       while (i < lmb_rgn_lst->count) {
> >> +               phys_addr_t base = rgn[i].base;
> >> +               phys_size_t size = rgn[i].size;
> >> +               u32 flags = rgn[i].flags;
> >> +
> >> +               if (flags & LMB_FDT) {
> >> +                       ret = lmb_free(base, size, flags);
> >> +                       if (ret < 0) {
> >> +                               printf("Unable to free FDT memory at 0x%08lx\n",
> >> +                                      (ulong)base);
> >> +                               i++;
> >> +                       }
> >> +               } else {
> >> +                       i++;
> >> +               }
> >> +       }
> >> +}
> >> +
> >>  static int _lmb_alloc_base(phys_size_t size, ulong align,
> >>                            phys_addr_t *addr, u32 flags)
> >>  {
> >> --
> >> 2.53.0
> >>
>
