Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BECEC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:08:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0411C874EB;
	Sun, 12 Nov 2023 21:04:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hw4txHD2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E932E874B6; Sun, 12 Nov 2023 21:03:58 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8546D874F3
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:03:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5afabb23900so44377667b3.2
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 12:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699819434; x=1700424234; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XYR+OHOykEPwiEgnYHXcKf12FMSK8KsSehwLjx5hvSQ=;
 b=Hw4txHD2HXDLkrO4WR+WQ4vP/Z2nCkbnY3PlTVOEw+1vq6b1600yI+dRimHSDvYaaw
 W4eAdbZmU5Wkt9BW6++PQiPxCkSyh1qQYT+BruTH6KnCpFsKljeCy/wcl/xVZwZiZz5Q
 hJNg5Gbj1fRLYhaHQ/pP1WcCDAkOSz8bboQ7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699819434; x=1700424234;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XYR+OHOykEPwiEgnYHXcKf12FMSK8KsSehwLjx5hvSQ=;
 b=KUMvEh8fVRbJWMTwPA4OnOial/RD/WTozsk8RujtOCcoiemTDTuGSXIQnzmcPDMMpU
 UW3lfN3vZpAg8OZCSW8S8wM6moXXFPU1Bm1XZ4SygalqCBo2G8qenPbDkbKOZWnM6QaU
 5yuL3wwb1sQ25YwR0wFIsBzexWz/r5KEUucWSdF/f5C2y3qSKVZE4n0UArpXtp87pAUS
 G79CeY5njFZA4hecL8lLv3mXynb8u2dKL3EynaAgMT1IY/AO9nCKCGMowlyJCb6R7mrh
 Y5Tj1Q0c6ZyhnclL2SScJQnFSSLi/lvckQEbqHbu7S1/Fv2DiwTnLVtv2hQHWv5EMfpI
 w75Q==
X-Gm-Message-State: AOJu0YwH0D3jWo7mhZMBlrYp7iyyqG/Et14UBRAl9qH1X6nalVi89MgO
 ZnctNMDBtyuUrZHJhJ+KJqlboPz/eU3/atOMm8SyeG/778PefL1EdjA=
X-Google-Smtp-Source: AGHT+IFUNSD3QLvp3T7VYFw14hAEDi2BW0GndvkrnwKPoHbzL2SHjvcXOsHLG2CbmN/8EntaFLsz0akxPQVaZmZYDNo=
X-Received: by 2002:a81:9150:0:b0:5b3:3109:36f4 with SMTP id
 i77-20020a819150000000b005b3310936f4mr5188811ywg.40.1699819434113; Sun, 12
 Nov 2023 12:03:54 -0800 (PST)
MIME-Version: 1.0
References: <20231103183844.2308934-1-seanedmond@linux.microsoft.com>
 <20231103183844.2308934-5-seanedmond@linux.microsoft.com>
 <CAPnjgZ0-o61kX7yanfi8TQKJj+sjBANUA13hjGSzxWN6EZHZZQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ0-o61kX7yanfi8TQKJj+sjBANUA13hjGSzxWN6EZHZZQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 12 Nov 2023 13:01:05 -0700
Message-ID: <CAPnjgZ0Yr1c3bMzcaVe8KX4mhjby0FAfVV=zs29n0vd=gZVNbw@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] dm: core: Modify default for OFNODE_MULTI_TREE
To: seanedmond@linux.microsoft.com
Cc: u-boot@lists.denx.de, dphadke@linux.microsoft.com, 
 ilias.apalodimas@linaro.org, trini@konsulko.com
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

Hi Sean,

On Fri, 3 Nov 2023 at 13:38, Simon Glass <sjg@chromium.org> wrote:
>
> On Fri, 3 Nov 2023 at 12:38, <seanedmond@linux.microsoft.com> wrote:
> >
> > From: Sean Edmond <seanedmond@microsoft.com>
> >
> > There is a preference to use the "ofnode" API for FDT fixups
> > moving forward.  The FDT fixup will usually be for the kernel FDT.  To
> > fixup the kernel FDT with the ofnode API, it's required to set the
> > OFNODE_MULTI_TREE option.
> >
> > To ensure existing users of kaslr fdt fixup are not impacted, Let's modify
> > the default value for OFNODE_MULTI_TREE to ensure it's always set if
> > !OF_LIVE.  This will cause a 1007 byte increase in the code size.
> >
> > Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
> > ---
> >  drivers/core/Kconfig | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
>
> Reviewed-by: Simon Glass <sjg@chromium.org>

This actually disables the option for sandbox. You may as well enabled
it by default always, since if OF_LIVE is active we are already adding
a lot of code.

That explains the cedit error that Tom mentioned.

Regards,
Simon
