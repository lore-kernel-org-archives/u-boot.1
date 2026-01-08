Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382FCD1D478
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 19:59:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1C2F84150;
	Thu,  8 Jan 2026 20:59:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OOnPGoZp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3DD98415E; Thu,  8 Jan 2026 20:59:13 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACE4D83B05
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 20:59:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b73161849e1so672557166b.2
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 11:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767902351; x=1768507151; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v80ZzTIFyDcKlxF9ie3iVjHJmGGYMHYBssMhJewsaAs=;
 b=OOnPGoZp8EnfaVe/lEYvMUChCQCWV0Y1Qzt3eR9elnmvlcgnAiSNJx3aESHPEYsUby
 nwRnWGCoqy+Q++lzn849CzdmaRGFWOsuZgk2KssNwnpouqiGhhTPy0ShLmWnMWibL6S4
 VcS3N9FzA8OTIFW76JySk/wMpQjXf/+gEo90Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767902351; x=1768507151;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v80ZzTIFyDcKlxF9ie3iVjHJmGGYMHYBssMhJewsaAs=;
 b=XJeVbfObnmqbrjUDNN6ZDZQEo0jf+bAsXYPb5zRfbk0yW5adxc8YUoWqfZv8qf6+dQ
 4KlK5qOuC/ouicPZCQyvvbFfcQWz6TgZYaQ6E9vclnRpEH7lPz7oS9x7moBHoIL6s2+s
 5QUrzWySEK3dU8l92MKMWuau85cuAhs1tBLytMwps5VwPKWjOiegckV0yBBIewaOKVlF
 lz3bojJIJ7DOEO7cXEMvL005V8NbmLMvJ/lxuenwyQCjKKoBcYVu21Yg5aPFm1Q/bxIL
 Q5/e//tNyKBCN4cNmaYvTCD7sg9UH+TboO2cSUBoKkJyazZG1IEmT/TNTvR0OHzIPSDT
 Xa8A==
X-Gm-Message-State: AOJu0YyZ7J1enMWFfZQiNNY4z7e5juRxzVNZDCqPdttIW0ub0DY3febR
 1/s5u6c5DaIBD56UItXJwLHxwUmf9MCfjzulqfMMAEHiJH5BgKkDh2YPc0t5pHALNd39r5iS/eY
 MF9PP1S5XR9XcgArYaIoGjUvLgiD2GpbfU9hAxieT6aGD+dAkb78=
X-Gm-Gg: AY/fxX5OtwPZcUL+5rNrOT0ysMAAhJD9ZjZ6Kt/cCitgDqJkKogtu26bL6JwwYI/Laj
 3Ydx7XlHuh5+9YQzO5UtEyRlq326MWYovIZ75qTXso6mwwbq2AOBc5WcKQ+U/xLpmCAfAVwy4Px
 kxm954VJJsoVC3ch0tbvZhYaopSYV1PzHueJRou1yvwRcxLTBl1RWf6EDO4MxDjUaBga9yGszIx
 wvkVN87VKoiahx5MfmdMG2sHco0QaJVXHEHl4cOGZAU6nBcxmB/ea/3GWhLhxS1wd0mbrwhDLOg
 OxSt
X-Google-Smtp-Source: AGHT+IFCP8FxGtbzy3u4oBa7HudwcVSEP2egWltrb41+kX1LuOM9G1D+h9IYc7MPqmfHzebXmm1JgOOt8uNkgah58TY=
X-Received: by 2002:a17:907:9714:b0:b7a:1bdc:aab7 with SMTP id
 a640c23a62f3a-b844542977fmr734055766b.64.1767902351114; Thu, 08 Jan 2026
 11:59:11 -0800 (PST)
MIME-Version: 1.0
References: <20251231100831.119142-1-t.preissl@proton.me>
 <20251231100831.119142-2-t.preissl@proton.me>
In-Reply-To: <20251231100831.119142-2-t.preissl@proton.me>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 8 Jan 2026 12:58:58 -0700
X-Gm-Features: AQt7F2ot07Ng1Bl-dh_QWRIFa5EKd57sC8sdcp8f3Bwj3VJg4P6R-G5aYS-bTqc
Message-ID: <CAFLszTj_9Tcb=c-9Yzhkxf=zb1ByaXYquqo865mq3ELFTup5SA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] fs: prevent integer overflow in fs.c do_mv
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

On Wed, 31 Dec 2025 at 06:18, Timo tp Prei=C3=9Fl <t.preissl@proton.me> wro=
te:
>
> An integer overflow in size calculations could lead to
> under-allocation and potential heap buffer overflow.
>
> Signed-off-by: Timo tp Prei=C3=9Fl <t.preissl@proton.me>
> ---
>  fs/fs.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <simon.glass@canonical.com>


>
> diff --git a/fs/fs.c b/fs/fs.c
> index c7706d9af85..319c55c440a 100644
> --- a/fs/fs.c
> +++ b/fs/fs.c
> @@ -1059,15 +1059,25 @@ int do_mv(struct cmd_tbl *cmdtp, int flag, int ar=
gc, char *const argv[],
>          */
>         if (dirs) {
>                 char *src_name =3D strrchr(src, '/');
> -               int dst_len;
>
>                 if (src_name)
>                         src_name +=3D 1;
>                 else
>                         src_name =3D src;
>
> -               dst_len =3D strlen(dst);
> -               new_dst =3D calloc(1, dst_len + strlen(src_name) + 2);
> +               size_t dst_len =3D strlen(dst);
> +               size_t src_len =3D strlen(src_name);
> +               size_t total;
> +
> +               if (__builtin_add_overflow(dst_len, src_len, &total) ||
> +                   __builtin_add_overflow(total, 2, &total)) {
> +                       return 0;
> +               }
> +
> +               new_dst =3D calloc(1, total);
> +               if (!new_dst)
> +                       return 0;
> +
>                 strcpy(new_dst, dst);
>
>                 /* If there is already a trailing slash, don't add anothe=
r */
> --
> 2.43.0
>
>
