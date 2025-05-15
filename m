Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40C6C2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 19:33:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C8D882A9E;
	Thu, 15 May 2025 21:33:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NW1wGzpg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EAF682AB2; Thu, 15 May 2025 21:33:55 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DD7E8129F
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 21:33:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ad24b7e0331so219610466b.0
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 12:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1747337632; x=1747942432; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3TggA6hTgqRTBTurFwnoFVzTvgFAgCEQusnUp/56kP0=;
 b=NW1wGzpgMroV7xAT5hNGgpZSs0kP3XfsQzIdyJTxeH8UtSMAO0T9mScgz0GONB6q5l
 boNCP0Bp+IVoj2rugxc0dLr926XnraRgWxGRbGSgLsGon+T7143pxibtHaweHiQQRCtC
 5DXl3voHlF0+FsUb1KN4azF2SGLVSHwPT9UhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747337632; x=1747942432;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3TggA6hTgqRTBTurFwnoFVzTvgFAgCEQusnUp/56kP0=;
 b=VnaAacCHpnyYAQDkuJiwFpSVt9reK8Iyv1Mc+Jcm31TTz2KtuWMV/XYmQHVvuO+Lzn
 CPM9pjOGNLpJaZ81rrT25m1dduZfeKisVrvEPQGScZzZicRTS7tY7DNdwUspIuTj0G5K
 XoZV4VR7o6aZRQgRsdXeoaazyzDSXkd4jlyWC7Ubz27tXaw2xCcEeVQWUPV+rBzVoWL1
 6jor1bK1DmSIcB5FPzN0nRW4lqO+w0KPWwHE22gpfXUtXqpC/M24Fx3GcrOv7K1kqmQg
 FAqYzOdu16nrA7zHEBv9kepjmNv6/Y1LPEfBRMWVL0ebSv1b2VXUWHrkhGWVfTshMOmY
 oCYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWi0ijDDwBJBC+tQ3C20uPaBtr6ELPaLVuj3dt/aogE7T22AW8Cnc/5wzBRPkKczOQ+83M/fpQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yw9P6fI7ggzEMO+M3iM1ybgcxSWtDY/ZJ+VNbe2ViCtD25eYP0f
 0oZSeIk0p8RjQo66gMXe7EpQoeCiIFbWv6IsLXaJ9JKCJsdUYGtBv6QQlruyp4H1Wrf7Nloaaj2
 eSJSeN96wbQi97OPy3HVtRfdHYQOdhyKaRoWyw6lr
X-Gm-Gg: ASbGncs82SUdigk4o5rbzKTHcNmI9iMzcI66a4dzao2/nGY9nf7mVR86jhWM0TCk3Wd
 yNtA+iKqwg4M+FnncKBmUFIN70PTiilFZbWK51PWGbb46Rntyx9FXmpHS1JOGt29/CqIFkAMw08
 cXdKnrtuN5eOoicDFWqXa/LspNV4sGY5w3pMRlh4Wv9mk=
X-Google-Smtp-Source: AGHT+IE0Irjv5d53bR3NMqqyC4cUViD0TLMe53U2fP3hUdUKh6YWL6Vwt8VZ6t0wL0bQJk32lCoB7Ydf1bb6Oria6oc=
X-Received: by 2002:a17:907:7ba3:b0:ad2:5878:3e66 with SMTP id
 a640c23a62f3a-ad52d51bb60mr81057166b.34.1747337632448; Thu, 15 May 2025
 12:33:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250511141828.2367318-2-sjg@chromium.org>
 <20250511141828.2367318-1-sjg@chromium.org>
 <CAFLszTjf_4E+spiD3FBFvXQbXtrnBxgoF1hCjNsauySom2SgFA@mail.gmail.com>
 <20250515135546.GF603748@bill-the-cat>
In-Reply-To: <20250515135546.GF603748@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 15 May 2025 21:33:18 +0200
X-Gm-Features: AX0GCFszwf_Jzux4mugrZ7BXuiF4eAq7c2i7O0QqGRL4KcMjTFuZJblohmmsCDQ
Message-ID: <CAFLszTiOe56kP1i_AGLSZBRvyNOYWHMZXC45Qi0YsrP1rkjYAA@mail.gmail.com>
Subject: Re: [PATCH 1/6] test: Update fs_helper to support passing in the image
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Richard Weinberger <richard@nod.at>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Tom,

On Thu, 15 May 2025 at 15:55, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, May 15, 2025 at 06:51:17AM -0700, Simon Glass wrote:
> > This function is useful for other scripts, so add a parameter to specify
> > the image name, if desired.
> >
> > Also add a flag to quieten the output of some of the tools, since in
> > many cases we only want to see warnings / errors.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  test/py/tests/fs_helper.py | 18 +++++++++++++-----
> >  1 file changed, 13 insertions(+), 5 deletions(-)
> >
> > Applied to sjg/master, thanks!
>
> You have been repeatedly asked to not send messages about your personal
> tree to the list. Please stop sending these messages (and I hope you
> didn't change the patchwork status too, again).

We are still not really on the same page here.

This series is showing as rejected in patchwork, so I've applied it to
my tree and sent an appropriate message. While we are in this state of
your rejecting my patches, I am not sure what else I can do. I have
already renamed the tree, as you requested, so there should be no
confusion that this is my tree. If there is still confusion, then
perhaps the rename (which took quite a bit of effort) was not
effective in resolving your concerns?

If you do take a pull request (e.g. for one of the 100+ patches
assigned to me in patchwork right now), the patches will then be in
your tree, so presumably need to be marked 'accepted' in patchwork.
When would be the best time for me to change this status?

BTW, I'm really not sure why you have rejected this particular patch.
Even if you don't want scripts maintained in your tree, this is really
just a small tweak. It will help reduce the delta between our trees.

Regards,
Simon
