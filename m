Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A95C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 11:32:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0465987845;
	Thu, 28 Dec 2023 12:32:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vzPHev8f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52061879F0; Thu, 28 Dec 2023 12:32:06 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 473238773E
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 12:32:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2cca9a9362aso46247621fa.3
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 03:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703763123; x=1704367923; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s0ZgkYH7VzFWUORUf8rQyjVahPld5j4HlSFoRlTBFsg=;
 b=vzPHev8fxpc6CbM6ZTQ354lrj9gB60MN9JCTYl20ETdaxHUANQqNU8GsjiaPS1qDes
 vYYmpuNrU49esltbBtwHL/ss7BsZbhC2GDSC8l15Ur9EF1rwI4K7jP03hleu7kQSFg/S
 wQIoZwZAoth66DzDFRndpFiqA4rxhhjENzZhCOlGf0ySyEtBxKf3+0L0Ute2TIzpheNz
 oHwU87t3xQINdtXDNjUuBSQqh//JfVQnbq46b8tqVYMmLTrdBrqRkaLlfV9ra8Wt5xna
 LVjp8jSavrUaY0mq7UbFxfRSL95ZsXZUV4r7GlZ9Wyd7akbRSLVZcdw3iqHomgn2fd/r
 9DpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703763123; x=1704367923;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s0ZgkYH7VzFWUORUf8rQyjVahPld5j4HlSFoRlTBFsg=;
 b=eG0G811HqHRRK20CLvrCSwIbzLF6o3aftdddnm1/fHtDT4NLpUuzSBikHJDusJlvXL
 qytc3xFtCnngfBTqK10Nq0Txn0LmsD/QAIUBV7IllyP8x7qeLGFdWFnGhgRcTYTiLo1I
 bhw29oxl+20sORdf1q6UMNJjVCpI1w4MwvfJovHluQmGJ22qnP2ex21FXwRZUAnCpNVP
 LbKDJSKrmxU2QRkb/nSh7LopbElJew91lzM735IMLIQkacRkbWbSFQS60trBXoN3ZsJq
 iUP4SrpcgtvjUYixzrwNC2AxZEcTuTG3T1jdSfUwE8x6oEvqgCWe4u+xCzLU1gb/hHf5
 w6Rw==
X-Gm-Message-State: AOJu0YyWiAdGWs+xWKuFsSi2iUzl3/2c/19pIwdLY+CrosV0FeMc5imH
 IWQd4QOdquSkgy0nrv7weBG0No9f6MA80SXJ11QFRXK4ekGdlw==
X-Google-Smtp-Source: AGHT+IG8pzQTT9r6gAbDNxE8szFlAsYljFTwTR6ZgqNYeU/CFrYJ3NUSHrvDtP5M75u6cwqw2V51H5Azp27JCaERats=
X-Received: by 2002:a05:6512:110a:b0:50e:7b4d:cc86 with SMTP id
 l10-20020a056512110a00b0050e7b4dcc86mr1826844lfg.69.1703763123393; Thu, 28
 Dec 2023 03:32:03 -0800 (PST)
MIME-Version: 1.0
References: <20231227210712.712937-1-raymond.mao@linaro.org>
 <20231227210712.712937-9-raymond.mao@linaro.org>
In-Reply-To: <20231227210712.712937-9-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 28 Dec 2023 13:31:27 +0200
Message-ID: <CAC_iWjJ2GAOU93x1gHPYKXyiU0j6Tp0yHqeCtsctY3mOdz+9VA@mail.gmail.com>
Subject: Re: [PATCH v4 08/12] bloblist: Handle alignment with a void entry
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>
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

Hi Raymond,

On Wed, 27 Dec 2023 at 23:08, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> From: Simon Glass <sjg@chromium.org>
>
> Rather than setting the alignment using the header size, add an entirely
> new entry to cover the gap left by the alignment.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>  common/bloblist.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/common/bloblist.c b/common/bloblist.c
> index 705d9c6ae9..73dbbc01c0 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -142,7 +142,7 @@ static int bloblist_addrec(uint tag, int size, int align_log2,
>  {
>         struct bloblist_hdr *hdr = gd->bloblist;
>         struct bloblist_rec *rec;
> -       int data_start, new_alloced;
> +       int data_start, aligned_start, new_alloced;
>
>         if (!align_log2)
>                 align_log2 = BLOBLIST_ALIGN_LOG2;
> @@ -151,10 +151,25 @@ static int bloblist_addrec(uint tag, int size, int align_log2,
>         data_start = map_to_sysmem(hdr) + hdr->alloced + sizeof(*rec);
>
>         /* Align the address and then calculate the offset from ->alloced */
> -       data_start = ALIGN(data_start, 1U << align_log2) - map_to_sysmem(hdr);
> +       aligned_start = ALIGN(data_start, 1U << align_log2) - data_start;
> +
> +       /* If we need to create a dummy record, create it */
> +       if (aligned_start) {
> +               int void_size = aligned_start - sizeof(*rec);
> +               struct bloblist_rec *vrec;
> +               int ret;
> +
> +               ret = bloblist_addrec(BLOBLISTT_VOID, void_size, 0, &vrec);

I just noticed the 'BLOBLISTT'. Is that on purpose? or a typo?

> +               if (ret)
> +                       return log_msg_ret("void", ret);
> +
> +               /* start the record after that */
> +               data_start = map_to_sysmem(hdr) + hdr->alloced + sizeof(*vrec);
> +       }
>
>         /* Calculate the new allocated total */
> -       new_alloced = data_start + ALIGN(size, 1U << align_log2);
> +       new_alloced = data_start - map_to_sysmem(hdr) +
> +               ALIGN(size, 1U << align_log2);

So, wouldn't it make more sense to add the dummy record and align the
whole thing *after* we've added the entry?
Doing it like this might leave the last entry on an unaligned boundary, no?

Thanks
/Ilias
>
>         if (new_alloced > hdr->size) {
>                 log_err("Failed to allocate %x bytes size=%x, need size=%x\n",
> @@ -164,7 +179,7 @@ static int bloblist_addrec(uint tag, int size, int align_log2,
>         rec = (void *)hdr + hdr->alloced;
>
>         rec->tag = tag;
> -       rec->hdr_size = data_start - hdr->alloced;
> +       rec->hdr_size = sizeof(struct bloblist_rec);
>         rec->size = size;
>
>         /* Zero the record data */
> --
> 2.25.1
>
