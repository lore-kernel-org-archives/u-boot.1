Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893CFCCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 12:02:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 551CF841E6;
	Fri, 10 Oct 2025 14:00:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EaUaGHjk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15E0783FF0; Fri, 10 Oct 2025 14:00:18 +0200 (CEST)
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com
 [IPv6:2607:f8b0:4864:20::b12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C79EF8421E
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 14:00:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-635401a8f5aso2320713d50.1
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 05:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760097614; x=1760702414; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Vf7kK5vTqY3xAuf7e/dZmm3aBfF8c/YVkB5xNLD4pck=;
 b=EaUaGHjkf//U+nd+wHC69gGUSxvaKMIPTl9kcbI7KqdvSPI+sZ5KjNL4GAhTIs80uU
 eWXp+/mdJslL6jV5527TS7dahCARcWCWIStk0AnK86U93t1NagVQTxmnw0ybpwHni97M
 BDiy+O9KlDm0m+4Yh0Ai+Mb0yQAT8Q4z25itqXuO5V6D+y3muYnoSq+CXxiK6qm6c3XY
 pzKoF9LP3BPpbFQ5iwMsETPh5WhY3jgUgoOHl3phbeI7UEaqMOq0SK+pkgqSUgEYAkNC
 6hU5ojC7YONccTfdCCw6A7hYvUJq0jkhe+iORRtf9hGdQfhmFR7297Fv+lSHu5BzYW6x
 YWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760097614; x=1760702414;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vf7kK5vTqY3xAuf7e/dZmm3aBfF8c/YVkB5xNLD4pck=;
 b=jfhzuG9E9KF5Y1z7TkP3nzu0LsRnzq2GhfxDQSwJnHykzXpmgXBBxHG+osk/iYW+e7
 LnYIIJ75GIDYO5uJMgP3i3TzXzL62xnukgnxKmKKl3STAyrwyFJTFSGlwNrRqhN1pZ2f
 8628pwPQ0XgUTVNnSH4dVdUcyH0nqH21WY10Kj2pwSOYQOu0uefC0+UG/6YKvgnMgDPl
 /6cgwKbhlMuyfcaNAlbvgOW4NaxBQ+lWJ3Olc2H8Wwtv+OlAOU0KKRlZHz7prTLEAa9C
 2e6vSsha5iKa8QPZztH1nV6WEn+TgO6ccUctiVekrPtns2TjMfPFPlf4vJjFBCDmFv9I
 FTtg==
X-Gm-Message-State: AOJu0YzGxiRXcI8z4sRJpN+eaQwltxVURAKnB5KpG72SfivlOCBOuD2/
 G+JZlfFXMy8dCLaUnhTF4QvBtOKHVOyv3pAmxAvvvyrjxOY3GupdHhFPTvnAl7QA6EFm8e2eHGM
 B30cG1T3EB7gtPM4h/bZcB2RWlu6KOFsnlFKa5xLeDQ==
X-Gm-Gg: ASbGncuQcbS8IWkgKV0m4aXOWK92zXpA/fAZDpbY4DIzg+tVRY+/m76Y5NOPhZBDWgn
 KQt4lP9s9dGl/xVxrEGeciazA714j83Mh0Y5CDSVsuV3S43C/KGX+8ku68VCP9EmXNFmRMUHKbz
 RgIODrM7+oF+oTAWlniHkQlcxBaB49oIlidgJ4JK/sblkOGK9tuetMXFRhlKfOrDl3gHE+5l66m
 m/cQjLcblq+1eS52Bj9Rl7q6X6PN2t5AV8W/RbHbl5WWKT1dDgCRpmT/5GgAgfp0OW1mVymRXTH
 gxD6GUYafg==
X-Google-Smtp-Source: AGHT+IHMJrceFm7db5FZ2FZLNhNqEJc0pA/NWYWHhUYN+s0KvSAS2zZ9pM+mjKvZAYrQKDLrd4d3/FetcOHQLoz2rm4=
X-Received: by 2002:a53:ea91:0:b0:635:4ecc:fc2b with SMTP id
 956f58d0204a3-63ccb967475mr7959515d50.51.1760097614225; Fri, 10 Oct 2025
 05:00:14 -0700 (PDT)
MIME-Version: 1.0
References: <20251010055340.2574743-1-anshuld@ti.com>
 <20251010055340.2574743-6-anshuld@ti.com>
In-Reply-To: <20251010055340.2574743-6-anshuld@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 10 Oct 2025 14:59:38 +0300
X-Gm-Features: AS18NWD2fzdn2OkT-bFXku1zc61zS0cGROoWCzRpe5Y6Gd3vtOyoEli9-YltZ-8
Message-ID: <CAC_iWjJGbmO9-EDN4HQ7EP1ee=6ZPd_8M8Sgv9Pkq0=orUU5-A@mail.gmail.com>
Subject: Re: [PATCH v9 05/11] arm: armv8: mmu: add mem_map_fix_dram_banks
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

On Fri, 10 Oct 2025 at 08:53, Anshul Dalal <anshuld@ti.com> wrote:
>
> For armv8, U-Boot uses a static map defined as 'mem_map' for configuring
> the MMU as part of mmu_setup.
>
> But since the exact configuration of memory banks might not be known at
> build time, many platforms such as imx9, versal2 etc. utilize
> gd->bd->bi_dram to configure the static map at runtime.
>
> Therefore this patch adds a new API mem_map_fix_dram_banks that modifies
> the static map in a similar way. Allowing the caller to map all dram
> banks by just passing the index to last entry in their mem_map and it's
> length.
>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> Tested-by: Wadim Egorov <w.egorov@phytec.de>
> ---
>  arch/arm/cpu/armv8/cache_v8.c    | 28 ++++++++++++++++++++++++++++
>  arch/arm/include/asm/armv8/mmu.h | 10 ++++++++++
>  2 files changed, 38 insertions(+)
>
> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> index 74c78cb2fb0..cdf17d5f396 100644
> --- a/arch/arm/cpu/armv8/cache_v8.c
> +++ b/arch/arm/cpu/armv8/cache_v8.c
> @@ -58,6 +58,34 @@ static int get_effective_el(void)
>         return el;
>  }
>
> +int mem_map_fix_dram_banks(unsigned int index, unsigned int len, u64 attrs)

Nit, but perhaps mem_map_from_dram_banks() is a better name?

> +{
> +       unsigned int i;
> +       int ret = fdtdec_setup_memory_banksize();
> +
> +       if (ret) {
> +               printf("%s: Failed to setup dram banks\n", __func__);
> +               return ret;

We already include <log.h>, so I prefer using log_err() etc.

> +       }
> +
> +       if (index + CONFIG_NR_DRAM_BANKS >= len) {
> +               printf("%s: Provided mem_map array has insufficient size for DRAM entries\n",
> +                      __func__);
> +               return -ENOMEM;
> +       }
> +
[...]

Thanks
/Ilias
