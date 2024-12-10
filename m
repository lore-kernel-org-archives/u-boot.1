Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC6AE7717F
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 09:54:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC9498946B;
	Tue, 10 Dec 2024 10:54:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RPNenWRE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9585894BA; Tue, 10 Dec 2024 10:54:26 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 409338910B
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 10:54:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d3f65844deso3266008a12.0
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 01:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733824464; x=1734429264; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jtPMskVVQTEzMbeimgYhbmsqyvBqNwgdxGb1V1slmvg=;
 b=RPNenWREfYMhlgnV07VRybvCwoVcrtMYlRXTzE8b3J+YHfPRJ8ogE1IAmyX+cnn3bY
 i+t7xakKX62oZM+ozUIJvloqFstGQ9vG2mZpgvHFNtlR+LjmsRuRGGeGx9SNf6Fy9NKz
 6U2+vdzFGQy/RvCHWOEyNxwpZZOGN+Cm2W2XnWtR92igNYqI+hPpJf6UECLAYxWJc0+h
 n1S1wefSvTt0uK2PLsZB11S8kYZkyLOnIccyunefPwlteGimZjADwHAq8sjoQfWoi7W5
 sBM/hisjVnbCkc0oZk+sNleIApD3+KIfgkU8tyVe9jN6XLP2ok+d18MFpsvsiKjQM89r
 itSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733824464; x=1734429264;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jtPMskVVQTEzMbeimgYhbmsqyvBqNwgdxGb1V1slmvg=;
 b=Ekb5DAflwCvFDdAdqFsWsfQiBXNV2CnXjDW7EOMWFGuBav8phNwFp3PLk1uLM9qkyc
 wDDK11w1wOLyaSEfSNpXLNKR0VSI0n/67zrmWBpLmfMeoiLsC/eBvsoIKEgDD4v7kJx5
 6Qrj6IIjw/k5qhK39OjkhvdBRLpMhYMzic4oAAPB8bjIw0GvyP8/VNLhvETI8PHT0nza
 kEz4wAWTeh2P2ACb/kTCm02F7QqmWR/ingMEcyUONs/Ka8zIjMcruCAUc4KI1qEck8ul
 KDN+l26Cy27bWNHLmROR5HdcxykB41OXs9OBSXe4nnQHxRwkezL4yiOFvTzTpJ38QZ1e
 dC/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0HnAWNT8otmASiS3zukj1zz/w1cjLCNQK+AiFI8E7oi+2oyWsZck1qkgW2gDciuxOAa1YJMg=@lists.denx.de
X-Gm-Message-State: AOJu0Yw5yolKlJOxAm/kzKwjyN4PPPestKUqv33hjWHGgsU5I30KSRR3
 SwenvZXrKkFc9H+tLFekkCXZN9zp9C1SJPbcfxox8vmxZlvP7BhfiMNer/z8su6625YFIXfXiIz
 yIRszAmdkuq2vpsxjpLYPoonRleh/MG4AC4Y57Q==
X-Gm-Gg: ASbGnct+VXjaru79aXI/QJmJRimEXBacTzxKvtAK4sqIKL/agPuNmIAXpsNmzYeDTWy
 EifIJZkz5kJIeK1GWN3Txrxy36H8xVwnSR826
X-Google-Smtp-Source: AGHT+IFVCtF5Y+e88riYZpOtRM07axt3OJD+PPSFT4zJh3Xzmt6rFmI25QeJVRjsfbMEZKF7wqyb71uvPP41/oBxL7I=
X-Received: by 2002:a05:6402:35d1:b0:5d0:a80d:bce9 with SMTP id
 4fb4d7f45d1cf-5d3be71c114mr13559468a12.20.1733824463563; Tue, 10 Dec 2024
 01:54:23 -0800 (PST)
MIME-Version: 1.0
References: <20241208105223.2821049-1-ilias.apalodimas@linaro.org>
 <20241208105223.2821049-2-ilias.apalodimas@linaro.org>
In-Reply-To: <20241208105223.2821049-2-ilias.apalodimas@linaro.org>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 10 Dec 2024 15:24:12 +0530
Message-ID: <CADg8p97-pEi7OTWwGQiDiTOvPaF+sq96UaK0bRhgU=YyQzTvRg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] lmb: Replace lmb_reserve() with
 lmb_reserve_flags()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, trini@konsulko.com,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Korsgaard <peter@korsgaard.com>, 
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Baruch Siach <baruch@tkos.co.il>, 
 Nam Cao <namcao@linutronix.de>, Janne Grunau <j@jannau.net>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
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

On Sun, 8 Dec 2024 at 16:22, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> lmb_reserve() is just calling lmb_reserve_flags() with LMB_NONE.
> There's not much we gain from this abstraction, so let's remove the
> former and make the code a bit easier to follow.
>
> The code size increase is minimal - e.g for sandbox which includes all
> of the LMB tests
>
> add/remove: 0/1 grow/shrink: 12/0 up/down: 46/-4 (42)
> Function                                     old     new   delta
> lib_test_lmb_overlapping_reserve            1018    1030     +12
> version_string                                70      76      +6
> test_get_unreserved_size                    1032    1038      +6
> test_alloc_addr                             2933    2939      +6
> test_multi_alloc.constprop                  3034    3036      +2
> test_bigblock                                911     913      +2
> load_serial                                  946     948      +2
> lib_test_lmb_flags                          2101    2103      +2
> do_bootz                                     526     528      +2
> do_bootm_linux                              2067    2069      +2
> bootm_run_states                            5275    5277      +2
> boot_relocate_fdt                            599     601      +2
> lmb_reserve                                    4       -      -4
> Total: Before=2492742, After=2492784, chg +0.00%
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---

Fwiw, I had attempted this earlier on similar lines -- have a single
API, which would take the flag as a parameter [1], but was asked not
to take this approach as part of the review [2].

-sughosh

[1] - https://lists.denx.de/pipermail/u-boot/2024-July/559790.html
[2] - https://lists.denx.de/pipermail/u-boot/2024-August/561607.html

>  arch/powerpc/cpu/mpc85xx/mp.c |  2 +-
>  arch/powerpc/lib/misc.c       |  2 +-
>  boot/bootm.c                  |  3 ++-
>  boot/image-board.c            |  2 +-
>  boot/image-fdt.c              |  5 +++--
>  cmd/booti.c                   |  2 +-
>  cmd/bootz.c                   |  2 +-
>  cmd/load.c                    |  2 +-
>  include/lmb.h                 |  1 -
>  lib/lmb.c                     |  5 -----
>  test/lib/lmb.c                | 30 +++++++++++++++---------------
>  11 files changed, 26 insertions(+), 30 deletions(-)
>
> diff --git a/arch/powerpc/cpu/mpc85xx/mp.c b/arch/powerpc/cpu/mpc85xx/mp.c
> index bed465cb2cba..22252c1448a8 100644
> --- a/arch/powerpc/cpu/mpc85xx/mp.c
> +++ b/arch/powerpc/cpu/mpc85xx/mp.c
> @@ -412,7 +412,7 @@ void cpu_mp_lmb_reserve(void)
>  {
>         u32 bootpg = determine_mp_bootpg(NULL);
>
> -       lmb_reserve(bootpg, 4096);
> +       lmb_reserve_flags(bootpg, 4096, LMB_NONE);
>  }
>
>  void setup_mp(void)
> diff --git a/arch/powerpc/lib/misc.c b/arch/powerpc/lib/misc.c
> index 4cd23b3406d1..c08d4b35118b 100644
> --- a/arch/powerpc/lib/misc.c
> +++ b/arch/powerpc/lib/misc.c
> @@ -40,7 +40,7 @@ int arch_misc_init(void)
>
>                         printf("WARNING: adjusting available memory from 0x%lx to 0x%llx\n",
>                                size, (unsigned long long)bootm_size);
> -                       lmb_reserve(base, bootm_size - size);
> +                       lmb_reserve_flags(base, bootm_size - size, LMB_NONE);
>                 }
>
>  #ifdef CONFIG_MP
> diff --git a/boot/bootm.c b/boot/bootm.c
> index 16a43d519a8a..c8662442e403 100644
> --- a/boot/bootm.c
> +++ b/boot/bootm.c
> @@ -696,7 +696,8 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
>         }
>
>         if (CONFIG_IS_ENABLED(LMB))
> -               lmb_reserve(images->os.load, (load_end - images->os.load));
> +               lmb_reserve_flags(images->os.load, (load_end - images->os.load),
> +                                 LMB_NONE);
>
>         return 0;
>  }
> diff --git a/boot/image-board.c b/boot/image-board.c
> index b726bd6b3035..c4d914fd6074 100644
> --- a/boot/image-board.c
> +++ b/boot/image-board.c
> @@ -562,7 +562,7 @@ int boot_ramdisk_high(ulong rd_data, ulong rd_len, ulong *initrd_start,
>                         debug("   in-place initrd\n");
>                         *initrd_start = rd_data;
>                         *initrd_end = rd_data + rd_len;
> -                       lmb_reserve(rd_data, rd_len);
> +                       lmb_reserve_flags(rd_data, rd_len, LMB_NONE);
>                 } else {
>                         if (initrd_high)
>                                 *initrd_start = (ulong)lmb_alloc_base(rd_len,
> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> index 3d5b6f9e2dc7..fd68b8594325 100644
> --- a/boot/image-fdt.c
> +++ b/boot/image-fdt.c
> @@ -184,7 +184,8 @@ int boot_relocate_fdt(char **of_flat_tree, ulong *of_size)
>                 if (desired_addr == ~0UL) {
>                         /* All ones means use fdt in place */
>                         of_start = fdt_blob;
> -                       lmb_reserve(map_to_sysmem(of_start), of_len);
> +                       lmb_reserve_flags(map_to_sysmem(of_start), of_len,
> +                                         LMB_NONE);
>                         disable_relocation = 1;
>                 } else if (desired_addr) {
>                         addr = lmb_alloc_base(of_len, 0x1000, desired_addr);
> @@ -675,7 +676,7 @@ int image_setup_libfdt(struct bootm_headers *images, void *blob, bool lmb)
>
>         /* Create a new LMB reservation */
>         if (CONFIG_IS_ENABLED(LMB) && lmb)
> -               lmb_reserve(map_to_sysmem(blob), of_size);
> +               lmb_reserve_flags(map_to_sysmem(blob), of_size, LMB_NONE);
>
>  #if defined(CONFIG_ARCH_KEYSTONE)
>         if (IS_ENABLED(CONFIG_OF_BOARD_SETUP))
> diff --git a/cmd/booti.c b/cmd/booti.c
> index 43e79e87201b..58d355726cc5 100644
> --- a/cmd/booti.c
> +++ b/cmd/booti.c
> @@ -87,7 +87,7 @@ static int booti_start(struct bootm_info *bmi)
>         images->os.start = relocated_addr;
>         images->os.end = relocated_addr + image_size;
>
> -       lmb_reserve(images->ep, le32_to_cpu(image_size));
> +       lmb_reserve_flags(images->ep, le32_to_cpu(image_size), LMB_NONE);
>
>         /*
>          * Handle the BOOTM_STATE_FINDOTHER state ourselves as we do not
> diff --git a/cmd/bootz.c b/cmd/bootz.c
> index 787203f5bd70..ab2bf12eb8b0 100644
> --- a/cmd/bootz.c
> +++ b/cmd/bootz.c
> @@ -56,7 +56,7 @@ static int bootz_start(struct cmd_tbl *cmdtp, int flag, int argc,
>         if (ret != 0)
>                 return 1;
>
> -       lmb_reserve(images->ep, zi_end - zi_start);
> +       lmb_reserve_flags(images->ep, zi_end - zi_start, LMB_NONE);
>
>         /*
>          * Handle the BOOTM_STATE_FINDOTHER state ourselves as we do not
> diff --git a/cmd/load.c b/cmd/load.c
> index 20d802502ae6..dfbb6d2db0c9 100644
> --- a/cmd/load.c
> +++ b/cmd/load.c
> @@ -179,7 +179,7 @@ static ulong load_serial(long offset)
>                     {
>                         void *dst;
>
> -                       ret = lmb_reserve(store_addr, binlen);
> +                       ret = lmb_reserve_flags(store_addr, binlen, LMB_NONE);
>                         if (ret) {
>                                 printf("\nCannot overwrite reserved area (%08lx..%08lx)\n",
>                                         store_addr, store_addr + binlen);
> diff --git a/include/lmb.h b/include/lmb.h
> index f221f0cce8f7..62882464f866 100644
> --- a/include/lmb.h
> +++ b/include/lmb.h
> @@ -82,7 +82,6 @@ int lmb_init(void);
>  void lmb_add_memory(void);
>
>  long lmb_add(phys_addr_t base, phys_size_t size);
> -long lmb_reserve(phys_addr_t base, phys_size_t size);
>  /**
>   * lmb_reserve_flags - Reserve one region with a specific flags bitfield.
>   *
> diff --git a/lib/lmb.c b/lib/lmb.c
> index b03237bc06cb..a7ecbb58831f 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -698,11 +698,6 @@ long lmb_reserve_flags(phys_addr_t base, phys_size_t size, enum lmb_flags flags)
>         return lmb_map_update_notify(base, size, MAP_OP_RESERVE, flags);
>  }
>
> -long lmb_reserve(phys_addr_t base, phys_size_t size)
> -{
> -       return lmb_reserve_flags(base, size, LMB_NONE);
> -}
> -
>  static phys_addr_t _lmb_alloc_base(phys_size_t size, ulong align,
>                                     phys_addr_t max_addr, enum lmb_flags flags)
>  {
> diff --git a/test/lib/lmb.c b/test/lib/lmb.c
> index 0bd29e2a4fe7..8af5dcad2ecc 100644
> --- a/test/lib/lmb.c
> +++ b/test/lib/lmb.c
> @@ -117,7 +117,7 @@ static int test_multi_alloc(struct unit_test_state *uts, const phys_addr_t ram,
>         }
>
>         /* reserve 64KiB somewhere */
> -       ret = lmb_reserve(alloc_64k_addr, 0x10000);
> +       ret = lmb_reserve_flags(alloc_64k_addr, 0x10000, LMB_NONE);
>         ut_asserteq(ret, 0);
>         ASSERT_LMB(mem_lst, used_lst, 0, 0, 1, alloc_64k_addr, 0x10000,
>                    0, 0, 0, 0);
> @@ -264,7 +264,7 @@ static int test_bigblock(struct unit_test_state *uts, const phys_addr_t ram)
>         ut_asserteq(ret, 0);
>
>         /* reserve 64KiB in the middle of RAM */
> -       ret = lmb_reserve(alloc_64k_addr, 0x10000);
> +       ret = lmb_reserve_flags(alloc_64k_addr, 0x10000, LMB_NONE);
>         ut_asserteq(ret, 0);
>         ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, alloc_64k_addr, 0x10000,
>                    0, 0, 0, 0);
> @@ -466,35 +466,35 @@ static int lib_test_lmb_overlapping_reserve(struct unit_test_state *uts)
>         ret = lmb_add(ram, ram_size);
>         ut_asserteq(ret, 0);
>
> -       ret = lmb_reserve(0x40010000, 0x10000);
> +       ret = lmb_reserve_flags(0x40010000, 0x10000, LMB_NONE);
>         ut_asserteq(ret, 0);
>         ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40010000, 0x10000,
>                    0, 0, 0, 0);
>
>         /* allocate overlapping region should return the coalesced count */
> -       ret = lmb_reserve(0x40011000, 0x10000);
> +       ret = lmb_reserve_flags(0x40011000, 0x10000, LMB_NONE);
>         ut_asserteq(ret, 0);
>         ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40010000, 0x11000,
>                    0, 0, 0, 0);
>         /* allocate 3nd region */
> -       ret = lmb_reserve(0x40030000, 0x10000);
> +       ret = lmb_reserve_flags(0x40030000, 0x10000, LMB_NONE);
>         ut_asserteq(ret, 0);
>         ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, 0x40010000, 0x11000,
>                    0x40030000, 0x10000, 0, 0);
>         /* allocate 2nd region , This should coalesced all region into one */
> -       ret = lmb_reserve(0x40020000, 0x10000);
> +       ret = lmb_reserve_flags(0x40020000, 0x10000, LMB_NONE);
>         ut_assert(ret >= 0);
>         ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40010000, 0x30000,
>                    0, 0, 0, 0);
>
>         /* allocate 2nd region, which should be added as first region */
> -       ret = lmb_reserve(0x40000000, 0x8000);
> +       ret = lmb_reserve_flags(0x40000000, 0x8000, LMB_NONE);
>         ut_assert(ret >= 0);
>         ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, 0x40000000, 0x8000,
>                    0x40010000, 0x30000, 0, 0);
>
>         /* allocate 3rd region, coalesce with first and overlap with second */
> -       ret = lmb_reserve(0x40008000, 0x10000);
> +       ret = lmb_reserve_flags(0x40008000, 0x10000, LMB_NONE);
>         ut_assert(ret >= 0);
>         ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40000000, 0x40000,
>                    0, 0, 0, 0);
> @@ -550,11 +550,11 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
>         ut_asserteq(ret, 0);
>
>         /*  reserve 3 blocks */
> -       ret = lmb_reserve(alloc_addr_a, 0x10000);
> +       ret = lmb_reserve_flags(alloc_addr_a, 0x10000, LMB_NONE);
>         ut_asserteq(ret, 0);
> -       ret = lmb_reserve(alloc_addr_b, 0x10000);
> +       ret = lmb_reserve_flags(alloc_addr_b, 0x10000, LMB_NONE);
>         ut_asserteq(ret, 0);
> -       ret = lmb_reserve(alloc_addr_c, 0x10000);
> +       ret = lmb_reserve_flags(alloc_addr_c, 0x10000, LMB_NONE);
>         ut_asserteq(ret, 0);
>         ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 3, alloc_addr_a, 0x10000,
>                    alloc_addr_b, 0x10000, alloc_addr_c, 0x10000);
> @@ -680,11 +680,11 @@ static int test_get_unreserved_size(struct unit_test_state *uts,
>         ut_asserteq(ret, 0);
>
>         /*  reserve 3 blocks */
> -       ret = lmb_reserve(alloc_addr_a, 0x10000);
> +       ret = lmb_reserve_flags(alloc_addr_a, 0x10000, LMB_NONE);
>         ut_asserteq(ret, 0);
> -       ret = lmb_reserve(alloc_addr_b, 0x10000);
> +       ret = lmb_reserve_flags(alloc_addr_b, 0x10000, LMB_NONE);
>         ut_asserteq(ret, 0);
> -       ret = lmb_reserve(alloc_addr_c, 0x10000);
> +       ret = lmb_reserve_flags(alloc_addr_c, 0x10000, LMB_NONE);
>         ut_asserteq(ret, 0);
>         ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 3, alloc_addr_a, 0x10000,
>                    alloc_addr_b, 0x10000, alloc_addr_c, 0x10000);
> @@ -789,7 +789,7 @@ static int lib_test_lmb_flags(struct unit_test_state *uts)
>         ut_asserteq(lmb_is_nomap(&used[1]), 0);
>
>         /* test that old API use LMB_NONE */
> -       ret = lmb_reserve(0x40040000, 0x10000);
> +       ret = lmb_reserve_flags(0x40040000, 0x10000, LMB_NONE);
>         ut_asserteq(ret, 0);
>         ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, 0x40000000, 0x30000,
>                    0x40030000, 0x20000, 0, 0);
> --
> 2.45.2
>
