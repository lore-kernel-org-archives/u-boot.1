Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1C6C7115A
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 16:22:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78E4382C65;
	Thu, 19 Jun 2025 18:22:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZkQBr0VW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5050A82CCE; Thu, 19 Jun 2025 18:22:21 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6C69800C1
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 18:22:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-235e1d710d8so13643995ad.1
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 09:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750350137; x=1750954937; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=61F6dnyPCGum5fpeGnvNNUDlA6TOLmpFReI9w8VFd10=;
 b=ZkQBr0VWGp+RIi76jwGvk54GmVOcrH4noEtUGvpS3F8QQpdCIibKdMDRDqxV+D8w8A
 9EFCFEPZNODtwxDJa1iM0eF/BrtezTNMjRpzw/sVq5EZjO3O9tWoo2oFF+Kx12f8tyFp
 A1QtS2NUT5cQ00T2BXuPMvDEOVMXo5s10c1jzyw5KDopTi+QiByCyOMbq7NoNzkJPi4g
 oF9FMviZeVot+SQgKzjDQKg+Jg2gdxgi+C2wdL5GO9ZcLOR5KR1eRKddsafitL5aPtim
 TIoT8QPgEN0pBwP/oNb47JuYh64pEGm9GH7v36oYQLGypElruX8qc0NZfIE4kO+9px/A
 eXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750350137; x=1750954937;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=61F6dnyPCGum5fpeGnvNNUDlA6TOLmpFReI9w8VFd10=;
 b=chb1eDWu20CLfjxEPPOQRTzNLLWbiC/Jl1U6xx5mQh5bFyEwsnM605h9droHF438PV
 K+/LIVzru2PslH80fvFU/7pmmFSY0szQd6lmR615aglYjswqwySArG70cvq3yCR0+6FA
 29bS08rf/1IRT8OGtEweYh5UEdbQVww7vEXJy34Zxe+Zd7clRjw3UXn/TA7PKoFdkTLq
 9Jz4VssYnx06pWTQIx/8DDP4s22q1AR3JjdbNdEP1j/c+STND35ypm/odGDZtWChFG+V
 TvLma5b4pyG7CjbiRhUFuXeRV67+JXycDv+mfQ7R7PA57n/q6343u4dsIBLvd/l9cn8e
 lDhQ==
X-Gm-Message-State: AOJu0YzLbKJ5z3Pyo/kturp9FM1Bir1JXU1nz6HXBik9sYpZDj2a2Jva
 zegoPOMTyJ3Nljb7aOirxV9NvCeV8/3pzY/AkVVMFM4BrAkZIbJR9CVxoV6/MV+IVolD9i6uSzI
 3PGVt3VuUnscrrFcy0IFqDqhdh6JEZv8yQpcftz01hA==
X-Gm-Gg: ASbGncuifWx/mFClaTQmXGPE8QN/5WXQa9qe6+uH74MbUqSUq2RszGXkWwX89VNCPkd
 /HUstTzMkqF+Y0DEabzur+kXx2WO3LBzGnb0+fGlqVAPmJWJBSZXHsUOs4+INumRccFVZ93ZFjm
 1KH4dir8Co0lohs6beeU0jqpg7E/IKQAZdyGEIf1y1J9ZQ
X-Google-Smtp-Source: AGHT+IEJKd6H08Iqv/2SuxOaXTR/bsppuqsfA8R6p1Dz2P0jf2lX6LRPxjPfgmLjtUUEEkMoClN7fi3rT5FXK45Tz9g=
X-Received: by 2002:a17:90a:dfc8:b0:311:f05b:86a5 with SMTP id
 98e67ed59e1d1-313f19d2977mr38010141a91.0.1750350137114; Thu, 19 Jun 2025
 09:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250618145930.2652304-1-raymond.mao@linaro.org>
 <20250618145930.2652304-7-raymond.mao@linaro.org>
 <9a5ed161-0420-4656-9fcf-6d122d4f6c0e@amd.com>
In-Reply-To: <9a5ed161-0420-4656-9fcf-6d122d4f6c0e@amd.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 19 Jun 2025 12:22:05 -0400
X-Gm-Features: AX0GCFs1mb3ZFR_RK2u57kQe2BEA-XK8g6AqnCdmPGW3MiArLFOnqtr5sFCgtcw
Message-ID: <CAEfUkUL5L6YVbWtZrjitKuRPbs_3-=nr4i_1xtppi6CcXhhv1w@mail.gmail.com>
Subject: Re: [PATCH 6/6] fdtdec: apply DT overlays from bloblist
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, venkatesh.abbarapu@amd.com, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Levi Yun <yeoreum.yun@arm.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Harrison Mutai <harrison.mutai@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Matthias Brugger <mbrugger@suse.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Michal,

On Thu, 19 Jun 2025 at 07:39, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 6/18/25 16:59, Raymond Mao wrote:
> > During FDT setup, apply all existing DT overlays from the bloblist
> > to the base FDT if bloblist is being used for handoff from previous
> > boot stage.
>
> More technical details would be good to have here.
> Especially that the way what you are using is to expand DT
>
Agree. I can add more details in the next post.

> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> >   lib/fdtdec.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 56 insertions(+)
> >
> > diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> > index c38738b48c7..3a218d8c94a 100644
> > --- a/lib/fdtdec.c
> > +++ b/lib/fdtdec.c
> > @@ -1687,6 +1687,60 @@ void fdtdec_setup_embed(void)
> >       gd->fdt_src = FDTSRC_EMBED;
> >   }
> >
> > +static int fdtdec_apply_dto_from_blob(void **blob)
> > +{
> > +     int ret;
> > +     struct fdt_header *live_fdt;
> > +     size_t new_fdt_size, blob_size;
> > +     int expand_by;
> > +
> > +     if (!CONFIG_IS_ENABLED(OF_LIBFDT_OVERLAY) ||
> > +         !CONFIG_IS_ENABLED(BLOBLIST))
> > +             return -EPERM;
> > +
> > +     live_fdt = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
> > +     ret = fdt_check_header(live_fdt);
> > +     if (ret)
> > +             return ret;
>
>
> Why is this needed? You already have gd->fdt_blob which has been checked.
>
You are right, these can be skipped.

>
> > +
> > +     ret = fdt_check_header(*blob);
> > +     if (ret)
> > +             return ret;
> > +
> > +     blob_size = fdt_totalsize(*blob);
> > +
> > +     /* Expand the FDT for spare spaces to apply the overlay */
> > +     new_fdt_size = fdt_totalsize(live_fdt) + blob_size + 0x400;
>
> Some notes about this 0x400 would be good. Do you see issue if you don't use
> this value? Is file DTB after expansion actually bigger then origin+overlay that
> you need to add 0x400 magic value here?
>
The value 0x400 is arbitrary and it really depends on the DTOs.
When applying a DTO, it may create new entries in:
The structure block (nodes, properties)
The strings block (all unique strings, including property names and values)
These new entries require extra space, not just equal to the overlay
size - because:
Some parts will bring in new strings, which get appended to the string table.
Also alignment padding might require more bytes.
What I am concerned about is that 0x400 might be not sufficient for
those complex DTOs.
Maybe more bytes are required.

>
> > +     ret = bloblist_resize(BLOBLISTT_CONTROL_FDT, new_fdt_size, &expand_by);
> > +     if (ret)
> > +             return ret;
>
> You do resize inside tl list.. That should be described in commit message
> because my exception was that this location can be read only from NS world.
>
I can update the commit message with more details but why should it be
read-only? At least I don't recall if the spec says the TL is not
expected to be updated in BL33.

> I didn't run this on HW and likely I should do it to understand this better
> but isn't this moving CONTROL_FDT entry to different location which will have
> bigger space for applying overlay?
>
Do you mean to move it to a predefined address like existing
CONFIG_BLOBLIST_ADDR with more space reserved? I am open to it.
But what I have to say is that the entry memory can only be marked
with void, no reclaim memory mechanisms. This leads to duplicated
memory ranges.
Other than that, I think dynamically increasing/shrinking the size is
more flexible.

> Isn't it also worth to check if existing CONTROL_FDT has enough space inside
> that new overlay can fit there before resizing it?
By default each entry only contains the actual size since bloblist
(aka transfer list) is designed as a compact data structure and there
should not be a waiver for CONTROL_FDT to carry additional spare
spaces.

>
>
> > +
> > +     /* The blob is shifted if it was following the FDT */
> > +     if (*blob > (void *)live_fdt)
> > +             *blob += expand_by;
> > +
> > +     ret = fdt_open_into(live_fdt, live_fdt, new_fdt_size);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = fdt_overlay_apply_verbose(live_fdt, *blob);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* Shrink the excessive spaces */
> > +     fdt_pack(live_fdt);
> > +     new_fdt_size = fdt_totalsize(live_fdt);
> > +     ret = bloblist_resize(BLOBLISTT_CONTROL_FDT, new_fdt_size, &expand_by);
> > +     if (ret)
> > +             return ret;
>
> I didn't try to run on HW but don't you need to also adjust gd->fdt_blob to
> point to current location where fdt is?
>
gd->fdt_blob is already pointed to the one inside TL, it remains the
same, only the size is changed.

Regards,
Raymond

> Thanks,
> Michal
>
>
