Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3323FF8873
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 14:09:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5609284894;
	Wed, 29 Apr 2026 16:09:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EAJftRDh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 911DD8488F; Wed, 29 Apr 2026 16:09:53 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46FF28489C
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:09:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-66e8cf72a93so15804872a12.0
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 07:09:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777471791; cv=none;
 d=google.com; s=arc-20240605;
 b=V9jDeFjELGXAGsZe1mwjvj2Tqxs5OJcY5chosVHXBwpveFBFOgzNSZepm+g2hzn7ai
 uBJA/7h9vB2heLgIPXl6Nb0AEdRQ7fagmnwPGLqrQD+a4eIxxbgJddK/Bxd6T8jJ51oH
 JJmnmkD2S4Iuj7Z/nNsg5C+mt1DRIKNF7PkaxCDLJSuVOKK08Nl4RkZaakQe/+dsHFmD
 xwGeCUPC0pK85kho8r/71ImPoRj0Z7yjEoqbHkLNGkGtqvgzNmo+tBCg8uQbt4XqhrcU
 uWKiHh6XWoUVUTDQvelyWYbE2gwulSikz5Bv3QMOX8ObskdweAQLG4xOk5fthZGXNn/t
 Uryw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IxcdklNwQRNH63ztKNrZ758sMfz7RMn5R/r8ik27Uuk=;
 fh=OF00omt3W5XkTWoy8yz+VALjHs5aNJpNm30/GdQrL1I=;
 b=PQWRFQRC9qjJnN43vcbYzAuiHseGAdvTJ/9VyFncAa+iHxAwekundNYWuD4D1UPOTW
 Ip+L0NsFfFigEe20fO9PpeJfmZbzDhvIbNJbnFRd0+trPCqm79XLq5ouKZ7oR8fH7xBn
 07pzo4xFDbZ70iBcyzFgS7pOFofpZtgJ3Wtqgciiad0YjtePAfMBdiUNub3/WHO3GpBP
 e8hezW9HklY4snW5C/Y3MZqxwGCkfuHc6fNBxOSiyyzqYrzOFImnjaeeg74J90edr2g3
 1yiuDC6K2aYfrt5rggBGTJZHV7iDeHJy/blDCv/wJ9QJSuBIqVc6pIP8WWUfGRx/VZzd
 6C5Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777471791; x=1778076591; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IxcdklNwQRNH63ztKNrZ758sMfz7RMn5R/r8ik27Uuk=;
 b=EAJftRDh1OK/VUhz0lSTCmIvI2MkSUEDITBYhQcyVEPQFjkiO2hNExkQYs7ac7W1Bz
 sXcNJvis5l4bxPEUigxAshqo8TzY7awGlS2b+0rtyr1pr8U6e4l/lJiO+oZ8dK0ZlsGc
 +2CznhWbpei0qzd1BzngJqk1iBl2ayeNrGxnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777471791; x=1778076591;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IxcdklNwQRNH63ztKNrZ758sMfz7RMn5R/r8ik27Uuk=;
 b=h/z1bgt2xzSHWGwSFnWgRkeiRb0Frxb16YSOfO1w9N++kDc+iE5j+2fk9iVqtcMyvO
 W6hS35c3jrwPNo1qn57gQj9sX/2ulUBGYf6LtO3pugC0DfrLVfNB89u3S/Jt2tCdOdA2
 dPQIf90pQGKZPAgnwAyhTkn1b1qBgOcelI20J7KBSs9I5unqDqUwMubDsy2GQpN6sv5I
 fDdEnFX+j3KSzIRWcjePVE6X9Wz0lWovl+7XDw6ms+dyWuCdYTg+EIbOtshls1QW7j//
 fs40mIb4+stuH9Fnf744rbhqN/DMpoWEI2FfEDhzzz2RBZCtPhTJLIwx4qvykipA6k/u
 hsAQ==
X-Gm-Message-State: AOJu0YxlFpNGfnbGC2YlDcY6DL+XEAWu/V80X/Cn3NQJBeRVtKEeWbve
 g0CES59wvuc5FYYvxqAxMoiyNXShQ/YltYGKmJN3yrEgdE4z2meOJfJiMrsBC6bQkjS8h85ZGwT
 qa8C2j+1s4kAVpR2BGf2oE1k+7pxgdXPx1scxZ+Ja
X-Gm-Gg: AeBDievKXYxvNbVejJLmTkv/Et7H7G2Zs//aPefYYDd0JDkT7OMi+Nz2MC3//1X4SsN
 hB022q1oW6og5pP8cpUMvl6mHk3fW1mZr8kg89J06382ylY8G1rJK/ZRBdWDj3bEapqHgW8XGmN
 r/S+yMe/nnEW8huXZhGC3e0PnCOJAF+rUzGNah99XU/sSvhHL6iJ0+QPmVZ7TPIv4IBRLQi/TLj
 yz4bX6qWatA7IU0DEHNrt1CJRQaYLyp14sH+EMlNRkzmRNWgiFZxf86oBbZx3YUG27IZr6ZkMT+
 mcw3BZhoL3TAuYTu
X-Received: by 2002:a17:907:1b10:b0:b9c:bc70:e928 with SMTP id
 a640c23a62f3a-bb80377aa23mr479841266b.25.1777471790703; Wed, 29 Apr 2026
 07:09:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776954004.git.jcethrid@gmail.com>
 <650457e35a26c26601053a00dcb09e33cb8f151c.1776954004.git.jcethrid@gmail.com>
In-Reply-To: <650457e35a26c26601053a00dcb09e33cb8f151c.1776954004.git.jcethrid@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Apr 2026 08:09:34 -0600
X-Gm-Features: AVHnY4LXruahCl1_kISnzCUhWOFLkT-gMdfmklb-SwGQp7ysB6YFth6eeoSdMBA
Message-ID: <CAFLszTjHe0bHsEFO6kb7tobZV-waenyp1DNcdivWpm36aPAEbA@mail.gmail.com>
Subject: Re: [PATCH v5 06/15] mach-sc5xx: Remove preliminary binman support
To: jcethrid@gmail.com
Cc: u-boot@lists.denx.de, malysagreg@gmail.com, trini@konsulko.com, 
 linux@analog.com, philip@philipmolloy.com, sjg@chromium.org, 
 Caleb Ethridge <caleb.ethridge@analog.com>
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

On 2026-04-23T14:24:50, Caleb Ethridge <jcethrid@gmail.com> wrote:
> mach-sc5xx: Remove preliminary binman support
>
> Remove preliminary binman support from all sc5xx ADSP boards.
> Full support was never added because it was unused.
>
> Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
>
> arch/arm/dts/sc5xx.dtsi     | 41 -----------------------------------------
>  arch/arm/mach-sc5xx/Kconfig | 33 ---------------------------------
>  2 files changed, 74 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
