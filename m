Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA7DC47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 08:37:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A5408796E;
	Wed, 17 Jan 2024 09:37:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XFClNUpG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CA9B87985; Wed, 17 Jan 2024 09:37:29 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20A348796E
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 09:37:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2ccae380df2so118446151fa.1
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 00:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705480646; x=1706085446; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t6PzjYH8vOi3ShjI+PQTnn7ErhGc2il7/zcvAVqJYsk=;
 b=XFClNUpGemvJl5nsW8Hj4EQPCqWVSjkZg8jZKbtmoAmRuMnWswJl0MHAwe7nHYxk2d
 VBFJ6n2u4EUvWeXXOKcY8yKip6+Ukp3HEC/S2IR0Quk/nTjusxJWirTpjNxwbwyUWRd0
 PeGfO4FNdTSRTcgAs+Xy5LNQ8NgsHsiJqoL6TqViHOyqFJl5u73LW8PXSqQCqcStPnkd
 ZB1uxeQpl/i/hAwygM4FVRDsxNvCNl2k+b533HfqwTdmZHWaVQJ8ApUg0YJQlt6QXL5K
 xIkiAYhovZTqFoTvYInVtGi9R7I/i9ROSERvGBcgO2danMD8eMfLHfJYssWaF/tsqrW1
 j7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705480646; x=1706085446;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t6PzjYH8vOi3ShjI+PQTnn7ErhGc2il7/zcvAVqJYsk=;
 b=dB38g9Ww2tDHy1QNvPN7AgovEi4pBQ9uObLs38lrvOaH2/HjZDbvJXtKiDA89oTPk9
 1cPPJWKSu1msWLkgIPKMME8QVoFNaWxH5Wdva1BWQOMwl70OlzJQ5C87EAJOpKHTRQDZ
 M44MtxrC2t7uYvnv9e1jWRDPZn6A9novu6jLXQYhSpnyhBR8FzsK6Cauy34NoglazF2w
 +M1DFZg38D2CDLn4e86CpBPCaZe0mJICCIi5kuEIuKCG7zEa9WG4xRNaX32wBZ6dqWD6
 zh+cX4wDTF/C+GE3rx3Bl4OM24HOEnGulqIDfJACx5VGj2BLe4mQupVx2fPiOTcs/baE
 YUXw==
X-Gm-Message-State: AOJu0YxNvuZpgt6mVv4oZfXaHETgaRY8SjoWVQLqcW1m9ntZJFyq8MTJ
 GGD3Q0eNbxFoJtXef8713lH6eWuCCcouHNqNmkUYT5NeAgbwww==
X-Google-Smtp-Source: AGHT+IGrOe6I4UJjT+3mK87AOvpPfis8yUgv9H4nQDfCztl2tMDc9kPXdjOD+FtVbm62xVSIYUHfZXDc4bAq0Y+J6Jc=
X-Received: by 2002:a19:f501:0:b0:50e:3e3a:3d6a with SMTP id
 j1-20020a19f501000000b0050e3e3a3d6amr3057117lfb.108.1705480646359; Wed, 17
 Jan 2024 00:37:26 -0800 (PST)
MIME-Version: 1.0
References: <20240116171356.376801-1-raymond.mao@linaro.org>
 <20240116171356.376801-4-raymond.mao@linaro.org>
In-Reply-To: <20240116171356.376801-4-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 17 Jan 2024 10:36:50 +0200
Message-ID: <CAC_iWjKi8TpyFOHQCNM3G6v59TRteYVDKf+8d+iLMru+WoK-gg@mail.gmail.com>
Subject: Re: [PATCH v6 3/7] bloblist: refactor of bloblist_reloc()
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Fabio Estevam <festevam@denx.de>,
 Bin Meng <bmeng@tinylab.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, 
 Andre Przywara <andre.przywara@arm.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Yang Xiwen <forbidden405@outlook.com>,
 =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>, 
 Peng Fan <peng.fan@nxp.com>, Kevin Chen <kevin_chen@aspeedtech.com>, 
 Sean Anderson <seanga2@gmail.com>, Nikhil M Jain <n-jain1@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Shiji Yang <yangshiji66@outlook.com>
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

On Tue, 16 Jan 2024 at 19:14, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> The current bloblist pointer and size can be retrieved from global
> data, so we don't need to pass them from the function arguments.
> This change also help to remove all external access of gd->bloblist
> outside of bloblist module.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - New patch file created for v2.
> Changes in v3
> - Check the space size before copying the bloblist.
> - Add return code of bloblist_reloc().
> Changes in v4
> - return error code from bloblist_reloc().
>
>  common/bloblist.c  | 10 ++++++++--
>  common/board_f.c   |  9 +++------
>  include/bloblist.h |  8 ++++----
>  test/bloblist.c    |  6 ++----
>  4 files changed, 17 insertions(+), 16 deletions(-)
>
> diff --git a/common/bloblist.c b/common/bloblist.c
> index 26b0ba33b1..c2fd07575f 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -472,13 +472,19 @@ void bloblist_show_list(void)
>         }
>  }
>
> -void bloblist_reloc(void *to, uint to_size, void *from, uint from_size)
> +int bloblist_reloc(void *to, uint to_size)
>  {
>         struct bloblist_hdr *hdr;
>
> -       memcpy(to, from, from_size);
> +       if (to_size < gd->bloblist->total_size)
> +               return -ENOSPC;
> +
> +       memcpy(to, gd->bloblist, gd->bloblist->total_size);
>         hdr = to;
>         hdr->total_size = to_size;
> +       gd->bloblist = to;
> +
> +       return 0;
>  }
>
>  int bloblist_init(void)
> diff --git a/common/board_f.c b/common/board_f.c
> index d4d7d01f8f..f4145a2698 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -676,13 +676,10 @@ static int reloc_bloblist(void)
>                 return 0;
>         }
>         if (gd->new_bloblist) {
> -               int size = CONFIG_BLOBLIST_SIZE;
> -
>                 debug("Copying bloblist from %p to %p, size %x\n",
> -                     gd->bloblist, gd->new_bloblist, size);
> -               bloblist_reloc(gd->new_bloblist, CONFIG_BLOBLIST_SIZE_RELOC,
> -                              gd->bloblist, size);
> -               gd->bloblist = gd->new_bloblist;
> +                     gd->bloblist, gd->new_bloblist, gd->bloblist->total_size);
> +               return bloblist_reloc(gd->new_bloblist,
> +                                     CONFIG_BLOBLIST_SIZE_RELOC);
>         }
>  #endif
>
> diff --git a/include/bloblist.h b/include/bloblist.h
> index cc78259e5a..0ae079d62a 100644
> --- a/include/bloblist.h
> +++ b/include/bloblist.h
> @@ -426,11 +426,11 @@ const char *bloblist_tag_name(enum bloblist_tag_t tag);
>   * bloblist_reloc() - Relocate the bloblist and optionally resize it
>   *
>   * @to: Pointer to new bloblist location (must not overlap old location)
> - * @to_size: New size for bloblist (must be larger than from_size)
> - * @from: Pointer to bloblist to relocate
> - * @from_size: Size of bloblist to relocate
> + * @to_size: New size for bloblist
> + * Return: 0 if OK, -ENOSPC if the new size is small than the bloblist total
> + *        size.
>   */
> -void bloblist_reloc(void *to, uint to_size, void *from, uint from_size);
> +int bloblist_reloc(void *to, uint to_size);
>
>  /**
>   * bloblist_init() - Init the bloblist system with a single bloblist
> diff --git a/test/bloblist.c b/test/bloblist.c
> index 7dab9addf8..1c60bbac36 100644
> --- a/test/bloblist.c
> +++ b/test/bloblist.c
> @@ -376,13 +376,12 @@ static int bloblist_test_reloc(struct unit_test_state *uts)
>  {
>         const uint large_size = TEST_BLOBLIST_SIZE;
>         const uint small_size = 0x20;
> -       void *old_ptr, *new_ptr;
> +       void *new_ptr;
>         void *blob1, *blob2;
>         ulong new_addr;
>         ulong new_size;
>
>         ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
> -       old_ptr = map_sysmem(TEST_ADDR, TEST_BLOBLIST_SIZE);
>
>         /* Add one blob and then one that won't fit */
>         blob1 = bloblist_add(TEST_TAG, small_size, 0);
> @@ -394,8 +393,7 @@ static int bloblist_test_reloc(struct unit_test_state *uts)
>         new_addr = TEST_ADDR + TEST_BLOBLIST_SIZE;
>         new_size = TEST_BLOBLIST_SIZE + 0x100;
>         new_ptr = map_sysmem(new_addr, TEST_BLOBLIST_SIZE);
> -       bloblist_reloc(new_ptr, new_size, old_ptr, TEST_BLOBLIST_SIZE);
> -       gd->bloblist = new_ptr;
> +       ut_assertok(bloblist_reloc(new_ptr, new_size));
>
>         /* Check the old blob is there and that we can now add the bigger one */
>         ut_assertnonnull(bloblist_find(TEST_TAG, small_size));
> --
> 2.25.1
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
