Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15010E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 16:27:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4102A80362;
	Wed, 11 Dec 2024 17:27:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vEdCWISx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3992B80369; Wed, 11 Dec 2024 17:27:33 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C807680323
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 17:27:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5d3cf094768so8385959a12.0
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 08:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934450; x=1734539250; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8RnMQms5pLVRGA/jB8KluoiX5D5eeY8dZC8NBRiKOiw=;
 b=vEdCWISxjndyrCq8AR2/NfvZBLQL8Nl3LLuN+sZYvE4gSrIBpIGNSDu3A36xu5HOGw
 BNwqqbBbFFOYfGYn5JMzTkkzJZ8OEVUNsm4RmmbpfKRmsQ1dTrFudPZNmXEPB5ZPi7dP
 dRv9AQgEBd0jp4kIjOV1G2orwRDz0mR9d2we/Jm3k96XH0C9GBkfr0pBZqZ5hmqUiKFa
 5yxIirdzkTKU8mMQxie21NnzcRRTsDs3PODZVpjLHf41jX8XxH53uVDyeEO1l23zy6Km
 GrpEMZ/D45LVzF+gi7aWLey+R/hrw8ok2TsesvGeJgqjStQletWwqfVlmv8EXS/adM8b
 xHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934450; x=1734539250;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8RnMQms5pLVRGA/jB8KluoiX5D5eeY8dZC8NBRiKOiw=;
 b=gwJCEzRxvgDDCFLbgYzQOeU6u63ZQRA+93aBLtvCgLyw3g3pl2mWGc5U+CY9iNqQl7
 z4OkyCWBjCp4APzUuMXxc0MAP98HSTg4lJsICQVJ7C6zno/JHuGPqBEJVMCbFwS+AZS6
 94I5ynEdQXyho/VW+r4rfAK/tm+mRMr1ReWR5xvH1c5JF1bidf/gKfSlzthpUGO6oqUv
 afj62c2YJ+9kDhbt3QUm/AwTU3oV4+jBIyPNukPP6m33nHJWZVybw3HHAMU1elmmxO3V
 PQZNcH5QX/wH/w7sMsou0sfzZnIynYyhKPgGUSdt9dkbZ4CCWTRSMf6dZlsctyp/kBEg
 /Ayg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbaNBOaX9ElGmOO1a31NM/BxEBDT+zYOAycCfgZhML78jqu09Q78cc5zVQ7ZLJQNlNmp9Bg6g=@lists.denx.de
X-Gm-Message-State: AOJu0Yx51H95OwAYy903tmNGktLYYOj7KfIP0ZsNG1nTEzo7eH11iqca
 m1G+O6AW0MDDAXVf8XKPXcQ/ZtXiZjLu9vpcsnhQ8TzoPZ7zG2v+ufwls0kEimhzNPO9/0SJpEw
 zEOmSITtjVbzf+YVa69iDHqcggxP1njjYqXCUCQ==
X-Gm-Gg: ASbGnct3GDP3X4IYVhZaaO00vt7BI38omhjGDf1sLKOXnO8Nsj/z0GedTfs9MrEE8nc
 kC/FEeVpSxpaGbGlwK83ZKyFvIKLJsTPi5MQ=
X-Google-Smtp-Source: AGHT+IE2MgNsCBVDBS9n4/jMkfc+Y+lG4U36adovE7pV9erTi1WlbPs9TdLXMK13xkUOAfso22rAWRtfxSbMVh2V/ok=
X-Received: by 2002:a05:6402:280f:b0:5d3:e63c:7d71 with SMTP id
 4fb4d7f45d1cf-5d43308c2e0mr3194696a12.11.1733934450163; Wed, 11 Dec 2024
 08:27:30 -0800 (PST)
MIME-Version: 1.0
References: <20241202070624.1295497-1-sughosh.ganu@linaro.org>
 <173358702572.3722028.2684286775587826268.b4-ty@konsulko.com>
 <092f9d73-c0c5-419e-b6e5-e671f8227753@foss.st.com>
In-Reply-To: <092f9d73-c0c5-419e-b6e5-e671f8227753@foss.st.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 11 Dec 2024 21:57:18 +0530
Message-ID: <CADg8p96XXRVn6r-9tSu-h1CANgnayQuEVs8XVUb8eAd8d5kz9A@mail.gmail.com>
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

On Wed, 11 Dec 2024 at 21:50, Patrice CHOTARD
<patrice.chotard@foss.st.com> wrote:
>
>
>
> On 12/7/24 16:57, Tom Rini wrote:
> > On Mon, 02 Dec 2024 12:36:24 +0530, Sughosh Ganu wrote:
> >
> >> There are platforms which set the value of ram_top based on certain
> >> restrictions that the platform might have in accessing memory above
> >> ram_top, even when the memory region is in the same DRAM bank. So,
> >> even though the LMB allocator works as expected, when trying to
> >> allocate memory above ram_top, prohibit this by marking all memory
> >> above ram_top as reserved, even if the said memory region is from the
> >> same bank.
> >>
> >> [...]
> >
> > Applied to u-boot/master, thanks!
> >
> Hello
>
> This patch is breaking the boot on STM32MP135F-DK.
>
> On this platform, we got an area above gd->ram_top,
> this area, reserved for OPTEE, is tagged with LMB_NOMAP in boot_fdt_add_mem_rsv_regions().
>
> Since this commit 1a48b0be93d4 ("lmb: prohibit allocations above ram_top even from same bank"),
> this area is no more tagged as LMB_NOMAP, because it's previously been
> tagged with LMB_NOOVERWRITE in lmb_add_memory().
>
> By not being tagged LMB_NOMAP, the MMU configuration is impacted and leads to a panic.
>
> I suggest to revert this patch.

I don't think that this patch should be reverted. If the said platform
has a reserved memory region above ram_top, I would suggest to either
a) move the ram_top on this platform so that the op-tee region gets
marked as no-map in the lmb memory map, or b) do not use the lmb
memory map to configure the MMU -- can the MMU configuration logic not
read the DT to get which regions are to be marked as no-map?

As far as the lmb module is concerned, it is being told through this
commit to not consider memory above ram_top for allocations, which is
not an incorrect thing imo.

-sughosh

>
> Patrice
