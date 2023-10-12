Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E87ECDB482
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 15:44:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AF9A86E6C;
	Thu, 12 Oct 2023 17:37:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Xp9BMaJ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D920386EC7; Thu, 12 Oct 2023 17:30:47 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABAE986EBB
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 17:30:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5347e657a11so1793700a12.2
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 08:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697124553; x=1697729353; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TxcREo6TACB2HoVvP1NZcnSTlM9wgAmYYWMzJk17Vjo=;
 b=Xp9BMaJ2Q2GKISCeNxk0YCMWHFAkeem65Ah0OpgcPfKBkJnhtmY8l8UuaivS7aaE84
 GdEBJUxTyIzYVX7iEAEtfcDQlc+3X/7ErY9kKP/tjPKHArI+0O+FaAMzi8dzUkY2tVss
 m9GorrnS8v+CeOLr1B4d2ni40U8Jgz2JZhDis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697124553; x=1697729353;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TxcREo6TACB2HoVvP1NZcnSTlM9wgAmYYWMzJk17Vjo=;
 b=YeRQWBNDQmny4kd9Ol/zNbAXn1iE0goRtDDNq+oIuPHG1p0llHjJvpo35kvyYDsZy4
 uRTIdZyazFqcOaMRj/BXWFlXLuiZFqVLzg+qMb/1PADVHaYhwDk2vXxbe4n8kzUsRkMj
 x78iLzrFPBbwym0APp4xRA67fz0BV3NQIaSRuFrgSDzLURkUQiPIjLCc4oyfCNMfuF0s
 x9wjVEYdF/9KlYwvxazxomYzQoWEaDxFgGn1284tVAobe2EItpAQONoXXs5k71JvUlRQ
 nw/skSyQyXNrP5P+makTBnA4aZcM3yyHp4t0WTDTrrtx3o4t5vcXGJXI/s5e+ezLMVEv
 +c3w==
X-Gm-Message-State: AOJu0YwirzjiIFxBYVOUblojBlGH+YtdZhWLJT33oeNgZhVTIJQlvL2y
 cTaUnWTQ0TzFU+I4ZED/dAG9vPa5qdmsQLKiBJfpkYBZv2+B+7vvKOs=
X-Google-Smtp-Source: AGHT+IEEpjxdL1tXIClxH59TvA1wOFMQwnFJTUvkjMvP2SYljj97zwr4XBTs9hiqkE3PEILAS75Nlc9bsMGzpRsXmJM=
X-Received: by 2002:a17:906:1011:b0:9ae:513d:47bd with SMTP id
 17-20020a170906101100b009ae513d47bdmr24314863ejm.26.1697124553319; Thu, 12
 Oct 2023 08:29:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-2-seanga2@gmail.com>
 <CAPnjgZ07k1UeQDT6Ci9Dhtz6oKajGKoP5zr3-55UNHaJsN28=A@mail.gmail.com>
 <8611e3da-7232-1149-8f7b-7106b6cc9d0b@gmail.com>
In-Reply-To: <8611e3da-7232-1149-8f7b-7106b6cc9d0b@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 12 Oct 2023 08:28:53 -0700
Message-ID: <CAPnjgZ3K4s7ZbFnn=P39pjHXNFHEy-Bs-Qbjxi+3powCUrBKrA@mail.gmail.com>
Subject: Re: [PATCH 01/26] spl: legacy: Fix referencing _image_binary_end
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Fabio Estevam <festevam@denx.de>, Marek Vasut <marex@denx.de>
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

Hi Sean,

On Wed, 11 Oct 2023 at 21:30, Sean Anderson <seanga2@gmail.com> wrote:
>
> On 10/11/23 23:41, Simon Glass wrote:
> > On Wed, 11 Oct 2023 at 18:56, Sean Anderson <seanga2@gmail.com> wrote:
> >>
> >> On non-arm architectures, _image_binary_end is defined as a ulong and not a
> >> char[]. Dereference it when accessing it, which is correct for both.
> >
> > Is 'dereference' the right word?
>
> Yeah...
>
> "Take the address of it when accessing it"?

That seems better.

Regards,
Simon


>
> --Sean
>
> >>
> >> Fixes: 1b8a1be1a1f ("spl: spl_legacy: Fix spl_end address")
> >> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> >> ---
> >>
> >>   common/spl/spl_legacy.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> >
> >>
> >> diff --git a/common/spl/spl_legacy.c b/common/spl/spl_legacy.c
> >> index 095443c63d8..e9564e5c2a5 100644
> >> --- a/common/spl/spl_legacy.c
> >> +++ b/common/spl/spl_legacy.c
> >> @@ -19,7 +19,7 @@
> >>   static void spl_parse_legacy_validate(uintptr_t start, uintptr_t size)
> >>   {
> >>          uintptr_t spl_start = (uintptr_t)_start;
> >> -       uintptr_t spl_end = (uintptr_t)_image_binary_end;
> >> +       uintptr_t spl_end = (uintptr_t)&_image_binary_end;
> >>          uintptr_t end = start + size;
> >>
> >>          if ((start >= spl_start && start < spl_end) ||
> >> --
> >> 2.37.1
> >>
>
