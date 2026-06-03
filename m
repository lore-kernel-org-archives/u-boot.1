Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C6DCD6E55
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 17:05:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25049844CF;
	Wed,  3 Jun 2026 19:05:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HgXJIfjZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A62D84895; Wed,  3 Jun 2026 19:05:27 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69A7183FF5
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 19:05:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c857d04cc99so403651a12.0
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 10:05:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780506324; cv=none;
 d=google.com; s=arc-20240605;
 b=gP2f09ke6cl+AHDG07CW4wJWxFf+LPyKWfwd9ZcTV2vgN4X5YFuuXAbjxE24U3peeq
 leqoTau+BEhYMLYA6XBT60WPkoGRbYeoGHzU2vT59xg5Df9SpWzM15bjE/ZTEOyj39hy
 A8zpBh8pZeHNH595vdnP+5HPtzFB5YdBwfzgjCOu3OcX9ePPm1Vpzc7Ud0socCS/S+f0
 UPfBgYTpQ7R0JQtGqyNbflJozy1RfuC93hcGrlYcG4Whde+X04RRgddwmiLtKXX+bzqW
 FhybtdnWfpVYt1MKNsuEaqHGBEaY6inLckdGnn1nRq7md4ousn9f4iq0t3Bgo5ZZw0dl
 ERoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=w+ulaCmeUx1RzPn9OML01v44H1wu7dNw70PrKaEoWQw=;
 fh=DYMU3dRED0rmVKTDqXRHxrZw93vonVJHh6vC8tHyRiY=;
 b=PbGrsVD/SIhpDkWlIRAL1T17FTkFLb3GhtlgdStL6ix2XNqCArRLWOc9vNybfzsMRz
 RmAaVZXe/p5JSeKpUj6IFk+k8Dn+XD0JhadYcOJLz48Zk+JPNjCIwe3T/9qyUe5w0Aey
 JQ+Dae5RXlM9BWRnuv2pEfHVAoO7qVlktR5NuLi1XEWKTMIksT1wvLV8yfIE49f/uHJf
 /tTTQaBJlRS8BYYrooaECIxwYl4Rd5TMrPU09Gvdk02YG0IBxrVroQf/eD4vMHzouGx5
 ZNb9QtmrxyKetbl+2O6rTxm2BSsg8dx6wor51P4HD0qBZNCtTIXIGgva9b1OM0fIKGNZ
 H1sA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780506324; x=1781111124; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w+ulaCmeUx1RzPn9OML01v44H1wu7dNw70PrKaEoWQw=;
 b=HgXJIfjZmo4kIG2NQk5aBhqT591Q/fTeSOtQb4JjF3erwWZ9ag0aVb8a5sC3W7EQoV
 DQCka78uCeaE6frJx2ClmodScahC7hEWq2wWZ7h5oie2owR0O214x6afJ25GEWGsQevG
 VdqAVOLBjb9aqQNI3Vq5gj5tQDPJ7MYJgvOBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780506324; x=1781111124;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w+ulaCmeUx1RzPn9OML01v44H1wu7dNw70PrKaEoWQw=;
 b=MfSqe6GodAGNOeTi6YRs0NBgWgGyVeBpNART9tSptdl84z0hHP5L/hYrYkWC1jTmCn
 4dj0xYqVEL9gdmnc7q4ik6eW1uPApbpHbUvhPz5cpZNj3IVErQdd2qk1/U6dTK3cMk4e
 yyoSp5jqNsO8DvbIGP35vRESzJjVYfprHcCbN6SYOf14uS0DsS96o3EYS1Gs0ZFJc5me
 BHeMhFsytUc66ELakPZw3SXTl3SNtJudv/V/Iy9k+sqWsKHTPW1GYz5g15qdtVzoB53N
 xdKZ8CTfMifK8Q+efWYyksNLiMpHsHzrR8y7e86iDtP3F7VEzNchIJLyKgPfz6kjyuH8
 08DA==
X-Gm-Message-State: AOJu0YwJ3R7q9upd3Kf1tnNAVzdkB6/FSDOrbZFX0c3cJFHXOhOqEXh2
 pFh+K9ZLeOVcNGz7uJapPTDFWX6vw7xxUTmUyo+NCYxUe1jcylu0fgtsWt5A5lW0oAZeznxOIzn
 SxDLSC/S3WotGAkqDFYFu01n+R8myiGUDNgPzPVLj
X-Gm-Gg: Acq92OFwPrVbp6TVjgHOUBY0JWmzHlVLB0esXdLmbvT/dnaorgc2h6FNVXQaNWrcYDS
 d0A1EMpo5/7yBztkzkefPbIG1//4HcKWzUvIgtweKFw/z/O2N3KPMuYBmffdIgx7Vf0TryxJFtm
 wcLLhb1iMMQpmM/uCCP7u15A5UMaMldQ+Bo8xI30QQVYZXkrIZtmfmC0yeK5NUBZnvgA7N7ATwU
 06owXhAMrFLJQYC5pIb7N+F8aCnX1x1tmKuaY/yvLky0fdPq0Zm/KqkWz+9a+mGWjTEEIO6jB/7
 X0eN2OdXSf8afL7U
X-Received: by 2002:a05:6300:2284:b0:3b3:9f77:2e45 with SMTP id
 adf61e73a8af0-3b4b1dce93dmr234993637.1.1780506323974; Wed, 03 Jun 2026
 10:05:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260603070743.1268544-1-dmukhin@ford.com>
 <20260603070743.1268544-4-dmukhin@ford.com>
In-Reply-To: <20260603070743.1268544-4-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 3 Jun 2026 11:04:47 -0600
X-Gm-Features: AVHnY4Looi3s1X4XB_etACcQpOFXM58jaTvnN6Coyv1Iog0na0dbqM703BFKeIo
Message-ID: <CAFLszTjdA=URxc1M11capjkJNRiPLcaVd+OW4BOxfht5urzDrA@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] reset: Print reset type on diagnostic console
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com
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

On 2026-06-03T07:07:36, None <dmukhin@ford.com> wrote:
> reset: Print reset type on diagnostic console
>
> Add a diagnostic console trace indicating the reset type.
>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> drivers/sysreset/sysreset-uclass.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
