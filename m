Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17188C83030
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 20:09:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78EBB831C3;
	Mon,  7 Jul 2025 22:09:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sT+CKCzI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3A2D831D3; Mon,  7 Jul 2025 22:09:49 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73292831B5
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 22:09:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ae401ebcbc4so585568466b.1
 for <u-boot@lists.denx.de>; Mon, 07 Jul 2025 13:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751918987; x=1752523787; darn=lists.denx.de;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BuXtVfZ2q9EOa8UhKuFMOB/QbeiPXl0W6Yhwn6+l/vA=;
 b=sT+CKCzI5UmDiIUWriyf/H+HwqGiMJ2IPOW2bcNBle4nUlCcoARuJH5SwZnNCFJ7EI
 XGmlpryVE7e++5grqABIDo58ib1HnNrqGuYtuSyoHkNpWfOFU3zAPykXBpIg/900Nwo9
 2QhEwIbEGO1a4UrGmCd46jU8IV8QW9ATGgMAbBPlMSwix5kS9XRWQrfqqErd0aQL9ugQ
 KyhOoyeefuUEKemjisJGkgwCTAi6cZaNmUqTRU/7s+0f9/1V46e/PeYn+PUNQXt2+zC8
 J42LKlGxyOfXTFZabjA5092MgEYOz83+w+REREySBBGCv2qzpqdX6OZ4oUvxo2TVj0th
 3oWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751918987; x=1752523787;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BuXtVfZ2q9EOa8UhKuFMOB/QbeiPXl0W6Yhwn6+l/vA=;
 b=meoqQmL3Fqp2cDGipDBl0AWPE4gcCffpsYLLUKUxo+n5INcHa1JVLUUHQe5w479wIm
 aj3ZBin/qPIAwihS7KlLQnIurMFDC0BO4VgPSNsPjsqYc0S/DRp8HgXFtatEyYBKaJDB
 QxfnyXlih2Fjpwqc4zUJYmTNYu60dyvvA6CmK4YBI8D5XrctnM98aGVoh5q78GsBldI4
 FqKKkZT9IsQgRQ+CNOFVXbR7qhmo7pTTVeH0CbmUawSQ9iOPZXpPXIpn47DLuxH8OfP6
 7JPC+ma1Ek+N6nv6GPpC7KLhqRCan4SyF58GPBHW35/ziL9tdXBXtgE823sfml62plNq
 XVjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWr7ep91uKFEgkj0zGur0cqMZ3jGxSKHki1upiooYCK3oNGnKkg5i3MhxKXSZUmcPIEm7HQYDY=@lists.denx.de
X-Gm-Message-State: AOJu0Yyn7A4Vu41ruDk4hJtA0qjPkcNy9wJ5Uo1y9ANeBLFVKFFd/Lw1
 HChJjVufS7XFJIGoGfu9kw1SEftAq2Ob6o7fipF8Qw4eJT7MOve5MLdUYzBWA58HbLwVMHlVd6U
 wqkhk8So=
X-Gm-Gg: ASbGncu9+GYA+sppbS9uJkZp2TsgVFU2KMw4AJmLpzX94EqJvKFGNoC4cb2wd3zxAx8
 Ai1AUf/O7aRKKi65ige5WVKPIQ4wyK+BlOjHsQTqnV6azwkdWoUrYkBcCvvVBel16wTSxdz7EOy
 0E1r78BUZfLZzqedEPrJScZANWnjXIDOExswuXlaUQBU5M5x6eO53JXo8jCGoAEjRGLLZOOF3az
 Hs5z9e+uauWcUbaZCNGf81Sy2ZJ3wrNx8yKtV4YYP2GPfQu66+mIf/0Pwdje4X9JWSJBLqXjO2e
 TkuaxjzFDtvRTHuYnn47OkaeU29r57BRGUkuNu4iADCAzpK777qpQ6/Ut89hRJdkM+6Xc/6+/S1
 Y22EjUqnN3vqendT9oeoGNYs7
X-Google-Smtp-Source: AGHT+IGdcN/9hk5cLV7miE4RJ2M+ETAJohx+OI8Jb+IfFCd0DmUcsfDicT2h8DEN7X0QQzqPNPSJbw==
X-Received: by 2002:a17:906:28d6:b0:ae3:cd73:efbc with SMTP id
 a640c23a62f3a-ae6b021b6c3mr41246466b.46.1751918986785; 
 Mon, 07 Jul 2025 13:09:46 -0700 (PDT)
Received: from localhost (ppp089210105145.access.hol.gr. [89.210.105.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f6ac62dfsm765310466b.105.2025.07.07.13.09.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jul 2025 13:09:46 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Jul 2025 23:09:44 +0300
Message-Id: <DB63G6T323QW.2AQUT656TKCGJ@linaro.org>
To: "Anshul Dalal" <anshuld@ti.com>, <u-boot@lists.denx.de>
Cc: <vigneshr@ti.com>, <trini@konsulko.com>, <nm@ti.com>,
 <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <a-nandan@ti.com>, <afd@ti.com>, <bb@ti.com>,
 <u-kumar1@ti.com>, <devarsht@ti.com>
Subject: Re: [PATCH v5 3/4] mach-k3: add dynamic mmu fixups for SPL stage
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
X-Mailer: aerc 0.20.0
References: <20250703133533.104758-1-anshuld@ti.com>
 <20250703133533.104758-4-anshuld@ti.com>
In-Reply-To: <20250703133533.104758-4-anshuld@ti.com>
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

Hi Anshul,

On Thu Jul 3, 2025 at 4:35 PM EEST, Anshul Dalal wrote:
> On platforms with spl splash support such as 62p and 62x
> (CONFIG_VIDEO=3Dy), the top of DDR is reserved for the framebuffer.
>
> The size of the framebuffer is computed at runtime by video_reserve.
> During the MMU configuration an entry corresponding to the framebuffer
> should be dynamically created to properly allocate the required space
> for the framebuffer.
>
> Therefore this patch adds k3_spl_mem_map_init which adds the required
> MMU entry by querying the gd after the framebuffer size has been
> computed in spl_reserve_video_from_ram_top.
>
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  arch/arm/mach-k3/arm64/arm64-mmu.c | 13 ++++++++++++-
>  arch/arm/mach-k3/common.c          | 17 ++++++++++++++---
>  2 files changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-k3/arm64/arm64-mmu.c b/arch/arm/mach-k3/arm64/=
arm64-mmu.c
> index 49dd6fcb23b..b1b287f2114 100644
> --- a/arch/arm/mach-k3/arm64/arm64-mmu.c
> +++ b/arch/arm/mach-k3/arm64/arm64-mmu.c
> @@ -131,6 +131,13 @@ static int k3_setup_extra_mem_banks(unsigned int *ma=
p_idx)
>  	return 0;
>  }
>
> +static void k3_spl_mem_map_init(unsigned int *map_idx)
> +{
> +	if (CONFIG_IS_ENABLED(VIDEO))
> +		k3_mmu_add_cachable_entry(gd_video_bottom(), gd_video_top(),
> +					  map_idx);
> +}
> +

I don't know wnough details for this board, but generally speaking we shoul=
d be doing
this commonly for all arm64 platforms. There's mmu code for that. Can you e=
xplain why
this is only useful to k3?

Thanks
/Ilias
>  static int k3_uboot_mem_map_init(unsigned int *map_idx)
>  {
>  	int ret;
> @@ -159,7 +166,11 @@ int k3_mem_map_init(void)
>
>  	map_idx++;
>
> -	ret =3D k3_uboot_mem_map_init(&map_idx);
> +	if (xpl_phase() =3D=3D PHASE_SPL)
> +		k3_spl_mem_map_init(&map_idx);
> +	else
> +		ret =3D k3_uboot_mem_map_init(&map_idx);
> +
>  	if (ret)
>  		return ret;
>
> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> index fc230f180d0..e72413b9803 100644
> --- a/arch/arm/mach-k3/common.c
> +++ b/arch/arm/mach-k3/common.c
> @@ -32,6 +32,7 @@
>  #include <dm/device-internal.h>
>
>  #include <asm/arch/k3-qos.h>
> +#include <mach/k3-ddr.h>
>
>  struct ti_sci_handle *get_ti_sci_handle(void)
>  {
> @@ -224,16 +225,26 @@ void spl_enable_cache(void)
>
>  	dram_init();
>
> -	/* reserve TLB table */
> -	gd->arch.tlb_size =3D PGTABLE_SIZE;
> -
>  	gd->ram_top +=3D get_effective_memsize();
> +	/* keep ram_top in the 32-bit address space */
> +	if (gd->ram_top >=3D 0x100000000)
> +		gd->ram_top =3D (phys_addr_t)0x100000000;
> +
>  	gd->relocaddr =3D gd->ram_top;
>
>  	ret =3D spl_reserve_video_from_ram_top();
>  	if (ret)
>  		panic("Failed to reserve framebuffer memory (%d)\n", ret);
>
> +	if (IS_ENABLED(CONFIG_ARM64)) {
> +		ret =3D k3_mem_map_init();
> +		if (ret)
> +			panic("Failed to setup MMU table (%d)\n", ret);
> +	}
> +
> +	/* reserve TLB table */
> +	gd->arch.tlb_size =3D PGTABLE_SIZE;
> +
>  	gd->arch.tlb_addr =3D gd->relocaddr - gd->arch.tlb_size;
>  	gd->arch.tlb_addr &=3D ~(0x10000 - 1);
>  	debug("TLB table from %08lx to %08lx\n", gd->arch.tlb_addr,

