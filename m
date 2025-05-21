Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E06C2D0CD
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 07:53:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0F6782D2B;
	Wed, 21 May 2025 09:53:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NoWPYG4E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5677082D33; Wed, 21 May 2025 09:53:08 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4136882BD6
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 09:53:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-442f4a3a4d6so41910945e9.0
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 00:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747813986; x=1748418786; darn=lists.denx.de;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=40igUJGxXuBoOLAFP8HtoeHwgvg2yZAlXkImFUz8clc=;
 b=NoWPYG4E/kFufjZ2LBa6vg8IjSvm7YnxF95QahAXDXy0G1X/4tg979uNerD4LRkLb/
 SbGbxP+jy9/te5gr3uRiyYwj2YHuCC5jEwF2vpfc0qzvnmeg/+IPbDLVl0G/f1zZq96C
 6YsWnK/G5DuH7Od0bYiAssZ/Bh/xkQfH1DGR7obITLr5iMwdygtSAu3V5M1WlPq+A/fl
 BZa55Hu9wrBwQYHaFWzCTGys339vUyy006qlj5oYo3nXYpZupUJgiaAppGk6ftUrI+73
 SmO5aZPmjFfIHjZqvoQaDiRLA/mTNKPkgQf/JG8jM9mKwdveMKXDDuTe1f0JVpKcNQ+8
 uBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747813986; x=1748418786;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=40igUJGxXuBoOLAFP8HtoeHwgvg2yZAlXkImFUz8clc=;
 b=Q9LkcEzOnihw6rkiIoZeqI6t8HdYaYlrNCVRClt8wnmJwZwzYCeB7aLuRpnOAsKQfp
 3BIkPWFuhXsdasv/5TRz3dhqOtz99GH8z5r4sPH1NaPaztl/v4JbrAl530IgYM14Sl/g
 9BW7DgycGx8OT9bFQAfWy17ilx3mF+Gt+N1BqeuTuy4QupyRf+AfpnZqdlrHDSwdc/vX
 pr3dzCVgsFNtxEKXrwRtcbcnSKWCsSphvz6r5ZadAgZVep5IrX5+yAcoiPTWIm9pdqP/
 mxR3h4CDvHqD8trsmRKT0xzRYulRUEgbelxrJWb2eTRxyE38GhXjPVtLqncezviy7smv
 DC2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5JHL5PeE1LiT2nfRmvw8HC1PK4PhXvumV+lFh3qlTV8LwOFd3eGmLwJVxJyF3javalV2iqaA=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4FCWXOTB4Fr65Q4yaF4JBwCX1M/f8ahYDXVaV59V8wmu0SSgg
 wfV9H6DRrA5j1rc1kfa/krLbc1rgQQgfhgbXjpB27hSY0hRrvyde1MdOL9UeaxnNHYU=
X-Gm-Gg: ASbGncvvDo+g+rTjMnzaY2wWQc9IxUKxRFHY5PccdJXUcw7waZPoMly15itBeFVqFqF
 hQa6kQKKJWUXuHo9sJ/trgpYOOwel0kicPPgFM1AuYaqjEbmkDJLrSxiYVCc06M8J7Mn+hnt3gF
 +HxhduHy5ljKzp384R9xtCPz2ogjGD79xtiURH2XwgNxATKrVbvi7VJ0o0nEUYFzyPCsMbkt+KE
 aV8JU39ySloI7laCxG/JET9aMvGYsB8EpGIPIepoj0cLVv4vrSO41F9JU5jlauotj4I9VfSHx7I
 zgDTJFtsUk8d4T/L+eK1kxBxjHMUNtWHkjcYGMuF7SAOgPqW6Yk8s30FzHo=
X-Google-Smtp-Source: AGHT+IF8vxedh9boh7twtAuuP7cAutqbnEK3gub/bHcC+U67HvF8+E5zFp/3QhSxsVQsHaEoLh52IA==
X-Received: by 2002:a05:600c:3587:b0:43d:16a0:d98d with SMTP id
 5b1f17b1804b1-442fd9970d1mr151078455e9.15.1747813985687; 
 Wed, 21 May 2025 00:53:05 -0700 (PDT)
Received: from localhost ([46.198.180.244]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f18251c7sm59787875e9.3.2025.05.21.00.53.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 00:53:05 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 May 2025 10:53:03 +0300
Message-Id: <DA1OCJCRJ6KI.1X5DUMJDQ6913@linaro.org>
Cc: "Tom Rini" <trini@konsulko.com>, "Casey Connolly"
 <casey.connolly@linaro.org>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Mark Kettenis" <kettenis@openbsd.org>, "Weijie Gao"
 <weijie.gao@mediatek.com>, "Heinrich Schuchardt" <xypron.glpk@gmx.de>,
 "Simon Glass" <sjg@chromium.org>
Subject: Re: [PATCH v2 1/5] lmb: replace lmb_reserve() and lmb_alloc_addr()
 API's
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
To: "Sughosh Ganu" <sughosh.ganu@linaro.org>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.20.0
References: <20250520120606.173228-1-sughosh.ganu@linaro.org>
 <20250520120606.173228-2-sughosh.ganu@linaro.org>
In-Reply-To: <20250520120606.173228-2-sughosh.ganu@linaro.org>
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

Hi Sughosh

On Tue May 20, 2025 at 3:06 PM EEST, Sughosh Ganu wrote:
> There currently are multiple allocation API's in the LMB module. There
> are a couple of API's for allocating memory(lmb_alloc() and
> lmb_alloc_base()), and then there are two for requesting a reservation
> for a particular memory region (lmb_reserve() and
> lmb_alloc_addr()). Introduce a single API lmb_allocate_mem() which
> will cater to all types of allocation requests and replace
> lmb_reserve() and lmb_alloc_addr() with the new API.
>
> Moreover, the lmb_reserve() API is pretty similar to the
> lmb_alloc_addr() API, with the one difference being that the
> lmb_reserve() API allows for reserving any address passed to it --
> the address need not be part of the LMB memory map. The
> lmb_alloc_addr() does check that the address being requested is
> actually part of the LMB memory map.
>
> There is no need to support reserving memory regions which are outside
> the LMB memory map. Remove the lmb_reserve() API functionality and use
> the functionality provided by lmb_alloc_addr() instead. The
> lmb_alloc_addr() will check if the requested address is part of the
> LMB memory map and return an error if not.
>
>  	 * there's no need to check the result
>  	 */
>  	arm_smccc_smc(MTK_SIP_GET_BL31_REGION, 0, 0, 0, 0, 0, 0, 0, &res);
> -	lmb_reserve(res.a1, res.a2, LMB_NOMAP);
> +	addr =3D (phys_addr_t)res.a1;
> +	lmb_allocate_mem(LMB_MEM_ALLOC_ADDR, 0, &addr, res.a2, LMB_NOMAP);

In some case you check the return value and in others you ignore it.
Since you are changing this, check the return address everywhere

> + * be -EINVAL if the requested memory region is not part of the LMB memo=
ry
> + * map, and -EEXIST if the requested region is already allocated.
> + */
> +int lmb_allocate_mem(enum lmb_mem_type type, u64 align, phys_addr_t *add=
r,

Nit, but can you rename it to lmb_alloc_mem() so it uses abbreviations ever=
ywhere?

> +/**
> + * lmb_can_reserve_region() - check if the region can be reserved
> + * @base: base address of region to be reserved
> + * @size: size of region to be reserved
> + * @flags: flag of the region to be reserved
> + *
> + * Go through all the reserved regions and ensure that the requested
> + * region does not overlap with any existing regions. An overlap is
> + * allowed only when the flag of the request region and the existing
> + * region is LMB_NONE.
> + *
> + * Return: true if region can be reserved, false otherwise
> + */
> +static bool lmb_can_reserve_region(phys_addr_t base, phys_size_t size,
> +				   u32 flags)

Overall this is a good cleanup. But I was hoping we can rid of this as well=
.
This is almost identical to lmb_overlaps_region() with very small differenc=
es.
One of these takes the lmb list as an argument and the other is also checki=
ng some flags.
It's better if we keep one.

[...]

Overall this is moving towards thr gith direction

Cheers
/Ilias
