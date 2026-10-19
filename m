Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E7C6CCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 09:14:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D15CA80BED;
	Mon, 19 Oct 2026 09:14:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ucC1UxjT4njK; Mon, 19 Oct 2026 09:14:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0BCD780D1F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792401282;
	b=iSE+oFupP1uWySC85k3gvcGpLkJxIPpX8n1p2hr8cmOpCZK0IgurskVMZihiz48OrQp8
	 W6F013LRTeYBoPeqVyerJMmK6VRjRtJ+u8XbHAn+QqFExLp2YBJIGMZ3gPGs7njx7K1vL
	 iYrKMxsHK6+MHd+z+jlwuulC5Z5p0O5dbKzR4oNf2PxIyLULHdP7xDoaTIoR2KFKoM1XA
	 4ic+p32mKQNA9m/aDGP1q9gK1tKpirG9evdx6D6gMR7LJESt81MsmptaLcjK5zEvs/p33
	 72//icIWKw0bayuajbXabSfYHoAufhtMX/pA97S0GfsB6thYwts3vY0O3ePMAyVlZBA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792401282;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yhWDmnngqWerqvkZQc2R/zS5LxOaF1S2bbIwEUQskyU=;
	b=Rr47CmkskMtncRNGfgCKgWShXz2dgGXxzXfDgstpx1LCte2i7CVnAP03WZrXVVM01hYe
	 TbTJDL5Bq4gJV0+JRblC1vuCkX9xPm8Dx4BSgqbhmBuGjBBSz4lfDVCPxRtiy3K2B3k9L
	 o8dI8AOFI6TZO14VnDMq8MpqDMoSmZMG3tVhbioILad314vRyFFEqw+4AL6PxCeZ/M8C6
	 gRN5wWvqbfgMHdxJ6yQokKpWzzv1QJRThLUgrX+4yTAlYv7Uhh3VO2QF4KkmAohE10Gfd
	 USSsrvGZLCEii+gS08aIor/C/Xe8Eg3d+B1ShhKE8AcFR0iVty0DQOelySEHbiR0vZw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792401282;
	bh=yhWDmnngqWerqvkZQc2R/zS5LxOaF1S2bbIwEUQskyU=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HqzhZ9J5S4FNE/TkyeCsuaIwPOn2Ti9KjonhX97WxyoFCFtH+F6vcL0GcxtAJXeLW
	 AIeZ+0ZApeK+iOHZubjLSKFXnsgXwiZhXKXFe89U8r/1ZV2Qy6FaZXFGRARrDlEMkI
	 +aELuvH2MnDfJ23lDcE8zB2S8ebCMjHW6gCn6GIo6pWzwZMCPViw+W/o3pQxOit4u9
	 3GC83UpUiuB8mAUg9dMCRuk8mKhpRaNOcP2fFXrFF7Dyy/zU+fStxiLtyn5KfvhddN
	 M1PS4h+vt6qihKBvH33FQR+v/GaCsYo3y5CKh2V3fwtaI5xt9f8h3yBFcrQvztxmAO
	 3p9hZFw03UtJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0BCD780D1F;
	Mon, 19 Oct 2026 09:14:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9EA651DE
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:14:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 84D124018B
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:14:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cnIq7XL1GEM8 for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 09:14:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D7CBD40062
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792401280;
 b=joIuOkmMTyzrCwUThfQRw3+ZPOF1CrGLpj95Bnfu9ihIG5qyJuYj/a5qA72ME/dAii3A
 CdVr0gztuSrLDss+RzyvQtNP/Za2wl95wo5otAvoAXIhO/uGgZqClSy+r5d/I9yaGMKQT
 H4Bmj8XuqVmYz41Sz8rqS8GrSnczWHAy8vcsARXCNbj6e7Wl4zVH0KKO4QwYgfUeZTdda
 moQhE82vmFECvg7POoM4DPZ382tCpoE3LJ88Bg7TrzKpZ6841Z5jVfo/bvRVI6iKHdmB6
 Yv27XwwYj+EYbfC7F9R3SOq6b1sUsGpyd6GCEQ2281V8t+ZFqcn+72eO0TlqJnstMIg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792401280;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=yhWDmnngqWerqvkZQc2R/zS5LxOaF1S2bbIwEUQskyU=;
 b=SK983X1ULmAxu7pk+J7+VuYsVPvn+OeCDd6242RWTjv+Dl8uDbJQmg64pSlPbpIGAbiy
 z6er972gABeJD4ZVZZMxsW9iZXnrERWBZF2iGWRv5mOuanp3411cxqlxLsI6EXGhuyLBF
 r0Jeplww/aI0PGuapK+0awotYuUecNabAgNpkftxJDySIahr7hjkg/XJtoM1uZjB8mKbx
 rTSrH4ktypal8dDxXGVQpZEb6lpWzXataV2fqYk8F1WMElKfXMRooCcxDWFkAZRJUFR4z
 HfiqjoegihD+Wn/kA9r1O6KCxor7HN89fSQP60fTW2l/kWniXUZ7idngVPTkR+rYLBg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=iJKScxuP; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::102e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=iJKScxuP
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D7CBD40062
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:14:39 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3ab9268d90eso1043358a91.3
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 02:14:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792401279; cv=none;
 d=google.com; s=arc-20260327;
 b=D34x/dl+x6h/OIDdOTFWEuH/MbICNAkAElw/yJcEuBgY2iim3hVWClzUh+ZgODcZSJ
 xkR1dkfdFxioolB0H4xWm1Q57KS/0rqT3pbw0DNfbdvgn7UnIWEWuAopLPY6PT8OU4DD
 E0wxJT01xC95gWMGr2T0w8jhFv9dxmvY91zDmmOm/7Fv7d6h3hsns+V2jK2oEkUK+5VQ
 n7JjCbkEb3SZhBI0Zb7a4NUUB7OX8l6xZWzjWdBvIf4rWeOnz9qu4OB6hmCTjewhQZje
 Za+g9PUkqKSbTMeZcNOVRGFIlLAZY9Y/GgKs6UO6S2RQgYxtujRVTS0K18Eipq68SgfJ
 PFhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=yhWDmnngqWerqvkZQc2R/zS5LxOaF1S2bbIwEUQskyU=;
 fh=W9limZYOATxEysRzoYuLOospUaufMivdRUWM0xek0BM=;
 b=AlofhDIKPNyZM0sfhmEm8a1Gda5BeTJiSxsDLT/9TdJHD9LB1qtOSdUnp8Ao/pXxUV
 bY8uGbhf8p+DdKYABLJIbLZll2zDr3XgTw9rUBA8k5k+NxWzlob5HA5/KQ4akIJ3CjPF
 eOHnccgbhU/clOTI1oPuHGiI0YjNXHaMNQ/z41jjfOS21TSLZTwc9NXJ6awz7wyMsl/x
 dVpE+JW5CQxewXnLUPiENZxvXc5zf62Nw0HfiWwwvi8ym6vQPCDSAejku3e5wplK4tfM
 cC3QhY4/74nKiVyp/qP0Deo5zUc8XnF+p8C0/3k0I52YPon3167znjahQGnMFmgrJMci
 yx+A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792401279; x=1793006079;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yhWDmnngqWerqvkZQc2R/zS5LxOaF1S2bbIwEUQskyU=;
 b=iJKScxuPJIiYSGsnDf3w0yflZSZROPXyk7CAo3O+iRo1e+Us3AIpXmFBGXE/Cn+bwW
 TRvu60R/0ScSyGvocYvkOL84ypNwXg07SR04XWZqoRv+BifQKaLePB93ErjjKhkDrf03
 N2mLQ/rHCU6JDlIx3fWZHKc2HAjHEZ88ry64g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792401279; x=1793006079;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yhWDmnngqWerqvkZQc2R/zS5LxOaF1S2bbIwEUQskyU=;
 b=sDvOFlFNisU76hbotUCCg96277BoS0ZhOrV2InmtARLfPVhD1MLiUap2qfGpJPDC8T
 CyaHZhjK3/5KHHj0hFLXXr0gM/IlOY8Y/Nb+Zi+YXFXuCh7Xl2bWPH259qSK/cJJZRMc
 J/VHTpQLx6os+Layq10vf/qpGpkpdw7aVAcBgLBjPsuSXnmyuku1YGvC0v+wQwE0YbjK
 wvENDNrbd80pTt5NLad8tuVy0YNgaw3d4SoVpXJoIvhpEXM651DnifC6qvEmtE16XL6W
 L5A8nuQls5+YAOdlHYGvLKA0frNe5uuSMNcBEuhuu0jZe+FlGA4My+9I8ckpltKKsebO
 0b4g==
X-Gm-Message-State: AFq9FYKhCjVrn4uYILzlT0mHA67bnhcbSAaZIi3daXUeWhJ3KxCVmG8D
 7BeQ8RnyL+q7AptZwABtzJ9zMn7zneZltm0GqLszOWzsItg7poQbt3011wnpmdlt1DzL++0lsVo
 1BeukpbrMcVojoQdsdEMO3+T6UKHlWykakEyXWJ7h
X-Gm-Gg: AYBFou1F9uOrOlQYb4HTfOy/kUU0Mkc2hSxZR2guu+1beoNy0GKn46IOeK5BZEzad0g
 0SLXR4HjvhIEGlHI6kaS4dZar3aoAwsVJCF7Qi+w+rtgWMMT8HtVOww5QeoNvu1qe40dF/MGdtl
 /dirddNApOz579IMxp+msovkzp8g2gEmdAgeUHo/7J8kq7uFIIaUOeh2lLJ2A3Wk0p6118duSz5
 F8pCTqRRU+d/pt1mkAueijlfHLbx93fBJY2PtLSTx5yArLlT/Yvo6Hx9v5coaRQpsc2QP7Y0ahK
 cZo+MYMucL180ka3Xf/hijoCNwWfytvDhtS5VaFbyp3ZvwKz/sRVaQ==
X-Received: by 2002:a17:90b:4fc2:b0:3ac:a203:e092 with SMTP id
 98e67ed59e1d1-3acee27717fmr6475280a91.1.1792401278642; Mon, 19 Oct 2026
 02:14:38 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 11:14:32 +0200
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 02:07:03 -0700
MIME-Version: 1.0
In-Reply-To: <20261017-b4-expo-colours-v1-7-479ac06e7642@protonmail.com>
References: <20261017-b4-expo-colours-v1-0-479ac06e7642@protonmail.com>
 <20261017-b4-expo-colours-v1-7-479ac06e7642@protonmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 11:14:32 +0200
X-Gm-Features: AclHuK8ysS0NA4Es_xMfXm9Oao8XyV789vMutejbDjzTnqCSuQautFD8txqDxis
Message-ID: <CAFLszTi1SLQV2nXv471jf8b2NVv2df25dENus7z0ZzWh7KQGzA@mail.gmail.com>
Subject: Re: [PATCH 07/14] expo: Allow the background colour to be set
To: petr.hodina@protonmail.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Alexander Martinz <amartinz@shiftphones.com>,
 =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Petr Pavlata <petr@acrux.cz>, David Heidelberg <david@ixit.cz>
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

On 2026-10-17T09:10:23, Petr Hodina via B4 Relay
<devnull+petr.hodina.protonmail.com@kernel.org> wrote:
> expo: Allow the background colour to be set
>
> Expo clears the display to black or white depending on the video
> device's white_on_black setting.
>
> Add expo_set_bg_rgb() to use another colour instead. The colour is also set
> as the background of text while the expo is rendered.
>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
>
> boot/expo.c    | 42 +++++++++++++++++++++++++++++++++---------
>  include/expo.h | 15 +++++++++++++++
>  2 files changed, 48 insertions(+), 9 deletions(-)

> diff --git a/boot/expo.c b/boot/expo.c
> @@ -215,30 +215,54 @@ int expo_render(struct expo *exp)
> +	if (exp->has_bg_rgb) {
> +		colour = video_rgb_to_colour(vid_priv, exp->bg_rgb >> 16,
> +					     exp->bg_rgb >> 8, exp->bg_rgb);

Please mask these explicitly, e.g. (exp->bg_rgb >> 16) & 0xff. The
implicit u8 truncation works, but masking is the usual style in U-Boot
and reads much more clearly.

> diff --git a/boot/expo.c b/boot/expo.c
> @@ -215,30 +215,54 @@ int expo_render(struct expo *exp)
>  	struct udevice *dev = exp->display;
>  	struct video_priv *vid_priv = dev_get_uclass_priv(dev);
> +	u32 old_bg = vid_priv->colour_bg;

...
> +done:
> +	vid_priv->colour_bg = old_bg;
> +
> +	return ret;
> +}

The save/restore runs unconditionally, so the common path (has_bg_rgb
== false) now does a pointless read-and-write of colour_bg on every
render. Please only touch colour_bg when has_bg_rgb is set - it also
makes the intent clearer that expo only perturbs the vidconsole state
when a custom background is in use.

> diff --git a/include/expo.h b/include/expo.h
> @@ -636,6 +640,17 @@ int expo_render(struct expo *exp);
> + * By default the display is cleared to black or white depending on the video
> + * device's white_on_black setting. This selects another colour instead
> + *
> + * @exp: Expo to update
> + * @rgb: Background colour as 0xRRGGBB
> + */
> +void expo_set_bg_rgb(struct expo *exp, u32 rgb);

Just to check - is there an intended way to go back to the default
(black/white) after calling this? has_bg_rgb is sticky. If that is
intentional please say so in the kernel-doc; otherwise a sentinel
value (or a separate clear helper) would be useful for callers that
drive expo across multiple screens.

Regards,
Simon
