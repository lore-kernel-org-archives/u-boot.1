Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C81B0CD4F39
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 05:29:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23C0F80F0E;
	Thu, 14 May 2026 07:29:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pcc.me.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=pcc-me-uk.20251104.gappssmtp.com header.i=@pcc-me-uk.20251104.gappssmtp.com header.b="nhiNzq9U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BC97846A1; Thu, 14 May 2026 05:08:26 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35C3B84676
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 05:08:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=pcc.me.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peter@pcc.me.uk
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-bb91b426e40so1240849366b.0
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 20:08:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778728103; cv=none;
 d=google.com; s=arc-20240605;
 b=SEnGjcinwNr0KkZRjsW0Y+gyyZ4RzB/6eEU2xLEYkjVuvDCn1ZgqT9B1VPS+Uxq4QR
 tr3kgGSf0gGh/LekKhz/GzsrjyqEKLPR+hL/5zk40AxlL9ssB/UCElvYAxI05y153X+Q
 b86SxWcZ+U2xCJf1wHQWvpA3Wdy9niF14ceH+ZKwG0scuA12zbEoUBqkHBiFrjNXZEPn
 juGBuSY6urEwRYSCYINt6szBZnmb8MyDFk+iZ0j8tm6pFnJqvbrNBttUI4gdd3bX9vQW
 7KuB5JSmSbmmQ9v99UpZKIoAUPh+uvb80Ot5xt2KKxQQ2KzwZyEAvka8stcQj/C899fI
 gfgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RzMq50jG9EohevL3dcC/38N3pOF9yFCDogj3W59pcnU=;
 fh=0p6nxrs3QuCfZ3jy9Rl6S5Wmb2+JkZT2yTVTCCcSO3Q=;
 b=ZygboS9fq9WRvJC+48Fd44TiYPE2Y2L8GHauHv+4RXJqv4vHMR7Za95/KgqRaSTrsJ
 HNSor6oQfbUtofAOJWEieBW3UzwcHrgXi2QV2JdFYHT6LSrg1vTqCDqL7o0nbmZ43TbX
 6pGqQcsYkaeiCsAxivpN3EQxdaJ4hHRHqldwmDDC1kHlQOI/ks9pfssl/WlO8bgKHarA
 FIW6NDjO1EjYSL2BnJ5h44mPKRagJNgyAY9z1nMS2i9dlH+ryEO4qRDxhW/boagaSxXH
 PWwX3OPM/b2Mru2SR/b8D6m9CguVmQqPuUBbz1vM3iT17xjooMcdYPal6eBoHwcF26cz
 iUqQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=pcc-me-uk.20251104.gappssmtp.com; s=20251104; t=1778728103; x=1779332903;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RzMq50jG9EohevL3dcC/38N3pOF9yFCDogj3W59pcnU=;
 b=nhiNzq9Ulphvk1/+1R+2IxeQZCBuLdN/+gqb8dujaBxYt6jaBgxnyds4S9aZFY+Z3a
 w2CvtxkCDa59bcDkOff6ZCoCPxTIVm/9VnGB1DJtymwn5rYXoKxXtnkgjxG5mV5STZOF
 BUnyy17/MmM1pGPT+fHXuIrHCIoqs14Gnb34eNjhQWrUn+gkQLWNZrSIeM8oimfSKscI
 WHcKX9t/CN6UwBWdCf631sfFEbyb/syIjqc3UpsE+rCCwkmOsuLQ+uRMr3OZbFCOY6tw
 SJC+6OvKcxEMKoiyzrAGCr+8SZ8bSBRAqnFAp0tW+MaI4Ush/yyh9xwi+Vn0SZHU+Vi5
 zQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778728103; x=1779332903;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RzMq50jG9EohevL3dcC/38N3pOF9yFCDogj3W59pcnU=;
 b=G34xG4eiDMcHvC26GpjzwiG0/h4w9WHAiA2RlJMe9M5MmHbBOXaF2vdxfrVUmOrkV/
 HhLE4+G57fG+B9YqhmXTMHoCu1d/mnvcLCzBu3uOCl2zAoxpzlNZOqwnohXNXCUkeVml
 UA2iPSTTmWGDoWWPSOVNb/tJ4j0t0guqgCxiZAUbM2zOubQ/bhdpDxQOofLgCAR32MOx
 ER7M9D92e/5anJMjjKG9HZH6wmoDzQyVUvy9pntJQ9Ad69Ve1uONv7AeQ8JqCx/0ckwK
 AG8xhbab6KV9sk9UXmTWjUllGqkuuDhpMA4Zpp0tR73FblOC9pePWE7qfuepnOzZ3Mdy
 8oqQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8TzKnKE7D4aKYAr0eFmMNg9280aLHxRfX4+T8/bt/mJRRZogb4zY2nHyLcWJ4KVzhjwCpkbto=@lists.denx.de
X-Gm-Message-State: AOJu0YzX095ju+Vj57hHGGS7tvo6Xq8xp4Z44GkHFKu1m4eqi//tz+ZU
 LJS9lmZ8mQuxmCWsgXfN2qGIlBy8ZH64RzujVT/qsNQ1CWdiHRVmWMjAAz2fyajFQgVzYfjZFIJ
 WlFnxu9e7/T/YOdAgfeBttwGGdjGs6cX61Re8JOZBWQ==
X-Gm-Gg: Acq92OErfVQ6ylH9PTN1TqNfFtjxdYZ1my9m+8a/KwKdfVmUV+961O0TBoAVgTKxyVa
 SAhDu+Exi2vm4jD6SlbrhdqfE4WJyMPaqNyAoutmV3i0Z25JkWPSjLn7f3n/T4diKQqtSRXzHa+
 XjBn6kuK+0HtgZ70z/0fkyVbR0PMM3oHTAlH9VymUotfiqbcv0RroUg5TEquQnjCUgoEgC5X/uC
 RRZqB3nVg8ELk+GwhxxgUybDS5SvPKRb2EMKWq9SxPtkxvfxkDudQsrgGqkqoUaPg9R/+mr4ffn
 rxFONznj
X-Received: by 2002:a17:907:d0e:b0:bc3:80a5:5277 with SMTP id
 a640c23a62f3a-bd3e38a973fmr325629466b.45.1778728103368; Wed, 13 May 2026
 20:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260512055008.9357-1-peter@pcc.me.uk>
 <96868c0e-277e-ff6b-8cab-985ec0b91dcb@nabladev.com>
In-Reply-To: <96868c0e-277e-ff6b-8cab-985ec0b91dcb@nabladev.com>
From: Peter Collingbourne <peter@pcc.me.uk>
Date: Wed, 13 May 2026 20:08:10 -0700
X-Gm-Features: AVHnY4INQoNp9Zal1917lwUwP0h1RDQTq20opgWe9i_1TS2az17exTCn5GTiUZk
Message-ID: <CAPQLkRjnCS0mHDn+mn22dMwQKGmDDQgDG9PGpN4u5YH+JA3kYg@mail.gmail.com>
Subject: Re: [PATCH] fs: ubifs: remove dead code
To: Heiko Schocher <hs@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Yao Zi <me@ziyao.cc>, 
 u-boot@lists.denx.de, Kyungmin Park <kmpark@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 14 May 2026 07:29:43 +0200
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

Hi Heiko,

On Wed, May 13, 2026 at 7:50=E2=80=AFPM Heiko Schocher <hs@nabladev.com> wr=
ote:
>
> Hello Peter,
>
> On 12.05.26 07:50, Peter Collingbourne wrote:
> > This code is dead because it appears after an infinite loop; remove it.
> >
> > Fixes: 4c4477c77008 ("fs: ubifs: fix bugs involving symlinks in ubifs_f=
indfile")
>
> Wrong commit ID? I find in current HEAD:
> """
> commit d5888d509cc43942ec98d993f2d129f5c8ddc432
> Author: Peter Collingbourne <peter@pcc.me.uk>
> Date:   Tue May 5 03:38:16 2026 -0700
>
>      fs: ubifs: fix bugs involving symlinks in ubifs_findfile
> """

Yeah, I see the same. Looks like I accidentally used my original
commit ID instead of the one that was pushed.

> > Signed-off-by: Peter Collingbourne <peter@pcc.me.uk>
> > ---
> >   fs/ubifs/ubifs.c | 3 ---
> >   1 file changed, 3 deletions(-)
> >
> > diff --git a/fs/ubifs/ubifs.c b/fs/ubifs/ubifs.c
> > index aafbd01a028..3f2e2037745 100644
> > --- a/fs/ubifs/ubifs.c
> > +++ b/fs/ubifs/ubifs.c
> > @@ -608,9 +608,6 @@ static unsigned long ubifs_findfile(struct super_bl=
ock *sb, char *filename)
> >               root_inum =3D inum;
> >               name =3D next;
> >       }
> > -
> > -     kfree(buf);
> > -     return 0;
>
> May we need to stay with "return 0;" at the end of the function, as
> some source code checking tool will claim if there is none?

I'd probably remove it unless some tool complains. If there's code at
the end it can mislead readers into thinking it's reachable, which is
how I ended up adding the kfree() there in the first place.

> Beside of the nitpick:
>
> Reviewed-by: Heiko Schocher <hs@nabladev.com>
>
> If you find time to send a v2 with updated commit ID I would be happy,
> else I can fix it when picking up the patch, if okay for you.

Feel free to fix it up, thanks.

Peter
