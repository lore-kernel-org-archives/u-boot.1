Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E82ED1D48A
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 19:59:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FDB8842D7;
	Thu,  8 Jan 2026 20:59:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EnEdTpaE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F5FE842D7; Thu,  8 Jan 2026 20:59:29 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 743A6842C7
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 20:59:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b8010b8f078so572529866b.0
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 11:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767902367; x=1768507167; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w/PSmeqL0dxD1y/S01IBBrXwjT9dqMztWJ4plhupWHs=;
 b=EnEdTpaEdDMMNVUBb0zNimU+PaY1QmWvwJY9jIpyn3GOODsQse+F/rhp3cd7xPsknT
 G6Qx+s+FTIBLulumnZqWDTjO3pLQgl+tXHxsTPzBB8e1rKLHgtFPCw8Ztu4QoYx7KR2S
 cONJknA/4LPjQtcaAtfRDoWrOlM94FdxYCJfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767902367; x=1768507167;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w/PSmeqL0dxD1y/S01IBBrXwjT9dqMztWJ4plhupWHs=;
 b=LljXzQaFhDNQgW26QIlt25jCgJXHAZIiKQ3MhgP+0s+o8DhGwp4pGTR+Isc3IeGEx2
 XC9ERu2jc66i++SEreSD7uDnxbXgAstQ+TR7fodSfuj6jj2oXxFwxt/SIiQz2i+4YTMg
 X1ea0K7+W2lf56LAW6K/T3gQUBd54uVkc+Rxv+3U3TJhVpNWb6e4LBVF5Ds1s/u6FHF5
 2ygpWrYRIqUP9291Qu4dB7lg6LR+SSV4RFoOJvZMffA5LSAcI9JpVyvKSz5wDU0qczKC
 IQS1ZNEMmEaGcrkF/93iUuTV7XZQ5TBlEl48lNewavzZ0eucEWu+ZmOO/QFRymDyxm/Z
 7F5Q==
X-Gm-Message-State: AOJu0YzQflgXDbpGH9xp+sRhSoP2Fm/SZXEo4Ago0YCET2in9IVbMm39
 wSLEy7TYeixZIlhXySZkb1UG+8Ed3QmHHFIFVrT3iBCugLHgpoWDXgU4fHrKimtLvcA3kqOttc2
 DygGjB+rPtb7JDNUE2k4N0iT8r+ffOesjgIDjwhFT
X-Gm-Gg: AY/fxX73zN9ClclFGe6iUJZgPZ6SwKCpdcwGYrOAdMAd1ORs2m9MDXkIR+VN6B13TOo
 OLN9+Y2Ffewlf5ew/lxqrMxtcpmx7MY0N+nNExRniGGLJKDnLZi1KUJLR2E32or3WmTalbJ8yv3
 N+cg0iqYDRwlfYrbXOJKFIzReGhRdEEArD/zzH3R3ipMdEEKFLnwUCpVAQXNdrSCOCrVC2j2wB9
 /pcqe6+yGRp9kXgNJwtk5pbkHwF6gh1Qa555nOzilAwH6zduW/il+HvadQmLFXCTO4PBGHqkvr7
 dgmF
X-Google-Smtp-Source: AGHT+IFKaX+PeBews5yMYhwhToov6TxO1ZYwbQQabMIm0DyVKgUCl2HemZZdF9vzqwhjgBfGADVO5s8ue8mQPnYB+Ss=
X-Received: by 2002:a17:907:6d20:b0:b73:845f:4432 with SMTP id
 a640c23a62f3a-b8445179d7fmr705672766b.32.1767902366912; Thu, 08 Jan 2026
 11:59:26 -0800 (PST)
MIME-Version: 1.0
References: <20251231100831.119142-1-t.preissl@proton.me>
 <20251231100831.119142-4-t.preissl@proton.me>
In-Reply-To: <20251231100831.119142-4-t.preissl@proton.me>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 8 Jan 2026 12:59:12 -0700
X-Gm-Features: AQt7F2r5VsFxp8mPMXB8T_TRtKbG6eUMSKzsQxr1Jt9Acs_Mtg529fxXERrv-Pk
Message-ID: <CAFLszTgDODfTDCnkmTiqJ+7faJRRKmk-Y1OsTq=PLcY5ttFQqw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] fs: prevent integer overflow in sqfs_concat
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

On Wed, 31 Dec 2025 at 06:19, Timo tp Prei=C3=9Fl <t.preissl@proton.me> wro=
te:
>
> An integer overflow in length calculation could lead to
> under-allocation and buffer overcopy.
>
> Signed-off-by: Timo tp Prei=C3=9Fl <t.preissl@proton.me>
> ---
>  fs/squashfs/sqfs.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
> index 4d3d83b7587..1dc63257fb9 100644
> --- a/fs/squashfs/sqfs.c
> +++ b/fs/squashfs/sqfs.c
> @@ -254,11 +254,15 @@ static int sqfs_get_tokens_length(char **tokens, in=
t count)
>  static char *sqfs_concat_tokens(char **token_list, int token_count)
>  {
>         char *result;
> -       int i, length =3D 0, offset =3D 0;
> +       size_t i, length =3D 0, offset =3D 0;
> +       size_t alloc;
>

token_count is an int, so I think 'i' should stay as one?

>         length =3D sqfs_get_tokens_length(token_list, token_count);
>
> -       result =3D malloc(length + 1);
> +       if (__builtin_add_overflow(length, 1, &alloc))
> +               return 0;
> +
> +       result =3D malloc(alloc);
>         if (!result)
>                 return NULL;
>
> --
> 2.43.0
>
>

Regards,
Simon
