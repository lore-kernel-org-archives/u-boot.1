Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A3CEA71BB
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 04:15:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E937483B99;
	Mon, 20 Apr 2026 06:15:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z8O2yeR2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 287F883BC8; Mon, 20 Apr 2026 06:15:14 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3296080433
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 06:15:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b9382e59c0eso409772266b.0
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 21:15:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776658511; cv=none;
 d=google.com; s=arc-20240605;
 b=jtXY8EWeu6anqrP0BKn/qvzFfzUFRJb+DmaRTeXq31c3yHu1eH8ILaGAPoHfxbsoRD
 2f7PXvIuGVZUX1aiYCcPJ/akB+Jt/OITBUc7dc6Ccd8hmoKr2ew0NwDEBLGeq0A7Mz4L
 LgazM/fMcZEoYASG0PFygOkZr4eHvGywQEcQRMBZs+rGLZW+96msjyaHJO8rtDS0BnEo
 BkwpEi/PveCF0Ovftc4s4UvXI1IkIUajZ1Zd1FaPg5ZQnX72LPAW10w7mUPA0cr+5nyB
 KChbRiXCytczMOm/xdZaceiafwx/ySOxis7LqckHg+uo+/adKsUe/UpchVqcJRMRB88P
 EmlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Pe5QP1dSzscYwnWxuRzzJ5ZZQA1T1MkaoxUiQR4kxB4=;
 fh=k4fXn4kwROCCtveCNjc56oJSyLnO9t1n/jBV1Bns8dU=;
 b=fS2h0Iv/DA/kelwhpKXH0J8p/k1l4NfY9or3f+ZmH/F1y72PkyD8JR28d06/UkIjvk
 KvYeRsarR7QvDF5TGgNBpiQx+7OVmGVRGeYTHng9RJdsYjCGW6nTN0VBhNV8rkADjk+K
 QVtSSJqrZiVNRkn/uJXlhoLlDIZrqkXzH0JpWGCYwugllHsWkF6OXcAJXCyuWj3pNdVn
 yKGxysVEBS1thX+E9miy038deamvqg9JruSvWGn+wOLNg3ZtAgH9+1uNo25WN1dj2P+h
 3azc+QnhD21jnKwLDn27sI7Qeu/C9+23ppfTiAU2EBNuRBF6o+v6d4whvMFGmqdsUXvX
 5WVA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776658511; x=1777263311; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Pe5QP1dSzscYwnWxuRzzJ5ZZQA1T1MkaoxUiQR4kxB4=;
 b=Z8O2yeR2B3krRrPnsvyJj/tu42LGf2bmEu6ZzGH1l2vKNeY1Er/VxaomHK12SHdI3Y
 7xzE7WC4Kz5LSdxJ5/ypgXXmj7LfvfI9esDOq6HoneY89HbYFozeHy34mMV6JUKQYalS
 xeLtSBkbiBVMHi5Z0Qv125GRMt12BD8m2cuiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776658511; x=1777263311;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pe5QP1dSzscYwnWxuRzzJ5ZZQA1T1MkaoxUiQR4kxB4=;
 b=buZGRQeFsXr8LK/LGYiZkK7fyDxSQBzuuOQQxjeSYDK+GUbtYnijh6cIgDMt14s4gX
 y22hKJ/ic/EauwNH72F+7/kucAXRGeUGXVvXoUCzkx1tiATPTKq4mTBYdZe5YmibWQob
 sbqT1yjDdPzJzBkuHNDRv/mb3abN0FFPSNbO4bMtzR+Nk6HqiS0MDDTSg8EbeipiLO3P
 b6tKkcaVEulE7Mbk+3bBJ1KS8t92wBA34gtf9ycf5dKcOtNBpysMilRSPYKZuFR9Trg2
 z0y6VpIHiNITvwpyxgLYe1BnTgpCCOhbbGT1dJCGwRTTZiIwV+dEJSiO/xJ89VVA2+CT
 vg0A==
X-Gm-Message-State: AOJu0YwafuhnBjfN5QwVnbPnkmcsqUflOvPRfaugA7HdLJ1AOhc98h+N
 aPDRYIxjYT3g6mKgjWTaN3HQqRiuNBTm62bFAuwIydSmVTsWMm8VGGxpRDZhmQb58DCQt5XqPfr
 UgI0daTxoBAepBSsx5gqYH8foSrIGxTZhg7vftgRL
X-Gm-Gg: AeBDietiO3KVVQbvCbxl3wQQaZ7UyTDUJRnq0IJEr4K7QOUcyQBC4+CmkLAuQhhVEhi
 40CBeUOZGCJwGV0Yo9H9fl8cK5ZWCB/+soWhQljyUsGq6NaVN4XVO4hx1pvz5BnTOvT0X/7ZtrE
 vQWsXklC6EqvQIJ7xG7EXLdFl4YNGC90tow+nu5ckuEiieSlffyMfF1uhH1WSSpqI3CT7eR9Xrl
 ywdX8LDobN5oSgKS6sy4YjE6HSJvRUJMieGMLo9ayBJAm6e5Wztht1ugfol9Lc8U6/zUb4EkfvD
 NDXM5Uig1UQ0PZ08rf6T
X-Received: by 2002:a17:907:6188:b0:b9d:2fce:308b with SMTP id
 a640c23a62f3a-ba41afe9d42mr363899166b.30.1776658511407; Sun, 19 Apr 2026
 21:15:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260420012348.400492-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260420012348.400492-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 16:14:58 +1200
X-Gm-Features: AQROBzC-uBYuNEFv-QJqFvNwRSZ-jMsYh547ex2E-tbTeBKnyliWbj1G8lUIox8
Message-ID: <CAFLszTg+nfKGCaHGz6-GHoQ+KntLYYdUTZqfYGpBdsvLSW9FZQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Respect CONFIG_SYS_DTC_PAD_BYTES after fdtgrep
To: marek.vasut+renesas@mailbox.org
Cc: u-boot@lists.denx.de, Adriano Cordova <adrianox@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Tom Rini <trini@konsulko.com>
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

On 2026-04-20T01:23:26, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> kbuild: Respect CONFIG_SYS_DTC_PAD_BYTES after fdtgrep
>
> The fdtgrep command will reduce the DT to minimum size, thus eliminating
> the extra padding configured via CONFIG_SYS_DTC_PAD_BYTES. Reinstate the
> extra padding by running the output DTB from fdtgrep through DTC with the
> -p CONFIG_SYS_DTC_PAD_BYTES flag again in case CONFIG_SYS_DTC_PAD_BYTES
> is not zero.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
> scripts/Makefile.lib | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
