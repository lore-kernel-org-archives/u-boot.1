Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC028C46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 09:58:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59A00875BF;
	Wed, 27 Dec 2023 10:58:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DtqriZmy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FE858764D; Wed, 27 Dec 2023 10:58:56 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F9668744F
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 10:58:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-50e7d6565b5so1636907e87.0
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 01:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703671133; x=1704275933; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ekoSlIiuT+rVmXK33BktGQl1z4l+bv82+vsA7jRtWfc=;
 b=DtqriZmyXQY5BuRqL5jldpaVP3FhSfwc3J6jmmkkgEBqUD3DC1bcgTuKtve4CBusC1
 2FtkDV17uVUb8Zu5mwcDYsDBgEPJ8BF6SKjGiGdLDYhrqzriULWm9CTUcozyQKn3Bajz
 FOarveDiJaZpow04KAUCblC2btZbbL9JDaTgZ8iwIE8RiktfgXsVsRuvh1KsnKUng/Kz
 SZ5H/XGiNeIG78EMnmr/P2LdHcndt4kHHhYH0cvJVjWXmskw8o8vebmUevALQgDQVhWr
 K15K7pnxKSd48hkWLd1M81DthxMoPhp80bAPlnJ85iZXmhZvghxzYRTIRmDcSH05Mijf
 IfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703671133; x=1704275933;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ekoSlIiuT+rVmXK33BktGQl1z4l+bv82+vsA7jRtWfc=;
 b=DZkOCNwhmjMxJ8pBQuyxr3IG2w3UPfAMJx/qheSepbgFyMaU7C4gN6jj7BAmpJZVBJ
 eUu8VWPLzSFp/RJyFLWM0BUpwWtRDzoMg6QQBQ3Bt5/5jc6JNPyc1F3MeUcoCYeVeb4X
 kPaebD1an7gvPfDp/6I5RX/NltZRx4ft9XH91GChkhG8OdY/zN6D59d7iGTQrV6C8zR7
 SES5PLRMPPje5ZzOSA3GuL6Q71EUd6eBJ0d9AkYh4XL2amnmdmMhc8ZuGzvQ8L81gCy+
 oWZ5LSY3xoXm/73K9t8qBl2Zts/ZS3kpQ2b2GZ4OnIgF1y+wjdJ/AH10DM6Kn3+90HX+
 0T8g==
X-Gm-Message-State: AOJu0YzyuNIgVgzkrjVEZpgBpZDKgH/EkePi8nw/5OnQ0OhgRhvVafX4
 XHBQHqO3aO5yrTjI2ggUXZvEBPi6cobDBHLdcdkBhRxym/GVvA==
X-Google-Smtp-Source: AGHT+IF/9/m41nH29q7KAwpzemNw640FaP2w6aVJisSIAkjCxTlGMspnh3flm/FV/Td6nieJl+16dMeSwrzhNma5rDU=
X-Received: by 2002:ac2:5b9b:0:b0:50e:71d4:c76d with SMTP id
 o27-20020ac25b9b000000b0050e71d4c76dmr2329919lfn.109.1703671133438; Wed, 27
 Dec 2023 01:58:53 -0800 (PST)
MIME-Version: 1.0
References: <20231218181901.337515-1-raymond.mao@linaro.org>
 <20231218181901.337515-10-raymond.mao@linaro.org>
In-Reply-To: <20231218181901.337515-10-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 27 Dec 2023 11:58:17 +0200
Message-ID: <CAC_iWj+a=kTUm5Kp+tgtea6tG1XgkDC+V2JeZ3zjqTS-9T6-uw@mail.gmail.com>
Subject: Re: [PATCH v3 09/14] bloblist: Handle alignment with a void entry
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

On Mon, 18 Dec 2023 at 20:20, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> From: Simon Glass <sjg@chromium.org>
>
> Rather than setting the alignment using the header size, add an entirely
> new entry to cover the gap left by the alignment.

Hmm, why? Does it make out life easier somehow if new entries get added?


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
