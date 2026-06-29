Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F57C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 07:52:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF226841F2;
	Mon, 29 Jun 2026 09:52:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Qzbni+PM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 224C584105; Mon, 29 Jun 2026 09:52:15 +0200 (CEST)
Received: from mail-yx1-xb133.google.com (mail-yx1-xb133.google.com
 [IPv6:2607:f8b0:4864:20::b133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61C7684105
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 09:52:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-664e3ed58bcso341911d50.1
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 00:52:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782719530; cv=none;
 d=google.com; s=arc-20260327;
 b=dpZbW4XIo+Kd2+/vZSNKq1AEp7/z0CHAFMskVH7cfBpVqisXVjneOjdGu5Ea9kbnK4
 SvLo/mtqureu0ITmFleLLeiTRPmNoJr9wJ68vI/CmRf9pgb1C8BiyFM9LHpCRxFXAM5/
 LxmiFQ/wPHKjuOlJU04uPQrw9gKO3+gP09gFraAI75uqSANNnQ9UehnMfDvIbJxNlUle
 EsyBbOAiAn/SjnCLnzFcz5ZyFGCKLNKWDqAIaC69FU+aX1i1j85gOsTQSGXPY6JTMyDU
 3NoARBUlfJQ7WFxpRhpt9H8syIg0WPmVYbBF/d52sLbLvUEdjgk+3WyKV6IgYQ29d53C
 ID8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4O35/PizOG5DNmnK8wMxEcziCBs4csD23Fvakcz6tkU=;
 fh=1VnWZbJSzak5E2EMwpXvDabsx6XMyRYgfdGNvKqaic8=;
 b=pb0ZwA3ICqZpKrsbwojxLq7XeSXh3+0tH5bcr2yCh5aZQGVidr+Lq0JVUPwrO/KRkB
 ABkVfCNzgl20cBObyEsSGkC8jEwhIXzuzKQwe0hnvdObqVdRYOBBIINcQ8HZyg7MW56C
 XeSRtxWYfm6Rv9R20twwCPpxdgMXYDOROTxl1QnFNH8gEMMhzP9DDyFMDikOkzxsknbw
 jmSn3nNIBgA++OV6w7hcjFqKO+lgJIkIncq1+/tPmzgkVkc77P8EEKwr+02+O503kmYG
 kmqOAiz1yAF97v8p6kmNDtjGLa18bE+gvXMcZ2O1trG9vrqnfSV7pR0AQ9FcRcHFokMy
 nwzw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782719530; x=1783324330; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4O35/PizOG5DNmnK8wMxEcziCBs4csD23Fvakcz6tkU=;
 b=Qzbni+PMLj3Gdd53syRKyYg8iFS90z/zEUJO/ZhS5YNr2yWdpurXO4iTNsWgvtM1X9
 e6k2LFvXh3AdfCHwQaxh9N0YY6up0x7fdZrcK/Tc+87K2E1d4y+nXoMmdRb5CYG87Grp
 g5fUkvAjsuVrzJuzSQiDvJscnAOgVFsfKSDKXdYrsALD2mjjUtRwB9Krx0Rc9TAsoWZW
 ZVtDT4KhSArtdR9+iwe6hSuUQ74fzHBIj5Gc0CczqaXSRbr/Kf7t1KClFMqTdHdgf4w5
 62/L0jZ9lTHSEXiF+kALn/Hmy7PIsHjm7UpPJQtrRwAeW/+Fv4d5e5RWa3Si61rc/10k
 K3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782719530; x=1783324330;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4O35/PizOG5DNmnK8wMxEcziCBs4csD23Fvakcz6tkU=;
 b=IeQ/xZ3BN3TVPN0hyXA0fruOjvJsoMO/Jscm9+aT7Espelf9b/WF6dkFg4lobW9OD/
 LICDFp3Ywihfg/XzAthiz+CZEk3QempE0ObYFrO+H0iCHTpD5M18lozjpAN1aaJeMzoQ
 flRtYa0VMwHVRLbSlLZFu2lt4SJT0I3Yfi0aauGafkF+KR5XD85F8cmlOE6K/zDjiySA
 KxXbTjhXlVAQnVaT7vBxbvbYLnA5+zNME/2lJZEPVvJq49Kg+6U0kZraIwwH1+eCLccK
 e3OsrUE4yY2YNZIyaxJ+HEsrK3lckKjRbFjmbpwY/6nePpRB2WPD/UF3d4tL9uzUnVCs
 4r0A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rro/aKnEO8LpDbZCj7089CECBUKojMiZ+ENH5DeRhw/2ZF74jop4UehUzH2oK+Vaqqe0cg6Dyo=@lists.denx.de
X-Gm-Message-State: AOJu0Ywg70hSxkh/Q8+VLDYmMnwlMfPPYfcC+ll6E6dXYBi9Eol0t8PE
 JGHp/+9oGiBM5bqyps82tdWh9xseAN6MuD47eFwm7xT57hUT5FmD9G7pv00Wf6ZoSAlK6f/hJ2Q
 zQrezMMzW1vTTwlvnZafJ53BpELGyW8rbTPMwgUvS/w==
X-Gm-Gg: AfdE7cnHJ8W6A3brffJudhnVp1uow4aLd4IEb6GEHGGDD8AJ+2qwDlMdyggydmHZTK4
 KG5F9WQjGHViPAjzSp23IxPtS+v4cFleactsBboMlY7ZGcGW0M/VL0fI+ICVDi/6RW9ZXKbvvjO
 I+dOOztbvj+oRMSMyORxTUT7R2zV3JpCNHTq39UHvSM3VIaN5yzNysQ8wp5g07DjWlmqMFQnuLo
 AOatdCC2hqvhULAEGbQny7fcNxi/dO+XdSWT+rdgbURjbDRw2+3VIghr8bct5U58sCQQpoTKvre
 fsu5/joGBNnJHs1d2Zqt/4TXX3WAQpuxvEYeQ5OyaZek7EugdfLviXLnle78jnZUBJw1VvWCaFm
 i1WDAECA8EZvUvjHrcIywN0mGWKr2kErc4yO/172sj7O+Am+II85MEYeOCQivt4D7hGt1X9Ojuj
 SEIiKaYY5sC0LYpIUU42EfA2b3ANKgyCd6EF4mkEt/7VROSaOMVUqGFhw/hg/kKzzhWmnUICMNC
 XN2WkWpC2OVuxE/pr/nqOnnuhiizVqAYvnaS1VWROsB2DBwqEamfXxlsjnlXhOXoM/Jppg8fY9/
 psz/HV7LeWGJ9YXRKqiryyqToiOBs5V4kh6UYQcyXkv5iQZLVrMO0k5VzGixSWeU9lhXl+U=
X-Received: by 2002:a05:690e:d07:b0:664:a8fa:19db with SMTP id
 956f58d0204a3-664a8fa1a3dmr9534934d50.5.1782719530075; Mon, 29 Jun 2026
 00:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260627202410.1148976-1-jonas@kwiboo.se>
In-Reply-To: <20260627202410.1148976-1-jonas@kwiboo.se>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 29 Jun 2026 10:51:34 +0300
X-Gm-Features: AVVi8CfLLZIITEala4GNYx1DCgkyvbzPr2gT4NcLjJEO2Xd2rj5a2hoMhpnxoE8
Message-ID: <CAC_iWj+VC06ybFpMwa50P=eoAUk6bBh1=z89c99J7zb5UtcrCw@mail.gmail.com>
Subject: Re: [PATCH] rockchip: sdram: Fix initialization of DRAM banks
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Thanks Jonas

On Sat, 27 Jun 2026 at 23:24, Jonas Karlman <jonas@kwiboo.se> wrote:

> The commit 55a342176984 ("common: Add an option to relocate on ram top")
> changed so that dram_init_banksize() is called before gd->ram_top has
> been initialized. This change broke Rockchip DRAM banks configuration
> due to gd->ram_top now being 0 when dram_init_banksize() is called.
>
> This makes first DRAM bank size calculation overflow and end up with
>
>   DRAM bank   = 0x0000000000000000
>   -> start    = 0x0000000000200000
>   -> size     = 0xffffffffffe00000
>
> instead of the expected (for 2 GiB)
>
>   DRAM bank   = 0x0000000000000000
>   -> start    = 0x0000000000200000
>   -> size     = 0x000000007fe00000
>
> or (for 4 GiB)
>
>   DRAM bank   = 0x0000000000000000
>   -> start    = 0x0000000000200000
>   -> size     = 0x00000000f7e00000
>
> on e.g. RK3399 boards.
>
> Change to not depend on gd->ram_top having to be pre-calculated before
> dram_init_banksize() is called, also move the related method
> board_get_usable_ram_top() closer to more easily get an overview of
> their interdependence, to restore working DRAM bank initialization.
>
> Fixes: 55a342176984 ("common: Add an option to relocate on ram top")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---


I tested in on one board I got available

SoC: Rockchip rk3399
Reset cause: unknown reset
Model: Radxa ROCK Pi 4A
DRAM:  4 GiB (total 3.9 GiB)

[...]

=> bdinfo
boot_params = 0x0000000000000000
DRAM bank   = 0x0000000000000000
-> start    = 0x0000000000200000
-> size     = 0x00000000f7e00000
flashstart  = 0x0000000000000000
flashsize   = 0x0000000000000000
flashoffset = 0x0000000000000000
baudrate    = 1500000 bps
relocaddr   = 0x00000000f3f0c000
reloc off   = 0x00000000f370c000
Build       = 64-bit
current eth = ethernet@fe300000
ethaddr     = e6:9a:46:f0:87:25
IP addr     = <NULL>
fdt_blob    = 0x00000000f1eeccf0
Video       = vop@ff8f0000 inactive
Video       = vop@ff900000 inactive
lmb_dump_all:
 memory.count = 0x1
 memory[0]      [0x200000-0xf7ffffff], 0xf7e00000 bytes, flags: none
 reserved.count = 0x2
 reserved[0]    [0xf0ee7000-0xf0eebfff], 0x5000 bytes, flags: no-notify,
no-overwrite
 reserved[1]    [0xf0eecce0-0xf7ffffff], 0x7113320 bytes, flags:
no-overwrite
devicetree  = separate
serial addr = 0x00000000ff1a0000
 width      = 0x0000000000000004
 shift      = 0x0000000000000002
 offset     = 0x0000000000000000
 clock      = 0x00000000016e3600
arch_number = 0x0000000000000000
TLB addr    = 0x00000000f7ff0000
irq_sp      = 0x00000000f1eecce0
sp start    = 0x00000000f1eecce0
Early malloc usage: 2510 / 10000

Reported-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Tested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org> # on Radxa ROCK
Pi 4A


>  arch/arm/mach-rockchip/sdram.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/sdram.c
> b/arch/arm/mach-rockchip/sdram.c
> index f0923186fa61..2e404df1b200 100644
> --- a/arch/arm/mach-rockchip/sdram.c
> +++ b/arch/arm/mach-rockchip/sdram.c
> @@ -294,10 +294,20 @@ __weak int rockchip_dram_init_banksize_fixup(struct
> bd_info *bd)
>         return 0;
>  }
>
> +phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
> +{
> +       /* Make sure U-Boot only uses the space below the 4G address
> boundary */
> +       u64 usable_top = min_t(u64, CFG_SYS_SDRAM_BASE + SDRAM_MAX_SIZE,
> SZ_4G);
> +
> +       return (gd->ram_top > usable_top) ? usable_top : gd->ram_top;
> +}
> +
>  int dram_init_banksize(void)
>  {
> -       size_t ram_top = (unsigned long)(gd->ram_size +
> CFG_SYS_SDRAM_BASE);
> -       size_t top = min((unsigned long)ram_top, (unsigned
> long)(gd->ram_top));
> +       /* Make sure first bank uses the space below the 4G address
> boundary */
> +       u64 usable_top = min_t(u64, CFG_SYS_SDRAM_BASE + SDRAM_MAX_SIZE,
> SZ_4G);
> +       size_t ram_top = (unsigned long)(CFG_SYS_SDRAM_BASE +
> gd->ram_size);
> +       size_t top = min((unsigned long)ram_top, (unsigned
> long)(usable_top));
>
>  #ifdef CONFIG_ARM64
>         int ret = rockchip_dram_init_banksize();
> @@ -507,11 +517,3 @@ int dram_init(void)
>
>         return 0;
>  }
> -
> -phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
> -{
> -       /* Make sure U-Boot only uses the space below the 4G address
> boundary */
> -       u64 top = min_t(u64, CFG_SYS_SDRAM_BASE + SDRAM_MAX_SIZE, SZ_4G);
> -
> -       return (gd->ram_top > top) ? top : gd->ram_top;
> -}
> --
> 2.54.0
>
>
