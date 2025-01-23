Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32CBAC0218B
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 14:37:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81CD5807B3;
	Thu, 23 Jan 2025 15:37:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Nefgi133";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A509480137; Thu, 23 Jan 2025 15:37:46 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9912F807B4
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 15:37:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ab2bb0822a4so199029266b.3
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 06:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737643064; x=1738247864; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yVAN5yaGsOxUcQlChYHwWrKhPwuSIM1LCJ7tu3ioN3I=;
 b=Nefgi133w7xeFqjWiWug8GKwhTvZwOH12ysRpE7DT/8B+brTmucrlzvFfDz78bxQna
 wYf0GXQolYBECDxnydCxx+E3rYpN2NZU5JRCiHrT+3sdmyIemnwq/Iji3EKQ/i8EaS5B
 gFFK/mFmo4LX1utOXw45LVzlriHPys0DZmh1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737643064; x=1738247864;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yVAN5yaGsOxUcQlChYHwWrKhPwuSIM1LCJ7tu3ioN3I=;
 b=haCRAA0WN8RHLrItfFPG3WWKoXURKeroWNg5D+uBLHIN30W/QJXVkbE25j9ws5BK07
 gjuwo01RK5Zk77pcoWeHoDNKSM7j2Ynpe4nXr7uaFKzNsLFh/Zmbjryrm02DKFrflckQ
 9/Ivi0bNMnBue1G+uI2TmozU3o7VVpZwdOnYU/PY7BUuATpSAmoffb4qhwicevYpYWak
 LfZ2NSU1+vhdQpT11Jrq27SJTomsFs6IFTRWvaZPcKg2iAmOq0reF2rLqxviN5u2iZWa
 pDmllhsKUpEBXH7cfDeCEt8fDZZ0KEWRIr97s/dr7arJ1yug6z63oburU3nm9BzEX3kJ
 okpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIf9wsVbv0sBRTPqeGIW1eJiXjDvPcw7R+0f5WgYLx6ZvQLySTuNcgighvoEmHcaS+XmjIjvs=@lists.denx.de
X-Gm-Message-State: AOJu0YxbhbgB3qrDQrGARoFj35m+oai/2EGhslg0SbgbfBE6nBGwNu4D
 YfKNfSxPZnfnsLiMDdu8V3ANzcUAOQEZEv4ehMMLzkXJzPNoVBeLXIdBewFpVb41Nfckvxkh/tl
 +L353IQXZpftcB1zXRkwjZ7/YimaioxmcNkvA
X-Gm-Gg: ASbGncuOQdLBtfaZ63yFNru0AmbecLIgXIVafZpidX6iPkKYndRF6p4pws98ixOpFpf
 Xcc8SBP6pd/m3XAykZLhmNyQYcUaD0oR5dr1NtNId6hxOZF2/J6OA9j1KcwiLVGA=
X-Google-Smtp-Source: AGHT+IGDtcpVUDkRd+Lc4v54Q+bTwMUQLDnV0rtmAhzE8wDokkTSG/Wjm9A35vdN9UroDoixQf2KwRUlscwt5F2cer4=
X-Received: by 2002:a17:907:6ea6:b0:aac:1e96:e7d2 with SMTP id
 a640c23a62f3a-ab38b3d708amr2651336266b.54.1737643063980; Thu, 23 Jan 2025
 06:37:43 -0800 (PST)
MIME-Version: 1.0
References: <20250117102734.3725009-2-caleb.connolly@linaro.org>
In-Reply-To: <20250117102734.3725009-2-caleb.connolly@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 23 Jan 2025 07:37:30 -0700
X-Gm-Features: AbW1kvbRYxUjNp0U2zrNdAkzhh_jbh9x8W9RJXN_Ao9iG7qUdcckbbsUPc1oJys
Message-ID: <CAFLszThD3VCJC_2X_Z0DYBiEgtR_AfvMx11f-tUAvEuYmDU9eg@mail.gmail.com>
Subject: Re: [PATCH] mach-snapdragon: fix board_fdt_blob_setup()
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Matthias Brugger <mbrugger@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
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

Hi Caleb,

On Fri, 17 Jan 2025 at 03:29, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> In fc37a73e6679 (fdt: Swap the signature for board_fdt_blob_setup())
> there was a subtle change to the Snapdragon implementation, removing the
> assignment to gd->fdt_blob partway through the function.
>
> This breaks qcom_parse_memory() which was also called during
> board_fdt_blob_setup().
>
> Since this was a strange (and seemingly unnecessary choice), take the
> chance to move this to the more typical dram_init() phase so that we
> don't depend on gd->fdt_blob being correct until after
> board_fdt_blob_setup() has finished.
>
> Fixes: fc37a73e6679 (fdt: Swap the signature for board_fdt_blob_setup())
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/mach-snapdragon/board.c | 67 +++++++++++++++-----------------
>  1 file changed, 31 insertions(+), 36 deletions(-)
>
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index f1319df43147..fbb3d6e588e3 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -45,17 +45,8 @@ static struct {
>         phys_addr_t start;
>         phys_size_t size;
>  } prevbl_ddr_banks[CONFIG_NR_DRAM_BANKS] __section(".data") = { 0 };
>
> -int dram_init(void)
> -{
> -       /*
> -        * gd->ram_base / ram_size have been setup already
> -        * in qcom_parse_memory().
> -        */
> -       return 0;
> -}
> -
>  static int ddr_bank_cmp(const void *v1, const void *v2)
>  {
>         const struct {
>                 phys_addr_t start;
> @@ -69,42 +60,22 @@ static int ddr_bank_cmp(const void *v1, const void *v2)
>
>         return (res1->start >> 24) - (res2->start >> 24);
>  }
>
> -/* This has to be done post-relocation since gd->bd isn't preserved */
> -static void qcom_configure_bi_dram(void)
> -{
> -       int i;
> -
> -       for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
> -               gd->bd->bi_dram[i].start = prevbl_ddr_banks[i].start;
> -               gd->bd->bi_dram[i].size = prevbl_ddr_banks[i].size;
> -       }
> -}
> -
> -int dram_init_banksize(void)
> -{
> -       qcom_configure_bi_dram();
> -
> -       return 0;
> -}
> -
>  static void qcom_parse_memory(void)
>  {
>         ofnode node;
> -       const fdt64_t *memory;
> +       const fdt64_t *memory = NULL;
>         int memsize;
>         phys_addr_t ram_end = 0;
>         int i, j, banks;
>
>         node = ofnode_path("/memory");
> -       if (!ofnode_valid(node)) {
> -               log_err("No memory node found in device tree!\n");
> -               return;
> -       }
> -       memory = ofnode_read_prop(node, "reg", &memsize);
> -       if (!memory) {
> -               log_err("No memory configuration was provided by the previous bootloader!\n");
> +       if (ofnode_valid(node))
> +               memory = ofnode_read_prop(node, "reg", &memsize);
> +
> +       if (!memory || !ofnode_valid(node)) {
> +               panic("No memory configuration was provided by the previous bootloader!\n");
>                 return;
>         }
>
>         banks = min(memsize / (2 * sizeof(u64)), (ulong)CONFIG_NR_DRAM_BANKS);
> @@ -134,8 +105,32 @@ static void qcom_parse_memory(void)
>         debug("ram_base = %#011lx, ram_size = %#011llx, ram_end = %#011llx\n",
>               gd->ram_base, gd->ram_size, ram_end);
>  }
>
> +int dram_init(void)
> +{
> +       qcom_parse_memory();
> +       return 0;
> +}
> +
> +/* This has to be done post-relocation since gd->bd isn't preserved */
> +static void qcom_configure_bi_dram(void)
> +{
> +       int i;
> +
> +       for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
> +               gd->bd->bi_dram[i].start = prevbl_ddr_banks[i].start;
> +               gd->bd->bi_dram[i].size = prevbl_ddr_banks[i].size;
> +       }
> +}
> +
> +int dram_init_banksize(void)
> +{
> +       qcom_configure_bi_dram();
> +
> +       return 0;
> +}
> +
>  static void show_psci_version(void)
>  {
>         struct arm_smccc_res res;
>
> @@ -173,9 +168,9 @@ int board_fdt_blob_setup(void **fdtp)
>                 ret = -EEXIST;
>         } else {
>                 debug("Using external FDT\n");
>                 /* So we can use it before returning */
> -               *fdtp = fdt;
> +               gd->fdt_blob = *fdtp = fdt;

Can you avoid assigning to gd->fdt_blob here? The intent is that this
is done by the caller.

>         }
>
>         /*
>          * Parse the /memory node while we're here,
> --
> 2.48.0
>

I notice this is rejected in patchwork, but I don't see any discussion
as to why?

Regards,
Simon
