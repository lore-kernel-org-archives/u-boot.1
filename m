Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFB2E8FDD8
	for <u-boot@archiver.kernel.org>; Sat, 27 Dec 2025 13:45:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20E0183B85;
	Sat, 27 Dec 2025 14:45:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="njt06U+P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6734A83B72; Sat, 27 Dec 2025 14:45:43 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04B4183B97
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 14:45:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-34c84ec3b6eso10112022a91.3
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 05:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1766843139; x=1767447939; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ux+5DBUSw7pzwbVJmhwErlURQgXh1BBaFpbUawjDFXY=;
 b=njt06U+PoO1BjyzwK34OcUb/bOpR5cukeS6Wsn2PlENUtsvPhO9JjU0iJBw5PrkQLj
 LVqRkzAT1rTnTinKW96ZmN3foPsLN8GvJa6A5Str0pY+n49k6jJpIaf49rf9nDHCgnTB
 h1VEfQw6KeuHv86eSD2TFIdy0Qa++bQI0x2gU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766843139; x=1767447939;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ux+5DBUSw7pzwbVJmhwErlURQgXh1BBaFpbUawjDFXY=;
 b=vk7HNCLCexkv+F3FNcpFlKpQNpS2cnmf74OWEZzwGMmhnwTR8C2cWcaSv9AbzXWN95
 aP0hDY4JQRJ59Lm+BbYSP/NqXvY03IiQ0G/fL5DpsCRhqW5w7ejcHn27kHrgFDWVlJE9
 2uXnC6R9QDuRD6wJUz6DG1OAcK+c03rMe3uDubL39sYxvDbwVGcCsLba+6z8zazo7/LA
 +JqrymZ8hJn9WtyOBBXfwlVnKyD12xWMwJHngLaidY/bDkSeBo5L4mjAtp4yyv9laStL
 BLU0SmoWV/03/XIFQ4PbKqgzubptZBT8++s2XupYR9doWVUr743BRFBXy/OFxZViLm55
 UiNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZzgq8j9K5snXj7Z4LCo8XQDZZTfW4y/iAbE6wdiehxbcv578FthpMJ+ouHzc2vG8nE6PY7eg=@lists.denx.de
X-Gm-Message-State: AOJu0YyveMqXeUiA0DbyyDbC6od4H6X1aectJ5l2oyjuUmZmdBj6voQQ
 CjQTcl++5LR/6+DmInt2CeBwSTS0TVUCsjAdz8yJGRXU2uLROpV3td0cAC7KMIn1XMtTFT+mA8u
 0Ny0Bos1XgD+hpK7uhl1xtjtKq2yC0yFGYlVETmAf
X-Gm-Gg: AY/fxX6xywSG5Y9vzWXFYZj+Ldol0Fcf6L2B3uoofNGhej1JEgUN21u6/4+gjDTGUEN
 9kjTSWBG2UIpUZR3joo9MOT9vxlixCG7RpZzbWkAab9SZCZL/1/2WpE5xXus0WfZyKEbK9xVO7f
 WZ5UzmQuueDqFjSY13Xi6iIsZrkIkTWIVocQrnemVVDMAZ/Br9QsITmH2sfxrdxJAbwiw1r7LD/
 PZ0PrAlDA0LrfPu6E5/EE3sDEgGgNausohWIAU0o8acNcs0j+XoT1+14UU+xsPzQHrNLAxLOzN2
 B9ob
X-Google-Smtp-Source: AGHT+IGnzbqPa/SMhYbJV21LeBNupKFmT+dBNuo3dw+9P5k54NfTKvlGZ7m86FScXbAltJynp+WGwcOlV5uEjJBdCg0=
X-Received: by 2002:a17:90b:1e0a:b0:340:d81d:7874 with SMTP id
 98e67ed59e1d1-34e921cc253mr25982701a91.26.1766843139315; Sat, 27 Dec 2025
 05:45:39 -0800 (PST)
MIME-Version: 1.0
References: <20251221015859.738112-1-heinrich.schuchardt@canonical.com>
 <20251221015859.738112-6-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251221015859.738112-6-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 27 Dec 2025 06:45:08 -0700
X-Gm-Features: AQt7F2oKX-cN84pw15sfB_f168p1ED6kVUwDTDAKTa6wVoAFWHSsL_6idR-wyhc
Message-ID: <CAFLszTi2OMvyiMX8xZVPfhz9TG3P_nq28ycqRzAJBRcvoN2a9A@mail.gmail.com>
Subject: Re: [RFC 5/8] cmd/meminfo: display of addresses above 4 GiB
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Yao Zi <me@ziyao.cc>, 
 Raymond Mao <raymondmaoca@gmail.com>, Sean Edmond <seanedmond@microsoft.com>, 
 Heiko Schocher <hs@nabladev.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Rasmus Villemoes <ravi@prevas.dk>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
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

On Sat, 20 Dec 2025 at 18:59, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Addresses above 4 GiB don't fit into 8 digits.
> Use 13 digits which encompass up to 15 TiB.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/meminfo.c      | 8 ++++----
>  test/cmd/meminfo.c | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
>

Reviewed-by: Simon Glass <simon.glass@canonical.com>


> diff --git a/cmd/meminfo.c b/cmd/meminfo.c
> index aa3b5bafe17..b731280d106 100644
> --- a/cmd/meminfo.c
> +++ b/cmd/meminfo.c
> @@ -23,9 +23,9 @@ static void print_region(const char *name, ulong base, ulong size, ulong *uptop)
>  {
>         ulong end = base + size;
>
> -       printf("%-12s %8lx %8lx %8lx", name, base, size, end);
> +       printf("%-12s %13lx %13lx %13lx", name, base, size, end);
>         if (*uptop)
> -               printf(" %8lx", *uptop - end);
> +               printf(" %13lx", *uptop - end);
>         putc('\n');
>         *uptop = base;
>  }
> @@ -64,9 +64,9 @@ static int do_meminfo(struct cmd_tbl *cmdtp, int flag, int argc,
>
>         arch_dump_mem_attrs();
>
> -       printf("\n%-12s %8s %8s %8s %8s\n", "Region", "Base", "Size", "End",
> +       printf("\n%-12s %13s %13s %13s %13s\n", "Region", "Base", "Size", "End",
>                "Gap");
> -       printf("------------------------------------------------\n");
> +       printf("--------------------------------------------------------------------\n");
>         upto = 0;
>         if (IS_ENABLED(CONFIG_VIDEO))
>                 print_region("video", gd_video_bottom(),
> diff --git a/test/cmd/meminfo.c b/test/cmd/meminfo.c
> index 40c3520496e..9224b9589f3 100644
> --- a/test/cmd/meminfo.c
> +++ b/test/cmd/meminfo.c
> @@ -17,7 +17,7 @@ static int cmd_test_meminfo(struct unit_test_state *uts)
>         ut_assert_nextlinen("DRAM:  ");
>         ut_assert_nextline_empty();
>
> -       ut_assert_nextline("Region           Base     Size      End      Gap");
> +       ut_assert_nextline("Region                Base          Size           End           Gap");
>         ut_assert_nextlinen("-");
>
>         /* For now we don't worry about checking the values */
> --
> 2.51.0
>
