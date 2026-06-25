Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E1D5CDE001
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 14:29:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4EBC847C8;
	Thu, 25 Jun 2026 16:29:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IQmZDBVT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48D328494B; Thu, 25 Jun 2026 16:29:21 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4676984704
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 16:29:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c07a6520cafso431753866b.0
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 07:29:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782397759; cv=none;
 d=google.com; s=arc-20260327;
 b=BLmfytXdD6v+WR/8cv8dSGtbtg7XjRROr3KtJ/Bp444VH0mfEq2w7LELpFhOnHDj6e
 52iW+lxe3aOJaelgIEgKyTddC06RYKTPpq7q+diD2goysVW8dC7aSmisQJAbkrcALrkX
 Mbbs5NEU4PZvgM58yaHltu4EKPflqr0vOZ7/hkV0ms4dQih+l9P7RhEv8DwLzb3HhEZa
 zJiHL7vmUsYLIXcv5AJBJZyLJbBKUa5VoTyF1sQFu8NiejOoKG844k+zmAA7uK0XStT/
 +7KGnaLQ9MaImhPA4espJhqZdHKHk1hmNNWacMfKJWteCP0dRg2NY6BKVYwJYDKaJVsW
 +Ceg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=g/QYF/4T44dqwTdyWTTKK+oZ0PQf1C7k4zmnaAfUdJo=;
 fh=SJzU0vqhCd6XZ12LivayWWnEo0s7vlwiBzlNcKhQZ8Y=;
 b=hweSpxbLTw0o3DYFGogN3yxFC7sF7Fjdr8nIYGkQ/cV0fCqL6df/O09Tln8jyhmoA9
 zRKynNEJgHzVH3Mmqss8bbun+BuP16hm2hvkznqTSPTyKyc5QFywdn6ZeKJ9UPh7YmFw
 muJkGXWx5Z2UOkXdFuYCGuQaxhK61jXGG/0R7ICGr1hz4k2PzgofNOQHWPl6bELsgN9i
 likuHxbHfkoDVzYqDs2qvZ356e5oDMdd2ENkSfaTSklmrUnvsM/U1kzFqAIJmwr4VZxu
 EmieIkSVYBzFgcIIfYK4U7BebU4PmKaZDHSCGChzlHenb+oAmVsYQYBSoR13dl+woZnR
 bXTQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782397759; x=1783002559; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=g/QYF/4T44dqwTdyWTTKK+oZ0PQf1C7k4zmnaAfUdJo=;
 b=IQmZDBVTNT4kR0rmE+lIfKt+E1h3xr0lqONP+LQtII3cAyZJHog1g8C+7avnyDC4GN
 8T4/xP11pL74rfW3m6RLECi1QGaQpTetHYO/Ifi9y/9qGAxaUOLLF4IC7v7hs6IZT5+y
 BLMw6Wa+3seVPcPfaqrmXVSqFL878WEd4B2Qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782397759; x=1783002559;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g/QYF/4T44dqwTdyWTTKK+oZ0PQf1C7k4zmnaAfUdJo=;
 b=Eqk4chqMWAfdbaLPtNEN+G39P96IZ2fa92BqyyZhgBIBwcbSnfliNTFfXMyjBliYFr
 0Q/W5hmURvLykM2KGaIQ9LdTcefn3M/BD/BUhH5wRyQ+yzgaBOf8R3n+lMB7I5d01wYE
 lEuE31m3xwgR9GuZlpIRDLqMMSruLxUF/+cOvywc4QI1mC3ZpnCqxJo2VENVMla1ZAXt
 6BbGQ+wvxiHhuV5CjdM3bDf/Gvh1QfOlKjnJxrrlbK+syc5wO5HVu85nQvM5KhK7Lrn0
 Sj50DEU9mDBItORfDhwknHIvdaKNo+I1C6u6/h2lc5IpUeRVw/zJqzpjX+bdujXLXwRJ
 thCQ==
X-Gm-Message-State: AOJu0YzMqtNCOpnxu1/nrD25yvEspAVVhy7fHrLNiQd7eboyNf8Zg/0f
 hAQPgoIC58eWx13L5YhCkcsKjMY7CZu4P+vzovl++BfgDSe24YASnlOTcx3fGgepYK02t+b6oME
 KuVVorQ9al5aakvXr60nPy4CBFpHH8GERQKpXWq7M
X-Gm-Gg: AfdE7cm4uManUp9LWHUlKry0MV/86PGQs92bLkB7BB9DE+c1f26S6+UcCqLiJsTm5Uz
 lvU62xwukp3AqyWbGEhnLj728iO0yynjsMtHxSNBiN4gf6BPmsKUawZBAd3IUfkBoJSKEO/0YCz
 7ImdSGdqvyimMRznkcazvPubvXOYVbzQPUtDpsMQwuclgCoq8aMoH4fqfQCxGHqatr5UZ/NyTiK
 dNYYHg+R8LTsXD4HshIYJyncfqNs7ewo8x760T/FVuqkiDi6iogNloaU2C3+NIwh43gnpmsIA==
X-Received: by 2002:a17:907:980f:b0:c10:fd1:4fd with SMTP id
 a640c23a62f3a-c1205dafad1mr261190066b.2.1782397758695; Thu, 25 Jun 2026
 07:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260622111933.1488593-1-nora.schiffer@ew.tq-group.com>
 <20260622111933.1488593-3-nora.schiffer@ew.tq-group.com>
In-Reply-To: <20260622111933.1488593-3-nora.schiffer@ew.tq-group.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jun 2026 15:29:05 +0100
X-Gm-Features: AVVi8CdXOl5iXVib4egInj9RzwkIGg5IJ_ezfBTZnhkchBNDzYcPz_IsJK09wjE
Message-ID: <CAFLszTii-g=ipzxoSL5OrK_V+gvDT_K4tHfdgtLUb6KoSRHySg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] bootm: allow omitting entry point for
 IH_TYPE_KERNEL_NOLOAD
To: nora.schiffer@ew.tq-group.com
Cc: u-boot@lists.denx.de, u-boot@ew.tq-group.com, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Aristo Chen <aristo.chen@canonical.com>
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

On 2026-06-22T11:19:32, Nora Schiffer <nora.schiffer@ew.tq-group.com> wrote:
> bootm: allow omitting entry point for IH_TYPE_KERNEL_NOLOAD
>
> For IH_TYPE_KERNEL_NOLOAD, the entry point is given relative to the
> image start, making 0 a valid default, and for IH_OS_EFI, it is ignored
> altogether, so it may be preferable to omit it.
>
> Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
>
> boot/bootm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
