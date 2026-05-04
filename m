Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4C1FF886F
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 13:00:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 663EA8468B;
	Mon,  4 May 2026 15:00:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mVE/lDyS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EBA68468E; Mon,  4 May 2026 15:00:30 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 626A48466D
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 15:00:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-67b6dc50b61so5870517a12.2
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 06:00:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777899628; cv=none;
 d=google.com; s=arc-20240605;
 b=f9T6OQcYQR5P+rlmBYj9K7vy9bt4o4OoAHjw+Dh/JeosHcXBO4uodRHJytey2WfZ8P
 Ia0vgF8RAfBt0J2fFNi0nkSM2OB/ZHzA6Xk13bqeojULKfg8tMOUj6mbkboABOW5xD9G
 WALqxJbDGgKz9JNxotUiHMk3MV9BX3QgIuVfkLiucEJ87hWwRtYlLaRTKTzvCnML7nbQ
 e7Wl0CayYqmGYP9hJqgLPN7wXPNYqufZ221D5kO46GhXY4IHU5Y25z2J54dOvEItNn9M
 TL87eC49DQMccIxdt7qwsRmX4Z5nP4/MaYFGYNValgqX64IiV1eqwuyAu4XVCTNI/SAf
 FCxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Bfa7Mc8HXS6es8daTNmTzyV03n57SLP0hxsVVc1w/2E=;
 fh=UjSUHWUl7dcWuaSYwEpla6iZYDT6sMJTlssR4/uRKYc=;
 b=B7y9zVeeqr2nik/0J5RehxsUno4oqtZfcBGqW/orG50eO4M1grE8maCKgrqrdZn8zk
 fBuHB3b1/Il1tGA0gnbuXroEv3Uu7acFH0b3aGKPGpcie1DS6N7uyj4kThiAYe7JxN7k
 6mA7PdgDDB852vFiPCnM2UWeD8nnMfulmfIGQm13LYCsVWkJO75v1EDqlUcnKcNsuRhN
 SsDbgyp4T02W6AoFkOPXpMua+8pkhIkOU3N6CEFJl6UqaEmitQt/rGm1pMrGi/WHH1bV
 Onxpj2iB2WlZOi7TByQTZxHf/A4K+1uZkaEFfJoyHYT1e1mUjL2vPrfRfTSGQg4x6COj
 HZBg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777899628; x=1778504428; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Bfa7Mc8HXS6es8daTNmTzyV03n57SLP0hxsVVc1w/2E=;
 b=mVE/lDyS+01h7lDh/1BVphzxgLqEEsxitkUeS86Bcjk5p0PmS4abpAPYOiYOrKAQ9d
 3TLhF5j/PLufrjbdqoGmOpVJehpVqCjDwEUHmM1Zz6pJWgimMenROrZGiPubYbcF+FDs
 kTDmjOMxdxF3EwmUQe4orZAw/phpBbXoOrgxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777899628; x=1778504428;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bfa7Mc8HXS6es8daTNmTzyV03n57SLP0hxsVVc1w/2E=;
 b=U2lbOu277I0VT+LmsEwZ+DRE22DJuEOaMIXOvLGPOlP1KxUyYWdlRt/iavNYD5ddfh
 pRBQRID1XeskAgoQhTwcoUXFnf9GGP2zd/MYk+NAsHmAj4rFTvyT80X56vfYaOcv6p+/
 u/mXQvYVbeG9SmFbtPNBlotquvFj9WxiufM+/TRSZcqCwdf6mBsHdobGRPPswX1vQYrL
 TKJsUJ5gtTpU6nd41/TseeOvMu57FI6Q5dH3q3Paie8cw/ddfkepOQrKYearpohIguw2
 lNymqkyroUpSYAvS671X1jhF8aeZ2jULG0JE5SdDKodNB+S3VADu954eaWY7QxFRBmeB
 arVQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9HMWWnBrjcqnENOwz81E45eLoCHoigtODxkTxnlzI5v7e4s6MLd/9yEoJljq5xbw2/AilpUTY=@lists.denx.de
X-Gm-Message-State: AOJu0YypOxiVTKIduOmT6reviaki4lqgsCSEYzteXPae5V2D390FVNwu
 /VhMv+IoCfb1pbFoSShyceqQhia16BMVlRJiD9zfvKA+j78whJY9xY8A+90+oKEVq7x59fZEIId
 sbQpbEB11/YyK/2t8HRpNC+zwxuwy5rrFObewHIWk
X-Gm-Gg: AeBDiespXPpo7hKe3wgPY+62KxezC9PR2KIoXWJ+Qqlv6L15SpBrgKdaFF/ga39Z+wN
 /F1mS5zljGIYE+jd3LjsVOnL5jTWsq7+UV4HGAaliNZa2JJrY4llGQPzBKpXZYQSmauPd8JhFom
 Q2Y1FX2VxpczPaId20lJkblhkDsxZw3Mq6fAI5qqNWcQGz/rT+HrB3RVupYVdqTdDtUKHKoAJHc
 hxK1gnM/FgHA772fDzXDbabxqU9FdShDXcLzfgyZPxibW7h/4wk2LMqJWfsKpwbkHqpYmzvYnRk
 Vq5grz9SxxyN+sqY
X-Received: by 2002:a17:906:4fd4:b0:b93:51df:dd23 with SMTP id
 a640c23a62f3a-bbff9830ec9mr508915766b.16.1777899627687; Mon, 04 May 2026
 06:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260501151612.229417-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260501151612.229417-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 07:00:14 -0600
X-Gm-Features: AVHnY4Lv7Arb3DuELBKIlpID-dMnTAg5YVd0R7eSw7G172HWp0INdtIpiCZu4TA
Message-ID: <CAFLszTjW4A-xrdMP-1H75L3bPwoxxo3jV3VruSBH3eZMBSGO=g@mail.gmail.com>
Subject: Re: [PATCH 1/1] video: show 'physical' frame buffer on sandbox
To: heinrich.schuchardt@canonical.com
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 u-boot@lists.denx.de
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

Hi Heinrich,

On 2026-05-01T15:16:12, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> video: show 'physical' frame buffer on sandbox
>
> We allow using double buffering for video. This can be accomplished by
> cyclic copies or we may copy 'damaged' areas.
>
> To inspect the output we must inspect the target frame buffer that models
> the physical frame buffer on the sandbox.
>
> If double buffering is active, priv->copy_fb is a pointer to the target
> frame buffer.
>
> Fixes: 5c8dddadf1c9 ("video: Use cyclic to handle video sync")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> drivers/video/video-uclass.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

> diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
> @@ -516,8 +516,7 @@ int video_sync(struct udevice *vid, bool force)
>               video_flush_dcache(vid, true);
>
>  #if defined(CONFIG_VIDEO_SANDBOX_SDL)
> -     /* to see the copy framebuffer, use priv->copy_fb */
> -     sandbox_sdl_sync(priv->fb);
> +     sandbox_sdl_sync(priv->copy_fb ? priv->copy_fb : priv->fb);
>  #endif
>       priv->last_sync = get_timer(0);

The change matches what real hardware would display.

The Fixes: tag is misleading though. Commit 5c8dddadf1c9 only added
the cyclic timer; displaying priv->fb predates it by years, going back
to the introduction of the uclass, well before copy_fb existed in
2020. Please can you drop the Fixes: line or point it at the commit
that made this observable?

Also please update the stale comment in dm_test_video_copy() - it
tells the reader to manually edit video_sync() to call
sandbox_sdl_sync(priv->copy_fb), which is exactly what this patch
makes the default.

One more thing: video_flush_copy() only updates damaged regions, so on
a force sync with no damage we display whatever copy_fb last held. I
think that's fine because priv->fb hasn't changed either, but please
can you confirm?

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
