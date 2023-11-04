Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74946C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 19:44:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A682486FC3;
	Sat,  4 Nov 2023 20:43:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QZ0Qdlve";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9218186FC3; Sat,  4 Nov 2023 20:43:50 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8814086EEE
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 20:43:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-543456dbd7bso8313481a12.1
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 12:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699127027; x=1699731827; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l3yJEC9vMFMC+ibU4McUpNLgpuwgxq7rrtldncx2KLU=;
 b=QZ0Qdlve50FBmfcEw9Of2hn82JZLERt0Y9OTKcCOYBwQ1LVkB1gT/Qp6a0Ji9/Ae59
 BhuOer7uTeoE5fyL0k4HCYPL+VUQL0Mcvc6XbvP7JHQVPTtTmGPRcTtKaynFmFjWepCc
 TOv3q67cPJ9bVj7deOxHeWxlNijmY2T5f7i2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699127027; x=1699731827;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l3yJEC9vMFMC+ibU4McUpNLgpuwgxq7rrtldncx2KLU=;
 b=usNYIxJw/jNzIzb8os/NyyfrKW2kzfzhKg/UnmlGuz0bhL94zvnPTghW2vCBHhoqZd
 d5M49gGJ/VVtuenK5oF0wfdiQoIM5PM6KBE2h9EECaTHflsfiZevuTVGvwW7ltiXb/1U
 hVi7VkTC7a3ErIOu3zTYq00fZoBV7CoiZKRWRUd7Vg+jBCqA33sVPRhsEuuHN5j/HgaP
 kIgTdgpB3BP08yFfyFFVeRYf3MbEXPZaI3ayEU8TEhmmUw1DRFqLOderVAGUcmVCfUIG
 Dm7aHrcS0PcHJAra+lgwXsFVuR3BKQp7kRL7ZXPy+X5pMO/9+kFjZXDCL908PuPN6ZKI
 XaUw==
X-Gm-Message-State: AOJu0Yxz4lfT2JCa87FS0ccUGe09rwWiTpB7nD9b6kus4w1sQTpqkzqI
 fGHIJz84q+ChHIdCULg7K+U5PaxODDKnDkT/jlIOeg==
X-Google-Smtp-Source: AGHT+IFRXsFSf41fMspDJNMoVgPh0U6Tmkc/E6h2Ar6U8bluYQ+iKDe9H4mbs4dUeoSboGnBfG8byKMwdiXziVFJJHE=
X-Received: by 2002:a05:6402:5191:b0:52e:3ce8:e333 with SMTP id
 q17-20020a056402519100b0052e3ce8e333mr6497900edd.18.1699127026908; Sat, 04
 Nov 2023 12:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <20231031131208.435268-1-devarsht@ti.com>
 <20231031131208.435268-2-devarsht@ti.com>
 <CAPnjgZ3U_HDUfm+GBDSm44FZFx7n5nrZbM3gHHYkyYj7P2582w@mail.gmail.com>
 <24320603-e448-11e1-fb80-74db72fb009c@ti.com>
In-Reply-To: <24320603-e448-11e1-fb80-74db72fb009c@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 4 Nov 2023 19:43:35 +0000
Message-ID: <CAPnjgZ3_sRxW+qf60GdQ+fq9zYfKeBWObhs0HrJB07V5TE9NjQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] arm: mach-k3: common: Reserve video memory from
 end of the RAM
To: Devarsh Thakkar <devarsht@ti.com>
Cc: u-boot@lists.denx.de, agust@denx.de, trini@konsulko.com, 
 bmeng.cn@gmail.com, msuchanek@suse.de, rasmus.villemoes@prevas.dk, 
 yangshiji66@outlook.com, praneeth@ti.com, nm@ti.com, vigneshr@ti.com, 
 a-bhatia1@ti.com, j-luthra@ti.com, nsekhar@ti.com, n-jain1@ti.com
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

Hi Devarsh,

On Fri, 3 Nov 2023 at 11:48, Devarsh Thakkar <devarsht@ti.com> wrote:
>
> Hi Simon,
>
> Thanks for the review.
>
> On 03/11/23 04:16, Simon Glass wrote:
> > Hi Devarsh,
> >
> > On Tue, 31 Oct 2023 at 13:12, Devarsh Thakkar <devarsht@ti.com> wrote:
> >>
> >> Add function spl_reserve_video which is a wrapper
> >> around video_reserve to setup video memory and update
> >> the relocation address pointer.
> >>
> >> Setup video memory before page table reservation so that
> >> framebuffer memory gets reserved from the end of RAM.
> >>
> >> This is as per the new policy being discussed for passing
> >> blobs where each of the reserved areas for bloblists
> >> to be passed need to be reserved at the end of RAM.
> >>
> >> This is done to enable the next stage to directly skip
> >> the pre-reserved area from previous stage right from the end of RAM
> >> without having to make any gaps/holes to accommodate those
> >> regions which was the case before as previous stage
> >> reserved region not from the end of RAM.
> >>
> >> Suggested-by: Simon Glass <sjg@chromium.org>
> >> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> >> ---
> >> V2: Make a generic function "spl_reserve_video" under
> >>      common/spl which can be re-used by other platforms too
> >>      for reserving video memory from spl.
> >> ---
> >>   arch/arm/mach-k3/common.c |  2 ++
> >>   common/spl/spl.c          | 19 +++++++++++++++++++
> >>   include/spl.h             |  4 ++++
> >>   3 files changed, 25 insertions(+)
> >
> >>
> >> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> >> index c3006ba387..03e3b46282 100644
> >> --- a/arch/arm/mach-k3/common.c
> >> +++ b/arch/arm/mach-k3/common.c
> >> @@ -537,6 +537,8 @@ void spl_enable_dcache(void)
> >>          if (ram_top >= 0x100000000)
> >>                  ram_top = (phys_addr_t) 0x100000000;
> >>
> >> +       gd->relocaddr = ram_top;
> >> +       spl_reserve_video();
> >
> > Need to check error here
> >
>
> Ok, I can check for error and print a message, but would still proceed
> with build (similar to reserve_video in u-boot proper (from which this
> is derived)), I hope that is fine.

No, we need to fail if something is wrong.

>
> >>          gd->arch.tlb_addr = ram_top - gd->arch.tlb_size;
> >>          gd->arch.tlb_addr &= ~(0x10000 - 1);
> >>          debug("TLB table from %08lx to %08lx\n", gd->arch.tlb_addr,
> >> diff --git a/common/spl/spl.c b/common/spl/spl.c
> >> index 732d90d39e..89172f2ebf 100644
> >> --- a/common/spl/spl.c
> >> +++ b/common/spl/spl.c
> >> @@ -41,6 +41,7 @@
> >>   #include <fdt_support.h>
> >>   #include <bootcount.h>
> >>   #include <wdt.h>
> >> +#include <video.h>
> >>
> >>   DECLARE_GLOBAL_DATA_PTR;
> >>   DECLARE_BINMAN_MAGIC_SYM;
> >> @@ -151,6 +152,24 @@ void spl_fixup_fdt(void *fdt_blob)
> >>   #endif
> >>   }
> >>
> >> +int spl_reserve_video(void)
> >> +{
> >> +       if (CONFIG_IS_ENABLED(VIDEO)) {
> >> +               ulong addr;
> >> +               int ret;
> >> +
> >> +               addr = gd->relocaddr;
> >> +               ret = video_reserve(&addr);
> >> +               if (ret)
> >> +                       return ret;
> >> +               debug("Reserving %luk for video at: %08lx\n",
> >> +                     ((unsigned long)gd->relocaddr - addr) >> 10, addr);
> >> +               gd->relocaddr = addr;
> >> +       }
> >> +
> >> +       return 0;
> >> +}
> >> +
> >>   ulong spl_get_image_pos(void)
> >>   {
> >>          if (!CONFIG_IS_ENABLED(BINMAN_UBOOT_SYMBOLS))
> >> diff --git a/include/spl.h b/include/spl.h
> >> index 0d49e4a454..9682e51fc1 100644
> >> --- a/include/spl.h
> >> +++ b/include/spl.h
> >> @@ -825,6 +825,10 @@ int spl_usb_load(struct spl_image_info *spl_image,
> >>
> >>   int spl_ymodem_load_image(struct spl_image_info *spl_image,
> >>                            struct spl_boot_device *bootdev);
> >> +/**
> >> + * spl_reserve_video() - Reserve video and update relocation address
> >
> > This needs more detail about:
> > - gd->relocaddr
>
> Points to current relocation address which points to region below
> reserved area ?
>
> > - where the video memory is allocated
> I didn't get you, allocation is stored in RAM, is that what you mean ?

Yes, but specifically at the top of RAM, I believe?

>
> > - where the allocation is stored (in the video-device plat?)ok
>
> > - return value
> >
>
> Just a point of note, this spl_reserve_video is inspired by
> reserve_video from u-boot proper and we are essentially leaving upto
> users to follow the "guideline" to reserve video from RAM by setting
> gd->relocaddr to end of RAM before calling to function.
>
> But if we want to directly enforce the guideline, I can move that logic
> inside this API and we can have spl_reserve_video_from_ramtop, let me
> know your opinion on this if we want to go this way.

That seems OK to me, so far as I understand what you are saying.

[..]

Regards,
Simon
