Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C7EC001B0
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 22:47:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB57786FA8;
	Thu,  2 Nov 2023 23:46:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TD45z+wj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F05F887467; Thu,  2 Nov 2023 23:46:41 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6E4287713
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 23:46:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-d9beb863816so1515604276.1
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 15:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698965195; x=1699569995; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=smHZlRvWEqbfImUmuKEa7bl5eK9Gwhlrj5CValZEpcQ=;
 b=TD45z+wjfdgIyOBs9qjyPRy01M8Hjg900ss6muF23ENddir+IwfNjS3T2+10vISEwf
 zBXIVTf79lMygCgRFlQyx7KH3nrqQNStuwQ5eUwYQak3Mc3NFeRYXejPxmaiiRoYPmCv
 FFHN4bnxotNQrLDjwOD5qEahpTUEPsdV5ICOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698965195; x=1699569995;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=smHZlRvWEqbfImUmuKEa7bl5eK9Gwhlrj5CValZEpcQ=;
 b=C/UFnH8Nxcow9f+jd6UcWKkliqZ+uGDjaHf8tqPwN/GXEAFf8Skb4yezeM2mm43UOW
 EdqkHZwE8NK3guQATyFE6u6kDijoC9VYGG6Qq2XZV9YyVZZ+irCtmxxCpdSBFRf0qQBp
 v7YZhChyaAvj0SGQ3uqSXCnPGu3RVO0BFmOi0oxap63duk7wzP3RRdkCtF5bgLT+dmX0
 2JKRwTZKnHxcbNbMH2o62iXFEJTXLNo8W+qzwwZP2/DuaHwKpyzTw7RExJIp8603dRCW
 YRDeKOxHZwHTE/R/ncO0/6/kCBKWfcYK3PlALqqNC9sIPgPLztwRw2yNunwA2Rv3MvK9
 oiqQ==
X-Gm-Message-State: AOJu0YwyCFhmvJqkZ1zigeBWWNzDzF6hWYUhM9FgHqS9+K4lU/rmnnga
 EoALvPY6PL9lIVBkNuSzrWqzXcCNE6RWHwydBcsh1Q==
X-Google-Smtp-Source: AGHT+IGWJnZFmeNupXn+3L47RogUEj8qp1FWouG6PyvBCuVmBx+ktpDSqIx6vaay1ECglNIEUG+17LlQnxStKAnN7kM=
X-Received: by 2002:a25:2f8e:0:b0:da0:47d8:4659 with SMTP id
 v136-20020a252f8e000000b00da047d84659mr16382052ybv.52.1698965195207; Thu, 02
 Nov 2023 15:46:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231031131208.435268-1-devarsht@ti.com>
 <20231031131208.435268-4-devarsht@ti.com>
In-Reply-To: <20231031131208.435268-4-devarsht@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Nov 2023 22:46:07 +0000
Message-ID: <CAPnjgZ2n8u6pYNoQ5n1qqQpZkDs-uM4-FMHbT4Pq6aZtt+ixjg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] common/board_f: Catch bloblist before starting
 resevations
To: Devarsh Thakkar <devarsht@ti.com>
Cc: u-boot@lists.denx.de, agust@denx.de, trini@konsulko.com, 
 bmeng.cn@gmail.com, msuchanek@suse.de, rasmus.villemoes@prevas.dk, 
 yangshiji66@outlook.com, praneeth@ti.com, nm@ti.com, vigneshr@ti.com, 
 a-bhatia1@ti.com, j-luthra@ti.com, nsekhar@ti.com, n-jain1@ti.com
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

Hi Devarsh,

On Tue, 31 Oct 2023 at 13:12, Devarsh Thakkar <devarsht@ti.com> wrote:
>
> Start reservations needed for init sequence only after catching
> bloblists from previous stage.
>
> This is to avoid catching bloblists in the middle causing
> gaps while u-boot is reserving.
>
> Adjust the relocaddr as per video hand-off information
> received from previous stage so that further reservations
> start only after regions reserved for previous stages
>
> Skip reservation for video memory if it was already
> filled by a bloblist.
>
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
> V2: Fix typo in commit title and checkpatch warnings/checks
> ---
>  common/board_f.c | 33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/common/board_f.c b/common/board_f.c
> index d4d7d01f8f..acf802c9cb 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -403,7 +403,7 @@ __weak int arch_reserve_mmu(void)
>         return 0;
>  }
>
> -static int reserve_video(void)
> +static int reserve_video_from_videoblob(void)
>  {
>         if (IS_ENABLED(CONFIG_SPL_VIDEO_HANDOFF) && spl_phase() > PHASE_SPL) {
>                 struct video_handoff *ho;
> @@ -412,8 +412,34 @@ static int reserve_video(void)
>                 if (!ho)
>                         return log_msg_ret("blf", -ENOENT);
>                 video_reserve_from_bloblist(ho);
> -               gd->relocaddr = ho->fb;
> -       } else if (CONFIG_IS_ENABLED(VIDEO)) {
> +
> +               /* Sanity check fb from blob is before current relocaddr */
> +               if (likely(gd->relocaddr > (unsigned long)ho->fb))
> +                       gd->relocaddr = ho->fb;
> +       }
> +
> +       return 0;
> +}
> +
> +/*
> + * Check if any bloblist received specifying reserved areas from previous stage and adjust
> + * gd->relocaddr accordingly, so that we start reserving after pre-reserved areas
> + * from previous stage.
> + *
> + * NOTE:
> + * IT is recommended that all bloblists from previous stage are reserved from ram_top
> + * as next stage will simply start reserving further regions after them.
> + */
> +static int setup_relocaddr_from_bloblist(void)
> +{
> +       reserve_video_from_videoblob();
> +
> +       return 0;
> +}
> +
> +static int reserve_video(void)
> +{
> +       if (CONFIG_IS_ENABLED(VIDEO)) {
>                 ulong addr;
>                 int ret;
>
> @@ -923,6 +949,7 @@ static const init_fnc_t init_sequence_f[] = {
>         reserve_pram,
>  #endif
>         reserve_round_4k,
> +       setup_relocaddr_from_bloblist,
>         arch_reserve_mmu,
>         reserve_video,

But you have renamed this function, so how does this commit build?

buildman -b <branch> --board sandbox_spl

might help?

>         reserve_trace,
> --
> 2.34.1
>

Regards,
Simon
