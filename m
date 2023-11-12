Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFF2C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:03:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C5C687263;
	Sun, 12 Nov 2023 21:03:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MOLNMK78";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D758B86F95; Sun, 12 Nov 2023 21:03:05 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B38C48700D
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:02:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-d9a6399cf78so3072423276.0
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 12:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699819378; x=1700424178; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ejdwNTUMgbkZp7zLd8908UnXWIdedDhI2Rwg7NeGUW0=;
 b=MOLNMK786+1VAHtlOH6Jkgd467We1MY7W4cX7JRVJ0VBMpVBwRUxawUXHewyAnrDn1
 h56cYvg4Chk0VPurkjK6d2LI4FspDyzr3xZCD+V6JRbYsL6ZlGRv9AlKdcGa418MPGA3
 QRSM4X6GauRJDZUhNJ2sm+JzZK3iZJ7HNKUmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699819378; x=1700424178;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ejdwNTUMgbkZp7zLd8908UnXWIdedDhI2Rwg7NeGUW0=;
 b=suJZ/EsL3xFbThxgaGz6epQqifnTjK1DSz8MsJt6NzEicbpTfShPcvOTQaH+sAei3T
 IlPjSvOV9icy362IFJe20Bd40TvuNif/7Lbr2NFRCLJBua8FsC+HnuhXARwMk8MorPxS
 WxRM/H7SUJLNhDq86fD3ksofyHFS7ns2edMeAfF23HdTI/RiW4sqvLITByEjA+uce22H
 nqYhrc9xzMzbVuGsp14b6aOU9Lj3QXVsTyFUics5Us7Oe7DwVlaysGJQKOTwmtTrwPXi
 Lruf+BC/EbxvMxOZiDz8ING0J/wkTpU2Jy1/QYDMd3xmiAzw11THDcM7Lh5qQonuC1/s
 L4uQ==
X-Gm-Message-State: AOJu0YwwwHykpg4KrvjCa/NE0ojNH88SsxlCYLh4kR7RtWL46CQCw0q+
 T49ozn/Px57d26+N/xG/kiyasUSiSsM+0ZBohTiu/A==
X-Google-Smtp-Source: AGHT+IG1Vj883CEqobVAJx28Cqf3znOWGDspI+TUlMGIW2rvr75YvhUhvU0+XORTmmUZvbq2IBLsrD4+HfmbclUx0s0=
X-Received: by 2002:a25:24e:0:b0:da0:a8a7:d351 with SMTP id
 75-20020a25024e000000b00da0a8a7d351mr4955491ybc.9.1699819378194; Sun, 12 Nov
 2023 12:02:58 -0800 (PST)
MIME-Version: 1.0
References: <20231110152944.647535-1-devarsht@ti.com>
 <20231110152944.647535-4-devarsht@ti.com>
In-Reply-To: <20231110152944.647535-4-devarsht@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 12 Nov 2023 13:01:19 -0700
Message-ID: <CAPnjgZ1--+PBECK7UhWbsCyaUDMKL8LRm3sQnOz8YZsJdpHC6w@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] common/board_f: Catch bloblist before starting
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

On Fri, 10 Nov 2023 at 08:29, Devarsh Thakkar <devarsht@ti.com> wrote:
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
> V3: No change
> ---
>  common/board_f.c | 33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>


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
>         reserve_trace,
> --
> 2.34.1
>
