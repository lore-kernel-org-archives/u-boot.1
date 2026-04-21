Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C287AF94CB5
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 22:54:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55F5483FED;
	Wed, 22 Apr 2026 00:54:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="a/87x80o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCDB5841C8; Wed, 22 Apr 2026 00:54:27 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C607783AC5
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 00:54:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ba699316b42so490234566b.3
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:54:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776812065; cv=none;
 d=google.com; s=arc-20240605;
 b=REYT+nEEr0w7Bs88yUvq40rZg6E+QzCOZ1wiw8wMOExG7YSjCy4h50HjCJ458ALRNl
 wVNDDVB68oUZPI3ZE/e0DhchKLFpg2pPsVcZ2T+SOW5FCCccDTFVttelumPJtPJYWknI
 icRpUIz7P14JbH8YVtZedLxxA5wyhWJ8GcchS10/7yGju7kiU85HkVYj0iG+V0JPlq8y
 4/UTkMd/qSpyz7ZM0h7TZ/R804DUTehv7E9j8DTm1mYuJGbGdBBYc+C5mn3lnkTP3oOt
 V3hZS79JZG+8/u99Z0TxMQw6LL2YbZ2qQGQeRtgQixTy9XTeO3Wdpa/E8dkmcqLZe+oT
 w6zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+2MHSIVhgjFnGx4NY48zdPFpOVk9soZ08gsQsPm+ZpQ=;
 fh=Rg0xNKHxZ4g1flPBYXxd2BdumAWPW6DQK67vLImDETQ=;
 b=jcxxvKPKMpUkOkMfIygURV0i+tVQHV4upRR5M6G0o/809nu8scpMsN49Wdq3fEZ/nY
 8/ounNqGmU/3JDEkLAif7I+SjbklOTxAUAxLV+eLgKuFFc88UnidNK+S/B0LF/jl7q+y
 qGEBGiRj8jwxHMOOGrW917fJtBtBC0LL5K8JEXd7651itOhAAHk/69CLlmMiwOO9u+8+
 aQnkE1mznJGE8nQ6u8ade7HMhfyKid3X8EfFuyC0a43vTz+3/L+3EwrUVnj0jCxW3Fq/
 srsEUcoVKZjEeFVTws+zegoG0b0FSlpqZAE5OCsWeRqcLtpaE5iPSkbioQtS/DlpaI5D
 azCg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776812065; x=1777416865; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+2MHSIVhgjFnGx4NY48zdPFpOVk9soZ08gsQsPm+ZpQ=;
 b=a/87x80o4MJVih2HhfqQ5UkehVa2Aa3yKlqR24ThUm8jDVZOIYIRuxkz2/uhYEZrWe
 v9mg5fwm5hZEF9+Hd67J1JZKarywAwqhRyCVqwhYLhqvA59hVjS82l7WVt/ipBaDGVUD
 5OqIA9LuV56RSZpbovha2Jm23XLINoQe8k4TI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776812065; x=1777416865;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+2MHSIVhgjFnGx4NY48zdPFpOVk9soZ08gsQsPm+ZpQ=;
 b=JKAtKA6A63Z9Y3apzpq9n5GElnvDIn9X9vOVnRKc00KJRsroOKfprzUFs1JVZ4z22g
 BWjtPbwB5BNFv1Z1VCpoNWRDQxO9WlxSrSWzGutZ3e0MvywSl+zj2ujzSb5mRsJv/TGx
 qWi5R/qXM9uJLDUIZrxIAeEccC1URUgX1XMs6xhbyUSoDg5b6u0Q0nYTyGlM/MnX1Kfx
 LJhebm/uy/nFQMa+OaNQDJDD1kmUQn7uKgb/PVSf0fNgirp8Db+EAkkNcQHBnLbyyAEW
 whf0UCRafRftuk4PPsGqaoPNu8wgIxmBNG+6K6Qc5oygEUU2h3TPGORxYIVfjCEdVpSH
 /WwA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9E9EBrFuH3KYxuQlntlP24I85vFwvgr+oUiKw+eH5i80/Qi4n7uSyi0O5RcQO7QR6vhrCofwc=@lists.denx.de
X-Gm-Message-State: AOJu0Yy12lwtrs9C9sWQPr9PNGb0B75hUwtQX7b/nvoQPHBlaG0heYcl
 u+j+Ui6awqe03z29CTgK/6GUVPFWxyQ+7bIzhV9088srCEafjYJ9VSdgg5DDOEGYnD7rAmV6HDX
 7rrn7d1AiTG4ELuBKlSsQ6BiHOCLzdXrGxPoC+Z7o
X-Gm-Gg: AeBDiet5hAMJKKY1G3tAM2E+cqbD/+YctY2A6R5xpDWX8g0cVGry/tnV3mk37RnmVC8
 9oj8BbvLR13zkVK9qv16HNG2yJKoyubHOlHWN0Xa16NPvWzHVM3N4zCCT45dAvunlgifhEIe15M
 fiDG53xco6WQu41Isu2IlrAQwnJEB4/ZPxCOMNsa8IMlflaAPG7v7ItzmcQKlVhcbJXew7vbFNS
 /QblV1YCVaUdiksMroWgEDr6bNvOx2Q541OetL37sOygJKh2D9eKIDEVwBGWzRe9WG+Gl6EiTC6
 hEHjX8Num+++80Dbkbxk
X-Received: by 2002:a17:907:3d90:b0:ba7:cc67:4874 with SMTP id
 a640c23a62f3a-ba7cc674c7bmr490781666b.46.1776812065195; Tue, 21 Apr 2026
 15:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260420192520.1444749-1-rs@ti.com>
 <20260420192520.1444749-3-rs@ti.com>
 <CAFLszTggCLQPaJcRoxhjHOuRM10yW3pr8JjRj+LLA-ZupVOSjg@mail.gmail.com>
 <DHZ6GETQ2Z6C.2EZP9ISNJR0E7@ti.com>
In-Reply-To: <DHZ6GETQ2Z6C.2EZP9ISNJR0E7@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 10:54:13 +1200
X-Gm-Features: AQROBzCU23CVpGruY4Cu5iYaLAc-kESq2FsXOTxhP7CquQp_kUE0vR_eBSwoxfM
Message-ID: <CAFLszTi-6pmOYA1F8eZuXtV=Lg5fByTsPCeSBCp65kzw5DAW_g@mail.gmail.com>
Subject: Re: [PATCHv4 2/6] boot_fdt_add_mem_rsv_regions: free old dtb
 reservations
To: Randolph Sapp <rs@ti.com>
Cc: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, 
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

Hi Randolph,

On Wed, 22 Apr 2026 at 10:14, Randolph Sapp <rs@ti.com> wrote:
>
> On Tue Apr 21, 2026 at 3:40 PM CDT, Simon Glass wrote:
> > Hi Randolph,
> >
> > On 2026-04-20T19:25:18, Randolph Sapp <rs@ti.com> wrote:
> >> boot_fdt_add_mem_rsv_regions: free old dtb reservations
> >>
> >> Add a free flag and an initial call to free allocations covered by the
> >> global FDT. This assumes that all calls to boot_fdt_add_mem_rsv_regions
> >> occur before the transition to the new device tree, thus we can access
> >> the currently active device tree through the global data pointer.
> >>
> >> This allows us to clearly indicate to the user when a device tree
> >> reservation fails. How we handle this can still use some improvement.
> >> Right now we'll keep the default behavior and try to boot anyway.
> >>
> >> This functionality was broken in:
> >> 5a6aa7d ("boot: fdt: Handle already reserved memory in boot_fdt_reserve_region()")
> >>
> >> Signed-off-by: Randolph Sapp <rs@ti.com>
> >>
> >> arch/mips/lib/bootm.c |  2 +-
> >>  boot/bootm.c          |  2 +-
> >>  boot/bootm_os.c       |  2 +-
> >>  boot/image-board.c    |  2 +-
> >>  boot/image-fdt.c      | 57 +++++++++++++++++++++++++++++++++++----------------
> >>  include/image.h       |  2 +-
> >>  lib/lmb.c             |  2 +-
> >>  7 files changed, 45 insertions(+), 24 deletions(-)
> >
> >> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> >> @@ -69,35 +69,51 @@ static const struct legacy_img_hdr *image_get_fdt(ulong fdt_addr)
> >> +static void boot_fdt_reserve_region(u64 addr, u64 size, u32 flags, bool free)
> >>  {
> >> -     long ret;
> >> +     int ret;
> >
> > nit: perhaps keep this one 'long' since lmb_free() returns long ?
> >
> > Regards,
> > Simon
>
> Ugh, yeah though it should only return 0, -EEXIST, or -1 since that's all
> lmb_add_region_flags returns. I'm not going to ask why that's the case.

Ah yes, I suppose it could be changed to return an int.

Regards,
Simon
