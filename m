Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E11D3CD4F54
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 06:24:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFF5E88B7F;
	Thu,  5 Sep 2024 08:24:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="p5eFL2K0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCD6488B94; Thu,  5 Sep 2024 08:24:42 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5DD388B84
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 08:24:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c3d209da98so161750a12.1
 for <u-boot@lists.denx.de>; Wed, 04 Sep 2024 23:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725517480; x=1726122280; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jWVfy44CgCEVAH/eGlbrtYetqVfQgrDhnpthtmkeVbg=;
 b=p5eFL2K0CUU59evidJdTwXuJPO+rnGLvJWHUM7Had1zEXsLYRt/BOIoQMKmeCWeNy/
 rhdPAavDAonr5hyuVh4s0ruwv9vBeXXkQa5IEJen9+ANCRDiJDjOzhhCWo8sGJzM2/Y3
 6WJZgidclwPxykFu76BLO4G2W/8FRQVA43MiUoUexG/ldzWnsTxb4bcC0iOc6JIcLGL3
 SKXTIv93mLWvk9gTGCCVgtGXGJjIXhKkuQuhEypWqdZVAI7laZb+TZYtqsiYtqZuiEbK
 Te8mALvnL1pA/LsjnrV61S+HSYflitQ5/rUNwZQeZQGDbu7cn1IGWuxCE7M9KIWrPZKU
 bukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725517480; x=1726122280;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jWVfy44CgCEVAH/eGlbrtYetqVfQgrDhnpthtmkeVbg=;
 b=pyAvEO80pZzzMR2wsp+sP0CcdBaC19407jWZTY8XLnL4NnnN6V2XiNcfXbR8Nz4V/c
 3NeRF3an/i94rLOsdphLAIKzzCKJJL4OfTrzLe4Dc5aIYodZ72KGbTt7klpcTy6Y5h5+
 uMI6FKSeZnUkih/kFF/Fsp8WuBqZEak9Yq0k5S1IWUlNVIV6h9j9u7GsoGqB7GOz9oQj
 WJRu4pQ2e43DMcSt6rC1fuxbSnm52V0Kvt7H7eqa1ocm1bNvAwzvM1LKVM9txmzJaarH
 1AVbJO5eOBr0j2O4EpZAUAn3+PUGvrMv9Dp1vyFgvj3K13s+nWo9dHO4wrm5bUt3QoUN
 sNCg==
X-Gm-Message-State: AOJu0YwgoIXnXmKKY6988XmPoD3AkYuLc1mxbduASkhjy6rQVkbFb9si
 S20eQv8Byr53fJrDNPCuKC0BBTyVgo+6UCkV1VbO7jdUTlQbCCvynBLM51B0reiGfMBcxCOiOuy
 0kKsyR3hS5JxLMGPXnulsSYzkks4DdblpRjmK604+zbcliAFX
X-Google-Smtp-Source: AGHT+IEwkmlejpIuc+bjZ1y6/djXOtW2xyXZdIEv6Obj9nuv5m51LHXxwuU4n2yXbDNbHCW6m5gSVbjs3xPhQgwtlMw=
X-Received: by 2002:a05:6402:2089:b0:5c3:cc1c:4d9c with SMTP id
 4fb4d7f45d1cf-5c3cc1c4dbdmr2606846a12.18.1725517480091; Wed, 04 Sep 2024
 23:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240830114057.891069-1-sughosh.ganu@linaro.org>
 <dc2c0bd1-3aa7-4347-a4d6-5754a40e5b7e@amd.com>
In-Reply-To: <dc2c0bd1-3aa7-4347-a4d6-5754a40e5b7e@amd.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 5 Sep 2024 11:54:28 +0530
Message-ID: <CADg8p95OdP5DE39VO+2uu28q_MeYFD1qqUZOvoAXQwUztBGZmA@mail.gmail.com>
Subject: Re: [PATCH 0/6] Miscellaneous FWU fixes
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Wed, 4 Sept 2024 at 17:30, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 8/30/24 13:40, Sughosh Ganu wrote:
> >
> > The following set of patches are miscellaneous fixes and some
> > hardening of the FWU update logic.
> >
> > Sughosh Ganu (6):
> >    fwu: v2: perform some checks before reading metadata
> >    fwu: v2: try reading both copies of metadata
> >    fwu: v1: do a version check for the metadata
> >    fwu: check all images for transitioning out of Trial State
> >    fwu: add dependency checks for selecting FWU metadata version
> >    fwu: do not allow capsule processing on exceeding Trial Counter
> >      threshold
> >
> >   include/fwu.h            | 11 ++++++
> >   lib/fwu_updates/Kconfig  |  1 +
> >   lib/fwu_updates/fwu.c    | 31 +++++++++++++++-
> >   lib/fwu_updates/fwu_v1.c | 18 +++++++--
> >   lib/fwu_updates/fwu_v2.c | 80 ++++++++++++++++++++++------------------
> >   5 files changed, 99 insertions(+), 42 deletions(-)
> >
>
> I found one more thing.
>
> I did this change
>
> diff --git a/tools/mkfwumdata.c b/tools/mkfwumdata.c
> index fbc2067bc12d..dab9530e499c 100644
> --- a/tools/mkfwumdata.c
> +++ b/tools/mkfwumdata.c
> @@ -293,7 +293,7 @@ static void fwu_fill_version_specific_mdata(struct
> fwu_mdata_object *mobj)
>          struct fwu_mdata *mdata = mobj->mdata;
>
>          mdata->metadata_size = mobj->size;
> -       mdata->desc_offset = sizeof(struct fwu_mdata);
> +       mdata->desc_offset = 0x21; sizeof(struct fwu_mdata);
>
>          for (i = 0; i < MAX_BANKS_V2; i++)
>                  mdata->bank_state[i] = i < mobj->banks ?
>
>
> to break desc_offset location. I generated mdata structure and write it to
> primary mdata partition.
>
> This has been spotted by (my debug) which is the reason why I did it.
>
>         if (g_mdata.desc_offset != FWU_IMG_DESC_OFFSET) {
>                 printf("mdata offset is not 0x20\n");
>                 return false;
>         }
>
> But I got one more message below which
>
> mdata offset is not 0x20
> Both FWU metadata copies are valid but do not match. Restoring the secondary
> partition from the primary

The reason why this logic is in place is to handle the scenario
whereby, during the metadata update, the primary copy gets updated
correctly, but due to some reason (like a power cut), the secondary
copy does not -- this is because the primary copy gets updated first.
In such a scenario, the secondary copy of metadata can be then
restored from the primary copy. In the scenario where the primary copy
is corrupted, it will show up in the crc check, and will get restored
from the secondary copy.

-sughosh

>
> But this is wrong. 0x21 there is wrong as been detected but sync code detects it
> as correct one and by this break also backup copy.
>
> Thanks,
> Michal
