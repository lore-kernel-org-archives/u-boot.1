Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B998E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 08:02:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6586280087;
	Fri, 20 Dec 2024 09:02:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LBaD2wyt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F0248021A; Fri, 20 Dec 2024 09:02:07 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E66BE8007D
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 09:02:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5d3f65844deso2445891a12.0
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 00:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734681724; x=1735286524; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/OSv2o/KdK3FX1X7ZdMBSLosxczXykB1hIYWKaQmZm4=;
 b=LBaD2wytVOWx+Q6OzK2e+x1LfIgFGEoXx5VOAY5VRjTsa89x6RW+wmihqnN8xI0uJg
 zWIVIc6A1b7p21Eb6lCfKnfrlm3Kymk5wW5Jr7GoOxIAlLm3SXCEcCUMpSyV/aVshUu0
 hlFYRSVO7xXOn0I3/PIgtc6sqYVnjXqVXRVGVhtDDMRO27tJemsvR7TP+5jBtJi4envm
 rRw/66N3v9/gb6rMhbz1+j+kxDWFraxci7AnksZK7xEM1yTBAGd4nzwuf+1s4kV3jTV5
 rbfD7rMFLLNIBVjDCyLcDVeGRufaNTEEuTMKYL3XqA4jja+j+fMhrIxTpbwyrSoCEUmb
 Ckfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734681724; x=1735286524;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/OSv2o/KdK3FX1X7ZdMBSLosxczXykB1hIYWKaQmZm4=;
 b=mZtGoCsCgqSDf3+cPW526GjCjV3koCQ8UvplUFjbeLfOVC+O4o2sidfFU7yv2C4Zyc
 +Qg1RZh4GypSfHTYcH3d0YnAsE7lmountOPTQ52Zwp4AOScrHis5O+VIOZiJfFD0Sz6H
 +qsswP7IBbDnJ19s3kjuik4zGOx7y9Sq+V7bcC6uscSHOfSa3lvcBlUHhxGTvcnw9pj7
 fMX037/vLSFxE/SVT2RjXaQupGsmIpLAnYa2lsK3xc6dsMTv0p5etuu9qg3wikyfE55P
 weWcAT9ECVWol6HNctz2MqiG57Zi9SwZcItgDt4n2Yai+8pRZyDNrjm+ebGJ8TMOgz90
 hdKQ==
X-Gm-Message-State: AOJu0YwDe+JHbf8nGwZzr443lS5u8PE3jEQmov50ZhnS9k//RqHHZaaD
 tw2W9maWPAw6Vw8sEbOQdVKnxoUELkfI0cPHImBvNxxvf9Qpt3RChp7IMMrfYtja3Q8v3bIrRI0
 rFVEWH6OmBhZ+XJio95R0G8wYQneRb+sCHGzFDw==
X-Gm-Gg: ASbGncvc2Md3gwLSmJveT8baZyd2Q76z5qMR4OTT8qQ35C5Ecj/w/NuAUlLtS0kZTWp
 ShDlc4nbcSheucj4Dq4XP/SG/ADSYLP2w6Z/EXw==
X-Google-Smtp-Source: AGHT+IGFOy2qM2y+iatYvmkxPDonqNjB/3hliVqpHxSyYz+yd0E4GeNg78J2LaSECk9qJGnXXhMr32X9orfIUrzAMds=
X-Received: by 2002:a05:6402:5c4:b0:5d8:211a:4d59 with SMTP id
 4fb4d7f45d1cf-5d8211a4ec1mr818501a12.19.1734681724239; Fri, 20 Dec 2024
 00:02:04 -0800 (PST)
MIME-Version: 1.0
References: <20241220030742.1745984-1-venkatesh.abbarapu@amd.com>
In-Reply-To: <20241220030742.1745984-1-venkatesh.abbarapu@amd.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Fri, 20 Dec 2024 13:31:53 +0530
Message-ID: <CADg8p96XFAGNfTivFasC6n_7M6A5D49GBR_q6=1XMwcFx5vB7g@mail.gmail.com>
Subject: Re: [PATCH v2] common: memtop: Fix the return type for find_ram_top
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@amd.com
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

On Fri, 20 Dec 2024 at 08:38, Venkatesh Yadav Abbarapu
<venkatesh.abbarapu@amd.com> wrote:
>
> As the return type is "int" for find_ram_top() function and
> returning the "base" which is of phys_addr_t is breaking when the
> "base" address is 64-bit. So fix this by updating the return type as
> phys_addr_t.
>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Reviewed-by: Michal Simek <michal.simek@amd.com>
> ---

Acked-by: Sughosh Ganu <sughosh.ganu@linaro.org>

-sughosh

> Changes in v2:
> - Fixed the check patch warning.
> ---
>  common/memtop.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/common/memtop.c b/common/memtop.c
> index 841d89e0799..bff27d8211e 100644
> --- a/common/memtop.c
> +++ b/common/memtop.c
> @@ -121,8 +121,8 @@ static long region_overlap_check(struct mem_region *mem_rgn, phys_addr_t base,
>         return (i < mem_rgn->count) ? i : -1;
>  }
>
> -static int find_ram_top(struct mem_region *free_mem,
> -                       struct mem_region *reserved_mem, phys_size_t size)
> +static phys_addr_t find_ram_top(struct mem_region *free_mem,
> +                               struct mem_region *reserved_mem, phys_size_t size)
>  {
>         long i, rgn;
>         phys_addr_t base = 0;
> --
> 2.34.1
>
