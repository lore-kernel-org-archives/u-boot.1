Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C38D9E77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 06:58:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 471A388E5C;
	Sun,  8 Dec 2024 07:58:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OSVK+Bfu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A30E88E5C; Sun,  8 Dec 2024 07:58:05 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3477388A43
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 07:58:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-6eff5ad69a1so7874287b3.3
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 22:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733641081; x=1734245881; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A1jyWyWIXEsSG+4JnDz1hqh9Eqf6P68tKTqebUQ1QW4=;
 b=OSVK+BfuG1FEA6YGRuXrOih80o63qK4gFLilO0OWr17yTVhTMUJWV1t884uXLYjtRE
 NcILSeU6FdkDKgxtd809AAzcA9AUZNkBGfxpuNzuh1Q9Yuu4l/ZVr7CxAo1agetSycq+
 CFvTdcnQkBXvfDNlnEveI759P8SvSjIlLy5Gq/AzpiQDRXueLE93O1e0A/kjNehiUKFH
 NGn8KyeNqbVyWzjLAh6Fh9bsMTk7QTicn7OkTmexr7e4Cg8Wp2sVPoniT2xtkmheyV+5
 Yth3AFmNLQJLYtbIj2Cikk9HcdNcn0FmVIWRnv2k2Xo9GDmkXVaebC24efxYMaZjK5Qx
 Nb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733641081; x=1734245881;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A1jyWyWIXEsSG+4JnDz1hqh9Eqf6P68tKTqebUQ1QW4=;
 b=CjOxFx9gUGMIWiU7waRDZavc/Fp2p5njs6km/XZcvXjomvZCBK5uNQ6+heGtw3ed6P
 Xl6a7s6oSOgYzU27SUpACpWHWG8WYz00NPBe1CitCNssKiWiD3yj2zlK0mpI9QadHUTy
 ugn9P4muC47kbTeVrUKCYaLagkcIBR7AWdT77jwS8sIaMZnHewp8N2yD32W/4udNiXRY
 qK2lcLnxI76rGtN1tus2N2J+dhJqcwfKMgm76MTPG1fTM/+YUYmn53BjxSW49jcXjYf1
 +eebutjB+tBHkycdOjMc9WzVI4cC6GDn4In5XLS0cFEy7ZRqfzVWz0v3iyLJY8zsNk2l
 QiKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVI8owVEtCsnuRD0Ba0A9EvsvKLiQfeSm/HO9c9wWH3m8ymLhAT7++o/R0pPE1J3tRBj8XdZfU=@lists.denx.de
X-Gm-Message-State: AOJu0Yw5hbqqq/YpBSmfkOWHn7m7NkJxIxvyAKWqLzmvH1JUoMF7H8uj
 YxIUbJIxwfkWkOmvpBNn6afw9hhYIqtZ84eGf02sMpagtfT7ss0W9En5s/bzmWiiDpfjHJ9teYO
 M7OhlwiSpA5jbunOC2HcNoOYmYjaERlkSJvO0WA==
X-Gm-Gg: ASbGncu4zYGfvaywEn2t+EOxBOjuvfccNjMXPO3oHjRXR8GJ6O2lKWLxAeTrUsU7uHd
 2WQNfIqm9NjFYmvILVzxILx4yIpqn3bw=
X-Google-Smtp-Source: AGHT+IEyScbYgW1lH7a8kB7cdBt++D+8XXBoY90jMehKTl8B2m/XFSfDPg4pJqzlzpl4aYHymfJx4elO6A26wYRuX/E=
X-Received: by 2002:a05:690c:67c6:b0:6ef:a4ec:f69b with SMTP id
 00721157ae682-6efe3bfb6acmr76788177b3.10.1733641081040; Sat, 07 Dec 2024
 22:58:01 -0800 (PST)
MIME-Version: 1.0
References: <20241208002121.31887-1-semen.protsenko@linaro.org>
 <20241208002121.31887-7-semen.protsenko@linaro.org>
In-Reply-To: <20241208002121.31887-7-semen.protsenko@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 8 Dec 2024 08:57:25 +0200
Message-ID: <CAC_iWjJL7xkEUsvwWO4fg+yj=5VQnagKVGxBnNKS90w28vLoCw@mail.gmail.com>
Subject: Re: [PATCH 6/6] boot: fdt: Handle already reserved memory in
 boot_fdt_reserve_region()
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
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

On Sun, 8 Dec 2024 at 02:21, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> The boot_fdt_add_mem_rsv_regions() function can be called twice, e.g.
> first time during the board init (as a part of LMB init), and then when
> booting the OS with 'booti' command:
>
>     lmb_add_region_flags
>     lmb_reserve_flags
>     boot_fdt_reserve_region
>     boot_fdt_add_mem_rsv_regions
>                ^
>                |
>                +-----------------------+
>                | (1)                   | (2)
>     lmb_reserve_common        image_setup_linux
>     lmb_init                  ...
>     initr_lmb                 do_booti
>     board_init_r              'booti'
>
> That consequently leads to the attempt of reserving the same memory
> areas (described in the 'reserved-memory' dts node) in LMB. The
> lmb_add_region_flags() returns -EEXIST error code in such cases, but
> boot_fdt_reserve_region() handles all negative error codes as a failure
> to reserve fdt memory region, printing corresponding error messages,
> which are essentially harmless, but misleading. For example, this is the
> output of 'booti' command on E850-96 board:
>
>     => booti $loadaddr - $fdtaddr
>     ...
>     ERROR: reserving fdt memory region failed
>            (addr=bab00000 size=5500000 flags=2)
>     ERROR: reserving fdt memory region failed
>            (addr=f0000000 size=200000 flags=4)
>     ...
>     Starting kernel ...
>
> The mentioned false positive error messages are observed starting with
> commit 1d9aa4a283da ("lmb: Fix the allocation of overlapping memory
> areas with !LMB_NONE"), which removes the check for the already added
> memory regions in lmb_add_region_flags(), making it return -1 for
> !LMB_NONE cases. Another commit 827dee587b75 ("fdt: lmb: add reserved
> regions as no-overwrite") changes flags used for reserving memory in
> boot_fdt_add_mem_rsv_regions() from LMB_NONE to LMB_NOOVERWRITE. So
> together with the patch mentioned earlier, it makes
> lmb_add_region_flags() return -1 when called from
> boot_fdt_reserve_region().
>
> Since then, the different patch was implemented, adding the check back
> and returning -EEXIST error code in described cases, which is:
>
>    lmb: Return -EEXIST in lmb_add_region_flags() if region already added
>
> Handle -EEXIST error code as a normal (successful) case in
> lmb_reserve_flags() and don't print any messages.
>
> Fixes: 1d9aa4a283da ("lmb: Fix the allocation of overlapping memory areas with !LMB_NONE")
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  boot/image-fdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> index 3d5b6f9e2dc7..73c43c30684f 100644
> --- a/boot/image-fdt.c
> +++ b/boot/image-fdt.c
> @@ -77,7 +77,7 @@ static void boot_fdt_reserve_region(u64 addr, u64 size, enum lmb_flags flags)
>                 debug("   reserving fdt memory region: addr=%llx size=%llx flags=%x\n",
>                       (unsigned long long)addr,
>                       (unsigned long long)size, flags);
> -       } else {
> +       } else if (ret != -EEXIST) {
>                 puts("ERROR: reserving fdt memory region failed ");
>                 printf("(addr=%llx size=%llx flags=%x)\n",
>                        (unsigned long long)addr,
> --
> 2.39.5
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
