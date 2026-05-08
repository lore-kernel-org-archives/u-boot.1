Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9924ACD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 16:29:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B5E884D73;
	Fri,  8 May 2026 18:29:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V0cphBFh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3125C84D80; Fri,  8 May 2026 18:29:39 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09C2784D5B
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 18:29:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-678adefbd26so3983702a12.3
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 09:29:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778257776; cv=none;
 d=google.com; s=arc-20240605;
 b=fFTRm1Eddl6XUl8IP03OISBqkMRoy1vqZuvkjJ1PBktjqDYYebPCXJSBqiBLwa2aZc
 HIswnihbYCgQSVbmmFheMZKOymS3/VXXub3xmmzqn2MFVmVQS072Wsl1BKxopcjf8oeD
 MYizbUalWc2ogt9rv8w+y3RdPQ6CasPd/IH60+Hd3EUDHBqouwtkG/JG0GXY39vyufD8
 oO+f4SkvQeMu4It1q0GFqkoWVfJi7dSq83Ot4x3IBOhtbpoTBKC8JF4ALAKR22zTNRY0
 Cw9kIucPcieZ/OsPqmD3sObD13/0wE2I2B3cBfuql/rjJTUmcmD8OetQRCiOAjT8gfUX
 HX8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=POFyWbqfUI5u7Il/wtBJJdTElIuvsAnugfonimAvcaU=;
 fh=7+NugGQ2fjuifNFbboBIeXRgPjkONDOweWugJxHsSfY=;
 b=Fsu7K6btSxebuFITxx0WFepChk9IzUB0mcwXyG7qbwupBc9FKk7SBYo1kuT8wcDz3b
 pmlBaraua3L4OrFfSSLgpUYYN2xhmWIiG+a4vBbOmT8NWGGNHjVRkPgDdG/ceIUQesBe
 MCtm0TqnMlMbBif5BSHjARA3+Pm5e4rSwW/oRHsZY2p6T0KeFfjHhO5kcbhW0w1dZyGB
 veZPsF8LkxZRYhsXE+McJ86egeN/NBnpH8DAyUVbDaip5YtR7Occdw1ssNUhvzV3umlr
 HLwUCocUbqWMXEK8NWqHQCrR+BAQV3n4Ve5En825VlpM5vtIIf4oXLA1Md0pRVv3JC7/
 zkag==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778257776; x=1778862576; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=POFyWbqfUI5u7Il/wtBJJdTElIuvsAnugfonimAvcaU=;
 b=V0cphBFhoPPdq2KgDybgDnTe0DRJ5dx5sq6Q4JpNy8Frc63kFoINl57pTvefUtcwIC
 Tses8hVaXBACwtnr8D7/b+5EE1K0bsYxkoe6rQOLACw/xK0nQaL02UXVf2UPfp+ewftX
 XvVqRvo2sQhCjM+JkcCEyFd5VsuIYsDQa4nfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778257776; x=1778862576;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=POFyWbqfUI5u7Il/wtBJJdTElIuvsAnugfonimAvcaU=;
 b=pQiIVKM5g7Mwtb01hoBFzHz5x5Lc3HsmaCrJ4OoVjxX/1CjcZM1O1wWHHz/rEjHmKu
 +KDH0EVP38Gro/3gu03pv8SBjaSrwaNnYqDWxmbboUO2hLZt/O8Fkh5BD99bkoYCgqx/
 OE1dpBHvqodEsnYYFEBxBI+0a/Ajekk3IIFLHRFdF6zsB2vsa5K+J0kiQgZvfNK4HGl4
 JuKKKhq6gafxRckXrwTCBgJud1Y2imykcAogwkP2vZv7pwLLsiFE175t1a1xC80wRZl6
 tLrJL/k79QwXZ/hUfoXwvj412sZwfKRV2q90gAUHiZwQJrkTfCQtvNZ3f1fYd+UeLiwc
 8uLg==
X-Gm-Message-State: AOJu0YxFBOWuxtaYDtUj2r/T+zoT33I8mimvq/AFazggaCk5EoHEKoJF
 BiCxn7NeLQj/G8PyMKPG/4FRR8vbly2OtxSkTJ6ZG1ngs9oM6DdH4ClTdQut8hzbtBGCcs9bNT7
 JXIcVk0ho9O07BDhG2YgKpUv8FypBlZWELV0h0/8erYy5oz1XSx4=
X-Gm-Gg: Acq92OEqKEBShklLgPrvhycChHYnjES+R5iKLz45Y1mqeDP7ecWjADPuhNwmirxlHrU
 3Pebcv24PPnDLuK1crg7kturYFhZNMSxtWDA0F10GO1b2iFSKzcy3i5AoL4+/CojG5JAJrptbjV
 i+eAgvOTo5jyjdaPIccXs6wamnZhqE4oEoR3FJY9xvWbfdMnMEex7Ex3YwzfgP6ls7jO8Zxri3g
 ydJbUhdW7FyCm0DEyfzEfdAlpiVWMx0sxCz+RbYPBZ4uK8PDIHU11P7DBcsYRxSIrOpDgEMe/Dh
 V75n/w==
X-Received: by 2002:a17:907:3c8c:b0:ba6:6c2d:5c81 with SMTP id
 a640c23a62f3a-bcaad42b3b3mr219307766b.44.1778257776340; Fri, 08 May 2026
 09:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260507164248.59353-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260507164248.59353-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 10:29:22 -0600
X-Gm-Features: AVHnY4KzzQKtdgvzdjgVNYVL8CefqH6StZ0rZMwi--PeK4tzMyIrFRaqoWau9zk
Message-ID: <CAFLszTjizssuT0Acka0DBTZsX=99gqeP3GdNShFj8LMCDCXOVQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] block: ide: Staticize and constify driver ops
To: marek.vasut+renesas@mailbox.org
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On 2026-05-07T16:42:39, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> block: ide: Staticize and constify driver ops
>
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
> drivers/block/ide.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
