Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D86A8CCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 13:00:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 589AC83734;
	Fri, 17 Oct 2025 15:00:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tFEg2mLe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A32FE837E4; Fri, 17 Oct 2025 15:00:56 +0200 (CEST)
Received: from mail-yx1-xb135.google.com (mail-yx1-xb135.google.com
 [IPv6:2607:f8b0:4864:20::b135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B749383710
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 15:00:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-635401a8f5aso1803569d50.1
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 06:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760706052; x=1761310852; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rpVxWi7LUbvJROZYJpCPsGS8YiDCIVbHNj0WqJNoeTQ=;
 b=tFEg2mLenVdTW4KtPtXnSPr/Z6q+rqkZIUytZ9dLxlHPvk+VONtcvGHZ4GS5IWt1YI
 ki0uz33iq6OJry9LzbArluQvAh3H/UUeDtwAJMRhaMKd/+e/NmLb9IYrYFlW3IGrbXRU
 oFjhyRymw5trz80SY8CZh7vkaa3fHidox0ERYsQAqSIQfHpWvQzEoXsTmK30TJIurWEQ
 bsGtfPRkQDmcyg31ILJYCEHwdhpHRnwFt3W8S8lIwqiZGbD/59xaLdKFwg7pabp4MjM9
 kjr8i7+Pb1t6D+7Jyc6/hjiMiEWj+BuVmXNaPljF2DLYWNYkwrjvfFxwqf20hifMvUBM
 B7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760706052; x=1761310852;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rpVxWi7LUbvJROZYJpCPsGS8YiDCIVbHNj0WqJNoeTQ=;
 b=DhsHlbIskRp1F8hWBO/IR2lHP3ejaezV3NPvQgt9dGb4AZD47nZcX5mgQ1jD/sRUKM
 aBZZzChBc62jqg6IKsGo59QoeUlECKZ6js29jZi65O0wqUMjcuR0B4ujnFG6gZnxO1n2
 rQu5BgaON3qQRed4KNjM21dZe4MbCh3YEsRNv2gBbFbjSCod5EWoxovfww4wsRd2ihwr
 eMtQUgpyzXFL+4OsIwXGq7skMFQ8UrndXHjQ0CMpV7jd1AQsxqeNhpK2O83MaLR50wka
 t+SBRQ+3JgTXYqW3Kb+veKiM934RyXyHxRwP94oRvAW6Y8L31DHJaskllZTiTwxBe21r
 +Gcw==
X-Gm-Message-State: AOJu0YzKQQAoQDrB+pbxGdZgGRb4e+aCVSZMdiKXU/vt55uQWSwnfoyM
 yQcs2yNOMTuGw4xQAILKL5Jj0Mj3z+Dk3EhAb7xZgJb8+OOnBiyBoWcIeS1WK+6y0ppx37FbXFR
 cNAQryp1RBNhKf+YHYq6vXhRBcS6vV+bURvL7L6s8WQ==
X-Gm-Gg: ASbGncsEVCvihh7UViFx52m7arPw1dWrT89hRs0BpoxxIAvn6B1XcVKO340KJJFXeUn
 jHed9UaMAiZ4ld3hM116DDLGuZg6yTVugoWfFLeSEJt7wImpW4jiRi7WibTnEHACgOKwxvAZpfq
 B0t0HUjliM6aLoLOhdW0ya2GfNWAfOF8LjmgtFD+93vzNEjjGbedPohv55r7FPckWNAomtGO03Z
 ttQDV9izVEImg1PhFrgl6xSmpgR18vya5aDkGG3uFPRc0wPN8DNWOzOysjieVfMXn0IiceSQRdd
 FWMnOfyWlLhEZnWYUFmJrxMbBPi96P+9Sg+RhB4L
X-Google-Smtp-Source: AGHT+IF/HecFxNXXiHL8qDzPB4SBeXgVvAm5vfo0L/zfHZ45Ynb26pHrrPdTGtaw2mrr2FZP0k4yl60z4hD2VsTw3AE=
X-Received: by 2002:a05:690e:118e:b0:63e:bce:b4ea with SMTP id
 956f58d0204a3-63e1623f618mr2638924d50.36.1760706052189; Fri, 17 Oct 2025
 06:00:52 -0700 (PDT)
MIME-Version: 1.0
References: <20251010134424.3835757-1-anshuld@ti.com>
 <20251010134424.3835757-6-anshuld@ti.com>
 <CAC_iWj+pyDhYnaJE+eX8LP+Czu13+oH+H1XfMbH4wWgVqY6k2w@mail.gmail.com>
 <DDKLWVUX1CPJ.3EMPE1DELU070@ti.com>
In-Reply-To: <DDKLWVUX1CPJ.3EMPE1DELU070@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 17 Oct 2025 16:00:15 +0300
X-Gm-Features: AS18NWAfX1NHuLTide-siH_LmO2CLH1JMJpo--Ols1TlhzKDaLa2ZHyWj2_J_fg
Message-ID: <CAC_iWjJjNVQLfKfbkAmmcm6y0VDSaGibR59kF+pbZGbWb+kBuw@mail.gmail.com>
Subject: Re: [PATCH v10 05/11] arm: armv8: mmu: add mem_map_from_dram_banks
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, d-gole@ti.com, b-padhi@ti.com, vigneshr@ti.com, 
 trini@konsulko.com, nm@ti.com, robertcnelson@gmail.com, w.egorov@phytec.de, 
 francesco.dolcini@toradex.com, ggiordano@phytec.com, m-chawdhry@ti.com, 
 afd@ti.com, bb@ti.com, u-kumar1@ti.com, devarsht@ti.com, xypron.glpk@gmx.de
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

On Fri, 17 Oct 2025 at 15:47, Anshul Dalal <anshuld@ti.com> wrote:
>
> Hello Ilias,
>
> On Fri Oct 17, 2025 at 5:39 PM IST, Ilias Apalodimas wrote:
> > Hi Anshul,
> >
> > On Fri, 10 Oct 2025 at 16:44, Anshul Dalal <anshuld@ti.com> wrote:
> >>
> >> For armv8, U-Boot uses a static map defined as 'mem_map' for configuring
> >> the MMU as part of mmu_setup.
> >>
> >> But since the exact configuration of memory banks might not be known at
> >> build time, many platforms such as imx9, versal2 etc. utilize
> >> gd->bd->bi_dram to configure the static map at runtime.
> >>
> >> Therefore this patch adds a new API mem_map_from_dram_banks that
> >> modifies the static map in a similar way. Allowing the caller to map all
> >> dram banks by just passing the index to last entry in their mem_map and
> >> it's length.
> >>
> >> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> >> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> >> Tested-by: Wadim Egorov <w.egorov@phytec.de>
> >> ---
> >>  arch/arm/cpu/armv8/cache_v8.c    | 28 ++++++++++++++++++++++++++++
> >>  arch/arm/include/asm/armv8/mmu.h | 11 +++++++++++
> >>  2 files changed, 39 insertions(+)
> >>
> >> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> >> index 74c78cb2fb0..9b3c37dae82 100644
> >> --- a/arch/arm/cpu/armv8/cache_v8.c
> >> +++ b/arch/arm/cpu/armv8/cache_v8.c
> >> @@ -58,6 +58,34 @@ static int get_effective_el(void)
> >>         return el;
> >>  }
> >>
> >> +int mem_map_from_dram_banks(unsigned int index, unsigned int len, u64 attrs)
> >> +{
> >> +       unsigned int i;
> >> +       int ret = fdtdec_setup_memory_banksize();
> >> +
> >> +       if (ret) {
> >> +               log_err("%s: Failed to setup dram banks\n", __func__);
> >> +               return ret;
> >> +       }
> >> +
> >> +       if (index + CONFIG_NR_DRAM_BANKS >= len) {
> >> +               log_err("%s: Provided mem_map array has insufficient size for DRAM entries\n",
> >> +                       __func__);
> >> +               return -ENOMEM;
> >> +       }
> >> +
> >> +       for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
> >> +               mem_map[index].virt = gd->bd->bi_dram[i].start;
> >> +               mem_map[index].phys = gd->bd->bi_dram[i].start;
> >> +               mem_map[index].size = gd->bd->bi_dram[i].size;
> >> +               mem_map[index].attrs = attrs;
> >> +               index++;
> >> +       }
> >> +
> >> +       memset(&mem_map[index], 0, sizeof(mem_map[index]));
> >> +
> >> +       return 0;
> >> +}
> >
> > Is there a reason we add all the memory maps now and remove them later
> > with mmu_unmap_reserved_mem(). IOW we could add the DT parsing in this
> > function and not map the 'no-map' addresses to begin with.
> > Unless someone changes the DTB on the fly ?
> >
>
> There are two reasons for doing it this way:
>
> 1. Modifying mem_map directly makes creating multiple carveouts quite
> complex with the logic for handling all the edge cases, for example see
> v4[1] of this series. It's much simpler to use the MMU APIs instead
> after calling mmu_setup with everything mapped in mem_map.
>
> 2. We can't blindly unmap all 'no-map' regions since some regions that
> would be 'no-map' in the kernel's context are required at U-Boot, like
> the memory pools for remote cores that rely on U-Boot to load their
> firmware.

Fair enough. Since you'll send a V11 adding this on the description
helps. Also mention that this should all happen before enabling the
caches, so mapping memory that is marked as no-map; shouldn't cause
any crashes

Thanks
/Ilias
>
> Regards,
> Anshul
