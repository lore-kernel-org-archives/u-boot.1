Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 252DACF45D4
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 23:38:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFB9783759;
	Tue, 13 Jan 2026 00:38:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EVMGOZgH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7A9283952; Tue, 13 Jan 2026 00:38:37 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0164D836A3
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 00:38:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b870732cce2so268591866b.3
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 15:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1768261115; x=1768865915; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7VcC6BHG3ByFbu8fgdC6gmG5zH21VPZ3ZgWYoXPEFkM=;
 b=EVMGOZgHjfwlFM7u1rP7B2hOzREv5R8tcy0vqTYBLldeucVyEbxVnA+n3pOamTby7H
 CkGmPEhg2fRNFt7acOmGS/sS4jIYOCVsl0aTDGvOkkvea3ttKYrgOt5pgy1MBH/MNrN/
 1k7gcjk9P48gIfLP+6IP4lGXU8Z5Vyb2VPMJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768261115; x=1768865915;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7VcC6BHG3ByFbu8fgdC6gmG5zH21VPZ3ZgWYoXPEFkM=;
 b=WkkDof3rS4lAP2yUn5O5kTKlK3sDR0YcZZGoA6Kh5PLYLpJzMt9Tx1QVruDA7adCzj
 UOyn+BMdUKXVyDW4sgq0W5YJdtmj1q7xWmXHBq59sY2cOajLRa+mtb3ChiOGn7o16B6g
 0QcBF7B6gfoFDT4QqgwoFuFiwgq5wEWe1m3mapxh+ToTFsMcpqPZv6mABJ8EXCl44XWS
 vcSxkXWDM7pryQOT3WT3Rq0tqg02NjuPN50eKK1EdCSnWM+f30FQOALPd9UnAEmZU4SS
 gs12KZgGp04xnCrmZ1BMqM1APwGeqUdLh1KL7JjTAF7HH+KgO76VDU7fFPKd/gAuX1fw
 Av6g==
X-Gm-Message-State: AOJu0Yyunyy2HAD1DUUyQy/8ZIMdERoRW2WWrgI4syR4nwJFcBlwj8Kx
 4bmyTrus+wotl4qCn8xB6XfOajNJJYM6vCposUfmtnDNKeZG0Scc+9SZnnmNnGCzkPv/b17ZsEt
 iby6AFw/PTrIfeIueFFru8H8r2QvAUvLXO2XRDg54
X-Gm-Gg: AY/fxX56xm+U1A6TpwkNgKSp/6I5PhnwWEZ66FIPoC0O8ZW3d/tcgqlVag1TfDMG1K0
 grpskpv1KjaC2+0eOcpEntmUKKkbckvuSjCj4JPK+JEQXbsZWMFh/KLsj+VHFrOMjKLjREWGFQ8
 ccQi46LnnvOCouLTjo7p7dN84/HhTiVzH2SIxvlz296QHhqaJ5qYpNIDdfi6/d2HPklLEsfCPeu
 WT57Y0p70KkddJ9Miw1zsNPGWr7m/r4tEOdACV7gvizQK1hgL98LxNcyz0cqjUl9LOusw==
X-Google-Smtp-Source: AGHT+IGhS+gBB3Oh5Y1Q9FJ80ha/n8K4CB+YdmK2f3IioxzEpL3oUbSdYcZyn2BnajwYAFv7OqkLCBLehm6O9v9Oz2o=
X-Received: by 2002:a17:907:1b28:b0:b6d:73f8:3168 with SMTP id
 a640c23a62f3a-b844516a5fcmr1943484166b.3.1768261115485; Mon, 12 Jan 2026
 15:38:35 -0800 (PST)
MIME-Version: 1.0
References: <20260109112428.262793-1-t.preissl@proton.me>
 <20260109112428.262793-4-t.preissl@proton.me>
In-Reply-To: <20260109112428.262793-4-t.preissl@proton.me>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 12 Jan 2026 16:38:23 -0700
X-Gm-Features: AZwV_Qh1CJqD2q1qTR-Uehe7bIZD0T2zuOVtQeQCh-FrU-4OzEuBt321D7Yvgh8
Message-ID: <CAFLszTh0d4GMy5Hubgc0JRG_5B7d45FPVGG2LX7dnRL7aHVA5g@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] fs: prevent integer overflow in sqfs_concat
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
> An integer overflow in length calculation could lead to
> under-allocation and buffer overcopy.
>
> Signed-off-by: Timo tp Prei=C3=9Fl <t.preissl@proton.me>
> ---
>  fs/squashfs/sqfs.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <simon.glass@canonical.com>


> diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
> index 4d3d83b7587..f668c26472e 100644
> --- a/fs/squashfs/sqfs.c
> +++ b/fs/squashfs/sqfs.c
> @@ -255,10 +255,14 @@ static char *sqfs_concat_tokens(char **token_list, =
int token_count)
>  {
>         char *result;
>         int i, length =3D 0, offset =3D 0;
> +       size_t alloc;
>
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
