Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F361E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 14:51:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C7CC802B4;
	Wed, 18 Dec 2024 15:51:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XJ+fofis";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCF6E802B4; Wed, 18 Dec 2024 15:51:06 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78F1D8031D
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 15:51:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aa67f31a858so1206441866b.2
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 06:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734533463; x=1735138263; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T7YwQ15kg3ObQf6A6IrW7Med5rKWh4krHRIw2AmC1ek=;
 b=XJ+fofisU1XMcx9+FWLSbPxwL1dAqeBu3PMFh7f9ZJZAJ5AvMudFVqoK0hj4t5BoHV
 4lfc17e8DFpnKgDzlhxdaKXtDXffDO6MX9GTqI7cjFf0vBVdPFHXSJsuzG7fN7tXxp27
 8Fs+bphpXZCuAze7nntWWHPa7T7VAumkOe4dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734533463; x=1735138263;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T7YwQ15kg3ObQf6A6IrW7Med5rKWh4krHRIw2AmC1ek=;
 b=NalvStpcibhB1OMeytAMKFDEyHcIo9cy+O8MZl/3lHl4Wn7Y+eNt5cJEyjgWJ0L7nz
 ojX2hMVq/IkJsuaOkTE77y6r28liK8gDClohd1FLsPy0fLNjBB9W1Ffi+zcQk846MwyR
 FsuKXIUOtKie7T6YwxIDf1CXRVIYLu+TKFVVPxv6kjH0SQuS5sfD4inVDpQgz/krjWDU
 0A1QT+UHnTHrA+Gnx2c/VAEwtqjaWg36EPL8FfTIpzWvN8BXlaiqnKqBJGCZxlDkNtg6
 Dz3rheZTDlZbaLga/X4Sfqixz3vkKRPNa2eLxSoN1YtYv/4t5gbftTaiAi8XP1N1LZ14
 Y5Rw==
X-Gm-Message-State: AOJu0YxUGW13MSNOkS8OKDZHWuNO0U+evCWExAI21yF9YUlXX6cWZrj1
 L92jEEYpNTMk02172+gvuocXSolOMbMmM3ftPRqBQkOwxf7KzqTm5+B1FSUcmSCW/+mjRzQSkPX
 4tiv5S46y84eekZ9PhfbhCoKjX23Rcm121Po3
X-Gm-Gg: ASbGncvdcjYKj4w8QfkIyIMuQ1Pni0HFnTwCbwL4WzAr88nOjmQsGuXoZrHIP2gNXTp
 /caPNHf5D9rojwOmSzifZ1sXBC03FQvg22JQNNls=
X-Google-Smtp-Source: AGHT+IE+71uZc2/MPYFzfyDZ/pJHfPgaYM+LoUKj7YiOeh7x8KNBgObJrT232vwtOUgsuzSUgkr9u1PenlhaDYhCYJs=
X-Received: by 2002:a17:906:318d:b0:aa6:4a5b:b729 with SMTP id
 a640c23a62f3a-aabf477ed9cmr239353266b.33.1734533462865; Wed, 18 Dec 2024
 06:51:02 -0800 (PST)
MIME-Version: 1.0
References: <20241218025540.3025522-1-sjg@chromium.org>
 <20241218025540.3025522-2-sjg@chromium.org>
 <20241218143137.GY1505244@bill-the-cat>
In-Reply-To: <20241218143137.GY1505244@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 18 Dec 2024 07:50:51 -0700
Message-ID: <CAFLszTjdK7GipW4mH_ALF-n0q732kzBsjAC4A0zDx8xwn_BKPQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] gitlab: Resurrect the Beaglebone Black in the sjg lab
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Wed, 18 Dec 2024 at 07:31, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Dec 17, 2024 at 07:55:39PM -0700, Simon Glass wrote:
>
> > This is working again, so add it back.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  .gitlab-ci.yml | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
>
> FWIW, this has always worked, but I don't know if you changed something
> on your labgrid side of things.

OK, good. It must have magically fixed itself from last time I tested it.

Regards,
Simon
