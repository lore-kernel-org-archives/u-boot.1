Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C7AC4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 00:52:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A40287635;
	Tue,  5 Dec 2023 01:52:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HhEUEdMC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E65EF87882; Tue,  5 Dec 2023 01:52:13 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7331B87635
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 01:52:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a1b6d183fb8so204216266b.3
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 16:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701737531; x=1702342331; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MDtzFPUcbIxqN1bjtAMuuocQ6JrOov3Cyshs0Xtami0=;
 b=HhEUEdMC7Szc/pNzrojYP4BL3g8gkmCBJsTzDQ4Zhc/Chm8PFm1mfpc0JKFAQpvOuk
 tVfEIcKa4VIFdG0tflL3oRpeitXRATgNd5XIra6/FrbS6tLx3rDj8kiJcN0uUZggOlVG
 oUSMbXDuyTodY/vmtDg7IAO7N6XCZA8T//9hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701737531; x=1702342331;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MDtzFPUcbIxqN1bjtAMuuocQ6JrOov3Cyshs0Xtami0=;
 b=rH5fBFC/LhKecm8qOGC/Y67889eb8PWt6/Y3PsO6n+7cUcXSYj+QU8Olvlw1x8hku6
 9ot/KbXDfR3dthx3wvvFpVi6+kCZylQggN8sw98lLPfz5PGmyWFyV9gSMjGpAkeVuguF
 E9IutzlZwm1C/3pEqo39UrPFAP1E6HjNyHbq7pfk5Cc0zKgSgJzK9OJ/6AET7qM+Uhow
 RQwcHyb3B7tfu80L+FRyS0CgUt/inqeU5C/reusg+gvAzU9ncrmkyQlLCXNm5XqbR0pJ
 3eO6ZNm9AeFC4opNrBJvsc8Ce3a+jI3D+Gs2t7TTu/Maszft5v16dQnMlOoaSgcYTRe7
 uG1g==
X-Gm-Message-State: AOJu0YwuyMrcA30MEZQQTo8ATOAcm8ixsdvVwYKyc68g+a6sgysVGlWP
 KQeWNEd0MxwwY19dHm1sD16zZ1wq1hRgJAWtqQsl+g==
X-Google-Smtp-Source: AGHT+IHlpSvPJYbDVDQO/SOY6AFlbOB8cluIIi61rmTNmOWzaIViwOvVjZJg/HOXCCLMhdbQ+7wSiVm113rcnipX31g=
X-Received: by 2002:a17:906:364a:b0:a18:7999:764 with SMTP id
 r10-20020a170906364a00b00a1879990764mr5685ejb.17.1701737530757; Mon, 04 Dec
 2023 16:52:10 -0800 (PST)
MIME-Version: 1.0
References: <20231123110222.15116-1-clamor95@gmail.com>
 <20231123110222.15116-5-clamor95@gmail.com>
In-Reply-To: <20231123110222.15116-5-clamor95@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 Dec 2023 17:51:57 -0700
Message-ID: <CAPnjgZ1vSuodpCqJ0mXM7Ar8okB6BuBHRowKRcWYV9rax_eyLw@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] lib: membuff: fix readline not returning line in
 case of overflow
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Bin Meng <bmeng@tinylab.org>, Ion Agorria <ion@agorria.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Sean Anderson <sean.anderson@seco.com>, 
 Heiko Schocher <hs@denx.de>, Dmitrii Merkurev <dimorinny@google.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, u-boot@lists.denx.de
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

Hi Svyatoslav,

On Thu, 23 Nov 2023 at 04:02, Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> From: Ion Agorria <ion@agorria.com>
>
> If a line overflows readline's maxlen it won't advance the membuffer
> and will return 0 as read amount which isn't even documented.
> Fix by removing this behavior alltogether.

spelling

But then how does one know the whole line has been read?

I don't think this is a good idea. We need to return some sort of
error condition.

I suggest either:

1. Add a new function which reads a line up to maxlen and discards
anything after that
2. returning -1 in the case that the line was too long, then having
the caller call a new membuff_skipline() function to skip it (which
supports any length)


>
> Signed-off-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  lib/membuff.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/lib/membuff.c b/lib/membuff.c
> index 36dc43a523..f582193dcd 100644
> --- a/lib/membuff.c
> +++ b/lib/membuff.c
> @@ -292,15 +292,12 @@ int membuff_readline(struct membuff *mb, char *str, int maxlen, int minch)
>  {
>         int len;  /* number of bytes read (!= string length) */
>         char *s, *end;
> -       bool ok = false;
> -       char *orig = str;
>
>         end = mb->head >= mb->tail ? mb->head : mb->end;
>         for (len = 0, s = mb->tail; s < end && len < maxlen - 1; str++) {
>                 *str = *s++;
>                 len++;
>                 if (*str == '\n' || *str < minch) {
> -                       ok = true;
>                         break;
>                 }
>                 if (s == end && mb->tail > mb->head) {
> @@ -309,13 +306,6 @@ int membuff_readline(struct membuff *mb, char *str, int maxlen, int minch)
>                 }
>         }
>
> -       /* couldn't get the whole string */
> -       if (!ok) {
> -               if (maxlen)
> -                       *orig = '\0';
> -               return 0;
> -       }
> -
>         /* terminate the string, update the membuff and return success */
>         *str = '\0';
>         mb->tail = s == mb->end ? mb->start : s;
> --
> 2.40.1
>
