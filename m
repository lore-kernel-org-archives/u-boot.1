Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB07CA5FDD
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 12:34:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2CB9880F77;
	Sat,  3 Oct 2026 12:34:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ooMzp__xlKtR; Sat,  3 Oct 2026 12:34:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 55DCB80F71
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791030879;
	b=nXwOJJX+qX4N3nnJ9w2e4VkdTXA4qPtuvNGm4p2a4cf4JOxZb211b/Rg0zV4b20upUrG
	 HiK/qprbVvvDLkto9aUFJx2rSpkyY4+UhJhR5Kb4o98Ye408r+vyVp/GXpvvE+yO8oYzA
	 ik+7ofYlfOLg8d3dQaewzJjv+JpWBFTHGnwdVwVtkdP+42061Drs8N0vNS6ggW+fvsPON
	 7/oYsoymkPyaO4Wz7lAUUmRXWC2EANdGWH9uOu3Uq/wmlVPzg0gNdFzht1kbPxiaFrYFP
	 DMwGdFjwMaNsTzDsMfZK7XGuh8qLj5+SBYm0hmH3Ei4G4mrjWfdfFO8O/bzuvglwhSg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791030879;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7yNNq/zgO8PXTtrPsxSb8ekni2yNGmx81YtyCskOTPc=;
	b=ZJEEwQxS96x8KPXMCIVR7fGkDQEcK2FitigK25/Ft9ppdafGjFuKIHHMvGSDplbVW0e2
	 vTneuWPvPwZdenNYU/4xxSxPR0jty0WH4K4JVh52NRvRGI8OQPvXg0K1MvdEKnOv7+t8T
	 WqWXbcZAaSuwfnLpscdIwb5HrgK2ibZBqL6Li6FW6zVBS0/UFYZvph8/4vYPUytBT8dIv
	 4WQrAl2yB89LkB/1EFDMiD2ObAc1KOiNp0GuTmIfSNHVEXaL3M/GBzP2dr4z0F6fuGdc5
	 EOVs+H9uP7j0QcLlsj5c6KESuWs5g6La2bzKbjYeiuFU9CAH4X2iZUzSmuYvECjmZyg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=avYloluq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791030879;
	bh=7yNNq/zgO8PXTtrPsxSb8ekni2yNGmx81YtyCskOTPc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V62pu1SThuGDW6AR10H/doUXY+Sl1X8/2LOcHQcYOkIaYau3htzQtpUPVQ4JAJTh5
	 CXrPv3TAEoFa28heNHLX2h/TlIrgKJTlSOmsxIKjipgmvERIn8PvmLiWAAoM0UqNFe
	 4dZcRNkXtwbKbKJ0Wj+1eIL7mbzvEkR+r4oZtXiVGjL5kXyHI/J7Ahz+5+f4JkCth1
	 PtRQGW25NRHdet0y6EkeMDp5EjVN2zilgQeN8mBAa9ord5NIPbx6nhq+XmBsOTeaKY
	 Mz28AWgrNTnTLq8aR7ib39Ps03/nslW+47irnlMYaTnhTqv3Hr7aHUSlQUeqfHEpzX
	 CK2zXYblGoIrg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 55DCB80F71;
	Sat,  3 Oct 2026 12:34:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E27F8335
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 12:34:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C774580F71
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 12:34:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Aq5BL8ghOVAx for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 12:34:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A2E5880F6B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791030862;
 b=EXCm372Crxo2U2wgE9VrK+5cYEa0y7FV/RWd/1CNcS7JNvt+p/05XfTb9n322G3LPZSF
 GydKbP2rmTvRPHuU4CXpDgqK+qdudDOqP38Z9lDHJw5ArHzwGXkLY1/34ydMuaedwPig+
 alBDovsuIoRj527RLbY//TGdyoyV9AcxIshQgFDT1EbyeRfudPTOwDTATbiHObqOcTiDd
 s/69NuYDVjsVjvLL4OdeiXfBgruooKIBgx99lUh8ytaXPmexRI2E8LAg2P6oahFIHPHgb
 IKEuRYVLs3KlIgrQ8qrlkBtGurApxzb4sf78gcu7It3XmRaxpMoKR1wPTIW0T1cowDQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791030862;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=7yNNq/zgO8PXTtrPsxSb8ekni2yNGmx81YtyCskOTPc=;
 b=V03A5tCp0H5i5UzAS/Z+IN2bnxW/sTYpb/EVg8SMmTptyauAo9Bsf7bzAiah5RqFxPEK
 ng8zvLRumS7Y0hn8xqFe62km/oAjEyYKumfo29acR2sywOik/zS/9mPsER3SmZEURX6wN
 WLDeyIKD76dK0zPgsUMBeeMG39bihyFvT6TVTxhYvV++I52OXPU5whE0UVJl0nT+sCR7i
 cbAEmiUSy4fIV0VefVH4VB+CwFMFn/jETT/oQQYLtDXDoL+a0lxQiNjfqXiIHXdpQQuk0
 ejNrOhEvqWiUWlidPfSx5hk5b29BXmlQNzcqksVA1Sz4IDhiY/7bZnzLuj9PV0UOxGQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=avYloluq; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=avYloluq
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A2E5880F6B
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 12:34:20 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6a9bd4db6ccso479100a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 05:34:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791030859; cv=none;
 d=google.com; s=arc-20260327;
 b=DWwpAbzN+GNJcBXvyZXMsiQ2TPNt7JW5LXQ6GCl5otTCSDIb/uADs6tfayRagCJBoV
 zowAiZA7a7qUsxhUMZftbRb/fl/6sYjrSZ7LoEmcsccm2QZ+F9q/0fjOCxoFBprAV4/P
 vuMqfJfp80NkfVHyXuPQVIj+HN5W+wCdH09H4R4KkL/NW7ThsFezddP26agKGPvpjBNX
 mpZ8mOa9TYK017XJaUepj9z9guRqQzs+oEWA5DS3/IvDMFIBdgRTmhwe/1+VH6dytpiA
 PagZ+YxDMXjYNLM6r7wB2UFx8BNx2RXTv1jzkkAdjvB7i0I51J/tLV5BtrD56ZSHZkKn
 h4iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7yNNq/zgO8PXTtrPsxSb8ekni2yNGmx81YtyCskOTPc=;
 fh=Y0ewoOy1m24gAX+VUatIisMB8DFcFCnEMXt3vH+oxCg=;
 b=PQ7GVK8Hl+gxTDiY1Qo7QWE7TzHHwTZSIvJxDKP6N1B3ctxkpUn4vQ6mS9w6JbvODj
 qMSNBEtR14DdP96USnNPe4LxVuUzMk48aLgQvCW5ujCYkvTtqYHN4t9dlVOFmuwpggkn
 F59F5BVK2jwOZobh4hCjE8AkIUYN/n7gCYwkquZW/i4YrG0OrdnUTK49dH+FQJu3ly5C
 xV2B3eqdaoIRuNrZ8uXFPz9wnq0vH7A0DsccDZddjrRL8e4uOWR4DuItqldYC4zYOHEc
 Q4fXTTeXcXl50GgACjYx860xBUpo6jsPcBCxIDLV9IbOH5JlLlMJavCjYNwK/u/En24o
 5PAw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791030859; x=1791635659;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7yNNq/zgO8PXTtrPsxSb8ekni2yNGmx81YtyCskOTPc=;
 b=avYloluqeR+k9QNGJyfY9RmfslRF0Bq/xf6XVYzJbnHBA5JQFb2iODV6Xo4gdhOPFa
 f+sm5xj9lwN3sx19KvDsINgat2PAIjOm6CZJcUT+76u0/QwUik3m4+L67p9ooM4DoGDE
 ifr6h6tmnlRXXuuUfrwx7zwtKui5rbYI9Advo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791030859; x=1791635659;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7yNNq/zgO8PXTtrPsxSb8ekni2yNGmx81YtyCskOTPc=;
 b=gBG3VFfLQYEzI7cZ26N8RG3fV/Wk46mukfLxwz/HhPTuYeRBXsswSM+O7uVO+kK/rM
 nz0z8HBXiq45PgDSU08xyFL6/aAxyoWg0yYlZmDyIJkCbZH/015SsWBIlUYBNxyEXiF7
 4w1Reep2W6dSqkz8zWduhMuL6lOVt+3akwjcLAHcTkXGs5eTSB+f+oF3O0VU1vjGqA7L
 +v0tsgqVAQoJL/vggBXbpBcW/8fm5fcU+fKvlKPV0n7f0q/w2+kMJg15mE/VfyEAo44E
 mpBGHClYSqHB9axN59tLNktIIEAQjVkgidXrk4zOUGlQYaSZ29WGCc5Qj7QZtJ26GRqw
 47iw==
X-Gm-Message-State: AFq9FYIcrbLrJQZqrTMXdZfR2scxza+dm0A2vSm+QjpeGjyemdhQZ7ug
 HG2UqQCmMmXuGHihiDzXanbsw0BtGemyteGEsk4spEqj3QMhMnSAJWovD4k6+sV80V8D5dc7Wva
 ogB46lYrry9HgmGVG1LwVsr7brTKYZdLE9wa5mTTbMzrQGfu76UFm0/c9
X-Gm-Gg: AYBFou3yxUoBARobByk/Z4bHkFWH3JzE8gzAkT1OwDGFk+FKJ2BwjEpBkoq5UFAMTwQ
 OGhBmtDzjUcR4So1KFv+LtmeevBlemoqJz1UWIJC5hoFSGXMOeDeUIjhesDD8bk4Zi4MEPuiqSZ
 WbKMfWBJo9Tskj4ht6CHUWMHx5O684H6WL8Nw32G+jgH+SXBNb34N37jyIM4Xp0GD0jC9jUoSoD
 k51Wkll/5xaOqGlPI3U/6fy+pWcNi0omYBNIT/WumumdlMSDAL8WiqHv7AFJuu4jolYx66eM3De
 9SUNoQ5YV9wZZ+OtdeRbHELVo+4zrGPwv+KBtiqZeegRzhGOhB8Fq8JNRRhCASvcRhg=
X-Received: by 2002:a05:6402:50cb:b0:6a1:4458:7f2d with SMTP id
 4fb4d7f45d1cf-6afad760edcmr2187064a12.5.1791030858768; Sat, 03 Oct 2026
 05:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <20261002-b4-framebuffer-stride-fix-v1-1-4a8498416b01@protonmail.com>
In-Reply-To: <20261002-b4-framebuffer-stride-fix-v1-1-4a8498416b01@protonmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 Oct 2026 13:33:21 +0100
X-Gm-Features: AclHuK8Ik0gd2KPE8a3Ed-i1shxzU-bTWqx-UN9oZTfDP7PNyWOUNuinAHC5mDw
Message-ID: <CAFLszTiFQ+GVpZnPiRkHGVDnL--A99CkjkXCvQD0VKAHg=AWEQ@mail.gmail.com>
Subject: Re: [PATCH] video: console: clear rows stride-aware in set_row
To: petr.hodina@protonmail.com
Cc: u-boot@lists.u-boot-project.org, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>, 
 David Heidelberg <david@ixit.cz>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Petr,

On 2026-10-02T21:19:31, Petr Hodina via B4 Relay
<devnull+petr.hodina.protonmail.com@kernel.org> wrote:
> video: console: clear rows stride-aware in set_row
>
> console_set_row() and console_set_row_2() clear a row with a single
> contiguous fill assuming line_length == xsize * pbytes. A stride-padded
> framebuffer inherited from a prior boot stage (e.g. via
> simple-framebuffer) breaks that assumption leaving stale pixels after
> scroll.
>
> Step per scanline by line_length instead matching the glyph renderer.
>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
>
> drivers/video/console_normal.c | 16 +++++++++-------
>  drivers/video/console_rotate.c | 16 +++++++++-------
>  2 files changed, 18 insertions(+), 14 deletions(-)

> diff --git a/drivers/video/console_normal.c b/drivers/video/console_normal.c
> @@ -29,11 +28,14 @@ static int console_set_row(struct udevice *dev, uint row, int clr)
> +     for (j = 0; j < fontdata->height; j++) {
> +             dst = line;
> +             for (i = 0; i < vid_priv->xsize; i++)
> +                     fill_pixel_and_goto_next(&dst, clr, pbytes, pbytes);
> +             line += vid_priv->line_length;
> +     }

The old loop writes height * xsize pixels contiguously, so with a
padded stride it runs into the padding and stops short of the last
scanlines of the row.

BTW video_fill_part() already does a stride-aware fill and calls
video_damage(), so this could become something like:

    return video_fill_part(dev->parent, 0, row * fontdata->height,
                           vid_priv->xsize,
                           (row + 1) * fontdata->height, clr);

That avoids open-coding the same loop here and in console_set_row_2().
It returns -ENOSYS for an unsupported bpix, so the
check_bpix_support() call could go too. What do you think? I am OK
with the patch as it is, if you prefer.

> diff --git a/drivers/video/console_rotate.c b/drivers/video/console_rotate.c
> @@ -112,18 +112,20 @@ static int console_set_row_2(struct udevice *dev, uint row, int clr)
> +     void *start, *line, *dst;
> +     int i, j;
>       int pbytes = VNBYTES(vid_priv->bpix);
>
>       start = vid_priv->fb + vid_priv->ysize * vid_priv->line_length -
>               (row + 1) * fontdata->height * vid_priv->line_length;
>       line = start;

Since you are changing this, start is no longer needed. You could
assign to line directly, as console_set_row() does.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
