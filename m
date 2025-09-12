Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27403CA101F
	for <u-boot@archiver.kernel.org>; Fri, 12 Sep 2025 06:34:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C6B48334F;
	Fri, 12 Sep 2025 08:34:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="p8xrkMgE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68597833E9; Fri, 12 Sep 2025 08:33:59 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D9DE83322
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 08:33:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-7227bc08c97so17859297b3.1
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 23:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757658836; x=1758263636; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FJ9diK6rNWduvgZtttD3f1Zp4tA6wp3oLjiDXxuyXuE=;
 b=p8xrkMgE7Zk3gw1NgsFcbd7o2/L7lOgABNoHb0/Ywy/h9E94i4jSSyxMfSYrofbxJG
 52Mbu4sWeYOPmOWU9gYgEL2zHJ64D5VizO4hxjZTTKYxouB4pkefbk5Cv8QfRD++1s+t
 H8RSrgIE1UVQmnso1NZzFlv1pBtAKZ086YzTzE8mydR7/P7p88AyR2Gxgu49gnlZZRbE
 fX0vWzqw5hauhRT/4esY9f/kArdFBHmVli6YziOn9e2beQNQTAomWi/nS7v/UXb7eDlv
 fyyRM/8H7BMag8JYDMsd8vzkDuy0tSNqtZykswHl+U2UuTwLeuuu6FWFHO5FtlTEJ2+8
 x/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757658836; x=1758263636;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FJ9diK6rNWduvgZtttD3f1Zp4tA6wp3oLjiDXxuyXuE=;
 b=ZVW35cLZwZoEQCyBQ59PSa5u6ApF/nsnGMfxtlLXk6pQN9Q9F95wvfmsjSirWjcdpL
 FNApyGBW/6sUy3DnhBKQ0VW8wqcWLbrnYAOXaxou5BsVO1kw2F/rBY3KRwsRHlBAexsf
 +erE7uwwYiYi6Gvm6QrKqjd2qRwlUSTsBNdguR1GGoqt6uYyv/qM84BdF4wrVWoiP6HD
 HFsm0d87szx0Is8Hp1eN0EWMP/O6QxweTlX2UQRLlOcaS2a3BFashUOj3rn7m6Bt8Ss/
 i3QtPT+7JzSfAEg+2iTBDwoNc6g+ai6vxl7qNdvYCNS+nKvC+Yy4AnnqvO+Sa1wF+ZYU
 AHpg==
X-Gm-Message-State: AOJu0Ywhs1HjAUuDUVzBtI1cUPYvS97fWkKUBGrAC95Mi62/7+zmkBps
 s+iPMZ5uipQGuaYOfJSOZJ5XpZrzkb2V3r1P1cHSzJI+v/N31bXDbmWVcQ3QLot2PAz7iWXAv55
 z7jUAqOHGltILb0cm6H6FIlAKGVIWPlFzw1gnPiyw/Q==
X-Gm-Gg: ASbGncsh3M2Zuj0NiKrOCueLEs1gSG1VRoM7rcB18An4SSu3x+qAyrqyqi4kZR0FAsz
 xuJ29hjr/I++mP8KTIyh8DNzYXuu85Tny1sahFs0dG7gkwQKnNh7vycNhSsTq/dPclKtJCxLnpr
 3IAD65UdHg6WeQ7+fXdWkYT7RUUBl6brIcQoNcCedPMEyCg4k1I/5Tm6OLJJfzZfybbCPWph7Wd
 g0M10h7um2973fL7bUixdSHGr9E/1x2+FOrehMup8XEGT085nMm/SmHjESHqq7pwBtyt/tShb/+
 0j7sKnXBodVklrbsSmF7ZolQbfLLTD0TH7GSWGJ97UENFywWp1pXKxda2TTAlRE=
X-Google-Smtp-Source: AGHT+IGl1rwHT9YEx8Wv3n+7oIMipDLnc3upd6CaWthLhIknwRW1HjtyDzrC+tfc/89sE4dD3ahXNmsZucFlX64wiAY=
X-Received: by 2002:a05:690c:b86:b0:71b:f46e:691 with SMTP id
 00721157ae682-7306a0393b9mr18597547b3.11.1757658835878; Thu, 11 Sep 2025
 23:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250905081902.489345-1-anshuld@ti.com>
 <20250905081902.489345-6-anshuld@ti.com>
In-Reply-To: <20250905081902.489345-6-anshuld@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 12 Sep 2025 09:33:20 +0300
X-Gm-Features: Ac12FXzQ3EMLv87L8fUhV-cYSkltEGMlkaD_nei3H_YiYoRUkj027mVBGg2IuF8
Message-ID: <CAC_iWjJos1Xu0LWK4aqJ9aq2UZhor8uvnGRVg1xKs69HmnhP6A@mail.gmail.com>
Subject: Re: [PATCH -next v6 05/10] arm: armv8: mmu: add mem_map_fix_dram_banks
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, d-gole@ti.com, b-padhi@ti.com, vigneshr@ti.com, 
 trini@konsulko.com, nm@ti.com, robertcnelson@gmail.com, w.egorov@phytec.de, 
 francesco.dolcini@toradex.com, ggiordano@phytec.com, m-chawdhry@ti.com, 
 a-nandan@ti.com, afd@ti.com, bb@ti.com, u-kumar1@ti.com, devarsht@ti.com
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

Hi Anshul,

On Fri, 5 Sept 2025 at 11:19, Anshul Dalal <anshuld@ti.com> wrote:
>
> For armv8, U-Boot uses a static map defined as 'mem_map' for configuring
> the MMU as part of mmu_setup.
>
> But since the exact configuration of memory banks might not be known at
> build time, many platforms such as imx9, versal2 etc. utilize
> gd->bd->bi_dram to configure the static map at runtime.
>
> Therefore this patch adds a new API mem_map_fix_dram_banks that modifies
> the static map in a similar way. Allowing for anyone to map all dram
> banks by just passing the index to last entry in their mem_map and it's
> length.
>
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  arch/arm/cpu/armv8/cache_v8.c    | 27 +++++++++++++++++++++++++++
>  arch/arm/include/asm/armv8/mmu.h | 10 ++++++++++
>  2 files changed, 37 insertions(+)
>
> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> index 6e662395a83..edb895da1f2 100644
> --- a/arch/arm/cpu/armv8/cache_v8.c
> +++ b/arch/arm/cpu/armv8/cache_v8.c
> @@ -58,6 +58,33 @@ static int get_effective_el(void)
>         return el;
>  }
>
> +int mem_map_fix_dram_banks(unsigned int index, unsigned int len, u64 attrs)
> +{
> +       unsigned int i;
> +       int ret = fdtdec_setup_memory_banksize();
> +
> +       if (ret) {
> +               printf("%s: Failed to setup dram banks\n", __func__);
> +               return ret;
> +       }
> +
> +       if (index + CONFIG_NR_DRAM_BANKS >= len) {
> +               printf("%s: Not sufficient space in memory map\n", __func__);
> +               return -ENOMEM;
> +       }

The length of the mem_map array is configured at compile time.
So this is going to fail for all existing boards unless someone
explicitly changes the size of their struct mm_region.
I think if we go down that path, we need to change the error message
as well and point them to the right direction

> +
> +       for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
> +               mem_map[index].virt = gd->bd->bi_dram[i].start;
> +               mem_map[index].phys = gd->bd->bi_dram[i].start;
> +               mem_map[index].size = gd->bd->bi_dram[i].size;
> +               mem_map[index].attrs = attrs;
> +               index++;
> +       }
> +
> +       mem_map[index] = (const struct mm_region){ 0 };

Why do you need the const?
Can we do
memset(&mem_map[index], 0, sizeof(mem_map[index]));
instead?

[...]

Thanks
/Ilias
