Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF91E743CE
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 23:43:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3563886E65;
	Fri, 29 Sep 2023 01:43:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UG7bE/U2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A508A86E6C; Fri, 29 Sep 2023 01:42:58 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9348186898
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 01:42:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-53406799540so11522591a12.1
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 16:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695944576; x=1696549376; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PKWFDXbnqddhmtC8riN8PSqReLFCrVDfLWWM1ny8vd4=;
 b=UG7bE/U2shdYq0NDJ+/5Hb+QB+DVKO2KauK61dhqgIDreD0LIq4U6DVtHBYw1gHOwM
 twetgSQ3/iBhI3gtTLw2iYWQBxcN87VsIkxZnl0M1hkrdjewiDCkHHGX2NLb+LTkpUlV
 rTrFAHuzCIb6e1U8pa2ktiAI07JgMQBLg4UsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695944576; x=1696549376;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PKWFDXbnqddhmtC8riN8PSqReLFCrVDfLWWM1ny8vd4=;
 b=SBMkU/mBgMW/VqRmoGdIY7ujvU/+ZgJOaV63DV6/KDGRwVJtVswkVbg1pGQXSld+8O
 MyB3xovud5T9UGL8+klaP+VmNZbeGEq7s32MixHcqRSd7hxRZZHfe2Jepv+wTsoXNDjH
 mJVAyRBVE3ysqJ5qMK1DBSIiru9Y9j9uJO+Xl+0SUFnQw0nHHkDjsY8AQLe0lHXHQ+ov
 eo92m9uF+ni42Vtx4w9pWb3iKGTpg30GUBvQleWRMWE9MQ3UzpU57rDQRQpmK1rg9Np1
 eUqkjFfh4puFKmXwqx4tjnzM7u5FiYSLAPD7rM3mqH8lab3M96kkAOIo97mOXhhB2K8x
 fsUg==
X-Gm-Message-State: AOJu0YzLy0iEg70w8tP4xtbFZEkjTLA4eEG2DgbdOITn9nnQHtS33zCi
 7mf6K+GYDBaKaDeJ2YNGN61OB+hxVeZYFriNe29RRQ==
X-Google-Smtp-Source: AGHT+IFJ6n5x45QoUiKMXlHGJLUqNk9CFZacIjW4hljIHqkgdhCSKums5Q+aiyDmYIPIeyjurHNxoa5MgpXCJsZjbKo=
X-Received: by 2002:a05:6402:398:b0:530:db58:61c8 with SMTP id
 o24-20020a056402039800b00530db5861c8mr2523757edv.23.1695944575865; Thu, 28
 Sep 2023 16:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230927214415.2224768-1-jonas@kwiboo.se>
In-Reply-To: <20230927214415.2224768-1-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Sep 2023 17:42:37 -0600
Message-ID: <CAPnjgZ3ThwoeEiiei53ZdCb1MvkDA8yaZTStpZ6LWauE7q+88w@mail.gmail.com>
Subject: Re: [PATCH] spl: Jump to image at end of board_init_r
To: Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de, Chanho Park <chanho61.park@samsung.com>, 
 Ferass El Hafidi <vitali64pmemail@protonmail.com>
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

On Wed, 27 Sept 2023 at 15:44, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> spl_board_prepare_for_boot() is not called before jumping/invoking atf,
> optee, opensbi or linux images.
>
> Jump to image at the end of board_init_r() to fix this.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> This patch have dependencies on the following patches:
>
> spl: add __noreturn attribute to spl_invoke_opensbi function
> https://patchwork.ozlabs.org/patch/1827057/
>
> spl: add __noreturn attribute to spl_invoke_atf function
> https://patchwork.ozlabs.org/patch/1831366/
>
> spl: Drop the switch() statement for OS selection
> from the "spl: Preparation for Universal Payload" series
> https://patchwork.ozlabs.org/patch/1839731/
> ---
>  common/spl/spl.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Very nice to see this!
