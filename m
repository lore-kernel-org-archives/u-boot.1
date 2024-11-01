Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B0DE6B243
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 11:47:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 639AF88F92;
	Fri,  1 Nov 2024 12:47:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="StAvlWTt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD931891DD; Fri,  1 Nov 2024 12:47:36 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B65688E94
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 12:47:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5c94a7239cfso1173006a12.3
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 04:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730461654; x=1731066454; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n2kqK3Gqoy32R6+rqlsssIZDVlixu9xnj1RqYvwGElk=;
 b=StAvlWTtvRoc2wxk7r0D3a+dRtRGTt3qS88HZ/1aZXEnO9x9OGls/x2dlZocLaRKtv
 VaPVNYEUJ6744qT0yUVhdzKs6GFdsxgay9wJhMsguoHEditRrhfOItVMd3aLpKwzYxew
 gIkKwUeg5e++Q9r6HcOohYLxv1Nk8cTf1o8kjTNQPu8L+RlpQ5BfyKMh+dAuCXMgVFv3
 KcFIy66JF8sStER+UG9iUZ5q3PIzAZWDwp8QSvrZkTcwmvhGwdPwW/hzTdTK5VKvLIQ1
 C43PX5lJZIeedjElgqMkHZrOk9NRNiuiz/naoNX+lj6UTAO+2mgMSOE5Nh2vJekbhr4X
 FOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730461654; x=1731066454;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n2kqK3Gqoy32R6+rqlsssIZDVlixu9xnj1RqYvwGElk=;
 b=plgR6AJ2rcNCzYVCediGiDJfOF713fnQf+oIDptc6goHBiEaz5+dG/p4DH1JEqBsq5
 DXOfEA86HpKMbZzy2O7I58WnBpqxyxiyExcNdkEsL4EElBUqFVo/FLyks+ILxo7BTdYP
 b90pDCPRgNuF25961Su5JdsQBu/iheXl0hvg4JYm8vgOaqC7ZI2s7spxhORrcrLlpkpq
 tmyAo1GTHDQThm7gc+2n1TmlMPnt2Wxl1pO4OJwExRI/vqN4HaHvDBoOwbbH0UYZHltr
 Qj4MBO4q4ZIY+c4SZNSk5MMpsc7uLoRgFUyEints9rofKaGsz1jBBb3wUeHp97qkNiET
 lWhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6Lip5DcEjp8fqFgyHElZhD0UOSXF5FTW/TFnDnYXm2D5HekP86LnJHDCwdP3bJsvmWjyXW5Y=@lists.denx.de
X-Gm-Message-State: AOJu0Ywn8RgO/Z2D25kf6bB45jQQrQh2XJ66SvZKPRnuvHFe233q6v1s
 HSGQg46A9GC9QI0cczkZKB3gzsH9aLM+e6NrAlZ6lqDxF9sa9EZlPl9Jx3hElddpCpiUGqYNcSV
 yCbj1ShLqmVGXs3CRr9a/eamfsUjcVmSu691XldL3OMv7RULK
X-Google-Smtp-Source: AGHT+IG2+C8Dg/vunXCZuoAjCiYz4x8CquyA7B5/Whtpeg8vPtPCSQv2huwgW8IzXeWRakQZGJaWdweXEk53n5RpDTA=
X-Received: by 2002:aa7:ce1a:0:b0:5cb:bebb:38d8 with SMTP id
 4fb4d7f45d1cf-5ceb9263166mr2909192a12.14.1730461653758; Fri, 01 Nov 2024
 04:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <20241101-io_lmb_apple_dart_iommu-v1-0-fe4b9a74d47c@jannau.net>
In-Reply-To: <20241101-io_lmb_apple_dart_iommu-v1-0-fe4b9a74d47c@jannau.net>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Fri, 1 Nov 2024 17:17:22 +0530
Message-ID: <CADg8p97H9eqncSEGjZF5EGP2M9Y10MmV28RwSdtsW+T8fSURiw@mail.gmail.com>
Subject: Re: [PATCH 0/4] Fix IOVA allocation in Apple dart iommu after global
 LMB mem map changes
To: Janne Grunau <j@jannau.net>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

On Fri, 1 Nov 2024 at 15:47, Janne Grunau <j@jannau.net> wrote:
>
> The changes in "Make LMB memory map global and persistent" [1] break
> mapping DMA memory in the USB xHCI driver when using the apple_dart
> iommu present on Apple silicon systems.
>
> The IOVA space used by the u-boot driver (low 4GB) and physical memory
> do not overlap. The physical memory on this systems starts depending on
> the SoC either at 0x10_0000_0000 or 0x100_0000_0000. It make no sense to
> manage these distinct regions in a single LMB map. In addition every
> device has its own iommu and IO address space so sharing a single memory
> map between all iommu instances is not necessary.
>
> To fix this issue restore the used subset (add, alloc and free) of the
> previous pointer based LMB interface with "io_" as prefix.
>
> To ensure that low level lmb functions do not use the global LMB
> variable reorder lib/lmb.c so that the variable is not visible.
>
> Tested with patches from my "Fix device removal order for Apple dart
> iommu" series [2] to fix a separate issue.
>
> The cosmetic commit has two checkpatch warnings in existing code which I
> ignored.
>
> [1] https://lore.kernel.org/u-boot/20240826115940.3233167-1-sughosh.ganu@linaro.org/
> [2] https://lore.kernel.org/u-boot/20241031-iommu_apple_dart_ordering-v1-0-8a6877946d6b@jannau.net/
>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
> Janne Grunau (4):
>       lmb: Do not use global LMB variable in _lmb_free()
>       lmb: cosmetic: reorder functions and global LMB variable
>       lmb: Add basic io_lmb functionality
>       iommu: apple: Manage IOVA separately from global LMB mem map

Thanks for these changes. I am currently on leave, but will take a
look at this in detail next week. But on a cursory glance, I have to
say that I am not entirely satisfied with this solution as well. With
these patches, we now have a disparity in terms on how we view the LMB
memory map -- we have a global map for RAM address range, but a per
device one for IOVA's. I understand that IOVA's are supposed to be
per-device, but then I think that perhaps LMB is not the right way to
solve this. This was fine earlier, when the entire LMB implementation
in U-Boot was local, but that is not the case now. I wonder if there
can be a different, non-LMB way to implement this. Earlier, we had
functions for allocating and maintaining a memory map in the EFI
memory module. I am wondering if we can use those functions in a
common place, and use that implementation instead of having this in
LMB. That way, every device which is looking for an IOVA map, can
maintain one, and use the common functions to add memory space to it's
map, and then use that memory for allocations. Also, based on your
explanation above, I think that it should be the responsibility of the
device to get the IOVA address range, and then pass those addresses to
the IOMMU driver? Let us see what others have to say on this solution.
If there is consensus, I can look at a solution once I am back.

-sughosh

>
>  drivers/iommu/apple_dart.c |  16 +-
>  include/lmb.h              |  47 ++++
>  lib/lmb.c                  | 608 ++++++++++++++++++++++++++-------------------
>  3 files changed, 406 insertions(+), 265 deletions(-)
> ---
> base-commit: 1d147b74f437fb0e85821e8271fe52bc5fd30194
> change-id: 20241101-io_lmb_apple_dart_iommu-dc2674ef9036
>
> Best regards,
> --
> Janne Grunau <j@jannau.net>
>
