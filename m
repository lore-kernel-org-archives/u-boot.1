Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D685CF45D4
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 23:38:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D03D83935;
	Tue, 13 Jan 2026 00:38:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dO2Dx8KK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5D8A83923; Tue, 13 Jan 2026 00:38:34 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8EFD836A3
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 00:38:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-64daeb28c56so11481217a12.2
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 15:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1768261112; x=1768865912; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XIITvyYEiiKaT6+ntPqW2BetBsZ86WXvYCgJoX94/+4=;
 b=dO2Dx8KK0f0E6+PwHv0H+KQ+XQ6d0XQVPOPl4SW9U4BxqNVp0AKO2qfBoWUZ28Qg4m
 ta4EkRnuBOqIupMMA/zI+neOusqaF29y/6tE84cy4zDxYeSPV8iLTihdo1Q/zgwDOj2k
 mw+08DZ7sHvtDCPvSg6j4lM98cipR8QELWDe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768261112; x=1768865912;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XIITvyYEiiKaT6+ntPqW2BetBsZ86WXvYCgJoX94/+4=;
 b=s6I0Vjbj8hdwuXR7i1Qhishm7/Sx3DgF/PgmzoBzJwX+ZVL6EBMlXmIa6piZxhLG/K
 2ntzRRlz3SwKM5WXB0KrciMZjqIcCVQsHioRlLgFqkxyEDcw3JGzoeDi/UoDerL7K0NQ
 b0GqwzMWTL1fogFh3CUYtsdTDOPHDw6fxy//vRAVea0QvmIfPcAri2PMBmT906UWwRZ0
 5RlFmq4rAvKCeFPfA+MFEBriLECOpwS3X7forFwKPHX7gfK7PdRv7VA5FgxQvWH7MXrD
 Y4dEL2kluX2mzbTmDH8cC4AFxokp0pLK9gXkq+QxsKrwZvQpdpVxPGEBa6Hq+hANhlPn
 UOmg==
X-Gm-Message-State: AOJu0YzNQREfWpzoA6ImVlXwsIU03ReIdL5MtkUWvx5LEOqEDZLdiOWP
 WtOV9aIGQIbCEwto/PejY0ouGnWm1LQdYxDZCxDA4jsi5gXd4FoRELbQvxoq74e08mXVRYOC3FI
 pPnqMrF7sc1wqEVs76RYanfivH+m+tgItZ1SWAOtp
X-Gm-Gg: AY/fxX7mFoUWv/hdRijbZ53bmBtqJmZC8SgFJz0UE1M4mjLT/fw0CYFO+dDaHGu2Sqj
 Vr0CDWxDIp0gtFr8cl7qWe9/Sv5wFEInnhHKcH1KU20iEnIwIrifrL4/9szQIcsnuXYyjJqrpiJ
 sf50osvjLOXiMrFU8af2nC+qB/DhlLi+LgGBp9XyRqscL8WC06tglYdY940MGzNIKdtvhk7zuZR
 Ke1Om5gOCmK/lr1hAGWKoT7uXr796LW95tS2BF+CP3AUhYAB7x1egdaHlV+Dmikt00D1w==
X-Google-Smtp-Source: AGHT+IEEVYv19NTYyO9ntfrRHiYrXkZcZ9NhMkPWO/v0nPZu6DYIaaOi+b0VQCHjjTlrS8NsD0lIYVp2Q20h57gvL+c=
X-Received: by 2002:a17:906:4fc9:b0:b80:3447:e0c0 with SMTP id
 a640c23a62f3a-b844542917bmr2041447966b.62.1768261112275; Mon, 12 Jan 2026
 15:38:32 -0800 (PST)
MIME-Version: 1.0
References: <20260109112428.262793-1-t.preissl@proton.me>
 <20260109112428.262793-3-t.preissl@proton.me>
In-Reply-To: <20260109112428.262793-3-t.preissl@proton.me>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 12 Jan 2026 16:38:20 -0700
X-Gm-Features: AZwV_QiMtez51K4nj7hDWwXeR6BlX94ijwKGfer_Ww0qvLIHzz5riOdx0_rq2WI
Message-ID: <CAFLszTgEuiVV9p9Bzbh1ufPrXQ83PONqZV=1efSx=wgGeSpuZg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] fs: prevent integer overflow in zfs_nvlist_lookup
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

On Fri, 9 Jan 2026 at 06:08, Timo tp Prei=C3=9Fl <t.preissl@proton.me> wrot=
e:
>
> An integer overflow in nvlist size calculation could lead
> to under-allocation and heap buffer overflow.
>
> Signed-off-by: Timo tp Prei=C3=9Fl <t.preissl@proton.me>
> ---
>  fs/zfs/zfs.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <simon.glass@canonical.com>


> diff --git a/fs/zfs/zfs.c b/fs/zfs/zfs.c
> index 410a61aa611..c7502c344ff 100644
> --- a/fs/zfs/zfs.c
> +++ b/fs/zfs/zfs.c
> @@ -1617,6 +1617,7 @@ zfs_nvlist_lookup_nvlist(char *nvlist, char *name)
>         char *ret;
>         size_t size;
>         int found;
> +       size_t alloc;
>
>         found =3D nvlist_find_value(nvlist, name, DATA_TYPE_NVLIST, &nvpa=
ir,
>                                                           &size, 0);
> @@ -1627,7 +1628,10 @@ zfs_nvlist_lookup_nvlist(char *nvlist, char *name)
>          * nvlist to hold the encoding method, and two zero uint32's afte=
r the
>          * nvlist as the NULL terminator.
>          */
> -       ret =3D calloc(1, size + 3 * sizeof(uint32_t));
> +       if (__builtin_add_overflow(size, 3 * sizeof(uint32_t), &alloc))
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
