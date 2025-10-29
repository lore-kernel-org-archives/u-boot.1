Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7433ECCF9EB
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 20:13:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC9F08334F;
	Wed, 29 Oct 2025 21:12:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E3RTWaMY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87B1382E34; Wed, 29 Oct 2025 21:12:57 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 759D68352B
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 21:12:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b6d83bf1077so58873666b.3
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 13:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1761768774; x=1762373574; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PEX1O+LXaEbETEmd7ol5qU7wdqRU8xfEufhKRx7yUtk=;
 b=E3RTWaMYJIGSk6rer5uN6NJEBo6F8uBcaQAtRzlhyo9PSdJ7N9f9Ds2bvi7qpxj3pf
 NW1rHEx9ZhcZZNgtFZxiqBUeaje2S7wJAYiZqv7CyPaYIPNWwDpoOghBlbbISXn2yYI2
 hxd/jhdMpz1B7V5r263UKr7/5EFnbZmDvQ/s0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761768774; x=1762373574;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PEX1O+LXaEbETEmd7ol5qU7wdqRU8xfEufhKRx7yUtk=;
 b=M7weE8Leu5D2/lM0HztPWef9ahdVN73cPhtYdwyO8w2bWGZhni7SefOmhyL6BUnPc/
 jrgxnGcMw2pGa2zhJ7bT+UwJMBPAJqDDfzWFoiL4y7qoXkoqjZh6MjrCfd3yMwxz5Sgf
 grOEOPvW58gtpnXpD38a53NuR3TAdu39WCfJqwhYeh+DhWgAVUKoAjqyl95ufG2tXukr
 LyEJvkFGm81WZRg0T4/77MNFKwhasEOlGocwzGU3SBftPGOlCU+lp712G4iAHFTNdYOx
 KLiRauv2jc9XRuSSc+P0ldxLTQHUsfb52wlXKxbNpVyH2JPyYakulke/zicC29BELBQV
 d2+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiTHVn4KK6jrAlYKQZHDBdp42ZptJSa48H2grAq/UvRffhvxG5i3jjCK5mL4bsrpBVMQGuams=@lists.denx.de
X-Gm-Message-State: AOJu0Yxx6RoZAHPOGNDzQw8d320APvK63uWfcAL7NtHf+PY4IDJuDm6i
 7Ic0R4rla5uiAxbl8mSTJaFXlGWKwpLbMNOHX8RIaGujOXrsnsYfH1i6aXFmIhLbozWjYd1hPlm
 a9UCJBZeevM9LE3xjUSo6I5zhX+Mn6/ypx4pqnS0Y
X-Gm-Gg: ASbGncs4gFZ6xm8JXUHODqjneyuwsOuyZwQ0JPa87SfBmB3jUJCPF0V1EJ27ecU6xka
 2B4r7BQFuRrVB06bkYPr3/38vgz++xzm+nluI6cRGu+cWEJLZOZaZFIA+Ea/KPon0+Axhb2atzj
 Pgeg8EsGAcR6IoAiUgV9s8f5itnjneSPHw/9gE4KrFnDQIHKzqYpOE0uh+Phed1saxdyU0vd5pK
 CTJYQ7e5GR6nyCtYrHQo1Wu1YiI0A+S9848fXthWP3wv/Tk316E7z7F12LGo+Uy67nacQ==
X-Google-Smtp-Source: AGHT+IG4B1jsoDWx6tlzOYW4XNkWIcmebLxaqBnjRWztQIjKtVx5E54rY3X5NGleFxShMo93nWbJXNPzjcPInrzGdr4=
X-Received: by 2002:a17:907:ea8:b0:b6d:55ce:fd29 with SMTP id
 a640c23a62f3a-b703d4d6347mr372504266b.34.1761768773978; Wed, 29 Oct 2025
 13:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <20251029134833.137965-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251029134833.137965-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Oct 2025 21:12:43 +0100
X-Gm-Features: AWmQ_blpWhFzMiexosQAYl5ltgaWD0DCCN9zdLh1ViZr7cai7SwzL73ZVKQyO7s
Message-ID: <CAFLszTjWcomV0uBLwM=0y=jBXSA6cZ0i6P6jySnL9LDGXf_QuQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Dockerfile: remove Python 2.7
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Wed, 29 Oct 2025 at 14:48, Heinrich Schuchardt <
heinrich.schuchardt@canonical.com> wrote:
>
> We don't use Python 2 anywhere. Remove the package from our Docker image.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  tools/docker/Dockerfile | 1 -
>  1 file changed, 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
