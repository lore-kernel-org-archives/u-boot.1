Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720E1F99C88
	for <u-boot@archiver.kernel.org>; Sat, 18 Apr 2026 18:15:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8D6F83B99;
	Sat, 18 Apr 2026 20:15:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KZzhrH2+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2810B83BC8; Sat, 18 Apr 2026 20:15:10 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26D7C836AC
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 20:15:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6749ed8ae14so61069a12.1
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 11:15:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776536107; cv=none;
 d=google.com; s=arc-20240605;
 b=FZNq5nxJ0wWsH4WpmYAPZXkt0Bp6lc64p0aLVa3NRjHuBXBQ0SoEbnOORM6hfpAwhz
 /omF6rPusLeBwD+9aMmTOqdUWLjEyUb9XhVN1+ocfDAqD02lleVvKS2eW6TqaTZEaCDj
 e6JRMVEp73br0xKwJC4S1iwaeG2UdJK3ikLHtZj85+XrY28QhuNZ3xyH8BeVMSc1Kwkc
 jjwNa/A5ZIpzFiJ9toE8WdgWUBV+I5Is0wDVMblKIICnaLx87mm/ODYy20Q3Gjj+jWGR
 H+JdEmt4cPYPYYuGR4qTtG1GCe+gNZ7JUZnbTFAkzjVyWiWLcmQBdZDlvCp4Yt7/xyjw
 lFAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UIgymoRU4YFXajvhhly2n+eWZwY470/L6WpkSTscJdk=;
 fh=H/pFTetJxgvl5smPC+CG4DCKjCDD/kBZHQnVZcCd5cU=;
 b=HY0sarurm2VmIhlHCMMn39xWIEgvYs0VZnOTVdQevX+YabFIGLl99n9V9oK+33nN0e
 s2g3BD7s4bOpewGkJuM64tll+IFBOq57JcJ6jEr7VxBoQr8JVEjt0eqcU6w4xFwqyQr1
 s/lL0CQ5LeaNEfbcT7/8UA5BusRYThhjY6kf/dEMfsY8r93YfiTTyQAfYe6+yAAgVSyH
 OZPT1Sfpp8j17cNfoP7zYEyQsP1wNgF7b6GvjXsXR9p6XFlgUKkJ4nIj/MnrXp0g3ZTe
 4nN1k5Wanl1AFODqbTRa0jZ6p6V7UnettR1SVkhOHtkq2R7pNi55a/j8XiTFPffSD976
 xF2g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776536107; x=1777140907; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UIgymoRU4YFXajvhhly2n+eWZwY470/L6WpkSTscJdk=;
 b=KZzhrH2+CHiccb5vkgO+3eDD577aal7eIlqzFJN4PRMRYx6YmchNL28P7jmi73k2ew
 L1MRWqi5OAtmMHi3s6GEmHHANB+/lLkZhZqOh5OUhVSbD6kSLsvDExwrtTJd4oal/ml1
 94g7PfZbxtW1EjMcciP3HmgfXGZK2K827OuVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776536107; x=1777140907;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UIgymoRU4YFXajvhhly2n+eWZwY470/L6WpkSTscJdk=;
 b=nU8/31JyQ+cJRRRE3OEif+gnU0cnxQLuFQA9pBB9Bxjpi4uk2pBS0zQodPT2mm7PaQ
 cm2QjwZHAYhLe1FoUn3NNxdsCnhUD7KpEo3HHDJZeUq85MNG4nASreNxQ8iO5ulavn8Y
 sEnkG4HSI0h1Ykix7X8JW1hVZBQQjOw+AlAR/UiAGBHH3n/bz4o1z1E/kV5lGJAO5qTT
 kTVoke+iKLeg+3SHcVFMgXybcLRHlGY6Y5vD0PtK0QRS5eMPB3KmMzZkWuPNRDahcv82
 3I8MXobR1XtdXMgJfDGJ9kKrNTmlBdKfcPhYbqj3pyvXTFvl8KWpGXq8MawWDvXczXG1
 nQ8Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+QmibcG8UPCHCfiMrF041WG0raq8T2C2OXvnOIoe2GZ7jS0tiS0UC4xYw3ZmcL9q9FjCW9Msc=@lists.denx.de
X-Gm-Message-State: AOJu0Yxz7mB52vJQFl9Mf3BM4vsmGOd/qmM1Xd29tk6+ABPBFwoLUdJt
 TfqI6D2dMG60Z61eq2fvzNejHcLIByh2wwSysfo00orNE1tXlAApQ2TuFWke39IHBl34SncoPrc
 h5X2iXdd0XOgC6X43a6Et6B3pf65WFRBKLxEwPqBeo8yyuL+4P4j67Q==
X-Gm-Gg: AeBDieuqpBdJBxNSiIzTXIOSWYRu5CSqIjOoU9s+3UrSzW6mLrVZ60eRM+Th9aq/k9C
 oWsTK42BDD84jolbe3k76YCQXHimyuhqFmRJWjKYBtYpkm1JNm8wB3lVhLmb1w1iW6p/k97PJn9
 Ez4uVmpQ6qJDXe/c5zR1BJg3p25lODTPHyfH2LI0/6oarER0SykmtR98x04J3NRKFGH/WyLdffG
 E3uG2cyd2WVBhYppc6HdTMNqimcZWekN7RprP08xbEDFPgN3oj1XHqCyQDwN1vJI2AH7AGbtZji
 VvNz0GvIC9FHYysihRdt
X-Received: by 2002:a17:907:6e89:b0:b94:cfd:f37b with SMTP id
 a640c23a62f3a-ba41b1de83amr363845066b.45.1776536107331; Sat, 18 Apr 2026
 11:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260414131558.538656-3-yan.wang@softathome.com>
 <20260417083050.499955-1-yan.wang@softathome.com>
 <20260417083050.499955-2-yan.wang@softathome.com>
In-Reply-To: <20260417083050.499955-2-yan.wang@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 19 Apr 2026 06:14:54 +1200
X-Gm-Features: AQROBzD6q-hQWVkq53JAD_VpXBzmhjjbK1Jx2FgbcD6e-olWkKYkwisMh4AJF7I
Message-ID: <CAFLszTgErg-LMnnNxGfDqUHT3eR1K_6kSOKicfvH_7AW6x+ekQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] binman: Generate preload header and sign data only
 once
To: yan.wang@softathome.com
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com, 
 paul.henrys_ext@softathome.com, u-boot@lists.denx.de
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

On 2026-04-17T08:30:47, Yan WANG <yan.wang@softathome.com> wrote:
> binman: Generate preload header and sign data only once
>
> To optimize preload generation, generate the header and signatures only
> after all data has been collected in ProcessContentsUpdate(). This
> avoids signing the data multiple times.
>
> Since header_size is known upfront (from __init__), create a placeholder
> in ObtainContents() to avoid an extra packing pass when
> ProcessContentsUpdate() detects a size change.
>
> This reduces unnecessary repacking and signing operations.
>
> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
>
> tools/binman/etype/pre_load.py | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
