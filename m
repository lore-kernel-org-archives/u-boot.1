Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1CCCE7B01
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 12:45:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1822A840CF;
	Fri, 14 Nov 2025 13:45:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jTIZ2cpM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CB3D840B0; Fri, 14 Nov 2025 13:45:42 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 128AE840DF
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 13:45:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2957850c63bso20136215ad.0
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 04:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763124337; x=1763729137; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mneKsGhR+16uisjWtcjHl/MU2mm0hqzK63J6Vi/YKnA=;
 b=jTIZ2cpMmlMhp+eYHQpycrNSIvGaXy0fKyLHvoMGq/31Li8OIiriWNSYQqDgxrDW2W
 FzgJszqBpL4u827AJPOZbSi/4OSfMBLwUoM/bCoE5tIB16IffXuN/Oq1NJTc076CJZUj
 8BCoZ1ksYn1bEyJTW41ijHVUoeooQr16zXLuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763124337; x=1763729137;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mneKsGhR+16uisjWtcjHl/MU2mm0hqzK63J6Vi/YKnA=;
 b=E2yNNAwoGcsS9wjx2PyTCzT7mcx6UIKt13w2E6O6mWuoY0B64pUqEDhIco+LKsrfIh
 LqH6qz0PCSQEBjNwhmTS/czkPJPNTcpaKYll9x3W/zNSt+6SA+BPRGicG4cXJmCbmaJT
 2mQsRsapiRwnfDDDgTM+3vDqeR/P0QkYWzFgxPNd0G4zw65QLxlg85UMuc2Hx2Fikggm
 YfZWlTFfGNWpVaPgvWaBrV8jmFIHD9lsh/F1WdMLvXDrdqRFZBsiM5ZL42qarBKgeSZ5
 lAepWl56+DBrTwUf9NUwqd/0fNHgEINrOzgxyZdnVKcJIQ9+li/Elr3gSEkxNKS8oVw6
 pXrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUinbTKUcibM1c1/yMRndk7EVEaVc3zSxPVVgroUea8ZEQpoHzdEHFolM7ZvmjetwfTInRWvmQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyUA93CV7pWxDU2DWG23i5fl6LgaX7n/R/aDODubU4nJ9IDhzVs
 XoKsWULllLJgNCNPkWHva+NwAluNlJYaP4k/McxDf6kbTWiHy6J9Np8cpu4qnnWSaAan2JgmCTV
 8abLM6oVgLTxCDXclNWiEL/xa6ZCfSQpEUkxWT66dafxlOzc0j2Q=
X-Gm-Gg: ASbGnctfj+PTw/snNjj+UN+UVRvIEzWhHmsQCXE1ItnsvxEI73hwRVZqd/0fuwu2s/w
 NnAyYRBvWRft4ZLy+lJo2pCJV9yi04ysxLGZHqEfx/5e4bGACEjxmHnXuhTwl2CVOFlQ05WFFD4
 +jE3DDE93YQWG2f7VZL0at+ufJfhX7CT3t+B7FaDUVCUSni2N8SpiHx3KhTKWWL0sYXbClB+q/s
 uKf7KDlYjtvJY7UyrsVidfLu8GXug63p9N0Sd0oHUJZdBFsHOCTHZiPbycJ6ShfqJ0XNQ==
X-Google-Smtp-Source: AGHT+IE1TLtJROLu0YV7Ota6sGD0JPc93a/zQOIOgmBlAIt59B5stGQdtgbdlJA/oV3a4dZXVARGPdTn4AKlmgIzDvI=
X-Received: by 2002:a17:902:e949:b0:297:e897:6f6d with SMTP id
 d9443c01a7336-2985a4cecb8mr76727375ad.9.1763124337469; Fri, 14 Nov 2025
 04:45:37 -0800 (PST)
MIME-Version: 1.0
References: <20251109101010.306268-1-heinrich.schuchardt@canonical.com>
 <20251109101010.306268-5-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251109101010.306268-5-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Nov 2025 05:44:52 -0700
X-Gm-Features: AWmQ_bkQ_J3GyAj2GdTdVnDOpaoGoeOqgzOC945n6gI8IhrkBqsEJrE-ggVD2X8
Message-ID: <CAFLszThE3Ntmr_P9TDBrW_y89p6+u2AwXv6Rcmhe=wcgznao_A@mail.gmail.com>
Subject: Re: [PATCH 4/9] test: cmd/bdinfo: consider arch_print_bdinfo() output
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>, 
 Harrison Mutai <harrison.mutai@arm.com>, Peng Fan <peng.fan@nxp.com>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Rick Chen <rick@andestech.com>, u-boot@lists.denx.de
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

Hi Heinrich,

On Sun, 9 Nov 2025 at 03:10, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On x86 commit 9b35dbc93fd4 ("x86: Show the timestamp counter with bdinfo")
> has added another bdinfo output line.
>
> On RISC-V commit 66b5ee9c558e ("riscv: add RISC-V fields to bdinfo
> command") implemented arch_print_bdinfo().
>
> Update the bdinfo test accordingly.
>
> Fixes: 9b35dbc93fd4 ("x86: Show the timestamp counter with bdinfo")
> Fixes: 66b5ee9c558e ("riscv: add RISC-V fields to bdinfo command")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  test/cmd/bdinfo.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
> index 214b237152b..28d448a0866 100644
> --- a/test/cmd/bdinfo.c
> +++ b/test/cmd/bdinfo.c
> @@ -215,8 +215,15 @@ static int bdinfo_test_all(struct unit_test_state *uts)
>                 ut_assertok(test_num_l(uts, "malloc base", gd_malloc_start()));
>         }
>
> +       /* Check arch_print_bdinfo() output */
>         if (IS_ENABLED(CONFIG_X86))
> -               ut_check_skip_to_linen(uts, " high end   =");
> +               ut_check_skip_to_linen(uts, "tsc");
> +
> +#ifdef CONFIG_RISCV
> +       ut_check_console_linen(uts, "boot hart");
> +       if (gd->arch.firmware_fdt_addr)
> +               ut_check_console_linen(uts, "firmware fdt");
> +#endif

How about creating an accessor so the #ifdef is in global_data.h and
you can use if (IS_ENABLED()) here?
>
>         return 0;
>  }
> --
> 2.51.0
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
SImon
