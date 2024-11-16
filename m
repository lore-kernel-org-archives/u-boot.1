Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3AC2D68BD0
	for <u-boot@archiver.kernel.org>; Sat, 16 Nov 2024 02:45:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C95378919F;
	Sat, 16 Nov 2024 03:45:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HE+uOySO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DB6A891B4; Sat, 16 Nov 2024 03:45:30 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 100CC8913F
 for <u-boot@lists.denx.de>; Sat, 16 Nov 2024 03:45:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a9ed49ec0f1so409296866b.1
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 18:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731725127; x=1732329927; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iwO6WUZvtOsjkgYw0rVq+VpsKqXNlPl91zPTWI6JCFY=;
 b=HE+uOySOvkMoerx9VVWLH/YG5aEnjQ98N9a5EUKb8Dm74oUrJrZuT7CSFN5mQb+KL9
 oiHA+CWJ3EoaD/fBoYpgHrpkEqFNPQPZO9eDpdBSQ22Vv6vIC27P7udJpHTB/M72oEcu
 zFSZuSQchjpKOB4Jnktc8PXdcSXLh5+RtIVIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731725127; x=1732329927;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iwO6WUZvtOsjkgYw0rVq+VpsKqXNlPl91zPTWI6JCFY=;
 b=NcmLi/lb6Xrr8ma6KlUfow8+WxhEqLmSv2g8Q5MNUUtGh8+M+Oz4XYVrww+1JfYt2V
 rv9M5V7AATjs7ZG3rKoC0WyThesA761nhTQVuYHWLTdD4oLMp0rj2BdkF6yHXgDxmwUK
 5qwrCBOEtvnFndpwbd5fhUCu/CE4d1c9C7bCDwM/plD6lnR7kMLnGTP6op3qm2jeNEK9
 Dr7cPkV5wBPA4U5x6PSezAaFHKbeMUxlgS4+he3Z9ZKAyNiLfsc70hlcCkBmFNSgKlzF
 c9FxZLwHuo7Xg5JjHxMfuMg2acrzMBdMb0BcQ4ywoZX2qkqNOzHx8DH6/n+VqWxDjP2t
 8Dkw==
X-Gm-Message-State: AOJu0YzIvwVcfKqutfdZ1CHJV7BAJcTUpOK5mE+RFpCgxP42JU/CsV+X
 xLgTfhZVjjG34BYlRWheQYRnffERRsiX3gwd4ws649ryt4k9ALN1nkBqMQtVG6DFa/BFW06FTTq
 z81WU8WBrWSNyjlrKDEbZbaS5TxSHKes/ObuPqIARk1RJQ2rikw==
X-Google-Smtp-Source: AGHT+IG/YPQI3wVN5+Vvhegcp/0M9Bs1mgnRuLRRww/DkEG4S+cCPKnz3pyKw01Pz24qvBsGrDFSilyxEcRg/TpCK+0=
X-Received: by 2002:a17:906:d54b:b0:a9a:1b32:5aa8 with SMTP id
 a640c23a62f3a-aa4833e8bc9mr416292366b.4.1731725127351; Fri, 15 Nov 2024
 18:45:27 -0800 (PST)
MIME-Version: 1.0
References: <20241115132821.c2cb96e17c9a62e450d155b0@brisammon.fastmail.fm>
In-Reply-To: <20241115132821.c2cb96e17c9a62e450d155b0@brisammon.fastmail.fm>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 Nov 2024 19:45:15 -0700
Message-ID: <CAFLszTgp3u1GZYT-n0=6M6YNPkYrx_pzX__5j=tQbHNLUH0f1w@mail.gmail.com>
Subject: Re: "help" output too much for my screen
To: Brian Sammon <u-boot@brisammon.fastmail.fm>
Cc: u-boot@lists.denx.de
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

Hi Brian,

On Fri, 15 Nov 2024 at 15:35, Brian Sammon <u-boot@brisammon.fastmail.fm> wrote:
>
> I recently upgraded the u-boot on my Pinebook Pro, and lo and behold!, the new version supports the built-in display.
>
> So, now I'm experimenting.  I hit the any key to stop the autoboot, and I get the command prompt.  I type "help", and a large quantity of information spews out to my screen, faster than I can read it, and scrolls off the top.
>
> So, this prompts a few questions:
> 1) is there a paginator, so I can do "help | more" or something like that?

Not that I know of. I suspect something could be implemented, if you are keen.

> 2) is there a scroll-back buffer, so I can do something like "Ctrl-Alt-PageUp" to view stuff that scrolled off the top of the screen?

Not on a real board. If you use sandbox, you can do that, though[1]

> 3) Is there a website that lists (and documents) the commands available at the command prompt?

Yes at [2]. I'm not sure what proportion are documented overall, but
perhaps close to half of the non-board-specific ones are.

Regards,
Simon

[1] https://docs.u-boot.org/en/latest/arch/sandbox/sandbox.html
[2] https://docs.u-boot.org/en/latest/usage/index.html
