Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA2AE7E350
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 09:03:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D06A283DC9;
	Fri,  3 Apr 2026 11:03:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D3Anl/c0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8907B8407E; Fri,  3 Apr 2026 11:03:25 +0200 (CEST)
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com
 [IPv6:2607:f8b0:4864:20::b12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F39A883CF5
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 11:03:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-6501547d7edso1782982d50.0
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 02:03:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775207000; cv=none;
 d=google.com; s=arc-20240605;
 b=LMP7bw/s5vLdqX1fin60KJZZnCNIFusutT5ucQKmWjRMmHVmRiKd/8lOG2lBlkBuKV
 8IpY9AzrDkUKbEJNkmLgb7G+vP+Ydp5re3/93LIN4AkCAk4C9LF9EizS9Pv+DSUtKmdV
 5l+trLiXnDj326L1wsopsm+xui73kzCOJ3valuaz0zHiKEBehdMPzggeylX1UGW4JekD
 fKgO9quQbbripYpD7jNH+jn5b8AroKcwLfUF5Op8+xq6RWs8Jag4xrPggYyheMLdDkUp
 rYxIY4DS0wE20KhAIYo/WPau739LlGEMxrkMTaT2a4gzCBdy2yiSauzMyPCmLGbvtZog
 Gtzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZmXXALt5GcQarR3lgBFtc3IcLrvMUOhFQ8x8/Zdbbjo=;
 fh=2FnlINDwuG2VCkTsijaydDxRzAX+RK6dGevoDCucQV0=;
 b=YUGo8VDr1fhtuILcb/KnQHScfJAvKHgPMkCG5GR+Ywqs68dXV6oj2j4IqjMwqOQPh1
 Xdsa7uHF3XV71VljxEF5ZSFCcHOmM0xU7sy/ZUwMc/1k2uvAcJZKu85RgRAP9YuNuEi1
 nr5K3HaPCKoUukgD5gejPzmZzx+NG5SRoZtz0MP16LmUHZJn8maLuFZ+XFnH6MIcFPGO
 mg0wP5Ad4WT2DsBZ58papcUEV5V7TJEHtYk1p7GwdXk9T2yhT7t9OpfBw2VwmjvLg7xh
 wQh4LsPxOj4sYbOKfBLcSFfbglXc6zKX5bFTnDwlDnh2d+neZQkbTpdBtvxVbuRRxGUA
 aRlQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775207000; x=1775811800; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZmXXALt5GcQarR3lgBFtc3IcLrvMUOhFQ8x8/Zdbbjo=;
 b=D3Anl/c0+ZyCzvfyj18seYicU1QSehcF30Jbvcia+E2No1sgimFcMOuPM6v7sZs3Y0
 65gZZNA/scwtNVbz6M35J5p9pggckKpxbwPx9pwfyMHJzRo24E09zPTmlH9RS+RqEh/Q
 gPNtz8IJM2PUb41MCeluLUD9eiraCThkNv8LePp3Ekq8vMihyNphlJ7LXobFHNJLtxE5
 v6luwBZj50vo9ICGGeGnKgFISmuX+2ES4r/Fatj3uCdcIkGm2To0T00W3Xu1zqgglpyp
 2SQhgvhE6YzeJB+Bs9GCIhImSbjEgTTFnrR+ZRxgXMYYol6J+iqLJVyFCwASCyn6mYE5
 HmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775207000; x=1775811800;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZmXXALt5GcQarR3lgBFtc3IcLrvMUOhFQ8x8/Zdbbjo=;
 b=hhkpBz/yU4sfnUJznwwwH5s7k2QXjNOS0ko4Mff07GtAfyI/H8tOrQ/cizu1PgEW4h
 k4JbQksmJqKavCUlwhxXk4A3x23nqYRHfDM0YNmhuO/wqR5iPawlLMklen2Iw58LNg2m
 +58J7GeLKTDG3uv9yiE1EH1HrgRWjAhwA9uCADNKZqBx3tQT9x3tX1W/n1fhij27nbsk
 wfNBrYGHW/Gmcx8wyXq7NxCBanbDER85JQR70T78s8MZ54cvgngZCDRHiqjpd1CJq7ER
 nK7/CJCzLq/8yTCuPMLWwh0JcoyOLDLxCVN5T/QIXJ/EYtPa5rpdgQsf74ek8rNfY4qx
 c0zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1i80nvtw5lNqQ5tIXutQMjVZDdE+Zn4wuysPNGA15g+VSIb0T2M7DFTOXZ5EWt13VRkFQ7ek=@lists.denx.de
X-Gm-Message-State: AOJu0YxCmI9FhlezZojTmMcCu4egHZ/XQz/aX9QWNtFWG683zK45zqEJ
 8cOL/3TtEYqciwJxoFPD7Bjm10SoWrJwU2/eVGTd14JdmEJf63d0Q3sZjThzFdlqRfv7g1QHPqk
 dDhaCOIDAEoQVyFm5m6uqKm9djI7BC2hl2PB/eKRSBw==
X-Gm-Gg: AeBDieuWZJ65Rl2XOZ9l2MRQ+ZBgTG5djk+QLMBkQk3nd8ffh0c33rQLZukfrShCQWF
 szpv0cFsdLf1tX/ITARJ73CMpT0fwMsZeZUquzdgnn/rgRg/kC51AV32rV8OeF7jaj0+H176ydo
 O3rDV/7JXyuA5frmm7V5sQZohhgvvMlb0ffJLSarM8S2/sjZcvbQ6pA4Nma0qgwrqFGOixY1tG5
 J64lvo3BAwaq8eNyI/qYIoRocOKOyCKSQUn4ET6sVZMUAntkBqQ+iq7maUlKh0mtbx6zZ5ly7lI
 5uEpgofS/rI0DbSKs/GJ37OZOkZ5nhJ33W4381O4Go55IW0PzLLcRbBKWjKi6APZzGQqU6D31Bm
 tvm9RQ9RpxfoqYe2UjkwD8Of3w/SsO0GQaXoVdQPw/OflHJWMcB+EiustuSaSXagWNNJr3l/MmW
 oEnBctwLQBHzAhRyefPZ0a+yVg1dahH1hz4oblRa9di29xSx0lbtbrjEJwPtqMrDe6S5vLzIwlO
 Y17qF70NILgZ5u/H1HvK4Oovwj66v/OVCjNPR+w9JurMrigflvJs6Dn4o3DGujqN29nDa35C4g3
 aNPxiq1fGXltBO2J0gi3d9OFUA5ed0EiRGGrXK5rsRLU
X-Received: by 2002:a05:690e:d41:b0:64f:fd62:d890 with SMTP id
 956f58d0204a3-6504870ea53mr1764136d50.16.1775206999717; Fri, 03 Apr 2026
 02:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260403090109.3564638-1-ilias.apalodimas@linaro.org>
 <20260403090109.3564638-5-ilias.apalodimas@linaro.org>
In-Reply-To: <20260403090109.3564638-5-ilias.apalodimas@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 3 Apr 2026 12:02:43 +0300
X-Gm-Features: AQROBzDZNNt3QHWkA44W6e3Msun2bGK3TiZVZ3A_U-4i09VSa-tAaw2_a96RwNo
Message-ID: <CAC_iWj+tZKs9hCha1GQvKnqq6-6S_oWWZipjWfG1NBTUOMXs1w@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] common: Add an optionto relocate on ram top
To: trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com, 
 sjg@chromium.org, u-boot@lists.denx.de
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

On Fri, 3 Apr 2026 at 12:01, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Right now we only relocate u-boot to the top of the first
> memory bank unless the board specific code overwrites it.
> This is problematic when loading big binaries as it
> fragments the contiguous memory space for no apparent reason.
>
> It's worth noting that there are cases where we must not relocate
> above the 4GiB boundary (64bit hardware with 32bit only capable
> DMA). E.g This will break platforms, if the ethernet
> controller cannot DMA above 4 GiB, and once U-Boot does
> get relocated above 4 GiB, the packet buffer which is built
> into the U-Boot binary is also relocated above 4 GiB.
>
> A previous patch moves the bi_dram[] info from bd to gd and make
> the memory bank information available early. So move the
> dram_init_banksize() INITCALL before the relocation address calculation
> and use it to derive the address.
>
> Also add a Kconfig option and allow the common code to relocate U-Boot
> to the top of the last discovered bank.
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  Kconfig          |  8 ++++++++
>  common/board_f.c | 17 ++++++++++++++++-
>  2 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/Kconfig b/Kconfig
> index ce25ea24a60f..b25e7f25591d 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -474,6 +474,14 @@ config SKIP_RELOCATE
>           Skips relocation of U-Boot allowing for systems that have extremely
>           limited RAM to run U-Boot.
>
> +config RELOC_ADDR_TOP
> +       bool "Relocate to the topmost memory address"
> +       help
> +         When U-Boot relocates, it chooses the end of the first memory bank.
> +         Enable this if you have multiple banks and want U-Boot to relocate
> +         to the topmost memory address. This will use the information of the
> +         board memory banks configured with dram_init_banksize().
> +
>  endif # EXPERT
>
>  config PHYS_64BIT
> diff --git a/common/board_f.c b/common/board_f.c
> index dd5518b60db4..2eab344037c8 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -339,6 +339,10 @@ static int setup_ram_base(void)
>
>  static int setup_ram_config(void)
>  {
> +#if CONFIG_IS_ENABLED(RELOC_ADDR_TOP)
> +       int bank;
> +       phys_size_t total_size = 0;
> +#endif
>         debug("Monitor len: %08x\n", gd->mon_len);
>  #if CONFIG_VAL(SYS_MEM_TOP_HIDE)
>         /*
> @@ -353,8 +357,19 @@ static int setup_ram_config(void)
>          */
>         gd->ram_size -= CONFIG_SYS_MEM_TOP_HIDE;
>  #endif

And I just realized I forgot to amend one of my patches....

This blocks needs to move below if CONFIG_IS_ENABLED(RELOC_ADDR_TOP)
etc, but I'll fix it in V2

> +#if CONFIG_IS_ENABLED(RELOC_ADDR_TOP)
> +       for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
> +               if (gd->ram_top <= gd->bi_dram[bank].start)
> +                       gd->ram_top = gd->bi_dram[bank].start +
> +                                       gd->bi_dram[bank].size;
> +               total_size += gd->bi_dram[bank].size;
> +       }
> +
> +       gd->ram_size = total_size;
> +#else
>         gd->ram_top = gd->ram_base + get_effective_memsize();
>         gd->ram_top = board_get_usable_ram_top(gd->mon_len);
> +#endif
>
>         debug("Ram top: %08llX\n", (unsigned long long)gd->ram_top);
>         debug("Ram size: %08llX\n", (unsigned long long)gd->ram_size);
> @@ -971,6 +986,7 @@ static void initcall_run_f(void)
>          *  - board info struct
>          */
>         INITCALL(setup_ram_base);
> +       INITCALL(dram_init_banksize);
>         INITCALL(setup_ram_config);
>         INITCALL(setup_dest_addr);
>  #if CONFIG_IS_ENABLED(OF_BOARD_FIXUP) && \
> @@ -999,7 +1015,6 @@ static void initcall_run_f(void)
>         INITCALL(reserve_bloblist);
>         INITCALL(reserve_arch);
>         INITCALL(reserve_stacks);
> -       INITCALL(dram_init_banksize);
>         INITCALL(show_dram_config);
>         WATCHDOG_RESET();
>         INITCALL(setup_bdinfo);
> --
> 2.53.0
>
