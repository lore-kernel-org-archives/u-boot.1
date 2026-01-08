Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F910D1D48A
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 19:59:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E31CB842CE;
	Thu,  8 Jan 2026 20:59:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T6EBNcnP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CE6A842CE; Thu,  8 Jan 2026 20:59:22 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59259842C7
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 20:59:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b79d6a70fc8so665331866b.0
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 11:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767902360; x=1768507160; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OPuATFTUgnhr3sBFKFD2TootIfWpOAkn2fsW5ye7PwQ=;
 b=T6EBNcnPh35oJJCbxVhZ1Efmo/7uOwHNWk2dZOvqWv65kKO5TzAzPvYXpnEzCGFRsq
 R9fAXGW/3nuQAbQGsgmhOw8ud282x1mq4XzAFnK3qrBmeMRbGqkWv1+qF+sCfLfrcU8n
 xZMX765b94V44Gre5we0od7E91j6oNC0CWHVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767902360; x=1768507160;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OPuATFTUgnhr3sBFKFD2TootIfWpOAkn2fsW5ye7PwQ=;
 b=OZ/6/tCAZrk4Jugwwkz5i1LXnRz78XwYnd1I/mmbRJKLD7ku/qnmdot8ITg15T8tfI
 zNAmoszQK5Q7bHeN/WmQ1wvsDGAJapPDBooxIKs3ZUzfWXwtYu9vwD/awPk4nMOU16lU
 M+Tg8K7raEZpNN3AjC2DtKFpJwjjb4FNGjLQf3E7Q1N0bSCGY4zBk3eJhqQ3BtwqFYid
 5Bj9Pjse6ZcsEh/emUP73ZaN5o5NLwSrtiHzJma9RFEycLIjWiI2FOffa0GgNBfXb076
 Zy0WXFy9j301WshwDtrenDArAe9zFpfLQf36CxSktrN42OEtObb4AASINVmd0HRpjuj3
 OO/g==
X-Gm-Message-State: AOJu0Yxk5Ku9wGqITXyn8OvMSkOSTJZJ5zBwG2JfrcRTsWy8laBLiWCF
 5s+0qeaEASGPvwyP2zuPcs2OfX521V9SlQlRyAmI5ZhS41sobumFs/83a3nlRK3nTpCDqiMpeD4
 Kh+fWmCxuaA5VGfMvu2AOlz/zmDU30OGcQnjkGz3qQihiE2KT/uY=
X-Gm-Gg: AY/fxX5xDGuruMYfZiXdq3/sPcRRWID3i+3K1IXNx9/sJKiM0ZWtBIA9u9t+clew9So
 4KTqFGB7q7uTgH0TUNXPQgxDcPyWshfQZYdyc3cnlP5mxvPdm1lz0PtAPDhcjosG2jxC2jBP6RP
 bDM3zSMgwaV+t7YpVgl3ijEjhunmE0M6YDQpGETiNpoj4aLnvTDAKak7jQJIDQNy+N2w7+cNzJe
 Ys7ub1cNtGoyZL8EIsRCbLXUCskbTRM2RcCNXDTn8QdsWUCJx2kinIHiEAEz8r3vMLFHA==
X-Google-Smtp-Source: AGHT+IGwOXjWlwSnSUzoVsRTayvWBow6sBymhDRk0LWkF5yrY8XDi9+JeEUjDxZe9viP9UhEXESxbFKmF12y0YEp8ps=
X-Received: by 2002:a17:907:c807:b0:b7a:18b3:7160 with SMTP id
 a640c23a62f3a-b84451fcfbfmr737801866b.27.1767902359788; Thu, 08 Jan 2026
 11:59:19 -0800 (PST)
MIME-Version: 1.0
References: <20251231100831.119142-1-t.preissl@proton.me>
 <20251231100831.119142-3-t.preissl@proton.me>
In-Reply-To: <20251231100831.119142-3-t.preissl@proton.me>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 8 Jan 2026 12:59:06 -0700
X-Gm-Features: AQt7F2q4p47e8-ONm_qGxR0Ko7m0QvYSqD7wlPaY6hWDhKthC0U6LY6_UbyKEh0
Message-ID: <CAFLszTgGuq9qRn=+KtV39UoagRL=v_o1KYHXb4pm=JXj9C0cLw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] fs: prevent integer overflow in zfs_nvlist_lookup
To: =?UTF-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>
Cc: u-boot@lists.denx.de, trini@konsulko.com
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

Hi Timo,

On Wed, 31 Dec 2025 at 06:18, Timo tp Prei=C3=9Fl <t.preissl@proton.me> wro=
te:
>
> An integer overflow in nvlist size calculation could lead
> to under-allocation and heap buffer overflow.
>
> Signed-off-by: Timo tp Prei=C3=9Fl <t.preissl@proton.me>
> ---
>  fs/zfs/zfs.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/zfs/zfs.c b/fs/zfs/zfs.c
> index 410a61aa611..624f4e48cc8 100644
> --- a/fs/zfs/zfs.c
> +++ b/fs/zfs/zfs.c
> @@ -1627,7 +1627,10 @@ zfs_nvlist_lookup_nvlist(char *nvlist, char *name)
>          * nvlist to hold the encoding method, and two zero uint32's afte=
r the
>          * nvlist as the NULL terminator.
>          */
> -       ret =3D calloc(1, size + 3 * sizeof(uint32_t));
> +       if (__builtin_add_overflow(size, 3 * sizeof(uint32_t), &alloc))

I don't see 'alloc' here. Is there another patch?

> +               return 0;
> +
> +       ret =3D calloc(1, alloc);
>         if (!ret)
>                 return 0;
>         memcpy(ret, nvlist, sizeof(uint32_t));
> --
> 2.43.0
>
>

Regards,
Simon
