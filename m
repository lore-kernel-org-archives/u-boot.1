Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE0BCD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 15:20:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CE258489C;
	Mon, 25 May 2026 17:20:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="noC12d6M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73865848B4; Mon, 25 May 2026 17:20:44 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75FED84859
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 17:20:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-bdd1986cc86so536474166b.2
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:20:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779722442; cv=none;
 d=google.com; s=arc-20240605;
 b=CYHawnydHx2ZY4RCNiA6oTPGorTj6Qsmb6DU8n8hKT6VwTOgjJ+o7EQVS+3OKqjwJW
 gPhzF5UAvZEu/xKg9vl/OjufWZDTefZQ7lQHzpmtvUeU31Ut7liF047PcfMTP2+IaNRN
 ksJ+RgLu/iU5bsaz92XOulMUKcBCW0A5FMF20Lh8ITkh8BncshCu6jBK008Lw21Lge3n
 05slUHRvvMrywcUkSyU9lIjfdBxijCGXbjF8MYpykxjl5qOQ18qovjMZY5sDRGnnM8hZ
 yWQebQn6f1fbCQTnJz1Kmp/xC4XQoQYMwb8Zggvb+VV9JMmdbuC+yp/ViuU0TMkXWb3g
 v8MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=95J1U9yLz/O/uskk6qlB4F/r+NPrhg8D/ge59T0HOqg=;
 fh=DYMU3dRED0rmVKTDqXRHxrZw93vonVJHh6vC8tHyRiY=;
 b=TgLApPoXt32+LrtqZsLCbQdFBCS+fuYUI7I0vbY5r2Htv5Q8KEiVl+CfOlD5JkHJZA
 7rATwpe/KvwQhkyYX4tZVDctGxmZqE55BXsXwPzXEcU1nA/18THkEj6h7zWUI7k70thr
 yuUVxQiRIWGUu+V7AClYSAL+Le0LqVsV70Kz7vg+oAS8s51NRaA93AwiAkhScgF8LRVQ
 MPtg4vGMqCjeSlHkaYnVxN46ZHlyt7wbBdXW0WgM+Ojfg0ITIexMsIEj5IdR5OgcaDKu
 S8MTWLc8pqkAnQutziOE+hAUFAd56XJInbT6EGQ5rXPW+Eh1maQGrMy0RIgmNk6AapfG
 6tgg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779722442; x=1780327242; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=95J1U9yLz/O/uskk6qlB4F/r+NPrhg8D/ge59T0HOqg=;
 b=noC12d6M3reut0DMJtJGxC7L5VgZ04qwzehrMAb/ItclRXia7u77inMYoomKrRd1FI
 B61qnTrLvwKL0DRrspCjmOsVox+9NLmNZnXMHGvdAjdiYe1rwBYLdnmI7+7IKAIjrL1G
 fpYeUwavxZRWzFo3PmBE0Fh47kciqhl2pkTwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779722442; x=1780327242;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=95J1U9yLz/O/uskk6qlB4F/r+NPrhg8D/ge59T0HOqg=;
 b=WTULriAH8GEzRbu8CV/hIBUR0jtPQAULoGfThDzWGYVx/mHxT9SLphi1YEobamvk87
 bELhvZzO5APiuQ+yH9voXISL5AKFkChGbg/To0fRg8wL69EfyeOTu+1gN3/DF8MY5gFT
 eHAnz9vf5NC1S0Gx45TWg6ZHIWgMcHAxxGqoG8aSm6I5yyET8tJKrhFinBvHsEj+R1Nf
 ApKGsZAsTLYf5K1eA5kAR6zgi0PvJkO3CXsOO7NqpyGRKr/Kt1ncu4hihrsrHiUF7l3A
 w9+6l4FS1iOdC+gGbR1JIjAxMcecYGAeUUzIKAW5zd4GYs7hI+SHeblCt6YoFV60h+de
 LqCA==
X-Gm-Message-State: AOJu0Yxjy3R/X2U7Nj1lsYgPOCuJ75cOnH+HYrbh+sUrrnCt/EJDzCaV
 qW686tRKANVrfniKg59Ucl1GHXLvKBk+siTKzUV+K7Y/nY3+yNWPsdHWaHINJYzao04L/qc4fiF
 jWgqjn6zXCdzWKgM5oeDZC7xpLyvIdTSr2rcx3s6X
X-Gm-Gg: Acq92OEEy19FLxbRfgRWMMUS1lGLnImFOd50EcmAP55Id+6qMcFIh/v6Lr9brK5LSWr
 AtGZhPv4IlGxcq+OK7pLyOKp6Huz9Vu6AY3v0odkV644qlFZrTOkK0DUfgg+QTRC6jyC+XczGuZ
 Bv9gS/x8xPgrg3XM/TAMdEc7QIvwJYvLHb3Bxbr/MG9epLVJOIFDhkl1h6Xwow1t6NtZw1f7zLG
 BLEBaJpeWfakQ2T+vlQcUGfogBtKbXHYujo1ZwgHYQzjSqtMTf61bNuQJ4tikHaX+11kcq3bpqw
 83mzlwZ0geZ/Ouio
X-Received: by 2002:a17:906:ef0c:b0:bc6:2bd3:8176 with SMTP id
 a640c23a62f3a-bdd279d1b58mr972008266b.35.1779722441831; Mon, 25 May 2026
 08:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260522012312.860026-1-dmukhin@ford.com>
 <20260522012312.860026-4-dmukhin@ford.com>
In-Reply-To: <20260522012312.860026-4-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 May 2026 09:20:29 -0600
X-Gm-Features: AVHnY4LozaXLmrRZBu3MDMgKc6PUZPNVHur7_p4NtFvdt9trPJrroeB82yhomsw
Message-ID: <CAFLszTg+fMxGix7bVCTS175VBEzFSJoQtzbVq0VQ0izO_NLUBg@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] reset: Print reset type on diagnostic console
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

Hi Denis,

On 2026-05-22T01:23:09, None <dmukhin@ford.com> wrote:
> reset: Print reset type on diagnostic console
>
> Add a diagnostic console trace indicating the reset type.
>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> drivers/sysreset/sysreset-uclass.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)

> diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
> @@ -22,6 +22,22 @@
> +static const char *get_reset_type_str(enum sysreset_t reset_type)
> +{
> +     switch (reset_type) {
> +     case SYSRESET_WARM:
> +             return 'warm';
> +     case SYSRESET_COLD:
> +             return 'cold';
> +     case SYSRESET_POWER:
> +             return 'PMIC';
> +     case SYSRESET_POWER_OFF:
> +             return "power off";
> +     default:
> +             return 'unknown';
> +     }
> +}

PMIC is an odd label for SYSRESET_POWER - the enum doc describes it as
"remove and restore power", so 'power' reads more naturally and lines
up with the enum name. What do you think?

Regards,
Simon
