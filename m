Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB025E77179
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 15:32:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A53D89613;
	Fri,  6 Dec 2024 16:32:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ea7xzMov";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94C1489645; Fri,  6 Dec 2024 16:32:04 +0100 (CET)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 532988964B
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 16:32:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2ee8647dbb9so1796452a91.2
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 07:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733499121; x=1734103921; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WDvNzuYtwhOF9jrd5OGuGf5gr+oFvLH9RATqDn4cSTY=;
 b=ea7xzMovLGK+uPvp4NfQgNSTxso+hJ1GKBeSiDqRQxPyKMdNrINu5HErQuStwNddav
 omB9wSRdYQj2A0Q223Z35mPJm8M8MAr7imekQLJhstrUAfd26wBwEeydZgBO7v2khFOh
 RB0WwZKsA2GLsEoWyA1uv9T+ocjuTfFhhu2B4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733499121; x=1734103921;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WDvNzuYtwhOF9jrd5OGuGf5gr+oFvLH9RATqDn4cSTY=;
 b=MQ3xftuQVOeJXwMF6KXJN7NSS6JCjmbXuMdI/kA7/BkZjly1IW9ojUu15MITVtdb2L
 6ApVnnOC0BwftnyJOzn/iJO30HI+UgOgFMGOjVPVJmCZL7/Lmc6xp640UgCbTApS/vz/
 Y4xey/PIjhxIh4S6FgoGuxmw+BdqDcJj5BZ1ZOcY+/m+gVIxyTdmWD23+2wjCEu/r5kn
 TIgippWhhrXwMn1G2DxFiDCcmAXMR02m357oULEvsGYPMSdFVsNsyr6i/D+lZ9aQR/ZW
 Cog8k5V9xbHT6J5b25wScgKl6Hs11Ltr9qAjJkL60iEcPWcllWU7/YYVQuwlhodYowtk
 zSsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYt1m6MeJhwCmSNx1oeOoI++ewgBuUH/ihNjaA5IVR0H1l+LbsaT47U1kQ8YvkznpQ0+C+muk=@lists.denx.de
X-Gm-Message-State: AOJu0YyTLjm8M3cB4aakRcbqc3IC94CBNxNIP4DLmrCCFOTwLYcUu5jJ
 fpYHWursyYHKrJLbGl+5iYTiX0LgT3gQwKEQozdXkgToYWvtuSIDiAtFTbF5NaUxObU7PhvT0VY
 xao1ZfEV/Um0jteAU2+03S30EbTBzMlWkpMVE
X-Gm-Gg: ASbGnct2sa4eoeVfJ3Jw3hSVLnIl/Ducikb2b+nd/UgYr3DQgKx0SjD5OMAWsaYfzMd
 CvgLmZRiZvLiV6osAZkIQjZpXyarGDQuW
X-Google-Smtp-Source: AGHT+IE4qvDNq5ZeCIn04rywJhOV/WySle2t6amikCo1ctrMq4c/cEtwrOoxcoQqR/RMDuXdWc6HEsGvhyfxSKSdiFA=
X-Received: by 2002:a17:90b:2f86:b0:2ee:c457:bf83 with SMTP id
 98e67ed59e1d1-2ef6a6c1400mr4136989a91.19.1733499120898; Fri, 06 Dec 2024
 07:32:00 -0800 (PST)
MIME-Version: 1.0
References: <20241202-sandbox_repair_of_embed-v1-0-05aff4b0ccf7@salutedevices.com>
 <20241202-sandbox_repair_of_embed-v1-1-05aff4b0ccf7@salutedevices.com>
In-Reply-To: <20241202-sandbox_repair_of_embed-v1-1-05aff4b0ccf7@salutedevices.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Dec 2024 08:31:17 -0700
Message-ID: <CAFLszTjs+RYUk9jGMtWArrSC=OEdxM7RXb2QCVWS0fWXdrtyyA@mail.gmail.com>
Subject: Re: [PATCH 1/5] sandbox: fix bloblist_finish() linker error if
 BLOBLIST=n
To: Evgeny Bachinin <EABachinin@salutedevices.com>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Levi Yun <yeoreum.yun@arm.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, kernel@salutedevices.com,
 evgen89bachinin@gmail.com, u-boot@lists.denx.de
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

On Mon, 2 Dec 2024 at 06:46, Evgeny Bachinin
<EABachinin@salutedevices.com> wrote:
>
> Having CONFIG_OF_EMBED=y && CONFIG_BLOBLIST=n leads to the link
> error:
> ```
> ld: /tmp/ccwtRVty.ltrans0.ltrans.o: in function `state_uninit':
> arch/sandbox/cpu/state.c:508: undefined reference to `bloblist_finish'
> ```
>
> Fixes: 1c52fcca72b ("sandbox: Write out bloblist when exiting")
> Signed-off-by: Evgeny Bachinin <EABachinin@salutedevices.com>
> ---
>  include/bloblist.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
