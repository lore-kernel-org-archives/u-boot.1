Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85910C48286
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 18:44:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAFFA8753E;
	Thu,  1 Feb 2024 19:44:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MOTJQWCq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCC3E87BDB; Thu,  1 Feb 2024 19:44:26 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FC7F86FCE
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 19:44:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a364b5c5c19so216651966b.1
 for <u-boot@lists.denx.de>; Thu, 01 Feb 2024 10:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1706813064; x=1707417864;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rPejtyBJLo7WhAx4ggUc1/se02NfsVglmCJu18mirTI=;
 b=MOTJQWCqZXdM+KaKibNkwuU+/Mt8uyP8gVMK2TIJzOgNH+n9LF+CRW++7ZWk5rf3BP
 5k5KCBO+2BhMc3P5SXBql8+uHW2Q2oEdwlL3z/OLewsK97daAM1fNkH52HRRXCerdrVI
 tggzHX3FZrK967QwryYljpFMPQfUNNtyTs0B4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706813064; x=1707417864;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rPejtyBJLo7WhAx4ggUc1/se02NfsVglmCJu18mirTI=;
 b=SYJBhS3Ll+CePh/cKiv1NVMYwu8qAEDowRUghrXL/joCMhJzBqVhv0jxm58PLQsDCX
 6pFESd/6l76zsK9e/Gu1Pj7y69B8VyTT516iKNkjozQxiUeHdsSFXBnLVCOSeRkdxr6U
 KMwF/4zEzBGsxMhHZK+y1aDRqCHi295FN4H2hfXl1/rwwJZv/KlzmAMms/yT9On0az32
 ML5VMZ9smZLOvBJJ63+6HIM3u+lJVy9vafnn92LtFaO145Rlto9AEWGOenw+z9CY6IS/
 Plw5GqC5tFiKXFpMbrBsMv2h+m3o/1aD/Q3v+REjnB2G9hoyafbAf8gjm4gcpOVujmlP
 D1og==
X-Gm-Message-State: AOJu0YyUtZXcRUmBFXkZ6mOdW1cIV52KlZpBFbBj5NNyXweHrMa43+7g
 xJBhMHpB7EaIvjPZCStRzs8j0c1L0xmsnzWlPfu8uHEn0cVQHiB/EGj2J6k+AlakNbQ9osrfdNZ
 vEeadvoN7A+R2arDyZfxjct6s0NdAltmv3gj1TA==
X-Google-Smtp-Source: AGHT+IEo+JA4gbMYQq84LTzB0EgDY03qg4f32D80MU35CgTZBekVYIF+xJDWu2vkyrcfSyZpic00QhblG7aG0mrTpVA=
X-Received: by 2002:a17:906:aec5:b0:a35:756b:d3ed with SMTP id
 me5-20020a170906aec500b00a35756bd3edmr4496614ejb.9.1706813063727; Thu, 01 Feb
 2024 10:44:23 -0800 (PST)
MIME-Version: 1.0
References: <20240201181851.221701-1-sean.anderson@seco.com>
In-Reply-To: <20240201181851.221701-1-sean.anderson@seco.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 1 Feb 2024 19:44:12 +0100
Message-ID: <CAOf5uwmaN=X+zwd+afKnqJx0=YZy+-87ojxSJmP5s1GAtSQ6KA@mail.gmail.com>
Subject: Re: [PATCH] lib: sparse: Fix error checking for write_sparse_chunk_raw
To: Sean Anderson <sean.anderson@seco.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 qianfanguijin@163.com, Dan Carpenter <dan.carpenter@linaro.org>
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

On Thu, Feb 1, 2024 at 7:19=E2=80=AFPM Sean Anderson <sean.anderson@seco.co=
m> wrote:
>
> The return value of write_sparse_chunk_raw is unsigned, so the existing
> check has no effect. Use IS_ERR_VALUE to detect error instead, which is
> what write_sparse_chunk_raw does itself.
>
> Fixes: 62649165cb0 ("lib: sparse: Make CHUNK_TYPE_RAW buffer aligned")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Link: https://lore.kernel.org/u-boot/1b323ec3-59b0-490b-a2f0-fd961dafcf49=
@moroto.mountain/
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
>
>  lib/image-sparse.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/image-sparse.c b/lib/image-sparse.c
> index f8289064692..09225692e9b 100644
> --- a/lib/image-sparse.c
> +++ b/lib/image-sparse.c
> @@ -211,7 +211,7 @@ int write_sparse_image(struct sparse_storage *info,
>
>                         blks =3D write_sparse_chunk_raw(info, blk, blkcnt=
,
>                                                       data, response);
> -                       if (blks < 0)
> +                       if (IS_ERR_VALUE(blks))
>                                 return -1;
>
>                         blk +=3D blks;
> --
> 2.35.1.1320.gc452695387.dirty
>

Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>

Michael

--
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
