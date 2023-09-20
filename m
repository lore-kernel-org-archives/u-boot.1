Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B99CE79CC
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 11:13:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F03886A2F;
	Wed, 20 Sep 2023 13:13:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZbyexTNO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C6CF86A2F; Wed, 20 Sep 2023 13:13:47 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C9B786813
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 13:13:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-273d9b1908eso1666609a91.0
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 04:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695208423; x=1695813223; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SDyrIQ72JpT/AmeI2spj9OffQJVAWVcnjKcJy4vVE3k=;
 b=ZbyexTNOEmE1BwE8BdS6UmiQAap+pU/PyazKojeb13l9soUQJMIMOUr1iob3Q1ojQu
 TJBF5bIzWL9JY/Z2r479yHewj/ftRBamFdnHNAG4GkQNGJObAtdnsLeo00o0rJf1z2My
 4rVXYGpS7nnT0f95UGMw/RwsthczrSa9INV7iy/VmsLxiPQG2EAQTAMwKnckFlDxwk85
 8/2JZusNUmqO5NoDXTn6FCQWuQw8mDRayIc5sevjEkbsPkCfH5KsrX/C6JHGCdqbFzcq
 nmhpcFmW1zjsAGc8MIrUZAJQ/uLqSqYg1xIVqcyFyZSbIoxe/ubgKc3R+RC5tMjXKNJC
 bpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695208423; x=1695813223;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SDyrIQ72JpT/AmeI2spj9OffQJVAWVcnjKcJy4vVE3k=;
 b=BIZYKQjtXwqr0gZv3glto3DC4xHseKYfmPgQ2OADgL/nz++evCMRDUBGjRD8uR1TzR
 bJf418+uLkZiuVKrExJiRxdv5Zd2qdYGmBFqCaZrF4H6mw0DDucjnZJHtakRWqrcl+WO
 KhVQY6oADTwrg8qKsFy8SGuDdQGoMMnaKQk+mZp8WE+1nIOwvlEGybIQMpja/8xG0cZJ
 2nLU4eU327pMUX2i5bv69D8DY5eRo1OpoVD8naVeg4qQHl0a3fpyYXY8MiyN7rQBR8EJ
 5LY9Y5wtLhcv3oA+68pKliNxa1Kf4fg+Z72zxDpsfgUBwJvl30tyacbfmgeVVU3jQfdY
 U5Eg==
X-Gm-Message-State: AOJu0YwNrwdlzEoTfMaF8X6wMe65Sof/5aRiv78613uz6qUiBw0LkAbh
 14IVk0KwXiqVHJQZ11eKy477w+S8tN+nokHLzOo=
X-Google-Smtp-Source: AGHT+IGiCp5n9XjhZLlBQg6YRn2WpNCP8+ThMyvR6MJXcrytyLm11G4ztBexep+t0I+DTMA3jtI07NQJFLdnxWwTWXk=
X-Received: by 2002:a17:90a:296:b0:269:34a6:d4ca with SMTP id
 w22-20020a17090a029600b0026934a6d4camr2246274pja.0.1695208422846; Wed, 20 Sep
 2023 04:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230919134932.134678-1-rasmus.villemoes@prevas.dk>
 <20230919134932.134678-2-rasmus.villemoes@prevas.dk>
In-Reply-To: <20230919134932.134678-2-rasmus.villemoes@prevas.dk>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 20 Sep 2023 08:13:31 -0300
Message-ID: <CAOMZO5CyKMybyxTNVBq7pgwXvmoZnp3t4_iexjg_yUd+j_XdiA@mail.gmail.com>
Subject: Re: [PATCH resend 1/2] imx: spl_imx_romapi: avoid tricky use of
 spl_load_simple_fit() to get full FIT size
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, uboot-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Sep 19, 2023 at 10:49=E2=80=AFAM Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> Currently, spl_imx_romapi uses a somewhat tricky workaround for the
> fact that a FIT image with external data doesn't directly allow one to
> know the full size of the file: It does a dummy spl_load_simple_fit(),
> having the ->read callback remember the largest offset requested, and
> then does a last call to rom_api_download_image() to fetch the
> remaining part of the full FIT image.
>
> We can avoid that by just keeping track of how much we have downloaded
> already, and if the ->read() requests something outside the current
> valid buffer, fetch up to the end of the current request.
>
> The current method also suffers from not working when CONFIG_IMX_HAB
> is enabled: While in that case u-boot.itb is not built with external
> data, so the fdt header does contain the full size of the dtb
> structure. However, it does not account for the extra CONFIG_CSF_SIZE
> added by board_spl_fit_size_align(). And also, the data it hands out
> during the first dummy spl_load_simple_fit() is of course garbage, and
> wouldn't pass the verification.
>
> So we really need to call spl_load_simple_fit() only once, let that
> figure out just how big the FIT image is (including whatever data, CSF
> or "ordinary" external data, has been tacked on beyond the fdt
> structure), and always provide valid data from the ->read callback.
>
> This only affects the CONFIG_SPL_LOAD_FIT case - I don't have any
> hardware or experience with the CONFIG_SPL_LOAD_IMX_CONTAINER case, so
> I leave that alone for now.
>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

Reviewed-by: Fabio Estevam <festevam@denx.de>
