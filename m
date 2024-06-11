Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C6C7C27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 18:53:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CC6B8873C;
	Tue, 11 Jun 2024 20:52:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Xy3sjzgj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB6BD88707; Tue, 11 Jun 2024 20:52:16 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BED588739
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 20:52:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6b09072c9d9so1440626d6.1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 11:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718131933; x=1718736733; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RE5wNSWE+nZw4iXA97bUWHuTZ4XAVep5kLhoUwgmaNs=;
 b=Xy3sjzgjRmt4BDE8T4vz8nmdEjns8KDO3ZLEpCoY78+PpB3V12xmyrBVFHuvOJffm+
 D4qyI4uP3oFRf63OEQAMTwoJYE674VSgVHnu8OcEAisQws0NMYXXY9J7CzuWkrkoWdpt
 dNx/zQL2TckVnTQaGxInHw+krT3AsqjzIKoT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718131933; x=1718736733;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RE5wNSWE+nZw4iXA97bUWHuTZ4XAVep5kLhoUwgmaNs=;
 b=gTTi77bspe01ymP2lfK6x4iQHhE3tZZky1ngFYXOryuhxaTYWvElGc3Q3u7SQ7B1Ow
 QIA+yZt7iMWtDwYPGy2cd2eBtZZannR6UC+cPxLwIyJVgRTAvoM+M0NU3cFA0nTB7ya4
 pTiawF1/9ca/c3Q0F7jZ+FebL7VeVi7zmvOKs+v3Vp90iR+6Z91WCELJrATpC+IH6n6W
 48QwwnxeeCrl89yZGolSgnY1mUHcvUTI8YP1RpMsmblfFmvg/sGHfLLni1I+Dzcy7p0b
 57t00L88J5/wVIHZZvrDJkmwI1765oZxbZEIoau7dm0VZ97i+IlE8lH/fOU2hLv/lEYe
 iW5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF4HaUdR25VV+gx5WCLfsi9GGxUqUQyUUsH6g+xrxp9JWzZUQQbQNtri0v/GBK+JCB1qG8dudOkCfvYD0E6iau2ZC2UQ==
X-Gm-Message-State: AOJu0YzV0KpR0yex/lFnC9aDK6YAsYOamajy3BUaNvjoB7Z1nuvL1s7f
 MP5TJoh51CaVaXkxrtZ5bV+Z9O8o/oeOXsSZoG/Z6vVZ7dcx8WidJNLtFA+lxUQk1fm6Rt5ylH6
 /7J8F5+P0fCwZAi9JHNER08kBcgfwsYyJAS82sm7vIaksm4I=
X-Google-Smtp-Source: AGHT+IE8cz4lIqPeA/BsfpSSq00hf3JzFVyXxPdtn54z/tV4jh5Ej+fxS+clSCiEkvjmcwmRIKbdBZtHYxiDaUk39aY=
X-Received: by 2002:a05:6214:418c:b0:6b0:820a:db18 with SMTP id
 6a1803df08f44-6b089f4870fmr61912526d6.16.1718131933322; Tue, 11 Jun 2024
 11:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240610-cmd-sound-help-v1-1-0c1e13a49ec4@cherry.de>
In-Reply-To: <20240610-cmd-sound-help-v1-1-0c1e13a49ec4@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 11 Jun 2024 12:52:02 -0600
Message-ID: <CAFLszTg35+wKFPPuKRGn2HH=oNvLrMUu+9zOvTiOuqvk31ZUrQ@mail.gmail.com>
Subject: Re: [PATCH] cmd: sound: fix help text
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
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

On Mon, 10 Jun 2024 at 10:11, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> There's never been a -q or -s argument handled in the command, so let's
> remove it. This was highlighted during review[1] but somehow still got
> through.
>
> While at it, slightly "reword" in the help text how the len + freq
> arguments are defined. Indeed, len and freq work in pair, it is possible
> to define none of either, n of both, or n - 1 of freq if there are n
> len, in which case the freq that goes with the last len would be the n -
> 1 (and not the default of 400Hz if neither len nor freq is passed). I
> assume this isn't what's expected but leaving it for another patch if
> need be to fix what happens in that very odd scenario.
>
> [1] https://lore.kernel.org/u-boot/CAPnjgZ0QWNqVFZfEWHxRcFOA3E3gRAZCYs77nGUXKL0pLp+JLQ@mail.gmail.com/
>
> Fixes: ea58b9a404d4 ("cmd: allow sound command to play multiple sounds")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  cmd/sound.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
